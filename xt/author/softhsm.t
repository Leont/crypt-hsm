use Test::More;

use strict;
use warnings;

use Crypt::HSM;

my $f = Crypt::HSM->load($ENV{HSM_PROVIDER} // '/usr/lib/pkcs11/libsofthsm2.so');

ok $f, 'load';

my $info = $f->info;
note explain $info;

my @slots = $f->slots;

for my $id ( @slots ) {
	note 'slotID: ', $id;
	my $slotInfo = $f->slot_info($id);
	note explain $slotInfo;

	my $tokenInfo = $f->token_info($id);
	note explain $tokenInfo;
}

my $session = $f->open_session($slots[0]);

my $sessionInfo = $session->info;
note explain $sessionInfo;

$session->login('user', '1234');

my %public_key_template = (
	class => 'public-key',
	'key-type' => 'rsa',
	token => 0,
	encrypt => 1,
	verify => 1,
	wrap => 1,
	'modulus-bits' => 2096,
	'public-exponent' => [ 1, 0, 1 ],
	label => 'test_pub',
	id => [ 1, 2, 3 ],
);

my %private_key_template = (
	class => 'private-key',
	'key-type' => 'rsa',
	token => 0,
	private => 1,
	sensitive => 1,
	decrypt => 1,
	sign => 1,
	unwrap => 1,
	label => 'test',
	id => [ 4, 5, 6 ],
);

my ($public_key, $private_key) = $session->generate_keypair('rsa-pkcs-key-pair-gen', \%public_key_template, \%private_key_template);

note $public_key;
note $private_key;

my $plain_text = 'plain text';
my $encrypted_text = $session->encrypt('rsa-pkcs', $public_key, $plain_text);
note unpack('H*', $encrypted_text);

my $decrypted_text = $session->decrypt('rsa-pkcs', $private_key, $encrypted_text);

is $decrypted_text, $plain_text, 'decrypt: "plain text"';

my $signature = $session->sign('sha256-rsa-pkcs', $private_key, $plain_text);
note unpack('H*', $signature);

ok $session->verify('sha256-rsa-pkcs', $public_key, $plain_text, $signature);

my $attributes = $session->get_attributes($public_key, [ 'modulus', 'public-exponent' ]);

note 'modulus: ', unpack('H*', $attributes->{modulus});
note 'exponent: ', unpack('H*', $attributes->{'public-exponent'});

$session->destroy_object($public_key);
$session->destroy_object($private_key);

done_testing;

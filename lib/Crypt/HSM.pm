package Crypt::HSM;

use strict;
use warnings;

use XSLoader;
XSLoader::load(__PACKAGE__, __PACKAGE__->VERSION);

1;

#ABSTRACT: A PKCS11 interface for Perl

=head1 SYNOPSIS

 my $hsm = Crypt::HSM->load('/usr/lib/pkcs11/libsofthsm2.so');
 my ($slot) = $hsm->slots;
 my $session = $hsm->open_session($slot);
 $session->login('user', '1234');

 my ($key) = $session->find_objects({ class => 'secret-key', label => "my-key" });
 my $ciphertext = $session->encrypt('aes-gcm', $key, $plaintext, $iv);

=head1 DESCRIPTION

This module interfaces with any PKCS11 library to use its cryptography.

=method load($path)

This loads the pkcs11 found a $path, and returns it as a new Crypt::HSM object.

=method slots($available = 1)

This lists the slots of this interface. If C<$available> is true only slots with a token available will be listed.

=method mechanisms($slot)

This returns all mechanisms supported by the token in the slot.

=method mechanism_info($slot, $mechanism)

This returns more information about the mechanism. This includes the following fields.

=over 4

=item * min-key-size

The minimum key size

=item * max-key-size

The maximum key size

=item * flags

This array lists properties of the mechanism. It may contain values like C<'encrypt'>, C<'decrypt'>, C<'sign'>, C<'verify'>, C<'generate'>, C<'wrap'> and C<'unwrap'>.

=back

=method open_session($slot, $flags = [])

This opens a session to C<$slot>. C<$flag> is an optional array that may currenlt contain the value C<'rw-session'> to enable writing to the token.

=method close_all_sessions($slot)

This closes all sessions on C<$slot>.

=method info()

This returns a hash with information about the HSM.

=method slot_info($slot)

This returns a hash with information about the slot.

=method token_info($slot)

This returns a hash with information about the token in the slot.

=method init_token($slot, $pin, $label)

This initializes a token on C<$slot>, with the associalted C<$pin> and C<$label> (max 32 characters).

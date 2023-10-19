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
 my $session = $slot->open_session;
 $session->login('user', '1234');

 my ($key) = $session->find_objects({ class => 'secret-key', label => "my-key" });
 my $ciphertext = $session->encrypt('aes-gcm', $key, $plaintext, $iv);

=head1 DESCRIPTION

This module interfaces with any PKCS11 library to use its cryptography.

=method load($path)

This loads the pkcs11 found a $path, and returns it as a new L<Crypt::HSM::Provider|Crypt::HSM::Provider> object.

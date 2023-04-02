package Crypt::HSM::Encrypt;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 ongoing encryption operation.

=head1 SYNOPSIS

 my $stream = $session->open_encrypt('aes-gcm', $key, $iv);
 my $ciphertext;
 for my $chunk (@chunks) {
   $ciphertext .= $stream->add_data($chunk);
 }
 $ciphertext .= $stream->finish;

=head1 DESCRIPTION

This class represents an encrypting stream.

=method add_data($plaintext)

This adds data to the encryption, and returns ciphertext.

=method finalize()

This finished the encryption, and returns and remaining ciphertext.

package Crypt::HSM::Decrypt;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 ongoing decryption operation.

=head1 SYNOPSIS

 my $stream = $session->open_decrypt('aes-gcm', $key, $iv);
 my $plaintext;
 for my $chunk (@chunks) {
   $plaintext .= $stream->add_data($chunk);
 }
 $plaintext .= $stream->finish;

=head1 DESCRIPTION

This class represents a decrypting stream.

=method add_data($plaintext)

This adds data to the decryption, and returns plaintext.

=method finalize()

This finished the decryption, and returns and remaining plaintext.


package Crypt::HSM::Stream;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 ongoing operation

=head1 SYNOPSIS

 my $stream = $session->open_encrypt('aes-cbc', $key, $iv);
 my $ciphertext;
 for my $chunk (@chunks) {
   $ciphertext .= $stream->add_data($chunk);
 }
 $ciphertext .= $stream->finish;


=head1 DESCRIPTION

This is a base-class for streaming actions.

=method get_state()

Get a copy of the cryptographic operations state of this operation

=method set_state($state)

Set a the cryptographic operations state of this operation.

package Crypt::HSM::Digest;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 ongoing digesting operation.

=head1 SYNOPSIS

 my $stream = $session->open_digest('aes-gcm', $key, $iv);
 for my $chunk (@chunks) {
   $stream->add_data($chunk);
 }
 my $digest = $stream->finish;

=head1 DESCRIPTION

This class represents a digestion stream.

=method add_data($plaintext)

This adds data to the digestion.

=method add_key($key)

This adds the value of the identifier C<$key> to the digest.

=method finalize()

This finished the digestion and returns the digest.



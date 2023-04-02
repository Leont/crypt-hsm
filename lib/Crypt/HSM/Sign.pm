package Crypt::HSM::Sign;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 ongoing signing operation.

=head1 SYNOPSIS

 my $stream = $session->open_sign('rsa-pkcs-pss', $key);
 for my $chunk (@chunks) {
   $stream->add_data($chunk);
 }
 my $signature = $stream->finish;

=head1 DESCRIPTION

This class represents a signing stream.

=method add_data($plaintext)

This adds data to the signing.

=method finalize()

This finished the signing and returns the signature.


package Crypt::HSM::Verify;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 ongoing verification operation.

=head1 SYNOPSIS

 my $stream = $session->open_verify('rsa-pkcs-pss', $key, $iv);
 for my $chunk (@chunks) {
   $stream->add_data($chunk);
 }
 my $success = $stream->finish($signature);

=head1 DESCRIPTION

This class represents a verification stream.

=method add_data($plaintext)

This adds data to the verification.

=method finalize($signature)

This finished the verification and returns true if the calculated signature
matches C<$signature>, or false otherwise.


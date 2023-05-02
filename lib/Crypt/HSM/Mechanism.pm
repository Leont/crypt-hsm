package Crypt::HSM::Mechanism;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 mechanism

=head1 SYNOPSIS

 my @signers = grep { $_->has_flags('sign', 'verify') } $slot->mechanisms;

=head1 DESCRIPTION

This represents a mechanism in a PKCS implementation.

=method name()

This returns the name of the mechanism

=method min_key_size()

This returns the minimum key size for this mechanism.

=method max_key_size()

This returns the maximum key size for this mechanism.

=method flags()

This array lists properties of the mechanism. It may contain values like C<'encrypt'>, C<'decrypt'>, C<'sign'>, C<'verify'>, C<'generate'>, C<'wrap'> and C<'unwrap'>.

=method has_flags(@flags)

This returns true the flags contain all of C<@flags>.

=method info()

This returns a hash with information about the mechanism. This includes the following fields.

=over 4

=item * min-key-size

The minimum key size

=item * max-key-size

The maximum key size

=item * flags

This contains the flags much like the C<flags> method.

=back

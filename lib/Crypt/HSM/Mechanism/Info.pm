package Crypt::HSM::Mechanism::Info;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: PKCS11 mechanism information


=method min_key_size()

This returns the minimum key size for this mechanism.

=method max_key_size()

This returns the maximum key size for this mechanism.

=method flags()

This hash with properties of the mechanism. It contains the following entries:

=over 4

=item * C<hw>

True if the mechanism is performed by the device; false if the mechanism is performed in software.

=item * C<encrypt>

true if the mechanism can be used with c<encrypt>.

=item * C<decrypt>

True if the mechanism can be used with C<decrypt>

=item * C<digest>

True if the mechanism can be used with C<digest>

=item * C<sign>

True if the mechanism can be used with C<sign>

=item * C<sign-recover>

True if the mechanism can be used with C<sign_recover>

=item * C<verify>

True if the mechanism can be used with C<verify>

=item * C<verify-recover>

True if the mechanism can be used with C<verify_recover>

=item * C<generate>

True if the mechanism can be used with C<generate>

=item * C<generate-key-pair>

True if the mechanism can be used with C<generate_key_pair>

=item * C<wrap>

True if the mechanism can be used with C<wrap>

=item * C<unwrap>

True if the mechanism can be used with C<unwrap>

=item * C<derive>

True if the mechanism can be used with C<derive>

=item * C<extension>

True if there is an extension to the flags; false if no extensions.

=back

=method has_flags(@flags)

This returns true the flags contain all of C<@flags>.

=method hash()

This returns a hash with information about the mechanism. This includes the following fields.

=over 4

=item * min-key-size

The minimum key size

=item * max-key-size

The maximum key size

=item * flags

This contains the flags much like the C<flags> method.

=back


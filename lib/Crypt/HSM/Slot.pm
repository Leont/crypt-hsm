package Crypt::HSM::Slot;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 slot

=head1 SYNOPSIS

 my $session = $slot->open_session;

=head1 DESCRIPTION

This represents a slot on a PKCS implementation.

=method open_session($flags = [])

This opens a session to this slot. C<$flag> is an optional array that may currenlt contain the value C<'rw-session'> to enable writing to the token. This returns a Crypt::HSM::Session object.

=method mechanisms()

This returns all mechanisms supported by the token in the slot as L<Crypt::HSM::Mechanism|Crypt::HSM::Mechanism> objects.

=method mechanism($name)

This returns the named mechanism as a L<Crypt::HSM::Mechanism|Crypt::HSM::Mechanism> object.

=method id()

This returns the identifier of this slot.

=method close_all_sessions()

This closes all sessions on this slot.

=method info()

This returns a hash with information about the slot.

=method token_info()

This returns a hash with information about the token in the slot.

=method init_token($pin, $label)

This initializes a token on the slot, with the associalted C<$pin> and C<$label> (max 32 characters).

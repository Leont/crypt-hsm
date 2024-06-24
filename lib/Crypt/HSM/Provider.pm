package Crypt::HSM::Provider;

use strict;
use warnings;

1;

#ABSTRACT: A PKCS11 provider

=head1 SYNOPSIS

 my $hsm = Crypt::HSM->load('/usr/lib/pkcs11/libsofthsm2.so');
 my ($slot) = $hsm->slots;
 my $session = $slot->open_session;
 $session->login('user', '1234');

=head1 DESCRIPTION

This module interfaces with any PKCS11 interface to use its cryptography.

=method slots($available = 1)

This lists the slots of this interface as L<Crypt::HSM::Slot|Crypt::HSM::Slot>. If C<$available> is true only slots with a token available will be listed.

=method slot($identifier)

This returns a L<Crypt::HSM::Slot|Crypt::HSM::Slot> for the slot with the given identifier.

=method info()

This returns a hash with information about the HSM.

=method wait_for_event(@flags)

This will wait until an event happens (e.g. a token becomes available in a slot). It currently supports only one flag C<'dont-block'>. It returns a L<Crypt::HSM::Slot|Crypt::HSM::Slot>, or if C<'dont-block'> is passed and no event is pending it returns C<undef>.

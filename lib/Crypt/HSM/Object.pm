package Crypt::HSM::Object;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 object

=head1 SYNOPSIS

 my ($key) = $session->find_objects({ label => $label, encrypt => 1 });
 if (not $key) {
	$key = $session->generate_key('aes-key-gen', { label => $label, sensitive => 1, "value-len" => 32 });
 }
 $session->encrypt('aes-gcm', $key, $plaintext, $nonce);

=head1 DESCRIPTION

This class represents an object (usually a key) in the HSM's database. The type of the object us stored in the C<class> attribute, and can be one of C<data>, C<certificate>, C<public-key>, C<private-key>, C<secret-key>, C<hw-feature>, C<domain-parameters>, C<mechanism>, C<otp-key>, C<profile>, or C<vendor-defined>; this type will define what other attributes are available for it.

It's returned by L<Crypt::HSM::Session|Crypt::HSM::Session> methods like C<find_object> and C<generate_key>, and used in methods such as C<encrypt>, C<decrypt>, C<sign> and C<verify>.

=method copy_object($attributes = {})

Copy the object, optionally adding/modifying the given attributes.

=method destroy_object()

This deletes this object from the slot.

=method get_attribute($attribute_name)

This returns the value of the named attribute of the object.

=method get_attributes(\@attribute_list)

This returns a hash with the attributes of the object that are asked for.

=method object_size()

This returns the size of this object.

=method set_attributes($attributes)

This sets the C<$attributes> on this object.

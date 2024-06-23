package Crypt::HSM::Key;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 key object

=head1 SYNOPSIS

=head1 DESCRIPTION



=method copy_object($attributes)

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


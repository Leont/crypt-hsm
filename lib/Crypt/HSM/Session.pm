package Crypt::HSM::Session;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 session

=head1 SYNOPSIS

 $session->encrypt('aes-cbc', $key, $plaintext);

 $session->sign('sha256-hmac', $key, $data);

 $session->verify('sha256-rsa-pkcs', $key, $data, $signature);

 my $key = $session->generate_key($type, { token => 1, sensitive => 1 });

 my @keys = $session->find_objects({ class => 'secret-key' });

 my $attr = $session->get_attribute

=head1 DESCRIPTION

This represents a session with a PKCS module such as an HSM. It does all 

=head2 Constants

This module uses hundreds of constants from the PKCS11 standard as short stings. They're all lowercased, without prefix and with hyphens instead of underscores. So C<CKM_SHA256_RSA_PKCS> becomes C<'sha256-rsa-pkcs'>.

=head2 Types

Various types of arguments are recurring its methods, these are:

=over 4

=item key/object

This is an identifier that refers to resource inside the HSM, it has no meaning outside of it.

=item mechanism

This is a mechanism for a cryptographic operation, e.g. C<'aes-gcm'>, C<'sha256-rsa-pkcs'> or C<'sha512-hmac'>. The list of supported mechanisms can be retrieved using the C<mechanisms> method on the C<Crypt::HSM> object.

=item attributes

This is an hash of attributes. The key is the name of the attribute (e.g. C<'class'>, C<'sensitive'>), the value depends on the key but is usually either an integer, a string or a bool.

=back

=method copy_object($object, $attributes)

Copy an object, optionally adding/modifying the given attributes.

=method create_object($attributes)

Create an object with the given C<$attribute> hash.

=method decrypt($mechanism, $key, $ciphertext)

Decrypt C<$ciphertext> with C<$mechanism> and C<$key>.

=method derive_key($mechanism, $key, $attributes)

Derive a new key from C<$key>, using mechanism and setting C<$attributes> on it.

=method destroy_object($object)

This deletes the object with the identifier C<$object>

=method digest($mechanism, $key, $input)

Digest C<$input> with C<$mechanism> and C<$key>.

=method encrypt($mechanism, $key, $plaintext)

Encrypt C<$plaintext> with C<$mechanism> and C<$key>.

=method find_objects($attributes)

Find all objects that satisfy the given C<$attributes>

=method generate_key($mechanism, $attributes)

Generate a new key for C<$mechanism> with C<$attributes>. Some relevant attributes are:

=over 4

=item * label

A label to your key, this helps with alter retreiving the key.

=item * token

If true this will store the key on the token, if false it will create a session key.

=item * sensitive

Sensitive keys cannot be revealed in plaintext, this is almost always desired for non-public keys.

=item * extractable

This allows the key to be extractable, for example using wrapping. 

=item * wrap-with-trusted

If true a key can only be extracted with a trusted key

=item * trusted

This marks the key as trusted, this usually requires logging in as security officer.

=item * private

If true the key can't be used without logging in.

=item * value-len

This sets the length of a key, this can be useful when creating a C<'generic-secret-key-gen'> in particular.

=back

Most of these have implementation-specific defaults.

=method generate_keypair($mechanism, $public_attributes, $private_attributes)

This generates a key pair. The attributes for the 

=method generate_random($length)

This generate C<$length> bytes of randomness.

=method get_attributes($object, $attribute_list)

This returns a hash with the attributes that are asked for.

=method info()

This returns information about the current session.

=method init_pin($pin)

This initializes the PIN for this slot.

=method login($type, $pin)

Log in the current session. C<$type> should be either C<'user'> (most likely), C<'so'> (security officer, for elevated privileges), or C<'context-dependent'>. C<$pin> is your password.

=method logout()

Log the current session out.

=method object_size($object)

This returns the size of C<$object>

=method seed_random($seed)

Mix additional seed material into the token’s random number generator

=method set_attributes($object, $attributes)

This sets the C<$attributes> on C<$object>.

=method set_pin($old_pin, $new_pin)

This changes the PIN from C<$old_pin> to C<$new_pin>.

=method sign($mechanism, $key, $input)

This creates a signature over C<$input> using C<$mechanism> and C<$key>.

=method unwrap_key($mechanism, $unwrap_key, $wrapped_key, $attributes)

This unwraps the key wrapped in the bytearray C<$wrapped_key> using C<mechanism> and C<$unwrap_key>, setting C<$attributes> on the new key.

=method verify($mechanism, $key, $data, $signature)

Verify that C<$signature> matches C<$data>, using C<$mechanism> and C<$key>.

=method wrap_key($mechanism, $wrap_key, $key)

This wraps C<$key> using C<$mechanism> and C<$wrap_key>.

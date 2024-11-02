package Crypt::HSM::Session;

use strict;
use warnings;

# Contains the actual implementation
use Crypt::HSM;

1;

#ABSTRACT: A PKCS11 session

=head1 SYNOPSIS

 $session->login('user', $password) if defined $password;

 my ($key) = $session->find_objects({ label => $label, encrypt => 1 });
 if (not $key) {
	$key = $session->generate_key('aes-key-gen', { label => $label, sensitive => 1, "value-len" => 32 });
 }
 my $iv = $session->generate_random(16);
 $session->encrypt('aes-cbc', $key, $plaintext, $iv);

=head1 DESCRIPTION

This represents a session with a PKCS module such as an HSM. It does most of the cryptographic work of using a PKCS11 interface.

=head2 Constants

This module uses hundreds of constants from the PKCS11 standard as short stings. They're all lowercased, without prefix and with hyphens instead of underscores. So C<CKM_SHA256_RSA_PKCS> becomes C<'sha256-rsa-pkcs'>. In KDF names, the <-kdf> part is eliminated.

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

=head2 Additional arguments

Many functions will also take one or more mechanism specific additional arguments after their generic arguments, for example an IV or nonce for a symmetric cipher, or a public key for a Diffie-Hellman derivation. Where supported these are documented in L<Crypt::HSM::Mechanism|Crypt::HSM::Mechanism>.

=method create_object($attributes)

Create an object with the given C<$attribute> hash. This returns a L<Crypt::HSM::Object|Crypt::HSM::Object> object.

=method decrypt($mechanism, $key, $ciphertext, ...)

Decrypt C<$ciphertext> with C<$mechanism> and C<$key>. This may take mechanism dependent additional arguments such as an IV.

=method derive_key($mechanism, $key, $attributes, ...)

Derive a new key from C<$key>, using mechanism and setting C<$attributes> on it. This may take mechanism dependent additional arguments. This returns a L<Crypt::HSM::Object|Crypt::HSM::Object> object.

=method digest($mechanism, $key, $input, ...)

Digest C<$input> with C<$mechanism> and C<$key>. This may take mechanism dependent additional arguments.

=method encrypt($mechanism, $key, $plaintext, ...)

Encrypt C<$plaintext> with C<$mechanism> and C<$key>. This may take mechanism dependent additional arguments such as an IV.

=method find_objects($attributes)

Find all objects that satisfy the given C<$attributes>. This returns a list of L<Crypt::HSM::Object|Crypt::HSM::Object> objects.

=method generate_key($mechanism, \%attributes)

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

Most of these have implementation-specific defaults. This returns a L<Crypt::HSM::Object|Crypt::HSM::Object> object.

=method generate_keypair($mechanism, \%public_attributes, \%private_attributes)

This generates a key pair. The attributes for the public and private keys work similar to `generate_key`. This returns two L<Crypt::HSM::Object|Crypt::HSM::Object> objects.

=method generate_random($length)

This generate C<$length> bytes of randomness.

=method info()

This returns information about the current session.

=method init_pin($pin)

This initializes the PIN for this slot.

=method login($type, $pin)

Log in the current session. C<$type> should be either C<'user'> (most likely), C<'so'> (security officer, for elevated privileges), or C<'context-dependent'>. C<$pin> is your password. This is needed on some providers but not all.

=method logout()

Log the current session out.

=method open_decrypt($mechanism, $key, ...)

Start a decryption with C<$mechanism> and C<$key>. This returns a L<Crypt::HSM::Decrypt|Crypt::HSM::Decrypt> object. This may take mechanism dependent additional arguments such as an IV.

=method open_digest($mechanism, ...)

Start a digest with C<$mechanism>. This returns a L<Crypt::HSM::Digest|Crypt::HSM::Digest> object. This may take mechanism dependent additional arguments.

=method open_encrypt($mechanism, $key, ...)

Start an encryption with C<$mechanism> and C<$key>. This returns a L<Crypt::HSM::Encrypt|Crypt::HSM::Encrypt> object. This may take mechanism dependent additional arguments such as an IV.

=method open_sign($mechanism, $key, ...)

Start an signing with C<$mechanism> and C<$key>. This returns a L<Crypt::HSM::Sign|Crypt::HSM::Sign> object. This may take mechanism dependent additional arguments.

=method open_verify($mechanism, $key, ...)

Start an verification with C<$mechanism> and C<$key>. This returns a L<Crypt::HSM::Verify|Crypt::HSM::Verify> object. This may take mechanism dependent additional arguments.

=method provider()

Returns the provider object for this session.

=method seed_random($seed)

Mix additional seed material into the token’s random number generator.

=method set_pin($old_pin, $new_pin)

This changes the PIN from C<$old_pin> to C<$new_pin>.

=method sign($mechanism, $key, $input, ...)

This creates a signature over C<$input> using C<$mechanism> and C<$key>. This may take mechanism dependent additional arguments.

=method slot()

Returns the slot identifier used for this session.

=method unwrap_key($mechanism, $unwrap_key, $wrapped_key, $attributes, ...)

This unwraps the key wrapped in the bytearray C<$wrapped_key> using C<mechanism> and key C<$unwrap_key>, setting C<$attributes> on the new key. This returns a L<Crypt::HSM::Object|Crypt::HSM::Object> object.

=method verify($mechanism, $key, $data, $signature, ...)

Verify that C<$signature> matches C<$data>, using C<$mechanism> and C<$key>. This may take mechanism dependent additional arguments

=method wrap_key($mechanism, $wrap_key, $key, ...)

This wraps key C<$key> using C<$mechanism> and key C<$wrap_key>.

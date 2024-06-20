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

=head1 ADDITIONAL ARGUMENTS

The following mechanism types have the following additional arguments for their respective operations:

=over 4

=item * C<'aes-cbc'>

=item * C<'aes-cbc-pad'>

=item * C<'aes-ofb'>

=item * C<'aes-cfb8'>

=item * C<'aes-cfb128'>

=item * C<'des-cbc'>

=item * C<'des-cbc-pad'>

=item * C<'des-ofb'>

=item * C<'des-cfb8'>

=item * C<'des-cfb128'>

=item * C<'des3-cbc'>

These take an IV as mandatory additional argument.

=item * C<'aes-ctr'>

This take an IV as mandatory additional argument. It also takes a counter length (in bits) as an optional argument, defaulting to 128.

=item * C<'aes-gcm'>

This take an IV as mandatory additional argument. It also takes an additional authenticated data section argument (defaulting to empty), and a tag length (in bits), defaulting to 128.

=item * C<'chacha20-poly1305'>

=item * C<'salsa20-poly1305'>

These take a nonce as mandatory additional argument. It also takes an additional authenticated data section argument (defaulting to empty).

=item * C<'rsa-pkcs-pss'>

This takes a hash and generator function as mandatory arguments, and optionally a salt length in bits (defaulting to 0).

=item * C<'sha224-rsa-pkcs-pss'>

=item * C<'sha256-rsa-pkcs-pss'>

=item * C<'sha384-rsa-pkcs-pss'>

=item * C<'sha512-rsa-pkcs-pss'>

These take an optional salt length in bits (defaulting to 0).

=item * C<'ecdh1-derive'>

=item * C<'ecdh1-cofactor-derive'>

These takes one mandatory argument: the public key to derive the new key with. It also takes two option arguments: the first is the key derivation function (defaulting to C<"null">), the second is the shared data for key derivation (defaulting to none).

=item * C<'concatenate-data-and-base'>

=item * C<'concatenate-base-and-data'>

=item * C<'aes-ecb-encrypt-data'>

=item * C<'des-ecb-encrypt-data'>

These takes the public data as mandatory additional argument.

=item * C<'concatenate-base-and-key'>

This takes a key identifier as mandatory additional argument.

=item * C<'aes-cbc-encrypt-data'>

=item * C<'des-cbc-encrypt-data'>

These takes the public data and an IV as mandatory additional arguments.

=item * C<'rsa-pkcs-oaep'>

This takes two mandatory arguments: the hash and the generator function.

=item * C<'eddsa'>

This takes two optional arguments. If no arguments are given it's run in pure mode, if they are given it's run in contextual mode. The first argument is the context data. The second is the pre-hash flag: if true it will enable pre-hashing mode.

=back

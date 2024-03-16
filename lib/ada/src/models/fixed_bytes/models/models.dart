import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/models/constant.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/core/fixed_bytes.dart';

/// Represents a Policy ID hash..
class PolicyID extends FixedBytes {
  PolicyID(List<int> data)
      : super(data, AdaTransactionConstant.blake2b224DigestSize);

  /// Constructor to create a PolicyID from hexadecimal string.
  PolicyID.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b224DigestSize);

  /// Deserialize a PolicyID from a CBOR byte value.
  PolicyID.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b224DigestSize);
}

/// Represents an Ed25519 key hash..
class Ed25519KeyHash extends FixedBytes {
  /// Constructor to create an Ed25519KeyHash from raw bytes.
  Ed25519KeyHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b224DigestSize);

  /// Constructor to create an Ed25519KeyHash from a hexadecimal string.
  Ed25519KeyHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b224DigestSize);

  /// Constructor to create an Ed25519KeyHash from a public key bytes.
  Ed25519KeyHash.fromPubkey(List<int> pubKeyBytes)
      : super(AdaAddressUtils.publicKeyToHash(pubKeyBytes),
            AdaTransactionConstant.blake2b224DigestSize);

  /// Deserialize an Ed25519KeyHash from a CBOR byte value.
  Ed25519KeyHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b224DigestSize);
}

/// Represents an Ed25519 pool key hash..
class Ed25519PoolKeyHash extends FixedBytes {
  /// Constructor to create an Ed25519PoolKeyHash from raw bytes.
  Ed25519PoolKeyHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b224DigestSize);

  /// Constructor to create an Ed25519PoolKeyHash from a hexadecimal string.
  Ed25519PoolKeyHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b224DigestSize);

  /// Constructor to create an Ed25519PoolKeyHash from a Bech32-encoded pool ID.
  Ed25519PoolKeyHash.fromBech32(String bech32PoolId)
      : super(AdaAddressUtils.decodePoolIdBech32(bech32PoolId),
            AdaTransactionConstant.blake2b224DigestSize);

  /// Deserialize an Ed25519PoolKeyHash from a CBOR byte value.
  Ed25519PoolKeyHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b224DigestSize);

  /// Constructor to create an Ed25519PoolKeyHash from a public key bytes.
  Ed25519PoolKeyHash.fromPubkey(List<int> pubKeyBytes)
      : super(AdaAddressUtils.publicKeyToHash(pubKeyBytes),
            AdaTransactionConstant.blake2b224DigestSize);
}

/// Represents a script hash..
class ScriptHash extends FixedBytes {
  /// Constructor to create a ScriptHash from raw bytes.
  ScriptHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b224DigestSize);

  /// Constructor to create a ScriptHash from a hexadecimal string.
  ScriptHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b224DigestSize);

  /// Deserialize a ScriptHash from a CBOR byte value.
  ScriptHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b224DigestSize);
}

/// Represents a hash for a genesis delegate.
class GenesisDelegateHash extends FixedBytes {
  /// Constructor to create a GenesisDelegateHash from raw bytes.
  GenesisDelegateHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b224DigestSize);

  /// Constructor to create a GenesisDelegateHash from a hexadecimal string.
  GenesisDelegateHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b224DigestSize);

  /// Deserialize a GenesisDelegateHash from a CBOR byte value.
  GenesisDelegateHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b224DigestSize);
}

/// Represents a hash for a genesis.
class GenesisHash extends FixedBytes {
  /// Constructor to create a GenesisHash from raw bytes.
  GenesisHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b224DigestSize);

  /// Constructor to create a GenesisHash from a hexadecimal string.
  GenesisHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b224DigestSize);

  /// Deserialize a GenesisHash from a CBOR byte value.
  GenesisHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b224DigestSize);
}

/// Represents a hash for a transaction.
class TransactionHash extends FixedBytes {
  /// Constructor to create a TransactionHash from raw bytes.
  TransactionHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create a TransactionHash from a hexadecimal string.
  TransactionHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b256DigestSize);

  /// Deserialize a TransactionHash from a CBOR byte value.
  TransactionHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b256DigestSize);
}

/// Represents a hash for auxiliary data.
class AuxiliaryDataHash extends FixedBytes {
  /// Constructor to create an AuxiliaryDataHash from raw bytes.
  AuxiliaryDataHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create an AuxiliaryDataHash from a hexadecimal string.
  AuxiliaryDataHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b256DigestSize);

  /// Deserialize an AuxiliaryDataHash from a CBOR byte value.
  AuxiliaryDataHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b256DigestSize);
}

/// Represents a hash for pool metadata.
class PoolMetadataHash extends FixedBytes {
  /// Constructor to create a PoolMetadataHash from raw bytes.
  PoolMetadataHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create a PoolMetadataHash from a hexadecimal string.
  PoolMetadataHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b256DigestSize);

  /// Deserialize a PoolMetadataHash from a CBOR byte value.
  PoolMetadataHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b256DigestSize);
}

/// Represents a VRF key hash.
class VRFKeyHash extends FixedBytes {
  /// Constructor to create a VRFKeyHash from raw bytes.
  VRFKeyHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create a VRFKeyHash from a hexadecimal string.
  VRFKeyHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b256DigestSize);

  /// Deserialize a VRFKeyHash from a CBOR byte value.
  VRFKeyHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b256DigestSize);
}

/// Represents a block hash.
class BlockHash extends FixedBytes {
  /// Constructor to create a BlockHash from raw bytes.
  BlockHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create a BlockHash from a hexadecimal string.
  BlockHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b256DigestSize);

  /// Deserialize a BlockHash from a CBOR byte value.
  BlockHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b256DigestSize);
}

/// Represents a script data hash.
class ScriptDataHash extends FixedBytes {
  /// Constructor to create a ScriptDataHash from raw bytes.
  ScriptDataHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create a ScriptDataHash from a hexadecimal string.
  ScriptDataHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b256DigestSize);

  /// Deserialize a ScriptDataHash from a CBOR byte value.
  ScriptDataHash.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b256DigestSize);
}

/// Represents a VRF verification key.
class VRFVKey extends FixedBytes {
  /// Constructor to create a VRF verification key from raw bytes.
  VRFVKey(List<int> data)
      : super(data, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create a VRF verification key from a hexadecimal string.
  VRFVKey.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b256DigestSize);

  /// Deserialize a VRF verification key from a CBOR byte value.
  VRFVKey.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b256DigestSize);
}

/// Represents a KES verification key.
class KESVKey extends FixedBytes {
  /// Constructor to create a KES verification key from raw bytes.
  KESVKey(List<int> data)
      : super(data, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create a KES verification key from a hexadecimal string.
  KESVKey.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b256DigestSize);

  /// Deserialize a KES verification key from a CBOR byte value.
  KESVKey.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b256DigestSize);
}

/// Represents a KES signature.
class KESSignature extends FixedBytes {
  /// Length of the KES signature in bytes.
  static const int length = 448;

  /// Constructor to create a KES signature from raw bytes.
  KESSignature(List<int> data) : super(data, length);

  /// Constructor to create a KES signature from a hexadecimal string.
  KESSignature.fromHex(String hexBytes) : super.fromHex(hexBytes, length);

  /// Deserialize a KES signature from a CBOR byte value.
  KESSignature.deserialize(CborBytesValue cbor) : super(cbor.value, length);
}

/// Represents a verification key (Vkey).
class Vkey extends FixedBytes {
  /// Constructor to create a Vkey from raw bytes.
  Vkey(List<int> data)
      : super(data, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create a Vkey from a hexadecimal string.
  Vkey.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b256DigestSize);

  /// Deserialize a Vkey from a CBOR byte value.
  Vkey.deserialize(CborBytesValue cbor)
      : super(cbor.value, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create a Vkey from a public key byte array.
  Vkey.fromPubKey(List<int> pubKeyBytes)
      : super(AdaAddressUtils.validatePubkeyAndRemovePrefix(pubKeyBytes),
            AdaTransactionConstant.blake2b256DigestSize);
}

/// Represents a data hash.
class DataHash extends FixedBytes {
  /// Constructor to create a data hash from raw bytes.
  DataHash(List<int> data)
      : super(data, AdaTransactionConstant.blake2b256DigestSize);

  /// Constructor to create a data hash from a hexadecimal string.
  DataHash.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b256DigestSize);
}

/// Represents an Ed25519 signature.
class Ed25519Signature extends FixedBytes {
  /// Constructs an Ed25519 signature instance.
  Ed25519Signature(List<int> signatureBytes)
      : super(signatureBytes, AdaTransactionConstant.signatureLength);

  /// Constructs an Ed25519 signature from hexadecimal bytes.
  Ed25519Signature.fromHex(String signatureHexBytes)
      : super.fromHex(
            signatureHexBytes, AdaTransactionConstant.signatureLength);

  /// Deserializes an Ed25519 signature from CBOR bytes.
  Ed25519Signature.deserialize(CborBytesValue signatureHexBytes)
      : super(signatureHexBytes.value, AdaTransactionConstant.signatureLength);
}

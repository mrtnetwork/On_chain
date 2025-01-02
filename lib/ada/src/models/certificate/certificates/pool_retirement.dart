import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/core/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/core/types.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

/// Represents a pool retirement certificate with serialization support.
class PoolRetirement extends Certificate {
  /// The hash of the pool key.
  final Ed25519KeyHash poolKeyHash;

  /// The epoch of the retirement.
  final int epoch;

  /// Constructs a PoolRetirement object with the specified epoch and pool key hash.
  const PoolRetirement({required this.epoch, required this.poolKeyHash});

  /// Deserializes a PoolRetirement object from its CBOR representation.
  factory PoolRetirement.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.getIndex(0),
        validate: CertificateType.poolRetirement);
    return PoolRetirement(
        epoch: cbor.getIndex<int>(2),
        poolKeyHash: Ed25519KeyHash.deserialize(cbor.getIndex(1)));
  }
  factory PoolRetirement.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson = json['pool_retirement'] ?? json;
    return PoolRetirement(
        epoch: correctJson['epoch'],
        poolKeyHash: Ed25519KeyHash.fromHex(correctJson['pool_keyhash']));
  }

  PoolRetirement copyWith({
    Ed25519KeyHash? poolKeyHash,
    int? epoch,
  }) {
    return PoolRetirement(
        poolKeyHash: poolKeyHash ?? this.poolKeyHash,
        epoch: epoch ?? this.epoch);
  }

  @override
  CertificateType get type => CertificateType.poolRetirement;

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength(
        [type.toCbor(), poolKeyHash.toCbor(), CborUnsignedValue.u32(epoch)]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'pool_retirement': {'pool_keyhash': poolKeyHash.toJson(), 'epoch': epoch}
    };
  }
}

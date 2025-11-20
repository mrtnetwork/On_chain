import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

/// Represents pool metadata
class PoolMetadata with InternalCborSerialization {
  /// The URL of the pool metadata.
  final String url;

  /// The hash of the pool metadata.
  final PoolMetadataHash poolMetadataHash;

  /// Constructs a PoolMetadata object with the specified URL and pool metadata hash.
  const PoolMetadata({required this.url, required this.poolMetadataHash});

  /// Deserializes a PoolMetadata object from its CBOR representation.
  factory PoolMetadata.deserialize(CborListValue cbor) {
    return PoolMetadata(
        url: cbor.elementAtString(0),
        poolMetadataHash:
            PoolMetadataHash.deserialize(cbor.elementAt<CborBytesValue>(1)));
  }

  factory PoolMetadata.fromJson(Map<String, dynamic> json) {
    return PoolMetadata(
        url: json['url'],
        poolMetadataHash: PoolMetadataHash.fromHex(json['pool_metadata_hash']));
  }

  PoolMetadata copyWith({String? url, PoolMetadataHash? poolMetadataHash}) {
    return PoolMetadata(
        url: url ?? this.url,
        poolMetadataHash: poolMetadataHash ?? this.poolMetadataHash);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      CborStringValue(url),
      poolMetadataHash.toCbor(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'url': url, 'pool_metadata_hash': poolMetadataHash.toJson()};
  }
}

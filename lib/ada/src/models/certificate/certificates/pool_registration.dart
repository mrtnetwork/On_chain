import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/core/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/core/types.dart';
import 'package:on_chain/ada/src/models/certificate/types/pool/pool_params.dart';

/// Represents a pool registration certificate with serialization support.
class PoolRegistration extends Certificate {
  /// The parameters of the pool being registered.
  final PoolParams poolParams;

  /// Constructs a PoolRegistration object with the specified pool parameters.
  const PoolRegistration(this.poolParams);

  /// Deserializes a PoolRegistration object from its CBOR representation.
  factory PoolRegistration.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.getIndex(0),
        validate: CertificateType.poolRegistration);
    return PoolRegistration(
        PoolParams.deserialize(cbor.sublist<CborObject>(1)));
  }
  factory PoolRegistration.fromJson(Map<String, dynamic> json) {
    return PoolRegistration(PoolParams.fromJson(
        json['pool_params'] ?? json['pool_registration']['pool_params']));
  }
  PoolRegistration copyWith({PoolParams? poolParams}) {
    return PoolRegistration(poolParams ?? this.poolParams);
  }

  @override
  CertificateType get type => CertificateType.poolRegistration;

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      type.toCbor(),
      ...poolParams.toCbor().cast<CborListValue<CborObject>>().value,
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'pool_registration': {'pool_params': poolParams.toJson()}
    };
  }
}

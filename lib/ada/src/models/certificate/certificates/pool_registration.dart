import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/ada/src/models/credential/models/key.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/pool/pool_params.dart';

/// Represents a pool registration certificate with serialization support.
class PoolRegistration extends Certificate {
  /// The parameters of the pool being registered.
  final PoolParams poolParams;

  /// Constructs a PoolRegistration object with the specified pool parameters.
  const PoolRegistration(this.poolParams);

  /// Deserializes a PoolRegistration object from its CBOR representation.
  factory PoolRegistration.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.poolRegistration);
    return PoolRegistration(
        PoolParams.deserialize(cbor.sublist<CborObject>(1)));
  }
  factory PoolRegistration.fromJson(Map<String, dynamic> json) {
    final currentJson = json[CertificateType.poolRegistration.name] ?? json;
    return PoolRegistration(PoolParams.fromJson(currentJson['pool_params']));
  }
  PoolRegistration copyWith({PoolParams? poolParams}) {
    return PoolRegistration(poolParams ?? this.poolParams);
  }

  @override
  CertificateType get type => CertificateType.poolRegistration;

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      ...poolParams.toCbor().as<CborListValue<CborObject>>().value,
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {'pool_params': poolParams.toJson()}
    };
  }

  @override
  List<Credential> get signersCredential =>
      poolParams.poolOwners.map((e) => CredentialKey(e.data)).toList();
}

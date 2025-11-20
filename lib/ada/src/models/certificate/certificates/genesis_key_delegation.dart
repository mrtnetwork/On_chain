import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

/// Represents a certificate for genesis key delegation.
class GenesisKeyDelegation extends Certificate {
  /// The hash of the genesis.
  final GenesisHash genesisHash;

  /// The hash of the genesis delegate.
  final GenesisDelegateHash genesisDelegateHash;

  /// The VRF key hash.
  final VRFKeyHash vrfKeyHash;

  /// Constructs a [GenesisKeyDelegation] certificate.
  const GenesisKeyDelegation(
      {required this.genesisDelegateHash,
      required this.genesisHash,
      required this.vrfKeyHash});

  /// Constructs a [GenesisKeyDelegation] instance from its serialized form.
  factory GenesisKeyDelegation.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.genesisKeyDelegation);
    return GenesisKeyDelegation(
        genesisDelegateHash:
            GenesisDelegateHash.deserialize(cbor.elementAt<CborBytesValue>(2)),
        genesisHash: GenesisHash.deserialize(cbor.elementAt<CborBytesValue>(1)),
        vrfKeyHash: VRFKeyHash.deserialize(cbor.elementAt<CborBytesValue>(3)));
  }
  factory GenesisKeyDelegation.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson =
        json[CertificateType.genesisKeyDelegation.name] ?? json;
    return GenesisKeyDelegation(
        genesisDelegateHash:
            GenesisDelegateHash.fromHex(correctJson['genesis_delegate_hash']),
        genesisHash: GenesisHash.fromHex(correctJson['genesishash']),
        vrfKeyHash: VRFKeyHash.fromHex(correctJson['vrf_keyhash']));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      genesisHash.toCbor(),
      genesisDelegateHash.toCbor(),
      vrfKeyHash.toCbor()
    ]);
  }

  @override
  CertificateType get type => CertificateType.genesisKeyDelegation;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'genesishash': genesisHash.toJson(),
        'genesis_delegate_hash': genesisDelegateHash.toJson(),
        'vrf_keyhash': vrfKeyHash.toJson()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [];
}

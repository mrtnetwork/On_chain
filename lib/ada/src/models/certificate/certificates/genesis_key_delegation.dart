import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/core/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/core/types.dart';
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
    CertificateType.deserialize(cbor.getIndex(0),
        validate: CertificateType.genesisKeyDelegation);
    return GenesisKeyDelegation(
        genesisDelegateHash: GenesisDelegateHash.deserialize(cbor.getIndex(2)),
        genesisHash: GenesisHash.deserialize(cbor.getIndex(1)),
        vrfKeyHash: VRFKeyHash.deserialize(cbor.getIndex(3)));
  }
  factory GenesisKeyDelegation.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson =
        json["genesis_key_delegation"] ?? json;
    return GenesisKeyDelegation(
        genesisDelegateHash:
            GenesisDelegateHash.fromHex(correctJson["genesis_delegate_hash"]),
        genesisHash: GenesisHash.fromHex(correctJson["genesishash"]),
        vrfKeyHash: VRFKeyHash.fromHex(correctJson["vrf_keyhash"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
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
      "genesis_key_delegation": {
        "genesishash": genesisHash.toJson(),
        "genesis_delegate_hash": genesisDelegateHash.toJson(),
        "vrf_keyhash": vrfKeyHash.toJson()
      }
    };
  }
}

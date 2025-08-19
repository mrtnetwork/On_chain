import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/keypair/keypair/public_key.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/block/models/header/header/protocol_version.dart';

import '../leader_cert/models/header_leader_cert.dart';
import 'operational_cert.dart';

class HeaderBody with ADASerialization {
  final int blockNumber;
  final BigInt slot;
  final BlockHash? prevHash;
  final AdaPublicKey issuerKey;
  final VRFVKey vrfvKey;
  final HeaderLeaderCert leaderCert;
  final int blockBodySize;
  final BlockHash blockBodyHash;
  final OperationalCert operationalCert;
  final ProtocolVersion protocolVersion;

  const HeaderBody(
      {required this.blockBodyHash,
      required this.slot,
      required this.blockBodySize,
      required this.blockNumber,
      required this.issuerKey,
      required this.leaderCert,
      required this.operationalCert,
      required this.prevHash,
      required this.protocolVersion,
      required this.vrfvKey});

  factory HeaderBody.fromJson(Map<String, dynamic> json) {
    return HeaderBody(
      blockNumber: json['block_number'],
      slot: BigInt.parse(json['slot']),
      prevHash: json['prev_hash'] != null
          ? BlockHash.fromHex(json['prev_hash'])
          : null,
      issuerKey: AdaPublicKey.fromHex(json['issuer_key']),
      vrfvKey: VRFVKey.fromHex(json['vrfv_key']),
      leaderCert: HeaderLeaderCert.fromJson(json['leader_cert']),
      blockBodySize: json['block_body_size'],
      blockBodyHash: BlockHash.fromHex(json['block_body_hash']),
      operationalCert: OperationalCert.fromJson(json['operational_cert']),
      protocolVersion: ProtocolVersion.fromJson(json['protocol_version']),
    );
  }

  factory HeaderBody.fromCborBytes(List<int> cborBytes) {
    return HeaderBody.deserialize(
        CborObject.fromCbor(cborBytes).as<CborListValue>("HeaderBody"));
  }
  factory HeaderBody.deserialize(CborListValue cbor) {
    final int leaderCertSize =
        cbor.elementAt<CborObject>(6).hasType<CborListValue>() ? 2 : 1;
    final int operationIndex = 5 + leaderCertSize + 2;
    final int protocolVersionIndex = operationIndex + 4;
    return HeaderBody(
        blockBodyHash: BlockHash.deserialize(
            cbor.elementAt<CborBytesValue>(5 + leaderCertSize + 1)),
        slot: cbor.elementAsInteger(1),
        blockBodySize: cbor.elementAt<CborNumeric>(5 + leaderCertSize).toInt(),
        blockNumber: cbor.elementAt<CborNumeric>(0).toInt(),
        issuerKey: AdaPublicKey.fromBytes(cbor.elementAtBytes(3)),
        leaderCert:
            HeaderLeaderCert.deserialize(cbor.sublist(5, 5 + leaderCertSize)),
        operationalCert: OperationalCert.deserialize(
            cbor.sublist(operationIndex, operationIndex + 4)),
        prevHash: cbor
            .elementAt<CborBytesValue?>(2)
            ?.convertTo<BlockHash, CborBytesValue>(
                (e) => BlockHash.deserialize(e)),
        protocolVersion:
            ProtocolVersion.deserialize(cbor.sublist(protocolVersionIndex)),
        vrfvKey: VRFVKey.deserialize(cbor.elementAt<CborBytesValue>(4)));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      CborSignedValue.i32(blockNumber),
      CborUnsignedValue.u64(slot),
      prevHash?.toCbor() ?? const CborNullValue(),
      CborBytesValue(issuerKey.toBytes(false)),
      vrfvKey.toCbor(),
      ...leaderCert.toCborObjects(),
      CborUnsignedValue.u32(blockBodySize),
      blockBodyHash.toCbor(),
      ...operationalCert.toCborObjects(),
      ...protocolVersion.toCborObjects()
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'block_number': blockNumber,
      'slot': slot.toString(),
      'prev_hash': prevHash?.toJson(),
      'issuer_key': issuerKey.toHex(),
      'vrfv_key': vrfvKey.toJson(),
      'leader_cert': leaderCert.toJson(),
      'block_body_size': blockBodySize,
      'block_body_hash': blockBodyHash.toJson(),
      'operational_cert': operationalCert.toJson(),
      'protocol_version': protocolVersion.toJson(),
    };
  }
}

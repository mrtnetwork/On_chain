import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/keypair/keypair/public_key.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/header/header/protocol_version.dart';

import '../leader_cert/header_leader_cert/header_leader_cert.dart';
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
  factory HeaderBody.fromCborBytes(List<int> cborBytes) {
    return HeaderBody.deserialize(CborObject.fromCbor(cborBytes).cast());
  }
  factory HeaderBody.deserialize(CborListValue cbor) {
    final int leaderCertSize =
        cbor.getIndex<CborObject>(6).hasType<CborListValue>() ? 2 : 1;
    final int operationIndex = 5 + leaderCertSize + 2;
    final int protocolVersionIndex = operationIndex + 4;
    return HeaderBody(
        blockBodyHash:
            BlockHash.deserialize(cbor.getIndex(5 + leaderCertSize + 1)),
        slot: cbor.getIndex<CborObject>(1).getInteger(),
        blockBodySize: cbor.getIndex(5 + leaderCertSize),
        blockNumber: cbor.getIndex(0),
        issuerKey: AdaPublicKey.fromBytes(cbor.getIndex(3)),
        leaderCert:
            HeaderLeaderCert.deserialize(cbor.sublist(5, 5 + leaderCertSize)),
        operationalCert: OperationalCert.deserialize(
            cbor.sublist(operationIndex, operationIndex + 4)),
        prevHash: cbor
            .getIndex<CborObject?>(2)
            ?.castTo<BlockHash, CborBytesValue>(
                (e) => BlockHash.deserialize(e)),
        protocolVersion:
            ProtocolVersion.deserialize(cbor.sublist(protocolVersionIndex)),
        vrfvKey: VRFVKey.deserialize(cbor.getIndex(4)));
  }

  @override
  CborObject toCbor() {
    return CborCustomLengthListValue.fixedLength([
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
    ], length: 15);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "blockNumber": blockNumber,
      "slot": slot.toString(),
      "prevHash": prevHash?.toJson(),
      "issuerKey": issuerKey.toHex(),
      "vrfvKey": vrfvKey.toJson(),
      "leaderCert": leaderCert.toJson(),
      "blockBodySize": blockBodySize,
      "blockBodyHash": blockBodyHash.toJson(),
      "operationalCert": operationalCert.toJson(),
      "protocolVersion": protocolVersion.toJson()
    };
  }
}

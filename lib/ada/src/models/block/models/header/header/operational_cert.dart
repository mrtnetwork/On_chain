import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

class OperationalCert with InternalCborSerialization {
  final KESVKey hotVkey;
  final int sequenceNumber;
  final int kesPeriod;
  final Ed25519Signature sigma;
  factory OperationalCert.fromJson(Map<String, dynamic> json) {
    return OperationalCert(
      hotVkey: KESVKey.fromHex(json['hot_vkey']),
      sequenceNumber: json['sequence_number'],
      kesPeriod: json['kes_period'],
      sigma: Ed25519Signature.fromHex(json['sigma']),
    );
  }

  const OperationalCert(
      {required this.hotVkey,
      required this.sequenceNumber,
      required this.kesPeriod,
      required this.sigma});
  factory OperationalCert.deserialize(CborListValue cbor) {
    return OperationalCert(
        hotVkey: KESVKey.deserialize(cbor.elementAt<CborBytesValue>(0)),
        sequenceNumber: cbor.elementAt<CborIntValue>(1).value,
        kesPeriod: cbor.elementAt<CborIntValue>(2).value,
        sigma: Ed25519Signature.deserialize(cbor.elementAt<CborBytesValue>(3)));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite(toCborObjects());
  }

  List<CborObject> toCborObjects() {
    return [
      hotVkey.toCbor(),
      CborUnsignedValue.u32(sequenceNumber),
      CborUnsignedValue.u32(kesPeriod),
      sigma.toCbor()
    ];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hot_vkey': hotVkey.toJson(),
      'sequence_number': sequenceNumber,
      'kes_period': kesPeriod,
      'sigma': sigma.toJson(),
    };
  }

  @override
  String toString() {
    return 'OperationalCert{hotVkey: $hotVkey, sequenceNumber:$sequenceNumber, kesPeriod:$kesPeriod, sigma:$sigma}';
  }
}

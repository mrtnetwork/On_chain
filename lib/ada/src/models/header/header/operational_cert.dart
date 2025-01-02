import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

class OperationalCert with ADASerialization {
  final KESVKey hotVkey;
  final int sequenceNumber;
  final int kesPeriod;
  final Ed25519Signature sigma;

  const OperationalCert(
      {required this.hotVkey,
      required this.sequenceNumber,
      required this.kesPeriod,
      required this.sigma});
  factory OperationalCert.deserialize(CborListValue cbor) {
    return OperationalCert(
        hotVkey: KESVKey.deserialize(cbor.getIndex(0)),
        sequenceNumber: cbor.getIndex<CborIntValue>(1).value,
        kesPeriod: cbor.getIndex<CborIntValue>(2).value,
        sigma: Ed25519Signature.deserialize(cbor.getIndex(3)));
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength(toCborObjects());
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
      'hotVkey': hotVkey.toJson(),
      'sequenceNumber': sequenceNumber,
      'kesPeriod': kesPeriod,
      'sigma': sigma.toJson()
    };
  }

  @override
  String toString() {
    return 'OperationalCert{hotVkey: $hotVkey, sequenceNumber:$sequenceNumber, kesPeriod:$kesPeriod, sigma:$sigma}';
  }
}

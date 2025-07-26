import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/constant.dart';
import 'package:on_chain/ada/src/models/utils.dart';

class VRFCert with ADASerialization {
  final List<int> output;
  final List<int> proof;
  VRFCert({required List<int> output, required List<int> proof})
      : output = output.asImmutableBytes,
        proof = AdaTransactionUtils.validateFixedLengthBytes(
            bytes: proof,
            length: AdaTransactionConstant.proofLength,
            objectName: 'proof');
  VRFCert copyWith({List<int>? output, List<int>? proof}) {
    return VRFCert(output: output ?? this.output, proof: proof ?? this.proof);
  }

  factory VRFCert.deserialize(CborListValue cbor) {
    return VRFCert(output: cbor.getIndex(0), proof: cbor.getIndex(1));
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength(
        [CborBytesValue(output), CborBytesValue(proof)]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'output': BytesUtils.toHexString(output),
      'proof': BytesUtils.toHexString(proof)
    };
  }
}

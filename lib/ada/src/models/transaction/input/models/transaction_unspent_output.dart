import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/transaction/input/models/transaction_input.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/transaction_output.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class TransactionUnspentOutput with InternalCborSerialization {
  final TransactionInput input;
  final TransactionOutput output;
  const TransactionUnspentOutput({required this.input, required this.output});
  factory TransactionUnspentOutput.fromJson(Map<String, dynamic> json) {
    return TransactionUnspentOutput(
        output: TransactionOutput.fromJson(json["output"]),
        input: TransactionInput.fromJson(json["input"]));
  }

  factory TransactionUnspentOutput.deserialize(CborIterableObject cbor) {
    return TransactionUnspentOutput(
        output: TransactionOutput.deserialize(cbor.elementAt(1)),
        input: TransactionInput.deserialize(cbor.elementAt(0)));
  }

  @override
  CborListValue<CborObject> toCbor() {
    return CborListValue<CborObject>.definite(
        [input.toCbor(), output.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"input": input.toJson(), "output": output.toJson()};
  }
}

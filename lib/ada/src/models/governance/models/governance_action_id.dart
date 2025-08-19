import 'package:blockchain_utils/bip/bip.dart';
import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/types/types.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class GovernanceActionId with ADASerialization {
  final TransactionHash transactionId;
  final int index;
  const GovernanceActionId({required this.transactionId, required this.index});
  factory GovernanceActionId.deserialize(CborListValue cbor) {
    return GovernanceActionId(
        transactionId:
            TransactionHash.deserialize(cbor.elementAt<CborBytesValue>(0)),
        index: cbor.elementAt<CborIntValue>(1).value);
  }
  factory GovernanceActionId.fromJson(Map<String, dynamic> json) {
    return GovernanceActionId(
        transactionId: TransactionHash.fromHex(json["transaction_id"]),
        index: json["index"]);
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite(
        [transactionId.toCbor(), CborIntValue(index)]);
  }

  @override
  Map<String, dynamic> toJson() {
    AdaStakeCredential;
    return {"transaction_id": transactionId.toHex(), "index": index};
  }
}

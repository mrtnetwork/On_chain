import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction.dart" as proto_transaction;

/// *
///  * A simple protobuf wrapper to store a list of transactions. This is used by
///  * `Transaction.[from|to]Bytes()` in the SDKs. The reason the SDK needs a list of transactions is
///  * because it holds onto a transaction per node. So if a transaction is to be submitted to nodes 3
///  * and 4 the SDK Transaction type would contain a list of 2 protobuf transactions, one for node 3
///  * and one for node 4.
class HederaTransactionList extends HederaProtoMessage with Equality {
  final List<proto_transaction.HederaTransaction> transactionList;

  const HederaTransactionList({
    this.transactionList = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        transactionList,
      ];


HederaTransactionList copyWith(
{List<proto_transaction.HederaTransaction>? transactionList,

}) {
    return HederaTransactionList(
transactionList: transactionList ?? this.transactionList,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'transaction_list': transactionList.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaTransactionList.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTransactionList(
      transactionList: (json.valueEnsureAsList<dynamic>('transaction_list', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_transaction.HederaTransaction, Object>(
          value: e,
          parse: (v) => proto_transaction.HederaTransaction.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaTransactionList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionList(
      transactionList: decode.getListOfBytes(1).map((b) => proto_transaction.HederaTransaction.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTransactionList;

}



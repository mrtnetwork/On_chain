import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Schedule Sign
///  * Transaction body for a `scheduleSign` transaction to add signatures
///  * to an existing scheduled transaction.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.scheduled"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Add signatures to an existing scheduled transaction.
///  *
///  * When a schedule _executes_ successfully, the receipt SHALL include a
///  * `scheduledTransactionID` with the `TransactionID` of the transaction that
///  * executed.&lt;br/&gt;
///  * When a scheduled transaction is executed the network SHALL charge the
///  * regular _service_ fee for the transaction to the `payerAccountID` for
///  * that schedule, but SHALL NOT charge node or network fees.&lt;br/&gt;
///  * If the `payerAccountID` field is not set, the effective `payerAccountID`
///  * SHALL be the `payer` for this create transaction.&lt;br/&gt;
///  * Each signature on this transaction SHALL "activate" the corresponding
///  * cryptographic("primitive") key for the schedule identified.&lt;br/&gt;
///  * Signature requirements SHALL be met when the set of active keys includes
///  * all keys required by the scheduled transaction.&lt;br/&gt;
///  * A scheduled transaction for a "long term" schedule SHALL NOT execute if
///  * the signature requirements for that transaction are not met when the
///  * network consensus time reaches the schedule `expiration_time`.&lt;br/&gt;
///  * A "short term" schedule SHALL execute immediately once signature
///  * requirements are met. This MAY be immediately when created.&lt;br/&gt;
///  *
///  * ### Block Stream Effects
///  * If the scheduled transaction is executed immediately following this
///  * `scheduleSign` transaction, the transaction record SHALL include a
///  * `scheduleRef` with the schedule identifier `scheduleID`.
class HederaScheduleSignTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///    * A schedule identifier.
  ///    * &lt;p&gt;
  ///    * This MUST identify the schedule to which signatures SHALL be added.
  final proto_basic_types.HederaScheduleID? scheduleID;

  const HederaScheduleSignTransactionBody({
    this.scheduleID,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        scheduleID,
      ];


HederaScheduleSignTransactionBody copyWith(
{proto_basic_types.HederaScheduleID? scheduleID,

}) {
    return HederaScheduleSignTransactionBody(
scheduleID: scheduleID ?? this.scheduleID,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'scheduleID': config.encodeMessage(scheduleID),
    };
  }


  factory HederaScheduleSignTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaScheduleSignTransactionBody(
      scheduleID: json.valueTo<proto_basic_types.HederaScheduleID?, Object>(
        key: 'scheduleID',
        parse: (v) => proto_basic_types.HederaScheduleID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaScheduleSignTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduleSignTransactionBody(
      scheduleID: decode.messageTo<proto_basic_types.HederaScheduleID?>(1, (b) => proto_basic_types.HederaScheduleID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoScheduleSignTransactionBody;

}



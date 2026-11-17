import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Schedule Delete
///  * A transaction body for a `scheduleDelete` transaction.
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
///  * Mark a schedule in the network state as deleted.
///  *
///  * This transaction MUST be signed by the `adminKey` for the
///  * identified schedule.&lt;br/&gt;
///  * If a schedule does not have `adminKey` set or if `adminKey` is an empty
///  * `KeyList`, that schedule SHALL be immutable and MUST NOT be deleted.&lt;br/&gt;
///  * A deleted schedule SHALL not be executed.&lt;br/&gt;
///  * A deleted schedule MUST NOT be the subject of a subsequent
///  * `scheduleSign` transaction.
///  *
///  * ### Block Stream Effects
///  * None
class HederaScheduleDeleteTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///    * A schedule identifier.
  ///    * &lt;p&gt;
  ///    * This MUST identify the schedule which SHALL be deleted.
  final proto_basic_types.HederaScheduleID? scheduleID;

  const HederaScheduleDeleteTransactionBody({
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


HederaScheduleDeleteTransactionBody copyWith(
{proto_basic_types.HederaScheduleID? scheduleID,

}) {
    return HederaScheduleDeleteTransactionBody(
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


  factory HederaScheduleDeleteTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaScheduleDeleteTransactionBody(
      scheduleID: json.valueTo<proto_basic_types.HederaScheduleID?, Object>(
        key: 'scheduleID',
        parse: (v) => proto_basic_types.HederaScheduleID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaScheduleDeleteTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduleDeleteTransactionBody(
      scheduleID: decode.messageTo<proto_basic_types.HederaScheduleID?>(1, (b) => proto_basic_types.HederaScheduleID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoScheduleDeleteTransactionBody;

}



import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Schedule Service
///  * Block stream messages that report the results of transactions handled by
///  * the `Schedule` service.
///  *
///  * The Schedule service handles delayed execution in two major forms.
///  * - Transactions that only execute after being signed, via scheduleSign
///  *   transactions, with additional keys beyond the keys that signe the
///  *   scheduleCreate transaction.
///  * - Transactions that only execute after a specified consensus time.
///  *
///  * Some outputs contain a scheduled transaction identifier.&lt;br/&gt;
///  * That value SHALL be set if, and only if, the transaction resulted in
///  * _execution_ of the scheduled child transaction.&lt;br/&gt;
///  * Most outputs from this service SHALL NOT set the scheduled transaction
///  * identifier, because the transaction has not executed yet. Only when the
///  * schedule has gathered all of the signatures required to execute the
///  * scheduled child transaction is the network able to execute that child
///  * transaction, and assign a final transaction identifier.
///  *
///  * When a scheduled child transaction is executed, the identifier of the
///  * schedule that executed that transaction SHALL be included as a
///  * `schedule_ref` in the _result_ for the _child_ transaction.&lt;br/&gt;
///  * The output of the schedule transaction (create or sign) SHALL NOT contain
///  * the `schedule_ref`.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// * Copyright (C) 2024 Hedera Hashgraph, LLC
///  *
///  * Licensed under the Apache License, Version 2.0 (the "License");
///  * you may not use this file except in compliance with the License.
///  * You may obtain a copy of the License at
///  *
///  *      http://www.apache.org/licenses/LICENSE-2.0
///  *
///  * Unless required by applicable law or agreed to in writing, software
///  * distributed under the License is distributed on an "AS IS" BASIS,
///  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  * See the License for the specific language governing permissions and
///  * limitations under the License.
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream.output"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Block Stream data for a `createSchedule` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaCreateScheduleOutput extends HederaProtoMessage with Equality {
    /// *
  ///      * A schedule identifier.
  ///      * &lt;p&gt;
  ///      * If the status of the transaction is `SUCCESS`, this value SHALL be
  ///      * set to the identifier of the schedule that was created. If the
  ///      * transaction status is `IDENTICAL_SCHEDULE_ALREADY_CREATED`, this
  ///      * value SHALL be set to the identifier of the existing schedule that
  ///      * is identical to the one that was attempted to be created. For any
  ///      * other status, this value SHALL NOT be set.
  final proto_basic_types.HederaScheduleID? scheduleId;

    /// *
  ///      * A scheduled transaction identifier.
  ///      * &lt;p&gt;
  ///      * This value SHALL be the transaction identifier for the _scheduled_
  ///      * child transaction executed as a result of gathering sufficient
  ///      * signatures to complete the schedule.&lt;br/&gt;
  ///      * This value SHALL NOT be set unless the scheduled transaction was
  ///      * executed as a child of this schedule create transaction.&lt;br/&gt;
  ///      * This value SHALL NOT be set unless this schedule create transaction
  ///      * was signed by sufficient keys to meet the signature requirements
  ///      * for the scheduled child transaction immediately.
  final proto_basic_types.HederaTransactionID? scheduledTransactionId;

  const HederaCreateScheduleOutput({
    this.scheduleId,
    this.scheduledTransactionId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        scheduleId,
        scheduledTransactionId,
      ];


HederaCreateScheduleOutput copyWith(
{proto_basic_types.HederaScheduleID? scheduleId,

proto_basic_types.HederaTransactionID? scheduledTransactionId,

}) {
    return HederaCreateScheduleOutput(
scheduleId: scheduleId ?? this.scheduleId,
scheduledTransactionId: scheduledTransactionId ?? this.scheduledTransactionId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'schedule_id': config.encodeMessage(scheduleId),
      'scheduled_transaction_id': config.encodeMessage(scheduledTransactionId),
    };
  }


  factory HederaCreateScheduleOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCreateScheduleOutput(
      scheduleId: json.valueTo<proto_basic_types.HederaScheduleID?, Object>(
        key: 'schedule_id',
        parse: (v) => proto_basic_types.HederaScheduleID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      scheduledTransactionId: json.valueTo<proto_basic_types.HederaTransactionID?, Object>(
        key: 'scheduled_transaction_id',
        parse: (v) => proto_basic_types.HederaTransactionID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaCreateScheduleOutput.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCreateScheduleOutput(
      scheduleId: decode.messageTo<proto_basic_types.HederaScheduleID?>(1, (b) => proto_basic_types.HederaScheduleID.deserialize(b)),
      scheduledTransactionId: decode.messageTo<proto_basic_types.HederaTransactionID?>(2, (b) => proto_basic_types.HederaTransactionID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputCreateScheduleOutput;

}


/// *
///  * Block Stream data for a `deleteSchedule` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaDeleteScheduleOutput extends HederaProtoMessage with Equality {
  const HederaDeleteScheduleOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaDeleteScheduleOutput copyWith(
) {
    return HederaDeleteScheduleOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaDeleteScheduleOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaDeleteScheduleOutput(
    );
  }

  factory HederaDeleteScheduleOutput.deserialize(List<int> bytes) {
    return HederaDeleteScheduleOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputDeleteScheduleOutput;

}


/// *
///  * Block Stream data for a `signSchedule` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaSignScheduleOutput extends HederaProtoMessage with Equality {
    /// *
  ///      * A scheduled transaction identifier.
  ///      * &lt;p&gt;
  ///      * This value SHALL be the transaction identifier for the _scheduled_
  ///      * child transaction executed as a result of gathering sufficient
  ///      * signatures to complete the schedule.&lt;br/&gt;
  ///      * This value SHALL NOT be set unless the scheduled transaction was
  ///      * executed as a child of this schedule sign transaction.&lt;br/&gt;
  ///      * This value SHALL NOT be set unless this schedule sign transaction
  ///      * was signed by sufficient additional keys to meet the signature
  ///      * requirements for the scheduled child transaction.
  final proto_basic_types.HederaTransactionID? scheduledTransactionId;

  const HederaSignScheduleOutput({
    this.scheduledTransactionId,
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
        scheduledTransactionId,
      ];


HederaSignScheduleOutput copyWith(
{proto_basic_types.HederaTransactionID? scheduledTransactionId,

}) {
    return HederaSignScheduleOutput(
scheduledTransactionId: scheduledTransactionId ?? this.scheduledTransactionId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'scheduled_transaction_id': config.encodeMessage(scheduledTransactionId),
    };
  }


  factory HederaSignScheduleOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSignScheduleOutput(
      scheduledTransactionId: json.valueTo<proto_basic_types.HederaTransactionID?, Object>(
        key: 'scheduled_transaction_id',
        parse: (v) => proto_basic_types.HederaTransactionID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaSignScheduleOutput.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSignScheduleOutput(
      scheduledTransactionId: decode.messageTo<proto_basic_types.HederaTransactionID?>(1, (b) => proto_basic_types.HederaTransactionID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputSignScheduleOutput;

}



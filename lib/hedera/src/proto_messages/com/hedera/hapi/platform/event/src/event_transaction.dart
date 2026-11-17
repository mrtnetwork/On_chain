import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/platform/event/src/state_signature_transaction.dart"
    as com_hedera_hapi_platform_event_state_signature_transaction;

/// *
///  * # Event Transaction
///  * An Event Transaction gossiped between nodes as part of events.
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
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.platform.event"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Defines the position of an EventTransaction relative to a logical "group"
///  * of EventTransaction that correspond to a single set of changes to the state
///  * Merkle tree.
enum HederaTransactionGroupRole implements ProtoEnumVariant {
  /// *
  ///    * The EventTransaction is the only transaction in its group.
  standalone(0, 'STANDALONE'),

  /// *
  ///    * The EventTransaction is a child and first in its group.
  firstChild(1, 'FIRST_CHILD'),

  /// *
  ///    * The EventTransaction is a child in the middle of its group.
  middleChild(2, 'MIDDLE_CHILD'),

  /// *
  ///    * The EventTransaction is a child and last in its group.
  lastChild(3, 'LAST_CHILD'),

  /// *
  ///    * The EventTransaction is a parent and first in its group.
  startingParent(4, 'STARTING_PARENT'),

  /// *
  ///    * The EventTransaction is a parent in the middle of its group.
  parent(5, 'PARENT'),

  /// *
  ///    * The EventTransaction is a parent and last in its group.
  endingParent(6, 'ENDING_PARENT');

  const HederaTransactionGroupRole(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaTransactionGroupRole fromValue(int? value) {
    value ??= 0;
    return HederaTransactionGroupRole.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaTransactionGroupRole found for the given value. $value",
                details: {
                  "name": "HederaTransactionGroupRole",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaTransactionGroupRole from(Object? value) {
    value ??= 0;
    return HederaTransactionGroupRole.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaTransactionGroupRole found for the given value. $value",
                details: {
                  "name": "HederaTransactionGroupRole",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// *
///  * An Event Transaction gossiped between nodes as part of events.
///  *
///  * Each node MUST extract this transaction and process according to the type
///  * of transaction encoded.&lt;br/&gt;
///  * Both the platform and the application built on that platform MAY define event
///  * transactions.&lt;br/&gt;
///  * The encoded data MUST be a serialized protobuf message.
class HederaEventTransaction extends HederaProtoMessage with Equality {
  /// *
  ///        * An application transaction.
  ///        * &lt;p&gt;
  ///        * The contents of this transaction SHALL be defined by the application
  ///        * subsystem that created the event.&lt;br/&gt;
  ///        * The contents MUST be a serialized protobuf message.
  final List<int>? applicationTransaction;

  /// *
  ///        * A state signature.
  ///        * &lt;p&gt;
  ///        * This transaction SHALL be a valid state signature for a state snapshot.
  final com_hedera_hapi_platform_event_state_signature_transaction.HederaStateSignatureTransaction?
  stateSignatureTransaction;

  /// *
  ///    * The role of this transaction in a group of transactions.
  final HederaTransactionGroupRole? transactionGroupRole;

  const HederaEventTransaction({
    this.applicationTransaction,
    this.stateSignatureTransaction,
    this.transactionGroupRole,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.enumType(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    applicationTransaction,
    stateSignatureTransaction,
    transactionGroupRole,
  ];

  HederaEventTransaction copyWith({
    List<int>? applicationTransaction,

    com_hedera_hapi_platform_event_state_signature_transaction.HederaStateSignatureTransaction?
    stateSignatureTransaction,

    HederaTransactionGroupRole? transactionGroupRole,
  }) {
    return HederaEventTransaction(
      applicationTransaction:
          applicationTransaction ?? this.applicationTransaction,
      stateSignatureTransaction:
          stateSignatureTransaction ?? this.stateSignatureTransaction,
      transactionGroupRole: transactionGroupRole ?? this.transactionGroupRole,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'application_transaction': config.encodeBinary(applicationTransaction),
      'state_signature_transaction': config.encodeMessage(
        stateSignatureTransaction,
      ),
      'transaction_group_role': config.encodeEnum(transactionGroupRole),
    };
  }

  factory HederaEventTransaction.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEventTransaction(
      applicationTransaction: config.decodeBinary<List<int>?>(
        json.valueAs(
          'application_transaction',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      stateSignatureTransaction: json.valueTo<
        com_hedera_hapi_platform_event_state_signature_transaction.HederaStateSignatureTransaction?,
        Object
      >(
        key: 'state_signature_transaction',
        parse:
            (v) => com_hedera_hapi_platform_event_state_signature_transaction
                .HederaStateSignatureTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionGroupRole: json.valueTo<HederaTransactionGroupRole?, Object?>(
        key: 'transaction_group_role',
        parse: (v) => HederaTransactionGroupRole.from(v),
      ),
    );
  }

  factory HederaEventTransaction.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEventTransaction(
      applicationTransaction: decode.getBytes<List<int>?>(1),
      stateSignatureTransaction: decode.messageTo<
        com_hedera_hapi_platform_event_state_signature_transaction.HederaStateSignatureTransaction?
      >(
        2,
        (b) => com_hedera_hapi_platform_event_state_signature_transaction
            .HederaStateSignatureTransaction.deserialize(b),
      ),
      transactionGroupRole: decode.getEnum<HederaTransactionGroupRole?>(
        3,
        HederaTransactionGroupRole.values,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiPlatformEventEventTransaction;
}

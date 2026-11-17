import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * The type of action described by the action proto.
enum HederaContractActionType implements ProtoEnumVariant {
    /// *
  ///    * default non-value.
  noAction(0, 'NO_ACTION'),
    /// *
  ///    * Most CALL, CALLCODE, DELEGATECALL, and STATICCALL, and first action of ContractCall/ContractCallLocal to deployed
  ///    * contracts. This does not include calls to system or precompiled contracts.
  call(1, 'CALL'),
    /// *
  ///    * CREATE, CREATE2, and first action of ContractCreate.
  create(2, 'CREATE'),
    /// *
  ///    * like Call, but to precompiled contracts (0x1 to 0x9 as of Berlin)
  precompile(3, 'PRECOMPILE'),
    /// *
  ///    * Call, but to system contract like HTS or ERC20 facades over Token accounts
  system(4, 'SYSTEM');

  const HederaContractActionType(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaContractActionType fromValue(int? value) {
    value ??=0;
    return HederaContractActionType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaContractActionType found for the given value. $value", details: {"name": "HederaContractActionType", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaContractActionType from(Object? value) {
    value ??=0;
    return HederaContractActionType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaContractActionType found for the given value. $value", details: {"name": "HederaContractActionType", "value": value?.toString()})
    );
  }

}


/// *
///  * The specific operation type of a call. The OP prefix has been added to avoid name collisions for
///  * the CALL and CREATE operation types since both ContractActionType and CallOperationType enums are
///  * used in ContractAction
enum HederaCallOperationType implements ProtoEnumVariant {
    /// *
  ///    * default operation type is UNKNOWN
  opUnknown(0, 'OP_UNKNOWN'),
    /// *
  ///    * CALL operation type.
  opCall(1, 'OP_CALL'),
    /// *
  ///    * CALLCODE operation type
  opCallcode(2, 'OP_CALLCODE'),
    /// *
  ///    * DELEGATECALL operation type
  opDelegatecall(3, 'OP_DELEGATECALL'),
    /// *
  ///    * STATICCALL operation type
  opStaticcall(4, 'OP_STATICCALL'),
    /// *
  ///    * CREATE operation type
  opCreate(5, 'OP_CREATE'),
    /// *
  ///    * CREATE2 operation type
  opCreate2(6, 'OP_CREATE2');

  const HederaCallOperationType(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaCallOperationType fromValue(int? value) {
    value ??=0;
    return HederaCallOperationType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaCallOperationType found for the given value. $value", details: {"name": "HederaCallOperationType", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaCallOperationType from(Object? value) {
    value ??=0;
    return HederaCallOperationType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaCallOperationType found for the given value. $value", details: {"name": "HederaCallOperationType", "value": value?.toString()})
    );
  }

}


/// -
///  * ‌
///  * Hedera Network Services Protobuf
///  * ​
///  * Copyright (C) 2018 - 2022 Hedera Hashgraph, LLC
///  * ​
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
///  * ‍
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.streams"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
class HederaContractActions extends HederaProtoMessage with Equality {
  final List<HederaContractAction> contractActions;

  const HederaContractActions({
    this.contractActions = const [],
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
        contractActions,
      ];


HederaContractActions copyWith(
{List<HederaContractAction>? contractActions,

}) {
    return HederaContractActions(
contractActions: contractActions ?? this.contractActions,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'contract_actions': contractActions.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaContractActions.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaContractActions(
      contractActions: (json.valueEnsureAsList<dynamic>('contract_actions', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaContractAction, Object>(
          value: e,
          parse: (v) => HederaContractAction.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaContractActions.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractActions(
      contractActions: decode.getListOfBytes(1).map((b) => HederaContractAction.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoContractActions;

}


/// *
///  * A finer grained action with a function result. Sometimes called "internal transactions." The function call itself
///  * will be the first action in a list, followed by sub-action in the order they were executed.
class HederaContractAction extends HederaProtoMessage with Equality {
    /// *
  ///    * The type of this action.
  final HederaContractActionType? callType;

    /// *
  ///    * Only the first action can come from an account, the rest will come from contracts.  Because of DELEGATECALL
  ///    * and CALLCODE the caller of actions whose parent is an account may also be an account.
  /// *
  ///      * If the caller was a regular account, the AccountID.
  final proto_basic_types.HederaAccountID? callingAccount;

    /// *
  ///      * If the caller was a smart contract account, the ContractID.
  final proto_basic_types.HederaContractID? callingContract;

    /// *
  ///    * The upper limit of gas this action can spend.
  final BigInt? gas;

    /// *
  ///    * Bytes passed in as input data to this action.
  final List<int>? input;

    /// *
  ///    * Who this action is directed to.
  /// *
  ///      * The AccountID of the recipient if the recipient is an account. Only HBars will be transferred, no other side
  ///      * effects should be expected.
  final proto_basic_types.HederaAccountID? recipientAccount;

    /// *
  ///      * The ContractID of the recipient if the recipient is a smart contract.
  final proto_basic_types.HederaContractID? recipientContract;

    /// *
  ///      * The bytes of the targeted by the action address.
  ///      * Only set on failed executions. If set, denotes that the address did not
  ///      * correspond to any account or contract at the time of finalization of
  ///      * this action.
  ///      * An example would be a failed lazy create as per HIP-583.
  final List<int>? targetedAddress;

    /// *
  ///    * The value (in tinybars) that is associated with this action.
  final BigInt? value;

    /// *
  ///    * The actual gas spent by this action.
  final BigInt? gasUsed;

    /// *
  ///    * The result data of the action.
  /// *
  ///      * If successful, the output bytes of the action.
  final List<int>? output;

    /// *
  ///      * The contract itself caused the transaction to fail via the `REVERT` operation
  final List<int>? revertReason;

    /// *
  ///      * The transaction itself failed without an explicit `REVERT`
  final List<int>? error;

    /// *
  ///    * The nesting depth of this call. The original action is at depth=0.
  final int? callDepth;

    /// *
  ///    * The call operation type
  final HederaCallOperationType? callOperationType;

  const HederaContractAction({
    this.callType,
    this.callingAccount,
    this.callingContract,
    this.gas,
    this.input,
    this.recipientAccount,
    this.recipientContract,
    this.targetedAddress,
    this.value,
    this.gasUsed,
    this.output,
    this.revertReason,
    this.error,
    this.callDepth,
    this.callOperationType,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.bytes(8),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.bytes(11),
        ProtoFieldConfig.bytes(12),
        ProtoFieldConfig.bytes(13),
        ProtoFieldConfig.int32(14),
        ProtoFieldConfig.enumType(15),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        callType,
        callingAccount,
        callingContract,
        gas,
        input,
        recipientAccount,
        recipientContract,
        targetedAddress,
        value,
        gasUsed,
        output,
        revertReason,
        error,
        callDepth,
        callOperationType,
      ];


HederaContractAction copyWith(
{HederaContractActionType? callType,

proto_basic_types.HederaAccountID? callingAccount,

proto_basic_types.HederaContractID? callingContract,

BigInt? gas,

List<int>? input,

proto_basic_types.HederaAccountID? recipientAccount,

proto_basic_types.HederaContractID? recipientContract,

List<int>? targetedAddress,

BigInt? value,

BigInt? gasUsed,

List<int>? output,

List<int>? revertReason,

List<int>? error,

int? callDepth,

HederaCallOperationType? callOperationType,

}) {
    return HederaContractAction(
callType: callType ?? this.callType,
callingAccount: callingAccount ?? this.callingAccount,
callingContract: callingContract ?? this.callingContract,
gas: gas ?? this.gas,
input: input ?? this.input,
recipientAccount: recipientAccount ?? this.recipientAccount,
recipientContract: recipientContract ?? this.recipientContract,
targetedAddress: targetedAddress ?? this.targetedAddress,
value: value ?? this.value,
gasUsed: gasUsed ?? this.gasUsed,
output: output ?? this.output,
revertReason: revertReason ?? this.revertReason,
error: error ?? this.error,
callDepth: callDepth ?? this.callDepth,
callOperationType: callOperationType ?? this.callOperationType,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'call_type': config.encodeEnum(callType),
      'calling_account': config.encodeMessage(callingAccount),
      'calling_contract': config.encodeMessage(callingContract),
      'gas': config.encodeBigint(gas),
      'input': config.encodeBinary(input),
      'recipient_account': config.encodeMessage(recipientAccount),
      'recipient_contract': config.encodeMessage(recipientContract),
      'targeted_address': config.encodeBinary(targetedAddress),
      'value': config.encodeBigint(value),
      'gas_used': config.encodeBigint(gasUsed),
      'output': config.encodeBinary(output),
      'revert_reason': config.encodeBinary(revertReason),
      'error': config.encodeBinary(error),
      'call_depth': callDepth,
      'call_operation_type': config.encodeEnum(callOperationType),
    };
  }


  factory HederaContractAction.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaContractAction(
      callType: json.valueTo<HederaContractActionType?, Object?>(
        key: 'call_type',
        parse: (v) => HederaContractActionType.from(v),
      ),
      callingAccount: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'calling_account',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      callingContract: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'calling_contract',
        parse: (v) => proto_basic_types.HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      gas: json.valueAsBigInt<BigInt?>('gas', normalizeKeyLookup: config.normalizeKeys),
      input: config.decodeBinary<List<int>?>(json.valueAs('input', normalizeKeyLookup: config.normalizeKeys)),
      recipientAccount: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'recipient_account',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      recipientContract: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'recipient_contract',
        parse: (v) => proto_basic_types.HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      targetedAddress: config.decodeBinary<List<int>?>(json.valueAs('targeted_address', normalizeKeyLookup: config.normalizeKeys)),
      value: json.valueAsBigInt<BigInt?>('value', normalizeKeyLookup: config.normalizeKeys),
      gasUsed: json.valueAsBigInt<BigInt?>('gas_used', normalizeKeyLookup: config.normalizeKeys),
      output: config.decodeBinary<List<int>?>(json.valueAs('output', normalizeKeyLookup: config.normalizeKeys)),
      revertReason: config.decodeBinary<List<int>?>(json.valueAs('revert_reason', normalizeKeyLookup: config.normalizeKeys)),
      error: config.decodeBinary<List<int>?>(json.valueAs('error', normalizeKeyLookup: config.normalizeKeys)),
      callDepth: json.valueAsInt<int?>('call_depth', normalizeKeyLookup: config.normalizeKeys),
      callOperationType: json.valueTo<HederaCallOperationType?, Object?>(
        key: 'call_operation_type',
        parse: (v) => HederaCallOperationType.from(v),
      ),
    );
  }

  factory HederaContractAction.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractAction(
      callType: decode.getEnum<HederaContractActionType?>(1, HederaContractActionType.values),
      callingAccount: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      callingContract: decode.messageTo<proto_basic_types.HederaContractID?>(3, (b) => proto_basic_types.HederaContractID.deserialize(b)),
      gas: decode.getBigInt<BigInt?>(4),
      input: decode.getBytes<List<int>?>(5),
      recipientAccount: decode.messageTo<proto_basic_types.HederaAccountID?>(6, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      recipientContract: decode.messageTo<proto_basic_types.HederaContractID?>(7, (b) => proto_basic_types.HederaContractID.deserialize(b)),
      targetedAddress: decode.getBytes<List<int>?>(8),
      value: decode.getBigInt<BigInt?>(9),
      gasUsed: decode.getBigInt<BigInt?>(10),
      output: decode.getBytes<List<int>?>(11),
      revertReason: decode.getBytes<List<int>?>(12),
      error: decode.getBytes<List<int>?>(13),
      callDepth: decode.getInt<int?>(14),
      callOperationType: decode.getEnum<HederaCallOperationType?>(15, HederaCallOperationType.values),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoContractAction;

}



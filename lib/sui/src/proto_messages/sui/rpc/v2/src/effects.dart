import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart" as sui_rpc_v2_bcs;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/execution_status.dart" as sui_rpc_v2_execution_status;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/gas_cost_summary.dart" as sui_rpc_v2_gas_cost_summary;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/object_reference.dart" as sui_rpc_v2_object_reference;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/owner.dart" as sui_rpc_v2_owner;

enum SuiChangedObjectInputObjectState implements ProtoEnumVariant {
  inputObjectStateUnknown(0, 'INPUT_OBJECT_STATE_UNKNOWN'),
  inputObjectStateDoesNotExist(1, 'INPUT_OBJECT_STATE_DOES_NOT_EXIST'),
  inputObjectStateExists(2, 'INPUT_OBJECT_STATE_EXISTS');

  const SuiChangedObjectInputObjectState(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiChangedObjectInputObjectState fromValue(int? value) {
    value ??=0;
    return SuiChangedObjectInputObjectState.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiChangedObjectInputObjectState found for the given value. $value", details: {"name": "SuiChangedObjectInputObjectState", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiChangedObjectInputObjectState from(Object? value) {
    value ??=0;
    return SuiChangedObjectInputObjectState.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiChangedObjectInputObjectState found for the given value. $value", details: {"name": "SuiChangedObjectInputObjectState", "value": value?.toString()})
    );
  }

}


enum SuiChangedObjectOutputObjectState implements ProtoEnumVariant {
  outputObjectStateUnknown(0, 'OUTPUT_OBJECT_STATE_UNKNOWN'),
  outputObjectStateDoesNotExist(1, 'OUTPUT_OBJECT_STATE_DOES_NOT_EXIST'),
  outputObjectStateObjectWrite(2, 'OUTPUT_OBJECT_STATE_OBJECT_WRITE'),
  outputObjectStatePackageWrite(3, 'OUTPUT_OBJECT_STATE_PACKAGE_WRITE'),
  outputObjectStateAccumulatorWrite(4, 'OUTPUT_OBJECT_STATE_ACCUMULATOR_WRITE');

  const SuiChangedObjectOutputObjectState(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiChangedObjectOutputObjectState fromValue(int? value) {
    value ??=0;
    return SuiChangedObjectOutputObjectState.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiChangedObjectOutputObjectState found for the given value. $value", details: {"name": "SuiChangedObjectOutputObjectState", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiChangedObjectOutputObjectState from(Object? value) {
    value ??=0;
    return SuiChangedObjectOutputObjectState.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiChangedObjectOutputObjectState found for the given value. $value", details: {"name": "SuiChangedObjectOutputObjectState", "value": value?.toString()})
    );
  }

}


enum SuiChangedObjectIdOperation implements ProtoEnumVariant {
  idOperationUnknown(0, 'ID_OPERATION_UNKNOWN'),
  none(1, 'NONE'),
  created(2, 'CREATED'),
  deleted(3, 'DELETED');

  const SuiChangedObjectIdOperation(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiChangedObjectIdOperation fromValue(int? value) {
    value ??=0;
    return SuiChangedObjectIdOperation.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiChangedObjectIdOperation found for the given value. $value", details: {"name": "SuiChangedObjectIdOperation", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiChangedObjectIdOperation from(Object? value) {
    value ??=0;
    return SuiChangedObjectIdOperation.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiChangedObjectIdOperation found for the given value. $value", details: {"name": "SuiChangedObjectIdOperation", "value": value?.toString()})
    );
  }

}


enum SuiAccumulatorWriteAccumulatorOperation implements ProtoEnumVariant {
  accumulatorOperationUnknown(0, 'ACCUMULATOR_OPERATION_UNKNOWN'),
  merge(1, 'MERGE'),
  split(2, 'SPLIT');

  const SuiAccumulatorWriteAccumulatorOperation(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiAccumulatorWriteAccumulatorOperation fromValue(int? value) {
    value ??=0;
    return SuiAccumulatorWriteAccumulatorOperation.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiAccumulatorWriteAccumulatorOperation found for the given value. $value", details: {"name": "SuiAccumulatorWriteAccumulatorOperation", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiAccumulatorWriteAccumulatorOperation from(Object? value) {
    value ??=0;
    return SuiAccumulatorWriteAccumulatorOperation.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiAccumulatorWriteAccumulatorOperation found for the given value. $value", details: {"name": "SuiAccumulatorWriteAccumulatorOperation", "value": value?.toString()})
    );
  }

}


enum SuiAccumulatorWriteAccumulatorValue implements ProtoEnumVariant {
  accumulatorValueUnknown(0, 'ACCUMULATOR_VALUE_UNKNOWN'),
  integer(1, 'INTEGER'),
  integerTuple(2, 'INTEGER_TUPLE'),
  eventDigest(3, 'EVENT_DIGEST');

  const SuiAccumulatorWriteAccumulatorValue(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiAccumulatorWriteAccumulatorValue fromValue(int? value) {
    value ??=0;
    return SuiAccumulatorWriteAccumulatorValue.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiAccumulatorWriteAccumulatorValue found for the given value. $value", details: {"name": "SuiAccumulatorWriteAccumulatorValue", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiAccumulatorWriteAccumulatorValue from(Object? value) {
    value ??=0;
    return SuiAccumulatorWriteAccumulatorValue.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiAccumulatorWriteAccumulatorValue found for the given value. $value", details: {"name": "SuiAccumulatorWriteAccumulatorValue", "value": value?.toString()})
    );
  }

}


enum SuiUnchangedConsensusObjectUnchangedConsensusObjectKind implements ProtoEnumVariant {
  unchangedConsensusObjectKindUnknown(0, 'UNCHANGED_CONSENSUS_OBJECT_KIND_UNKNOWN'),
    /// Read-only consensus object from the input.
  readOnlyRoot(1, 'READ_ONLY_ROOT'),
    /// Objects with ended consensus streams that appear mutably/owned in the input.
  mutateConsensusStreamEnded(2, 'MUTATE_CONSENSUS_STREAM_ENDED'),
    /// Objects with ended consensus streams objects that appear as read-only in the input.
  readConsensusStreamEnded(3, 'READ_CONSENSUS_STREAM_ENDED'),
    /// Consensus objects that were congested and resulted in this transaction being
  /// canceled.
  canceled(4, 'CANCELED'),
    /// Read of a per-epoch config object that should remain the same during an
  /// epoch. This optionally will indicate the sequence number of the config
  /// object at the start of the epoch.
  perEpochConfig(5, 'PER_EPOCH_CONFIG');

  const SuiUnchangedConsensusObjectUnchangedConsensusObjectKind(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiUnchangedConsensusObjectUnchangedConsensusObjectKind fromValue(int? value) {
    value ??=0;
    return SuiUnchangedConsensusObjectUnchangedConsensusObjectKind.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiUnchangedConsensusObjectUnchangedConsensusObjectKind found for the given value. $value", details: {"name": "SuiUnchangedConsensusObjectUnchangedConsensusObjectKind", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiUnchangedConsensusObjectUnchangedConsensusObjectKind from(Object? value) {
    value ??=0;
    return SuiUnchangedConsensusObjectUnchangedConsensusObjectKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiUnchangedConsensusObjectUnchangedConsensusObjectKind found for the given value. $value", details: {"name": "SuiUnchangedConsensusObjectUnchangedConsensusObjectKind", "value": value?.toString()})
    );
  }

}


/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// The effects of executing a transaction.
class SuiTransactionEffects extends SuiProtoMessage {
    /// This TransactionEffects serialized as BCS.
  final sui_rpc_v2_bcs.SuiBcs? bcs;

    /// The digest of this TransactionEffects.
  final String? digest;

    /// Version of this TransactionEffects.
  final int? version;

    /// The status of the execution.
  final sui_rpc_v2_execution_status.SuiExecutionStatus? status;

    /// The epoch when this transaction was executed.
  final BigInt? epoch;

    /// The gas used by this transaction.
  final sui_rpc_v2_gas_cost_summary.SuiGasCostSummary? gasUsed;

    /// The transaction digest.
  final String? transactionDigest;

    /// Information about the gas object. Also present in the `changed_objects` vector.
  ///
  /// System transactions that don't require gas will leave this as `None`.
  final SuiChangedObject? gasObject;

    /// The digest of the events emitted during execution,
  /// can be `None` if the transaction does not emit any event.
  final String? eventsDigest;

    /// The set of transaction digests this transaction depends on.
  final List<String> dependencies;

    /// The version number of all the written objects (excluding packages) by this transaction.
  final BigInt? lamportVersion;

    /// Objects whose state are changed by this transaction.
  final List<SuiChangedObject> changedObjects;

    /// Consensus objects that are not mutated in this transaction. Unlike owned objects,
  /// read-only consensus objects' version are not committed in the transaction,
  /// and in order for a node to catch up and execute it without consensus sequencing,
  /// the version needs to be committed in the effects.
  final List<SuiUnchangedConsensusObject> unchangedConsensusObjects;

    /// Auxiliary data that are not protocol-critical, generated as part of the effects but are stored separately.
  /// Storing it separately allows us to avoid bloating the effects with data that are not critical.
  /// It also provides more flexibility on the format and type of the data.
  final String? auxiliaryDataDigest;

  final List<sui_rpc_v2_object_reference.SuiObjectReference> unchangedLoadedRuntimeObjects;

  const SuiTransactionEffects({
    this.bcs,
    this.digest,
    this.version,
    this.status,
    this.epoch,
    this.gasUsed,
    this.transactionDigest,
    this.gasObject,
    this.eventsDigest,
    this.dependencies = const [],
    this.lamportVersion,
    this.changedObjects = const [],
    this.unchangedConsensusObjects = const [],
    this.auxiliaryDataDigest,
    this.unchangedLoadedRuntimeObjects = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.int32(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(5, hasOptionalFlags: true),
        ProtoFieldConfig.message(6, hasOptionalFlags: true),
        ProtoFieldConfig.string(7, hasOptionalFlags: true),
        ProtoFieldConfig.message(8, hasOptionalFlags: true),
        ProtoFieldConfig.string(9, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 10,
          elementType: ProtoFieldType.string,
        ),
        ProtoFieldConfig.uint64(11, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 12,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 13,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.string(14, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 15,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        bcs,
        digest,
        version,
        status,
        epoch,
        gasUsed,
        transactionDigest,
        gasObject,
        eventsDigest,
        dependencies,
        lamportVersion,
        changedObjects,
        unchangedConsensusObjects,
        auxiliaryDataDigest,
        unchangedLoadedRuntimeObjects,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'bcs': config.encodeMessage(bcs),
      'digest': digest,
      'version': version,
      'status': config.encodeMessage(status),
      'epoch': config.encodeBigint(epoch),
      'gas_used': config.encodeMessage(gasUsed),
      'transaction_digest': transactionDigest,
      'gas_object': config.encodeMessage(gasObject),
      'events_digest': eventsDigest,
      'dependencies': dependencies.map((e) => e).toList(),
      'lamport_version': config.encodeBigint(lamportVersion),
      'changed_objects': changedObjects.map((e) => config.encodeMessage(e)).toList(),
      'unchanged_consensus_objects': unchangedConsensusObjects.map((e) => config.encodeMessage(e)).toList(),
      'auxiliary_data_digest': auxiliaryDataDigest,
      'unchanged_loaded_runtime_objects': unchangedLoadedRuntimeObjects.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiTransactionEffects.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiTransactionEffects(
      bcs: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'bcs',
        parse: (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      digest: json.valueAsString<String?>('digest', normalizeKeyLookup: config.normalizeKeys),
      version: json.valueAsInt<int?>('version', normalizeKeyLookup: config.normalizeKeys),
      status: json.valueTo<sui_rpc_v2_execution_status.SuiExecutionStatus?, Object>(
        key: 'status',
        parse: (v) => sui_rpc_v2_execution_status.SuiExecutionStatus.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      epoch: json.valueAsBigInt<BigInt?>('epoch', normalizeKeyLookup: config.normalizeKeys),
      gasUsed: json.valueTo<sui_rpc_v2_gas_cost_summary.SuiGasCostSummary?, Object>(
        key: 'gas_used',
        parse: (v) => sui_rpc_v2_gas_cost_summary.SuiGasCostSummary.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      transactionDigest: json.valueAsString<String?>('transaction_digest', normalizeKeyLookup: config.normalizeKeys),
      gasObject: json.valueTo<SuiChangedObject?, Object>(
        key: 'gas_object',
        parse: (v) => SuiChangedObject.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      eventsDigest: json.valueAsString<String?>('events_digest', normalizeKeyLookup: config.normalizeKeys),
      dependencies: (json.valueEnsureAsList<dynamic>('dependencies', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueAsString<String>(e)).toList(),
      lamportVersion: json.valueAsBigInt<BigInt?>('lamport_version', normalizeKeyLookup: config.normalizeKeys),
      changedObjects: (json.valueEnsureAsList<dynamic>('changed_objects', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiChangedObject, Object>(
          value: e,
          parse: (v) => SuiChangedObject.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      unchangedConsensusObjects: (json.valueEnsureAsList<dynamic>('unchanged_consensus_objects', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiUnchangedConsensusObject, Object>(
          value: e,
          parse: (v) => SuiUnchangedConsensusObject.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      auxiliaryDataDigest: json.valueAsString<String?>('auxiliary_data_digest', normalizeKeyLookup: config.normalizeKeys),
      unchangedLoadedRuntimeObjects: (json.valueEnsureAsList<dynamic>('unchanged_loaded_runtime_objects', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<sui_rpc_v2_object_reference.SuiObjectReference, Object>(
          value: e,
          parse: (v) => sui_rpc_v2_object_reference.SuiObjectReference.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiTransactionEffects.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTransactionEffects(
      bcs: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(1, (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b)),
      digest: decode.getString<String?>(2),
      version: decode.getInt<int?>(3),
      status: decode.messageTo<sui_rpc_v2_execution_status.SuiExecutionStatus?>(4, (b) => sui_rpc_v2_execution_status.SuiExecutionStatus.deserialize(b)),
      epoch: decode.getBigInt<BigInt?>(5),
      gasUsed: decode.messageTo<sui_rpc_v2_gas_cost_summary.SuiGasCostSummary?>(6, (b) => sui_rpc_v2_gas_cost_summary.SuiGasCostSummary.deserialize(b)),
      transactionDigest: decode.getString<String?>(7),
      gasObject: decode.messageTo<SuiChangedObject?>(8, (b) => SuiChangedObject.deserialize(b)),
      eventsDigest: decode.getString<String?>(9),
      dependencies: decode.getListOrEmpty<String>(10),
      lamportVersion: decode.getBigInt<BigInt?>(11),
      changedObjects: decode.getListOfBytes(12).map((b) => SuiChangedObject.deserialize(b)).toList(),
      unchangedConsensusObjects: decode.getListOfBytes(13).map((b) => SuiUnchangedConsensusObject.deserialize(b)).toList(),
      auxiliaryDataDigest: decode.getString<String?>(14),
      unchangedLoadedRuntimeObjects: decode.getListOfBytes(15).map((b) => sui_rpc_v2_object_reference.SuiObjectReference.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2TransactionEffects;

}


/// Input/output state of an object that was changed during execution.
class SuiChangedObject extends SuiProtoMessage {
    /// ID of the object.
  final String? objectId;

  final SuiChangedObjectInputObjectState? inputState;

    /// Version of the object before this transaction executed.
  final BigInt? inputVersion;

    /// Digest of the object before this transaction executed.
  final String? inputDigest;

    /// Owner of the object before this transaction executed.
  final sui_rpc_v2_owner.SuiOwner? inputOwner;

  final SuiChangedObjectOutputObjectState? outputState;

    /// Version of the object after this transaction executed.
  final BigInt? outputVersion;

    /// Digest of the object after this transaction executed.
  final String? outputDigest;

    /// Owner of the object after this transaction executed.
  final sui_rpc_v2_owner.SuiOwner? outputOwner;

    /// The contents of the accumulator write when `output_state` is `OUTPUT_OBJECT_STATE_ACCUMULATOR_WRITE`
  final SuiAccumulatorWrite? accumulatorWrite;

    /// What happened to an `ObjectId` during execution.
  final SuiChangedObjectIdOperation? idOperation;

    /// Type information is not provided by the effects structure but is instead
  /// provided by an indexing layer
  final String? objectType;

  const SuiChangedObject({
    this.objectId,
    this.inputState,
    this.inputVersion,
    this.inputDigest,
    this.inputOwner,
    this.outputState,
    this.outputVersion,
    this.outputDigest,
    this.outputOwner,
    this.accumulatorWrite,
    this.idOperation,
    this.objectType,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(6, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(7, hasOptionalFlags: true),
        ProtoFieldConfig.string(8, hasOptionalFlags: true),
        ProtoFieldConfig.message(9, hasOptionalFlags: true),
        ProtoFieldConfig.message(12, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(10, hasOptionalFlags: true),
        ProtoFieldConfig.string(11, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        objectId,
        inputState,
        inputVersion,
        inputDigest,
        inputOwner,
        outputState,
        outputVersion,
        outputDigest,
        outputOwner,
        accumulatorWrite,
        idOperation,
        objectType,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'object_id': objectId,
      'input_state': config.encodeEnum(inputState),
      'input_version': config.encodeBigint(inputVersion),
      'input_digest': inputDigest,
      'input_owner': config.encodeMessage(inputOwner),
      'output_state': config.encodeEnum(outputState),
      'output_version': config.encodeBigint(outputVersion),
      'output_digest': outputDigest,
      'output_owner': config.encodeMessage(outputOwner),
      'accumulator_write': config.encodeMessage(accumulatorWrite),
      'id_operation': config.encodeEnum(idOperation),
      'object_type': objectType,
    };
  }


  factory SuiChangedObject.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiChangedObject(
      objectId: json.valueAsString<String?>('object_id', normalizeKeyLookup: config.normalizeKeys),
      inputState: json.valueTo<SuiChangedObjectInputObjectState?, Object?>(
        key: 'input_state',
        parse: (v) => SuiChangedObjectInputObjectState.from(v),
      ),
      inputVersion: json.valueAsBigInt<BigInt?>('input_version', normalizeKeyLookup: config.normalizeKeys),
      inputDigest: json.valueAsString<String?>('input_digest', normalizeKeyLookup: config.normalizeKeys),
      inputOwner: json.valueTo<sui_rpc_v2_owner.SuiOwner?, Object>(
        key: 'input_owner',
        parse: (v) => sui_rpc_v2_owner.SuiOwner.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      outputState: json.valueTo<SuiChangedObjectOutputObjectState?, Object?>(
        key: 'output_state',
        parse: (v) => SuiChangedObjectOutputObjectState.from(v),
      ),
      outputVersion: json.valueAsBigInt<BigInt?>('output_version', normalizeKeyLookup: config.normalizeKeys),
      outputDigest: json.valueAsString<String?>('output_digest', normalizeKeyLookup: config.normalizeKeys),
      outputOwner: json.valueTo<sui_rpc_v2_owner.SuiOwner?, Object>(
        key: 'output_owner',
        parse: (v) => sui_rpc_v2_owner.SuiOwner.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      accumulatorWrite: json.valueTo<SuiAccumulatorWrite?, Object>(
        key: 'accumulator_write',
        parse: (v) => SuiAccumulatorWrite.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      idOperation: json.valueTo<SuiChangedObjectIdOperation?, Object?>(
        key: 'id_operation',
        parse: (v) => SuiChangedObjectIdOperation.from(v),
      ),
      objectType: json.valueAsString<String?>('object_type', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiChangedObject.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiChangedObject(
      objectId: decode.getString<String?>(1),
      inputState: decode.getEnum<SuiChangedObjectInputObjectState?>(2, SuiChangedObjectInputObjectState.values),
      inputVersion: decode.getBigInt<BigInt?>(3),
      inputDigest: decode.getString<String?>(4),
      inputOwner: decode.messageTo<sui_rpc_v2_owner.SuiOwner?>(5, (b) => sui_rpc_v2_owner.SuiOwner.deserialize(b)),
      outputState: decode.getEnum<SuiChangedObjectOutputObjectState?>(6, SuiChangedObjectOutputObjectState.values),
      outputVersion: decode.getBigInt<BigInt?>(7),
      outputDigest: decode.getString<String?>(8),
      outputOwner: decode.messageTo<sui_rpc_v2_owner.SuiOwner?>(9, (b) => sui_rpc_v2_owner.SuiOwner.deserialize(b)),
      accumulatorWrite: decode.messageTo<SuiAccumulatorWrite?>(12, (b) => SuiAccumulatorWrite.deserialize(b)),
      idOperation: decode.getEnum<SuiChangedObjectIdOperation?>(10, SuiChangedObjectIdOperation.values),
      objectType: decode.getString<String?>(11),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ChangedObject;

}


/// An entry in an event digest accumulator value.
class SuiEventDigestEntry extends SuiProtoMessage {
    /// Index of the event within its transaction.
  final BigInt? eventIndex;

    /// Digest of the event.
  final String? digest;

  const SuiEventDigestEntry({
    this.eventIndex,
    this.digest,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        eventIndex,
        digest,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'event_index': config.encodeBigint(eventIndex),
      'digest': digest,
    };
  }


  factory SuiEventDigestEntry.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiEventDigestEntry(
      eventIndex: json.valueAsBigInt<BigInt?>('event_index', normalizeKeyLookup: config.normalizeKeys),
      digest: json.valueAsString<String?>('digest', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiEventDigestEntry.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEventDigestEntry(
      eventIndex: decode.getBigInt<BigInt?>(1),
      digest: decode.getString<String?>(2),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2EventDigestEntry;

}


class SuiAccumulatorWrite extends SuiProtoMessage {
  final String? address;

  final String? accumulatorType;

  final SuiAccumulatorWriteAccumulatorOperation? operation;

  final SuiAccumulatorWriteAccumulatorValue? valueKind;

    /// Set when the accumulator value is an integer (value_kind = INTEGER).
  final BigInt? integerValue;

    /// Set, with len 2, when the accumulator value is an integer tuple
  /// (value_kind = INTEGER_TUPLE).
  final List<BigInt> integerTuple;

    /// Set when the accumulator value is an event digest list (value_kind = EVENT_DIGEST).
  /// Contains a non-empty list of (event_index, digest) pairs representing
  /// authenticated event stream entries within a transaction.
  final List<SuiEventDigestEntry> eventDigestValue;

  const SuiAccumulatorWrite({
    this.address,
    this.accumulatorType,
    this.operation,
    this.valueKind,
    this.integerValue,
    this.integerTuple = const [],
    this.eventDigestValue = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(3, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(4, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(5, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.uint64,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 7,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        address,
        accumulatorType,
        operation,
        valueKind,
        integerValue,
        integerTuple,
        eventDigestValue,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'address': address,
      'accumulator_type': accumulatorType,
      'operation': config.encodeEnum(operation),
      'value_kind': config.encodeEnum(valueKind),
      'integer_value': config.encodeBigint(integerValue),
      'integer_tuple': integerTuple.map((e) => config.encodeBigint(e)).toList(),
      'event_digest_value': eventDigestValue.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiAccumulatorWrite.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiAccumulatorWrite(
      address: json.valueAsString<String?>('address', normalizeKeyLookup: config.normalizeKeys),
      accumulatorType: json.valueAsString<String?>('accumulator_type', normalizeKeyLookup: config.normalizeKeys),
      operation: json.valueTo<SuiAccumulatorWriteAccumulatorOperation?, Object?>(
        key: 'operation',
        parse: (v) => SuiAccumulatorWriteAccumulatorOperation.from(v),
      ),
      valueKind: json.valueTo<SuiAccumulatorWriteAccumulatorValue?, Object?>(
        key: 'value_kind',
        parse: (v) => SuiAccumulatorWriteAccumulatorValue.from(v),
      ),
      integerValue: json.valueAsBigInt<BigInt?>('integer_value', normalizeKeyLookup: config.normalizeKeys),
      integerTuple: (json.valueEnsureAsList<dynamic>('integer_tuple', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
      eventDigestValue: (json.valueEnsureAsList<dynamic>('event_digest_value', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiEventDigestEntry, Object>(
          value: e,
          parse: (v) => SuiEventDigestEntry.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiAccumulatorWrite.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiAccumulatorWrite(
      address: decode.getString<String?>(1),
      accumulatorType: decode.getString<String?>(2),
      operation: decode.getEnum<SuiAccumulatorWriteAccumulatorOperation?>(3, SuiAccumulatorWriteAccumulatorOperation.values),
      valueKind: decode.getEnum<SuiAccumulatorWriteAccumulatorValue?>(4, SuiAccumulatorWriteAccumulatorValue.values),
      integerValue: decode.getBigInt<BigInt?>(5),
      integerTuple: decode.getListOrEmpty<BigInt>(6),
      eventDigestValue: decode.getListOfBytes(7).map((b) => SuiEventDigestEntry.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2AccumulatorWrite;

}


/// A consensus object that wasn't changed during execution.
class SuiUnchangedConsensusObject extends SuiProtoMessage {
  final SuiUnchangedConsensusObjectUnchangedConsensusObjectKind? kind;

    /// ObjectId of the consensus object.
  final String? objectId;

    /// Version of the consensus object.
  final BigInt? version;

    /// Digest of the consensus object.
  final String? digest;

    /// Type information is not provided by the effects structure but is instead
  /// provided by an indexing layer
  final String? objectType;

  const SuiUnchangedConsensusObject({
    this.kind,
    this.objectId,
    this.version,
    this.digest,
    this.objectType,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        kind,
        objectId,
        version,
        digest,
        objectType,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'kind': config.encodeEnum(kind),
      'object_id': objectId,
      'version': config.encodeBigint(version),
      'digest': digest,
      'object_type': objectType,
    };
  }


  factory SuiUnchangedConsensusObject.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiUnchangedConsensusObject(
      kind: json.valueTo<SuiUnchangedConsensusObjectUnchangedConsensusObjectKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiUnchangedConsensusObjectUnchangedConsensusObjectKind.from(v),
      ),
      objectId: json.valueAsString<String?>('object_id', normalizeKeyLookup: config.normalizeKeys),
      version: json.valueAsBigInt<BigInt?>('version', normalizeKeyLookup: config.normalizeKeys),
      digest: json.valueAsString<String?>('digest', normalizeKeyLookup: config.normalizeKeys),
      objectType: json.valueAsString<String?>('object_type', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiUnchangedConsensusObject.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiUnchangedConsensusObject(
      kind: decode.getEnum<SuiUnchangedConsensusObjectUnchangedConsensusObjectKind?>(1, SuiUnchangedConsensusObjectUnchangedConsensusObjectKind.values),
      objectId: decode.getString<String?>(2),
      version: decode.getBigInt<BigInt?>(3),
      digest: decode.getString<String?>(4),
      objectType: decode.getString<String?>(5),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2UnchangedConsensusObject;

}



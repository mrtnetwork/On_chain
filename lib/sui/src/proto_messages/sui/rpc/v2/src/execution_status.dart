import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

enum SuiExecutionErrorExecutionErrorKind implements ProtoEnumVariant {
  executionErrorKindUnknown(0, 'EXECUTION_ERROR_KIND_UNKNOWN'),
    /// Insufficient gas.
  insufficientGas(1, 'INSUFFICIENT_GAS'),
    /// Invalid `Gas` object.
  invalidGasObject(2, 'INVALID_GAS_OBJECT'),
    /// Invariant violation.
  invariantViolation(3, 'INVARIANT_VIOLATION'),
    /// Attempted to use feature that is not supported yet.
  featureNotYetSupported(4, 'FEATURE_NOT_YET_SUPPORTED'),
    /// Move object is larger than the maximum allowed size.
  objectTooBig(5, 'OBJECT_TOO_BIG'),
    /// Package is larger than the maximum allowed size.
  packageTooBig(6, 'PACKAGE_TOO_BIG'),
    /// Circular object ownership.
  circularObjectOwnership(7, 'CIRCULAR_OBJECT_OWNERSHIP'),
    ///
  /// Coin errors.
  ///
  /// Insufficient coin balance for requested operation.
  insufficientCoinBalance(8, 'INSUFFICIENT_COIN_BALANCE'),
    /// Coin balance overflowed an u64.
  coinBalanceOverflow(9, 'COIN_BALANCE_OVERFLOW'),
    ///
  /// Publish/Upgrade errors.
  ///
  /// Publish error, non-zero address.
  /// The modules in the package must have their self-addresses set to zero.
  publishErrorNonZeroAddress(10, 'PUBLISH_ERROR_NON_ZERO_ADDRESS'),
    /// Sui Move bytecode verification error.
  suiMoveVerificationError(11, 'SUI_MOVE_VERIFICATION_ERROR'),
    ///
  /// MoveVm errors.
  ///
  /// Error from a non-abort instruction.
  /// Possible causes:
  /// Arithmetic error, stack overflow, max value depth, or similar.
  movePrimitiveRuntimeError(12, 'MOVE_PRIMITIVE_RUNTIME_ERROR'),
    /// Move runtime abort.
  moveAbort(13, 'MOVE_ABORT'),
    /// Bytecode verification error.
  vmVerificationOrDeserializationError(14, 'VM_VERIFICATION_OR_DESERIALIZATION_ERROR'),
    /// MoveVm invariant violation.
  vmInvariantViolation(15, 'VM_INVARIANT_VIOLATION'),
    ///
  /// Programmable transaction errors.
  ///
  /// Function not found.
  functionNotFound(16, 'FUNCTION_NOT_FOUND'),
    /// Parity mismatch for Move function.
  /// The number of arguments does not match the number of parameters.
  arityMismatch(17, 'ARITY_MISMATCH'),
    /// Type parity mismatch for Move function.
  /// Mismatch between the number of actual versus expected type arguments.
  typeArityMismatch(18, 'TYPE_ARITY_MISMATCH'),
    /// Non-entry function invoked. Move Call must start with an entry function.
  nonEntryFunctionInvoked(19, 'NON_ENTRY_FUNCTION_INVOKED'),
    /// Invalid command argument.
  commandArgumentError(20, 'COMMAND_ARGUMENT_ERROR'),
    /// Type argument error.
  typeArgumentError(21, 'TYPE_ARGUMENT_ERROR'),
    /// Unused result without the drop ability.
  unusedValueWithoutDrop(22, 'UNUSED_VALUE_WITHOUT_DROP'),
    /// Invalid public Move function signature.
  /// Unsupported return type for return value.
  invalidPublicFunctionReturnType(23, 'INVALID_PUBLIC_FUNCTION_RETURN_TYPE'),
    /// Invalid transfer object, object does not have public transfer.
  invalidTransferObject(24, 'INVALID_TRANSFER_OBJECT'),
    ///
  /// Post-execution errors.
  ///
  /// Effects from the transaction are too large.
  effectsTooLarge(25, 'EFFECTS_TOO_LARGE'),
    /// Publish or Upgrade is missing dependency.
  publishUpgradeMissingDependency(26, 'PUBLISH_UPGRADE_MISSING_DEPENDENCY'),
    /// Publish or upgrade dependency downgrade.
  ///
  /// Indirect (transitive) dependency of published or upgraded package has been assigned an
  /// on-chain version that is less than the version required by one of the package's
  /// transitive dependencies.
  publishUpgradeDependencyDowngrade(27, 'PUBLISH_UPGRADE_DEPENDENCY_DOWNGRADE'),
    /// Invalid package upgrade.
  packageUpgradeError(28, 'PACKAGE_UPGRADE_ERROR'),
    /// Indicates the transaction tried to write objects too large to storage.
  writtenObjectsTooLarge(29, 'WRITTEN_OBJECTS_TOO_LARGE'),
    /// Certificate is on the deny list.
  certificateDenied(30, 'CERTIFICATE_DENIED'),
    /// Sui Move bytecode verification timed out.
  suiMoveVerificationTimedout(31, 'SUI_MOVE_VERIFICATION_TIMEDOUT'),
    /// The requested consensus object operation is not allowed.
  consensusObjectOperationNotAllowed(32, 'CONSENSUS_OBJECT_OPERATION_NOT_ALLOWED'),
    /// Requested consensus object has been deleted.
  inputObjectDeleted(33, 'INPUT_OBJECT_DELETED'),
    /// Certificate is canceled due to congestion on consensus objects.
  executionCanceledDueToConsensusObjectCongestion(34, 'EXECUTION_CANCELED_DUE_TO_CONSENSUS_OBJECT_CONGESTION'),
    /// Address is denied for this coin type.
  addressDeniedForCoin(35, 'ADDRESS_DENIED_FOR_COIN'),
    /// Coin type is globally paused for use.
  coinTypeGlobalPause(36, 'COIN_TYPE_GLOBAL_PAUSE'),
    /// Certificate is canceled because randomness could not be generated this epoch.
  executionCanceledDueToRandomnessUnavailable(37, 'EXECUTION_CANCELED_DUE_TO_RANDOMNESS_UNAVAILABLE'),
    /// Move vector element (passed to MakeMoveVec) with size {value_size} is larger \
  /// than the maximum size {max_scaled_size}. Note that this maximum is scaled based on the \
  /// type of the vector element.
  moveVectorElemTooBig(38, 'MOVE_VECTOR_ELEM_TOO_BIG'),
    /// Move value (possibly an upgrade ticket or a dev-inspect value) with size {value_size} \
  /// is larger than the maximum size  {max_scaled_size}. Note that this maximum is scaled based \
  /// on the type of the value.
  moveRawValueTooBig(39, 'MOVE_RAW_VALUE_TOO_BIG'),
    /// A valid linkage was unable to be determined for the transaction or one of its commands.
  invalidLinkage(40, 'INVALID_LINKAGE'),
    /// Insufficient funds for transaction withdrawal
  insufficientFundsForWithdraw(41, 'INSUFFICIENT_FUNDS_FOR_WITHDRAW'),
    /// An input object with non-exclusive write mutability was modified
  nonExclusiveWriteInputObjectModified(42, 'NON_EXCLUSIVE_WRITE_INPUT_OBJECT_MODIFIED');

  const SuiExecutionErrorExecutionErrorKind(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiExecutionErrorExecutionErrorKind fromValue(int? value) {
    value ??=0;
    return SuiExecutionErrorExecutionErrorKind.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiExecutionErrorExecutionErrorKind found for the given value. $value", details: {"name": "SuiExecutionErrorExecutionErrorKind", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiExecutionErrorExecutionErrorKind from(Object? value) {
    value ??=0;
    return SuiExecutionErrorExecutionErrorKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiExecutionErrorExecutionErrorKind found for the given value. $value", details: {"name": "SuiExecutionErrorExecutionErrorKind", "value": value?.toString()})
    );
  }

}


enum SuiCommandArgumentErrorCommandArgumentErrorKind implements ProtoEnumVariant {
  commandArgumentErrorKindUnknown(0, 'COMMAND_ARGUMENT_ERROR_KIND_UNKNOWN'),
    /// The type of the value does not match the expected type.
  typeMismatch(1, 'TYPE_MISMATCH'),
    /// The argument cannot be deserialized into a value of the specified type.
  invalidBcsBytes(2, 'INVALID_BCS_BYTES'),
    /// The argument cannot be instantiated from raw bytes.
  invalidUsageOfPureArgument(3, 'INVALID_USAGE_OF_PURE_ARGUMENT'),
    /// Invalid argument to private entry function.
  /// Private entry functions cannot take arguments from other Move functions.
  invalidArgumentToPrivateEntryFunction(4, 'INVALID_ARGUMENT_TO_PRIVATE_ENTRY_FUNCTION'),
    /// Out of bounds access to input or results.
  ///
  /// `index` field will be set indicating the invalid index value.
  indexOutOfBounds(5, 'INDEX_OUT_OF_BOUNDS'),
    /// Out of bounds access to subresult.
  ///
  /// `index` and `subresult` fields will be set indicating the invalid index value.
  secondaryIndexOutOfBounds(6, 'SECONDARY_INDEX_OUT_OF_BOUNDS'),
    /// Invalid usage of result.
  /// Expected a single result but found either no return value or multiple.
  /// `index` field will be set indicating the invalid index value.
  invalidResultArity(7, 'INVALID_RESULT_ARITY'),
    /// Invalid usage of gas coin.
  /// The gas coin can only be used by-value with a `TransferObject` command.
  invalidGasCoinUsage(8, 'INVALID_GAS_COIN_USAGE'),
    /// Invalid usage of Move value.
  /// - Mutably borrowed values require unique usage.
  /// - Immutably borrowed values cannot be taken or borrowed mutably.
  /// - Taken values cannot be used again.
  invalidValueUsage(9, 'INVALID_VALUE_USAGE'),
    /// Immutable objects cannot be passed by-value.
  invalidObjectByValue(10, 'INVALID_OBJECT_BY_VALUE'),
    /// Immutable objects cannot be passed by mutable reference, `&amp;mut`.
  invalidObjectByMutRef(11, 'INVALID_OBJECT_BY_MUT_REF'),
    /// Consensus object operations such as wrapping, freezing, or converting to owned are not
  /// allowed.
  consensusObjectOperationNotAllowed(12, 'CONSENSUS_OBJECT_OPERATION_NOT_ALLOWED'),
    /// Invalid argument arity. Expected a single argument but found a result that expanded to
  /// multiple arguments.
  invalidArgumentArity(13, 'INVALID_ARGUMENT_ARITY'),
    /// Object passed to TransferObject does not have public transfer, i.e. the `store` ability
  invalidTransferObject(14, 'INVALID_TRANSFER_OBJECT'),
    /// First argument to MakeMoveVec is not an object. If no type is specified for MakeMoveVec,
  /// all arguments must be the same object type.
  invalidMakeMoveVecNonObjectArgument(15, 'INVALID_MAKE_MOVE_VEC_NON_OBJECT_ARGUMENT'),
    /// Specified argument location does not have a value and cannot be used
  argumentWithoutValue(16, 'ARGUMENT_WITHOUT_VALUE'),
    /// Cannot move a borrowed value. The value's type does resulted in this argument usage being
  /// inferred as a move. This is likely due to the type not having the `copy` ability; although
  /// in rare cases, it could also be this is the last usage of a value without the `drop`
  /// ability.
  cannotMoveBorrowedValue(17, 'CANNOT_MOVE_BORROWED_VALUE'),
    /// Cannot write to an argument location that is still borrowed, and where that borrow is an
  /// extension of that reference. This is likely due to this argument being used in a Move call
  /// that returns a reference, and that reference is used in a later command.
  cannotWriteToExtendedReference(18, 'CANNOT_WRITE_TO_EXTENDED_REFERENCE'),
    /// The argument specified cannot be used as a reference argument in the Move call. Either the
  /// argument is a mutable reference and it conflicts with another argument to the call, or the
  /// argument is mutable and another reference extends it and will be used in a later command.
  invalidReferenceArgument(19, 'INVALID_REFERENCE_ARGUMENT'),
    /// Invalid usage of TxContext in the function signature. TxContext can only be used by
  /// reference, `&amp;TxContext` or `&amp;mut TxContext`. If used mutably, it must be the only
  /// TxContext parameter, and TxContext can never be returned from a Move call.
  invalidTxContext(20, 'INVALID_TX_CONTEXT');

  const SuiCommandArgumentErrorCommandArgumentErrorKind(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiCommandArgumentErrorCommandArgumentErrorKind fromValue(int? value) {
    value ??=0;
    return SuiCommandArgumentErrorCommandArgumentErrorKind.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiCommandArgumentErrorCommandArgumentErrorKind found for the given value. $value", details: {"name": "SuiCommandArgumentErrorCommandArgumentErrorKind", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiCommandArgumentErrorCommandArgumentErrorKind from(Object? value) {
    value ??=0;
    return SuiCommandArgumentErrorCommandArgumentErrorKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiCommandArgumentErrorCommandArgumentErrorKind found for the given value. $value", details: {"name": "SuiCommandArgumentErrorCommandArgumentErrorKind", "value": value?.toString()})
    );
  }

}


enum SuiPackageUpgradeErrorPackageUpgradeErrorKind implements ProtoEnumVariant {
  packageUpgradeErrorKindUnknown(0, 'PACKAGE_UPGRADE_ERROR_KIND_UNKNOWN'),
    /// Unable to fetch package.
  unableToFetchPackage(1, 'UNABLE_TO_FETCH_PACKAGE'),
    /// Object is not a package.
  notAPackage(2, 'NOT_A_PACKAGE'),
    /// Package upgrade is incompatible with previous version.
  incompatibleUpgrade(3, 'INCOMPATIBLE_UPGRADE'),
    /// Digest in upgrade ticket and computed digest differ.
  digestDoesNotMatch(4, 'DIGEST_DOES_NOT_MATCH'),
    /// Upgrade policy is not valid.
  unknownUpgradePolicy(5, 'UNKNOWN_UPGRADE_POLICY'),
    /// Package ID does not match `PackageId` in upgrade ticket.
  packageIdDoesNotMatch(6, 'PACKAGE_ID_DOES_NOT_MATCH');

  const SuiPackageUpgradeErrorPackageUpgradeErrorKind(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiPackageUpgradeErrorPackageUpgradeErrorKind fromValue(int? value) {
    value ??=0;
    return SuiPackageUpgradeErrorPackageUpgradeErrorKind.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiPackageUpgradeErrorPackageUpgradeErrorKind found for the given value. $value", details: {"name": "SuiPackageUpgradeErrorPackageUpgradeErrorKind", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiPackageUpgradeErrorPackageUpgradeErrorKind from(Object? value) {
    value ??=0;
    return SuiPackageUpgradeErrorPackageUpgradeErrorKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiPackageUpgradeErrorPackageUpgradeErrorKind found for the given value. $value", details: {"name": "SuiPackageUpgradeErrorPackageUpgradeErrorKind", "value": value?.toString()})
    );
  }

}


enum SuiTypeArgumentErrorTypeArgumentErrorKind implements ProtoEnumVariant {
  typeArgumentErrorKindUnknown(0, 'TYPE_ARGUMENT_ERROR_KIND_UNKNOWN'),
    /// A type was not found in the module specified.
  typeNotFound(1, 'TYPE_NOT_FOUND'),
    /// A type provided did not match the specified constraint.
  constraintNotSatisfied(2, 'CONSTRAINT_NOT_SATISFIED');

  const SuiTypeArgumentErrorTypeArgumentErrorKind(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiTypeArgumentErrorTypeArgumentErrorKind fromValue(int? value) {
    value ??=0;
    return SuiTypeArgumentErrorTypeArgumentErrorKind.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiTypeArgumentErrorTypeArgumentErrorKind found for the given value. $value", details: {"name": "SuiTypeArgumentErrorTypeArgumentErrorKind", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiTypeArgumentErrorTypeArgumentErrorKind from(Object? value) {
    value ??=0;
    return SuiTypeArgumentErrorTypeArgumentErrorKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiTypeArgumentErrorTypeArgumentErrorKind found for the given value. $value", details: {"name": "SuiTypeArgumentErrorTypeArgumentErrorKind", "value": value?.toString()})
    );
  }

}


/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// The status of an executed transaction.
class SuiExecutionStatus extends SuiProtoMessage {
    /// Indicates if the transaction was successful or not.
  final bool? success;

    /// The error if `success` is false.
  final SuiExecutionError? error;

  const SuiExecutionStatus({
    this.success,
    this.error,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        success,
        error,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'success': success,
      'error': config.encodeMessage(error),
    };
  }


  factory SuiExecutionStatus.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiExecutionStatus(
      success: json.valueAsBool<bool?>('success', normalizeKeyLookup: config.normalizeKeys),
      error: json.valueTo<SuiExecutionError?, Object>(
        key: 'error',
        parse: (v) => SuiExecutionError.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiExecutionStatus.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiExecutionStatus(
      success: decode.getBool<bool?>(1),
      error: decode.messageTo<SuiExecutionError?>(2, (b) => SuiExecutionError.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ExecutionStatus;

}


/// An error that can occur during the execution of a transaction.
class SuiExecutionError extends SuiProtoMessage {
    /// A human readable description of the error
  final String? description;

    /// The command, if any, during which the error occurred.
  final BigInt? command;

  final SuiExecutionErrorExecutionErrorKind? kind;

  final SuiMoveAbort? abort;

  final SuiSizeError? sizeError;

  final SuiCommandArgumentError? commandArgumentError;

  final SuiTypeArgumentError? typeArgumentError;

  final SuiPackageUpgradeError? packageUpgradeError;

  final SuiIndexError? indexError;

  final String? objectId;

  final SuiCoinDenyListError? coinDenyListError;

    /// Set of objects that were congested, leading to the transaction's cancellation.
  final SuiCongestedObjects? congestedObjects;

  const SuiExecutionError({
    this.description,
    this.command,
    this.kind,
    this.abort,
    this.sizeError,
    this.commandArgumentError,
    this.typeArgumentError,
    this.packageUpgradeError,
    this.indexError,
    this.objectId,
    this.coinDenyListError,
    this.congestedObjects,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.string(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(12),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        description,
        command,
        kind,
        abort,
        sizeError,
        commandArgumentError,
        typeArgumentError,
        packageUpgradeError,
        indexError,
        objectId,
        coinDenyListError,
        congestedObjects,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'description': description,
      'command': config.encodeBigint(command),
      'kind': config.encodeEnum(kind),
      'abort': config.encodeMessage(abort),
      'size_error': config.encodeMessage(sizeError),
      'command_argument_error': config.encodeMessage(commandArgumentError),
      'type_argument_error': config.encodeMessage(typeArgumentError),
      'package_upgrade_error': config.encodeMessage(packageUpgradeError),
      'index_error': config.encodeMessage(indexError),
      'object_id': objectId,
      'coin_deny_list_error': config.encodeMessage(coinDenyListError),
      'congested_objects': config.encodeMessage(congestedObjects),
    };
  }


  factory SuiExecutionError.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiExecutionError(
      description: json.valueAsString<String?>('description', normalizeKeyLookup: config.normalizeKeys),
      command: json.valueAsBigInt<BigInt?>('command', normalizeKeyLookup: config.normalizeKeys),
      kind: json.valueTo<SuiExecutionErrorExecutionErrorKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiExecutionErrorExecutionErrorKind.from(v),
      ),
      abort: json.valueTo<SuiMoveAbort?, Object>(
        key: 'abort',
        parse: (v) => SuiMoveAbort.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      sizeError: json.valueTo<SuiSizeError?, Object>(
        key: 'size_error',
        parse: (v) => SuiSizeError.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      commandArgumentError: json.valueTo<SuiCommandArgumentError?, Object>(
        key: 'command_argument_error',
        parse: (v) => SuiCommandArgumentError.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      typeArgumentError: json.valueTo<SuiTypeArgumentError?, Object>(
        key: 'type_argument_error',
        parse: (v) => SuiTypeArgumentError.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      packageUpgradeError: json.valueTo<SuiPackageUpgradeError?, Object>(
        key: 'package_upgrade_error',
        parse: (v) => SuiPackageUpgradeError.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      indexError: json.valueTo<SuiIndexError?, Object>(
        key: 'index_error',
        parse: (v) => SuiIndexError.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      objectId: json.valueAsString<String?>('object_id', normalizeKeyLookup: config.normalizeKeys),
      coinDenyListError: json.valueTo<SuiCoinDenyListError?, Object>(
        key: 'coin_deny_list_error',
        parse: (v) => SuiCoinDenyListError.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      congestedObjects: json.valueTo<SuiCongestedObjects?, Object>(
        key: 'congested_objects',
        parse: (v) => SuiCongestedObjects.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiExecutionError.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiExecutionError(
      description: decode.getString<String?>(1),
      command: decode.getBigInt<BigInt?>(2),
      kind: decode.getEnum<SuiExecutionErrorExecutionErrorKind?>(3, SuiExecutionErrorExecutionErrorKind.values),
      abort: decode.messageTo<SuiMoveAbort?>(4, (b) => SuiMoveAbort.deserialize(b)),
      sizeError: decode.messageTo<SuiSizeError?>(5, (b) => SuiSizeError.deserialize(b)),
      commandArgumentError: decode.messageTo<SuiCommandArgumentError?>(6, (b) => SuiCommandArgumentError.deserialize(b)),
      typeArgumentError: decode.messageTo<SuiTypeArgumentError?>(7, (b) => SuiTypeArgumentError.deserialize(b)),
      packageUpgradeError: decode.messageTo<SuiPackageUpgradeError?>(8, (b) => SuiPackageUpgradeError.deserialize(b)),
      indexError: decode.messageTo<SuiIndexError?>(9, (b) => SuiIndexError.deserialize(b)),
      objectId: decode.getString<String?>(10),
      coinDenyListError: decode.messageTo<SuiCoinDenyListError?>(11, (b) => SuiCoinDenyListError.deserialize(b)),
      congestedObjects: decode.messageTo<SuiCongestedObjects?>(12, (b) => SuiCongestedObjects.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ExecutionError;

}


class SuiMoveAbort extends SuiProtoMessage {
  final BigInt? abortCode;

    /// Location in Move where the error occurred.
  final SuiMoveLocation? location;

    /// Extra error information if abort code is a "Clever Error"
  final SuiCleverError? cleverError;

  const SuiMoveAbort({
    this.abortCode,
    this.location,
    this.cleverError,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        abortCode,
        location,
        cleverError,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'abort_code': config.encodeBigint(abortCode),
      'location': config.encodeMessage(location),
      'clever_error': config.encodeMessage(cleverError),
    };
  }


  factory SuiMoveAbort.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiMoveAbort(
      abortCode: json.valueAsBigInt<BigInt?>('abort_code', normalizeKeyLookup: config.normalizeKeys),
      location: json.valueTo<SuiMoveLocation?, Object>(
        key: 'location',
        parse: (v) => SuiMoveLocation.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      cleverError: json.valueTo<SuiCleverError?, Object>(
        key: 'clever_error',
        parse: (v) => SuiCleverError.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiMoveAbort.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMoveAbort(
      abortCode: decode.getBigInt<BigInt?>(1),
      location: decode.messageTo<SuiMoveLocation?>(2, (b) => SuiMoveLocation.deserialize(b)),
      cleverError: decode.messageTo<SuiCleverError?>(3, (b) => SuiCleverError.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2MoveAbort;

}


/// Location in Move bytecode where an error occurred.
class SuiMoveLocation extends SuiProtoMessage {
    /// The package ID.
  final String? package;

    /// The module name.
  final String? module;

    /// The function index.
  final int? function;

    /// Offset of the instruction where the error occurred.
  final int? instruction;

    /// The name of the function, if available.
  final String? functionName;

  const SuiMoveLocation({
    this.package,
    this.module,
    this.function,
    this.instruction,
    this.functionName,
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
        ProtoFieldConfig.uint32(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        package,
        module,
        function,
        instruction,
        functionName,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'package': package,
      'module': module,
      'function': function,
      'instruction': instruction,
      'function_name': functionName,
    };
  }


  factory SuiMoveLocation.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiMoveLocation(
      package: json.valueAsString<String?>('package', normalizeKeyLookup: config.normalizeKeys),
      module: json.valueAsString<String?>('module', normalizeKeyLookup: config.normalizeKeys),
      function: json.valueAsInt<int?>('function', normalizeKeyLookup: config.normalizeKeys),
      instruction: json.valueAsInt<int?>('instruction', normalizeKeyLookup: config.normalizeKeys),
      functionName: json.valueAsString<String?>('function_name', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiMoveLocation.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMoveLocation(
      package: decode.getString<String?>(1),
      module: decode.getString<String?>(2),
      function: decode.getInt<int?>(3),
      instruction: decode.getInt<int?>(4),
      functionName: decode.getString<String?>(5),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2MoveLocation;

}


class SuiCleverError extends SuiProtoMessage {
  final BigInt? errorCode;

  final BigInt? lineNumber;

  final String? constantName;

  final String? constantType;

  final String? rendered;

  final BuBytes? raw;

  SuiCleverError({
    this.errorCode,
    this.lineNumber,
    this.constantName,
    this.constantType,
    this.rendered,
    List<int>? raw,
  }) : 
    raw = raw?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5),
        ProtoFieldConfig.bytes(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        errorCode,
        lineNumber,
        constantName,
        constantType,
        rendered,
        raw,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'error_code': config.encodeBigint(errorCode),
      'line_number': config.encodeBigint(lineNumber),
      'constant_name': constantName,
      'constant_type': constantType,
      'rendered': rendered,
      'raw': config.encodeBinary(raw),
    };
  }


  factory SuiCleverError.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiCleverError(
      errorCode: json.valueAsBigInt<BigInt?>('error_code', normalizeKeyLookup: config.normalizeKeys),
      lineNumber: json.valueAsBigInt<BigInt?>('line_number', normalizeKeyLookup: config.normalizeKeys),
      constantName: json.valueAsString<String?>('constant_name', normalizeKeyLookup: config.normalizeKeys),
      constantType: json.valueAsString<String?>('constant_type', normalizeKeyLookup: config.normalizeKeys),
      rendered: json.valueAsString<String?>('rendered', normalizeKeyLookup: config.normalizeKeys),
      raw: config.decodeBinary<List<int>?>(json.valueAs('raw', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory SuiCleverError.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCleverError(
      errorCode: decode.getBigInt<BigInt?>(1),
      lineNumber: decode.getBigInt<BigInt?>(2),
      constantName: decode.getString<String?>(3),
      constantType: decode.getString<String?>(4),
      rendered: decode.getString<String?>(5),
      raw: decode.getBytes<List<int>?>(6),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2CleverError;

}


/// A size error.
class SuiSizeError extends SuiProtoMessage {
    /// The offending size.
  final BigInt? size;

    /// The maximum allowable size.
  final BigInt? maxSize;

  const SuiSizeError({
    this.size,
    this.maxSize,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        size,
        maxSize,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'size': config.encodeBigint(size),
      'max_size': config.encodeBigint(maxSize),
    };
  }


  factory SuiSizeError.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiSizeError(
      size: json.valueAsBigInt<BigInt?>('size', normalizeKeyLookup: config.normalizeKeys),
      maxSize: json.valueAsBigInt<BigInt?>('max_size', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiSizeError.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSizeError(
      size: decode.getBigInt<BigInt?>(1),
      maxSize: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2SizeError;

}


class SuiIndexError extends SuiProtoMessage {
    /// Index of an input or result.
  final int? index;

    /// Index of a subresult.
  final int? subresult;

  const SuiIndexError({
    this.index,
    this.subresult,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint32(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        index,
        subresult,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'index': index,
      'subresult': subresult,
    };
  }


  factory SuiIndexError.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiIndexError(
      index: json.valueAsInt<int?>('index', normalizeKeyLookup: config.normalizeKeys),
      subresult: json.valueAsInt<int?>('subresult', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiIndexError.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiIndexError(
      index: decode.getInt<int?>(1),
      subresult: decode.getInt<int?>(2),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2IndexError;

}


class SuiCoinDenyListError extends SuiProtoMessage {
    /// Denied address.
  final String? address;

    /// Coin type.
  final String? coinType;

  const SuiCoinDenyListError({
    this.address,
    this.coinType,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        address,
        coinType,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'address': address,
      'coin_type': coinType,
    };
  }


  factory SuiCoinDenyListError.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiCoinDenyListError(
      address: json.valueAsString<String?>('address', normalizeKeyLookup: config.normalizeKeys),
      coinType: json.valueAsString<String?>('coin_type', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiCoinDenyListError.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCoinDenyListError(
      address: decode.getString<String?>(1),
      coinType: decode.getString<String?>(2),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2CoinDenyListError;

}


/// Set of objects that were congested, leading to the transaction's cancellation.
class SuiCongestedObjects extends SuiProtoMessage {
  final List<String> objects;

  const SuiCongestedObjects({
    this.objects = const [],
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
          elementType: ProtoFieldType.string,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        objects,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'objects': objects.map((e) => e).toList(),
    };
  }


  factory SuiCongestedObjects.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiCongestedObjects(
      objects: (json.valueEnsureAsList<dynamic>('objects', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueAsString<String>(e)).toList(),
    );
  }

  factory SuiCongestedObjects.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCongestedObjects(
      objects: decode.getListOrEmpty<String>(1),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2CongestedObjects;

}


/// An error with an argument to a command.
class SuiCommandArgumentError extends SuiProtoMessage {
    /// Position of the problematic argument.
  final int? argument;

  final SuiCommandArgumentErrorCommandArgumentErrorKind? kind;

  final SuiIndexError? indexError;

  const SuiCommandArgumentError({
    this.argument,
    this.kind,
    this.indexError,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint32(1, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        argument,
        kind,
        indexError,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'argument': argument,
      'kind': config.encodeEnum(kind),
      'index_error': config.encodeMessage(indexError),
    };
  }


  factory SuiCommandArgumentError.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiCommandArgumentError(
      argument: json.valueAsInt<int?>('argument', normalizeKeyLookup: config.normalizeKeys),
      kind: json.valueTo<SuiCommandArgumentErrorCommandArgumentErrorKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiCommandArgumentErrorCommandArgumentErrorKind.from(v),
      ),
      indexError: json.valueTo<SuiIndexError?, Object>(
        key: 'index_error',
        parse: (v) => SuiIndexError.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiCommandArgumentError.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCommandArgumentError(
      argument: decode.getInt<int?>(1),
      kind: decode.getEnum<SuiCommandArgumentErrorCommandArgumentErrorKind?>(2, SuiCommandArgumentErrorCommandArgumentErrorKind.values),
      indexError: decode.messageTo<SuiIndexError?>(3, (b) => SuiIndexError.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2CommandArgumentError;

}


/// An error with upgrading a package.
class SuiPackageUpgradeError extends SuiProtoMessage {
  final SuiPackageUpgradeErrorPackageUpgradeErrorKind? kind;

    /// The Package Id.
  final String? packageId;

    /// A digest.
  final String? digest;

    /// The policy.
  final int? policy;

    /// The ticket Id.
  final String? ticketId;

  const SuiPackageUpgradeError({
    this.kind,
    this.packageId,
    this.digest,
    this.policy,
    this.ticketId,
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
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        kind,
        packageId,
        digest,
        policy,
        ticketId,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'kind': config.encodeEnum(kind),
      'package_id': packageId,
      'digest': digest,
      'policy': policy,
      'ticket_id': ticketId,
    };
  }


  factory SuiPackageUpgradeError.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiPackageUpgradeError(
      kind: json.valueTo<SuiPackageUpgradeErrorPackageUpgradeErrorKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiPackageUpgradeErrorPackageUpgradeErrorKind.from(v),
      ),
      packageId: json.valueAsString<String?>('package_id', normalizeKeyLookup: config.normalizeKeys),
      digest: json.valueAsString<String?>('digest', normalizeKeyLookup: config.normalizeKeys),
      policy: json.valueAsInt<int?>('policy', normalizeKeyLookup: config.normalizeKeys),
      ticketId: json.valueAsString<String?>('ticket_id', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiPackageUpgradeError.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiPackageUpgradeError(
      kind: decode.getEnum<SuiPackageUpgradeErrorPackageUpgradeErrorKind?>(1, SuiPackageUpgradeErrorPackageUpgradeErrorKind.values),
      packageId: decode.getString<String?>(2),
      digest: decode.getString<String?>(3),
      policy: decode.getInt<int?>(4),
      ticketId: decode.getString<String?>(5),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2PackageUpgradeError;

}


/// Type argument error.
class SuiTypeArgumentError extends SuiProtoMessage {
    /// Index of the problematic type argument.
  final int? typeArgument;

  final SuiTypeArgumentErrorTypeArgumentErrorKind? kind;

  const SuiTypeArgumentError({
    this.typeArgument,
    this.kind,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint32(1, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        typeArgument,
        kind,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'type_argument': typeArgument,
      'kind': config.encodeEnum(kind),
    };
  }


  factory SuiTypeArgumentError.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiTypeArgumentError(
      typeArgument: json.valueAsInt<int?>('type_argument', normalizeKeyLookup: config.normalizeKeys),
      kind: json.valueTo<SuiTypeArgumentErrorTypeArgumentErrorKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiTypeArgumentErrorTypeArgumentErrorKind.from(v),
      ),
    );
  }

  factory SuiTypeArgumentError.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTypeArgumentError(
      typeArgument: decode.getInt<int?>(1),
      kind: decode.getEnum<SuiTypeArgumentErrorTypeArgumentErrorKind?>(2, SuiTypeArgumentErrorTypeArgumentErrorKind.values),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2TypeArgumentError;

}



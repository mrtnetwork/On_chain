import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/transaction.dart"
    as sui_rpc_v2_transaction;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature.dart"
    as sui_rpc_v2_signature;
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/field_mask.dart"
    as google_protobuf_field_mask;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/executed_transaction.dart"
    as sui_rpc_v2_executed_transaction;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/argument.dart"
    as sui_rpc_v2_argument;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart"
    as sui_rpc_v2_bcs;
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/struct.dart"
    as google_protobuf_struct;

/// buf:lint:ignore ENUM_ZERO_VALUE_SUFFIX
enum SuiSimulateTransactionRequestTransactionChecks
    implements ProtoEnumVariant {
  enabled(0, 'ENABLED'),
  disabled(1, 'DISABLED');

  const SuiSimulateTransactionRequestTransactionChecks(
    this.value,
    this.protoName,
  );

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiSimulateTransactionRequestTransactionChecks fromValue(int? value) {
    value ??= 0;
    return SuiSimulateTransactionRequestTransactionChecks.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiSimulateTransactionRequestTransactionChecks found for the given value. $value",
                details: {
                  "name": "SuiSimulateTransactionRequestTransactionChecks",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiSimulateTransactionRequestTransactionChecks from(Object? value) {
    value ??= 0;
    return SuiSimulateTransactionRequestTransactionChecks.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiSimulateTransactionRequestTransactionChecks found for the given value. $value",
                details: {
                  "name": "SuiSimulateTransactionRequestTransactionChecks",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

class SuiExecuteTransactionRequest extends SuiProtoMessage
    with ISuiProtoServiceMessage<SuiExecuteTransactionResponse> {
  /// The transaction to execute.
  final sui_rpc_v2_transaction.SuiTransaction? transaction;

  /// Set of `UserSignature`s authorizing the execution of the provided
  /// transaction.
  final List<sui_rpc_v2_signature.SuiUserSignature> signatures;

  /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `effects.status,checkpoint`.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  const SuiExecuteTransactionRequest({
    this.transaction,
    this.signatures = const [],
    this.readMask,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [transaction, signatures, readMask];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transaction': config.encodeMessage(transaction),
      'signatures': signatures.map((e) => config.encodeMessage(e)).toList(),
      'read_mask': config.encodeMessage(readMask),
    };
  }

  factory SuiExecuteTransactionRequest.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiExecuteTransactionRequest(
      transaction: json.valueTo<sui_rpc_v2_transaction.SuiTransaction?, Object>(
        key: 'transaction',
        parse:
            (v) => sui_rpc_v2_transaction.SuiTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signatures:
          (json.valueEnsureAsList<dynamic>(
                'signatures',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  sui_rpc_v2_signature.SuiUserSignature,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => sui_rpc_v2_signature.SuiUserSignature.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse:
            (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiExecuteTransactionRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiExecuteTransactionRequest(
      transaction: decode.messageTo<sui_rpc_v2_transaction.SuiTransaction?>(
        1,
        (b) => sui_rpc_v2_transaction.SuiTransaction.deserialize(b),
      ),
      signatures:
          decode
              .getListOfBytes(2)
              .map((b) => sui_rpc_v2_signature.SuiUserSignature.deserialize(b))
              .toList(),
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(
        3,
        (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ExecuteTransactionRequest;
  @override
  SuiExecuteTransactionResponse onServiceResponse(List<int> bytes) {
    return SuiExecuteTransactionResponse.deserialize(bytes);
  }

  @override
  SuiExecuteTransactionResponse onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return SuiExecuteTransactionResponse.fromJson(json);
  }
}

/// Response message for `NodeService.ExecuteTransaction`.
class SuiExecuteTransactionResponse extends SuiProtoMessage {
  final sui_rpc_v2_executed_transaction.SuiExecutedTransaction? transaction;

  const SuiExecuteTransactionResponse({this.transaction});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1, hasOptionalFlags: true)],
    );
  }

  @override
  List<Object?> get protoValues => [transaction];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'transaction': config.encodeMessage(transaction)};
  }

  factory SuiExecuteTransactionResponse.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiExecuteTransactionResponse(
      transaction: json.valueTo<
        sui_rpc_v2_executed_transaction.SuiExecutedTransaction?,
        Object
      >(
        key: 'transaction',
        parse:
            (v) =>
                sui_rpc_v2_executed_transaction.SuiExecutedTransaction.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiExecuteTransactionResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiExecuteTransactionResponse(
      transaction: decode
          .messageTo<sui_rpc_v2_executed_transaction.SuiExecutedTransaction?>(
            1,
            (b) => sui_rpc_v2_executed_transaction
                .SuiExecutedTransaction.deserialize(b),
          ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ExecuteTransactionResponse;
}

class SuiSimulateTransactionRequest extends SuiProtoMessage
    with ISuiProtoServiceMessage<SuiSimulateTransactionResponse> {
  final sui_rpc_v2_transaction.SuiTransaction? transaction;

  /// Mask specifying which fields to read.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  /// Specify whether checks should be ENABLED (default) or DISABLED while executing the transaction
  final SuiSimulateTransactionRequestTransactionChecks? checks;

  /// Perform gas selection based on a budget estimation and include the
  /// selected gas payment and budget in the response.
  ///
  /// This option will be ignored if `checks` is `DISABLED`.
  final bool? doGasSelection;

  const SuiSimulateTransactionRequest({
    this.transaction,
    this.readMask,
    this.checks,
    this.doGasSelection,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(3, hasOptionalFlags: true),
        ProtoFieldConfig.bool(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    transaction,
    readMask,
    checks,
    doGasSelection,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transaction': config.encodeMessage(transaction),
      'read_mask': config.encodeMessage(readMask),
      'checks': config.encodeEnum(checks),
      'do_gas_selection': doGasSelection,
    };
  }

  factory SuiSimulateTransactionRequest.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSimulateTransactionRequest(
      transaction: json.valueTo<sui_rpc_v2_transaction.SuiTransaction?, Object>(
        key: 'transaction',
        parse:
            (v) => sui_rpc_v2_transaction.SuiTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse:
            (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      checks: json
          .valueTo<SuiSimulateTransactionRequestTransactionChecks?, Object?>(
            key: 'checks',
            parse:
                (v) => SuiSimulateTransactionRequestTransactionChecks.from(v),
          ),
      doGasSelection: json.valueAsBool<bool?>(
        'do_gas_selection',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiSimulateTransactionRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSimulateTransactionRequest(
      transaction: decode.messageTo<sui_rpc_v2_transaction.SuiTransaction?>(
        1,
        (b) => sui_rpc_v2_transaction.SuiTransaction.deserialize(b),
      ),
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(
        2,
        (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b),
      ),
      checks: decode.getEnum<SuiSimulateTransactionRequestTransactionChecks?>(
        3,
        SuiSimulateTransactionRequestTransactionChecks.values,
      ),
      doGasSelection: decode.getBool<bool?>(4),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SimulateTransactionRequest;
  @override
  SuiSimulateTransactionResponse onServiceResponse(List<int> bytes) {
    return SuiSimulateTransactionResponse.deserialize(bytes);
  }

  @override
  SuiSimulateTransactionResponse onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return SuiSimulateTransactionResponse.fromJson(json);
  }
}

class SuiSimulateTransactionResponse extends SuiProtoMessage {
  final sui_rpc_v2_executed_transaction.SuiExecutedTransaction? transaction;

  final List<SuiCommandResult> commandOutputs;

  /// A suggested gas price to use, that is above RGP, in order to provide a
  /// better chance of the transaction being included in the presence of
  /// congested objects.
  final BigInt? suggestedGasPrice;

  const SuiSimulateTransactionResponse({
    this.transaction,
    this.commandOutputs = const [],
    this.suggestedGasPrice,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    transaction,
    commandOutputs,
    suggestedGasPrice,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transaction': config.encodeMessage(transaction),
      'command_outputs':
          commandOutputs.map((e) => config.encodeMessage(e)).toList(),
      'suggested_gas_price': config.encodeBigint(suggestedGasPrice),
    };
  }

  factory SuiSimulateTransactionResponse.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSimulateTransactionResponse(
      transaction: json.valueTo<
        sui_rpc_v2_executed_transaction.SuiExecutedTransaction?,
        Object
      >(
        key: 'transaction',
        parse:
            (v) =>
                sui_rpc_v2_executed_transaction.SuiExecutedTransaction.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      commandOutputs:
          (json.valueEnsureAsList<dynamic>(
                'command_outputs',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiCommandResult, Object>(
                  value: e,
                  parse:
                      (v) => SuiCommandResult.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      suggestedGasPrice: json.valueAsBigInt<BigInt?>(
        'suggested_gas_price',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiSimulateTransactionResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSimulateTransactionResponse(
      transaction: decode
          .messageTo<sui_rpc_v2_executed_transaction.SuiExecutedTransaction?>(
            1,
            (b) => sui_rpc_v2_executed_transaction
                .SuiExecutedTransaction.deserialize(b),
          ),
      commandOutputs:
          decode
              .getListOfBytes(2)
              .map((b) => SuiCommandResult.deserialize(b))
              .toList(),
      suggestedGasPrice: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SimulateTransactionResponse;
}

/// An intermediate result/output from the execution of a single command
class SuiCommandResult extends SuiProtoMessage {
  final List<SuiCommandOutput> returnValues;

  final List<SuiCommandOutput> mutatedByRef;

  const SuiCommandResult({
    this.returnValues = const [],
    this.mutatedByRef = const [],
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
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [returnValues, mutatedByRef];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'return_values':
          returnValues.map((e) => config.encodeMessage(e)).toList(),
      'mutated_by_ref':
          mutatedByRef.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiCommandResult.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiCommandResult(
      returnValues:
          (json.valueEnsureAsList<dynamic>(
                'return_values',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiCommandOutput, Object>(
                  value: e,
                  parse:
                      (v) => SuiCommandOutput.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      mutatedByRef:
          (json.valueEnsureAsList<dynamic>(
                'mutated_by_ref',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiCommandOutput, Object>(
                  value: e,
                  parse:
                      (v) => SuiCommandOutput.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiCommandResult.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCommandResult(
      returnValues:
          decode
              .getListOfBytes(1)
              .map((b) => SuiCommandOutput.deserialize(b))
              .toList(),
      mutatedByRef:
          decode
              .getListOfBytes(2)
              .map((b) => SuiCommandOutput.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2CommandResult;
}

class SuiCommandOutput extends SuiProtoMessage {
  final sui_rpc_v2_argument.SuiArgument? argument;

  final sui_rpc_v2_bcs.SuiBcs? value;

  /// JSON rendering of the output.
  final google_protobuf_struct.SuiValue? json;

  const SuiCommandOutput({this.argument, this.value, this.json});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [argument, value, json];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'argument': config.encodeMessage(argument),
      'value': config.encodeMessage(value),
      'json': config.encodeMessage(json),
    };
  }

  factory SuiCommandOutput.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiCommandOutput(
      argument: json.valueTo<sui_rpc_v2_argument.SuiArgument?, Object>(
        key: 'argument',
        parse:
            (v) => sui_rpc_v2_argument.SuiArgument.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      value: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'value',
        parse:
            (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      json: json.valueTo<google_protobuf_struct.SuiValue?, Object>(
        key: 'json',
        parse:
            (v) => google_protobuf_struct.SuiValue.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiCommandOutput.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCommandOutput(
      argument: decode.messageTo<sui_rpc_v2_argument.SuiArgument?>(
        1,
        (b) => sui_rpc_v2_argument.SuiArgument.deserialize(b),
      ),
      value: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(
        2,
        (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b),
      ),
      json: decode.messageTo<google_protobuf_struct.SuiValue?>(
        3,
        (b) => google_protobuf_struct.SuiValue.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2CommandOutput;
}

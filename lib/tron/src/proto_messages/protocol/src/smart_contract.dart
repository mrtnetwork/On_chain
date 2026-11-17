import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/models/contracts/contracts.dart"
    as protocol_contracts;
import "package:on_chain/tron/src/proto_messages/protocol/src/api.dart"
    as protocol_api;

enum TronSmartContractABIEntryEntryType implements ProtoEnumVariant {
  unknownEntryType(0, 'UnknownEntryType'),
  constructor(1, 'Constructor'),
  function(2, 'Function'),
  event(3, 'Event'),
  fallback(4, 'Fallback'),
  receive(5, 'Receive'),
  error(6, 'Error');

  const TronSmartContractABIEntryEntryType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronSmartContractABIEntryEntryType fromValue(int? value) {
    value ??= 0;
    return TronSmartContractABIEntryEntryType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching TronSmartContractABIEntryEntryType found for the given value. $value", details: {"name": "TronSmartContractABIEntryEntryType", "value": value?.toString()}),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronSmartContractABIEntryEntryType from(Object? value) {
    value ??= 0;
    return TronSmartContractABIEntryEntryType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching TronSmartContractABIEntryEntryType found for the given value. $value", details: {"name": "TronSmartContractABIEntryEntryType", "value": value?.toString()}),
    );
  }
}

/// SolidityType type = 3;
enum TronSmartContractABIEntryStateMutabilityType implements ProtoEnumVariant {
  unknownMutabilityType(0, 'UnknownMutabilityType'),
  pure(1, 'Pure'),
  view(2, 'View'),
  nonpayable(3, 'Nonpayable'),
  payable(4, 'Payable');

  const TronSmartContractABIEntryStateMutabilityType(
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
  static TronSmartContractABIEntryStateMutabilityType fromValue(int? value) {
    value ??= 0;
    return TronSmartContractABIEntryStateMutabilityType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching TronSmartContractABIEntryStateMutabilityType found for the given value. $value", details: {"name": "TronSmartContractABIEntryStateMutabilityType", "value": value?.toString()}),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronSmartContractABIEntryStateMutabilityType from(Object? value) {
    value ??= 0;
    return TronSmartContractABIEntryStateMutabilityType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching TronSmartContractABIEntryStateMutabilityType found for the given value. $value", details: {"name": "TronSmartContractABIEntryStateMutabilityType", "value": value?.toString()}),
    );
  }
}

class TronSmartContractABI extends TronProtoMessage {
  final List<TronSmartContractABIEntry> entrys;

  const TronSmartContractABI({this.entrys = const []});

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
  List<Object?> get protoValues => [entrys];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'entrys': entrys.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronSmartContractABI.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSmartContractABI(
      entrys:
          (json.valueEnsureAsList<dynamic>(
                'entrys',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronSmartContractABIEntry, Object>(
                  value: e,
                  parse:
                      (v) => TronSmartContractABIEntry.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronSmartContractABI.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSmartContractABI(
      entrys:
          decode
              .getListOfBytes(1)
              .map((b) => TronSmartContractABIEntry.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSmartContractAbi;
}

class TronSmartContractABIEntry extends TronProtoMessage {
  final bool? anonymous;

  final bool? constant;

  final String? name;

  final List<TronSmartContractABIEntryParam> inputs;

  final List<TronSmartContractABIEntryParam> outputs;

  final TronSmartContractABIEntryEntryType? type;

  final bool? payable;

  final TronSmartContractABIEntryStateMutabilityType? stateMutability;

  const TronSmartContractABIEntry({
    this.anonymous,
    this.constant,
    this.name,
    this.inputs = const [],
    this.outputs = const [],
    this.type,
    this.payable,
    this.stateMutability,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1),
        ProtoFieldConfig.bool(2),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.enumType(6),
        ProtoFieldConfig.bool(7),
        ProtoFieldConfig.enumType(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    anonymous,
    constant,
    name,
    inputs,
    outputs,
    type,
    payable,
    stateMutability,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'anonymous': anonymous,
      'constant': constant,
      'name': name,
      'inputs': inputs.map((e) => config.encodeMessage(e)).toList(),
      'outputs': outputs.map((e) => config.encodeMessage(e)).toList(),
      'type': config.encodeEnum(type),
      'payable': payable,
      'stateMutability': config.encodeEnum(stateMutability),
    }.notNullValue;
  }

  factory TronSmartContractABIEntry.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSmartContractABIEntry(
      anonymous: json.valueAsBool<bool?>(
        'anonymous',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      constant: json.valueAsBool<bool?>(
        'constant',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      inputs:
          (json.valueEnsureAsList<dynamic>(
                'inputs',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) =>
                    JsonParser.valueTo<TronSmartContractABIEntryParam, Object>(
                      value: e,
                      parse:
                          (v) => TronSmartContractABIEntryParam.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                    ),
              )
              .toList(),
      outputs:
          (json.valueEnsureAsList<dynamic>(
                'outputs',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) =>
                    JsonParser.valueTo<TronSmartContractABIEntryParam, Object>(
                      value: e,
                      parse:
                          (v) => TronSmartContractABIEntryParam.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                    ),
              )
              .toList(),
      type: json.valueTo<TronSmartContractABIEntryEntryType?, Object?>(
        key: 'type',
        parse: (v) => TronSmartContractABIEntryEntryType.from(v),
      ),
      payable: json.valueAsBool<bool?>(
        'payable',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stateMutability: json
          .valueTo<TronSmartContractABIEntryStateMutabilityType?, Object?>(
            key: 'stateMutability',
            parse: (v) => TronSmartContractABIEntryStateMutabilityType.from(v),
          ),
    );
  }

  factory TronSmartContractABIEntry.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSmartContractABIEntry(
      anonymous: decode.getBool<bool?>(1),
      constant: decode.getBool<bool?>(2),
      name: decode.getString<String?>(3),
      inputs:
          decode
              .getListOfBytes(4)
              .map((b) => TronSmartContractABIEntryParam.deserialize(b))
              .toList(),
      outputs:
          decode
              .getListOfBytes(5)
              .map((b) => TronSmartContractABIEntryParam.deserialize(b))
              .toList(),
      type: decode.getEnum<TronSmartContractABIEntryEntryType?>(
        6,
        TronSmartContractABIEntryEntryType.values,
      ),
      payable: decode.getBool<bool?>(7),
      stateMutability: decode
          .getEnum<TronSmartContractABIEntryStateMutabilityType?>(
            8,
            TronSmartContractABIEntryStateMutabilityType.values,
          ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSmartContractAbiEntry;
}

class TronSmartContractABIEntryParam extends TronProtoMessage {
  final bool? indexed;

  final String? name;

  final String? type;

  const TronSmartContractABIEntryParam({this.indexed, this.name, this.type});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.string(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [indexed, name, type];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'indexed': indexed, 'name': name, 'type': type}.notNullValue;
  }

  factory TronSmartContractABIEntryParam.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSmartContractABIEntryParam(
      indexed: json.valueAsBool<bool?>(
        'indexed',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      type: json.valueAsString<String?>(
        'type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronSmartContractABIEntryParam.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSmartContractABIEntryParam(
      indexed: decode.getBool<bool?>(1),
      name: decode.getString<String?>(2),
      type: decode.getString<String?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSmartContractAbiEntryParam;
}

class TronContractState extends TronProtoMessage {
  final BigInt? energyUsage;

  final BigInt? energyFactor;

  final BigInt? updateCycle;

  const TronContractState({
    this.energyUsage,
    this.energyFactor,
    this.updateCycle,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [energyUsage, energyFactor, updateCycle];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'energy_usage': config.encodeBigint(energyUsage),
      'energy_factor': config.encodeBigint(energyFactor),
      'update_cycle': config.encodeBigint(updateCycle),
    }.notNullValue;
  }

  factory TronContractState.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronContractState(
      energyUsage: json.valueAsBigInt<BigInt?>(
        'energy_usage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      energyFactor: json.valueAsBigInt<BigInt?>(
        'energy_factor',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      updateCycle: json.valueAsBigInt<BigInt?>(
        'update_cycle',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronContractState.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronContractState(
      energyUsage: decode.getBigInt<BigInt?>(1),
      energyFactor: decode.getBigInt<BigInt?>(2),
      updateCycle: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolContractState;
}

class TronSmartContractDataWrapper extends TronProtoMessage {
  final protocol_contracts.TronSmartContract? smartContract;

  final List<int>? runtimecode;

  final TronContractState? contractState;

  const TronSmartContractDataWrapper({
    this.smartContract,
    this.runtimecode,
    this.contractState,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [smartContract, runtimecode, contractState];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'smart_contract': config.encodeMessage(smartContract),
      'runtimecode': config.encodeBinary(runtimecode),
      'contract_state': config.encodeMessage(contractState),
    }.notNullValue;
  }

  factory TronSmartContractDataWrapper.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSmartContractDataWrapper(
      smartContract: json
          .valueTo<protocol_contracts.TronSmartContract?, Object>(
            key: 'smart_contract',
            parse:
                (v) => protocol_contracts.TronSmartContract.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      runtimecode: config.decodeBinary<List<int>?>(
        json.valueAs('runtimecode', normalizeKeyLookup: config.normalizeKeys),
      ),
      contractState: json.valueTo<TronContractState?, Object>(
        key: 'contract_state',
        parse:
            (v) => TronContractState.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronSmartContractDataWrapper.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSmartContractDataWrapper(
      smartContract: decode.messageTo<protocol_contracts.TronSmartContract?>(
        1,
        (b) => protocol_contracts.TronSmartContract.deserialize(b),
      ),
      runtimecode: decode.getBytes<List<int>?>(2),
      contractState: decode.messageTo<TronContractState?>(
        3,
        (b) => TronContractState.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSmartContractDataWrapper;
}

class TronWalletUpdateSetting extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// modify the consume_user_resource_percent
  final protocol_contracts.TronUpdateSettingContract? updateSetting;

  const TronWalletUpdateSetting({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.updateSetting,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      updateSetting?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateSetting?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(updateSetting) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUpdateSetting;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletUpdateEnergyLimit extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// modify the energy_limit
  final protocol_contracts.TronUpdateEnergyLimitContract? updateEnergyLimit;

  const TronWalletUpdateEnergyLimit({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.updateEnergyLimit,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      updateEnergyLimit?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateEnergyLimit?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(updateEnergyLimit) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUpdateEnergyLimit;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletDeployContract extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronCreateSmartContract? deployContract;

  const TronWalletDeployContract({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.deployContract,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      deployContract?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => deployContract?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(deployContract) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletDeployContract;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletTriggerContract extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronTriggerSmartContract? triggerContract;

  const TronWalletTriggerContract({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.triggerContract,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      triggerContract?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => triggerContract?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(triggerContract) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletTriggerContract;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletTriggerConstantContract extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronTriggerSmartContract? triggerConstantContract;

  const TronWalletTriggerConstantContract({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.triggerConstantContract,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      triggerConstantContract?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => triggerConstantContract?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(triggerConstantContract) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletTriggerConstantContract;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletEstimateEnergy extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronEstimateEnergyMessage> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronTriggerSmartContract? estimateEnergy;

  const TronWalletEstimateEnergy({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.estimateEnergy,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      estimateEnergy?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => estimateEnergy?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(estimateEnergy) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletEstimateEnergy;
  @override
  protocol_api.TronEstimateEnergyMessage onServiceResponse(List<int> bytes) {
    return protocol_api.TronEstimateEnergyMessage.deserialize(bytes);
  }

  @override
  protocol_api.TronEstimateEnergyMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronEstimateEnergyMessage.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletClearContractABI extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronClearABIContract? clearContractABI;

  const TronWalletClearContractABI({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.clearContractABI,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      clearContractABI?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => clearContractABI?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(clearContractABI) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletClearContractABI;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityTriggerConstantContract extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronTriggerSmartContract? triggerConstantContract;

  const TronWalletSolidityTriggerConstantContract({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.triggerConstantContract,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      triggerConstantContract?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => triggerConstantContract?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(triggerConstantContract) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityTriggerConstantContract;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityEstimateEnergy extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronEstimateEnergyMessage> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronTriggerSmartContract? estimateEnergy;

  const TronWalletSolidityEstimateEnergy({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.estimateEnergy,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      estimateEnergy?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => estimateEnergy?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(estimateEnergy) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityEstimateEnergy;
  @override
  protocol_api.TronEstimateEnergyMessage onServiceResponse(List<int> bytes) {
    return protocol_api.TronEstimateEnergyMessage.deserialize(bytes);
  }

  @override
  protocol_api.TronEstimateEnergyMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronEstimateEnergyMessage.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

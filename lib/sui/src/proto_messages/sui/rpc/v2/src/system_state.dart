import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
class SuiSystemState extends SuiProtoMessage {
  /// The version of the system state data structure type.
  final BigInt? version;

  /// The epoch id
  final BigInt? epoch;

  /// The protocol version
  final BigInt? protocolVersion;

  /// Information about the validators
  final SuiValidatorSet? validators;

  /// Storage Fund info
  final SuiStorageFund? storageFund;

  /// Set of system config parameters
  final SuiSystemParameters? parameters;

  /// The reference gas price for this epoch
  final BigInt? referenceGasPrice;

  /// A list of the records of validator reporting each other.
  ///
  /// There is an entry in this list for each validator that has been reported
  /// at least once. Each record contains all the validators that reported
  /// them. If a validator has never been reported they don't have a record in this list.
  /// This lists persists across epoch: a peer continues being in a reported state until the
  /// reporter doesn't explicitly remove their report.
  final List<SuiValidatorReportRecord> validatorReportRecords;

  /// Schedule of stake subsidies given out each epoch.
  final SuiStakeSubsidy? stakeSubsidy;

  /// Whether the system is running in a downgraded safe mode due to a non-recoverable bug.
  /// This is set whenever we failed to execute advance_epoch, and ended up executing advance_epoch_safe_mode.
  /// It can be reset once we are able to successfully execute advance_epoch.
  /// The rest of the fields starting with `safe_mode_` are accumulated during safe mode
  /// when advance_epoch_safe_mode is executed. They will eventually be processed once we
  /// are out of safe mode.
  final bool? safeMode;

  /// Storage rewards accumulated during safe_mode
  final BigInt? safeModeStorageRewards;

  /// Computation rewards accumulated during safe_mode
  final BigInt? safeModeComputationRewards;

  /// Storage rebates paid out during safe_mode
  final BigInt? safeModeStorageRebates;

  /// Nonrefundable storage fees accumulated during safe_mode
  final BigInt? safeModeNonRefundableStorageFee;

  /// Unix timestamp of when this this epoch started
  final BigInt? epochStartTimestampMs;

  /// Any extra fields that's not defined statically.
  final SuiMoveTable? extraFields;

  const SuiSystemState({
    this.version,
    this.epoch,
    this.protocolVersion,
    this.validators,
    this.storageFund,
    this.parameters,
    this.referenceGasPrice,
    this.validatorReportRecords = const [],
    this.stakeSubsidy,
    this.safeMode,
    this.safeModeStorageRewards,
    this.safeModeComputationRewards,
    this.safeModeStorageRebates,
    this.safeModeNonRefundableStorageFee,
    this.epochStartTimestampMs,
    this.extraFields,
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
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
        ProtoFieldConfig.message(6, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(7, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(9, hasOptionalFlags: true),
        ProtoFieldConfig.bool(10, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(11, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(12, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(13, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(14, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(15, hasOptionalFlags: true),
        ProtoFieldConfig.message(16, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    version,
    epoch,
    protocolVersion,
    validators,
    storageFund,
    parameters,
    referenceGasPrice,
    validatorReportRecords,
    stakeSubsidy,
    safeMode,
    safeModeStorageRewards,
    safeModeComputationRewards,
    safeModeStorageRebates,
    safeModeNonRefundableStorageFee,
    epochStartTimestampMs,
    extraFields,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'version': config.encodeBigint(version),
      'epoch': config.encodeBigint(epoch),
      'protocol_version': config.encodeBigint(protocolVersion),
      'validators': config.encodeMessage(validators),
      'storage_fund': config.encodeMessage(storageFund),
      'parameters': config.encodeMessage(parameters),
      'reference_gas_price': config.encodeBigint(referenceGasPrice),
      'validator_report_records':
          validatorReportRecords.map((e) => config.encodeMessage(e)).toList(),
      'stake_subsidy': config.encodeMessage(stakeSubsidy),
      'safe_mode': safeMode,
      'safe_mode_storage_rewards': config.encodeBigint(safeModeStorageRewards),
      'safe_mode_computation_rewards': config.encodeBigint(
        safeModeComputationRewards,
      ),
      'safe_mode_storage_rebates': config.encodeBigint(safeModeStorageRebates),
      'safe_mode_non_refundable_storage_fee': config.encodeBigint(
        safeModeNonRefundableStorageFee,
      ),
      'epoch_start_timestamp_ms': config.encodeBigint(epochStartTimestampMs),
      'extra_fields': config.encodeMessage(extraFields),
    };
  }

  factory SuiSystemState.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSystemState(
      version: json.valueAsBigInt<BigInt?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      protocolVersion: json.valueAsBigInt<BigInt?>(
        'protocol_version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      validators: json.valueTo<SuiValidatorSet?, Object>(
        key: 'validators',
        parse:
            (v) =>
                SuiValidatorSet.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storageFund: json.valueTo<SuiStorageFund?, Object>(
        key: 'storage_fund',
        parse:
            (v) =>
                SuiStorageFund.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      parameters: json.valueTo<SuiSystemParameters?, Object>(
        key: 'parameters',
        parse:
            (v) => SuiSystemParameters.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      referenceGasPrice: json.valueAsBigInt<BigInt?>(
        'reference_gas_price',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      validatorReportRecords:
          (json.valueEnsureAsList<dynamic>(
                'validator_report_records',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiValidatorReportRecord, Object>(
                  value: e,
                  parse:
                      (v) => SuiValidatorReportRecord.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      stakeSubsidy: json.valueTo<SuiStakeSubsidy?, Object>(
        key: 'stake_subsidy',
        parse:
            (v) =>
                SuiStakeSubsidy.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      safeMode: json.valueAsBool<bool?>(
        'safe_mode',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      safeModeStorageRewards: json.valueAsBigInt<BigInt?>(
        'safe_mode_storage_rewards',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      safeModeComputationRewards: json.valueAsBigInt<BigInt?>(
        'safe_mode_computation_rewards',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      safeModeStorageRebates: json.valueAsBigInt<BigInt?>(
        'safe_mode_storage_rebates',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      safeModeNonRefundableStorageFee: json.valueAsBigInt<BigInt?>(
        'safe_mode_non_refundable_storage_fee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      epochStartTimestampMs: json.valueAsBigInt<BigInt?>(
        'epoch_start_timestamp_ms',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      extraFields: json.valueTo<SuiMoveTable?, Object>(
        key: 'extra_fields',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiSystemState.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSystemState(
      version: decode.getBigInt<BigInt?>(1),
      epoch: decode.getBigInt<BigInt?>(2),
      protocolVersion: decode.getBigInt<BigInt?>(3),
      validators: decode.messageTo<SuiValidatorSet?>(
        4,
        (b) => SuiValidatorSet.deserialize(b),
      ),
      storageFund: decode.messageTo<SuiStorageFund?>(
        5,
        (b) => SuiStorageFund.deserialize(b),
      ),
      parameters: decode.messageTo<SuiSystemParameters?>(
        6,
        (b) => SuiSystemParameters.deserialize(b),
      ),
      referenceGasPrice: decode.getBigInt<BigInt?>(7),
      validatorReportRecords:
          decode
              .getListOfBytes(8)
              .map((b) => SuiValidatorReportRecord.deserialize(b))
              .toList(),
      stakeSubsidy: decode.messageTo<SuiStakeSubsidy?>(
        9,
        (b) => SuiStakeSubsidy.deserialize(b),
      ),
      safeMode: decode.getBool<bool?>(10),
      safeModeStorageRewards: decode.getBigInt<BigInt?>(11),
      safeModeComputationRewards: decode.getBigInt<BigInt?>(12),
      safeModeStorageRebates: decode.getBigInt<BigInt?>(13),
      safeModeNonRefundableStorageFee: decode.getBigInt<BigInt?>(14),
      epochStartTimestampMs: decode.getBigInt<BigInt?>(15),
      extraFields: decode.messageTo<SuiMoveTable?>(
        16,
        (b) => SuiMoveTable.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SystemState;
}

class SuiValidatorReportRecord extends SuiProtoMessage {
  /// The address of the validator being reported
  final String? reported;

  /// The list of validator (addresses) that are reporting on the validator specified by `reported`
  final List<String> reporters;

  const SuiValidatorReportRecord({this.reported, this.reporters = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.string,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [reported, reporters];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'reported': reported,
      'reporters': reporters.map((e) => e).toList(),
    };
  }

  factory SuiValidatorReportRecord.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiValidatorReportRecord(
      reported: json.valueAsString<String?>(
        'reported',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      reporters:
          (json.valueEnsureAsList<dynamic>(
            'reporters',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsString<String>(e)).toList(),
    );
  }

  factory SuiValidatorReportRecord.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiValidatorReportRecord(
      reported: decode.getString<String?>(1),
      reporters: decode.getListOrEmpty<String>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ValidatorReportRecord;
}

class SuiSystemParameters extends SuiProtoMessage {
  /// The duration of an epoch, in milliseconds.
  final BigInt? epochDurationMs;

  /// The starting epoch in which stake subsidies start being paid out
  final BigInt? stakeSubsidyStartEpoch;

  /// Minimum number of active validators at any moment.
  final BigInt? minValidatorCount;

  /// Maximum number of active validators at any moment.
  /// We do not allow the number of validators in any epoch to go above this.
  final BigInt? maxValidatorCount;

  /// Deprecated.
  /// Lower-bound on the amount of stake required to become a validator.
  final BigInt? minValidatorJoiningStake;

  /// Deprecated.
  /// Validators with stake amount below `validator_low_stake_threshold` are considered to
  /// have low stake and will be escorted out of the validator set after being below this
  /// threshold for more than `validator_low_stake_grace_period` number of epochs.
  final BigInt? validatorLowStakeThreshold;

  /// Deprecated.
  /// Validators with stake below `validator_very_low_stake_threshold` will be removed
  /// immediately at epoch change, no grace period.
  final BigInt? validatorVeryLowStakeThreshold;

  /// A validator can have stake below `validator_low_stake_threshold`
  /// for this many epochs before being kicked out.
  final BigInt? validatorLowStakeGracePeriod;

  /// Any extra fields that are not defined statically.
  final SuiMoveTable? extraFields;

  const SuiSystemParameters({
    this.epochDurationMs,
    this.stakeSubsidyStartEpoch,
    this.minValidatorCount,
    this.maxValidatorCount,
    this.minValidatorJoiningStake,
    this.validatorLowStakeThreshold,
    this.validatorVeryLowStakeThreshold,
    this.validatorLowStakeGracePeriod,
    this.extraFields,
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
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(5, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(6, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(7, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(8, hasOptionalFlags: true),
        ProtoFieldConfig.message(9, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    epochDurationMs,
    stakeSubsidyStartEpoch,
    minValidatorCount,
    maxValidatorCount,
    minValidatorJoiningStake,
    validatorLowStakeThreshold,
    validatorVeryLowStakeThreshold,
    validatorLowStakeGracePeriod,
    extraFields,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'epoch_duration_ms': config.encodeBigint(epochDurationMs),
      'stake_subsidy_start_epoch': config.encodeBigint(stakeSubsidyStartEpoch),
      'min_validator_count': config.encodeBigint(minValidatorCount),
      'max_validator_count': config.encodeBigint(maxValidatorCount),
      'min_validator_joining_stake': config.encodeBigint(
        minValidatorJoiningStake,
      ),
      'validator_low_stake_threshold': config.encodeBigint(
        validatorLowStakeThreshold,
      ),
      'validator_very_low_stake_threshold': config.encodeBigint(
        validatorVeryLowStakeThreshold,
      ),
      'validator_low_stake_grace_period': config.encodeBigint(
        validatorLowStakeGracePeriod,
      ),
      'extra_fields': config.encodeMessage(extraFields),
    };
  }

  factory SuiSystemParameters.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSystemParameters(
      epochDurationMs: json.valueAsBigInt<BigInt?>(
        'epoch_duration_ms',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakeSubsidyStartEpoch: json.valueAsBigInt<BigInt?>(
        'stake_subsidy_start_epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      minValidatorCount: json.valueAsBigInt<BigInt?>(
        'min_validator_count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxValidatorCount: json.valueAsBigInt<BigInt?>(
        'max_validator_count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      minValidatorJoiningStake: json.valueAsBigInt<BigInt?>(
        'min_validator_joining_stake',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      validatorLowStakeThreshold: json.valueAsBigInt<BigInt?>(
        'validator_low_stake_threshold',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      validatorVeryLowStakeThreshold: json.valueAsBigInt<BigInt?>(
        'validator_very_low_stake_threshold',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      validatorLowStakeGracePeriod: json.valueAsBigInt<BigInt?>(
        'validator_low_stake_grace_period',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      extraFields: json.valueTo<SuiMoveTable?, Object>(
        key: 'extra_fields',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiSystemParameters.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSystemParameters(
      epochDurationMs: decode.getBigInt<BigInt?>(1),
      stakeSubsidyStartEpoch: decode.getBigInt<BigInt?>(2),
      minValidatorCount: decode.getBigInt<BigInt?>(3),
      maxValidatorCount: decode.getBigInt<BigInt?>(4),
      minValidatorJoiningStake: decode.getBigInt<BigInt?>(5),
      validatorLowStakeThreshold: decode.getBigInt<BigInt?>(6),
      validatorVeryLowStakeThreshold: decode.getBigInt<BigInt?>(7),
      validatorLowStakeGracePeriod: decode.getBigInt<BigInt?>(8),
      extraFields: decode.messageTo<SuiMoveTable?>(
        9,
        (b) => SuiMoveTable.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SystemParameters;
}

/// A message that represents a Move `0x2::table::Table` or `0x2::bag::Bag`
class SuiMoveTable extends SuiProtoMessage {
  /// The UID of the table or bag
  final String? id;

  /// The size or number of key-value pairs in the table or bag
  final BigInt? size;

  const SuiMoveTable({this.id, this.size});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [id, size];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'id': id, 'size': config.encodeBigint(size)};
  }

  factory SuiMoveTable.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiMoveTable(
      id: json.valueAsString<String?>(
        'id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      size: json.valueAsBigInt<BigInt?>(
        'size',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiMoveTable.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMoveTable(
      id: decode.getString<String?>(1),
      size: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2MoveTable;
}

class SuiStakeSubsidy extends SuiProtoMessage {
  /// Balance of SUI set aside for stake subsidies that will be drawn down over time.
  final BigInt? balance;

  /// Count of the number of times stake subsidies have been distributed.
  final BigInt? distributionCounter;

  /// The amount of stake subsidy to be drawn down per distribution.
  /// This amount decays and decreases over time.
  final BigInt? currentDistributionAmount;

  /// Number of distributions to occur before the distribution amount decays.
  final BigInt? stakeSubsidyPeriodLength;

  /// The rate at which the distribution amount decays at the end of each
  /// period. Expressed in basis points.
  final int? stakeSubsidyDecreaseRate;

  /// Any extra fields that's not defined statically.
  final SuiMoveTable? extraFields;

  const SuiStakeSubsidy({
    this.balance,
    this.distributionCounter,
    this.currentDistributionAmount,
    this.stakeSubsidyPeriodLength,
    this.stakeSubsidyDecreaseRate,
    this.extraFields,
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
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(5, hasOptionalFlags: true),
        ProtoFieldConfig.message(6, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    balance,
    distributionCounter,
    currentDistributionAmount,
    stakeSubsidyPeriodLength,
    stakeSubsidyDecreaseRate,
    extraFields,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'balance': config.encodeBigint(balance),
      'distribution_counter': config.encodeBigint(distributionCounter),
      'current_distribution_amount': config.encodeBigint(
        currentDistributionAmount,
      ),
      'stake_subsidy_period_length': config.encodeBigint(
        stakeSubsidyPeriodLength,
      ),
      'stake_subsidy_decrease_rate': stakeSubsidyDecreaseRate,
      'extra_fields': config.encodeMessage(extraFields),
    };
  }

  factory SuiStakeSubsidy.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiStakeSubsidy(
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      distributionCounter: json.valueAsBigInt<BigInt?>(
        'distribution_counter',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      currentDistributionAmount: json.valueAsBigInt<BigInt?>(
        'current_distribution_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakeSubsidyPeriodLength: json.valueAsBigInt<BigInt?>(
        'stake_subsidy_period_length',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakeSubsidyDecreaseRate: json.valueAsInt<int?>(
        'stake_subsidy_decrease_rate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      extraFields: json.valueTo<SuiMoveTable?, Object>(
        key: 'extra_fields',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiStakeSubsidy.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiStakeSubsidy(
      balance: decode.getBigInt<BigInt?>(1),
      distributionCounter: decode.getBigInt<BigInt?>(2),
      currentDistributionAmount: decode.getBigInt<BigInt?>(3),
      stakeSubsidyPeriodLength: decode.getBigInt<BigInt?>(4),
      stakeSubsidyDecreaseRate: decode.getInt<int?>(5),
      extraFields: decode.messageTo<SuiMoveTable?>(
        6,
        (b) => SuiMoveTable.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2StakeSubsidy;
}

/// Struct representing the onchain storage fund.
class SuiStorageFund extends SuiProtoMessage {
  /// This is the sum of `storage_rebate` of
  /// all objects currently stored on-chain. To maintain this invariant, the only inflow of this
  /// balance is storage charges collected from transactions, and the only outflow is storage rebates
  /// of transactions, including both the portion refunded to the transaction senders as well as
  /// the non-refundable portion taken out and put into `non_refundable_balance`.
  final BigInt? totalObjectStorageRebates;

  /// Represents any remaining inflow of the storage fund that should not
  /// be taken out of the fund.
  final BigInt? nonRefundableBalance;

  const SuiStorageFund({
    this.totalObjectStorageRebates,
    this.nonRefundableBalance,
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
    totalObjectStorageRebates,
    nonRefundableBalance,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'total_object_storage_rebates': config.encodeBigint(
        totalObjectStorageRebates,
      ),
      'non_refundable_balance': config.encodeBigint(nonRefundableBalance),
    };
  }

  factory SuiStorageFund.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiStorageFund(
      totalObjectStorageRebates: json.valueAsBigInt<BigInt?>(
        'total_object_storage_rebates',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nonRefundableBalance: json.valueAsBigInt<BigInt?>(
        'non_refundable_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiStorageFund.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiStorageFund(
      totalObjectStorageRebates: decode.getBigInt<BigInt?>(1),
      nonRefundableBalance: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2StorageFund;
}

class SuiValidatorSet extends SuiProtoMessage {
  /// Total amount of stake from all active validators at the beginning of the epoch.
  /// Written only once per epoch, in `advance_epoch` function.
  final BigInt? totalStake;

  /// The current list of active validators.
  final List<SuiValidator> activeValidators;

  /// List of new validator candidates added during the current epoch.
  /// They will be processed at the end of the epoch.
  ///
  /// key: u64 (index), value: 0x3::validator::Validator
  final SuiMoveTable? pendingActiveValidators;

  /// Removal requests from the validators. Each element is an index
  /// pointing to `active_validators`.
  final List<BigInt> pendingRemovals;

  /// Mappings from staking pool's ID to the sui address of a validator.
  ///
  /// key: address (staking pool Id), value: address (sui address of the validator)
  final SuiMoveTable? stakingPoolMappings;

  /// Mapping from a staking pool ID to the inactive validator that has that pool as its staking pool.
  /// When a validator is deactivated the validator is removed from `active_validators` it
  /// is added to this table so that stakers can continue to withdraw their stake from it.
  ///
  /// key: address (staking pool Id), value: 0x3::validator_wrapper::ValidatorWrapper
  final SuiMoveTable? inactiveValidators;

  /// Table storing preactive/candidate validators, mapping their addresses to their `Validator ` structs.
  /// When an address calls `request_add_validator_candidate`, they get added to this table and become a preactive
  /// validator.
  /// When the candidate has met the min stake requirement, they can call `request_add_validator` to
  /// officially add them to the active validator set `active_validators` next epoch.
  ///
  /// key: address (sui address of the validator), value: 0x3::validator_wrapper::ValidatorWrapper
  final SuiMoveTable? validatorCandidates;

  /// Table storing the number of epochs during which a validator's stake has been below the low stake threshold.
  final Map<String, BigInt> atRiskValidators;

  /// Any extra fields that's not defined statically.
  final SuiMoveTable? extraFields;

  const SuiValidatorSet({
    this.totalStake,
    this.activeValidators = const [],
    this.pendingActiveValidators,
    this.pendingRemovals = const [],
    this.stakingPoolMappings,
    this.inactiveValidators,
    this.validatorCandidates,
    this.atRiskValidators = const {},
    this.extraFields,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.uint64,
        ),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
        ProtoFieldConfig.message(6, hasOptionalFlags: true),
        ProtoFieldConfig.message(7, hasOptionalFlags: true),
        ProtoFieldConfig.map(
          fieldNumber: 8,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.uint64,
        ),
        ProtoFieldConfig.message(9, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    totalStake,
    activeValidators,
    pendingActiveValidators,
    pendingRemovals,
    stakingPoolMappings,
    inactiveValidators,
    validatorCandidates,
    atRiskValidators,
    extraFields,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'total_stake': config.encodeBigint(totalStake),
      'active_validators':
          activeValidators.map((e) => config.encodeMessage(e)).toList(),
      'pending_active_validators': config.encodeMessage(
        pendingActiveValidators,
      ),
      'pending_removals':
          pendingRemovals.map((e) => config.encodeBigint(e)).toList(),
      'staking_pool_mappings': config.encodeMessage(stakingPoolMappings),
      'inactive_validators': config.encodeMessage(inactiveValidators),
      'validator_candidates': config.encodeMessage(validatorCandidates),
      'at_risk_validators': config.encodeMap(
        atRiskValidators,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'extra_fields': config.encodeMessage(extraFields),
    };
  }

  factory SuiValidatorSet.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiValidatorSet(
      totalStake: json.valueAsBigInt<BigInt?>(
        'total_stake',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      activeValidators:
          (json.valueEnsureAsList<dynamic>(
                'active_validators',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiValidator, Object>(
                  value: e,
                  parse:
                      (v) => SuiValidator.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      pendingActiveValidators: json.valueTo<SuiMoveTable?, Object>(
        key: 'pending_active_validators',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pendingRemovals:
          (json.valueEnsureAsList<dynamic>(
            'pending_removals',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
      stakingPoolMappings: json.valueTo<SuiMoveTable?, Object>(
        key: 'staking_pool_mappings',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      inactiveValidators: json.valueTo<SuiMoveTable?, Object>(
        key: 'inactive_validators',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      validatorCandidates: json.valueTo<SuiMoveTable?, Object>(
        key: 'validator_candidates',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      atRiskValidators: config.decodeMap(
        json.valueAs(
          'at_risk_validators',
          normalizeKeyLookup: config.normalizeKeys,
        ),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      extraFields: json.valueTo<SuiMoveTable?, Object>(
        key: 'extra_fields',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiValidatorSet.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiValidatorSet(
      totalStake: decode.getBigInt<BigInt?>(1),
      activeValidators:
          decode
              .getListOfBytes(2)
              .map((b) => SuiValidator.deserialize(b))
              .toList(),
      pendingActiveValidators: decode.messageTo<SuiMoveTable?>(
        3,
        (b) => SuiMoveTable.deserialize(b),
      ),
      pendingRemovals: decode.getListOrEmpty<BigInt>(4),
      stakingPoolMappings: decode.messageTo<SuiMoveTable?>(
        5,
        (b) => SuiMoveTable.deserialize(b),
      ),
      inactiveValidators: decode.messageTo<SuiMoveTable?>(
        6,
        (b) => SuiMoveTable.deserialize(b),
      ),
      validatorCandidates: decode.messageTo<SuiMoveTable?>(
        7,
        (b) => SuiMoveTable.deserialize(b),
      ),
      atRiskValidators: decode.getMap<String, BigInt>(8),
      extraFields: decode.messageTo<SuiMoveTable?>(
        9,
        (b) => SuiMoveTable.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ValidatorSet;
}

/// Definition of a Validator in the system contracts
///
/// Note: fields of ValidatorMetadata are flattened into this type
class SuiValidator extends SuiProtoMessage {
  /// A unique human-readable name of this validator.
  final String? name;

  /// The Sui Address of the validator. This is the sender that created the Validator object,
  /// and also the address to send validator/coins to during withdraws.
  final String? address;

  final String? description;

  final String? imageUrl;

  final String? projectUrl;

  /// Reserve field for protocol key scheme
  /// The public key bytes corresponding to the private key that the validator
  /// holds to sign transactions. For now, this is the same as AuthorityName.
  final BuBytes? protocolPublicKey;

  /// This is a proof that the validator has ownership of the protocol private key
  final BuBytes? proofOfPossession;

  /// Reserve field for network key scheme
  /// The public key bytes corresponding to the private key that the validator
  /// uses to establish TLS connections
  final BuBytes? networkPublicKey;

  /// Reserve field for worker key scheme
  /// The public key bytes corresponding to the Narwhal Worker
  final BuBytes? workerPublicKey;

  /// The network address of the validator (could also contain extra info such as port, DNS and etc.).
  final String? networkAddress;

  /// The address of the validator used for p2p activities such as state sync (could also contain extra info such as port, DNS and etc.).
  final String? p2pAddress;

  /// The address of the narwhal primary
  final String? primaryAddress;

  /// The address of the narwhal worker
  final String? workerAddress;

  /// "next_epoch" metadata only takes effects in the next epoch.
  /// If none, current value will stay unchanged.
  /// Reserve field for protocol key scheme
  final BuBytes? nextEpochProtocolPublicKey;

  final BuBytes? nextEpochProofOfPossession;

  /// Reserve field for network key scheme
  final BuBytes? nextEpochNetworkPublicKey;

  /// Reserve field for worker key scheme
  final BuBytes? nextEpochWorkerPublicKey;

  final String? nextEpochNetworkAddress;

  final String? nextEpochP2pAddress;

  final String? nextEpochPrimaryAddress;

  final String? nextEpochWorkerAddress;

  /// Any extra fields that's not defined statically in the `ValidatorMetadata` struct
  final SuiMoveTable? metadataExtraFields;

  /// The voting power of this validator, which might be different from its
  /// stake amount.
  final BigInt? votingPower;

  /// The ID of this validator's current valid `UnverifiedValidatorOperationCap`
  final String? operationCapId;

  /// Gas price quote, updated only at end of epoch.
  final BigInt? gasPrice;

  /// Staking pool for this validator.
  final SuiStakingPool? stakingPool;

  /// Commission rate of the validator, in basis point.
  final BigInt? commissionRate;

  /// Total amount of stake that would be active in the next epoch.
  final BigInt? nextEpochStake;

  /// This validator's gas price quote for the next epoch.
  final BigInt? nextEpochGasPrice;

  /// The commission rate of the validator starting the next epoch, in basis point.
  final BigInt? nextEpochCommissionRate;

  /// Any extra fields that's not defined statically.
  final SuiMoveTable? extraFields;

  SuiValidator({
    this.name,
    this.address,
    this.description,
    this.imageUrl,
    this.projectUrl,
    List<int>? protocolPublicKey,
    List<int>? proofOfPossession,
    List<int>? networkPublicKey,
    List<int>? workerPublicKey,
    this.networkAddress,
    this.p2pAddress,
    this.primaryAddress,
    this.workerAddress,
    List<int>? nextEpochProtocolPublicKey,
    List<int>? nextEpochProofOfPossession,
    List<int>? nextEpochNetworkPublicKey,
    List<int>? nextEpochWorkerPublicKey,
    this.nextEpochNetworkAddress,
    this.nextEpochP2pAddress,
    this.nextEpochPrimaryAddress,
    this.nextEpochWorkerAddress,
    this.metadataExtraFields,
    this.votingPower,
    this.operationCapId,
    this.gasPrice,
    this.stakingPool,
    this.commissionRate,
    this.nextEpochStake,
    this.nextEpochGasPrice,
    this.nextEpochCommissionRate,
    this.extraFields,
  }) : protocolPublicKey = protocolPublicKey?.asImmutableBytes,
       proofOfPossession = proofOfPossession?.asImmutableBytes,
       networkPublicKey = networkPublicKey?.asImmutableBytes,
       workerPublicKey = workerPublicKey?.asImmutableBytes,
       nextEpochProtocolPublicKey =
           nextEpochProtocolPublicKey?.asImmutableBytes,
       nextEpochProofOfPossession =
           nextEpochProofOfPossession?.asImmutableBytes,
       nextEpochNetworkPublicKey = nextEpochNetworkPublicKey?.asImmutableBytes,
       nextEpochWorkerPublicKey = nextEpochWorkerPublicKey?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(7, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(8, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(10, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(12, hasOptionalFlags: true),
        ProtoFieldConfig.string(13, hasOptionalFlags: true),
        ProtoFieldConfig.string(14, hasOptionalFlags: true),
        ProtoFieldConfig.string(15, hasOptionalFlags: true),
        ProtoFieldConfig.string(16, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(18, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(19, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(21, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(23, hasOptionalFlags: true),
        ProtoFieldConfig.string(24, hasOptionalFlags: true),
        ProtoFieldConfig.string(25, hasOptionalFlags: true),
        ProtoFieldConfig.string(26, hasOptionalFlags: true),
        ProtoFieldConfig.string(27, hasOptionalFlags: true),
        ProtoFieldConfig.message(28, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(29, hasOptionalFlags: true),
        ProtoFieldConfig.string(30, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(31, hasOptionalFlags: true),
        ProtoFieldConfig.message(32, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(33, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(34, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(35, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(36, hasOptionalFlags: true),
        ProtoFieldConfig.message(37, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    name,
    address,
    description,
    imageUrl,
    projectUrl,
    protocolPublicKey,
    proofOfPossession,
    networkPublicKey,
    workerPublicKey,
    networkAddress,
    p2pAddress,
    primaryAddress,
    workerAddress,
    nextEpochProtocolPublicKey,
    nextEpochProofOfPossession,
    nextEpochNetworkPublicKey,
    nextEpochWorkerPublicKey,
    nextEpochNetworkAddress,
    nextEpochP2pAddress,
    nextEpochPrimaryAddress,
    nextEpochWorkerAddress,
    metadataExtraFields,
    votingPower,
    operationCapId,
    gasPrice,
    stakingPool,
    commissionRate,
    nextEpochStake,
    nextEpochGasPrice,
    nextEpochCommissionRate,
    extraFields,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'name': name,
      'address': address,
      'description': description,
      'image_url': imageUrl,
      'project_url': projectUrl,
      'protocol_public_key': config.encodeBinary(protocolPublicKey),
      'proof_of_possession': config.encodeBinary(proofOfPossession),
      'network_public_key': config.encodeBinary(networkPublicKey),
      'worker_public_key': config.encodeBinary(workerPublicKey),
      'network_address': networkAddress,
      'p2p_address': p2pAddress,
      'primary_address': primaryAddress,
      'worker_address': workerAddress,
      'next_epoch_protocol_public_key': config.encodeBinary(
        nextEpochProtocolPublicKey,
      ),
      'next_epoch_proof_of_possession': config.encodeBinary(
        nextEpochProofOfPossession,
      ),
      'next_epoch_network_public_key': config.encodeBinary(
        nextEpochNetworkPublicKey,
      ),
      'next_epoch_worker_public_key': config.encodeBinary(
        nextEpochWorkerPublicKey,
      ),
      'next_epoch_network_address': nextEpochNetworkAddress,
      'next_epoch_p2p_address': nextEpochP2pAddress,
      'next_epoch_primary_address': nextEpochPrimaryAddress,
      'next_epoch_worker_address': nextEpochWorkerAddress,
      'metadata_extra_fields': config.encodeMessage(metadataExtraFields),
      'voting_power': config.encodeBigint(votingPower),
      'operation_cap_id': operationCapId,
      'gas_price': config.encodeBigint(gasPrice),
      'staking_pool': config.encodeMessage(stakingPool),
      'commission_rate': config.encodeBigint(commissionRate),
      'next_epoch_stake': config.encodeBigint(nextEpochStake),
      'next_epoch_gas_price': config.encodeBigint(nextEpochGasPrice),
      'next_epoch_commission_rate': config.encodeBigint(
        nextEpochCommissionRate,
      ),
      'extra_fields': config.encodeMessage(extraFields),
    };
  }

  factory SuiValidator.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiValidator(
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      address: json.valueAsString<String?>(
        'address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      description: json.valueAsString<String?>(
        'description',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      imageUrl: json.valueAsString<String?>(
        'image_url',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      projectUrl: json.valueAsString<String?>(
        'project_url',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      protocolPublicKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'protocol_public_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      proofOfPossession: config.decodeBinary<List<int>?>(
        json.valueAs(
          'proof_of_possession',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      networkPublicKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'network_public_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      workerPublicKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'worker_public_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      networkAddress: json.valueAsString<String?>(
        'network_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      p2pAddress: json.valueAsString<String?>(
        'p2p_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      primaryAddress: json.valueAsString<String?>(
        'primary_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      workerAddress: json.valueAsString<String?>(
        'worker_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nextEpochProtocolPublicKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'next_epoch_protocol_public_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      nextEpochProofOfPossession: config.decodeBinary<List<int>?>(
        json.valueAs(
          'next_epoch_proof_of_possession',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      nextEpochNetworkPublicKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'next_epoch_network_public_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      nextEpochWorkerPublicKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'next_epoch_worker_public_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      nextEpochNetworkAddress: json.valueAsString<String?>(
        'next_epoch_network_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nextEpochP2pAddress: json.valueAsString<String?>(
        'next_epoch_p2p_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nextEpochPrimaryAddress: json.valueAsString<String?>(
        'next_epoch_primary_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nextEpochWorkerAddress: json.valueAsString<String?>(
        'next_epoch_worker_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      metadataExtraFields: json.valueTo<SuiMoveTable?, Object>(
        key: 'metadata_extra_fields',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      votingPower: json.valueAsBigInt<BigInt?>(
        'voting_power',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      operationCapId: json.valueAsString<String?>(
        'operation_cap_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      gasPrice: json.valueAsBigInt<BigInt?>(
        'gas_price',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakingPool: json.valueTo<SuiStakingPool?, Object>(
        key: 'staking_pool',
        parse:
            (v) =>
                SuiStakingPool.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      commissionRate: json.valueAsBigInt<BigInt?>(
        'commission_rate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nextEpochStake: json.valueAsBigInt<BigInt?>(
        'next_epoch_stake',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nextEpochGasPrice: json.valueAsBigInt<BigInt?>(
        'next_epoch_gas_price',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nextEpochCommissionRate: json.valueAsBigInt<BigInt?>(
        'next_epoch_commission_rate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      extraFields: json.valueTo<SuiMoveTable?, Object>(
        key: 'extra_fields',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiValidator.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiValidator(
      name: decode.getString<String?>(1),
      address: decode.getString<String?>(2),
      description: decode.getString<String?>(3),
      imageUrl: decode.getString<String?>(4),
      projectUrl: decode.getString<String?>(5),
      protocolPublicKey: decode.getBytes<List<int>?>(7),
      proofOfPossession: decode.getBytes<List<int>?>(8),
      networkPublicKey: decode.getBytes<List<int>?>(10),
      workerPublicKey: decode.getBytes<List<int>?>(12),
      networkAddress: decode.getString<String?>(13),
      p2pAddress: decode.getString<String?>(14),
      primaryAddress: decode.getString<String?>(15),
      workerAddress: decode.getString<String?>(16),
      nextEpochProtocolPublicKey: decode.getBytes<List<int>?>(18),
      nextEpochProofOfPossession: decode.getBytes<List<int>?>(19),
      nextEpochNetworkPublicKey: decode.getBytes<List<int>?>(21),
      nextEpochWorkerPublicKey: decode.getBytes<List<int>?>(23),
      nextEpochNetworkAddress: decode.getString<String?>(24),
      nextEpochP2pAddress: decode.getString<String?>(25),
      nextEpochPrimaryAddress: decode.getString<String?>(26),
      nextEpochWorkerAddress: decode.getString<String?>(27),
      metadataExtraFields: decode.messageTo<SuiMoveTable?>(
        28,
        (b) => SuiMoveTable.deserialize(b),
      ),
      votingPower: decode.getBigInt<BigInt?>(29),
      operationCapId: decode.getString<String?>(30),
      gasPrice: decode.getBigInt<BigInt?>(31),
      stakingPool: decode.messageTo<SuiStakingPool?>(
        32,
        (b) => SuiStakingPool.deserialize(b),
      ),
      commissionRate: decode.getBigInt<BigInt?>(33),
      nextEpochStake: decode.getBigInt<BigInt?>(34),
      nextEpochGasPrice: decode.getBigInt<BigInt?>(35),
      nextEpochCommissionRate: decode.getBigInt<BigInt?>(36),
      extraFields: decode.messageTo<SuiMoveTable?>(
        37,
        (b) => SuiMoveTable.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Validator;
}

/// A staking pool embedded in each validator struct in the system state object.
class SuiStakingPool extends SuiProtoMessage {
  /// UID of the StakingPool object
  final String? id;

  /// The epoch at which this pool became active.
  /// The value is `None` if the pool is pre-active and `Some(&lt;epoch_number&gt;)` if active or inactive.
  final BigInt? activationEpoch;

  /// The epoch at which this staking pool ceased to be active. `None` = {pre-active, active},
  /// `Some(&lt;epoch_number&gt;)` if in-active, and it was de-activated at epoch `&lt;epoch_number&gt;`.
  final BigInt? deactivationEpoch;

  /// The total number of SUI tokens in this pool, including the SUI in the rewards_pool, as well as in all the principal
  /// in the `StakedSui` object, updated at epoch boundaries.
  final BigInt? suiBalance;

  /// The epoch stake rewards will be added here at the end of each epoch.
  final BigInt? rewardsPool;

  /// Total number of pool tokens issued by the pool.
  final BigInt? poolTokenBalance;

  /// Exchange rate history of previous epochs.
  ///
  /// The entries start from the `activation_epoch` of this pool and contains exchange rates at the beginning of each epoch,
  /// i.e., right after the rewards for the previous epoch have been deposited into the pool.
  ///
  /// key: u64 (epoch number), value: PoolTokenExchangeRate
  final SuiMoveTable? exchangeRates;

  /// Pending stake amount for this epoch, emptied at epoch boundaries.
  final BigInt? pendingStake;

  /// Pending stake withdrawn during the current epoch, emptied at epoch boundaries.
  /// This includes both the principal and rewards SUI withdrawn.
  final BigInt? pendingTotalSuiWithdraw;

  /// Pending pool token withdrawn during the current epoch, emptied at epoch boundaries.
  final BigInt? pendingPoolTokenWithdraw;

  /// Any extra fields that's not defined statically.
  final SuiMoveTable? extraFields;

  const SuiStakingPool({
    this.id,
    this.activationEpoch,
    this.deactivationEpoch,
    this.suiBalance,
    this.rewardsPool,
    this.poolTokenBalance,
    this.exchangeRates,
    this.pendingStake,
    this.pendingTotalSuiWithdraw,
    this.pendingPoolTokenWithdraw,
    this.extraFields,
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
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(5, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(6, hasOptionalFlags: true),
        ProtoFieldConfig.message(7, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(8, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(9, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(10, hasOptionalFlags: true),
        ProtoFieldConfig.message(11, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    id,
    activationEpoch,
    deactivationEpoch,
    suiBalance,
    rewardsPool,
    poolTokenBalance,
    exchangeRates,
    pendingStake,
    pendingTotalSuiWithdraw,
    pendingPoolTokenWithdraw,
    extraFields,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'id': id,
      'activation_epoch': config.encodeBigint(activationEpoch),
      'deactivation_epoch': config.encodeBigint(deactivationEpoch),
      'sui_balance': config.encodeBigint(suiBalance),
      'rewards_pool': config.encodeBigint(rewardsPool),
      'pool_token_balance': config.encodeBigint(poolTokenBalance),
      'exchange_rates': config.encodeMessage(exchangeRates),
      'pending_stake': config.encodeBigint(pendingStake),
      'pending_total_sui_withdraw': config.encodeBigint(
        pendingTotalSuiWithdraw,
      ),
      'pending_pool_token_withdraw': config.encodeBigint(
        pendingPoolTokenWithdraw,
      ),
      'extra_fields': config.encodeMessage(extraFields),
    };
  }

  factory SuiStakingPool.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiStakingPool(
      id: json.valueAsString<String?>(
        'id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      activationEpoch: json.valueAsBigInt<BigInt?>(
        'activation_epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      deactivationEpoch: json.valueAsBigInt<BigInt?>(
        'deactivation_epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      suiBalance: json.valueAsBigInt<BigInt?>(
        'sui_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      rewardsPool: json.valueAsBigInt<BigInt?>(
        'rewards_pool',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      poolTokenBalance: json.valueAsBigInt<BigInt?>(
        'pool_token_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      exchangeRates: json.valueTo<SuiMoveTable?, Object>(
        key: 'exchange_rates',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pendingStake: json.valueAsBigInt<BigInt?>(
        'pending_stake',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pendingTotalSuiWithdraw: json.valueAsBigInt<BigInt?>(
        'pending_total_sui_withdraw',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pendingPoolTokenWithdraw: json.valueAsBigInt<BigInt?>(
        'pending_pool_token_withdraw',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      extraFields: json.valueTo<SuiMoveTable?, Object>(
        key: 'extra_fields',
        parse:
            (v) => SuiMoveTable.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiStakingPool.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiStakingPool(
      id: decode.getString<String?>(1),
      activationEpoch: decode.getBigInt<BigInt?>(2),
      deactivationEpoch: decode.getBigInt<BigInt?>(3),
      suiBalance: decode.getBigInt<BigInt?>(4),
      rewardsPool: decode.getBigInt<BigInt?>(5),
      poolTokenBalance: decode.getBigInt<BigInt?>(6),
      exchangeRates: decode.messageTo<SuiMoveTable?>(
        7,
        (b) => SuiMoveTable.deserialize(b),
      ),
      pendingStake: decode.getBigInt<BigInt?>(8),
      pendingTotalSuiWithdraw: decode.getBigInt<BigInt?>(9),
      pendingPoolTokenWithdraw: decode.getBigInt<BigInt?>(10),
      extraFields: decode.messageTo<SuiMoveTable?>(
        11,
        (b) => SuiMoveTable.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2StakingPool;
}

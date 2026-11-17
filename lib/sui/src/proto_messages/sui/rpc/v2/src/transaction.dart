import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import 'package:on_chain/sui/src/serialization/protobuf/wkt.dart';

import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart"
    as sui_rpc_v2_bcs;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/object_reference.dart"
    as sui_rpc_v2_object_reference;
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/timestamp.dart"
    as google_protobuf_timestamp;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/input.dart"
    as sui_rpc_v2_input;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/argument.dart"
    as sui_rpc_v2_argument;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/object.dart"
    as sui_rpc_v2_object;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/jwk.dart"
    as sui_rpc_v2_jwk;
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/duration.dart"
    as google_protobuf_duration;

enum SuiTransactionExpirationTransactionExpirationKind
    implements ProtoEnumVariant {
  transactionExpirationKindUnknown(0, 'TRANSACTION_EXPIRATION_KIND_UNKNOWN'),

  /// The transaction has no expiration.
  none(1, 'NONE'),

  /// Validators won't sign and execute transaction unless the expiration epoch
  /// is greater than or equal to the current epoch.
  epoch(2, 'EPOCH'),

  /// This variant enables gas payments from address balances.
  ///
  /// When transactions use address balances for gas payment instead of explicit gas coins,
  /// we lose the natural transaction uniqueness and replay prevention that comes from
  /// mutation of gas coin objects.
  ///
  /// By bounding expiration and providing a nonce, validators must only retain
  /// executed digests for the maximum possible expiry range to differentiate
  /// retries from unique transactions with otherwise identical inputs.
  validDuring(3, 'VALID_DURING'),

  /// Everything in VALID_DURING, plus a restriction on which validators may
  /// propose the transaction in consensus.
  validity(4, 'VALIDITY');

  const SuiTransactionExpirationTransactionExpirationKind(
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
  static SuiTransactionExpirationTransactionExpirationKind fromValue(
    int? value,
  ) {
    value ??= 0;
    return SuiTransactionExpirationTransactionExpirationKind.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiTransactionExpirationTransactionExpirationKind found for the given value. $value",
                details: {
                  "name": "SuiTransactionExpirationTransactionExpirationKind",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiTransactionExpirationTransactionExpirationKind from(Object? value) {
    value ??= 0;
    return SuiTransactionExpirationTransactionExpirationKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiTransactionExpirationTransactionExpirationKind found for the given value. $value",
                details: {
                  "name": "SuiTransactionExpirationTransactionExpirationKind",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum SuiTransactionKindKind implements ProtoEnumVariant {
  kindUnknown(0, 'KIND_UNKNOWN'),

  /// A user transaction comprised of a list of native commands and Move calls.
  programmableTransaction(1, 'PROGRAMMABLE_TRANSACTION'),

  /// System Transactions
  /// System transaction used to end an epoch.
  ///
  /// The `ChangeEpoch` variant is now deprecated (but the `ChangeEpoch` struct is still used by
  /// `EndOfEpochTransaction`).
  changeEpoch(2, 'CHANGE_EPOCH'),

  /// Transaction used to initialize the chain state.
  ///
  /// Only valid if in the genesis checkpoint (0) and if this is the very first transaction ever
  /// executed on the chain.
  genesis(3, 'GENESIS'),

  /// V1 consensus commit update.
  consensusCommitPrologueV1(4, 'CONSENSUS_COMMIT_PROLOGUE_V1'),

  /// Update set of valid JWKs used for zklogin.
  authenticatorStateUpdate(5, 'AUTHENTICATOR_STATE_UPDATE'),

  /// Set of operations to run at the end of the epoch to close out the current epoch and start
  /// the next one.
  endOfEpoch(6, 'END_OF_EPOCH'),

  /// Randomness update.
  randomnessStateUpdate(7, 'RANDOMNESS_STATE_UPDATE'),

  /// V2 consensus commit update.
  consensusCommitPrologueV2(8, 'CONSENSUS_COMMIT_PROLOGUE_V2'),

  /// V3 consensus commit update.
  consensusCommitPrologueV3(9, 'CONSENSUS_COMMIT_PROLOGUE_V3'),

  /// V4 consensus commit update.
  consensusCommitPrologueV4(10, 'CONSENSUS_COMMIT_PROLOGUE_V4'),

  /// A system transaction comprised of a list of native commands and Move calls.
  programmableSystemTransaction(11, 'PROGRAMMABLE_SYSTEM_TRANSACTION');

  const SuiTransactionKindKind(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiTransactionKindKind fromValue(int? value) {
    value ??= 0;
    return SuiTransactionKindKind.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiTransactionKindKind found for the given value. $value",
                details: {
                  "name": "SuiTransactionKindKind",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiTransactionKindKind from(Object? value) {
    value ??= 0;
    return SuiTransactionKindKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiTransactionKindKind found for the given value. $value",
                details: {
                  "name": "SuiTransactionKindKind",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum SuiEndOfEpochTransactionKindKind implements ProtoEnumVariant {
  kindUnknown(0, 'KIND_UNKNOWN'),

  /// End the epoch and start the next one.
  changeEpoch(1, 'CHANGE_EPOCH'),

  /// Create and initialize the authenticator object used for zklogin.
  authenticatorStateCreate(2, 'AUTHENTICATOR_STATE_CREATE'),

  /// Expire JWKs used for zklogin.
  authenticatorStateExpire(3, 'AUTHENTICATOR_STATE_EXPIRE'),

  /// Create and initialize the randomness object.
  randomnessStateCreate(4, 'RANDOMNESS_STATE_CREATE'),

  /// Create and initialize the deny list object.
  denyListStateCreate(5, 'DENY_LIST_STATE_CREATE'),

  /// Create and initialize the bridge object.
  bridgeStateCreate(6, 'BRIDGE_STATE_CREATE'),

  /// Initialize the bridge committee.
  bridgeCommitteeInit(7, 'BRIDGE_COMMITTEE_INIT'),

  /// Execution time observations from the committee to preserve cross epoch
  storeExecutionTimeObservations(8, 'STORE_EXECUTION_TIME_OBSERVATIONS'),

  /// Create the accumulator root object.
  accumulatorRootCreate(9, 'ACCUMULATOR_ROOT_CREATE'),

  /// Create and initialize the Coin Registry object.
  coinRegistryCreate(10, 'COIN_REGISTRY_CREATE'),

  /// Create and initialize the Display Registry object.
  displayRegistryCreate(11, 'DISPLAY_REGISTRY_CREATE'),

  /// Create and initialize the Address Alias State object.
  addressAliasStateCreate(12, 'ADDRESS_ALIAS_STATE_CREATE'),

  /// Write the end-of-epoch-computed storage cost for accumulator objects.
  writeAccumulatorStorageCost(13, 'WRITE_ACCUMULATOR_STORAGE_COST'),

  /// Create and initialize the Forwarding Address Registry object.
  forwardingAddressRegistryCreate(14, 'FORWARDING_ADDRESS_REGISTRY_CREATE');

  const SuiEndOfEpochTransactionKindKind(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiEndOfEpochTransactionKindKind fromValue(int? value) {
    value ??= 0;
    return SuiEndOfEpochTransactionKindKind.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiEndOfEpochTransactionKindKind found for the given value. $value",
                details: {
                  "name": "SuiEndOfEpochTransactionKindKind",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiEndOfEpochTransactionKindKind from(Object? value) {
    value ??= 0;
    return SuiEndOfEpochTransactionKindKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiEndOfEpochTransactionKindKind found for the given value. $value",
                details: {
                  "name": "SuiEndOfEpochTransactionKindKind",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum SuiExecutionTimeObservationExecutionTimeObservationKind
    implements ProtoEnumVariant {
  executionTimeObservationKindUnknown(
    0,
    'EXECUTION_TIME_OBSERVATION_KIND_UNKNOWN',
  ),
  moveEntryPoint(1, 'MOVE_ENTRY_POINT'),
  transferObjects(2, 'TRANSFER_OBJECTS'),
  splitCoins(3, 'SPLIT_COINS'),
  mergeCoins(4, 'MERGE_COINS'),
  publish(5, 'PUBLISH'),
  makeMoveVector(6, 'MAKE_MOVE_VECTOR'),
  upgrade(7, 'UPGRADE');

  const SuiExecutionTimeObservationExecutionTimeObservationKind(
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
  static SuiExecutionTimeObservationExecutionTimeObservationKind fromValue(
    int? value,
  ) {
    value ??= 0;
    return SuiExecutionTimeObservationExecutionTimeObservationKind.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiExecutionTimeObservationExecutionTimeObservationKind found for the given value. $value",
                details: {
                  "name":
                      "SuiExecutionTimeObservationExecutionTimeObservationKind",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiExecutionTimeObservationExecutionTimeObservationKind from(
    Object? value,
  ) {
    value ??= 0;
    return SuiExecutionTimeObservationExecutionTimeObservationKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiExecutionTimeObservationExecutionTimeObservationKind found for the given value. $value",
                details: {
                  "name":
                      "SuiExecutionTimeObservationExecutionTimeObservationKind",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// A transaction.
class SuiTransaction extends SuiProtoMessage {
  /// This Transaction serialized as BCS.
  final sui_rpc_v2_bcs.SuiBcs? bcs;

  /// The digest of this Transaction.
  final String? digest;

  /// Version of this Transaction.
  final int? version;

  final SuiTransactionKind? kind;

  final String? sender;

  final SuiGasPayment? gasPayment;

  final SuiTransactionExpiration? expiration;

  const SuiTransaction({
    this.bcs,
    this.digest,
    this.version,
    this.kind,
    this.sender,
    this.gasPayment,
    this.expiration,
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
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
        ProtoFieldConfig.message(6, hasOptionalFlags: true),
        ProtoFieldConfig.message(7, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    bcs,
    digest,
    version,
    kind,
    sender,
    gasPayment,
    expiration,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'bcs': config.encodeMessage(bcs),
      'digest': digest,
      'version': version,
      'kind': config.encodeMessage(kind),
      'sender': sender,
      'gas_payment': config.encodeMessage(gasPayment),
      'expiration': config.encodeMessage(expiration),
    };
  }

  factory SuiTransaction.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiTransaction(
      bcs: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'bcs',
        parse:
            (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      digest: json.valueAsString<String?>(
        'digest',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      version: json.valueAsInt<int?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      kind: json.valueTo<SuiTransactionKind?, Object>(
        key: 'kind',
        parse:
            (v) => SuiTransactionKind.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sender: json.valueAsString<String?>(
        'sender',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      gasPayment: json.valueTo<SuiGasPayment?, Object>(
        key: 'gas_payment',
        parse:
            (v) =>
                SuiGasPayment.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expiration: json.valueTo<SuiTransactionExpiration?, Object>(
        key: 'expiration',
        parse:
            (v) => SuiTransactionExpiration.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiTransaction.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTransaction(
      bcs: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(
        1,
        (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b),
      ),
      digest: decode.getString<String?>(2),
      version: decode.getInt<int?>(3),
      kind: decode.messageTo<SuiTransactionKind?>(
        4,
        (b) => SuiTransactionKind.deserialize(b),
      ),
      sender: decode.getString<String?>(5),
      gasPayment: decode.messageTo<SuiGasPayment?>(
        6,
        (b) => SuiGasPayment.deserialize(b),
      ),
      expiration: decode.messageTo<SuiTransactionExpiration?>(
        7,
        (b) => SuiTransactionExpiration.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Transaction;
}

/// Payment information for executing a transaction.
class SuiGasPayment extends SuiProtoMessage {
  /// Set of gas objects to use for payment.
  final List<sui_rpc_v2_object_reference.SuiObjectReference> objects;

  /// Owner of the gas objects, either the transaction sender or a sponsor.
  final String? owner;

  /// Gas unit price to use when charging for computation.
  ///
  /// Must be greater than or equal to the network's current RGP (reference gas price).
  final BigInt? price;

  /// Total budget willing to spend for the execution of a transaction.
  final BigInt? budget;

  const SuiGasPayment({
    this.objects = const [],
    this.owner,
    this.price,
    this.budget,
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
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [objects, owner, price, budget];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'objects': objects.map((e) => config.encodeMessage(e)).toList(),
      'owner': owner,
      'price': config.encodeBigint(price),
      'budget': config.encodeBigint(budget),
    };
  }

  factory SuiGasPayment.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiGasPayment(
      objects:
          (json.valueEnsureAsList<dynamic>(
                'objects',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  sui_rpc_v2_object_reference.SuiObjectReference,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => sui_rpc_v2_object_reference
                          .SuiObjectReference.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      owner: json.valueAsString<String?>(
        'owner',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      price: json.valueAsBigInt<BigInt?>(
        'price',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      budget: json.valueAsBigInt<BigInt?>(
        'budget',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiGasPayment.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGasPayment(
      objects:
          decode
              .getListOfBytes(1)
              .map(
                (b) => sui_rpc_v2_object_reference
                    .SuiObjectReference.deserialize(b),
              )
              .toList(),
      owner: decode.getString<String?>(2),
      price: decode.getBigInt<BigInt?>(3),
      budget: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2GasPayment;
}

/// A TTL for a transaction.
class SuiTransactionExpiration extends SuiProtoMessage {
  final SuiTransactionExpirationTransactionExpirationKind? kind;

  /// Maximum epoch in which a transaction can be executed. The provided maximal epoch
  /// must be greater than or equal to the current epoch for a transaction to execute.
  final BigInt? epoch;

  /// Minimal epoch in which a transaction can be executed. The provided minimal epoch
  /// must be less than or equal to the current epoch for a transaction to execute.
  final BigInt? minEpoch;

  /// Minimal UNIX timestamp in which a transaction can be executed. The
  /// provided minimal timestamp must be less than or equal to the current
  /// clock.
  final google_protobuf_timestamp.SuiTimestamp? minTimestamp;

  /// Maximum UNIX timestamp in which a transaction can be executed. The
  /// provided maximal timestamp must be greater than or equal to the current
  /// clock.
  final google_protobuf_timestamp.SuiTimestamp? maxTimestamp;

  /// ChainId of the network this transaction is intended for in order to prevent cross-chain replay
  final String? chain;

  /// User-provided uniqueness identifier to differentiate otherwise identical transactions
  final int? nonce;

  /// The validators allowed to propose this transaction in consensus. Only set when `kind`
  /// is `VALIDITY`. Leave unset to let any validator propose the transaction.
  final SuiAllowedProposers? allowedProposers;

  const SuiTransactionExpiration({
    this.kind,
    this.epoch,
    this.minEpoch,
    this.minTimestamp,
    this.maxTimestamp,
    this.chain,
    this.nonce,
    this.allowedProposers,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
        ProtoFieldConfig.string(6, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(7, hasOptionalFlags: true),
        ProtoFieldConfig.message(8, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    kind,
    epoch,
    minEpoch,
    minTimestamp,
    maxTimestamp,
    chain,
    nonce,
    allowedProposers,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'kind': config.encodeEnum(kind),
      'epoch': config.encodeBigint(epoch),
      'min_epoch': config.encodeBigint(minEpoch),
      'min_timestamp': minTimestamp?.toRfc3339(),
      'max_timestamp': maxTimestamp?.toRfc3339(),
      'chain': chain,
      'nonce': nonce,
      'allowed_proposers': config.encodeMessage(allowedProposers),
    };
  }

  factory SuiTransactionExpiration.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiTransactionExpiration(
      kind: json.valueTo<
        SuiTransactionExpirationTransactionExpirationKind?,
        Object?
      >(
        key: 'kind',
        parse: (v) => SuiTransactionExpirationTransactionExpirationKind.from(v),
      ),
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      minEpoch: json.valueAsBigInt<BigInt?>(
        'min_epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      minTimestamp: json
          .valueTo<google_protobuf_timestamp.SuiTimestamp?, Object>(
            key: 'min_timestamp',
            parse:
                (v) => google_protobuf_timestamp.SuiTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      maxTimestamp: json
          .valueTo<google_protobuf_timestamp.SuiTimestamp?, Object>(
            key: 'max_timestamp',
            parse:
                (v) => google_protobuf_timestamp.SuiTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      chain: json.valueAsString<String?>(
        'chain',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nonce: json.valueAsInt<int?>(
        'nonce',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      allowedProposers: json.valueTo<SuiAllowedProposers?, Object>(
        key: 'allowed_proposers',
        parse:
            (v) => SuiAllowedProposers.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiTransactionExpiration.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTransactionExpiration(
      kind: decode.getEnum<SuiTransactionExpirationTransactionExpirationKind?>(
        1,
        SuiTransactionExpirationTransactionExpirationKind.values,
      ),
      epoch: decode.getBigInt<BigInt?>(2),
      minEpoch: decode.getBigInt<BigInt?>(3),
      minTimestamp: decode.messageTo<google_protobuf_timestamp.SuiTimestamp?>(
        4,
        (b) => google_protobuf_timestamp.SuiTimestamp.deserialize(b),
      ),
      maxTimestamp: decode.messageTo<google_protobuf_timestamp.SuiTimestamp?>(
        5,
        (b) => google_protobuf_timestamp.SuiTimestamp.deserialize(b),
      ),
      chain: decode.getString<String?>(6),
      nonce: decode.getInt<int?>(7),
      allowedProposers: decode.messageTo<SuiAllowedProposers?>(
        8,
        (b) => SuiAllowedProposers.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2TransactionExpiration;
}

/// The validators allowed to propose a transaction in consensus.
///
/// Proposal by any other validator is byzantine behavior and invalidates the whole block.
class SuiAllowedProposers extends SuiProtoMessage {
  /// The epoch whose committee `proposers` indexes into.
  ///
  /// Committee indices are only meaningful against one committee, so a set recorded for any
  /// other epoch is ignored and the transaction is treated as naming no proposers.
  final BigInt? epoch;

  /// Committee indices of the allowed proposers, strictly increasing and non-empty.
  ///
  /// An empty list names no validator and is rejected; omit `allowed_proposers` entirely to
  /// let any validator propose the transaction.
  final List<int> proposers;

  const SuiAllowedProposers({this.epoch, this.proposers = const []});

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
          elementType: ProtoFieldType.uint32,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [epoch, proposers];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'epoch': config.encodeBigint(epoch),
      'proposers': proposers.map((e) => e).toList(),
    };
  }

  factory SuiAllowedProposers.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiAllowedProposers(
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      proposers:
          (json.valueEnsureAsList<dynamic>(
            'proposers',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsInt<int>(e)).toList(),
    );
  }

  factory SuiAllowedProposers.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiAllowedProposers(
      epoch: decode.getBigInt<BigInt?>(1),
      proposers: decode.getListOrEmpty<int>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2AllowedProposers;
}

/// Transaction type.
class SuiTransactionKind extends SuiProtoMessage {
  final SuiTransactionKindKind? kind;

  /// A transaction comprised of a list of native commands and Move calls.
  final SuiProgrammableTransaction? programmableTransaction;

  /// System transaction used to end an epoch.
  ///
  /// The `ChangeEpoch` variant is now deprecated (but the `ChangeEpoch` struct is still used by
  /// `EndOfEpochTransaction`).
  final SuiChangeEpoch? changeEpoch;

  /// Transaction used to initialize the chain state.
  ///
  /// Only valid if in the genesis checkpoint (0) and if this is the very first transaction ever
  /// executed on the chain.
  final SuiGenesisTransaction? genesis;

  /// consensus commit update info
  final SuiConsensusCommitPrologue? consensusCommitPrologue;

  /// Update set of valid JWKs used for zklogin.
  final SuiAuthenticatorStateUpdate? authenticatorStateUpdate;

  /// Set of operations to run at the end of the epoch to close out the current epoch and start
  /// the next one.
  final SuiEndOfEpochTransaction? endOfEpoch;

  /// Randomness update.
  final SuiRandomnessStateUpdate? randomnessStateUpdate;

  const SuiTransactionKind({
    this.kind,
    this.programmableTransaction,
    this.changeEpoch,
    this.genesis,
    this.consensusCommitPrologue,
    this.authenticatorStateUpdate,
    this.endOfEpoch,
    this.randomnessStateUpdate,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    kind,
    programmableTransaction,
    changeEpoch,
    genesis,
    consensusCommitPrologue,
    authenticatorStateUpdate,
    endOfEpoch,
    randomnessStateUpdate,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'kind': config.encodeEnum(kind),
      'programmable_transaction': config.encodeMessage(programmableTransaction),
      'change_epoch': config.encodeMessage(changeEpoch),
      'genesis': config.encodeMessage(genesis),
      'consensus_commit_prologue': config.encodeMessage(
        consensusCommitPrologue,
      ),
      'authenticator_state_update': config.encodeMessage(
        authenticatorStateUpdate,
      ),
      'end_of_epoch': config.encodeMessage(endOfEpoch),
      'randomness_state_update': config.encodeMessage(randomnessStateUpdate),
    };
  }

  factory SuiTransactionKind.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiTransactionKind(
      kind: json.valueTo<SuiTransactionKindKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiTransactionKindKind.from(v),
      ),
      programmableTransaction: json
          .valueTo<SuiProgrammableTransaction?, Object>(
            key: 'programmable_transaction',
            parse:
                (v) => SuiProgrammableTransaction.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      changeEpoch: json.valueTo<SuiChangeEpoch?, Object>(
        key: 'change_epoch',
        parse:
            (v) =>
                SuiChangeEpoch.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      genesis: json.valueTo<SuiGenesisTransaction?, Object>(
        key: 'genesis',
        parse:
            (v) => SuiGenesisTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consensusCommitPrologue: json
          .valueTo<SuiConsensusCommitPrologue?, Object>(
            key: 'consensus_commit_prologue',
            parse:
                (v) => SuiConsensusCommitPrologue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      authenticatorStateUpdate: json
          .valueTo<SuiAuthenticatorStateUpdate?, Object>(
            key: 'authenticator_state_update',
            parse:
                (v) => SuiAuthenticatorStateUpdate.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      endOfEpoch: json.valueTo<SuiEndOfEpochTransaction?, Object>(
        key: 'end_of_epoch',
        parse:
            (v) => SuiEndOfEpochTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      randomnessStateUpdate: json.valueTo<SuiRandomnessStateUpdate?, Object>(
        key: 'randomness_state_update',
        parse:
            (v) => SuiRandomnessStateUpdate.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiTransactionKind.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTransactionKind(
      kind: decode.getEnum<SuiTransactionKindKind?>(
        1,
        SuiTransactionKindKind.values,
      ),
      programmableTransaction: decode.messageTo<SuiProgrammableTransaction?>(
        2,
        (b) => SuiProgrammableTransaction.deserialize(b),
      ),
      changeEpoch: decode.messageTo<SuiChangeEpoch?>(
        3,
        (b) => SuiChangeEpoch.deserialize(b),
      ),
      genesis: decode.messageTo<SuiGenesisTransaction?>(
        4,
        (b) => SuiGenesisTransaction.deserialize(b),
      ),
      consensusCommitPrologue: decode.messageTo<SuiConsensusCommitPrologue?>(
        5,
        (b) => SuiConsensusCommitPrologue.deserialize(b),
      ),
      authenticatorStateUpdate: decode.messageTo<SuiAuthenticatorStateUpdate?>(
        6,
        (b) => SuiAuthenticatorStateUpdate.deserialize(b),
      ),
      endOfEpoch: decode.messageTo<SuiEndOfEpochTransaction?>(
        7,
        (b) => SuiEndOfEpochTransaction.deserialize(b),
      ),
      randomnessStateUpdate: decode.messageTo<SuiRandomnessStateUpdate?>(
        8,
        (b) => SuiRandomnessStateUpdate.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2TransactionKind;
}

/// A user transaction.
///
/// Contains a series of native commands and Move calls where the results of one command can be
/// used in future commands.
class SuiProgrammableTransaction extends SuiProtoMessage {
  /// Input objects or primitive values.
  final List<sui_rpc_v2_input.SuiInput> inputs;

  /// The commands to be executed sequentially. A failure in any command
  /// results in the failure of the entire transaction.
  final List<SuiCommand> commands;

  const SuiProgrammableTransaction({
    this.inputs = const [],
    this.commands = const [],
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
  List<Object?> get protoValues => [inputs, commands];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'inputs': inputs.map((e) => config.encodeMessage(e)).toList(),
      'commands': commands.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiProgrammableTransaction.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiProgrammableTransaction(
      inputs:
          (json.valueEnsureAsList<dynamic>(
                'inputs',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<sui_rpc_v2_input.SuiInput, Object>(
                  value: e,
                  parse:
                      (v) => sui_rpc_v2_input.SuiInput.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      commands:
          (json.valueEnsureAsList<dynamic>(
                'commands',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiCommand, Object>(
                  value: e,
                  parse:
                      (v) => SuiCommand.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiProgrammableTransaction.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiProgrammableTransaction(
      inputs:
          decode
              .getListOfBytes(1)
              .map((b) => sui_rpc_v2_input.SuiInput.deserialize(b))
              .toList(),
      commands:
          decode
              .getListOfBytes(2)
              .map((b) => SuiCommand.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ProgrammableTransaction;
}

/// A single command in a programmable transaction.
class SuiCommand extends SuiProtoMessage {
  /// A call to either an entry or a public Move function.
  final SuiMoveCall? moveCall;

  /// `(Vec&lt;forall T:key+store. T&gt;, address)`
  /// It sends n-objects to the specified address. These objects must have store
  /// (public transfer) and either the previous owner must be an address or the object must
  /// be newly created.
  final SuiTransferObjects? transferObjects;

  /// `(&amp;mut Coin&lt;T&gt;, Vec&lt;u64&gt;)` -&gt; `Vec&lt;Coin&lt;T&gt;&gt;`
  /// It splits off some amounts into new coins with those amounts.
  final SuiSplitCoins? splitCoins;

  /// `(&amp;mut Coin&lt;T&gt;, Vec&lt;Coin&lt;T&gt;&gt;)`
  /// It merges n-coins into the first coin.
  final SuiMergeCoins? mergeCoins;

  /// Publishes a Move package. It takes the package bytes and a list of the package's transitive
  /// dependencies to link against on chain.
  final SuiPublish? publish;

  /// `forall T: Vec&lt;T&gt; -&gt; vector&lt;T&gt;`
  /// Given n-values of the same type, it constructs a vector. For non-objects or an empty vector,
  /// the type tag must be specified.
  final SuiMakeMoveVector? makeMoveVector;

  /// Upgrades a Move package.
  /// Takes (in order):
  /// 1. A vector of serialized modules for the package.
  /// 2. A vector of object ids for the transitive dependencies of the new package.
  /// 3. The object ID of the package being upgraded.
  /// 4. An argument holding the `UpgradeTicket` that must have been produced from an earlier command in the same
  /// programmable transaction.
  final SuiUpgrade? upgrade;

  const SuiCommand({
    this.moveCall,
    this.transferObjects,
    this.splitCoins,
    this.mergeCoins,
    this.publish,
    this.makeMoveVector,
    this.upgrade,
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
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    moveCall,
    transferObjects,
    splitCoins,
    mergeCoins,
    publish,
    makeMoveVector,
    upgrade,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'move_call': config.encodeMessage(moveCall),
      'transfer_objects': config.encodeMessage(transferObjects),
      'split_coins': config.encodeMessage(splitCoins),
      'merge_coins': config.encodeMessage(mergeCoins),
      'publish': config.encodeMessage(publish),
      'make_move_vector': config.encodeMessage(makeMoveVector),
      'upgrade': config.encodeMessage(upgrade),
    };
  }

  factory SuiCommand.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiCommand(
      moveCall: json.valueTo<SuiMoveCall?, Object>(
        key: 'move_call',
        parse:
            (v) => SuiMoveCall.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transferObjects: json.valueTo<SuiTransferObjects?, Object>(
        key: 'transfer_objects',
        parse:
            (v) => SuiTransferObjects.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      splitCoins: json.valueTo<SuiSplitCoins?, Object>(
        key: 'split_coins',
        parse:
            (v) =>
                SuiSplitCoins.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      mergeCoins: json.valueTo<SuiMergeCoins?, Object>(
        key: 'merge_coins',
        parse:
            (v) =>
                SuiMergeCoins.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      publish: json.valueTo<SuiPublish?, Object>(
        key: 'publish',
        parse:
            (v) => SuiPublish.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      makeMoveVector: json.valueTo<SuiMakeMoveVector?, Object>(
        key: 'make_move_vector',
        parse:
            (v) => SuiMakeMoveVector.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      upgrade: json.valueTo<SuiUpgrade?, Object>(
        key: 'upgrade',
        parse:
            (v) => SuiUpgrade.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiCommand.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCommand(
      moveCall: decode.messageTo<SuiMoveCall?>(
        1,
        (b) => SuiMoveCall.deserialize(b),
      ),
      transferObjects: decode.messageTo<SuiTransferObjects?>(
        2,
        (b) => SuiTransferObjects.deserialize(b),
      ),
      splitCoins: decode.messageTo<SuiSplitCoins?>(
        3,
        (b) => SuiSplitCoins.deserialize(b),
      ),
      mergeCoins: decode.messageTo<SuiMergeCoins?>(
        4,
        (b) => SuiMergeCoins.deserialize(b),
      ),
      publish: decode.messageTo<SuiPublish?>(
        5,
        (b) => SuiPublish.deserialize(b),
      ),
      makeMoveVector: decode.messageTo<SuiMakeMoveVector?>(
        6,
        (b) => SuiMakeMoveVector.deserialize(b),
      ),
      upgrade: decode.messageTo<SuiUpgrade?>(
        7,
        (b) => SuiUpgrade.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Command;
}

/// Command to call a Move function.
///
/// Functions that can be called by a `MoveCall` command are those that have a function signature
/// that is either `entry` or `public` (which don't have a reference return type).
class SuiMoveCall extends SuiProtoMessage {
  /// The package containing the module and function.
  final String? package;

  /// The specific module in the package containing the function.
  final String? module;

  /// The function to be called.
  final String? function;

  /// The type arguments to the function.
  final List<String> typeArguments;

  /// The arguments to the function.
  final List<sui_rpc_v2_argument.SuiArgument> arguments;

  const SuiMoveCall({
    this.package,
    this.module,
    this.function,
    this.typeArguments = const [],
    this.arguments = const [],
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
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.string,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    package,
    module,
    function,
    typeArguments,
    arguments,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'package': package,
      'module': module,
      'function': function,
      'type_arguments': typeArguments.map((e) => e).toList(),
      'arguments': arguments.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiMoveCall.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiMoveCall(
      package: json.valueAsString<String?>(
        'package',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      module: json.valueAsString<String?>(
        'module',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      function: json.valueAsString<String?>(
        'function',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      typeArguments:
          (json.valueEnsureAsList<dynamic>(
            'type_arguments',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsString<String>(e)).toList(),
      arguments:
          (json.valueEnsureAsList<dynamic>(
                'arguments',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) =>
                    JsonParser.valueTo<sui_rpc_v2_argument.SuiArgument, Object>(
                      value: e,
                      parse:
                          (v) => sui_rpc_v2_argument.SuiArgument.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                    ),
              )
              .toList(),
    );
  }

  factory SuiMoveCall.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMoveCall(
      package: decode.getString<String?>(1),
      module: decode.getString<String?>(2),
      function: decode.getString<String?>(3),
      typeArguments: decode.getListOrEmpty<String>(4),
      arguments:
          decode
              .getListOfBytes(5)
              .map((b) => sui_rpc_v2_argument.SuiArgument.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2MoveCall;
}

/// Command to transfer ownership of a set of objects to an address.
class SuiTransferObjects extends SuiProtoMessage {
  /// Set of objects to transfer.
  final List<sui_rpc_v2_argument.SuiArgument> objects;

  /// The address to transfer ownership to.
  final sui_rpc_v2_argument.SuiArgument? address;

  const SuiTransferObjects({this.objects = const [], this.address});

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
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [objects, address];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'objects': objects.map((e) => config.encodeMessage(e)).toList(),
      'address': config.encodeMessage(address),
    };
  }

  factory SuiTransferObjects.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiTransferObjects(
      objects:
          (json.valueEnsureAsList<dynamic>(
                'objects',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) =>
                    JsonParser.valueTo<sui_rpc_v2_argument.SuiArgument, Object>(
                      value: e,
                      parse:
                          (v) => sui_rpc_v2_argument.SuiArgument.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                    ),
              )
              .toList(),
      address: json.valueTo<sui_rpc_v2_argument.SuiArgument?, Object>(
        key: 'address',
        parse:
            (v) => sui_rpc_v2_argument.SuiArgument.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiTransferObjects.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTransferObjects(
      objects:
          decode
              .getListOfBytes(1)
              .map((b) => sui_rpc_v2_argument.SuiArgument.deserialize(b))
              .toList(),
      address: decode.messageTo<sui_rpc_v2_argument.SuiArgument?>(
        2,
        (b) => sui_rpc_v2_argument.SuiArgument.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2TransferObjects;
}

/// Command to split a single coin object into multiple coins.
class SuiSplitCoins extends SuiProtoMessage {
  /// The coin to split.
  final sui_rpc_v2_argument.SuiArgument? coin;

  /// The amounts to split off.
  final List<sui_rpc_v2_argument.SuiArgument> amounts;

  const SuiSplitCoins({this.coin, this.amounts = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [coin, amounts];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'coin': config.encodeMessage(coin),
      'amounts': amounts.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiSplitCoins.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSplitCoins(
      coin: json.valueTo<sui_rpc_v2_argument.SuiArgument?, Object>(
        key: 'coin',
        parse:
            (v) => sui_rpc_v2_argument.SuiArgument.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      amounts:
          (json.valueEnsureAsList<dynamic>(
                'amounts',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) =>
                    JsonParser.valueTo<sui_rpc_v2_argument.SuiArgument, Object>(
                      value: e,
                      parse:
                          (v) => sui_rpc_v2_argument.SuiArgument.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                    ),
              )
              .toList(),
    );
  }

  factory SuiSplitCoins.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSplitCoins(
      coin: decode.messageTo<sui_rpc_v2_argument.SuiArgument?>(
        1,
        (b) => sui_rpc_v2_argument.SuiArgument.deserialize(b),
      ),
      amounts:
          decode
              .getListOfBytes(2)
              .map((b) => sui_rpc_v2_argument.SuiArgument.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SplitCoins;
}

/// Command to merge multiple coins of the same type into a single coin.
class SuiMergeCoins extends SuiProtoMessage {
  /// Coin to merge coins into.
  final sui_rpc_v2_argument.SuiArgument? coin;

  /// Set of coins to merge into `coin`.
  ///
  /// All listed coins must be of the same type and be the same type as `coin`
  final List<sui_rpc_v2_argument.SuiArgument> coinsToMerge;

  const SuiMergeCoins({this.coin, this.coinsToMerge = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [coin, coinsToMerge];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'coin': config.encodeMessage(coin),
      'coins_to_merge':
          coinsToMerge.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiMergeCoins.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiMergeCoins(
      coin: json.valueTo<sui_rpc_v2_argument.SuiArgument?, Object>(
        key: 'coin',
        parse:
            (v) => sui_rpc_v2_argument.SuiArgument.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      coinsToMerge:
          (json.valueEnsureAsList<dynamic>(
                'coins_to_merge',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) =>
                    JsonParser.valueTo<sui_rpc_v2_argument.SuiArgument, Object>(
                      value: e,
                      parse:
                          (v) => sui_rpc_v2_argument.SuiArgument.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                    ),
              )
              .toList(),
    );
  }

  factory SuiMergeCoins.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMergeCoins(
      coin: decode.messageTo<sui_rpc_v2_argument.SuiArgument?>(
        1,
        (b) => sui_rpc_v2_argument.SuiArgument.deserialize(b),
      ),
      coinsToMerge:
          decode
              .getListOfBytes(2)
              .map((b) => sui_rpc_v2_argument.SuiArgument.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2MergeCoins;
}

/// Command to publish a new Move package.
class SuiPublish extends SuiProtoMessage {
  /// The serialized Move modules.
  final List<BuBytes> modules;

  /// Set of packages that the to-be published package depends on.
  final List<String> dependencies;

  SuiPublish({List<List<int>> modules = const [], this.dependencies = const []})
    : modules = modules.map((e) => e.asImmutableBytes).toImutableList;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.string,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [modules, dependencies];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'modules': modules.map((e) => config.encodeBinary(e)).toList(),
      'dependencies': dependencies.map((e) => e).toList(),
    };
  }

  factory SuiPublish.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiPublish(
      modules:
          (json.valueEnsureAsList<dynamic>(
            'modules',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      dependencies:
          (json.valueEnsureAsList<dynamic>(
            'dependencies',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsString<String>(e)).toList(),
    );
  }

  factory SuiPublish.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiPublish(
      modules: decode.getListOfBytes(1),
      dependencies: decode.getListOrEmpty<String>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Publish;
}

/// Command to build a Move vector out of a set of individual elements.
class SuiMakeMoveVector extends SuiProtoMessage {
  /// Type of the individual elements.
  ///
  /// This is required to be set when the type can't be inferred, for example when the set of
  /// provided arguments are all pure input values.
  final String? elementType;

  /// The set individual elements to build the vector with.
  final List<sui_rpc_v2_argument.SuiArgument> elements;

  const SuiMakeMoveVector({this.elementType, this.elements = const []});

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
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [elementType, elements];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'element_type': elementType,
      'elements': elements.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiMakeMoveVector.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiMakeMoveVector(
      elementType: json.valueAsString<String?>(
        'element_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      elements:
          (json.valueEnsureAsList<dynamic>(
                'elements',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) =>
                    JsonParser.valueTo<sui_rpc_v2_argument.SuiArgument, Object>(
                      value: e,
                      parse:
                          (v) => sui_rpc_v2_argument.SuiArgument.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                    ),
              )
              .toList(),
    );
  }

  factory SuiMakeMoveVector.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMakeMoveVector(
      elementType: decode.getString<String?>(1),
      elements:
          decode
              .getListOfBytes(2)
              .map((b) => sui_rpc_v2_argument.SuiArgument.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2MakeMoveVector;
}

/// Command to upgrade an already published package.
class SuiUpgrade extends SuiProtoMessage {
  /// The serialized Move modules.
  final List<BuBytes> modules;

  /// Set of packages that the to-be published package depends on.
  final List<String> dependencies;

  /// Package ID of the package to upgrade.
  final String? package;

  /// Ticket authorizing the upgrade.
  final sui_rpc_v2_argument.SuiArgument? ticket;

  SuiUpgrade({
    List<List<int>> modules = const [],
    this.dependencies = const [],
    this.package,
    this.ticket,
  }) : modules = modules.map((e) => e.asImmutableBytes).toImutableList;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.string,
        ),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [modules, dependencies, package, ticket];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'modules': modules.map((e) => config.encodeBinary(e)).toList(),
      'dependencies': dependencies.map((e) => e).toList(),
      'package': package,
      'ticket': config.encodeMessage(ticket),
    };
  }

  factory SuiUpgrade.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiUpgrade(
      modules:
          (json.valueEnsureAsList<dynamic>(
            'modules',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      dependencies:
          (json.valueEnsureAsList<dynamic>(
            'dependencies',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsString<String>(e)).toList(),
      package: json.valueAsString<String?>(
        'package',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ticket: json.valueTo<sui_rpc_v2_argument.SuiArgument?, Object>(
        key: 'ticket',
        parse:
            (v) => sui_rpc_v2_argument.SuiArgument.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiUpgrade.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiUpgrade(
      modules: decode.getListOfBytes(1),
      dependencies: decode.getListOrEmpty<String>(2),
      package: decode.getString<String?>(3),
      ticket: decode.messageTo<sui_rpc_v2_argument.SuiArgument?>(
        4,
        (b) => sui_rpc_v2_argument.SuiArgument.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Upgrade;
}

/// Randomness update.
class SuiRandomnessStateUpdate extends SuiProtoMessage {
  /// Epoch of the randomness state update transaction.
  final BigInt? epoch;

  /// Randomness round of the update.
  final BigInt? randomnessRound;

  /// Updated random bytes.
  final BuBytes? randomBytes;

  /// The initial version of the randomness object that it was shared at.
  final BigInt? randomnessObjectInitialSharedVersion;

  SuiRandomnessStateUpdate({
    this.epoch,
    this.randomnessRound,
    List<int>? randomBytes,
    this.randomnessObjectInitialSharedVersion,
  }) : randomBytes = randomBytes?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    epoch,
    randomnessRound,
    randomBytes,
    randomnessObjectInitialSharedVersion,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'epoch': config.encodeBigint(epoch),
      'randomness_round': config.encodeBigint(randomnessRound),
      'random_bytes': config.encodeBinary(randomBytes),
      'randomness_object_initial_shared_version': config.encodeBigint(
        randomnessObjectInitialSharedVersion,
      ),
    };
  }

  factory SuiRandomnessStateUpdate.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiRandomnessStateUpdate(
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      randomnessRound: json.valueAsBigInt<BigInt?>(
        'randomness_round',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      randomBytes: config.decodeBinary<List<int>?>(
        json.valueAs('random_bytes', normalizeKeyLookup: config.normalizeKeys),
      ),
      randomnessObjectInitialSharedVersion: json.valueAsBigInt<BigInt?>(
        'randomness_object_initial_shared_version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiRandomnessStateUpdate.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiRandomnessStateUpdate(
      epoch: decode.getBigInt<BigInt?>(1),
      randomnessRound: decode.getBigInt<BigInt?>(2),
      randomBytes: decode.getBytes<List<int>?>(3),
      randomnessObjectInitialSharedVersion: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2RandomnessStateUpdate;
}

/// System transaction used to change the epoch.
class SuiChangeEpoch extends SuiProtoMessage {
  /// The next (to become) epoch ID.
  final BigInt? epoch;

  /// The protocol version in effect in the new epoch.
  final BigInt? protocolVersion;

  /// The total amount of gas charged for storage during the epoch.
  final BigInt? storageCharge;

  /// The total amount of gas charged for computation during the epoch.
  final BigInt? computationCharge;

  /// The amount of storage rebate refunded to the txn senders.
  final BigInt? storageRebate;

  /// The non-refundable storage fee.
  final BigInt? nonRefundableStorageFee;

  /// Unix timestamp when epoch started.
  final google_protobuf_timestamp.SuiTimestamp? epochStartTimestamp;

  /// System packages (specifically framework and Move stdlib) that are written before the new
  /// epoch starts. This tracks framework upgrades on chain. When executing the `ChangeEpoch` txn,
  /// the validator must write out the following modules.  Modules are provided with the version they
  /// will be upgraded to, their modules in serialized form (which include their package ID), and
  /// a list of their transitive dependencies.
  final List<SuiSystemPackage> systemPackages;

  const SuiChangeEpoch({
    this.epoch,
    this.protocolVersion,
    this.storageCharge,
    this.computationCharge,
    this.storageRebate,
    this.nonRefundableStorageFee,
    this.epochStartTimestamp,
    this.systemPackages = const [],
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
        ProtoFieldConfig.message(7, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    epoch,
    protocolVersion,
    storageCharge,
    computationCharge,
    storageRebate,
    nonRefundableStorageFee,
    epochStartTimestamp,
    systemPackages,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'epoch': config.encodeBigint(epoch),
      'protocol_version': config.encodeBigint(protocolVersion),
      'storage_charge': config.encodeBigint(storageCharge),
      'computation_charge': config.encodeBigint(computationCharge),
      'storage_rebate': config.encodeBigint(storageRebate),
      'non_refundable_storage_fee': config.encodeBigint(
        nonRefundableStorageFee,
      ),
      'epoch_start_timestamp': epochStartTimestamp?.toRfc3339(),
      'system_packages':
          systemPackages.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiChangeEpoch.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiChangeEpoch(
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      protocolVersion: json.valueAsBigInt<BigInt?>(
        'protocol_version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storageCharge: json.valueAsBigInt<BigInt?>(
        'storage_charge',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      computationCharge: json.valueAsBigInt<BigInt?>(
        'computation_charge',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storageRebate: json.valueAsBigInt<BigInt?>(
        'storage_rebate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nonRefundableStorageFee: json.valueAsBigInt<BigInt?>(
        'non_refundable_storage_fee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      epochStartTimestamp: json
          .valueTo<google_protobuf_timestamp.SuiTimestamp?, Object>(
            key: 'epoch_start_timestamp',
            parse:
                (v) => google_protobuf_timestamp.SuiTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      systemPackages:
          (json.valueEnsureAsList<dynamic>(
                'system_packages',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiSystemPackage, Object>(
                  value: e,
                  parse:
                      (v) => SuiSystemPackage.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiChangeEpoch.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiChangeEpoch(
      epoch: decode.getBigInt<BigInt?>(1),
      protocolVersion: decode.getBigInt<BigInt?>(2),
      storageCharge: decode.getBigInt<BigInt?>(3),
      computationCharge: decode.getBigInt<BigInt?>(4),
      storageRebate: decode.getBigInt<BigInt?>(5),
      nonRefundableStorageFee: decode.getBigInt<BigInt?>(6),
      epochStartTimestamp: decode
          .messageTo<google_protobuf_timestamp.SuiTimestamp?>(
            7,
            (b) => google_protobuf_timestamp.SuiTimestamp.deserialize(b),
          ),
      systemPackages:
          decode
              .getListOfBytes(8)
              .map((b) => SuiSystemPackage.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ChangeEpoch;
}

/// System package.
class SuiSystemPackage extends SuiProtoMessage {
  /// Version of the package.
  final BigInt? version;

  /// Move modules.
  final List<BuBytes> modules;

  /// Package dependencies.
  final List<String> dependencies;

  SuiSystemPackage({
    this.version,
    List<List<int>> modules = const [],
    this.dependencies = const [],
  }) : modules = modules.map((e) => e.asImmutableBytes).toImutableList;

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
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.string,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [version, modules, dependencies];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'version': config.encodeBigint(version),
      'modules': modules.map((e) => config.encodeBinary(e)).toList(),
      'dependencies': dependencies.map((e) => e).toList(),
    };
  }

  factory SuiSystemPackage.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSystemPackage(
      version: json.valueAsBigInt<BigInt?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      modules:
          (json.valueEnsureAsList<dynamic>(
            'modules',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      dependencies:
          (json.valueEnsureAsList<dynamic>(
            'dependencies',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsString<String>(e)).toList(),
    );
  }

  factory SuiSystemPackage.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSystemPackage(
      version: decode.getBigInt<BigInt?>(1),
      modules: decode.getListOfBytes(2),
      dependencies: decode.getListOrEmpty<String>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SystemPackage;
}

/// The genesis transaction.
class SuiGenesisTransaction extends SuiProtoMessage {
  /// Set of genesis objects.
  final List<sui_rpc_v2_object.SuiObject> objects;

  const SuiGenesisTransaction({this.objects = const []});

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
  List<Object?> get protoValues => [objects];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'objects': objects.map((e) => config.encodeMessage(e)).toList()};
  }

  factory SuiGenesisTransaction.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiGenesisTransaction(
      objects:
          (json.valueEnsureAsList<dynamic>(
                'objects',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<sui_rpc_v2_object.SuiObject, Object>(
                  value: e,
                  parse:
                      (v) => sui_rpc_v2_object.SuiObject.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiGenesisTransaction.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGenesisTransaction(
      objects:
          decode
              .getListOfBytes(1)
              .map((b) => sui_rpc_v2_object.SuiObject.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2GenesisTransaction;
}

/// Consensus commit prologue system transaction.
///
/// This message can represent V1, V2, and V3 prologue types.
class SuiConsensusCommitPrologue extends SuiProtoMessage {
  /// Epoch of the commit prologue transaction.
  ///
  /// Present in V1, V2, V3, V4.
  final BigInt? epoch;

  /// Consensus round of the commit.
  ///
  /// Present in V1, V2, V3, V4.
  final BigInt? round;

  /// Unix timestamp from consensus.
  ///
  /// Present in V1, V2, V3, V4.
  final google_protobuf_timestamp.SuiTimestamp? commitTimestamp;

  /// Digest of consensus output.
  ///
  /// Present in V2, V3, V4.
  final String? consensusCommitDigest;

  /// The sub DAG index of the consensus commit. This field is populated if there
  /// are multiple consensus commits per round.
  ///
  /// Present in V3, V4.
  final BigInt? subDagIndex;

  /// Stores consensus handler determined consensus object version assignments.
  ///
  /// Present in V3, V4.
  final SuiConsensusDeterminedVersionAssignments?
  consensusDeterminedVersionAssignments;

  /// Digest of any additional state computed by the consensus handler.
  /// Used to detect forking bugs as early as possible.
  ///
  /// Present in V4.
  final String? additionalStateDigest;

  const SuiConsensusCommitPrologue({
    this.epoch,
    this.round,
    this.commitTimestamp,
    this.consensusCommitDigest,
    this.subDagIndex,
    this.consensusDeterminedVersionAssignments,
    this.additionalStateDigest,
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
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(5, hasOptionalFlags: true),
        ProtoFieldConfig.message(6, hasOptionalFlags: true),
        ProtoFieldConfig.string(7, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    epoch,
    round,
    commitTimestamp,
    consensusCommitDigest,
    subDagIndex,
    consensusDeterminedVersionAssignments,
    additionalStateDigest,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'epoch': config.encodeBigint(epoch),
      'round': config.encodeBigint(round),
      'commit_timestamp': commitTimestamp?.toRfc3339(),
      'consensus_commit_digest': consensusCommitDigest,
      'sub_dag_index': config.encodeBigint(subDagIndex),
      'consensus_determined_version_assignments': config.encodeMessage(
        consensusDeterminedVersionAssignments,
      ),
      'additional_state_digest': additionalStateDigest,
    };
  }

  factory SuiConsensusCommitPrologue.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiConsensusCommitPrologue(
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      round: json.valueAsBigInt<BigInt?>(
        'round',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      commitTimestamp: json
          .valueTo<google_protobuf_timestamp.SuiTimestamp?, Object>(
            key: 'commit_timestamp',
            parse:
                (v) => google_protobuf_timestamp.SuiTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      consensusCommitDigest: json.valueAsString<String?>(
        'consensus_commit_digest',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      subDagIndex: json.valueAsBigInt<BigInt?>(
        'sub_dag_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consensusDeterminedVersionAssignments: json
          .valueTo<SuiConsensusDeterminedVersionAssignments?, Object>(
            key: 'consensus_determined_version_assignments',
            parse:
                (v) => SuiConsensusDeterminedVersionAssignments.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      additionalStateDigest: json.valueAsString<String?>(
        'additional_state_digest',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiConsensusCommitPrologue.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiConsensusCommitPrologue(
      epoch: decode.getBigInt<BigInt?>(1),
      round: decode.getBigInt<BigInt?>(2),
      commitTimestamp: decode
          .messageTo<google_protobuf_timestamp.SuiTimestamp?>(
            3,
            (b) => google_protobuf_timestamp.SuiTimestamp.deserialize(b),
          ),
      consensusCommitDigest: decode.getString<String?>(4),
      subDagIndex: decode.getBigInt<BigInt?>(5),
      consensusDeterminedVersionAssignments: decode
          .messageTo<SuiConsensusDeterminedVersionAssignments?>(
            6,
            (b) => SuiConsensusDeterminedVersionAssignments.deserialize(b),
          ),
      additionalStateDigest: decode.getString<String?>(7),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ConsensusCommitPrologue;
}

/// Object version assignment from consensus.
class SuiVersionAssignment extends SuiProtoMessage {
  /// `ObjectId` of the object.
  final String? objectId;

  /// start version of the consensus stream for this object
  final BigInt? startVersion;

  /// Assigned version.
  final BigInt? version;

  const SuiVersionAssignment({this.objectId, this.startVersion, this.version});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [objectId, startVersion, version];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'object_id': objectId,
      'start_version': config.encodeBigint(startVersion),
      'version': config.encodeBigint(version),
    };
  }

  factory SuiVersionAssignment.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiVersionAssignment(
      objectId: json.valueAsString<String?>(
        'object_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      startVersion: json.valueAsBigInt<BigInt?>(
        'start_version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      version: json.valueAsBigInt<BigInt?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiVersionAssignment.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiVersionAssignment(
      objectId: decode.getString<String?>(1),
      startVersion: decode.getBigInt<BigInt?>(2),
      version: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2VersionAssignment;
}

/// A transaction that was canceled.
class SuiCanceledTransaction extends SuiProtoMessage {
  /// Digest of the canceled transaction.
  final String? digest;

  /// List of object version assignments.
  final List<SuiVersionAssignment> versionAssignments;

  const SuiCanceledTransaction({
    this.digest,
    this.versionAssignments = const [],
  });

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
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [digest, versionAssignments];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'digest': digest,
      'version_assignments':
          versionAssignments.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiCanceledTransaction.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiCanceledTransaction(
      digest: json.valueAsString<String?>(
        'digest',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      versionAssignments:
          (json.valueEnsureAsList<dynamic>(
                'version_assignments',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiVersionAssignment, Object>(
                  value: e,
                  parse:
                      (v) => SuiVersionAssignment.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiCanceledTransaction.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCanceledTransaction(
      digest: decode.getString<String?>(1),
      versionAssignments:
          decode
              .getListOfBytes(2)
              .map((b) => SuiVersionAssignment.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2CanceledTransaction;
}

/// Version assignments performed by consensus.
class SuiConsensusDeterminedVersionAssignments extends SuiProtoMessage {
  /// Version of this message
  final int? version;

  /// Canceled transaction version assignment.
  final List<SuiCanceledTransaction> canceledTransactions;

  const SuiConsensusDeterminedVersionAssignments({
    this.version,
    this.canceledTransactions = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int32(1, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [version, canceledTransactions];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'version': version,
      'canceled_transactions':
          canceledTransactions.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiConsensusDeterminedVersionAssignments.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiConsensusDeterminedVersionAssignments(
      version: json.valueAsInt<int?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      canceledTransactions:
          (json.valueEnsureAsList<dynamic>(
                'canceled_transactions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiCanceledTransaction, Object>(
                  value: e,
                  parse:
                      (v) => SuiCanceledTransaction.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiConsensusDeterminedVersionAssignments.deserialize(
    List<int> bytes,
  ) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiConsensusDeterminedVersionAssignments(
      version: decode.getInt<int?>(1),
      canceledTransactions:
          decode
              .getListOfBytes(3)
              .map((b) => SuiCanceledTransaction.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ConsensusDeterminedVersionAssignments;
}

/// Update the set of valid JWKs.
class SuiAuthenticatorStateUpdate extends SuiProtoMessage {
  /// Epoch of the authenticator state update transaction.
  final BigInt? epoch;

  /// Consensus round of the authenticator state update.
  final BigInt? round;

  /// Newly active JWKs.
  final List<SuiActiveJwk> newActiveJwks;

  /// The initial version of the authenticator object that it was shared at.
  final BigInt? authenticatorObjectInitialSharedVersion;

  const SuiAuthenticatorStateUpdate({
    this.epoch,
    this.round,
    this.newActiveJwks = const [],
    this.authenticatorObjectInitialSharedVersion,
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
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    epoch,
    round,
    newActiveJwks,
    authenticatorObjectInitialSharedVersion,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'epoch': config.encodeBigint(epoch),
      'round': config.encodeBigint(round),
      'new_active_jwks':
          newActiveJwks.map((e) => config.encodeMessage(e)).toList(),
      'authenticator_object_initial_shared_version': config.encodeBigint(
        authenticatorObjectInitialSharedVersion,
      ),
    };
  }

  factory SuiAuthenticatorStateUpdate.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiAuthenticatorStateUpdate(
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      round: json.valueAsBigInt<BigInt?>(
        'round',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      newActiveJwks:
          (json.valueEnsureAsList<dynamic>(
                'new_active_jwks',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiActiveJwk, Object>(
                  value: e,
                  parse:
                      (v) => SuiActiveJwk.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      authenticatorObjectInitialSharedVersion: json.valueAsBigInt<BigInt?>(
        'authenticator_object_initial_shared_version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiAuthenticatorStateUpdate.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiAuthenticatorStateUpdate(
      epoch: decode.getBigInt<BigInt?>(1),
      round: decode.getBigInt<BigInt?>(2),
      newActiveJwks:
          decode
              .getListOfBytes(3)
              .map((b) => SuiActiveJwk.deserialize(b))
              .toList(),
      authenticatorObjectInitialSharedVersion: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2AuthenticatorStateUpdate;
}

/// A new JWK.
class SuiActiveJwk extends SuiProtoMessage {
  /// Identifier used to uniquely identify a JWK.
  final sui_rpc_v2_jwk.SuiJwkId? id;

  /// The JWK.
  final sui_rpc_v2_jwk.SuiJwk? jwk;

  /// Most recent epoch in which the JWK was validated.
  final BigInt? epoch;

  const SuiActiveJwk({this.id, this.jwk, this.epoch});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [id, jwk, epoch];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'id': config.encodeMessage(id),
      'jwk': config.encodeMessage(jwk),
      'epoch': config.encodeBigint(epoch),
    };
  }

  factory SuiActiveJwk.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiActiveJwk(
      id: json.valueTo<sui_rpc_v2_jwk.SuiJwkId?, Object>(
        key: 'id',
        parse:
            (v) => sui_rpc_v2_jwk.SuiJwkId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      jwk: json.valueTo<sui_rpc_v2_jwk.SuiJwk?, Object>(
        key: 'jwk',
        parse:
            (v) => sui_rpc_v2_jwk.SuiJwk.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiActiveJwk.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiActiveJwk(
      id: decode.messageTo<sui_rpc_v2_jwk.SuiJwkId?>(
        1,
        (b) => sui_rpc_v2_jwk.SuiJwkId.deserialize(b),
      ),
      jwk: decode.messageTo<sui_rpc_v2_jwk.SuiJwk?>(
        2,
        (b) => sui_rpc_v2_jwk.SuiJwk.deserialize(b),
      ),
      epoch: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ActiveJwk;
}

/// Set of operations run at the end of the epoch to close out the current epoch
/// and start the next one.
class SuiEndOfEpochTransaction extends SuiProtoMessage {
  final List<SuiEndOfEpochTransactionKind> transactions;

  const SuiEndOfEpochTransaction({this.transactions = const []});

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
  List<Object?> get protoValues => [transactions];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transactions': transactions.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiEndOfEpochTransaction.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiEndOfEpochTransaction(
      transactions:
          (json.valueEnsureAsList<dynamic>(
                'transactions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiEndOfEpochTransactionKind, Object>(
                  value: e,
                  parse:
                      (v) => SuiEndOfEpochTransactionKind.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiEndOfEpochTransaction.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEndOfEpochTransaction(
      transactions:
          decode
              .getListOfBytes(1)
              .map((b) => SuiEndOfEpochTransactionKind.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2EndOfEpochTransaction;
}

/// Operation run at the end of an epoch.
class SuiEndOfEpochTransactionKind extends SuiProtoMessage {
  final SuiEndOfEpochTransactionKindKind? kind;

  /// End the epoch and start the next one.
  final SuiChangeEpoch? changeEpoch;

  /// Expire JWKs used for zklogin.
  final SuiAuthenticatorStateExpire? authenticatorStateExpire;

  /// Execution time observations from the committee to preserve cross epoch
  final SuiExecutionTimeObservations? executionTimeObservations;

  /// ChainId used when initializing the bridge
  final String? bridgeChainId;

  /// Start version of the Bridge object
  final BigInt? bridgeObjectVersion;

  /// Contains the end-of-epoch-computed storage cost for accumulator objects.
  final BigInt? storageCost;

  const SuiEndOfEpochTransactionKind({
    this.kind,
    this.changeEpoch,
    this.authenticatorStateExpire,
    this.executionTimeObservations,
    this.bridgeChainId,
    this.bridgeObjectVersion,
    this.storageCost,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.string(5),
        ProtoFieldConfig.uint64(6),
        ProtoFieldConfig.uint64(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    kind,
    changeEpoch,
    authenticatorStateExpire,
    executionTimeObservations,
    bridgeChainId,
    bridgeObjectVersion,
    storageCost,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'kind': config.encodeEnum(kind),
      'change_epoch': config.encodeMessage(changeEpoch),
      'authenticator_state_expire': config.encodeMessage(
        authenticatorStateExpire,
      ),
      'execution_time_observations': config.encodeMessage(
        executionTimeObservations,
      ),
      'bridge_chain_id': bridgeChainId,
      'bridge_object_version': config.encodeBigint(bridgeObjectVersion),
      'storage_cost': config.encodeBigint(storageCost),
    };
  }

  factory SuiEndOfEpochTransactionKind.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiEndOfEpochTransactionKind(
      kind: json.valueTo<SuiEndOfEpochTransactionKindKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiEndOfEpochTransactionKindKind.from(v),
      ),
      changeEpoch: json.valueTo<SuiChangeEpoch?, Object>(
        key: 'change_epoch',
        parse:
            (v) =>
                SuiChangeEpoch.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      authenticatorStateExpire: json
          .valueTo<SuiAuthenticatorStateExpire?, Object>(
            key: 'authenticator_state_expire',
            parse:
                (v) => SuiAuthenticatorStateExpire.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      executionTimeObservations: json
          .valueTo<SuiExecutionTimeObservations?, Object>(
            key: 'execution_time_observations',
            parse:
                (v) => SuiExecutionTimeObservations.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      bridgeChainId: json.valueAsString<String?>(
        'bridge_chain_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      bridgeObjectVersion: json.valueAsBigInt<BigInt?>(
        'bridge_object_version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storageCost: json.valueAsBigInt<BigInt?>(
        'storage_cost',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiEndOfEpochTransactionKind.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEndOfEpochTransactionKind(
      kind: decode.getEnum<SuiEndOfEpochTransactionKindKind?>(
        1,
        SuiEndOfEpochTransactionKindKind.values,
      ),
      changeEpoch: decode.messageTo<SuiChangeEpoch?>(
        2,
        (b) => SuiChangeEpoch.deserialize(b),
      ),
      authenticatorStateExpire: decode.messageTo<SuiAuthenticatorStateExpire?>(
        3,
        (b) => SuiAuthenticatorStateExpire.deserialize(b),
      ),
      executionTimeObservations: decode
          .messageTo<SuiExecutionTimeObservations?>(
            4,
            (b) => SuiExecutionTimeObservations.deserialize(b),
          ),
      bridgeChainId: decode.getString<String?>(5),
      bridgeObjectVersion: decode.getBigInt<BigInt?>(6),
      storageCost: decode.getBigInt<BigInt?>(7),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2EndOfEpochTransactionKind;
}

/// Expire old JWKs.
class SuiAuthenticatorStateExpire extends SuiProtoMessage {
  /// Expire JWKs that have a lower epoch than this.
  final BigInt? minEpoch;

  /// The initial version of the authenticator object that it was shared at.
  final BigInt? authenticatorObjectInitialSharedVersion;

  const SuiAuthenticatorStateExpire({
    this.minEpoch,
    this.authenticatorObjectInitialSharedVersion,
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
    minEpoch,
    authenticatorObjectInitialSharedVersion,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'min_epoch': config.encodeBigint(minEpoch),
      'authenticator_object_initial_shared_version': config.encodeBigint(
        authenticatorObjectInitialSharedVersion,
      ),
    };
  }

  factory SuiAuthenticatorStateExpire.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiAuthenticatorStateExpire(
      minEpoch: json.valueAsBigInt<BigInt?>(
        'min_epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      authenticatorObjectInitialSharedVersion: json.valueAsBigInt<BigInt?>(
        'authenticator_object_initial_shared_version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiAuthenticatorStateExpire.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiAuthenticatorStateExpire(
      minEpoch: decode.getBigInt<BigInt?>(1),
      authenticatorObjectInitialSharedVersion: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2AuthenticatorStateExpire;
}

class SuiExecutionTimeObservations extends SuiProtoMessage {
  /// Version of this ExecutionTimeObservations
  final int? version;

  final List<SuiExecutionTimeObservation> observations;

  const SuiExecutionTimeObservations({
    this.version,
    this.observations = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int32(1, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [version, observations];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'version': version,
      'observations': observations.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiExecutionTimeObservations.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiExecutionTimeObservations(
      version: json.valueAsInt<int?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      observations:
          (json.valueEnsureAsList<dynamic>(
                'observations',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiExecutionTimeObservation, Object>(
                  value: e,
                  parse:
                      (v) => SuiExecutionTimeObservation.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiExecutionTimeObservations.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiExecutionTimeObservations(
      version: decode.getInt<int?>(1),
      observations:
          decode
              .getListOfBytes(2)
              .map((b) => SuiExecutionTimeObservation.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ExecutionTimeObservations;
}

class SuiExecutionTimeObservation extends SuiProtoMessage {
  final SuiExecutionTimeObservationExecutionTimeObservationKind? kind;

  final SuiMoveCall? moveEntryPoint;

  final List<SuiValidatorExecutionTimeObservation> validatorObservations;

  const SuiExecutionTimeObservation({
    this.kind,
    this.moveEntryPoint,
    this.validatorObservations = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    kind,
    moveEntryPoint,
    validatorObservations,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'kind': config.encodeEnum(kind),
      'move_entry_point': config.encodeMessage(moveEntryPoint),
      'validator_observations':
          validatorObservations.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiExecutionTimeObservation.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiExecutionTimeObservation(
      kind: json.valueTo<
        SuiExecutionTimeObservationExecutionTimeObservationKind?,
        Object?
      >(
        key: 'kind',
        parse:
            (v) =>
                SuiExecutionTimeObservationExecutionTimeObservationKind.from(v),
      ),
      moveEntryPoint: json.valueTo<SuiMoveCall?, Object>(
        key: 'move_entry_point',
        parse:
            (v) => SuiMoveCall.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      validatorObservations:
          (json.valueEnsureAsList<dynamic>(
                'validator_observations',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  SuiValidatorExecutionTimeObservation,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => SuiValidatorExecutionTimeObservation.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiExecutionTimeObservation.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiExecutionTimeObservation(
      kind: decode
          .getEnum<SuiExecutionTimeObservationExecutionTimeObservationKind?>(
            1,
            SuiExecutionTimeObservationExecutionTimeObservationKind.values,
          ),
      moveEntryPoint: decode.messageTo<SuiMoveCall?>(
        2,
        (b) => SuiMoveCall.deserialize(b),
      ),
      validatorObservations:
          decode
              .getListOfBytes(3)
              .map((b) => SuiValidatorExecutionTimeObservation.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ExecutionTimeObservation;
}

class SuiValidatorExecutionTimeObservation extends SuiProtoMessage {
  /// Bls12381 public key of the validator
  final BuBytes? validator;

  /// Duration of an execution observation
  final google_protobuf_duration.SuiDuration? duration;

  SuiValidatorExecutionTimeObservation({List<int>? validator, this.duration})
    : validator = validator?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [validator, duration];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'validator': config.encodeBinary(validator),
      'duration': duration?.encodeString(asNanos: false),
    };
  }

  factory SuiValidatorExecutionTimeObservation.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiValidatorExecutionTimeObservation(
      validator: config.decodeBinary<List<int>?>(
        json.valueAs('validator', normalizeKeyLookup: config.normalizeKeys),
      ),
      duration: json.valueTo<google_protobuf_duration.SuiDuration?, Object>(
        key: 'duration',
        parse:
            (v) => google_protobuf_duration.SuiDuration.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiValidatorExecutionTimeObservation.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiValidatorExecutionTimeObservation(
      validator: decode.getBytes<List<int>?>(1),
      duration: decode.messageTo<google_protobuf_duration.SuiDuration?>(
        2,
        (b) => google_protobuf_duration.SuiDuration.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ValidatorExecutionTimeObservation;
}

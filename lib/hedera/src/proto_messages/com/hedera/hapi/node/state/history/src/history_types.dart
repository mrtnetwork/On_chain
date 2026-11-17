import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;

/// *
///  * The phase of a WRAPS proof construction.
enum HederaWrapsPhase implements ProtoEnumVariant {
  /// *
  ///    * Nodes are publishing their proof keys and R1 messages.
  r1(0, 'R1'),

  /// *
  ///    * Nodes are publishing their R2 messages.
  r2(1, 'R2'),

  /// *
  ///    * Nodes are publishing their R3 messages.
  r3(2, 'R3'),

  /// *
  ///    * Nodes are aggregating all messages to produce a final signature.
  aggregate(3, 'AGGREGATE'),

  /// *
  ///    * Nodes are doing work that must occur in a different event loop
  ///    * than the one used for the above phases.
  postAggregation(4, 'POST_AGGREGATION');

  const HederaWrapsPhase(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaWrapsPhase fromValue(int? value) {
    value ??= 0;
    return HederaWrapsPhase.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaWrapsPhase found for the given value. $value",
                details: {
                  "name": "HederaWrapsPhase",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaWrapsPhase from(Object? value) {
    value ??= 0;
    return HederaWrapsPhase.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaWrapsPhase found for the given value. $value",
                details: {
                  "name": "HederaWrapsPhase",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.history"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A set of proof keys for a node; that is, the key the node is
///  * currently using and the key it wants to use in assembling the
///  * next address book in the ledger id's chain of trust.
class HederaProofKeySet extends HederaProtoMessage with Equality {
  /// *
  ///    * The consensus time when the network adopted the active
  ///    * proof key in this set. An adoption time that is sufficiently
  ///    * tardy relative to the latest assembly start time may result
  ///    * in the node's key being omitted from the address book.
  final proto_timestamp.HederaTimestamp? adoptionTime;

  /// *
  ///    * The proof key the node is using.
  final List<int>? key;

  /// *
  ///    * If set, the proof key the node wants to start using in the
  ///    * address book.
  final List<int>? nextKey;

  const HederaProofKeySet({this.adoptionTime, this.key, this.nextKey});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [adoptionTime, key, nextKey];

  HederaProofKeySet copyWith({
    proto_timestamp.HederaTimestamp? adoptionTime,

    List<int>? key,

    List<int>? nextKey,
  }) {
    return HederaProofKeySet(
      adoptionTime: adoptionTime ?? this.adoptionTime,
      key: key ?? this.key,
      nextKey: nextKey ?? this.nextKey,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'adoption_time': config.encodeMessage(adoptionTime),
      'key': config.encodeBinary(key),
      'next_key': config.encodeBinary(nextKey),
    };
  }

  factory HederaProofKeySet.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaProofKeySet(
      adoptionTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'adoption_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      key: config.decodeBinary<List<int>?>(
        json.valueAs('key', normalizeKeyLookup: config.normalizeKeys),
      ),
      nextKey: config.decodeBinary<List<int>?>(
        json.valueAs('next_key', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaProofKeySet.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaProofKeySet(
      adoptionTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        2,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      key: decode.getBytes<List<int>?>(3),
      nextKey: decode.getBytes<List<int>?>(4),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHistoryProofKeySet;
}

/// *
///  * A record of the proof key a node had in a particular address
///  * book. Necessary to keep at each point history so that nodes
///  * can verify the correct key was used to sign in transitions
///  * starting from the current address book; no matter how keys
///  * have been rotated from the time the address book was created.
class HederaProofKey extends HederaProtoMessage with Equality {
  /// *
  ///    * The node id.
  final BigInt? nodeId;

  /// *
  ///    * The key.
  final List<int>? key;

  const HederaProofKey({this.nodeId, this.key});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.uint64(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [nodeId, key];

  HederaProofKey copyWith({BigInt? nodeId, List<int>? key}) {
    return HederaProofKey(nodeId: nodeId ?? this.nodeId, key: key ?? this.key);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'node_id': config.encodeBigint(nodeId),
      'key': config.encodeBinary(key),
    };
  }

  factory HederaProofKey.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaProofKey(
      nodeId: json.valueAsBigInt<BigInt?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      key: config.decodeBinary<List<int>?>(
        json.valueAs('key', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaProofKey.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaProofKey(
      nodeId: decode.getBigInt<BigInt?>(1),
      key: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHistoryProofKey;
}

/// *
///  * A piece of new history in the form of an address book hash and
///  * associated metadata.
class HederaHistory extends HederaProtoMessage with Equality {
  /// *
  ///    * The address book hash of the new history.
  final List<int>? addressBookHash;

  /// *
  ///    * The metadata associated to the address book.
  final List<int>? metadata;

  const HederaHistory({this.addressBookHash, this.metadata});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [addressBookHash, metadata];

  HederaHistory copyWith({List<int>? addressBookHash, List<int>? metadata}) {
    return HederaHistory(
      addressBookHash: addressBookHash ?? this.addressBookHash,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'address_book_hash': config.encodeBinary(addressBookHash),
      'metadata': config.encodeBinary(metadata),
    };
  }

  factory HederaHistory.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHistory(
      addressBookHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'address_book_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      metadata: config.decodeBinary<List<int>?>(
        json.valueAs('metadata', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaHistory.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHistory(
      addressBookHash: decode.getBytes<List<int>?>(1),
      metadata: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHistoryHistory;
}

/// *
///  * A proof that some address book history belongs to the ledger id's chain of trust.
class HederaHistoryProof extends HederaProtoMessage with Equality {
  /// *
  ///    * The proof keys for the target address book, needed to keep
  ///    * constructing proofs after adopting the target address book's
  ///    * roster at a handoff.
  final List<HederaProofKey> targetProofKeys;

  /// *
  ///    * The target history of the proof.
  final HederaHistory? targetHistory;

  /// *
  ///    * The proof of chain of trust from the ledger id to the target
  ///    * history's metadata. May be switched from AggregatedNodeSignatures
  ///    * to a recursive proof when one becomes available.
  final HederaChainOfTrustProof? chainOfTrustProof;

  /// *
  ///    * If set, the uncompressed proof of chain of trust from the ledger id to
  ///    * the target address book; the uncompressed version of the WRAPS proof is
  ///    * required to keep extending the chain of trust.
  final List<int>? uncompressedWrapsProof;

  const HederaHistoryProof({
    this.targetProofKeys = const [],
    this.targetHistory,
    this.chainOfTrustProof,
    this.uncompressedWrapsProof,
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
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    targetProofKeys,
    targetHistory,
    chainOfTrustProof,
    uncompressedWrapsProof,
  ];

  HederaHistoryProof copyWith({
    List<HederaProofKey>? targetProofKeys,

    HederaHistory? targetHistory,

    HederaChainOfTrustProof? chainOfTrustProof,

    List<int>? uncompressedWrapsProof,
  }) {
    return HederaHistoryProof(
      targetProofKeys: targetProofKeys ?? this.targetProofKeys,
      targetHistory: targetHistory ?? this.targetHistory,
      chainOfTrustProof: chainOfTrustProof ?? this.chainOfTrustProof,
      uncompressedWrapsProof:
          uncompressedWrapsProof ?? this.uncompressedWrapsProof,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'target_proof_keys':
          targetProofKeys.map((e) => config.encodeMessage(e)).toList(),
      'target_history': config.encodeMessage(targetHistory),
      'chain_of_trust_proof': config.encodeMessage(chainOfTrustProof),
      'uncompressed_wraps_proof': config.encodeBinary(uncompressedWrapsProof),
    };
  }

  factory HederaHistoryProof.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHistoryProof(
      targetProofKeys:
          (json.valueEnsureAsList<dynamic>(
                'target_proof_keys',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaProofKey, Object>(
                  value: e,
                  parse:
                      (v) => HederaProofKey.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      targetHistory: json.valueTo<HederaHistory?, Object>(
        key: 'target_history',
        parse:
            (v) =>
                HederaHistory.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      chainOfTrustProof: json.valueTo<HederaChainOfTrustProof?, Object>(
        key: 'chain_of_trust_proof',
        parse:
            (v) => HederaChainOfTrustProof.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      uncompressedWrapsProof: config.decodeBinary<List<int>?>(
        json.valueAs(
          'uncompressed_wraps_proof',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaHistoryProof.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHistoryProof(
      targetProofKeys:
          decode
              .getListOfBytes(1)
              .map((b) => HederaProofKey.deserialize(b))
              .toList(),
      targetHistory: decode.messageTo<HederaHistory?>(
        2,
        (b) => HederaHistory.deserialize(b),
      ),
      chainOfTrustProof: decode.messageTo<HederaChainOfTrustProof?>(
        3,
        (b) => HederaChainOfTrustProof.deserialize(b),
      ),
      uncompressedWrapsProof: decode.getBytes<List<int>?>(4),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHistoryHistoryProof;
}

/// *
///  * Summary of the status of constructing a metadata proof, necessary to
///  * ensure deterministic construction ending in a roster with sufficient
///  * weight to enact its own constructions.
class HederaHistoryProofConstruction extends HederaProtoMessage with Equality {
  /// *
  ///    * The construction id.
  final BigInt? constructionId;

  /// *
  ///    * The hash of the roster whose weights are used to determine when
  ///    * certain thresholds are during construction.
  final List<int>? sourceRosterHash;

  /// *
  ///    * The hash of the roster whose weights are used to assess progress
  ///    * toward obtaining proof keys for parties that hold at least a
  ///    * strong minority of the stake in that roster.
  final List<int>? targetRosterHash;

  /// *
  ///      * If the network is still gathering proof keys for this
  ///      * construction, the next time at which nodes should stop waiting
  ///      * for tardy proof keys and assemble the history to be proven as
  ///      * soon as it has the associated metadata and proof keys for nodes
  ///      * with &gt;2/3 weight in the target roster.
  final proto_timestamp.HederaTimestamp? gracePeriodEndTime;

  /// *
  ///      * If the network has gathered enough proof keys to assemble the
  ///      * history for this construction, the cutoff time at which those
  ///      * keys must have been adopted to be included in the final history.
  final proto_timestamp.HederaTimestamp? assemblyStartTime;

  /// *
  ///      * When this construction is complete, the proof that the target
  ///      * roster's address book and associated metadata belong to the
  ///      * ledger id's chain of trust.
  final HederaHistoryProof? targetProof;

  /// *
  ///      * If set, the reason the construction failed.
  final String? failureReason;

  /// *
  ///      * If set, the state of the WRAPS signing protocol for this construction.
  final HederaWrapsSigningState? wrapsSigningState;

  /// *
  ///    * The number of times the network has had to restart this construction.
  final int? wrapsRetryCount;

  const HederaHistoryProofConstruction({
    this.constructionId,
    this.sourceRosterHash,
    this.targetRosterHash,
    this.gracePeriodEndTime,
    this.assemblyStartTime,
    this.targetProof,
    this.failureReason,
    this.wrapsSigningState,
    this.wrapsRetryCount,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.string(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.uint32(10),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    constructionId,
    sourceRosterHash,
    targetRosterHash,
    gracePeriodEndTime,
    assemblyStartTime,
    targetProof,
    failureReason,
    wrapsSigningState,
    wrapsRetryCount,
  ];

  HederaHistoryProofConstruction copyWith({
    BigInt? constructionId,

    List<int>? sourceRosterHash,

    List<int>? targetRosterHash,

    proto_timestamp.HederaTimestamp? gracePeriodEndTime,

    proto_timestamp.HederaTimestamp? assemblyStartTime,

    HederaHistoryProof? targetProof,

    String? failureReason,

    HederaWrapsSigningState? wrapsSigningState,

    int? wrapsRetryCount,
  }) {
    return HederaHistoryProofConstruction(
      constructionId: constructionId ?? this.constructionId,
      sourceRosterHash: sourceRosterHash ?? this.sourceRosterHash,
      targetRosterHash: targetRosterHash ?? this.targetRosterHash,
      gracePeriodEndTime: gracePeriodEndTime ?? this.gracePeriodEndTime,
      assemblyStartTime: assemblyStartTime ?? this.assemblyStartTime,
      targetProof: targetProof ?? this.targetProof,
      failureReason: failureReason ?? this.failureReason,
      wrapsSigningState: wrapsSigningState ?? this.wrapsSigningState,
      wrapsRetryCount: wrapsRetryCount ?? this.wrapsRetryCount,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'construction_id': config.encodeBigint(constructionId),
      'source_roster_hash': config.encodeBinary(sourceRosterHash),
      'target_roster_hash': config.encodeBinary(targetRosterHash),
      'grace_period_end_time': config.encodeMessage(gracePeriodEndTime),
      'assembly_start_time': config.encodeMessage(assemblyStartTime),
      'target_proof': config.encodeMessage(targetProof),
      'failure_reason': failureReason,
      'wraps_signing_state': config.encodeMessage(wrapsSigningState),
      'wraps_retry_count': wrapsRetryCount,
    };
  }

  factory HederaHistoryProofConstruction.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHistoryProofConstruction(
      constructionId: json.valueAsBigInt<BigInt?>(
        'construction_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sourceRosterHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'source_roster_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      targetRosterHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'target_roster_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      gracePeriodEndTime: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'grace_period_end_time',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      assemblyStartTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'assembly_start_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      targetProof: json.valueTo<HederaHistoryProof?, Object>(
        key: 'target_proof',
        parse:
            (v) => HederaHistoryProof.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      failureReason: json.valueAsString<String?>(
        'failure_reason',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      wrapsSigningState: json.valueTo<HederaWrapsSigningState?, Object>(
        key: 'wraps_signing_state',
        parse:
            (v) => HederaWrapsSigningState.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      wrapsRetryCount: json.valueAsInt<int?>(
        'wraps_retry_count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaHistoryProofConstruction.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHistoryProofConstruction(
      constructionId: decode.getBigInt<BigInt?>(1),
      sourceRosterHash: decode.getBytes<List<int>?>(2),
      targetRosterHash: decode.getBytes<List<int>?>(4),
      gracePeriodEndTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        5,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      assemblyStartTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        6,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      targetProof: decode.messageTo<HederaHistoryProof?>(
        7,
        (b) => HederaHistoryProof.deserialize(b),
      ),
      failureReason: decode.getString<String?>(8),
      wrapsSigningState: decode.messageTo<HederaWrapsSigningState?>(
        9,
        (b) => HederaWrapsSigningState.deserialize(b),
      ),
      wrapsRetryCount: decode.getInt<int?>(10),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeStateHistoryHistoryProofConstruction;
}

/// *
///  * The state of an ongoing WRAPS signature protocol.
class HederaWrapsSigningState extends HederaProtoMessage with Equality {
  /// *
  ///    * The phase of the WRAPS protocol.
  final HederaWrapsPhase? phase;

  /// *
  ///    * If the network is still gathering WRAPS messages for the R2 or R3
  ///    * protocol phase, the next time at which nodes should stop waiting
  ///    * for tardy messages from R1 participants and start over.
  final proto_timestamp.HederaTimestamp? gracePeriodEndTime;

  const HederaWrapsSigningState({this.phase, this.gracePeriodEndTime});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.enumType(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [phase, gracePeriodEndTime];

  HederaWrapsSigningState copyWith({
    HederaWrapsPhase? phase,

    proto_timestamp.HederaTimestamp? gracePeriodEndTime,
  }) {
    return HederaWrapsSigningState(
      phase: phase ?? this.phase,
      gracePeriodEndTime: gracePeriodEndTime ?? this.gracePeriodEndTime,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'phase': config.encodeEnum(phase),
      'grace_period_end_time': config.encodeMessage(gracePeriodEndTime),
    };
  }

  factory HederaWrapsSigningState.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaWrapsSigningState(
      phase: json.valueTo<HederaWrapsPhase?, Object?>(
        key: 'phase',
        parse: (v) => HederaWrapsPhase.from(v),
      ),
      gracePeriodEndTime: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'grace_period_end_time',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaWrapsSigningState.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaWrapsSigningState(
      phase: decode.getEnum<HederaWrapsPhase?>(1, HederaWrapsPhase.values),
      gracePeriodEndTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        2,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHistoryWrapsSigningState;
}

/// *
///  * A construction-scoped node id.
class HederaConstructionNodeId extends HederaProtoMessage with Equality {
  /// *
  ///    * The unique id of a history proof construction.
  final BigInt? constructionId;

  /// *
  ///    * The unique id of a node.
  final BigInt? nodeId;

  const HederaConstructionNodeId({this.constructionId, this.nodeId});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.uint64(1), ProtoFieldConfig.uint64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [constructionId, nodeId];

  HederaConstructionNodeId copyWith({BigInt? constructionId, BigInt? nodeId}) {
    return HederaConstructionNodeId(
      constructionId: constructionId ?? this.constructionId,
      nodeId: nodeId ?? this.nodeId,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'construction_id': config.encodeBigint(constructionId),
      'node_id': config.encodeBigint(nodeId),
    };
  }

  factory HederaConstructionNodeId.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaConstructionNodeId(
      constructionId: json.valueAsBigInt<BigInt?>(
        'construction_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeId: json.valueAsBigInt<BigInt?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaConstructionNodeId.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConstructionNodeId(
      constructionId: decode.getBigInt<BigInt?>(1),
      nodeId: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHistoryConstructionNodeId;
}

/// *
///  * A node's vote for a particular history proof; either by explicitly
///  * giving the proof, or by identifying a node that already voted for it.
class HederaHistoryProofVote extends HederaProtoMessage with Equality {
  /// *
  ///      * The history proof the submitting node is voting for.
  final HederaHistoryProof? proof;

  /// *
  ///      * The id of another node that already voted for the exact proof
  ///      * the submitting node is voting for.
  final BigInt? congruentNodeId;

  const HederaHistoryProofVote({this.proof, this.congruentNodeId});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.uint64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [proof, congruentNodeId];

  HederaHistoryProofVote copyWith({
    HederaHistoryProof? proof,

    BigInt? congruentNodeId,
  }) {
    return HederaHistoryProofVote(
      proof: proof ?? this.proof,
      congruentNodeId: congruentNodeId ?? this.congruentNodeId,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'proof': config.encodeMessage(proof),
      'congruent_node_id': config.encodeBigint(congruentNodeId),
    };
  }

  factory HederaHistoryProofVote.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHistoryProofVote(
      proof: json.valueTo<HederaHistoryProof?, Object>(
        key: 'proof',
        parse:
            (v) => HederaHistoryProof.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      congruentNodeId: json.valueAsBigInt<BigInt?>(
        'congruent_node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaHistoryProofVote.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHistoryProofVote(
      proof: decode.messageTo<HederaHistoryProof?>(
        1,
        (b) => HederaHistoryProof.deserialize(b),
      ),
      congruentNodeId: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHistoryHistoryProofVote;
}

/// *
///  * A node's signature blessing some new history.
class HederaHistorySignature extends HederaProtoMessage with Equality {
  /// *
  ///    * The new history the node is signing.
  final HederaHistory? history;

  /// *
  ///    * The node's signature on the canonical serialization of
  ///    * the new history.
  final List<int>? signature;

  const HederaHistorySignature({this.history, this.signature});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [history, signature];

  HederaHistorySignature copyWith({
    HederaHistory? history,

    List<int>? signature,
  }) {
    return HederaHistorySignature(
      history: history ?? this.history,
      signature: signature ?? this.signature,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'history': config.encodeMessage(history),
      'signature': config.encodeBinary(signature),
    };
  }

  factory HederaHistorySignature.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHistorySignature(
      history: json.valueTo<HederaHistory?, Object>(
        key: 'history',
        parse:
            (v) =>
                HederaHistory.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signature: config.decodeBinary<List<int>?>(
        json.valueAs('signature', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaHistorySignature.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHistorySignature(
      history: decode.messageTo<HederaHistory?>(
        1,
        (b) => HederaHistory.deserialize(b),
      ),
      signature: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHistoryHistorySignature;
}

/// *
///  * A signature on some new history recorded at a certain time.
class HederaRecordedHistorySignature extends HederaProtoMessage with Equality {
  /// *
  ///    * The time at which the signature was recorded.
  final proto_timestamp.HederaTimestamp? signingTime;

  /// *
  ///    * The signature on some new history.
  final HederaHistorySignature? historySignature;

  const HederaRecordedHistorySignature({
    this.signingTime,
    this.historySignature,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [signingTime, historySignature];

  HederaRecordedHistorySignature copyWith({
    proto_timestamp.HederaTimestamp? signingTime,

    HederaHistorySignature? historySignature,
  }) {
    return HederaRecordedHistorySignature(
      signingTime: signingTime ?? this.signingTime,
      historySignature: historySignature ?? this.historySignature,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'signing_time': config.encodeMessage(signingTime),
      'history_signature': config.encodeMessage(historySignature),
    };
  }

  factory HederaRecordedHistorySignature.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRecordedHistorySignature(
      signingTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'signing_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      historySignature: json.valueTo<HederaHistorySignature?, Object>(
        key: 'history_signature',
        parse:
            (v) => HederaHistorySignature.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaRecordedHistorySignature.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRecordedHistorySignature(
      signingTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        1,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      historySignature: decode.messageTo<HederaHistorySignature?>(
        2,
        (b) => HederaHistorySignature.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeStateHistoryRecordedHistorySignature;
}

/// *
///  * A message published by a node during a WRAPS proof construction.
class HederaWrapsMessageDetails extends HederaProtoMessage with Equality {
  /// *
  ///    * The time at which the message was published.
  final proto_timestamp.HederaTimestamp? publicationTime;

  /// *
  ///    * The phase of the construction the message applies to.
  final HederaWrapsPhase? phase;

  /// *
  ///    * The message itself.
  final List<int>? message;

  const HederaWrapsMessageDetails({
    this.publicationTime,
    this.phase,
    this.message,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.enumType(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [publicationTime, phase, message];

  HederaWrapsMessageDetails copyWith({
    proto_timestamp.HederaTimestamp? publicationTime,

    HederaWrapsPhase? phase,

    List<int>? message,
  }) {
    return HederaWrapsMessageDetails(
      publicationTime: publicationTime ?? this.publicationTime,
      phase: phase ?? this.phase,
      message: message ?? this.message,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'publication_time': config.encodeMessage(publicationTime),
      'phase': config.encodeEnum(phase),
      'message': config.encodeBinary(message),
    };
  }

  factory HederaWrapsMessageDetails.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaWrapsMessageDetails(
      publicationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'publication_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      phase: json.valueTo<HederaWrapsPhase?, Object?>(
        key: 'phase',
        parse: (v) => HederaWrapsPhase.from(v),
      ),
      message: config.decodeBinary<List<int>?>(
        json.valueAs('message', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaWrapsMessageDetails.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaWrapsMessageDetails(
      publicationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        1,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      phase: decode.getEnum<HederaWrapsPhase?>(2, HederaWrapsPhase.values),
      message: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeStateHistoryWrapsMessageDetails;
}

/// *
///  * A history of messages published during a WRAPS proof construction.
class HederaWrapsMessageHistory extends HederaProtoMessage with Equality {
  /// * The published messages.
  final List<HederaWrapsMessageDetails> messages;

  const HederaWrapsMessageHistory({this.messages = const []});

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
  List<Object?> get protoValues => [messages];

  HederaWrapsMessageHistory copyWith({
    List<HederaWrapsMessageDetails>? messages,
  }) {
    return HederaWrapsMessageHistory(messages: messages ?? this.messages);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'messages': messages.map((e) => config.encodeMessage(e)).toList()};
  }

  factory HederaWrapsMessageHistory.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaWrapsMessageHistory(
      messages:
          (json.valueEnsureAsList<dynamic>(
                'messages',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaWrapsMessageDetails, Object>(
                  value: e,
                  parse:
                      (v) => HederaWrapsMessageDetails.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaWrapsMessageHistory.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaWrapsMessageHistory(
      messages:
          decode
              .getListOfBytes(1)
              .map((b) => HederaWrapsMessageDetails.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeStateHistoryWrapsMessageHistory;
}

class HederaChainOfTrustProof extends HederaProtoMessage with Equality {
  /// *
  ///          * If there is not yet a SNARK proving the chain of trust from ledger id to
  ///          * the hinTS verification key, an aggregation of Schnorr signatures on
  ///          * the concatenation of the ledger id and genesis hinTS verification key
  ///          * that serve as witnesses for the SNARK prover algorithm.
  final HederaAggregatedNodeSignatures? aggregatedNodeSignatures;

  /// *
  ///          * If known, a ZK-compressed SNARK proof proving the chain of trust from
  ///          * the ledger id to this hinTS verification key.
  final List<int>? wrapsProof;

  const HederaChainOfTrustProof({
    this.aggregatedNodeSignatures,
    this.wrapsProof,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [aggregatedNodeSignatures, wrapsProof];

  HederaChainOfTrustProof copyWith({
    HederaAggregatedNodeSignatures? aggregatedNodeSignatures,

    List<int>? wrapsProof,
  }) {
    return HederaChainOfTrustProof(
      aggregatedNodeSignatures:
          aggregatedNodeSignatures ?? this.aggregatedNodeSignatures,
      wrapsProof: wrapsProof ?? this.wrapsProof,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'aggregated_node_signatures': config.encodeMessage(
        aggregatedNodeSignatures,
      ),
      'wraps_proof': config.encodeBinary(wrapsProof),
    };
  }

  factory HederaChainOfTrustProof.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaChainOfTrustProof(
      aggregatedNodeSignatures: json
          .valueTo<HederaAggregatedNodeSignatures?, Object>(
            key: 'aggregated_node_signatures',
            parse:
                (v) => HederaAggregatedNodeSignatures.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      wrapsProof: config.decodeBinary<List<int>?>(
        json.valueAs('wraps_proof', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaChainOfTrustProof.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaChainOfTrustProof(
      aggregatedNodeSignatures: decode
          .messageTo<HederaAggregatedNodeSignatures?>(
            1,
            (b) => HederaAggregatedNodeSignatures.deserialize(b),
          ),
      wrapsProof: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHistoryChainOfTrustProof;
}

/// *
///  * An aggregation of node signatures on some data.
///  * &lt;p&gt;
///  * Can be used to prove the genesis hinTS verification key in a block proof; but
///  * not succinct and not recursive; hence in normal operations with TSS, used only
///  * until the first recursive proof is available.
class HederaAggregatedNodeSignatures extends HederaProtoMessage with Equality {
  /// *
  ///    * The aggregated signature.
  final List<int>? aggregatedSignature;

  /// *
  ///    * In ascending order, the ids of the nodes that contributed signatures.
  final List<BigInt> signingNodeIds;

  /// *
  ///    * The hinTS key that this signature witnesses.
  final List<int>? verificationKey;

  const HederaAggregatedNodeSignatures({
    this.aggregatedSignature,
    this.signingNodeIds = const [],
    this.verificationKey,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.uint64,
        ),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    aggregatedSignature,
    signingNodeIds,
    verificationKey,
  ];

  HederaAggregatedNodeSignatures copyWith({
    List<int>? aggregatedSignature,

    List<BigInt>? signingNodeIds,

    List<int>? verificationKey,
  }) {
    return HederaAggregatedNodeSignatures(
      aggregatedSignature: aggregatedSignature ?? this.aggregatedSignature,
      signingNodeIds: signingNodeIds ?? this.signingNodeIds,
      verificationKey: verificationKey ?? this.verificationKey,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'aggregated_signature': config.encodeBinary(aggregatedSignature),
      'signing_node_ids':
          signingNodeIds.map((e) => config.encodeBigint(e)).toList(),
      'verification_key': config.encodeBinary(verificationKey),
    };
  }

  factory HederaAggregatedNodeSignatures.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaAggregatedNodeSignatures(
      aggregatedSignature: config.decodeBinary<List<int>?>(
        json.valueAs(
          'aggregated_signature',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      signingNodeIds:
          (json.valueEnsureAsList<dynamic>(
            'signing_node_ids',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
      verificationKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'verification_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaAggregatedNodeSignatures.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAggregatedNodeSignatures(
      aggregatedSignature: decode.getBytes<List<int>?>(1),
      signingNodeIds: decode.getListOrEmpty<BigInt>(2),
      verificationKey: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeStateHistoryAggregatedNodeSignatures;
}

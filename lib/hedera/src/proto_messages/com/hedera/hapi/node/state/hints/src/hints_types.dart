import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart"
    as google_protobuf_wrappers;

/// *
///  * The stage of a CRS construction.
enum HederaCRSStage implements ProtoEnumVariant {
  /// *
  ///      * The network is gathering contributions to the CRS from all nodes.
  gatheringContributions(0, 'GATHERING_CONTRIBUTIONS'),

  /// *
  ///      * The network is waiting for some grace period to allow the verification future
  ///      * to be completed after the last node has contributed to the CRS.
  waitingForAdoptingFinalCrs(1, 'WAITING_FOR_ADOPTING_FINAL_CRS'),

  /// *
  ///      * The network has completed the CRS construction and is set in the CrsState.
  completed(2, 'COMPLETED');

  const HederaCRSStage(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaCRSStage fromValue(int? value) {
    value ??= 0;
    return HederaCRSStage.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaCRSStage found for the given value. $value",
                details: {"name": "HederaCRSStage", "value": value?.toString()},
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaCRSStage from(Object? value) {
    value ??= 0;
    return HederaCRSStage.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaCRSStage found for the given value. $value",
                details: {"name": "HederaCRSStage", "value": value?.toString()},
              ),
    );
  }
}

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.hints"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * The id of a party in a hinTS scheme with a certain
///  * number of parties.
class HederaHintsPartyId extends HederaProtoMessage with Equality {
  /// *
  ///    * The party id, in the range [0, num_parties).
  final int? partyId;

  /// *
  ///    * The number of parties in the hinTS scheme.
  final int? numParties;

  const HederaHintsPartyId({this.partyId, this.numParties});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.uint32(1), ProtoFieldConfig.uint32(2)],
    );
  }

  @override
  List<Object?> get protoValues => [partyId, numParties];

  HederaHintsPartyId copyWith({int? partyId, int? numParties}) {
    return HederaHintsPartyId(
      partyId: partyId ?? this.partyId,
      numParties: numParties ?? this.numParties,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'party_id': partyId, 'num_parties': numParties};
  }

  factory HederaHintsPartyId.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHintsPartyId(
      partyId: json.valueAsInt<int?>(
        'party_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numParties: json.valueAsInt<int?>(
        'num_parties',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaHintsPartyId.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHintsPartyId(
      partyId: decode.getInt<int?>(1),
      numParties: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHintsHintsPartyId;
}

/// *
///  * A set of hinTS keys submitted by a node.
class HederaHintsKeySet extends HederaProtoMessage with Equality {
  /// *
  ///    * The id of the node submitting these keys.
  final BigInt? nodeId;

  /// *
  ///    * The consensus time at which the network adopted the active
  ///    * hinTS key in this set.
  final proto_timestamp.HederaTimestamp? adoptionTime;

  /// *
  ///    * The party's active hinTS key.
  final List<int>? key;

  /// *
  ///    * If set, the new hinTS key the node wants to use when
  ///    * the next construction begins.
  final List<int>? nextKey;

  const HederaHintsKeySet({
    this.nodeId,
    this.adoptionTime,
    this.key,
    this.nextKey,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [nodeId, adoptionTime, key, nextKey];

  HederaHintsKeySet copyWith({
    BigInt? nodeId,

    proto_timestamp.HederaTimestamp? adoptionTime,

    List<int>? key,

    List<int>? nextKey,
  }) {
    return HederaHintsKeySet(
      nodeId: nodeId ?? this.nodeId,
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
      'node_id': config.encodeBigint(nodeId),
      'adoption_time': config.encodeMessage(adoptionTime),
      'key': config.encodeBinary(key),
      'next_key': config.encodeBinary(nextKey),
    };
  }

  factory HederaHintsKeySet.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHintsKeySet(
      nodeId: json.valueAsBigInt<BigInt?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
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

  factory HederaHintsKeySet.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHintsKeySet(
      nodeId: decode.getBigInt<BigInt?>(1),
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
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHintsHintsKeySet;
}

/// *
///  * The output of the hinTS preprocessing algorithm; that is, a
///  * linear-size aggregation key and a succinct verification key.
class HederaPreprocessedKeys extends HederaProtoMessage with Equality {
  /// *
  ///    * The aggregation key for the hinTS scheme
  final List<int>? aggregationKey;

  /// *
  ///    * The succinct verification key for the hinTS scheme.
  final List<int>? verificationKey;

  const HederaPreprocessedKeys({this.aggregationKey, this.verificationKey});

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
  List<Object?> get protoValues => [aggregationKey, verificationKey];

  HederaPreprocessedKeys copyWith({
    List<int>? aggregationKey,

    List<int>? verificationKey,
  }) {
    return HederaPreprocessedKeys(
      aggregationKey: aggregationKey ?? this.aggregationKey,
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
      'aggregation_key': config.encodeBinary(aggregationKey),
      'verification_key': config.encodeBinary(verificationKey),
    };
  }

  factory HederaPreprocessedKeys.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaPreprocessedKeys(
      aggregationKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'aggregation_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      verificationKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'verification_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaPreprocessedKeys.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPreprocessedKeys(
      aggregationKey: decode.getBytes<List<int>?>(1),
      verificationKey: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHintsPreprocessedKeys;
}

/// *
///  * The id for a node's vote for the output of the
///  * preprocessing output of a hinTS construction.
class HederaPreprocessingVoteId extends HederaProtoMessage with Equality {
  /// *
  ///    * The construction this vote is connected to.
  final BigInt? constructionId;

  /// *
  ///    * The id of the node submitting the vote.
  final BigInt? nodeId;

  const HederaPreprocessingVoteId({this.constructionId, this.nodeId});

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

  HederaPreprocessingVoteId copyWith({BigInt? constructionId, BigInt? nodeId}) {
    return HederaPreprocessingVoteId(
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

  factory HederaPreprocessingVoteId.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaPreprocessingVoteId(
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

  factory HederaPreprocessingVoteId.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPreprocessingVoteId(
      constructionId: decode.getBigInt<BigInt?>(1),
      nodeId: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHintsPreprocessingVoteId;
}

/// *
///  * A node's vote for the consensus output of a hinTS preprocessing
///  * algorithm.
class HederaPreprocessingVote extends HederaProtoMessage with Equality {
  /// *
  ///      * The preprocessed keys this node is voting for.
  final HederaPreprocessedKeys? preprocessedKeys;

  /// *
  ///      * The id of any node that already voted for the exact keys
  ///      * that this node wanted to vote for.
  final BigInt? congruentNodeId;

  const HederaPreprocessingVote({this.preprocessedKeys, this.congruentNodeId});

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
  List<Object?> get protoValues => [preprocessedKeys, congruentNodeId];

  HederaPreprocessingVote copyWith({
    HederaPreprocessedKeys? preprocessedKeys,

    BigInt? congruentNodeId,
  }) {
    return HederaPreprocessingVote(
      preprocessedKeys: preprocessedKeys ?? this.preprocessedKeys,
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
      'preprocessed_keys': config.encodeMessage(preprocessedKeys),
      'congruent_node_id': config.encodeBigint(congruentNodeId),
    };
  }

  factory HederaPreprocessingVote.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaPreprocessingVote(
      preprocessedKeys: json.valueTo<HederaPreprocessedKeys?, Object>(
        key: 'preprocessed_keys',
        parse:
            (v) => HederaPreprocessedKeys.fromJson(
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

  factory HederaPreprocessingVote.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPreprocessingVote(
      preprocessedKeys: decode.messageTo<HederaPreprocessedKeys?>(
        1,
        (b) => HederaPreprocessedKeys.deserialize(b),
      ),
      congruentNodeId: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHintsPreprocessingVote;
}

/// *
///  * A node's weighted hinTS party id.
class HederaNodePartyId extends HederaProtoMessage with Equality {
  /// *
  ///    * The node id.
  final BigInt? nodeId;

  /// *
  ///    * The party id.
  final int? partyId;

  /// *
  ///    * The party's weight in the construction.
  final BigInt? partyWeight;

  const HederaNodePartyId({this.nodeId, this.partyId, this.partyWeight});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.uint32(2),
        ProtoFieldConfig.uint64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [nodeId, partyId, partyWeight];

  HederaNodePartyId copyWith({
    BigInt? nodeId,

    int? partyId,

    BigInt? partyWeight,
  }) {
    return HederaNodePartyId(
      nodeId: nodeId ?? this.nodeId,
      partyId: partyId ?? this.partyId,
      partyWeight: partyWeight ?? this.partyWeight,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'node_id': config.encodeBigint(nodeId),
      'party_id': partyId,
      'party_weight': config.encodeBigint(partyWeight),
    };
  }

  factory HederaNodePartyId.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNodePartyId(
      nodeId: json.valueAsBigInt<BigInt?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      partyId: json.valueAsInt<int?>(
        'party_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      partyWeight: json.valueAsBigInt<BigInt?>(
        'party_weight',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaNodePartyId.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodePartyId(
      nodeId: decode.getBigInt<BigInt?>(1),
      partyId: decode.getInt<int?>(2),
      partyWeight: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHintsNodePartyId;
}

/// *
///  * The information constituting the hinTS scheme Hiero TSS.
class HederaHintsScheme extends HederaProtoMessage with Equality {
  /// *
  ///    * The aggregation and verification keys for the scheme.
  final HederaPreprocessedKeys? preprocessedKeys;

  /// *
  ///    * The final party ids assigned to each node in the target roster.
  final List<HederaNodePartyId> nodePartyIds;

  const HederaHintsScheme({
    this.preprocessedKeys,
    this.nodePartyIds = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [preprocessedKeys, nodePartyIds];

  HederaHintsScheme copyWith({
    HederaPreprocessedKeys? preprocessedKeys,

    List<HederaNodePartyId>? nodePartyIds,
  }) {
    return HederaHintsScheme(
      preprocessedKeys: preprocessedKeys ?? this.preprocessedKeys,
      nodePartyIds: nodePartyIds ?? this.nodePartyIds,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'preprocessed_keys': config.encodeMessage(preprocessedKeys),
      'node_party_ids':
          nodePartyIds.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaHintsScheme.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHintsScheme(
      preprocessedKeys: json.valueTo<HederaPreprocessedKeys?, Object>(
        key: 'preprocessed_keys',
        parse:
            (v) => HederaPreprocessedKeys.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodePartyIds:
          (json.valueEnsureAsList<dynamic>(
                'node_party_ids',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaNodePartyId, Object>(
                  value: e,
                  parse:
                      (v) => HederaNodePartyId.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaHintsScheme.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHintsScheme(
      preprocessedKeys: decode.messageTo<HederaPreprocessedKeys?>(
        1,
        (b) => HederaPreprocessedKeys.deserialize(b),
      ),
      nodePartyIds:
          decode
              .getListOfBytes(2)
              .map((b) => HederaNodePartyId.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHintsHintsScheme;
}

/// *
///  * A summary of progress in constructing a hinTS scheme.
class HederaHintsConstruction extends HederaProtoMessage with Equality {
  /// *
  ///    * The id of the construction.
  final BigInt? constructionId;

  /// *
  ///    * The hash of the roster whose weights are used to determine when
  ///    * the &gt;=1/3 weight signing threshold is reached.
  final List<int>? sourceRosterHash;

  /// *
  ///    * The hash of the roster whose weights are used to determine when
  ///    * the &gt;2/3 weight availability threshold is reached.
  final List<int>? targetRosterHash;

  /// *
  ///      * If the network is still gathering hinTS keys for this construction,
  ///      * the time at which honest nodes should stop waiting for tardy
  ///      * publications and begin preprocessing as soon as there are valid
  ///      * hinTS keys for nodes with &gt;2/3 weight in the target roster.
  final proto_timestamp.HederaTimestamp? gracePeriodEndTime;

  /// *
  ///      * If the network has gathered enough hinTS keys for this construction
  ///      * to begin preprocessing, the cutoff time by which keys must have been
  ///      * adopted to be included as input to the preprocessing algorithm.
  final proto_timestamp.HederaTimestamp? preprocessingStartTime;

  /// *
  ///      * If set, the completed hinTS scheme.
  final HederaHintsScheme? hintsScheme;

  const HederaHintsConstruction({
    this.constructionId,
    this.sourceRosterHash,
    this.targetRosterHash,
    this.gracePeriodEndTime,
    this.preprocessingStartTime,
    this.hintsScheme,
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
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    constructionId,
    sourceRosterHash,
    targetRosterHash,
    gracePeriodEndTime,
    preprocessingStartTime,
    hintsScheme,
  ];

  HederaHintsConstruction copyWith({
    BigInt? constructionId,

    List<int>? sourceRosterHash,

    List<int>? targetRosterHash,

    proto_timestamp.HederaTimestamp? gracePeriodEndTime,

    proto_timestamp.HederaTimestamp? preprocessingStartTime,

    HederaHintsScheme? hintsScheme,
  }) {
    return HederaHintsConstruction(
      constructionId: constructionId ?? this.constructionId,
      sourceRosterHash: sourceRosterHash ?? this.sourceRosterHash,
      targetRosterHash: targetRosterHash ?? this.targetRosterHash,
      gracePeriodEndTime: gracePeriodEndTime ?? this.gracePeriodEndTime,
      preprocessingStartTime:
          preprocessingStartTime ?? this.preprocessingStartTime,
      hintsScheme: hintsScheme ?? this.hintsScheme,
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
      'preprocessing_start_time': config.encodeMessage(preprocessingStartTime),
      'hints_scheme': config.encodeMessage(hintsScheme),
    };
  }

  factory HederaHintsConstruction.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHintsConstruction(
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
      preprocessingStartTime: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'preprocessing_start_time',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      hintsScheme: json.valueTo<HederaHintsScheme?, Object>(
        key: 'hints_scheme',
        parse:
            (v) => HederaHintsScheme.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaHintsConstruction.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHintsConstruction(
      constructionId: decode.getBigInt<BigInt?>(1),
      sourceRosterHash: decode.getBytes<List<int>?>(2),
      targetRosterHash: decode.getBytes<List<int>?>(3),
      gracePeriodEndTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        4,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      preprocessingStartTime: decode
          .messageTo<proto_timestamp.HederaTimestamp?>(
            5,
            (b) => proto_timestamp.HederaTimestamp.deserialize(b),
          ),
      hintsScheme: decode.messageTo<HederaHintsScheme?>(
        6,
        (b) => HederaHintsScheme.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHintsHintsConstruction;
}

/// *
///  * The state of a CRS construction.
class HederaCRSState extends HederaProtoMessage with Equality {
  /// *
  ///      * The bytes of the CRS. Based on the CRSStage, this may be the initial CRS
  ///      * or the final CRS.
  final List<int>? crs;

  /// *
  ///      * The stage of the CRS construction.
  final HederaCRSStage? stage;

  /// *
  ///      * The id of the next node that should contribute to the CRS. This is used
  ///      * to ensure that all nodes contribute to the CRS in a round-robin fashion.
  ///      * If this is null, then all nodes in the network have contributed to the CRS.
  final google_protobuf_wrappers.HederaUInt64Value? nextContributingNodeId;

  /// *
  ///      * The time at which the network should stop waiting for the node's contributions
  ///      * and move on to the next node in the round-robin fashion.
  final proto_timestamp.HederaTimestamp? contributionEndTime;

  const HederaCRSState({
    this.crs,
    this.stage,
    this.nextContributingNodeId,
    this.contributionEndTime,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.enumType(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    crs,
    stage,
    nextContributingNodeId,
    contributionEndTime,
  ];

  HederaCRSState copyWith({
    List<int>? crs,

    HederaCRSStage? stage,

    google_protobuf_wrappers.HederaUInt64Value? nextContributingNodeId,

    proto_timestamp.HederaTimestamp? contributionEndTime,
  }) {
    return HederaCRSState(
      crs: crs ?? this.crs,
      stage: stage ?? this.stage,
      nextContributingNodeId:
          nextContributingNodeId ?? this.nextContributingNodeId,
      contributionEndTime: contributionEndTime ?? this.contributionEndTime,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'crs': config.encodeBinary(crs),
      'stage': config.encodeEnum(stage),
      'next_contributing_node_id': config.encodeMessage(nextContributingNodeId),
      'contribution_end_time': config.encodeMessage(contributionEndTime),
    };
  }

  factory HederaCRSState.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCRSState(
      crs: config.decodeBinary<List<int>?>(
        json.valueAs('crs', normalizeKeyLookup: config.normalizeKeys),
      ),
      stage: json.valueTo<HederaCRSStage?, Object?>(
        key: 'stage',
        parse: (v) => HederaCRSStage.from(v),
      ),
      nextContributingNodeId: json
          .valueTo<google_protobuf_wrappers.HederaUInt64Value?, Object>(
            key: 'next_contributing_node_id',
            parse:
                (v) => google_protobuf_wrappers.HederaUInt64Value.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      contributionEndTime: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'contribution_end_time',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaCRSState.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCRSState(
      crs: decode.getBytes<List<int>?>(1),
      stage: decode.getEnum<HederaCRSStage?>(2, HederaCRSStage.values),
      nextContributingNodeId: decode
          .messageTo<google_protobuf_wrappers.HederaUInt64Value?>(
            3,
            (b) => google_protobuf_wrappers.HederaUInt64Value.deserialize(b),
          ),
      contributionEndTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        4,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHintsCRSState;
}

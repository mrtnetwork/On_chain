// GENERATED CODE - DO NOT MODIFY BY HAND
// Source: OpenAPI 3.0.0
// Smart Rollup Node RPCs Octez 25.1 (04d849eb)

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Free-form JSON object (OpenAPI schema `error` had no type).
typedef OctezRollupError = Map<String, dynamic>;

typedef OctezRollupSmartRollupAddress = OctezRollupUnistring;

typedef OctezRollupSmartRollupCommitmentHash = OctezRollupUnistring;

typedef OctezRollupSmartRollupStateHash = OctezRollupUnistring;

/// Decimal representation of 64 bit integers
typedef OctezRollupInt64 = String;

typedef OctezRollupSignaturePublicKeyHash = OctezRollupUnistring;

/// Decimal representation of a positive big number
typedef OctezRollupPositiveBignum = String;

typedef OctezRollupDalCommitment = OctezRollupUnistring;

/// One million mutez make a tez (1 tez = 1e6 mutez)
typedef OctezRollupMutez = OctezRollupPositiveBignum;

/// Decimal representation of a big number
typedef OctezRollupBignum = String;

/// One thousand nanotez make a mutez (1 tez = 1e9 nanotez)
typedef OctezRollupNanotez = List<OctezRollupBignum>;

typedef OctezRollupBlockHash = OctezRollupUnistring;

typedef OctezRollupSmartRollupContextHash = OctezRollupUnistring;

typedef OctezRollupSmartRollupMerkelizedPayloadHashesHash =
    OctezRollupUnistring;

typedef OctezRollupSmartRollupInboxHash = OctezRollupUnistring;

/// A date in RFC 3339 notation.
typedef OctezRollupTimestampRfc = OctezRollupUnistring;

/// A contract notation as given to an RPC or inside scripts. Can be a base58 originated contract hash.
typedef OctezRollupN025PsUshuaiContractIdOriginated = OctezRollupUnistring;

/// A timestamp as seen by the protocol: second-level precision, epoch based.
typedef OctezRollupTimestampProtocol = OctezRollupUnistring;

/// Exception
typedef OctezRollupException = OctezRollupUnistring;

typedef OctezRollupScRollupL2MessageId = OctezRollupUnistring;

/// A hex encoded smart rollup message
typedef OctezRollupScL2Message = String;

typedef OctezRollupOperationHash = OctezRollupUnistring;

typedef OctezRollupInjectorOperationHash = OctezRollupUnistring;

enum OctezRollupResponseAdminInjectorQueuesItemTagsItem {
  addMessages("add_messages"),
  publish("publish"),
  refute("refute"),
  recover("recover"),
  timeout("timeout"),
  publishDalCommitment("publish_dal_commitment"),
  cement("cement"),
  executeOutboxMessage("execute_outbox_message");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemTagsItem(this.value);

  static OctezRollupResponseAdminInjectorQueuesItemTagsItem fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemTagsItem.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesKind {
  addMessages("add_messages");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesKind(
    this.value,
  );

  static OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseAdminInjectorQueuesItemQueueItemCementKind {
  cement("cement");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemCementKind(
    this.value,
  );

  static OctezRollupResponseAdminInjectorQueuesItemQueueItemCementKind fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemQueueItemCementKind.",
              ),
    );
  }

  String toJson() => value;
}

/// Either a plain UTF8 string, or a sequence of bytes for strings that contain invalid byte sequences.
sealed class OctezRollupUnistring {
  const OctezRollupUnistring();

  factory OctezRollupUnistring.fromJson(dynamic json) {
    if (json is String) return OctezRollupUnistringStringValue(json);
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('invalid_utf8_string')) {
        return OctezRollupUnistringInvalidUtf8String.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupUnistring',
      reason: 'Cannot parse OctezRollupUnistring from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupUnistringStringValue extends OctezRollupUnistring {
  final String value;
  const OctezRollupUnistringStringValue(this.value);

  @override
  dynamic toJson() => value;
}

class OctezRollupUnistringInvalidUtf8String extends OctezRollupUnistring {
  final BuBytes invalidUtf8String;

  OctezRollupUnistringInvalidUtf8String({required List<int> invalidUtf8String})
    : invalidUtf8String = invalidUtf8String.asImmutableBytes;

  factory OctezRollupUnistringInvalidUtf8String.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupUnistringInvalidUtf8String(
      invalidUtf8String: json.valueAsList<List<int>>('invalid_utf8_string'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'invalid_utf8_string': invalidUtf8String,
      }.notNullValue.cast<String, dynamic>();
}

enum OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishKind {
  publish("publish");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishKind(
    this.value,
  );

  static OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteKind {
  refute("refute");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteKind(
    this.value,
  );

  static OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteKind fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStartRefutationKind {
  start("start");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStartRefutationKind(
    this.value,
  );

  static OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStartRefutationKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStartRefutationKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveRefutationKind {
  move("move");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveRefutationKind(
    this.value,
  );

  static OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveRefutationKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveRefutationKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStep {
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStep();

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStep.fromJson(
    dynamic json,
  ) {
    if (json is List) {
      return OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepDissection(
        (json)
            .map(
              (e) =>
                  OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepDissectionItem.fromJson(
                    e,
                  ),
            )
            .toList(),
      );
    }
    if (json is String) {
      return OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepProof(
        json,
      );
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStep',
      reason:
          'Cannot parse OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStep from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepDissection
    extends
        OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStep {
  final List<
    OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepDissectionItem
  >
  value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepDissection(
    this.value,
  );

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepProof
    extends
        OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStep {
  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepProof(
    this.value,
  );

  @override
  dynamic toJson() => value;
}

sealed class OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation {
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation();

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['refutation_kind'] == "start" &&
          map.hasValue('player_commitment_hash') &&
          map.hasValue('opponent_commitment_hash')) {
        return OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStart.fromJson(
          map,
        );
      }
      if (map['refutation_kind'] == "move" &&
          map.hasValue('choice') &&
          map.hasValue('step')) {
        return OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMove.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation',
      reason:
          'Cannot parse OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStart
    extends
        OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStartRefutationKind
  refutationKind;
  final OctezRollupSmartRollupCommitmentHash playerCommitmentHash;
  final OctezRollupSmartRollupCommitmentHash opponentCommitmentHash;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStart({
    required this.refutationKind,
    required this.playerCommitmentHash,
    required this.opponentCommitmentHash,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStart.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStart(
      refutationKind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationStartRefutationKind.fromJson(
            json['refutation_kind'],
          ),
      playerCommitmentHash: OctezRollupUnistring.fromJson(
        json['player_commitment_hash'],
      ),
      opponentCommitmentHash: OctezRollupUnistring.fromJson(
        json['opponent_commitment_hash'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'refutation_kind': refutationKind.toJson(),
        'player_commitment_hash': playerCommitmentHash.toJson(),
        'opponent_commitment_hash': opponentCommitmentHash.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMove
    extends
        OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveRefutationKind
  refutationKind;
  final OctezRollupPositiveBignum choice;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStep
  step;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMove({
    required this.refutationKind,
    required this.choice,
    required this.step,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMove.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMove(
      refutationKind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveRefutationKind.fromJson(
            json['refutation_kind'],
          ),
      choice:
          (json['choice'] is num
              ? json['choice'].toString()
              : json.valueAsString('choice')),
      step:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStep.fromJson(
            json['step'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'refutation_kind': refutationKind.toJson(),
        'choice': choice,
        'step': step.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

enum OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutKind {
  timeout("timeout");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutKind(
    this.value,
  );

  static OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseAdminInjectorQueuesItemQueueItemRecoverKind {
  recover("recover");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRecoverKind(
    this.value,
  );

  static OctezRollupResponseAdminInjectorQueuesItemQueueItemRecoverKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemQueueItemRecoverKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessageKind {
  executeOutboxMessage("execute_outbox_message");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessageKind(
    this.value,
  );

  static OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessageKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessageKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitmentKind {
  publishDalCommitment("publish_dal_commitment");

  final String value;
  const OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitmentKind(
    this.value,
  );

  static OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitmentKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitmentKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupResponseAdminInjectorQueuesItemQueueItem {
  const OctezRollupResponseAdminInjectorQueuesItemQueueItem();

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['kind'] == "refute" &&
          map.hasValue('rollup') &&
          map.hasValue('opponent') &&
          map.hasValue('refutation')) {
        return OctezRollupResponseAdminInjectorQueuesItemQueueItemRefute.fromJson(
          map,
        );
      }
      if (map['kind'] == "execute_outbox_message" &&
          map.hasValue('rollup') &&
          map.hasValue('cemented_commitment') &&
          map.hasValue('proof')) {
        return OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessage.fromJson(
          map,
        );
      }
      if (map['kind'] == "publish_dal_commitment" &&
          map.hasValue('slot_index') &&
          map.hasValue('commitment') &&
          map.hasValue('commitment_proof')) {
        return OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitment.fromJson(
          map,
        );
      }
      if (map['kind'] == "timeout" &&
          map.hasValue('rollup') &&
          map.hasValue('stakers')) {
        return OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeout.fromJson(
          map,
        );
      }
      if (map['kind'] == "recover" &&
          map.hasValue('rollup') &&
          map.hasValue('staker')) {
        return OctezRollupResponseAdminInjectorQueuesItemQueueItemRecover.fromJson(
          map,
        );
      }
      if (map['kind'] == "cement" &&
          map.hasValue('rollup') &&
          map.hasValue('commitment')) {
        return OctezRollupResponseAdminInjectorQueuesItemQueueItemCement.fromJson(
          map,
        );
      }
      if (map['kind'] == "publish" &&
          map.hasValue('rollup') &&
          map.hasValue('commitment')) {
        return OctezRollupResponseAdminInjectorQueuesItemQueueItemPublish.fromJson(
          map,
        );
      }
      if (map['kind'] == "add_messages" && map.hasValue('message')) {
        return OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessages.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseAdminInjectorQueuesItemQueueItem',
      reason:
          'Cannot parse OctezRollupResponseAdminInjectorQueuesItemQueueItem from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessages
    extends OctezRollupResponseAdminInjectorQueuesItemQueueItem {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesKind kind;
  final List<String> message;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?
  errors;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessages({
    required this.kind,
    required this.message,
    this.errors,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessages.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessages(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesKind.fromJson(
            json['kind'],
          ),
      message: json.valueAsList<List<String>>('message'),
      errors: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?,
        Map<String, dynamic>
      >(
        key: 'errors',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'message': message,
        'errors': errors?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemCement
    extends OctezRollupResponseAdminInjectorQueuesItemQueueItem {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemCementKind kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupSmartRollupCommitmentHash commitment;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?
  errors;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemCement({
    required this.kind,
    required this.rollup,
    required this.commitment,
    this.errors,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemCement.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemCement(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemCementKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      commitment: OctezRollupUnistring.fromJson(json['commitment']),
      errors: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?,
        Map<String, dynamic>
      >(
        key: 'errors',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'commitment': commitment.toJson(),
        'errors': errors?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemPublish
    extends OctezRollupResponseAdminInjectorQueuesItemQueueItem {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishKind kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment
  commitment;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?
  errors;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemPublish({
    required this.kind,
    required this.rollup,
    required this.commitment,
    this.errors,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemPublish.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemPublish(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      commitment: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment,
        Map<String, dynamic>
      >(
        key: 'commitment',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment.fromJson(
                  v,
                ),
      ),
      errors: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?,
        Map<String, dynamic>
      >(
        key: 'errors',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'commitment': commitment.toJson(),
        'errors': errors?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemRefute
    extends OctezRollupResponseAdminInjectorQueuesItemQueueItem {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteKind kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupSignaturePublicKeyHash opponent;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation
  refutation;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?
  errors;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefute({
    required this.kind,
    required this.rollup,
    required this.opponent,
    required this.refutation,
    this.errors,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemRefute.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemRefute(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      opponent: OctezRollupUnistring.fromJson(json['opponent']),
      refutation:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation.fromJson(
            json['refutation'],
          ),
      errors: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?,
        Map<String, dynamic>
      >(
        key: 'errors',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'opponent': opponent.toJson(),
        'refutation': refutation.toJson(),
        'errors': errors?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeout
    extends OctezRollupResponseAdminInjectorQueuesItemQueueItem {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutKind kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutStakers
  stakers;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?
  errors;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeout({
    required this.kind,
    required this.rollup,
    required this.stakers,
    this.errors,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeout.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeout(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      stakers: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutStakers,
        Map<String, dynamic>
      >(
        key: 'stakers',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutStakers.fromJson(
                  v,
                ),
      ),
      errors: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?,
        Map<String, dynamic>
      >(
        key: 'errors',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'stakers': stakers.toJson(),
        'errors': errors?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemRecover
    extends OctezRollupResponseAdminInjectorQueuesItemQueueItem {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemRecoverKind kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupSignaturePublicKeyHash staker;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?
  errors;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRecover({
    required this.kind,
    required this.rollup,
    required this.staker,
    this.errors,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemRecover.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemRecover(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemRecoverKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      staker: OctezRollupUnistring.fromJson(json['staker']),
      errors: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?,
        Map<String, dynamic>
      >(
        key: 'errors',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'staker': staker.toJson(),
        'errors': errors?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessage
    extends OctezRollupResponseAdminInjectorQueuesItemQueueItem {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessageKind
  kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupSmartRollupCommitmentHash cementedCommitment;
  final String proof;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?
  errors;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessage({
    required this.kind,
    required this.rollup,
    required this.cementedCommitment,
    required this.proof,
    this.errors,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessage(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessageKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      cementedCommitment: OctezRollupUnistring.fromJson(
        json['cemented_commitment'],
      ),
      proof:
          (json['proof'] is num
              ? json['proof'].toString()
              : json.valueAsString('proof')),
      errors: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?,
        Map<String, dynamic>
      >(
        key: 'errors',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'cemented_commitment': cementedCommitment.toJson(),
        'proof': proof,
        'errors': errors?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitment
    extends OctezRollupResponseAdminInjectorQueuesItemQueueItem {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitmentKind
  kind;
  final int slotIndex;
  final OctezRollupDalCommitment commitment;
  final String commitmentProof;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?
  errors;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitment({
    required this.kind,
    required this.slotIndex,
    required this.commitment,
    required this.commitmentProof,
    this.errors,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitment.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitment(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitmentKind.fromJson(
            json['kind'],
          ),
      slotIndex: json.valueAsInt('slot_index'),
      commitment: OctezRollupUnistring.fromJson(json['commitment']),
      commitmentProof:
          (json['commitment_proof'] is num
              ? json['commitment_proof'].toString()
              : json.valueAsString('commitment_proof')),
      errors: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors?,
        Map<String, dynamic>
      >(
        key: 'errors',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'slot_index': slotIndex,
        'commitment': commitment.toJson(),
        'commitment_proof': commitmentProof,
        'errors': errors?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValue {
  const OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValue();

  factory OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValue.fromJson(
    dynamic json,
  ) {
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValue',
      reason:
          'Cannot parse OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValue from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValueSignaturePublicKeyHash
    extends
        OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValue {
  final OctezRollupSignaturePublicKeyHash value;
  const OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValueSignaturePublicKeyHash(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class OctezRollupResponseConfigSmartRollupNodeOperatorOperating {
  const OctezRollupResponseConfigSmartRollupNodeOperatorOperating();

  factory OctezRollupResponseConfigSmartRollupNodeOperatorOperating.fromJson(
    dynamic json,
  ) {
    if (json is List) {
      return OctezRollupResponseConfigSmartRollupNodeOperatorOperatingMultipleOperator(
        (json)
            .map((e) => OctezRollupSignaturePublicKeyHash.fromJson(e))
            .toList(),
      );
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperator(
          OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValue.fromJson(
            map,
          ),
        );
      } catch (_) {}
    }
    try {
      return OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperator(
        OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValue.fromJson(
          json,
        ),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseConfigSmartRollupNodeOperatorOperating',
      reason:
          'Cannot parse OctezRollupResponseConfigSmartRollupNodeOperatorOperating from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperator
    extends OctezRollupResponseConfigSmartRollupNodeOperatorOperating {
  final OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperatorValue
  value;
  const OctezRollupResponseConfigSmartRollupNodeOperatorOperatingSignaturePublicKeyHashOperator(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class OctezRollupResponseConfigSmartRollupNodeOperatorOperatingMultipleOperator
    extends OctezRollupResponseConfigSmartRollupNodeOperatorOperating {
  final List<OctezRollupSignaturePublicKeyHash> value;
  const OctezRollupResponseConfigSmartRollupNodeOperatorOperatingMultipleOperator(
    this.value,
  );

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

sealed class OctezRollupResponseConfigAclItem {
  const OctezRollupResponseConfigAclItem();

  factory OctezRollupResponseConfigAclItem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('address') && map.hasValue('whitelist')) {
        return OctezRollupResponseConfigAclItemWhitelist.fromJson(map);
      }
      if (map.hasValue('address') && map.hasValue('blacklist')) {
        return OctezRollupResponseConfigAclItemBlacklist.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseConfigAclItem',
      reason: 'Cannot parse OctezRollupResponseConfigAclItem from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseConfigAclItemWhitelist
    extends OctezRollupResponseConfigAclItem {
  final OctezRollupUnistring address;
  final List<OctezRollupUnistring> whitelist;

  const OctezRollupResponseConfigAclItemWhitelist({
    required this.address,
    required this.whitelist,
  });

  factory OctezRollupResponseConfigAclItemWhitelist.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigAclItemWhitelist(
      address: OctezRollupUnistring.fromJson(json['address']),
      whitelist:
          json
              .valueEnsureAsList<dynamic>('whitelist')
              .map((e) => OctezRollupUnistring.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'address': address.toJson(),
        'whitelist': whitelist.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigAclItemBlacklist
    extends OctezRollupResponseConfigAclItem {
  final OctezRollupUnistring address;
  final List<OctezRollupUnistring> blacklist;

  const OctezRollupResponseConfigAclItemBlacklist({
    required this.address,
    required this.blacklist,
  });

  factory OctezRollupResponseConfigAclItemBlacklist.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigAclItemBlacklist(
      address: OctezRollupUnistring.fromJson(json['address']),
      blacklist:
          json
              .valueEnsureAsList<dynamic>('blacklist')
              .map((e) => OctezRollupUnistring.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'address': address.toJson(),
        'blacklist': blacklist.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupScRollupNodeMode {
  const OctezRollupScRollupNodeMode();

  factory OctezRollupScRollupNodeMode.fromJson(dynamic json) {
    if (json is String) {
      return switch (json) {
        'observer' => const OctezRollupScRollupNodeModeObserver(),
        'accuser' => const OctezRollupScRollupNodeModeAccuser(),
        'bailout' => const OctezRollupScRollupNodeModeBailout(),
        'batcher' => const OctezRollupScRollupNodeModeBatcher(),
        'maintenance' => const OctezRollupScRollupNodeModeMaintenance(),
        'operator' => const OctezRollupScRollupNodeModeOperator(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezRollupScRollupNodeMode',
            reason: 'Unknown OctezRollupScRollupNodeMode: $json',
          ),
      };
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('custom')) {
        return OctezRollupScRollupNodeModeCustom.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupScRollupNodeMode',
      reason: 'Cannot parse OctezRollupScRollupNodeMode from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupScRollupNodeModeCustom extends OctezRollupScRollupNodeMode {
  final List<OctezRollupResponseAdminInjectorQueuesItemTagsItem> custom;

  const OctezRollupScRollupNodeModeCustom({required this.custom});

  factory OctezRollupScRollupNodeModeCustom.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupScRollupNodeModeCustom(
      custom:
          json
              .valueEnsureAsList<dynamic>('custom')
              .map(
                (e) =>
                    OctezRollupResponseAdminInjectorQueuesItemTagsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'custom': custom.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupScRollupNodeModeObserver extends OctezRollupScRollupNodeMode {
  const OctezRollupScRollupNodeModeObserver();

  @override
  String toJson() => 'observer';
}

class OctezRollupScRollupNodeModeAccuser extends OctezRollupScRollupNodeMode {
  const OctezRollupScRollupNodeModeAccuser();

  @override
  String toJson() => 'accuser';
}

class OctezRollupScRollupNodeModeBailout extends OctezRollupScRollupNodeMode {
  const OctezRollupScRollupNodeModeBailout();

  @override
  String toJson() => 'bailout';
}

class OctezRollupScRollupNodeModeBatcher extends OctezRollupScRollupNodeMode {
  const OctezRollupScRollupNodeModeBatcher();

  @override
  String toJson() => 'batcher';
}

class OctezRollupScRollupNodeModeMaintenance
    extends OctezRollupScRollupNodeMode {
  const OctezRollupScRollupNodeModeMaintenance();

  @override
  String toJson() => 'maintenance';
}

class OctezRollupScRollupNodeModeOperator extends OctezRollupScRollupNodeMode {
  const OctezRollupScRollupNodeModeOperator();

  @override
  String toJson() => 'operator';
}

/// If enabled, the rollup node will issue wrong commitments (for test only!)
sealed class OctezRollupResponseConfigLoserMode {
  const OctezRollupResponseConfigLoserMode();

  factory OctezRollupResponseConfigLoserMode.fromJson(dynamic json) {
    if (json is List) {
      return OctezRollupResponseConfigLoserModeFailure(
        (json)
            .map(
              (e) => OctezRollupResponseConfigLoserModeFailureItem.fromJson(e),
            )
            .toList(),
      );
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('number_of_slots') &&
          map.hasValue('attestation_lag') &&
          map.hasValue('slot_size') &&
          map.hasValue('page_size')) {
        return OctezRollupResponseConfigLoserModeInvalidDalParameters.fromJson(
          map,
        );
      }
      if (map.hasValue('page_payload_strategy')) {
        return OctezRollupResponseConfigLoserModeInvalidDalPage.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseConfigLoserMode',
      reason: 'Cannot parse OctezRollupResponseConfigLoserMode from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseConfigLoserModeFailure
    extends OctezRollupResponseConfigLoserMode {
  final List<OctezRollupResponseConfigLoserModeFailureItem> value;
  const OctezRollupResponseConfigLoserModeFailure(this.value);

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

class OctezRollupResponseConfigLoserModeInvalidDalParameters
    extends OctezRollupResponseConfigLoserMode {
  final OctezRollupInt64 numberOfSlots;
  final OctezRollupInt64 attestationLag;
  final OctezRollupInt64 slotSize;
  final OctezRollupInt64 pageSize;

  const OctezRollupResponseConfigLoserModeInvalidDalParameters({
    required this.numberOfSlots,
    required this.attestationLag,
    required this.slotSize,
    required this.pageSize,
  });

  factory OctezRollupResponseConfigLoserModeInvalidDalParameters.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigLoserModeInvalidDalParameters(
      numberOfSlots:
          (json['number_of_slots'] is num
              ? json['number_of_slots'].toString()
              : json.valueAsString('number_of_slots')),
      attestationLag:
          (json['attestation_lag'] is num
              ? json['attestation_lag'].toString()
              : json.valueAsString('attestation_lag')),
      slotSize:
          (json['slot_size'] is num
              ? json['slot_size'].toString()
              : json.valueAsString('slot_size')),
      pageSize:
          (json['page_size'] is num
              ? json['page_size'].toString()
              : json.valueAsString('page_size')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'number_of_slots': numberOfSlots,
        'attestation_lag': attestationLag,
        'slot_size': slotSize,
        'page_size': pageSize,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigLoserModeInvalidDalPage
    extends OctezRollupResponseConfigLoserMode {
  final int? inboxLevel;
  final int? publishedLevel;
  final int? slotIndex;
  final int? pageIndex;
  final OctezRollupUnistring pagePayloadStrategy;

  const OctezRollupResponseConfigLoserModeInvalidDalPage({
    this.inboxLevel,
    this.publishedLevel,
    this.slotIndex,
    this.pageIndex,
    required this.pagePayloadStrategy,
  });

  factory OctezRollupResponseConfigLoserModeInvalidDalPage.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigLoserModeInvalidDalPage(
      inboxLevel: json.valueAsInt('inbox_level'),
      publishedLevel: json.valueAsInt('published_level'),
      slotIndex: json.valueAsInt('slot_index'),
      pageIndex: json.valueAsInt('page_index'),
      pagePayloadStrategy: OctezRollupUnistring.fromJson(
        json['page_payload_strategy'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'inbox_level': inboxLevel,
        'published_level': publishedLevel,
        'slot_index': slotIndex,
        'page_index': pageIndex,
        'page_payload_strategy': pagePayloadStrategy.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupResponseConfigUnsafePvmPatchesItem {
  const OctezRollupResponseConfigUnsafePvmPatchesItem();

  factory OctezRollupResponseConfigUnsafePvmPatchesItem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('increase_max_nb_tick')) {
        return OctezRollupResponseConfigUnsafePvmPatchesItemIncreaseMaxNbTick.fromJson(
          map,
        );
      }
      if (map.hasValue('patch_durable_storage')) {
        return OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStorage.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseConfigUnsafePvmPatchesItem',
      reason:
          'Cannot parse OctezRollupResponseConfigUnsafePvmPatchesItem from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseConfigUnsafePvmPatchesItemIncreaseMaxNbTick
    extends OctezRollupResponseConfigUnsafePvmPatchesItem {
  final OctezRollupInt64 increaseMaxNbTick;

  const OctezRollupResponseConfigUnsafePvmPatchesItemIncreaseMaxNbTick({
    required this.increaseMaxNbTick,
  });

  factory OctezRollupResponseConfigUnsafePvmPatchesItemIncreaseMaxNbTick.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigUnsafePvmPatchesItemIncreaseMaxNbTick(
      increaseMaxNbTick:
          (json['increase_max_nb_tick'] is num
              ? json['increase_max_nb_tick'].toString()
              : json.valueAsString('increase_max_nb_tick')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'increase_max_nb_tick': increaseMaxNbTick,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStorage
    extends OctezRollupResponseConfigUnsafePvmPatchesItem {
  final OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStoragePatchDurableStorage
  patchDurableStorage;

  const OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStorage({
    required this.patchDurableStorage,
  });

  factory OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStorage.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStorage(
      patchDurableStorage: json.valueTo<
        OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStoragePatchDurableStorage,
        Map<String, dynamic>
      >(
        key: 'patch_durable_storage',
        parse:
            (v) =>
                OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStoragePatchDurableStorage.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'patch_durable_storage': patchDurableStorage.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination {
  const OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination();

  factory OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination.fromJson(
    dynamic json,
  ) {
    if (json is String) {
      return switch (json) {
        'any' =>
          const OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestinationAny(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination',
            reason:
                'Unknown OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination: $json',
          ),
      };
    }
    if (json is List) {
      return OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestinationDestinationAmong(
        (json).map((e) => OctezRollupUnistring.fromJson(e)).toList(),
      );
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination',
      reason:
          'Cannot parse OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestinationAny
    extends
        OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination {
  const OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestinationAny();

  @override
  String toJson() => 'any';
}

class OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestinationDestinationAmong
    extends
        OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination {
  final List<OctezRollupUnistring> value;
  const OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestinationDestinationAmong(
    this.value,
  );

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

enum OctezRollupResponseConfigHistoryMode {
  full("full"),
  archive("archive");

  final String value;
  const OctezRollupResponseConfigHistoryMode(this.value);

  static OctezRollupResponseConfigHistoryMode fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseConfigHistoryMode.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseConfigCommitOnBlockValue {
  block("block");

  final String value;
  const OctezRollupResponseConfigCommitOnBlockValue(this.value);

  static OctezRollupResponseConfigCommitOnBlockValue fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseConfigCommitOnBlockValue.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseConfigCommitOnCommitmentValue {
  commitment("commitment");

  final String value;
  const OctezRollupResponseConfigCommitOnCommitmentValue(this.value);

  static OctezRollupResponseConfigCommitOnCommitmentValue fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseConfigCommitOnCommitmentValue.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupResponseConfigCommitOn {
  const OctezRollupResponseConfigCommitOn();

  factory OctezRollupResponseConfigCommitOn.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezRollupResponseConfigCommitOnBlock(
          OctezRollupResponseConfigCommitOnBlockValue.fromJson(map),
        );
      } catch (_) {}
      try {
        return OctezRollupResponseConfigCommitOnCommitment(
          OctezRollupResponseConfigCommitOnCommitmentValue.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return OctezRollupResponseConfigCommitOnBlock(
        OctezRollupResponseConfigCommitOnBlockValue.fromJson(json),
      );
    } catch (_) {}
    try {
      return OctezRollupResponseConfigCommitOnCommitment(
        OctezRollupResponseConfigCommitOnCommitmentValue.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseConfigCommitOn',
      reason: 'Cannot parse OctezRollupResponseConfigCommitOn from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseConfigCommitOnBlock
    extends OctezRollupResponseConfigCommitOn {
  final OctezRollupResponseConfigCommitOnBlockValue value;
  const OctezRollupResponseConfigCommitOnBlock(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class OctezRollupResponseConfigCommitOnCommitment
    extends OctezRollupResponseConfigCommitOn {
  final OctezRollupResponseConfigCommitOnCommitmentValue value;
  const OctezRollupResponseConfigCommitOnCommitment(this.value);

  @override
  dynamic toJson() => value.toJson();
}

enum OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetryFilterItem {
  finaliseUpdateLast("finalise_update_last"),
  interruptRemote("interrupt_remote"),
  minorLeaveBarrier("minor_leave_barrier"),
  finaliseUpdateFirst("finalise_update_first"),
  majorGcStw("major_gc_stw"),
  minorRememberedSetPromote("minor_remembered_set_promote"),
  explicitGcFullMajor("explicit_gc_full_major"),
  minorFinalizersOldify("minor_finalizers_oldify"),
  major("major"),
  minorFinalized("minor_finalized"),
  majorSlice("major_slice"),
  minorFinalizersAdmin("minor_finalizers_admin"),
  minorGlobalRoots("minor_global_roots"),
  minorLocalRoots("minor_local_roots"),
  stwHandler("stw_handler"),
  majorMarkRoots("major_mark_roots"),
  majorFinishMarking("major_finish_marking"),
  compactionEvacuate("compaction_evacuate"),
  explicitGcStat("explicit_gc_stat"),
  majorFinishCycle("major_finish_cycle"),
  majorGcCycleDomains("major_gc_cycle_domains"),
  compactionRelease("compaction_release"),
  compaction("compaction"),
  explicitGcCompact("explicit_gc_compact"),
  explicitGcMajor("explicit_gc_major"),
  explicitGcMajorSlice("explicit_gc_major_slice"),
  majorGcPhaseChange("major_gc_phase_change"),
  majorEpheSweep("major_ephe_sweep"),
  stwApiBarrier("stw_api_barrier"),
  majorFinishSweeping("major_finish_sweeping"),
  minorLocalRootsPromote("minor_local_roots_promote"),
  majorMark("major_mark"),
  majorMarkOpportunistic("major_mark_opportunistic"),
  explicitGcSet("explicit_gc_set"),
  minor("minor"),
  compactionForward("compaction_forward"),
  minorRememberedSet("minor_remembered_set"),
  majorSweep("major_sweep"),
  stwLeader("stw_leader"),
  minorClear("minor_clear"),
  domainResizeHeapReservation("domain_resize_heap_reservation"),
  explicitGcMinor("explicit_gc_minor"),
  majorEpheMark("major_ephe_mark");

  final String value;
  const OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetryFilterItem(
    this.value,
  );

  static OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetryFilterItem
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetryFilterItem.",
              ),
    );
  }

  String toJson() => value;
}

/// Enable or disable opentelemetry profiling
sealed class OctezRollupResponseConfigOpentelemetry {
  const OctezRollupResponseConfigOpentelemetry();

  factory OctezRollupResponseConfigOpentelemetry.fromJson(dynamic json) {
    if (json is bool) {
      return OctezRollupResponseConfigOpentelemetryOpentelemetryBoolean(json);
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('enable') &&
          map.hasValue('instance_id') &&
          map.hasValue('environment') &&
          map.hasValue('debug') &&
          map.hasValue('url_traces') &&
          map.hasValue('url_logs') &&
          map.hasValue('headers') &&
          map.hasValue('batch_traces') &&
          map.hasValue('batch_logs') &&
          map.hasValue('batch_timeout_ms') &&
          map.hasValue('gc_telemetry')) {
        return OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfig.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseConfigOpentelemetry',
      reason: 'Cannot parse OctezRollupResponseConfigOpentelemetry from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfig
    extends OctezRollupResponseConfigOpentelemetry {
  /// Enable opentelemetry profiling
  final bool? enable;

  /// Instance id to identify the node in Opentelemetry traces. Takes precedence over <'data_dir>/telemetry_id.
  final OctezRollupUnistring? instanceId;

  /// Deployment environment, used for Datadog tagging, will be extracted from env variable DD_ENV if null. See https://docs.datadoghq.com/getting_started/tagging/unified_service_tagging.
  final OctezRollupUnistring? environment;

  /// Enable debug mode
  final bool? debug;

  /// URL to send traces
  final OctezRollupUnistring? urlTraces;

  /// URL to send logs
  final OctezRollupUnistring? urlLogs;

  /// API headers sent to the endpoint
  final List<List<OctezRollupUnistring>>? headers;

  /// Batch traces
  final int? batchTraces;

  /// Batch logs
  final int? batchLogs;

  /// Milliseconds after which we emit a batch, even incomplete
  final int? batchTimeoutMs;

  /// Enable traces for GC events (costly)
  final OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetry?
  gcTelemetry;

  const OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfig({
    this.enable,
    this.instanceId,
    this.environment,
    this.debug,
    this.urlTraces,
    this.urlLogs,
    this.headers,
    this.batchTraces,
    this.batchLogs,
    this.batchTimeoutMs,
    this.gcTelemetry,
  });

  factory OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfig.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfig(
      enable: json.valueAsBool('enable'),
      instanceId:
          json.hasValue('instance_id')
              ? OctezRollupUnistring.fromJson(json['instance_id'])
              : null,
      environment:
          json.hasValue('environment')
              ? OctezRollupUnistring.fromJson(json['environment'])
              : null,
      debug: json.valueAsBool('debug'),
      urlTraces:
          json.hasValue('url_traces')
              ? OctezRollupUnistring.fromJson(json['url_traces'])
              : null,
      urlLogs:
          json.hasValue('url_logs')
              ? OctezRollupUnistring.fromJson(json['url_logs'])
              : null,
      headers:
          json.hasValue('headers')
              ? json
                  .valueEnsureAsList<dynamic>('headers')
                  .map(
                    (e) =>
                        (e as List)
                            .map((e) => OctezRollupUnistring.fromJson(e))
                            .toList(),
                  )
                  .toList()
              : null,
      batchTraces: json.valueAsInt('batch_traces'),
      batchLogs: json.valueAsInt('batch_logs'),
      batchTimeoutMs: json.valueAsInt('batch_timeout_ms'),
      gcTelemetry: json.valueTo<
        OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetry?,
        Map<String, dynamic>
      >(
        key: 'gc_telemetry',
        parse:
            (v) =>
                OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetry.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'enable': enable,
        'instance_id': instanceId?.toJson(),
        'environment': environment?.toJson(),
        'debug': debug,
        'url_traces': urlTraces?.toJson(),
        'url_logs': urlLogs?.toJson(),
        'headers':
            headers?.map((e) => e.map((x) => x.toJson()).toList()).toList(),
        'batch_traces': batchTraces,
        'batch_logs': batchLogs,
        'batch_timeout_ms': batchTimeoutMs,
        'gc_telemetry': gcTelemetry?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigOpentelemetryOpentelemetryBoolean
    extends OctezRollupResponseConfigOpentelemetry {
  final bool value;
  const OctezRollupResponseConfigOpentelemetryOpentelemetryBoolean(this.value);

  @override
  dynamic toJson() => value;
}

enum OctezRollupServiceTreeStaticStaticGetServiceMeth {
  pATCH("PATCH"),
  gET("GET"),
  pOST("POST"),
  pUT("PUT"),
  dELETE("DELETE");

  final String value;
  const OctezRollupServiceTreeStaticStaticGetServiceMeth(this.value);

  static OctezRollupServiceTreeStaticStaticGetServiceMeth fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupServiceTreeStaticStaticGetServiceMeth.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValue {
  const OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValue();

  factory OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValue.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValueUnistring(
          OctezRollupUnistring.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValueUnistring(
        OctezRollupUnistring.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValue',
      reason:
          'Cannot parse OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValue from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValueUnistring
    extends OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValue {
  final OctezRollupUnistring value;
  const OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValueUnistring(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

enum OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicId {
  single("single");

  final String value;
  const OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicId(
    this.value,
  );

  static OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicId
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicId.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTailId {
  multiple("multiple");

  final String value;
  const OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTailId(
    this.value,
  );

  static OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTailId
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTailId.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupServiceTreeStaticStaticGetServicePathItem {
  const OctezRollupServiceTreeStaticStaticGetServicePathItem();

  factory OctezRollupServiceTreeStaticStaticGetServicePathItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['id'] == "single" && map.hasValue('name')) {
        return OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamic.fromJson(
          map,
        );
      }
      if (map['id'] == "multiple" && map.hasValue('name')) {
        return OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTail.fromJson(
          map,
        );
      }
      try {
        return OctezRollupServiceTreeStaticStaticGetServicePathItemPStatic(
          OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValue.fromJson(
            map,
          ),
        );
      } catch (_) {}
    }
    try {
      return OctezRollupServiceTreeStaticStaticGetServicePathItemPStatic(
        OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValue.fromJson(
          json,
        ),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezRollupServiceTreeStaticStaticGetServicePathItem',
      reason:
          'Cannot parse OctezRollupServiceTreeStaticStaticGetServicePathItem from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupServiceTreeStaticStaticGetServicePathItemPStatic
    extends OctezRollupServiceTreeStaticStaticGetServicePathItem {
  final OctezRollupServiceTreeStaticStaticGetServicePathItemPStaticValue value;
  const OctezRollupServiceTreeStaticStaticGetServicePathItemPStatic(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamic
    extends OctezRollupServiceTreeStaticStaticGetServicePathItem {
  final OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicId id;
  final OctezRollupUnistring name;
  final OctezRollupUnistring? descr;

  const OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamic({
    required this.id,
    required this.name,
    this.descr,
  });

  factory OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamic.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamic(
      id: OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicId.fromJson(
        json['id'],
      ),
      name: OctezRollupUnistring.fromJson(json['name']),
      descr:
          json.hasValue('descr')
              ? OctezRollupUnistring.fromJson(json['descr'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'id': id.toJson(),
        'name': name.toJson(),
        'descr': descr?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTail
    extends OctezRollupServiceTreeStaticStaticGetServicePathItem {
  final OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTailId id;
  final OctezRollupUnistring name;
  final OctezRollupUnistring? descr;

  const OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTail({
    required this.id,
    required this.name,
    this.descr,
  });

  factory OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTail.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTail(
      id: OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicTailId.fromJson(
        json['id'],
      ),
      name: OctezRollupUnistring.fromJson(json['name']),
      descr:
          json.hasValue('descr')
              ? OctezRollupUnistring.fromJson(json['descr'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'id': id.toJson(),
        'name': name.toJson(),
        'descr': descr?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind {
  const OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind();

  factory OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('single')) {
        return OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingle.fromJson(
          map,
        );
      }
      if (map.hasValue('optional')) {
        return OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindOptional.fromJson(
          map,
        );
      }
      if (map.hasValue('flag')) {
        return OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlag.fromJson(
          map,
        );
      }
      if (map.hasValue('multi')) {
        return OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindMulti.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind',
      reason:
          'Cannot parse OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingle
    extends OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind {
  final OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle
  single;

  const OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingle({
    required this.single,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingle.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingle(
      single: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle,
        Map<String, dynamic>
      >(
        key: 'single',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'single': single.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindOptional
    extends OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind {
  final OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle
  optional;

  const OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindOptional({
    required this.optional,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindOptional.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindOptional(
      optional: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle,
        Map<String, dynamic>
      >(
        key: 'optional',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'optional': optional.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlag
    extends OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind {
  final OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlagFlag flag;

  const OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlag({
    required this.flag,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlag.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlag(
      flag: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlagFlag,
        Map<String, dynamic>
      >(
        key: 'flag',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlagFlag.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'flag': flag.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindMulti
    extends OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind {
  final OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle
  multi;

  const OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindMulti({
    required this.multi,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindMulti.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindMulti(
      multi: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle,
        Map<String, dynamic>
      >(
        key: 'multi',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'multi': multi.toJson()}.notNullValue.cast<String, dynamic>();
}

enum OctezRollupLayoutZeroWidthKind {
  zeroWidth("Zero_width");

  final String value;
  const OctezRollupLayoutZeroWidthKind(this.value);

  static OctezRollupLayoutZeroWidthKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutZeroWidthKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutIntSize {
  int32("Int32"),
  int16("Int16"),
  uint16("Uint16"),
  int64("Int64"),
  int8("Int8"),
  uint8("Uint8");

  final String value;
  const OctezRollupLayoutIntSize(this.value);

  static OctezRollupLayoutIntSize fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutIntSize.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutIntEndianness {
  little("Little"),
  big("Big");

  final String value;
  const OctezRollupLayoutIntEndianness(this.value);

  static OctezRollupLayoutIntEndianness fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutIntEndianness.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutIntKind {
  int_("Int");

  final String value;
  const OctezRollupLayoutIntKind(this.value);

  static OctezRollupLayoutIntKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutIntKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutBoolKind {
  bool_("Bool");

  final String value;
  const OctezRollupLayoutBoolKind(this.value);

  static OctezRollupLayoutBoolKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutBoolKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutRangedIntKind {
  rangedInt("RangedInt");

  final String value;
  const OctezRollupLayoutRangedIntKind(this.value);

  static OctezRollupLayoutRangedIntKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutRangedIntKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutRangedFloatKind {
  rangedFloat("RangedFloat");

  final String value;
  const OctezRollupLayoutRangedFloatKind(this.value);

  static OctezRollupLayoutRangedFloatKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutRangedFloatKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutFloatKind {
  float("Float");

  final String value;
  const OctezRollupLayoutFloatKind(this.value);

  static OctezRollupLayoutFloatKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutFloatKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutBytesKind {
  bytes("Bytes");

  final String value;
  const OctezRollupLayoutBytesKind(this.value);

  static OctezRollupLayoutBytesKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutBytesKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutStringValueKind {
  string("String");

  final String value;
  const OctezRollupLayoutStringValueKind(this.value);

  static OctezRollupLayoutStringValueKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutStringValueKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutEnumSize {
  int16("Int16"),
  uint16("Uint16"),
  int8("Int8"),
  uint8("Uint8");

  final String value;
  const OctezRollupLayoutEnumSize(this.value);

  static OctezRollupLayoutEnumSize fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutEnumSize.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutEnumKind {
  enum_("Enum");

  final String value;
  const OctezRollupLayoutEnumKind(this.value);

  static OctezRollupLayoutEnumKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutEnumKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutSeqKind {
  seq("Seq");

  final String value;
  const OctezRollupLayoutSeqKind(this.value);

  static OctezRollupLayoutSeqKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutSeqKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutSeqLengthLimitNoLimitKind {
  noLimit("no-limit");

  final String value;
  const OctezRollupLayoutSeqLengthLimitNoLimitKind(this.value);

  static OctezRollupLayoutSeqLengthLimitNoLimitKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutSeqLengthLimitNoLimitKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutSeqLengthLimitAtMostKind {
  atMost("at-most");

  final String value;
  const OctezRollupLayoutSeqLengthLimitAtMostKind(this.value);

  static OctezRollupLayoutSeqLengthLimitAtMostKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutSeqLengthLimitAtMostKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutSeqLengthLimitExactlyKind {
  exactly("exactly");

  final String value;
  const OctezRollupLayoutSeqLengthLimitExactlyKind(this.value);

  static OctezRollupLayoutSeqLengthLimitExactlyKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutSeqLengthLimitExactlyKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupLayoutSeqLengthLimit {
  const OctezRollupLayoutSeqLengthLimit();

  factory OctezRollupLayoutSeqLengthLimit.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['kind'] == "at-most" && map.hasValue('at_most')) {
        return OctezRollupLayoutSeqLengthLimitAtMost.fromJson(map);
      }
      if (map['kind'] == "exactly" && map.hasValue('exactly')) {
        return OctezRollupLayoutSeqLengthLimitExactly.fromJson(map);
      }
      if (map['kind'] == "no-limit") {
        return OctezRollupLayoutSeqLengthLimitNoLimit.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupLayoutSeqLengthLimit',
      reason: 'Cannot parse OctezRollupLayoutSeqLengthLimit from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupLayoutSeqLengthLimitNoLimit
    extends OctezRollupLayoutSeqLengthLimit {
  final OctezRollupLayoutSeqLengthLimitNoLimitKind kind;

  const OctezRollupLayoutSeqLengthLimitNoLimit({required this.kind});

  factory OctezRollupLayoutSeqLengthLimitNoLimit.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupLayoutSeqLengthLimitNoLimit(
      kind: OctezRollupLayoutSeqLengthLimitNoLimitKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'kind': kind.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutSeqLengthLimitAtMost
    extends OctezRollupLayoutSeqLengthLimit {
  final OctezRollupLayoutSeqLengthLimitAtMostKind kind;
  final int atMost;

  const OctezRollupLayoutSeqLengthLimitAtMost({
    required this.kind,
    required this.atMost,
  });

  factory OctezRollupLayoutSeqLengthLimitAtMost.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupLayoutSeqLengthLimitAtMost(
      kind: OctezRollupLayoutSeqLengthLimitAtMostKind.fromJson(json['kind']),
      atMost: json.valueAsInt('at_most'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'at_most': atMost,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutSeqLengthLimitExactly
    extends OctezRollupLayoutSeqLengthLimit {
  final OctezRollupLayoutSeqLengthLimitExactlyKind kind;
  final int exactly;

  const OctezRollupLayoutSeqLengthLimitExactly({
    required this.kind,
    required this.exactly,
  });

  factory OctezRollupLayoutSeqLengthLimitExactly.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupLayoutSeqLengthLimitExactly(
      kind: OctezRollupLayoutSeqLengthLimitExactlyKind.fromJson(json['kind']),
      exactly: json.valueAsInt('exactly'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'exactly': exactly,
      }.notNullValue.cast<String, dynamic>();
}

enum OctezRollupLayoutRefKind {
  ref("Ref");

  final String value;
  const OctezRollupLayoutRefKind(this.value);

  static OctezRollupLayoutRefKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutRefKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupLayoutPaddingKind {
  padding("Padding");

  final String value;
  const OctezRollupLayoutPaddingKind(this.value);

  static OctezRollupLayoutPaddingKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupLayoutPaddingKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupLayout {
  const OctezRollupLayout();

  factory OctezRollupLayout.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['kind'] == "Enum" &&
          map.hasValue('size') &&
          map.hasValue('reference')) {
        return OctezRollupLayoutEnum.fromJson(map);
      }
      if (map['kind'] == "Seq" && map.hasValue('layout')) {
        return OctezRollupLayoutSeq.fromJson(map);
      }
      if (map['kind'] == "RangedInt" &&
          map.hasValue('min') &&
          map.hasValue('max')) {
        return OctezRollupLayoutRangedInt.fromJson(map);
      }
      if (map['kind'] == "RangedFloat" &&
          map.hasValue('min') &&
          map.hasValue('max')) {
        return OctezRollupLayoutRangedFloat.fromJson(map);
      }
      if (map['kind'] == "Ref" && map.hasValue('name')) {
        return OctezRollupLayoutRef.fromJson(map);
      }
      if (map['kind'] == "Int" && map.hasValue('size')) {
        return OctezRollupLayoutInt.fromJson(map);
      }
      if (map['kind'] == "Zero_width") {
        return OctezRollupLayoutZeroWidth.fromJson(map);
      }
      if (map['kind'] == "Bool") {
        return OctezRollupLayoutBool.fromJson(map);
      }
      if (map['kind'] == "Float") {
        return OctezRollupLayoutFloat.fromJson(map);
      }
      if (map['kind'] == "Bytes") {
        return OctezRollupLayoutBytes.fromJson(map);
      }
      if (map['kind'] == "String") {
        return OctezRollupLayoutStringValue.fromJson(map);
      }
      if (map['kind'] == "Padding") {
        return OctezRollupLayoutPadding.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupLayout',
      reason: 'Cannot parse OctezRollupLayout from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupLayoutZeroWidth extends OctezRollupLayout {
  final OctezRollupLayoutZeroWidthKind kind;

  const OctezRollupLayoutZeroWidth({required this.kind});

  factory OctezRollupLayoutZeroWidth.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutZeroWidth(
      kind: OctezRollupLayoutZeroWidthKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'kind': kind.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutInt extends OctezRollupLayout {
  final OctezRollupLayoutIntSize size;
  final OctezRollupLayoutIntEndianness? endianness;
  final OctezRollupLayoutIntKind kind;

  const OctezRollupLayoutInt({
    required this.size,
    this.endianness,
    required this.kind,
  });

  factory OctezRollupLayoutInt.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutInt(
      size: OctezRollupLayoutIntSize.fromJson(json['size']),
      endianness:
          json.hasValue('endianness')
              ? OctezRollupLayoutIntEndianness.fromJson(json['endianness'])
              : null,
      kind: OctezRollupLayoutIntKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'size': size.toJson(),
        'endianness': endianness?.toJson(),
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutBool extends OctezRollupLayout {
  final OctezRollupLayoutBoolKind kind;

  const OctezRollupLayoutBool({required this.kind});

  factory OctezRollupLayoutBool.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutBool(
      kind: OctezRollupLayoutBoolKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'kind': kind.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutRangedInt extends OctezRollupLayout {
  final int min;
  final OctezRollupLayoutIntEndianness? endianness;
  final int max;
  final OctezRollupLayoutRangedIntKind kind;

  const OctezRollupLayoutRangedInt({
    required this.min,
    this.endianness,
    required this.max,
    required this.kind,
  });

  factory OctezRollupLayoutRangedInt.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutRangedInt(
      min: json.valueAsInt('min'),
      endianness:
          json.hasValue('endianness')
              ? OctezRollupLayoutIntEndianness.fromJson(json['endianness'])
              : null,
      max: json.valueAsInt('max'),
      kind: OctezRollupLayoutRangedIntKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'min': min,
        'endianness': endianness?.toJson(),
        'max': max,
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutRangedFloat extends OctezRollupLayout {
  final num min;
  final num max;
  final OctezRollupLayoutRangedFloatKind kind;

  const OctezRollupLayoutRangedFloat({
    required this.min,
    required this.max,
    required this.kind,
  });

  factory OctezRollupLayoutRangedFloat.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutRangedFloat(
      min: json.valueAsNum('min'),
      max: json.valueAsNum('max'),
      kind: OctezRollupLayoutRangedFloatKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'min': min,
        'max': max,
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutFloat extends OctezRollupLayout {
  final OctezRollupLayoutFloatKind kind;

  const OctezRollupLayoutFloat({required this.kind});

  factory OctezRollupLayoutFloat.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutFloat(
      kind: OctezRollupLayoutFloatKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'kind': kind.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutBytes extends OctezRollupLayout {
  final OctezRollupLayoutBytesKind kind;

  const OctezRollupLayoutBytes({required this.kind});

  factory OctezRollupLayoutBytes.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutBytes(
      kind: OctezRollupLayoutBytesKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'kind': kind.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutStringValue extends OctezRollupLayout {
  final OctezRollupLayoutStringValueKind kind;

  const OctezRollupLayoutStringValue({required this.kind});

  factory OctezRollupLayoutStringValue.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutStringValue(
      kind: OctezRollupLayoutStringValueKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'kind': kind.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutEnum extends OctezRollupLayout {
  final OctezRollupLayoutEnumSize size;
  final OctezRollupUnistring reference;
  final OctezRollupLayoutEnumKind kind;

  const OctezRollupLayoutEnum({
    required this.size,
    required this.reference,
    required this.kind,
  });

  factory OctezRollupLayoutEnum.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutEnum(
      size: OctezRollupLayoutEnumSize.fromJson(json['size']),
      reference: OctezRollupUnistring.fromJson(json['reference']),
      kind: OctezRollupLayoutEnumKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'size': size.toJson(),
        'reference': reference.toJson(),
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutSeq extends OctezRollupLayout {
  final OctezRollupLayout layout;
  final OctezRollupLayoutSeqKind kind;
  final OctezRollupLayoutSeqLengthLimit? lengthLimit;

  const OctezRollupLayoutSeq({
    required this.layout,
    required this.kind,
    this.lengthLimit,
  });

  factory OctezRollupLayoutSeq.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutSeq(
      layout: OctezRollupLayout.fromJson(json['layout']),
      kind: OctezRollupLayoutSeqKind.fromJson(json['kind']),
      lengthLimit:
          json.hasValue('length_limit')
              ? OctezRollupLayoutSeqLengthLimit.fromJson(json['length_limit'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'layout': layout.toJson(),
        'kind': kind.toJson(),
        'length_limit': lengthLimit?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutRef extends OctezRollupLayout {
  final OctezRollupUnistring name;
  final OctezRollupLayoutRefKind kind;

  const OctezRollupLayoutRef({required this.name, required this.kind});

  factory OctezRollupLayoutRef.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutRef(
      name: OctezRollupUnistring.fromJson(json['name']),
      kind: OctezRollupLayoutRefKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'name': name.toJson(),
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupLayoutPadding extends OctezRollupLayout {
  final OctezRollupLayoutPaddingKind kind;

  const OctezRollupLayoutPadding({required this.kind});

  factory OctezRollupLayoutPadding.fromJson(Map<String, dynamic> json) {
    return OctezRollupLayoutPadding(
      kind: OctezRollupLayoutPaddingKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'kind': kind.toJson()}.notNullValue.cast<String, dynamic>();
}

enum OctezRollupSchemaKindFixedKind {
  fixed("Fixed");

  final String value;
  const OctezRollupSchemaKindFixedKind(this.value);

  static OctezRollupSchemaKindFixedKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupSchemaKindFixedKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupSchemaKindDynamicKind {
  dynamic_("Dynamic");

  final String value;
  const OctezRollupSchemaKindDynamicKind(this.value);

  static OctezRollupSchemaKindDynamicKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupSchemaKindDynamicKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupSchemaKindVariableKind {
  variable("Variable");

  final String value;
  const OctezRollupSchemaKindVariableKind(this.value);

  static OctezRollupSchemaKindVariableKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupSchemaKindVariableKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupSchemaKind {
  const OctezRollupSchemaKind();

  factory OctezRollupSchemaKind.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['kind'] == "Fixed" && map.hasValue('size')) {
        return OctezRollupSchemaKindFixed.fromJson(map);
      }
      if (map['kind'] == "Dynamic") {
        return OctezRollupSchemaKindDynamic.fromJson(map);
      }
      if (map['kind'] == "Variable") {
        return OctezRollupSchemaKindVariable.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupSchemaKind',
      reason: 'Cannot parse OctezRollupSchemaKind from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupSchemaKindFixed extends OctezRollupSchemaKind {
  final int size;
  final OctezRollupSchemaKindFixedKind kind;

  const OctezRollupSchemaKindFixed({required this.size, required this.kind});

  factory OctezRollupSchemaKindFixed.fromJson(Map<String, dynamic> json) {
    return OctezRollupSchemaKindFixed(
      size: json.valueAsInt('size'),
      kind: OctezRollupSchemaKindFixedKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'size': size,
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupSchemaKindDynamic extends OctezRollupSchemaKind {
  final OctezRollupSchemaKindDynamicKind kind;

  const OctezRollupSchemaKindDynamic({required this.kind});

  factory OctezRollupSchemaKindDynamic.fromJson(Map<String, dynamic> json) {
    return OctezRollupSchemaKindDynamic(
      kind: OctezRollupSchemaKindDynamicKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'kind': kind.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupSchemaKindVariable extends OctezRollupSchemaKind {
  final OctezRollupSchemaKindVariableKind kind;

  const OctezRollupSchemaKindVariable({required this.kind});

  factory OctezRollupSchemaKindVariable.fromJson(Map<String, dynamic> json) {
    return OctezRollupSchemaKindVariable(
      kind: OctezRollupSchemaKindVariableKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'kind': kind.toJson()}.notNullValue.cast<String, dynamic>();
}

enum OctezRollupSchemaFieldNamedFieldKind {
  named("named");

  final String value;
  const OctezRollupSchemaFieldNamedFieldKind(this.value);

  static OctezRollupSchemaFieldNamedFieldKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupSchemaFieldNamedFieldKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupSchemaFieldAnonymousFieldKind {
  anon("anon");

  final String value;
  const OctezRollupSchemaFieldAnonymousFieldKind(this.value);

  static OctezRollupSchemaFieldAnonymousFieldKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupSchemaFieldAnonymousFieldKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupSchemaFieldDynamicFieldKind {
  dyn("dyn");

  final String value;
  const OctezRollupSchemaFieldDynamicFieldKind(this.value);

  static OctezRollupSchemaFieldDynamicFieldKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupSchemaFieldDynamicFieldKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupSchemaFieldDynamicFieldSize {
  n("N"),
  uint30("Uint30"),
  uint16("Uint16"),
  uint8("Uint8");

  final String value;
  const OctezRollupSchemaFieldDynamicFieldSize(this.value);

  static OctezRollupSchemaFieldDynamicFieldSize fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupSchemaFieldDynamicFieldSize.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupSchemaFieldOptionalFieldKind {
  optionIndicator("option_indicator");

  final String value;
  const OctezRollupSchemaFieldOptionalFieldKind(this.value);

  static OctezRollupSchemaFieldOptionalFieldKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupSchemaFieldOptionalFieldKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupSchemaField {
  const OctezRollupSchemaField();

  factory OctezRollupSchemaField.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['kind'] == "dyn" &&
          map.hasValue('num_fields') &&
          map.hasValue('size')) {
        return OctezRollupSchemaFieldDynamicField.fromJson(map);
      }
      if (map['kind'] == "named" &&
          map.hasValue('name') &&
          map.hasValue('layout') &&
          map.hasValue('data_kind')) {
        return OctezRollupSchemaFieldNamedField.fromJson(map);
      }
      if (map['kind'] == "anon" &&
          map.hasValue('layout') &&
          map.hasValue('data_kind')) {
        return OctezRollupSchemaFieldAnonymousField.fromJson(map);
      }
      if (map['kind'] == "option_indicator" && map.hasValue('name')) {
        return OctezRollupSchemaFieldOptionalField.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupSchemaField',
      reason: 'Cannot parse OctezRollupSchemaField from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupSchemaFieldNamedField extends OctezRollupSchemaField {
  final OctezRollupUnistring name;
  final OctezRollupLayout layout;
  final OctezRollupSchemaKind dataKind;
  final OctezRollupSchemaFieldNamedFieldKind kind;

  const OctezRollupSchemaFieldNamedField({
    required this.name,
    required this.layout,
    required this.dataKind,
    required this.kind,
  });

  factory OctezRollupSchemaFieldNamedField.fromJson(Map<String, dynamic> json) {
    return OctezRollupSchemaFieldNamedField(
      name: OctezRollupUnistring.fromJson(json['name']),
      layout: OctezRollupLayout.fromJson(json['layout']),
      dataKind: OctezRollupSchemaKind.fromJson(json['data_kind']),
      kind: OctezRollupSchemaFieldNamedFieldKind.fromJson(json['kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'name': name.toJson(),
        'layout': layout.toJson(),
        'data_kind': dataKind.toJson(),
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupSchemaFieldAnonymousField extends OctezRollupSchemaField {
  final OctezRollupLayout layout;
  final OctezRollupSchemaFieldAnonymousFieldKind kind;
  final OctezRollupSchemaKind dataKind;

  const OctezRollupSchemaFieldAnonymousField({
    required this.layout,
    required this.kind,
    required this.dataKind,
  });

  factory OctezRollupSchemaFieldAnonymousField.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupSchemaFieldAnonymousField(
      layout: OctezRollupLayout.fromJson(json['layout']),
      kind: OctezRollupSchemaFieldAnonymousFieldKind.fromJson(json['kind']),
      dataKind: OctezRollupSchemaKind.fromJson(json['data_kind']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'layout': layout.toJson(),
        'kind': kind.toJson(),
        'data_kind': dataKind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupSchemaFieldDynamicField extends OctezRollupSchemaField {
  final OctezRollupSchemaFieldDynamicFieldKind kind;
  final OctezRollupUnistring? name;
  final int numFields;
  final OctezRollupSchemaFieldDynamicFieldSize size;

  const OctezRollupSchemaFieldDynamicField({
    required this.kind,
    this.name,
    required this.numFields,
    required this.size,
  });

  factory OctezRollupSchemaFieldDynamicField.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupSchemaFieldDynamicField(
      kind: OctezRollupSchemaFieldDynamicFieldKind.fromJson(json['kind']),
      name:
          json.hasValue('name')
              ? OctezRollupUnistring.fromJson(json['name'])
              : null,
      numFields: json.valueAsInt('num_fields'),
      size: OctezRollupSchemaFieldDynamicFieldSize.fromJson(json['size']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'name': name?.toJson(),
        'num_fields': numFields,
        'size': size.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupSchemaFieldOptionalField extends OctezRollupSchemaField {
  final OctezRollupSchemaFieldOptionalFieldKind kind;
  final OctezRollupUnistring name;

  const OctezRollupSchemaFieldOptionalField({
    required this.kind,
    required this.name,
  });

  factory OctezRollupSchemaFieldOptionalField.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupSchemaFieldOptionalField(
      kind: OctezRollupSchemaFieldOptionalFieldKind.fromJson(json['kind']),
      name: OctezRollupUnistring.fromJson(json['name']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'name': name.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

enum OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCasesTagSize {
  uint16("Uint16"),
  uint8("Uint8");

  final String value;
  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCasesTagSize(
    this.value,
  );

  static OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCasesTagSize
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCasesTagSize.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItem {
  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItem();

  factory OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItem.fromJson(
    dynamic json,
  ) {
    if (json is num) {
      return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItemInteger(
        json.toInt(),
      );
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItemUnistring(
          OctezRollupUnistring.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItemUnistring(
        OctezRollupUnistring.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItem',
      reason:
          'Cannot parse OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItem from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItemInteger
    extends
        OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItem {
  final int value;
  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItemInteger(
    this.value,
  );

  @override
  dynamic toJson() => value;
}

class OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItemUnistring
    extends
        OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItem {
  final OctezRollupUnistring value;
  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItemUnistring(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel {
  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel();

  factory OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('tag_size') &&
          map.hasValue('kind') &&
          map.hasValue('cases')) {
        return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCases.fromJson(
          map,
        );
      }
      if (map.hasValue('size') && map.hasValue('cases')) {
        return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnum.fromJson(
          map,
        );
      }
      if (map.hasValue('fields')) {
        return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelObj.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel',
      reason:
          'Cannot parse OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelObj
    extends
        OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel {
  final List<OctezRollupSchemaField> fields;

  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelObj({
    required this.fields,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelObj.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelObj(
      fields:
          json
              .valueEnsureAsList<dynamic>('fields')
              .map((e) => OctezRollupSchemaField.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'fields': fields.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCases
    extends
        OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel {
  final OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCasesTagSize
  tagSize;
  final OctezRollupSchemaKind kind;
  final List<OctezRollupUnionCase> cases;

  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCases({
    required this.tagSize,
    required this.kind,
    required this.cases,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCases.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCases(
      tagSize:
          OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelCasesTagSize.fromJson(
            json['tag_size'],
          ),
      kind: OctezRollupSchemaKind.fromJson(json['kind']),
      cases:
          json
              .valueEnsureAsList<Map<String, dynamic>>('cases')
              .map((e) => OctezRollupUnionCase.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'tag_size': tagSize.toJson(),
        'kind': kind.toJson(),
        'cases': cases.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnum
    extends
        OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel {
  final OctezRollupLayoutEnumSize size;
  final List<
    List<
      OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItem
    >
  >
  cases;

  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnum({
    required this.size,
    required this.cases,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnum.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnum(
      size: OctezRollupLayoutEnumSize.fromJson(json['size']),
      cases:
          json
              .valueEnsureAsList<dynamic>('cases')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) =>
                              OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevelIntEnumCasesItemItem.fromJson(
                                e,
                              ),
                        )
                        .toList(),
              )
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'size': size.toJson(),
        'cases': cases.map((e) => e.map((x) => x.toJson()).toList()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupServiceTreeStaticStaticSubdirs {
  const OctezRollupServiceTreeStaticStaticSubdirs();

  factory OctezRollupServiceTreeStaticStaticSubdirs.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('suffixes')) {
        return OctezRollupServiceTreeStaticStaticSubdirsSuffixes.fromJson(map);
      }
      if (map.hasValue('dynamic_dispatch')) {
        return OctezRollupServiceTreeStaticStaticSubdirsArg.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupServiceTreeStaticStaticSubdirs',
      reason:
          'Cannot parse OctezRollupServiceTreeStaticStaticSubdirs from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupServiceTreeStaticStaticSubdirsSuffixes
    extends OctezRollupServiceTreeStaticStaticSubdirs {
  final List<OctezRollupServiceTreeStaticStaticSubdirsSuffixesSuffixesItem>
  suffixes;

  const OctezRollupServiceTreeStaticStaticSubdirsSuffixes({
    required this.suffixes,
  });

  factory OctezRollupServiceTreeStaticStaticSubdirsSuffixes.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticSubdirsSuffixes(
      suffixes:
          json
              .valueEnsureAsList<Map<String, dynamic>>('suffixes')
              .map(
                (e) =>
                    OctezRollupServiceTreeStaticStaticSubdirsSuffixesSuffixesItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'suffixes': suffixes.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticSubdirsArg
    extends OctezRollupServiceTreeStaticStaticSubdirs {
  final OctezRollupServiceTreeStaticStaticSubdirsArgDynamicDispatch
  dynamicDispatch;

  const OctezRollupServiceTreeStaticStaticSubdirsArg({
    required this.dynamicDispatch,
  });

  factory OctezRollupServiceTreeStaticStaticSubdirsArg.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticSubdirsArg(
      dynamicDispatch: json.valueTo<
        OctezRollupServiceTreeStaticStaticSubdirsArgDynamicDispatch,
        Map<String, dynamic>
      >(
        key: 'dynamic_dispatch',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticSubdirsArgDynamicDispatch.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'dynamic_dispatch': dynamicDispatch.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// GET /describe (response)
sealed class OctezRollupServiceTree {
  const OctezRollupServiceTree();

  factory OctezRollupServiceTree.fromJson(dynamic json) {
    if (json is String) {
      return switch (json) {
        'empty' => const OctezRollupServiceTreeEmpty(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezRollupServiceTree',
            reason: 'Unknown OctezRollupServiceTree: $json',
          ),
      };
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('static')) {
        return OctezRollupServiceTreeStatic.fromJson(map);
      }
      if (map.hasValue('dynamic')) {
        return OctezRollupServiceTreeDynamic.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupServiceTree',
      reason: 'Cannot parse OctezRollupServiceTree from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupServiceTreeStatic extends OctezRollupServiceTree {
  final OctezRollupServiceTreeStaticStatic static_;

  const OctezRollupServiceTreeStatic({required this.static_});

  factory OctezRollupServiceTreeStatic.fromJson(Map<String, dynamic> json) {
    return OctezRollupServiceTreeStatic(
      static_: json
          .valueTo<OctezRollupServiceTreeStaticStatic, Map<String, dynamic>>(
            key: 'static',
            parse: (v) => OctezRollupServiceTreeStaticStatic.fromJson(v),
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'static': static_.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeDynamic extends OctezRollupServiceTree {
  final OctezRollupUnistring? dynamic_;

  const OctezRollupServiceTreeDynamic({this.dynamic_});

  factory OctezRollupServiceTreeDynamic.fromJson(Map<String, dynamic> json) {
    return OctezRollupServiceTreeDynamic(
      dynamic_:
          json.hasValue('dynamic')
              ? OctezRollupUnistring.fromJson(json['dynamic'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'dynamic': dynamic_?.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeEmpty extends OctezRollupServiceTree {
  const OctezRollupServiceTreeEmpty();

  @override
  String toJson() => 'empty';
}

sealed class OctezRollupMichelineOutboxTransactionParametersExpression {
  const OctezRollupMichelineOutboxTransactionParametersExpression();

  factory OctezRollupMichelineOutboxTransactionParametersExpression.fromJson(
    dynamic json,
  ) {
    if (json is List) {
      return OctezRollupMichelineOutboxTransactionParametersExpressionSequence(
        (json)
            .map(
              (e) =>
                  OctezRollupMichelineOutboxTransactionParametersExpression.fromJson(
                    e,
                  ),
            )
            .toList(),
      );
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('prim')) {
        return OctezRollupMichelineOutboxTransactionParametersExpressionPrimGeneric.fromJson(
          map,
        );
      }
      if (map.hasValue('int')) {
        return OctezRollupMichelineOutboxTransactionParametersExpressionInt.fromJson(
          map,
        );
      }
      if (map.hasValue('string')) {
        return OctezRollupMichelineOutboxTransactionParametersExpressionStringValue.fromJson(
          map,
        );
      }
      if (map.hasValue('bytes')) {
        return OctezRollupMichelineOutboxTransactionParametersExpressionBytes.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupMichelineOutboxTransactionParametersExpression',
      reason:
          'Cannot parse OctezRollupMichelineOutboxTransactionParametersExpression from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupMichelineOutboxTransactionParametersExpressionInt
    extends OctezRollupMichelineOutboxTransactionParametersExpression {
  final OctezRollupBignum int_;

  const OctezRollupMichelineOutboxTransactionParametersExpressionInt({
    required this.int_,
  });

  factory OctezRollupMichelineOutboxTransactionParametersExpressionInt.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMichelineOutboxTransactionParametersExpressionInt(
      int_:
          (json['int'] is num
              ? json['int'].toString()
              : json.valueAsString('int')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'int': int_}.notNullValue.cast<String, dynamic>();
}

class OctezRollupMichelineOutboxTransactionParametersExpressionStringValue
    extends OctezRollupMichelineOutboxTransactionParametersExpression {
  final OctezRollupUnistring string;

  const OctezRollupMichelineOutboxTransactionParametersExpressionStringValue({
    required this.string,
  });

  factory OctezRollupMichelineOutboxTransactionParametersExpressionStringValue.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMichelineOutboxTransactionParametersExpressionStringValue(
      string: OctezRollupUnistring.fromJson(json['string']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'string': string.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupMichelineOutboxTransactionParametersExpressionBytes
    extends OctezRollupMichelineOutboxTransactionParametersExpression {
  final String bytes;

  const OctezRollupMichelineOutboxTransactionParametersExpressionBytes({
    required this.bytes,
  });

  factory OctezRollupMichelineOutboxTransactionParametersExpressionBytes.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMichelineOutboxTransactionParametersExpressionBytes(
      bytes:
          (json['bytes'] is num
              ? json['bytes'].toString()
              : json.valueAsString('bytes')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'bytes': bytes}.notNullValue.cast<String, dynamic>();
}

class OctezRollupMichelineOutboxTransactionParametersExpressionSequence
    extends OctezRollupMichelineOutboxTransactionParametersExpression {
  final List<OctezRollupMichelineOutboxTransactionParametersExpression> value;
  const OctezRollupMichelineOutboxTransactionParametersExpressionSequence(
    this.value,
  );

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

class OctezRollupMichelineOutboxTransactionParametersExpressionPrimGeneric
    extends OctezRollupMichelineOutboxTransactionParametersExpression {
  final OctezRollupUnistring prim;
  final List<OctezRollupMichelineOutboxTransactionParametersExpression>? args;
  final List<OctezRollupUnistring>? annots;

  const OctezRollupMichelineOutboxTransactionParametersExpressionPrimGeneric({
    required this.prim,
    this.args,
    this.annots,
  });

  factory OctezRollupMichelineOutboxTransactionParametersExpressionPrimGeneric.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMichelineOutboxTransactionParametersExpressionPrimGeneric(
      prim: OctezRollupUnistring.fromJson(json['prim']),
      args:
          json.hasValue('args')
              ? json
                  .valueEnsureAsList<dynamic>('args')
                  .map(
                    (e) =>
                        OctezRollupMichelineOutboxTransactionParametersExpression.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      annots:
          json.hasValue('annots')
              ? json
                  .valueEnsureAsList<dynamic>('annots')
                  .map((e) => OctezRollupUnistring.fromJson(e))
                  .toList()
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'prim': prim.toJson(),
        'args': args?.map((e) => e.toJson()).toList(),
        'annots': annots?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupMichelineOutboxTransactionParametersTypeExpression {
  const OctezRollupMichelineOutboxTransactionParametersTypeExpression();

  factory OctezRollupMichelineOutboxTransactionParametersTypeExpression.fromJson(
    dynamic json,
  ) {
    if (json is List) {
      return OctezRollupMichelineOutboxTransactionParametersTypeExpressionSequence(
        (json)
            .map(
              (e) =>
                  OctezRollupMichelineOutboxTransactionParametersTypeExpression.fromJson(
                    e,
                  ),
            )
            .toList(),
      );
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('prim')) {
        return OctezRollupMichelineOutboxTransactionParametersTypeExpressionPrimGeneric.fromJson(
          map,
        );
      }
      if (map.hasValue('int')) {
        return OctezRollupMichelineOutboxTransactionParametersTypeExpressionInt.fromJson(
          map,
        );
      }
      if (map.hasValue('string')) {
        return OctezRollupMichelineOutboxTransactionParametersTypeExpressionStringValue.fromJson(
          map,
        );
      }
      if (map.hasValue('bytes')) {
        return OctezRollupMichelineOutboxTransactionParametersTypeExpressionBytes.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupMichelineOutboxTransactionParametersTypeExpression',
      reason:
          'Cannot parse OctezRollupMichelineOutboxTransactionParametersTypeExpression from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupMichelineOutboxTransactionParametersTypeExpressionInt
    extends OctezRollupMichelineOutboxTransactionParametersTypeExpression {
  final OctezRollupBignum int_;

  const OctezRollupMichelineOutboxTransactionParametersTypeExpressionInt({
    required this.int_,
  });

  factory OctezRollupMichelineOutboxTransactionParametersTypeExpressionInt.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMichelineOutboxTransactionParametersTypeExpressionInt(
      int_:
          (json['int'] is num
              ? json['int'].toString()
              : json.valueAsString('int')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'int': int_}.notNullValue.cast<String, dynamic>();
}

class OctezRollupMichelineOutboxTransactionParametersTypeExpressionStringValue
    extends OctezRollupMichelineOutboxTransactionParametersTypeExpression {
  final OctezRollupUnistring string;

  const OctezRollupMichelineOutboxTransactionParametersTypeExpressionStringValue({
    required this.string,
  });

  factory OctezRollupMichelineOutboxTransactionParametersTypeExpressionStringValue.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMichelineOutboxTransactionParametersTypeExpressionStringValue(
      string: OctezRollupUnistring.fromJson(json['string']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'string': string.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupMichelineOutboxTransactionParametersTypeExpressionBytes
    extends OctezRollupMichelineOutboxTransactionParametersTypeExpression {
  final String bytes;

  const OctezRollupMichelineOutboxTransactionParametersTypeExpressionBytes({
    required this.bytes,
  });

  factory OctezRollupMichelineOutboxTransactionParametersTypeExpressionBytes.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMichelineOutboxTransactionParametersTypeExpressionBytes(
      bytes:
          (json['bytes'] is num
              ? json['bytes'].toString()
              : json.valueAsString('bytes')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'bytes': bytes}.notNullValue.cast<String, dynamic>();
}

class OctezRollupMichelineOutboxTransactionParametersTypeExpressionSequence
    extends OctezRollupMichelineOutboxTransactionParametersTypeExpression {
  final List<OctezRollupMichelineOutboxTransactionParametersTypeExpression>
  value;
  const OctezRollupMichelineOutboxTransactionParametersTypeExpressionSequence(
    this.value,
  );

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

class OctezRollupMichelineOutboxTransactionParametersTypeExpressionPrimGeneric
    extends OctezRollupMichelineOutboxTransactionParametersTypeExpression {
  final OctezRollupUnistring prim;
  final List<OctezRollupMichelineOutboxTransactionParametersTypeExpression>?
  args;
  final List<OctezRollupUnistring>? annots;

  const OctezRollupMichelineOutboxTransactionParametersTypeExpressionPrimGeneric({
    required this.prim,
    this.args,
    this.annots,
  });

  factory OctezRollupMichelineOutboxTransactionParametersTypeExpressionPrimGeneric.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMichelineOutboxTransactionParametersTypeExpressionPrimGeneric(
      prim: OctezRollupUnistring.fromJson(json['prim']),
      args:
          json.hasValue('args')
              ? json
                  .valueEnsureAsList<dynamic>('args')
                  .map(
                    (e) =>
                        OctezRollupMichelineOutboxTransactionParametersTypeExpression.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      annots:
          json.hasValue('annots')
              ? json
                  .valueEnsureAsList<dynamic>('annots')
                  .map((e) => OctezRollupUnistring.fromJson(e))
                  .toList()
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'prim': prim.toJson(),
        'args': args?.map((e) => e.toJson()).toList(),
        'annots': annots?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupResponseGlobalBlockBlockIdOutboxItem {
  const OctezRollupResponseGlobalBlockBlockIdOutboxItem();

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('message_index') && map.hasValue('whitelist_update')) {
        return OctezRollupResponseGlobalBlockBlockIdOutboxItemWhitelistUpdate.fromJson(
          map,
        );
      }
      if (map.hasValue('message_index') && map.hasValue('transactions')) {
        return OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactions.fromJson(
          map,
        );
      }
      if (map.hasValue('message_index') &&
          map.hasValue('canonical_rollup_signal')) {
        return OctezRollupResponseGlobalBlockBlockIdOutboxItemCanonicalRollupSignal.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseGlobalBlockBlockIdOutboxItem',
      reason:
          'Cannot parse OctezRollupResponseGlobalBlockBlockIdOutboxItem from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItemWhitelistUpdate
    extends OctezRollupResponseGlobalBlockBlockIdOutboxItem {
  final int messageIndex;
  final List<OctezRollupSignaturePublicKeyHash>? whitelistUpdate;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItemWhitelistUpdate({
    required this.messageIndex,
    this.whitelistUpdate,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItemWhitelistUpdate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItemWhitelistUpdate(
      messageIndex: json.valueAsInt('message_index'),
      whitelistUpdate:
          json.hasValue('whitelist_update')
              ? json
                  .valueEnsureAsList<dynamic>('whitelist_update')
                  .map((e) => OctezRollupUnistring.fromJson(e))
                  .toList()
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'message_index': messageIndex,
        'whitelist_update': whitelistUpdate?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactions
    extends OctezRollupResponseGlobalBlockBlockIdOutboxItem {
  final int messageIndex;
  final List<
    OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactionsTransactionsItem
  >
  transactions;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactions({
    required this.messageIndex,
    required this.transactions,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactions.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactions(
      messageIndex: json.valueAsInt('message_index'),
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map(
                (e) =>
                    OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactionsTransactionsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'message_index': messageIndex,
        'transactions': transactions.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItemCanonicalRollupSignal
    extends OctezRollupResponseGlobalBlockBlockIdOutboxItem {
  final int messageIndex;
  final OctezRollupUnistring canonicalRollupSignal;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItemCanonicalRollupSignal({
    required this.messageIndex,
    required this.canonicalRollupSignal,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItemCanonicalRollupSignal.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItemCanonicalRollupSignal(
      messageIndex: json.valueAsInt('message_index'),
      canonicalRollupSignal: OctezRollupUnistring.fromJson(
        json['canonical_rollup_signal'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'message_index': messageIndex,
        'canonical_rollup_signal': canonicalRollupSignal.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupTimestampSystemRFCEncodingValue {
  const OctezRollupTimestampSystemRFCEncodingValue();

  factory OctezRollupTimestampSystemRFCEncodingValue.fromJson(dynamic json) {
    throw OnChainErrors.tezosPlugin(
      'OctezRollupTimestampSystemRFCEncodingValue',
      reason:
          'Cannot parse OctezRollupTimestampSystemRFCEncodingValue from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupTimestampSystemRFCEncodingValueTimestampRfc
    extends OctezRollupTimestampSystemRFCEncodingValue {
  final OctezRollupTimestampRfc value;
  const OctezRollupTimestampSystemRFCEncodingValueTimestampRfc(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class OctezRollupTimestampSystemSecondSinceEpochValue {
  const OctezRollupTimestampSystemSecondSinceEpochValue();

  factory OctezRollupTimestampSystemSecondSinceEpochValue.fromJson(
    dynamic json,
  ) {
    if (json is String) {
      return OctezRollupTimestampSystemSecondSinceEpochValueInt64(json);
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupTimestampSystemSecondSinceEpochValue',
      reason:
          'Cannot parse OctezRollupTimestampSystemSecondSinceEpochValue from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupTimestampSystemSecondSinceEpochValueInt64
    extends OctezRollupTimestampSystemSecondSinceEpochValue {
  final OctezRollupInt64 value;
  const OctezRollupTimestampSystemSecondSinceEpochValueInt64(this.value);

  @override
  dynamic toJson() => value;
}

/// A timestamp as seen by the underlying, local computer: subsecond-level precision, epoch or rfc3339 based.
sealed class OctezRollupTimestampSystem {
  const OctezRollupTimestampSystem();

  factory OctezRollupTimestampSystem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezRollupTimestampSystemRFCEncoding(
          OctezRollupTimestampSystemRFCEncodingValue.fromJson(map),
        );
      } catch (_) {}
      try {
        return OctezRollupTimestampSystemSecondSinceEpoch(
          OctezRollupTimestampSystemSecondSinceEpochValue.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return OctezRollupTimestampSystemRFCEncoding(
        OctezRollupTimestampSystemRFCEncodingValue.fromJson(json),
      );
    } catch (_) {}
    try {
      return OctezRollupTimestampSystemSecondSinceEpoch(
        OctezRollupTimestampSystemSecondSinceEpochValue.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezRollupTimestampSystem',
      reason: 'Cannot parse OctezRollupTimestampSystem from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupTimestampSystemRFCEncoding extends OctezRollupTimestampSystem {
  final OctezRollupTimestampSystemRFCEncodingValue value;
  const OctezRollupTimestampSystemRFCEncoding(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class OctezRollupTimestampSystemSecondSinceEpoch
    extends OctezRollupTimestampSystem {
  final OctezRollupTimestampSystemSecondSinceEpochValue value;
  const OctezRollupTimestampSystemSecondSinceEpoch(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class OctezRollupResponseGlobalBlockBlockIdCommittedStatus {
  const OctezRollupResponseGlobalBlockBlockIdCommittedStatus();

  factory OctezRollupResponseGlobalBlockBlockIdCommittedStatus.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('uncommitted')) {
        return OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommitted.fromJson(
          map,
        );
      }
      if (map.hasValue('committed')) {
        return OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommitted.fromJson(
          map,
        );
      }
      if (map.hasValue('cemented')) {
        return OctezRollupResponseGlobalBlockBlockIdCommittedStatusCemented.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseGlobalBlockBlockIdCommittedStatus',
      reason:
          'Cannot parse OctezRollupResponseGlobalBlockBlockIdCommittedStatus from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommitted
    extends OctezRollupResponseGlobalBlockBlockIdCommittedStatus {
  final OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommittedUncommitted
  uncommitted;

  const OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommitted({
    required this.uncommitted,
  });

  factory OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommitted.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommitted(
      uncommitted: json.valueTo<
        OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommittedUncommitted,
        Map<String, dynamic>
      >(
        key: 'uncommitted',
        parse:
            (v) =>
                OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommittedUncommitted.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'uncommitted': uncommitted.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommitted
    extends OctezRollupResponseGlobalBlockBlockIdCommittedStatus {
  final OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommittedCommitted
  committed;

  const OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommitted({
    required this.committed,
  });

  factory OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommitted.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommitted(
      committed: json.valueTo<
        OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommittedCommitted,
        Map<String, dynamic>
      >(
        key: 'committed',
        parse:
            (v) =>
                OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommittedCommitted.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'committed': committed.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdCommittedStatusCemented
    extends OctezRollupResponseGlobalBlockBlockIdCommittedStatus {
  final OctezRollupResponseGlobalBlockBlockIdCommittedStatusCementedCemented
  cemented;

  const OctezRollupResponseGlobalBlockBlockIdCommittedStatusCemented({
    required this.cemented,
  });

  factory OctezRollupResponseGlobalBlockBlockIdCommittedStatusCemented.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdCommittedStatusCemented(
      cemented: json.valueTo<
        OctezRollupResponseGlobalBlockBlockIdCommittedStatusCementedCemented,
        Map<String, dynamic>
      >(
        key: 'cemented',
        parse:
            (v) =>
                OctezRollupResponseGlobalBlockBlockIdCommittedStatusCementedCemented.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'cemented': cemented.toJson()}.notNullValue.cast<String, dynamic>();
}

enum OctezRollupN025PsUshuaiMichelsonV1Primitives {
  sHA256("SHA256"),
  pUSH("PUSH"),
  gETANDUPDATE("GET_AND_UPDATE"),
  rENAME("RENAME"),
  false_("False"),
  cAST("CAST"),
  iSNAT("ISNAT"),
  unit("unit"),
  pACK("PACK"),
  eMIT("EMIT"),
  string("string"),
  chainId("chain_id"),
  pair("Pair"),
  constant("constant"),
  iFCONS("IF_CONS"),
  iNDEXADDRESS("INDEX_ADDRESS"),
  signature("signature"),
  storage("storage"),
  oR("OR"),
  chest("chest"),
  view("view"),
  uNPACK("UNPACK"),
  aDD("ADD"),
  dIP("DIP"),
  lambda("lambda"),
  mEM("MEM"),
  bYTES("BYTES"),
  sENDER("SENDER"),
  aDDRESS("ADDRESS"),
  cDR("CDR"),
  sAPLINGEMPTYSTATE("SAPLING_EMPTY_STATE"),
  nat("nat"),
  lOOP("LOOP"),
  gETADDRESSINDEX("GET_ADDRESS_INDEX"),
  mutez("mutez"),
  sHA512("SHA512"),
  cREATEACCOUNT("CREATE_ACCOUNT"),
  bLAKE2B("BLAKE2B"),
  rEADTICKET("READ_TICKET"),
  lE("LE"),
  saplingTransactionDeprecated("sapling_transaction_deprecated"),
  bytes("bytes"),
  timestamp("timestamp"),
  or("or"),
  cHAINID("CHAIN_ID"),
  ticket("ticket"),
  sELFADDRESS("SELF_ADDRESS"),
  sOURCE("SOURCE"),
  iMPLICITACCOUNT("IMPLICIT_ACCOUNT"),
  contract("contract"),
  aMOUNT("AMOUNT"),
  cHECKSIGNATURE("CHECK_SIGNATURE"),
  txRollupL2Address("tx_rollup_l2_address"),
  lSR("LSR"),
  eQ("EQ"),
  elt("Elt"),
  oPENCHEST("OPEN_CHEST"),
  nIL("NIL"),
  cREATECONTRACT("CREATE_CONTRACT"),
  lSL("LSL"),
  tRANSFERTOKENS("TRANSFER_TOKENS"),
  jOINTICKETS("JOIN_TICKETS"),
  sWAP("SWAP"),
  some("Some"),
  parameter("parameter"),
  option("option"),
  never("never"),
  vIEW("VIEW"),
  none("None"),
  sLICE("SLICE"),
  bool_("bool"),
  aBS("ABS"),
  key("key"),
  dUG("DUG"),
  keyHash("key_hash"),
  cAR("CAR"),
  gET("GET"),
  hASHKEY("HASH_KEY"),
  cONCAT("CONCAT"),
  lEVEL("LEVEL"),
  sAPLINGVERIFYUPDATE("SAPLING_VERIFY_UPDATE"),
  tOTALVOTINGPOWER("TOTAL_VOTING_POWER"),
  lambdaRec("Lambda_rec"),
  sIZE("SIZE"),
  map("map"),
  sTEPSTOQUOTA("STEPS_TO_QUOTA"),
  iFNONE("IF_NONE"),
  uNPAIR("UNPAIR"),
  cONS("CONS"),
  unit2("Unit"),
  cONTRACT("CONTRACT"),
  mUL("MUL"),
  uPDATE("UPDATE"),
  eXEC("EXEC"),
  pAIR("PAIR"),
  sPLITTICKET("SPLIT_TICKET"),
  rIGHT("RIGHT"),
  int_("int"),
  aND("AND"),
  nEG("NEG"),
  bigMap("big_map"),
  bALANCE("BALANCE"),
  sETDELEGATE("SET_DELEGATE"),
  nEVER("NEVER"),
  mINBLOCKTIME("MIN_BLOCK_TIME"),
  iNT("INT"),
  bls12381Fr("bls12_381_fr"),
  iTER("ITER"),
  true_("True"),
  right("Right"),
  ticket2("Ticket"),
  gT("GT"),
  dIG("DIG"),
  operation("operation"),
  sUB("SUB"),
  eDIV("EDIV"),
  mAP("MAP"),
  iFLEFT("IF_LEFT"),
  list("list"),
  vOTINGPOWER("VOTING_POWER"),
  lAMBDAREC("LAMBDA_REC"),
  left("Left"),
  bls12381G2("bls12_381_g2"),
  tICKETDEPRECATED("TICKET_DEPRECATED"),
  bls12381G1("bls12_381_g1"),
  saplingState("sapling_state"),
  dUP("DUP"),
  lEFT("LEFT"),
  chestKey("chest_key"),
  pair2("pair"),
  sHA3("SHA3"),
  lAMBDA("LAMBDA"),
  nOT("NOT"),
  kECCAK("KECCAK"),
  nOW("NOW"),
  nAT("NAT"),
  gE("GE"),
  set_("set"),
  address("address"),
  nEQ("NEQ"),
  iF("IF"),
  fAILWITH("FAILWITH"),
  nONE("NONE"),
  sUBMUTEZ("SUB_MUTEZ"),
  xOR("XOR"),
  lOOPLEFT("LOOP_LEFT"),
  pAIRINGCHECK("PAIRING_CHECK"),
  dROP("DROP"),
  eMPTYBIGMAP("EMPTY_BIG_MAP"),
  uNIT("UNIT"),
  saplingTransaction("sapling_transaction"),
  tICKET("TICKET"),
  eMPTYMAP("EMPTY_MAP"),
  aPPLY("APPLY"),
  lT("LT"),
  sOME("SOME"),
  iSIMPLICITACCOUNT("IS_IMPLICIT_ACCOUNT"),
  cOMPARE("COMPARE"),
  eMPTYSET("EMPTY_SET"),
  sELF("SELF"),
  code("code");

  final String value;
  const OctezRollupN025PsUshuaiMichelsonV1Primitives(this.value);

  static OctezRollupN025PsUshuaiMichelsonV1Primitives fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupN025PsUshuaiMichelsonV1Primitives.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupMicheline025PsUshuaiMichelsonV1Expression {
  const OctezRollupMicheline025PsUshuaiMichelsonV1Expression();

  factory OctezRollupMicheline025PsUshuaiMichelsonV1Expression.fromJson(
    dynamic json,
  ) {
    if (json is List) {
      return OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionSequence(
        (json)
            .map(
              (e) =>
                  OctezRollupMicheline025PsUshuaiMichelsonV1Expression.fromJson(
                    e,
                  ),
            )
            .toList(),
      );
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('prim')) {
        return OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionPrimGeneric.fromJson(
          map,
        );
      }
      if (map.hasValue('int')) {
        return OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionInt.fromJson(
          map,
        );
      }
      if (map.hasValue('string')) {
        return OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionStringValue.fromJson(
          map,
        );
      }
      if (map.hasValue('bytes')) {
        return OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionBytes.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupMicheline025PsUshuaiMichelsonV1Expression',
      reason:
          'Cannot parse OctezRollupMicheline025PsUshuaiMichelsonV1Expression from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionInt
    extends OctezRollupMicheline025PsUshuaiMichelsonV1Expression {
  final OctezRollupBignum int_;

  const OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionInt({
    required this.int_,
  });

  factory OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionInt.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionInt(
      int_:
          (json['int'] is num
              ? json['int'].toString()
              : json.valueAsString('int')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'int': int_}.notNullValue.cast<String, dynamic>();
}

class OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionStringValue
    extends OctezRollupMicheline025PsUshuaiMichelsonV1Expression {
  final OctezRollupUnistring string;

  const OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionStringValue({
    required this.string,
  });

  factory OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionStringValue.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionStringValue(
      string: OctezRollupUnistring.fromJson(json['string']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'string': string.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionBytes
    extends OctezRollupMicheline025PsUshuaiMichelsonV1Expression {
  final String bytes;

  const OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionBytes({
    required this.bytes,
  });

  factory OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionBytes.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionBytes(
      bytes:
          (json['bytes'] is num
              ? json['bytes'].toString()
              : json.valueAsString('bytes')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'bytes': bytes}.notNullValue.cast<String, dynamic>();
}

class OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionSequence
    extends OctezRollupMicheline025PsUshuaiMichelsonV1Expression {
  final List<OctezRollupMicheline025PsUshuaiMichelsonV1Expression> value;
  const OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionSequence(
    this.value,
  );

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

class OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionPrimGeneric
    extends OctezRollupMicheline025PsUshuaiMichelsonV1Expression {
  final OctezRollupN025PsUshuaiMichelsonV1Primitives prim;
  final List<OctezRollupMicheline025PsUshuaiMichelsonV1Expression>? args;
  final List<OctezRollupUnistring>? annots;

  const OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionPrimGeneric({
    required this.prim,
    this.args,
    this.annots,
  });

  factory OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionPrimGeneric.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupMicheline025PsUshuaiMichelsonV1ExpressionPrimGeneric(
      prim: OctezRollupN025PsUshuaiMichelsonV1Primitives.fromJson(json['prim']),
      args:
          json.hasValue('args')
              ? json
                  .valueEnsureAsList<dynamic>('args')
                  .map(
                    (e) =>
                        OctezRollupMicheline025PsUshuaiMichelsonV1Expression.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      annots:
          json.hasValue('annots')
              ? json
                  .valueEnsureAsList<dynamic>('annots')
                  .map((e) => OctezRollupUnistring.fromJson(e))
                  .toList()
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'prim': prim.toJson(),
        'args': args?.map((e) => e.toJson()).toList(),
        'annots': annots?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

enum OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchKind {
  untyped("untyped");

  final String value;
  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchKind(
    this.value,
  );

  static OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedKind {
  typed("typed");

  final String value;
  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedKind(
    this.value,
  );

  static OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdateKind {
  whitelistUpdate("whitelist_update");

  final String value;
  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdateKind(
    this.value,
  );

  static OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdateKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdateKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignalKind {
  canonicalRollupSignal("canonical_rollup_signal");

  final String value;
  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignalKind(
    this.value,
  );

  static OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignalKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignalKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message {
  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message();

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['kind'] == "canonical_rollup_signal" && map.hasValue('payload')) {
        return OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignal.fromJson(
          map,
        );
      }
      if (map['kind'] == "untyped" && map.hasValue('transactions')) {
        return OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatch.fromJson(
          map,
        );
      }
      if (map['kind'] == "typed" && map.hasValue('transactions')) {
        return OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTyped.fromJson(
          map,
        );
      }
      if (map['kind'] == "whitelist_update") {
        return OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdate.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message',
      reason:
          'Cannot parse OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatch
    extends OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message {
  final List<
    OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTransactionsItem
  >
  transactions;
  final OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchKind
  kind;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatch({
    required this.transactions,
    required this.kind,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatch.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatch(
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map(
                (e) =>
                    OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTransactionsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      kind:
          OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchKind.fromJson(
            json['kind'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'transactions': transactions.map((e) => e.toJson()).toList(),
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTyped
    extends OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message {
  final List<
    OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedTransactionsItem
  >
  transactions;
  final OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedKind
  kind;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTyped({
    required this.transactions,
    required this.kind,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTyped.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTyped(
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map(
                (e) =>
                    OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedTransactionsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      kind:
          OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedKind.fromJson(
            json['kind'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'transactions': transactions.map((e) => e.toJson()).toList(),
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdate
    extends OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message {
  final List<OctezRollupSignaturePublicKeyHash>? whitelist;
  final OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdateKind
  kind;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdate({
    this.whitelist,
    required this.kind,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdate(
      whitelist:
          json.hasValue('whitelist')
              ? json
                  .valueEnsureAsList<dynamic>('whitelist')
                  .map((e) => OctezRollupUnistring.fromJson(e))
                  .toList()
              : null,
      kind:
          OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageWhitelistUpdateKind.fromJson(
            json['kind'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'whitelist': whitelist?.map((e) => e.toJson()).toList(),
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignal
    extends OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message {
  final OctezRollupUnistring payload;
  final OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignalKind
  kind;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignal({
    required this.payload,
    required this.kind,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignal.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignal(
      payload: OctezRollupUnistring.fromJson(json['payload']),
      kind:
          OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageCanonicalRollupSignalKind.fromJson(
            json['kind'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'payload': payload.toJson(),
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

enum OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmStateKind {
  pvmState("pvm_state");

  final String value;
  const OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmStateKind(
    this.value,
  );

  static OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmStateKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmStateKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorageKind {
  durableStorage("durable_storage");

  final String value;
  const OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorageKind(
    this.value,
  );

  static OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorageKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorageKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItem {
  const OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItem();

  factory OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['kind'] == "pvm_state" && map.hasValue('key')) {
        return OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmState.fromJson(
          map,
        );
      }
      if (map['kind'] == "durable_storage" && map.hasValue('key')) {
        return OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorage.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItem',
      reason:
          'Cannot parse OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItem from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmState
    extends OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItem {
  final OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmStateKind
  kind;
  final List<OctezRollupUnistring> key;

  const OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmState({
    required this.kind,
    required this.key,
  });

  factory OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmState.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmState(
      kind:
          OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemPvmStateKind.fromJson(
            json['kind'],
          ),
      key:
          json
              .valueEnsureAsList<dynamic>('key')
              .map((e) => OctezRollupUnistring.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'key': key.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorage
    extends OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItem {
  final OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorageKind
  kind;
  final List<OctezRollupUnistring> key;

  const OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorage({
    required this.kind,
    required this.key,
  });

  factory OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorage.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorage(
      kind:
          OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItemDurableStorageKind.fromJson(
            json['kind'],
          ),
      key:
          json
              .valueEnsureAsList<dynamic>('key')
              .map((e) => OctezRollupUnistring.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'key': key.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

/// Either a plain UTF8 string, or a sequence of bytes for strings that contain invalid byte sequences.
sealed class OctezRollupResponseGlobalBlockBlockIdStatus {
  const OctezRollupResponseGlobalBlockBlockIdStatus();

  factory OctezRollupResponseGlobalBlockBlockIdStatus.fromJson(dynamic json) {
    if (json is String) {
      return OctezRollupResponseGlobalBlockBlockIdStatusStringValue(json);
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('invalid_utf8_string')) {
        return OctezRollupResponseGlobalBlockBlockIdStatusInvalidUtf8String.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseGlobalBlockBlockIdStatus',
      reason:
          'Cannot parse OctezRollupResponseGlobalBlockBlockIdStatus from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseGlobalBlockBlockIdStatusStringValue
    extends OctezRollupResponseGlobalBlockBlockIdStatus {
  final String value;
  const OctezRollupResponseGlobalBlockBlockIdStatusStringValue(this.value);

  @override
  dynamic toJson() => value;
}

class OctezRollupResponseGlobalBlockBlockIdStatusInvalidUtf8String
    extends OctezRollupResponseGlobalBlockBlockIdStatus {
  final BuBytes invalidUtf8String;

  OctezRollupResponseGlobalBlockBlockIdStatusInvalidUtf8String({
    required List<int> invalidUtf8String,
  }) : invalidUtf8String = invalidUtf8String.asImmutableBytes;

  factory OctezRollupResponseGlobalBlockBlockIdStatusInvalidUtf8String.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdStatusInvalidUtf8String(
      invalidUtf8String: json.valueAsList<List<int>>('invalid_utf8_string'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'invalid_utf8_string': invalidUtf8String,
      }.notNullValue.cast<String, dynamic>();
}

enum OctezRollupResponseHealthL1Connection {
  connected("connected"),
  reconnecting("reconnecting"),
  disconnected("disconnected");

  final String value;
  const OctezRollupResponseHealthL1Connection(this.value);

  static OctezRollupResponseHealthL1Connection fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseHealthL1Connection.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupResponseHealthActiveWorkersItemItemVariant1Value {
  const OctezRollupResponseHealthActiveWorkersItemItemVariant1Value();

  factory OctezRollupResponseHealthActiveWorkersItemItemVariant1Value.fromJson(
    dynamic json,
  ) {
    if (json is String) {
      return switch (json) {
        'running' =>
          const OctezRollupResponseHealthActiveWorkersItemItemVariant1ValueRunning(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezRollupResponseHealthActiveWorkersItemItemVariant1Value',
            reason:
                'Unknown OctezRollupResponseHealthActiveWorkersItemItemVariant1Value: $json',
          ),
      };
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('crashed')) {
        return OctezRollupResponseHealthActiveWorkersItemItemVariant1ValueCrashed.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseHealthActiveWorkersItemItemVariant1Value',
      reason:
          'Cannot parse OctezRollupResponseHealthActiveWorkersItemItemVariant1Value from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseHealthActiveWorkersItemItemVariant1ValueRunning
    extends OctezRollupResponseHealthActiveWorkersItemItemVariant1Value {
  const OctezRollupResponseHealthActiveWorkersItemItemVariant1ValueRunning();

  @override
  String toJson() => 'running';
}

class OctezRollupResponseHealthActiveWorkersItemItemVariant1ValueCrashed
    extends OctezRollupResponseHealthActiveWorkersItemItemVariant1Value {
  final OctezRollupException crashed;

  const OctezRollupResponseHealthActiveWorkersItemItemVariant1ValueCrashed({
    required this.crashed,
  });

  factory OctezRollupResponseHealthActiveWorkersItemItemVariant1ValueCrashed.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseHealthActiveWorkersItemItemVariant1ValueCrashed(
      crashed: OctezRollupUnistring.fromJson(json['crashed']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'crashed': crashed.toJson()}.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupResponseHealthActiveWorkersItemItem {
  const OctezRollupResponseHealthActiveWorkersItemItem();

  factory OctezRollupResponseHealthActiveWorkersItemItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezRollupResponseHealthActiveWorkersItemItemUnistring(
          OctezRollupUnistring.fromJson(map),
        );
      } catch (_) {}
      try {
        return OctezRollupResponseHealthActiveWorkersItemItemVariant1(
          OctezRollupResponseHealthActiveWorkersItemItemVariant1Value.fromJson(
            map,
          ),
        );
      } catch (_) {}
    }
    try {
      return OctezRollupResponseHealthActiveWorkersItemItemUnistring(
        OctezRollupUnistring.fromJson(json),
      );
    } catch (_) {}
    try {
      return OctezRollupResponseHealthActiveWorkersItemItemVariant1(
        OctezRollupResponseHealthActiveWorkersItemItemVariant1Value.fromJson(
          json,
        ),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseHealthActiveWorkersItemItem',
      reason:
          'Cannot parse OctezRollupResponseHealthActiveWorkersItemItem from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseHealthActiveWorkersItemItemUnistring
    extends OctezRollupResponseHealthActiveWorkersItemItem {
  final OctezRollupUnistring value;
  const OctezRollupResponseHealthActiveWorkersItemItemUnistring(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class OctezRollupResponseHealthActiveWorkersItemItemVariant1
    extends OctezRollupResponseHealthActiveWorkersItemItem {
  final OctezRollupResponseHealthActiveWorkersItemItemVariant1Value value;
  const OctezRollupResponseHealthActiveWorkersItemItemVariant1(this.value);

  @override
  dynamic toJson() => value.toJson();
}

enum OctezRollupResponseLocalBatcherQueueL2MessageIdUnknownStatus {
  unknown("unknown");

  final String value;
  const OctezRollupResponseLocalBatcherQueueL2MessageIdUnknownStatus(
    this.value,
  );

  static OctezRollupResponseLocalBatcherQueueL2MessageIdUnknownStatus fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseLocalBatcherQueueL2MessageIdUnknownStatus.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatchStatus {
  pendingBatch("pending_batch");

  final String value;
  const OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatchStatus(
    this.value,
  );

  static OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatchStatus
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatchStatus.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjectionStatus {
  pendingInjection("pending_injection");

  final String value;
  const OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjectionStatus(
    this.value,
  );

  static OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjectionStatus
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjectionStatus.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupScRollupNodeL1Operation {
  const OctezRollupScRollupNodeL1Operation();

  factory OctezRollupScRollupNodeL1Operation.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['kind'] == "refute" &&
          map.hasValue('rollup') &&
          map.hasValue('opponent') &&
          map.hasValue('refutation')) {
        return OctezRollupScRollupNodeL1OperationRefute.fromJson(map);
      }
      if (map['kind'] == "execute_outbox_message" &&
          map.hasValue('rollup') &&
          map.hasValue('cemented_commitment') &&
          map.hasValue('proof')) {
        return OctezRollupScRollupNodeL1OperationExecuteOutboxMessage.fromJson(
          map,
        );
      }
      if (map['kind'] == "publish_dal_commitment" &&
          map.hasValue('slot_index') &&
          map.hasValue('commitment') &&
          map.hasValue('commitment_proof')) {
        return OctezRollupScRollupNodeL1OperationPublishDalCommitment.fromJson(
          map,
        );
      }
      if (map['kind'] == "timeout" &&
          map.hasValue('rollup') &&
          map.hasValue('stakers')) {
        return OctezRollupScRollupNodeL1OperationTimeout.fromJson(map);
      }
      if (map['kind'] == "recover" &&
          map.hasValue('rollup') &&
          map.hasValue('staker')) {
        return OctezRollupScRollupNodeL1OperationRecover.fromJson(map);
      }
      if (map['kind'] == "cement" &&
          map.hasValue('rollup') &&
          map.hasValue('commitment')) {
        return OctezRollupScRollupNodeL1OperationCement.fromJson(map);
      }
      if (map['kind'] == "publish" &&
          map.hasValue('rollup') &&
          map.hasValue('commitment')) {
        return OctezRollupScRollupNodeL1OperationPublish.fromJson(map);
      }
      if (map['kind'] == "add_messages" && map.hasValue('message')) {
        return OctezRollupScRollupNodeL1OperationAddMessages.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupScRollupNodeL1Operation',
      reason: 'Cannot parse OctezRollupScRollupNodeL1Operation from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupScRollupNodeL1OperationAddMessages
    extends OctezRollupScRollupNodeL1Operation {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesKind kind;
  final List<String> message;

  const OctezRollupScRollupNodeL1OperationAddMessages({
    required this.kind,
    required this.message,
  });

  factory OctezRollupScRollupNodeL1OperationAddMessages.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupScRollupNodeL1OperationAddMessages(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesKind.fromJson(
            json['kind'],
          ),
      message: json.valueAsList<List<String>>('message'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'message': message,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupScRollupNodeL1OperationCement
    extends OctezRollupScRollupNodeL1Operation {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemCementKind kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupSmartRollupCommitmentHash commitment;

  const OctezRollupScRollupNodeL1OperationCement({
    required this.kind,
    required this.rollup,
    required this.commitment,
  });

  factory OctezRollupScRollupNodeL1OperationCement.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupScRollupNodeL1OperationCement(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemCementKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      commitment: OctezRollupUnistring.fromJson(json['commitment']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'commitment': commitment.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupScRollupNodeL1OperationPublish
    extends OctezRollupScRollupNodeL1Operation {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishKind kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment
  commitment;

  const OctezRollupScRollupNodeL1OperationPublish({
    required this.kind,
    required this.rollup,
    required this.commitment,
  });

  factory OctezRollupScRollupNodeL1OperationPublish.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupScRollupNodeL1OperationPublish(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      commitment: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment,
        Map<String, dynamic>
      >(
        key: 'commitment',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'commitment': commitment.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupScRollupNodeL1OperationRefute
    extends OctezRollupScRollupNodeL1Operation {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteKind kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupSignaturePublicKeyHash opponent;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation
  refutation;

  const OctezRollupScRollupNodeL1OperationRefute({
    required this.kind,
    required this.rollup,
    required this.opponent,
    required this.refutation,
  });

  factory OctezRollupScRollupNodeL1OperationRefute.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupScRollupNodeL1OperationRefute(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      opponent: OctezRollupUnistring.fromJson(json['opponent']),
      refutation:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutation.fromJson(
            json['refutation'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'opponent': opponent.toJson(),
        'refutation': refutation.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupScRollupNodeL1OperationTimeout
    extends OctezRollupScRollupNodeL1Operation {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutKind kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutStakers
  stakers;

  const OctezRollupScRollupNodeL1OperationTimeout({
    required this.kind,
    required this.rollup,
    required this.stakers,
  });

  factory OctezRollupScRollupNodeL1OperationTimeout.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupScRollupNodeL1OperationTimeout(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      stakers: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutStakers,
        Map<String, dynamic>
      >(
        key: 'stakers',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutStakers.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'stakers': stakers.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupScRollupNodeL1OperationRecover
    extends OctezRollupScRollupNodeL1Operation {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemRecoverKind kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupSignaturePublicKeyHash staker;

  const OctezRollupScRollupNodeL1OperationRecover({
    required this.kind,
    required this.rollup,
    required this.staker,
  });

  factory OctezRollupScRollupNodeL1OperationRecover.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupScRollupNodeL1OperationRecover(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemRecoverKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      staker: OctezRollupUnistring.fromJson(json['staker']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'staker': staker.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupScRollupNodeL1OperationExecuteOutboxMessage
    extends OctezRollupScRollupNodeL1Operation {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessageKind
  kind;
  final OctezRollupSmartRollupAddress rollup;
  final OctezRollupSmartRollupCommitmentHash cementedCommitment;
  final String proof;

  const OctezRollupScRollupNodeL1OperationExecuteOutboxMessage({
    required this.kind,
    required this.rollup,
    required this.cementedCommitment,
    required this.proof,
  });

  factory OctezRollupScRollupNodeL1OperationExecuteOutboxMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupScRollupNodeL1OperationExecuteOutboxMessage(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemExecuteOutboxMessageKind.fromJson(
            json['kind'],
          ),
      rollup: OctezRollupUnistring.fromJson(json['rollup']),
      cementedCommitment: OctezRollupUnistring.fromJson(
        json['cemented_commitment'],
      ),
      proof:
          (json['proof'] is num
              ? json['proof'].toString()
              : json.valueAsString('proof')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'rollup': rollup.toJson(),
        'cemented_commitment': cementedCommitment.toJson(),
        'proof': proof,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupScRollupNodeL1OperationPublishDalCommitment
    extends OctezRollupScRollupNodeL1Operation {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitmentKind
  kind;
  final int slotIndex;
  final OctezRollupDalCommitment commitment;
  final String commitmentProof;

  const OctezRollupScRollupNodeL1OperationPublishDalCommitment({
    required this.kind,
    required this.slotIndex,
    required this.commitment,
    required this.commitmentProof,
  });

  factory OctezRollupScRollupNodeL1OperationPublishDalCommitment.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupScRollupNodeL1OperationPublishDalCommitment(
      kind:
          OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishDalCommitmentKind.fromJson(
            json['kind'],
          ),
      slotIndex: json.valueAsInt('slot_index'),
      commitment: OctezRollupUnistring.fromJson(json['commitment']),
      commitmentProof:
          (json['commitment_proof'] is num
              ? json['commitment_proof'].toString()
              : json.valueAsString('commitment_proof')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'slot_index': slotIndex,
        'commitment': commitment.toJson(),
        'commitment_proof': commitmentProof,
      }.notNullValue.cast<String, dynamic>();
}

enum OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedStatus {
  injected("injected");

  final String value;
  const OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedStatus(
    this.value,
  );

  static OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedStatus fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedStatus.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedStatus {
  included("included");

  final String value;
  const OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedStatus(
    this.value,
  );

  static OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedStatus fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedStatus.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezRollupResponseLocalBatcherQueueL2MessageIdCommittedStatus {
  committed("committed");

  final String value;
  const OctezRollupResponseLocalBatcherQueueL2MessageIdCommittedStatus(
    this.value,
  );

  static OctezRollupResponseLocalBatcherQueueL2MessageIdCommittedStatus
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseLocalBatcherQueueL2MessageIdCommittedStatus.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupResponseLocalBatcherQueueL2MessageId {
  const OctezRollupResponseLocalBatcherQueueL2MessageId();

  factory OctezRollupResponseLocalBatcherQueueL2MessageId.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['status'] == "committed" &&
          map.hasValue('operation') &&
          map.hasValue('layer1') &&
          map.hasValue('finalized') &&
          map.hasValue('cemented') &&
          map.hasValue('commitment') &&
          map.hasValue('hash') &&
          map.hasValue('first_published_at_level') &&
          map.hasValue('published_at_level')) {
        return OctezRollupResponseLocalBatcherQueueL2MessageIdCommitted.fromJson(
          map,
        );
      }
      if (map['status'] == "included" &&
          map.hasValue('operation') &&
          map.hasValue('layer1') &&
          map.hasValue('finalized') &&
          map.hasValue('cemented')) {
        return OctezRollupResponseLocalBatcherQueueL2MessageIdIncluded.fromJson(
          map,
        );
      }
      if (map['status'] == "injected" &&
          map.hasValue('operation') &&
          map.hasValue('layer1')) {
        return OctezRollupResponseLocalBatcherQueueL2MessageIdInjected.fromJson(
          map,
        );
      }
      if (map['status'] == "pending_injection" && map.hasValue('operation')) {
        return OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjection.fromJson(
          map,
        );
      }
      if (map['status'] == "unknown") {
        return OctezRollupResponseLocalBatcherQueueL2MessageIdUnknown.fromJson(
          map,
        );
      }
      if (map['status'] == "pending_batch") {
        return OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatch.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseLocalBatcherQueueL2MessageId',
      reason:
          'Cannot parse OctezRollupResponseLocalBatcherQueueL2MessageId from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseLocalBatcherQueueL2MessageIdUnknown
    extends OctezRollupResponseLocalBatcherQueueL2MessageId {
  final String? content;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdUnknownStatus status;

  const OctezRollupResponseLocalBatcherQueueL2MessageIdUnknown({
    this.content,
    required this.status,
  });

  factory OctezRollupResponseLocalBatcherQueueL2MessageIdUnknown.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalBatcherQueueL2MessageIdUnknown(
      content:
          (json['content'] is num
              ? json['content'].toString()
              : json.valueAsString('content')),
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdUnknownStatus.fromJson(
            json['status'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'content': content,
        'status': status.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatch
    extends OctezRollupResponseLocalBatcherQueueL2MessageId {
  final String? content;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatchStatus
  status;

  const OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatch({
    this.content,
    required this.status,
  });

  factory OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatch.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatch(
      content:
          (json['content'] is num
              ? json['content'].toString()
              : json.valueAsString('content')),
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatchStatus.fromJson(
            json['status'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'content': content,
        'status': status.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjection
    extends OctezRollupResponseLocalBatcherQueueL2MessageId {
  final String? content;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjectionStatus
  status;
  final OctezRollupScRollupNodeL1Operation operation;

  const OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjection({
    this.content,
    required this.status,
    required this.operation,
  });

  factory OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjection.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjection(
      content:
          (json['content'] is num
              ? json['content'].toString()
              : json.valueAsString('content')),
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjectionStatus.fromJson(
            json['status'],
          ),
      operation: OctezRollupScRollupNodeL1Operation.fromJson(json['operation']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'content': content,
        'status': status.toJson(),
        'operation': operation.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalBatcherQueueL2MessageIdInjected
    extends OctezRollupResponseLocalBatcherQueueL2MessageId {
  final String? content;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedStatus status;
  final OctezRollupScRollupNodeL1Operation operation;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedLayer1 layer1;

  const OctezRollupResponseLocalBatcherQueueL2MessageIdInjected({
    this.content,
    required this.status,
    required this.operation,
    required this.layer1,
  });

  factory OctezRollupResponseLocalBatcherQueueL2MessageIdInjected.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalBatcherQueueL2MessageIdInjected(
      content:
          (json['content'] is num
              ? json['content'].toString()
              : json.valueAsString('content')),
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedStatus.fromJson(
            json['status'],
          ),
      operation: OctezRollupScRollupNodeL1Operation.fromJson(json['operation']),
      layer1: json.valueTo<
        OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedLayer1,
        Map<String, dynamic>
      >(
        key: 'layer1',
        parse:
            (v) =>
                OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedLayer1.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'content': content,
        'status': status.toJson(),
        'operation': operation.toJson(),
        'layer1': layer1.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalBatcherQueueL2MessageIdIncluded
    extends OctezRollupResponseLocalBatcherQueueL2MessageId {
  final String? content;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedStatus status;
  final OctezRollupScRollupNodeL1Operation operation;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1 layer1;
  final bool finalized;
  final bool cemented;

  const OctezRollupResponseLocalBatcherQueueL2MessageIdIncluded({
    this.content,
    required this.status,
    required this.operation,
    required this.layer1,
    required this.finalized,
    required this.cemented,
  });

  factory OctezRollupResponseLocalBatcherQueueL2MessageIdIncluded.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalBatcherQueueL2MessageIdIncluded(
      content:
          (json['content'] is num
              ? json['content'].toString()
              : json.valueAsString('content')),
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedStatus.fromJson(
            json['status'],
          ),
      operation: OctezRollupScRollupNodeL1Operation.fromJson(json['operation']),
      layer1: json.valueTo<
        OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1,
        Map<String, dynamic>
      >(
        key: 'layer1',
        parse:
            (v) =>
                OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1.fromJson(
                  v,
                ),
      ),
      finalized: json.valueAsBool('finalized'),
      cemented: json.valueAsBool('cemented'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'content': content,
        'status': status.toJson(),
        'operation': operation.toJson(),
        'layer1': layer1.toJson(),
        'finalized': finalized,
        'cemented': cemented,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalBatcherQueueL2MessageIdCommitted
    extends OctezRollupResponseLocalBatcherQueueL2MessageId {
  final String? content;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdCommittedStatus status;
  final OctezRollupScRollupNodeL1Operation operation;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1 layer1;
  final bool finalized;
  final bool cemented;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment
  commitment;
  final OctezRollupSmartRollupCommitmentHash hash;
  final int firstPublishedAtLevel;
  final int publishedAtLevel;

  const OctezRollupResponseLocalBatcherQueueL2MessageIdCommitted({
    this.content,
    required this.status,
    required this.operation,
    required this.layer1,
    required this.finalized,
    required this.cemented,
    required this.commitment,
    required this.hash,
    required this.firstPublishedAtLevel,
    required this.publishedAtLevel,
  });

  factory OctezRollupResponseLocalBatcherQueueL2MessageIdCommitted.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalBatcherQueueL2MessageIdCommitted(
      content:
          (json['content'] is num
              ? json['content'].toString()
              : json.valueAsString('content')),
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdCommittedStatus.fromJson(
            json['status'],
          ),
      operation: OctezRollupScRollupNodeL1Operation.fromJson(json['operation']),
      layer1: json.valueTo<
        OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1,
        Map<String, dynamic>
      >(
        key: 'layer1',
        parse:
            (v) =>
                OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1.fromJson(
                  v,
                ),
      ),
      finalized: json.valueAsBool('finalized'),
      cemented: json.valueAsBool('cemented'),
      commitment: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment,
        Map<String, dynamic>
      >(
        key: 'commitment',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment.fromJson(
                  v,
                ),
      ),
      hash: OctezRollupUnistring.fromJson(json['hash']),
      firstPublishedAtLevel: json.valueAsInt('first_published_at_level'),
      publishedAtLevel: json.valueAsInt('published_at_level'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'content': content,
        'status': status.toJson(),
        'operation': operation.toJson(),
        'layer1': layer1.toJson(),
        'finalized': finalized,
        'cemented': cemented,
        'commitment': commitment.toJson(),
        'hash': hash.toJson(),
        'first_published_at_level': firstPublishedAtLevel,
        'published_at_level': publishedAtLevel,
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus {
  const OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus();

  factory OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['status'] == "committed" &&
          map.hasValue('operation') &&
          map.hasValue('layer1') &&
          map.hasValue('finalized') &&
          map.hasValue('cemented') &&
          map.hasValue('commitment') &&
          map.hasValue('hash') &&
          map.hasValue('first_published_at_level') &&
          map.hasValue('published_at_level')) {
        return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusCommitted.fromJson(
          map,
        );
      }
      if (map['status'] == "included" &&
          map.hasValue('operation') &&
          map.hasValue('layer1') &&
          map.hasValue('finalized') &&
          map.hasValue('cemented')) {
        return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusIncluded.fromJson(
          map,
        );
      }
      if (map['status'] == "injected" &&
          map.hasValue('operation') &&
          map.hasValue('layer1')) {
        return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusInjected.fromJson(
          map,
        );
      }
      if (map['status'] == "pending_injection" && map.hasValue('operation')) {
        return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusPendingInjection.fromJson(
          map,
        );
      }
      if (map['status'] == "unknown") {
        return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusUnknown.fromJson(
          map,
        );
      }
      if (map['status'] == "pending_batch") {
        return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusPendingBatch.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus',
      reason:
          'Cannot parse OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusUnknown
    extends OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus {
  final OctezRollupResponseLocalBatcherQueueL2MessageIdUnknownStatus status;

  const OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusUnknown({
    required this.status,
  });

  factory OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusUnknown.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusUnknown(
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdUnknownStatus.fromJson(
            json['status'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'status': status.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusPendingBatch
    extends OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus {
  final OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatchStatus
  status;

  const OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusPendingBatch({
    required this.status,
  });

  factory OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusPendingBatch.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusPendingBatch(
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdPendingBatchStatus.fromJson(
            json['status'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'status': status.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusPendingInjection
    extends OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus {
  final OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjectionStatus
  status;
  final OctezRollupScRollupNodeL1Operation operation;

  const OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusPendingInjection({
    required this.status,
    required this.operation,
  });

  factory OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusPendingInjection.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusPendingInjection(
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdPendingInjectionStatus.fromJson(
            json['status'],
          ),
      operation: OctezRollupScRollupNodeL1Operation.fromJson(json['operation']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'status': status.toJson(),
        'operation': operation.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusInjected
    extends OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus {
  final OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedStatus status;
  final OctezRollupScRollupNodeL1Operation operation;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedLayer1 layer1;

  const OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusInjected({
    required this.status,
    required this.operation,
    required this.layer1,
  });

  factory OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusInjected.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusInjected(
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedStatus.fromJson(
            json['status'],
          ),
      operation: OctezRollupScRollupNodeL1Operation.fromJson(json['operation']),
      layer1: json.valueTo<
        OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedLayer1,
        Map<String, dynamic>
      >(
        key: 'layer1',
        parse:
            (v) =>
                OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedLayer1.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'status': status.toJson(),
        'operation': operation.toJson(),
        'layer1': layer1.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusIncluded
    extends OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus {
  final OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedStatus status;
  final OctezRollupScRollupNodeL1Operation operation;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1 layer1;
  final bool finalized;
  final bool cemented;

  const OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusIncluded({
    required this.status,
    required this.operation,
    required this.layer1,
    required this.finalized,
    required this.cemented,
  });

  factory OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusIncluded.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusIncluded(
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedStatus.fromJson(
            json['status'],
          ),
      operation: OctezRollupScRollupNodeL1Operation.fromJson(json['operation']),
      layer1: json.valueTo<
        OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1,
        Map<String, dynamic>
      >(
        key: 'layer1',
        parse:
            (v) =>
                OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1.fromJson(
                  v,
                ),
      ),
      finalized: json.valueAsBool('finalized'),
      cemented: json.valueAsBool('cemented'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'status': status.toJson(),
        'operation': operation.toJson(),
        'layer1': layer1.toJson(),
        'finalized': finalized,
        'cemented': cemented,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusCommitted
    extends OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus {
  final OctezRollupResponseLocalBatcherQueueL2MessageIdCommittedStatus status;
  final OctezRollupScRollupNodeL1Operation operation;
  final OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1 layer1;
  final bool finalized;
  final bool cemented;
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment
  commitment;
  final OctezRollupSmartRollupCommitmentHash hash;
  final int firstPublishedAtLevel;
  final int publishedAtLevel;

  const OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusCommitted({
    required this.status,
    required this.operation,
    required this.layer1,
    required this.finalized,
    required this.cemented,
    required this.commitment,
    required this.hash,
    required this.firstPublishedAtLevel,
    required this.publishedAtLevel,
  });

  factory OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusCommitted.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatusCommitted(
      status:
          OctezRollupResponseLocalBatcherQueueL2MessageIdCommittedStatus.fromJson(
            json['status'],
          ),
      operation: OctezRollupScRollupNodeL1Operation.fromJson(json['operation']),
      layer1: json.valueTo<
        OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1,
        Map<String, dynamic>
      >(
        key: 'layer1',
        parse:
            (v) =>
                OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1.fromJson(
                  v,
                ),
      ),
      finalized: json.valueAsBool('finalized'),
      cemented: json.valueAsBool('cemented'),
      commitment: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment,
        Map<String, dynamic>
      >(
        key: 'commitment',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment.fromJson(
                  v,
                ),
      ),
      hash: OctezRollupUnistring.fromJson(json['hash']),
      firstPublishedAtLevel: json.valueAsInt('first_published_at_level'),
      publishedAtLevel: json.valueAsInt('published_at_level'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'status': status.toJson(),
        'operation': operation.toJson(),
        'layer1': layer1.toJson(),
        'finalized': finalized,
        'cemented': cemented,
        'commitment': commitment.toJson(),
        'hash': hash.toJson(),
        'first_published_at_level': firstPublishedAtLevel,
        'published_at_level': publishedAtLevel,
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupResponseLocalOutboxPendingItemMessagesItemMessage {
  const OctezRollupResponseLocalOutboxPendingItemMessagesItemMessage();

  factory OctezRollupResponseLocalOutboxPendingItemMessagesItemMessage.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('whitelist_update')) {
        return OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageWhitelistUpdate.fromJson(
          map,
        );
      }
      if (map.hasValue('transactions')) {
        return OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageTransactions.fromJson(
          map,
        );
      }
      if (map.hasValue('canonical_rollup_signal')) {
        return OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageCanonicalRollupSignal.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseLocalOutboxPendingItemMessagesItemMessage',
      reason:
          'Cannot parse OctezRollupResponseLocalOutboxPendingItemMessagesItemMessage from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageWhitelistUpdate
    extends OctezRollupResponseLocalOutboxPendingItemMessagesItemMessage {
  final List<OctezRollupSignaturePublicKeyHash>? whitelistUpdate;

  const OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageWhitelistUpdate({
    this.whitelistUpdate,
  });

  factory OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageWhitelistUpdate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageWhitelistUpdate(
      whitelistUpdate:
          json.hasValue('whitelist_update')
              ? json
                  .valueEnsureAsList<dynamic>('whitelist_update')
                  .map((e) => OctezRollupUnistring.fromJson(e))
                  .toList()
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'whitelist_update': whitelistUpdate?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageTransactions
    extends OctezRollupResponseLocalOutboxPendingItemMessagesItemMessage {
  final List<
    OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactionsTransactionsItem
  >
  transactions;

  const OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageTransactions({
    required this.transactions,
  });

  factory OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageTransactions.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageTransactions(
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map(
                (e) =>
                    OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactionsTransactionsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'transactions': transactions.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageCanonicalRollupSignal
    extends OctezRollupResponseLocalOutboxPendingItemMessagesItemMessage {
  final OctezRollupUnistring canonicalRollupSignal;

  const OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageCanonicalRollupSignal({
    required this.canonicalRollupSignal,
  });

  factory OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageCanonicalRollupSignal.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalOutboxPendingItemMessagesItemMessageCanonicalRollupSignal(
      canonicalRollupSignal: OctezRollupUnistring.fromJson(
        json['canonical_rollup_signal'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'canonical_rollup_signal': canonicalRollupSignal.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

enum OctezRollupResponseLocalOutboxPendingItemStatus {
  pending("pending"),
  executable("executable"),
  lost("lost");

  final String value;
  const OctezRollupResponseLocalOutboxPendingItemStatus(this.value);

  static OctezRollupResponseLocalOutboxPendingItemStatus fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupResponseLocalOutboxPendingItemStatus.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezRollupResponseLocalSynchronized {
  const OctezRollupResponseLocalSynchronized();

  factory OctezRollupResponseLocalSynchronized.fromJson(dynamic json) {
    if (json is String) {
      return switch (json) {
        'synchronized' =>
          const OctezRollupResponseLocalSynchronizedSynchronized(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezRollupResponseLocalSynchronized',
            reason: 'Unknown OctezRollupResponseLocalSynchronized: $json',
          ),
      };
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('synchronizing')) {
        return OctezRollupResponseLocalSynchronizedSynchronizing.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseLocalSynchronized',
      reason: 'Cannot parse OctezRollupResponseLocalSynchronized from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseLocalSynchronizedSynchronized
    extends OctezRollupResponseLocalSynchronized {
  const OctezRollupResponseLocalSynchronizedSynchronized();

  @override
  String toJson() => 'synchronized';
}

class OctezRollupResponseLocalSynchronizedSynchronizing
    extends OctezRollupResponseLocalSynchronized {
  final OctezRollupResponseLocalSynchronizedSynchronizingSynchronizing
  synchronizing;

  const OctezRollupResponseLocalSynchronizedSynchronizing({
    required this.synchronizing,
  });

  factory OctezRollupResponseLocalSynchronizedSynchronizing.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalSynchronizedSynchronizing(
      synchronizing: json.valueTo<
        OctezRollupResponseLocalSynchronizedSynchronizingSynchronizing,
        Map<String, dynamic>
      >(
        key: 'synchronizing',
        parse:
            (v) =>
                OctezRollupResponseLocalSynchronizedSynchronizingSynchronizing.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'synchronizing': synchronizing.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezRollupResponseStatsMemory {
  const OctezRollupResponseStatsMemory();

  factory OctezRollupResponseStatsMemory.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('page_size') &&
          map.hasValue('size') &&
          map.hasValue('resident') &&
          map.hasValue('shared') &&
          map.hasValue('text') &&
          map.hasValue('lib') &&
          map.hasValue('data') &&
          map.hasValue('dt')) {
        return OctezRollupResponseStatsMemoryLinuxProcStatm.fromJson(map);
      }
      if (map.hasValue('page_size') &&
          map.hasValue('mem') &&
          map.hasValue('resident')) {
        return OctezRollupResponseStatsMemoryDarwinPs.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezRollupResponseStatsMemory',
      reason: 'Cannot parse OctezRollupResponseStatsMemory from $json',
    );
  }

  dynamic toJson();
}

class OctezRollupResponseStatsMemoryLinuxProcStatm
    extends OctezRollupResponseStatsMemory {
  final int pageSize;
  final OctezRollupInt64 size;
  final OctezRollupInt64 resident;
  final OctezRollupInt64 shared;
  final OctezRollupInt64 text;
  final OctezRollupInt64 lib;
  final OctezRollupInt64 data;
  final OctezRollupInt64 dt;

  const OctezRollupResponseStatsMemoryLinuxProcStatm({
    required this.pageSize,
    required this.size,
    required this.resident,
    required this.shared,
    required this.text,
    required this.lib,
    required this.data,
    required this.dt,
  });

  factory OctezRollupResponseStatsMemoryLinuxProcStatm.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseStatsMemoryLinuxProcStatm(
      pageSize: json.valueAsInt('page_size'),
      size:
          (json['size'] is num
              ? json['size'].toString()
              : json.valueAsString('size')),
      resident:
          (json['resident'] is num
              ? json['resident'].toString()
              : json.valueAsString('resident')),
      shared:
          (json['shared'] is num
              ? json['shared'].toString()
              : json.valueAsString('shared')),
      text:
          (json['text'] is num
              ? json['text'].toString()
              : json.valueAsString('text')),
      lib:
          (json['lib'] is num
              ? json['lib'].toString()
              : json.valueAsString('lib')),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString('data')),
      dt:
          (json['dt'] is num
              ? json['dt'].toString()
              : json.valueAsString('dt')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'page_size': pageSize,
        'size': size,
        'resident': resident,
        'shared': shared,
        'text': text,
        'lib': lib,
        'data': data,
        'dt': dt,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseStatsMemoryDarwinPs
    extends OctezRollupResponseStatsMemory {
  final int pageSize;
  final num mem;
  final OctezRollupInt64 resident;

  const OctezRollupResponseStatsMemoryDarwinPs({
    required this.pageSize,
    required this.mem,
    required this.resident,
  });

  factory OctezRollupResponseStatsMemoryDarwinPs.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseStatsMemoryDarwinPs(
      pageSize: json.valueAsInt('page_size'),
      mem: json.valueAsNum('mem'),
      resident:
          (json['resident'] is num
              ? json['resident'].toString()
              : json.valueAsString('resident')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'page_size': pageSize,
        'mem': mem,
        'resident': resident,
      }.notNullValue.cast<String, dynamic>();
}

/// Commit to disk every block
enum OctezRollupCommitEveryBlock {
  block("block");

  final String value;
  const OctezRollupCommitEveryBlock(this.value);

  static OctezRollupCommitEveryBlock fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupCommitEveryBlock.",
              ),
    );
  }

  String toJson() => value;
}

/// Commit to disk every time a commitment is computed
enum OctezRollupCommitEveryCommitment {
  commitment("commitment");

  final String value;
  const OctezRollupCommitEveryCommitment(this.value);

  static OctezRollupCommitEveryCommitment fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezRollupCommitEveryCommitment.",
              ),
    );
  }

  String toJson() => value;
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors {
  final int count;
  final OctezRollupError? last;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors({
    required this.count,
    this.last,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemAddMessagesErrors(
      count: json.valueAsInt('count'),
      last:
          json.hasValue('last')
              ? Map<String, dynamic>.from(json['last'] as Map)
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {'count': count, 'last': last}.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment {
  final OctezRollupSmartRollupStateHash compressedState;
  final int inboxLevel;
  final OctezRollupSmartRollupCommitmentHash predecessor;
  final OctezRollupInt64 numberOfTicks;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment({
    required this.compressedState,
    required this.inboxLevel,
    required this.predecessor,
    required this.numberOfTicks,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment(
      compressedState: OctezRollupUnistring.fromJson(json['compressed_state']),
      inboxLevel: json.valueAsInt('inbox_level'),
      predecessor: OctezRollupUnistring.fromJson(json['predecessor']),
      numberOfTicks:
          (json['number_of_ticks'] is num
              ? json['number_of_ticks'].toString()
              : json.valueAsString('number_of_ticks')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'compressed_state': compressedState.toJson(),
        'inbox_level': inboxLevel,
        'predecessor': predecessor.toJson(),
        'number_of_ticks': numberOfTicks,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepDissectionItem {
  final OctezRollupSmartRollupStateHash? state;
  final OctezRollupPositiveBignum tick;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepDissectionItem({
    this.state,
    required this.tick,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepDissectionItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemRefuteRefutationMoveStepDissectionItem(
      state:
          json.hasValue('state')
              ? OctezRollupUnistring.fromJson(json['state'])
              : null,
      tick:
          (json['tick'] is num
              ? json['tick'].toString()
              : json.valueAsString('tick')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'state': state?.toJson(),
        'tick': tick,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutStakers {
  final OctezRollupSignaturePublicKeyHash alice;
  final OctezRollupSignaturePublicKeyHash bob;

  const OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutStakers({
    required this.alice,
    required this.bob,
  });

  factory OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutStakers.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItemQueueItemTimeoutStakers(
      alice: OctezRollupUnistring.fromJson(json['alice']),
      bob: OctezRollupUnistring.fromJson(json['bob']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'alice': alice.toJson(),
        'bob': bob.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesItem {
  final List<OctezRollupResponseAdminInjectorQueuesItemTagsItem> tags;
  final List<OctezRollupResponseAdminInjectorQueuesItemQueueItem> queue;

  const OctezRollupResponseAdminInjectorQueuesItem({
    required this.tags,
    required this.queue,
  });

  factory OctezRollupResponseAdminInjectorQueuesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesItem(
      tags:
          json
              .valueEnsureAsList<dynamic>('tags')
              .map(
                (e) =>
                    OctezRollupResponseAdminInjectorQueuesItemTagsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      queue:
          json
              .valueEnsureAsList<dynamic>('queue')
              .map(
                (e) =>
                    OctezRollupResponseAdminInjectorQueuesItemQueueItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'tags': tags.map((e) => e.toJson()).toList(),
        'queue': queue.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesTotalInjectorsItem {
  final List<OctezRollupResponseAdminInjectorQueuesItemTagsItem> tags;
  final int queueSize;

  const OctezRollupResponseAdminInjectorQueuesTotalInjectorsItem({
    required this.tags,
    required this.queueSize,
  });

  factory OctezRollupResponseAdminInjectorQueuesTotalInjectorsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesTotalInjectorsItem(
      tags:
          json
              .valueEnsureAsList<dynamic>('tags')
              .map(
                (e) =>
                    OctezRollupResponseAdminInjectorQueuesItemTagsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      queueSize: json.valueAsInt('queue_size'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'tags': tags.map((e) => e.toJson()).toList(),
        'queue_size': queueSize,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseAdminInjectorQueuesTotal {
  final List<OctezRollupResponseAdminInjectorQueuesTotalInjectorsItem>
  injectors;
  final int total;

  const OctezRollupResponseAdminInjectorQueuesTotal({
    required this.injectors,
    required this.total,
  });

  factory OctezRollupResponseAdminInjectorQueuesTotal.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseAdminInjectorQueuesTotal(
      injectors:
          json
              .valueEnsureAsList<Map<String, dynamic>>('injectors')
              .map(
                (e) =>
                    OctezRollupResponseAdminInjectorQueuesTotalInjectorsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      total: json.valueAsInt('total'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'injectors': injectors.map((e) => e.toJson()).toList(),
        'total': total,
      }.notNullValue.cast<String, dynamic>();
}

/// Operators that sign operations of the smart rollup, by purpose
class OctezRollupResponseConfigSmartRollupNodeOperator {
  final OctezRollupResponseConfigSmartRollupNodeOperatorOperating? operating;
  final OctezRollupResponseConfigSmartRollupNodeOperatorOperating? batching;
  final OctezRollupResponseConfigSmartRollupNodeOperatorOperating? cementing;
  final OctezRollupResponseConfigSmartRollupNodeOperatorOperating? recovering;
  final OctezRollupResponseConfigSmartRollupNodeOperatorOperating?
  executingOutbox;

  const OctezRollupResponseConfigSmartRollupNodeOperator({
    this.operating,
    this.batching,
    this.cementing,
    this.recovering,
    this.executingOutbox,
  });

  factory OctezRollupResponseConfigSmartRollupNodeOperator.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigSmartRollupNodeOperator(
      operating:
          json.hasValue('operating')
              ? OctezRollupResponseConfigSmartRollupNodeOperatorOperating.fromJson(
                json['operating'],
              )
              : null,
      batching:
          json.hasValue('batching')
              ? OctezRollupResponseConfigSmartRollupNodeOperatorOperating.fromJson(
                json['batching'],
              )
              : null,
      cementing:
          json.hasValue('cementing')
              ? OctezRollupResponseConfigSmartRollupNodeOperatorOperating.fromJson(
                json['cementing'],
              )
              : null,
      recovering:
          json.hasValue('recovering')
              ? OctezRollupResponseConfigSmartRollupNodeOperatorOperating.fromJson(
                json['recovering'],
              )
              : null,
      executingOutbox:
          json.hasValue('executing_outbox')
              ? OctezRollupResponseConfigSmartRollupNodeOperatorOperating.fromJson(
                json['executing_outbox'],
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'operating': operating?.toJson(),
        'batching': batching?.toJson(),
        'cementing': cementing?.toJson(),
        'recovering': recovering?.toJson(),
        'executing_outbox': executingOutbox?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigFeeParametersPublish {
  /// Exclude operations with lower fees
  final OctezRollupMutez? minimalFees;

  /// Exclude operations with lower fees per byte
  final OctezRollupNanotez? minimalNanotezPerByte;

  /// Exclude operations with lower gas fees
  final OctezRollupNanotez? minimalNanotezPerGasUnit;

  /// Don't check that the fee is lower than the estimated default
  final bool? forceLowFee;

  /// The fee cap
  final OctezRollupMutez? feeCap;

  /// The burn cap
  final OctezRollupMutez? burnCap;

  const OctezRollupResponseConfigFeeParametersPublish({
    this.minimalFees,
    this.minimalNanotezPerByte,
    this.minimalNanotezPerGasUnit,
    this.forceLowFee,
    this.feeCap,
    this.burnCap,
  });

  factory OctezRollupResponseConfigFeeParametersPublish.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigFeeParametersPublish(
      minimalFees:
          (json['minimal-fees'] is num
              ? json['minimal-fees'].toString()
              : json.valueAsString('minimal-fees')),
      minimalNanotezPerByte: json.valueAsList<List<OctezRollupBignum>?>(
        'minimal-nanotez-per-byte',
      ),
      minimalNanotezPerGasUnit: json.valueAsList<List<OctezRollupBignum>?>(
        'minimal-nanotez-per-gas-unit',
      ),
      forceLowFee: json.valueAsBool('force-low-fee'),
      feeCap:
          (json['fee-cap'] is num
              ? json['fee-cap'].toString()
              : json.valueAsString('fee-cap')),
      burnCap:
          (json['burn-cap'] is num
              ? json['burn-cap'].toString()
              : json.valueAsString('burn-cap')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'minimal-fees': minimalFees,
        'minimal-nanotez-per-byte': minimalNanotezPerByte,
        'minimal-nanotez-per-gas-unit': minimalNanotezPerGasUnit,
        'force-low-fee': forceLowFee,
        'fee-cap': feeCap,
        'burn-cap': burnCap,
      }.notNullValue.cast<String, dynamic>();
}

/// The fee parameters for each purpose used when injecting operations in L1
class OctezRollupResponseConfigFeeParameters {
  final OctezRollupResponseConfigFeeParametersPublish? publish;
  final OctezRollupResponseConfigFeeParametersPublish? addMessages;
  final OctezRollupResponseConfigFeeParametersPublish? cement;
  final OctezRollupResponseConfigFeeParametersPublish? timeout;
  final OctezRollupResponseConfigFeeParametersPublish? refute;
  final OctezRollupResponseConfigFeeParametersPublish? recover;
  final OctezRollupResponseConfigFeeParametersPublish? executeOutboxMessage;
  final OctezRollupResponseConfigFeeParametersPublish? publishDalCommitment;

  const OctezRollupResponseConfigFeeParameters({
    this.publish,
    this.addMessages,
    this.cement,
    this.timeout,
    this.refute,
    this.recover,
    this.executeOutboxMessage,
    this.publishDalCommitment,
  });

  factory OctezRollupResponseConfigFeeParameters.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigFeeParameters(
      publish: json.valueTo<
        OctezRollupResponseConfigFeeParametersPublish?,
        Map<String, dynamic>
      >(
        key: 'publish',
        parse: (v) => OctezRollupResponseConfigFeeParametersPublish.fromJson(v),
      ),
      addMessages: json.valueTo<
        OctezRollupResponseConfigFeeParametersPublish?,
        Map<String, dynamic>
      >(
        key: 'add_messages',
        parse: (v) => OctezRollupResponseConfigFeeParametersPublish.fromJson(v),
      ),
      cement: json.valueTo<
        OctezRollupResponseConfigFeeParametersPublish?,
        Map<String, dynamic>
      >(
        key: 'cement',
        parse: (v) => OctezRollupResponseConfigFeeParametersPublish.fromJson(v),
      ),
      timeout: json.valueTo<
        OctezRollupResponseConfigFeeParametersPublish?,
        Map<String, dynamic>
      >(
        key: 'timeout',
        parse: (v) => OctezRollupResponseConfigFeeParametersPublish.fromJson(v),
      ),
      refute: json.valueTo<
        OctezRollupResponseConfigFeeParametersPublish?,
        Map<String, dynamic>
      >(
        key: 'refute',
        parse: (v) => OctezRollupResponseConfigFeeParametersPublish.fromJson(v),
      ),
      recover: json.valueTo<
        OctezRollupResponseConfigFeeParametersPublish?,
        Map<String, dynamic>
      >(
        key: 'recover',
        parse: (v) => OctezRollupResponseConfigFeeParametersPublish.fromJson(v),
      ),
      executeOutboxMessage: json.valueTo<
        OctezRollupResponseConfigFeeParametersPublish?,
        Map<String, dynamic>
      >(
        key: 'execute_outbox_message',
        parse: (v) => OctezRollupResponseConfigFeeParametersPublish.fromJson(v),
      ),
      publishDalCommitment: json.valueTo<
        OctezRollupResponseConfigFeeParametersPublish?,
        Map<String, dynamic>
      >(
        key: 'publish_dal_commitment',
        parse: (v) => OctezRollupResponseConfigFeeParametersPublish.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'publish': publish?.toJson(),
        'add_messages': addMessages?.toJson(),
        'cement': cement?.toJson(),
        'timeout': timeout?.toJson(),
        'refute': refute?.toJson(),
        'recover': recover?.toJson(),
        'execute_outbox_message': executeOutboxMessage?.toJson(),
        'publish_dal_commitment': publishDalCommitment?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigLoserModeFailureItem {
  final int level;
  final int messageIndex;
  final OctezRollupInt64 messageTick;

  const OctezRollupResponseConfigLoserModeFailureItem({
    required this.level,
    required this.messageIndex,
    required this.messageTick,
  });

  factory OctezRollupResponseConfigLoserModeFailureItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigLoserModeFailureItem(
      level: json.valueAsInt('level'),
      messageIndex: json.valueAsInt('message_index'),
      messageTick:
          (json['message_tick'] is num
              ? json['message_tick'].toString()
              : json.valueAsString('message_tick')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'level': level,
        'message_index': messageIndex,
        'message_tick': messageTick,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStoragePatchDurableStorage {
  final OctezRollupUnistring key;
  final String value;

  const OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStoragePatchDurableStorage({
    required this.key,
    required this.value,
  });

  factory OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStoragePatchDurableStorage.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStoragePatchDurableStorage(
      key: OctezRollupUnistring.fromJson(json['key']),
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString('value')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'key': key.toJson(),
        'value': value,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransaction {
  final OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination
  destination;
  final OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination
  entrypoint;

  const OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransaction({
    required this.destination,
    required this.entrypoint,
  });

  factory OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransaction.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransaction(
      destination:
          OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination.fromJson(
            json['destination'],
          ),
      entrypoint:
          OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransactionDestination.fromJson(
            json['entrypoint'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'destination': destination.toJson(),
        'entrypoint': entrypoint.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigExecuteOutboxMessagesFilterItem {
  final OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransaction
  transaction;

  const OctezRollupResponseConfigExecuteOutboxMessagesFilterItem({
    required this.transaction,
  });

  factory OctezRollupResponseConfigExecuteOutboxMessagesFilterItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigExecuteOutboxMessagesFilterItem(
      transaction: json.valueTo<
        OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransaction,
        Map<String, dynamic>
      >(
        key: 'transaction',
        parse:
            (v) =>
                OctezRollupResponseConfigExecuteOutboxMessagesFilterItemTransaction.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'transaction': transaction.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigBatcher {
  final int? minBatchElements;
  final int? minBatchSize;
  final int? maxBatchElements;
  final int? maxBatchSize;

  const OctezRollupResponseConfigBatcher({
    this.minBatchElements,
    this.minBatchSize,
    this.maxBatchElements,
    this.maxBatchSize,
  });

  factory OctezRollupResponseConfigBatcher.fromJson(Map<String, dynamic> json) {
    return OctezRollupResponseConfigBatcher(
      minBatchElements: json.valueAsInt('min_batch_elements'),
      minBatchSize: json.valueAsInt('min_batch_size'),
      maxBatchElements: json.valueAsInt('max_batch_elements'),
      maxBatchSize: json.valueAsInt('max_batch_size'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'min_batch_elements': minBatchElements,
        'min_batch_size': minBatchSize,
        'max_batch_elements': maxBatchElements,
        'max_batch_size': maxBatchSize,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigInjector {
  final int? retentionPeriod;
  final int? attempts;
  final int? injectionTtl;

  /// Maximum number of operations to include in a single L1 batch. If not specified, batches are limited only by the operation size limit.
  final int? maxBatchLength;

  const OctezRollupResponseConfigInjector({
    this.retentionPeriod,
    this.attempts,
    this.injectionTtl,
    this.maxBatchLength,
  });

  factory OctezRollupResponseConfigInjector.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigInjector(
      retentionPeriod: json.valueAsInt('retention_period'),
      attempts: json.valueAsInt('attempts'),
      injectionTtl: json.valueAsInt('injection_ttl'),
      maxBatchLength: json.valueAsInt('max_batch_length'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'retention_period': retentionPeriod,
        'attempts': attempts,
        'injection_ttl': injectionTtl,
        'max_batch_length': maxBatchLength,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigGcParameters {
  final int? frequency;
  final int? contextSplittingPeriod;

  const OctezRollupResponseConfigGcParameters({
    this.frequency,
    this.contextSplittingPeriod,
  });

  factory OctezRollupResponseConfigGcParameters.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigGcParameters(
      frequency: json.valueAsInt('frequency'),
      contextSplittingPeriod: json.valueAsInt('context_splitting_period'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'frequency': frequency,
        'context_splitting_period': contextSplittingPeriod,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfigCors {
  final List<OctezRollupUnistring> allowedHeaders;
  final List<OctezRollupUnistring> allowedOrigins;

  const OctezRollupResponseConfigCors({
    required this.allowedHeaders,
    required this.allowedOrigins,
  });

  factory OctezRollupResponseConfigCors.fromJson(Map<String, dynamic> json) {
    return OctezRollupResponseConfigCors(
      allowedHeaders:
          json
              .valueEnsureAsList<dynamic>('allowed_headers')
              .map((e) => OctezRollupUnistring.fromJson(e))
              .toList(),
      allowedOrigins:
          json
              .valueEnsureAsList<dynamic>('allowed_origins')
              .map((e) => OctezRollupUnistring.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'allowed_headers': allowedHeaders.map((e) => e.toJson()).toList(),
        'allowed_origins': allowedOrigins.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

/// Enable traces for GC events (costly)
class OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetry {
  final bool? enable;

  /// Filter for which GC events to emit traces
  final List<
    OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetryFilterItem
  >?
  filter;

  /// Minimal span duration for a GC event to be emitted
  final num? minDurationMs;

  const OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetry({
    this.enable,
    this.filter,
    this.minDurationMs,
  });

  factory OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetry.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetry(
      enable: json.valueAsBool('enable'),
      filter:
          json.hasValue('filter')
              ? json
                  .valueEnsureAsList<dynamic>('filter')
                  .map(
                    (e) =>
                        OctezRollupResponseConfigOpentelemetryDetailedOpentelemetryConfigGcTelemetryFilterItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      minDurationMs: json.valueAsNum('min_duration_ms'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'enable': enable,
        'filter': filter?.map((e) => e.toJson()).toList(),
        'min_duration_ms': minDurationMs,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseConfig {
  /// Smart rollup address
  final OctezRollupSmartRollupAddress smartRollupAddress;

  /// Whether the rollup is an Etherlink rollup. Defaults to identification based on known Etherlink addresses.
  final bool? etherlink;

  /// Boot sector
  final OctezRollupUnistring? bootSector;

  /// Operators that sign operations of the smart rollup, by purpose
  final OctezRollupResponseConfigSmartRollupNodeOperator
  smartRollupNodeOperator;

  /// RPC address
  final OctezRollupUnistring rpcAddr;

  /// RPC port
  final int rpcPort;

  /// Access control list
  final List<OctezRollupResponseConfigAclItem> acl;

  /// Metrics address
  final OctezRollupUnistring? metricsAddr;
  final bool performanceMetrics;

  /// The reconnection (to the tezos node) delay in seconds
  final num reconnectionDelay;

  /// The fee parameters for each purpose used when injecting operations in L1
  final OctezRollupResponseConfigFeeParameters feeParameters;

  /// The mode for this rollup node
  final OctezRollupScRollupNodeMode mode;

  /// If enabled, the rollup node will issue wrong commitments (for test only!)
  final OctezRollupResponseConfigLoserMode loserMode;

  /// Apply the unsafe PVM patches for this rollup (either user provided or hardcoded).
  final bool applyUnsafePatches;

  /// Unsafe patches to apply to the PVM. For tests only, don't set this value in production.
  final List<OctezRollupResponseConfigUnsafePvmPatchesItem> unsafePvmPatches;

  /// A filter to select which outbox messages the rollup will execute automatically (must be in maintenance or operator mode).
  final List<OctezRollupResponseConfigExecuteOutboxMessagesFilterItem>
  executeOutboxMessagesFilter;
  final OctezRollupUnistring? dALNodeEndpoint;
  final OctezRollupUnistring? preImagesEndpoint;
  final OctezRollupResponseConfigBatcher batcher;
  final OctezRollupResponseConfigInjector injector;
  final int l1BlocksCacheSize;
  final int l2BlocksCacheSize;
  final int? prefetchBlocks;

  /// When set to true, the rollup node only monitors L1 head which are finalized. This option has no effect for RISC-V rollups.
  final bool l1MonitorFinalized;
  final num l1RpcTimeout;
  final num loopRetryDelay;

  /// Deprecated
  final int? indexBufferSize;
  final int? irminCacheSize;
  final bool logKernelDebug;
  final OctezRollupUnistring? logKernelDebugFile;
  final bool unsafeDisableWasmKernelChecks;
  final bool noDegraded;

  /// When set to true, the rollup node will fall back to the slow VM interpreter when the fast execution engine fails instead of exiting.
  final bool slowVmFallback;
  final OctezRollupResponseConfigGcParameters gcParameters;
  final OctezRollupResponseConfigHistoryMode? historyMode;
  final OctezRollupResponseConfigCors cors;
  final bool bailOnDisagree;
  final OctezRollupResponseConfigCommitOn commitOn;

  /// Enable or disable opentelemetry profiling
  final OctezRollupResponseConfigOpentelemetry? opentelemetry;
  final int dalSlotStatusMaxFetchAttempts;

  const OctezRollupResponseConfig({
    required this.smartRollupAddress,
    this.etherlink,
    this.bootSector,
    required this.smartRollupNodeOperator,
    required this.rpcAddr,
    required this.rpcPort,
    required this.acl,
    this.metricsAddr,
    required this.performanceMetrics,
    required this.reconnectionDelay,
    required this.feeParameters,
    required this.mode,
    required this.loserMode,
    required this.applyUnsafePatches,
    required this.unsafePvmPatches,
    required this.executeOutboxMessagesFilter,
    this.dALNodeEndpoint,
    this.preImagesEndpoint,
    required this.batcher,
    required this.injector,
    required this.l1BlocksCacheSize,
    required this.l2BlocksCacheSize,
    this.prefetchBlocks,
    required this.l1MonitorFinalized,
    required this.l1RpcTimeout,
    required this.loopRetryDelay,
    this.indexBufferSize,
    this.irminCacheSize,
    required this.logKernelDebug,
    this.logKernelDebugFile,
    required this.unsafeDisableWasmKernelChecks,
    required this.noDegraded,
    required this.slowVmFallback,
    required this.gcParameters,
    this.historyMode,
    required this.cors,
    required this.bailOnDisagree,
    required this.commitOn,
    this.opentelemetry,
    required this.dalSlotStatusMaxFetchAttempts,
  });

  factory OctezRollupResponseConfig.fromJson(Map<String, dynamic> json) {
    return OctezRollupResponseConfig(
      smartRollupAddress: OctezRollupUnistring.fromJson(
        json['smart-rollup-address'],
      ),
      etherlink: json.valueAsBool('etherlink'),
      bootSector:
          json.hasValue('boot-sector')
              ? OctezRollupUnistring.fromJson(json['boot-sector'])
              : null,
      smartRollupNodeOperator: json.valueTo<
        OctezRollupResponseConfigSmartRollupNodeOperator,
        Map<String, dynamic>
      >(
        key: 'smart-rollup-node-operator',
        parse:
            (v) => OctezRollupResponseConfigSmartRollupNodeOperator.fromJson(v),
      ),
      rpcAddr: OctezRollupUnistring.fromJson(json['rpc-addr']),
      rpcPort: json.valueAsInt('rpc-port'),
      acl:
          json
              .valueEnsureAsList<dynamic>('acl')
              .map((e) => OctezRollupResponseConfigAclItem.fromJson(e))
              .toList(),
      metricsAddr:
          json.hasValue('metrics-addr')
              ? OctezRollupUnistring.fromJson(json['metrics-addr'])
              : null,
      performanceMetrics: json.valueAsBool('performance-metrics'),
      reconnectionDelay: json.valueAsNum('reconnection_delay'),
      feeParameters: json.valueTo<
        OctezRollupResponseConfigFeeParameters,
        Map<String, dynamic>
      >(
        key: 'fee-parameters',
        parse: (v) => OctezRollupResponseConfigFeeParameters.fromJson(v),
      ),
      mode: OctezRollupScRollupNodeMode.fromJson(json['mode']),
      loserMode: OctezRollupResponseConfigLoserMode.fromJson(
        json['loser-mode'],
      ),
      applyUnsafePatches: json.valueAsBool('apply-unsafe-patches'),
      unsafePvmPatches:
          json
              .valueEnsureAsList<dynamic>('unsafe-pvm-patches')
              .map(
                (e) =>
                    OctezRollupResponseConfigUnsafePvmPatchesItem.fromJson(e),
              )
              .toList(),
      executeOutboxMessagesFilter:
          json
              .valueEnsureAsList<Map<String, dynamic>>(
                'execute-outbox-messages-filter',
              )
              .map(
                (e) =>
                    OctezRollupResponseConfigExecuteOutboxMessagesFilterItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      dALNodeEndpoint:
          json.hasValue('DAL node endpoint')
              ? OctezRollupUnistring.fromJson(json['DAL node endpoint'])
              : null,
      preImagesEndpoint:
          json.hasValue('pre-images-endpoint')
              ? OctezRollupUnistring.fromJson(json['pre-images-endpoint'])
              : null,
      batcher: json
          .valueTo<OctezRollupResponseConfigBatcher, Map<String, dynamic>>(
            key: 'batcher',
            parse: (v) => OctezRollupResponseConfigBatcher.fromJson(v),
          ),
      injector: json
          .valueTo<OctezRollupResponseConfigInjector, Map<String, dynamic>>(
            key: 'injector',
            parse: (v) => OctezRollupResponseConfigInjector.fromJson(v),
          ),
      l1BlocksCacheSize: json.valueAsInt('l1_blocks_cache_size'),
      l2BlocksCacheSize: json.valueAsInt('l2_blocks_cache_size'),
      prefetchBlocks: json.valueAsInt('prefetch_blocks'),
      l1MonitorFinalized: json.valueAsBool('l1_monitor_finalized'),
      l1RpcTimeout: json.valueAsNum('l1_rpc_timeout'),
      loopRetryDelay: json.valueAsNum('loop_retry_delay'),
      indexBufferSize: json.valueAsInt('index_buffer_size'),
      irminCacheSize: json.valueAsInt('irmin_cache_size'),
      logKernelDebug: json.valueAsBool('log-kernel-debug'),
      logKernelDebugFile:
          json.hasValue('log-kernel-debug-file')
              ? OctezRollupUnistring.fromJson(json['log-kernel-debug-file'])
              : null,
      unsafeDisableWasmKernelChecks: json.valueAsBool(
        'unsafe-disable-wasm-kernel-checks',
      ),
      noDegraded: json.valueAsBool('no-degraded'),
      slowVmFallback: json.valueAsBool('slow-vm-fallback'),
      gcParameters: json
          .valueTo<OctezRollupResponseConfigGcParameters, Map<String, dynamic>>(
            key: 'gc-parameters',
            parse: (v) => OctezRollupResponseConfigGcParameters.fromJson(v),
          ),
      historyMode:
          json.hasValue('history-mode')
              ? OctezRollupResponseConfigHistoryMode.fromJson(
                json['history-mode'],
              )
              : null,
      cors: json.valueTo<OctezRollupResponseConfigCors, Map<String, dynamic>>(
        key: 'cors',
        parse: (v) => OctezRollupResponseConfigCors.fromJson(v),
      ),
      bailOnDisagree: json.valueAsBool('bail-on-disagree'),
      commitOn: OctezRollupResponseConfigCommitOn.fromJson(json['commit-on']),
      opentelemetry:
          json.hasValue('opentelemetry')
              ? OctezRollupResponseConfigOpentelemetry.fromJson(
                json['opentelemetry'],
              )
              : null,
      dalSlotStatusMaxFetchAttempts: json.valueAsInt(
        'dal_slot_status_max_fetch_attempts',
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'smart-rollup-address': smartRollupAddress.toJson(),
        'etherlink': etherlink,
        'boot-sector': bootSector?.toJson(),
        'smart-rollup-node-operator': smartRollupNodeOperator.toJson(),
        'rpc-addr': rpcAddr.toJson(),
        'rpc-port': rpcPort,
        'acl': acl.map((e) => e.toJson()).toList(),
        'metrics-addr': metricsAddr?.toJson(),
        'performance-metrics': performanceMetrics,
        'reconnection_delay': reconnectionDelay,
        'fee-parameters': feeParameters.toJson(),
        'mode': mode.toJson(),
        'loser-mode': loserMode.toJson(),
        'apply-unsafe-patches': applyUnsafePatches,
        'unsafe-pvm-patches': unsafePvmPatches.map((e) => e.toJson()).toList(),
        'execute-outbox-messages-filter':
            executeOutboxMessagesFilter.map((e) => e.toJson()).toList(),
        'DAL node endpoint': dALNodeEndpoint?.toJson(),
        'pre-images-endpoint': preImagesEndpoint?.toJson(),
        'batcher': batcher.toJson(),
        'injector': injector.toJson(),
        'l1_blocks_cache_size': l1BlocksCacheSize,
        'l2_blocks_cache_size': l2BlocksCacheSize,
        'prefetch_blocks': prefetchBlocks,
        'l1_monitor_finalized': l1MonitorFinalized,
        'l1_rpc_timeout': l1RpcTimeout,
        'loop_retry_delay': loopRetryDelay,
        'index_buffer_size': indexBufferSize,
        'irmin_cache_size': irminCacheSize,
        'log-kernel-debug': logKernelDebug,
        'log-kernel-debug-file': logKernelDebugFile?.toJson(),
        'unsafe-disable-wasm-kernel-checks': unsafeDisableWasmKernelChecks,
        'no-degraded': noDegraded,
        'slow-vm-fallback': slowVmFallback,
        'gc-parameters': gcParameters.toJson(),
        'history-mode': historyMode?.toJson(),
        'cors': cors.toJson(),
        'bail-on-disagree': bailOnDisagree,
        'commit-on': commitOn.toJson(),
        'opentelemetry': opentelemetry?.toJson(),
        'dal_slot_status_max_fetch_attempts': dalSlotStatusMaxFetchAttempts,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle {
  final OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicId id;
  final OctezRollupUnistring name;
  final OctezRollupUnistring? descr;

  const OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle({
    required this.id,
    required this.name,
    this.descr,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle(
      id: OctezRollupServiceTreeStaticStaticGetServicePathItemPDynamicId.fromJson(
        json['id'],
      ),
      name: OctezRollupUnistring.fromJson(json['name']),
      descr:
          json.hasValue('descr')
              ? OctezRollupUnistring.fromJson(json['descr'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id.toJson(),
        'name': name.toJson(),
        'descr': descr?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlagFlag {
  const OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlagFlag();

  factory OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlagFlag.fromJson(
    Map<String, dynamic> json,
  ) {
    return const OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindFlagFlag();
  }

  Map<String, dynamic> toJson() => {}.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceQueryItem {
  final OctezRollupUnistring name;
  final OctezRollupUnistring? description;
  final OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind kind;

  const OctezRollupServiceTreeStaticStaticGetServiceQueryItem({
    required this.name,
    this.description,
    required this.kind,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceQueryItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceQueryItem(
      name: OctezRollupUnistring.fromJson(json['name']),
      description:
          json.hasValue('description')
              ? OctezRollupUnistring.fromJson(json['description'])
              : null,
      kind: OctezRollupServiceTreeStaticStaticGetServiceQueryItemKind.fromJson(
        json['kind'],
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name.toJson(),
        'description': description?.toJson(),
        'kind': kind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupUnionCase {
  final int tag;
  final List<OctezRollupSchemaField> fields;
  final OctezRollupUnistring? name;

  const OctezRollupUnionCase({
    required this.tag,
    required this.fields,
    this.name,
  });

  factory OctezRollupUnionCase.fromJson(Map<String, dynamic> json) {
    return OctezRollupUnionCase(
      tag: json.valueAsInt('tag'),
      fields:
          json
              .valueEnsureAsList<dynamic>('fields')
              .map((e) => OctezRollupSchemaField.fromJson(e))
              .toList(),
      name:
          json.hasValue('name')
              ? OctezRollupUnistring.fromJson(json['name'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'tag': tag,
        'fields': fields.map((e) => e.toJson()).toList(),
        'name': name?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItemDescription {
  final OctezRollupUnistring title;
  final OctezRollupUnistring? description;

  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItemDescription({
    required this.title,
    this.description,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItemDescription.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItemDescription(
      title: OctezRollupUnistring.fromJson(json['title']),
      description:
          json.hasValue('description')
              ? OctezRollupUnistring.fromJson(json['description'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'title': title.toJson(),
        'description': description?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItem {
  final OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItemDescription
  description;
  final OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel
  encoding;

  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItem({
    required this.description,
    required this.encoding,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItem(
      description: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItemDescription,
        Map<String, dynamic>
      >(
        key: 'description',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItemDescription.fromJson(
                  v,
                ),
      ),
      encoding:
          OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel.fromJson(
            json['encoding'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'description': description.toJson(),
        'encoding': encoding.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchema {
  final OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel
  toplevel;
  final List<
    OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItem
  >
  fields;

  const OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchema({
    required this.toplevel,
    required this.fields,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchema.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchema(
      toplevel:
          OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaToplevel.fromJson(
            json['toplevel'],
          ),
      fields:
          json
              .valueEnsureAsList<Map<String, dynamic>>('fields')
              .map(
                (e) =>
                    OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchemaFieldsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'toplevel': toplevel.toJson(),
        'fields': fields.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetServiceInput {
  final dynamic jsonSchema;
  final OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchema
  binarySchema;

  const OctezRollupServiceTreeStaticStaticGetServiceInput({
    required this.jsonSchema,
    required this.binarySchema,
  });

  factory OctezRollupServiceTreeStaticStaticGetServiceInput.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetServiceInput(
      jsonSchema: json['json_schema'],
      binarySchema: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchema,
        Map<String, dynamic>
      >(
        key: 'binary_schema',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticGetServiceInputBinarySchema.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'json_schema': jsonSchema,
        'binary_schema': binarySchema.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticGetService {
  final OctezRollupServiceTreeStaticStaticGetServiceMeth meth;
  final List<OctezRollupServiceTreeStaticStaticGetServicePathItem> path;
  final OctezRollupUnistring? description;
  final List<OctezRollupServiceTreeStaticStaticGetServiceQueryItem> query;
  final OctezRollupServiceTreeStaticStaticGetServiceInput? input;
  final OctezRollupServiceTreeStaticStaticGetServiceInput output;
  final OctezRollupServiceTreeStaticStaticGetServiceInput error;

  const OctezRollupServiceTreeStaticStaticGetService({
    required this.meth,
    required this.path,
    this.description,
    required this.query,
    this.input,
    required this.output,
    required this.error,
  });

  factory OctezRollupServiceTreeStaticStaticGetService.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticGetService(
      meth: OctezRollupServiceTreeStaticStaticGetServiceMeth.fromJson(
        json['meth'],
      ),
      path:
          json
              .valueEnsureAsList<dynamic>('path')
              .map(
                (e) =>
                    OctezRollupServiceTreeStaticStaticGetServicePathItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      description:
          json.hasValue('description')
              ? OctezRollupUnistring.fromJson(json['description'])
              : null,
      query:
          json
              .valueEnsureAsList<Map<String, dynamic>>('query')
              .map(
                (e) =>
                    OctezRollupServiceTreeStaticStaticGetServiceQueryItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      input: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetServiceInput?,
        Map<String, dynamic>
      >(
        key: 'input',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticGetServiceInput.fromJson(v),
      ),
      output: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetServiceInput,
        Map<String, dynamic>
      >(
        key: 'output',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticGetServiceInput.fromJson(v),
      ),
      error: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetServiceInput,
        Map<String, dynamic>
      >(
        key: 'error',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticGetServiceInput.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'meth': meth.toJson(),
        'path': path.map((e) => e.toJson()).toList(),
        'description': description?.toJson(),
        'query': query.map((e) => e.toJson()).toList(),
        'input': input?.toJson(),
        'output': output.toJson(),
        'error': error.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticSubdirsSuffixesSuffixesItem {
  final OctezRollupUnistring name;
  final OctezRollupServiceTree tree;

  const OctezRollupServiceTreeStaticStaticSubdirsSuffixesSuffixesItem({
    required this.name,
    required this.tree,
  });

  factory OctezRollupServiceTreeStaticStaticSubdirsSuffixesSuffixesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticSubdirsSuffixesSuffixesItem(
      name: OctezRollupUnistring.fromJson(json['name']),
      tree: OctezRollupServiceTree.fromJson(json['tree']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name.toJson(),
        'tree': tree.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStaticSubdirsArgDynamicDispatch {
  final OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle
  arg;
  final OctezRollupServiceTree tree;

  const OctezRollupServiceTreeStaticStaticSubdirsArgDynamicDispatch({
    required this.arg,
    required this.tree,
  });

  factory OctezRollupServiceTreeStaticStaticSubdirsArgDynamicDispatch.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStaticSubdirsArgDynamicDispatch(
      arg: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle,
        Map<String, dynamic>
      >(
        key: 'arg',
        parse:
            (v) =>
                OctezRollupServiceTreeStaticStaticGetServiceQueryItemKindSingleSingle.fromJson(
                  v,
                ),
      ),
      tree: OctezRollupServiceTree.fromJson(json['tree']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'arg': arg.toJson(),
        'tree': tree.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupServiceTreeStaticStatic {
  final OctezRollupServiceTreeStaticStaticGetService? getService;
  final OctezRollupServiceTreeStaticStaticGetService? postService;
  final OctezRollupServiceTreeStaticStaticGetService? deleteService;
  final OctezRollupServiceTreeStaticStaticGetService? putService;
  final OctezRollupServiceTreeStaticStaticGetService? patchService;
  final OctezRollupServiceTreeStaticStaticSubdirs? subdirs;

  const OctezRollupServiceTreeStaticStatic({
    this.getService,
    this.postService,
    this.deleteService,
    this.putService,
    this.patchService,
    this.subdirs,
  });

  factory OctezRollupServiceTreeStaticStatic.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupServiceTreeStaticStatic(
      getService: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetService?,
        Map<String, dynamic>
      >(
        key: 'get_service',
        parse: (v) => OctezRollupServiceTreeStaticStaticGetService.fromJson(v),
      ),
      postService: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetService?,
        Map<String, dynamic>
      >(
        key: 'post_service',
        parse: (v) => OctezRollupServiceTreeStaticStaticGetService.fromJson(v),
      ),
      deleteService: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetService?,
        Map<String, dynamic>
      >(
        key: 'delete_service',
        parse: (v) => OctezRollupServiceTreeStaticStaticGetService.fromJson(v),
      ),
      putService: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetService?,
        Map<String, dynamic>
      >(
        key: 'put_service',
        parse: (v) => OctezRollupServiceTreeStaticStaticGetService.fromJson(v),
      ),
      patchService: json.valueTo<
        OctezRollupServiceTreeStaticStaticGetService?,
        Map<String, dynamic>
      >(
        key: 'patch_service',
        parse: (v) => OctezRollupServiceTreeStaticStaticGetService.fromJson(v),
      ),
      subdirs:
          json.hasValue('subdirs')
              ? OctezRollupServiceTreeStaticStaticSubdirs.fromJson(
                json['subdirs'],
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'get_service': getService?.toJson(),
        'post_service': postService?.toJson(),
        'delete_service': deleteService?.toJson(),
        'put_service': putService?.toJson(),
        'patch_service': patchService?.toJson(),
        'subdirs': subdirs?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessagesContent {
  final OctezRollupSmartRollupMerkelizedPayloadHashesHash hash;
  final int level;

  const OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessagesContent({
    required this.hash,
    required this.level,
  });

  factory OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessagesContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessagesContent(
      hash: OctezRollupUnistring.fromJson(json['hash']),
      level: json.valueAsInt('level'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'hash': hash.toJson(),
        'level': level,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessages {
  final OctezRollupPositiveBignum index;
  final OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessagesContent
  content;
  final List<OctezRollupSmartRollupInboxHash> backPointers;

  const OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessages({
    required this.index,
    required this.content,
    required this.backPointers,
  });

  factory OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessages.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessages(
      index:
          (json['index'] is num
              ? json['index'].toString()
              : json.valueAsString('index')),
      content: json.valueTo<
        OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessagesContent,
        Map<String, dynamic>
      >(
        key: 'content',
        parse:
            (v) =>
                OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessagesContent.fromJson(
                  v,
                ),
      ),
      backPointers:
          json
              .valueEnsureAsList<dynamic>('back_pointers')
              .map((e) => OctezRollupUnistring.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'index': index,
        'content': content.toJson(),
        'back_pointers': backPointers.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

/// Inbox for this block.
class OctezRollupResponseGlobalBlockBlockIdInbox {
  final int level;
  final OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessages
  oldLevelsMessages;

  const OctezRollupResponseGlobalBlockBlockIdInbox({
    required this.level,
    required this.oldLevelsMessages,
  });

  factory OctezRollupResponseGlobalBlockBlockIdInbox.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdInbox(
      level: json.valueAsInt('level'),
      oldLevelsMessages: json.valueTo<
        OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessages,
        Map<String, dynamic>
      >(
        key: 'old_levels_messages',
        parse:
            (v) =>
                OctezRollupResponseGlobalBlockBlockIdInboxOldLevelsMessages.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'level': level,
        'old_levels_messages': oldLevelsMessages.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactionsTransactionsItem {
  final OctezRollupUnistring destination;
  final OctezRollupUnistring? entrypoint;
  final OctezRollupMichelineOutboxTransactionParametersExpression? parameters;
  final OctezRollupMichelineOutboxTransactionParametersTypeExpression?
  parametersTy;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactionsTransactionsItem({
    required this.destination,
    this.entrypoint,
    this.parameters,
    this.parametersTy,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactionsTransactionsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItemTransactionsTransactionsItem(
      destination: OctezRollupUnistring.fromJson(json['destination']),
      entrypoint:
          json.hasValue('entrypoint')
              ? OctezRollupUnistring.fromJson(json['entrypoint'])
              : null,
      parameters:
          json.hasValue('parameters')
              ? OctezRollupMichelineOutboxTransactionParametersExpression.fromJson(
                json['parameters'],
              )
              : null,
      parametersTy:
          json.hasValue('parameters_ty')
              ? OctezRollupMichelineOutboxTransactionParametersTypeExpression.fromJson(
                json['parameters_ty'],
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'destination': destination.toJson(),
        'entrypoint': entrypoint?.toJson(),
        'parameters': parameters?.toJson(),
        'parameters_ty': parametersTy?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockId {
  /// Tezos block hash.
  final OctezRollupBlockHash blockHash;

  /// Level of the block, corresponds to the level of the tezos block.
  final int level;

  /// Predecessor hash of the Tezos block.
  final OctezRollupBlockHash predecessor;

  /// Hash of this block's commitment if any was computed for it.
  final OctezRollupSmartRollupCommitmentHash? commitmentHash;

  /// Previous commitment hash in the chain. If there is a commitment for this block, this field contains the commitment that was previously computed.
  final OctezRollupSmartRollupCommitmentHash previousCommitmentHash;

  /// Hash of the layer 2 context for this block.
  final OctezRollupSmartRollupContextHash? context;

  /// Witness for the inbox for this block, i.e. the Merkle hash of payloads of messages.
  final OctezRollupSmartRollupMerkelizedPayloadHashesHash inboxWitness;

  /// Hash of the inbox for this block.
  final OctezRollupSmartRollupInboxHash inboxHash;

  /// Inbox for this block.
  final OctezRollupResponseGlobalBlockBlockIdInbox inbox;

  /// Messages added to the inbox in this block.
  final List<String> messages;

  /// Commitment, if any is computed for this block.
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment?
  commitment;

  /// Outbox messages produced by PVM execution of inbox
  final List<OctezRollupResponseGlobalBlockBlockIdOutboxItem>? outbox;

  /// Initial tick of the PVM at this block, i.e. before evaluation of the messages.
  final OctezRollupPositiveBignum initialTick;

  /// Number of ticks produced by the evaluation of the messages in this block.
  final OctezRollupInt64 numTicks;

  /// Hash of the PVM state after evaluation of the messages in this block.
  final OctezRollupSmartRollupStateHash? stateHash;

  /// Status of the PVM after evaluation of the messages in this block.
  final OctezRollupUnistring? pvmStatus;

  const OctezRollupResponseGlobalBlockBlockId({
    required this.blockHash,
    required this.level,
    required this.predecessor,
    this.commitmentHash,
    required this.previousCommitmentHash,
    this.context,
    required this.inboxWitness,
    required this.inboxHash,
    required this.inbox,
    required this.messages,
    this.commitment,
    this.outbox,
    required this.initialTick,
    required this.numTicks,
    this.stateHash,
    this.pvmStatus,
  });

  factory OctezRollupResponseGlobalBlockBlockId.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockId(
      blockHash: OctezRollupUnistring.fromJson(json['block_hash']),
      level: json.valueAsInt('level'),
      predecessor: OctezRollupUnistring.fromJson(json['predecessor']),
      commitmentHash:
          json.hasValue('commitment_hash')
              ? OctezRollupUnistring.fromJson(json['commitment_hash'])
              : null,
      previousCommitmentHash: OctezRollupUnistring.fromJson(
        json['previous_commitment_hash'],
      ),
      context:
          json.hasValue('context')
              ? OctezRollupUnistring.fromJson(json['context'])
              : null,
      inboxWitness: OctezRollupUnistring.fromJson(json['inbox_witness']),
      inboxHash: OctezRollupUnistring.fromJson(json['inbox_hash']),
      inbox: json.valueTo<
        OctezRollupResponseGlobalBlockBlockIdInbox,
        Map<String, dynamic>
      >(
        key: 'inbox',
        parse: (v) => OctezRollupResponseGlobalBlockBlockIdInbox.fromJson(v),
      ),
      messages: json.valueAsList<List<String>>('messages'),
      commitment: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment?,
        Map<String, dynamic>
      >(
        key: 'commitment',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment.fromJson(
                  v,
                ),
      ),
      outbox:
          json.hasValue('outbox')
              ? json
                  .valueEnsureAsList<dynamic>('outbox')
                  .map(
                    (e) =>
                        OctezRollupResponseGlobalBlockBlockIdOutboxItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      initialTick:
          (json['initial_tick'] is num
              ? json['initial_tick'].toString()
              : json.valueAsString('initial_tick')),
      numTicks:
          (json['num_ticks'] is num
              ? json['num_ticks'].toString()
              : json.valueAsString('num_ticks')),
      stateHash:
          json.hasValue('state_hash')
              ? OctezRollupUnistring.fromJson(json['state_hash'])
              : null,
      pvmStatus:
          json.hasValue('pvm_status')
              ? OctezRollupUnistring.fromJson(json['pvm_status'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'block_hash': blockHash.toJson(),
        'level': level,
        'predecessor': predecessor.toJson(),
        'commitment_hash': commitmentHash?.toJson(),
        'previous_commitment_hash': previousCommitmentHash.toJson(),
        'context': context?.toJson(),
        'inbox_witness': inboxWitness.toJson(),
        'inbox_hash': inboxHash.toJson(),
        'inbox': inbox.toJson(),
        'messages': messages,
        'commitment': commitment?.toJson(),
        'outbox': outbox?.map((e) => e.toJson()).toList(),
        'initial_tick': initialTick,
        'num_ticks': numTicks,
        'state_hash': stateHash?.toJson(),
        'pvm_status': pvmStatus?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommittedUncommitted {
  /// Level at which the following commitment will be produced.
  final int commitmentLevel;

  /// Estimated time at which the commitment will be published.
  final OctezRollupTimestampSystem estimatedCommitmentTime;

  /// Estimated time at which the commitment will be cemented.
  final OctezRollupTimestampSystem estimatedCementationTime;

  const OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommittedUncommitted({
    required this.commitmentLevel,
    required this.estimatedCommitmentTime,
    required this.estimatedCementationTime,
  });

  factory OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommittedUncommitted.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdCommittedStatusUncommittedUncommitted(
      commitmentLevel: json.valueAsInt('commitment_level'),
      estimatedCommitmentTime: OctezRollupTimestampSystem.fromJson(
        json['estimated_commitment_time'],
      ),
      estimatedCementationTime: OctezRollupTimestampSystem.fromJson(
        json['estimated_cementation_time'],
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'commitment_level': commitmentLevel,
        'estimated_commitment_time': estimatedCommitmentTime.toJson(),
        'estimated_cementation_time': estimatedCementationTime.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommittedCommitted {
  /// Hash of following commitment.
  final OctezRollupSmartRollupCommitmentHash commitmentHash;

  /// Level of following commitment.
  final int commitmentLevel;

  /// Level at which commitment was first published.
  final int firstPublishedLevel;

  /// Level at which commitment was published by operator (may be null if e.g. rollup node does not publish).
  final int? publishedLevel;

  /// Estimated time at which the commitment will be cemented.
  final OctezRollupTimestampSystem estimatedCementationTime;

  const OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommittedCommitted({
    required this.commitmentHash,
    required this.commitmentLevel,
    required this.firstPublishedLevel,
    this.publishedLevel,
    required this.estimatedCementationTime,
  });

  factory OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommittedCommitted.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdCommittedStatusCommittedCommitted(
      commitmentHash: OctezRollupUnistring.fromJson(json['commitment_hash']),
      commitmentLevel: json.valueAsInt('commitment_level'),
      firstPublishedLevel: json.valueAsInt('first_published_level'),
      publishedLevel: json.valueAsInt('published_level'),
      estimatedCementationTime: OctezRollupTimestampSystem.fromJson(
        json['estimated_cementation_time'],
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'commitment_hash': commitmentHash.toJson(),
        'commitment_level': commitmentLevel,
        'first_published_level': firstPublishedLevel,
        'published_level': publishedLevel,
        'estimated_cementation_time': estimatedCementationTime.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdCommittedStatusCementedCemented {
  /// Hash of following commitment.
  final OctezRollupSmartRollupCommitmentHash commitmentHash;

  /// Level of following commitment.
  final int commitmentLevel;

  /// Level at which commitment was first published.
  final int firstPublishedLevel;

  /// Level at which commitment was published by operator (may be null if e.g. rollup node does not publish).
  final int? publishedLevel;

  /// Number of blocks since commitment was cemented.
  final int blocksSinceCemented;

  const OctezRollupResponseGlobalBlockBlockIdCommittedStatusCementedCemented({
    required this.commitmentHash,
    required this.commitmentLevel,
    required this.firstPublishedLevel,
    this.publishedLevel,
    required this.blocksSinceCemented,
  });

  factory OctezRollupResponseGlobalBlockBlockIdCommittedStatusCementedCemented.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdCommittedStatusCementedCemented(
      commitmentHash: OctezRollupUnistring.fromJson(json['commitment_hash']),
      commitmentLevel: json.valueAsInt('commitment_level'),
      firstPublishedLevel: json.valueAsInt('first_published_level'),
      publishedLevel: json.valueAsInt('published_level'),
      blocksSinceCemented: json.valueAsInt('blocks_since_cemented'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'commitment_hash': commitmentHash.toJson(),
        'commitment_level': commitmentLevel,
        'first_published_level': firstPublishedLevel,
        'published_level': publishedLevel,
        'blocks_since_cemented': blocksSinceCemented,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdHelpersProofsOutboxLevelMessages {
  final OctezRollupSmartRollupCommitmentHash commitment;
  final String proof;

  const OctezRollupResponseGlobalBlockBlockIdHelpersProofsOutboxLevelMessages({
    required this.commitment,
    required this.proof,
  });

  factory OctezRollupResponseGlobalBlockBlockIdHelpersProofsOutboxLevelMessages.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdHelpersProofsOutboxLevelMessages(
      commitment: OctezRollupUnistring.fromJson(json['commitment']),
      proof:
          (json['proof'] is num
              ? json['proof'].toString()
              : json.valueAsString('proof')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'commitment': commitment.toJson(),
        'proof': proof,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTransactionsItem {
  final OctezRollupMicheline025PsUshuaiMichelsonV1Expression parameters;
  final OctezRollupN025PsUshuaiContractIdOriginated destination;
  final OctezRollupUnistring? entrypoint;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTransactionsItem({
    required this.parameters,
    required this.destination,
    this.entrypoint,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTransactionsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTransactionsItem(
      parameters: OctezRollupMicheline025PsUshuaiMichelsonV1Expression.fromJson(
        json['parameters'],
      ),
      destination: OctezRollupUnistring.fromJson(json['destination']),
      entrypoint:
          json.hasValue('entrypoint')
              ? OctezRollupUnistring.fromJson(json['entrypoint'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'parameters': parameters.toJson(),
        'destination': destination.toJson(),
        'entrypoint': entrypoint?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedTransactionsItem {
  final OctezRollupMicheline025PsUshuaiMichelsonV1Expression parameters;
  final OctezRollupMicheline025PsUshuaiMichelsonV1Expression parametersTy;
  final OctezRollupN025PsUshuaiContractIdOriginated destination;
  final OctezRollupUnistring? entrypoint;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedTransactionsItem({
    required this.parameters,
    required this.parametersTy,
    required this.destination,
    this.entrypoint,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedTransactionsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItem108MessageAtomicTransactionBatchTypedTransactionsItem(
      parameters: OctezRollupMicheline025PsUshuaiMichelsonV1Expression.fromJson(
        json['parameters'],
      ),
      parametersTy:
          OctezRollupMicheline025PsUshuaiMichelsonV1Expression.fromJson(
            json['parameters_ty'],
          ),
      destination: OctezRollupUnistring.fromJson(json['destination']),
      entrypoint:
          json.hasValue('entrypoint')
              ? OctezRollupUnistring.fromJson(json['entrypoint'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'parameters': parameters.toJson(),
        'parameters_ty': parametersTy.toJson(),
        'destination': destination.toJson(),
        'entrypoint': entrypoint?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdOutboxItem108 {
  final int outboxLevel;
  final OctezRollupPositiveBignum messageIndex;
  final OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message message;

  const OctezRollupResponseGlobalBlockBlockIdOutboxItem108({
    required this.outboxLevel,
    required this.messageIndex,
    required this.message,
  });

  factory OctezRollupResponseGlobalBlockBlockIdOutboxItem108.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdOutboxItem108(
      outboxLevel: json.valueAsInt('outbox_level'),
      messageIndex:
          (json['message_index'] is num
              ? json['message_index'].toString()
              : json.valueAsString('message_index')),
      message:
          OctezRollupResponseGlobalBlockBlockIdOutboxItem108Message.fromJson(
            json['message'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'outbox_level': outboxLevel,
        'message_index': messageIndex,
        'message': message.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalBlockBlockIdSimulate {
  /// Hash of the state after execution of the PVM on the input messages
  final OctezRollupSmartRollupStateHash stateHash;

  /// Status of the PVM after evaluation
  final OctezRollupUnistring status;

  /// Output produced by evaluation of the messages
  final List<OctezRollupResponseGlobalBlockBlockIdOutboxItem108> output;

  /// Level of the inbox that would contain these messages
  final int inboxLevel;

  /// Ticks taken by the PVM for evaluating the messages
  final OctezRollupBignum numTicks;

  /// PVM state values requested after the simulation
  final List<String?>? insights;

  const OctezRollupResponseGlobalBlockBlockIdSimulate({
    required this.stateHash,
    required this.status,
    required this.output,
    required this.inboxLevel,
    required this.numTicks,
    this.insights,
  });

  factory OctezRollupResponseGlobalBlockBlockIdSimulate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdSimulate(
      stateHash: OctezRollupUnistring.fromJson(json['state_hash']),
      status: OctezRollupUnistring.fromJson(json['status']),
      output:
          json
              .valueEnsureAsList<Map<String, dynamic>>('output')
              .map(
                (e) =>
                    OctezRollupResponseGlobalBlockBlockIdOutboxItem108.fromJson(
                      e,
                    ),
              )
              .toList(),
      inboxLevel: json.valueAsInt('inbox_level'),
      numTicks:
          (json['num_ticks'] is num
              ? json['num_ticks'].toString()
              : json.valueAsString('num_ticks')),
      insights:
          json.hasValue('insights')
              ? json
                  .valueEnsureAsList<dynamic>('insights')
                  .map(
                    (e) =>
                        e == null
                            ? null
                            : (e is num
                                ? e.toString()
                                : JsonParser.valueAsString<String>(e)),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'state_hash': stateHash.toJson(),
        'status': status.toJson(),
        'output': output.map((e) => e.toJson()).toList(),
        'inbox_level': inboxLevel,
        'num_ticks': numTicks,
        'insights': insights,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupGlobalBlockBlockIdSimulateBody {
  /// Serialized messages for simulation.
  final List<String> messages;

  /// Pages (at most 4kB) to be used for revelation ticks
  final List<String>? revealPages;

  /// Paths in the PVM to inspect after the simulation
  final List<OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItem>?
  insightRequests;

  final OctezRollupUnistring? logKernelDebugFile;

  const OctezRollupGlobalBlockBlockIdSimulateBody({
    required this.messages,
    this.revealPages,
    this.insightRequests,
    this.logKernelDebugFile,
  });

  factory OctezRollupGlobalBlockBlockIdSimulateBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupGlobalBlockBlockIdSimulateBody(
      messages: json.valueAsList<List<String>>('messages'),
      revealPages: json.valueAsList<List<String>?>('reveal_pages'),
      insightRequests:
          json.hasValue('insight_requests')
              ? json
                  .valueEnsureAsList<dynamic>('insight_requests')
                  .map(
                    (e) =>
                        OctezRollupGlobalBlockBlockIdSimulateBodyInsightRequestsItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      logKernelDebugFile:
          json.hasValue('log_kernel_debug_file')
              ? OctezRollupUnistring.fromJson(json['log_kernel_debug_file'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'messages': messages,
        'reveal_pages': revealPages,
        'insight_requests': insightRequests?.map((e) => e.toJson()).toList(),
        'log_kernel_debug_file': logKernelDebugFile?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalLastCementedCommitment {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment
  commitment;
  final OctezRollupSmartRollupCommitmentHash hash;

  const OctezRollupResponseGlobalLastCementedCommitment({
    required this.commitment,
    required this.hash,
  });

  factory OctezRollupResponseGlobalLastCementedCommitment.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalLastCementedCommitment(
      commitment: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment,
        Map<String, dynamic>
      >(
        key: 'commitment',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment.fromJson(
                  v,
                ),
      ),
      hash: OctezRollupUnistring.fromJson(json['hash']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'commitment': commitment.toJson(),
        'hash': hash.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseGlobalMonitorBlocks {
  /// Tezos block hash.
  final OctezRollupBlockHash blockHash;

  /// Level of the block, corresponds to the level of the tezos block.
  final int level;

  /// Predecessor hash of the Tezos block.
  final OctezRollupBlockHash predecessor;

  /// Hash of this block's commitment if any was computed for it.
  final OctezRollupSmartRollupCommitmentHash? commitmentHash;

  /// Previous commitment hash in the chain. If there is a commitment for this block, this field contains the commitment that was previously computed.
  final OctezRollupSmartRollupCommitmentHash previousCommitmentHash;

  /// Hash of the layer 2 context for this block.
  final OctezRollupSmartRollupContextHash? context;

  /// Witness for the inbox for this block, i.e. the Merkle hash of payloads of messages.
  final OctezRollupSmartRollupMerkelizedPayloadHashesHash inboxWitness;

  /// Hash of the inbox for this block.
  final OctezRollupSmartRollupInboxHash inboxHash;

  /// Initial tick of the PVM at this block, i.e. before evaluation of the messages.
  final OctezRollupPositiveBignum initialTick;

  /// Number of ticks produced by the evaluation of the messages in this block.
  final OctezRollupInt64 numTicks;

  /// Hash of the PVM state after evaluation of the messages in this block.
  final OctezRollupSmartRollupStateHash? stateHash;

  /// Status of the PVM after evaluation of the messages in this block.
  final OctezRollupUnistring? pvmStatus;

  const OctezRollupResponseGlobalMonitorBlocks({
    required this.blockHash,
    required this.level,
    required this.predecessor,
    this.commitmentHash,
    required this.previousCommitmentHash,
    this.context,
    required this.inboxWitness,
    required this.inboxHash,
    required this.initialTick,
    required this.numTicks,
    this.stateHash,
    this.pvmStatus,
  });

  factory OctezRollupResponseGlobalMonitorBlocks.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseGlobalMonitorBlocks(
      blockHash: OctezRollupUnistring.fromJson(json['block_hash']),
      level: json.valueAsInt('level'),
      predecessor: OctezRollupUnistring.fromJson(json['predecessor']),
      commitmentHash:
          json.hasValue('commitment_hash')
              ? OctezRollupUnistring.fromJson(json['commitment_hash'])
              : null,
      previousCommitmentHash: OctezRollupUnistring.fromJson(
        json['previous_commitment_hash'],
      ),
      context:
          json.hasValue('context')
              ? OctezRollupUnistring.fromJson(json['context'])
              : null,
      inboxWitness: OctezRollupUnistring.fromJson(json['inbox_witness']),
      inboxHash: OctezRollupUnistring.fromJson(json['inbox_hash']),
      initialTick:
          (json['initial_tick'] is num
              ? json['initial_tick'].toString()
              : json.valueAsString('initial_tick')),
      numTicks:
          (json['num_ticks'] is num
              ? json['num_ticks'].toString()
              : json.valueAsString('num_ticks')),
      stateHash:
          json.hasValue('state_hash')
              ? OctezRollupUnistring.fromJson(json['state_hash'])
              : null,
      pvmStatus:
          json.hasValue('pvm_status')
              ? OctezRollupUnistring.fromJson(json['pvm_status'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'block_hash': blockHash.toJson(),
        'level': level,
        'predecessor': predecessor.toJson(),
        'commitment_hash': commitmentHash?.toJson(),
        'previous_commitment_hash': previousCommitmentHash.toJson(),
        'context': context?.toJson(),
        'inbox_witness': inboxWitness.toJson(),
        'inbox_hash': inboxHash.toJson(),
        'initial_tick': initialTick,
        'num_ticks': numTicks,
        'state_hash': stateHash?.toJson(),
        'pvm_status': pvmStatus?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseHealthL1LastSeenHead {
  final OctezRollupBlockHash hash;
  final int level;
  final OctezRollupTimestampProtocol timestamp;

  const OctezRollupResponseHealthL1LastSeenHead({
    required this.hash,
    required this.level,
    required this.timestamp,
  });

  factory OctezRollupResponseHealthL1LastSeenHead.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseHealthL1LastSeenHead(
      hash: OctezRollupUnistring.fromJson(json['hash']),
      level: json.valueAsInt('level'),
      timestamp: OctezRollupUnistring.fromJson(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'hash': hash.toJson(),
        'level': level,
        'timestamp': timestamp.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseHealthL1 {
  final OctezRollupResponseHealthL1Connection connection;
  final int blocksLate;
  final OctezRollupResponseHealthL1LastSeenHead? lastSeenHead;

  const OctezRollupResponseHealthL1({
    required this.connection,
    required this.blocksLate,
    this.lastSeenHead,
  });

  factory OctezRollupResponseHealthL1.fromJson(Map<String, dynamic> json) {
    return OctezRollupResponseHealthL1(
      connection: OctezRollupResponseHealthL1Connection.fromJson(
        json['connection'],
      ),
      blocksLate: json.valueAsInt('blocks_late'),
      lastSeenHead: json.valueTo<
        OctezRollupResponseHealthL1LastSeenHead?,
        Map<String, dynamic>
      >(
        key: 'last_seen_head',
        parse: (v) => OctezRollupResponseHealthL1LastSeenHead.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'connection': connection.toJson(),
        'blocks_late': blocksLate,
        'last_seen_head': lastSeenHead?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseHealth {
  final bool healthy;
  final bool degraded;
  final OctezRollupResponseHealthL1 l1;
  final List<List<OctezRollupResponseHealthActiveWorkersItemItem>>
  activeWorkers;

  const OctezRollupResponseHealth({
    required this.healthy,
    required this.degraded,
    required this.l1,
    required this.activeWorkers,
  });

  factory OctezRollupResponseHealth.fromJson(Map<String, dynamic> json) {
    return OctezRollupResponseHealth(
      healthy: json.valueAsBool('healthy'),
      degraded: json.valueAsBool('degraded'),
      l1: json.valueTo<OctezRollupResponseHealthL1, Map<String, dynamic>>(
        key: 'l1',
        parse: (v) => OctezRollupResponseHealthL1.fromJson(v),
      ),
      activeWorkers:
          json
              .valueEnsureAsList<dynamic>('active_workers')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) =>
                              OctezRollupResponseHealthActiveWorkersItemItem.fromJson(
                                e,
                              ),
                        )
                        .toList(),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'healthy': healthy,
        'degraded': degraded,
        'l1': l1.toJson(),
        'active_workers':
            activeWorkers
                .map((e) => e.map((x) => x.toJson()).toList())
                .toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalBatcherQueueItemMessage {
  final OctezRollupScL2Message content;
  final OctezRollupPositiveBignum counter;

  const OctezRollupResponseLocalBatcherQueueItemMessage({
    required this.content,
    required this.counter,
  });

  factory OctezRollupResponseLocalBatcherQueueItemMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalBatcherQueueItemMessage(
      content:
          (json['content'] is num
              ? json['content'].toString()
              : json.valueAsString('content')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'content': content,
        'counter': counter,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalBatcherQueueItem {
  final OctezRollupPositiveBignum? order;
  final OctezRollupScRollupL2MessageId id;
  final OctezRollupResponseLocalBatcherQueueItemMessage message;
  final OctezRollupUnistring? traceparent;

  const OctezRollupResponseLocalBatcherQueueItem({
    this.order,
    required this.id,
    required this.message,
    this.traceparent,
  });

  factory OctezRollupResponseLocalBatcherQueueItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalBatcherQueueItem(
      order:
          (json['order'] is num
              ? json['order'].toString()
              : json.valueAsString('order')),
      id: OctezRollupUnistring.fromJson(json['id']),
      message: json.valueTo<
        OctezRollupResponseLocalBatcherQueueItemMessage,
        Map<String, dynamic>
      >(
        key: 'message',
        parse:
            (v) => OctezRollupResponseLocalBatcherQueueItemMessage.fromJson(v),
      ),
      traceparent:
          json.hasValue('traceparent')
              ? OctezRollupUnistring.fromJson(json['traceparent'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'order': order,
        'id': id.toJson(),
        'message': message.toJson(),
        'traceparent': traceparent?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedLayer1 {
  final OctezRollupOperationHash operationHash;
  final int operationIndex;

  const OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedLayer1({
    required this.operationHash,
    required this.operationIndex,
  });

  factory OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedLayer1.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalBatcherQueueL2MessageIdInjectedLayer1(
      operationHash: OctezRollupUnistring.fromJson(json['operation_hash']),
      operationIndex: json.valueAsInt('operation_index'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'operation_hash': operationHash.toJson(),
        'operation_index': operationIndex,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1 {
  final OctezRollupOperationHash operationHash;
  final int operationIndex;
  final OctezRollupBlockHash blockHash;
  final int level;

  const OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1({
    required this.operationHash,
    required this.operationIndex,
    required this.blockHash,
    required this.level,
  });

  factory OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalBatcherQueueL2MessageIdIncludedLayer1(
      operationHash: OctezRollupUnistring.fromJson(json['operation_hash']),
      operationIndex: json.valueAsInt('operation_index'),
      blockHash: OctezRollupUnistring.fromJson(json['block_hash']),
      level: json.valueAsInt('level'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'operation_hash': operationHash.toJson(),
        'operation_index': operationIndex,
        'block_hash': blockHash.toJson(),
        'level': level,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalCommitmentsCommitmentHash {
  final OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment
  commitment;
  final OctezRollupSmartRollupCommitmentHash hash;
  final int? firstPublishedAtLevel;
  final int? publishedAtLevel;

  const OctezRollupResponseLocalCommitmentsCommitmentHash({
    required this.commitment,
    required this.hash,
    this.firstPublishedAtLevel,
    this.publishedAtLevel,
  });

  factory OctezRollupResponseLocalCommitmentsCommitmentHash.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalCommitmentsCommitmentHash(
      commitment: json.valueTo<
        OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment,
        Map<String, dynamic>
      >(
        key: 'commitment',
        parse:
            (v) =>
                OctezRollupResponseAdminInjectorQueuesItemQueueItemPublishCommitment.fromJson(
                  v,
                ),
      ),
      hash: OctezRollupUnistring.fromJson(json['hash']),
      firstPublishedAtLevel: json.valueAsInt('first_published_at_level'),
      publishedAtLevel: json.valueAsInt('published_at_level'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'commitment': commitment.toJson(),
        'hash': hash.toJson(),
        'first_published_at_level': firstPublishedAtLevel,
        'published_at_level': publishedAtLevel,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalDalInjectedOperationsStatusesItem {
  final OctezRollupInjectorOperationHash id;
  final OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus status;

  const OctezRollupResponseLocalDalInjectedOperationsStatusesItem({
    required this.id,
    required this.status,
  });

  factory OctezRollupResponseLocalDalInjectedOperationsStatusesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalDalInjectedOperationsStatusesItem(
      id: OctezRollupUnistring.fromJson(json['id']),
      status:
          OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus.fromJson(
            json['status'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id.toJson(),
        'status': status.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// Slot indices to set
class OctezRollupLocalDalSlotIndicesBody {
  final BuBytes indices;

  OctezRollupLocalDalSlotIndicesBody({required List<int> indices})
    : indices = indices.asImmutableBytes;

  factory OctezRollupLocalDalSlotIndicesBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupLocalDalSlotIndicesBody(
      indices: json.valueAsList<List<int>>('indices'),
    );
  }

  Map<String, dynamic> toJson() =>
      {'indices': indices}.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalGcInfo {
  /// First level where data is guaranteed to be available in the rollup node.
  final int firstAvailableLevel;

  /// The level at which the last GC was triggered.
  final int? lastGcLevel;

  /// The level at which the context was split for the last time. Commits before this level are in other chunks.
  final int? lastContextSplitLevel;

  /// The level which was the target of the last successful GC.
  final int? lastSuccessfulGcTarget;

  const OctezRollupResponseLocalGcInfo({
    required this.firstAvailableLevel,
    this.lastGcLevel,
    this.lastContextSplitLevel,
    this.lastSuccessfulGcTarget,
  });

  factory OctezRollupResponseLocalGcInfo.fromJson(Map<String, dynamic> json) {
    return OctezRollupResponseLocalGcInfo(
      firstAvailableLevel: json.valueAsInt('first_available_level'),
      lastGcLevel: json.valueAsInt('last_gc_level'),
      lastContextSplitLevel: json.valueAsInt('last_context_split_level'),
      lastSuccessfulGcTarget: json.valueAsInt('last_successful_gc_target'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'first_available_level': firstAvailableLevel,
        'last_gc_level': lastGcLevel,
        'last_context_split_level': lastContextSplitLevel,
        'last_successful_gc_target': lastSuccessfulGcTarget,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalOutboxPendingItemMessagesItem {
  final int messageIndex;
  final OctezRollupResponseLocalOutboxPendingItemMessagesItemMessage? message;

  const OctezRollupResponseLocalOutboxPendingItemMessagesItem({
    required this.messageIndex,
    this.message,
  });

  factory OctezRollupResponseLocalOutboxPendingItemMessagesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalOutboxPendingItemMessagesItem(
      messageIndex: json.valueAsInt('message_index'),
      message:
          json.hasValue('message')
              ? OctezRollupResponseLocalOutboxPendingItemMessagesItemMessage.fromJson(
                json['message'],
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'message_index': messageIndex,
        'message': message?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalOutboxPendingItem {
  final int outboxLevel;
  final List<OctezRollupResponseLocalOutboxPendingItemMessagesItem> messages;
  final OctezRollupResponseLocalOutboxPendingItemStatus status;

  const OctezRollupResponseLocalOutboxPendingItem({
    required this.outboxLevel,
    required this.messages,
    required this.status,
  });

  factory OctezRollupResponseLocalOutboxPendingItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalOutboxPendingItem(
      outboxLevel: json.valueAsInt('outbox_level'),
      messages:
          json
              .valueEnsureAsList<Map<String, dynamic>>('messages')
              .map(
                (e) =>
                    OctezRollupResponseLocalOutboxPendingItemMessagesItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      status: OctezRollupResponseLocalOutboxPendingItemStatus.fromJson(
        json['status'],
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'outbox_level': outboxLevel,
        'messages': messages.map((e) => e.toJson()).toList(),
        'status': status.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalOutboxPendingExecutableItem {
  final int outboxLevel;
  final List<OctezRollupResponseLocalOutboxPendingItemMessagesItem> messages;

  const OctezRollupResponseLocalOutboxPendingExecutableItem({
    required this.outboxLevel,
    required this.messages,
  });

  factory OctezRollupResponseLocalOutboxPendingExecutableItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalOutboxPendingExecutableItem(
      outboxLevel: json.valueAsInt('outbox_level'),
      messages:
          json
              .valueEnsureAsList<Map<String, dynamic>>('messages')
              .map(
                (e) =>
                    OctezRollupResponseLocalOutboxPendingItemMessagesItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'outbox_level': outboxLevel,
        'messages': messages.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseLocalSynchronizedSynchronizingSynchronizing {
  final int processedLevel;
  final int l1HeadLevel;
  final num percentageDone;

  const OctezRollupResponseLocalSynchronizedSynchronizingSynchronizing({
    required this.processedLevel,
    required this.l1HeadLevel,
    required this.percentageDone,
  });

  factory OctezRollupResponseLocalSynchronizedSynchronizingSynchronizing.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezRollupResponseLocalSynchronizedSynchronizingSynchronizing(
      processedLevel: json.valueAsInt('processed_level'),
      l1HeadLevel: json.valueAsInt('l1_head_level'),
      percentageDone: json.valueAsNum('percentage_done'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'processed_level': processedLevel,
        'l1_head_level': l1HeadLevel,
        'percentage_done': percentageDone,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseStatsOcamlGc {
  final num minorWords;
  final num promotedWords;
  final num majorWords;
  final int minorCollections;
  final int majorCollections;
  final int forcedMajorCollections;
  final int heapWords;
  final int heapChunks;
  final int liveWords;
  final int liveBlocks;
  final int freeWords;
  final int freeBlocks;
  final int largestFree;
  final int fragments;
  final int compactions;
  final int topHeapWords;
  final int stackSize;

  const OctezRollupResponseStatsOcamlGc({
    required this.minorWords,
    required this.promotedWords,
    required this.majorWords,
    required this.minorCollections,
    required this.majorCollections,
    required this.forcedMajorCollections,
    required this.heapWords,
    required this.heapChunks,
    required this.liveWords,
    required this.liveBlocks,
    required this.freeWords,
    required this.freeBlocks,
    required this.largestFree,
    required this.fragments,
    required this.compactions,
    required this.topHeapWords,
    required this.stackSize,
  });

  factory OctezRollupResponseStatsOcamlGc.fromJson(Map<String, dynamic> json) {
    return OctezRollupResponseStatsOcamlGc(
      minorWords: json.valueAsNum('minor_words'),
      promotedWords: json.valueAsNum('promoted_words'),
      majorWords: json.valueAsNum('major_words'),
      minorCollections: json.valueAsInt('minor_collections'),
      majorCollections: json.valueAsInt('major_collections'),
      forcedMajorCollections: json.valueAsInt('forced_major_collections'),
      heapWords: json.valueAsInt('heap_words'),
      heapChunks: json.valueAsInt('heap_chunks'),
      liveWords: json.valueAsInt('live_words'),
      liveBlocks: json.valueAsInt('live_blocks'),
      freeWords: json.valueAsInt('free_words'),
      freeBlocks: json.valueAsInt('free_blocks'),
      largestFree: json.valueAsInt('largest_free'),
      fragments: json.valueAsInt('fragments'),
      compactions: json.valueAsInt('compactions'),
      topHeapWords: json.valueAsInt('top_heap_words'),
      stackSize: json.valueAsInt('stack_size'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'minor_words': minorWords,
        'promoted_words': promotedWords,
        'major_words': majorWords,
        'minor_collections': minorCollections,
        'major_collections': majorCollections,
        'forced_major_collections': forcedMajorCollections,
        'heap_words': heapWords,
        'heap_chunks': heapChunks,
        'live_words': liveWords,
        'live_blocks': liveBlocks,
        'free_words': freeWords,
        'free_blocks': freeBlocks,
        'largest_free': largestFree,
        'fragments': fragments,
        'compactions': compactions,
        'top_heap_words': topHeapWords,
        'stack_size': stackSize,
      }.notNullValue.cast<String, dynamic>();
}

class OctezRollupResponseVersion {
  final OctezRollupUnistring version;
  final OctezRollupUnistring storeVersion;
  final OctezRollupUnistring contextVersion;

  const OctezRollupResponseVersion({
    required this.version,
    required this.storeVersion,
    required this.contextVersion,
  });

  factory OctezRollupResponseVersion.fromJson(Map<String, dynamic> json) {
    return OctezRollupResponseVersion(
      version: OctezRollupUnistring.fromJson(json['version']),
      storeVersion: OctezRollupUnistring.fromJson(json['store_version']),
      contextVersion: OctezRollupUnistring.fromJson(json['context_version']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'version': version.toJson(),
        'store_version': storeVersion.toJson(),
        'context_version': contextVersion.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

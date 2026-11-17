// GENERATED CODE - DO NOT MODIFY BY HAND
// Source: OpenAPI 3.0.0
// Octez Mempool RPC Octez 25.1 (04d849eb)

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

typedef OctezMempoolOperationHash = OctezMempoolUnistring;

typedef OctezMempoolProtocolHash = OctezMempoolUnistring;

typedef OctezMempoolBlockHash = OctezMempoolUnistring;

typedef OctezMempoolValueHash = OctezMempoolUnistring;

/// Decimal representation of a big number
typedef OctezMempoolBignum = String;

typedef OctezMempoolSignatureV3 = OctezMempoolUnistring;

/// A timestamp as seen by the protocol: second-level precision, epoch based.
typedef OctezMempoolTimestampProtocol = OctezMempoolUnistring;

typedef OctezMempoolOperationListListHash = OctezMempoolUnistring;

/// The fitness, or score, of a block, that allows Tezos to decide which chain is best. A fitness value is a list of byte sequences. They are compared as follows: shortest lists are smaller; lists of the same length are compared according to lexicographical order.
typedef OctezMempoolFitness = List<String>;

typedef OctezMempoolContextHash = OctezMempoolUnistring;

typedef OctezMempoolCycleNonce = OctezMempoolUnistring;

typedef OctezMempoolDalCommitment = OctezMempoolUnistring;

typedef OctezMempoolEd25519PublicKeyHash = OctezMempoolUnistring;

typedef OctezMempoolSignaturePublicKeyHash = OctezMempoolUnistring;

/// Decimal representation of a positive big number
typedef OctezMempoolPositiveBignum = String;

typedef OctezMempoolN025PsUshuaiMutez = OctezMempoolPositiveBignum;

typedef OctezMempoolSignaturePublicKey = OctezMempoolUnistring;

typedef OctezMempoolBls12381Signature = OctezMempoolUnistring;

/// A contract notation as given to an RPC or inside scripts. Can be a base58 implicit contract hash or a base58 originated contract hash.
typedef OctezMempoolN025PsUshuaiContractId = OctezMempoolUnistring;

/// A contract notation as given to an RPC or inside scripts. Can be a base58 originated contract hash.
typedef OctezMempoolN025PsUshuaiContractIdOriginated = OctezMempoolUnistring;

typedef OctezMempoolSmartRollupAddress = OctezMempoolUnistring;

typedef OctezMempoolSmartRollupStateHash = OctezMempoolUnistring;

typedef OctezMempoolSmartRollupCommitmentHash = OctezMempoolUnistring;

/// Decimal representation of 64 bit integers
typedef OctezMempoolInt64 = String;

typedef OctezMempoolZkRollupHash = OctezMempoolUnistring;

typedef OctezMempoolScriptExpr = OctezMempoolUnistring;

/// Free-form JSON object (OpenAPI schema `error_opt` had no type).
typedef OctezMempoolErrorOpt = Map<String, dynamic>;

/// Free-form JSON object (OpenAPI schema `error` had no type).
typedef OctezMempoolError = Map<String, dynamic>;

/// Either a plain UTF8 string, or a sequence of bytes for strings that contain invalid byte sequences.
sealed class OctezMempoolUnistring {
  const OctezMempoolUnistring();

  factory OctezMempoolUnistring.fromJson(dynamic json) {
    if (json is String) return OctezMempoolUnistringStringValue(json);
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('invalid_utf8_string')) {
        return OctezMempoolUnistringInvalidUtf8String.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolUnistring',
      reason: 'Cannot parse OctezMempoolUnistring from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolUnistringStringValue extends OctezMempoolUnistring {
  final String value;
  const OctezMempoolUnistringStringValue(this.value);

  @override
  dynamic toJson() => value;
}

class OctezMempoolUnistringInvalidUtf8String extends OctezMempoolUnistring {
  final BuBytes invalidUtf8String;

  OctezMempoolUnistringInvalidUtf8String({required List<int> invalidUtf8String})
    : invalidUtf8String = invalidUtf8String.asImmutableBytes;

  factory OctezMempoolUnistringInvalidUtf8String.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolUnistringInvalidUtf8String(
      invalidUtf8String: json.valueAsList<List<int>>('invalid_utf8_string'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'invalid_utf8_string': invalidUtf8String,
      }.notNullValue.cast<String, dynamic>();
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationKind {
  attestation("attestation");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationKind fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDalKind {
  attestationWithDal("attestation_with_dal");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDalKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDalKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDalKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationKind {
  preattestation("preattestation");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateKind {
  attestationsAggregate("attestations_aggregate");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregateKind {
  preattestationsAggregate("preattestations_aggregate");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregateKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregateKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregateKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidenceKind {
  doubleConsensusOperationEvidence("double_consensus_operation_evidence");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidenceKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidenceKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidenceKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezMempoolN025PsUshuaiInlinedConsensusOperationContents {
  const OctezMempoolN025PsUshuaiInlinedConsensusOperationContents();

  factory OctezMempoolN025PsUshuaiInlinedConsensusOperationContents.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['kind'] == "attestation_with_dal" &&
          map.hasValue('slot') &&
          map.hasValue('level') &&
          map.hasValue('round') &&
          map.hasValue('block_payload_hash') &&
          map.hasValue('dal_attestation')) {
        return OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestationWithDal.fromJson(
          map,
        );
      }
      if (map['kind'] == "preattestation" &&
          map.hasValue('slot') &&
          map.hasValue('level') &&
          map.hasValue('round') &&
          map.hasValue('block_payload_hash')) {
        return OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsPreattestation.fromJson(
          map,
        );
      }
      if (map['kind'] == "attestation" &&
          map.hasValue('slot') &&
          map.hasValue('level') &&
          map.hasValue('round') &&
          map.hasValue('block_payload_hash')) {
        return OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestation.fromJson(
          map,
        );
      }
      if (map['kind'] == "preattestations_aggregate" &&
          map.hasValue('consensus_content') &&
          map.hasValue('committee')) {
        return OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsPreattestationsAggregate.fromJson(
          map,
        );
      }
      if (map['kind'] == "attestations_aggregate" &&
          map.hasValue('consensus_content') &&
          map.hasValue('committee')) {
        return OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestationsAggregate.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiInlinedConsensusOperationContents',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiInlinedConsensusOperationContents from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsPreattestation
    extends OctezMempoolN025PsUshuaiInlinedConsensusOperationContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationKind kind;
  final int slot;
  final int level;
  final int round;
  final OctezMempoolValueHash blockPayloadHash;

  const OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsPreattestation({
    required this.kind,
    required this.slot,
    required this.level,
    required this.round,
    required this.blockPayloadHash,
  });

  factory OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsPreattestation.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsPreattestation(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationKind.fromJson(
            json['kind'],
          ),
      slot: json.valueAsInt('slot'),
      level: json.valueAsInt('level'),
      round: json.valueAsInt('round'),
      blockPayloadHash: OctezMempoolUnistring.fromJson(
        json['block_payload_hash'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'slot': slot,
        'level': level,
        'round': round,
        'block_payload_hash': blockPayloadHash.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestation
    extends OctezMempoolN025PsUshuaiInlinedConsensusOperationContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationKind kind;
  final int slot;
  final int level;
  final int round;
  final OctezMempoolValueHash blockPayloadHash;

  const OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestation({
    required this.kind,
    required this.slot,
    required this.level,
    required this.round,
    required this.blockPayloadHash,
  });

  factory OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestation.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestation(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationKind.fromJson(
            json['kind'],
          ),
      slot: json.valueAsInt('slot'),
      level: json.valueAsInt('level'),
      round: json.valueAsInt('round'),
      blockPayloadHash: OctezMempoolUnistring.fromJson(
        json['block_payload_hash'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'slot': slot,
        'level': level,
        'round': round,
        'block_payload_hash': blockPayloadHash.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestationWithDal
    extends OctezMempoolN025PsUshuaiInlinedConsensusOperationContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDalKind
  kind;
  final int slot;
  final int level;
  final int round;
  final OctezMempoolValueHash blockPayloadHash;
  final OctezMempoolBignum dalAttestation;

  const OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestationWithDal({
    required this.kind,
    required this.slot,
    required this.level,
    required this.round,
    required this.blockPayloadHash,
    required this.dalAttestation,
  });

  factory OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestationWithDal.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestationWithDal(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDalKind.fromJson(
            json['kind'],
          ),
      slot: json.valueAsInt('slot'),
      level: json.valueAsInt('level'),
      round: json.valueAsInt('round'),
      blockPayloadHash: OctezMempoolUnistring.fromJson(
        json['block_payload_hash'],
      ),
      dalAttestation:
          (json['dal_attestation'] is num
              ? json['dal_attestation'].toString()
              : json.valueAsString('dal_attestation')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'slot': slot,
        'level': level,
        'round': round,
        'block_payload_hash': blockPayloadHash.toJson(),
        'dal_attestation': dalAttestation,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsPreattestationsAggregate
    extends OctezMempoolN025PsUshuaiInlinedConsensusOperationContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregateKind
  kind;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent
  consensusContent;
  final BuBytes committee;

  OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsPreattestationsAggregate({
    required this.kind,
    required this.consensusContent,
    required List<int> committee,
  }) : committee = committee.asImmutableBytes;

  factory OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsPreattestationsAggregate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsPreattestationsAggregate(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregateKind.fromJson(
            json['kind'],
          ),
      consensusContent: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent,
        Map<String, dynamic>
      >(
        key: 'consensus_content',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent.fromJson(
                  v,
                ),
      ),
      committee: json.valueAsList<List<int>>('committee'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'consensus_content': consensusContent.toJson(),
        'committee': committee,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestationsAggregate
    extends OctezMempoolN025PsUshuaiInlinedConsensusOperationContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateKind
  kind;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent
  consensusContent;
  final List<
    OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateCommitteeItem
  >
  committee;

  OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestationsAggregate({
    required this.kind,
    required this.consensusContent,
    required this.committee,
  });

  factory OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestationsAggregate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiInlinedConsensusOperationContentsAttestationsAggregate(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateKind.fromJson(
            json['kind'],
          ),
      consensusContent: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent,
        Map<String, dynamic>
      >(
        key: 'consensus_content',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent.fromJson(
                  v,
                ),
      ),
      committee:
          json
              .valueEnsureAsList<Map<String, dynamic>>('committee')
              .map(
                (e) =>
                    OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateCommitteeItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'consensus_content': consensusContent.toJson(),
        'committee': committee.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelationKind {
  seedNonceRevelation("seed_nonce_revelation");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelationKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelationKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelationKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationKind {
  vdfRevelation("vdf_revelation");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItem {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItem();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItem.fromJson(
    dynamic json,
  ) {
    if (json is String) {
      return OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItemStringValue(
        json,
      );
    }
    if (json is String) {
      return OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItemStringValue2(
        json,
      );
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItem',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItem from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItemStringValue
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItem {
  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItemStringValue(
    this.value,
  );

  @override
  dynamic toJson() => value;
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItemStringValue2
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItem {
  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItemStringValue2(
    this.value,
  );

  @override
  dynamic toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidenceKind {
  doubleBakingEvidence("double_baking_evidence");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidenceKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidenceKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidenceKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiLiquidityBakingVote {
  on_("on"),
  off("off"),
  pass("pass");

  final String value;
  const OctezMempoolN025PsUshuaiLiquidityBakingVote(this.value);

  static OctezMempoolN025PsUshuaiLiquidityBakingVote fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiLiquidityBakingVote.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceKind {
  dalEntrapmentEvidence("dal_entrapment_evidence");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItem {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItem();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItem.fromJson(
    dynamic json,
  ) {
    if (json is num) {
      return OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItemInteger(
        json.toInt(),
      );
    }
    if (json is List) {
      return OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItemList1(
        List<dynamic>.from(json) as List<String>,
      );
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItem',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItem from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItemInteger
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItem {
  final int value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItemInteger(
    this.value,
  );

  @override
  dynamic toJson() => value;
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItemList1
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItem {
  final List<String> value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItemList1(
    this.value,
  );

  @override
  dynamic toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccountKind {
  activateAccount("activate_account");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccountKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccountKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccountKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsProposalsKind {
  proposals("proposals");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsProposalsKind(this.value);

  static OctezMempoolN025PsUshuaiOperationAlphaContentsProposalsKind fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsProposalsKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsBallotKind {
  ballot("ballot");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsBallotKind(this.value);

  static OctezMempoolN025PsUshuaiOperationAlphaContentsBallotKind fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsBallotKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsBallotBallot {
  nay("nay"),
  yay("yay"),
  pass("pass");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsBallotBallot(this.value);

  static OctezMempoolN025PsUshuaiOperationAlphaContentsBallotBallot fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsBallotBallot.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsRevealKind {
  reveal("reveal");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsRevealKind(this.value);

  static OctezMempoolN025PsUshuaiOperationAlphaContentsRevealKind fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsRevealKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionKind {
  transaction("transaction");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionKind fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezMempoolN025PsUshuaiEntrypointNamedValue {
  const OctezMempoolN025PsUshuaiEntrypointNamedValue();

  factory OctezMempoolN025PsUshuaiEntrypointNamedValue.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezMempoolN025PsUshuaiEntrypointNamedValueUnistring(
          OctezMempoolUnistring.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return OctezMempoolN025PsUshuaiEntrypointNamedValueUnistring(
        OctezMempoolUnistring.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiEntrypointNamedValue',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiEntrypointNamedValue from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiEntrypointNamedValueUnistring
    extends OctezMempoolN025PsUshuaiEntrypointNamedValue {
  final OctezMempoolUnistring value;
  const OctezMempoolN025PsUshuaiEntrypointNamedValueUnistring(this.value);

  @override
  dynamic toJson() => value.toJson();
}

/// Named entrypoint to a Michelson smart contract
sealed class OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypoint();

  factory OctezMempoolN025PsUshuaiEntrypoint.fromJson(dynamic json) {
    if (json is String) {
      return switch (json) {
        'default' => const OctezMempoolN025PsUshuaiEntrypointDefault(),
        'root' => const OctezMempoolN025PsUshuaiEntrypointRoot(),
        'do' => const OctezMempoolN025PsUshuaiEntrypointDo(),
        'set_delegate' => const OctezMempoolN025PsUshuaiEntrypointSetDelegate(),
        'remove_delegate' =>
          const OctezMempoolN025PsUshuaiEntrypointRemoveDelegate(),
        'deposit' => const OctezMempoolN025PsUshuaiEntrypointDeposit(),
        'stake' => const OctezMempoolN025PsUshuaiEntrypointStake(),
        'unstake' => const OctezMempoolN025PsUshuaiEntrypointUnstake(),
        'finalize_unstake' =>
          const OctezMempoolN025PsUshuaiEntrypointFinalizeUnstake(),
        'set_delegate_parameters' =>
          const OctezMempoolN025PsUshuaiEntrypointSetDelegateParameters(),
        _ => OctezMempoolN025PsUshuaiEntrypointNamed(
          OctezMempoolN025PsUshuaiEntrypointNamedValue.fromJson(json),
        ),
      };
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezMempoolN025PsUshuaiEntrypointNamed(
          OctezMempoolN025PsUshuaiEntrypointNamedValue.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return OctezMempoolN025PsUshuaiEntrypointNamed(
        OctezMempoolN025PsUshuaiEntrypointNamedValue.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiEntrypoint',
      reason: 'Cannot parse OctezMempoolN025PsUshuaiEntrypoint from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiEntrypointDefault
    extends OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypointDefault();

  @override
  String toJson() => 'default';
}

class OctezMempoolN025PsUshuaiEntrypointRoot
    extends OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypointRoot();

  @override
  String toJson() => 'root';
}

class OctezMempoolN025PsUshuaiEntrypointDo
    extends OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypointDo();

  @override
  String toJson() => 'do';
}

class OctezMempoolN025PsUshuaiEntrypointSetDelegate
    extends OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypointSetDelegate();

  @override
  String toJson() => 'set_delegate';
}

class OctezMempoolN025PsUshuaiEntrypointRemoveDelegate
    extends OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypointRemoveDelegate();

  @override
  String toJson() => 'remove_delegate';
}

class OctezMempoolN025PsUshuaiEntrypointDeposit
    extends OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypointDeposit();

  @override
  String toJson() => 'deposit';
}

class OctezMempoolN025PsUshuaiEntrypointStake
    extends OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypointStake();

  @override
  String toJson() => 'stake';
}

class OctezMempoolN025PsUshuaiEntrypointUnstake
    extends OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypointUnstake();

  @override
  String toJson() => 'unstake';
}

class OctezMempoolN025PsUshuaiEntrypointFinalizeUnstake
    extends OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypointFinalizeUnstake();

  @override
  String toJson() => 'finalize_unstake';
}

class OctezMempoolN025PsUshuaiEntrypointSetDelegateParameters
    extends OctezMempoolN025PsUshuaiEntrypoint {
  const OctezMempoolN025PsUshuaiEntrypointSetDelegateParameters();

  @override
  String toJson() => 'set_delegate_parameters';
}

class OctezMempoolN025PsUshuaiEntrypointNamed
    extends OctezMempoolN025PsUshuaiEntrypoint {
  final OctezMempoolN025PsUshuaiEntrypointNamedValue value;
  const OctezMempoolN025PsUshuaiEntrypointNamed(this.value);

  @override
  dynamic toJson() => value.toJson();
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsOriginationKind {
  origination("origination");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsOriginationKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsOriginationKind fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsOriginationKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsDelegationKind {
  delegation("delegation");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsDelegationKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsDelegationKind fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsDelegationKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimitKind {
  setDepositsLimit("set_deposits_limit");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimitKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimitKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimitKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorageKind {
  increasePaidStorage("increase_paid_storage");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorageKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorageKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorageKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKeyKind {
  updateConsensusKey("update_consensus_key");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKeyKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKeyKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKeyKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKeyKind {
  updateCompanionKey("update_companion_key");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKeyKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKeyKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKeyKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegateKind {
  drainDelegate("drain_delegate");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegateKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegateKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegateKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoopKind {
  failingNoop("failing_noop");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoopKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoopKind fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoopKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstantKind {
  registerGlobalConstant("register_global_constant");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstantKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstantKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstantKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicketKind {
  transferTicket("transfer_ticket");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicketKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicketKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicketKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentKind {
  dalPublishCommitment("dal_publish_commitment");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginateKind {
  smartRollupOriginate("smart_rollup_originate");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginateKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginateKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginateKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginatePvmKind {
  wasm200("wasm_2_0_0"),
  arith("arith"),
  riscv("riscv");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginatePvmKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginatePvmKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginatePvmKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessagesKind {
  smartRollupAddMessages("smart_rollup_add_messages");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessagesKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessagesKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessagesKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCementKind {
  smartRollupCement("smart_rollup_cement");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCementKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCementKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCementKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishKind {
  smartRollupPublish("smart_rollup_publish");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteKind {
  smartRollupRefute("smart_rollup_refute");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStartRefutationKind {
  start("start");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStartRefutationKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStartRefutationKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStartRefutationKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveRefutationKind {
  move("move");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveRefutationKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveRefutationKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveRefutationKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProofInputProofKind {
  inboxProof("inbox_proof");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProofInputProofKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProofInputProofKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProofInputProofKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofInputProofKind {
  revealProof("reveal_proof");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofInputProofKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofInputProofKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofInputProofKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProofRevealProofKind {
  rawDataProof("raw_data_proof");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProofRevealProofKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProofRevealProofKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProofRevealProofKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProofRevealProofKind {
  metadataProof("metadata_proof");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProofRevealProofKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProofRevealProofKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProofRevealProofKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofRevealProofKind {
  dalPageProof("dal_page_proof");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofRevealProofKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofRevealProofKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofRevealProofKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProofRevealProofKind {
  dalParametersProof("dal_parameters_proof");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProofRevealProofKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProofRevealProofKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProofRevealProofKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['reveal_proof_kind'] == "dal_page_proof" &&
          map.hasValue('dal_page_id') &&
          map.hasValue('dal_proof')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProof.fromJson(
          map,
        );
      }
      if (map['reveal_proof_kind'] == "raw_data_proof" &&
          map.hasValue('raw_data')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProof.fromJson(
          map,
        );
      }
      if (map['reveal_proof_kind'] == "metadata_proof") {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProof.fromJson(
          map,
        );
      }
      if (map['reveal_proof_kind'] == "dal_parameters_proof") {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProof.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProof
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProofRevealProofKind
  revealProofKind;
  final String rawData;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProof({
    required this.revealProofKind,
    required this.rawData,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProof(
      revealProofKind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofRawDataProofRevealProofKind.fromJson(
            json['reveal_proof_kind'],
          ),
      rawData:
          (json['raw_data'] is num
              ? json['raw_data'].toString()
              : json.valueAsString('raw_data')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'reveal_proof_kind': revealProofKind.toJson(),
        'raw_data': rawData,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProof
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProofRevealProofKind
  revealProofKind;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProof({
    required this.revealProofKind,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProof(
      revealProofKind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofMetadataProofRevealProofKind.fromJson(
            json['reveal_proof_kind'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'reveal_proof_kind': revealProofKind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProof
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofRevealProofKind
  revealProofKind;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofDalPageId
  dalPageId;
  final String dalProof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProof({
    required this.revealProofKind,
    required this.dalPageId,
    required this.dalProof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProof(
      revealProofKind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofRevealProofKind.fromJson(
            json['reveal_proof_kind'],
          ),
      dalPageId: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofDalPageId,
        Map<String, dynamic>
      >(
        key: 'dal_page_id',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofDalPageId.fromJson(
                  v,
                ),
      ),
      dalProof:
          (json['dal_proof'] is num
              ? json['dal_proof'].toString()
              : json.valueAsString('dal_proof')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'reveal_proof_kind': revealProofKind.toJson(),
        'dal_page_id': dalPageId.toJson(),
        'dal_proof': dalProof,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProof
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProofRevealProofKind
  revealProofKind;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProof({
    required this.revealProofKind,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProof(
      revealProofKind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalParametersProofRevealProofKind.fromJson(
            json['reveal_proof_kind'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'reveal_proof_kind': revealProofKind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInputInputProofKind {
  firstInput("first_input");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInputInputProofKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInputInputProofKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInputInputProofKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProof {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProof();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProof.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['input_proof_kind'] == "inbox_proof" &&
          map.hasValue('level') &&
          map.hasValue('message_counter') &&
          map.hasValue('serialized_proof')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProof.fromJson(
          map,
        );
      }
      if (map['input_proof_kind'] == "reveal_proof" &&
          map.hasValue('reveal_proof')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProof.fromJson(
          map,
        );
      }
      if (map['input_proof_kind'] == "first_input") {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInput.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProof',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProof from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProof
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProof {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProofInputProofKind
  inputProofKind;
  final int level;
  final OctezMempoolPositiveBignum messageCounter;
  final String serializedProof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProof({
    required this.inputProofKind,
    required this.level,
    required this.messageCounter,
    required this.serializedProof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProof(
      inputProofKind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofInboxProofInputProofKind.fromJson(
            json['input_proof_kind'],
          ),
      level: json.valueAsInt('level'),
      messageCounter:
          (json['message_counter'] is num
              ? json['message_counter'].toString()
              : json.valueAsString('message_counter')),
      serializedProof:
          (json['serialized_proof'] is num
              ? json['serialized_proof'].toString()
              : json.valueAsString('serialized_proof')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'input_proof_kind': inputProofKind.toJson(),
        'level': level,
        'message_counter': messageCounter,
        'serialized_proof': serializedProof,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProof
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProof {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofInputProofKind
  inputProofKind;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof
  revealProof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProof({
    required this.inputProofKind,
    required this.revealProof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProof(
      inputProofKind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofInputProofKind.fromJson(
            json['input_proof_kind'],
          ),
      revealProof:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProof.fromJson(
            json['reveal_proof'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'input_proof_kind': inputProofKind.toJson(),
        'reveal_proof': revealProof.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInput
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProof {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInputInputProofKind
  inputProofKind;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInput({
    required this.inputProofKind,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInput.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInput(
      inputProofKind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofFirstInputInputProofKind.fromJson(
            json['input_proof_kind'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'input_proof_kind': inputProofKind.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStep {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStep();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStep.fromJson(
    dynamic json,
  ) {
    if (json is List) {
      return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepDissection(
        (json)
            .map(
              (e) =>
                  OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepDissectionItem.fromJson(
                    e,
                  ),
            )
            .toList(),
      );
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('pvm_step')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProof.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStep',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStep from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepDissection
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStep {
  final List<
    OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepDissectionItem
  >
  value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepDissection(
    this.value,
  );

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProof
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStep {
  final String pvmStep;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProof?
  inputProof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProof({
    required this.pvmStep,
    this.inputProof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProof(
      pvmStep:
          (json['pvm_step'] is num
              ? json['pvm_step'].toString()
              : json.valueAsString('pvm_step')),
      inputProof:
          json.hasValue('input_proof')
              ? OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProof.fromJson(
                json['input_proof'],
              )
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'pvm_step': pvmStep,
        'input_proof': inputProof?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutation {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutation();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutation.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['refutation_kind'] == "start" &&
          map.hasValue('player_commitment_hash') &&
          map.hasValue('opponent_commitment_hash')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStart.fromJson(
          map,
        );
      }
      if (map['refutation_kind'] == "move" &&
          map.hasValue('choice') &&
          map.hasValue('step')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMove.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutation',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutation from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStart
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutation {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStartRefutationKind
  refutationKind;
  final OctezMempoolSmartRollupCommitmentHash playerCommitmentHash;
  final OctezMempoolSmartRollupCommitmentHash opponentCommitmentHash;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStart({
    required this.refutationKind,
    required this.playerCommitmentHash,
    required this.opponentCommitmentHash,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStart.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStart(
      refutationKind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationStartRefutationKind.fromJson(
            json['refutation_kind'],
          ),
      playerCommitmentHash: OctezMempoolUnistring.fromJson(
        json['player_commitment_hash'],
      ),
      opponentCommitmentHash: OctezMempoolUnistring.fromJson(
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

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMove
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutation {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveRefutationKind
  refutationKind;
  final OctezMempoolPositiveBignum choice;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStep
  step;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMove({
    required this.refutationKind,
    required this.choice,
    required this.step,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMove.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMove(
      refutationKind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveRefutationKind.fromJson(
            json['refutation_kind'],
          ),
      choice:
          (json['choice'] is num
              ? json['choice'].toString()
              : json.valueAsString('choice')),
      step:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStep.fromJson(
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

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutKind {
  smartRollupTimeout("smart_rollup_timeout");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessageKind {
  smartRollupExecuteOutboxMessage("smart_rollup_execute_outbox_message");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessageKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessageKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessageKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBondKind {
  smartRollupRecoverBond("smart_rollup_recover_bond");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBondKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBondKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBondKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationKind {
  zkRollupOrigination("zk_rollup_origination");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('public')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValuePublic.fromJson(
          map,
        );
      }
      if (map.hasValue('private')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValuePrivate.fromJson(
          map,
        );
      }
      if (map.hasValue('fee')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValueFee.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValuePublic
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value {
  final dynamic public;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValuePublic({
    required this.public,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValuePublic.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValuePublic(
      public: json['public'],
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'public': public}.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValuePrivate
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value {
  final dynamic private;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValuePrivate({
    required this.private,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValuePrivate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValuePrivate(
      private: json['private'],
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'private': private}.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValueFee
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value {
  final dynamic fee;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValueFee({
    required this.fee,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValueFee.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1ValueFee(
      fee: json['fee'],
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'fee': fee}.notNullValue.cast<String, dynamic>();
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItem {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItem();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemUnistring(
          OctezMempoolUnistring.fromJson(map),
        );
      } catch (_) {}
      try {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1(
          OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value.fromJson(
            map,
          ),
        );
      } catch (_) {}
    }
    try {
      return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemUnistring(
        OctezMempoolUnistring.fromJson(json),
      );
    } catch (_) {}
    try {
      return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1(
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value.fromJson(
          json,
        ),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItem',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItem from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemUnistring
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItem {
  final OctezMempoolUnistring value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemUnistring(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItem {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1Value
  value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItemVariant1(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishKind {
  zkRollupPublish("zk_rollup_publish");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezMempoolN025PsUshuaiMichelsonV1Primitives {
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
  const OctezMempoolN025PsUshuaiMichelsonV1Primitives(this.value);

  static OctezMempoolN025PsUshuaiMichelsonV1Primitives fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiMichelsonV1Primitives.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezMempoolMicheline025PsUshuaiMichelsonV1Expression {
  const OctezMempoolMicheline025PsUshuaiMichelsonV1Expression();

  factory OctezMempoolMicheline025PsUshuaiMichelsonV1Expression.fromJson(
    dynamic json,
  ) {
    if (json is List) {
      return OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionSequence(
        (json)
            .map(
              (e) =>
                  OctezMempoolMicheline025PsUshuaiMichelsonV1Expression.fromJson(
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
        return OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionPrimGeneric.fromJson(
          map,
        );
      }
      if (map.hasValue('int')) {
        return OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionInt.fromJson(
          map,
        );
      }
      if (map.hasValue('string')) {
        return OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionStringValue.fromJson(
          map,
        );
      }
      if (map.hasValue('bytes')) {
        return OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionBytes.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolMicheline025PsUshuaiMichelsonV1Expression',
      reason:
          'Cannot parse OctezMempoolMicheline025PsUshuaiMichelsonV1Expression from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionInt
    extends OctezMempoolMicheline025PsUshuaiMichelsonV1Expression {
  final OctezMempoolBignum int_;

  const OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionInt({
    required this.int_,
  });

  factory OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionInt.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionInt(
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

class OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionStringValue
    extends OctezMempoolMicheline025PsUshuaiMichelsonV1Expression {
  final OctezMempoolUnistring string;

  const OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionStringValue({
    required this.string,
  });

  factory OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionStringValue.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionStringValue(
      string: OctezMempoolUnistring.fromJson(json['string']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'string': string.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionBytes
    extends OctezMempoolMicheline025PsUshuaiMichelsonV1Expression {
  final String bytes;

  const OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionBytes({
    required this.bytes,
  });

  factory OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionBytes.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionBytes(
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

class OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionSequence
    extends OctezMempoolMicheline025PsUshuaiMichelsonV1Expression {
  final List<OctezMempoolMicheline025PsUshuaiMichelsonV1Expression> value;
  const OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionSequence(
    this.value,
  );

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

class OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionPrimGeneric
    extends OctezMempoolMicheline025PsUshuaiMichelsonV1Expression {
  final OctezMempoolN025PsUshuaiMichelsonV1Primitives prim;
  final List<OctezMempoolMicheline025PsUshuaiMichelsonV1Expression>? args;
  final List<OctezMempoolUnistring>? annots;

  const OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionPrimGeneric({
    required this.prim,
    this.args,
    this.annots,
  });

  factory OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionPrimGeneric.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolMicheline025PsUshuaiMichelsonV1ExpressionPrimGeneric(
      prim: OctezMempoolN025PsUshuaiMichelsonV1Primitives.fromJson(
        json['prim'],
      ),
      args:
          json.hasValue('args')
              ? json
                  .valueEnsureAsList<dynamic>('args')
                  .map(
                    (e) =>
                        OctezMempoolMicheline025PsUshuaiMichelsonV1Expression.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      annots:
          json.hasValue('annots')
              ? json
                  .valueEnsureAsList<dynamic>('annots')
                  .map((e) => OctezMempoolUnistring.fromJson(e))
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

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1Value {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1Value();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1Value.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('contents') &&
          map.hasValue('ty') &&
          map.hasValue('ticketer')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1ValueSome.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1Value',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1Value from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1ValueSome
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1Value {
  final OctezMempoolMicheline025PsUshuaiMichelsonV1Expression contents;
  final OctezMempoolMicheline025PsUshuaiMichelsonV1Expression ty;
  final OctezMempoolN025PsUshuaiContractId ticketer;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1ValueSome({
    required this.contents,
    required this.ty,
    required this.ticketer,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1ValueSome.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1ValueSome(
      contents: OctezMempoolMicheline025PsUshuaiMichelsonV1Expression.fromJson(
        json['contents'],
      ),
      ty: OctezMempoolMicheline025PsUshuaiMichelsonV1Expression.fromJson(
        json['ty'],
      ),
      ticketer: OctezMempoolUnistring.fromJson(json['ticketer']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'contents': contents.toJson(),
        'ty': ty.toJson(),
        'ticketer': ticketer.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItem {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItem();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1(
          OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1Value.fromJson(
            map,
          ),
        );
      } catch (_) {}
      if (map.hasValue('op_code') &&
          map.hasValue('price') &&
          map.hasValue('l1_dst') &&
          map.hasValue('rollup_id') &&
          map.hasValue('payload')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayload.fromJson(
          map,
        );
      }
    }
    try {
      return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1(
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1Value.fromJson(
          json,
        ),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItem',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItem from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayload
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItem {
  final int opCode;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayloadPrice
  price;
  final OctezMempoolSignaturePublicKeyHash l1Dst;
  final OctezMempoolZkRollupHash rollupId;
  final List<String> payload;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayload({
    required this.opCode,
    required this.price,
    required this.l1Dst,
    required this.rollupId,
    required this.payload,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayload.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayload(
      opCode: json.valueAsInt('op_code'),
      price: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayloadPrice,
        Map<String, dynamic>
      >(
        key: 'price',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayloadPrice.fromJson(
                  v,
                ),
      ),
      l1Dst: OctezMempoolUnistring.fromJson(json['l1_dst']),
      rollupId: OctezMempoolUnistring.fromJson(json['rollup_id']),
      payload: json.valueAsList<List<String>>('payload'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'op_code': opCode,
        'price': price.toJson(),
        'l1_dst': l1Dst.toJson(),
        'rollup_id': rollupId.toJson(),
        'payload': payload,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItem {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1Value
  value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemVariant1(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

enum OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateKind {
  zkRollupUpdate("zk_rollup_update");

  final String value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateKind(
    this.value,
  );

  static OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItem {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItem();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItemUnistring(
          OctezMempoolUnistring.fromJson(map),
        );
      } catch (_) {}
      if (map.hasValue('new_state') &&
          map.hasValue('fee') &&
          map.hasValue('exit_validity')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItemNewStateFeeExitValidity.fromJson(
          map,
        );
      }
    }
    try {
      return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItemUnistring(
        OctezMempoolUnistring.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItem',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItem from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItemUnistring
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItem {
  final OctezMempoolUnistring value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItemUnistring(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItemNewStateFeeExitValidity
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItem {
  final List<String> newState;
  final String fee;
  final bool exitValidity;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItemNewStateFeeExitValidity({
    required this.newState,
    required this.fee,
    required this.exitValidity,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItemNewStateFeeExitValidity.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItemNewStateFeeExitValidity(
      newState: json.valueAsList<List<String>>('new_state'),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      exitValidity: json.valueAsBool('exit_validity'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'new_state': newState,
        'fee': fee,
        'exit_validity': exitValidity,
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItem {
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItem();

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItemUnistring(
          OctezMempoolUnistring.fromJson(map),
        );
      } catch (_) {}
      if (map.hasValue('new_state') && map.hasValue('fee')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItemNewStateFee.fromJson(
          map,
        );
      }
    }
    try {
      return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItemUnistring(
        OctezMempoolUnistring.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItem',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItem from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItemUnistring
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItem {
  final OctezMempoolUnistring value;
  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItemUnistring(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItemNewStateFee
    extends
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItem {
  final List<String> newState;
  final String fee;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItemNewStateFee({
    required this.newState,
    required this.fee,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItemNewStateFee.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItemNewStateFee(
      newState: json.valueAsList<List<String>>('new_state'),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'new_state': newState, 'fee': fee}.notNullValue.cast<String, dynamic>();
}

sealed class OctezMempoolN025PsUshuaiOperationAlphaContents {
  const OctezMempoolN025PsUshuaiOperationAlphaContents();

  factory OctezMempoolN025PsUshuaiOperationAlphaContents.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['kind'] == "transfer_ticket" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('ticket_contents') &&
          map.hasValue('ticket_ty') &&
          map.hasValue('ticket_ticketer') &&
          map.hasValue('ticket_amount') &&
          map.hasValue('destination') &&
          map.hasValue('entrypoint')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicket.fromJson(
          map,
        );
      }
      if (map['kind'] == "zk_rollup_origination" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('public_parameters') &&
          map.hasValue('circuits_info') &&
          map.hasValue('init_state') &&
          map.hasValue('nb_ops')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOrigination.fromJson(
          map,
        );
      }
      if (map['kind'] == "smart_rollup_originate" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('pvm_kind') &&
          map.hasValue('kernel') &&
          map.hasValue('parameters_ty')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginate.fromJson(
          map,
        );
      }
      if (map['kind'] == "smart_rollup_refute" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('rollup') &&
          map.hasValue('opponent') &&
          map.hasValue('refutation')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefute.fromJson(
          map,
        );
      }
      if (map['kind'] == "smart_rollup_execute_outbox_message" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('rollup') &&
          map.hasValue('cemented_commitment') &&
          map.hasValue('output_proof')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessage.fromJson(
          map,
        );
      }
      if (map['kind'] == "origination" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('balance') &&
          map.hasValue('script')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsOrigination.fromJson(
          map,
        );
      }
      if (map['kind'] == "smart_rollup_recover_bond" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('rollup') &&
          map.hasValue('staker')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBond.fromJson(
          map,
        );
      }
      if (map['kind'] == "zk_rollup_publish" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('zk_rollup') &&
          map.hasValue('op')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublish.fromJson(
          map,
        );
      }
      if (map['kind'] == "smart_rollup_timeout" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('rollup') &&
          map.hasValue('stakers')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeout.fromJson(
          map,
        );
      }
      if (map['kind'] == "smart_rollup_publish" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('rollup') &&
          map.hasValue('commitment')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublish.fromJson(
          map,
        );
      }
      if (map['kind'] == "transaction" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('amount') &&
          map.hasValue('destination')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsTransaction.fromJson(
          map,
        );
      }
      if (map['kind'] == "zk_rollup_update" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('zk_rollup') &&
          map.hasValue('update')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdate.fromJson(
          map,
        );
      }
      if (map['kind'] == "dal_entrapment_evidence" &&
          map.hasValue('attestation') &&
          map.hasValue('consensus_slot') &&
          map.hasValue('slot_index') &&
          map.hasValue('shard_with_proof')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidence.fromJson(
          map,
        );
      }
      if (map['kind'] == "increase_paid_storage" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('amount') &&
          map.hasValue('destination')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorage.fromJson(
          map,
        );
      }
      if (map['kind'] == "smart_rollup_add_messages" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('message')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessages.fromJson(
          map,
        );
      }
      if (map['kind'] == "reveal" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('public_key')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsReveal.fromJson(
          map,
        );
      }
      if (map['kind'] == "dal_publish_commitment" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('slot_header')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitment.fromJson(
          map,
        );
      }
      if (map['kind'] == "register_global_constant" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('value')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstant.fromJson(
          map,
        );
      }
      if (map['kind'] == "smart_rollup_cement" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('rollup')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCement.fromJson(
          map,
        );
      }
      if (map['kind'] == "update_consensus_key" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('pk')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKey.fromJson(
          map,
        );
      }
      if (map['kind'] == "update_companion_key" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit') &&
          map.hasValue('pk')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKey.fromJson(
          map,
        );
      }
      if (map['kind'] == "attestation_with_dal" &&
          map.hasValue('slot') &&
          map.hasValue('level') &&
          map.hasValue('round') &&
          map.hasValue('block_payload_hash') &&
          map.hasValue('dal_attestation')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDal.fromJson(
          map,
        );
      }
      if (map['kind'] == "set_deposits_limit" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimit.fromJson(
          map,
        );
      }
      if (map['kind'] == "ballot" &&
          map.hasValue('source') &&
          map.hasValue('period') &&
          map.hasValue('proposal') &&
          map.hasValue('ballot')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsBallot.fromJson(
          map,
        );
      }
      if (map['kind'] == "delegation" &&
          map.hasValue('source') &&
          map.hasValue('fee') &&
          map.hasValue('counter') &&
          map.hasValue('gas_limit') &&
          map.hasValue('storage_limit')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsDelegation.fromJson(
          map,
        );
      }
      if (map['kind'] == "double_consensus_operation_evidence" &&
          map.hasValue('slot') &&
          map.hasValue('op1') &&
          map.hasValue('op2')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidence.fromJson(
          map,
        );
      }
      if (map['kind'] == "attestation" &&
          map.hasValue('slot') &&
          map.hasValue('level') &&
          map.hasValue('round') &&
          map.hasValue('block_payload_hash')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsAttestation.fromJson(
          map,
        );
      }
      if (map['kind'] == "preattestation" &&
          map.hasValue('slot') &&
          map.hasValue('level') &&
          map.hasValue('round') &&
          map.hasValue('block_payload_hash')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestation.fromJson(
          map,
        );
      }
      if (map['kind'] == "drain_delegate" &&
          map.hasValue('consensus_key') &&
          map.hasValue('delegate') &&
          map.hasValue('destination')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegate.fromJson(
          map,
        );
      }
      if (map['kind'] == "proposals" &&
          map.hasValue('source') &&
          map.hasValue('period') &&
          map.hasValue('proposals')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsProposals.fromJson(
          map,
        );
      }
      if (map['kind'] == "activate_account" &&
          map.hasValue('pkh') &&
          map.hasValue('secret')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccount.fromJson(
          map,
        );
      }
      if (map['kind'] == "double_baking_evidence" &&
          map.hasValue('bh1') &&
          map.hasValue('bh2')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidence.fromJson(
          map,
        );
      }
      if (map['kind'] == "seed_nonce_revelation" &&
          map.hasValue('level') &&
          map.hasValue('nonce')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelation.fromJson(
          map,
        );
      }
      if (map['kind'] == "preattestations_aggregate" &&
          map.hasValue('consensus_content') &&
          map.hasValue('committee')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregate.fromJson(
          map,
        );
      }
      if (map['kind'] == "attestations_aggregate" &&
          map.hasValue('consensus_content') &&
          map.hasValue('committee')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregate.fromJson(
          map,
        );
      }
      if (map['kind'] == "vdf_revelation" && map.hasValue('solution')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelation.fromJson(
          map,
        );
      }
      if (map['kind'] == "failing_noop" && map.hasValue('arbitrary')) {
        return OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoop.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezMempoolN025PsUshuaiOperationAlphaContents',
      reason:
          'Cannot parse OctezMempoolN025PsUshuaiOperationAlphaContents from $json',
    );
  }

  dynamic toJson();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsAttestation
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationKind kind;
  final int slot;
  final int level;
  final int round;
  final OctezMempoolValueHash blockPayloadHash;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsAttestation({
    required this.kind,
    required this.slot,
    required this.level,
    required this.round,
    required this.blockPayloadHash,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsAttestation.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsAttestation(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationKind.fromJson(
            json['kind'],
          ),
      slot: json.valueAsInt('slot'),
      level: json.valueAsInt('level'),
      round: json.valueAsInt('round'),
      blockPayloadHash: OctezMempoolUnistring.fromJson(
        json['block_payload_hash'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'slot': slot,
        'level': level,
        'round': round,
        'block_payload_hash': blockPayloadHash.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDal
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDalKind
  kind;
  final int slot;
  final int level;
  final int round;
  final OctezMempoolValueHash blockPayloadHash;
  final OctezMempoolBignum dalAttestation;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDal({
    required this.kind,
    required this.slot,
    required this.level,
    required this.round,
    required this.blockPayloadHash,
    required this.dalAttestation,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDal.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDal(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationWithDalKind.fromJson(
            json['kind'],
          ),
      slot: json.valueAsInt('slot'),
      level: json.valueAsInt('level'),
      round: json.valueAsInt('round'),
      blockPayloadHash: OctezMempoolUnistring.fromJson(
        json['block_payload_hash'],
      ),
      dalAttestation:
          (json['dal_attestation'] is num
              ? json['dal_attestation'].toString()
              : json.valueAsString('dal_attestation')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'slot': slot,
        'level': level,
        'round': round,
        'block_payload_hash': blockPayloadHash.toJson(),
        'dal_attestation': dalAttestation,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestation
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationKind kind;
  final int slot;
  final int level;
  final int round;
  final OctezMempoolValueHash blockPayloadHash;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestation({
    required this.kind,
    required this.slot,
    required this.level,
    required this.round,
    required this.blockPayloadHash,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestation.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestation(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationKind.fromJson(
            json['kind'],
          ),
      slot: json.valueAsInt('slot'),
      level: json.valueAsInt('level'),
      round: json.valueAsInt('round'),
      blockPayloadHash: OctezMempoolUnistring.fromJson(
        json['block_payload_hash'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'slot': slot,
        'level': level,
        'round': round,
        'block_payload_hash': blockPayloadHash.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregate
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateKind
  kind;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent
  consensusContent;
  final List<
    OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateCommitteeItem
  >
  committee;

  OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregate({
    required this.kind,
    required this.consensusContent,
    required this.committee,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregate(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateKind.fromJson(
            json['kind'],
          ),
      consensusContent: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent,
        Map<String, dynamic>
      >(
        key: 'consensus_content',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent.fromJson(
                  v,
                ),
      ),
      committee:
          json
              .valueEnsureAsList<Map<String, dynamic>>('committee')
              .map(
                (e) =>
                    OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateCommitteeItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'consensus_content': consensusContent.toJson(),
        'committee': committee.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregate
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregateKind
  kind;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent
  consensusContent;
  final BuBytes committee;

  OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregate({
    required this.kind,
    required this.consensusContent,
    required List<int> committee,
  }) : committee = committee.asImmutableBytes;

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregate(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsPreattestationsAggregateKind.fromJson(
            json['kind'],
          ),
      consensusContent: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent,
        Map<String, dynamic>
      >(
        key: 'consensus_content',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent.fromJson(
                  v,
                ),
      ),
      committee: json.valueAsList<List<int>>('committee'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'consensus_content': consensusContent.toJson(),
        'committee': committee,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidence
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidenceKind
  kind;
  final int slot;
  final OctezMempoolN025PsUshuaiInlinedConsensusOperation op1;
  final OctezMempoolN025PsUshuaiInlinedConsensusOperation op2;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidence({
    required this.kind,
    required this.slot,
    required this.op1,
    required this.op2,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidence.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidence(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleConsensusOperationEvidenceKind.fromJson(
            json['kind'],
          ),
      slot: json.valueAsInt('slot'),
      op1: json.valueTo<
        OctezMempoolN025PsUshuaiInlinedConsensusOperation,
        Map<String, dynamic>
      >(
        key: 'op1',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiInlinedConsensusOperation.fromJson(v),
      ),
      op2: json.valueTo<
        OctezMempoolN025PsUshuaiInlinedConsensusOperation,
        Map<String, dynamic>
      >(
        key: 'op2',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiInlinedConsensusOperation.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'slot': slot,
        'op1': op1.toJson(),
        'op2': op2.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelation
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelationKind
  kind;
  final int level;
  final String nonce;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelation({
    required this.kind,
    required this.level,
    required this.nonce,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelation.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelation(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSeedNonceRevelationKind.fromJson(
            json['kind'],
          ),
      level: json.valueAsInt('level'),
      nonce:
          (json['nonce'] is num
              ? json['nonce'].toString()
              : json.valueAsString('nonce')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'level': level,
        'nonce': nonce,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelation
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationKind kind;
  final List<
    OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItem
  >
  solution;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelation({
    required this.kind,
    required this.solution,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelation.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelation(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationKind.fromJson(
            json['kind'],
          ),
      solution:
          json
              .valueEnsureAsList<dynamic>('solution')
              .map(
                (e) =>
                    OctezMempoolN025PsUshuaiOperationAlphaContentsVdfRevelationSolutionItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'solution': solution.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidence
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidenceKind
  kind;
  final OctezMempoolN025PsUshuaiBlockHeaderAlphaFullHeader bh1;
  final OctezMempoolN025PsUshuaiBlockHeaderAlphaFullHeader bh2;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidence({
    required this.kind,
    required this.bh1,
    required this.bh2,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidence.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidence(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsDoubleBakingEvidenceKind.fromJson(
            json['kind'],
          ),
      bh1: json.valueTo<
        OctezMempoolN025PsUshuaiBlockHeaderAlphaFullHeader,
        Map<String, dynamic>
      >(
        key: 'bh1',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiBlockHeaderAlphaFullHeader.fromJson(v),
      ),
      bh2: json.valueTo<
        OctezMempoolN025PsUshuaiBlockHeaderAlphaFullHeader,
        Map<String, dynamic>
      >(
        key: 'bh2',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiBlockHeaderAlphaFullHeader.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'bh1': bh1.toJson(),
        'bh2': bh2.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidence
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceKind
  kind;
  final OctezMempoolN025PsUshuaiInlinedConsensusOperation attestation;
  final int consensusSlot;
  final int slotIndex;
  final int? lagIndex;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProof
  shardWithProof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidence({
    required this.kind,
    required this.attestation,
    required this.consensusSlot,
    required this.slotIndex,
    this.lagIndex,
    required this.shardWithProof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidence.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidence(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceKind.fromJson(
            json['kind'],
          ),
      attestation: json.valueTo<
        OctezMempoolN025PsUshuaiInlinedConsensusOperation,
        Map<String, dynamic>
      >(
        key: 'attestation',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiInlinedConsensusOperation.fromJson(v),
      ),
      consensusSlot: json.valueAsInt('consensus_slot'),
      slotIndex: json.valueAsInt('slot_index'),
      lagIndex: json.valueAsInt('lag_index'),
      shardWithProof: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProof,
        Map<String, dynamic>
      >(
        key: 'shard_with_proof',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProof.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'attestation': attestation.toJson(),
        'consensus_slot': consensusSlot,
        'slot_index': slotIndex,
        'lag_index': lagIndex,
        'shard_with_proof': shardWithProof.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccount
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccountKind kind;
  final OctezMempoolEd25519PublicKeyHash pkh;
  final String secret;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccount({
    required this.kind,
    required this.pkh,
    required this.secret,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccount.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccount(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsActivateAccountKind.fromJson(
            json['kind'],
          ),
      pkh: OctezMempoolUnistring.fromJson(json['pkh']),
      secret:
          (json['secret'] is num
              ? json['secret'].toString()
              : json.valueAsString('secret')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'pkh': pkh.toJson(),
        'secret': secret,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsProposals
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsProposalsKind kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final int period;
  final List<OctezMempoolProtocolHash> proposals;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsProposals({
    required this.kind,
    required this.source,
    required this.period,
    required this.proposals,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsProposals.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsProposals(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsProposalsKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      period: json.valueAsInt('period'),
      proposals:
          json
              .valueEnsureAsList<dynamic>('proposals')
              .map((e) => OctezMempoolUnistring.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'period': period,
        'proposals': proposals.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsBallot
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsBallotKind kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final int period;
  final OctezMempoolProtocolHash proposal;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsBallotBallot ballot;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsBallot({
    required this.kind,
    required this.source,
    required this.period,
    required this.proposal,
    required this.ballot,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsBallot.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsBallot(
      kind: OctezMempoolN025PsUshuaiOperationAlphaContentsBallotKind.fromJson(
        json['kind'],
      ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      period: json.valueAsInt('period'),
      proposal: OctezMempoolUnistring.fromJson(json['proposal']),
      ballot:
          OctezMempoolN025PsUshuaiOperationAlphaContentsBallotBallot.fromJson(
            json['ballot'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'period': period,
        'proposal': proposal.toJson(),
        'ballot': ballot.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsReveal
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsRevealKind kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolSignaturePublicKey publicKey;
  final OctezMempoolBls12381Signature? proof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsReveal({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.publicKey,
    this.proof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsReveal.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsReveal(
      kind: OctezMempoolN025PsUshuaiOperationAlphaContentsRevealKind.fromJson(
        json['kind'],
      ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      publicKey: OctezMempoolUnistring.fromJson(json['public_key']),
      proof:
          json.hasValue('proof')
              ? OctezMempoolUnistring.fromJson(json['proof'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'public_key': publicKey.toJson(),
        'proof': proof?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsTransaction
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionKind kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolN025PsUshuaiMutez amount;
  final OctezMempoolN025PsUshuaiContractId destination;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionParameters?
  parameters;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsTransaction({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.amount,
    required this.destination,
    this.parameters,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsTransaction.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsTransaction(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString('amount')),
      destination: OctezMempoolUnistring.fromJson(json['destination']),
      parameters: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionParameters?,
        Map<String, dynamic>
      >(
        key: 'parameters',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionParameters.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'amount': amount,
        'destination': destination.toJson(),
        'parameters': parameters?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsOrigination
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsOriginationKind kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolN025PsUshuaiMutez balance;
  final OctezMempoolSignaturePublicKeyHash? delegate;
  final OctezMempoolN025PsUshuaiScriptedContracts script;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsOrigination({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.balance,
    this.delegate,
    required this.script,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsOrigination.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsOrigination(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsOriginationKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString('balance')),
      delegate:
          json.hasValue('delegate')
              ? OctezMempoolUnistring.fromJson(json['delegate'])
              : null,
      script: json.valueTo<
        OctezMempoolN025PsUshuaiScriptedContracts,
        Map<String, dynamic>
      >(
        key: 'script',
        parse: (v) => OctezMempoolN025PsUshuaiScriptedContracts.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'balance': balance,
        'delegate': delegate?.toJson(),
        'script': script.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsDelegation
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsDelegationKind kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolSignaturePublicKeyHash? delegate;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsDelegation({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    this.delegate,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsDelegation.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsDelegation(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsDelegationKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      delegate:
          json.hasValue('delegate')
              ? OctezMempoolUnistring.fromJson(json['delegate'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'delegate': delegate?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimit
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimitKind kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolN025PsUshuaiMutez? limit;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimit({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    this.limit,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimit.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimit(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSetDepositsLimitKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      limit:
          (json['limit'] is num
              ? json['limit'].toString()
              : json.valueAsString('limit')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'limit': limit,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorage
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorageKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolBignum amount;
  final OctezMempoolN025PsUshuaiContractIdOriginated destination;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorage({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.amount,
    required this.destination,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorage.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorage(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsIncreasePaidStorageKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString('amount')),
      destination: OctezMempoolUnistring.fromJson(json['destination']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'amount': amount,
        'destination': destination.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKey
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKeyKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolSignaturePublicKey pk;
  final OctezMempoolBls12381Signature? proof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKey({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.pk,
    this.proof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKey.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKey(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateConsensusKeyKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      pk: OctezMempoolUnistring.fromJson(json['pk']),
      proof:
          json.hasValue('proof')
              ? OctezMempoolUnistring.fromJson(json['proof'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'pk': pk.toJson(),
        'proof': proof?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKey
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKeyKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolSignaturePublicKey pk;
  final OctezMempoolBls12381Signature? proof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKey({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.pk,
    this.proof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKey.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKey(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsUpdateCompanionKeyKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      pk: OctezMempoolUnistring.fromJson(json['pk']),
      proof:
          json.hasValue('proof')
              ? OctezMempoolUnistring.fromJson(json['proof'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'pk': pk.toJson(),
        'proof': proof?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegate
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegateKind kind;
  final OctezMempoolSignaturePublicKeyHash consensusKey;
  final OctezMempoolSignaturePublicKeyHash delegate;
  final OctezMempoolSignaturePublicKeyHash destination;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegate({
    required this.kind,
    required this.consensusKey,
    required this.delegate,
    required this.destination,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegate(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsDrainDelegateKind.fromJson(
            json['kind'],
          ),
      consensusKey: OctezMempoolUnistring.fromJson(json['consensus_key']),
      delegate: OctezMempoolUnistring.fromJson(json['delegate']),
      destination: OctezMempoolUnistring.fromJson(json['destination']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'consensus_key': consensusKey.toJson(),
        'delegate': delegate.toJson(),
        'destination': destination.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoop
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoopKind kind;
  final String arbitrary;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoop({
    required this.kind,
    required this.arbitrary,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoop.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoop(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsFailingNoopKind.fromJson(
            json['kind'],
          ),
      arbitrary:
          (json['arbitrary'] is num
              ? json['arbitrary'].toString()
              : json.valueAsString('arbitrary')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'arbitrary': arbitrary,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstant
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstantKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;

  final dynamic value;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstant({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.value,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstant.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstant(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsRegisterGlobalConstantKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      value: json['value'],
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'value': value,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicket
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicketKind kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;

  final dynamic ticketContents;

  final dynamic ticketTy;
  final OctezMempoolN025PsUshuaiContractId ticketTicketer;
  final OctezMempoolPositiveBignum ticketAmount;
  final OctezMempoolN025PsUshuaiContractId destination;
  final OctezMempoolUnistring entrypoint;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicket({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.ticketContents,
    required this.ticketTy,
    required this.ticketTicketer,
    required this.ticketAmount,
    required this.destination,
    required this.entrypoint,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicket.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicket(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsTransferTicketKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      ticketContents: json['ticket_contents'],
      ticketTy: json['ticket_ty'],
      ticketTicketer: OctezMempoolUnistring.fromJson(json['ticket_ticketer']),
      ticketAmount:
          (json['ticket_amount'] is num
              ? json['ticket_amount'].toString()
              : json.valueAsString('ticket_amount')),
      destination: OctezMempoolUnistring.fromJson(json['destination']),
      entrypoint: OctezMempoolUnistring.fromJson(json['entrypoint']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'ticket_contents': ticketContents,
        'ticket_ty': ticketTy,
        'ticket_ticketer': ticketTicketer.toJson(),
        'ticket_amount': ticketAmount,
        'destination': destination.toJson(),
        'entrypoint': entrypoint.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitment
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentSlotHeader
  slotHeader;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitment({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.slotHeader,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitment.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitment(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      slotHeader: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentSlotHeader,
        Map<String, dynamic>
      >(
        key: 'slot_header',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentSlotHeader.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'slot_header': slotHeader.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginate
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginateKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginatePvmKind
  pvmKind;
  final String kernel;

  final dynamic parametersTy;
  final List<OctezMempoolSignaturePublicKeyHash>? whitelist;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginate({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.pvmKind,
    required this.kernel,
    required this.parametersTy,
    this.whitelist,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginate(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginateKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      pvmKind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupOriginatePvmKind.fromJson(
            json['pvm_kind'],
          ),
      kernel:
          (json['kernel'] is num
              ? json['kernel'].toString()
              : json.valueAsString('kernel')),
      parametersTy: json['parameters_ty'],
      whitelist:
          json.hasValue('whitelist')
              ? json
                  .valueEnsureAsList<dynamic>('whitelist')
                  .map((e) => OctezMempoolUnistring.fromJson(e))
                  .toList()
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'pvm_kind': pvmKind.toJson(),
        'kernel': kernel,
        'parameters_ty': parametersTy,
        'whitelist': whitelist?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessages
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessagesKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final List<String> message;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessages({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.message,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessages.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessages(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupAddMessagesKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      message: json.valueAsList<List<String>>('message'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'message': message,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCement
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCementKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolSmartRollupAddress rollup;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCement({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.rollup,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCement.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCement(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupCementKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      rollup: OctezMempoolUnistring.fromJson(json['rollup']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'rollup': rollup.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublish
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolSmartRollupAddress rollup;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishCommitment
  commitment;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublish({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.rollup,
    required this.commitment,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublish.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublish(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      rollup: OctezMempoolUnistring.fromJson(json['rollup']),
      commitment: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishCommitment,
        Map<String, dynamic>
      >(
        key: 'commitment',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishCommitment.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'rollup': rollup.toJson(),
        'commitment': commitment.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefute
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolSmartRollupAddress rollup;
  final OctezMempoolSignaturePublicKeyHash opponent;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutation
  refutation;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefute({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.rollup,
    required this.opponent,
    required this.refutation,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefute.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefute(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      rollup: OctezMempoolUnistring.fromJson(json['rollup']),
      opponent: OctezMempoolUnistring.fromJson(json['opponent']),
      refutation:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutation.fromJson(
            json['refutation'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'rollup': rollup.toJson(),
        'opponent': opponent.toJson(),
        'refutation': refutation.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeout
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolSmartRollupAddress rollup;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutStakers
  stakers;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeout({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.rollup,
    required this.stakers,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeout.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeout(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      rollup: OctezMempoolUnistring.fromJson(json['rollup']),
      stakers: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutStakers,
        Map<String, dynamic>
      >(
        key: 'stakers',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutStakers.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'rollup': rollup.toJson(),
        'stakers': stakers.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessage
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessageKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolSmartRollupAddress rollup;
  final OctezMempoolSmartRollupCommitmentHash cementedCommitment;
  final String outputProof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessage({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.rollup,
    required this.cementedCommitment,
    required this.outputProof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessage(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupExecuteOutboxMessageKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      rollup: OctezMempoolUnistring.fromJson(json['rollup']),
      cementedCommitment: OctezMempoolUnistring.fromJson(
        json['cemented_commitment'],
      ),
      outputProof:
          (json['output_proof'] is num
              ? json['output_proof'].toString()
              : json.valueAsString('output_proof')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'rollup': rollup.toJson(),
        'cemented_commitment': cementedCommitment.toJson(),
        'output_proof': outputProof,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBond
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBondKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolSmartRollupAddress rollup;
  final OctezMempoolSignaturePublicKeyHash staker;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBond({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.rollup,
    required this.staker,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBond.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBond(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRecoverBondKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      rollup: OctezMempoolUnistring.fromJson(json['rollup']),
      staker: OctezMempoolUnistring.fromJson(json['staker']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'rollup': rollup.toJson(),
        'staker': staker.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOrigination
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationKind
  kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final String publicParameters;
  final List<
    List<
      OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItem
    >
  >
  circuitsInfo;
  final List<String> initState;
  final int nbOps;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOrigination({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.publicParameters,
    required this.circuitsInfo,
    required this.initState,
    required this.nbOps,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOrigination.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOrigination(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      publicParameters:
          (json['public_parameters'] is num
              ? json['public_parameters'].toString()
              : json.valueAsString('public_parameters')),
      circuitsInfo:
          json
              .valueEnsureAsList<dynamic>('circuits_info')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) =>
                              OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupOriginationCircuitsInfoItemItem.fromJson(
                                e,
                              ),
                        )
                        .toList(),
              )
              .toList(),
      initState: json.valueAsList<List<String>>('init_state'),
      nbOps: json.valueAsInt('nb_ops'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'public_parameters': publicParameters,
        'circuits_info':
            circuitsInfo.map((e) => e.map((x) => x.toJson()).toList()).toList(),
        'init_state': initState,
        'nb_ops': nbOps,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublish
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishKind kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolZkRollupHash zkRollup;
  final List<
    List<
      OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItem
    >
  >
  op;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublish({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.zkRollup,
    required this.op,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublish.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublish(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      zkRollup: OctezMempoolUnistring.fromJson(json['zk_rollup']),
      op:
          json
              .valueEnsureAsList<dynamic>('op')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) =>
                              OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItem.fromJson(
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
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'zk_rollup': zkRollup.toJson(),
        'op': op.map((e) => e.map((x) => x.toJson()).toList()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdate
    extends OctezMempoolN025PsUshuaiOperationAlphaContents {
  final OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateKind kind;
  final OctezMempoolSignaturePublicKeyHash source;
  final OctezMempoolN025PsUshuaiMutez fee;
  final OctezMempoolPositiveBignum counter;
  final OctezMempoolPositiveBignum gasLimit;
  final OctezMempoolPositiveBignum storageLimit;
  final OctezMempoolZkRollupHash zkRollup;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdate
  update;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdate({
    required this.kind,
    required this.source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
    required this.zkRollup,
    required this.update,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdate(
      kind:
          OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateKind.fromJson(
            json['kind'],
          ),
      source: OctezMempoolUnistring.fromJson(json['source']),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString('fee')),
      counter:
          (json['counter'] is num
              ? json['counter'].toString()
              : json.valueAsString('counter')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString('gas_limit')),
      storageLimit:
          (json['storage_limit'] is num
              ? json['storage_limit'].toString()
              : json.valueAsString('storage_limit')),
      zkRollup: OctezMempoolUnistring.fromJson(json['zk_rollup']),
      update: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdate,
        Map<String, dynamic>
      >(
        key: 'update',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdate.fromJson(
                  v,
                ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'source': source.toJson(),
        'fee': fee,
        'counter': counter,
        'gas_limit': gasLimit,
        'storage_limit': storageLimit,
        'zk_rollup': zkRollup.toJson(),
        'update': update.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent {
  final int level;
  final int round;
  final OctezMempoolValueHash blockPayloadHash;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent({
    required this.level,
    required this.round,
    required this.blockPayloadHash,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateConsensusContent(
      level: json.valueAsInt('level'),
      round: json.valueAsInt('round'),
      blockPayloadHash: OctezMempoolUnistring.fromJson(
        json['block_payload_hash'],
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'level': level,
        'round': round,
        'block_payload_hash': blockPayloadHash.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateCommitteeItem {
  final int slot;
  final OctezMempoolBignum? dalAttestation;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateCommitteeItem({
    required this.slot,
    this.dalAttestation,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateCommitteeItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsAttestationsAggregateCommitteeItem(
      slot: json.valueAsInt('slot'),
      dalAttestation:
          (json['dal_attestation'] is num
              ? json['dal_attestation'].toString()
              : json.valueAsString('dal_attestation')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'slot': slot,
        'dal_attestation': dalAttestation,
      }.notNullValue.cast<String, dynamic>();
}

/// An operation's shell header.
class OctezMempoolN025PsUshuaiInlinedConsensusOperation {
  final OctezMempoolBlockHash branch;
  final OctezMempoolN025PsUshuaiInlinedConsensusOperationContents operations;
  final OctezMempoolSignatureV3? signature;

  const OctezMempoolN025PsUshuaiInlinedConsensusOperation({
    required this.branch,
    required this.operations,
    this.signature,
  });

  factory OctezMempoolN025PsUshuaiInlinedConsensusOperation.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiInlinedConsensusOperation(
      branch: OctezMempoolUnistring.fromJson(json['branch']),
      operations:
          OctezMempoolN025PsUshuaiInlinedConsensusOperationContents.fromJson(
            json['operations'],
          ),
      signature:
          json.hasValue('signature')
              ? OctezMempoolUnistring.fromJson(json['signature'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'branch': branch.toJson(),
        'operations': operations.toJson(),
        'signature': signature?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// Block header's shell-related content. It contains information such as the block level, its predecessor and timestamp.
class OctezMempoolN025PsUshuaiBlockHeaderAlphaFullHeader {
  final int level;
  final int proto;
  final OctezMempoolBlockHash predecessor;
  final OctezMempoolTimestampProtocol timestamp;
  final int validationPass;
  final OctezMempoolOperationListListHash operationsHash;
  final OctezMempoolFitness fitness;
  final OctezMempoolContextHash context;
  final OctezMempoolValueHash payloadHash;
  final int payloadRound;
  final String proofOfWorkNonce;
  final OctezMempoolCycleNonce? seedNonceHash;
  final OctezMempoolN025PsUshuaiLiquidityBakingVote liquidityBakingToggleVote;
  final OctezMempoolSignatureV3 signature;

  const OctezMempoolN025PsUshuaiBlockHeaderAlphaFullHeader({
    required this.level,
    required this.proto,
    required this.predecessor,
    required this.timestamp,
    required this.validationPass,
    required this.operationsHash,
    required this.fitness,
    required this.context,
    required this.payloadHash,
    required this.payloadRound,
    required this.proofOfWorkNonce,
    this.seedNonceHash,
    required this.liquidityBakingToggleVote,
    required this.signature,
  });

  factory OctezMempoolN025PsUshuaiBlockHeaderAlphaFullHeader.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiBlockHeaderAlphaFullHeader(
      level: json.valueAsInt('level'),
      proto: json.valueAsInt('proto'),
      predecessor: OctezMempoolUnistring.fromJson(json['predecessor']),
      timestamp: OctezMempoolUnistring.fromJson(json['timestamp']),
      validationPass: json.valueAsInt('validation_pass'),
      operationsHash: OctezMempoolUnistring.fromJson(json['operations_hash']),
      fitness: json.valueAsList<List<String>>('fitness'),
      context: OctezMempoolUnistring.fromJson(json['context']),
      payloadHash: OctezMempoolUnistring.fromJson(json['payload_hash']),
      payloadRound: json.valueAsInt('payload_round'),
      proofOfWorkNonce:
          (json['proof_of_work_nonce'] is num
              ? json['proof_of_work_nonce'].toString()
              : json.valueAsString('proof_of_work_nonce')),
      seedNonceHash:
          json.hasValue('seed_nonce_hash')
              ? OctezMempoolUnistring.fromJson(json['seed_nonce_hash'])
              : null,
      liquidityBakingToggleVote:
          OctezMempoolN025PsUshuaiLiquidityBakingVote.fromJson(
            json['liquidity_baking_toggle_vote'],
          ),
      signature: OctezMempoolUnistring.fromJson(json['signature']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'level': level,
        'proto': proto,
        'predecessor': predecessor.toJson(),
        'timestamp': timestamp.toJson(),
        'validation_pass': validationPass,
        'operations_hash': operationsHash.toJson(),
        'fitness': fitness,
        'context': context.toJson(),
        'payload_hash': payloadHash.toJson(),
        'payload_round': payloadRound,
        'proof_of_work_nonce': proofOfWorkNonce,
        'seed_nonce_hash': seedNonceHash?.toJson(),
        'liquidity_baking_toggle_vote': liquidityBakingToggleVote.toJson(),
        'signature': signature.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProof {
  final List<
    OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItem
  >
  shard;
  final OctezMempoolDalCommitment proof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProof({
    required this.shard,
    required this.proof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProof(
      shard:
          json
              .valueEnsureAsList<dynamic>('shard')
              .map(
                (e) =>
                    OctezMempoolN025PsUshuaiOperationAlphaContentsDalEntrapmentEvidenceShardWithProofShardItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      proof: OctezMempoolUnistring.fromJson(json['proof']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'shard': shard.map((e) => e.toJson()).toList(),
        'proof': proof.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionParameters {
  final OctezMempoolN025PsUshuaiEntrypoint entrypoint;

  final dynamic value;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionParameters({
    required this.entrypoint,
    required this.value,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionParameters.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsTransactionParameters(
      entrypoint: OctezMempoolN025PsUshuaiEntrypoint.fromJson(
        json['entrypoint'],
      ),
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'entrypoint': entrypoint.toJson(),
        'value': value,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiScriptedContracts {
  final dynamic code;

  final dynamic storage;

  const OctezMempoolN025PsUshuaiScriptedContracts({
    required this.code,
    required this.storage,
  });

  factory OctezMempoolN025PsUshuaiScriptedContracts.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiScriptedContracts(
      code: json['code'],
      storage: json['storage'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'code': code, 'storage': storage}.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentSlotHeader {
  final int slotIndex;
  final OctezMempoolDalCommitment commitment;
  final String commitmentProof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentSlotHeader({
    required this.slotIndex,
    required this.commitment,
    required this.commitmentProof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentSlotHeader.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsDalPublishCommitmentSlotHeader(
      slotIndex: json.valueAsInt('slot_index'),
      commitment: OctezMempoolUnistring.fromJson(json['commitment']),
      commitmentProof:
          (json['commitment_proof'] is num
              ? json['commitment_proof'].toString()
              : json.valueAsString('commitment_proof')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'slot_index': slotIndex,
        'commitment': commitment.toJson(),
        'commitment_proof': commitmentProof,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishCommitment {
  final OctezMempoolSmartRollupStateHash compressedState;
  final int inboxLevel;
  final OctezMempoolSmartRollupCommitmentHash predecessor;
  final OctezMempoolInt64 numberOfTicks;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishCommitment({
    required this.compressedState,
    required this.inboxLevel,
    required this.predecessor,
    required this.numberOfTicks,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishCommitment.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupPublishCommitment(
      compressedState: OctezMempoolUnistring.fromJson(json['compressed_state']),
      inboxLevel: json.valueAsInt('inbox_level'),
      predecessor: OctezMempoolUnistring.fromJson(json['predecessor']),
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

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepDissectionItem {
  final OctezMempoolSmartRollupStateHash? state;
  final OctezMempoolPositiveBignum tick;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepDissectionItem({
    this.state,
    required this.tick,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepDissectionItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepDissectionItem(
      state:
          json.hasValue('state')
              ? OctezMempoolUnistring.fromJson(json['state'])
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

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofDalPageId {
  final int publishedLevel;
  final int slotIndex;
  final int pageIndex;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofDalPageId({
    required this.publishedLevel,
    required this.slotIndex,
    required this.pageIndex,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofDalPageId.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupRefuteRefutationMoveStepProofInputProofRevealProofRevealProofDalPageProofDalPageId(
      publishedLevel: json.valueAsInt('published_level'),
      slotIndex: json.valueAsInt('slot_index'),
      pageIndex: json.valueAsInt('page_index'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'published_level': publishedLevel,
        'slot_index': slotIndex,
        'page_index': pageIndex,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutStakers {
  final OctezMempoolSignaturePublicKeyHash alice;
  final OctezMempoolSignaturePublicKeyHash bob;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutStakers({
    required this.alice,
    required this.bob,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutStakers.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsSmartRollupTimeoutStakers(
      alice: OctezMempoolUnistring.fromJson(json['alice']),
      bob: OctezMempoolUnistring.fromJson(json['bob']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'alice': alice.toJson(),
        'bob': bob.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayloadPrice {
  final OctezMempoolScriptExpr id;
  final OctezMempoolBignum amount;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayloadPrice({
    required this.id,
    required this.amount,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayloadPrice.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupPublishOpItemItemOpCodePriceL1DstRollupIdPayloadPrice(
      id: OctezMempoolUnistring.fromJson(json['id']),
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString('amount')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id.toJson(),
        'amount': amount,
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdateFeePi {
  final List<String> newState;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdateFeePi({
    required this.newState,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdateFeePi.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdateFeePi(
      newState: json.valueAsList<List<String>>('new_state'),
    );
  }

  Map<String, dynamic> toJson() =>
      {'new_state': newState}.notNullValue.cast<String, dynamic>();
}

class OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdate {
  final List<
    List<
      OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItem
    >
  >
  pendingPis;
  final List<
    List<
      OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItem
    >
  >
  privatePis;
  final OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdateFeePi
  feePi;
  final String proof;

  const OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdate({
    required this.pendingPis,
    required this.privatePis,
    required this.feePi,
    required this.proof,
  });

  factory OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdate.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdate(
      pendingPis:
          json
              .valueEnsureAsList<dynamic>('pending_pis')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) =>
                              OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePendingPisItemItem.fromJson(
                                e,
                              ),
                        )
                        .toList(),
              )
              .toList(),
      privatePis:
          json
              .valueEnsureAsList<dynamic>('private_pis')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) =>
                              OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdatePrivatePisItemItem.fromJson(
                                e,
                              ),
                        )
                        .toList(),
              )
              .toList(),
      feePi: json.valueTo<
        OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdateFeePi,
        Map<String, dynamic>
      >(
        key: 'fee_pi',
        parse:
            (v) =>
                OctezMempoolN025PsUshuaiOperationAlphaContentsZkRollupUpdateUpdateFeePi.fromJson(
                  v,
                ),
      ),
      proof:
          (json['proof'] is num
              ? json['proof'].toString()
              : json.valueAsString('proof')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'pending_pis':
            pendingPis.map((e) => e.map((x) => x.toJson()).toList()).toList(),
        'private_pis':
            privatePis.map((e) => e.map((x) => x.toJson()).toList()).toList(),
        'fee_pi': feePi.toJson(),
        'proof': proof,
      }.notNullValue.cast<String, dynamic>();
}

/// An operation's shell header.
class OctezMempoolResponseMonitorOperationsItem {
  final OctezMempoolOperationHash hash;
  final OctezMempoolProtocolHash protocol;
  final OctezMempoolBlockHash branch;
  final List<OctezMempoolN025PsUshuaiOperationAlphaContents> contents;
  final OctezMempoolSignatureV3? signature;
  final OctezMempoolErrorOpt? error;

  const OctezMempoolResponseMonitorOperationsItem({
    required this.hash,
    required this.protocol,
    required this.branch,
    required this.contents,
    this.signature,
    this.error,
  });

  factory OctezMempoolResponseMonitorOperationsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolResponseMonitorOperationsItem(
      hash: OctezMempoolUnistring.fromJson(json['hash']),
      protocol: OctezMempoolProtocolHash.fromJson(json['protocol']),
      branch: OctezMempoolUnistring.fromJson(json['branch']),
      contents:
          json
              .valueEnsureAsList<dynamic>('contents')
              .map(
                (e) =>
                    OctezMempoolN025PsUshuaiOperationAlphaContents.fromJson(e),
              )
              .toList(),
      signature:
          json.hasValue('signature')
              ? OctezMempoolUnistring.fromJson(json['signature'])
              : null,
      error:
          json.hasValue('error')
              ? Map<String, dynamic>.from(json['error'] as Map)
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'hash': hash.toJson(),
        'protocol': protocol.toJson(),
        'branch': branch.toJson(),
        'contents': contents.map((e) => e.toJson()).toList(),
        'signature': signature?.toJson(),
        'error': error,
      }.notNullValue.cast<String, dynamic>();
}

/// An operation's shell header.
class OctezMempoolResponsePendingOperationsValidatedItem {
  final OctezMempoolOperationHash hash;
  final OctezMempoolBlockHash branch;
  final List<OctezMempoolN025PsUshuaiOperationAlphaContents> contents;
  final OctezMempoolSignatureV3? signature;

  const OctezMempoolResponsePendingOperationsValidatedItem({
    required this.hash,
    required this.branch,
    required this.contents,
    this.signature,
  });

  factory OctezMempoolResponsePendingOperationsValidatedItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolResponsePendingOperationsValidatedItem(
      hash: OctezMempoolUnistring.fromJson(json['hash']),
      branch: OctezMempoolUnistring.fromJson(json['branch']),
      contents:
          json
              .valueEnsureAsList<dynamic>('contents')
              .map(
                (e) =>
                    OctezMempoolN025PsUshuaiOperationAlphaContents.fromJson(e),
              )
              .toList(),
      signature:
          json.hasValue('signature')
              ? OctezMempoolUnistring.fromJson(json['signature'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'hash': hash.toJson(),
        'branch': branch.toJson(),
        'contents': contents.map((e) => e.toJson()).toList(),
        'signature': signature?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// An operation's shell header.
class OctezMempoolResponsePendingOperationsRefusedItem {
  final OctezMempoolOperationHash hash;
  final OctezMempoolProtocolHash protocol;
  final OctezMempoolBlockHash branch;
  final List<OctezMempoolN025PsUshuaiOperationAlphaContents> contents;
  final OctezMempoolSignatureV3? signature;
  final OctezMempoolError error;

  const OctezMempoolResponsePendingOperationsRefusedItem({
    required this.hash,
    required this.protocol,
    required this.branch,
    required this.contents,
    this.signature,
    required this.error,
  });

  factory OctezMempoolResponsePendingOperationsRefusedItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolResponsePendingOperationsRefusedItem(
      hash: OctezMempoolUnistring.fromJson(json['hash']),
      protocol: OctezMempoolProtocolHash.fromJson(json['protocol']),
      branch: OctezMempoolUnistring.fromJson(json['branch']),
      contents:
          json
              .valueEnsureAsList<dynamic>('contents')
              .map(
                (e) =>
                    OctezMempoolN025PsUshuaiOperationAlphaContents.fromJson(e),
              )
              .toList(),
      signature:
          json.hasValue('signature')
              ? OctezMempoolUnistring.fromJson(json['signature'])
              : null,
      error: Map<String, dynamic>.from(json['error'] as Map),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'hash': hash.toJson(),
        'protocol': protocol.toJson(),
        'branch': branch.toJson(),
        'contents': contents.map((e) => e.toJson()).toList(),
        'signature': signature?.toJson(),
        'error': error,
      }.notNullValue.cast<String, dynamic>();
}

/// An operation's shell header.
class OctezMempoolResponsePendingOperationsUnprocessedItem {
  final OctezMempoolOperationHash hash;
  final OctezMempoolProtocolHash protocol;
  final OctezMempoolBlockHash branch;
  final List<OctezMempoolN025PsUshuaiOperationAlphaContents> contents;
  final OctezMempoolSignatureV3? signature;

  const OctezMempoolResponsePendingOperationsUnprocessedItem({
    required this.hash,
    required this.protocol,
    required this.branch,
    required this.contents,
    this.signature,
  });

  factory OctezMempoolResponsePendingOperationsUnprocessedItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolResponsePendingOperationsUnprocessedItem(
      hash: OctezMempoolUnistring.fromJson(json['hash']),
      protocol: OctezMempoolProtocolHash.fromJson(json['protocol']),
      branch: OctezMempoolUnistring.fromJson(json['branch']),
      contents:
          json
              .valueEnsureAsList<dynamic>('contents')
              .map(
                (e) =>
                    OctezMempoolN025PsUshuaiOperationAlphaContents.fromJson(e),
              )
              .toList(),
      signature:
          json.hasValue('signature')
              ? OctezMempoolUnistring.fromJson(json['signature'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'hash': hash.toJson(),
        'protocol': protocol.toJson(),
        'branch': branch.toJson(),
        'contents': contents.map((e) => e.toJson()).toList(),
        'signature': signature?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolResponsePendingOperations {
  final List<OctezMempoolResponsePendingOperationsValidatedItem> validated;
  final List<OctezMempoolResponsePendingOperationsRefusedItem> refused;
  final List<OctezMempoolResponsePendingOperationsRefusedItem> outdated;
  final List<OctezMempoolResponsePendingOperationsRefusedItem> branchRefused;
  final List<OctezMempoolResponsePendingOperationsRefusedItem> branchDelayed;
  final List<OctezMempoolResponsePendingOperationsUnprocessedItem> unprocessed;

  const OctezMempoolResponsePendingOperations({
    required this.validated,
    required this.refused,
    required this.outdated,
    required this.branchRefused,
    required this.branchDelayed,
    required this.unprocessed,
  });

  factory OctezMempoolResponsePendingOperations.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezMempoolResponsePendingOperations(
      validated:
          json
              .valueEnsureAsList<Map<String, dynamic>>('validated')
              .map(
                (e) =>
                    OctezMempoolResponsePendingOperationsValidatedItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      refused:
          json
              .valueEnsureAsList<Map<String, dynamic>>('refused')
              .map(
                (e) =>
                    OctezMempoolResponsePendingOperationsRefusedItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      outdated:
          json
              .valueEnsureAsList<Map<String, dynamic>>('outdated')
              .map(
                (e) =>
                    OctezMempoolResponsePendingOperationsRefusedItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      branchRefused:
          json
              .valueEnsureAsList<Map<String, dynamic>>('branch_refused')
              .map(
                (e) =>
                    OctezMempoolResponsePendingOperationsRefusedItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      branchDelayed:
          json
              .valueEnsureAsList<Map<String, dynamic>>('branch_delayed')
              .map(
                (e) =>
                    OctezMempoolResponsePendingOperationsRefusedItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      unprocessed:
          json
              .valueEnsureAsList<Map<String, dynamic>>('unprocessed')
              .map(
                (e) =>
                    OctezMempoolResponsePendingOperationsUnprocessedItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'validated': validated.map((e) => e.toJson()).toList(),
        'refused': refused.map((e) => e.toJson()).toList(),
        'outdated': outdated.map((e) => e.toJson()).toList(),
        'branch_refused': branchRefused.map((e) => e.toJson()).toList(),
        'branch_delayed': branchDelayed.map((e) => e.toJson()).toList(),
        'unprocessed': unprocessed.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezMempoolResponseRequestOperations {
  const OctezMempoolResponseRequestOperations();

  factory OctezMempoolResponseRequestOperations.fromJson(
    Map<String, dynamic> json,
  ) {
    return const OctezMempoolResponseRequestOperations();
  }

  Map<String, dynamic> toJson() => {}.notNullValue.cast<String, dynamic>();
}

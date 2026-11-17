// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid type alias `UserNumber`.
typedef NnsInternetIdentityUserNumber = BigInt;

/// Candid type alias `AccountNumber`.
typedef NnsInternetIdentityAccountNumber = BigInt;

/// Candid type alias `PublicKey`.
typedef NnsInternetIdentityPublicKey = List<int>;

/// Candid type alias `CredentialId`.
typedef NnsInternetIdentityCredentialId = List<int>;

/// Candid type alias `Aaguid`.
typedef NnsInternetIdentityAaguid = List<int>;

/// Candid type alias `DeviceKey`.
typedef NnsInternetIdentityDeviceKey = NnsInternetIdentityPublicKey;

/// Candid type alias `UserKey`.
typedef NnsInternetIdentityUserKey = NnsInternetIdentityPublicKey;

/// Candid type alias `SessionKey`.
typedef NnsInternetIdentitySessionKey = NnsInternetIdentityPublicKey;

/// Candid type alias `FrontendHostname`.
typedef NnsInternetIdentityFrontendHostname = String;

/// Candid type alias `Timestamp`.
typedef NnsInternetIdentityTimestamp = BigInt;

/// Candid type alias `MetadataMap`.
typedef NnsInternetIdentityMetadataMap =
    List<NnsInternetIdentityMetadataMapItem>;

/// CType for alias `MetadataMap`.
abstract final class NnsInternetIdentityMetadataMapCandid {
  static CType get ctype => CType.vec(NnsInternetIdentityMetadataMapItem.ctype);
}

/// Candid type alias `ChallengeKey`.
typedef NnsInternetIdentityChallengeKey = String;

/// Candid type alias `CaptchaResult`.
typedef NnsInternetIdentityCaptchaResult = NnsInternetIdentityChallengeResult;

/// CType for alias `CaptchaResult`.
abstract final class NnsInternetIdentityCaptchaResultCandid {
  static CType get ctype => NnsInternetIdentityChallengeResult.ctype;
}

/// Candid type alias `Iss`.
typedef NnsInternetIdentityIss = String;

/// Candid type alias `Sub`.
typedef NnsInternetIdentitySub = String;

/// Candid type alias `Aud`.
typedef NnsInternetIdentityAud = String;

/// Candid type alias `JWT`.
typedef NnsInternetIdentityJWT = String;

/// Candid type alias `Salt`.
typedef NnsInternetIdentitySalt = List<int>;

/// Candid type alias `IdentityNumber`.
typedef NnsInternetIdentityIdentityNumber = BigInt;

/// Candid type alias `MetadataMapV2`.
typedef NnsInternetIdentityMetadataMapV2 =
    List<NnsInternetIdentityMetadataMapV2Item>;

/// CType for alias `MetadataMapV2`.
abstract final class NnsInternetIdentityMetadataMapV2Candid {
  static CType get ctype =>
      CType.vec(NnsInternetIdentityMetadataMapV2Item.ctype);
}

/// Candid type alias `RegistrationId`.
typedef NnsInternetIdentityRegistrationId = String;

/// Candid type alias `ListAvailableAttributesResponse`.
typedef NnsInternetIdentityListAvailableAttributesResponse =
    List<NnsInternetIdentityPrepareAttributeResponseAttributes>;

/// CType for alias `ListAvailableAttributesResponse`.
abstract final class NnsInternetIdentityListAvailableAttributesResponseCandid {
  static CType get ctype =>
      CType.vec(NnsInternetIdentityPrepareAttributeResponseAttributes.ctype);
}

/// Candid record `NnsInternetIdentityMetadataMap.item`.
final class NnsInternetIdentityMetadataMapItem with CandidSerializable {
  final String field0;
  final NnsInternetIdentityMetadataMapItem1 field1;

  const NnsInternetIdentityMetadataMapItem({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => NnsInternetIdentityMetadataMapItem1.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory NnsInternetIdentityMetadataMapItem.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityMetadataMapItem(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<NnsInternetIdentityMetadataMapItem1, Map>(
        key: '1',
        parse:
            (e) => NnsInternetIdentityMetadataMapItem1.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentityMetadataMapItem.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMetadataMapItem.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `NnsInternetIdentityMetadataMapItem.1`.
sealed class NnsInternetIdentityMetadataMapItem1 with CandidSerializable {
  const NnsInternetIdentityMetadataMapItem1();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('map'),
      () => NnsInternetIdentityMetadataMapCandid.ctype,
    ),
    Field(Label.named('string'), CType.text),
    Field(Label.named('bytes'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityMetadataMapItem1.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('map')) {
      return NnsInternetIdentityMetadataMapItem1Map(
        json.valueTo<List<NnsInternetIdentityMetadataMapItem>, List>(
          key: 'map',
          parse:
              (e) =>
                  e
                      .map<NnsInternetIdentityMetadataMapItem>(
                        (x) => NnsInternetIdentityMetadataMapItem.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('string')) {
      return NnsInternetIdentityMetadataMapItem1String(
        json.valueAsString<String>('string'),
      );
    }
    if (json.containsKey('bytes')) {
      return NnsInternetIdentityMetadataMapItem1Bytes(
        json.valueAsBytes<List<int>>('bytes', encoding: StringEncoding.base64),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityMetadataMapItem1.fromCandid',
      reason: 'Unknown NnsInternetIdentityMetadataMapItem1 arm',
    );
  }

  factory NnsInternetIdentityMetadataMapItem1.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMetadataMapItem1.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityMetadataMapItem.1.map`.
final class NnsInternetIdentityMetadataMapItem1Map
    extends NnsInternetIdentityMetadataMapItem1 {
  final NnsInternetIdentityMetadataMap value;
  const NnsInternetIdentityMetadataMapItem1Map(this.value);

  @override
  CType get candidType => NnsInternetIdentityMetadataMapItem1.ctype;

  @override
  dynamic get candidValue =>
      Variant('map', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'map': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `NnsInternetIdentityMetadataMapItem.1.string`.
final class NnsInternetIdentityMetadataMapItem1String
    extends NnsInternetIdentityMetadataMapItem1 {
  final String value;
  const NnsInternetIdentityMetadataMapItem1String(this.value);

  @override
  CType get candidType => NnsInternetIdentityMetadataMapItem1.ctype;

  @override
  dynamic get candidValue => Variant('string', value);

  @override
  Map<String, dynamic> toJson() => {'string': value};
}

/// Variant arm `NnsInternetIdentityMetadataMapItem.1.bytes`.
final class NnsInternetIdentityMetadataMapItem1Bytes
    extends NnsInternetIdentityMetadataMapItem1 {
  final List<int> value;
  const NnsInternetIdentityMetadataMapItem1Bytes(this.value);

  @override
  CType get candidType => NnsInternetIdentityMetadataMapItem1.ctype;

  @override
  dynamic get candidValue => Variant('bytes', value);

  @override
  Map<String, dynamic> toJson() => {'bytes': value};
}

/// Candid record `NnsInternetIdentityInternetIdentityStats.assigned_user_number_range`.
final class NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange
    with CandidSerializable {
  final BigInt field0;
  final BigInt field1;

  const NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.nat64),
    Field(Label.id(1), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1};

  factory NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange(
      field0: json.valueAsBigInt<BigInt>('0'),
      field1: json.valueAsBigInt<BigInt>('1'),
    );
  }

  factory NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsInternetIdentityInternetIdentityStats.event_aggregations`.
final class NnsInternetIdentityInternetIdentityStatsEventAggregations
    with CandidSerializable {
  final String field0;
  final List<NnsInternetIdentityInternetIdentityStatsEventAggregations1> field1;

  const NnsInternetIdentityInternetIdentityStatsEventAggregations({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(
      Label.id(1),
      () => CType.vec(
        NnsInternetIdentityInternetIdentityStatsEventAggregations1.ctype,
      ),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    '0': field0,
    '1': field1.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    '0': field0,
    '1': field1.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityInternetIdentityStatsEventAggregations.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityInternetIdentityStatsEventAggregations(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<
        List<NnsInternetIdentityInternetIdentityStatsEventAggregations1>,
        List
      >(
        key: '1',
        parse:
            (e) =>
                e
                    .map<
                      NnsInternetIdentityInternetIdentityStatsEventAggregations1
                    >(
                      (x) =>
                          NnsInternetIdentityInternetIdentityStatsEventAggregations1.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityInternetIdentityStatsEventAggregations.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityInternetIdentityStatsEventAggregations.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsInternetIdentityInternetIdentityStatsEventAggregations.1`.
final class NnsInternetIdentityInternetIdentityStatsEventAggregations1
    with CandidSerializable {
  final String field0;
  final BigInt field1;

  const NnsInternetIdentityInternetIdentityStatsEventAggregations1({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    Field(Label.id(1), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1};

  factory NnsInternetIdentityInternetIdentityStatsEventAggregations1.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityInternetIdentityStatsEventAggregations1(
      field0: json.valueAsString<String>('0'),
      field1: json.valueAsBigInt<BigInt>('1'),
    );
  }

  factory NnsInternetIdentityInternetIdentityStatsEventAggregations1.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityInternetIdentityStatsEventAggregations1.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `NnsInternetIdentityCaptchaConfig.captcha_trigger`.
sealed class NnsInternetIdentityCaptchaConfigCaptchaTrigger
    with CandidSerializable {
  const NnsInternetIdentityCaptchaConfigCaptchaTrigger();

  static CType get ctype => CType.variant([
    Field(
      Label.named('Dynamic'),
      CType.record([
        Field(Label.named('threshold_pct'), CType.nat16),
        Field(Label.named('current_rate_sampling_interval_s'), CType.nat64),
        Field(Label.named('reference_rate_sampling_interval_s'), CType.nat64),
      ]),
    ),
    LazyField(
      Label.named('Static'),
      () => NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityCaptchaConfigCaptchaTrigger.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Dynamic')) {
      return NnsInternetIdentityCaptchaConfigCaptchaTriggerDynamic.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Dynamic']),
      );
    }
    if (json.containsKey('Static')) {
      return NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic2(
        json.valueTo<NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic, Map>(
          key: 'Static',
          parse:
              (e) =>
                  NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic.fromCandid(
                    JsonParser.valueEnsureAsMap<String, dynamic>(e),
                  ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityCaptchaConfigCaptchaTrigger.fromCandid',
      reason: 'Unknown NnsInternetIdentityCaptchaConfigCaptchaTrigger arm',
    );
  }

  factory NnsInternetIdentityCaptchaConfigCaptchaTrigger.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityCaptchaConfigCaptchaTrigger.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityCaptchaConfig.captcha_trigger.Dynamic`.
final class NnsInternetIdentityCaptchaConfigCaptchaTriggerDynamic
    extends NnsInternetIdentityCaptchaConfigCaptchaTrigger {
  final int thresholdPct;
  final BigInt currentRateSamplingIntervalS;
  final BigInt referenceRateSamplingIntervalS;

  const NnsInternetIdentityCaptchaConfigCaptchaTriggerDynamic({
    required this.thresholdPct,
    required this.currentRateSamplingIntervalS,
    required this.referenceRateSamplingIntervalS,
  });

  @override
  CType get candidType => NnsInternetIdentityCaptchaConfigCaptchaTrigger.ctype;

  @override
  dynamic get candidValue => Variant('Dynamic', {
    'threshold_pct': thresholdPct,
    'current_rate_sampling_interval_s': currentRateSamplingIntervalS,
    'reference_rate_sampling_interval_s': referenceRateSamplingIntervalS,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Dynamic': {
      'threshold_pct': thresholdPct,
      'current_rate_sampling_interval_s': currentRateSamplingIntervalS,
      'reference_rate_sampling_interval_s': referenceRateSamplingIntervalS,
    },
  };

  factory NnsInternetIdentityCaptchaConfigCaptchaTriggerDynamic.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityCaptchaConfigCaptchaTriggerDynamic(
      thresholdPct: json.valueAsInt<int>('threshold_pct'),
      currentRateSamplingIntervalS: json.valueAsBigInt<BigInt>(
        'current_rate_sampling_interval_s',
      ),
      referenceRateSamplingIntervalS: json.valueAsBigInt<BigInt>(
        'reference_rate_sampling_interval_s',
      ),
    );
  }
}

/// Variant arm `NnsInternetIdentityCaptchaConfig.captcha_trigger.Static`.
final class NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic2
    extends NnsInternetIdentityCaptchaConfigCaptchaTrigger {
  final NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic value;
  const NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic2(this.value);

  @override
  CType get candidType => NnsInternetIdentityCaptchaConfigCaptchaTrigger.ctype;

  @override
  dynamic get candidValue => Variant('Static', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Static': value.toJson()};
}

/// Candid variant `NnsInternetIdentityCaptchaConfigCaptchaTrigger.Static`.
sealed class NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic
    with CandidSerializable {
  const NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic();

  static CType get ctype => CType.variant([
    Field(Label.named('CaptchaEnabled'), CType.null_),
    Field(Label.named('CaptchaDisabled'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('CaptchaEnabled')) {
      return const NnsInternetIdentityCaptchaConfigCaptchaTriggerStaticCaptchaEnabled();
    }
    if (json.containsKey('CaptchaDisabled')) {
      return const NnsInternetIdentityCaptchaConfigCaptchaTriggerStaticCaptchaDisabled();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic.fromCandid',
      reason:
          'Unknown NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic arm',
    );
  }

  factory NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityCaptchaConfigCaptchaTrigger.Static.CaptchaEnabled` (nullary).
final class NnsInternetIdentityCaptchaConfigCaptchaTriggerStaticCaptchaEnabled
    extends NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic {
  const NnsInternetIdentityCaptchaConfigCaptchaTriggerStaticCaptchaEnabled();

  @override
  CType get candidType =>
      NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic.ctype;

  @override
  dynamic get candidValue => const Variant('CaptchaEnabled', null);

  @override
  Map<String, dynamic> toJson() => {'CaptchaEnabled': null};
}

/// Variant arm `NnsInternetIdentityCaptchaConfigCaptchaTrigger.Static.CaptchaDisabled` (nullary).
final class NnsInternetIdentityCaptchaConfigCaptchaTriggerStaticCaptchaDisabled
    extends NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic {
  const NnsInternetIdentityCaptchaConfigCaptchaTriggerStaticCaptchaDisabled();

  @override
  CType get candidType =>
      NnsInternetIdentityCaptchaConfigCaptchaTriggerStatic.ctype;

  @override
  dynamic get candidValue => const Variant('CaptchaDisabled', null);

  @override
  Map<String, dynamic> toJson() => {'CaptchaDisabled': null};
}

/// Candid record `NnsInternetIdentityOpenIdConfig.seed_jwks`.
final class NnsInternetIdentityOpenIdConfigSeedJwks with CandidSerializable {
  final String field0;
  final String field1;

  const NnsInternetIdentityOpenIdConfigSeedJwks({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    Field(Label.id(1), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1};

  factory NnsInternetIdentityOpenIdConfigSeedJwks.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityOpenIdConfigSeedJwks(
      field0: json.valueAsString<String>('0'),
      field1: json.valueAsString<String>('1'),
    );
  }

  factory NnsInternetIdentityOpenIdConfigSeedJwks.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenIdConfigSeedJwks.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsInternetIdentityMetadataMapV2.item`.
final class NnsInternetIdentityMetadataMapV2Item with CandidSerializable {
  final String field0;
  final NnsInternetIdentityMetadataMapV2Item1 field1;

  const NnsInternetIdentityMetadataMapV2Item({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => NnsInternetIdentityMetadataMapV2Item1.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory NnsInternetIdentityMetadataMapV2Item.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityMetadataMapV2Item(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<NnsInternetIdentityMetadataMapV2Item1, Map>(
        key: '1',
        parse:
            (e) => NnsInternetIdentityMetadataMapV2Item1.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentityMetadataMapV2Item.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMetadataMapV2Item.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `NnsInternetIdentityMetadataMapV2Item.1`.
sealed class NnsInternetIdentityMetadataMapV2Item1 with CandidSerializable {
  const NnsInternetIdentityMetadataMapV2Item1();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Map'),
      () => NnsInternetIdentityMetadataMapV2Candid.ctype,
    ),
    Field(Label.named('String'), CType.text),
    Field(Label.named('Bytes'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityMetadataMapV2Item1.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Map')) {
      return NnsInternetIdentityMetadataMapV2Item1Map(
        json.valueTo<List<NnsInternetIdentityMetadataMapV2Item>, List>(
          key: 'Map',
          parse:
              (e) =>
                  e
                      .map<NnsInternetIdentityMetadataMapV2Item>(
                        (x) => NnsInternetIdentityMetadataMapV2Item.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('String')) {
      return NnsInternetIdentityMetadataMapV2Item1String(
        json.valueAsString<String>('String'),
      );
    }
    if (json.containsKey('Bytes')) {
      return NnsInternetIdentityMetadataMapV2Item1Bytes(
        json.valueAsBytes<List<int>>('Bytes', encoding: StringEncoding.base64),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityMetadataMapV2Item1.fromCandid',
      reason: 'Unknown NnsInternetIdentityMetadataMapV2Item1 arm',
    );
  }

  factory NnsInternetIdentityMetadataMapV2Item1.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMetadataMapV2Item1.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityMetadataMapV2Item.1.Map`.
final class NnsInternetIdentityMetadataMapV2Item1Map
    extends NnsInternetIdentityMetadataMapV2Item1 {
  final NnsInternetIdentityMetadataMapV2 value;
  const NnsInternetIdentityMetadataMapV2Item1Map(this.value);

  @override
  CType get candidType => NnsInternetIdentityMetadataMapV2Item1.ctype;

  @override
  dynamic get candidValue =>
      Variant('Map', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Map': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `NnsInternetIdentityMetadataMapV2Item.1.String`.
final class NnsInternetIdentityMetadataMapV2Item1String
    extends NnsInternetIdentityMetadataMapV2Item1 {
  final String value;
  const NnsInternetIdentityMetadataMapV2Item1String(this.value);

  @override
  CType get candidType => NnsInternetIdentityMetadataMapV2Item1.ctype;

  @override
  dynamic get candidValue => Variant('String', value);

  @override
  Map<String, dynamic> toJson() => {'String': value};
}

/// Variant arm `NnsInternetIdentityMetadataMapV2Item.1.Bytes`.
final class NnsInternetIdentityMetadataMapV2Item1Bytes
    extends NnsInternetIdentityMetadataMapV2Item1 {
  final List<int> value;
  const NnsInternetIdentityMetadataMapV2Item1Bytes(this.value);

  @override
  CType get candidType => NnsInternetIdentityMetadataMapV2Item1.ctype;

  @override
  dynamic get candidValue => Variant('Bytes', value);

  @override
  Map<String, dynamic> toJson() => {'Bytes': value};
}

/// Candid record `NnsInternetIdentityPrepareAttributeResponse.attributes`.
final class NnsInternetIdentityPrepareAttributeResponseAttributes
    with CandidSerializable {
  final String field0;
  final List<int> field1;

  const NnsInternetIdentityPrepareAttributeResponseAttributes({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    Field(Label.id(1), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1};

  factory NnsInternetIdentityPrepareAttributeResponseAttributes.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareAttributeResponseAttributes(
      field0: json.valueAsString<String>('0'),
      field1: json.valueAsBytes<List<int>>(
        '1',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityPrepareAttributeResponseAttributes.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareAttributeResponseAttributes.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsInternetIdentityIcrc3Value.Map`.
final class NnsInternetIdentityIcrc3ValueMap with CandidSerializable {
  final String field0;
  final NnsInternetIdentityIcrc3Value field1;

  const NnsInternetIdentityIcrc3ValueMap({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => NnsInternetIdentityIcrc3Value.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory NnsInternetIdentityIcrc3ValueMap.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIcrc3ValueMap(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<NnsInternetIdentityIcrc3Value, Map>(
        key: '1',
        parse:
            (e) => NnsInternetIdentityIcrc3Value.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentityIcrc3ValueMap.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIcrc3ValueMap.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `NnsInternetIdentityIdentityRegistrationStart.response`.
sealed class NnsInternetIdentityIdentityRegistrationStartResponse
    with CandidSerializable {
  const NnsInternetIdentityIdentityRegistrationStartResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityIdRegNextStepResult.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityIdRegStartError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdentityRegistrationStartResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityIdentityRegistrationStartResponseOk(
        json.valueTo<NnsInternetIdentityIdRegNextStepResult, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityIdRegNextStepResult.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityIdentityRegistrationStartResponseErr(
        json.valueTo<NnsInternetIdentityIdRegStartError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityIdRegStartError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdentityRegistrationStartResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityIdentityRegistrationStartResponse arm',
    );
  }

  factory NnsInternetIdentityIdentityRegistrationStartResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityRegistrationStartResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityIdentityRegistrationStart.response.Ok`.
final class NnsInternetIdentityIdentityRegistrationStartResponseOk
    extends NnsInternetIdentityIdentityRegistrationStartResponse {
  final NnsInternetIdentityIdRegNextStepResult value;
  const NnsInternetIdentityIdentityRegistrationStartResponseOk(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityRegistrationStartResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityIdentityRegistrationStart.response.Err`.
final class NnsInternetIdentityIdentityRegistrationStartResponseErr
    extends NnsInternetIdentityIdentityRegistrationStartResponse {
  final NnsInternetIdentityIdRegStartError value;
  const NnsInternetIdentityIdentityRegistrationStartResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityRegistrationStartResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityCheckCaptcha.response`.
sealed class NnsInternetIdentityCheckCaptchaResponse with CandidSerializable {
  const NnsInternetIdentityCheckCaptchaResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityIdRegNextStepResult.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityCheckCaptchaError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityCheckCaptchaResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityCheckCaptchaResponseOk(
        json.valueTo<NnsInternetIdentityIdRegNextStepResult, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityIdRegNextStepResult.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityCheckCaptchaResponseErr(
        json.valueTo<NnsInternetIdentityCheckCaptchaError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityCheckCaptchaError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityCheckCaptchaResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityCheckCaptchaResponse arm',
    );
  }

  factory NnsInternetIdentityCheckCaptchaResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityCheckCaptchaResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityCheckCaptcha.response.Ok`.
final class NnsInternetIdentityCheckCaptchaResponseOk
    extends NnsInternetIdentityCheckCaptchaResponse {
  final NnsInternetIdentityIdRegNextStepResult value;
  const NnsInternetIdentityCheckCaptchaResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityCheckCaptchaResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityCheckCaptcha.response.Err`.
final class NnsInternetIdentityCheckCaptchaResponseErr
    extends NnsInternetIdentityCheckCaptchaResponse {
  final NnsInternetIdentityCheckCaptchaError value;
  const NnsInternetIdentityCheckCaptchaResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityCheckCaptchaResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityIdentityRegistrationFinish.response`.
sealed class NnsInternetIdentityIdentityRegistrationFinishResponse
    with CandidSerializable {
  const NnsInternetIdentityIdentityRegistrationFinishResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityIdRegFinishResult.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityIdRegFinishError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdentityRegistrationFinishResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityIdentityRegistrationFinishResponseOk(
        json.valueTo<NnsInternetIdentityIdRegFinishResult, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityIdRegFinishResult.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityIdentityRegistrationFinishResponseErr(
        json.valueTo<NnsInternetIdentityIdRegFinishError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityIdRegFinishError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdentityRegistrationFinishResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityIdentityRegistrationFinishResponse arm',
    );
  }

  factory NnsInternetIdentityIdentityRegistrationFinishResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityRegistrationFinishResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityIdentityRegistrationFinish.response.Ok`.
final class NnsInternetIdentityIdentityRegistrationFinishResponseOk
    extends NnsInternetIdentityIdentityRegistrationFinishResponse {
  final NnsInternetIdentityIdRegFinishResult value;
  const NnsInternetIdentityIdentityRegistrationFinishResponseOk(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityRegistrationFinishResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityIdentityRegistrationFinish.response.Err`.
final class NnsInternetIdentityIdentityRegistrationFinishResponseErr
    extends NnsInternetIdentityIdentityRegistrationFinishResponse {
  final NnsInternetIdentityIdRegFinishError value;
  const NnsInternetIdentityIdentityRegistrationFinishResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityRegistrationFinishResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityIdentityAuthnInfo.response`.
sealed class NnsInternetIdentityIdentityAuthnInfoResponse
    with CandidSerializable {
  const NnsInternetIdentityIdentityAuthnInfoResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityIdentityAuthnInfo.ctype,
    ),
    Field(Label.named('Err'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdentityAuthnInfoResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityIdentityAuthnInfoResponseOk(
        json.valueTo<NnsInternetIdentityIdentityAuthnInfo, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityIdentityAuthnInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return const NnsInternetIdentityIdentityAuthnInfoResponseErr();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdentityAuthnInfoResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityIdentityAuthnInfoResponse arm',
    );
  }

  factory NnsInternetIdentityIdentityAuthnInfoResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityAuthnInfoResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityIdentityAuthnInfo.response.Ok`.
final class NnsInternetIdentityIdentityAuthnInfoResponseOk
    extends NnsInternetIdentityIdentityAuthnInfoResponse {
  final NnsInternetIdentityIdentityAuthnInfo value;
  const NnsInternetIdentityIdentityAuthnInfoResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityIdentityAuthnInfoResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityIdentityAuthnInfo.response.Err` (nullary).
final class NnsInternetIdentityIdentityAuthnInfoResponseErr
    extends NnsInternetIdentityIdentityAuthnInfoResponse {
  const NnsInternetIdentityIdentityAuthnInfoResponseErr();

  @override
  CType get candidType => NnsInternetIdentityIdentityAuthnInfoResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Err', null);

  @override
  Map<String, dynamic> toJson() => {'Err': null};
}

/// Candid variant `NnsInternetIdentityIdentityInfo.response`.
sealed class NnsInternetIdentityIdentityInfoResponse with CandidSerializable {
  const NnsInternetIdentityIdentityInfoResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsInternetIdentityIdentityInfo.ctype),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityIdentityInfoError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdentityInfoResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityIdentityInfoResponseOk(
        json.valueTo<NnsInternetIdentityIdentityInfo, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityIdentityInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityIdentityInfoResponseErr(
        json.valueTo<NnsInternetIdentityIdentityInfoError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityIdentityInfoError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdentityInfoResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityIdentityInfoResponse arm',
    );
  }

  factory NnsInternetIdentityIdentityInfoResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityInfoResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityIdentityInfo.response.Ok`.
final class NnsInternetIdentityIdentityInfoResponseOk
    extends NnsInternetIdentityIdentityInfoResponse {
  final NnsInternetIdentityIdentityInfo value;
  const NnsInternetIdentityIdentityInfoResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityIdentityInfoResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityIdentityInfo.response.Err`.
final class NnsInternetIdentityIdentityInfoResponseErr
    extends NnsInternetIdentityIdentityInfoResponse {
  final NnsInternetIdentityIdentityInfoError value;
  const NnsInternetIdentityIdentityInfoResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityIdentityInfoResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityIdentityMetadataReplace.response`.
sealed class NnsInternetIdentityIdentityMetadataReplaceResponse
    with CandidSerializable {
  const NnsInternetIdentityIdentityMetadataReplaceResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityIdentityMetadataReplaceError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdentityMetadataReplaceResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityIdentityMetadataReplaceResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityIdentityMetadataReplaceResponseErr(
        json.valueTo<NnsInternetIdentityIdentityMetadataReplaceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityIdentityMetadataReplaceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdentityMetadataReplaceResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityIdentityMetadataReplaceResponse arm',
    );
  }

  factory NnsInternetIdentityIdentityMetadataReplaceResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityMetadataReplaceResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityIdentityMetadataReplace.response.Ok` (nullary).
final class NnsInternetIdentityIdentityMetadataReplaceResponseOk
    extends NnsInternetIdentityIdentityMetadataReplaceResponse {
  const NnsInternetIdentityIdentityMetadataReplaceResponseOk();

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityMetadataReplaceResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityIdentityMetadataReplace.response.Err`.
final class NnsInternetIdentityIdentityMetadataReplaceResponseErr
    extends NnsInternetIdentityIdentityMetadataReplaceResponse {
  final NnsInternetIdentityIdentityMetadataReplaceError value;
  const NnsInternetIdentityIdentityMetadataReplaceResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityMetadataReplaceResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityIdentityPropertiesReplace.response`.
sealed class NnsInternetIdentityIdentityPropertiesReplaceResponse
    with CandidSerializable {
  const NnsInternetIdentityIdentityPropertiesReplaceResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityIdentityPropertiesReplaceError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdentityPropertiesReplaceResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityIdentityPropertiesReplaceResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityIdentityPropertiesReplaceResponseErr(
        json.valueTo<NnsInternetIdentityIdentityPropertiesReplaceError, Map>(
          key: 'Err',
          parse:
              (e) =>
                  NnsInternetIdentityIdentityPropertiesReplaceError.fromCandid(
                    JsonParser.valueEnsureAsMap<String, dynamic>(e),
                  ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdentityPropertiesReplaceResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityIdentityPropertiesReplaceResponse arm',
    );
  }

  factory NnsInternetIdentityIdentityPropertiesReplaceResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityPropertiesReplaceResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityIdentityPropertiesReplace.response.Ok` (nullary).
final class NnsInternetIdentityIdentityPropertiesReplaceResponseOk
    extends NnsInternetIdentityIdentityPropertiesReplaceResponse {
  const NnsInternetIdentityIdentityPropertiesReplaceResponseOk();

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityPropertiesReplaceResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityIdentityPropertiesReplace.response.Err`.
final class NnsInternetIdentityIdentityPropertiesReplaceResponseErr
    extends NnsInternetIdentityIdentityPropertiesReplaceResponse {
  final NnsInternetIdentityIdentityPropertiesReplaceError value;
  const NnsInternetIdentityIdentityPropertiesReplaceResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityPropertiesReplaceResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityAuthnMethodAdd.response`.
sealed class NnsInternetIdentityAuthnMethodAddResponse with CandidSerializable {
  const NnsInternetIdentityAuthnMethodAddResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAuthnMethodAddError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodAddResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityAuthnMethodAddResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityAuthnMethodAddResponseErr(
        json.valueTo<NnsInternetIdentityAuthnMethodAddError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityAuthnMethodAddError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodAddResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodAddResponse arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodAddResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodAddResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityAuthnMethodAdd.response.Ok` (nullary).
final class NnsInternetIdentityAuthnMethodAddResponseOk
    extends NnsInternetIdentityAuthnMethodAddResponse {
  const NnsInternetIdentityAuthnMethodAddResponseOk();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodAddResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityAuthnMethodAdd.response.Err`.
final class NnsInternetIdentityAuthnMethodAddResponseErr
    extends NnsInternetIdentityAuthnMethodAddResponse {
  final NnsInternetIdentityAuthnMethodAddError value;
  const NnsInternetIdentityAuthnMethodAddResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodAddResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityAuthnMethodReplace.response`.
sealed class NnsInternetIdentityAuthnMethodReplaceResponse
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodReplaceResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAuthnMethodReplaceError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodReplaceResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityAuthnMethodReplaceResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityAuthnMethodReplaceResponseErr(
        json.valueTo<NnsInternetIdentityAuthnMethodReplaceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityAuthnMethodReplaceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodReplaceResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodReplaceResponse arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodReplaceResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodReplaceResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityAuthnMethodReplace.response.Ok` (nullary).
final class NnsInternetIdentityAuthnMethodReplaceResponseOk
    extends NnsInternetIdentityAuthnMethodReplaceResponse {
  const NnsInternetIdentityAuthnMethodReplaceResponseOk();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodReplaceResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityAuthnMethodReplace.response.Err`.
final class NnsInternetIdentityAuthnMethodReplaceResponseErr
    extends NnsInternetIdentityAuthnMethodReplaceResponse {
  final NnsInternetIdentityAuthnMethodReplaceError value;
  const NnsInternetIdentityAuthnMethodReplaceResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodReplaceResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityAuthnMethodMetadataReplace.response`.
sealed class NnsInternetIdentityAuthnMethodMetadataReplaceResponse
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodMetadataReplaceResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAuthnMethodMetadataReplaceError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodMetadataReplaceResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityAuthnMethodMetadataReplaceResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityAuthnMethodMetadataReplaceResponseErr(
        json.valueTo<NnsInternetIdentityAuthnMethodMetadataReplaceError, Map>(
          key: 'Err',
          parse:
              (e) =>
                  NnsInternetIdentityAuthnMethodMetadataReplaceError.fromCandid(
                    JsonParser.valueEnsureAsMap<String, dynamic>(e),
                  ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodMetadataReplaceResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityAuthnMethodMetadataReplaceResponse arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodMetadataReplaceResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodMetadataReplaceResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityAuthnMethodMetadataReplace.response.Ok` (nullary).
final class NnsInternetIdentityAuthnMethodMetadataReplaceResponseOk
    extends NnsInternetIdentityAuthnMethodMetadataReplaceResponse {
  const NnsInternetIdentityAuthnMethodMetadataReplaceResponseOk();

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodMetadataReplaceResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityAuthnMethodMetadataReplace.response.Err`.
final class NnsInternetIdentityAuthnMethodMetadataReplaceResponseErr
    extends NnsInternetIdentityAuthnMethodMetadataReplaceResponse {
  final NnsInternetIdentityAuthnMethodMetadataReplaceError value;
  const NnsInternetIdentityAuthnMethodMetadataReplaceResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodMetadataReplaceResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityAuthnMethodSecuritySettingsReplace.response`.
sealed class NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponseErr(
        json.valueTo<
          NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError,
          Map
        >(
          key: 'Err',
          parse:
              (e) =>
                  NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError.fromCandid(
                    JsonParser.valueEnsureAsMap<String, dynamic>(e),
                  ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityAuthnMethodSecuritySettingsReplace.response.Ok` (nullary).
final class NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponseOk
    extends NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse {
  const NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponseOk();

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityAuthnMethodSecuritySettingsReplace.response.Err`.
final class NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponseErr
    extends NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse {
  final NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError value;
  const NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponseErr(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityAuthnMethodRemove.response`.
sealed class NnsInternetIdentityAuthnMethodRemoveResponse
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodRemoveResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    Field(Label.named('Err'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodRemoveResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityAuthnMethodRemoveResponseOk();
    }
    if (json.containsKey('Err')) {
      return const NnsInternetIdentityAuthnMethodRemoveResponseErr();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodRemoveResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodRemoveResponse arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodRemoveResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodRemoveResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityAuthnMethodRemove.response.Ok` (nullary).
final class NnsInternetIdentityAuthnMethodRemoveResponseOk
    extends NnsInternetIdentityAuthnMethodRemoveResponse {
  const NnsInternetIdentityAuthnMethodRemoveResponseOk();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodRemoveResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityAuthnMethodRemove.response.Err` (nullary).
final class NnsInternetIdentityAuthnMethodRemoveResponseErr
    extends NnsInternetIdentityAuthnMethodRemoveResponse {
  const NnsInternetIdentityAuthnMethodRemoveResponseErr();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodRemoveResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Err', null);

  @override
  Map<String, dynamic> toJson() => {'Err': null};
}

/// Candid variant `NnsInternetIdentityAuthnMethodRegistrationModeEnter.response`.
sealed class NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse();

  static CType get ctype => CType.variant([
    Field(
      Label.named('Ok'),
      CType.record([Field(Label.named('expiration'), CType.nat64)]),
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAuthnMethodRegistrationModeEnterError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityAuthnMethodRegistrationModeEnterResponseOk.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Ok']),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityAuthnMethodRegistrationModeEnterResponseErr(
        json.valueTo<
          NnsInternetIdentityAuthnMethodRegistrationModeEnterError,
          Map
        >(
          key: 'Err',
          parse:
              (e) =>
                  NnsInternetIdentityAuthnMethodRegistrationModeEnterError.fromCandid(
                    JsonParser.valueEnsureAsMap<String, dynamic>(e),
                  ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityAuthnMethodRegistrationModeEnter.response.Ok`.
final class NnsInternetIdentityAuthnMethodRegistrationModeEnterResponseOk
    extends NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse {
  final NnsInternetIdentityTimestamp expiration;

  const NnsInternetIdentityAuthnMethodRegistrationModeEnterResponseOk({
    required this.expiration,
  });

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', {'expiration': expiration});

  @override
  Map<String, dynamic> toJson() => {
    'Ok': {'expiration': expiration},
  };

  factory NnsInternetIdentityAuthnMethodRegistrationModeEnterResponseOk.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAuthnMethodRegistrationModeEnterResponseOk(
      expiration: json.valueAsBigInt<BigInt>('expiration'),
    );
  }
}

/// Variant arm `NnsInternetIdentityAuthnMethodRegistrationModeEnter.response.Err`.
final class NnsInternetIdentityAuthnMethodRegistrationModeEnterResponseErr
    extends NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse {
  final NnsInternetIdentityAuthnMethodRegistrationModeEnterError value;
  const NnsInternetIdentityAuthnMethodRegistrationModeEnterResponseErr(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityAuthnMethodRegistrationModeExit.response`.
sealed class NnsInternetIdentityAuthnMethodRegistrationModeExitResponse
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodRegistrationModeExitResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAuthnMethodRegistrationModeExitError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodRegistrationModeExitResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityAuthnMethodRegistrationModeExitResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityAuthnMethodRegistrationModeExitResponseErr(
        json.valueTo<
          NnsInternetIdentityAuthnMethodRegistrationModeExitError,
          Map
        >(
          key: 'Err',
          parse:
              (e) =>
                  NnsInternetIdentityAuthnMethodRegistrationModeExitError.fromCandid(
                    JsonParser.valueEnsureAsMap<String, dynamic>(e),
                  ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodRegistrationModeExitResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityAuthnMethodRegistrationModeExitResponse arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodRegistrationModeExitResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodRegistrationModeExitResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityAuthnMethodRegistrationModeExit.response.Ok` (nullary).
final class NnsInternetIdentityAuthnMethodRegistrationModeExitResponseOk
    extends NnsInternetIdentityAuthnMethodRegistrationModeExitResponse {
  const NnsInternetIdentityAuthnMethodRegistrationModeExitResponseOk();

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeExitResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityAuthnMethodRegistrationModeExit.response.Err`.
final class NnsInternetIdentityAuthnMethodRegistrationModeExitResponseErr
    extends NnsInternetIdentityAuthnMethodRegistrationModeExitResponse {
  final NnsInternetIdentityAuthnMethodRegistrationModeExitError value;
  const NnsInternetIdentityAuthnMethodRegistrationModeExitResponseErr(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeExitResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityAuthnMethodRegister.response`.
sealed class NnsInternetIdentityAuthnMethodRegisterResponse
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodRegisterResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityAuthnMethodConfirmationCode.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAuthnMethodRegisterError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodRegisterResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityAuthnMethodRegisterResponseOk(
        json.valueTo<NnsInternetIdentityAuthnMethodConfirmationCode, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityAuthnMethodConfirmationCode.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityAuthnMethodRegisterResponseErr(
        json.valueTo<NnsInternetIdentityAuthnMethodRegisterError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityAuthnMethodRegisterError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodRegisterResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodRegisterResponse arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodRegisterResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodRegisterResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityAuthnMethodRegister.response.Ok`.
final class NnsInternetIdentityAuthnMethodRegisterResponseOk
    extends NnsInternetIdentityAuthnMethodRegisterResponse {
  final NnsInternetIdentityAuthnMethodConfirmationCode value;
  const NnsInternetIdentityAuthnMethodRegisterResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodRegisterResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityAuthnMethodRegister.response.Err`.
final class NnsInternetIdentityAuthnMethodRegisterResponseErr
    extends NnsInternetIdentityAuthnMethodRegisterResponse {
  final NnsInternetIdentityAuthnMethodRegisterError value;
  const NnsInternetIdentityAuthnMethodRegisterResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodRegisterResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityAuthnMethodConfirm.response`.
sealed class NnsInternetIdentityAuthnMethodConfirmResponse
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodConfirmResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAuthnMethodConfirmationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodConfirmResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityAuthnMethodConfirmResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityAuthnMethodConfirmResponseErr(
        json.valueTo<NnsInternetIdentityAuthnMethodConfirmationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityAuthnMethodConfirmationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodConfirmResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodConfirmResponse arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodConfirmResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodConfirmResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityAuthnMethodConfirm.response.Ok` (nullary).
final class NnsInternetIdentityAuthnMethodConfirmResponseOk
    extends NnsInternetIdentityAuthnMethodConfirmResponse {
  const NnsInternetIdentityAuthnMethodConfirmResponseOk();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodConfirmResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityAuthnMethodConfirm.response.Err`.
final class NnsInternetIdentityAuthnMethodConfirmResponseErr
    extends NnsInternetIdentityAuthnMethodConfirmResponse {
  final NnsInternetIdentityAuthnMethodConfirmationError value;
  const NnsInternetIdentityAuthnMethodConfirmResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodConfirmResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityPrepareAttributes.response`.
sealed class NnsInternetIdentityPrepareAttributesResponse
    with CandidSerializable {
  const NnsInternetIdentityPrepareAttributesResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityPrepareAttributeResponse.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityPrepareAttributeError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPrepareAttributesResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityPrepareAttributesResponseOk(
        json.valueTo<NnsInternetIdentityPrepareAttributeResponse, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityPrepareAttributeResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityPrepareAttributesResponseErr(
        json.valueTo<NnsInternetIdentityPrepareAttributeError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityPrepareAttributeError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPrepareAttributesResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityPrepareAttributesResponse arm',
    );
  }

  factory NnsInternetIdentityPrepareAttributesResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareAttributesResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityPrepareAttributes.response.Ok`.
final class NnsInternetIdentityPrepareAttributesResponseOk
    extends NnsInternetIdentityPrepareAttributesResponse {
  final NnsInternetIdentityPrepareAttributeResponse value;
  const NnsInternetIdentityPrepareAttributesResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityPrepareAttributesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityPrepareAttributes.response.Err`.
final class NnsInternetIdentityPrepareAttributesResponseErr
    extends NnsInternetIdentityPrepareAttributesResponse {
  final NnsInternetIdentityPrepareAttributeError value;
  const NnsInternetIdentityPrepareAttributesResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityPrepareAttributesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityGetAttributes.response`.
sealed class NnsInternetIdentityGetAttributesResponse with CandidSerializable {
  const NnsInternetIdentityGetAttributesResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityCertifiedAttributes.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityGetAttributesError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetAttributesResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityGetAttributesResponseOk(
        json.valueTo<NnsInternetIdentityCertifiedAttributes, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityCertifiedAttributes.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityGetAttributesResponseErr(
        json.valueTo<NnsInternetIdentityGetAttributesError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityGetAttributesError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetAttributesResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetAttributesResponse arm',
    );
  }

  factory NnsInternetIdentityGetAttributesResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetAttributesResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityGetAttributes.response.Ok`.
final class NnsInternetIdentityGetAttributesResponseOk
    extends NnsInternetIdentityGetAttributesResponse {
  final NnsInternetIdentityCertifiedAttributes value;
  const NnsInternetIdentityGetAttributesResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetAttributesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityGetAttributes.response.Err`.
final class NnsInternetIdentityGetAttributesResponseErr
    extends NnsInternetIdentityGetAttributesResponse {
  final NnsInternetIdentityGetAttributesError value;
  const NnsInternetIdentityGetAttributesResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetAttributesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityPrepareIcrc3Attributes.response`.
sealed class NnsInternetIdentityPrepareIcrc3AttributesResponse
    with CandidSerializable {
  const NnsInternetIdentityPrepareIcrc3AttributesResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityPrepareIcrc3AttributeResponse.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityPrepareIcrc3AttributeError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPrepareIcrc3AttributesResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityPrepareIcrc3AttributesResponseOk(
        json.valueTo<NnsInternetIdentityPrepareIcrc3AttributeResponse, Map>(
          key: 'Ok',
          parse:
              (e) =>
                  NnsInternetIdentityPrepareIcrc3AttributeResponse.fromCandid(
                    JsonParser.valueEnsureAsMap<String, dynamic>(e),
                  ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityPrepareIcrc3AttributesResponseErr(
        json.valueTo<NnsInternetIdentityPrepareIcrc3AttributeError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityPrepareIcrc3AttributeError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPrepareIcrc3AttributesResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityPrepareIcrc3AttributesResponse arm',
    );
  }

  factory NnsInternetIdentityPrepareIcrc3AttributesResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareIcrc3AttributesResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityPrepareIcrc3Attributes.response.Ok`.
final class NnsInternetIdentityPrepareIcrc3AttributesResponseOk
    extends NnsInternetIdentityPrepareIcrc3AttributesResponse {
  final NnsInternetIdentityPrepareIcrc3AttributeResponse value;
  const NnsInternetIdentityPrepareIcrc3AttributesResponseOk(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityPrepareIcrc3AttributesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityPrepareIcrc3Attributes.response.Err`.
final class NnsInternetIdentityPrepareIcrc3AttributesResponseErr
    extends NnsInternetIdentityPrepareIcrc3AttributesResponse {
  final NnsInternetIdentityPrepareIcrc3AttributeError value;
  const NnsInternetIdentityPrepareIcrc3AttributesResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityPrepareIcrc3AttributesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityGetIcrc3Attributes.response`.
sealed class NnsInternetIdentityGetIcrc3AttributesResponse
    with CandidSerializable {
  const NnsInternetIdentityGetIcrc3AttributesResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityGetIcrc3AttributeResponse.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityGetIcrc3AttributeError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetIcrc3AttributesResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityGetIcrc3AttributesResponseOk(
        json.valueTo<NnsInternetIdentityGetIcrc3AttributeResponse, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityGetIcrc3AttributeResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityGetIcrc3AttributesResponseErr(
        json.valueTo<NnsInternetIdentityGetIcrc3AttributeError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityGetIcrc3AttributeError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetIcrc3AttributesResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetIcrc3AttributesResponse arm',
    );
  }

  factory NnsInternetIdentityGetIcrc3AttributesResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetIcrc3AttributesResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityGetIcrc3Attributes.response.Ok`.
final class NnsInternetIdentityGetIcrc3AttributesResponseOk
    extends NnsInternetIdentityGetIcrc3AttributesResponse {
  final NnsInternetIdentityGetIcrc3AttributeResponse value;
  const NnsInternetIdentityGetIcrc3AttributesResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetIcrc3AttributesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityGetIcrc3Attributes.response.Err`.
final class NnsInternetIdentityGetIcrc3AttributesResponseErr
    extends NnsInternetIdentityGetIcrc3AttributesResponse {
  final NnsInternetIdentityGetIcrc3AttributeError value;
  const NnsInternetIdentityGetIcrc3AttributesResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetIcrc3AttributesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityListAvailableAttributes.response`.
sealed class NnsInternetIdentityListAvailableAttributesResponse2
    with CandidSerializable {
  const NnsInternetIdentityListAvailableAttributesResponse2();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityListAvailableAttributesResponseCandid.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityListAvailableAttributesError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityListAvailableAttributesResponse2.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityListAvailableAttributesResponse2Ok(
        json.valueTo<
          List<NnsInternetIdentityPrepareAttributeResponseAttributes>,
          List
        >(
          key: 'Ok',
          parse:
              (e) =>
                  e
                      .map<
                        NnsInternetIdentityPrepareAttributeResponseAttributes
                      >(
                        (x) =>
                            NnsInternetIdentityPrepareAttributeResponseAttributes.fromCandid(
                              JsonParser.valueEnsureAsMap<String, dynamic>(x),
                            ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityListAvailableAttributesResponse2Err(
        json.valueTo<NnsInternetIdentityListAvailableAttributesError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityListAvailableAttributesError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityListAvailableAttributesResponse2.fromCandid',
      reason: 'Unknown NnsInternetIdentityListAvailableAttributesResponse2 arm',
    );
  }

  factory NnsInternetIdentityListAvailableAttributesResponse2.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityListAvailableAttributesResponse2.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityListAvailableAttributes.response.Ok`.
final class NnsInternetIdentityListAvailableAttributesResponse2Ok
    extends NnsInternetIdentityListAvailableAttributesResponse2 {
  final NnsInternetIdentityListAvailableAttributesResponse value;
  const NnsInternetIdentityListAvailableAttributesResponse2Ok(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityListAvailableAttributesResponse2.ctype;

  @override
  dynamic get candidValue =>
      Variant('Ok', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Ok': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `NnsInternetIdentityListAvailableAttributes.response.Err`.
final class NnsInternetIdentityListAvailableAttributesResponse2Err
    extends NnsInternetIdentityListAvailableAttributesResponse2 {
  final NnsInternetIdentityListAvailableAttributesError value;
  const NnsInternetIdentityListAvailableAttributesResponse2Err(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityListAvailableAttributesResponse2.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityPrepareIdAlias.response`.
sealed class NnsInternetIdentityPrepareIdAliasResponse with CandidSerializable {
  const NnsInternetIdentityPrepareIdAliasResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityPreparedIdAlias.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityPrepareIdAliasError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPrepareIdAliasResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityPrepareIdAliasResponseOk(
        json.valueTo<NnsInternetIdentityPreparedIdAlias, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityPreparedIdAlias.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityPrepareIdAliasResponseErr(
        json.valueTo<NnsInternetIdentityPrepareIdAliasError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityPrepareIdAliasError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPrepareIdAliasResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityPrepareIdAliasResponse arm',
    );
  }

  factory NnsInternetIdentityPrepareIdAliasResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareIdAliasResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityPrepareIdAlias.response.Ok`.
final class NnsInternetIdentityPrepareIdAliasResponseOk
    extends NnsInternetIdentityPrepareIdAliasResponse {
  final NnsInternetIdentityPreparedIdAlias value;
  const NnsInternetIdentityPrepareIdAliasResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityPrepareIdAliasResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityPrepareIdAlias.response.Err`.
final class NnsInternetIdentityPrepareIdAliasResponseErr
    extends NnsInternetIdentityPrepareIdAliasResponse {
  final NnsInternetIdentityPrepareIdAliasError value;
  const NnsInternetIdentityPrepareIdAliasResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityPrepareIdAliasResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityGetIdAlias.response`.
sealed class NnsInternetIdentityGetIdAliasResponse with CandidSerializable {
  const NnsInternetIdentityGetIdAliasResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityIdAliasCredentials.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityGetIdAliasError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetIdAliasResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityGetIdAliasResponseOk(
        json.valueTo<NnsInternetIdentityIdAliasCredentials, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityIdAliasCredentials.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityGetIdAliasResponseErr(
        json.valueTo<NnsInternetIdentityGetIdAliasError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityGetIdAliasError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetIdAliasResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetIdAliasResponse arm',
    );
  }

  factory NnsInternetIdentityGetIdAliasResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetIdAliasResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityGetIdAlias.response.Ok`.
final class NnsInternetIdentityGetIdAliasResponseOk
    extends NnsInternetIdentityGetIdAliasResponse {
  final NnsInternetIdentityIdAliasCredentials value;
  const NnsInternetIdentityGetIdAliasResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetIdAliasResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityGetIdAlias.response.Err`.
final class NnsInternetIdentityGetIdAliasResponseErr
    extends NnsInternetIdentityGetIdAliasResponse {
  final NnsInternetIdentityGetIdAliasError value;
  const NnsInternetIdentityGetIdAliasResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetIdAliasResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityOpenidIdentityRegistrationFinish.response`.
sealed class NnsInternetIdentityOpenidIdentityRegistrationFinishResponse
    with CandidSerializable {
  const NnsInternetIdentityOpenidIdentityRegistrationFinishResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityIdRegFinishResult.ctype,
    ),
    Field(Label.named('Pending'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityIdRegFinishError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityOpenidIdentityRegistrationFinishResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityOpenidIdentityRegistrationFinishResponseOk(
        json.valueTo<NnsInternetIdentityIdRegFinishResult, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityIdRegFinishResult.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Pending')) {
      return const NnsInternetIdentityOpenidIdentityRegistrationFinishResponsePending();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityOpenidIdentityRegistrationFinishResponseErr(
        json.valueTo<NnsInternetIdentityIdRegFinishError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityIdRegFinishError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityOpenidIdentityRegistrationFinishResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityOpenidIdentityRegistrationFinishResponse arm',
    );
  }

  factory NnsInternetIdentityOpenidIdentityRegistrationFinishResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenidIdentityRegistrationFinishResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityOpenidIdentityRegistrationFinish.response.Ok`.
final class NnsInternetIdentityOpenidIdentityRegistrationFinishResponseOk
    extends NnsInternetIdentityOpenidIdentityRegistrationFinishResponse {
  final NnsInternetIdentityIdRegFinishResult value;
  const NnsInternetIdentityOpenidIdentityRegistrationFinishResponseOk(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityOpenidIdentityRegistrationFinishResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityOpenidIdentityRegistrationFinish.response.Pending` (nullary).
final class NnsInternetIdentityOpenidIdentityRegistrationFinishResponsePending
    extends NnsInternetIdentityOpenidIdentityRegistrationFinishResponse {
  const NnsInternetIdentityOpenidIdentityRegistrationFinishResponsePending();

  @override
  CType get candidType =>
      NnsInternetIdentityOpenidIdentityRegistrationFinishResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Pending', null);

  @override
  Map<String, dynamic> toJson() => {'Pending': null};
}

/// Variant arm `NnsInternetIdentityOpenidIdentityRegistrationFinish.response.Err`.
final class NnsInternetIdentityOpenidIdentityRegistrationFinishResponseErr
    extends NnsInternetIdentityOpenidIdentityRegistrationFinishResponse {
  final NnsInternetIdentityIdRegFinishError value;
  const NnsInternetIdentityOpenidIdentityRegistrationFinishResponseErr(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityOpenidIdentityRegistrationFinishResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityOpenidCredentialAdd.response`.
sealed class NnsInternetIdentityOpenidCredentialAddResponse
    with CandidSerializable {
  const NnsInternetIdentityOpenidCredentialAddResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    Field(Label.named('Pending'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityOpenIdCredentialAddError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityOpenidCredentialAddResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityOpenidCredentialAddResponseOk();
    }
    if (json.containsKey('Pending')) {
      return const NnsInternetIdentityOpenidCredentialAddResponsePending();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityOpenidCredentialAddResponseErr(
        json.valueTo<NnsInternetIdentityOpenIdCredentialAddError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityOpenIdCredentialAddError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityOpenidCredentialAddResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityOpenidCredentialAddResponse arm',
    );
  }

  factory NnsInternetIdentityOpenidCredentialAddResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenidCredentialAddResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityOpenidCredentialAdd.response.Ok` (nullary).
final class NnsInternetIdentityOpenidCredentialAddResponseOk
    extends NnsInternetIdentityOpenidCredentialAddResponse {
  const NnsInternetIdentityOpenidCredentialAddResponseOk();

  @override
  CType get candidType => NnsInternetIdentityOpenidCredentialAddResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityOpenidCredentialAdd.response.Pending` (nullary).
final class NnsInternetIdentityOpenidCredentialAddResponsePending
    extends NnsInternetIdentityOpenidCredentialAddResponse {
  const NnsInternetIdentityOpenidCredentialAddResponsePending();

  @override
  CType get candidType => NnsInternetIdentityOpenidCredentialAddResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Pending', null);

  @override
  Map<String, dynamic> toJson() => {'Pending': null};
}

/// Variant arm `NnsInternetIdentityOpenidCredentialAdd.response.Err`.
final class NnsInternetIdentityOpenidCredentialAddResponseErr
    extends NnsInternetIdentityOpenidCredentialAddResponse {
  final NnsInternetIdentityOpenIdCredentialAddError value;
  const NnsInternetIdentityOpenidCredentialAddResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityOpenidCredentialAddResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityOpenidCredentialRemove.response`.
sealed class NnsInternetIdentityOpenidCredentialRemoveResponse
    with CandidSerializable {
  const NnsInternetIdentityOpenidCredentialRemoveResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityOpenIdCredentialRemoveError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityOpenidCredentialRemoveResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityOpenidCredentialRemoveResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityOpenidCredentialRemoveResponseErr(
        json.valueTo<NnsInternetIdentityOpenIdCredentialRemoveError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityOpenIdCredentialRemoveError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityOpenidCredentialRemoveResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityOpenidCredentialRemoveResponse arm',
    );
  }

  factory NnsInternetIdentityOpenidCredentialRemoveResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenidCredentialRemoveResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityOpenidCredentialRemove.response.Ok` (nullary).
final class NnsInternetIdentityOpenidCredentialRemoveResponseOk
    extends NnsInternetIdentityOpenidCredentialRemoveResponse {
  const NnsInternetIdentityOpenidCredentialRemoveResponseOk();

  @override
  CType get candidType =>
      NnsInternetIdentityOpenidCredentialRemoveResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityOpenidCredentialRemove.response.Err`.
final class NnsInternetIdentityOpenidCredentialRemoveResponseErr
    extends NnsInternetIdentityOpenidCredentialRemoveResponse {
  final NnsInternetIdentityOpenIdCredentialRemoveError value;
  const NnsInternetIdentityOpenidCredentialRemoveResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityOpenidCredentialRemoveResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityOpenidPrepareDelegation.response`.
sealed class NnsInternetIdentityOpenidPrepareDelegationResponse
    with CandidSerializable {
  const NnsInternetIdentityOpenidPrepareDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityOpenIdPrepareDelegationResponse.ctype,
    ),
    Field(Label.named('Pending'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityOpenIdDelegationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityOpenidPrepareDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityOpenidPrepareDelegationResponseOk(
        json.valueTo<NnsInternetIdentityOpenIdPrepareDelegationResponse, Map>(
          key: 'Ok',
          parse:
              (e) =>
                  NnsInternetIdentityOpenIdPrepareDelegationResponse.fromCandid(
                    JsonParser.valueEnsureAsMap<String, dynamic>(e),
                  ),
        ),
      );
    }
    if (json.containsKey('Pending')) {
      return const NnsInternetIdentityOpenidPrepareDelegationResponsePending();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityOpenidPrepareDelegationResponseErr(
        json.valueTo<NnsInternetIdentityOpenIdDelegationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityOpenIdDelegationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityOpenidPrepareDelegationResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityOpenidPrepareDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityOpenidPrepareDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenidPrepareDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityOpenidPrepareDelegation.response.Ok`.
final class NnsInternetIdentityOpenidPrepareDelegationResponseOk
    extends NnsInternetIdentityOpenidPrepareDelegationResponse {
  final NnsInternetIdentityOpenIdPrepareDelegationResponse value;
  const NnsInternetIdentityOpenidPrepareDelegationResponseOk(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityOpenidPrepareDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityOpenidPrepareDelegation.response.Pending` (nullary).
final class NnsInternetIdentityOpenidPrepareDelegationResponsePending
    extends NnsInternetIdentityOpenidPrepareDelegationResponse {
  const NnsInternetIdentityOpenidPrepareDelegationResponsePending();

  @override
  CType get candidType =>
      NnsInternetIdentityOpenidPrepareDelegationResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Pending', null);

  @override
  Map<String, dynamic> toJson() => {'Pending': null};
}

/// Variant arm `NnsInternetIdentityOpenidPrepareDelegation.response.Err`.
final class NnsInternetIdentityOpenidPrepareDelegationResponseErr
    extends NnsInternetIdentityOpenidPrepareDelegationResponse {
  final NnsInternetIdentityOpenIdDelegationError value;
  const NnsInternetIdentityOpenidPrepareDelegationResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityOpenidPrepareDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityOpenidGetDelegation.response`.
sealed class NnsInternetIdentityOpenidGetDelegationResponse
    with CandidSerializable {
  const NnsInternetIdentityOpenidGetDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentitySignedDelegation.ctype,
    ),
    Field(Label.named('Pending'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityOpenIdDelegationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityOpenidGetDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityOpenidGetDelegationResponseOk(
        json.valueTo<NnsInternetIdentitySignedDelegation, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentitySignedDelegation.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Pending')) {
      return const NnsInternetIdentityOpenidGetDelegationResponsePending();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityOpenidGetDelegationResponseErr(
        json.valueTo<NnsInternetIdentityOpenIdDelegationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityOpenIdDelegationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityOpenidGetDelegationResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityOpenidGetDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityOpenidGetDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenidGetDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityOpenidGetDelegation.response.Ok`.
final class NnsInternetIdentityOpenidGetDelegationResponseOk
    extends NnsInternetIdentityOpenidGetDelegationResponse {
  final NnsInternetIdentitySignedDelegation value;
  const NnsInternetIdentityOpenidGetDelegationResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityOpenidGetDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityOpenidGetDelegation.response.Pending` (nullary).
final class NnsInternetIdentityOpenidGetDelegationResponsePending
    extends NnsInternetIdentityOpenidGetDelegationResponse {
  const NnsInternetIdentityOpenidGetDelegationResponsePending();

  @override
  CType get candidType => NnsInternetIdentityOpenidGetDelegationResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Pending', null);

  @override
  Map<String, dynamic> toJson() => {'Pending': null};
}

/// Variant arm `NnsInternetIdentityOpenidGetDelegation.response.Err`.
final class NnsInternetIdentityOpenidGetDelegationResponseErr
    extends NnsInternetIdentityOpenidGetDelegationResponse {
  final NnsInternetIdentityOpenIdDelegationError value;
  const NnsInternetIdentityOpenidGetDelegationResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityOpenidGetDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentitySsoPrepareDelegation.response`.
sealed class NnsInternetIdentitySsoPrepareDelegationResponse2
    with CandidSerializable {
  const NnsInternetIdentitySsoPrepareDelegationResponse2();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentitySsoPrepareDelegationResponse.ctype,
    ),
    Field(Label.named('Pending'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityOpenIdDelegationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentitySsoPrepareDelegationResponse2.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentitySsoPrepareDelegationResponse2Ok(
        json.valueTo<NnsInternetIdentitySsoPrepareDelegationResponse, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentitySsoPrepareDelegationResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Pending')) {
      return const NnsInternetIdentitySsoPrepareDelegationResponse2Pending();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentitySsoPrepareDelegationResponse2Err(
        json.valueTo<NnsInternetIdentityOpenIdDelegationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityOpenIdDelegationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentitySsoPrepareDelegationResponse2.fromCandid',
      reason: 'Unknown NnsInternetIdentitySsoPrepareDelegationResponse2 arm',
    );
  }

  factory NnsInternetIdentitySsoPrepareDelegationResponse2.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySsoPrepareDelegationResponse2.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentitySsoPrepareDelegation.response.Ok`.
final class NnsInternetIdentitySsoPrepareDelegationResponse2Ok
    extends NnsInternetIdentitySsoPrepareDelegationResponse2 {
  final NnsInternetIdentitySsoPrepareDelegationResponse value;
  const NnsInternetIdentitySsoPrepareDelegationResponse2Ok(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentitySsoPrepareDelegationResponse2.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentitySsoPrepareDelegation.response.Pending` (nullary).
final class NnsInternetIdentitySsoPrepareDelegationResponse2Pending
    extends NnsInternetIdentitySsoPrepareDelegationResponse2 {
  const NnsInternetIdentitySsoPrepareDelegationResponse2Pending();

  @override
  CType get candidType =>
      NnsInternetIdentitySsoPrepareDelegationResponse2.ctype;

  @override
  dynamic get candidValue => const Variant('Pending', null);

  @override
  Map<String, dynamic> toJson() => {'Pending': null};
}

/// Variant arm `NnsInternetIdentitySsoPrepareDelegation.response.Err`.
final class NnsInternetIdentitySsoPrepareDelegationResponse2Err
    extends NnsInternetIdentitySsoPrepareDelegationResponse2 {
  final NnsInternetIdentityOpenIdDelegationError value;
  const NnsInternetIdentitySsoPrepareDelegationResponse2Err(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentitySsoPrepareDelegationResponse2.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentitySsoGetDelegation.response`.
sealed class NnsInternetIdentitySsoGetDelegationResponse2
    with CandidSerializable {
  const NnsInternetIdentitySsoGetDelegationResponse2();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentitySsoGetDelegationResponse.ctype,
    ),
    Field(Label.named('Pending'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityOpenIdDelegationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentitySsoGetDelegationResponse2.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentitySsoGetDelegationResponse2Ok(
        json.valueTo<NnsInternetIdentitySsoGetDelegationResponse, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentitySsoGetDelegationResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Pending')) {
      return const NnsInternetIdentitySsoGetDelegationResponse2Pending();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentitySsoGetDelegationResponse2Err(
        json.valueTo<NnsInternetIdentityOpenIdDelegationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityOpenIdDelegationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentitySsoGetDelegationResponse2.fromCandid',
      reason: 'Unknown NnsInternetIdentitySsoGetDelegationResponse2 arm',
    );
  }

  factory NnsInternetIdentitySsoGetDelegationResponse2.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySsoGetDelegationResponse2.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentitySsoGetDelegation.response.Ok`.
final class NnsInternetIdentitySsoGetDelegationResponse2Ok
    extends NnsInternetIdentitySsoGetDelegationResponse2 {
  final NnsInternetIdentitySsoGetDelegationResponse value;
  const NnsInternetIdentitySsoGetDelegationResponse2Ok(this.value);

  @override
  CType get candidType => NnsInternetIdentitySsoGetDelegationResponse2.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentitySsoGetDelegation.response.Pending` (nullary).
final class NnsInternetIdentitySsoGetDelegationResponse2Pending
    extends NnsInternetIdentitySsoGetDelegationResponse2 {
  const NnsInternetIdentitySsoGetDelegationResponse2Pending();

  @override
  CType get candidType => NnsInternetIdentitySsoGetDelegationResponse2.ctype;

  @override
  dynamic get candidValue => const Variant('Pending', null);

  @override
  Map<String, dynamic> toJson() => {'Pending': null};
}

/// Variant arm `NnsInternetIdentitySsoGetDelegation.response.Err`.
final class NnsInternetIdentitySsoGetDelegationResponse2Err
    extends NnsInternetIdentitySsoGetDelegationResponse2 {
  final NnsInternetIdentityOpenIdDelegationError value;
  const NnsInternetIdentitySsoGetDelegationResponse2Err(this.value);

  @override
  CType get candidType => NnsInternetIdentitySsoGetDelegationResponse2.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityEmailChallengeSubmitDkimLeaf.response`.
sealed class NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse
    with CandidSerializable {
  const NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityEmailChallengeError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityEmailChallengeSubmitDkimLeafResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityEmailChallengeSubmitDkimLeafResponseErr(
        json.valueTo<NnsInternetIdentityEmailChallengeError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityEmailChallengeError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse arm',
    );
  }

  factory NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityEmailChallengeSubmitDkimLeaf.response.Ok` (nullary).
final class NnsInternetIdentityEmailChallengeSubmitDkimLeafResponseOk
    extends NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse {
  const NnsInternetIdentityEmailChallengeSubmitDkimLeafResponseOk();

  @override
  CType get candidType =>
      NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityEmailChallengeSubmitDkimLeaf.response.Err`.
final class NnsInternetIdentityEmailChallengeSubmitDkimLeafResponseErr
    extends NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse {
  final NnsInternetIdentityEmailChallengeError value;
  const NnsInternetIdentityEmailChallengeSubmitDkimLeafResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityEmailRecoveryCredentialPrepareAdd.response`.
sealed class NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse
    with CandidSerializable {
  const NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsInternetIdentityEmailChallenge.ctype),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityEmailChallengeError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponseOk(
        json.valueTo<NnsInternetIdentityEmailChallenge, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityEmailChallenge.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponseErr(
        json.valueTo<NnsInternetIdentityEmailChallengeError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityEmailChallengeError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse arm',
    );
  }

  factory NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityEmailRecoveryCredentialPrepareAdd.response.Ok`.
final class NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponseOk
    extends NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse {
  final NnsInternetIdentityEmailChallenge value;
  const NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponseOk(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityEmailRecoveryCredentialPrepareAdd.response.Err`.
final class NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponseErr
    extends NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse {
  final NnsInternetIdentityEmailChallengeError value;
  const NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponseErr(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityEmailRecoveryGetDelegation.response`.
sealed class NnsInternetIdentityEmailRecoveryGetDelegationResponse
    with CandidSerializable {
  const NnsInternetIdentityEmailRecoveryGetDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentitySignedDelegation.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityEmailChallengeError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityEmailRecoveryGetDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityEmailRecoveryGetDelegationResponseOk(
        json.valueTo<NnsInternetIdentitySignedDelegation, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentitySignedDelegation.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityEmailRecoveryGetDelegationResponseErr(
        json.valueTo<NnsInternetIdentityEmailChallengeError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityEmailChallengeError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityEmailRecoveryGetDelegationResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityEmailRecoveryGetDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityEmailRecoveryGetDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailRecoveryGetDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityEmailRecoveryGetDelegation.response.Ok`.
final class NnsInternetIdentityEmailRecoveryGetDelegationResponseOk
    extends NnsInternetIdentityEmailRecoveryGetDelegationResponse {
  final NnsInternetIdentitySignedDelegation value;
  const NnsInternetIdentityEmailRecoveryGetDelegationResponseOk(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityEmailRecoveryGetDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityEmailRecoveryGetDelegation.response.Err`.
final class NnsInternetIdentityEmailRecoveryGetDelegationResponseErr
    extends NnsInternetIdentityEmailRecoveryGetDelegationResponse {
  final NnsInternetIdentityEmailChallengeError value;
  const NnsInternetIdentityEmailRecoveryGetDelegationResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityEmailRecoveryGetDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityGetAccounts.response`.
sealed class NnsInternetIdentityGetAccountsResponse with CandidSerializable {
  const NnsInternetIdentityGetAccountsResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => CType.vec(NnsInternetIdentityAccountInfo.ctype),
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityGetAccountsError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetAccountsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityGetAccountsResponseOk(
        json.valueTo<List<NnsInternetIdentityAccountInfo>, List>(
          key: 'Ok',
          parse:
              (e) =>
                  e
                      .map<NnsInternetIdentityAccountInfo>(
                        (x) => NnsInternetIdentityAccountInfo.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityGetAccountsResponseErr(
        json.valueTo<NnsInternetIdentityGetAccountsError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityGetAccountsError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetAccountsResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetAccountsResponse arm',
    );
  }

  factory NnsInternetIdentityGetAccountsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetAccountsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityGetAccounts.response.Ok`.
final class NnsInternetIdentityGetAccountsResponseOk
    extends NnsInternetIdentityGetAccountsResponse {
  final List<NnsInternetIdentityAccountInfo> value;
  const NnsInternetIdentityGetAccountsResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetAccountsResponse.ctype;

  @override
  dynamic get candidValue =>
      Variant('Ok', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Ok': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `NnsInternetIdentityGetAccounts.response.Err`.
final class NnsInternetIdentityGetAccountsResponseErr
    extends NnsInternetIdentityGetAccountsResponse {
  final NnsInternetIdentityGetAccountsError value;
  const NnsInternetIdentityGetAccountsResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetAccountsResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityCreateAccount.response`.
sealed class NnsInternetIdentityCreateAccountResponse with CandidSerializable {
  const NnsInternetIdentityCreateAccountResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsInternetIdentityAccountInfo.ctype),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityCreateAccountError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityCreateAccountResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityCreateAccountResponseOk(
        json.valueTo<NnsInternetIdentityAccountInfo, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityAccountInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityCreateAccountResponseErr(
        json.valueTo<NnsInternetIdentityCreateAccountError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityCreateAccountError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityCreateAccountResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityCreateAccountResponse arm',
    );
  }

  factory NnsInternetIdentityCreateAccountResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityCreateAccountResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityCreateAccount.response.Ok`.
final class NnsInternetIdentityCreateAccountResponseOk
    extends NnsInternetIdentityCreateAccountResponse {
  final NnsInternetIdentityAccountInfo value;
  const NnsInternetIdentityCreateAccountResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityCreateAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityCreateAccount.response.Err`.
final class NnsInternetIdentityCreateAccountResponseErr
    extends NnsInternetIdentityCreateAccountResponse {
  final NnsInternetIdentityCreateAccountError value;
  const NnsInternetIdentityCreateAccountResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityCreateAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityUpdateAccount.response`.
sealed class NnsInternetIdentityUpdateAccountResponse with CandidSerializable {
  const NnsInternetIdentityUpdateAccountResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsInternetIdentityAccountInfo.ctype),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityUpdateAccountError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityUpdateAccountResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityUpdateAccountResponseOk(
        json.valueTo<NnsInternetIdentityAccountInfo, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityAccountInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityUpdateAccountResponseErr(
        json.valueTo<NnsInternetIdentityUpdateAccountError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityUpdateAccountError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityUpdateAccountResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityUpdateAccountResponse arm',
    );
  }

  factory NnsInternetIdentityUpdateAccountResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityUpdateAccountResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityUpdateAccount.response.Ok`.
final class NnsInternetIdentityUpdateAccountResponseOk
    extends NnsInternetIdentityUpdateAccountResponse {
  final NnsInternetIdentityAccountInfo value;
  const NnsInternetIdentityUpdateAccountResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityUpdateAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityUpdateAccount.response.Err`.
final class NnsInternetIdentityUpdateAccountResponseErr
    extends NnsInternetIdentityUpdateAccountResponse {
  final NnsInternetIdentityUpdateAccountError value;
  const NnsInternetIdentityUpdateAccountResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityUpdateAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityPrepareAccountDelegation.response`.
sealed class NnsInternetIdentityPrepareAccountDelegationResponse
    with CandidSerializable {
  const NnsInternetIdentityPrepareAccountDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityPrepareAccountDelegation.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAccountDelegationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPrepareAccountDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityPrepareAccountDelegationResponseOk(
        json.valueTo<NnsInternetIdentityPrepareAccountDelegation, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityPrepareAccountDelegation.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityPrepareAccountDelegationResponseErr(
        json.valueTo<NnsInternetIdentityAccountDelegationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityAccountDelegationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPrepareAccountDelegationResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityPrepareAccountDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityPrepareAccountDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareAccountDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityPrepareAccountDelegation.response.Ok`.
final class NnsInternetIdentityPrepareAccountDelegationResponseOk
    extends NnsInternetIdentityPrepareAccountDelegationResponse {
  final NnsInternetIdentityPrepareAccountDelegation value;
  const NnsInternetIdentityPrepareAccountDelegationResponseOk(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityPrepareAccountDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityPrepareAccountDelegation.response.Err`.
final class NnsInternetIdentityPrepareAccountDelegationResponseErr
    extends NnsInternetIdentityPrepareAccountDelegationResponse {
  final NnsInternetIdentityAccountDelegationError value;
  const NnsInternetIdentityPrepareAccountDelegationResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityPrepareAccountDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityGetAccountDelegation.response`.
sealed class NnsInternetIdentityGetAccountDelegationResponse
    with CandidSerializable {
  const NnsInternetIdentityGetAccountDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentitySignedDelegation.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAccountDelegationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetAccountDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityGetAccountDelegationResponseOk(
        json.valueTo<NnsInternetIdentitySignedDelegation, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentitySignedDelegation.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityGetAccountDelegationResponseErr(
        json.valueTo<NnsInternetIdentityAccountDelegationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityAccountDelegationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetAccountDelegationResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetAccountDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityGetAccountDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetAccountDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityGetAccountDelegation.response.Ok`.
final class NnsInternetIdentityGetAccountDelegationResponseOk
    extends NnsInternetIdentityGetAccountDelegationResponse {
  final NnsInternetIdentitySignedDelegation value;
  const NnsInternetIdentityGetAccountDelegationResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetAccountDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityGetAccountDelegation.response.Err`.
final class NnsInternetIdentityGetAccountDelegationResponseErr
    extends NnsInternetIdentityGetAccountDelegationResponse {
  final NnsInternetIdentityAccountDelegationError value;
  const NnsInternetIdentityGetAccountDelegationResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetAccountDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityMcpSetConfig.response`.
sealed class NnsInternetIdentityMcpSetConfigResponse with CandidSerializable {
  const NnsInternetIdentityMcpSetConfigResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    Field(Label.named('Err'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityMcpSetConfigResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return const NnsInternetIdentityMcpSetConfigResponseOk();
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityMcpSetConfigResponseErr(
        json.valueAsString<String>('Err'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityMcpSetConfigResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityMcpSetConfigResponse arm',
    );
  }

  factory NnsInternetIdentityMcpSetConfigResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMcpSetConfigResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityMcpSetConfig.response.Ok` (nullary).
final class NnsInternetIdentityMcpSetConfigResponseOk
    extends NnsInternetIdentityMcpSetConfigResponse {
  const NnsInternetIdentityMcpSetConfigResponseOk();

  @override
  CType get candidType => NnsInternetIdentityMcpSetConfigResponse.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `NnsInternetIdentityMcpSetConfig.response.Err`.
final class NnsInternetIdentityMcpSetConfigResponseErr
    extends NnsInternetIdentityMcpSetConfigResponse {
  final String value;
  const NnsInternetIdentityMcpSetConfigResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityMcpSetConfigResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value);

  @override
  Map<String, dynamic> toJson() => {'Err': value};
}

/// Candid variant `NnsInternetIdentityMcpPrepareDelegation.response`.
sealed class NnsInternetIdentityMcpPrepareDelegationResponse
    with CandidSerializable {
  const NnsInternetIdentityMcpPrepareDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityMcpPrepareDelegation.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAccountDelegationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityMcpPrepareDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityMcpPrepareDelegationResponseOk(
        json.valueTo<NnsInternetIdentityMcpPrepareDelegation, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityMcpPrepareDelegation.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityMcpPrepareDelegationResponseErr(
        json.valueTo<NnsInternetIdentityAccountDelegationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityAccountDelegationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityMcpPrepareDelegationResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityMcpPrepareDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityMcpPrepareDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMcpPrepareDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityMcpPrepareDelegation.response.Ok`.
final class NnsInternetIdentityMcpPrepareDelegationResponseOk
    extends NnsInternetIdentityMcpPrepareDelegationResponse {
  final NnsInternetIdentityMcpPrepareDelegation value;
  const NnsInternetIdentityMcpPrepareDelegationResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityMcpPrepareDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityMcpPrepareDelegation.response.Err`.
final class NnsInternetIdentityMcpPrepareDelegationResponseErr
    extends NnsInternetIdentityMcpPrepareDelegationResponse {
  final NnsInternetIdentityAccountDelegationError value;
  const NnsInternetIdentityMcpPrepareDelegationResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityMcpPrepareDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityMcpGetAccounts.response`.
sealed class NnsInternetIdentityMcpGetAccountsResponse with CandidSerializable {
  const NnsInternetIdentityMcpGetAccountsResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => CType.vec(NnsInternetIdentityAccountInfo.ctype),
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityAccountDelegationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityMcpGetAccountsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityMcpGetAccountsResponseOk(
        json.valueTo<List<NnsInternetIdentityAccountInfo>, List>(
          key: 'Ok',
          parse:
              (e) =>
                  e
                      .map<NnsInternetIdentityAccountInfo>(
                        (x) => NnsInternetIdentityAccountInfo.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityMcpGetAccountsResponseErr(
        json.valueTo<NnsInternetIdentityAccountDelegationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityAccountDelegationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityMcpGetAccountsResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityMcpGetAccountsResponse arm',
    );
  }

  factory NnsInternetIdentityMcpGetAccountsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMcpGetAccountsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityMcpGetAccounts.response.Ok`.
final class NnsInternetIdentityMcpGetAccountsResponseOk
    extends NnsInternetIdentityMcpGetAccountsResponse {
  final List<NnsInternetIdentityAccountInfo> value;
  const NnsInternetIdentityMcpGetAccountsResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityMcpGetAccountsResponse.ctype;

  @override
  dynamic get candidValue =>
      Variant('Ok', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Ok': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `NnsInternetIdentityMcpGetAccounts.response.Err`.
final class NnsInternetIdentityMcpGetAccountsResponseErr
    extends NnsInternetIdentityMcpGetAccountsResponse {
  final NnsInternetIdentityAccountDelegationError value;
  const NnsInternetIdentityMcpGetAccountsResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityMcpGetAccountsResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityPrepareSessionDelegation.response`.
sealed class NnsInternetIdentityPrepareSessionDelegationResponse
    with CandidSerializable {
  const NnsInternetIdentityPrepareSessionDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityPrepareSessionDelegation.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentitySessionDelegationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPrepareSessionDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityPrepareSessionDelegationResponseOk(
        json.valueTo<NnsInternetIdentityPrepareSessionDelegation, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityPrepareSessionDelegation.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityPrepareSessionDelegationResponseErr(
        json.valueTo<NnsInternetIdentitySessionDelegationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentitySessionDelegationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPrepareSessionDelegationResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityPrepareSessionDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityPrepareSessionDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareSessionDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityPrepareSessionDelegation.response.Ok`.
final class NnsInternetIdentityPrepareSessionDelegationResponseOk
    extends NnsInternetIdentityPrepareSessionDelegationResponse {
  final NnsInternetIdentityPrepareSessionDelegation value;
  const NnsInternetIdentityPrepareSessionDelegationResponseOk(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityPrepareSessionDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityPrepareSessionDelegation.response.Err`.
final class NnsInternetIdentityPrepareSessionDelegationResponseErr
    extends NnsInternetIdentityPrepareSessionDelegationResponse {
  final NnsInternetIdentitySessionDelegationError value;
  const NnsInternetIdentityPrepareSessionDelegationResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityPrepareSessionDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityGetSessionDelegation.response`.
sealed class NnsInternetIdentityGetSessionDelegationResponse
    with CandidSerializable {
  const NnsInternetIdentityGetSessionDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentitySignedDelegation.ctype,
    ),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentitySessionDelegationError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetSessionDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityGetSessionDelegationResponseOk(
        json.valueTo<NnsInternetIdentitySignedDelegation, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentitySignedDelegation.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityGetSessionDelegationResponseErr(
        json.valueTo<NnsInternetIdentitySessionDelegationError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentitySessionDelegationError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetSessionDelegationResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetSessionDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityGetSessionDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetSessionDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityGetSessionDelegation.response.Ok`.
final class NnsInternetIdentityGetSessionDelegationResponseOk
    extends NnsInternetIdentityGetSessionDelegationResponse {
  final NnsInternetIdentitySignedDelegation value;
  const NnsInternetIdentityGetSessionDelegationResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetSessionDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityGetSessionDelegation.response.Err`.
final class NnsInternetIdentityGetSessionDelegationResponseErr
    extends NnsInternetIdentityGetSessionDelegationResponse {
  final NnsInternetIdentitySessionDelegationError value;
  const NnsInternetIdentityGetSessionDelegationResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetSessionDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentityPrepareMcpRegistrationDelegation.response`.
sealed class NnsInternetIdentityPrepareMcpRegistrationDelegationResponse
    with CandidSerializable {
  const NnsInternetIdentityPrepareMcpRegistrationDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityPrepareMcpRegistrationDelegation.ctype,
    ),
    Field(Label.named('Err'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPrepareMcpRegistrationDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityPrepareMcpRegistrationDelegationResponseOk(
        json.valueTo<NnsInternetIdentityPrepareMcpRegistrationDelegation, Map>(
          key: 'Ok',
          parse:
              (e) =>
                  NnsInternetIdentityPrepareMcpRegistrationDelegation.fromCandid(
                    JsonParser.valueEnsureAsMap<String, dynamic>(e),
                  ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityPrepareMcpRegistrationDelegationResponseErr(
        json.valueAsString<String>('Err'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPrepareMcpRegistrationDelegationResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityPrepareMcpRegistrationDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityPrepareMcpRegistrationDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareMcpRegistrationDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityPrepareMcpRegistrationDelegation.response.Ok`.
final class NnsInternetIdentityPrepareMcpRegistrationDelegationResponseOk
    extends NnsInternetIdentityPrepareMcpRegistrationDelegationResponse {
  final NnsInternetIdentityPrepareMcpRegistrationDelegation value;
  const NnsInternetIdentityPrepareMcpRegistrationDelegationResponseOk(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityPrepareMcpRegistrationDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityPrepareMcpRegistrationDelegation.response.Err`.
final class NnsInternetIdentityPrepareMcpRegistrationDelegationResponseErr
    extends NnsInternetIdentityPrepareMcpRegistrationDelegationResponse {
  final String value;
  const NnsInternetIdentityPrepareMcpRegistrationDelegationResponseErr(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityPrepareMcpRegistrationDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value);

  @override
  Map<String, dynamic> toJson() => {'Err': value};
}

/// Candid variant `NnsInternetIdentityGetMcpRegistrationDelegation.response`.
sealed class NnsInternetIdentityGetMcpRegistrationDelegationResponse
    with CandidSerializable {
  const NnsInternetIdentityGetMcpRegistrationDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentitySignedDelegation.ctype,
    ),
    Field(Label.named('Err'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetMcpRegistrationDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityGetMcpRegistrationDelegationResponseOk(
        json.valueTo<NnsInternetIdentitySignedDelegation, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentitySignedDelegation.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityGetMcpRegistrationDelegationResponseErr(
        json.valueAsString<String>('Err'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetMcpRegistrationDelegationResponse.fromCandid',
      reason:
          'Unknown NnsInternetIdentityGetMcpRegistrationDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityGetMcpRegistrationDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetMcpRegistrationDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityGetMcpRegistrationDelegation.response.Ok`.
final class NnsInternetIdentityGetMcpRegistrationDelegationResponseOk
    extends NnsInternetIdentityGetMcpRegistrationDelegationResponse {
  final NnsInternetIdentitySignedDelegation value;
  const NnsInternetIdentityGetMcpRegistrationDelegationResponseOk(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityGetMcpRegistrationDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityGetMcpRegistrationDelegation.response.Err`.
final class NnsInternetIdentityGetMcpRegistrationDelegationResponseErr
    extends NnsInternetIdentityGetMcpRegistrationDelegationResponse {
  final String value;
  const NnsInternetIdentityGetMcpRegistrationDelegationResponseErr(this.value);

  @override
  CType get candidType =>
      NnsInternetIdentityGetMcpRegistrationDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value);

  @override
  Map<String, dynamic> toJson() => {'Err': value};
}

/// Candid variant `NnsInternetIdentityMcpRegisterV2.response`.
sealed class NnsInternetIdentityMcpRegisterV2Response with CandidSerializable {
  const NnsInternetIdentityMcpRegisterV2Response();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsInternetIdentityMcpRegistrationV2.ctype,
    ),
    Field(Label.named('Err'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityMcpRegisterV2Response.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityMcpRegisterV2ResponseOk(
        json.valueTo<NnsInternetIdentityMcpRegistrationV2, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityMcpRegistrationV2.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityMcpRegisterV2ResponseErr(
        json.valueAsString<String>('Err'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityMcpRegisterV2Response.fromCandid',
      reason: 'Unknown NnsInternetIdentityMcpRegisterV2Response arm',
    );
  }

  factory NnsInternetIdentityMcpRegisterV2Response.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMcpRegisterV2Response.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityMcpRegisterV2.response.Ok`.
final class NnsInternetIdentityMcpRegisterV2ResponseOk
    extends NnsInternetIdentityMcpRegisterV2Response {
  final NnsInternetIdentityMcpRegistrationV2 value;
  const NnsInternetIdentityMcpRegisterV2ResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityMcpRegisterV2Response.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityMcpRegisterV2.response.Err`.
final class NnsInternetIdentityMcpRegisterV2ResponseErr
    extends NnsInternetIdentityMcpRegisterV2Response {
  final String value;
  const NnsInternetIdentityMcpRegisterV2ResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityMcpRegisterV2Response.ctype;

  @override
  dynamic get candidValue => Variant('Err', value);

  @override
  Map<String, dynamic> toJson() => {'Err': value};
}

/// Candid variant `NnsInternetIdentityGetDefaultAccount.response`.
sealed class NnsInternetIdentityGetDefaultAccountResponse
    with CandidSerializable {
  const NnsInternetIdentityGetDefaultAccountResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsInternetIdentityAccountInfo.ctype),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentityGetDefaultAccountError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetDefaultAccountResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentityGetDefaultAccountResponseOk(
        json.valueTo<NnsInternetIdentityAccountInfo, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityAccountInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentityGetDefaultAccountResponseErr(
        json.valueTo<NnsInternetIdentityGetDefaultAccountError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentityGetDefaultAccountError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetDefaultAccountResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetDefaultAccountResponse arm',
    );
  }

  factory NnsInternetIdentityGetDefaultAccountResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetDefaultAccountResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentityGetDefaultAccount.response.Ok`.
final class NnsInternetIdentityGetDefaultAccountResponseOk
    extends NnsInternetIdentityGetDefaultAccountResponse {
  final NnsInternetIdentityAccountInfo value;
  const NnsInternetIdentityGetDefaultAccountResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetDefaultAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentityGetDefaultAccount.response.Err`.
final class NnsInternetIdentityGetDefaultAccountResponseErr
    extends NnsInternetIdentityGetDefaultAccountResponse {
  final NnsInternetIdentityGetDefaultAccountError value;
  const NnsInternetIdentityGetDefaultAccountResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetDefaultAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NnsInternetIdentitySetDefaultAccount.response`.
sealed class NnsInternetIdentitySetDefaultAccountResponse
    with CandidSerializable {
  const NnsInternetIdentitySetDefaultAccountResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsInternetIdentityAccountInfo.ctype),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentitySetDefaultAccountError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentitySetDefaultAccountResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentitySetDefaultAccountResponseOk(
        json.valueTo<NnsInternetIdentityAccountInfo, Map>(
          key: 'Ok',
          parse:
              (e) => NnsInternetIdentityAccountInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentitySetDefaultAccountResponseErr(
        json.valueTo<NnsInternetIdentitySetDefaultAccountError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentitySetDefaultAccountError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentitySetDefaultAccountResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentitySetDefaultAccountResponse arm',
    );
  }

  factory NnsInternetIdentitySetDefaultAccountResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySetDefaultAccountResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NnsInternetIdentitySetDefaultAccount.response.Ok`.
final class NnsInternetIdentitySetDefaultAccountResponseOk
    extends NnsInternetIdentitySetDefaultAccountResponse {
  final NnsInternetIdentityAccountInfo value;
  const NnsInternetIdentitySetDefaultAccountResponseOk(this.value);

  @override
  CType get candidType => NnsInternetIdentitySetDefaultAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NnsInternetIdentitySetDefaultAccount.response.Err`.
final class NnsInternetIdentitySetDefaultAccountResponseErr
    extends NnsInternetIdentitySetDefaultAccountResponse {
  final NnsInternetIdentitySetDefaultAccountError value;
  const NnsInternetIdentitySetDefaultAccountResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentitySetDefaultAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `HeaderField`.
final class NnsInternetIdentityHeaderField with CandidSerializable {
  final String field0;
  final String field1;

  const NnsInternetIdentityHeaderField({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    Field(Label.id(1), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1};

  factory NnsInternetIdentityHeaderField.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityHeaderField(
      field0: json.valueAsString<String>('0'),
      field1: json.valueAsString<String>('1'),
    );
  }

  factory NnsInternetIdentityHeaderField.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityHeaderField.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `HttpRequest`.
final class NnsInternetIdentityHttpRequest with CandidSerializable {
  final String method;
  final String url;
  final List<NnsInternetIdentityHeaderField> headers;
  final List<int> body;
  final int? certificateVersion;

  const NnsInternetIdentityHttpRequest({
    required this.method,
    required this.url,
    required this.headers,
    required this.body,
    this.certificateVersion,
  });

  static CType get ctype => CType.record([
    Field(Label.named('method'), CType.text),
    Field(Label.named('url'), CType.text),
    LazyField(
      Label.named('headers'),
      () => CType.vec(NnsInternetIdentityHeaderField.ctype),
    ),
    Field(Label.named('body'), CType.vec(CType.nat8)),
    Field(Label.named('certificate_version'), CType.opt(CType.nat16)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'method': method,
    'url': url,
    'headers': headers.map((el) => el.candidValue).toList(),
    'body': body,
    'certificate_version': certificateVersion,
  };

  Map<String, dynamic> toJson() => {
    'method': method,
    'url': url,
    'headers': headers.map((el) => el.toJson()).toList(),
    'body': body,
    'certificate_version': certificateVersion,
  };

  factory NnsInternetIdentityHttpRequest.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityHttpRequest(
      method: json.valueAsString<String>('method'),
      url: json.valueAsString<String>('url'),
      headers: json.valueTo<List<NnsInternetIdentityHeaderField>, List>(
        key: 'headers',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityHeaderField>(
                      (x) => NnsInternetIdentityHeaderField.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      body: json.valueAsBytes<List<int>>(
        'body',
        encoding: StringEncoding.base64,
      ),
      certificateVersion: json.valueAsInt<int?>('certificate_version'),
    );
  }

  factory NnsInternetIdentityHttpRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityHttpRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `HttpResponse`.
final class NnsInternetIdentityHttpResponse with CandidSerializable {
  final int statusCode;
  final List<NnsInternetIdentityHeaderField> headers;
  final List<int> body;
  final bool? upgrade;

  const NnsInternetIdentityHttpResponse({
    required this.statusCode,
    required this.headers,
    required this.body,
    this.upgrade,
  });

  static CType get ctype => CType.record([
    Field(Label.named('status_code'), CType.nat16),
    LazyField(
      Label.named('headers'),
      () => CType.vec(NnsInternetIdentityHeaderField.ctype),
    ),
    Field(Label.named('body'), CType.vec(CType.nat8)),
    Field(Label.named('upgrade'), CType.opt(CType.bool_)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'status_code': statusCode,
    'headers': headers.map((el) => el.candidValue).toList(),
    'body': body,
    'upgrade': upgrade,
  };

  Map<String, dynamic> toJson() => {
    'status_code': statusCode,
    'headers': headers.map((el) => el.toJson()).toList(),
    'body': body,
    'upgrade': upgrade,
  };

  factory NnsInternetIdentityHttpResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityHttpResponse(
      statusCode: json.valueAsInt<int>('status_code'),
      headers: json.valueTo<List<NnsInternetIdentityHeaderField>, List>(
        key: 'headers',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityHeaderField>(
                      (x) => NnsInternetIdentityHeaderField.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      body: json.valueAsBytes<List<int>>(
        'body',
        encoding: StringEncoding.base64,
      ),
      upgrade: json.valueAsBool<bool?>('upgrade'),
    );
  }

  factory NnsInternetIdentityHttpResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityHttpResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `StreamingCallbackHttpResponse`.
final class NnsInternetIdentityStreamingCallbackHttpResponse
    with CandidSerializable {
  final List<int> body;
  final NnsInternetIdentityToken? token;

  const NnsInternetIdentityStreamingCallbackHttpResponse({
    required this.body,
    this.token,
  });

  static CType get ctype => CType.record([
    Field(Label.named('body'), CType.vec(CType.nat8)),
    LazyField(
      Label.named('token'),
      () => CType.opt(NnsInternetIdentityToken.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'body': body, 'token': token?.candidValue};

  Map<String, dynamic> toJson() => {'body': body, 'token': token?.toJson()};

  factory NnsInternetIdentityStreamingCallbackHttpResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityStreamingCallbackHttpResponse(
      body: json.valueAsBytes<List<int>>(
        'body',
        encoding: StringEncoding.base64,
      ),
      token: json.valueTo<NnsInternetIdentityToken?, Map>(
        key: 'token',
        parse:
            (e) => NnsInternetIdentityToken.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentityStreamingCallbackHttpResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityStreamingCallbackHttpResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Token`.
final class NnsInternetIdentityToken with CandidSerializable {
  const NnsInternetIdentityToken();

  static CType get ctype => CType.record(const []);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => <String, dynamic>{};

  Map<String, dynamic> toJson() => <String, dynamic>{};

  factory NnsInternetIdentityToken.fromCandid(Map<String, dynamic> json) {
    return const NnsInternetIdentityToken();
  }

  factory NnsInternetIdentityToken.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityToken.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `StreamingStrategy`.
sealed class NnsInternetIdentityStreamingStrategy with CandidSerializable {
  const NnsInternetIdentityStreamingStrategy();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Callback'),
      () => CType.record([
        Field(
          Label.named('callback'),
          CType.func(const FunctionType([], [], [])),
        ),
        LazyField(Label.named('token'), () => NnsInternetIdentityToken.ctype),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityStreamingStrategy.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Callback')) {
      return NnsInternetIdentityStreamingStrategyCallback.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Callback']),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityStreamingStrategy.fromCandid',
      reason: 'Unknown NnsInternetIdentityStreamingStrategy arm',
    );
  }

  factory NnsInternetIdentityStreamingStrategy.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityStreamingStrategy.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `StreamingStrategy.Callback`.
final class NnsInternetIdentityStreamingStrategyCallback
    extends NnsInternetIdentityStreamingStrategy {
  final FuncRef callback;
  final NnsInternetIdentityToken token;

  const NnsInternetIdentityStreamingStrategyCallback({
    required this.callback,
    required this.token,
  });

  @override
  CType get candidType => NnsInternetIdentityStreamingStrategy.ctype;

  @override
  dynamic get candidValue =>
      Variant('Callback', {'callback': callback, 'token': token.candidValue});

  @override
  Map<String, dynamic> toJson() => {
    'Callback': {'callback': callback, 'token': token.toJson()},
  };

  factory NnsInternetIdentityStreamingStrategyCallback.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityStreamingStrategyCallback(
      callback: json['callback'],
      token: json.valueTo<NnsInternetIdentityToken, Map>(
        key: 'token',
        parse:
            (e) => NnsInternetIdentityToken.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }
}

/// Candid variant `Purpose`.
sealed class NnsInternetIdentityPurpose with CandidSerializable {
  const NnsInternetIdentityPurpose();

  static CType get ctype => CType.variant([
    Field(Label.named('recovery'), CType.null_),
    Field(Label.named('authentication'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPurpose.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('recovery')) {
      return const NnsInternetIdentityPurposeRecovery();
    }
    if (json.containsKey('authentication')) {
      return const NnsInternetIdentityPurposeAuthentication();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPurpose.fromCandid',
      reason: 'Unknown NnsInternetIdentityPurpose arm',
    );
  }

  factory NnsInternetIdentityPurpose.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPurpose.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Purpose.recovery` (nullary).
final class NnsInternetIdentityPurposeRecovery
    extends NnsInternetIdentityPurpose {
  const NnsInternetIdentityPurposeRecovery();

  @override
  CType get candidType => NnsInternetIdentityPurpose.ctype;

  @override
  dynamic get candidValue => const Variant('recovery', null);

  @override
  Map<String, dynamic> toJson() => {'recovery': null};
}

/// Variant arm `Purpose.authentication` (nullary).
final class NnsInternetIdentityPurposeAuthentication
    extends NnsInternetIdentityPurpose {
  const NnsInternetIdentityPurposeAuthentication();

  @override
  CType get candidType => NnsInternetIdentityPurpose.ctype;

  @override
  dynamic get candidValue => const Variant('authentication', null);

  @override
  Map<String, dynamic> toJson() => {'authentication': null};
}

/// Candid variant `KeyType`.
sealed class NnsInternetIdentityKeyType with CandidSerializable {
  const NnsInternetIdentityKeyType();

  static CType get ctype => CType.variant([
    Field(Label.named('unknown'), CType.null_),
    Field(Label.named('platform'), CType.null_),
    Field(Label.named('cross_platform'), CType.null_),
    Field(Label.named('seed_phrase'), CType.null_),
    Field(Label.named('browser_storage_key'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityKeyType.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('unknown')) {
      return const NnsInternetIdentityKeyTypeUnknown();
    }
    if (json.containsKey('platform')) {
      return const NnsInternetIdentityKeyTypePlatform();
    }
    if (json.containsKey('cross_platform')) {
      return const NnsInternetIdentityKeyTypeCrossPlatform();
    }
    if (json.containsKey('seed_phrase')) {
      return const NnsInternetIdentityKeyTypeSeedPhrase();
    }
    if (json.containsKey('browser_storage_key')) {
      return const NnsInternetIdentityKeyTypeBrowserStorageKey();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityKeyType.fromCandid',
      reason: 'Unknown NnsInternetIdentityKeyType arm',
    );
  }

  factory NnsInternetIdentityKeyType.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityKeyType.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `KeyType.unknown` (nullary).
final class NnsInternetIdentityKeyTypeUnknown
    extends NnsInternetIdentityKeyType {
  const NnsInternetIdentityKeyTypeUnknown();

  @override
  CType get candidType => NnsInternetIdentityKeyType.ctype;

  @override
  dynamic get candidValue => const Variant('unknown', null);

  @override
  Map<String, dynamic> toJson() => {'unknown': null};
}

/// Variant arm `KeyType.platform` (nullary).
final class NnsInternetIdentityKeyTypePlatform
    extends NnsInternetIdentityKeyType {
  const NnsInternetIdentityKeyTypePlatform();

  @override
  CType get candidType => NnsInternetIdentityKeyType.ctype;

  @override
  dynamic get candidValue => const Variant('platform', null);

  @override
  Map<String, dynamic> toJson() => {'platform': null};
}

/// Variant arm `KeyType.cross_platform` (nullary).
final class NnsInternetIdentityKeyTypeCrossPlatform
    extends NnsInternetIdentityKeyType {
  const NnsInternetIdentityKeyTypeCrossPlatform();

  @override
  CType get candidType => NnsInternetIdentityKeyType.ctype;

  @override
  dynamic get candidValue => const Variant('cross_platform', null);

  @override
  Map<String, dynamic> toJson() => {'cross_platform': null};
}

/// Variant arm `KeyType.seed_phrase` (nullary).
final class NnsInternetIdentityKeyTypeSeedPhrase
    extends NnsInternetIdentityKeyType {
  const NnsInternetIdentityKeyTypeSeedPhrase();

  @override
  CType get candidType => NnsInternetIdentityKeyType.ctype;

  @override
  dynamic get candidValue => const Variant('seed_phrase', null);

  @override
  Map<String, dynamic> toJson() => {'seed_phrase': null};
}

/// Variant arm `KeyType.browser_storage_key` (nullary).
final class NnsInternetIdentityKeyTypeBrowserStorageKey
    extends NnsInternetIdentityKeyType {
  const NnsInternetIdentityKeyTypeBrowserStorageKey();

  @override
  CType get candidType => NnsInternetIdentityKeyType.ctype;

  @override
  dynamic get candidValue => const Variant('browser_storage_key', null);

  @override
  Map<String, dynamic> toJson() => {'browser_storage_key': null};
}

/// Candid variant `DeviceProtection`.
sealed class NnsInternetIdentityDeviceProtection with CandidSerializable {
  const NnsInternetIdentityDeviceProtection();

  static CType get ctype => CType.variant([
    Field(Label.named('protected'), CType.null_),
    Field(Label.named('unprotected'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityDeviceProtection.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('protected')) {
      return const NnsInternetIdentityDeviceProtectionProtected();
    }
    if (json.containsKey('unprotected')) {
      return const NnsInternetIdentityDeviceProtectionUnprotected();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityDeviceProtection.fromCandid',
      reason: 'Unknown NnsInternetIdentityDeviceProtection arm',
    );
  }

  factory NnsInternetIdentityDeviceProtection.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDeviceProtection.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `DeviceProtection.protected` (nullary).
final class NnsInternetIdentityDeviceProtectionProtected
    extends NnsInternetIdentityDeviceProtection {
  const NnsInternetIdentityDeviceProtectionProtected();

  @override
  CType get candidType => NnsInternetIdentityDeviceProtection.ctype;

  @override
  dynamic get candidValue => const Variant('protected', null);

  @override
  Map<String, dynamic> toJson() => {'protected': null};
}

/// Variant arm `DeviceProtection.unprotected` (nullary).
final class NnsInternetIdentityDeviceProtectionUnprotected
    extends NnsInternetIdentityDeviceProtection {
  const NnsInternetIdentityDeviceProtectionUnprotected();

  @override
  CType get candidType => NnsInternetIdentityDeviceProtection.ctype;

  @override
  dynamic get candidValue => const Variant('unprotected', null);

  @override
  Map<String, dynamic> toJson() => {'unprotected': null};
}

/// Candid record `Challenge`.
final class NnsInternetIdentityChallenge with CandidSerializable {
  final String pngBase64;
  final NnsInternetIdentityChallengeKey challengeKey;

  const NnsInternetIdentityChallenge({
    required this.pngBase64,
    required this.challengeKey,
  });

  static CType get ctype => CType.record([
    Field(Label.named('png_base64'), CType.text),
    Field(Label.named('challenge_key'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'png_base64': pngBase64,
    'challenge_key': challengeKey,
  };

  Map<String, dynamic> toJson() => {
    'png_base64': pngBase64,
    'challenge_key': challengeKey,
  };

  factory NnsInternetIdentityChallenge.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityChallenge(
      pngBase64: json.valueAsString<String>('png_base64'),
      challengeKey: json.valueAsString<String>('challenge_key'),
    );
  }

  factory NnsInternetIdentityChallenge.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityChallenge.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DeviceData`.
final class NnsInternetIdentityDeviceData with CandidSerializable {
  final NnsInternetIdentityDeviceKey pubkey;
  final String alias;
  final NnsInternetIdentityCredentialId? credentialId;
  final NnsInternetIdentityAaguid? aaguid;
  final NnsInternetIdentityPurpose purpose;
  final NnsInternetIdentityKeyType keyType;
  final NnsInternetIdentityDeviceProtection protection;
  final String? origin;
  final NnsInternetIdentityMetadataMap? metadata;

  const NnsInternetIdentityDeviceData({
    required this.pubkey,
    required this.alias,
    this.credentialId,
    this.aaguid,
    required this.purpose,
    required this.keyType,
    required this.protection,
    this.origin,
    this.metadata,
  });

  static CType get ctype => CType.record([
    Field(Label.named('pubkey'), CType.vec(CType.nat8)),
    Field(Label.named('alias'), CType.text),
    Field(Label.named('credential_id'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('aaguid'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('purpose'), () => NnsInternetIdentityPurpose.ctype),
    LazyField(Label.named('key_type'), () => NnsInternetIdentityKeyType.ctype),
    LazyField(
      Label.named('protection'),
      () => NnsInternetIdentityDeviceProtection.ctype,
    ),
    Field(Label.named('origin'), CType.opt(CType.text)),
    LazyField(
      Label.named('metadata'),
      () => CType.opt(NnsInternetIdentityMetadataMapCandid.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'pubkey': pubkey,
    'alias': alias,
    'credential_id': credentialId,
    'aaguid': aaguid,
    'purpose': purpose.candidValue,
    'key_type': keyType.candidValue,
    'protection': protection.candidValue,
    'origin': origin,
    'metadata': metadata?.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'pubkey': pubkey,
    'alias': alias,
    'credential_id': credentialId,
    'aaguid': aaguid,
    'purpose': purpose.toJson(),
    'key_type': keyType.toJson(),
    'protection': protection.toJson(),
    'origin': origin,
    'metadata': metadata?.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityDeviceData.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityDeviceData(
      pubkey: json.valueAsBytes<List<int>>(
        'pubkey',
        encoding: StringEncoding.base64,
      ),
      alias: json.valueAsString<String>('alias'),
      credentialId: json.valueAsBytes<List<int>?>(
        'credential_id',
        encoding: StringEncoding.base64,
      ),
      aaguid: json.valueAsBytes<List<int>?>(
        'aaguid',
        encoding: StringEncoding.base64,
      ),
      purpose: json.valueTo<NnsInternetIdentityPurpose, Map>(
        key: 'purpose',
        parse:
            (e) => NnsInternetIdentityPurpose.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      keyType: json.valueTo<NnsInternetIdentityKeyType, Map>(
        key: 'key_type',
        parse:
            (e) => NnsInternetIdentityKeyType.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      protection: json.valueTo<NnsInternetIdentityDeviceProtection, Map>(
        key: 'protection',
        parse:
            (e) => NnsInternetIdentityDeviceProtection.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      origin: json.valueAsString<String?>('origin'),
      metadata: json.valueTo<List<NnsInternetIdentityMetadataMapItem>?, List>(
        key: 'metadata',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityMetadataMapItem>(
                      (x) => NnsInternetIdentityMetadataMapItem.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityDeviceData.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDeviceData.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DeviceWithUsage`.
final class NnsInternetIdentityDeviceWithUsage with CandidSerializable {
  final NnsInternetIdentityDeviceKey pubkey;
  final String alias;
  final NnsInternetIdentityCredentialId? credentialId;
  final NnsInternetIdentityAaguid? aaguid;
  final NnsInternetIdentityPurpose purpose;
  final NnsInternetIdentityKeyType keyType;
  final NnsInternetIdentityDeviceProtection protection;
  final String? origin;
  final NnsInternetIdentityTimestamp? lastUsage;
  final NnsInternetIdentityMetadataMap? metadata;

  const NnsInternetIdentityDeviceWithUsage({
    required this.pubkey,
    required this.alias,
    this.credentialId,
    this.aaguid,
    required this.purpose,
    required this.keyType,
    required this.protection,
    this.origin,
    this.lastUsage,
    this.metadata,
  });

  static CType get ctype => CType.record([
    Field(Label.named('pubkey'), CType.vec(CType.nat8)),
    Field(Label.named('alias'), CType.text),
    Field(Label.named('credential_id'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('aaguid'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('purpose'), () => NnsInternetIdentityPurpose.ctype),
    LazyField(Label.named('key_type'), () => NnsInternetIdentityKeyType.ctype),
    LazyField(
      Label.named('protection'),
      () => NnsInternetIdentityDeviceProtection.ctype,
    ),
    Field(Label.named('origin'), CType.opt(CType.text)),
    Field(Label.named('last_usage'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('metadata'),
      () => CType.opt(NnsInternetIdentityMetadataMapCandid.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'pubkey': pubkey,
    'alias': alias,
    'credential_id': credentialId,
    'aaguid': aaguid,
    'purpose': purpose.candidValue,
    'key_type': keyType.candidValue,
    'protection': protection.candidValue,
    'origin': origin,
    'last_usage': lastUsage,
    'metadata': metadata?.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'pubkey': pubkey,
    'alias': alias,
    'credential_id': credentialId,
    'aaguid': aaguid,
    'purpose': purpose.toJson(),
    'key_type': keyType.toJson(),
    'protection': protection.toJson(),
    'origin': origin,
    'last_usage': lastUsage,
    'metadata': metadata?.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityDeviceWithUsage.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityDeviceWithUsage(
      pubkey: json.valueAsBytes<List<int>>(
        'pubkey',
        encoding: StringEncoding.base64,
      ),
      alias: json.valueAsString<String>('alias'),
      credentialId: json.valueAsBytes<List<int>?>(
        'credential_id',
        encoding: StringEncoding.base64,
      ),
      aaguid: json.valueAsBytes<List<int>?>(
        'aaguid',
        encoding: StringEncoding.base64,
      ),
      purpose: json.valueTo<NnsInternetIdentityPurpose, Map>(
        key: 'purpose',
        parse:
            (e) => NnsInternetIdentityPurpose.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      keyType: json.valueTo<NnsInternetIdentityKeyType, Map>(
        key: 'key_type',
        parse:
            (e) => NnsInternetIdentityKeyType.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      protection: json.valueTo<NnsInternetIdentityDeviceProtection, Map>(
        key: 'protection',
        parse:
            (e) => NnsInternetIdentityDeviceProtection.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      origin: json.valueAsString<String?>('origin'),
      lastUsage: json.valueAsBigInt<BigInt?>('last_usage'),
      metadata: json.valueTo<List<NnsInternetIdentityMetadataMapItem>?, List>(
        key: 'metadata',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityMetadataMapItem>(
                      (x) => NnsInternetIdentityMetadataMapItem.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityDeviceWithUsage.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDeviceWithUsage.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DeviceKeyWithAnchor`.
final class NnsInternetIdentityDeviceKeyWithAnchor with CandidSerializable {
  final NnsInternetIdentityDeviceKey pubkey;
  final NnsInternetIdentityUserNumber anchorNumber;

  const NnsInternetIdentityDeviceKeyWithAnchor({
    required this.pubkey,
    required this.anchorNumber,
  });

  static CType get ctype => CType.record([
    Field(Label.named('pubkey'), CType.vec(CType.nat8)),
    Field(Label.named('anchor_number'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'pubkey': pubkey, 'anchor_number': anchorNumber};

  Map<String, dynamic> toJson() => {
    'pubkey': pubkey,
    'anchor_number': anchorNumber,
  };

  factory NnsInternetIdentityDeviceKeyWithAnchor.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityDeviceKeyWithAnchor(
      pubkey: json.valueAsBytes<List<int>>(
        'pubkey',
        encoding: StringEncoding.base64,
      ),
      anchorNumber: json.valueAsBigInt<BigInt>('anchor_number'),
    );
  }

  factory NnsInternetIdentityDeviceKeyWithAnchor.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDeviceKeyWithAnchor.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `RegisterResponse`.
sealed class NnsInternetIdentityRegisterResponse with CandidSerializable {
  const NnsInternetIdentityRegisterResponse();

  static CType get ctype => CType.variant([
    Field(
      Label.named('registered'),
      CType.record([Field(Label.named('user_number'), CType.nat64)]),
    ),
    Field(Label.named('canister_full'), CType.null_),
    Field(Label.named('bad_challenge'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityRegisterResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('registered')) {
      return NnsInternetIdentityRegisterResponseRegistered.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['registered']),
      );
    }
    if (json.containsKey('canister_full')) {
      return const NnsInternetIdentityRegisterResponseCanisterFull();
    }
    if (json.containsKey('bad_challenge')) {
      return const NnsInternetIdentityRegisterResponseBadChallenge();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityRegisterResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityRegisterResponse arm',
    );
  }

  factory NnsInternetIdentityRegisterResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityRegisterResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `RegisterResponse.registered`.
final class NnsInternetIdentityRegisterResponseRegistered
    extends NnsInternetIdentityRegisterResponse {
  final NnsInternetIdentityUserNumber userNumber;

  const NnsInternetIdentityRegisterResponseRegistered({
    required this.userNumber,
  });

  @override
  CType get candidType => NnsInternetIdentityRegisterResponse.ctype;

  @override
  dynamic get candidValue => Variant('registered', {'user_number': userNumber});

  @override
  Map<String, dynamic> toJson() => {
    'registered': {'user_number': userNumber},
  };

  factory NnsInternetIdentityRegisterResponseRegistered.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityRegisterResponseRegistered(
      userNumber: json.valueAsBigInt<BigInt>('user_number'),
    );
  }
}

/// Variant arm `RegisterResponse.canister_full` (nullary).
final class NnsInternetIdentityRegisterResponseCanisterFull
    extends NnsInternetIdentityRegisterResponse {
  const NnsInternetIdentityRegisterResponseCanisterFull();

  @override
  CType get candidType => NnsInternetIdentityRegisterResponse.ctype;

  @override
  dynamic get candidValue => const Variant('canister_full', null);

  @override
  Map<String, dynamic> toJson() => {'canister_full': null};
}

/// Variant arm `RegisterResponse.bad_challenge` (nullary).
final class NnsInternetIdentityRegisterResponseBadChallenge
    extends NnsInternetIdentityRegisterResponse {
  const NnsInternetIdentityRegisterResponseBadChallenge();

  @override
  CType get candidType => NnsInternetIdentityRegisterResponse.ctype;

  @override
  dynamic get candidValue => const Variant('bad_challenge', null);

  @override
  Map<String, dynamic> toJson() => {'bad_challenge': null};
}

/// Candid variant `AddTentativeDeviceResponse`.
sealed class NnsInternetIdentityAddTentativeDeviceResponse
    with CandidSerializable {
  const NnsInternetIdentityAddTentativeDeviceResponse();

  static CType get ctype => CType.variant([
    Field(
      Label.named('added_tentatively'),
      CType.record([
        Field(Label.named('verification_code'), CType.text),
        Field(Label.named('device_registration_timeout'), CType.nat64),
      ]),
    ),
    Field(Label.named('device_registration_mode_off'), CType.null_),
    Field(Label.named('another_device_tentatively_added'), CType.null_),
    Field(
      Label.named('passkey_with_this_public_key_is_already_used'),
      CType.null_,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAddTentativeDeviceResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('added_tentatively')) {
      return NnsInternetIdentityAddTentativeDeviceResponseAddedTentatively.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['added_tentatively']),
      );
    }
    if (json.containsKey('device_registration_mode_off')) {
      return const NnsInternetIdentityAddTentativeDeviceResponseDeviceRegistrationModeOff();
    }
    if (json.containsKey('another_device_tentatively_added')) {
      return const NnsInternetIdentityAddTentativeDeviceResponseAnotherDeviceTentativelyAdded();
    }
    if (json.containsKey('passkey_with_this_public_key_is_already_used')) {
      return const NnsInternetIdentityAddTentativeDeviceResponsePasskeyWithThisPublicKeyIsAlreadyUsed();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAddTentativeDeviceResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityAddTentativeDeviceResponse arm',
    );
  }

  factory NnsInternetIdentityAddTentativeDeviceResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAddTentativeDeviceResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AddTentativeDeviceResponse.added_tentatively`.
final class NnsInternetIdentityAddTentativeDeviceResponseAddedTentatively
    extends NnsInternetIdentityAddTentativeDeviceResponse {
  final String verificationCode;
  final NnsInternetIdentityTimestamp deviceRegistrationTimeout;

  const NnsInternetIdentityAddTentativeDeviceResponseAddedTentatively({
    required this.verificationCode,
    required this.deviceRegistrationTimeout,
  });

  @override
  CType get candidType => NnsInternetIdentityAddTentativeDeviceResponse.ctype;

  @override
  dynamic get candidValue => Variant('added_tentatively', {
    'verification_code': verificationCode,
    'device_registration_timeout': deviceRegistrationTimeout,
  });

  @override
  Map<String, dynamic> toJson() => {
    'added_tentatively': {
      'verification_code': verificationCode,
      'device_registration_timeout': deviceRegistrationTimeout,
    },
  };

  factory NnsInternetIdentityAddTentativeDeviceResponseAddedTentatively.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAddTentativeDeviceResponseAddedTentatively(
      verificationCode: json.valueAsString<String>('verification_code'),
      deviceRegistrationTimeout: json.valueAsBigInt<BigInt>(
        'device_registration_timeout',
      ),
    );
  }
}

/// Variant arm `AddTentativeDeviceResponse.device_registration_mode_off` (nullary).
final class NnsInternetIdentityAddTentativeDeviceResponseDeviceRegistrationModeOff
    extends NnsInternetIdentityAddTentativeDeviceResponse {
  const NnsInternetIdentityAddTentativeDeviceResponseDeviceRegistrationModeOff();

  @override
  CType get candidType => NnsInternetIdentityAddTentativeDeviceResponse.ctype;

  @override
  dynamic get candidValue =>
      const Variant('device_registration_mode_off', null);

  @override
  Map<String, dynamic> toJson() => {'device_registration_mode_off': null};
}

/// Variant arm `AddTentativeDeviceResponse.another_device_tentatively_added` (nullary).
final class NnsInternetIdentityAddTentativeDeviceResponseAnotherDeviceTentativelyAdded
    extends NnsInternetIdentityAddTentativeDeviceResponse {
  const NnsInternetIdentityAddTentativeDeviceResponseAnotherDeviceTentativelyAdded();

  @override
  CType get candidType => NnsInternetIdentityAddTentativeDeviceResponse.ctype;

  @override
  dynamic get candidValue =>
      const Variant('another_device_tentatively_added', null);

  @override
  Map<String, dynamic> toJson() => {'another_device_tentatively_added': null};
}

/// Variant arm `AddTentativeDeviceResponse.passkey_with_this_public_key_is_already_used` (nullary).
final class NnsInternetIdentityAddTentativeDeviceResponsePasskeyWithThisPublicKeyIsAlreadyUsed
    extends NnsInternetIdentityAddTentativeDeviceResponse {
  const NnsInternetIdentityAddTentativeDeviceResponsePasskeyWithThisPublicKeyIsAlreadyUsed();

  @override
  CType get candidType => NnsInternetIdentityAddTentativeDeviceResponse.ctype;

  @override
  dynamic get candidValue =>
      const Variant('passkey_with_this_public_key_is_already_used', null);

  @override
  Map<String, dynamic> toJson() => {
    'passkey_with_this_public_key_is_already_used': null,
  };
}

/// Candid variant `VerifyTentativeDeviceResponse`.
sealed class NnsInternetIdentityVerifyTentativeDeviceResponse
    with CandidSerializable {
  const NnsInternetIdentityVerifyTentativeDeviceResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('verified'), CType.null_),
    Field(
      Label.named('wrong_code'),
      CType.record([Field(Label.named('retries_left'), CType.nat8)]),
    ),
    Field(Label.named('device_registration_mode_off'), CType.null_),
    Field(Label.named('no_device_to_verify'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityVerifyTentativeDeviceResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('verified')) {
      return const NnsInternetIdentityVerifyTentativeDeviceResponseVerified();
    }
    if (json.containsKey('wrong_code')) {
      return NnsInternetIdentityVerifyTentativeDeviceResponseWrongCode.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['wrong_code']),
      );
    }
    if (json.containsKey('device_registration_mode_off')) {
      return const NnsInternetIdentityVerifyTentativeDeviceResponseDeviceRegistrationModeOff();
    }
    if (json.containsKey('no_device_to_verify')) {
      return const NnsInternetIdentityVerifyTentativeDeviceResponseNoDeviceToVerify();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityVerifyTentativeDeviceResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityVerifyTentativeDeviceResponse arm',
    );
  }

  factory NnsInternetIdentityVerifyTentativeDeviceResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityVerifyTentativeDeviceResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `VerifyTentativeDeviceResponse.verified` (nullary).
final class NnsInternetIdentityVerifyTentativeDeviceResponseVerified
    extends NnsInternetIdentityVerifyTentativeDeviceResponse {
  const NnsInternetIdentityVerifyTentativeDeviceResponseVerified();

  @override
  CType get candidType =>
      NnsInternetIdentityVerifyTentativeDeviceResponse.ctype;

  @override
  dynamic get candidValue => const Variant('verified', null);

  @override
  Map<String, dynamic> toJson() => {'verified': null};
}

/// Variant arm `VerifyTentativeDeviceResponse.wrong_code`.
final class NnsInternetIdentityVerifyTentativeDeviceResponseWrongCode
    extends NnsInternetIdentityVerifyTentativeDeviceResponse {
  final int retriesLeft;

  const NnsInternetIdentityVerifyTentativeDeviceResponseWrongCode({
    required this.retriesLeft,
  });

  @override
  CType get candidType =>
      NnsInternetIdentityVerifyTentativeDeviceResponse.ctype;

  @override
  dynamic get candidValue =>
      Variant('wrong_code', {'retries_left': retriesLeft});

  @override
  Map<String, dynamic> toJson() => {
    'wrong_code': {'retries_left': retriesLeft},
  };

  factory NnsInternetIdentityVerifyTentativeDeviceResponseWrongCode.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityVerifyTentativeDeviceResponseWrongCode(
      retriesLeft: json.valueAsInt<int>('retries_left'),
    );
  }
}

/// Variant arm `VerifyTentativeDeviceResponse.device_registration_mode_off` (nullary).
final class NnsInternetIdentityVerifyTentativeDeviceResponseDeviceRegistrationModeOff
    extends NnsInternetIdentityVerifyTentativeDeviceResponse {
  const NnsInternetIdentityVerifyTentativeDeviceResponseDeviceRegistrationModeOff();

  @override
  CType get candidType =>
      NnsInternetIdentityVerifyTentativeDeviceResponse.ctype;

  @override
  dynamic get candidValue =>
      const Variant('device_registration_mode_off', null);

  @override
  Map<String, dynamic> toJson() => {'device_registration_mode_off': null};
}

/// Variant arm `VerifyTentativeDeviceResponse.no_device_to_verify` (nullary).
final class NnsInternetIdentityVerifyTentativeDeviceResponseNoDeviceToVerify
    extends NnsInternetIdentityVerifyTentativeDeviceResponse {
  const NnsInternetIdentityVerifyTentativeDeviceResponseNoDeviceToVerify();

  @override
  CType get candidType =>
      NnsInternetIdentityVerifyTentativeDeviceResponse.ctype;

  @override
  dynamic get candidValue => const Variant('no_device_to_verify', null);

  @override
  Map<String, dynamic> toJson() => {'no_device_to_verify': null};
}

/// Candid record `Delegation`.
final class NnsInternetIdentityDelegation with CandidSerializable {
  final NnsInternetIdentityPublicKey pubkey;
  final NnsInternetIdentityTimestamp expiration;
  final List<IcpPrincipalAddress>? targets;
  final String? permissions;

  const NnsInternetIdentityDelegation({
    required this.pubkey,
    required this.expiration,
    this.targets,
    this.permissions,
  });

  static CType get ctype => CType.record([
    Field(Label.named('pubkey'), CType.vec(CType.nat8)),
    Field(Label.named('expiration'), CType.nat64),
    Field(Label.named('targets'), CType.opt(CType.vec(CType.principal))),
    Field(Label.named('permissions'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'pubkey': pubkey,
    'expiration': expiration,
    'targets': targets,
    'permissions': permissions,
  };

  Map<String, dynamic> toJson() => {
    'pubkey': pubkey,
    'expiration': expiration,
    'targets': targets?.map((el) => el.address).toList(),
    'permissions': permissions,
  };

  factory NnsInternetIdentityDelegation.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityDelegation(
      pubkey: json.valueAsBytes<List<int>>(
        'pubkey',
        encoding: StringEncoding.base64,
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
      targets: json.valueTo<List<IcpPrincipalAddress>?, List>(
        key: 'targets',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      permissions: json.valueAsString<String?>('permissions'),
    );
  }

  factory NnsInternetIdentityDelegation.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDelegation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Permissions`.
sealed class NnsInternetIdentityPermissions with CandidSerializable {
  const NnsInternetIdentityPermissions();

  static CType get ctype => CType.variant([
    Field(Label.named('queries'), CType.null_),
    Field(Label.named('all'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPermissions.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('queries')) {
      return const NnsInternetIdentityPermissionsQueries();
    }
    if (json.containsKey('all')) {
      return const NnsInternetIdentityPermissionsAll();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPermissions.fromCandid',
      reason: 'Unknown NnsInternetIdentityPermissions arm',
    );
  }

  factory NnsInternetIdentityPermissions.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPermissions.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Permissions.queries` (nullary).
final class NnsInternetIdentityPermissionsQueries
    extends NnsInternetIdentityPermissions {
  const NnsInternetIdentityPermissionsQueries();

  @override
  CType get candidType => NnsInternetIdentityPermissions.ctype;

  @override
  dynamic get candidValue => const Variant('queries', null);

  @override
  Map<String, dynamic> toJson() => {'queries': null};
}

/// Variant arm `Permissions.all` (nullary).
final class NnsInternetIdentityPermissionsAll
    extends NnsInternetIdentityPermissions {
  const NnsInternetIdentityPermissionsAll();

  @override
  CType get candidType => NnsInternetIdentityPermissions.ctype;

  @override
  dynamic get candidValue => const Variant('all', null);

  @override
  Map<String, dynamic> toJson() => {'all': null};
}

/// Candid record `SignedDelegation`.
final class NnsInternetIdentitySignedDelegation with CandidSerializable {
  final NnsInternetIdentityDelegation delegation;
  final List<int> signature;

  const NnsInternetIdentitySignedDelegation({
    required this.delegation,
    required this.signature,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('delegation'),
      () => NnsInternetIdentityDelegation.ctype,
    ),
    Field(Label.named('signature'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'delegation': delegation.candidValue,
    'signature': signature,
  };

  Map<String, dynamic> toJson() => {
    'delegation': delegation.toJson(),
    'signature': signature,
  };

  factory NnsInternetIdentitySignedDelegation.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySignedDelegation(
      delegation: json.valueTo<NnsInternetIdentityDelegation, Map>(
        key: 'delegation',
        parse:
            (e) => NnsInternetIdentityDelegation.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      signature: json.valueAsBytes<List<int>>(
        'signature',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentitySignedDelegation.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySignedDelegation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `GetDelegationResponse`.
sealed class NnsInternetIdentityGetDelegationResponse with CandidSerializable {
  const NnsInternetIdentityGetDelegationResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('signed_delegation'),
      () => NnsInternetIdentitySignedDelegation.ctype,
    ),
    Field(Label.named('no_such_delegation'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('signed_delegation')) {
      return NnsInternetIdentityGetDelegationResponseSignedDelegation(
        json.valueTo<NnsInternetIdentitySignedDelegation, Map>(
          key: 'signed_delegation',
          parse:
              (e) => NnsInternetIdentitySignedDelegation.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('no_such_delegation')) {
      return const NnsInternetIdentityGetDelegationResponseNoSuchDelegation();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetDelegationResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetDelegationResponse arm',
    );
  }

  factory NnsInternetIdentityGetDelegationResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetDelegationResponse.signed_delegation`.
final class NnsInternetIdentityGetDelegationResponseSignedDelegation
    extends NnsInternetIdentityGetDelegationResponse {
  final NnsInternetIdentitySignedDelegation value;
  const NnsInternetIdentityGetDelegationResponseSignedDelegation(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetDelegationResponse.ctype;

  @override
  dynamic get candidValue => Variant('signed_delegation', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'signed_delegation': value.toJson()};
}

/// Variant arm `GetDelegationResponse.no_such_delegation` (nullary).
final class NnsInternetIdentityGetDelegationResponseNoSuchDelegation
    extends NnsInternetIdentityGetDelegationResponse {
  const NnsInternetIdentityGetDelegationResponseNoSuchDelegation();

  @override
  CType get candidType => NnsInternetIdentityGetDelegationResponse.ctype;

  @override
  dynamic get candidValue => const Variant('no_such_delegation', null);

  @override
  Map<String, dynamic> toJson() => {'no_such_delegation': null};
}

/// Candid record `InternetIdentityStats`.
final class NnsInternetIdentityInternetIdentityStats with CandidSerializable {
  final BigInt usersRegistered;
  final int storageLayoutVersion;
  final NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange
  assignedUserNumberRange;
  final NnsInternetIdentityArchiveInfo archiveInfo;
  final BigInt canisterCreationCyclesCost;
  final List<NnsInternetIdentityInternetIdentityStatsEventAggregations>
  eventAggregations;

  const NnsInternetIdentityInternetIdentityStats({
    required this.usersRegistered,
    required this.storageLayoutVersion,
    required this.assignedUserNumberRange,
    required this.archiveInfo,
    required this.canisterCreationCyclesCost,
    required this.eventAggregations,
  });

  static CType get ctype => CType.record([
    Field(Label.named('users_registered'), CType.nat64),
    Field(Label.named('storage_layout_version'), CType.nat8),
    LazyField(
      Label.named('assigned_user_number_range'),
      () =>
          NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange.ctype,
    ),
    LazyField(
      Label.named('archive_info'),
      () => NnsInternetIdentityArchiveInfo.ctype,
    ),
    Field(Label.named('canister_creation_cycles_cost'), CType.nat64),
    LazyField(
      Label.named('event_aggregations'),
      () => CType.vec(
        NnsInternetIdentityInternetIdentityStatsEventAggregations.ctype,
      ),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'users_registered': usersRegistered,
    'storage_layout_version': storageLayoutVersion,
    'assigned_user_number_range': assignedUserNumberRange.candidValue,
    'archive_info': archiveInfo.candidValue,
    'canister_creation_cycles_cost': canisterCreationCyclesCost,
    'event_aggregations':
        eventAggregations.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'users_registered': usersRegistered,
    'storage_layout_version': storageLayoutVersion,
    'assigned_user_number_range': assignedUserNumberRange.toJson(),
    'archive_info': archiveInfo.toJson(),
    'canister_creation_cycles_cost': canisterCreationCyclesCost,
    'event_aggregations': eventAggregations.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityInternetIdentityStats.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityInternetIdentityStats(
      usersRegistered: json.valueAsBigInt<BigInt>('users_registered'),
      storageLayoutVersion: json.valueAsInt<int>('storage_layout_version'),
      assignedUserNumberRange: json.valueTo<
        NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange,
        Map
      >(
        key: 'assigned_user_number_range',
        parse:
            (e) =>
                NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
      ),
      archiveInfo: json.valueTo<NnsInternetIdentityArchiveInfo, Map>(
        key: 'archive_info',
        parse:
            (e) => NnsInternetIdentityArchiveInfo.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      canisterCreationCyclesCost: json.valueAsBigInt<BigInt>(
        'canister_creation_cycles_cost',
      ),
      eventAggregations: json.valueTo<
        List<NnsInternetIdentityInternetIdentityStatsEventAggregations>,
        List
      >(
        key: 'event_aggregations',
        parse:
            (e) =>
                e
                    .map<
                      NnsInternetIdentityInternetIdentityStatsEventAggregations
                    >(
                      (x) =>
                          NnsInternetIdentityInternetIdentityStatsEventAggregations.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityInternetIdentityStats.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityInternetIdentityStats.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ArchiveConfig`.
final class NnsInternetIdentityArchiveConfig with CandidSerializable {
  final List<int> moduleHash;
  final BigInt entriesBufferLimit;
  final int entriesFetchLimit;
  final BigInt pollingIntervalNs;

  const NnsInternetIdentityArchiveConfig({
    required this.moduleHash,
    required this.entriesBufferLimit,
    required this.entriesFetchLimit,
    required this.pollingIntervalNs,
  });

  static CType get ctype => CType.record([
    Field(Label.named('module_hash'), CType.vec(CType.nat8)),
    Field(Label.named('entries_buffer_limit'), CType.nat64),
    Field(Label.named('entries_fetch_limit'), CType.nat16),
    Field(Label.named('polling_interval_ns'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'module_hash': moduleHash,
    'entries_buffer_limit': entriesBufferLimit,
    'entries_fetch_limit': entriesFetchLimit,
    'polling_interval_ns': pollingIntervalNs,
  };

  Map<String, dynamic> toJson() => {
    'module_hash': moduleHash,
    'entries_buffer_limit': entriesBufferLimit,
    'entries_fetch_limit': entriesFetchLimit,
    'polling_interval_ns': pollingIntervalNs,
  };

  factory NnsInternetIdentityArchiveConfig.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityArchiveConfig(
      moduleHash: json.valueAsBytes<List<int>>(
        'module_hash',
        encoding: StringEncoding.base64,
      ),
      entriesBufferLimit: json.valueAsBigInt<BigInt>('entries_buffer_limit'),
      entriesFetchLimit: json.valueAsInt<int>('entries_fetch_limit'),
      pollingIntervalNs: json.valueAsBigInt<BigInt>('polling_interval_ns'),
    );
  }

  factory NnsInternetIdentityArchiveConfig.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityArchiveConfig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ArchiveInfo`.
final class NnsInternetIdentityArchiveInfo with CandidSerializable {
  final IcpPrincipalAddress? archiveCanister;
  final NnsInternetIdentityArchiveConfig? archiveConfig;

  const NnsInternetIdentityArchiveInfo({
    this.archiveCanister,
    this.archiveConfig,
  });

  static CType get ctype => CType.record([
    Field(Label.named('archive_canister'), CType.opt(CType.principal)),
    LazyField(
      Label.named('archive_config'),
      () => CType.opt(NnsInternetIdentityArchiveConfig.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'archive_canister': archiveCanister,
    'archive_config': archiveConfig?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'archive_canister': archiveCanister?.address,
    'archive_config': archiveConfig?.toJson(),
  };

  factory NnsInternetIdentityArchiveInfo.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityArchiveInfo(
      archiveCanister: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'archive_canister',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      archiveConfig: json.valueTo<NnsInternetIdentityArchiveConfig?, Map>(
        key: 'archive_config',
        parse:
            (e) => NnsInternetIdentityArchiveConfig.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentityArchiveInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityArchiveInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RateLimitConfig`.
final class NnsInternetIdentityRateLimitConfig with CandidSerializable {
  final BigInt timePerTokenNs;
  final BigInt maxTokens;

  const NnsInternetIdentityRateLimitConfig({
    required this.timePerTokenNs,
    required this.maxTokens,
  });

  static CType get ctype => CType.record([
    Field(Label.named('time_per_token_ns'), CType.nat64),
    Field(Label.named('max_tokens'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'time_per_token_ns': timePerTokenNs,
    'max_tokens': maxTokens,
  };

  Map<String, dynamic> toJson() => {
    'time_per_token_ns': timePerTokenNs,
    'max_tokens': maxTokens,
  };

  factory NnsInternetIdentityRateLimitConfig.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityRateLimitConfig(
      timePerTokenNs: json.valueAsBigInt<BigInt>('time_per_token_ns'),
      maxTokens: json.valueAsBigInt<BigInt>('max_tokens'),
    );
  }

  factory NnsInternetIdentityRateLimitConfig.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityRateLimitConfig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CaptchaConfig`.
final class NnsInternetIdentityCaptchaConfig with CandidSerializable {
  final BigInt maxUnsolvedCaptchas;
  final NnsInternetIdentityCaptchaConfigCaptchaTrigger captchaTrigger;

  const NnsInternetIdentityCaptchaConfig({
    required this.maxUnsolvedCaptchas,
    required this.captchaTrigger,
  });

  static CType get ctype => CType.record([
    Field(Label.named('max_unsolved_captchas'), CType.nat64),
    LazyField(
      Label.named('captcha_trigger'),
      () => NnsInternetIdentityCaptchaConfigCaptchaTrigger.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'max_unsolved_captchas': maxUnsolvedCaptchas,
    'captcha_trigger': captchaTrigger.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'max_unsolved_captchas': maxUnsolvedCaptchas,
    'captcha_trigger': captchaTrigger.toJson(),
  };

  factory NnsInternetIdentityCaptchaConfig.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityCaptchaConfig(
      maxUnsolvedCaptchas: json.valueAsBigInt<BigInt>('max_unsolved_captchas'),
      captchaTrigger: json
          .valueTo<NnsInternetIdentityCaptchaConfigCaptchaTrigger, Map>(
            key: 'captcha_trigger',
            parse:
                (e) =>
                    NnsInternetIdentityCaptchaConfigCaptchaTrigger.fromCandid(
                      JsonParser.valueEnsureAsMap<String, dynamic>(e),
                    ),
          ),
    );
  }

  factory NnsInternetIdentityCaptchaConfig.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityCaptchaConfig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `InternetIdentityInit`.
final class NnsInternetIdentityInternetIdentityInit with CandidSerializable {
  final NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange?
  assignedUserNumberRange;
  final NnsInternetIdentityArchiveConfig? archiveConfig;
  final BigInt? canisterCreationCyclesCost;
  final NnsInternetIdentityRateLimitConfig? registerRateLimit;
  final NnsInternetIdentityCaptchaConfig? captchaConfig;
  final List<String>? relatedOrigins;
  final List<String>? newFlowOrigins;
  final List<NnsInternetIdentityOpenIdConfig>? openidConfigs;
  final bool? ssoAllowInsecureDiscovery;
  final NnsInternetIdentityAnalyticsConfig? analyticsConfig;
  final bool? enableDappsExplorer;
  final bool? isProduction;
  final NnsInternetIdentityDummyAuthConfig? dummyAuth;
  final IcpPrincipalAddress? backendCanisterId;
  final String? backendOrigin;
  final bool? enableDnssecEmailRecovery;
  final NnsInternetIdentityDnssecConfig? dnssecConfig;
  final NnsInternetIdentityDohConfig? dohConfig;
  final String? mcpOfficialUrl;

  const NnsInternetIdentityInternetIdentityInit({
    this.assignedUserNumberRange,
    this.archiveConfig,
    this.canisterCreationCyclesCost,
    this.registerRateLimit,
    this.captchaConfig,
    this.relatedOrigins,
    this.newFlowOrigins,
    this.openidConfigs,
    this.ssoAllowInsecureDiscovery,
    this.analyticsConfig,
    this.enableDappsExplorer,
    this.isProduction,
    this.dummyAuth,
    this.backendCanisterId,
    this.backendOrigin,
    this.enableDnssecEmailRecovery,
    this.dnssecConfig,
    this.dohConfig,
    this.mcpOfficialUrl,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('assigned_user_number_range'),
      () => CType.opt(
        NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange.ctype,
      ),
    ),
    LazyField(
      Label.named('archive_config'),
      () => CType.opt(NnsInternetIdentityArchiveConfig.ctype),
    ),
    Field(Label.named('canister_creation_cycles_cost'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('register_rate_limit'),
      () => CType.opt(NnsInternetIdentityRateLimitConfig.ctype),
    ),
    LazyField(
      Label.named('captcha_config'),
      () => CType.opt(NnsInternetIdentityCaptchaConfig.ctype),
    ),
    Field(Label.named('related_origins'), CType.opt(CType.vec(CType.text))),
    Field(Label.named('new_flow_origins'), CType.opt(CType.vec(CType.text))),
    LazyField(
      Label.named('openid_configs'),
      () => CType.opt(CType.vec(NnsInternetIdentityOpenIdConfig.ctype)),
    ),
    Field(Label.named('sso_allow_insecure_discovery'), CType.opt(CType.bool_)),
    LazyField(
      Label.named('analytics_config'),
      () => CType.opt(CType.opt(NnsInternetIdentityAnalyticsConfig.ctype)),
    ),
    Field(Label.named('enable_dapps_explorer'), CType.opt(CType.bool_)),
    Field(Label.named('is_production'), CType.opt(CType.bool_)),
    LazyField(
      Label.named('dummy_auth'),
      () => CType.opt(CType.opt(NnsInternetIdentityDummyAuthConfig.ctype)),
    ),
    Field(Label.named('backend_canister_id'), CType.opt(CType.principal)),
    Field(Label.named('backend_origin'), CType.opt(CType.text)),
    Field(Label.named('enable_dnssec_email_recovery'), CType.opt(CType.bool_)),
    LazyField(
      Label.named('dnssec_config'),
      () => CType.opt(CType.opt(NnsInternetIdentityDnssecConfig.ctype)),
    ),
    LazyField(
      Label.named('doh_config'),
      () => CType.opt(CType.opt(NnsInternetIdentityDohConfig.ctype)),
    ),
    Field(Label.named('mcp_official_url'), CType.opt(CType.opt(CType.text))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'assigned_user_number_range': assignedUserNumberRange?.candidValue,
    'archive_config': archiveConfig?.candidValue,
    'canister_creation_cycles_cost': canisterCreationCyclesCost,
    'register_rate_limit': registerRateLimit?.candidValue,
    'captcha_config': captchaConfig?.candidValue,
    'related_origins': relatedOrigins,
    'new_flow_origins': newFlowOrigins,
    'openid_configs': openidConfigs?.map((el) => el.candidValue).toList(),
    'sso_allow_insecure_discovery': ssoAllowInsecureDiscovery,
    'analytics_config': analyticsConfig?.candidValue,
    'enable_dapps_explorer': enableDappsExplorer,
    'is_production': isProduction,
    'dummy_auth': dummyAuth?.candidValue,
    'backend_canister_id': backendCanisterId,
    'backend_origin': backendOrigin,
    'enable_dnssec_email_recovery': enableDnssecEmailRecovery,
    'dnssec_config': dnssecConfig?.candidValue,
    'doh_config': dohConfig?.candidValue,
    'mcp_official_url': mcpOfficialUrl,
  };

  Map<String, dynamic> toJson() => {
    'assigned_user_number_range': assignedUserNumberRange?.toJson(),
    'archive_config': archiveConfig?.toJson(),
    'canister_creation_cycles_cost': canisterCreationCyclesCost,
    'register_rate_limit': registerRateLimit?.toJson(),
    'captcha_config': captchaConfig?.toJson(),
    'related_origins': relatedOrigins,
    'new_flow_origins': newFlowOrigins,
    'openid_configs': openidConfigs?.map((el) => el.toJson()).toList(),
    'sso_allow_insecure_discovery': ssoAllowInsecureDiscovery,
    'analytics_config': analyticsConfig?.toJson(),
    'enable_dapps_explorer': enableDappsExplorer,
    'is_production': isProduction,
    'dummy_auth': dummyAuth?.toJson(),
    'backend_canister_id': backendCanisterId?.address,
    'backend_origin': backendOrigin,
    'enable_dnssec_email_recovery': enableDnssecEmailRecovery,
    'dnssec_config': dnssecConfig?.toJson(),
    'doh_config': dohConfig?.toJson(),
    'mcp_official_url': mcpOfficialUrl,
  };

  factory NnsInternetIdentityInternetIdentityInit.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityInternetIdentityInit(
      assignedUserNumberRange: json.valueTo<
        NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange?,
        Map
      >(
        key: 'assigned_user_number_range',
        parse:
            (e) =>
                NnsInternetIdentityInternetIdentityStatsAssignedUserNumberRange.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
      ),
      archiveConfig: json.valueTo<NnsInternetIdentityArchiveConfig?, Map>(
        key: 'archive_config',
        parse:
            (e) => NnsInternetIdentityArchiveConfig.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      canisterCreationCyclesCost: json.valueAsBigInt<BigInt?>(
        'canister_creation_cycles_cost',
      ),
      registerRateLimit: json.valueTo<NnsInternetIdentityRateLimitConfig?, Map>(
        key: 'register_rate_limit',
        parse:
            (e) => NnsInternetIdentityRateLimitConfig.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      captchaConfig: json.valueTo<NnsInternetIdentityCaptchaConfig?, Map>(
        key: 'captcha_config',
        parse:
            (e) => NnsInternetIdentityCaptchaConfig.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      relatedOrigins: json.valueTo<List<String>?, List>(
        key: 'related_origins',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
      newFlowOrigins: json.valueTo<List<String>?, List>(
        key: 'new_flow_origins',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
      openidConfigs: json.valueTo<List<NnsInternetIdentityOpenIdConfig>?, List>(
        key: 'openid_configs',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityOpenIdConfig>(
                      (x) => NnsInternetIdentityOpenIdConfig.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      ssoAllowInsecureDiscovery: json.valueAsBool<bool?>(
        'sso_allow_insecure_discovery',
      ),
      analyticsConfig: json['analytics_config'],
      enableDappsExplorer: json.valueAsBool<bool?>('enable_dapps_explorer'),
      isProduction: json.valueAsBool<bool?>('is_production'),
      dummyAuth: json['dummy_auth'],
      backendCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'backend_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      backendOrigin: json.valueAsString<String?>('backend_origin'),
      enableDnssecEmailRecovery: json.valueAsBool<bool?>(
        'enable_dnssec_email_recovery',
      ),
      dnssecConfig: json['dnssec_config'],
      dohConfig: json['doh_config'],
      mcpOfficialUrl: json['mcp_official_url'],
    );
  }

  factory NnsInternetIdentityInternetIdentityInit.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityInternetIdentityInit.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DnssecConfig`.
final class NnsInternetIdentityDnssecConfig with CandidSerializable {
  final List<NnsInternetIdentityDnssecRootAnchor> rootAnchors;

  const NnsInternetIdentityDnssecConfig({required this.rootAnchors});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('root_anchors'),
      () => CType.vec(NnsInternetIdentityDnssecRootAnchor.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'root_anchors': rootAnchors.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'root_anchors': rootAnchors.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityDnssecConfig.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityDnssecConfig(
      rootAnchors: json
          .valueTo<List<NnsInternetIdentityDnssecRootAnchor>, List>(
            key: 'root_anchors',
            parse:
                (e) =>
                    e
                        .map<NnsInternetIdentityDnssecRootAnchor>(
                          (x) => NnsInternetIdentityDnssecRootAnchor.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsInternetIdentityDnssecConfig.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDnssecConfig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DnssecRootAnchor`.
final class NnsInternetIdentityDnssecRootAnchor with CandidSerializable {
  final int keyTag;
  final int algorithm;
  final int digestType;
  final List<int> digest;

  const NnsInternetIdentityDnssecRootAnchor({
    required this.keyTag,
    required this.algorithm,
    required this.digestType,
    required this.digest,
  });

  static CType get ctype => CType.record([
    Field(Label.named('key_tag'), CType.nat16),
    Field(Label.named('algorithm'), CType.nat8),
    Field(Label.named('digest_type'), CType.nat8),
    Field(Label.named('digest'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'key_tag': keyTag,
    'algorithm': algorithm,
    'digest_type': digestType,
    'digest': digest,
  };

  Map<String, dynamic> toJson() => {
    'key_tag': keyTag,
    'algorithm': algorithm,
    'digest_type': digestType,
    'digest': digest,
  };

  factory NnsInternetIdentityDnssecRootAnchor.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityDnssecRootAnchor(
      keyTag: json.valueAsInt<int>('key_tag'),
      algorithm: json.valueAsInt<int>('algorithm'),
      digestType: json.valueAsInt<int>('digest_type'),
      digest: json.valueAsBytes<List<int>>(
        'digest',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityDnssecRootAnchor.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDnssecRootAnchor.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DohConfig`.
final class NnsInternetIdentityDohConfig with CandidSerializable {
  final List<String> allowedDomains;
  final BigInt? maxCacheAgeSecs;

  const NnsInternetIdentityDohConfig({
    required this.allowedDomains,
    this.maxCacheAgeSecs,
  });

  static CType get ctype => CType.record([
    Field(Label.named('allowed_domains'), CType.vec(CType.text)),
    Field(Label.named('max_cache_age_secs'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'allowed_domains': allowedDomains,
    'max_cache_age_secs': maxCacheAgeSecs,
  };

  Map<String, dynamic> toJson() => {
    'allowed_domains': allowedDomains,
    'max_cache_age_secs': maxCacheAgeSecs,
  };

  factory NnsInternetIdentityDohConfig.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityDohConfig(
      allowedDomains: json.valueTo<List<String>, List>(
        key: 'allowed_domains',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
      maxCacheAgeSecs: json.valueAsBigInt<BigInt?>('max_cache_age_secs'),
    );
  }

  factory NnsInternetIdentityDohConfig.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDohConfig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ChallengeResult`.
final class NnsInternetIdentityChallengeResult with CandidSerializable {
  final NnsInternetIdentityChallengeKey key;
  final String chars;

  const NnsInternetIdentityChallengeResult({
    required this.key,
    required this.chars,
  });

  static CType get ctype => CType.record([
    Field(Label.named('key'), CType.text),
    Field(Label.named('chars'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'key': key, 'chars': chars};

  Map<String, dynamic> toJson() => {'key': key, 'chars': chars};

  factory NnsInternetIdentityChallengeResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityChallengeResult(
      key: json.valueAsString<String>('key'),
      chars: json.valueAsString<String>('chars'),
    );
  }

  factory NnsInternetIdentityChallengeResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityChallengeResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DeviceRegistrationInfo`.
final class NnsInternetIdentityDeviceRegistrationInfo with CandidSerializable {
  final NnsInternetIdentityDeviceData? tentativeDevice;
  final IcpPrincipalAddress? tentativeSession;
  final NnsInternetIdentityTimestamp expiration;

  const NnsInternetIdentityDeviceRegistrationInfo({
    this.tentativeDevice,
    this.tentativeSession,
    required this.expiration,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('tentative_device'),
      () => CType.opt(NnsInternetIdentityDeviceData.ctype),
    ),
    Field(Label.named('tentative_session'), CType.opt(CType.principal)),
    Field(Label.named('expiration'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'tentative_device': tentativeDevice?.candidValue,
    'tentative_session': tentativeSession,
    'expiration': expiration,
  };

  Map<String, dynamic> toJson() => {
    'tentative_device': tentativeDevice?.toJson(),
    'tentative_session': tentativeSession?.address,
    'expiration': expiration,
  };

  factory NnsInternetIdentityDeviceRegistrationInfo.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityDeviceRegistrationInfo(
      tentativeDevice: json.valueTo<NnsInternetIdentityDeviceData?, Map>(
        key: 'tentative_device',
        parse:
            (e) => NnsInternetIdentityDeviceData.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      tentativeSession: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'tentative_session',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
    );
  }

  factory NnsInternetIdentityDeviceRegistrationInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDeviceRegistrationInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `IdentityAnchorInfo`.
final class NnsInternetIdentityIdentityAnchorInfo with CandidSerializable {
  final List<NnsInternetIdentityDeviceWithUsage> devices;
  final NnsInternetIdentityDeviceRegistrationInfo? deviceRegistration;
  final List<NnsInternetIdentityOpenIdCredential>? openidCredentials;
  final String? name;
  final NnsInternetIdentityTimestamp? createdAt;

  const NnsInternetIdentityIdentityAnchorInfo({
    required this.devices,
    this.deviceRegistration,
    this.openidCredentials,
    this.name,
    this.createdAt,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('devices'),
      () => CType.vec(NnsInternetIdentityDeviceWithUsage.ctype),
    ),
    LazyField(
      Label.named('device_registration'),
      () => CType.opt(NnsInternetIdentityDeviceRegistrationInfo.ctype),
    ),
    LazyField(
      Label.named('openid_credentials'),
      () => CType.opt(CType.vec(NnsInternetIdentityOpenIdCredential.ctype)),
    ),
    Field(Label.named('name'), CType.opt(CType.text)),
    Field(Label.named('created_at'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'devices': devices.map((el) => el.candidValue).toList(),
    'device_registration': deviceRegistration?.candidValue,
    'openid_credentials':
        openidCredentials?.map((el) => el.candidValue).toList(),
    'name': name,
    'created_at': createdAt,
  };

  Map<String, dynamic> toJson() => {
    'devices': devices.map((el) => el.toJson()).toList(),
    'device_registration': deviceRegistration?.toJson(),
    'openid_credentials': openidCredentials?.map((el) => el.toJson()).toList(),
    'name': name,
    'created_at': createdAt,
  };

  factory NnsInternetIdentityIdentityAnchorInfo.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdentityAnchorInfo(
      devices: json.valueTo<List<NnsInternetIdentityDeviceWithUsage>, List>(
        key: 'devices',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityDeviceWithUsage>(
                      (x) => NnsInternetIdentityDeviceWithUsage.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      deviceRegistration: json
          .valueTo<NnsInternetIdentityDeviceRegistrationInfo?, Map>(
            key: 'device_registration',
            parse:
                (e) => NnsInternetIdentityDeviceRegistrationInfo.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      openidCredentials: json
          .valueTo<List<NnsInternetIdentityOpenIdCredential>?, List>(
            key: 'openid_credentials',
            parse:
                (e) =>
                    e
                        .map<NnsInternetIdentityOpenIdCredential>(
                          (x) => NnsInternetIdentityOpenIdCredential.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
      name: json.valueAsString<String?>('name'),
      createdAt: json.valueAsBigInt<BigInt?>('created_at'),
    );
  }

  factory NnsInternetIdentityIdentityAnchorInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityAnchorInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AnchorCredentials`.
final class NnsInternetIdentityAnchorCredentials with CandidSerializable {
  final List<NnsInternetIdentityWebAuthnCredential> credentials;
  final List<NnsInternetIdentityWebAuthnCredential> recoveryCredentials;
  final List<int> recoveryPhrases;

  const NnsInternetIdentityAnchorCredentials({
    required this.credentials,
    required this.recoveryCredentials,
    required this.recoveryPhrases,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('credentials'),
      () => CType.vec(NnsInternetIdentityWebAuthnCredential.ctype),
    ),
    LazyField(
      Label.named('recovery_credentials'),
      () => CType.vec(NnsInternetIdentityWebAuthnCredential.ctype),
    ),
    Field(Label.named('recovery_phrases'), CType.vec(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'credentials': credentials.map((el) => el.candidValue).toList(),
    'recovery_credentials':
        recoveryCredentials.map((el) => el.candidValue).toList(),
    'recovery_phrases': recoveryPhrases,
  };

  Map<String, dynamic> toJson() => {
    'credentials': credentials.map((el) => el.toJson()).toList(),
    'recovery_credentials':
        recoveryCredentials.map((el) => el.toJson()).toList(),
    'recovery_phrases': recoveryPhrases,
  };

  factory NnsInternetIdentityAnchorCredentials.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAnchorCredentials(
      credentials: json
          .valueTo<List<NnsInternetIdentityWebAuthnCredential>, List>(
            key: 'credentials',
            parse:
                (e) =>
                    e
                        .map<NnsInternetIdentityWebAuthnCredential>(
                          (x) =>
                              NnsInternetIdentityWebAuthnCredential.fromCandid(
                                JsonParser.valueEnsureAsMap<String, dynamic>(x),
                              ),
                        )
                        .toList(),
          ),
      recoveryCredentials: json
          .valueTo<List<NnsInternetIdentityWebAuthnCredential>, List>(
            key: 'recovery_credentials',
            parse:
                (e) =>
                    e
                        .map<NnsInternetIdentityWebAuthnCredential>(
                          (x) =>
                              NnsInternetIdentityWebAuthnCredential.fromCandid(
                                JsonParser.valueEnsureAsMap<String, dynamic>(x),
                              ),
                        )
                        .toList(),
          ),
      recoveryPhrases: json.valueAsBytes<List<int>>(
        'recovery_phrases',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityAnchorCredentials.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAnchorCredentials.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `WebAuthnCredential`.
final class NnsInternetIdentityWebAuthnCredential with CandidSerializable {
  final NnsInternetIdentityCredentialId credentialId;
  final NnsInternetIdentityPublicKey pubkey;

  const NnsInternetIdentityWebAuthnCredential({
    required this.credentialId,
    required this.pubkey,
  });

  static CType get ctype => CType.record([
    Field(Label.named('credential_id'), CType.vec(CType.nat8)),
    Field(Label.named('pubkey'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'credential_id': credentialId, 'pubkey': pubkey};

  Map<String, dynamic> toJson() => {
    'credential_id': credentialId,
    'pubkey': pubkey,
  };

  factory NnsInternetIdentityWebAuthnCredential.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityWebAuthnCredential(
      credentialId: json.valueAsBytes<List<int>>(
        'credential_id',
        encoding: StringEncoding.base64,
      ),
      pubkey: json.valueAsBytes<List<int>>(
        'pubkey',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityWebAuthnCredential.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityWebAuthnCredential.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `DeployArchiveResult`.
sealed class NnsInternetIdentityDeployArchiveResult with CandidSerializable {
  const NnsInternetIdentityDeployArchiveResult();

  static CType get ctype => CType.variant([
    Field(Label.named('success'), CType.principal),
    Field(Label.named('creation_in_progress'), CType.null_),
    Field(Label.named('failed'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityDeployArchiveResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('success')) {
      return NnsInternetIdentityDeployArchiveResultSuccess(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'success',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('creation_in_progress')) {
      return const NnsInternetIdentityDeployArchiveResultCreationInProgress();
    }
    if (json.containsKey('failed')) {
      return NnsInternetIdentityDeployArchiveResultFailed(
        json.valueAsString<String>('failed'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityDeployArchiveResult.fromCandid',
      reason: 'Unknown NnsInternetIdentityDeployArchiveResult arm',
    );
  }

  factory NnsInternetIdentityDeployArchiveResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDeployArchiveResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `DeployArchiveResult.success`.
final class NnsInternetIdentityDeployArchiveResultSuccess
    extends NnsInternetIdentityDeployArchiveResult {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityDeployArchiveResultSuccess(this.value);

  @override
  CType get candidType => NnsInternetIdentityDeployArchiveResult.ctype;

  @override
  dynamic get candidValue => Variant('success', value);

  @override
  Map<String, dynamic> toJson() => {'success': value.address};
}

/// Variant arm `DeployArchiveResult.creation_in_progress` (nullary).
final class NnsInternetIdentityDeployArchiveResultCreationInProgress
    extends NnsInternetIdentityDeployArchiveResult {
  const NnsInternetIdentityDeployArchiveResultCreationInProgress();

  @override
  CType get candidType => NnsInternetIdentityDeployArchiveResult.ctype;

  @override
  dynamic get candidValue => const Variant('creation_in_progress', null);

  @override
  Map<String, dynamic> toJson() => {'creation_in_progress': null};
}

/// Variant arm `DeployArchiveResult.failed`.
final class NnsInternetIdentityDeployArchiveResultFailed
    extends NnsInternetIdentityDeployArchiveResult {
  final String value;
  const NnsInternetIdentityDeployArchiveResultFailed(this.value);

  @override
  CType get candidType => NnsInternetIdentityDeployArchiveResult.ctype;

  @override
  dynamic get candidValue => Variant('failed', value);

  @override
  Map<String, dynamic> toJson() => {'failed': value};
}

/// Candid record `BufferedArchiveEntry`.
final class NnsInternetIdentityBufferedArchiveEntry with CandidSerializable {
  final NnsInternetIdentityUserNumber anchorNumber;
  final NnsInternetIdentityTimestamp timestamp;
  final BigInt sequenceNumber;
  final List<int> entry;

  const NnsInternetIdentityBufferedArchiveEntry({
    required this.anchorNumber,
    required this.timestamp,
    required this.sequenceNumber,
    required this.entry,
  });

  static CType get ctype => CType.record([
    Field(Label.named('anchor_number'), CType.nat64),
    Field(Label.named('timestamp'), CType.nat64),
    Field(Label.named('sequence_number'), CType.nat64),
    Field(Label.named('entry'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'anchor_number': anchorNumber,
    'timestamp': timestamp,
    'sequence_number': sequenceNumber,
    'entry': entry,
  };

  Map<String, dynamic> toJson() => {
    'anchor_number': anchorNumber,
    'timestamp': timestamp,
    'sequence_number': sequenceNumber,
    'entry': entry,
  };

  factory NnsInternetIdentityBufferedArchiveEntry.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityBufferedArchiveEntry(
      anchorNumber: json.valueAsBigInt<BigInt>('anchor_number'),
      timestamp: json.valueAsBigInt<BigInt>('timestamp'),
      sequenceNumber: json.valueAsBigInt<BigInt>('sequence_number'),
      entry: json.valueAsBytes<List<int>>(
        'entry',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityBufferedArchiveEntry.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityBufferedArchiveEntry.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `OpenIdEmailVerification`.
sealed class NnsInternetIdentityOpenIdEmailVerification
    with CandidSerializable {
  const NnsInternetIdentityOpenIdEmailVerification();

  static CType get ctype => CType.variant([
    Field(Label.named('Unknown'), CType.null_),
    Field(Label.named('Google'), CType.null_),
    Field(Label.named('Microsoft'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityOpenIdEmailVerification.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unknown')) {
      return const NnsInternetIdentityOpenIdEmailVerificationUnknown();
    }
    if (json.containsKey('Google')) {
      return const NnsInternetIdentityOpenIdEmailVerificationGoogle();
    }
    if (json.containsKey('Microsoft')) {
      return const NnsInternetIdentityOpenIdEmailVerificationMicrosoft();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityOpenIdEmailVerification.fromCandid',
      reason: 'Unknown NnsInternetIdentityOpenIdEmailVerification arm',
    );
  }

  factory NnsInternetIdentityOpenIdEmailVerification.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenIdEmailVerification.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `OpenIdEmailVerification.Unknown` (nullary).
final class NnsInternetIdentityOpenIdEmailVerificationUnknown
    extends NnsInternetIdentityOpenIdEmailVerification {
  const NnsInternetIdentityOpenIdEmailVerificationUnknown();

  @override
  CType get candidType => NnsInternetIdentityOpenIdEmailVerification.ctype;

  @override
  dynamic get candidValue => const Variant('Unknown', null);

  @override
  Map<String, dynamic> toJson() => {'Unknown': null};
}

/// Variant arm `OpenIdEmailVerification.Google` (nullary).
final class NnsInternetIdentityOpenIdEmailVerificationGoogle
    extends NnsInternetIdentityOpenIdEmailVerification {
  const NnsInternetIdentityOpenIdEmailVerificationGoogle();

  @override
  CType get candidType => NnsInternetIdentityOpenIdEmailVerification.ctype;

  @override
  dynamic get candidValue => const Variant('Google', null);

  @override
  Map<String, dynamic> toJson() => {'Google': null};
}

/// Variant arm `OpenIdEmailVerification.Microsoft` (nullary).
final class NnsInternetIdentityOpenIdEmailVerificationMicrosoft
    extends NnsInternetIdentityOpenIdEmailVerification {
  const NnsInternetIdentityOpenIdEmailVerificationMicrosoft();

  @override
  CType get candidType => NnsInternetIdentityOpenIdEmailVerification.ctype;

  @override
  dynamic get candidValue => const Variant('Microsoft', null);

  @override
  Map<String, dynamic> toJson() => {'Microsoft': null};
}

/// Candid record `OpenIdConfig`.
final class NnsInternetIdentityOpenIdConfig with CandidSerializable {
  final String name;
  final String logo;
  final String issuer;
  final String clientId;
  final String jwksUri;
  final String authUri;
  final List<String> authScope;
  final String? fedcmUri;
  final NnsInternetIdentityOpenIdEmailVerification? emailVerification;
  final List<List<NnsInternetIdentityOpenIdConfigSeedJwks>>? seedJwks;

  const NnsInternetIdentityOpenIdConfig({
    required this.name,
    required this.logo,
    required this.issuer,
    required this.clientId,
    required this.jwksUri,
    required this.authUri,
    required this.authScope,
    this.fedcmUri,
    this.emailVerification,
    this.seedJwks,
  });

  static CType get ctype => CType.record([
    Field(Label.named('name'), CType.text),
    Field(Label.named('logo'), CType.text),
    Field(Label.named('issuer'), CType.text),
    Field(Label.named('client_id'), CType.text),
    Field(Label.named('jwks_uri'), CType.text),
    Field(Label.named('auth_uri'), CType.text),
    Field(Label.named('auth_scope'), CType.vec(CType.text)),
    Field(Label.named('fedcm_uri'), CType.opt(CType.text)),
    LazyField(
      Label.named('email_verification'),
      () => CType.opt(NnsInternetIdentityOpenIdEmailVerification.ctype),
    ),
    LazyField(
      Label.named('seed_jwks'),
      () => CType.opt(
        CType.vec(CType.vec(NnsInternetIdentityOpenIdConfigSeedJwks.ctype)),
      ),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'name': name,
    'logo': logo,
    'issuer': issuer,
    'client_id': clientId,
    'jwks_uri': jwksUri,
    'auth_uri': authUri,
    'auth_scope': authScope,
    'fedcm_uri': fedcmUri,
    'email_verification': emailVerification?.candidValue,
    'seed_jwks':
        seedJwks?.map((el) => el.map((e1) => e1.candidValue).toList()).toList(),
  };

  Map<String, dynamic> toJson() => {
    'name': name,
    'logo': logo,
    'issuer': issuer,
    'client_id': clientId,
    'jwks_uri': jwksUri,
    'auth_uri': authUri,
    'auth_scope': authScope,
    'fedcm_uri': fedcmUri,
    'email_verification': emailVerification?.toJson(),
    'seed_jwks':
        seedJwks?.map((el) => el.map((e1) => e1.toJson()).toList()).toList(),
  };

  factory NnsInternetIdentityOpenIdConfig.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityOpenIdConfig(
      name: json.valueAsString<String>('name'),
      logo: json.valueAsString<String>('logo'),
      issuer: json.valueAsString<String>('issuer'),
      clientId: json.valueAsString<String>('client_id'),
      jwksUri: json.valueAsString<String>('jwks_uri'),
      authUri: json.valueAsString<String>('auth_uri'),
      authScope: json.valueTo<List<String>, List>(
        key: 'auth_scope',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
      fedcmUri: json.valueAsString<String?>('fedcm_uri'),
      emailVerification: json
          .valueTo<NnsInternetIdentityOpenIdEmailVerification?, Map>(
            key: 'email_verification',
            parse:
                (e) => NnsInternetIdentityOpenIdEmailVerification.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      seedJwks: json.valueTo<
        List<List<NnsInternetIdentityOpenIdConfigSeedJwks>>?,
        List
      >(
        key: 'seed_jwks',
        parse:
            (e) =>
                e
                    .map<List<NnsInternetIdentityOpenIdConfigSeedJwks>>(
                      (x) =>
                          (x as List)
                              .map<NnsInternetIdentityOpenIdConfigSeedJwks>(
                                (y) =>
                                    NnsInternetIdentityOpenIdConfigSeedJwks.fromCandid(
                                      JsonParser.valueEnsureAsMap<
                                        String,
                                        dynamic
                                      >(y),
                                    ),
                              )
                              .toList(),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityOpenIdConfig.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenIdConfig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SsoDiscovery`.
final class NnsInternetIdentitySsoDiscovery with CandidSerializable {
  final String discoveryDomain;
  final String clientId;
  final String issuer;
  final String authorizationEndpoint;
  final List<String> scopes;
  final String? name;
  final String? resolvedClientId;
  final BigInt sessionMaxAgeNs;

  const NnsInternetIdentitySsoDiscovery({
    required this.discoveryDomain,
    required this.clientId,
    required this.issuer,
    required this.authorizationEndpoint,
    required this.scopes,
    this.name,
    this.resolvedClientId,
    required this.sessionMaxAgeNs,
  });

  static CType get ctype => CType.record([
    Field(Label.named('discovery_domain'), CType.text),
    Field(Label.named('client_id'), CType.text),
    Field(Label.named('issuer'), CType.text),
    Field(Label.named('authorization_endpoint'), CType.text),
    Field(Label.named('scopes'), CType.vec(CType.text)),
    Field(Label.named('name'), CType.opt(CType.text)),
    Field(Label.named('resolved_client_id'), CType.opt(CType.text)),
    Field(Label.named('session_max_age_ns'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'discovery_domain': discoveryDomain,
    'client_id': clientId,
    'issuer': issuer,
    'authorization_endpoint': authorizationEndpoint,
    'scopes': scopes,
    'name': name,
    'resolved_client_id': resolvedClientId,
    'session_max_age_ns': sessionMaxAgeNs,
  };

  Map<String, dynamic> toJson() => {
    'discovery_domain': discoveryDomain,
    'client_id': clientId,
    'issuer': issuer,
    'authorization_endpoint': authorizationEndpoint,
    'scopes': scopes,
    'name': name,
    'resolved_client_id': resolvedClientId,
    'session_max_age_ns': sessionMaxAgeNs,
  };

  factory NnsInternetIdentitySsoDiscovery.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySsoDiscovery(
      discoveryDomain: json.valueAsString<String>('discovery_domain'),
      clientId: json.valueAsString<String>('client_id'),
      issuer: json.valueAsString<String>('issuer'),
      authorizationEndpoint: json.valueAsString<String>(
        'authorization_endpoint',
      ),
      scopes: json.valueTo<List<String>, List>(
        key: 'scopes',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
      name: json.valueAsString<String?>('name'),
      resolvedClientId: json.valueAsString<String?>('resolved_client_id'),
      sessionMaxAgeNs: json.valueAsBigInt<BigInt>('session_max_age_ns'),
    );
  }

  factory NnsInternetIdentitySsoDiscovery.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySsoDiscovery.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `SsoDiscoveryStatus`.
sealed class NnsInternetIdentitySsoDiscoveryStatus with CandidSerializable {
  const NnsInternetIdentitySsoDiscoveryStatus();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Resolved'),
      () => NnsInternetIdentitySsoDiscovery.ctype,
    ),
    Field(Label.named('Pending'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentitySsoDiscoveryStatus.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Resolved')) {
      return NnsInternetIdentitySsoDiscoveryStatusResolved(
        json.valueTo<NnsInternetIdentitySsoDiscovery, Map>(
          key: 'Resolved',
          parse:
              (e) => NnsInternetIdentitySsoDiscovery.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Pending')) {
      return const NnsInternetIdentitySsoDiscoveryStatusPending();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentitySsoDiscoveryStatus.fromCandid',
      reason: 'Unknown NnsInternetIdentitySsoDiscoveryStatus arm',
    );
  }

  factory NnsInternetIdentitySsoDiscoveryStatus.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySsoDiscoveryStatus.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `SsoDiscoveryStatus.Resolved`.
final class NnsInternetIdentitySsoDiscoveryStatusResolved
    extends NnsInternetIdentitySsoDiscoveryStatus {
  final NnsInternetIdentitySsoDiscovery value;
  const NnsInternetIdentitySsoDiscoveryStatusResolved(this.value);

  @override
  CType get candidType => NnsInternetIdentitySsoDiscoveryStatus.ctype;

  @override
  dynamic get candidValue => Variant('Resolved', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Resolved': value.toJson()};
}

/// Variant arm `SsoDiscoveryStatus.Pending` (nullary).
final class NnsInternetIdentitySsoDiscoveryStatusPending
    extends NnsInternetIdentitySsoDiscoveryStatus {
  const NnsInternetIdentitySsoDiscoveryStatusPending();

  @override
  CType get candidType => NnsInternetIdentitySsoDiscoveryStatus.ctype;

  @override
  dynamic get candidValue => const Variant('Pending', null);

  @override
  Map<String, dynamic> toJson() => {'Pending': null};
}

/// Candid record `GetSsoDiscoveryStatusRequest`.
final class NnsInternetIdentityGetSsoDiscoveryStatusRequest
    with CandidSerializable {
  final String orgDomain;
  final NnsInternetIdentityFrontendHostname? targetAppOrigin;

  const NnsInternetIdentityGetSsoDiscoveryStatusRequest({
    required this.orgDomain,
    this.targetAppOrigin,
  });

  static CType get ctype => CType.record([
    Field(Label.named('org_domain'), CType.text),
    Field(Label.named('target_app_origin'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'org_domain': orgDomain,
    'target_app_origin': targetAppOrigin,
  };

  Map<String, dynamic> toJson() => {
    'org_domain': orgDomain,
    'target_app_origin': targetAppOrigin,
  };

  factory NnsInternetIdentityGetSsoDiscoveryStatusRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityGetSsoDiscoveryStatusRequest(
      orgDomain: json.valueAsString<String>('org_domain'),
      targetAppOrigin: json.valueAsString<String?>('target_app_origin'),
    );
  }

  factory NnsInternetIdentityGetSsoDiscoveryStatusRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetSsoDiscoveryStatusRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `OpenIdCredentialKey`.
final class NnsInternetIdentityOpenIdCredentialKey with CandidSerializable {
  final NnsInternetIdentityIss field0;
  final NnsInternetIdentitySub field1;
  final NnsInternetIdentityAud field2;

  const NnsInternetIdentityOpenIdCredentialKey({
    required this.field0,
    required this.field1,
    required this.field2,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    Field(Label.id(1), CType.text),
    Field(Label.id(2), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1, '2': field2};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1, '2': field2};

  factory NnsInternetIdentityOpenIdCredentialKey.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityOpenIdCredentialKey(
      field0: json.valueAsString<String>('0'),
      field1: json.valueAsString<String>('1'),
      field2: json.valueAsString<String>('2'),
    );
  }

  factory NnsInternetIdentityOpenIdCredentialKey.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenIdCredentialKey.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `AnalyticsConfig`.
sealed class NnsInternetIdentityAnalyticsConfig with CandidSerializable {
  const NnsInternetIdentityAnalyticsConfig();

  static CType get ctype => CType.variant([
    Field(
      Label.named('Plausible'),
      CType.record([
        Field(Label.named('domain'), CType.opt(CType.text)),
        Field(Label.named('hash_mode'), CType.opt(CType.bool_)),
        Field(Label.named('track_localhost'), CType.opt(CType.bool_)),
        Field(Label.named('api_host'), CType.opt(CType.text)),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAnalyticsConfig.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Plausible')) {
      return NnsInternetIdentityAnalyticsConfigPlausible.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Plausible']),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAnalyticsConfig.fromCandid',
      reason: 'Unknown NnsInternetIdentityAnalyticsConfig arm',
    );
  }

  factory NnsInternetIdentityAnalyticsConfig.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAnalyticsConfig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AnalyticsConfig.Plausible`.
final class NnsInternetIdentityAnalyticsConfigPlausible
    extends NnsInternetIdentityAnalyticsConfig {
  final String? domain;
  final bool? hashMode;
  final bool? trackLocalhost;
  final String? apiHost;

  const NnsInternetIdentityAnalyticsConfigPlausible({
    this.domain,
    this.hashMode,
    this.trackLocalhost,
    this.apiHost,
  });

  @override
  CType get candidType => NnsInternetIdentityAnalyticsConfig.ctype;

  @override
  dynamic get candidValue => Variant('Plausible', {
    'domain': domain,
    'hash_mode': hashMode,
    'track_localhost': trackLocalhost,
    'api_host': apiHost,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Plausible': {
      'domain': domain,
      'hash_mode': hashMode,
      'track_localhost': trackLocalhost,
      'api_host': apiHost,
    },
  };

  factory NnsInternetIdentityAnalyticsConfigPlausible.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAnalyticsConfigPlausible(
      domain: json.valueAsString<String?>('domain'),
      hashMode: json.valueAsBool<bool?>('hash_mode'),
      trackLocalhost: json.valueAsBool<bool?>('track_localhost'),
      apiHost: json.valueAsString<String?>('api_host'),
    );
  }
}

/// Candid record `OpenIdCredential`.
final class NnsInternetIdentityOpenIdCredential with CandidSerializable {
  final NnsInternetIdentityIss iss;
  final NnsInternetIdentitySub sub;
  final NnsInternetIdentityAud aud;
  final NnsInternetIdentityTimestamp? lastUsageTimestamp;
  final NnsInternetIdentityMetadataMapV2 metadata;
  final String? ssoDomain;
  final String? ssoName;

  const NnsInternetIdentityOpenIdCredential({
    required this.iss,
    required this.sub,
    required this.aud,
    this.lastUsageTimestamp,
    required this.metadata,
    this.ssoDomain,
    this.ssoName,
  });

  static CType get ctype => CType.record([
    Field(Label.named('iss'), CType.text),
    Field(Label.named('sub'), CType.text),
    Field(Label.named('aud'), CType.text),
    Field(Label.named('last_usage_timestamp'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('metadata'),
      () => NnsInternetIdentityMetadataMapV2Candid.ctype,
    ),
    Field(Label.named('sso_domain'), CType.opt(CType.text)),
    Field(Label.named('sso_name'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'iss': iss,
    'sub': sub,
    'aud': aud,
    'last_usage_timestamp': lastUsageTimestamp,
    'metadata': metadata.map((el) => el.candidValue).toList(),
    'sso_domain': ssoDomain,
    'sso_name': ssoName,
  };

  Map<String, dynamic> toJson() => {
    'iss': iss,
    'sub': sub,
    'aud': aud,
    'last_usage_timestamp': lastUsageTimestamp,
    'metadata': metadata.map((el) => el.toJson()).toList(),
    'sso_domain': ssoDomain,
    'sso_name': ssoName,
  };

  factory NnsInternetIdentityOpenIdCredential.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityOpenIdCredential(
      iss: json.valueAsString<String>('iss'),
      sub: json.valueAsString<String>('sub'),
      aud: json.valueAsString<String>('aud'),
      lastUsageTimestamp: json.valueAsBigInt<BigInt?>('last_usage_timestamp'),
      metadata: json.valueTo<List<NnsInternetIdentityMetadataMapV2Item>, List>(
        key: 'metadata',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityMetadataMapV2Item>(
                      (x) => NnsInternetIdentityMetadataMapV2Item.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      ssoDomain: json.valueAsString<String?>('sso_domain'),
      ssoName: json.valueAsString<String?>('sso_name'),
    );
  }

  factory NnsInternetIdentityOpenIdCredential.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenIdCredential.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `OpenIdCredentialAddError`.
sealed class NnsInternetIdentityOpenIdCredentialAddError
    with CandidSerializable {
  const NnsInternetIdentityOpenIdCredentialAddError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('JwtVerificationFailed'), CType.null_),
    Field(Label.named('OpenIdCredentialAlreadyRegistered'), CType.null_),
    Field(Label.named('InternalCanisterError'), CType.text),
    Field(Label.named('JwtExpired'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityOpenIdCredentialAddError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityOpenIdCredentialAddErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('JwtVerificationFailed')) {
      return const NnsInternetIdentityOpenIdCredentialAddErrorJwtVerificationFailed();
    }
    if (json.containsKey('OpenIdCredentialAlreadyRegistered')) {
      return const NnsInternetIdentityOpenIdCredentialAddErrorOpenIdCredentialAlreadyRegistered();
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityOpenIdCredentialAddErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    if (json.containsKey('JwtExpired')) {
      return const NnsInternetIdentityOpenIdCredentialAddErrorJwtExpired();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityOpenIdCredentialAddError.fromCandid',
      reason: 'Unknown NnsInternetIdentityOpenIdCredentialAddError arm',
    );
  }

  factory NnsInternetIdentityOpenIdCredentialAddError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenIdCredentialAddError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `OpenIdCredentialAddError.Unauthorized`.
final class NnsInternetIdentityOpenIdCredentialAddErrorUnauthorized
    extends NnsInternetIdentityOpenIdCredentialAddError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityOpenIdCredentialAddErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityOpenIdCredentialAddError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `OpenIdCredentialAddError.JwtVerificationFailed` (nullary).
final class NnsInternetIdentityOpenIdCredentialAddErrorJwtVerificationFailed
    extends NnsInternetIdentityOpenIdCredentialAddError {
  const NnsInternetIdentityOpenIdCredentialAddErrorJwtVerificationFailed();

  @override
  CType get candidType => NnsInternetIdentityOpenIdCredentialAddError.ctype;

  @override
  dynamic get candidValue => const Variant('JwtVerificationFailed', null);

  @override
  Map<String, dynamic> toJson() => {'JwtVerificationFailed': null};
}

/// Variant arm `OpenIdCredentialAddError.OpenIdCredentialAlreadyRegistered` (nullary).
final class NnsInternetIdentityOpenIdCredentialAddErrorOpenIdCredentialAlreadyRegistered
    extends NnsInternetIdentityOpenIdCredentialAddError {
  const NnsInternetIdentityOpenIdCredentialAddErrorOpenIdCredentialAlreadyRegistered();

  @override
  CType get candidType => NnsInternetIdentityOpenIdCredentialAddError.ctype;

  @override
  dynamic get candidValue =>
      const Variant('OpenIdCredentialAlreadyRegistered', null);

  @override
  Map<String, dynamic> toJson() => {'OpenIdCredentialAlreadyRegistered': null};
}

/// Variant arm `OpenIdCredentialAddError.InternalCanisterError`.
final class NnsInternetIdentityOpenIdCredentialAddErrorInternalCanisterError
    extends NnsInternetIdentityOpenIdCredentialAddError {
  final String value;
  const NnsInternetIdentityOpenIdCredentialAddErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityOpenIdCredentialAddError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Variant arm `OpenIdCredentialAddError.JwtExpired` (nullary).
final class NnsInternetIdentityOpenIdCredentialAddErrorJwtExpired
    extends NnsInternetIdentityOpenIdCredentialAddError {
  const NnsInternetIdentityOpenIdCredentialAddErrorJwtExpired();

  @override
  CType get candidType => NnsInternetIdentityOpenIdCredentialAddError.ctype;

  @override
  dynamic get candidValue => const Variant('JwtExpired', null);

  @override
  Map<String, dynamic> toJson() => {'JwtExpired': null};
}

/// Candid variant `OpenIdCredentialRemoveError`.
sealed class NnsInternetIdentityOpenIdCredentialRemoveError
    with CandidSerializable {
  const NnsInternetIdentityOpenIdCredentialRemoveError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('OpenIdCredentialNotFound'), CType.null_),
    Field(Label.named('InternalCanisterError'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityOpenIdCredentialRemoveError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityOpenIdCredentialRemoveErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('OpenIdCredentialNotFound')) {
      return const NnsInternetIdentityOpenIdCredentialRemoveErrorOpenIdCredentialNotFound();
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityOpenIdCredentialRemoveErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityOpenIdCredentialRemoveError.fromCandid',
      reason: 'Unknown NnsInternetIdentityOpenIdCredentialRemoveError arm',
    );
  }

  factory NnsInternetIdentityOpenIdCredentialRemoveError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenIdCredentialRemoveError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `OpenIdCredentialRemoveError.Unauthorized`.
final class NnsInternetIdentityOpenIdCredentialRemoveErrorUnauthorized
    extends NnsInternetIdentityOpenIdCredentialRemoveError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityOpenIdCredentialRemoveErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityOpenIdCredentialRemoveError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `OpenIdCredentialRemoveError.OpenIdCredentialNotFound` (nullary).
final class NnsInternetIdentityOpenIdCredentialRemoveErrorOpenIdCredentialNotFound
    extends NnsInternetIdentityOpenIdCredentialRemoveError {
  const NnsInternetIdentityOpenIdCredentialRemoveErrorOpenIdCredentialNotFound();

  @override
  CType get candidType => NnsInternetIdentityOpenIdCredentialRemoveError.ctype;

  @override
  dynamic get candidValue => const Variant('OpenIdCredentialNotFound', null);

  @override
  Map<String, dynamic> toJson() => {'OpenIdCredentialNotFound': null};
}

/// Variant arm `OpenIdCredentialRemoveError.InternalCanisterError`.
final class NnsInternetIdentityOpenIdCredentialRemoveErrorInternalCanisterError
    extends NnsInternetIdentityOpenIdCredentialRemoveError {
  final String value;
  const NnsInternetIdentityOpenIdCredentialRemoveErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityOpenIdCredentialRemoveError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Candid variant `OpenIdDelegationError`.
sealed class NnsInternetIdentityOpenIdDelegationError with CandidSerializable {
  const NnsInternetIdentityOpenIdDelegationError();

  static CType get ctype => CType.variant([
    Field(Label.named('NoSuchAnchor'), CType.null_),
    Field(Label.named('JwtVerificationFailed'), CType.null_),
    Field(Label.named('NoSuchDelegation'), CType.null_),
    Field(Label.named('JwtExpired'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityOpenIdDelegationError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('NoSuchAnchor')) {
      return const NnsInternetIdentityOpenIdDelegationErrorNoSuchAnchor();
    }
    if (json.containsKey('JwtVerificationFailed')) {
      return const NnsInternetIdentityOpenIdDelegationErrorJwtVerificationFailed();
    }
    if (json.containsKey('NoSuchDelegation')) {
      return const NnsInternetIdentityOpenIdDelegationErrorNoSuchDelegation();
    }
    if (json.containsKey('JwtExpired')) {
      return const NnsInternetIdentityOpenIdDelegationErrorJwtExpired();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityOpenIdDelegationError.fromCandid',
      reason: 'Unknown NnsInternetIdentityOpenIdDelegationError arm',
    );
  }

  factory NnsInternetIdentityOpenIdDelegationError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenIdDelegationError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `OpenIdDelegationError.NoSuchAnchor` (nullary).
final class NnsInternetIdentityOpenIdDelegationErrorNoSuchAnchor
    extends NnsInternetIdentityOpenIdDelegationError {
  const NnsInternetIdentityOpenIdDelegationErrorNoSuchAnchor();

  @override
  CType get candidType => NnsInternetIdentityOpenIdDelegationError.ctype;

  @override
  dynamic get candidValue => const Variant('NoSuchAnchor', null);

  @override
  Map<String, dynamic> toJson() => {'NoSuchAnchor': null};
}

/// Variant arm `OpenIdDelegationError.JwtVerificationFailed` (nullary).
final class NnsInternetIdentityOpenIdDelegationErrorJwtVerificationFailed
    extends NnsInternetIdentityOpenIdDelegationError {
  const NnsInternetIdentityOpenIdDelegationErrorJwtVerificationFailed();

  @override
  CType get candidType => NnsInternetIdentityOpenIdDelegationError.ctype;

  @override
  dynamic get candidValue => const Variant('JwtVerificationFailed', null);

  @override
  Map<String, dynamic> toJson() => {'JwtVerificationFailed': null};
}

/// Variant arm `OpenIdDelegationError.NoSuchDelegation` (nullary).
final class NnsInternetIdentityOpenIdDelegationErrorNoSuchDelegation
    extends NnsInternetIdentityOpenIdDelegationError {
  const NnsInternetIdentityOpenIdDelegationErrorNoSuchDelegation();

  @override
  CType get candidType => NnsInternetIdentityOpenIdDelegationError.ctype;

  @override
  dynamic get candidValue => const Variant('NoSuchDelegation', null);

  @override
  Map<String, dynamic> toJson() => {'NoSuchDelegation': null};
}

/// Variant arm `OpenIdDelegationError.JwtExpired` (nullary).
final class NnsInternetIdentityOpenIdDelegationErrorJwtExpired
    extends NnsInternetIdentityOpenIdDelegationError {
  const NnsInternetIdentityOpenIdDelegationErrorJwtExpired();

  @override
  CType get candidType => NnsInternetIdentityOpenIdDelegationError.ctype;

  @override
  dynamic get candidValue => const Variant('JwtExpired', null);

  @override
  Map<String, dynamic> toJson() => {'JwtExpired': null};
}

/// Candid record `OpenIdPrepareDelegationResponse`.
final class NnsInternetIdentityOpenIdPrepareDelegationResponse
    with CandidSerializable {
  final NnsInternetIdentityUserKey userKey;
  final NnsInternetIdentityTimestamp expiration;
  final NnsInternetIdentityUserNumber anchorNumber;

  const NnsInternetIdentityOpenIdPrepareDelegationResponse({
    required this.userKey,
    required this.expiration,
    required this.anchorNumber,
  });

  static CType get ctype => CType.record([
    Field(Label.named('user_key'), CType.vec(CType.nat8)),
    Field(Label.named('expiration'), CType.nat64),
    Field(Label.named('anchor_number'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'user_key': userKey,
    'expiration': expiration,
    'anchor_number': anchorNumber,
  };

  Map<String, dynamic> toJson() => {
    'user_key': userKey,
    'expiration': expiration,
    'anchor_number': anchorNumber,
  };

  factory NnsInternetIdentityOpenIdPrepareDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityOpenIdPrepareDelegationResponse(
      userKey: json.valueAsBytes<List<int>>(
        'user_key',
        encoding: StringEncoding.base64,
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
      anchorNumber: json.valueAsBigInt<BigInt>('anchor_number'),
    );
  }

  factory NnsInternetIdentityOpenIdPrepareDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenIdPrepareDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SsoPrepareDelegationRequest`.
final class NnsInternetIdentitySsoPrepareDelegationRequest
    with CandidSerializable {
  final NnsInternetIdentityJWT jwt;
  final NnsInternetIdentitySalt salt;
  final NnsInternetIdentitySessionKey sessionKey;
  final String orgDomain;
  final NnsInternetIdentityFrontendHostname targetAppOrigin;

  const NnsInternetIdentitySsoPrepareDelegationRequest({
    required this.jwt,
    required this.salt,
    required this.sessionKey,
    required this.orgDomain,
    required this.targetAppOrigin,
  });

  static CType get ctype => CType.record([
    Field(Label.named('jwt'), CType.text),
    Field(Label.named('salt'), CType.vec(CType.nat8)),
    Field(Label.named('session_key'), CType.vec(CType.nat8)),
    Field(Label.named('org_domain'), CType.text),
    Field(Label.named('target_app_origin'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'jwt': jwt,
    'salt': salt,
    'session_key': sessionKey,
    'org_domain': orgDomain,
    'target_app_origin': targetAppOrigin,
  };

  Map<String, dynamic> toJson() => {
    'jwt': jwt,
    'salt': salt,
    'session_key': sessionKey,
    'org_domain': orgDomain,
    'target_app_origin': targetAppOrigin,
  };

  factory NnsInternetIdentitySsoPrepareDelegationRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySsoPrepareDelegationRequest(
      jwt: json.valueAsString<String>('jwt'),
      salt: json.valueAsBytes<List<int>>(
        'salt',
        encoding: StringEncoding.base64,
      ),
      sessionKey: json.valueAsBytes<List<int>>(
        'session_key',
        encoding: StringEncoding.base64,
      ),
      orgDomain: json.valueAsString<String>('org_domain'),
      targetAppOrigin: json.valueAsString<String>('target_app_origin'),
    );
  }

  factory NnsInternetIdentitySsoPrepareDelegationRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySsoPrepareDelegationRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SsoGetDelegationRequest`.
final class NnsInternetIdentitySsoGetDelegationRequest with CandidSerializable {
  final NnsInternetIdentityJWT jwt;
  final NnsInternetIdentitySalt salt;
  final NnsInternetIdentitySessionKey sessionKey;
  final NnsInternetIdentityTimestamp expiration;
  final String orgDomain;
  final NnsInternetIdentityFrontendHostname targetAppOrigin;
  final List<int> ssoAttrBundle;

  const NnsInternetIdentitySsoGetDelegationRequest({
    required this.jwt,
    required this.salt,
    required this.sessionKey,
    required this.expiration,
    required this.orgDomain,
    required this.targetAppOrigin,
    required this.ssoAttrBundle,
  });

  static CType get ctype => CType.record([
    Field(Label.named('jwt'), CType.text),
    Field(Label.named('salt'), CType.vec(CType.nat8)),
    Field(Label.named('session_key'), CType.vec(CType.nat8)),
    Field(Label.named('expiration'), CType.nat64),
    Field(Label.named('org_domain'), CType.text),
    Field(Label.named('target_app_origin'), CType.text),
    Field(Label.named('sso_attr_bundle'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'jwt': jwt,
    'salt': salt,
    'session_key': sessionKey,
    'expiration': expiration,
    'org_domain': orgDomain,
    'target_app_origin': targetAppOrigin,
    'sso_attr_bundle': ssoAttrBundle,
  };

  Map<String, dynamic> toJson() => {
    'jwt': jwt,
    'salt': salt,
    'session_key': sessionKey,
    'expiration': expiration,
    'org_domain': orgDomain,
    'target_app_origin': targetAppOrigin,
    'sso_attr_bundle': ssoAttrBundle,
  };

  factory NnsInternetIdentitySsoGetDelegationRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySsoGetDelegationRequest(
      jwt: json.valueAsString<String>('jwt'),
      salt: json.valueAsBytes<List<int>>(
        'salt',
        encoding: StringEncoding.base64,
      ),
      sessionKey: json.valueAsBytes<List<int>>(
        'session_key',
        encoding: StringEncoding.base64,
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
      orgDomain: json.valueAsString<String>('org_domain'),
      targetAppOrigin: json.valueAsString<String>('target_app_origin'),
      ssoAttrBundle: json.valueAsBytes<List<int>>(
        'sso_attr_bundle',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentitySsoGetDelegationRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySsoGetDelegationRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SsoPrepareDelegationResponse`.
final class NnsInternetIdentitySsoPrepareDelegationResponse
    with CandidSerializable {
  final NnsInternetIdentityUserKey userKey;
  final NnsInternetIdentityTimestamp expiration;
  final NnsInternetIdentityUserNumber anchorNumber;
  final List<int> ssoAttrBundle;

  const NnsInternetIdentitySsoPrepareDelegationResponse({
    required this.userKey,
    required this.expiration,
    required this.anchorNumber,
    required this.ssoAttrBundle,
  });

  static CType get ctype => CType.record([
    Field(Label.named('user_key'), CType.vec(CType.nat8)),
    Field(Label.named('expiration'), CType.nat64),
    Field(Label.named('anchor_number'), CType.nat64),
    Field(Label.named('sso_attr_bundle'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'user_key': userKey,
    'expiration': expiration,
    'anchor_number': anchorNumber,
    'sso_attr_bundle': ssoAttrBundle,
  };

  Map<String, dynamic> toJson() => {
    'user_key': userKey,
    'expiration': expiration,
    'anchor_number': anchorNumber,
    'sso_attr_bundle': ssoAttrBundle,
  };

  factory NnsInternetIdentitySsoPrepareDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySsoPrepareDelegationResponse(
      userKey: json.valueAsBytes<List<int>>(
        'user_key',
        encoding: StringEncoding.base64,
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
      anchorNumber: json.valueAsBigInt<BigInt>('anchor_number'),
      ssoAttrBundle: json.valueAsBytes<List<int>>(
        'sso_attr_bundle',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentitySsoPrepareDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySsoPrepareDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SsoGetDelegationResponse`.
final class NnsInternetIdentitySsoGetDelegationResponse
    with CandidSerializable {
  final NnsInternetIdentitySignedDelegation signedDelegation;
  final List<int> ssoAttrBundleSignature;

  const NnsInternetIdentitySsoGetDelegationResponse({
    required this.signedDelegation,
    required this.ssoAttrBundleSignature,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('signed_delegation'),
      () => NnsInternetIdentitySignedDelegation.ctype,
    ),
    Field(Label.named('sso_attr_bundle_signature'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'signed_delegation': signedDelegation.candidValue,
    'sso_attr_bundle_signature': ssoAttrBundleSignature,
  };

  Map<String, dynamic> toJson() => {
    'signed_delegation': signedDelegation.toJson(),
    'sso_attr_bundle_signature': ssoAttrBundleSignature,
  };

  factory NnsInternetIdentitySsoGetDelegationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySsoGetDelegationResponse(
      signedDelegation: json.valueTo<NnsInternetIdentitySignedDelegation, Map>(
        key: 'signed_delegation',
        parse:
            (e) => NnsInternetIdentitySignedDelegation.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      ssoAttrBundleSignature: json.valueAsBytes<List<int>>(
        'sso_attr_bundle_signature',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentitySsoGetDelegationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySsoGetDelegationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `EmailRecoveryCredential`.
final class NnsInternetIdentityEmailRecoveryCredential with CandidSerializable {
  final String address;
  final NnsInternetIdentityTimestamp createdAt;
  final NnsInternetIdentityTimestamp? lastUsed;

  const NnsInternetIdentityEmailRecoveryCredential({
    required this.address,
    required this.createdAt,
    this.lastUsed,
  });

  static CType get ctype => CType.record([
    Field(Label.named('address'), CType.text),
    Field(Label.named('created_at'), CType.nat64),
    Field(Label.named('last_used'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'address': address,
    'created_at': createdAt,
    'last_used': lastUsed,
  };

  Map<String, dynamic> toJson() => {
    'address': address,
    'created_at': createdAt,
    'last_used': lastUsed,
  };

  factory NnsInternetIdentityEmailRecoveryCredential.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityEmailRecoveryCredential(
      address: json.valueAsString<String>('address'),
      createdAt: json.valueAsBigInt<BigInt>('created_at'),
      lastUsed: json.valueAsBigInt<BigInt?>('last_used'),
    );
  }

  factory NnsInternetIdentityEmailRecoveryCredential.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailRecoveryCredential.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `VerifiedEmail`.
final class NnsInternetIdentityVerifiedEmail with CandidSerializable {
  final String address;
  final NnsInternetIdentityTimestamp verifiedAt;

  const NnsInternetIdentityVerifiedEmail({
    required this.address,
    required this.verifiedAt,
  });

  static CType get ctype => CType.record([
    Field(Label.named('address'), CType.text),
    Field(Label.named('verified_at'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'address': address, 'verified_at': verifiedAt};

  Map<String, dynamic> toJson() => {
    'address': address,
    'verified_at': verifiedAt,
  };

  factory NnsInternetIdentityVerifiedEmail.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityVerifiedEmail(
      address: json.valueAsString<String>('address'),
      verifiedAt: json.valueAsBigInt<BigInt>('verified_at'),
    );
  }

  factory NnsInternetIdentityVerifiedEmail.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityVerifiedEmail.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `EmailChallenge`.
final class NnsInternetIdentityEmailChallenge with CandidSerializable {
  final String nonce;
  final NnsInternetIdentityTimestamp expiresAt;

  const NnsInternetIdentityEmailChallenge({
    required this.nonce,
    required this.expiresAt,
  });

  static CType get ctype => CType.record([
    Field(Label.named('nonce'), CType.text),
    Field(Label.named('expires_at'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'nonce': nonce, 'expires_at': expiresAt};

  Map<String, dynamic> toJson() => {'nonce': nonce, 'expires_at': expiresAt};

  factory NnsInternetIdentityEmailChallenge.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityEmailChallenge(
      nonce: json.valueAsString<String>('nonce'),
      expiresAt: json.valueAsBigInt<BigInt>('expires_at'),
    );
  }

  factory NnsInternetIdentityEmailChallenge.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailChallenge.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `EmailChallengeDnsInput`.
final class NnsInternetIdentityEmailChallengeDnsInput with CandidSerializable {
  final String address;
  final NnsInternetIdentityDnsProofBundle? dnsProof;

  const NnsInternetIdentityEmailChallengeDnsInput({
    required this.address,
    this.dnsProof,
  });

  static CType get ctype => CType.record([
    Field(Label.named('address'), CType.text),
    LazyField(
      Label.named('dns_proof'),
      () => CType.opt(NnsInternetIdentityDnsProofBundle.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'address': address,
    'dns_proof': dnsProof?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'address': address,
    'dns_proof': dnsProof?.toJson(),
  };

  factory NnsInternetIdentityEmailChallengeDnsInput.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityEmailChallengeDnsInput(
      address: json.valueAsString<String>('address'),
      dnsProof: json.valueTo<NnsInternetIdentityDnsProofBundle?, Map>(
        key: 'dns_proof',
        parse:
            (e) => NnsInternetIdentityDnsProofBundle.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentityEmailChallengeDnsInput.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailChallengeDnsInput.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `EmailChallengeSubmitDkimLeafArg`.
final class NnsInternetIdentityEmailChallengeSubmitDkimLeafArg
    with CandidSerializable {
  final String nonce;
  final List<NnsInternetIdentitySignedRRset> hops;
  final List<NnsInternetIdentityDelegationChain> extraChains;

  const NnsInternetIdentityEmailChallengeSubmitDkimLeafArg({
    required this.nonce,
    required this.hops,
    required this.extraChains,
  });

  static CType get ctype => CType.record([
    Field(Label.named('nonce'), CType.text),
    LazyField(
      Label.named('hops'),
      () => CType.vec(NnsInternetIdentitySignedRRset.ctype),
    ),
    LazyField(
      Label.named('extra_chains'),
      () => CType.vec(NnsInternetIdentityDelegationChain.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'nonce': nonce,
    'hops': hops.map((el) => el.candidValue).toList(),
    'extra_chains': extraChains.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'nonce': nonce,
    'hops': hops.map((el) => el.toJson()).toList(),
    'extra_chains': extraChains.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityEmailChallengeSubmitDkimLeafArg.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityEmailChallengeSubmitDkimLeafArg(
      nonce: json.valueAsString<String>('nonce'),
      hops: json.valueTo<List<NnsInternetIdentitySignedRRset>, List>(
        key: 'hops',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentitySignedRRset>(
                      (x) => NnsInternetIdentitySignedRRset.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      extraChains: json.valueTo<List<NnsInternetIdentityDelegationChain>, List>(
        key: 'extra_chains',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityDelegationChain>(
                      (x) => NnsInternetIdentityDelegationChain.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityEmailChallengeSubmitDkimLeafArg.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailChallengeSubmitDkimLeafArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `EmailChallengeResolveViaDohArg`.
final class NnsInternetIdentityEmailChallengeResolveViaDohArg
    with CandidSerializable {
  final String nonce;

  const NnsInternetIdentityEmailChallengeResolveViaDohArg({
    required this.nonce,
  });

  static CType get ctype =>
      CType.record([Field(Label.named('nonce'), CType.text)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'nonce': nonce};

  Map<String, dynamic> toJson() => {'nonce': nonce};

  factory NnsInternetIdentityEmailChallengeResolveViaDohArg.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityEmailChallengeResolveViaDohArg(
      nonce: json.valueAsString<String>('nonce'),
    );
  }

  factory NnsInternetIdentityEmailChallengeResolveViaDohArg.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailChallengeResolveViaDohArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Rrsig`.
final class NnsInternetIdentityRrsig with CandidSerializable {
  final int typeCovered;
  final int algorithm;
  final int labels;
  final int originalTtl;
  final int expiration;
  final int inception;
  final int keyTag;
  final List<int> signerName;
  final List<int> signature;

  const NnsInternetIdentityRrsig({
    required this.typeCovered,
    required this.algorithm,
    required this.labels,
    required this.originalTtl,
    required this.expiration,
    required this.inception,
    required this.keyTag,
    required this.signerName,
    required this.signature,
  });

  static CType get ctype => CType.record([
    Field(Label.named('type_covered'), CType.nat16),
    Field(Label.named('algorithm'), CType.nat8),
    Field(Label.named('labels'), CType.nat8),
    Field(Label.named('original_ttl'), CType.nat32),
    Field(Label.named('expiration'), CType.nat32),
    Field(Label.named('inception'), CType.nat32),
    Field(Label.named('key_tag'), CType.nat16),
    Field(Label.named('signer_name'), CType.vec(CType.nat8)),
    Field(Label.named('signature'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'type_covered': typeCovered,
    'algorithm': algorithm,
    'labels': labels,
    'original_ttl': originalTtl,
    'expiration': expiration,
    'inception': inception,
    'key_tag': keyTag,
    'signer_name': signerName,
    'signature': signature,
  };

  Map<String, dynamic> toJson() => {
    'type_covered': typeCovered,
    'algorithm': algorithm,
    'labels': labels,
    'original_ttl': originalTtl,
    'expiration': expiration,
    'inception': inception,
    'key_tag': keyTag,
    'signer_name': signerName,
    'signature': signature,
  };

  factory NnsInternetIdentityRrsig.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityRrsig(
      typeCovered: json.valueAsInt<int>('type_covered'),
      algorithm: json.valueAsInt<int>('algorithm'),
      labels: json.valueAsInt<int>('labels'),
      originalTtl: json.valueAsInt<int>('original_ttl'),
      expiration: json.valueAsInt<int>('expiration'),
      inception: json.valueAsInt<int>('inception'),
      keyTag: json.valueAsInt<int>('key_tag'),
      signerName: json.valueAsBytes<List<int>>(
        'signer_name',
        encoding: StringEncoding.base64,
      ),
      signature: json.valueAsBytes<List<int>>(
        'signature',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityRrsig.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityRrsig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SignedRRset`.
final class NnsInternetIdentitySignedRRset with CandidSerializable {
  final List<int> name;
  final int rtype;
  final List<int> rdata;
  final int ttl;
  final NnsInternetIdentityRrsig rrsig;

  const NnsInternetIdentitySignedRRset({
    required this.name,
    required this.rtype,
    required this.rdata,
    required this.ttl,
    required this.rrsig,
  });

  static CType get ctype => CType.record([
    Field(Label.named('name'), CType.vec(CType.nat8)),
    Field(Label.named('rtype'), CType.nat16),
    Field(Label.named('rdata'), CType.vec(CType.vec(CType.nat8))),
    Field(Label.named('ttl'), CType.nat32),
    LazyField(Label.named('rrsig'), () => NnsInternetIdentityRrsig.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'name': name,
    'rtype': rtype,
    'rdata': rdata,
    'ttl': ttl,
    'rrsig': rrsig.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'name': name,
    'rtype': rtype,
    'rdata': rdata,
    'ttl': ttl,
    'rrsig': rrsig.toJson(),
  };

  factory NnsInternetIdentitySignedRRset.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentitySignedRRset(
      name: json.valueAsBytes<List<int>>(
        'name',
        encoding: StringEncoding.base64,
      ),
      rtype: json.valueAsInt<int>('rtype'),
      rdata: json.valueAsBytes<List<int>>(
        'rdata',
        encoding: StringEncoding.base64,
      ),
      ttl: json.valueAsInt<int>('ttl'),
      rrsig: json.valueTo<NnsInternetIdentityRrsig, Map>(
        key: 'rrsig',
        parse:
            (e) => NnsInternetIdentityRrsig.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentitySignedRRset.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySignedRRset.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DelegationLink`.
final class NnsInternetIdentityDelegationLink with CandidSerializable {
  final NnsInternetIdentitySignedRRset childDs;
  final NnsInternetIdentitySignedRRset childDnskey;

  const NnsInternetIdentityDelegationLink({
    required this.childDs,
    required this.childDnskey,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('child_ds'),
      () => NnsInternetIdentitySignedRRset.ctype,
    ),
    LazyField(
      Label.named('child_dnskey'),
      () => NnsInternetIdentitySignedRRset.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'child_ds': childDs.candidValue,
    'child_dnskey': childDnskey.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'child_ds': childDs.toJson(),
    'child_dnskey': childDnskey.toJson(),
  };

  factory NnsInternetIdentityDelegationLink.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityDelegationLink(
      childDs: json.valueTo<NnsInternetIdentitySignedRRset, Map>(
        key: 'child_ds',
        parse:
            (e) => NnsInternetIdentitySignedRRset.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      childDnskey: json.valueTo<NnsInternetIdentitySignedRRset, Map>(
        key: 'child_dnskey',
        parse:
            (e) => NnsInternetIdentitySignedRRset.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentityDelegationLink.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDelegationLink.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DelegationChain`.
final class NnsInternetIdentityDelegationChain with CandidSerializable {
  final List<NnsInternetIdentityDelegationLink> links;

  const NnsInternetIdentityDelegationChain({required this.links});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('links'),
      () => CType.vec(NnsInternetIdentityDelegationLink.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'links': links.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'links': links.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityDelegationChain.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityDelegationChain(
      links: json.valueTo<List<NnsInternetIdentityDelegationLink>, List>(
        key: 'links',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityDelegationLink>(
                      (x) => NnsInternetIdentityDelegationLink.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityDelegationChain.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDelegationChain.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DnsProofBundle`.
final class NnsInternetIdentityDnsProofBundle with CandidSerializable {
  final NnsInternetIdentitySignedRRset rootDnskey;
  final List<NnsInternetIdentityDelegationChain> chains;
  final List<NnsInternetIdentitySignedRRset> hops;

  const NnsInternetIdentityDnsProofBundle({
    required this.rootDnskey,
    required this.chains,
    required this.hops,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('root_dnskey'),
      () => NnsInternetIdentitySignedRRset.ctype,
    ),
    LazyField(
      Label.named('chains'),
      () => CType.vec(NnsInternetIdentityDelegationChain.ctype),
    ),
    LazyField(
      Label.named('hops'),
      () => CType.vec(NnsInternetIdentitySignedRRset.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'root_dnskey': rootDnskey.candidValue,
    'chains': chains.map((el) => el.candidValue).toList(),
    'hops': hops.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'root_dnskey': rootDnskey.toJson(),
    'chains': chains.map((el) => el.toJson()).toList(),
    'hops': hops.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityDnsProofBundle.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityDnsProofBundle(
      rootDnskey: json.valueTo<NnsInternetIdentitySignedRRset, Map>(
        key: 'root_dnskey',
        parse:
            (e) => NnsInternetIdentitySignedRRset.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      chains: json.valueTo<List<NnsInternetIdentityDelegationChain>, List>(
        key: 'chains',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityDelegationChain>(
                      (x) => NnsInternetIdentityDelegationChain.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      hops: json.valueTo<List<NnsInternetIdentitySignedRRset>, List>(
        key: 'hops',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentitySignedRRset>(
                      (x) => NnsInternetIdentitySignedRRset.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityDnsProofBundle.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDnsProofBundle.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `DohFailureReason`.
sealed class NnsInternetIdentityDohFailureReason with CandidSerializable {
  const NnsInternetIdentityDohFailureReason();

  static CType get ctype => CType.variant([
    Field(Label.named('AllProvidersFailed'), CType.null_),
    Field(
      Label.named('QuorumFailed'),
      CType.record([
        Field(Label.named('agreeing'), CType.nat32),
        Field(Label.named('total'), CType.nat32),
      ]),
    ),
    Field(Label.named('ResponseMalformed'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityDohFailureReason.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('AllProvidersFailed')) {
      return const NnsInternetIdentityDohFailureReasonAllProvidersFailed();
    }
    if (json.containsKey('QuorumFailed')) {
      return NnsInternetIdentityDohFailureReasonQuorumFailed.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['QuorumFailed']),
      );
    }
    if (json.containsKey('ResponseMalformed')) {
      return NnsInternetIdentityDohFailureReasonResponseMalformed(
        json.valueAsString<String>('ResponseMalformed'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityDohFailureReason.fromCandid',
      reason: 'Unknown NnsInternetIdentityDohFailureReason arm',
    );
  }

  factory NnsInternetIdentityDohFailureReason.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDohFailureReason.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `DohFailureReason.AllProvidersFailed` (nullary).
final class NnsInternetIdentityDohFailureReasonAllProvidersFailed
    extends NnsInternetIdentityDohFailureReason {
  const NnsInternetIdentityDohFailureReasonAllProvidersFailed();

  @override
  CType get candidType => NnsInternetIdentityDohFailureReason.ctype;

  @override
  dynamic get candidValue => const Variant('AllProvidersFailed', null);

  @override
  Map<String, dynamic> toJson() => {'AllProvidersFailed': null};
}

/// Variant arm `DohFailureReason.QuorumFailed`.
final class NnsInternetIdentityDohFailureReasonQuorumFailed
    extends NnsInternetIdentityDohFailureReason {
  final int agreeing;
  final int total;

  const NnsInternetIdentityDohFailureReasonQuorumFailed({
    required this.agreeing,
    required this.total,
  });

  @override
  CType get candidType => NnsInternetIdentityDohFailureReason.ctype;

  @override
  dynamic get candidValue =>
      Variant('QuorumFailed', {'agreeing': agreeing, 'total': total});

  @override
  Map<String, dynamic> toJson() => {
    'QuorumFailed': {'agreeing': agreeing, 'total': total},
  };

  factory NnsInternetIdentityDohFailureReasonQuorumFailed.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityDohFailureReasonQuorumFailed(
      agreeing: json.valueAsInt<int>('agreeing'),
      total: json.valueAsInt<int>('total'),
    );
  }
}

/// Variant arm `DohFailureReason.ResponseMalformed`.
final class NnsInternetIdentityDohFailureReasonResponseMalformed
    extends NnsInternetIdentityDohFailureReason {
  final String value;
  const NnsInternetIdentityDohFailureReasonResponseMalformed(this.value);

  @override
  CType get candidType => NnsInternetIdentityDohFailureReason.ctype;

  @override
  dynamic get candidValue => Variant('ResponseMalformed', value);

  @override
  Map<String, dynamic> toJson() => {'ResponseMalformed': value};
}

/// Candid variant `EmailChallengeError`.
sealed class NnsInternetIdentityEmailChallengeError with CandidSerializable {
  const NnsInternetIdentityEmailChallengeError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('NonceUnknown'), CType.null_),
    Field(Label.named('NonceExpired'), CType.null_),
    Field(Label.named('DomainNotAllowlisted'), CType.text),
    LazyField(
      Label.named('DohFetchFailed'),
      () => NnsInternetIdentityDohFailureReason.ctype,
    ),
    Field(Label.named('DomainNotSupported'), CType.text),
    Field(Label.named('EmailVerificationFailed'), CType.text),
    Field(Label.named('DkimLeafMismatch'), CType.null_),
    Field(Label.named('EmptyDkimLeafHops'), CType.null_),
    Field(Label.named('NoDkimLeafExpected'), CType.null_),
    Field(Label.named('AddressMismatch'), CType.null_),
    Field(Label.named('SubjectNotSigned'), CType.null_),
    Field(Label.named('AddressAlreadyRegistered'), CType.null_),
    Field(Label.named('AddressNotRegistered'), CType.null_),
    Field(Label.named('InvalidEmailAddress'), CType.text),
    Field(
      Label.named('LimitReached'),
      CType.record([Field(Label.named('limit'), CType.nat8)]),
    ),
    Field(Label.named('InternalCanisterError'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityEmailChallengeError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityEmailChallengeErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('NonceUnknown')) {
      return const NnsInternetIdentityEmailChallengeErrorNonceUnknown();
    }
    if (json.containsKey('NonceExpired')) {
      return const NnsInternetIdentityEmailChallengeErrorNonceExpired();
    }
    if (json.containsKey('DomainNotAllowlisted')) {
      return NnsInternetIdentityEmailChallengeErrorDomainNotAllowlisted(
        json.valueAsString<String>('DomainNotAllowlisted'),
      );
    }
    if (json.containsKey('DohFetchFailed')) {
      return NnsInternetIdentityEmailChallengeErrorDohFetchFailed(
        json.valueTo<NnsInternetIdentityDohFailureReason, Map>(
          key: 'DohFetchFailed',
          parse:
              (e) => NnsInternetIdentityDohFailureReason.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DomainNotSupported')) {
      return NnsInternetIdentityEmailChallengeErrorDomainNotSupported(
        json.valueAsString<String>('DomainNotSupported'),
      );
    }
    if (json.containsKey('EmailVerificationFailed')) {
      return NnsInternetIdentityEmailChallengeErrorEmailVerificationFailed(
        json.valueAsString<String>('EmailVerificationFailed'),
      );
    }
    if (json.containsKey('DkimLeafMismatch')) {
      return const NnsInternetIdentityEmailChallengeErrorDkimLeafMismatch();
    }
    if (json.containsKey('EmptyDkimLeafHops')) {
      return const NnsInternetIdentityEmailChallengeErrorEmptyDkimLeafHops();
    }
    if (json.containsKey('NoDkimLeafExpected')) {
      return const NnsInternetIdentityEmailChallengeErrorNoDkimLeafExpected();
    }
    if (json.containsKey('AddressMismatch')) {
      return const NnsInternetIdentityEmailChallengeErrorAddressMismatch();
    }
    if (json.containsKey('SubjectNotSigned')) {
      return const NnsInternetIdentityEmailChallengeErrorSubjectNotSigned();
    }
    if (json.containsKey('AddressAlreadyRegistered')) {
      return const NnsInternetIdentityEmailChallengeErrorAddressAlreadyRegistered();
    }
    if (json.containsKey('AddressNotRegistered')) {
      return const NnsInternetIdentityEmailChallengeErrorAddressNotRegistered();
    }
    if (json.containsKey('InvalidEmailAddress')) {
      return NnsInternetIdentityEmailChallengeErrorInvalidEmailAddress(
        json.valueAsString<String>('InvalidEmailAddress'),
      );
    }
    if (json.containsKey('LimitReached')) {
      return NnsInternetIdentityEmailChallengeErrorLimitReached.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['LimitReached']),
      );
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityEmailChallengeErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityEmailChallengeError.fromCandid',
      reason: 'Unknown NnsInternetIdentityEmailChallengeError arm',
    );
  }

  factory NnsInternetIdentityEmailChallengeError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailChallengeError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `EmailChallengeError.Unauthorized`.
final class NnsInternetIdentityEmailChallengeErrorUnauthorized
    extends NnsInternetIdentityEmailChallengeError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityEmailChallengeErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `EmailChallengeError.NonceUnknown` (nullary).
final class NnsInternetIdentityEmailChallengeErrorNonceUnknown
    extends NnsInternetIdentityEmailChallengeError {
  const NnsInternetIdentityEmailChallengeErrorNonceUnknown();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => const Variant('NonceUnknown', null);

  @override
  Map<String, dynamic> toJson() => {'NonceUnknown': null};
}

/// Variant arm `EmailChallengeError.NonceExpired` (nullary).
final class NnsInternetIdentityEmailChallengeErrorNonceExpired
    extends NnsInternetIdentityEmailChallengeError {
  const NnsInternetIdentityEmailChallengeErrorNonceExpired();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => const Variant('NonceExpired', null);

  @override
  Map<String, dynamic> toJson() => {'NonceExpired': null};
}

/// Variant arm `EmailChallengeError.DomainNotAllowlisted`.
final class NnsInternetIdentityEmailChallengeErrorDomainNotAllowlisted
    extends NnsInternetIdentityEmailChallengeError {
  final String value;
  const NnsInternetIdentityEmailChallengeErrorDomainNotAllowlisted(this.value);

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => Variant('DomainNotAllowlisted', value);

  @override
  Map<String, dynamic> toJson() => {'DomainNotAllowlisted': value};
}

/// Variant arm `EmailChallengeError.DohFetchFailed`.
final class NnsInternetIdentityEmailChallengeErrorDohFetchFailed
    extends NnsInternetIdentityEmailChallengeError {
  final NnsInternetIdentityDohFailureReason value;
  const NnsInternetIdentityEmailChallengeErrorDohFetchFailed(this.value);

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => Variant('DohFetchFailed', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DohFetchFailed': value.toJson()};
}

/// Variant arm `EmailChallengeError.DomainNotSupported`.
final class NnsInternetIdentityEmailChallengeErrorDomainNotSupported
    extends NnsInternetIdentityEmailChallengeError {
  final String value;
  const NnsInternetIdentityEmailChallengeErrorDomainNotSupported(this.value);

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => Variant('DomainNotSupported', value);

  @override
  Map<String, dynamic> toJson() => {'DomainNotSupported': value};
}

/// Variant arm `EmailChallengeError.EmailVerificationFailed`.
final class NnsInternetIdentityEmailChallengeErrorEmailVerificationFailed
    extends NnsInternetIdentityEmailChallengeError {
  final String value;
  const NnsInternetIdentityEmailChallengeErrorEmailVerificationFailed(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => Variant('EmailVerificationFailed', value);

  @override
  Map<String, dynamic> toJson() => {'EmailVerificationFailed': value};
}

/// Variant arm `EmailChallengeError.DkimLeafMismatch` (nullary).
final class NnsInternetIdentityEmailChallengeErrorDkimLeafMismatch
    extends NnsInternetIdentityEmailChallengeError {
  const NnsInternetIdentityEmailChallengeErrorDkimLeafMismatch();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => const Variant('DkimLeafMismatch', null);

  @override
  Map<String, dynamic> toJson() => {'DkimLeafMismatch': null};
}

/// Variant arm `EmailChallengeError.EmptyDkimLeafHops` (nullary).
final class NnsInternetIdentityEmailChallengeErrorEmptyDkimLeafHops
    extends NnsInternetIdentityEmailChallengeError {
  const NnsInternetIdentityEmailChallengeErrorEmptyDkimLeafHops();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => const Variant('EmptyDkimLeafHops', null);

  @override
  Map<String, dynamic> toJson() => {'EmptyDkimLeafHops': null};
}

/// Variant arm `EmailChallengeError.NoDkimLeafExpected` (nullary).
final class NnsInternetIdentityEmailChallengeErrorNoDkimLeafExpected
    extends NnsInternetIdentityEmailChallengeError {
  const NnsInternetIdentityEmailChallengeErrorNoDkimLeafExpected();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => const Variant('NoDkimLeafExpected', null);

  @override
  Map<String, dynamic> toJson() => {'NoDkimLeafExpected': null};
}

/// Variant arm `EmailChallengeError.AddressMismatch` (nullary).
final class NnsInternetIdentityEmailChallengeErrorAddressMismatch
    extends NnsInternetIdentityEmailChallengeError {
  const NnsInternetIdentityEmailChallengeErrorAddressMismatch();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => const Variant('AddressMismatch', null);

  @override
  Map<String, dynamic> toJson() => {'AddressMismatch': null};
}

/// Variant arm `EmailChallengeError.SubjectNotSigned` (nullary).
final class NnsInternetIdentityEmailChallengeErrorSubjectNotSigned
    extends NnsInternetIdentityEmailChallengeError {
  const NnsInternetIdentityEmailChallengeErrorSubjectNotSigned();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => const Variant('SubjectNotSigned', null);

  @override
  Map<String, dynamic> toJson() => {'SubjectNotSigned': null};
}

/// Variant arm `EmailChallengeError.AddressAlreadyRegistered` (nullary).
final class NnsInternetIdentityEmailChallengeErrorAddressAlreadyRegistered
    extends NnsInternetIdentityEmailChallengeError {
  const NnsInternetIdentityEmailChallengeErrorAddressAlreadyRegistered();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => const Variant('AddressAlreadyRegistered', null);

  @override
  Map<String, dynamic> toJson() => {'AddressAlreadyRegistered': null};
}

/// Variant arm `EmailChallengeError.AddressNotRegistered` (nullary).
final class NnsInternetIdentityEmailChallengeErrorAddressNotRegistered
    extends NnsInternetIdentityEmailChallengeError {
  const NnsInternetIdentityEmailChallengeErrorAddressNotRegistered();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => const Variant('AddressNotRegistered', null);

  @override
  Map<String, dynamic> toJson() => {'AddressNotRegistered': null};
}

/// Variant arm `EmailChallengeError.InvalidEmailAddress`.
final class NnsInternetIdentityEmailChallengeErrorInvalidEmailAddress
    extends NnsInternetIdentityEmailChallengeError {
  final String value;
  const NnsInternetIdentityEmailChallengeErrorInvalidEmailAddress(this.value);

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidEmailAddress', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidEmailAddress': value};
}

/// Variant arm `EmailChallengeError.LimitReached`.
final class NnsInternetIdentityEmailChallengeErrorLimitReached
    extends NnsInternetIdentityEmailChallengeError {
  final int limit;

  const NnsInternetIdentityEmailChallengeErrorLimitReached({
    required this.limit,
  });

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => Variant('LimitReached', {'limit': limit});

  @override
  Map<String, dynamic> toJson() => {
    'LimitReached': {'limit': limit},
  };

  factory NnsInternetIdentityEmailChallengeErrorLimitReached.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityEmailChallengeErrorLimitReached(
      limit: json.valueAsInt<int>('limit'),
    );
  }
}

/// Variant arm `EmailChallengeError.InternalCanisterError`.
final class NnsInternetIdentityEmailChallengeErrorInternalCanisterError
    extends NnsInternetIdentityEmailChallengeError {
  final String value;
  const NnsInternetIdentityEmailChallengeErrorInternalCanisterError(this.value);

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Candid variant `EmailChallengeStatus`.
sealed class NnsInternetIdentityEmailChallengeStatus with CandidSerializable {
  const NnsInternetIdentityEmailChallengeStatus();

  static CType get ctype => CType.variant([
    Field(Label.named('Pending'), CType.null_),
    Field(Label.named('ResolvingDoh'), CType.null_),
    Field(
      Label.named('NeedDkimLeaf'),
      CType.record([Field(Label.named('selector'), CType.text)]),
    ),
    Field(Label.named('RegistrationSucceeded'), CType.null_),
    Field(
      Label.named('RecoveryReady'),
      CType.record([
        Field(Label.named('user_key'), CType.vec(CType.nat8)),
        Field(Label.named('expiration'), CType.nat64),
        Field(Label.named('anchor_number'), CType.nat64),
      ]),
    ),
    LazyField(
      Label.named('Failed'),
      () => NnsInternetIdentityEmailChallengeError.ctype,
    ),
    Field(Label.named('Expired'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityEmailChallengeStatus.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Pending')) {
      return const NnsInternetIdentityEmailChallengeStatusPending();
    }
    if (json.containsKey('ResolvingDoh')) {
      return const NnsInternetIdentityEmailChallengeStatusResolvingDoh();
    }
    if (json.containsKey('NeedDkimLeaf')) {
      return NnsInternetIdentityEmailChallengeStatusNeedDkimLeaf.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['NeedDkimLeaf']),
      );
    }
    if (json.containsKey('RegistrationSucceeded')) {
      return const NnsInternetIdentityEmailChallengeStatusRegistrationSucceeded();
    }
    if (json.containsKey('RecoveryReady')) {
      return NnsInternetIdentityEmailChallengeStatusRecoveryReady.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['RecoveryReady']),
      );
    }
    if (json.containsKey('Failed')) {
      return NnsInternetIdentityEmailChallengeStatusFailed(
        json.valueTo<NnsInternetIdentityEmailChallengeError, Map>(
          key: 'Failed',
          parse:
              (e) => NnsInternetIdentityEmailChallengeError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Expired')) {
      return const NnsInternetIdentityEmailChallengeStatusExpired();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityEmailChallengeStatus.fromCandid',
      reason: 'Unknown NnsInternetIdentityEmailChallengeStatus arm',
    );
  }

  factory NnsInternetIdentityEmailChallengeStatus.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailChallengeStatus.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `EmailChallengeStatus.Pending` (nullary).
final class NnsInternetIdentityEmailChallengeStatusPending
    extends NnsInternetIdentityEmailChallengeStatus {
  const NnsInternetIdentityEmailChallengeStatusPending();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeStatus.ctype;

  @override
  dynamic get candidValue => const Variant('Pending', null);

  @override
  Map<String, dynamic> toJson() => {'Pending': null};
}

/// Variant arm `EmailChallengeStatus.ResolvingDoh` (nullary).
final class NnsInternetIdentityEmailChallengeStatusResolvingDoh
    extends NnsInternetIdentityEmailChallengeStatus {
  const NnsInternetIdentityEmailChallengeStatusResolvingDoh();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeStatus.ctype;

  @override
  dynamic get candidValue => const Variant('ResolvingDoh', null);

  @override
  Map<String, dynamic> toJson() => {'ResolvingDoh': null};
}

/// Variant arm `EmailChallengeStatus.NeedDkimLeaf`.
final class NnsInternetIdentityEmailChallengeStatusNeedDkimLeaf
    extends NnsInternetIdentityEmailChallengeStatus {
  final String selector;

  const NnsInternetIdentityEmailChallengeStatusNeedDkimLeaf({
    required this.selector,
  });

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeStatus.ctype;

  @override
  dynamic get candidValue => Variant('NeedDkimLeaf', {'selector': selector});

  @override
  Map<String, dynamic> toJson() => {
    'NeedDkimLeaf': {'selector': selector},
  };

  factory NnsInternetIdentityEmailChallengeStatusNeedDkimLeaf.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityEmailChallengeStatusNeedDkimLeaf(
      selector: json.valueAsString<String>('selector'),
    );
  }
}

/// Variant arm `EmailChallengeStatus.RegistrationSucceeded` (nullary).
final class NnsInternetIdentityEmailChallengeStatusRegistrationSucceeded
    extends NnsInternetIdentityEmailChallengeStatus {
  const NnsInternetIdentityEmailChallengeStatusRegistrationSucceeded();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeStatus.ctype;

  @override
  dynamic get candidValue => const Variant('RegistrationSucceeded', null);

  @override
  Map<String, dynamic> toJson() => {'RegistrationSucceeded': null};
}

/// Variant arm `EmailChallengeStatus.RecoveryReady`.
final class NnsInternetIdentityEmailChallengeStatusRecoveryReady
    extends NnsInternetIdentityEmailChallengeStatus {
  final NnsInternetIdentityUserKey userKey;
  final NnsInternetIdentityTimestamp expiration;
  final NnsInternetIdentityIdentityNumber anchorNumber;

  const NnsInternetIdentityEmailChallengeStatusRecoveryReady({
    required this.userKey,
    required this.expiration,
    required this.anchorNumber,
  });

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeStatus.ctype;

  @override
  dynamic get candidValue => Variant('RecoveryReady', {
    'user_key': userKey,
    'expiration': expiration,
    'anchor_number': anchorNumber,
  });

  @override
  Map<String, dynamic> toJson() => {
    'RecoveryReady': {
      'user_key': userKey,
      'expiration': expiration,
      'anchor_number': anchorNumber,
    },
  };

  factory NnsInternetIdentityEmailChallengeStatusRecoveryReady.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityEmailChallengeStatusRecoveryReady(
      userKey: json.valueAsBytes<List<int>>(
        'user_key',
        encoding: StringEncoding.base64,
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
      anchorNumber: json.valueAsBigInt<BigInt>('anchor_number'),
    );
  }
}

/// Variant arm `EmailChallengeStatus.Failed`.
final class NnsInternetIdentityEmailChallengeStatusFailed
    extends NnsInternetIdentityEmailChallengeStatus {
  final NnsInternetIdentityEmailChallengeError value;
  const NnsInternetIdentityEmailChallengeStatusFailed(this.value);

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeStatus.ctype;

  @override
  dynamic get candidValue => Variant('Failed', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Failed': value.toJson()};
}

/// Variant arm `EmailChallengeStatus.Expired` (nullary).
final class NnsInternetIdentityEmailChallengeStatusExpired
    extends NnsInternetIdentityEmailChallengeStatus {
  const NnsInternetIdentityEmailChallengeStatusExpired();

  @override
  CType get candidType => NnsInternetIdentityEmailChallengeStatus.ctype;

  @override
  dynamic get candidValue => const Variant('Expired', null);

  @override
  Map<String, dynamic> toJson() => {'Expired': null};
}

/// Candid variant `VerificationPath`.
sealed class NnsInternetIdentityVerificationPath with CandidSerializable {
  const NnsInternetIdentityVerificationPath();

  static CType get ctype => CType.variant([
    Field(Label.named('Doh'), CType.null_),
    Field(Label.named('Dnssec'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityVerificationPath.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Doh')) {
      return const NnsInternetIdentityVerificationPathDoh();
    }
    if (json.containsKey('Dnssec')) {
      return const NnsInternetIdentityVerificationPathDnssec();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityVerificationPath.fromCandid',
      reason: 'Unknown NnsInternetIdentityVerificationPath arm',
    );
  }

  factory NnsInternetIdentityVerificationPath.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityVerificationPath.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `VerificationPath.Doh` (nullary).
final class NnsInternetIdentityVerificationPathDoh
    extends NnsInternetIdentityVerificationPath {
  const NnsInternetIdentityVerificationPathDoh();

  @override
  CType get candidType => NnsInternetIdentityVerificationPath.ctype;

  @override
  dynamic get candidValue => const Variant('Doh', null);

  @override
  Map<String, dynamic> toJson() => {'Doh': null};
}

/// Variant arm `VerificationPath.Dnssec` (nullary).
final class NnsInternetIdentityVerificationPathDnssec
    extends NnsInternetIdentityVerificationPath {
  const NnsInternetIdentityVerificationPathDnssec();

  @override
  CType get candidType => NnsInternetIdentityVerificationPath.ctype;

  @override
  dynamic get candidValue => const Variant('Dnssec', null);

  @override
  Map<String, dynamic> toJson() => {'Dnssec': null};
}

/// Candid record `EmailChallengeDiagnostics`.
final class NnsInternetIdentityEmailChallengeDiagnostics
    with CandidSerializable {
  final String? messageId;
  final String reasonCode;
  final NnsInternetIdentityVerificationPath verificationPath;
  final NnsInternetIdentityTimestamp createdAt;

  const NnsInternetIdentityEmailChallengeDiagnostics({
    this.messageId,
    required this.reasonCode,
    required this.verificationPath,
    required this.createdAt,
  });

  static CType get ctype => CType.record([
    Field(Label.named('message_id'), CType.opt(CType.text)),
    Field(Label.named('reason_code'), CType.text),
    LazyField(
      Label.named('verification_path'),
      () => NnsInternetIdentityVerificationPath.ctype,
    ),
    Field(Label.named('created_at'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'message_id': messageId,
    'reason_code': reasonCode,
    'verification_path': verificationPath.candidValue,
    'created_at': createdAt,
  };

  Map<String, dynamic> toJson() => {
    'message_id': messageId,
    'reason_code': reasonCode,
    'verification_path': verificationPath.toJson(),
    'created_at': createdAt,
  };

  factory NnsInternetIdentityEmailChallengeDiagnostics.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityEmailChallengeDiagnostics(
      messageId: json.valueAsString<String?>('message_id'),
      reasonCode: json.valueAsString<String>('reason_code'),
      verificationPath: json.valueTo<NnsInternetIdentityVerificationPath, Map>(
        key: 'verification_path',
        parse:
            (e) => NnsInternetIdentityVerificationPath.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      createdAt: json.valueAsBigInt<BigInt>('created_at'),
    );
  }

  factory NnsInternetIdentityEmailChallengeDiagnostics.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailChallengeDiagnostics.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `EmailRecoveryGetDelegationArgs`.
final class NnsInternetIdentityEmailRecoveryGetDelegationArgs
    with CandidSerializable {
  final String nonce;
  final NnsInternetIdentitySessionKey sessionKey;
  final NnsInternetIdentityTimestamp expiration;

  const NnsInternetIdentityEmailRecoveryGetDelegationArgs({
    required this.nonce,
    required this.sessionKey,
    required this.expiration,
  });

  static CType get ctype => CType.record([
    Field(Label.named('nonce'), CType.text),
    Field(Label.named('session_key'), CType.vec(CType.nat8)),
    Field(Label.named('expiration'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'nonce': nonce,
    'session_key': sessionKey,
    'expiration': expiration,
  };

  Map<String, dynamic> toJson() => {
    'nonce': nonce,
    'session_key': sessionKey,
    'expiration': expiration,
  };

  factory NnsInternetIdentityEmailRecoveryGetDelegationArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityEmailRecoveryGetDelegationArgs(
      nonce: json.valueAsString<String>('nonce'),
      sessionKey: json.valueAsBytes<List<int>>(
        'session_key',
        encoding: StringEncoding.base64,
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
    );
  }

  factory NnsInternetIdentityEmailRecoveryGetDelegationArgs.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityEmailRecoveryGetDelegationArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SmtpHeader`.
final class NnsInternetIdentitySmtpHeader with CandidSerializable {
  final String name;
  final String value;

  const NnsInternetIdentitySmtpHeader({
    required this.name,
    required this.value,
  });

  static CType get ctype => CType.record([
    Field(Label.named('name'), CType.text),
    Field(Label.named('value'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'name': name, 'value': value};

  Map<String, dynamic> toJson() => {'name': name, 'value': value};

  factory NnsInternetIdentitySmtpHeader.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentitySmtpHeader(
      name: json.valueAsString<String>('name'),
      value: json.valueAsString<String>('value'),
    );
  }

  factory NnsInternetIdentitySmtpHeader.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySmtpHeader.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SmtpMessage`.
final class NnsInternetIdentitySmtpMessage with CandidSerializable {
  final List<NnsInternetIdentitySmtpHeader> headers;
  final List<int> body;

  const NnsInternetIdentitySmtpMessage({
    required this.headers,
    required this.body,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('headers'),
      () => CType.vec(NnsInternetIdentitySmtpHeader.ctype),
    ),
    Field(Label.named('body'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'headers': headers.map((el) => el.candidValue).toList(),
    'body': body,
  };

  Map<String, dynamic> toJson() => {
    'headers': headers.map((el) => el.toJson()).toList(),
    'body': body,
  };

  factory NnsInternetIdentitySmtpMessage.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentitySmtpMessage(
      headers: json.valueTo<List<NnsInternetIdentitySmtpHeader>, List>(
        key: 'headers',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentitySmtpHeader>(
                      (x) => NnsInternetIdentitySmtpHeader.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      body: json.valueAsBytes<List<int>>(
        'body',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentitySmtpMessage.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySmtpMessage.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SmtpAddress`.
final class NnsInternetIdentitySmtpAddress with CandidSerializable {
  final String user;
  final String domain;

  const NnsInternetIdentitySmtpAddress({
    required this.user,
    required this.domain,
  });

  static CType get ctype => CType.record([
    Field(Label.named('user'), CType.text),
    Field(Label.named('domain'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'user': user, 'domain': domain};

  Map<String, dynamic> toJson() => {'user': user, 'domain': domain};

  factory NnsInternetIdentitySmtpAddress.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentitySmtpAddress(
      user: json.valueAsString<String>('user'),
      domain: json.valueAsString<String>('domain'),
    );
  }

  factory NnsInternetIdentitySmtpAddress.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySmtpAddress.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SmtpEnvelope`.
final class NnsInternetIdentitySmtpEnvelope with CandidSerializable {
  final NnsInternetIdentitySmtpAddress from;
  final List<NnsInternetIdentitySmtpAddress> to;

  const NnsInternetIdentitySmtpEnvelope({required this.from, required this.to});

  static CType get ctype => CType.record([
    LazyField(Label.named('from'), () => NnsInternetIdentitySmtpAddress.ctype),
    LazyField(
      Label.named('to'),
      () => CType.vec(NnsInternetIdentitySmtpAddress.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'from': from.candidValue,
    'to': to.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'from': from.toJson(),
    'to': to.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentitySmtpEnvelope.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySmtpEnvelope(
      from: json.valueTo<NnsInternetIdentitySmtpAddress, Map>(
        key: 'from',
        parse:
            (e) => NnsInternetIdentitySmtpAddress.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      to: json.valueTo<List<NnsInternetIdentitySmtpAddress>, List>(
        key: 'to',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentitySmtpAddress>(
                      (x) => NnsInternetIdentitySmtpAddress.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentitySmtpEnvelope.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySmtpEnvelope.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SmtpRequest`.
final class NnsInternetIdentitySmtpRequest with CandidSerializable {
  final NnsInternetIdentitySmtpMessage? message;
  final NnsInternetIdentitySmtpEnvelope? envelope;
  final List<String>? gatewayFlags;
  final String? messageId;

  const NnsInternetIdentitySmtpRequest({
    this.message,
    this.envelope,
    this.gatewayFlags,
    this.messageId,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('message'),
      () => CType.opt(NnsInternetIdentitySmtpMessage.ctype),
    ),
    LazyField(
      Label.named('envelope'),
      () => CType.opt(NnsInternetIdentitySmtpEnvelope.ctype),
    ),
    Field(Label.named('gateway_flags'), CType.opt(CType.vec(CType.text))),
    Field(Label.named('message_id'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'message': message?.candidValue,
    'envelope': envelope?.candidValue,
    'gateway_flags': gatewayFlags,
    'message_id': messageId,
  };

  Map<String, dynamic> toJson() => {
    'message': message?.toJson(),
    'envelope': envelope?.toJson(),
    'gateway_flags': gatewayFlags,
    'message_id': messageId,
  };

  factory NnsInternetIdentitySmtpRequest.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentitySmtpRequest(
      message: json.valueTo<NnsInternetIdentitySmtpMessage?, Map>(
        key: 'message',
        parse:
            (e) => NnsInternetIdentitySmtpMessage.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      envelope: json.valueTo<NnsInternetIdentitySmtpEnvelope?, Map>(
        key: 'envelope',
        parse:
            (e) => NnsInternetIdentitySmtpEnvelope.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      gatewayFlags: json.valueTo<List<String>?, List>(
        key: 'gateway_flags',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
      messageId: json.valueAsString<String?>('message_id'),
    );
  }

  factory NnsInternetIdentitySmtpRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySmtpRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SmtpRequestError`.
final class NnsInternetIdentitySmtpRequestError with CandidSerializable {
  final BigInt code;
  final String message;

  const NnsInternetIdentitySmtpRequestError({
    required this.code,
    required this.message,
  });

  static CType get ctype => CType.record([
    Field(Label.named('code'), CType.nat64),
    Field(Label.named('message'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'code': code, 'message': message};

  Map<String, dynamic> toJson() => {'code': code, 'message': message};

  factory NnsInternetIdentitySmtpRequestError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySmtpRequestError(
      code: json.valueAsBigInt<BigInt>('code'),
      message: json.valueAsString<String>('message'),
    );
  }

  factory NnsInternetIdentitySmtpRequestError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySmtpRequestError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `SmtpResponse`.
sealed class NnsInternetIdentitySmtpResponse with CandidSerializable {
  const NnsInternetIdentitySmtpResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.record(const [])),
    LazyField(
      Label.named('Err'),
      () => NnsInternetIdentitySmtpRequestError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentitySmtpResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsInternetIdentitySmtpResponseOk.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Ok']),
      );
    }
    if (json.containsKey('Err')) {
      return NnsInternetIdentitySmtpResponseErr(
        json.valueTo<NnsInternetIdentitySmtpRequestError, Map>(
          key: 'Err',
          parse:
              (e) => NnsInternetIdentitySmtpRequestError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentitySmtpResponse.fromCandid',
      reason: 'Unknown NnsInternetIdentitySmtpResponse arm',
    );
  }

  factory NnsInternetIdentitySmtpResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySmtpResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `SmtpResponse.Ok`.
final class NnsInternetIdentitySmtpResponseOk
    extends NnsInternetIdentitySmtpResponse {
  const NnsInternetIdentitySmtpResponseOk();

  @override
  CType get candidType => NnsInternetIdentitySmtpResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', {});

  @override
  Map<String, dynamic> toJson() => {'Ok': {}};

  factory NnsInternetIdentitySmtpResponseOk.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySmtpResponseOk();
  }
}

/// Variant arm `SmtpResponse.Err`.
final class NnsInternetIdentitySmtpResponseErr
    extends NnsInternetIdentitySmtpResponse {
  final NnsInternetIdentitySmtpRequestError value;
  const NnsInternetIdentitySmtpResponseErr(this.value);

  @override
  CType get candidType => NnsInternetIdentitySmtpResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `WebAuthn`.
final class NnsInternetIdentityWebAuthn with CandidSerializable {
  final NnsInternetIdentityCredentialId credentialId;
  final NnsInternetIdentityPublicKey pubkey;
  final NnsInternetIdentityAaguid? aaguid;

  const NnsInternetIdentityWebAuthn({
    required this.credentialId,
    required this.pubkey,
    this.aaguid,
  });

  static CType get ctype => CType.record([
    Field(Label.named('credential_id'), CType.vec(CType.nat8)),
    Field(Label.named('pubkey'), CType.vec(CType.nat8)),
    Field(Label.named('aaguid'), CType.opt(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'credential_id': credentialId,
    'pubkey': pubkey,
    'aaguid': aaguid,
  };

  Map<String, dynamic> toJson() => {
    'credential_id': credentialId,
    'pubkey': pubkey,
    'aaguid': aaguid,
  };

  factory NnsInternetIdentityWebAuthn.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityWebAuthn(
      credentialId: json.valueAsBytes<List<int>>(
        'credential_id',
        encoding: StringEncoding.base64,
      ),
      pubkey: json.valueAsBytes<List<int>>(
        'pubkey',
        encoding: StringEncoding.base64,
      ),
      aaguid: json.valueAsBytes<List<int>?>(
        'aaguid',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityWebAuthn.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityWebAuthn.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `PublicKeyAuthn`.
final class NnsInternetIdentityPublicKeyAuthn with CandidSerializable {
  final NnsInternetIdentityPublicKey pubkey;

  const NnsInternetIdentityPublicKeyAuthn({required this.pubkey});

  static CType get ctype =>
      CType.record([Field(Label.named('pubkey'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'pubkey': pubkey};

  Map<String, dynamic> toJson() => {'pubkey': pubkey};

  factory NnsInternetIdentityPublicKeyAuthn.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPublicKeyAuthn(
      pubkey: json.valueAsBytes<List<int>>(
        'pubkey',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityPublicKeyAuthn.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPublicKeyAuthn.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `AuthnMethod`.
sealed class NnsInternetIdentityAuthnMethod with CandidSerializable {
  const NnsInternetIdentityAuthnMethod();

  static CType get ctype => CType.variant([
    LazyField(Label.named('WebAuthn'), () => NnsInternetIdentityWebAuthn.ctype),
    LazyField(
      Label.named('PubKey'),
      () => NnsInternetIdentityPublicKeyAuthn.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethod.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('WebAuthn')) {
      return NnsInternetIdentityAuthnMethodWebAuthn(
        json.valueTo<NnsInternetIdentityWebAuthn, Map>(
          key: 'WebAuthn',
          parse:
              (e) => NnsInternetIdentityWebAuthn.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('PubKey')) {
      return NnsInternetIdentityAuthnMethodPubKey(
        json.valueTo<NnsInternetIdentityPublicKeyAuthn, Map>(
          key: 'PubKey',
          parse:
              (e) => NnsInternetIdentityPublicKeyAuthn.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethod.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethod arm',
    );
  }

  factory NnsInternetIdentityAuthnMethod.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethod.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethod.WebAuthn`.
final class NnsInternetIdentityAuthnMethodWebAuthn
    extends NnsInternetIdentityAuthnMethod {
  final NnsInternetIdentityWebAuthn value;
  const NnsInternetIdentityAuthnMethodWebAuthn(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethod.ctype;

  @override
  dynamic get candidValue => Variant('WebAuthn', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'WebAuthn': value.toJson()};
}

/// Variant arm `AuthnMethod.PubKey`.
final class NnsInternetIdentityAuthnMethodPubKey
    extends NnsInternetIdentityAuthnMethod {
  final NnsInternetIdentityPublicKeyAuthn value;
  const NnsInternetIdentityAuthnMethodPubKey(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethod.ctype;

  @override
  dynamic get candidValue => Variant('PubKey', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'PubKey': value.toJson()};
}

/// Candid variant `AuthnMethodProtection`.
sealed class NnsInternetIdentityAuthnMethodProtection with CandidSerializable {
  const NnsInternetIdentityAuthnMethodProtection();

  static CType get ctype => CType.variant([
    Field(Label.named('Protected'), CType.null_),
    Field(Label.named('Unprotected'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodProtection.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Protected')) {
      return const NnsInternetIdentityAuthnMethodProtectionProtected();
    }
    if (json.containsKey('Unprotected')) {
      return const NnsInternetIdentityAuthnMethodProtectionUnprotected();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodProtection.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodProtection arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodProtection.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodProtection.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethodProtection.Protected` (nullary).
final class NnsInternetIdentityAuthnMethodProtectionProtected
    extends NnsInternetIdentityAuthnMethodProtection {
  const NnsInternetIdentityAuthnMethodProtectionProtected();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodProtection.ctype;

  @override
  dynamic get candidValue => const Variant('Protected', null);

  @override
  Map<String, dynamic> toJson() => {'Protected': null};
}

/// Variant arm `AuthnMethodProtection.Unprotected` (nullary).
final class NnsInternetIdentityAuthnMethodProtectionUnprotected
    extends NnsInternetIdentityAuthnMethodProtection {
  const NnsInternetIdentityAuthnMethodProtectionUnprotected();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodProtection.ctype;

  @override
  dynamic get candidValue => const Variant('Unprotected', null);

  @override
  Map<String, dynamic> toJson() => {'Unprotected': null};
}

/// Candid variant `AuthnMethodPurpose`.
sealed class NnsInternetIdentityAuthnMethodPurpose with CandidSerializable {
  const NnsInternetIdentityAuthnMethodPurpose();

  static CType get ctype => CType.variant([
    Field(Label.named('Recovery'), CType.null_),
    Field(Label.named('Authentication'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodPurpose.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Recovery')) {
      return const NnsInternetIdentityAuthnMethodPurposeRecovery();
    }
    if (json.containsKey('Authentication')) {
      return const NnsInternetIdentityAuthnMethodPurposeAuthentication();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodPurpose.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodPurpose arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodPurpose.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodPurpose.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethodPurpose.Recovery` (nullary).
final class NnsInternetIdentityAuthnMethodPurposeRecovery
    extends NnsInternetIdentityAuthnMethodPurpose {
  const NnsInternetIdentityAuthnMethodPurposeRecovery();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodPurpose.ctype;

  @override
  dynamic get candidValue => const Variant('Recovery', null);

  @override
  Map<String, dynamic> toJson() => {'Recovery': null};
}

/// Variant arm `AuthnMethodPurpose.Authentication` (nullary).
final class NnsInternetIdentityAuthnMethodPurposeAuthentication
    extends NnsInternetIdentityAuthnMethodPurpose {
  const NnsInternetIdentityAuthnMethodPurposeAuthentication();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodPurpose.ctype;

  @override
  dynamic get candidValue => const Variant('Authentication', null);

  @override
  Map<String, dynamic> toJson() => {'Authentication': null};
}

/// Candid record `AuthnMethodSecuritySettings`.
final class NnsInternetIdentityAuthnMethodSecuritySettings
    with CandidSerializable {
  final NnsInternetIdentityAuthnMethodProtection protection;
  final NnsInternetIdentityAuthnMethodPurpose purpose;

  const NnsInternetIdentityAuthnMethodSecuritySettings({
    required this.protection,
    required this.purpose,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('protection'),
      () => NnsInternetIdentityAuthnMethodProtection.ctype,
    ),
    LazyField(
      Label.named('purpose'),
      () => NnsInternetIdentityAuthnMethodPurpose.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'protection': protection.candidValue,
    'purpose': purpose.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'protection': protection.toJson(),
    'purpose': purpose.toJson(),
  };

  factory NnsInternetIdentityAuthnMethodSecuritySettings.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAuthnMethodSecuritySettings(
      protection: json.valueTo<NnsInternetIdentityAuthnMethodProtection, Map>(
        key: 'protection',
        parse:
            (e) => NnsInternetIdentityAuthnMethodProtection.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      purpose: json.valueTo<NnsInternetIdentityAuthnMethodPurpose, Map>(
        key: 'purpose',
        parse:
            (e) => NnsInternetIdentityAuthnMethodPurpose.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentityAuthnMethodSecuritySettings.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodSecuritySettings.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AuthnMethodData`.
final class NnsInternetIdentityAuthnMethodData with CandidSerializable {
  final NnsInternetIdentityAuthnMethod authnMethod;
  final NnsInternetIdentityAuthnMethodSecuritySettings securitySettings;
  final NnsInternetIdentityMetadataMapV2 metadata;
  final NnsInternetIdentityTimestamp? lastAuthentication;

  const NnsInternetIdentityAuthnMethodData({
    required this.authnMethod,
    required this.securitySettings,
    required this.metadata,
    this.lastAuthentication,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('authn_method'),
      () => NnsInternetIdentityAuthnMethod.ctype,
    ),
    LazyField(
      Label.named('security_settings'),
      () => NnsInternetIdentityAuthnMethodSecuritySettings.ctype,
    ),
    LazyField(
      Label.named('metadata'),
      () => NnsInternetIdentityMetadataMapV2Candid.ctype,
    ),
    Field(Label.named('last_authentication'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'authn_method': authnMethod.candidValue,
    'security_settings': securitySettings.candidValue,
    'metadata': metadata.map((el) => el.candidValue).toList(),
    'last_authentication': lastAuthentication,
  };

  Map<String, dynamic> toJson() => {
    'authn_method': authnMethod.toJson(),
    'security_settings': securitySettings.toJson(),
    'metadata': metadata.map((el) => el.toJson()).toList(),
    'last_authentication': lastAuthentication,
  };

  factory NnsInternetIdentityAuthnMethodData.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAuthnMethodData(
      authnMethod: json.valueTo<NnsInternetIdentityAuthnMethod, Map>(
        key: 'authn_method',
        parse:
            (e) => NnsInternetIdentityAuthnMethod.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      securitySettings: json
          .valueTo<NnsInternetIdentityAuthnMethodSecuritySettings, Map>(
            key: 'security_settings',
            parse:
                (e) =>
                    NnsInternetIdentityAuthnMethodSecuritySettings.fromCandid(
                      JsonParser.valueEnsureAsMap<String, dynamic>(e),
                    ),
          ),
      metadata: json.valueTo<List<NnsInternetIdentityMetadataMapV2Item>, List>(
        key: 'metadata',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityMetadataMapV2Item>(
                      (x) => NnsInternetIdentityMetadataMapV2Item.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      lastAuthentication: json.valueAsBigInt<BigInt?>('last_authentication'),
    );
  }

  factory NnsInternetIdentityAuthnMethodData.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodData.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `OpenIDRegFinishArg`.
final class NnsInternetIdentityOpenIDRegFinishArg with CandidSerializable {
  final NnsInternetIdentityJWT jwt;
  final NnsInternetIdentitySalt salt;
  final String name;
  final String? discoveryDomain;
  final String? origin;

  const NnsInternetIdentityOpenIDRegFinishArg({
    required this.jwt,
    required this.salt,
    required this.name,
    this.discoveryDomain,
    this.origin,
  });

  static CType get ctype => CType.record([
    Field(Label.named('jwt'), CType.text),
    Field(Label.named('salt'), CType.vec(CType.nat8)),
    Field(Label.named('name'), CType.text),
    Field(Label.named('discovery_domain'), CType.opt(CType.text)),
    Field(Label.named('origin'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'jwt': jwt,
    'salt': salt,
    'name': name,
    'discovery_domain': discoveryDomain,
    'origin': origin,
  };

  Map<String, dynamic> toJson() => {
    'jwt': jwt,
    'salt': salt,
    'name': name,
    'discovery_domain': discoveryDomain,
    'origin': origin,
  };

  factory NnsInternetIdentityOpenIDRegFinishArg.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityOpenIDRegFinishArg(
      jwt: json.valueAsString<String>('jwt'),
      salt: json.valueAsBytes<List<int>>(
        'salt',
        encoding: StringEncoding.base64,
      ),
      name: json.valueAsString<String>('name'),
      discoveryDomain: json.valueAsString<String?>('discovery_domain'),
      origin: json.valueAsString<String?>('origin'),
    );
  }

  factory NnsInternetIdentityOpenIDRegFinishArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityOpenIDRegFinishArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AuthnMethodRegistrationInfo`.
final class NnsInternetIdentityAuthnMethodRegistrationInfo
    with CandidSerializable {
  final NnsInternetIdentityAuthnMethodData? authnMethod;
  final IcpPrincipalAddress? session;
  final NnsInternetIdentityTimestamp expiration;

  const NnsInternetIdentityAuthnMethodRegistrationInfo({
    this.authnMethod,
    this.session,
    required this.expiration,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('authn_method'),
      () => CType.opt(NnsInternetIdentityAuthnMethodData.ctype),
    ),
    Field(Label.named('session'), CType.opt(CType.principal)),
    Field(Label.named('expiration'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'authn_method': authnMethod?.candidValue,
    'session': session,
    'expiration': expiration,
  };

  Map<String, dynamic> toJson() => {
    'authn_method': authnMethod?.toJson(),
    'session': session?.address,
    'expiration': expiration,
  };

  factory NnsInternetIdentityAuthnMethodRegistrationInfo.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAuthnMethodRegistrationInfo(
      authnMethod: json.valueTo<NnsInternetIdentityAuthnMethodData?, Map>(
        key: 'authn_method',
        parse:
            (e) => NnsInternetIdentityAuthnMethodData.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      session: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'session',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
    );
  }

  factory NnsInternetIdentityAuthnMethodRegistrationInfo.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodRegistrationInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AuthnMethodConfirmationCode`.
final class NnsInternetIdentityAuthnMethodConfirmationCode
    with CandidSerializable {
  final String confirmationCode;
  final NnsInternetIdentityTimestamp expiration;

  const NnsInternetIdentityAuthnMethodConfirmationCode({
    required this.confirmationCode,
    required this.expiration,
  });

  static CType get ctype => CType.record([
    Field(Label.named('confirmation_code'), CType.text),
    Field(Label.named('expiration'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'confirmation_code': confirmationCode,
    'expiration': expiration,
  };

  Map<String, dynamic> toJson() => {
    'confirmation_code': confirmationCode,
    'expiration': expiration,
  };

  factory NnsInternetIdentityAuthnMethodConfirmationCode.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAuthnMethodConfirmationCode(
      confirmationCode: json.valueAsString<String>('confirmation_code'),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
    );
  }

  factory NnsInternetIdentityAuthnMethodConfirmationCode.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodConfirmationCode.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AuthnMethodSessionInfo`.
final class NnsInternetIdentityAuthnMethodSessionInfo with CandidSerializable {
  final String? name;
  final NnsInternetIdentityTimestamp? createdAt;

  const NnsInternetIdentityAuthnMethodSessionInfo({this.name, this.createdAt});

  static CType get ctype => CType.record([
    Field(Label.named('name'), CType.opt(CType.text)),
    Field(Label.named('created_at'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'name': name, 'created_at': createdAt};

  Map<String, dynamic> toJson() => {'name': name, 'created_at': createdAt};

  factory NnsInternetIdentityAuthnMethodSessionInfo.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAuthnMethodSessionInfo(
      name: json.valueAsString<String?>('name'),
      createdAt: json.valueAsBigInt<BigInt?>('created_at'),
    );
  }

  factory NnsInternetIdentityAuthnMethodSessionInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodSessionInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `AuthnMethodRegisterError`.
sealed class NnsInternetIdentityAuthnMethodRegisterError
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodRegisterError();

  static CType get ctype => CType.variant([
    Field(Label.named('RegistrationModeOff'), CType.null_),
    Field(Label.named('RegistrationAlreadyInProgress'), CType.null_),
    Field(Label.named('InvalidMetadata'), CType.text),
    Field(Label.named('NotSelfAuthenticating'), CType.principal),
    Field(Label.named('PasskeyWithThisPublicKeyIsAlreadyUsed'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodRegisterError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('RegistrationModeOff')) {
      return const NnsInternetIdentityAuthnMethodRegisterErrorRegistrationModeOff();
    }
    if (json.containsKey('RegistrationAlreadyInProgress')) {
      return const NnsInternetIdentityAuthnMethodRegisterErrorRegistrationAlreadyInProgress();
    }
    if (json.containsKey('InvalidMetadata')) {
      return NnsInternetIdentityAuthnMethodRegisterErrorInvalidMetadata(
        json.valueAsString<String>('InvalidMetadata'),
      );
    }
    if (json.containsKey('NotSelfAuthenticating')) {
      return NnsInternetIdentityAuthnMethodRegisterErrorNotSelfAuthenticating(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'NotSelfAuthenticating',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('PasskeyWithThisPublicKeyIsAlreadyUsed')) {
      return const NnsInternetIdentityAuthnMethodRegisterErrorPasskeyWithThisPublicKeyIsAlreadyUsed();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodRegisterError.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodRegisterError arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodRegisterError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodRegisterError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethodRegisterError.RegistrationModeOff` (nullary).
final class NnsInternetIdentityAuthnMethodRegisterErrorRegistrationModeOff
    extends NnsInternetIdentityAuthnMethodRegisterError {
  const NnsInternetIdentityAuthnMethodRegisterErrorRegistrationModeOff();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodRegisterError.ctype;

  @override
  dynamic get candidValue => const Variant('RegistrationModeOff', null);

  @override
  Map<String, dynamic> toJson() => {'RegistrationModeOff': null};
}

/// Variant arm `AuthnMethodRegisterError.RegistrationAlreadyInProgress` (nullary).
final class NnsInternetIdentityAuthnMethodRegisterErrorRegistrationAlreadyInProgress
    extends NnsInternetIdentityAuthnMethodRegisterError {
  const NnsInternetIdentityAuthnMethodRegisterErrorRegistrationAlreadyInProgress();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodRegisterError.ctype;

  @override
  dynamic get candidValue =>
      const Variant('RegistrationAlreadyInProgress', null);

  @override
  Map<String, dynamic> toJson() => {'RegistrationAlreadyInProgress': null};
}

/// Variant arm `AuthnMethodRegisterError.InvalidMetadata`.
final class NnsInternetIdentityAuthnMethodRegisterErrorInvalidMetadata
    extends NnsInternetIdentityAuthnMethodRegisterError {
  final String value;
  const NnsInternetIdentityAuthnMethodRegisterErrorInvalidMetadata(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodRegisterError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidMetadata', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidMetadata': value};
}

/// Variant arm `AuthnMethodRegisterError.NotSelfAuthenticating`.
final class NnsInternetIdentityAuthnMethodRegisterErrorNotSelfAuthenticating
    extends NnsInternetIdentityAuthnMethodRegisterError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityAuthnMethodRegisterErrorNotSelfAuthenticating(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodRegisterError.ctype;

  @override
  dynamic get candidValue => Variant('NotSelfAuthenticating', value);

  @override
  Map<String, dynamic> toJson() => {'NotSelfAuthenticating': value.address};
}

/// Variant arm `AuthnMethodRegisterError.PasskeyWithThisPublicKeyIsAlreadyUsed` (nullary).
final class NnsInternetIdentityAuthnMethodRegisterErrorPasskeyWithThisPublicKeyIsAlreadyUsed
    extends NnsInternetIdentityAuthnMethodRegisterError {
  const NnsInternetIdentityAuthnMethodRegisterErrorPasskeyWithThisPublicKeyIsAlreadyUsed();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodRegisterError.ctype;

  @override
  dynamic get candidValue =>
      const Variant('PasskeyWithThisPublicKeyIsAlreadyUsed', null);

  @override
  Map<String, dynamic> toJson() => {
    'PasskeyWithThisPublicKeyIsAlreadyUsed': null,
  };
}

/// Candid variant `AuthnMethodConfirmationError`.
sealed class NnsInternetIdentityAuthnMethodConfirmationError
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodConfirmationError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('InternalCanisterError'), CType.text),
    Field(
      Label.named('WrongCode'),
      CType.record([Field(Label.named('retries_left'), CType.nat8)]),
    ),
    Field(Label.named('RegistrationModeOff'), CType.null_),
    Field(Label.named('NoAuthnMethodToConfirm'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodConfirmationError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityAuthnMethodConfirmationErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityAuthnMethodConfirmationErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    if (json.containsKey('WrongCode')) {
      return NnsInternetIdentityAuthnMethodConfirmationErrorWrongCode.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['WrongCode']),
      );
    }
    if (json.containsKey('RegistrationModeOff')) {
      return const NnsInternetIdentityAuthnMethodConfirmationErrorRegistrationModeOff();
    }
    if (json.containsKey('NoAuthnMethodToConfirm')) {
      return const NnsInternetIdentityAuthnMethodConfirmationErrorNoAuthnMethodToConfirm();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodConfirmationError.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodConfirmationError arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodConfirmationError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodConfirmationError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethodConfirmationError.Unauthorized`.
final class NnsInternetIdentityAuthnMethodConfirmationErrorUnauthorized
    extends NnsInternetIdentityAuthnMethodConfirmationError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityAuthnMethodConfirmationErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodConfirmationError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `AuthnMethodConfirmationError.InternalCanisterError`.
final class NnsInternetIdentityAuthnMethodConfirmationErrorInternalCanisterError
    extends NnsInternetIdentityAuthnMethodConfirmationError {
  final String value;
  const NnsInternetIdentityAuthnMethodConfirmationErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodConfirmationError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Variant arm `AuthnMethodConfirmationError.WrongCode`.
final class NnsInternetIdentityAuthnMethodConfirmationErrorWrongCode
    extends NnsInternetIdentityAuthnMethodConfirmationError {
  final int retriesLeft;

  const NnsInternetIdentityAuthnMethodConfirmationErrorWrongCode({
    required this.retriesLeft,
  });

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodConfirmationError.ctype;

  @override
  dynamic get candidValue =>
      Variant('WrongCode', {'retries_left': retriesLeft});

  @override
  Map<String, dynamic> toJson() => {
    'WrongCode': {'retries_left': retriesLeft},
  };

  factory NnsInternetIdentityAuthnMethodConfirmationErrorWrongCode.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAuthnMethodConfirmationErrorWrongCode(
      retriesLeft: json.valueAsInt<int>('retries_left'),
    );
  }
}

/// Variant arm `AuthnMethodConfirmationError.RegistrationModeOff` (nullary).
final class NnsInternetIdentityAuthnMethodConfirmationErrorRegistrationModeOff
    extends NnsInternetIdentityAuthnMethodConfirmationError {
  const NnsInternetIdentityAuthnMethodConfirmationErrorRegistrationModeOff();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodConfirmationError.ctype;

  @override
  dynamic get candidValue => const Variant('RegistrationModeOff', null);

  @override
  Map<String, dynamic> toJson() => {'RegistrationModeOff': null};
}

/// Variant arm `AuthnMethodConfirmationError.NoAuthnMethodToConfirm` (nullary).
final class NnsInternetIdentityAuthnMethodConfirmationErrorNoAuthnMethodToConfirm
    extends NnsInternetIdentityAuthnMethodConfirmationError {
  const NnsInternetIdentityAuthnMethodConfirmationErrorNoAuthnMethodToConfirm();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodConfirmationError.ctype;

  @override
  dynamic get candidValue => const Variant('NoAuthnMethodToConfirm', null);

  @override
  Map<String, dynamic> toJson() => {'NoAuthnMethodToConfirm': null};
}

/// Candid variant `AuthnMethodRegistrationModeEnterError`.
sealed class NnsInternetIdentityAuthnMethodRegistrationModeEnterError
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodRegistrationModeEnterError();

  static CType get ctype => CType.variant([
    Field(Label.named('InvalidRegistrationId'), CType.text),
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('AlreadyInProgress'), CType.null_),
    Field(Label.named('InternalCanisterError'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodRegistrationModeEnterError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InvalidRegistrationId')) {
      return NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorInvalidRegistrationId(
        json.valueAsString<String>('InvalidRegistrationId'),
      );
    }
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('AlreadyInProgress')) {
      return const NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorAlreadyInProgress();
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodRegistrationModeEnterError.fromCandid',
      reason:
          'Unknown NnsInternetIdentityAuthnMethodRegistrationModeEnterError arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodRegistrationModeEnterError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodRegistrationModeEnterError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethodRegistrationModeEnterError.InvalidRegistrationId`.
final class NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorInvalidRegistrationId
    extends NnsInternetIdentityAuthnMethodRegistrationModeEnterError {
  final String value;
  const NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorInvalidRegistrationId(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeEnterError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidRegistrationId', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidRegistrationId': value};
}

/// Variant arm `AuthnMethodRegistrationModeEnterError.Unauthorized`.
final class NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorUnauthorized
    extends NnsInternetIdentityAuthnMethodRegistrationModeEnterError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorUnauthorized(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeEnterError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `AuthnMethodRegistrationModeEnterError.AlreadyInProgress` (nullary).
final class NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorAlreadyInProgress
    extends NnsInternetIdentityAuthnMethodRegistrationModeEnterError {
  const NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorAlreadyInProgress();

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeEnterError.ctype;

  @override
  dynamic get candidValue => const Variant('AlreadyInProgress', null);

  @override
  Map<String, dynamic> toJson() => {'AlreadyInProgress': null};
}

/// Variant arm `AuthnMethodRegistrationModeEnterError.InternalCanisterError`.
final class NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorInternalCanisterError
    extends NnsInternetIdentityAuthnMethodRegistrationModeEnterError {
  final String value;
  const NnsInternetIdentityAuthnMethodRegistrationModeEnterErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeEnterError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Candid variant `AuthnMethodRegistrationModeExitError`.
sealed class NnsInternetIdentityAuthnMethodRegistrationModeExitError
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodRegistrationModeExitError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('InternalCanisterError'), CType.text),
    Field(Label.named('RegistrationModeOff'), CType.null_),
    Field(Label.named('InvalidMetadata'), CType.text),
    Field(Label.named('PasskeyWithThisPublicKeyIsAlreadyUsed'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodRegistrationModeExitError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityAuthnMethodRegistrationModeExitErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityAuthnMethodRegistrationModeExitErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    if (json.containsKey('RegistrationModeOff')) {
      return const NnsInternetIdentityAuthnMethodRegistrationModeExitErrorRegistrationModeOff();
    }
    if (json.containsKey('InvalidMetadata')) {
      return NnsInternetIdentityAuthnMethodRegistrationModeExitErrorInvalidMetadata(
        json.valueAsString<String>('InvalidMetadata'),
      );
    }
    if (json.containsKey('PasskeyWithThisPublicKeyIsAlreadyUsed')) {
      return const NnsInternetIdentityAuthnMethodRegistrationModeExitErrorPasskeyWithThisPublicKeyIsAlreadyUsed();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodRegistrationModeExitError.fromCandid',
      reason:
          'Unknown NnsInternetIdentityAuthnMethodRegistrationModeExitError arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodRegistrationModeExitError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodRegistrationModeExitError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethodRegistrationModeExitError.Unauthorized`.
final class NnsInternetIdentityAuthnMethodRegistrationModeExitErrorUnauthorized
    extends NnsInternetIdentityAuthnMethodRegistrationModeExitError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityAuthnMethodRegistrationModeExitErrorUnauthorized(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeExitError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `AuthnMethodRegistrationModeExitError.InternalCanisterError`.
final class NnsInternetIdentityAuthnMethodRegistrationModeExitErrorInternalCanisterError
    extends NnsInternetIdentityAuthnMethodRegistrationModeExitError {
  final String value;
  const NnsInternetIdentityAuthnMethodRegistrationModeExitErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeExitError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Variant arm `AuthnMethodRegistrationModeExitError.RegistrationModeOff` (nullary).
final class NnsInternetIdentityAuthnMethodRegistrationModeExitErrorRegistrationModeOff
    extends NnsInternetIdentityAuthnMethodRegistrationModeExitError {
  const NnsInternetIdentityAuthnMethodRegistrationModeExitErrorRegistrationModeOff();

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeExitError.ctype;

  @override
  dynamic get candidValue => const Variant('RegistrationModeOff', null);

  @override
  Map<String, dynamic> toJson() => {'RegistrationModeOff': null};
}

/// Variant arm `AuthnMethodRegistrationModeExitError.InvalidMetadata`.
final class NnsInternetIdentityAuthnMethodRegistrationModeExitErrorInvalidMetadata
    extends NnsInternetIdentityAuthnMethodRegistrationModeExitError {
  final String value;
  const NnsInternetIdentityAuthnMethodRegistrationModeExitErrorInvalidMetadata(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeExitError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidMetadata', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidMetadata': value};
}

/// Variant arm `AuthnMethodRegistrationModeExitError.PasskeyWithThisPublicKeyIsAlreadyUsed` (nullary).
final class NnsInternetIdentityAuthnMethodRegistrationModeExitErrorPasskeyWithThisPublicKeyIsAlreadyUsed
    extends NnsInternetIdentityAuthnMethodRegistrationModeExitError {
  const NnsInternetIdentityAuthnMethodRegistrationModeExitErrorPasskeyWithThisPublicKeyIsAlreadyUsed();

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodRegistrationModeExitError.ctype;

  @override
  dynamic get candidValue =>
      const Variant('PasskeyWithThisPublicKeyIsAlreadyUsed', null);

  @override
  Map<String, dynamic> toJson() => {
    'PasskeyWithThisPublicKeyIsAlreadyUsed': null,
  };
}

/// Candid variant `LookupByRegistrationIdError`.
sealed class NnsInternetIdentityLookupByRegistrationIdError
    with CandidSerializable {
  const NnsInternetIdentityLookupByRegistrationIdError();

  static CType get ctype =>
      CType.variant([Field(Label.named('InvalidRegistrationId'), CType.text)]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityLookupByRegistrationIdError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InvalidRegistrationId')) {
      return NnsInternetIdentityLookupByRegistrationIdErrorInvalidRegistrationId(
        json.valueAsString<String>('InvalidRegistrationId'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityLookupByRegistrationIdError.fromCandid',
      reason: 'Unknown NnsInternetIdentityLookupByRegistrationIdError arm',
    );
  }

  factory NnsInternetIdentityLookupByRegistrationIdError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityLookupByRegistrationIdError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `LookupByRegistrationIdError.InvalidRegistrationId`.
final class NnsInternetIdentityLookupByRegistrationIdErrorInvalidRegistrationId
    extends NnsInternetIdentityLookupByRegistrationIdError {
  final String value;
  const NnsInternetIdentityLookupByRegistrationIdErrorInvalidRegistrationId(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityLookupByRegistrationIdError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidRegistrationId', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidRegistrationId': value};
}

/// Candid record `IdentityAuthnInfo`.
final class NnsInternetIdentityIdentityAuthnInfo with CandidSerializable {
  final List<NnsInternetIdentityAuthnMethod> authnMethods;
  final List<NnsInternetIdentityAuthnMethod> recoveryAuthnMethods;

  const NnsInternetIdentityIdentityAuthnInfo({
    required this.authnMethods,
    required this.recoveryAuthnMethods,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('authn_methods'),
      () => CType.vec(NnsInternetIdentityAuthnMethod.ctype),
    ),
    LazyField(
      Label.named('recovery_authn_methods'),
      () => CType.vec(NnsInternetIdentityAuthnMethod.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'authn_methods': authnMethods.map((el) => el.candidValue).toList(),
    'recovery_authn_methods':
        recoveryAuthnMethods.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'authn_methods': authnMethods.map((el) => el.toJson()).toList(),
    'recovery_authn_methods':
        recoveryAuthnMethods.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityIdentityAuthnInfo.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdentityAuthnInfo(
      authnMethods: json.valueTo<List<NnsInternetIdentityAuthnMethod>, List>(
        key: 'authn_methods',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityAuthnMethod>(
                      (x) => NnsInternetIdentityAuthnMethod.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      recoveryAuthnMethods: json
          .valueTo<List<NnsInternetIdentityAuthnMethod>, List>(
            key: 'recovery_authn_methods',
            parse:
                (e) =>
                    e
                        .map<NnsInternetIdentityAuthnMethod>(
                          (x) => NnsInternetIdentityAuthnMethod.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsInternetIdentityIdentityAuthnInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityAuthnInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `IdentityInfo`.
final class NnsInternetIdentityIdentityInfo with CandidSerializable {
  final List<NnsInternetIdentityAuthnMethodData> authnMethods;
  final NnsInternetIdentityAuthnMethodRegistrationInfo? authnMethodRegistration;
  final List<NnsInternetIdentityOpenIdCredential>? openidCredentials;
  final NnsInternetIdentityMetadataMapV2 metadata;
  final String? name;
  final NnsInternetIdentityTimestamp? createdAt;
  final List<NnsInternetIdentityEmailRecoveryCredential>? emailRecovery;
  final List<NnsInternetIdentityVerifiedEmail>? verifiedEmails;

  const NnsInternetIdentityIdentityInfo({
    required this.authnMethods,
    this.authnMethodRegistration,
    this.openidCredentials,
    required this.metadata,
    this.name,
    this.createdAt,
    this.emailRecovery,
    this.verifiedEmails,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('authn_methods'),
      () => CType.vec(NnsInternetIdentityAuthnMethodData.ctype),
    ),
    LazyField(
      Label.named('authn_method_registration'),
      () => CType.opt(NnsInternetIdentityAuthnMethodRegistrationInfo.ctype),
    ),
    LazyField(
      Label.named('openid_credentials'),
      () => CType.opt(CType.vec(NnsInternetIdentityOpenIdCredential.ctype)),
    ),
    LazyField(
      Label.named('metadata'),
      () => NnsInternetIdentityMetadataMapV2Candid.ctype,
    ),
    Field(Label.named('name'), CType.opt(CType.text)),
    Field(Label.named('created_at'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('email_recovery'),
      () => CType.opt(
        CType.vec(NnsInternetIdentityEmailRecoveryCredential.ctype),
      ),
    ),
    LazyField(
      Label.named('verified_emails'),
      () => CType.opt(CType.vec(NnsInternetIdentityVerifiedEmail.ctype)),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'authn_methods': authnMethods.map((el) => el.candidValue).toList(),
    'authn_method_registration': authnMethodRegistration?.candidValue,
    'openid_credentials':
        openidCredentials?.map((el) => el.candidValue).toList(),
    'metadata': metadata.map((el) => el.candidValue).toList(),
    'name': name,
    'created_at': createdAt,
    'email_recovery': emailRecovery?.map((el) => el.candidValue).toList(),
    'verified_emails': verifiedEmails?.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'authn_methods': authnMethods.map((el) => el.toJson()).toList(),
    'authn_method_registration': authnMethodRegistration?.toJson(),
    'openid_credentials': openidCredentials?.map((el) => el.toJson()).toList(),
    'metadata': metadata.map((el) => el.toJson()).toList(),
    'name': name,
    'created_at': createdAt,
    'email_recovery': emailRecovery?.map((el) => el.toJson()).toList(),
    'verified_emails': verifiedEmails?.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityIdentityInfo.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdentityInfo(
      authnMethods: json
          .valueTo<List<NnsInternetIdentityAuthnMethodData>, List>(
            key: 'authn_methods',
            parse:
                (e) =>
                    e
                        .map<NnsInternetIdentityAuthnMethodData>(
                          (x) => NnsInternetIdentityAuthnMethodData.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
      authnMethodRegistration: json
          .valueTo<NnsInternetIdentityAuthnMethodRegistrationInfo?, Map>(
            key: 'authn_method_registration',
            parse:
                (e) =>
                    NnsInternetIdentityAuthnMethodRegistrationInfo.fromCandid(
                      JsonParser.valueEnsureAsMap<String, dynamic>(e),
                    ),
          ),
      openidCredentials: json
          .valueTo<List<NnsInternetIdentityOpenIdCredential>?, List>(
            key: 'openid_credentials',
            parse:
                (e) =>
                    e
                        .map<NnsInternetIdentityOpenIdCredential>(
                          (x) => NnsInternetIdentityOpenIdCredential.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
      metadata: json.valueTo<List<NnsInternetIdentityMetadataMapV2Item>, List>(
        key: 'metadata',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityMetadataMapV2Item>(
                      (x) => NnsInternetIdentityMetadataMapV2Item.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      name: json.valueAsString<String?>('name'),
      createdAt: json.valueAsBigInt<BigInt?>('created_at'),
      emailRecovery: json.valueTo<
        List<NnsInternetIdentityEmailRecoveryCredential>?,
        List
      >(
        key: 'email_recovery',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityEmailRecoveryCredential>(
                      (x) =>
                          NnsInternetIdentityEmailRecoveryCredential.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      verifiedEmails: json
          .valueTo<List<NnsInternetIdentityVerifiedEmail>?, List>(
            key: 'verified_emails',
            parse:
                (e) =>
                    e
                        .map<NnsInternetIdentityVerifiedEmail>(
                          (x) => NnsInternetIdentityVerifiedEmail.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsInternetIdentityIdentityInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `IdentityInfoError`.
sealed class NnsInternetIdentityIdentityInfoError with CandidSerializable {
  const NnsInternetIdentityIdentityInfoError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('InternalCanisterError'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdentityInfoError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityIdentityInfoErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityIdentityInfoErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdentityInfoError.fromCandid',
      reason: 'Unknown NnsInternetIdentityIdentityInfoError arm',
    );
  }

  factory NnsInternetIdentityIdentityInfoError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityInfoError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `IdentityInfoError.Unauthorized`.
final class NnsInternetIdentityIdentityInfoErrorUnauthorized
    extends NnsInternetIdentityIdentityInfoError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityIdentityInfoErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityIdentityInfoError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `IdentityInfoError.InternalCanisterError`.
final class NnsInternetIdentityIdentityInfoErrorInternalCanisterError
    extends NnsInternetIdentityIdentityInfoError {
  final String value;
  const NnsInternetIdentityIdentityInfoErrorInternalCanisterError(this.value);

  @override
  CType get candidType => NnsInternetIdentityIdentityInfoError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Candid variant `AuthnMethodAddError`.
sealed class NnsInternetIdentityAuthnMethodAddError with CandidSerializable {
  const NnsInternetIdentityAuthnMethodAddError();

  static CType get ctype =>
      CType.variant([Field(Label.named('InvalidMetadata'), CType.text)]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodAddError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InvalidMetadata')) {
      return NnsInternetIdentityAuthnMethodAddErrorInvalidMetadata(
        json.valueAsString<String>('InvalidMetadata'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodAddError.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodAddError arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodAddError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodAddError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethodAddError.InvalidMetadata`.
final class NnsInternetIdentityAuthnMethodAddErrorInvalidMetadata
    extends NnsInternetIdentityAuthnMethodAddError {
  final String value;
  const NnsInternetIdentityAuthnMethodAddErrorInvalidMetadata(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodAddError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidMetadata', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidMetadata': value};
}

/// Candid variant `AuthnMethodReplaceError`.
sealed class NnsInternetIdentityAuthnMethodReplaceError
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodReplaceError();

  static CType get ctype => CType.variant([
    Field(Label.named('InvalidMetadata'), CType.text),
    Field(Label.named('AuthnMethodNotFound'), CType.null_),
    Field(Label.named('PasskeyWithThisPublicKeyIsAlreadyUsed'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodReplaceError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InvalidMetadata')) {
      return NnsInternetIdentityAuthnMethodReplaceErrorInvalidMetadata(
        json.valueAsString<String>('InvalidMetadata'),
      );
    }
    if (json.containsKey('AuthnMethodNotFound')) {
      return const NnsInternetIdentityAuthnMethodReplaceErrorAuthnMethodNotFound();
    }
    if (json.containsKey('PasskeyWithThisPublicKeyIsAlreadyUsed')) {
      return const NnsInternetIdentityAuthnMethodReplaceErrorPasskeyWithThisPublicKeyIsAlreadyUsed();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodReplaceError.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodReplaceError arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodReplaceError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodReplaceError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethodReplaceError.InvalidMetadata`.
final class NnsInternetIdentityAuthnMethodReplaceErrorInvalidMetadata
    extends NnsInternetIdentityAuthnMethodReplaceError {
  final String value;
  const NnsInternetIdentityAuthnMethodReplaceErrorInvalidMetadata(this.value);

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodReplaceError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidMetadata', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidMetadata': value};
}

/// Variant arm `AuthnMethodReplaceError.AuthnMethodNotFound` (nullary).
final class NnsInternetIdentityAuthnMethodReplaceErrorAuthnMethodNotFound
    extends NnsInternetIdentityAuthnMethodReplaceError {
  const NnsInternetIdentityAuthnMethodReplaceErrorAuthnMethodNotFound();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodReplaceError.ctype;

  @override
  dynamic get candidValue => const Variant('AuthnMethodNotFound', null);

  @override
  Map<String, dynamic> toJson() => {'AuthnMethodNotFound': null};
}

/// Variant arm `AuthnMethodReplaceError.PasskeyWithThisPublicKeyIsAlreadyUsed` (nullary).
final class NnsInternetIdentityAuthnMethodReplaceErrorPasskeyWithThisPublicKeyIsAlreadyUsed
    extends NnsInternetIdentityAuthnMethodReplaceError {
  const NnsInternetIdentityAuthnMethodReplaceErrorPasskeyWithThisPublicKeyIsAlreadyUsed();

  @override
  CType get candidType => NnsInternetIdentityAuthnMethodReplaceError.ctype;

  @override
  dynamic get candidValue =>
      const Variant('PasskeyWithThisPublicKeyIsAlreadyUsed', null);

  @override
  Map<String, dynamic> toJson() => {
    'PasskeyWithThisPublicKeyIsAlreadyUsed': null,
  };
}

/// Candid variant `AuthnMethodMetadataReplaceError`.
sealed class NnsInternetIdentityAuthnMethodMetadataReplaceError
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodMetadataReplaceError();

  static CType get ctype => CType.variant([
    Field(Label.named('InvalidMetadata'), CType.text),
    Field(Label.named('AuthnMethodNotFound'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodMetadataReplaceError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InvalidMetadata')) {
      return NnsInternetIdentityAuthnMethodMetadataReplaceErrorInvalidMetadata(
        json.valueAsString<String>('InvalidMetadata'),
      );
    }
    if (json.containsKey('AuthnMethodNotFound')) {
      return const NnsInternetIdentityAuthnMethodMetadataReplaceErrorAuthnMethodNotFound();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodMetadataReplaceError.fromCandid',
      reason: 'Unknown NnsInternetIdentityAuthnMethodMetadataReplaceError arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodMetadataReplaceError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodMetadataReplaceError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethodMetadataReplaceError.InvalidMetadata`.
final class NnsInternetIdentityAuthnMethodMetadataReplaceErrorInvalidMetadata
    extends NnsInternetIdentityAuthnMethodMetadataReplaceError {
  final String value;
  const NnsInternetIdentityAuthnMethodMetadataReplaceErrorInvalidMetadata(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodMetadataReplaceError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidMetadata', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidMetadata': value};
}

/// Variant arm `AuthnMethodMetadataReplaceError.AuthnMethodNotFound` (nullary).
final class NnsInternetIdentityAuthnMethodMetadataReplaceErrorAuthnMethodNotFound
    extends NnsInternetIdentityAuthnMethodMetadataReplaceError {
  const NnsInternetIdentityAuthnMethodMetadataReplaceErrorAuthnMethodNotFound();

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodMetadataReplaceError.ctype;

  @override
  dynamic get candidValue => const Variant('AuthnMethodNotFound', null);

  @override
  Map<String, dynamic> toJson() => {'AuthnMethodNotFound': null};
}

/// Candid variant `AuthnMethodSecuritySettingsReplaceError`.
sealed class NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError
    with CandidSerializable {
  const NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError();

  static CType get ctype =>
      CType.variant([Field(Label.named('AuthnMethodNotFound'), CType.null_)]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('AuthnMethodNotFound')) {
      return const NnsInternetIdentityAuthnMethodSecuritySettingsReplaceErrorAuthnMethodNotFound();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError.fromCandid',
      reason:
          'Unknown NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError arm',
    );
  }

  factory NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AuthnMethodSecuritySettingsReplaceError.AuthnMethodNotFound` (nullary).
final class NnsInternetIdentityAuthnMethodSecuritySettingsReplaceErrorAuthnMethodNotFound
    extends NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError {
  const NnsInternetIdentityAuthnMethodSecuritySettingsReplaceErrorAuthnMethodNotFound();

  @override
  CType get candidType =>
      NnsInternetIdentityAuthnMethodSecuritySettingsReplaceError.ctype;

  @override
  dynamic get candidValue => const Variant('AuthnMethodNotFound', null);

  @override
  Map<String, dynamic> toJson() => {'AuthnMethodNotFound': null};
}

/// Candid variant `IdentityMetadataReplaceError`.
sealed class NnsInternetIdentityIdentityMetadataReplaceError
    with CandidSerializable {
  const NnsInternetIdentityIdentityMetadataReplaceError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.principal),
    Field(
      Label.named('StorageSpaceExceeded'),
      CType.record([
        Field(Label.named('space_available'), CType.nat64),
        Field(Label.named('space_required'), CType.nat64),
      ]),
    ),
    Field(Label.named('InternalCanisterError'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdentityMetadataReplaceError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityIdentityMetadataReplaceErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('StorageSpaceExceeded')) {
      return NnsInternetIdentityIdentityMetadataReplaceErrorStorageSpaceExceeded.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['StorageSpaceExceeded'],
        ),
      );
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityIdentityMetadataReplaceErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdentityMetadataReplaceError.fromCandid',
      reason: 'Unknown NnsInternetIdentityIdentityMetadataReplaceError arm',
    );
  }

  factory NnsInternetIdentityIdentityMetadataReplaceError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityMetadataReplaceError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `IdentityMetadataReplaceError.Unauthorized`.
final class NnsInternetIdentityIdentityMetadataReplaceErrorUnauthorized
    extends NnsInternetIdentityIdentityMetadataReplaceError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityIdentityMetadataReplaceErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityIdentityMetadataReplaceError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `IdentityMetadataReplaceError.StorageSpaceExceeded`.
final class NnsInternetIdentityIdentityMetadataReplaceErrorStorageSpaceExceeded
    extends NnsInternetIdentityIdentityMetadataReplaceError {
  final BigInt spaceAvailable;
  final BigInt spaceRequired;

  const NnsInternetIdentityIdentityMetadataReplaceErrorStorageSpaceExceeded({
    required this.spaceAvailable,
    required this.spaceRequired,
  });

  @override
  CType get candidType => NnsInternetIdentityIdentityMetadataReplaceError.ctype;

  @override
  dynamic get candidValue => Variant('StorageSpaceExceeded', {
    'space_available': spaceAvailable,
    'space_required': spaceRequired,
  });

  @override
  Map<String, dynamic> toJson() => {
    'StorageSpaceExceeded': {
      'space_available': spaceAvailable,
      'space_required': spaceRequired,
    },
  };

  factory NnsInternetIdentityIdentityMetadataReplaceErrorStorageSpaceExceeded.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdentityMetadataReplaceErrorStorageSpaceExceeded(
      spaceAvailable: json.valueAsBigInt<BigInt>('space_available'),
      spaceRequired: json.valueAsBigInt<BigInt>('space_required'),
    );
  }
}

/// Variant arm `IdentityMetadataReplaceError.InternalCanisterError`.
final class NnsInternetIdentityIdentityMetadataReplaceErrorInternalCanisterError
    extends NnsInternetIdentityIdentityMetadataReplaceError {
  final String value;
  const NnsInternetIdentityIdentityMetadataReplaceErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityIdentityMetadataReplaceError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Candid variant `CreateAccountError`.
sealed class NnsInternetIdentityCreateAccountError with CandidSerializable {
  const NnsInternetIdentityCreateAccountError();

  static CType get ctype => CType.variant([
    Field(Label.named('InternalCanisterError'), CType.text),
    Field(Label.named('AccountLimitReached'), CType.null_),
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('NameTooLong'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityCreateAccountError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityCreateAccountErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    if (json.containsKey('AccountLimitReached')) {
      return const NnsInternetIdentityCreateAccountErrorAccountLimitReached();
    }
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityCreateAccountErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('NameTooLong')) {
      return const NnsInternetIdentityCreateAccountErrorNameTooLong();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityCreateAccountError.fromCandid',
      reason: 'Unknown NnsInternetIdentityCreateAccountError arm',
    );
  }

  factory NnsInternetIdentityCreateAccountError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityCreateAccountError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CreateAccountError.InternalCanisterError`.
final class NnsInternetIdentityCreateAccountErrorInternalCanisterError
    extends NnsInternetIdentityCreateAccountError {
  final String value;
  const NnsInternetIdentityCreateAccountErrorInternalCanisterError(this.value);

  @override
  CType get candidType => NnsInternetIdentityCreateAccountError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Variant arm `CreateAccountError.AccountLimitReached` (nullary).
final class NnsInternetIdentityCreateAccountErrorAccountLimitReached
    extends NnsInternetIdentityCreateAccountError {
  const NnsInternetIdentityCreateAccountErrorAccountLimitReached();

  @override
  CType get candidType => NnsInternetIdentityCreateAccountError.ctype;

  @override
  dynamic get candidValue => const Variant('AccountLimitReached', null);

  @override
  Map<String, dynamic> toJson() => {'AccountLimitReached': null};
}

/// Variant arm `CreateAccountError.Unauthorized`.
final class NnsInternetIdentityCreateAccountErrorUnauthorized
    extends NnsInternetIdentityCreateAccountError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityCreateAccountErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityCreateAccountError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `CreateAccountError.NameTooLong` (nullary).
final class NnsInternetIdentityCreateAccountErrorNameTooLong
    extends NnsInternetIdentityCreateAccountError {
  const NnsInternetIdentityCreateAccountErrorNameTooLong();

  @override
  CType get candidType => NnsInternetIdentityCreateAccountError.ctype;

  @override
  dynamic get candidValue => const Variant('NameTooLong', null);

  @override
  Map<String, dynamic> toJson() => {'NameTooLong': null};
}

/// Candid variant `UpdateAccountError`.
sealed class NnsInternetIdentityUpdateAccountError with CandidSerializable {
  const NnsInternetIdentityUpdateAccountError();

  static CType get ctype => CType.variant([
    Field(Label.named('InternalCanisterError'), CType.text),
    Field(Label.named('AccountLimitReached'), CType.null_),
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('NameTooLong'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityUpdateAccountError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityUpdateAccountErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    if (json.containsKey('AccountLimitReached')) {
      return const NnsInternetIdentityUpdateAccountErrorAccountLimitReached();
    }
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityUpdateAccountErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('NameTooLong')) {
      return const NnsInternetIdentityUpdateAccountErrorNameTooLong();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityUpdateAccountError.fromCandid',
      reason: 'Unknown NnsInternetIdentityUpdateAccountError arm',
    );
  }

  factory NnsInternetIdentityUpdateAccountError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityUpdateAccountError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `UpdateAccountError.InternalCanisterError`.
final class NnsInternetIdentityUpdateAccountErrorInternalCanisterError
    extends NnsInternetIdentityUpdateAccountError {
  final String value;
  const NnsInternetIdentityUpdateAccountErrorInternalCanisterError(this.value);

  @override
  CType get candidType => NnsInternetIdentityUpdateAccountError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Variant arm `UpdateAccountError.AccountLimitReached` (nullary).
final class NnsInternetIdentityUpdateAccountErrorAccountLimitReached
    extends NnsInternetIdentityUpdateAccountError {
  const NnsInternetIdentityUpdateAccountErrorAccountLimitReached();

  @override
  CType get candidType => NnsInternetIdentityUpdateAccountError.ctype;

  @override
  dynamic get candidValue => const Variant('AccountLimitReached', null);

  @override
  Map<String, dynamic> toJson() => {'AccountLimitReached': null};
}

/// Variant arm `UpdateAccountError.Unauthorized`.
final class NnsInternetIdentityUpdateAccountErrorUnauthorized
    extends NnsInternetIdentityUpdateAccountError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityUpdateAccountErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityUpdateAccountError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `UpdateAccountError.NameTooLong` (nullary).
final class NnsInternetIdentityUpdateAccountErrorNameTooLong
    extends NnsInternetIdentityUpdateAccountError {
  const NnsInternetIdentityUpdateAccountErrorNameTooLong();

  @override
  CType get candidType => NnsInternetIdentityUpdateAccountError.ctype;

  @override
  dynamic get candidValue => const Variant('NameTooLong', null);

  @override
  Map<String, dynamic> toJson() => {'NameTooLong': null};
}

/// Candid variant `AccountDelegationError`.
sealed class NnsInternetIdentityAccountDelegationError with CandidSerializable {
  const NnsInternetIdentityAccountDelegationError();

  static CType get ctype => CType.variant([
    Field(Label.named('InternalCanisterError'), CType.text),
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('NoSuchDelegation'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityAccountDelegationError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityAccountDelegationErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityAccountDelegationErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('NoSuchDelegation')) {
      return const NnsInternetIdentityAccountDelegationErrorNoSuchDelegation();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityAccountDelegationError.fromCandid',
      reason: 'Unknown NnsInternetIdentityAccountDelegationError arm',
    );
  }

  factory NnsInternetIdentityAccountDelegationError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAccountDelegationError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `AccountDelegationError.InternalCanisterError`.
final class NnsInternetIdentityAccountDelegationErrorInternalCanisterError
    extends NnsInternetIdentityAccountDelegationError {
  final String value;
  const NnsInternetIdentityAccountDelegationErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityAccountDelegationError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Variant arm `AccountDelegationError.Unauthorized`.
final class NnsInternetIdentityAccountDelegationErrorUnauthorized
    extends NnsInternetIdentityAccountDelegationError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityAccountDelegationErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityAccountDelegationError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `AccountDelegationError.NoSuchDelegation` (nullary).
final class NnsInternetIdentityAccountDelegationErrorNoSuchDelegation
    extends NnsInternetIdentityAccountDelegationError {
  const NnsInternetIdentityAccountDelegationErrorNoSuchDelegation();

  @override
  CType get candidType => NnsInternetIdentityAccountDelegationError.ctype;

  @override
  dynamic get candidValue => const Variant('NoSuchDelegation', null);

  @override
  Map<String, dynamic> toJson() => {'NoSuchDelegation': null};
}

/// Candid variant `GetDefaultAccountError`.
sealed class NnsInternetIdentityGetDefaultAccountError with CandidSerializable {
  const NnsInternetIdentityGetDefaultAccountError();

  static CType get ctype => CType.variant([
    Field(Label.named('InternalCanisterError'), CType.text),
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('NoSuchAnchor'), CType.null_),
    Field(
      Label.named('NoSuchOrigin'),
      CType.record([Field(Label.named('anchor_number'), CType.nat64)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetDefaultAccountError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityGetDefaultAccountErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityGetDefaultAccountErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('NoSuchAnchor')) {
      return const NnsInternetIdentityGetDefaultAccountErrorNoSuchAnchor();
    }
    if (json.containsKey('NoSuchOrigin')) {
      return NnsInternetIdentityGetDefaultAccountErrorNoSuchOrigin.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['NoSuchOrigin']),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetDefaultAccountError.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetDefaultAccountError arm',
    );
  }

  factory NnsInternetIdentityGetDefaultAccountError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetDefaultAccountError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetDefaultAccountError.InternalCanisterError`.
final class NnsInternetIdentityGetDefaultAccountErrorInternalCanisterError
    extends NnsInternetIdentityGetDefaultAccountError {
  final String value;
  const NnsInternetIdentityGetDefaultAccountErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityGetDefaultAccountError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Variant arm `GetDefaultAccountError.Unauthorized`.
final class NnsInternetIdentityGetDefaultAccountErrorUnauthorized
    extends NnsInternetIdentityGetDefaultAccountError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityGetDefaultAccountErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetDefaultAccountError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `GetDefaultAccountError.NoSuchAnchor` (nullary).
final class NnsInternetIdentityGetDefaultAccountErrorNoSuchAnchor
    extends NnsInternetIdentityGetDefaultAccountError {
  const NnsInternetIdentityGetDefaultAccountErrorNoSuchAnchor();

  @override
  CType get candidType => NnsInternetIdentityGetDefaultAccountError.ctype;

  @override
  dynamic get candidValue => const Variant('NoSuchAnchor', null);

  @override
  Map<String, dynamic> toJson() => {'NoSuchAnchor': null};
}

/// Variant arm `GetDefaultAccountError.NoSuchOrigin`.
final class NnsInternetIdentityGetDefaultAccountErrorNoSuchOrigin
    extends NnsInternetIdentityGetDefaultAccountError {
  final NnsInternetIdentityUserNumber anchorNumber;

  const NnsInternetIdentityGetDefaultAccountErrorNoSuchOrigin({
    required this.anchorNumber,
  });

  @override
  CType get candidType => NnsInternetIdentityGetDefaultAccountError.ctype;

  @override
  dynamic get candidValue =>
      Variant('NoSuchOrigin', {'anchor_number': anchorNumber});

  @override
  Map<String, dynamic> toJson() => {
    'NoSuchOrigin': {'anchor_number': anchorNumber},
  };

  factory NnsInternetIdentityGetDefaultAccountErrorNoSuchOrigin.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityGetDefaultAccountErrorNoSuchOrigin(
      anchorNumber: json.valueAsBigInt<BigInt>('anchor_number'),
    );
  }
}

/// Candid variant `SetDefaultAccountError`.
sealed class NnsInternetIdentitySetDefaultAccountError with CandidSerializable {
  const NnsInternetIdentitySetDefaultAccountError();

  static CType get ctype => CType.variant([
    Field(Label.named('InternalCanisterError'), CType.text),
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('NoSuchAnchor'), CType.null_),
    Field(
      Label.named('NoSuchOrigin'),
      CType.record([Field(Label.named('anchor_number'), CType.nat64)]),
    ),
    Field(
      Label.named('NoSuchAccount'),
      CType.record([
        Field(Label.named('anchor_number'), CType.nat64),
        Field(Label.named('origin'), CType.text),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentitySetDefaultAccountError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentitySetDefaultAccountErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentitySetDefaultAccountErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('NoSuchAnchor')) {
      return const NnsInternetIdentitySetDefaultAccountErrorNoSuchAnchor();
    }
    if (json.containsKey('NoSuchOrigin')) {
      return NnsInternetIdentitySetDefaultAccountErrorNoSuchOrigin.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['NoSuchOrigin']),
      );
    }
    if (json.containsKey('NoSuchAccount')) {
      return NnsInternetIdentitySetDefaultAccountErrorNoSuchAccount.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['NoSuchAccount']),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentitySetDefaultAccountError.fromCandid',
      reason: 'Unknown NnsInternetIdentitySetDefaultAccountError arm',
    );
  }

  factory NnsInternetIdentitySetDefaultAccountError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySetDefaultAccountError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `SetDefaultAccountError.InternalCanisterError`.
final class NnsInternetIdentitySetDefaultAccountErrorInternalCanisterError
    extends NnsInternetIdentitySetDefaultAccountError {
  final String value;
  const NnsInternetIdentitySetDefaultAccountErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentitySetDefaultAccountError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Variant arm `SetDefaultAccountError.Unauthorized`.
final class NnsInternetIdentitySetDefaultAccountErrorUnauthorized
    extends NnsInternetIdentitySetDefaultAccountError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentitySetDefaultAccountErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentitySetDefaultAccountError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `SetDefaultAccountError.NoSuchAnchor` (nullary).
final class NnsInternetIdentitySetDefaultAccountErrorNoSuchAnchor
    extends NnsInternetIdentitySetDefaultAccountError {
  const NnsInternetIdentitySetDefaultAccountErrorNoSuchAnchor();

  @override
  CType get candidType => NnsInternetIdentitySetDefaultAccountError.ctype;

  @override
  dynamic get candidValue => const Variant('NoSuchAnchor', null);

  @override
  Map<String, dynamic> toJson() => {'NoSuchAnchor': null};
}

/// Variant arm `SetDefaultAccountError.NoSuchOrigin`.
final class NnsInternetIdentitySetDefaultAccountErrorNoSuchOrigin
    extends NnsInternetIdentitySetDefaultAccountError {
  final NnsInternetIdentityUserNumber anchorNumber;

  const NnsInternetIdentitySetDefaultAccountErrorNoSuchOrigin({
    required this.anchorNumber,
  });

  @override
  CType get candidType => NnsInternetIdentitySetDefaultAccountError.ctype;

  @override
  dynamic get candidValue =>
      Variant('NoSuchOrigin', {'anchor_number': anchorNumber});

  @override
  Map<String, dynamic> toJson() => {
    'NoSuchOrigin': {'anchor_number': anchorNumber},
  };

  factory NnsInternetIdentitySetDefaultAccountErrorNoSuchOrigin.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySetDefaultAccountErrorNoSuchOrigin(
      anchorNumber: json.valueAsBigInt<BigInt>('anchor_number'),
    );
  }
}

/// Variant arm `SetDefaultAccountError.NoSuchAccount`.
final class NnsInternetIdentitySetDefaultAccountErrorNoSuchAccount
    extends NnsInternetIdentitySetDefaultAccountError {
  final NnsInternetIdentityUserNumber anchorNumber;
  final NnsInternetIdentityFrontendHostname origin;

  const NnsInternetIdentitySetDefaultAccountErrorNoSuchAccount({
    required this.anchorNumber,
    required this.origin,
  });

  @override
  CType get candidType => NnsInternetIdentitySetDefaultAccountError.ctype;

  @override
  dynamic get candidValue => Variant('NoSuchAccount', {
    'anchor_number': anchorNumber,
    'origin': origin,
  });

  @override
  Map<String, dynamic> toJson() => {
    'NoSuchAccount': {'anchor_number': anchorNumber, 'origin': origin},
  };

  factory NnsInternetIdentitySetDefaultAccountErrorNoSuchAccount.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySetDefaultAccountErrorNoSuchAccount(
      anchorNumber: json.valueAsBigInt<BigInt>('anchor_number'),
      origin: json.valueAsString<String>('origin'),
    );
  }
}

/// Candid record `PrepareAccountDelegation`.
final class NnsInternetIdentityPrepareAccountDelegation
    with CandidSerializable {
  final NnsInternetIdentityUserKey userKey;
  final NnsInternetIdentityTimestamp expiration;

  const NnsInternetIdentityPrepareAccountDelegation({
    required this.userKey,
    required this.expiration,
  });

  static CType get ctype => CType.record([
    Field(Label.named('user_key'), CType.vec(CType.nat8)),
    Field(Label.named('expiration'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'user_key': userKey, 'expiration': expiration};

  Map<String, dynamic> toJson() => {
    'user_key': userKey,
    'expiration': expiration,
  };

  factory NnsInternetIdentityPrepareAccountDelegation.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareAccountDelegation(
      userKey: json.valueAsBytes<List<int>>(
        'user_key',
        encoding: StringEncoding.base64,
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
    );
  }

  factory NnsInternetIdentityPrepareAccountDelegation.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareAccountDelegation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `McpPrepareDelegation`.
final class NnsInternetIdentityMcpPrepareDelegation with CandidSerializable {
  final NnsInternetIdentityUserKey userKey;
  final NnsInternetIdentityTimestamp expiration;
  final NnsInternetIdentityAccountNumber? accountNumber;

  const NnsInternetIdentityMcpPrepareDelegation({
    required this.userKey,
    required this.expiration,
    this.accountNumber,
  });

  static CType get ctype => CType.record([
    Field(Label.named('user_key'), CType.vec(CType.nat8)),
    Field(Label.named('expiration'), CType.nat64),
    Field(Label.named('account_number'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'user_key': userKey,
    'expiration': expiration,
    'account_number': accountNumber,
  };

  Map<String, dynamic> toJson() => {
    'user_key': userKey,
    'expiration': expiration,
    'account_number': accountNumber,
  };

  factory NnsInternetIdentityMcpPrepareDelegation.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityMcpPrepareDelegation(
      userKey: json.valueAsBytes<List<int>>(
        'user_key',
        encoding: StringEncoding.base64,
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
      accountNumber: json.valueAsBigInt<BigInt?>('account_number'),
    );
  }

  factory NnsInternetIdentityMcpPrepareDelegation.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMcpPrepareDelegation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `SessionDelegationError`.
sealed class NnsInternetIdentitySessionDelegationError with CandidSerializable {
  const NnsInternetIdentitySessionDelegationError();

  static CType get ctype => CType.variant([
    Field(Label.named('InternalCanisterError'), CType.text),
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('NoSuchDelegation'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentitySessionDelegationError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentitySessionDelegationErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentitySessionDelegationErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('NoSuchDelegation')) {
      return const NnsInternetIdentitySessionDelegationErrorNoSuchDelegation();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentitySessionDelegationError.fromCandid',
      reason: 'Unknown NnsInternetIdentitySessionDelegationError arm',
    );
  }

  factory NnsInternetIdentitySessionDelegationError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySessionDelegationError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `SessionDelegationError.InternalCanisterError`.
final class NnsInternetIdentitySessionDelegationErrorInternalCanisterError
    extends NnsInternetIdentitySessionDelegationError {
  final String value;
  const NnsInternetIdentitySessionDelegationErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentitySessionDelegationError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Variant arm `SessionDelegationError.Unauthorized`.
final class NnsInternetIdentitySessionDelegationErrorUnauthorized
    extends NnsInternetIdentitySessionDelegationError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentitySessionDelegationErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentitySessionDelegationError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `SessionDelegationError.NoSuchDelegation` (nullary).
final class NnsInternetIdentitySessionDelegationErrorNoSuchDelegation
    extends NnsInternetIdentitySessionDelegationError {
  const NnsInternetIdentitySessionDelegationErrorNoSuchDelegation();

  @override
  CType get candidType => NnsInternetIdentitySessionDelegationError.ctype;

  @override
  dynamic get candidValue => const Variant('NoSuchDelegation', null);

  @override
  Map<String, dynamic> toJson() => {'NoSuchDelegation': null};
}

/// Candid record `PrepareSessionDelegation`.
final class NnsInternetIdentityPrepareSessionDelegation
    with CandidSerializable {
  final NnsInternetIdentityUserKey userKey;
  final NnsInternetIdentityTimestamp expiration;

  const NnsInternetIdentityPrepareSessionDelegation({
    required this.userKey,
    required this.expiration,
  });

  static CType get ctype => CType.record([
    Field(Label.named('user_key'), CType.vec(CType.nat8)),
    Field(Label.named('expiration'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'user_key': userKey, 'expiration': expiration};

  Map<String, dynamic> toJson() => {
    'user_key': userKey,
    'expiration': expiration,
  };

  factory NnsInternetIdentityPrepareSessionDelegation.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareSessionDelegation(
      userKey: json.valueAsBytes<List<int>>(
        'user_key',
        encoding: StringEncoding.base64,
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
    );
  }

  factory NnsInternetIdentityPrepareSessionDelegation.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareSessionDelegation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `McpConfig`.
final class NnsInternetIdentityMcpConfig with CandidSerializable {
  final bool enabled;
  final String? url;

  const NnsInternetIdentityMcpConfig({required this.enabled, this.url});

  static CType get ctype => CType.record([
    Field(Label.named('enabled'), CType.bool_),
    Field(Label.named('url'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'enabled': enabled, 'url': url};

  Map<String, dynamic> toJson() => {'enabled': enabled, 'url': url};

  factory NnsInternetIdentityMcpConfig.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityMcpConfig(
      enabled: json.valueAsBool<bool>('enabled'),
      url: json.valueAsString<String?>('url'),
    );
  }

  factory NnsInternetIdentityMcpConfig.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMcpConfig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `PrepareMcpRegistrationDelegation`.
final class NnsInternetIdentityPrepareMcpRegistrationDelegation
    with CandidSerializable {
  final NnsInternetIdentityUserKey userKey;
  final NnsInternetIdentityTimestamp expiration;
  final String trustedUrl;

  const NnsInternetIdentityPrepareMcpRegistrationDelegation({
    required this.userKey,
    required this.expiration,
    required this.trustedUrl,
  });

  static CType get ctype => CType.record([
    Field(Label.named('user_key'), CType.vec(CType.nat8)),
    Field(Label.named('expiration'), CType.nat64),
    Field(Label.named('trusted_url'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'user_key': userKey,
    'expiration': expiration,
    'trusted_url': trustedUrl,
  };

  Map<String, dynamic> toJson() => {
    'user_key': userKey,
    'expiration': expiration,
    'trusted_url': trustedUrl,
  };

  factory NnsInternetIdentityPrepareMcpRegistrationDelegation.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareMcpRegistrationDelegation(
      userKey: json.valueAsBytes<List<int>>(
        'user_key',
        encoding: StringEncoding.base64,
      ),
      expiration: json.valueAsBigInt<BigInt>('expiration'),
      trustedUrl: json.valueAsString<String>('trusted_url'),
    );
  }

  factory NnsInternetIdentityPrepareMcpRegistrationDelegation.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareMcpRegistrationDelegation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `McpRegistrationV2`.
final class NnsInternetIdentityMcpRegistrationV2 with CandidSerializable {
  final NnsInternetIdentityTimestamp expiration;
  final NnsInternetIdentityPermissions permissions;

  const NnsInternetIdentityMcpRegistrationV2({
    required this.expiration,
    required this.permissions,
  });

  static CType get ctype => CType.record([
    Field(Label.named('expiration'), CType.nat64),
    LazyField(
      Label.named('permissions'),
      () => NnsInternetIdentityPermissions.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'expiration': expiration,
    'permissions': permissions.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'expiration': expiration,
    'permissions': permissions.toJson(),
  };

  factory NnsInternetIdentityMcpRegistrationV2.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityMcpRegistrationV2(
      expiration: json.valueAsBigInt<BigInt>('expiration'),
      permissions: json.valueTo<NnsInternetIdentityPermissions, Map>(
        key: 'permissions',
        parse:
            (e) => NnsInternetIdentityPermissions.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentityMcpRegistrationV2.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityMcpRegistrationV2.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `GetAccountsError`.
sealed class NnsInternetIdentityGetAccountsError with CandidSerializable {
  const NnsInternetIdentityGetAccountsError();

  static CType get ctype => CType.variant([
    Field(Label.named('InternalCanisterError'), CType.text),
    Field(Label.named('Unauthorized'), CType.principal),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetAccountsError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityGetAccountsErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityGetAccountsErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetAccountsError.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetAccountsError arm',
    );
  }

  factory NnsInternetIdentityGetAccountsError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetAccountsError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetAccountsError.InternalCanisterError`.
final class NnsInternetIdentityGetAccountsErrorInternalCanisterError
    extends NnsInternetIdentityGetAccountsError {
  final String value;
  const NnsInternetIdentityGetAccountsErrorInternalCanisterError(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetAccountsError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Variant arm `GetAccountsError.Unauthorized`.
final class NnsInternetIdentityGetAccountsErrorUnauthorized
    extends NnsInternetIdentityGetAccountsError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityGetAccountsErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetAccountsError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Candid record `PrepareIdAliasRequest`.
final class NnsInternetIdentityPrepareIdAliasRequest with CandidSerializable {
  final NnsInternetIdentityFrontendHostname issuer;
  final NnsInternetIdentityFrontendHostname relyingParty;
  final NnsInternetIdentityIdentityNumber identityNumber;

  const NnsInternetIdentityPrepareIdAliasRequest({
    required this.issuer,
    required this.relyingParty,
    required this.identityNumber,
  });

  static CType get ctype => CType.record([
    Field(Label.named('issuer'), CType.text),
    Field(Label.named('relying_party'), CType.text),
    Field(Label.named('identity_number'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'issuer': issuer,
    'relying_party': relyingParty,
    'identity_number': identityNumber,
  };

  Map<String, dynamic> toJson() => {
    'issuer': issuer,
    'relying_party': relyingParty,
    'identity_number': identityNumber,
  };

  factory NnsInternetIdentityPrepareIdAliasRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareIdAliasRequest(
      issuer: json.valueAsString<String>('issuer'),
      relyingParty: json.valueAsString<String>('relying_party'),
      identityNumber: json.valueAsBigInt<BigInt>('identity_number'),
    );
  }

  factory NnsInternetIdentityPrepareIdAliasRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareIdAliasRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `PrepareIdAliasError`.
sealed class NnsInternetIdentityPrepareIdAliasError with CandidSerializable {
  const NnsInternetIdentityPrepareIdAliasError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('InternalCanisterError'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPrepareIdAliasError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityPrepareIdAliasErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityPrepareIdAliasErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPrepareIdAliasError.fromCandid',
      reason: 'Unknown NnsInternetIdentityPrepareIdAliasError arm',
    );
  }

  factory NnsInternetIdentityPrepareIdAliasError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareIdAliasError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `PrepareIdAliasError.Unauthorized`.
final class NnsInternetIdentityPrepareIdAliasErrorUnauthorized
    extends NnsInternetIdentityPrepareIdAliasError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityPrepareIdAliasErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityPrepareIdAliasError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `PrepareIdAliasError.InternalCanisterError`.
final class NnsInternetIdentityPrepareIdAliasErrorInternalCanisterError
    extends NnsInternetIdentityPrepareIdAliasError {
  final String value;
  const NnsInternetIdentityPrepareIdAliasErrorInternalCanisterError(this.value);

  @override
  CType get candidType => NnsInternetIdentityPrepareIdAliasError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Candid record `PreparedIdAlias`.
final class NnsInternetIdentityPreparedIdAlias with CandidSerializable {
  final String rpIdAliasJwt;
  final String issuerIdAliasJwt;
  final NnsInternetIdentityPublicKey canisterSigPkDer;

  const NnsInternetIdentityPreparedIdAlias({
    required this.rpIdAliasJwt,
    required this.issuerIdAliasJwt,
    required this.canisterSigPkDer,
  });

  static CType get ctype => CType.record([
    Field(Label.named('rp_id_alias_jwt'), CType.text),
    Field(Label.named('issuer_id_alias_jwt'), CType.text),
    Field(Label.named('canister_sig_pk_der'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'rp_id_alias_jwt': rpIdAliasJwt,
    'issuer_id_alias_jwt': issuerIdAliasJwt,
    'canister_sig_pk_der': canisterSigPkDer,
  };

  Map<String, dynamic> toJson() => {
    'rp_id_alias_jwt': rpIdAliasJwt,
    'issuer_id_alias_jwt': issuerIdAliasJwt,
    'canister_sig_pk_der': canisterSigPkDer,
  };

  factory NnsInternetIdentityPreparedIdAlias.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPreparedIdAlias(
      rpIdAliasJwt: json.valueAsString<String>('rp_id_alias_jwt'),
      issuerIdAliasJwt: json.valueAsString<String>('issuer_id_alias_jwt'),
      canisterSigPkDer: json.valueAsBytes<List<int>>(
        'canister_sig_pk_der',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityPreparedIdAlias.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPreparedIdAlias.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetIdAliasRequest`.
final class NnsInternetIdentityGetIdAliasRequest with CandidSerializable {
  final String rpIdAliasJwt;
  final NnsInternetIdentityFrontendHostname issuer;
  final String issuerIdAliasJwt;
  final NnsInternetIdentityFrontendHostname relyingParty;
  final NnsInternetIdentityIdentityNumber identityNumber;

  const NnsInternetIdentityGetIdAliasRequest({
    required this.rpIdAliasJwt,
    required this.issuer,
    required this.issuerIdAliasJwt,
    required this.relyingParty,
    required this.identityNumber,
  });

  static CType get ctype => CType.record([
    Field(Label.named('rp_id_alias_jwt'), CType.text),
    Field(Label.named('issuer'), CType.text),
    Field(Label.named('issuer_id_alias_jwt'), CType.text),
    Field(Label.named('relying_party'), CType.text),
    Field(Label.named('identity_number'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'rp_id_alias_jwt': rpIdAliasJwt,
    'issuer': issuer,
    'issuer_id_alias_jwt': issuerIdAliasJwt,
    'relying_party': relyingParty,
    'identity_number': identityNumber,
  };

  Map<String, dynamic> toJson() => {
    'rp_id_alias_jwt': rpIdAliasJwt,
    'issuer': issuer,
    'issuer_id_alias_jwt': issuerIdAliasJwt,
    'relying_party': relyingParty,
    'identity_number': identityNumber,
  };

  factory NnsInternetIdentityGetIdAliasRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityGetIdAliasRequest(
      rpIdAliasJwt: json.valueAsString<String>('rp_id_alias_jwt'),
      issuer: json.valueAsString<String>('issuer'),
      issuerIdAliasJwt: json.valueAsString<String>('issuer_id_alias_jwt'),
      relyingParty: json.valueAsString<String>('relying_party'),
      identityNumber: json.valueAsBigInt<BigInt>('identity_number'),
    );
  }

  factory NnsInternetIdentityGetIdAliasRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetIdAliasRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `GetIdAliasError`.
sealed class NnsInternetIdentityGetIdAliasError with CandidSerializable {
  const NnsInternetIdentityGetIdAliasError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.principal),
    Field(Label.named('NoSuchCredentials'), CType.text),
    Field(Label.named('InternalCanisterError'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetIdAliasError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityGetIdAliasErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('NoSuchCredentials')) {
      return NnsInternetIdentityGetIdAliasErrorNoSuchCredentials(
        json.valueAsString<String>('NoSuchCredentials'),
      );
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityGetIdAliasErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetIdAliasError.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetIdAliasError arm',
    );
  }

  factory NnsInternetIdentityGetIdAliasError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetIdAliasError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetIdAliasError.Unauthorized`.
final class NnsInternetIdentityGetIdAliasErrorUnauthorized
    extends NnsInternetIdentityGetIdAliasError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityGetIdAliasErrorUnauthorized(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetIdAliasError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `GetIdAliasError.NoSuchCredentials`.
final class NnsInternetIdentityGetIdAliasErrorNoSuchCredentials
    extends NnsInternetIdentityGetIdAliasError {
  final String value;
  const NnsInternetIdentityGetIdAliasErrorNoSuchCredentials(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetIdAliasError.ctype;

  @override
  dynamic get candidValue => Variant('NoSuchCredentials', value);

  @override
  Map<String, dynamic> toJson() => {'NoSuchCredentials': value};
}

/// Variant arm `GetIdAliasError.InternalCanisterError`.
final class NnsInternetIdentityGetIdAliasErrorInternalCanisterError
    extends NnsInternetIdentityGetIdAliasError {
  final String value;
  const NnsInternetIdentityGetIdAliasErrorInternalCanisterError(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetIdAliasError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Candid record `IdAliasCredentials`.
final class NnsInternetIdentityIdAliasCredentials with CandidSerializable {
  final NnsInternetIdentitySignedIdAlias rpIdAliasCredential;
  final NnsInternetIdentitySignedIdAlias issuerIdAliasCredential;

  const NnsInternetIdentityIdAliasCredentials({
    required this.rpIdAliasCredential,
    required this.issuerIdAliasCredential,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('rp_id_alias_credential'),
      () => NnsInternetIdentitySignedIdAlias.ctype,
    ),
    LazyField(
      Label.named('issuer_id_alias_credential'),
      () => NnsInternetIdentitySignedIdAlias.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'rp_id_alias_credential': rpIdAliasCredential.candidValue,
    'issuer_id_alias_credential': issuerIdAliasCredential.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'rp_id_alias_credential': rpIdAliasCredential.toJson(),
    'issuer_id_alias_credential': issuerIdAliasCredential.toJson(),
  };

  factory NnsInternetIdentityIdAliasCredentials.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdAliasCredentials(
      rpIdAliasCredential: json.valueTo<NnsInternetIdentitySignedIdAlias, Map>(
        key: 'rp_id_alias_credential',
        parse:
            (e) => NnsInternetIdentitySignedIdAlias.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      issuerIdAliasCredential: json
          .valueTo<NnsInternetIdentitySignedIdAlias, Map>(
            key: 'issuer_id_alias_credential',
            parse:
                (e) => NnsInternetIdentitySignedIdAlias.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsInternetIdentityIdAliasCredentials.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdAliasCredentials.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SignedIdAlias`.
final class NnsInternetIdentitySignedIdAlias with CandidSerializable {
  final String credentialJws;
  final IcpPrincipalAddress idAlias;
  final IcpPrincipalAddress idDapp;

  const NnsInternetIdentitySignedIdAlias({
    required this.credentialJws,
    required this.idAlias,
    required this.idDapp,
  });

  static CType get ctype => CType.record([
    Field(Label.named('credential_jws'), CType.text),
    Field(Label.named('id_alias'), CType.principal),
    Field(Label.named('id_dapp'), CType.principal),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'credential_jws': credentialJws,
    'id_alias': idAlias,
    'id_dapp': idDapp,
  };

  Map<String, dynamic> toJson() => {
    'credential_jws': credentialJws,
    'id_alias': idAlias.address,
    'id_dapp': idDapp.address,
  };

  factory NnsInternetIdentitySignedIdAlias.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentitySignedIdAlias(
      credentialJws: json.valueAsString<String>('credential_jws'),
      idAlias: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'id_alias',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      idDapp: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'id_dapp',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsInternetIdentitySignedIdAlias.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentitySignedIdAlias.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `IdRegNextStepResult`.
final class NnsInternetIdentityIdRegNextStepResult with CandidSerializable {
  final NnsInternetIdentityRegistrationFlowNextStep nextStep;

  const NnsInternetIdentityIdRegNextStepResult({required this.nextStep});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('next_step'),
      () => NnsInternetIdentityRegistrationFlowNextStep.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'next_step': nextStep.candidValue};

  Map<String, dynamic> toJson() => {'next_step': nextStep.toJson()};

  factory NnsInternetIdentityIdRegNextStepResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdRegNextStepResult(
      nextStep: json.valueTo<NnsInternetIdentityRegistrationFlowNextStep, Map>(
        key: 'next_step',
        parse:
            (e) => NnsInternetIdentityRegistrationFlowNextStep.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsInternetIdentityIdRegNextStepResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdRegNextStepResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `IdRegStartError`.
sealed class NnsInternetIdentityIdRegStartError with CandidSerializable {
  const NnsInternetIdentityIdRegStartError();

  static CType get ctype => CType.variant([
    Field(Label.named('InvalidCaller'), CType.null_),
    Field(Label.named('RateLimitExceeded'), CType.null_),
    Field(Label.named('AlreadyInProgress'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdRegStartError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('InvalidCaller')) {
      return const NnsInternetIdentityIdRegStartErrorInvalidCaller();
    }
    if (json.containsKey('RateLimitExceeded')) {
      return const NnsInternetIdentityIdRegStartErrorRateLimitExceeded();
    }
    if (json.containsKey('AlreadyInProgress')) {
      return const NnsInternetIdentityIdRegStartErrorAlreadyInProgress();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdRegStartError.fromCandid',
      reason: 'Unknown NnsInternetIdentityIdRegStartError arm',
    );
  }

  factory NnsInternetIdentityIdRegStartError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdRegStartError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `IdRegStartError.InvalidCaller` (nullary).
final class NnsInternetIdentityIdRegStartErrorInvalidCaller
    extends NnsInternetIdentityIdRegStartError {
  const NnsInternetIdentityIdRegStartErrorInvalidCaller();

  @override
  CType get candidType => NnsInternetIdentityIdRegStartError.ctype;

  @override
  dynamic get candidValue => const Variant('InvalidCaller', null);

  @override
  Map<String, dynamic> toJson() => {'InvalidCaller': null};
}

/// Variant arm `IdRegStartError.RateLimitExceeded` (nullary).
final class NnsInternetIdentityIdRegStartErrorRateLimitExceeded
    extends NnsInternetIdentityIdRegStartError {
  const NnsInternetIdentityIdRegStartErrorRateLimitExceeded();

  @override
  CType get candidType => NnsInternetIdentityIdRegStartError.ctype;

  @override
  dynamic get candidValue => const Variant('RateLimitExceeded', null);

  @override
  Map<String, dynamic> toJson() => {'RateLimitExceeded': null};
}

/// Variant arm `IdRegStartError.AlreadyInProgress` (nullary).
final class NnsInternetIdentityIdRegStartErrorAlreadyInProgress
    extends NnsInternetIdentityIdRegStartError {
  const NnsInternetIdentityIdRegStartErrorAlreadyInProgress();

  @override
  CType get candidType => NnsInternetIdentityIdRegStartError.ctype;

  @override
  dynamic get candidValue => const Variant('AlreadyInProgress', null);

  @override
  Map<String, dynamic> toJson() => {'AlreadyInProgress': null};
}

/// Candid variant `RegistrationFlowNextStep`.
sealed class NnsInternetIdentityRegistrationFlowNextStep
    with CandidSerializable {
  const NnsInternetIdentityRegistrationFlowNextStep();

  static CType get ctype => CType.variant([
    Field(
      Label.named('CheckCaptcha'),
      CType.record([Field(Label.named('captcha_png_base64'), CType.text)]),
    ),
    Field(Label.named('Finish'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityRegistrationFlowNextStep.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('CheckCaptcha')) {
      return NnsInternetIdentityRegistrationFlowNextStepCheckCaptcha.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CheckCaptcha']),
      );
    }
    if (json.containsKey('Finish')) {
      return const NnsInternetIdentityRegistrationFlowNextStepFinish();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityRegistrationFlowNextStep.fromCandid',
      reason: 'Unknown NnsInternetIdentityRegistrationFlowNextStep arm',
    );
  }

  factory NnsInternetIdentityRegistrationFlowNextStep.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityRegistrationFlowNextStep.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `RegistrationFlowNextStep.CheckCaptcha`.
final class NnsInternetIdentityRegistrationFlowNextStepCheckCaptcha
    extends NnsInternetIdentityRegistrationFlowNextStep {
  final String captchaPngBase64;

  const NnsInternetIdentityRegistrationFlowNextStepCheckCaptcha({
    required this.captchaPngBase64,
  });

  @override
  CType get candidType => NnsInternetIdentityRegistrationFlowNextStep.ctype;

  @override
  dynamic get candidValue =>
      Variant('CheckCaptcha', {'captcha_png_base64': captchaPngBase64});

  @override
  Map<String, dynamic> toJson() => {
    'CheckCaptcha': {'captcha_png_base64': captchaPngBase64},
  };

  factory NnsInternetIdentityRegistrationFlowNextStepCheckCaptcha.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityRegistrationFlowNextStepCheckCaptcha(
      captchaPngBase64: json.valueAsString<String>('captcha_png_base64'),
    );
  }
}

/// Variant arm `RegistrationFlowNextStep.Finish` (nullary).
final class NnsInternetIdentityRegistrationFlowNextStepFinish
    extends NnsInternetIdentityRegistrationFlowNextStep {
  const NnsInternetIdentityRegistrationFlowNextStepFinish();

  @override
  CType get candidType => NnsInternetIdentityRegistrationFlowNextStep.ctype;

  @override
  dynamic get candidValue => const Variant('Finish', null);

  @override
  Map<String, dynamic> toJson() => {'Finish': null};
}

/// Candid record `CheckCaptchaArg`.
final class NnsInternetIdentityCheckCaptchaArg with CandidSerializable {
  final String solution;

  const NnsInternetIdentityCheckCaptchaArg({required this.solution});

  static CType get ctype =>
      CType.record([Field(Label.named('solution'), CType.text)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'solution': solution};

  Map<String, dynamic> toJson() => {'solution': solution};

  factory NnsInternetIdentityCheckCaptchaArg.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityCheckCaptchaArg(
      solution: json.valueAsString<String>('solution'),
    );
  }

  factory NnsInternetIdentityCheckCaptchaArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityCheckCaptchaArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `CheckCaptchaError`.
sealed class NnsInternetIdentityCheckCaptchaError with CandidSerializable {
  const NnsInternetIdentityCheckCaptchaError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('WrongSolution'),
      CType.record([Field(Label.named('new_captcha_png_base64'), CType.text)]),
    ),
    LazyField(
      Label.named('UnexpectedCall'),
      () => CType.record([
        LazyField(
          Label.named('next_step'),
          () => NnsInternetIdentityRegistrationFlowNextStep.ctype,
        ),
      ]),
    ),
    Field(Label.named('NoRegistrationFlow'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityCheckCaptchaError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('WrongSolution')) {
      return NnsInternetIdentityCheckCaptchaErrorWrongSolution.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['WrongSolution']),
      );
    }
    if (json.containsKey('UnexpectedCall')) {
      return NnsInternetIdentityCheckCaptchaErrorUnexpectedCall.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['UnexpectedCall']),
      );
    }
    if (json.containsKey('NoRegistrationFlow')) {
      return const NnsInternetIdentityCheckCaptchaErrorNoRegistrationFlow();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityCheckCaptchaError.fromCandid',
      reason: 'Unknown NnsInternetIdentityCheckCaptchaError arm',
    );
  }

  factory NnsInternetIdentityCheckCaptchaError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityCheckCaptchaError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CheckCaptchaError.WrongSolution`.
final class NnsInternetIdentityCheckCaptchaErrorWrongSolution
    extends NnsInternetIdentityCheckCaptchaError {
  final String newCaptchaPngBase64;

  const NnsInternetIdentityCheckCaptchaErrorWrongSolution({
    required this.newCaptchaPngBase64,
  });

  @override
  CType get candidType => NnsInternetIdentityCheckCaptchaError.ctype;

  @override
  dynamic get candidValue =>
      Variant('WrongSolution', {'new_captcha_png_base64': newCaptchaPngBase64});

  @override
  Map<String, dynamic> toJson() => {
    'WrongSolution': {'new_captcha_png_base64': newCaptchaPngBase64},
  };

  factory NnsInternetIdentityCheckCaptchaErrorWrongSolution.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityCheckCaptchaErrorWrongSolution(
      newCaptchaPngBase64: json.valueAsString<String>('new_captcha_png_base64'),
    );
  }
}

/// Variant arm `CheckCaptchaError.UnexpectedCall`.
final class NnsInternetIdentityCheckCaptchaErrorUnexpectedCall
    extends NnsInternetIdentityCheckCaptchaError {
  final NnsInternetIdentityRegistrationFlowNextStep nextStep;

  const NnsInternetIdentityCheckCaptchaErrorUnexpectedCall({
    required this.nextStep,
  });

  @override
  CType get candidType => NnsInternetIdentityCheckCaptchaError.ctype;

  @override
  dynamic get candidValue =>
      Variant('UnexpectedCall', {'next_step': nextStep.candidValue});

  @override
  Map<String, dynamic> toJson() => {
    'UnexpectedCall': {'next_step': nextStep.toJson()},
  };

  factory NnsInternetIdentityCheckCaptchaErrorUnexpectedCall.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityCheckCaptchaErrorUnexpectedCall(
      nextStep: json.valueTo<NnsInternetIdentityRegistrationFlowNextStep, Map>(
        key: 'next_step',
        parse:
            (e) => NnsInternetIdentityRegistrationFlowNextStep.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }
}

/// Variant arm `CheckCaptchaError.NoRegistrationFlow` (nullary).
final class NnsInternetIdentityCheckCaptchaErrorNoRegistrationFlow
    extends NnsInternetIdentityCheckCaptchaError {
  const NnsInternetIdentityCheckCaptchaErrorNoRegistrationFlow();

  @override
  CType get candidType => NnsInternetIdentityCheckCaptchaError.ctype;

  @override
  dynamic get candidValue => const Variant('NoRegistrationFlow', null);

  @override
  Map<String, dynamic> toJson() => {'NoRegistrationFlow': null};
}

/// Candid record `IdRegFinishArg`.
final class NnsInternetIdentityIdRegFinishArg with CandidSerializable {
  final NnsInternetIdentityAuthnMethodData authnMethod;
  final String? name;

  const NnsInternetIdentityIdRegFinishArg({
    required this.authnMethod,
    this.name,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('authn_method'),
      () => NnsInternetIdentityAuthnMethodData.ctype,
    ),
    Field(Label.named('name'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'authn_method': authnMethod.candidValue,
    'name': name,
  };

  Map<String, dynamic> toJson() => {
    'authn_method': authnMethod.toJson(),
    'name': name,
  };

  factory NnsInternetIdentityIdRegFinishArg.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdRegFinishArg(
      authnMethod: json.valueTo<NnsInternetIdentityAuthnMethodData, Map>(
        key: 'authn_method',
        parse:
            (e) => NnsInternetIdentityAuthnMethodData.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      name: json.valueAsString<String?>('name'),
    );
  }

  factory NnsInternetIdentityIdRegFinishArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdRegFinishArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `IdRegFinishResult`.
final class NnsInternetIdentityIdRegFinishResult with CandidSerializable {
  final BigInt identityNumber;

  const NnsInternetIdentityIdRegFinishResult({required this.identityNumber});

  static CType get ctype =>
      CType.record([Field(Label.named('identity_number'), CType.nat64)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'identity_number': identityNumber};

  Map<String, dynamic> toJson() => {'identity_number': identityNumber};

  factory NnsInternetIdentityIdRegFinishResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdRegFinishResult(
      identityNumber: json.valueAsBigInt<BigInt>('identity_number'),
    );
  }

  factory NnsInternetIdentityIdRegFinishResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdRegFinishResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `IdRegFinishError`.
sealed class NnsInternetIdentityIdRegFinishError with CandidSerializable {
  const NnsInternetIdentityIdRegFinishError();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('UnexpectedCall'),
      () => CType.record([
        LazyField(
          Label.named('next_step'),
          () => NnsInternetIdentityRegistrationFlowNextStep.ctype,
        ),
      ]),
    ),
    Field(Label.named('NoRegistrationFlow'), CType.null_),
    Field(Label.named('InvalidAuthnMethod'), CType.text),
    Field(Label.named('StorageError'), CType.text),
    Field(Label.named('SsoNormalLoginRequired'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdRegFinishError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('UnexpectedCall')) {
      return NnsInternetIdentityIdRegFinishErrorUnexpectedCall.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['UnexpectedCall']),
      );
    }
    if (json.containsKey('NoRegistrationFlow')) {
      return const NnsInternetIdentityIdRegFinishErrorNoRegistrationFlow();
    }
    if (json.containsKey('InvalidAuthnMethod')) {
      return NnsInternetIdentityIdRegFinishErrorInvalidAuthnMethod(
        json.valueAsString<String>('InvalidAuthnMethod'),
      );
    }
    if (json.containsKey('StorageError')) {
      return NnsInternetIdentityIdRegFinishErrorStorageError(
        json.valueAsString<String>('StorageError'),
      );
    }
    if (json.containsKey('SsoNormalLoginRequired')) {
      return const NnsInternetIdentityIdRegFinishErrorSsoNormalLoginRequired();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdRegFinishError.fromCandid',
      reason: 'Unknown NnsInternetIdentityIdRegFinishError arm',
    );
  }

  factory NnsInternetIdentityIdRegFinishError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdRegFinishError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `IdRegFinishError.UnexpectedCall`.
final class NnsInternetIdentityIdRegFinishErrorUnexpectedCall
    extends NnsInternetIdentityIdRegFinishError {
  final NnsInternetIdentityRegistrationFlowNextStep nextStep;

  const NnsInternetIdentityIdRegFinishErrorUnexpectedCall({
    required this.nextStep,
  });

  @override
  CType get candidType => NnsInternetIdentityIdRegFinishError.ctype;

  @override
  dynamic get candidValue =>
      Variant('UnexpectedCall', {'next_step': nextStep.candidValue});

  @override
  Map<String, dynamic> toJson() => {
    'UnexpectedCall': {'next_step': nextStep.toJson()},
  };

  factory NnsInternetIdentityIdRegFinishErrorUnexpectedCall.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdRegFinishErrorUnexpectedCall(
      nextStep: json.valueTo<NnsInternetIdentityRegistrationFlowNextStep, Map>(
        key: 'next_step',
        parse:
            (e) => NnsInternetIdentityRegistrationFlowNextStep.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }
}

/// Variant arm `IdRegFinishError.NoRegistrationFlow` (nullary).
final class NnsInternetIdentityIdRegFinishErrorNoRegistrationFlow
    extends NnsInternetIdentityIdRegFinishError {
  const NnsInternetIdentityIdRegFinishErrorNoRegistrationFlow();

  @override
  CType get candidType => NnsInternetIdentityIdRegFinishError.ctype;

  @override
  dynamic get candidValue => const Variant('NoRegistrationFlow', null);

  @override
  Map<String, dynamic> toJson() => {'NoRegistrationFlow': null};
}

/// Variant arm `IdRegFinishError.InvalidAuthnMethod`.
final class NnsInternetIdentityIdRegFinishErrorInvalidAuthnMethod
    extends NnsInternetIdentityIdRegFinishError {
  final String value;
  const NnsInternetIdentityIdRegFinishErrorInvalidAuthnMethod(this.value);

  @override
  CType get candidType => NnsInternetIdentityIdRegFinishError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidAuthnMethod', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidAuthnMethod': value};
}

/// Variant arm `IdRegFinishError.StorageError`.
final class NnsInternetIdentityIdRegFinishErrorStorageError
    extends NnsInternetIdentityIdRegFinishError {
  final String value;
  const NnsInternetIdentityIdRegFinishErrorStorageError(this.value);

  @override
  CType get candidType => NnsInternetIdentityIdRegFinishError.ctype;

  @override
  dynamic get candidValue => Variant('StorageError', value);

  @override
  Map<String, dynamic> toJson() => {'StorageError': value};
}

/// Variant arm `IdRegFinishError.SsoNormalLoginRequired` (nullary).
final class NnsInternetIdentityIdRegFinishErrorSsoNormalLoginRequired
    extends NnsInternetIdentityIdRegFinishError {
  const NnsInternetIdentityIdRegFinishErrorSsoNormalLoginRequired();

  @override
  CType get candidType => NnsInternetIdentityIdRegFinishError.ctype;

  @override
  dynamic get candidValue => const Variant('SsoNormalLoginRequired', null);

  @override
  Map<String, dynamic> toJson() => {'SsoNormalLoginRequired': null};
}

/// Candid record `AccountInfo`.
final class NnsInternetIdentityAccountInfo with CandidSerializable {
  final NnsInternetIdentityAccountNumber? accountNumber;
  final String origin;
  final NnsInternetIdentityTimestamp? lastUsed;
  final String? name;

  const NnsInternetIdentityAccountInfo({
    this.accountNumber,
    required this.origin,
    this.lastUsed,
    this.name,
  });

  static CType get ctype => CType.record([
    Field(Label.named('account_number'), CType.opt(CType.nat64)),
    Field(Label.named('origin'), CType.text),
    Field(Label.named('last_used'), CType.opt(CType.nat64)),
    Field(Label.named('name'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'account_number': accountNumber,
    'origin': origin,
    'last_used': lastUsed,
    'name': name,
  };

  Map<String, dynamic> toJson() => {
    'account_number': accountNumber,
    'origin': origin,
    'last_used': lastUsed,
    'name': name,
  };

  factory NnsInternetIdentityAccountInfo.fromCandid(Map<String, dynamic> json) {
    return NnsInternetIdentityAccountInfo(
      accountNumber: json.valueAsBigInt<BigInt?>('account_number'),
      origin: json.valueAsString<String>('origin'),
      lastUsed: json.valueAsBigInt<BigInt?>('last_used'),
      name: json.valueAsString<String?>('name'),
    );
  }

  factory NnsInternetIdentityAccountInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAccountInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AccountUpdate`.
final class NnsInternetIdentityAccountUpdate with CandidSerializable {
  final String? name;

  const NnsInternetIdentityAccountUpdate({this.name});

  static CType get ctype =>
      CType.record([Field(Label.named('name'), CType.opt(CType.text))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'name': name};

  Map<String, dynamic> toJson() => {'name': name};

  factory NnsInternetIdentityAccountUpdate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAccountUpdate(
      name: json.valueAsString<String?>('name'),
    );
  }

  factory NnsInternetIdentityAccountUpdate.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAccountUpdate.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DummyAuthConfig`.
final class NnsInternetIdentityDummyAuthConfig with CandidSerializable {
  final bool promptForIndex;

  const NnsInternetIdentityDummyAuthConfig({required this.promptForIndex});

  static CType get ctype =>
      CType.record([Field(Label.named('prompt_for_index'), CType.bool_)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'prompt_for_index': promptForIndex};

  Map<String, dynamic> toJson() => {'prompt_for_index': promptForIndex};

  factory NnsInternetIdentityDummyAuthConfig.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityDummyAuthConfig(
      promptForIndex: json.valueAsBool<bool>('prompt_for_index'),
    );
  }

  factory NnsInternetIdentityDummyAuthConfig.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityDummyAuthConfig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `IdentityPropertiesReplace`.
final class NnsInternetIdentityIdentityPropertiesReplace
    with CandidSerializable {
  final String? name;

  const NnsInternetIdentityIdentityPropertiesReplace({this.name});

  static CType get ctype =>
      CType.record([Field(Label.named('name'), CType.opt(CType.text))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'name': name};

  Map<String, dynamic> toJson() => {'name': name};

  factory NnsInternetIdentityIdentityPropertiesReplace.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdentityPropertiesReplace(
      name: json.valueAsString<String?>('name'),
    );
  }

  factory NnsInternetIdentityIdentityPropertiesReplace.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityPropertiesReplace.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `IdentityPropertiesReplaceError`.
sealed class NnsInternetIdentityIdentityPropertiesReplaceError
    with CandidSerializable {
  const NnsInternetIdentityIdentityPropertiesReplaceError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.principal),
    Field(
      Label.named('StorageSpaceExceeded'),
      CType.record([
        Field(Label.named('space_available'), CType.nat64),
        Field(Label.named('space_required'), CType.nat64),
      ]),
    ),
    Field(
      Label.named('NameTooLong'),
      CType.record([Field(Label.named('limit'), CType.nat64)]),
    ),
    Field(Label.named('InternalCanisterError'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIdentityPropertiesReplaceError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Unauthorized')) {
      return NnsInternetIdentityIdentityPropertiesReplaceErrorUnauthorized(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Unauthorized',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('StorageSpaceExceeded')) {
      return NnsInternetIdentityIdentityPropertiesReplaceErrorStorageSpaceExceeded.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['StorageSpaceExceeded'],
        ),
      );
    }
    if (json.containsKey('NameTooLong')) {
      return NnsInternetIdentityIdentityPropertiesReplaceErrorNameTooLong.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['NameTooLong']),
      );
    }
    if (json.containsKey('InternalCanisterError')) {
      return NnsInternetIdentityIdentityPropertiesReplaceErrorInternalCanisterError(
        json.valueAsString<String>('InternalCanisterError'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIdentityPropertiesReplaceError.fromCandid',
      reason: 'Unknown NnsInternetIdentityIdentityPropertiesReplaceError arm',
    );
  }

  factory NnsInternetIdentityIdentityPropertiesReplaceError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIdentityPropertiesReplaceError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `IdentityPropertiesReplaceError.Unauthorized`.
final class NnsInternetIdentityIdentityPropertiesReplaceErrorUnauthorized
    extends NnsInternetIdentityIdentityPropertiesReplaceError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityIdentityPropertiesReplaceErrorUnauthorized(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityPropertiesReplaceError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value.address};
}

/// Variant arm `IdentityPropertiesReplaceError.StorageSpaceExceeded`.
final class NnsInternetIdentityIdentityPropertiesReplaceErrorStorageSpaceExceeded
    extends NnsInternetIdentityIdentityPropertiesReplaceError {
  final BigInt spaceAvailable;
  final BigInt spaceRequired;

  const NnsInternetIdentityIdentityPropertiesReplaceErrorStorageSpaceExceeded({
    required this.spaceAvailable,
    required this.spaceRequired,
  });

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityPropertiesReplaceError.ctype;

  @override
  dynamic get candidValue => Variant('StorageSpaceExceeded', {
    'space_available': spaceAvailable,
    'space_required': spaceRequired,
  });

  @override
  Map<String, dynamic> toJson() => {
    'StorageSpaceExceeded': {
      'space_available': spaceAvailable,
      'space_required': spaceRequired,
    },
  };

  factory NnsInternetIdentityIdentityPropertiesReplaceErrorStorageSpaceExceeded.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdentityPropertiesReplaceErrorStorageSpaceExceeded(
      spaceAvailable: json.valueAsBigInt<BigInt>('space_available'),
      spaceRequired: json.valueAsBigInt<BigInt>('space_required'),
    );
  }
}

/// Variant arm `IdentityPropertiesReplaceError.NameTooLong`.
final class NnsInternetIdentityIdentityPropertiesReplaceErrorNameTooLong
    extends NnsInternetIdentityIdentityPropertiesReplaceError {
  final BigInt limit;

  const NnsInternetIdentityIdentityPropertiesReplaceErrorNameTooLong({
    required this.limit,
  });

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityPropertiesReplaceError.ctype;

  @override
  dynamic get candidValue => Variant('NameTooLong', {'limit': limit});

  @override
  Map<String, dynamic> toJson() => {
    'NameTooLong': {'limit': limit},
  };

  factory NnsInternetIdentityIdentityPropertiesReplaceErrorNameTooLong.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityIdentityPropertiesReplaceErrorNameTooLong(
      limit: json.valueAsBigInt<BigInt>('limit'),
    );
  }
}

/// Variant arm `IdentityPropertiesReplaceError.InternalCanisterError`.
final class NnsInternetIdentityIdentityPropertiesReplaceErrorInternalCanisterError
    extends NnsInternetIdentityIdentityPropertiesReplaceError {
  final String value;
  const NnsInternetIdentityIdentityPropertiesReplaceErrorInternalCanisterError(
    this.value,
  );

  @override
  CType get candidType =>
      NnsInternetIdentityIdentityPropertiesReplaceError.ctype;

  @override
  dynamic get candidValue => Variant('InternalCanisterError', value);

  @override
  Map<String, dynamic> toJson() => {'InternalCanisterError': value};
}

/// Candid record `PrepareAttributeRequest`.
final class NnsInternetIdentityPrepareAttributeRequest with CandidSerializable {
  final NnsInternetIdentityIdentityNumber identityNumber;
  final NnsInternetIdentityFrontendHostname origin;
  final NnsInternetIdentityAccountNumber? accountNumber;
  final List<String> attributeKeys;

  const NnsInternetIdentityPrepareAttributeRequest({
    required this.identityNumber,
    required this.origin,
    this.accountNumber,
    required this.attributeKeys,
  });

  static CType get ctype => CType.record([
    Field(Label.named('identity_number'), CType.nat64),
    Field(Label.named('origin'), CType.text),
    Field(Label.named('account_number'), CType.opt(CType.nat64)),
    Field(Label.named('attribute_keys'), CType.vec(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'identity_number': identityNumber,
    'origin': origin,
    'account_number': accountNumber,
    'attribute_keys': attributeKeys,
  };

  Map<String, dynamic> toJson() => {
    'identity_number': identityNumber,
    'origin': origin,
    'account_number': accountNumber,
    'attribute_keys': attributeKeys,
  };

  factory NnsInternetIdentityPrepareAttributeRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareAttributeRequest(
      identityNumber: json.valueAsBigInt<BigInt>('identity_number'),
      origin: json.valueAsString<String>('origin'),
      accountNumber: json.valueAsBigInt<BigInt?>('account_number'),
      attributeKeys: json.valueTo<List<String>, List>(
        key: 'attribute_keys',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityPrepareAttributeRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareAttributeRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `GetAccountError`.
sealed class NnsInternetIdentityGetAccountError with CandidSerializable {
  const NnsInternetIdentityGetAccountError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('NoSuchOrigin'),
      CType.record([Field(Label.named('anchor_number'), CType.nat64)]),
    ),
    Field(
      Label.named('NoSuchAccount'),
      CType.record([
        Field(Label.named('anchor_number'), CType.nat64),
        Field(Label.named('origin'), CType.text),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetAccountError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('NoSuchOrigin')) {
      return NnsInternetIdentityGetAccountErrorNoSuchOrigin.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['NoSuchOrigin']),
      );
    }
    if (json.containsKey('NoSuchAccount')) {
      return NnsInternetIdentityGetAccountErrorNoSuchAccount.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['NoSuchAccount']),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetAccountError.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetAccountError arm',
    );
  }

  factory NnsInternetIdentityGetAccountError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetAccountError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetAccountError.NoSuchOrigin`.
final class NnsInternetIdentityGetAccountErrorNoSuchOrigin
    extends NnsInternetIdentityGetAccountError {
  final NnsInternetIdentityUserNumber anchorNumber;

  const NnsInternetIdentityGetAccountErrorNoSuchOrigin({
    required this.anchorNumber,
  });

  @override
  CType get candidType => NnsInternetIdentityGetAccountError.ctype;

  @override
  dynamic get candidValue =>
      Variant('NoSuchOrigin', {'anchor_number': anchorNumber});

  @override
  Map<String, dynamic> toJson() => {
    'NoSuchOrigin': {'anchor_number': anchorNumber},
  };

  factory NnsInternetIdentityGetAccountErrorNoSuchOrigin.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityGetAccountErrorNoSuchOrigin(
      anchorNumber: json.valueAsBigInt<BigInt>('anchor_number'),
    );
  }
}

/// Variant arm `GetAccountError.NoSuchAccount`.
final class NnsInternetIdentityGetAccountErrorNoSuchAccount
    extends NnsInternetIdentityGetAccountError {
  final NnsInternetIdentityUserNumber anchorNumber;
  final NnsInternetIdentityFrontendHostname origin;

  const NnsInternetIdentityGetAccountErrorNoSuchAccount({
    required this.anchorNumber,
    required this.origin,
  });

  @override
  CType get candidType => NnsInternetIdentityGetAccountError.ctype;

  @override
  dynamic get candidValue => Variant('NoSuchAccount', {
    'anchor_number': anchorNumber,
    'origin': origin,
  });

  @override
  Map<String, dynamic> toJson() => {
    'NoSuchAccount': {'anchor_number': anchorNumber, 'origin': origin},
  };

  factory NnsInternetIdentityGetAccountErrorNoSuchAccount.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityGetAccountErrorNoSuchAccount(
      anchorNumber: json.valueAsBigInt<BigInt>('anchor_number'),
      origin: json.valueAsString<String>('origin'),
    );
  }
}

/// Candid variant `PrepareAttributeError`.
sealed class NnsInternetIdentityPrepareAttributeError with CandidSerializable {
  const NnsInternetIdentityPrepareAttributeError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('ValidationError'),
      CType.record([Field(Label.named('problems'), CType.vec(CType.text))]),
    ),
    Field(Label.named('AuthorizationError'), CType.principal),
    LazyField(
      Label.named('GetAccountError'),
      () => NnsInternetIdentityGetAccountError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPrepareAttributeError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('ValidationError')) {
      return NnsInternetIdentityPrepareAttributeErrorValidationError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['ValidationError']),
      );
    }
    if (json.containsKey('AuthorizationError')) {
      return NnsInternetIdentityPrepareAttributeErrorAuthorizationError(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'AuthorizationError',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('GetAccountError')) {
      return NnsInternetIdentityPrepareAttributeErrorGetAccountError(
        json.valueTo<NnsInternetIdentityGetAccountError, Map>(
          key: 'GetAccountError',
          parse:
              (e) => NnsInternetIdentityGetAccountError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPrepareAttributeError.fromCandid',
      reason: 'Unknown NnsInternetIdentityPrepareAttributeError arm',
    );
  }

  factory NnsInternetIdentityPrepareAttributeError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareAttributeError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `PrepareAttributeError.ValidationError`.
final class NnsInternetIdentityPrepareAttributeErrorValidationError
    extends NnsInternetIdentityPrepareAttributeError {
  final List<String> problems;

  const NnsInternetIdentityPrepareAttributeErrorValidationError({
    required this.problems,
  });

  @override
  CType get candidType => NnsInternetIdentityPrepareAttributeError.ctype;

  @override
  dynamic get candidValue => Variant('ValidationError', {'problems': problems});

  @override
  Map<String, dynamic> toJson() => {
    'ValidationError': {'problems': problems},
  };

  factory NnsInternetIdentityPrepareAttributeErrorValidationError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareAttributeErrorValidationError(
      problems: json.valueTo<List<String>, List>(
        key: 'problems',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
    );
  }
}

/// Variant arm `PrepareAttributeError.AuthorizationError`.
final class NnsInternetIdentityPrepareAttributeErrorAuthorizationError
    extends NnsInternetIdentityPrepareAttributeError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityPrepareAttributeErrorAuthorizationError(this.value);

  @override
  CType get candidType => NnsInternetIdentityPrepareAttributeError.ctype;

  @override
  dynamic get candidValue => Variant('AuthorizationError', value);

  @override
  Map<String, dynamic> toJson() => {'AuthorizationError': value.address};
}

/// Variant arm `PrepareAttributeError.GetAccountError`.
final class NnsInternetIdentityPrepareAttributeErrorGetAccountError
    extends NnsInternetIdentityPrepareAttributeError {
  final NnsInternetIdentityGetAccountError value;
  const NnsInternetIdentityPrepareAttributeErrorGetAccountError(this.value);

  @override
  CType get candidType => NnsInternetIdentityPrepareAttributeError.ctype;

  @override
  dynamic get candidValue => Variant('GetAccountError', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'GetAccountError': value.toJson()};
}

/// Candid record `PrepareAttributeResponse`.
final class NnsInternetIdentityPrepareAttributeResponse
    with CandidSerializable {
  final NnsInternetIdentityTimestamp issuedAtTimestampNs;
  final List<NnsInternetIdentityPrepareAttributeResponseAttributes> attributes;

  const NnsInternetIdentityPrepareAttributeResponse({
    required this.issuedAtTimestampNs,
    required this.attributes,
  });

  static CType get ctype => CType.record([
    Field(Label.named('issued_at_timestamp_ns'), CType.nat64),
    LazyField(
      Label.named('attributes'),
      () => CType.vec(
        NnsInternetIdentityPrepareAttributeResponseAttributes.ctype,
      ),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'issued_at_timestamp_ns': issuedAtTimestampNs,
    'attributes': attributes.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'issued_at_timestamp_ns': issuedAtTimestampNs,
    'attributes': attributes.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityPrepareAttributeResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareAttributeResponse(
      issuedAtTimestampNs: json.valueAsBigInt<BigInt>('issued_at_timestamp_ns'),
      attributes: json.valueTo<
        List<NnsInternetIdentityPrepareAttributeResponseAttributes>,
        List
      >(
        key: 'attributes',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityPrepareAttributeResponseAttributes>(
                      (x) =>
                          NnsInternetIdentityPrepareAttributeResponseAttributes.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityPrepareAttributeResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareAttributeResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetAttributesRequest`.
final class NnsInternetIdentityGetAttributesRequest with CandidSerializable {
  final NnsInternetIdentityIdentityNumber identityNumber;
  final NnsInternetIdentityFrontendHostname origin;
  final NnsInternetIdentityAccountNumber? accountNumber;
  final NnsInternetIdentityTimestamp issuedAtTimestampNs;
  final List<NnsInternetIdentityPrepareAttributeResponseAttributes> attributes;

  const NnsInternetIdentityGetAttributesRequest({
    required this.identityNumber,
    required this.origin,
    this.accountNumber,
    required this.issuedAtTimestampNs,
    required this.attributes,
  });

  static CType get ctype => CType.record([
    Field(Label.named('identity_number'), CType.nat64),
    Field(Label.named('origin'), CType.text),
    Field(Label.named('account_number'), CType.opt(CType.nat64)),
    Field(Label.named('issued_at_timestamp_ns'), CType.nat64),
    LazyField(
      Label.named('attributes'),
      () => CType.vec(
        NnsInternetIdentityPrepareAttributeResponseAttributes.ctype,
      ),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'identity_number': identityNumber,
    'origin': origin,
    'account_number': accountNumber,
    'issued_at_timestamp_ns': issuedAtTimestampNs,
    'attributes': attributes.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'identity_number': identityNumber,
    'origin': origin,
    'account_number': accountNumber,
    'issued_at_timestamp_ns': issuedAtTimestampNs,
    'attributes': attributes.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityGetAttributesRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityGetAttributesRequest(
      identityNumber: json.valueAsBigInt<BigInt>('identity_number'),
      origin: json.valueAsString<String>('origin'),
      accountNumber: json.valueAsBigInt<BigInt?>('account_number'),
      issuedAtTimestampNs: json.valueAsBigInt<BigInt>('issued_at_timestamp_ns'),
      attributes: json.valueTo<
        List<NnsInternetIdentityPrepareAttributeResponseAttributes>,
        List
      >(
        key: 'attributes',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityPrepareAttributeResponseAttributes>(
                      (x) =>
                          NnsInternetIdentityPrepareAttributeResponseAttributes.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityGetAttributesRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetAttributesRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CertifiedAttribute`.
final class NnsInternetIdentityCertifiedAttribute with CandidSerializable {
  final String key;
  final List<int> value;
  final List<int> signature;

  const NnsInternetIdentityCertifiedAttribute({
    required this.key,
    required this.value,
    required this.signature,
  });

  static CType get ctype => CType.record([
    Field(Label.named('key'), CType.text),
    Field(Label.named('value'), CType.vec(CType.nat8)),
    Field(Label.named('signature'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'key': key,
    'value': value,
    'signature': signature,
  };

  Map<String, dynamic> toJson() => {
    'key': key,
    'value': value,
    'signature': signature,
  };

  factory NnsInternetIdentityCertifiedAttribute.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityCertifiedAttribute(
      key: json.valueAsString<String>('key'),
      value: json.valueAsBytes<List<int>>(
        'value',
        encoding: StringEncoding.base64,
      ),
      signature: json.valueAsBytes<List<int>>(
        'signature',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityCertifiedAttribute.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityCertifiedAttribute.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CertifiedAttributes`.
final class NnsInternetIdentityCertifiedAttributes with CandidSerializable {
  final NnsInternetIdentityTimestamp expiresAtTimestampNs;
  final List<NnsInternetIdentityCertifiedAttribute> certifiedAttributes;

  const NnsInternetIdentityCertifiedAttributes({
    required this.expiresAtTimestampNs,
    required this.certifiedAttributes,
  });

  static CType get ctype => CType.record([
    Field(Label.named('expires_at_timestamp_ns'), CType.nat64),
    LazyField(
      Label.named('certified_attributes'),
      () => CType.vec(NnsInternetIdentityCertifiedAttribute.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'expires_at_timestamp_ns': expiresAtTimestampNs,
    'certified_attributes':
        certifiedAttributes.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'expires_at_timestamp_ns': expiresAtTimestampNs,
    'certified_attributes':
        certifiedAttributes.map((el) => el.toJson()).toList(),
  };

  factory NnsInternetIdentityCertifiedAttributes.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityCertifiedAttributes(
      expiresAtTimestampNs: json.valueAsBigInt<BigInt>(
        'expires_at_timestamp_ns',
      ),
      certifiedAttributes: json
          .valueTo<List<NnsInternetIdentityCertifiedAttribute>, List>(
            key: 'certified_attributes',
            parse:
                (e) =>
                    e
                        .map<NnsInternetIdentityCertifiedAttribute>(
                          (x) =>
                              NnsInternetIdentityCertifiedAttribute.fromCandid(
                                JsonParser.valueEnsureAsMap<String, dynamic>(x),
                              ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsInternetIdentityCertifiedAttributes.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityCertifiedAttributes.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `GetAttributesError`.
sealed class NnsInternetIdentityGetAttributesError with CandidSerializable {
  const NnsInternetIdentityGetAttributesError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('ValidationError'),
      CType.record([Field(Label.named('problems'), CType.vec(CType.text))]),
    ),
    Field(Label.named('AuthorizationError'), CType.principal),
    LazyField(
      Label.named('GetAccountError'),
      () => NnsInternetIdentityGetAccountError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetAttributesError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('ValidationError')) {
      return NnsInternetIdentityGetAttributesErrorValidationError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['ValidationError']),
      );
    }
    if (json.containsKey('AuthorizationError')) {
      return NnsInternetIdentityGetAttributesErrorAuthorizationError(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'AuthorizationError',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('GetAccountError')) {
      return NnsInternetIdentityGetAttributesErrorGetAccountError(
        json.valueTo<NnsInternetIdentityGetAccountError, Map>(
          key: 'GetAccountError',
          parse:
              (e) => NnsInternetIdentityGetAccountError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetAttributesError.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetAttributesError arm',
    );
  }

  factory NnsInternetIdentityGetAttributesError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetAttributesError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetAttributesError.ValidationError`.
final class NnsInternetIdentityGetAttributesErrorValidationError
    extends NnsInternetIdentityGetAttributesError {
  final List<String> problems;

  const NnsInternetIdentityGetAttributesErrorValidationError({
    required this.problems,
  });

  @override
  CType get candidType => NnsInternetIdentityGetAttributesError.ctype;

  @override
  dynamic get candidValue => Variant('ValidationError', {'problems': problems});

  @override
  Map<String, dynamic> toJson() => {
    'ValidationError': {'problems': problems},
  };

  factory NnsInternetIdentityGetAttributesErrorValidationError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityGetAttributesErrorValidationError(
      problems: json.valueTo<List<String>, List>(
        key: 'problems',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
    );
  }
}

/// Variant arm `GetAttributesError.AuthorizationError`.
final class NnsInternetIdentityGetAttributesErrorAuthorizationError
    extends NnsInternetIdentityGetAttributesError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityGetAttributesErrorAuthorizationError(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetAttributesError.ctype;

  @override
  dynamic get candidValue => Variant('AuthorizationError', value);

  @override
  Map<String, dynamic> toJson() => {'AuthorizationError': value.address};
}

/// Variant arm `GetAttributesError.GetAccountError`.
final class NnsInternetIdentityGetAttributesErrorGetAccountError
    extends NnsInternetIdentityGetAttributesError {
  final NnsInternetIdentityGetAccountError value;
  const NnsInternetIdentityGetAttributesErrorGetAccountError(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetAttributesError.ctype;

  @override
  dynamic get candidValue => Variant('GetAccountError', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'GetAccountError': value.toJson()};
}

/// Candid variant `Icrc3Value`.
sealed class NnsInternetIdentityIcrc3Value with CandidSerializable {
  const NnsInternetIdentityIcrc3Value();

  static CType get ctype => CType.variant([
    Field(Label.named('Nat'), CType.nat),
    Field(Label.named('Int'), CType.int_),
    Field(Label.named('Blob'), CType.vec(CType.nat8)),
    Field(Label.named('Text'), CType.text),
    LazyField(
      Label.named('Array'),
      () => CType.vec(NnsInternetIdentityIcrc3Value.ctype),
    ),
    LazyField(
      Label.named('Map'),
      () => CType.vec(NnsInternetIdentityIcrc3ValueMap.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityIcrc3Value.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Nat')) {
      return NnsInternetIdentityIcrc3ValueNat(
        json.valueAsBigInt<BigInt>('Nat'),
      );
    }
    if (json.containsKey('Int')) {
      return NnsInternetIdentityIcrc3ValueInt(
        json.valueAsBigInt<BigInt>('Int'),
      );
    }
    if (json.containsKey('Blob')) {
      return NnsInternetIdentityIcrc3ValueBlob(
        json.valueAsBytes<List<int>>('Blob', encoding: StringEncoding.base64),
      );
    }
    if (json.containsKey('Text')) {
      return NnsInternetIdentityIcrc3ValueText(
        json.valueAsString<String>('Text'),
      );
    }
    if (json.containsKey('Array')) {
      return NnsInternetIdentityIcrc3ValueArray(
        json.valueTo<List<NnsInternetIdentityIcrc3Value>, List>(
          key: 'Array',
          parse:
              (e) =>
                  e
                      .map<NnsInternetIdentityIcrc3Value>(
                        (x) => NnsInternetIdentityIcrc3Value.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('Map')) {
      return NnsInternetIdentityIcrc3ValueMap2(
        json.valueTo<List<NnsInternetIdentityIcrc3ValueMap>, List>(
          key: 'Map',
          parse:
              (e) =>
                  e
                      .map<NnsInternetIdentityIcrc3ValueMap>(
                        (x) => NnsInternetIdentityIcrc3ValueMap.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityIcrc3Value.fromCandid',
      reason: 'Unknown NnsInternetIdentityIcrc3Value arm',
    );
  }

  factory NnsInternetIdentityIcrc3Value.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityIcrc3Value.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Icrc3Value.Nat`.
final class NnsInternetIdentityIcrc3ValueNat
    extends NnsInternetIdentityIcrc3Value {
  final BigInt value;
  const NnsInternetIdentityIcrc3ValueNat(this.value);

  @override
  CType get candidType => NnsInternetIdentityIcrc3Value.ctype;

  @override
  dynamic get candidValue => Variant('Nat', value);

  @override
  Map<String, dynamic> toJson() => {'Nat': value};
}

/// Variant arm `Icrc3Value.Int`.
final class NnsInternetIdentityIcrc3ValueInt
    extends NnsInternetIdentityIcrc3Value {
  final BigInt value;
  const NnsInternetIdentityIcrc3ValueInt(this.value);

  @override
  CType get candidType => NnsInternetIdentityIcrc3Value.ctype;

  @override
  dynamic get candidValue => Variant('Int', value);

  @override
  Map<String, dynamic> toJson() => {'Int': value};
}

/// Variant arm `Icrc3Value.Blob`.
final class NnsInternetIdentityIcrc3ValueBlob
    extends NnsInternetIdentityIcrc3Value {
  final List<int> value;
  const NnsInternetIdentityIcrc3ValueBlob(this.value);

  @override
  CType get candidType => NnsInternetIdentityIcrc3Value.ctype;

  @override
  dynamic get candidValue => Variant('Blob', value);

  @override
  Map<String, dynamic> toJson() => {'Blob': value};
}

/// Variant arm `Icrc3Value.Text`.
final class NnsInternetIdentityIcrc3ValueText
    extends NnsInternetIdentityIcrc3Value {
  final String value;
  const NnsInternetIdentityIcrc3ValueText(this.value);

  @override
  CType get candidType => NnsInternetIdentityIcrc3Value.ctype;

  @override
  dynamic get candidValue => Variant('Text', value);

  @override
  Map<String, dynamic> toJson() => {'Text': value};
}

/// Variant arm `Icrc3Value.Array`.
final class NnsInternetIdentityIcrc3ValueArray
    extends NnsInternetIdentityIcrc3Value {
  final List<NnsInternetIdentityIcrc3Value> value;
  const NnsInternetIdentityIcrc3ValueArray(this.value);

  @override
  CType get candidType => NnsInternetIdentityIcrc3Value.ctype;

  @override
  dynamic get candidValue =>
      Variant('Array', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Array': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `Icrc3Value.Map`.
final class NnsInternetIdentityIcrc3ValueMap2
    extends NnsInternetIdentityIcrc3Value {
  final List<NnsInternetIdentityIcrc3ValueMap> value;
  const NnsInternetIdentityIcrc3ValueMap2(this.value);

  @override
  CType get candidType => NnsInternetIdentityIcrc3Value.ctype;

  @override
  dynamic get candidValue =>
      Variant('Map', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Map': value.map((el) => el.toJson()).toList(),
  };
}

/// Candid record `AttributeSpec`.
final class NnsInternetIdentityAttributeSpec with CandidSerializable {
  final String key;
  final List<int>? value;
  final bool omitScope;

  const NnsInternetIdentityAttributeSpec({
    required this.key,
    this.value,
    required this.omitScope,
  });

  static CType get ctype => CType.record([
    Field(Label.named('key'), CType.text),
    Field(Label.named('value'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('omit_scope'), CType.bool_),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'key': key,
    'value': value,
    'omit_scope': omitScope,
  };

  Map<String, dynamic> toJson() => {
    'key': key,
    'value': value,
    'omit_scope': omitScope,
  };

  factory NnsInternetIdentityAttributeSpec.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityAttributeSpec(
      key: json.valueAsString<String>('key'),
      value: json.valueAsBytes<List<int>?>(
        'value',
        encoding: StringEncoding.base64,
      ),
      omitScope: json.valueAsBool<bool>('omit_scope'),
    );
  }

  factory NnsInternetIdentityAttributeSpec.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityAttributeSpec.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `PrepareIcrc3AttributeRequest`.
final class NnsInternetIdentityPrepareIcrc3AttributeRequest
    with CandidSerializable {
  final NnsInternetIdentityIdentityNumber identityNumber;
  final NnsInternetIdentityFrontendHostname origin;
  final NnsInternetIdentityFrontendHostname? unmappedOrigin;
  final NnsInternetIdentityAccountNumber? accountNumber;
  final List<NnsInternetIdentityAttributeSpec> attributes;
  final List<int> nonce;

  const NnsInternetIdentityPrepareIcrc3AttributeRequest({
    required this.identityNumber,
    required this.origin,
    this.unmappedOrigin,
    this.accountNumber,
    required this.attributes,
    required this.nonce,
  });

  static CType get ctype => CType.record([
    Field(Label.named('identity_number'), CType.nat64),
    Field(Label.named('origin'), CType.text),
    Field(Label.named('unmapped_origin'), CType.opt(CType.text)),
    Field(Label.named('account_number'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('attributes'),
      () => CType.vec(NnsInternetIdentityAttributeSpec.ctype),
    ),
    Field(Label.named('nonce'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'identity_number': identityNumber,
    'origin': origin,
    'unmapped_origin': unmappedOrigin,
    'account_number': accountNumber,
    'attributes': attributes.map((el) => el.candidValue).toList(),
    'nonce': nonce,
  };

  Map<String, dynamic> toJson() => {
    'identity_number': identityNumber,
    'origin': origin,
    'unmapped_origin': unmappedOrigin,
    'account_number': accountNumber,
    'attributes': attributes.map((el) => el.toJson()).toList(),
    'nonce': nonce,
  };

  factory NnsInternetIdentityPrepareIcrc3AttributeRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareIcrc3AttributeRequest(
      identityNumber: json.valueAsBigInt<BigInt>('identity_number'),
      origin: json.valueAsString<String>('origin'),
      unmappedOrigin: json.valueAsString<String?>('unmapped_origin'),
      accountNumber: json.valueAsBigInt<BigInt?>('account_number'),
      attributes: json.valueTo<List<NnsInternetIdentityAttributeSpec>, List>(
        key: 'attributes',
        parse:
            (e) =>
                e
                    .map<NnsInternetIdentityAttributeSpec>(
                      (x) => NnsInternetIdentityAttributeSpec.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      nonce: json.valueAsBytes<List<int>>(
        'nonce',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityPrepareIcrc3AttributeRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareIcrc3AttributeRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `PrepareIcrc3AttributeResponse`.
final class NnsInternetIdentityPrepareIcrc3AttributeResponse
    with CandidSerializable {
  final List<int> message;

  const NnsInternetIdentityPrepareIcrc3AttributeResponse({
    required this.message,
  });

  static CType get ctype =>
      CType.record([Field(Label.named('message'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'message': message};

  Map<String, dynamic> toJson() => {'message': message};

  factory NnsInternetIdentityPrepareIcrc3AttributeResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareIcrc3AttributeResponse(
      message: json.valueAsBytes<List<int>>(
        'message',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityPrepareIcrc3AttributeResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareIcrc3AttributeResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `PrepareIcrc3AttributeError`.
sealed class NnsInternetIdentityPrepareIcrc3AttributeError
    with CandidSerializable {
  const NnsInternetIdentityPrepareIcrc3AttributeError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('ValidationError'),
      CType.record([Field(Label.named('problems'), CType.vec(CType.text))]),
    ),
    Field(Label.named('AuthorizationError'), CType.principal),
    LazyField(
      Label.named('GetAccountError'),
      () => NnsInternetIdentityGetAccountError.ctype,
    ),
    Field(
      Label.named('AttributeMismatch'),
      CType.record([Field(Label.named('problems'), CType.vec(CType.text))]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityPrepareIcrc3AttributeError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('ValidationError')) {
      return NnsInternetIdentityPrepareIcrc3AttributeErrorValidationError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['ValidationError']),
      );
    }
    if (json.containsKey('AuthorizationError')) {
      return NnsInternetIdentityPrepareIcrc3AttributeErrorAuthorizationError(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'AuthorizationError',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('GetAccountError')) {
      return NnsInternetIdentityPrepareIcrc3AttributeErrorGetAccountError(
        json.valueTo<NnsInternetIdentityGetAccountError, Map>(
          key: 'GetAccountError',
          parse:
              (e) => NnsInternetIdentityGetAccountError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('AttributeMismatch')) {
      return NnsInternetIdentityPrepareIcrc3AttributeErrorAttributeMismatch.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['AttributeMismatch']),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityPrepareIcrc3AttributeError.fromCandid',
      reason: 'Unknown NnsInternetIdentityPrepareIcrc3AttributeError arm',
    );
  }

  factory NnsInternetIdentityPrepareIcrc3AttributeError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityPrepareIcrc3AttributeError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `PrepareIcrc3AttributeError.ValidationError`.
final class NnsInternetIdentityPrepareIcrc3AttributeErrorValidationError
    extends NnsInternetIdentityPrepareIcrc3AttributeError {
  final List<String> problems;

  const NnsInternetIdentityPrepareIcrc3AttributeErrorValidationError({
    required this.problems,
  });

  @override
  CType get candidType => NnsInternetIdentityPrepareIcrc3AttributeError.ctype;

  @override
  dynamic get candidValue => Variant('ValidationError', {'problems': problems});

  @override
  Map<String, dynamic> toJson() => {
    'ValidationError': {'problems': problems},
  };

  factory NnsInternetIdentityPrepareIcrc3AttributeErrorValidationError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareIcrc3AttributeErrorValidationError(
      problems: json.valueTo<List<String>, List>(
        key: 'problems',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
    );
  }
}

/// Variant arm `PrepareIcrc3AttributeError.AuthorizationError`.
final class NnsInternetIdentityPrepareIcrc3AttributeErrorAuthorizationError
    extends NnsInternetIdentityPrepareIcrc3AttributeError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityPrepareIcrc3AttributeErrorAuthorizationError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityPrepareIcrc3AttributeError.ctype;

  @override
  dynamic get candidValue => Variant('AuthorizationError', value);

  @override
  Map<String, dynamic> toJson() => {'AuthorizationError': value.address};
}

/// Variant arm `PrepareIcrc3AttributeError.GetAccountError`.
final class NnsInternetIdentityPrepareIcrc3AttributeErrorGetAccountError
    extends NnsInternetIdentityPrepareIcrc3AttributeError {
  final NnsInternetIdentityGetAccountError value;
  const NnsInternetIdentityPrepareIcrc3AttributeErrorGetAccountError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityPrepareIcrc3AttributeError.ctype;

  @override
  dynamic get candidValue => Variant('GetAccountError', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'GetAccountError': value.toJson()};
}

/// Variant arm `PrepareIcrc3AttributeError.AttributeMismatch`.
final class NnsInternetIdentityPrepareIcrc3AttributeErrorAttributeMismatch
    extends NnsInternetIdentityPrepareIcrc3AttributeError {
  final List<String> problems;

  const NnsInternetIdentityPrepareIcrc3AttributeErrorAttributeMismatch({
    required this.problems,
  });

  @override
  CType get candidType => NnsInternetIdentityPrepareIcrc3AttributeError.ctype;

  @override
  dynamic get candidValue =>
      Variant('AttributeMismatch', {'problems': problems});

  @override
  Map<String, dynamic> toJson() => {
    'AttributeMismatch': {'problems': problems},
  };

  factory NnsInternetIdentityPrepareIcrc3AttributeErrorAttributeMismatch.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityPrepareIcrc3AttributeErrorAttributeMismatch(
      problems: json.valueTo<List<String>, List>(
        key: 'problems',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
    );
  }
}

/// Candid record `GetIcrc3AttributeRequest`.
final class NnsInternetIdentityGetIcrc3AttributeRequest
    with CandidSerializable {
  final NnsInternetIdentityIdentityNumber identityNumber;
  final NnsInternetIdentityFrontendHostname origin;
  final NnsInternetIdentityAccountNumber? accountNumber;
  final List<int> message;

  const NnsInternetIdentityGetIcrc3AttributeRequest({
    required this.identityNumber,
    required this.origin,
    this.accountNumber,
    required this.message,
  });

  static CType get ctype => CType.record([
    Field(Label.named('identity_number'), CType.nat64),
    Field(Label.named('origin'), CType.text),
    Field(Label.named('account_number'), CType.opt(CType.nat64)),
    Field(Label.named('message'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'identity_number': identityNumber,
    'origin': origin,
    'account_number': accountNumber,
    'message': message,
  };

  Map<String, dynamic> toJson() => {
    'identity_number': identityNumber,
    'origin': origin,
    'account_number': accountNumber,
    'message': message,
  };

  factory NnsInternetIdentityGetIcrc3AttributeRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityGetIcrc3AttributeRequest(
      identityNumber: json.valueAsBigInt<BigInt>('identity_number'),
      origin: json.valueAsString<String>('origin'),
      accountNumber: json.valueAsBigInt<BigInt?>('account_number'),
      message: json.valueAsBytes<List<int>>(
        'message',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityGetIcrc3AttributeRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetIcrc3AttributeRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetIcrc3AttributeResponse`.
final class NnsInternetIdentityGetIcrc3AttributeResponse
    with CandidSerializable {
  final List<int> signature;

  const NnsInternetIdentityGetIcrc3AttributeResponse({required this.signature});

  static CType get ctype =>
      CType.record([Field(Label.named('signature'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'signature': signature};

  Map<String, dynamic> toJson() => {'signature': signature};

  factory NnsInternetIdentityGetIcrc3AttributeResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityGetIcrc3AttributeResponse(
      signature: json.valueAsBytes<List<int>>(
        'signature',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsInternetIdentityGetIcrc3AttributeResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetIcrc3AttributeResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `GetIcrc3AttributeError`.
sealed class NnsInternetIdentityGetIcrc3AttributeError with CandidSerializable {
  const NnsInternetIdentityGetIcrc3AttributeError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('ValidationError'),
      CType.record([Field(Label.named('problems'), CType.vec(CType.text))]),
    ),
    Field(Label.named('AuthorizationError'), CType.principal),
    LazyField(
      Label.named('GetAccountError'),
      () => NnsInternetIdentityGetAccountError.ctype,
    ),
    Field(Label.named('NoSuchSignature'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityGetIcrc3AttributeError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('ValidationError')) {
      return NnsInternetIdentityGetIcrc3AttributeErrorValidationError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['ValidationError']),
      );
    }
    if (json.containsKey('AuthorizationError')) {
      return NnsInternetIdentityGetIcrc3AttributeErrorAuthorizationError(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'AuthorizationError',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('GetAccountError')) {
      return NnsInternetIdentityGetIcrc3AttributeErrorGetAccountError(
        json.valueTo<NnsInternetIdentityGetAccountError, Map>(
          key: 'GetAccountError',
          parse:
              (e) => NnsInternetIdentityGetAccountError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('NoSuchSignature')) {
      return const NnsInternetIdentityGetIcrc3AttributeErrorNoSuchSignature();
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityGetIcrc3AttributeError.fromCandid',
      reason: 'Unknown NnsInternetIdentityGetIcrc3AttributeError arm',
    );
  }

  factory NnsInternetIdentityGetIcrc3AttributeError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityGetIcrc3AttributeError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetIcrc3AttributeError.ValidationError`.
final class NnsInternetIdentityGetIcrc3AttributeErrorValidationError
    extends NnsInternetIdentityGetIcrc3AttributeError {
  final List<String> problems;

  const NnsInternetIdentityGetIcrc3AttributeErrorValidationError({
    required this.problems,
  });

  @override
  CType get candidType => NnsInternetIdentityGetIcrc3AttributeError.ctype;

  @override
  dynamic get candidValue => Variant('ValidationError', {'problems': problems});

  @override
  Map<String, dynamic> toJson() => {
    'ValidationError': {'problems': problems},
  };

  factory NnsInternetIdentityGetIcrc3AttributeErrorValidationError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityGetIcrc3AttributeErrorValidationError(
      problems: json.valueTo<List<String>, List>(
        key: 'problems',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
    );
  }
}

/// Variant arm `GetIcrc3AttributeError.AuthorizationError`.
final class NnsInternetIdentityGetIcrc3AttributeErrorAuthorizationError
    extends NnsInternetIdentityGetIcrc3AttributeError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityGetIcrc3AttributeErrorAuthorizationError(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetIcrc3AttributeError.ctype;

  @override
  dynamic get candidValue => Variant('AuthorizationError', value);

  @override
  Map<String, dynamic> toJson() => {'AuthorizationError': value.address};
}

/// Variant arm `GetIcrc3AttributeError.GetAccountError`.
final class NnsInternetIdentityGetIcrc3AttributeErrorGetAccountError
    extends NnsInternetIdentityGetIcrc3AttributeError {
  final NnsInternetIdentityGetAccountError value;
  const NnsInternetIdentityGetIcrc3AttributeErrorGetAccountError(this.value);

  @override
  CType get candidType => NnsInternetIdentityGetIcrc3AttributeError.ctype;

  @override
  dynamic get candidValue => Variant('GetAccountError', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'GetAccountError': value.toJson()};
}

/// Variant arm `GetIcrc3AttributeError.NoSuchSignature` (nullary).
final class NnsInternetIdentityGetIcrc3AttributeErrorNoSuchSignature
    extends NnsInternetIdentityGetIcrc3AttributeError {
  const NnsInternetIdentityGetIcrc3AttributeErrorNoSuchSignature();

  @override
  CType get candidType => NnsInternetIdentityGetIcrc3AttributeError.ctype;

  @override
  dynamic get candidValue => const Variant('NoSuchSignature', null);

  @override
  Map<String, dynamic> toJson() => {'NoSuchSignature': null};
}

/// Candid record `ListAvailableAttributesRequest`.
final class NnsInternetIdentityListAvailableAttributesRequest
    with CandidSerializable {
  final NnsInternetIdentityIdentityNumber identityNumber;
  final List<String>? attributes;

  const NnsInternetIdentityListAvailableAttributesRequest({
    required this.identityNumber,
    this.attributes,
  });

  static CType get ctype => CType.record([
    Field(Label.named('identity_number'), CType.nat64),
    Field(Label.named('attributes'), CType.opt(CType.vec(CType.text))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'identity_number': identityNumber,
    'attributes': attributes,
  };

  Map<String, dynamic> toJson() => {
    'identity_number': identityNumber,
    'attributes': attributes,
  };

  factory NnsInternetIdentityListAvailableAttributesRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityListAvailableAttributesRequest(
      identityNumber: json.valueAsBigInt<BigInt>('identity_number'),
      attributes: json.valueTo<List<String>?, List>(
        key: 'attributes',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
    );
  }

  factory NnsInternetIdentityListAvailableAttributesRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityListAvailableAttributesRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ListAvailableAttributesError`.
sealed class NnsInternetIdentityListAvailableAttributesError
    with CandidSerializable {
  const NnsInternetIdentityListAvailableAttributesError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('ValidationError'),
      CType.record([Field(Label.named('problems'), CType.vec(CType.text))]),
    ),
    Field(Label.named('AuthorizationError'), CType.principal),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsInternetIdentityListAvailableAttributesError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('ValidationError')) {
      return NnsInternetIdentityListAvailableAttributesErrorValidationError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['ValidationError']),
      );
    }
    if (json.containsKey('AuthorizationError')) {
      return NnsInternetIdentityListAvailableAttributesErrorAuthorizationError(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'AuthorizationError',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsInternetIdentityListAvailableAttributesError.fromCandid',
      reason: 'Unknown NnsInternetIdentityListAvailableAttributesError arm',
    );
  }

  factory NnsInternetIdentityListAvailableAttributesError.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsInternetIdentityListAvailableAttributesError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ListAvailableAttributesError.ValidationError`.
final class NnsInternetIdentityListAvailableAttributesErrorValidationError
    extends NnsInternetIdentityListAvailableAttributesError {
  final List<String> problems;

  const NnsInternetIdentityListAvailableAttributesErrorValidationError({
    required this.problems,
  });

  @override
  CType get candidType => NnsInternetIdentityListAvailableAttributesError.ctype;

  @override
  dynamic get candidValue => Variant('ValidationError', {'problems': problems});

  @override
  Map<String, dynamic> toJson() => {
    'ValidationError': {'problems': problems},
  };

  factory NnsInternetIdentityListAvailableAttributesErrorValidationError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsInternetIdentityListAvailableAttributesErrorValidationError(
      problems: json.valueTo<List<String>, List>(
        key: 'problems',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
    );
  }
}

/// Variant arm `ListAvailableAttributesError.AuthorizationError`.
final class NnsInternetIdentityListAvailableAttributesErrorAuthorizationError
    extends NnsInternetIdentityListAvailableAttributesError {
  final IcpPrincipalAddress value;
  const NnsInternetIdentityListAvailableAttributesErrorAuthorizationError(
    this.value,
  );

  @override
  CType get candidType => NnsInternetIdentityListAvailableAttributesError.ctype;

  @override
  dynamic get candidValue => Variant('AuthorizationError', value);

  @override
  Map<String, dynamic> toJson() => {'AuthorizationError': value.address};
}

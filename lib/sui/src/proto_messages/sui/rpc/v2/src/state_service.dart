import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/field_mask.dart"
    as google_protobuf_field_mask;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/object.dart"
    as sui_rpc_v2_object;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart"
    as sui_rpc_v2_bcs;

/// Information about the state of the coin's MetadataCap
enum SuiCoinMetadataMetadataCapState implements ProtoEnumVariant {
  /// Indicates the state of the MetadataCap is unknown.
  /// Set when the coin has not been migrated to the CoinRegistry.
  metadataCapStateUnknown(0, 'METADATA_CAP_STATE_UNKNOWN'),

  /// Indicates the MetadataCap has been claimed.
  claimed(1, 'CLAIMED'),

  /// Indicates the MetadataCap has not been claimed.
  unclaimed(2, 'UNCLAIMED'),

  /// Indicates the MetadataCap has been deleted.
  deleted(3, 'DELETED');

  const SuiCoinMetadataMetadataCapState(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiCoinMetadataMetadataCapState fromValue(int? value) {
    value ??= 0;
    return SuiCoinMetadataMetadataCapState.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiCoinMetadataMetadataCapState found for the given value. $value",
                details: {
                  "name": "SuiCoinMetadataMetadataCapState",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiCoinMetadataMetadataCapState from(Object? value) {
    value ??= 0;
    return SuiCoinMetadataMetadataCapState.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiCoinMetadataMetadataCapState found for the given value. $value",
                details: {
                  "name": "SuiCoinMetadataMetadataCapState",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// Supply state of a coin, matching the Move SupplyState enum
enum SuiCoinTreasurySupplyState implements ProtoEnumVariant {
  /// Supply is unknown or TreasuryCap still exists (minting still possible)
  supplyStateUnknown(0, 'SUPPLY_STATE_UNKNOWN'),

  /// Supply is fixed (TreasuryCap consumed, no more minting possible)
  fixed(1, 'FIXED'),

  /// Supply can only decrease (burning allowed, minting not allowed)
  burnOnly(2, 'BURN_ONLY');

  const SuiCoinTreasurySupplyState(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiCoinTreasurySupplyState fromValue(int? value) {
    value ??= 0;
    return SuiCoinTreasurySupplyState.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiCoinTreasurySupplyState found for the given value. $value",
                details: {
                  "name": "SuiCoinTreasurySupplyState",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiCoinTreasurySupplyState from(Object? value) {
    value ??= 0;
    return SuiCoinTreasurySupplyState.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiCoinTreasurySupplyState found for the given value. $value",
                details: {
                  "name": "SuiCoinTreasurySupplyState",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// Indicates the state of the regulation of the coin.
enum SuiRegulatedCoinMetadataCoinRegulatedState implements ProtoEnumVariant {
  /// Indicates the regulation state of the coin is unknown.
  /// This is set when a coin has not been migrated to the
  /// coin registry and has no `0x2::coin::RegulatedCoinMetadata`
  /// object.
  coinRegulatedStateUnknown(0, 'COIN_REGULATED_STATE_UNKNOWN'),

  /// Indicates a coin is regulated. RegulatedCoinMetadata will be populated.
  regulated(1, 'REGULATED'),

  /// Indicates a coin is unregulated.
  unregulated(2, 'UNREGULATED');

  const SuiRegulatedCoinMetadataCoinRegulatedState(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiRegulatedCoinMetadataCoinRegulatedState fromValue(int? value) {
    value ??= 0;
    return SuiRegulatedCoinMetadataCoinRegulatedState.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiRegulatedCoinMetadataCoinRegulatedState found for the given value. $value",
                details: {
                  "name": "SuiRegulatedCoinMetadataCoinRegulatedState",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiRegulatedCoinMetadataCoinRegulatedState from(Object? value) {
    value ??= 0;
    return SuiRegulatedCoinMetadataCoinRegulatedState.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiRegulatedCoinMetadataCoinRegulatedState found for the given value. $value",
                details: {
                  "name": "SuiRegulatedCoinMetadataCoinRegulatedState",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum SuiDynamicFieldDynamicFieldKind implements ProtoEnumVariant {
  dynamicFieldKindUnknown(0, 'DYNAMIC_FIELD_KIND_UNKNOWN'),
  field(1, 'FIELD'),
  object(2, 'OBJECT');

  const SuiDynamicFieldDynamicFieldKind(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiDynamicFieldDynamicFieldKind fromValue(int? value) {
    value ??= 0;
    return SuiDynamicFieldDynamicFieldKind.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiDynamicFieldDynamicFieldKind found for the given value. $value",
                details: {
                  "name": "SuiDynamicFieldDynamicFieldKind",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiDynamicFieldDynamicFieldKind from(Object? value) {
    value ??= 0;
    return SuiDynamicFieldDynamicFieldKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiDynamicFieldDynamicFieldKind found for the given value. $value",
                details: {
                  "name": "SuiDynamicFieldDynamicFieldKind",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// Request message for `NodeService.GetCoinInfo`.
class SuiGetCoinInfoRequest extends SuiProtoMessage
    with ISuiProtoServiceMessage<SuiGetCoinInfoResponse> {
  /// The coin type to request information about
  final String? coinType;

  const SuiGetCoinInfoRequest({this.coinType});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.string(1, hasOptionalFlags: true)],
    );
  }

  @override
  List<Object?> get protoValues => [coinType];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'coin_type': coinType};
  }

  factory SuiGetCoinInfoRequest.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiGetCoinInfoRequest(
      coinType: json.valueAsString<String?>(
        'coin_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiGetCoinInfoRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetCoinInfoRequest(coinType: decode.getString<String?>(1));
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2GetCoinInfoRequest;
  @override
  SuiGetCoinInfoResponse onServiceResponse(List<int> bytes) {
    return SuiGetCoinInfoResponse.deserialize(bytes);
  }

  @override
  SuiGetCoinInfoResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiGetCoinInfoResponse.fromJson(json);
  }
}

/// Response message for `NodeService.GetCoinInfo`.
class SuiGetCoinInfoResponse extends SuiProtoMessage {
  /// Required. The coin type.
  final String? coinType;

  /// This field will be populated with information about this coin
  /// type's `0x2::coin::CoinMetadata` if it exists and has not been wrapped.
  final SuiCoinMetadata? metadata;

  /// This field will be populated with information about this coin
  /// type's `0x2::coin::TreasuryCap` if it exists and has not been wrapped.
  final SuiCoinTreasury? treasury;

  /// If this coin type is a regulated coin, this field will be
  /// populated with information either from its Currency object
  /// in the CoinRegistry, or from its `0x2::coin::RegulatedCoinMetadata`
  /// object for coins that have not been migrated to the CoinRegistry
  ///
  /// If this coin is not known to be regulated, only the
  /// coin_regulated_state field will be populated.
  final SuiRegulatedCoinMetadata? regulatedMetadata;

  const SuiGetCoinInfoResponse({
    this.coinType,
    this.metadata,
    this.treasury,
    this.regulatedMetadata,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    coinType,
    metadata,
    treasury,
    regulatedMetadata,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'coin_type': coinType,
      'metadata': config.encodeMessage(metadata),
      'treasury': config.encodeMessage(treasury),
      'regulated_metadata': config.encodeMessage(regulatedMetadata),
    };
  }

  factory SuiGetCoinInfoResponse.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiGetCoinInfoResponse(
      coinType: json.valueAsString<String?>(
        'coin_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      metadata: json.valueTo<SuiCoinMetadata?, Object>(
        key: 'metadata',
        parse:
            (v) =>
                SuiCoinMetadata.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      treasury: json.valueTo<SuiCoinTreasury?, Object>(
        key: 'treasury',
        parse:
            (v) =>
                SuiCoinTreasury.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      regulatedMetadata: json.valueTo<SuiRegulatedCoinMetadata?, Object>(
        key: 'regulated_metadata',
        parse:
            (v) => SuiRegulatedCoinMetadata.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiGetCoinInfoResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetCoinInfoResponse(
      coinType: decode.getString<String?>(1),
      metadata: decode.messageTo<SuiCoinMetadata?>(
        2,
        (b) => SuiCoinMetadata.deserialize(b),
      ),
      treasury: decode.messageTo<SuiCoinTreasury?>(
        3,
        (b) => SuiCoinTreasury.deserialize(b),
      ),
      regulatedMetadata: decode.messageTo<SuiRegulatedCoinMetadata?>(
        4,
        (b) => SuiRegulatedCoinMetadata.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2GetCoinInfoResponse;
}

/// Metadata for a coin type
class SuiCoinMetadata extends SuiProtoMessage {
  /// ObjectId of the `0x2::coin::CoinMetadata` object or
  /// 0x2::sui::coin_registry::Currency object (when registered with CoinRegistry).
  final String? id;

  /// Number of decimal places to coin uses.
  final int? decimals;

  /// Name for the token
  final String? name;

  /// Symbol for the token
  final String? symbol;

  /// Description of the token
  final String? description;

  /// URL for the token logo
  final String? iconUrl;

  /// The MetadataCap ID if it has been claimed for this coin type.
  /// This capability allows updating the coin's metadata fields.
  /// Only populated when metadata is from CoinRegistry.
  final String? metadataCapId;

  /// State of the MetadataCap for this coin type.
  final SuiCoinMetadataMetadataCapState? metadataCapState;

  const SuiCoinMetadata({
    this.id,
    this.decimals,
    this.name,
    this.symbol,
    this.description,
    this.iconUrl,
    this.metadataCapId,
    this.metadataCapState,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
        ProtoFieldConfig.string(6, hasOptionalFlags: true),
        ProtoFieldConfig.string(7, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(8, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    id,
    decimals,
    name,
    symbol,
    description,
    iconUrl,
    metadataCapId,
    metadataCapState,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'id': id,
      'decimals': decimals,
      'name': name,
      'symbol': symbol,
      'description': description,
      'icon_url': iconUrl,
      'metadata_cap_id': metadataCapId,
      'metadata_cap_state': config.encodeEnum(metadataCapState),
    };
  }

  factory SuiCoinMetadata.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiCoinMetadata(
      id: json.valueAsString<String?>(
        'id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      decimals: json.valueAsInt<int?>(
        'decimals',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      symbol: json.valueAsString<String?>(
        'symbol',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      description: json.valueAsString<String?>(
        'description',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      iconUrl: json.valueAsString<String?>(
        'icon_url',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      metadataCapId: json.valueAsString<String?>(
        'metadata_cap_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      metadataCapState: json.valueTo<SuiCoinMetadataMetadataCapState?, Object?>(
        key: 'metadata_cap_state',
        parse: (v) => SuiCoinMetadataMetadataCapState.from(v),
      ),
    );
  }

  factory SuiCoinMetadata.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCoinMetadata(
      id: decode.getString<String?>(1),
      decimals: decode.getInt<int?>(2),
      name: decode.getString<String?>(3),
      symbol: decode.getString<String?>(4),
      description: decode.getString<String?>(5),
      iconUrl: decode.getString<String?>(6),
      metadataCapId: decode.getString<String?>(7),
      metadataCapState: decode.getEnum<SuiCoinMetadataMetadataCapState?>(
        8,
        SuiCoinMetadataMetadataCapState.values,
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2CoinMetadata;
}

/// Information about a coin type's `0x2::coin::TreasuryCap` and its total available supply
class SuiCoinTreasury extends SuiProtoMessage {
  /// ObjectId of the `0x2::coin::TreasuryCap` object.
  final String? id;

  /// Total available supply for this coin type.
  final BigInt? totalSupply;

  /// Supply state indicating if the supply is fixed or can still be minted
  final SuiCoinTreasurySupplyState? supplyState;

  const SuiCoinTreasury({this.id, this.totalSupply, this.supplyState});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [id, totalSupply, supplyState];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'id': id,
      'total_supply': config.encodeBigint(totalSupply),
      'supply_state': config.encodeEnum(supplyState),
    };
  }

  factory SuiCoinTreasury.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiCoinTreasury(
      id: json.valueAsString<String?>(
        'id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      totalSupply: json.valueAsBigInt<BigInt?>(
        'total_supply',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      supplyState: json.valueTo<SuiCoinTreasurySupplyState?, Object?>(
        key: 'supply_state',
        parse: (v) => SuiCoinTreasurySupplyState.from(v),
      ),
    );
  }

  factory SuiCoinTreasury.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCoinTreasury(
      id: decode.getString<String?>(1),
      totalSupply: decode.getBigInt<BigInt?>(2),
      supplyState: decode.getEnum<SuiCoinTreasurySupplyState?>(
        3,
        SuiCoinTreasurySupplyState.values,
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2CoinTreasury;
}

/// Information about a regulated coin, which indicates that it makes use of the transfer deny list.
class SuiRegulatedCoinMetadata extends SuiProtoMessage {
  /// ObjectId of the `0x2::coin::RegulatedCoinMetadata` object.
  /// Only present for coins that have not been migrated to CoinRegistry.
  final String? id;

  /// The ID of the coin's `CoinMetadata` or `CoinData` object.
  final String? coinMetadataObject;

  /// The ID of the coin's `DenyCap` object.
  final String? denyCapObject;

  /// Whether the coin can be globally paused
  final bool? allowGlobalPause;

  /// Variant of the regulated coin metadata
  final int? variant;

  /// Indicates the coin's regulated state.
  final SuiRegulatedCoinMetadataCoinRegulatedState? coinRegulatedState;

  const SuiRegulatedCoinMetadata({
    this.id,
    this.coinMetadataObject,
    this.denyCapObject,
    this.allowGlobalPause,
    this.variant,
    this.coinRegulatedState,
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
        ProtoFieldConfig.bool(4, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(5, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(6, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    id,
    coinMetadataObject,
    denyCapObject,
    allowGlobalPause,
    variant,
    coinRegulatedState,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'id': id,
      'coin_metadata_object': coinMetadataObject,
      'deny_cap_object': denyCapObject,
      'allow_global_pause': allowGlobalPause,
      'variant': variant,
      'coin_regulated_state': config.encodeEnum(coinRegulatedState),
    };
  }

  factory SuiRegulatedCoinMetadata.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiRegulatedCoinMetadata(
      id: json.valueAsString<String?>(
        'id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      coinMetadataObject: json.valueAsString<String?>(
        'coin_metadata_object',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      denyCapObject: json.valueAsString<String?>(
        'deny_cap_object',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      allowGlobalPause: json.valueAsBool<bool?>(
        'allow_global_pause',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      variant: json.valueAsInt<int?>(
        'variant',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      coinRegulatedState: json
          .valueTo<SuiRegulatedCoinMetadataCoinRegulatedState?, Object?>(
            key: 'coin_regulated_state',
            parse: (v) => SuiRegulatedCoinMetadataCoinRegulatedState.from(v),
          ),
    );
  }

  factory SuiRegulatedCoinMetadata.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiRegulatedCoinMetadata(
      id: decode.getString<String?>(1),
      coinMetadataObject: decode.getString<String?>(2),
      denyCapObject: decode.getString<String?>(3),
      allowGlobalPause: decode.getBool<bool?>(4),
      variant: decode.getInt<int?>(5),
      coinRegulatedState: decode
          .getEnum<SuiRegulatedCoinMetadataCoinRegulatedState?>(
            6,
            SuiRegulatedCoinMetadataCoinRegulatedState.values,
          ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2RegulatedCoinMetadata;
}

/// Request message for `LiveDataService.GetBalance`.
class SuiGetBalanceRequest extends SuiProtoMessage
    with ISuiProtoServiceMessage<SuiGetBalanceResponse> {
  /// Required. The owner's Sui address.
  final String? owner;

  /// Required. The type names for the coin (e.g., 0x2::sui::SUI).
  final String? coinType;

  const SuiGetBalanceRequest({this.owner, this.coinType});

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
  List<Object?> get protoValues => [owner, coinType];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'owner': owner, 'coin_type': coinType};
  }

  factory SuiGetBalanceRequest.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiGetBalanceRequest(
      owner: json.valueAsString<String?>(
        'owner',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      coinType: json.valueAsString<String?>(
        'coin_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiGetBalanceRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetBalanceRequest(
      owner: decode.getString<String?>(1),
      coinType: decode.getString<String?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2GetBalanceRequest;
  @override
  SuiGetBalanceResponse onServiceResponse(List<int> bytes) {
    return SuiGetBalanceResponse.deserialize(bytes);
  }

  @override
  SuiGetBalanceResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiGetBalanceResponse.fromJson(json);
  }
}

/// Response message for `LiveDataService.GetBalance`.
/// Return the total coin balance for one coin type, owned by the address owner.
class SuiGetBalanceResponse extends SuiProtoMessage {
  /// The balance information for the requested coin type.
  final SuiBalance? balance;

  const SuiGetBalanceResponse({this.balance});

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
  List<Object?> get protoValues => [balance];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'balance': config.encodeMessage(balance)};
  }

  factory SuiGetBalanceResponse.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiGetBalanceResponse(
      balance: json.valueTo<SuiBalance?, Object>(
        key: 'balance',
        parse:
            (v) => SuiBalance.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiGetBalanceResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetBalanceResponse(
      balance: decode.messageTo<SuiBalance?>(
        1,
        (b) => SuiBalance.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2GetBalanceResponse;
}

/// Request message for `LiveDataService.ListBalances`.
class SuiListBalancesRequest extends SuiProtoMessage
    with ISuiProtoServiceMessage<SuiListBalancesResponse> {
  /// Required. The owner's Sui address.
  final String? owner;

  /// The maximum number of balance entries to return. The service may return fewer than this value.
  /// If unspecified, at most `50` entries will be returned.
  /// The maximum value is `1000`; values above `1000` will be coerced to `1000`.
  final int? pageSize;

  /// A page token, received from a previous `ListBalances` call.
  /// Provide this to retrieve the subsequent page.
  ///
  /// When paginating, all other parameters provided to `ListBalances` must
  /// match the call that provided the page token.
  final BuBytes? pageToken;

  SuiListBalancesRequest({this.owner, this.pageSize, List<int>? pageToken})
    : pageToken = pageToken?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [owner, pageSize, pageToken];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'owner': owner,
      'page_size': pageSize,
      'page_token': config.encodeBinary(pageToken),
    };
  }

  factory SuiListBalancesRequest.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiListBalancesRequest(
      owner: json.valueAsString<String?>(
        'owner',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pageSize: json.valueAsInt<int?>(
        'page_size',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pageToken: config.decodeBinary<List<int>?>(
        json.valueAs('page_token', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory SuiListBalancesRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListBalancesRequest(
      owner: decode.getString<String?>(1),
      pageSize: decode.getInt<int?>(2),
      pageToken: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ListBalancesRequest;
  @override
  SuiListBalancesResponse onServiceResponse(List<int> bytes) {
    return SuiListBalancesResponse.deserialize(bytes);
  }

  @override
  SuiListBalancesResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiListBalancesResponse.fromJson(json);
  }
}

/// Response message for `LiveDataService.ListBalances`.
/// Return the total coin balance for all coin types, owned by the address owner.
class SuiListBalancesResponse extends SuiProtoMessage {
  /// The list of coin types and their respective balances.
  final List<SuiBalance> balances;

  /// A token, which can be sent as `page_token` to retrieve the next page.
  /// If this field is omitted, there are no subsequent pages.
  final BuBytes? nextPageToken;

  SuiListBalancesResponse({this.balances = const [], List<int>? nextPageToken})
    : nextPageToken = nextPageToken?.asImmutableBytes;

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
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [balances, nextPageToken];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'balances': balances.map((e) => config.encodeMessage(e)).toList(),
      'next_page_token': config.encodeBinary(nextPageToken),
    };
  }

  factory SuiListBalancesResponse.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiListBalancesResponse(
      balances:
          (json.valueEnsureAsList<dynamic>(
                'balances',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiBalance, Object>(
                  value: e,
                  parse:
                      (v) => SuiBalance.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      nextPageToken: config.decodeBinary<List<int>?>(
        json.valueAs(
          'next_page_token',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory SuiListBalancesResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListBalancesResponse(
      balances:
          decode
              .getListOfBytes(1)
              .map((b) => SuiBalance.deserialize(b))
              .toList(),
      nextPageToken: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ListBalancesResponse;
}

/// Balance information for a specific coin type.
class SuiBalance extends SuiProtoMessage {
  /// The type of the coin (e.g., 0x2::sui::SUI).
  final String? coinType;

  /// The total balance of `coin_type` in its smallest unit.
  /// This is the sum of all spendable amounts of `coin_type` (`address_balance`
  /// and `coin_balance`).
  final BigInt? balance;

  /// The balance of `Balance&lt;T&gt;` in this address's Address Balance.
  final BigInt? addressBalance;

  /// The balance of all `Coin&lt;T&gt;` objects owned by this address.
  final BigInt? coinBalance;

  const SuiBalance({
    this.coinType,
    this.balance,
    this.addressBalance,
    this.coinBalance,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(5, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    coinType,
    balance,
    addressBalance,
    coinBalance,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'coin_type': coinType,
      'balance': config.encodeBigint(balance),
      'address_balance': config.encodeBigint(addressBalance),
      'coin_balance': config.encodeBigint(coinBalance),
    };
  }

  factory SuiBalance.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiBalance(
      coinType: json.valueAsString<String?>(
        'coin_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      addressBalance: json.valueAsBigInt<BigInt?>(
        'address_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      coinBalance: json.valueAsBigInt<BigInt?>(
        'coin_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiBalance.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiBalance(
      coinType: decode.getString<String?>(1),
      balance: decode.getBigInt<BigInt?>(3),
      addressBalance: decode.getBigInt<BigInt?>(4),
      coinBalance: decode.getBigInt<BigInt?>(5),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Balance;
}

/// Request message for `NodeService.ListDynamicFields`
class SuiListDynamicFieldsRequest extends SuiProtoMessage
    with ISuiProtoServiceMessage<SuiListDynamicFieldsResponse> {
  /// Required. The `UID` of the parent, which owns the collections of dynamic fields.
  final String? parent;

  /// The maximum number of dynamic fields to return. The service may return fewer than this value.
  /// If unspecified, at most `50` entries will be returned.
  /// The maximum value is `1000`; values above `1000` will be coerced to `1000`.
  final int? pageSize;

  /// A page token, received from a previous `ListDynamicFields` call.
  /// Provide this to retrieve the subsequent page.
  ///
  /// When paginating, all other parameters provided to `ListDynamicFields` must
  /// match the call that provided the page token.
  final BuBytes? pageToken;

  /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `parent,field_id`.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  SuiListDynamicFieldsRequest({
    this.parent,
    this.pageSize,
    List<int>? pageToken,
    this.readMask,
  }) : pageToken = pageToken?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [parent, pageSize, pageToken, readMask];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'parent': parent,
      'page_size': pageSize,
      'page_token': config.encodeBinary(pageToken),
      'read_mask': config.encodeMessage(readMask),
    };
  }

  factory SuiListDynamicFieldsRequest.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiListDynamicFieldsRequest(
      parent: json.valueAsString<String?>(
        'parent',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pageSize: json.valueAsInt<int?>(
        'page_size',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pageToken: config.decodeBinary<List<int>?>(
        json.valueAs('page_token', normalizeKeyLookup: config.normalizeKeys),
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
    );
  }

  factory SuiListDynamicFieldsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListDynamicFieldsRequest(
      parent: decode.getString<String?>(1),
      pageSize: decode.getInt<int?>(2),
      pageToken: decode.getBytes<List<int>?>(3),
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(
        4,
        (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ListDynamicFieldsRequest;
  @override
  SuiListDynamicFieldsResponse onServiceResponse(List<int> bytes) {
    return SuiListDynamicFieldsResponse.deserialize(bytes);
  }

  @override
  SuiListDynamicFieldsResponse onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return SuiListDynamicFieldsResponse.fromJson(json);
  }
}

/// Response message for `NodeService.ListDynamicFields`
class SuiListDynamicFieldsResponse extends SuiProtoMessage {
  /// Page of dynamic fields owned by the specified parent.
  final List<SuiDynamicField> dynamicFields;

  /// A token, which can be sent as `page_token` to retrieve the next page.
  /// If this field is omitted, there are no subsequent pages.
  final BuBytes? nextPageToken;

  SuiListDynamicFieldsResponse({
    this.dynamicFields = const [],
    List<int>? nextPageToken,
  }) : nextPageToken = nextPageToken?.asImmutableBytes;

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
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [dynamicFields, nextPageToken];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'dynamic_fields':
          dynamicFields.map((e) => config.encodeMessage(e)).toList(),
      'next_page_token': config.encodeBinary(nextPageToken),
    };
  }

  factory SuiListDynamicFieldsResponse.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiListDynamicFieldsResponse(
      dynamicFields:
          (json.valueEnsureAsList<dynamic>(
                'dynamic_fields',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiDynamicField, Object>(
                  value: e,
                  parse:
                      (v) => SuiDynamicField.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      nextPageToken: config.decodeBinary<List<int>?>(
        json.valueAs(
          'next_page_token',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory SuiListDynamicFieldsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListDynamicFieldsResponse(
      dynamicFields:
          decode
              .getListOfBytes(1)
              .map((b) => SuiDynamicField.deserialize(b))
              .toList(),
      nextPageToken: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ListDynamicFieldsResponse;
}

class SuiDynamicField extends SuiProtoMessage {
  final SuiDynamicFieldDynamicFieldKind? kind;

  /// ObjectId of this dynamic field's parent.
  final String? parent;

  /// ObjectId of this dynamic field.
  final String? fieldId;

  /// The field object itself
  final sui_rpc_v2_object.SuiObject? fieldObject;

  /// The dynamic field's "name"
  final sui_rpc_v2_bcs.SuiBcs? name;

  /// The dynamic field's "value"
  final sui_rpc_v2_bcs.SuiBcs? value;

  /// The type of the dynamic field "value".
  ///
  /// If this is a dynamic object field then this is the type of the object
  /// itself (which is a child of this field), otherwise this is the type of the
  /// value of this field.
  final String? valueType;

  /// The ObjectId of the child object when a child is a dynamic
  /// object field.
  ///
  /// The presence or absence of this field can be used to determine if a child
  /// is a dynamic field or a dynamic child object
  final String? childId;

  /// The object itself when a child is a dynamic object field.
  final sui_rpc_v2_object.SuiObject? childObject;

  const SuiDynamicField({
    this.kind,
    this.parent,
    this.fieldId,
    this.fieldObject,
    this.name,
    this.value,
    this.valueType,
    this.childId,
    this.childObject,
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
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
        ProtoFieldConfig.message(6, hasOptionalFlags: true),
        ProtoFieldConfig.string(7, hasOptionalFlags: true),
        ProtoFieldConfig.string(8, hasOptionalFlags: true),
        ProtoFieldConfig.message(9, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    kind,
    parent,
    fieldId,
    fieldObject,
    name,
    value,
    valueType,
    childId,
    childObject,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'kind': config.encodeEnum(kind),
      'parent': parent,
      'field_id': fieldId,
      'field_object': config.encodeMessage(fieldObject),
      'name': config.encodeMessage(name),
      'value': config.encodeMessage(value),
      'value_type': valueType,
      'child_id': childId,
      'child_object': config.encodeMessage(childObject),
    };
  }

  factory SuiDynamicField.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiDynamicField(
      kind: json.valueTo<SuiDynamicFieldDynamicFieldKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiDynamicFieldDynamicFieldKind.from(v),
      ),
      parent: json.valueAsString<String?>(
        'parent',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fieldId: json.valueAsString<String?>(
        'field_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fieldObject: json.valueTo<sui_rpc_v2_object.SuiObject?, Object>(
        key: 'field_object',
        parse:
            (v) => sui_rpc_v2_object.SuiObject.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      name: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'name',
        parse:
            (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(
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
      valueType: json.valueAsString<String?>(
        'value_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      childId: json.valueAsString<String?>(
        'child_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      childObject: json.valueTo<sui_rpc_v2_object.SuiObject?, Object>(
        key: 'child_object',
        parse:
            (v) => sui_rpc_v2_object.SuiObject.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiDynamicField.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiDynamicField(
      kind: decode.getEnum<SuiDynamicFieldDynamicFieldKind?>(
        1,
        SuiDynamicFieldDynamicFieldKind.values,
      ),
      parent: decode.getString<String?>(2),
      fieldId: decode.getString<String?>(3),
      fieldObject: decode.messageTo<sui_rpc_v2_object.SuiObject?>(
        4,
        (b) => sui_rpc_v2_object.SuiObject.deserialize(b),
      ),
      name: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(
        5,
        (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b),
      ),
      value: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(
        6,
        (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b),
      ),
      valueType: decode.getString<String?>(7),
      childId: decode.getString<String?>(8),
      childObject: decode.messageTo<sui_rpc_v2_object.SuiObject?>(
        9,
        (b) => sui_rpc_v2_object.SuiObject.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2DynamicField;
}

class SuiListOwnedObjectsRequest extends SuiProtoMessage
    with ISuiProtoServiceMessage<SuiListOwnedObjectsResponse> {
  /// Required. The address of the account that owns the objects.
  final String? owner;

  /// The maximum number of entries return. The service may return fewer than this value.
  /// If unspecified, at most `50` entries will be returned.
  /// The maximum value is `1000`; values above `1000` will be coerced to `1000`.
  final int? pageSize;

  /// A page token, received from a previous `ListOwnedObjects` call.
  /// Provide this to retrieve the subsequent page.
  ///
  /// When paginating, all other parameters provided to `ListOwnedObjects` must
  /// match the call that provided the page token.
  final BuBytes? pageToken;

  /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `object_id,version,object_type`.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  /// Optional type filter to limit the types of objects listed.
  ///
  /// Providing an object type with no type params will return objects of that
  /// type with any type parameter, e.g. `0x2::coin::Coin` will return all
  /// `Coin&lt;T&gt;` objects regardless of the type parameter `T`. Providing a type
  /// with a type param will restrict the returned objects to only those objects
  /// that match the provided type parameters, e.g.
  /// `0x2::coin::Coin&lt;0x2::sui::SUI&gt;` will only return `Coin&lt;SUI&gt;` objects.
  final String? objectType;

  SuiListOwnedObjectsRequest({
    this.owner,
    this.pageSize,
    List<int>? pageToken,
    this.readMask,
    this.objectType,
  }) : pageToken = pageToken?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    owner,
    pageSize,
    pageToken,
    readMask,
    objectType,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'owner': owner,
      'page_size': pageSize,
      'page_token': config.encodeBinary(pageToken),
      'read_mask': config.encodeMessage(readMask),
      'object_type': objectType,
    };
  }

  factory SuiListOwnedObjectsRequest.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiListOwnedObjectsRequest(
      owner: json.valueAsString<String?>(
        'owner',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pageSize: json.valueAsInt<int?>(
        'page_size',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pageToken: config.decodeBinary<List<int>?>(
        json.valueAs('page_token', normalizeKeyLookup: config.normalizeKeys),
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
      objectType: json.valueAsString<String?>(
        'object_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiListOwnedObjectsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListOwnedObjectsRequest(
      owner: decode.getString<String?>(1),
      pageSize: decode.getInt<int?>(2),
      pageToken: decode.getBytes<List<int>?>(3),
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(
        4,
        (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b),
      ),
      objectType: decode.getString<String?>(5),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ListOwnedObjectsRequest;
  @override
  SuiListOwnedObjectsResponse onServiceResponse(List<int> bytes) {
    return SuiListOwnedObjectsResponse.deserialize(bytes);
  }

  @override
  SuiListOwnedObjectsResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiListOwnedObjectsResponse.fromJson(json);
  }
}

class SuiListOwnedObjectsResponse extends SuiProtoMessage {
  /// Page of dynamic fields owned by the specified parent.
  final List<sui_rpc_v2_object.SuiObject> objects;

  /// A token, which can be sent as `page_token` to retrieve the next page.
  /// If this field is omitted, there are no subsequent pages.
  final BuBytes? nextPageToken;

  SuiListOwnedObjectsResponse({
    this.objects = const [],
    List<int>? nextPageToken,
  }) : nextPageToken = nextPageToken?.asImmutableBytes;

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
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [objects, nextPageToken];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'objects': objects.map((e) => config.encodeMessage(e)).toList(),
      'next_page_token': config.encodeBinary(nextPageToken),
    };
  }

  factory SuiListOwnedObjectsResponse.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiListOwnedObjectsResponse(
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
      nextPageToken: config.decodeBinary<List<int>?>(
        json.valueAs(
          'next_page_token',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory SuiListOwnedObjectsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListOwnedObjectsResponse(
      objects:
          decode
              .getListOfBytes(1)
              .map((b) => sui_rpc_v2_object.SuiObject.deserialize(b))
              .toList(),
      nextPageToken: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ListOwnedObjectsResponse;
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// * Defines all possible *extra* fees.
enum HederaExtra implements ProtoEnumVariant {
  signatures(0, 'SIGNATURES'),
  keys(1, 'KEYS'),
  nftSerials(2, 'NFT_SERIALS'),
  accounts(3, 'ACCOUNTS'),
  tokenTypes(4, 'TOKEN_TYPES'),
  gas(5, 'GAS'),
  allowances(6, 'ALLOWANCES'),
  airdrops(7, 'AIRDROPS'),
  hookUpdates(8, 'HOOK_UPDATES'),
  tokenTransferBase(9, 'TOKEN_TRANSFER_BASE'),
  tokenTransferBaseCustomFees(10, 'TOKEN_TRANSFER_BASE_CUSTOM_FEES'),
  hookExecution(11, 'HOOK_EXECUTION'),
  tokenCreateWithCustomFee(12, 'TOKEN_CREATE_WITH_CUSTOM_FEE'),
  tokenMintNft(13, 'TOKEN_MINT_NFT'),
  consensusCreateTopicWithCustomFee(14, 'CONSENSUS_CREATE_TOPIC_WITH_CUSTOM_FEE'),
  consensusSubmitMessageWithCustomFee(15, 'CONSENSUS_SUBMIT_MESSAGE_WITH_CUSTOM_FEE'),
  scheduleCreateContractCallBase(16, 'SCHEDULE_CREATE_CONTRACT_CALL_BASE'),
  tokenAssociate(17, 'TOKEN_ASSOCIATE'),
  hookSlotUpdate(18, 'HOOK_SLOT_UPDATE'),
  tokenMintNftBase(19, 'TOKEN_MINT_NFT_BASE'),
  nftUpdate(20, 'NFT_UPDATE'),
  records(21, 'RECORDS'),
  stateBytes(22, 'STATE_BYTES'),
    /// For state-persisting operations (file uploads)
  processingBytes(23, 'PROCESSING_BYTES'),
    /// For node/network processing fees
  consensusSubmitMessageWithCustomFeeBytes(24, 'CONSENSUS_SUBMIT_MESSAGE_WITH_CUSTOM_FEE_BYTES'),
  consensusSubmitMessageWithoutCustomFeeBytes(25, 'CONSENSUS_SUBMIT_MESSAGE_WITHOUT_CUSTOM_FEE_BYTES');

  const HederaExtra(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaExtra fromValue(int? value) {
    value ??=0;
    return HederaExtra.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaExtra found for the given value. $value", details: {"name": "HederaExtra", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaExtra from(Object? value) {
    value ??=0;
    return HederaExtra.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaExtra found for the given value. $value", details: {"name": "HederaExtra", "value": value?.toString()})
    );
  }

}


/// *
///  * # Fee Schedule
///  * Defines a schedule of fees for every type of transaction, as specified by
///  * HIP-1261. Fee values are always positive integers and specified
///  * as tinycents (10&lt;sup&gt;-10&lt;/sup&gt; of USD).
/// &lt;&lt;&lt;pbj.java_package = "org.hiero.hapi.support.fees"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Fee schedule definition.&lt;br/&gt;
///  * This message defines how fees are charged for transactions.
class HederaHIP1261FeeSchedule extends HederaProtoMessage with Equality {
    /// *
  ///     * Defines how to compute the &lt;i&gt;node fee component&lt;/i&gt;.
  ///     *
  ///     * &lt;p&gt;The node fee component describes the fee to be paid to the node that
  ///     * submitted the transaction to the network. This fee exists to compensate
  ///     * the node for the work it performed to pre-check the transaction before
  ///     * submitting it, and incentivizes the node to open ports to the world to
  ///     * accept new transactions from users.
  ///     *
  ///     * &lt;p&gt;This fee is calculated in a consistent manner for *all* transactions.
  ///     *
  ///     * &lt;p&gt;The node fee schedule MUST be specified.
  final HederaNodeFee? node;

    /// *
  ///    * Defines the method by which the &lt;i&gt;network fee component&lt;/i&gt; is computed.
  ///    *
  ///    * &lt;p&gt;The network fee component covers the cost of gossip, consensus, signature
  ///    * verifications, fee payment, and blockchain storage. This component is
  ///    * typically combined with the service fee to determine the total fee paid into
  ///    * the network’s Fee Collection Account.
  ///    *
  ///    * &lt;p&gt;The network fee schedule MUST be specified.
  final HederaNetworkFee? network;

    /// *
  ///     * This fee is charged to the node that submitted the transaction when a
  ///     * transaction's bytes cannot be parsed. The fee is deposited into the
  ///     * network's Fee Collection Account.
  ///     *
  ///     * &lt;p&gt;This configuration SHOULD be specified.
  final HederaUnreadableTransactionFee? unreadable;

    /// *
  ///    * Every "extra" that can be assigned to a given fee is defined in this list.
  ///    *
  ///    * &lt;p&gt;The list of extras are optional. The list MUST NOT contain extras with
  ///    * duplicate names.
  final List<HederaExtraFeeDefinition> extras;

    /// *
  ///    * Fees for each service available in the network are included in this list.
  ///    *
  ///    * &lt;p&gt;The list of services are optional, but in practice, every existing
  ///    * service in the network MUST have a corresponding definition. The list
  ///    * MUST NOT contain services with duplicate names.
  final List<HederaServiceFeeSchedule> services;

  const HederaHIP1261FeeSchedule({
    this.node,
    this.network,
    this.unreadable,
    this.extras = const [],
    this.services = const [],
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
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
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
        node,
        network,
        unreadable,
        extras,
        services,
      ];


HederaHIP1261FeeSchedule copyWith(
{HederaNodeFee? node,

HederaNetworkFee? network,

HederaUnreadableTransactionFee? unreadable,

List<HederaExtraFeeDefinition>? extras,

List<HederaServiceFeeSchedule>? services,

}) {
    return HederaHIP1261FeeSchedule(
node: node ?? this.node,
network: network ?? this.network,
unreadable: unreadable ?? this.unreadable,
extras: extras ?? this.extras,
services: services ?? this.services,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'node': config.encodeMessage(node),
      'network': config.encodeMessage(network),
      'unreadable': config.encodeMessage(unreadable),
      'extras': extras.map((e) => config.encodeMessage(e)).toList(),
      'services': services.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaHIP1261FeeSchedule.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaHIP1261FeeSchedule(
      node: json.valueTo<HederaNodeFee?, Object>(
        key: 'node',
        parse: (v) => HederaNodeFee.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      network: json.valueTo<HederaNetworkFee?, Object>(
        key: 'network',
        parse: (v) => HederaNetworkFee.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      unreadable: json.valueTo<HederaUnreadableTransactionFee?, Object>(
        key: 'unreadable',
        parse: (v) => HederaUnreadableTransactionFee.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      extras: (json.valueEnsureAsList<dynamic>('extras', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaExtraFeeDefinition, Object>(
          value: e,
          parse: (v) => HederaExtraFeeDefinition.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      services: (json.valueEnsureAsList<dynamic>('services', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaServiceFeeSchedule, Object>(
          value: e,
          parse: (v) => HederaServiceFeeSchedule.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaHIP1261FeeSchedule.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHIP1261FeeSchedule(
      node: decode.messageTo<HederaNodeFee?>(1, (b) => HederaNodeFee.deserialize(b)),
      network: decode.messageTo<HederaNetworkFee?>(2, (b) => HederaNetworkFee.deserialize(b)),
      unreadable: decode.messageTo<HederaUnreadableTransactionFee?>(3, (b) => HederaUnreadableTransactionFee.deserialize(b)),
      extras: decode.getListOfBytes(4).map((b) => HederaExtraFeeDefinition.deserialize(b)).toList(),
      services: decode.getListOfBytes(5).map((b) => HederaServiceFeeSchedule.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesHIP1261FeeSchedule;

}


/// *
///  * Defines an "extra" fee. Each fee has a name and a fee amount defined in tinycents (10^8 per cent).
class HederaExtraFeeDefinition extends HederaProtoMessage with Equality {
    /// *
  ///    * The name of this "extra". The name MUST be unique within the complete FeeSchedule
  ///    * and MUST be specified. A valid name MUST match `[A-Za-z].*[A-Za-z0-9]*`.
  final HederaExtra? name;

    /// *
  ///    * The fee price, in tinycents. There are 10^8 tinycents per cent USD. The fee MUST be specified
  ///    * (a value of 0 is not permitted).
  final BigInt? fee;

  const HederaExtraFeeDefinition({
    this.name,
    this.fee,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.uint64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        name,
        fee,
      ];


HederaExtraFeeDefinition copyWith(
{HederaExtra? name,

BigInt? fee,

}) {
    return HederaExtraFeeDefinition(
name: name ?? this.name,
fee: fee ?? this.fee,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'name': config.encodeEnum(name),
      'fee': config.encodeBigint(fee),
    };
  }


  factory HederaExtraFeeDefinition.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaExtraFeeDefinition(
      name: json.valueTo<HederaExtra?, Object?>(
        key: 'name',
        parse: (v) => HederaExtra.from(v),
      ),
      fee: json.valueAsBigInt<BigInt?>('fee', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaExtraFeeDefinition.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaExtraFeeDefinition(
      name: decode.getEnum<HederaExtra?>(1, HederaExtra.values),
      fee: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesExtraFeeDefinition;

}


/// *
///  * The configuration for node fees. Applied to all transactions equally.
class HederaNodeFee extends HederaProtoMessage with Equality {
    /// *
  ///    * The base fee price, in tinycents. There are 10^8 tinycents per cent USD.
  ///    * The base fee, plus the extras, determine the node fee. The base_fee is
  ///    * optional. If omitted, the value is 0.
  final BigInt? baseFee;

    /// *
  ///    * References to each extra that should be used when computing the node fee.
  ///    * This list is optional, however, there SHOULD either be a base_fee or
  ///    * a list of extras, or both. This list MUST NOT contain more than one reference
  ///    * to the same extra.
  final List<HederaExtraFeeReference> extras;

  const HederaNodeFee({
    this.baseFee,
    this.extras = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        baseFee,
        extras,
      ];


HederaNodeFee copyWith(
{BigInt? baseFee,

List<HederaExtraFeeReference>? extras,

}) {
    return HederaNodeFee(
baseFee: baseFee ?? this.baseFee,
extras: extras ?? this.extras,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'base_fee': config.encodeBigint(baseFee),
      'extras': extras.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaNodeFee.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNodeFee(
      baseFee: json.valueAsBigInt<BigInt?>('base_fee', normalizeKeyLookup: config.normalizeKeys),
      extras: (json.valueEnsureAsList<dynamic>('extras', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaExtraFeeReference, Object>(
          value: e,
          parse: (v) => HederaExtraFeeReference.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaNodeFee.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeFee(
      baseFee: decode.getBigInt<BigInt?>(1),
      extras: decode.getListOfBytes(2).map((b) => HederaExtraFeeReference.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesNodeFee;

}


/// *
///  * The configuration for computing the network fee component.
class HederaNetworkFee extends HederaProtoMessage with Equality {
    /// *
  ///    * Multiplied by the node fee to determine the network fee. This value MUST be
  ///    * specified and MUST be at least 1.
  final int? multiplier;

  const HederaNetworkFee({
    this.multiplier,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint32(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        multiplier,
      ];


HederaNetworkFee copyWith(
{int? multiplier,

}) {
    return HederaNetworkFee(
multiplier: multiplier ?? this.multiplier,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'multiplier': multiplier,
    };
  }


  factory HederaNetworkFee.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNetworkFee(
      multiplier: json.valueAsInt<int?>('multiplier', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaNetworkFee.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNetworkFee(
      multiplier: decode.getInt<int?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesNetworkFee;

}


/// *
///  * The configuration for all transactions and queries within a single network service.
class HederaServiceFeeSchedule extends HederaProtoMessage with Equality {
    /// *
  ///    * The name of the service. This name MUST be specified and MUST match a name
  ///    * expected by the network service it configures (this is expected to match it
  ///    * exactly). The name must match `[A-Za-z].*[A-Za-z0-9]*`.
  final String? name;

    /// *
  ///    * The list of transaction and query fee configurations. This list MUST NOT be empty.
  ///    * The list MUST NOT contain entries with duplicate names.
  final List<HederaServiceFeeDefinition> schedule;

  const HederaServiceFeeSchedule({
    this.name,
    this.schedule = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        name,
        schedule,
      ];


HederaServiceFeeSchedule copyWith(
{String? name,

List<HederaServiceFeeDefinition>? schedule,

}) {
    return HederaServiceFeeSchedule(
name: name ?? this.name,
schedule: schedule ?? this.schedule,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'name': name,
      'schedule': schedule.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaServiceFeeSchedule.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaServiceFeeSchedule(
      name: json.valueAsString<String?>('name', normalizeKeyLookup: config.normalizeKeys),
      schedule: (json.valueEnsureAsList<dynamic>('schedule', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaServiceFeeDefinition, Object>(
          value: e,
          parse: (v) => HederaServiceFeeDefinition.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaServiceFeeSchedule.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaServiceFeeSchedule(
      name: decode.getString<String?>(1),
      schedule: decode.getListOfBytes(2).map((b) => HederaServiceFeeDefinition.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesServiceFeeSchedule;

}


/// *
///  * The definition of the fee for a transaction or query within a service.
class HederaServiceFeeDefinition extends HederaProtoMessage with Equality {
    /// *
  ///    * The name of the transaction or query. The name MUST be specified and MUST match a name
  ///    * defined by the specification for the service. Each name is unique within the file the
  ///    * context of a specific service. The name must match `[A-Za-z].*[A-Za-z0-9]*`.
  final proto_basic_types.HederaHederaFunctionality? name;

    /// *
  ///    * The base fee price, in tinycents. There are 10^8 tinycents per cent USD.
  ///    * The base fee, plus the extras, determine the service fee. The base_fee is
  ///    * optional. If omitted, the value is 0.
  final BigInt? baseFee;

    /// *
  ///    * References to each extra that should be used when computing the node fee.
  ///    * This list is optional, however, there SHOULD either be a base_fee or
  ///    * a list of extras, or both. Or the `free` field should be set to true.
  ///    * This list MUST NOT contain more than one reference to the same extra.
  final List<HederaExtraFeeReference> extras;

    /// *
  ///    * If true, then `base_fee` and `extras` are ignored, and the transaction or query
  ///    * will be free.
  final bool? free;

    /// *
  ///    * Variable rate pricing configuration for this fee definition.
  ///    * If not specified, variable rates are not supported for this
  ///    * transaction type, and the transaction will be charged the standard fee.
  final HederaVariableRateDefinition? highVolumeRates;

    /// *
  ///    * If true, the node and network fee components are not charged for this
  ///    * transaction type. The service fee (base_fee + extras) still applies.
  ///    *
  ///    * &lt;p&gt;This flag is intended for transaction types that are paid through
  ///    * alternative mechanisms (e.g., gas for smart contract calls) or that
  ///    * are privileged system operations exempt from standard fees.
  ///    *
  ///    * &lt;p&gt;If `free` is also true, `free` takes precedence and the transaction
  ///    * is entirely free.
  final bool? nodeNetworkFeeExempt;

  const HederaServiceFeeDefinition({
    this.name,
    this.baseFee,
    this.extras = const [],
    this.free,
    this.highVolumeRates,
    this.nodeNetworkFeeExempt,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bool(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.bool(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        name,
        baseFee,
        extras,
        free,
        highVolumeRates,
        nodeNetworkFeeExempt,
      ];


HederaServiceFeeDefinition copyWith(
{proto_basic_types.HederaHederaFunctionality? name,

BigInt? baseFee,

List<HederaExtraFeeReference>? extras,

bool? free,

HederaVariableRateDefinition? highVolumeRates,

bool? nodeNetworkFeeExempt,

}) {
    return HederaServiceFeeDefinition(
name: name ?? this.name,
baseFee: baseFee ?? this.baseFee,
extras: extras ?? this.extras,
free: free ?? this.free,
highVolumeRates: highVolumeRates ?? this.highVolumeRates,
nodeNetworkFeeExempt: nodeNetworkFeeExempt ?? this.nodeNetworkFeeExempt,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'name': config.encodeEnum(name),
      'base_fee': config.encodeBigint(baseFee),
      'extras': extras.map((e) => config.encodeMessage(e)).toList(),
      'free': free,
      'high_volume_rates': config.encodeMessage(highVolumeRates),
      'node_network_fee_exempt': nodeNetworkFeeExempt,
    };
  }


  factory HederaServiceFeeDefinition.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaServiceFeeDefinition(
      name: json.valueTo<proto_basic_types.HederaHederaFunctionality?, Object?>(
        key: 'name',
        parse: (v) => proto_basic_types.HederaHederaFunctionality.from(v),
      ),
      baseFee: json.valueAsBigInt<BigInt?>('base_fee', normalizeKeyLookup: config.normalizeKeys),
      extras: (json.valueEnsureAsList<dynamic>('extras', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaExtraFeeReference, Object>(
          value: e,
          parse: (v) => HederaExtraFeeReference.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      free: json.valueAsBool<bool?>('free', normalizeKeyLookup: config.normalizeKeys),
      highVolumeRates: json.valueTo<HederaVariableRateDefinition?, Object>(
        key: 'high_volume_rates',
        parse: (v) => HederaVariableRateDefinition.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      nodeNetworkFeeExempt: json.valueAsBool<bool?>('node_network_fee_exempt', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaServiceFeeDefinition.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaServiceFeeDefinition(
      name: decode.getEnum<proto_basic_types.HederaHederaFunctionality?>(1, proto_basic_types.HederaHederaFunctionality.values),
      baseFee: decode.getBigInt<BigInt?>(2),
      extras: decode.getListOfBytes(3).map((b) => HederaExtraFeeReference.deserialize(b)).toList(),
      free: decode.getBool<bool?>(4),
      highVolumeRates: decode.messageTo<HederaVariableRateDefinition?>(5, (b) => HederaVariableRateDefinition.deserialize(b)),
      nodeNetworkFeeExempt: decode.getBool<bool?>(6),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesServiceFeeDefinition;

}


/// *
///  * A reference to an "extra" defined within the `FeeSchedule`.
class HederaExtraFeeReference extends HederaProtoMessage with Equality {
    /// *
  ///    * The name of the referenced "extra". This name MUST match the name of an extra
  ///    * defined within the `FeeSchedule`.
  final HederaExtra? name;

    /// *
  ///    * The count of this "extra" that is included for free. For example, 256 "Bytes"
  ///    * may be included for free. Each byte above 256 would be charged the fee defined
  ///    * on the "Bytes" extra.
  final int? includedCount;

  const HederaExtraFeeReference({
    this.name,
    this.includedCount,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.uint32(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        name,
        includedCount,
      ];


HederaExtraFeeReference copyWith(
{HederaExtra? name,

int? includedCount,

}) {
    return HederaExtraFeeReference(
name: name ?? this.name,
includedCount: includedCount ?? this.includedCount,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'name': config.encodeEnum(name),
      'included_count': includedCount,
    };
  }


  factory HederaExtraFeeReference.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaExtraFeeReference(
      name: json.valueTo<HederaExtra?, Object?>(
        key: 'name',
        parse: (v) => HederaExtra.from(v),
      ),
      includedCount: json.valueAsInt<int?>('included_count', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaExtraFeeReference.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaExtraFeeReference(
      name: decode.getEnum<HederaExtra?>(1, HederaExtra.values),
      includedCount: decode.getInt<int?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesExtraFeeReference;

}


/// *
///  * Defines the fee to levy a node that sends bytes that cannot be parsed into a Transaction.
class HederaUnreadableTransactionFee extends HederaProtoMessage with Equality {
    /// *
  ///    * The punitive fee, in tinycents. There are 10^8 tinycents per cent USD. This value
  ///    * is optional and may be zero.
  final BigInt? fee;

  const HederaUnreadableTransactionFee({
    this.fee,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fee,
      ];


HederaUnreadableTransactionFee copyWith(
{BigInt? fee,

}) {
    return HederaUnreadableTransactionFee(
fee: fee ?? this.fee,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'fee': config.encodeBigint(fee),
    };
  }


  factory HederaUnreadableTransactionFee.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaUnreadableTransactionFee(
      fee: json.valueAsBigInt<BigInt?>('fee', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaUnreadableTransactionFee.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaUnreadableTransactionFee(
      fee: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesUnreadableTransactionFee;

}


/// *
///  * Defines the configuration for variable rate pricing.
///  * If variable rate pricing is in effect, the resulting fee multiplier will be a
///  * value between 1 (standard fee) and `max_multiplier` (cost ceiling). If a
///  * `pricing_curve` is specified, then the multiplier will be determined by the
///  * utilization percentage of the variable rate throttle and the pricing curve. If
///  * no `pricing_curve` is specified, then the multiplier will be interpolated
///  * on an _effective_ pricing curve described by a straight line
///  * between the standard fee and `max_multiplier` * `standard_fee`.
class HederaVariableRateDefinition extends HederaProtoMessage with Equality {
    /// *
  ///    * Maximum multiplier to prevent extreme pricing (cost ceiling).
  ///    * This value SHOULD be greater than or equal to 1000, any value less than 1000 SHALL be treated as 1000.
  ///    * This value SHALL be divided by 1000 before it is applied as a multiplier, a value of `1000` is therefore a multiplier of `1.000`.
  ///    * Given the normal price of the transaction, the computed variable price
  ///    * will not exceed this multiplier * `standard_fee`. Provides predictability
  ///    * for users regardless of utilization.
  final int? maxMultiplier;

    /// *
  ///    * Pricing curve configuration defining how fees scale with variable rate
  ///    * capacity utilization. Given a utilization percentage (0.0 to 1.0), the
  ///    * pricing curve determines the multiplier to use. If the curve returns a
  ///    * multiplier greater than `max_multiplier`, then `max_multiplier`
  ///    * will be used.
  ///    * &lt;p&gt;
  ///    * If the pricing_curve is not specified, then the multiplier will be linearly
  ///    * interpolated between 1 and `max_multiplier`.
  final HederaPricingCurve? pricingCurve;

  const HederaVariableRateDefinition({
    this.maxMultiplier,
    this.pricingCurve,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint32(2),
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        maxMultiplier,
        pricingCurve,
      ];


HederaVariableRateDefinition copyWith(
{int? maxMultiplier,

HederaPricingCurve? pricingCurve,

}) {
    return HederaVariableRateDefinition(
maxMultiplier: maxMultiplier ?? this.maxMultiplier,
pricingCurve: pricingCurve ?? this.pricingCurve,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'max_multiplier': maxMultiplier,
      'pricing_curve': config.encodeMessage(pricingCurve),
    };
  }


  factory HederaVariableRateDefinition.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaVariableRateDefinition(
      maxMultiplier: json.valueAsInt<int?>('max_multiplier', normalizeKeyLookup: config.normalizeKeys),
      pricingCurve: json.valueTo<HederaPricingCurve?, Object>(
        key: 'pricing_curve',
        parse: (v) => HederaPricingCurve.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaVariableRateDefinition.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaVariableRateDefinition(
      maxMultiplier: decode.getInt<int?>(2),
      pricingCurve: decode.messageTo<HederaPricingCurve?>(3, (b) => HederaPricingCurve.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesVariableRateDefinition;

}


/// *
///  * Defines the pricing curve used for variable rate calculations.
///  * This can be one of several types of curves, each with its own formula for
///  * calculating the multiplier based on the utilization percentage of the
///  * variable rate throttle.
class HederaPricingCurve extends HederaProtoMessage with Equality {
  final HederaPiecewiseLinearCurve? piecewiseLinear;

  const HederaPricingCurve({
    this.piecewiseLinear,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        piecewiseLinear,
      ];


HederaPricingCurve copyWith(
{HederaPiecewiseLinearCurve? piecewiseLinear,

}) {
    return HederaPricingCurve(
piecewiseLinear: piecewiseLinear ?? this.piecewiseLinear,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'piecewise_linear': config.encodeMessage(piecewiseLinear),
    };
  }


  factory HederaPricingCurve.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPricingCurve(
      piecewiseLinear: json.valueTo<HederaPiecewiseLinearCurve?, Object>(
        key: 'piecewise_linear',
        parse: (v) => HederaPiecewiseLinearCurve.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaPricingCurve.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPricingCurve(
      piecewiseLinear: decode.messageTo<HederaPiecewiseLinearCurve?>(1, (b) => HederaPiecewiseLinearCurve.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesPricingCurve;

}


/// *
///  * Contains a set of points (utilization, multiplier) that define a piecewise
///  * linear curve for variable pricing. Each point represents a linear segment
///  * between two utilization thresholds. The multiplier to use is interpolated
///  * between these points based on the current utilization percentage.
///  *
///  * For example, given points
///  *  - (0.0, 1.0)
///  *  - (0.5, 2.0)
///  *  - (1.0, 5.0)
///  * The multiplier for a utilization of 0.75 would be interpolated between the
///  * second and third points, resulting in a multiplier of 3.5.
class HederaPiecewiseLinearCurve extends HederaProtoMessage with Equality {
    /// *
  ///    * A list of points defining the piecewise linear curve.
  ///    * Each point is a pair of (utilization_percentage, multiplier). The list
  ///    * must be sorted by utilization_percentage in ascending order, and
  ///    * sub-ordered by multiplier in ascending order for points with the same
  ///    * utilization percentage. It is legal to have two points with the same
  ///    * utilization percentage, but they must have different multipliers.
  ///    * This allows the creation of stepped pricing curves.
  final List<HederaPiecewiseLinearPoint> points;

  const HederaPiecewiseLinearCurve({
    this.points = const [],
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        points,
      ];


HederaPiecewiseLinearCurve copyWith(
{List<HederaPiecewiseLinearPoint>? points,

}) {
    return HederaPiecewiseLinearCurve(
points: points ?? this.points,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'points': points.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaPiecewiseLinearCurve.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPiecewiseLinearCurve(
      points: (json.valueEnsureAsList<dynamic>('points', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaPiecewiseLinearPoint, Object>(
          value: e,
          parse: (v) => HederaPiecewiseLinearPoint.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaPiecewiseLinearCurve.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPiecewiseLinearCurve(
      points: decode.getListOfBytes(1).map((b) => HederaPiecewiseLinearPoint.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesPiecewiseLinearCurve;

}


/// *
///  * Represents a single point in a piecewise linear curve, with a utilization
///  * percentage and the corresponding multiplier.
class HederaPiecewiseLinearPoint extends HederaProtoMessage with Equality {
    /// *
  ///    * The utilization percentage for this point, in hundredths of one percent.
  ///    * This value must be between 0 and 10,000, inclusive.
  final int? utilizationBasisPoints;

    /// *
  ///    * The multiplier to apply at this utilization percentage.
  ///    * This value SHOULD be greater than or equal to 1000, any value less than 1000 SHALL be treated as 1000
  ///    * This value SHALL be divided by 1000 before it is applied as a multiplier, a value of `1000` is therefore a multiplier of `1.000`.
  final int? multiplier;

  const HederaPiecewiseLinearPoint({
    this.utilizationBasisPoints,
    this.multiplier,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint32(1),
        ProtoFieldConfig.uint32(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        utilizationBasisPoints,
        multiplier,
      ];


HederaPiecewiseLinearPoint copyWith(
{int? utilizationBasisPoints,

int? multiplier,

}) {
    return HederaPiecewiseLinearPoint(
utilizationBasisPoints: utilizationBasisPoints ?? this.utilizationBasisPoints,
multiplier: multiplier ?? this.multiplier,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'utilization_basis_points': utilizationBasisPoints,
      'multiplier': multiplier,
    };
  }


  factory HederaPiecewiseLinearPoint.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPiecewiseLinearPoint(
      utilizationBasisPoints: json.valueAsInt<int?>('utilization_basis_points', normalizeKeyLookup: config.normalizeKeys),
      multiplier: json.valueAsInt<int?>('multiplier', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaPiecewiseLinearPoint.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPiecewiseLinearPoint(
      utilizationBasisPoints: decode.getInt<int?>(1),
      multiplier: decode.getInt<int?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.orgHieroHapiSupportFeesPiecewiseLinearPoint;

}



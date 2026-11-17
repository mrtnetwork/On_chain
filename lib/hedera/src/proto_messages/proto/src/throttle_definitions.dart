import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Throttle Definitions
///  * A set of messages that support maintaining throttling limits on network
///  * transactions to ensure no one transaction type consumes the entirety of
///  * network resources. Also used to charge congestion fees when network load
///  * is exceptionally high, as an incentive to delay transactions that are
///  * not time-sensitive.
///  *
///  * For details behind this throttling design, please see the
///  * `docs/throttle-design.md` document in the
///  * [Hedera Services](https://github.com/hashgraph/hedera-services) repository.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.transaction"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A single throttle limit applied to one or more operations.
///  *
///  * The list of operations MUST contain at least one entry.&lt;br/&gt;
///  * The throttle limit SHALL be specified in thousandths of an operation
///  * per second; one operation per second for the network would be `1000`.&lt;br/&gt;
///  * The throttle limit MUST be greater than zero (`0`).
class HederaThrottleGroup extends HederaProtoMessage with Equality {
    /// *
  ///    * A list of operations to be throttled.
  ///    * &lt;p&gt;
  ///    * This list MUST contain at least one item.&lt;br/&gt;
  ///    * This list SHOULD NOT contain any item included in any other
  ///    * active `ThrottleGroup`.
  final List<proto_basic_types.HederaHederaFunctionality> operations;

    /// *
  ///    * A throttle limit for this group.&lt;br/&gt;
  ///    * This is a total number of operations, in thousandths, the network may
  ///    * perform each second for this group. Every node executes every transaction,
  ///    * so this limit effectively applies individually to each node as well.&lt;br/&gt;
  ///    * &lt;p&gt;
  ///    * This value MUST be greater than zero (`0`).&lt;br/&gt;
  ///    * This value SHOULD be less than `9,223,372`.&lt;br/&gt;
  final BigInt? milliOpsPerSec;

  const HederaThrottleGroup({
    this.operations = const [],
    this.milliOpsPerSec,
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
          elementType: ProtoFieldType.enumType,
        ),
        ProtoFieldConfig.uint64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        operations,
        milliOpsPerSec,
      ];


HederaThrottleGroup copyWith(
{List<proto_basic_types.HederaHederaFunctionality>? operations,

BigInt? milliOpsPerSec,

}) {
    return HederaThrottleGroup(
operations: operations ?? this.operations,
milliOpsPerSec: milliOpsPerSec ?? this.milliOpsPerSec,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'operations': operations.map((e) => config.encodeEnum(e)).toList(),
      'milliOpsPerSec': config.encodeBigint(milliOpsPerSec),
    };
  }


  factory HederaThrottleGroup.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaThrottleGroup(
      operations: (json.valueEnsureAsList<dynamic>('operations', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaHederaFunctionality, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaHederaFunctionality.from(v),
        )).toList(),
      milliOpsPerSec: json.valueAsBigInt<BigInt?>('milliOpsPerSec', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaThrottleGroup.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaThrottleGroup(
      operations: decode.getReapeatedEnum<proto_basic_types.HederaHederaFunctionality>(1, proto_basic_types.HederaHederaFunctionality.values),
      milliOpsPerSec: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoThrottleGroup;

}


/// *
///  * A "bucket" of performance allocated across one or more throttle groups.&lt;br/&gt;
///  * This entry combines one or more throttle groups into a single unit to
///  * calculate limitations and congestion. Each "bucket" "fills" as operations
///  * are completed, then "drains" over a period of time defined for each bucket.
///  * This fill-and-drain characteristic enables the network to process sudden
///  * bursts of heavy traffic while still observing throttle limits over longer
///  * timeframes.
///  *
///  * The value of `burstPeriodMs` is combined with the `milliOpsPerSec`
///  * values for the individual throttle groups to determine the total
///  * bucket "capacity". This combination MUST be less than the maximum
///  * value of a signed long integer (`9223372036854775807`), when scaled to
///  * a nanosecond measurement resolution.
///  *
///  * &gt; Note
///  * &gt;&gt; There is some question regarding the mechanism of calculating the
///  * &gt;&gt; combination of `burstPeriodMs` and `milliOpsPerSec`. The calculation
///  * &gt;&gt; Is implemented in difficult-to-find code, and very likely does not
///  * &gt;&gt; match the approach described here.
class HederaThrottleBucket extends HederaProtoMessage with Equality {
    /// *
  ///    * A name for this bucket.&lt;br/&gt;
  ///    * This is used for log entries.
  ///    * &lt;p&gt;
  ///    * This value SHOULD NOT exceed 20 characters.
  final String? name;

    /// *
  ///    * A burst duration limit, in milliseconds.&lt;br/&gt;
  ///    * This value determines the total "capacity" of the bucket. The rate
  ///    * at which the bucket "drains" is set by the throttles, and this duration
  ///    * sets how long that rate must be sustained to empty a "full" bucket.
  ///    * That combination (calculated as the product of this value and the least
  ///    * common multiple of the `milliOpsPerSec` values for all throttle groups)
  ///    * determines the maximum amount of operations this bucket can "hold".
  ///    * &lt;p&gt;
  ///    * The calculated capacity of this bucket MUST NOT exceed `9,223,372,036,854`.
  final BigInt? burstPeriodMs;

    /// *
  ///    * A list of throttle groups.&lt;br/&gt;
  ///    * These throttle groups combined define the effective throttle
  ///    * rate for the bucket.
  ///    * &lt;p&gt;
  ///    * This list MUST contain at least one entry.
  final List<HederaThrottleGroup> throttleGroups;

    /// *
  ///    * If set to true, this bucket is used for high-volume throttles.
  final bool? highVolume;

  const HederaThrottleBucket({
    this.name,
    this.burstPeriodMs,
    this.throttleGroups = const [],
    this.highVolume,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bool(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        name,
        burstPeriodMs,
        throttleGroups,
        highVolume,
      ];


HederaThrottleBucket copyWith(
{String? name,

BigInt? burstPeriodMs,

List<HederaThrottleGroup>? throttleGroups,

bool? highVolume,

}) {
    return HederaThrottleBucket(
name: name ?? this.name,
burstPeriodMs: burstPeriodMs ?? this.burstPeriodMs,
throttleGroups: throttleGroups ?? this.throttleGroups,
highVolume: highVolume ?? this.highVolume,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'name': name,
      'burstPeriodMs': config.encodeBigint(burstPeriodMs),
      'throttleGroups': throttleGroups.map((e) => config.encodeMessage(e)).toList(),
      'high_volume': highVolume,
    };
  }


  factory HederaThrottleBucket.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaThrottleBucket(
      name: json.valueAsString<String?>('name', normalizeKeyLookup: config.normalizeKeys),
      burstPeriodMs: json.valueAsBigInt<BigInt?>('burstPeriodMs', normalizeKeyLookup: config.normalizeKeys),
      throttleGroups: (json.valueEnsureAsList<dynamic>('throttleGroups', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaThrottleGroup, Object>(
          value: e,
          parse: (v) => HederaThrottleGroup.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      highVolume: json.valueAsBool<bool?>('high_volume', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaThrottleBucket.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaThrottleBucket(
      name: decode.getString<String?>(1),
      burstPeriodMs: decode.getBigInt<BigInt?>(2),
      throttleGroups: decode.getListOfBytes(3).map((b) => HederaThrottleGroup.deserialize(b)).toList(),
      highVolume: decode.getBool<bool?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoThrottleBucket;

}


/// *
///  * A list of throttle buckets.&lt;br/&gt;
///  * This list, simultaneously enforced, defines a complete throttling policy.
///  *
///  *  1. When an operation appears in more than one throttling bucket,
///  *     that operation SHALL be throttled unless all of the buckets where
///  *     the operation appears have "capacity" available.
///  *  1. An operation assigned to no buckets is SHALL be throttled in every
///  *     instance.  The _effective_ throttle for this case is `0`.
class HederaThrottleDefinitions extends HederaProtoMessage with Equality {
    /// *
  ///      * A list of throttle buckets.
  ///      * &lt;p&gt;
  ///      * This list MUST be set, and SHOULD NOT be empty.&lt;br/&gt;
  ///      * An empty list SHALL have the effect of setting all operations to
  ///      * a single group with throttle limit of `0` operations per second for the
  ///      * entire network.
  final List<HederaThrottleBucket> throttleBuckets;

  const HederaThrottleDefinitions({
    this.throttleBuckets = const [],
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
        throttleBuckets,
      ];


HederaThrottleDefinitions copyWith(
{List<HederaThrottleBucket>? throttleBuckets,

}) {
    return HederaThrottleDefinitions(
throttleBuckets: throttleBuckets ?? this.throttleBuckets,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'throttleBuckets': throttleBuckets.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaThrottleDefinitions.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaThrottleDefinitions(
      throttleBuckets: (json.valueEnsureAsList<dynamic>('throttleBuckets', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaThrottleBucket, Object>(
          value: e,
          parse: (v) => HederaThrottleBucket.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaThrottleDefinitions.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaThrottleDefinitions(
      throttleBuckets: decode.getListOfBytes(1).map((b) => HederaThrottleBucket.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoThrottleDefinitions;

}



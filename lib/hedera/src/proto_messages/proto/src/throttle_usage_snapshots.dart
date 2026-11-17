import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;

/// *
///  * # Throttle Snapshots
///  * Point-in-time information regarding throttle usage.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.throttles"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * All point-in-time snapshots of throttle usage for TPS, "gas" throttle
///  * values for a given point in time and evm ops duration throttle.
///  *
///  * &gt; Question:
///  * &gt;&gt; What point in time?  Should this store consensus timestamp here?
class HederaThrottleUsageSnapshots extends HederaProtoMessage with Equality {
  /// *
  ///      * A list of snapshots for TPS throttles.
  ///      * &lt;p&gt;
  ///      * &lt;blockquote&gt;Question:&lt;blockquote&gt;What is the order?&lt;/blockquote&gt;&lt;/blockquote&gt;
  final List<HederaThrottleUsageSnapshot> tpsThrottles;

  /// *
  ///      * A single snapshot for the gas throttle.
  final HederaThrottleUsageSnapshot? gasThrottle;

  /// *
  ///      * A single snapshot for evm ops duration throttle.
  final HederaThrottleUsageSnapshot? evmOpsDurationThrottle;

  const HederaThrottleUsageSnapshots({
    this.tpsThrottles = const [],
    this.gasThrottle,
    this.evmOpsDurationThrottle,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    tpsThrottles,
    gasThrottle,
    evmOpsDurationThrottle,
  ];

  HederaThrottleUsageSnapshots copyWith({
    List<HederaThrottleUsageSnapshot>? tpsThrottles,

    HederaThrottleUsageSnapshot? gasThrottle,

    HederaThrottleUsageSnapshot? evmOpsDurationThrottle,
  }) {
    return HederaThrottleUsageSnapshots(
      tpsThrottles: tpsThrottles ?? this.tpsThrottles,
      gasThrottle: gasThrottle ?? this.gasThrottle,
      evmOpsDurationThrottle:
          evmOpsDurationThrottle ?? this.evmOpsDurationThrottle,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'tps_throttles':
          tpsThrottles.map((e) => config.encodeMessage(e)).toList(),
      'gas_throttle': config.encodeMessage(gasThrottle),
      'evm_ops_duration_throttle': config.encodeMessage(evmOpsDurationThrottle),
    };
  }

  factory HederaThrottleUsageSnapshots.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaThrottleUsageSnapshots(
      tpsThrottles:
          (json.valueEnsureAsList<dynamic>(
                'tps_throttles',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaThrottleUsageSnapshot, Object>(
                  value: e,
                  parse:
                      (v) => HederaThrottleUsageSnapshot.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      gasThrottle: json.valueTo<HederaThrottleUsageSnapshot?, Object>(
        key: 'gas_throttle',
        parse:
            (v) => HederaThrottleUsageSnapshot.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      evmOpsDurationThrottle: json
          .valueTo<HederaThrottleUsageSnapshot?, Object>(
            key: 'evm_ops_duration_throttle',
            parse:
                (v) => HederaThrottleUsageSnapshot.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaThrottleUsageSnapshots.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaThrottleUsageSnapshots(
      tpsThrottles:
          decode
              .getListOfBytes(1)
              .map((b) => HederaThrottleUsageSnapshot.deserialize(b))
              .toList(),
      gasThrottle: decode.messageTo<HederaThrottleUsageSnapshot?>(
        2,
        (b) => HederaThrottleUsageSnapshot.deserialize(b),
      ),
      evmOpsDurationThrottle: decode.messageTo<HederaThrottleUsageSnapshot?>(
        3,
        (b) => HederaThrottleUsageSnapshot.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoThrottleUsageSnapshots;
}

/// *
///  * A single snapshot of the used throttle capacity for a throttle and point in
///  * time.
///  *
///  * &gt; Question:
///  * &gt;&gt; What throttle does this apply to? How is that determined?
class HederaThrottleUsageSnapshot extends HederaProtoMessage with Equality {
  /// *
  ///      * Used throttle capacity.
  final BigInt? used;

  /// *
  ///      * The time at which the this snapshot of capacity was calculated.&lt;br/&gt;
  ///      * Stored as an offset from the `epoch`.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch with 0 at `1970-01-01T00:00:00.000Z`.
  final proto_timestamp.HederaTimestamp? lastDecisionTime;

  const HederaThrottleUsageSnapshot({this.used, this.lastDecisionTime});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [used, lastDecisionTime];

  HederaThrottleUsageSnapshot copyWith({
    BigInt? used,

    proto_timestamp.HederaTimestamp? lastDecisionTime,
  }) {
    return HederaThrottleUsageSnapshot(
      used: used ?? this.used,
      lastDecisionTime: lastDecisionTime ?? this.lastDecisionTime,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'used': config.encodeBigint(used),
      'last_decision_time': config.encodeMessage(lastDecisionTime),
    };
  }

  factory HederaThrottleUsageSnapshot.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaThrottleUsageSnapshot(
      used: json.valueAsBigInt<BigInt?>(
        'used',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      lastDecisionTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'last_decision_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaThrottleUsageSnapshot.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaThrottleUsageSnapshot(
      used: decode.getBigInt<BigInt?>(1),
      lastDecisionTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        2,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoThrottleUsageSnapshot;
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;

/// *
///  * # Congestion timestamps
///  * The timestamp values indicating when congestion pricing changed.
///  *
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.congestion"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Two lists of congestion pricing level "start" times. Each list details the
///  * start of each time period when the congestion pricing level changed
///  * (increasing, or decreasing, the congestion fee multiplier).
///  *
class HederaCongestionLevelStarts extends HederaProtoMessage with Equality {
    /// *
  ///      * Timestamps for each point where "entity utilization" congestion pricing
  ///      * levels changed.
  ///      * &lt;p&gt;
  ///      * If congestion pricing has not occurred then this SHALL contain a single
  ///      * timestamp of value 0.
  final List<proto_timestamp.HederaTimestamp> genericLevelStarts;

    /// *
  ///      * Timestamps for each point where "gas utilization" congestion pricing
  ///      * levels changed.
  ///      * &lt;p&gt;
  ///      * If congestion pricing has not occurred then this SHALL contain a single
  ///      * timestamp of value 0.
  final List<proto_timestamp.HederaTimestamp> gasLevelStarts;

  const HederaCongestionLevelStarts({
    this.genericLevelStarts = const [],
    this.gasLevelStarts = const [],
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
  List<Object?> get protoValues => [
        genericLevelStarts,
        gasLevelStarts,
      ];


HederaCongestionLevelStarts copyWith(
{List<proto_timestamp.HederaTimestamp>? genericLevelStarts,

List<proto_timestamp.HederaTimestamp>? gasLevelStarts,

}) {
    return HederaCongestionLevelStarts(
genericLevelStarts: genericLevelStarts ?? this.genericLevelStarts,
gasLevelStarts: gasLevelStarts ?? this.gasLevelStarts,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'generic_level_starts': genericLevelStarts.map((e) => config.encodeMessage(e)).toList(),
      'gas_level_starts': gasLevelStarts.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaCongestionLevelStarts.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCongestionLevelStarts(
      genericLevelStarts: (json.valueEnsureAsList<dynamic>('generic_level_starts', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_timestamp.HederaTimestamp, Object>(
          value: e,
          parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      gasLevelStarts: (json.valueEnsureAsList<dynamic>('gas_level_starts', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_timestamp.HederaTimestamp, Object>(
          value: e,
          parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaCongestionLevelStarts.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCongestionLevelStarts(
      genericLevelStarts: decode.getListOfBytes(1).map((b) => proto_timestamp.HederaTimestamp.deserialize(b)).toList(),
      gasLevelStarts: decode.getListOfBytes(2).map((b) => proto_timestamp.HederaTimestamp.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoCongestionLevelStarts;

}



import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Timestamp
///  * Messages to describe exact date-time values, with resolution of seconds or
///  * nanoseconds, referenced to the UNIX epoch.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.base"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * An exact date and time.&lt;br/&gt;
///  * This is the same data structure as the Google protobuf Timestamp.proto.
///  *
///  * #### Additional Notes
///  * Useful information is present in comments on the
///  * [Google version](https://github.com/google/protobuf/blob/master/src/google/protobuf/timestamp.proto).
class HederaTimestamp extends HederaProtoMessage with Equality {
  /// *
  ///      * The number of complete seconds since the start of the epoch.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch with 0
  ///      * at `1970-01-01T00:00:00.000Z`.&lt;br/&gt;
  ///      * This value MUST be greater than 0.&lt;br/&gt;
  ///      * This value SHOULD be strictly greater than `946684800`.
  final BigInt? seconds;

  /// *
  ///      * The number of nanoseconds after the start of the second referenced
  ///      * in `seconds`.
  ///      * &lt;p&gt;
  ///      * This value MUST be greater than or equal to 0.&lt;br/&gt;
  ///      * This value MUST be strictly less than 1,000,000,000.
  final int? nanos;

  const HederaTimestamp({this.seconds, this.nanos});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.int32(2)],
    );
  }

  @override
  List<Object?> get protoValues => [seconds, nanos];

  HederaTimestamp copyWith({BigInt? seconds, int? nanos}) {
    return HederaTimestamp(
      seconds: seconds ?? this.seconds,
      nanos: nanos ?? this.nanos,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'seconds': config.encodeBigint(seconds), 'nanos': nanos};
  }

  factory HederaTimestamp.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTimestamp(
      seconds: json.valueAsBigInt<BigInt?>(
        'seconds',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nanos: json.valueAsInt<int?>(
        'nanos',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTimestamp.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTimestamp(
      seconds: decode.getBigInt<BigInt?>(1),
      nanos: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTimestamp;
}

/// *
///  * An exact date and time, with a resolution of one second.
class HederaTimestampSeconds extends HederaProtoMessage with Equality {
  /// *
  ///      * The number of complete seconds since the start of the epoch.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch with 0
  ///      * at `1970-01-01T00:00:00.000Z`.&lt;br/&gt;
  ///      * This value MUST be greater than 0.&lt;br/&gt;
  ///      * This value SHOULD be strictly greater than `946684800`.
  final BigInt? seconds;

  const HederaTimestampSeconds({this.seconds});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1)],
    );
  }

  @override
  List<Object?> get protoValues => [seconds];

  HederaTimestampSeconds copyWith({BigInt? seconds}) {
    return HederaTimestampSeconds(seconds: seconds ?? this.seconds);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'seconds': config.encodeBigint(seconds)};
  }

  factory HederaTimestampSeconds.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTimestampSeconds(
      seconds: json.valueAsBigInt<BigInt?>(
        'seconds',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTimestampSeconds.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTimestampSeconds(seconds: decode.getBigInt<BigInt?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTimestampSeconds;
}

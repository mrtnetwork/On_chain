import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Duration
///  * A duration, in seconds.
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
///  * A length of time in seconds.
///  *
///  * It is RECOMMENDED that this message be used whenever an amount of time,
///  * rather than a specific point in time, is needed.
class HederaDuration extends HederaProtoMessage with Equality {
    /// *
  ///      * The number of seconds for this duration.
  final BigInt? seconds;

  const HederaDuration({
    this.seconds,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        seconds,
      ];


HederaDuration copyWith(
{BigInt? seconds,

}) {
    return HederaDuration(
seconds: seconds ?? this.seconds,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'seconds': config.encodeBigint(seconds),
    };
  }


  factory HederaDuration.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaDuration(
      seconds: json.valueAsBigInt<BigInt?>('seconds', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaDuration.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaDuration(
      seconds: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoDuration;

}



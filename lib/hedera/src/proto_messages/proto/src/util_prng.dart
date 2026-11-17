import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Utility PRNG query
///  * A query to retrieve a deterministic pseudo-random value.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.util"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Request a deterministic pseudo-random number.
///  *
///  * The value returned SHALL be deterministic, but not easily predicted.
///  * The value returned SHALL NOT be suitable for cryptographic use.
///  *
///  * ### Block Stream Effects
///  * The result of this transaction is reported in a `UtilPrngOutput` message.
class HederaUtilPrngTransactionBody extends HederaProtoMessage with Equality {
  /// *
  ///      * A range for the requested value.
  ///      * &lt;p&gt;
  ///      * If this is greater than `0`, the service SHALL return a 32-bit
  ///      * pseudo-random number between 0 and the value provided in the
  ///      * transaction record.&lt;br/&gt;
  ///      * If this is unset, zero, or negative; the service SHALL return a
  ///      * 384-bit unsigned pseudo-random number in the record.
  final int? range;

  const HederaUtilPrngTransactionBody({this.range});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int32(1)],
    );
  }

  @override
  List<Object?> get protoValues => [range];

  HederaUtilPrngTransactionBody copyWith({int? range}) {
    return HederaUtilPrngTransactionBody(range: range ?? this.range);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'range': range};
  }

  factory HederaUtilPrngTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaUtilPrngTransactionBody(
      range: json.valueAsInt<int?>(
        'range',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaUtilPrngTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaUtilPrngTransactionBody(range: decode.getInt<int?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoUtilPrngTransactionBody;
}

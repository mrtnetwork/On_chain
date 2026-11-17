import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Token Un-Pause
///  * A transaction to "unpause" (i.e. resume) all activity for a token. While
///  * a token is "paused" it cannot be transferred between accounts by any
///  * transaction other than `rejectToken`. Once "unpaused", transactions involving
///  * that token may resume.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Resume transaction activity for a token.
///  *
///  * This transaction MUST be signed by the Token `pause_key`.&lt;br/&gt;
///  * The `token` identified MUST exist, and MUST NOT be deleted.&lt;br/&gt;
///  * The `token` identified MAY not be paused; if the token is not paused,
///  * this transaction SHALL have no effect.
///  * The `token` identified MUST have a `pause_key` set, the `pause_key` MUST be
///  * a valid `Key`, and the `pause_key` MUST NOT be an empty `KeyList`.&lt;br/&gt;
///  * An `unpaused` token MAY be transferred or otherwise modified.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenUnpauseTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///    * A token identifier.
  ///    * &lt;p&gt;
  ///    * The identified token SHALL be "unpaused". Subsequent transactions
  ///    * involving that token MAY succeed.
  final proto_basic_types.HederaTokenID? token;

  const HederaTokenUnpauseTransactionBody({this.token});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1)],
    );
  }

  @override
  List<Object?> get protoValues => [token];

  HederaTokenUnpauseTransactionBody copyWith({
    proto_basic_types.HederaTokenID? token,
  }) {
    return HederaTokenUnpauseTransactionBody(token: token ?? this.token);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'token': config.encodeMessage(token)};
  }

  factory HederaTokenUnpauseTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenUnpauseTransactionBody(
      token: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTokenUnpauseTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenUnpauseTransactionBody(
      token: decode.messageTo<proto_basic_types.HederaTokenID?>(
        1,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenUnpauseTransactionBody;
}

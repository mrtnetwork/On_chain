import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Token Delete
///  * Delete an Hedera Token Service (HTS) token.
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
///  * Mark a token as deleted.&lt;br/&gt;
///  * A deleted token remains present in the network state, but is no longer
///  * active, cannot be held in a balance, and all operations on that token
///  * fail. A deleted token is removed from network state when it expires.
///  *
///  * #### Operations on a deleted token
///  * All operations on a deleted token SHALL fail with a
///  * status code `TOKEN_WAS_DELETED`.&lt;br/&gt;
///  * Any attempt to transfer a deleted token between accounts SHALL fail with
///  * a status code `TOKEN_WAS_DELETED`.
///  *
///  * &gt; QUESTIONS
///  * &gt;&gt; What happens to existing balances/NFTs?
///  * &gt;&gt; Are these removed; are they stuck on the accounts?
///  * &gt;
///  * &gt;&gt; If balances/NFTs remain, can a `tokenReject` remove them?
///  *
///  * #### Requirements
///  * The `admin_key` for the token MUST be set, and MUST
///  * sign this transaction.&lt;br/&gt;
///  * If the `admin_key` for the token is not set, this transaction SHALL
///  * fail with a status code `TOKEN_IS_IMMUTABlE`.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenDeleteTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the token type to delete.&lt;br/&gt;
  ///      * The identified token MUST exist, and MUST NOT be deleted.
  final proto_basic_types.HederaTokenID? token;

  const HederaTokenDeleteTransactionBody({
    this.token,
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
        token,
      ];


HederaTokenDeleteTransactionBody copyWith(
{proto_basic_types.HederaTokenID? token,

}) {
    return HederaTokenDeleteTransactionBody(
token: token ?? this.token,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token': config.encodeMessage(token),
    };
  }


  factory HederaTokenDeleteTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenDeleteTransactionBody(
      token: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaTokenDeleteTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenDeleteTransactionBody(
      token: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenDeleteTransactionBody;

}



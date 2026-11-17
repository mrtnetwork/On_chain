import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Delete Live Hash
///  * Dissociate a specific live hash from a specified account.
///  *
///  * &gt; Important
///  * &gt;&gt; This transaction is obsolete and not supported.&lt;br/&gt;
///  * &gt;&gt; Any transaction of this type that is submitted SHALL fail with a `PRE_CHECK` result
///  * &gt;&gt; of `NOT_SUPPORTED`.
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
///  * Delete a specific live hash associated to a given account.
///  *
///  * This transaction MUST be signed by either the key of the associated account,
///  * or at least one of the keys listed in the live hash.
///  *
///  * ### Block Stream Effects
///  * None
class HederaCryptoDeleteLiveHashTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * An account associated to a live hash.
  final proto_basic_types.HederaAccountID? accountOfLiveHash;

  /// *
  ///      * The SHA-384 value of a specific live hash to delete.
  final List<int>? liveHashToDelete;

  const HederaCryptoDeleteLiveHashTransactionBody({
    this.accountOfLiveHash,
    this.liveHashToDelete,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [accountOfLiveHash, liveHashToDelete];

  HederaCryptoDeleteLiveHashTransactionBody copyWith({
    proto_basic_types.HederaAccountID? accountOfLiveHash,

    List<int>? liveHashToDelete,
  }) {
    return HederaCryptoDeleteLiveHashTransactionBody(
      accountOfLiveHash: accountOfLiveHash ?? this.accountOfLiveHash,
      liveHashToDelete: liveHashToDelete ?? this.liveHashToDelete,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'accountOfLiveHash': config.encodeMessage(accountOfLiveHash),
      'liveHashToDelete': config.encodeBinary(liveHashToDelete),
    };
  }

  factory HederaCryptoDeleteLiveHashTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoDeleteLiveHashTransactionBody(
      accountOfLiveHash: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'accountOfLiveHash',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      liveHashToDelete: config.decodeBinary<List<int>?>(
        json.valueAs(
          'liveHashToDelete',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaCryptoDeleteLiveHashTransactionBody.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoDeleteLiveHashTransactionBody(
      accountOfLiveHash: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      liveHashToDelete: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoDeleteLiveHashTransactionBody;
}

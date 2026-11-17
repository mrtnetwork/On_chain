import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Crypto Delete
///  * Message to delete an account.
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
///  * Delete an account.&lt;br/&gt;
///  * This will mark an account deleted, and transfer all tokens to a "sweep"
///  * account.
///  *
///  * A deleted account SHALL NOT hold a balance in any token type.&lt;br/&gt;
///  * A deleted account SHALL remain in state until it expires.&lt;br/&gt;
///  * Transfers that would increase the balance of a deleted account
///  * SHALL fail.&lt;br/&gt;
///  * A deleted account MAY be subject of a `cryptoUpdate` transaction to extend
///  * its expiration.&lt;br/&gt;
///  * When a deleted account expires it SHALL be removed entirely, and SHALL NOT
///  * be archived.
///  *
///  * ### Block Stream Effects
///  * None
class HederaCryptoDeleteTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * The identified account SHALL receive all tokens, token balances,
  ///      * and non-fungible/unique from the deleted account.&lt;br/&gt;
  ///      * The identified account MUST sign this transaction.&lt;br/&gt;
  ///      * If not set, the account to be deleted MUST NOT have a balance in any
  ///      * token, a balance in HBAR, or hold any NFT.
  final proto_basic_types.HederaAccountID? transferAccountID;

  /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * This account SHALL be deleted if this transaction succeeds.&lt;br/&gt;
  ///      * This account SHOULD NOT hold any balance other than HBAR.&lt;br/&gt;
  ///      * If this account _does_ hold balances, the `transferAccountID` value
  ///      * MUST be set to a valid transfer account.&lt;br/&gt;
  ///      * This account MUST sign this transaction.&lt;br/&gt;
  ///      * This field MUST be set to a valid account identifier.
  final proto_basic_types.HederaAccountID? deleteAccountID;

  const HederaCryptoDeleteTransactionBody({
    this.transferAccountID,
    this.deleteAccountID,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [transferAccountID, deleteAccountID];

  HederaCryptoDeleteTransactionBody copyWith({
    proto_basic_types.HederaAccountID? transferAccountID,

    proto_basic_types.HederaAccountID? deleteAccountID,
  }) {
    return HederaCryptoDeleteTransactionBody(
      transferAccountID: transferAccountID ?? this.transferAccountID,
      deleteAccountID: deleteAccountID ?? this.deleteAccountID,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transferAccountID': config.encodeMessage(transferAccountID),
      'deleteAccountID': config.encodeMessage(deleteAccountID),
    };
  }

  factory HederaCryptoDeleteTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoDeleteTransactionBody(
      transferAccountID: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'transferAccountID',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      deleteAccountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'deleteAccountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaCryptoDeleteTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoDeleteTransactionBody(
      transferAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      deleteAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoDeleteTransactionBody;
}

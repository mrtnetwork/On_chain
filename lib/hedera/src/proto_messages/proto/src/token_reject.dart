import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Token Reject
///  * Messages used to implement a transaction to reject a token type from an
///  * account.
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
///  * Reject undesired token(s).&lt;br/&gt;
///  * Transfer one or more token balances held by the requesting account to the
///  * treasury for each token type.
///  *
///  * Each transfer SHALL be one of the following
///  * - A single non-fungible/unique token.
///  * - The full balance held for a fungible/common token.
///  * A single `tokenReject` transaction SHALL support a maximum
///  * of 10 transfers.&lt;br/&gt;
///  * A token that is `pause`d MUST NOT be rejected.&lt;br/&gt;
///  * If the `owner` account is `frozen` with respect to the identified token(s)
///  * the token(s) MUST NOT be rejected.&lt;br/&gt;
///  * The `payer` for this transaction, and `owner` if set, SHALL NOT be charged
///  * any custom fees or other fees beyond the `tokenReject` transaction fee.
///  *
///  * ### Block Stream Effects
///  * - Each successful transfer from `payer` to `treasury` SHALL be recorded in
///  *   the `token_transfer_list` for the transaction record.
class HederaTokenRejectTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * An account identifier.&lt;br/&gt;
  ///      * This OPTIONAL field identifies the account holding the
  ///      * tokens to be rejected.
  ///      * &lt;p&gt;
  ///      * If set, this account MUST sign this transaction.
  ///      * If not set, the `payer` for this transaction SHALL be the effective
  ///      * `owner` for this transaction.
  final proto_basic_types.HederaAccountID? owner;

    /// *
  ///      * A list of one or more token rejections.
  ///      * &lt;p&gt;
  ///      * On success each rejected token serial number or balance SHALL be
  ///      * transferred from the requesting account to the treasury account for
  ///      * that token type.&lt;br/&gt;
  ///      * After rejection the requesting account SHALL continue to be associated
  ///      * with the token.&lt;br/&gt;
  ///      * If dissociation is desired then a separate `TokenDissociate` transaction
  ///      * MUST be submitted to remove the association.&lt;br/&gt;
  ///      * This list MUST contain at least one (1) entry and MUST NOT contain more
  ///      * than ten (10) entries.
  final List<HederaTokenReference> rejections;

  const HederaTokenRejectTransactionBody({
    this.owner,
    this.rejections = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        owner,
        rejections,
      ];


HederaTokenRejectTransactionBody copyWith(
{proto_basic_types.HederaAccountID? owner,

List<HederaTokenReference>? rejections,

}) {
    return HederaTokenRejectTransactionBody(
owner: owner ?? this.owner,
rejections: rejections ?? this.rejections,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'owner': config.encodeMessage(owner),
      'rejections': rejections.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaTokenRejectTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenRejectTransactionBody(
      owner: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'owner',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      rejections: (json.valueEnsureAsList<dynamic>('rejections', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaTokenReference, Object>(
          value: e,
          parse: (v) => HederaTokenReference.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaTokenRejectTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenRejectTransactionBody(
      owner: decode.messageTo<proto_basic_types.HederaAccountID?>(1, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      rejections: decode.getListOfBytes(2).map((b) => HederaTokenReference.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenRejectTransactionBody;

}


/// *
///  * A union token identifier.
///  *
///  * Identify a fungible/common token type, or a single
///  * non-fungible/unique token serial.
class HederaTokenReference extends HederaProtoMessage with Equality {
    /// *
  ///          * A fungible/common token type.
  final proto_basic_types.HederaTokenID? fungibleToken;

    /// *
  ///          * A single specific serialized non-fungible/unique token.
  final proto_basic_types.HederaNftID? nft;

  const HederaTokenReference({
    this.fungibleToken,
    this.nft,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fungibleToken,
        nft,
      ];


HederaTokenReference copyWith(
{proto_basic_types.HederaTokenID? fungibleToken,

proto_basic_types.HederaNftID? nft,

}) {
    return HederaTokenReference(
fungibleToken: fungibleToken ?? this.fungibleToken,
nft: nft ?? this.nft,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'fungible_token': config.encodeMessage(fungibleToken),
      'nft': config.encodeMessage(nft),
    };
  }


  factory HederaTokenReference.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenReference(
      fungibleToken: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'fungible_token',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      nft: json.valueTo<proto_basic_types.HederaNftID?, Object>(
        key: 'nft',
        parse: (v) => proto_basic_types.HederaNftID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaTokenReference.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenReference(
      fungibleToken: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      nft: decode.messageTo<proto_basic_types.HederaNftID?>(2, (b) => proto_basic_types.HederaNftID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenReference;

}



import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Token Mint
///  * Mint new tokens and deliver them to the token treasury. This is akin
///  * to how a fiat treasury will mint new coinage for circulation.
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
///  * Mint tokens and deliver the new tokens to the token treasury account.
///  *
///  * The token MUST have a `supply_key` set and that key MUST NOT
///  * be an empty `KeyList`.&lt;br/&gt;
///  * The token `supply_key` MUST sign this transaction.&lt;br/&gt;
///  * This operation SHALL increase the total supply for the token type by
///  * the number of tokens "minted".&lt;br/&gt;
///  * The total supply for the token type MUST NOT be increased above the
///  * maximum supply limit (2^63-1) by this transaction.&lt;br/&gt;
///  * The tokens minted SHALL be credited to the token treasury account.&lt;br/&gt;
///  * If the token is a fungible/common type, the amount MUST be specified.&lt;br/&gt;
///  * If the token is a non-fungible/unique type, the metadata bytes for each
///  * unique token MUST be specified in the `metadata` list.&lt;br/&gt;
///  * Each unique metadata MUST not exceed the global metadata size limit defined
///  * by the network configuration value `tokens.maxMetadataBytes`.&lt;br/&gt;
///  * The global batch size limit (`tokens.nfts.maxBatchSizeMint`) SHALL set
///  * the maximum number of individual NFT metadata permitted in a single
///  * `tokenMint` transaction.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenMintTransactionBody extends HederaProtoMessage with Equality {
  /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the token type to "mint".&lt;br/&gt;
  ///      * The identified token MUST exist, and MUST NOT be deleted.
  final proto_basic_types.HederaTokenID? token;

  /// *
  ///      * An amount to mint to the Treasury Account.
  ///      * &lt;p&gt;
  ///      * This is interpreted as an amount in the smallest possible denomination
  ///      * for the token (10&lt;sup&gt;-decimals&lt;/sup&gt; whole tokens).&lt;br/&gt;
  ///      * The balance for the token treasury account SHALL receive the newly
  ///      * minted tokens.&lt;br/&gt;
  ///      * If this value is equal to zero (`0`), the token SHOULD be a
  ///      * non-fungible/unique type.&lt;br/&gt;
  ///      * If this value is non-zero, the token MUST be a fungible/common type.
  final BigInt? amount;

  /// *
  ///      * A list of metadata bytes.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * One non-fungible/unique token SHALL be minted for each entry
  ///      * in this list.&lt;br/&gt;
  ///      * Each entry in this list MUST NOT be larger than the limit set by the
  ///      * current network configuration value `tokens.maxMetadataBytes`.&lt;br/&gt;
  ///      * This list MUST NOT contain more entries than the current limit set by
  ///      * the network configuration value `tokens.nfts.maxBatchSizeMint`.&lt;br/&gt;
  ///      * If this list is not empty, the token MUST be a
  ///      * non-fungible/unique type.&lt;br/&gt;
  ///      * If this list is empty, the token MUST be a fungible/common type.
  final List<List<int>> metadata;

  const HederaTokenMintTransactionBody({
    this.token,
    this.amount,
    this.metadata = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.bytes,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [token, amount, metadata];

  HederaTokenMintTransactionBody copyWith({
    proto_basic_types.HederaTokenID? token,

    BigInt? amount,

    List<List<int>>? metadata,
  }) {
    return HederaTokenMintTransactionBody(
      token: token ?? this.token,
      amount: amount ?? this.amount,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'token': config.encodeMessage(token),
      'amount': config.encodeBigint(amount),
      'metadata': metadata.map((e) => config.encodeBinary(e)).toList(),
    };
  }

  factory HederaTokenMintTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenMintTransactionBody(
      token: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      metadata:
          (json.valueEnsureAsList<dynamic>(
            'metadata',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
    );
  }

  factory HederaTokenMintTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenMintTransactionBody(
      token: decode.messageTo<proto_basic_types.HederaTokenID?>(
        1,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      amount: decode.getBigInt<BigInt?>(2),
      metadata: decode.getListOfBytes(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenMintTransactionBody;
}

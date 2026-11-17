import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Token Burn
///  * Permanently remove tokens from circulation, akin to how a fiat treasury
///  * will physically burn worn out bank notes.
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
///  * Burns tokens from the Token's treasury Account.
///  *
///  * The token MUST have a `supply_key` set and that key MUST NOT
///  * be an empty `KeyList`.&lt;br/&gt;
///  * The token `supply_key` MUST sign this transaction.&lt;br/&gt;
///  * This operation SHALL decrease the total supply for the token type by
///  * the number of tokens "burned".&lt;br/&gt;
///  * The total supply for the token type MUST NOT be reduced below zero (`0`)
///  * by this transaction.&lt;br/&gt;
///  * The tokens to burn SHALL be deducted from the token treasury account.&lt;br/&gt;
///  * If the token is a fungible/common type, the amount MUST be specified.&lt;br/&gt;
///  * If the token is a non-fungible/unique type, the specific serial numbers
///  * MUST be specified.&lt;br/&gt;
///  * The global batch size limit (`tokens.nfts.maxBatchSizeBurn`) SHALL set
///  * the maximum number of individual NFT serial numbers permitted in a single
///  * `tokenBurn` transaction.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenBurnTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the token type to "burn".&lt;br/&gt;
  ///      * The identified token MUST exist, and MUST NOT be deleted.
  final proto_basic_types.HederaTokenID? token;

    /// *
  ///      * An amount to burn from the Treasury Account.
  ///      * &lt;p&gt;
  ///      * This is interpreted as an amount in the smallest possible denomination
  ///      * for the token (10&lt;sup&gt;-decimals&lt;/sup&gt; whole tokens).&lt;br/&gt;
  ///      * The balance for the token treasury account MUST contain sufficient
  ///      * tokens to complete this transaction with a non-negative balance.&lt;br/&gt;
  ///      * If this value is equal to zero (`0`), the token SHOULD be a
  ///      * non-fungible/unique type.&lt;br/&gt;
  ///      * If this value is non-zero, the token MUST be a fungible/common type.
  final BigInt? amount;

    /// *
  ///      * A list of serial numbers to burn from the Treasury Account.
  ///      * &lt;p&gt;
  ///      * This list MUST NOT contain more entries than the current limit set by
  ///      * the network configuration value `tokens.nfts.maxBatchSizeBurn`.&lt;br/&gt;
  ///      * The treasury account for the token MUST hold each unique token
  ///      * identified in this list.&lt;br/&gt;
  ///      * If this list is not empty, the token MUST be a
  ///      * non-fungible/unique type.&lt;br/&gt;
  ///      * If this list is empty, the token MUST be a fungible/common type.
  final List<BigInt> serialNumbers;

  const HederaTokenBurnTransactionBody({
    this.token,
    this.amount,
    this.serialNumbers = const [],
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
          elementType: ProtoFieldType.int64,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        token,
        amount,
        serialNumbers,
      ];


HederaTokenBurnTransactionBody copyWith(
{proto_basic_types.HederaTokenID? token,

BigInt? amount,

List<BigInt>? serialNumbers,

}) {
    return HederaTokenBurnTransactionBody(
token: token ?? this.token,
amount: amount ?? this.amount,
serialNumbers: serialNumbers ?? this.serialNumbers,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token': config.encodeMessage(token),
      'amount': config.encodeBigint(amount),
      'serialNumbers': serialNumbers.map((e) => config.encodeBigint(e)).toList(),
    };
  }


  factory HederaTokenBurnTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenBurnTransactionBody(
      token: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
      serialNumbers: (json.valueEnsureAsList<dynamic>('serialNumbers', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
    );
  }

  factory HederaTokenBurnTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenBurnTransactionBody(
      token: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      amount: decode.getBigInt<BigInt?>(2),
      serialNumbers: decode.getListOrEmpty<BigInt>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenBurnTransactionBody;

}



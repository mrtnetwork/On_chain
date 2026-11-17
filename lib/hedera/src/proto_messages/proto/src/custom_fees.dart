import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Custom Fees
///  * Fees defined by token creators that are charged as part of each
///  * transfer of that token type.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.transaction"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A descriptor for a fee based on a portion of the tokens transferred.
///  *
///  * This fee option describes fees as a fraction of the amount of
///  * fungible/common token(s) transferred.  The fee also describes a minimum
///  * and maximum amount, both of which are OPTIONAL.
///  *
///  * This type of fee SHALL be assessed only for fungible/common tokens.&lt;br/&gt;
///  * This type of fee MUST NOT be defined for a non-fungible/unique
///  * token type.&lt;br/&gt;
///  * This fee SHALL be paid with the same type of tokens as those
///  * transferred.&lt;br/&gt;
///  * The fee MAY be subtracted from the transferred tokens, or MAY be assessed
///  * to the sender in addition to the tokens actually transferred, based on
///  * the `net_of_transfers` field.
///  *
///  * When a single transaction sends tokens from one sender to multiple
///  * recipients, and the `net_of_transfers` flag is false, the network
///  * SHALL attempt to evenly assess the total fee across all recipients
///  * proportionally. This may be inexact and, particularly when there are
///  * large differences between recipients, MAY result in small deviations
///  * from an ideal "fair" distribution.&lt;br/&gt;
///  * If the sender lacks sufficient tokens to pay fees, or the assessment
///  * of custom fees reduces the net amount transferred to or below zero,
///  * the transaction MAY fail due to insufficient funds to pay all fees.
class HederaFractionalFee extends HederaProtoMessage with Equality {
    /// *
  ///      * A Fraction of the transferred tokens to assess as a fee.&lt;br/&gt;
  ///      * This value MUST be less than or equal to one.&lt;br/&gt;
  ///      * This value MUST be greater than zero.
  final proto_basic_types.HederaFraction? fractionalAmount;

    /// *
  ///      * A minimum fee to charge, in units of 10&lt;sup&gt;-decimals&lt;/sup&gt; tokens.
  ///      * &lt;p&gt;
  ///      * This value is OPTIONAL, with a default of `0` indicating no minimum.&lt;br/&gt;
  ///      * If set, this value MUST be greater than zero.&lt;br/&gt;
  ///      * If set, all transfers SHALL pay at least this amount.
  final BigInt? minimumAmount;

    /// *
  ///      * A maximum fee to charge, in units of 10&lt;sup&gt;-decimals&lt;/sup&gt; tokens.
  ///      * &lt;p&gt;
  ///      * This value is OPTIONAL, with a default of `0` indicating no maximum.&lt;br/&gt;
  ///      * If set, this value MUST be greater than zero.&lt;br/&gt;
  ///      * If set, any fee charged SHALL NOT exceed this value.&lt;br/&gt;
  ///      * This value SHOULD be strictly greater than `minimum_amount`.
  ///      * If this amount is less than or equal to `minimum_amount`, then
  ///      * the fee charged SHALL always be equal to this value and
  ///      * `fractional_amount` SHALL NOT have any effect.
  final BigInt? maximumAmount;

    /// *
  ///      * Flag requesting to assess the calculated fee against the sender,
  ///      * without reducing the amount transferred.&lt;br/&gt;
  ///      * #### Effects of this flag
  ///      * &lt;ol&gt;
  ///      *   &lt;li&gt;If this value is true
  ///      *     &lt;ul&gt;
  ///      *       &lt;li&gt;The receiver of a transfer SHALL receive the entire
  ///      *           amount sent.&lt;/li&gt;
  ///      *       &lt;li&gt;The fee SHALL be charged to the sender as an additional
  ///      *           amount, increasing the token transfer debit.&lt;/li&gt;
  ///      *     &lt;/ul&gt;
  ///      *   &lt;/li&gt;
  ///      *   &lt;li&gt;If this value is false
  ///      *     &lt;ul&gt;
  ///      *       &lt;li&gt;The receiver of a transfer SHALL receive the amount sent
  ///      *           _after_ deduction of the calculated fee.&lt;/li&gt;
  ///      *     &lt;/ul&gt;
  ///      *   &lt;/li&gt;
  ///      * &lt;/ol&gt;
  final bool? netOfTransfers;

  const HederaFractionalFee({
    this.fractionalAmount,
    this.minimumAmount,
    this.maximumAmount,
    this.netOfTransfers,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bool(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fractionalAmount,
        minimumAmount,
        maximumAmount,
        netOfTransfers,
      ];


HederaFractionalFee copyWith(
{proto_basic_types.HederaFraction? fractionalAmount,

BigInt? minimumAmount,

BigInt? maximumAmount,

bool? netOfTransfers,

}) {
    return HederaFractionalFee(
fractionalAmount: fractionalAmount ?? this.fractionalAmount,
minimumAmount: minimumAmount ?? this.minimumAmount,
maximumAmount: maximumAmount ?? this.maximumAmount,
netOfTransfers: netOfTransfers ?? this.netOfTransfers,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'fractional_amount': config.encodeMessage(fractionalAmount),
      'minimum_amount': config.encodeBigint(minimumAmount),
      'maximum_amount': config.encodeBigint(maximumAmount),
      'net_of_transfers': netOfTransfers,
    };
  }


  factory HederaFractionalFee.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFractionalFee(
      fractionalAmount: json.valueTo<proto_basic_types.HederaFraction?, Object>(
        key: 'fractional_amount',
        parse: (v) => proto_basic_types.HederaFraction.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      minimumAmount: json.valueAsBigInt<BigInt?>('minimum_amount', normalizeKeyLookup: config.normalizeKeys),
      maximumAmount: json.valueAsBigInt<BigInt?>('maximum_amount', normalizeKeyLookup: config.normalizeKeys),
      netOfTransfers: json.valueAsBool<bool?>('net_of_transfers', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaFractionalFee.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFractionalFee(
      fractionalAmount: decode.messageTo<proto_basic_types.HederaFraction?>(1, (b) => proto_basic_types.HederaFraction.deserialize(b)),
      minimumAmount: decode.getBigInt<BigInt?>(2),
      maximumAmount: decode.getBigInt<BigInt?>(3),
      netOfTransfers: decode.getBool<bool?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFractionalFee;

}


/// *
///  * A fixed fee to assess for each token transfer, regardless of the
///  * amount transferred.&lt;br/&gt;
///  * This fee type describes a fixed fee for each transfer of a token type.
///  *
///  * The fee SHALL be charged to the `sender` for the token transfer
///  * transaction.&lt;br/&gt;
///  * This fee MAY be assessed in HBAR, the token type transferred, or any
///  * other token type, as determined by the `denominating_token_id` field.
class HederaFixedFee extends HederaProtoMessage with Equality {
    /// *
  ///      * The amount to assess for each transfer.
  ///      * &lt;p&gt;
  ///      * This value MUST be greater than `0`.&lt;br/&gt;
  ///      * This amount is expressed in units of 10&lt;sup&gt;-decimals&lt;/sup&gt; tokens.
  final BigInt? amount;

    /// *
  ///      * The token type used to pay the assessed fee.
  ///      * &lt;p&gt;
  ///      * If this is unset, the fee SHALL be assessed in HBAR.&lt;br/&gt;
  ///      * If this is set, the fee SHALL be assessed in the token identified.
  ///      * This MAY be any token type. Custom fees assessed in other token types
  ///      * are more likely to fail, however, and it is RECOMMENDED that token
  ///      * creators denominate custom fees in the transferred token, HBAR, or
  ///      * well documented and closely related token types.&lt;br/&gt;
  ///      * If this value is set to `0.0.0` in the `tokenCreate` transaction, it
  ///      * SHALL be replaced with the `TokenID` of the newly created token.
  final proto_basic_types.HederaTokenID? denominatingTokenId;

  const HederaFixedFee({
    this.amount,
    this.denominatingTokenId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        amount,
        denominatingTokenId,
      ];


HederaFixedFee copyWith(
{BigInt? amount,

proto_basic_types.HederaTokenID? denominatingTokenId,

}) {
    return HederaFixedFee(
amount: amount ?? this.amount,
denominatingTokenId: denominatingTokenId ?? this.denominatingTokenId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'amount': config.encodeBigint(amount),
      'denominating_token_id': config.encodeMessage(denominatingTokenId),
    };
  }


  factory HederaFixedFee.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFixedFee(
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
      denominatingTokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'denominating_token_id',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaFixedFee.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFixedFee(
      amount: decode.getBigInt<BigInt?>(1),
      denominatingTokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(2, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFixedFee;

}


/// *
///  * A fee to assess during a CryptoTransfer that changes ownership of a
///  * non-fungible/unique (NFT) token.&lt;br/&gt;
///  * This message defines the fraction of the fungible value exchanged for an
///  * NFT that the ledger should collect as a royalty.
///  * "Fungible value" includes both HBAR (ℏ) and units of fungible HTS tokens.
///  * When the NFT sender does not receive any fungible value, the ledger will
///  * assess the fallback fee, if present, to the new NFT owner. Royalty fees
///  * can only be added to non-fungible/unique tokens.
///  *
///  * #### Important Note
///  * &gt; Users should be aware that native royalty fees are _strictly_ a
///  * &gt; convenience feature, SHALL NOT be guaranteed, and the network SHALL NOT
///  * &gt; enforce _inescapable_ royalties on the exchange of a unique NFT.&lt;br/&gt;
///  * &gt; For _one_ example, if the counterparties agree to split their value
///  * &gt; transfer and NFT exchange into separate transactions, the network cannot
///  * &gt; possibly determine the value exchanged. Even trustless transactions,
///  * &gt; using a smart contract or other form of escrow, can arrange such split
///  * &gt; transactions as a single _logical_ transfer.
///  *
///  * Counterparties that wish to _respect_ creator royalties MUST follow the
///  * pattern the network recognizes.
///  * &lt;div style="margin-left: 2em; margin-top: -0.8em"&gt;
///  * A single transaction MUST contain all three elements, transfer of the NFT,
///  * debit of fungible value from the receiver, and credit of fungible value to
///  * the sender, in order for the network to accurately assess royalty fees.
///  * &lt;/div&gt;
///  * &lt;div style="margin-left: 1em; margin-top: -0.8em"&gt;
///  * Two examples are presented here.
///  * &lt;div style="margin-left: 1em"&gt;
///  * The NFT sender and receiver MUST both sign a single `cryptoTransfer` that
///  * transfers the NFT from sender to receiver, debits the fungible value from
///  * the receiver, and credits the sender with the fungible value the receiver
///  * is exchanging for the NFT.&lt;br/&gt;
///  * A marketplace using an approved spender account for an escrow transaction
///  * MUST credit the account selling the NFT in the same `cryptoTransfer`
///  * transaction that transfers the NFT to, and deducts fungible value from,
///  * the buying account.
///  * &lt;/div&gt;&lt;/div&gt;
///  * This type of fee MAY NOT produce accurate results if multiple transfers
///  * are executed in a single transaction. It is RECOMMENDED that each
///  * NFT subject to royalty fees be transferred separately and without
///  * unrelated fungible token transfers.
///  *
///  * The network SHALL NOT consider third-party transfers, including
///  * "approved spender" accounts, in collecting royalty fees. An honest
///  * broker MUST ensure that transfer of an NFT and payment delivered to
///  * the sender are present in the same transaction.
///  * There is an
///  * [open suggestion](https://github.com/hashgraph/hedera-improvement-proposal/discussions/578)
///  * that proposes to broaden the scope of transfers from which the network
///  * automatically collects royalties to cover related third parties. If this
///  * interests or concerns you, please add your voice to that discussion.
class HederaRoyaltyFee extends HederaProtoMessage with Equality {
    /// *
  ///      * The fraction of fungible value exchanged for an NFT to collect
  ///      * as royalty.
  ///      * &lt;p&gt;
  ///      * This SHALL be applied once to the total fungible value transferred
  ///      * for the transaction.&lt;br/&gt;
  ///      * There SHALL NOT be any adjustment based on multiple transfers
  ///      * involving the NFT sender as part of a single transaction.
  final proto_basic_types.HederaFraction? exchangeValueFraction;

    /// *
  ///      * A fixed fee to assess if no fungible value is known to be traded
  ///      * for the NFT.
  ///      * &lt;p&gt;
  ///      * If an NFT is transferred without a corresponding transfer of
  ///      * _fungible_ value returned in the same transaction, the network
  ///      * SHALL charge this fee as a fallback.&lt;br/&gt;
  ///      * Fallback fees MAY have unexpected effects when interacting with
  ///      * escrow, market transfers, and smart contracts.
  ///      * It is RECOMMENDED that developers carefully consider possible
  ///      * effects from fallback fees when designing systems that facilitate
  ///      * the transfer of NFTs.
  final HederaFixedFee? fallbackFee;

  const HederaRoyaltyFee({
    this.exchangeValueFraction,
    this.fallbackFee,
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
        exchangeValueFraction,
        fallbackFee,
      ];


HederaRoyaltyFee copyWith(
{proto_basic_types.HederaFraction? exchangeValueFraction,

HederaFixedFee? fallbackFee,

}) {
    return HederaRoyaltyFee(
exchangeValueFraction: exchangeValueFraction ?? this.exchangeValueFraction,
fallbackFee: fallbackFee ?? this.fallbackFee,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'exchange_value_fraction': config.encodeMessage(exchangeValueFraction),
      'fallback_fee': config.encodeMessage(fallbackFee),
    };
  }


  factory HederaRoyaltyFee.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRoyaltyFee(
      exchangeValueFraction: json.valueTo<proto_basic_types.HederaFraction?, Object>(
        key: 'exchange_value_fraction',
        parse: (v) => proto_basic_types.HederaFraction.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      fallbackFee: json.valueTo<HederaFixedFee?, Object>(
        key: 'fallback_fee',
        parse: (v) => HederaFixedFee.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaRoyaltyFee.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRoyaltyFee(
      exchangeValueFraction: decode.messageTo<proto_basic_types.HederaFraction?>(1, (b) => proto_basic_types.HederaFraction.deserialize(b)),
      fallbackFee: decode.messageTo<HederaFixedFee?>(2, (b) => HederaFixedFee.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoRoyaltyFee;

}


/// *
///  * A transfer fee to assess during a CryptoTransfer.&lt;br/&gt;
///  * This fee applies to transactions that transfer units of the token to
///  * which the fee is attached. A custom fee may be either fixed or fractional,
///  * and must specify a fee collector account to receive the assessed fees.
///  *
///  * Custom fees MUST be greater than zero (0).
class HederaCustomFee extends HederaProtoMessage with Equality {
    /// *
  ///          * A fixed fee to be charged to the `sender` for every token transfer.
  ///          * &lt;p&gt;
  ///          * This type of fee MAY be defined for any token type.&lt;br/&gt;
  ///          * This type of fee MAY be more consistent and reliable than
  ///          * other types.
  final HederaFixedFee? fixedFee;

    /// *
  ///          * A fee defined as a fraction of the tokens transferred.
  ///          * &lt;p&gt;
  ///          * This type of fee MUST NOT be defined for a non-fungible/unique
  ///          * token type.&lt;br/&gt;
  ///          * This fee MAY be charged to either sender, as an increase to the
  ///          * amount sent, or receiver, as a reduction to the amount received.
  final HederaFractionalFee? fractionalFee;

    /// *
  ///          * A fee charged as royalty for any transfer of a
  ///          * non-fungible/unique token.
  ///          * &lt;p&gt;
  ///          * This type of fee MUST NOT be defined for a
  ///          * fungible/common token type.
  final HederaRoyaltyFee? royaltyFee;

    /// *
  ///      * The account to receive the custom fee.
  final proto_basic_types.HederaAccountID? feeCollectorAccountId;

    /// *
  ///      * Flag indicating to exempt all custom fee collector accounts for this
  ///      * token type from paying this custom fee when sending tokens.
  ///      * &lt;p&gt;
  ///      * The treasury account for a token, and the account identified by the
  ///      * `fee_collector_account_id` field of this `CustomFee` are always exempt
  ///      * from this custom fee to avoid redundant and unnecessary transfers.
  ///      * If this value is `true` then the account(s) identified in
  ///      * `fee_collector_account_id` for _all_ custom fee definitions for this
  ///      * token type SHALL also be exempt from this custom fee.
  ///      * This behavior is specified in HIP-573.
  final bool? allCollectorsAreExempt;

  const HederaCustomFee({
    this.fixedFee,
    this.fractionalFee,
    this.royaltyFee,
    this.feeCollectorAccountId,
    this.allCollectorsAreExempt,
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
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.bool(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fixedFee,
        fractionalFee,
        royaltyFee,
        feeCollectorAccountId,
        allCollectorsAreExempt,
      ];


HederaCustomFee copyWith(
{HederaFixedFee? fixedFee,

HederaFractionalFee? fractionalFee,

HederaRoyaltyFee? royaltyFee,

proto_basic_types.HederaAccountID? feeCollectorAccountId,

bool? allCollectorsAreExempt,

}) {
    return HederaCustomFee(
fixedFee: fixedFee ?? this.fixedFee,
fractionalFee: fractionalFee ?? this.fractionalFee,
royaltyFee: royaltyFee ?? this.royaltyFee,
feeCollectorAccountId: feeCollectorAccountId ?? this.feeCollectorAccountId,
allCollectorsAreExempt: allCollectorsAreExempt ?? this.allCollectorsAreExempt,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'fixed_fee': config.encodeMessage(fixedFee),
      'fractional_fee': config.encodeMessage(fractionalFee),
      'royalty_fee': config.encodeMessage(royaltyFee),
      'fee_collector_account_id': config.encodeMessage(feeCollectorAccountId),
      'all_collectors_are_exempt': allCollectorsAreExempt,
    };
  }


  factory HederaCustomFee.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCustomFee(
      fixedFee: json.valueTo<HederaFixedFee?, Object>(
        key: 'fixed_fee',
        parse: (v) => HederaFixedFee.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      fractionalFee: json.valueTo<HederaFractionalFee?, Object>(
        key: 'fractional_fee',
        parse: (v) => HederaFractionalFee.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      royaltyFee: json.valueTo<HederaRoyaltyFee?, Object>(
        key: 'royalty_fee',
        parse: (v) => HederaRoyaltyFee.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      feeCollectorAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'fee_collector_account_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      allCollectorsAreExempt: json.valueAsBool<bool?>('all_collectors_are_exempt', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaCustomFee.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCustomFee(
      fixedFee: decode.messageTo<HederaFixedFee?>(1, (b) => HederaFixedFee.deserialize(b)),
      fractionalFee: decode.messageTo<HederaFractionalFee?>(2, (b) => HederaFractionalFee.deserialize(b)),
      royaltyFee: decode.messageTo<HederaRoyaltyFee?>(4, (b) => HederaRoyaltyFee.deserialize(b)),
      feeCollectorAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(3, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      allCollectorsAreExempt: decode.getBool<bool?>(5),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoCustomFee;

}


/// *
///  * Description of a transfer added to a `cryptoTransfer` transaction that
///  * satisfies custom fee requirements.
///  *
///  * It is important to note that this is not the actual transfer. The transfer
///  * of value SHALL be merged into the original transaction to minimize the
///  * number of actual transfers. This descriptor presents the fee assessed
///  * separately in the record stream so that the details of the fee assessed
///  * are not hidden in this process.
class HederaAssessedCustomFee extends HederaProtoMessage with Equality {
    /// *
  ///      * An amount of tokens assessed for this custom fee.
  ///      * &lt;p&gt;
  ///      * This shall be expressed in units of 10&lt;sup&gt;-decimals&lt;/sup&gt; tokens.
  final BigInt? amount;

    /// *
  ///      * The token transferred to satisfy this fee.
  ///      * &lt;p&gt;
  ///      * If the token transferred is HBAR, this field SHALL NOT be set.
  final proto_basic_types.HederaTokenID? tokenId;

    /// *
  ///      * An account that received the fee assessed.
  ///      * &lt;p&gt;
  ///      * This SHALL NOT be the sender or receiver of the original
  ///      * cryptoTransfer transaction.
  final proto_basic_types.HederaAccountID? feeCollectorAccountId;

    /// *
  ///      * An account that provided the tokens assessed as a fee.
  ///      * &lt;p&gt;
  ///      * This SHALL be the account that _would have_ had a higher balance
  ///      * absent the fee. In most cases this SHALL be the `sender`, but
  ///      * some _fractional_ fees reduce the amount transferred, and in those
  ///      * cases the `receiver` SHALL be the effective payer for the fee.&lt;br/&gt;
  ///      * There are currently no situations where a third party pays a custom
  ///      * fee. This MAY change in a future release.
  final List<proto_basic_types.HederaAccountID> effectivePayerAccountId;

  const HederaAssessedCustomFee({
    this.amount,
    this.tokenId,
    this.feeCollectorAccountId,
    this.effectivePayerAccountId = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        amount,
        tokenId,
        feeCollectorAccountId,
        effectivePayerAccountId,
      ];


HederaAssessedCustomFee copyWith(
{BigInt? amount,

proto_basic_types.HederaTokenID? tokenId,

proto_basic_types.HederaAccountID? feeCollectorAccountId,

List<proto_basic_types.HederaAccountID>? effectivePayerAccountId,

}) {
    return HederaAssessedCustomFee(
amount: amount ?? this.amount,
tokenId: tokenId ?? this.tokenId,
feeCollectorAccountId: feeCollectorAccountId ?? this.feeCollectorAccountId,
effectivePayerAccountId: effectivePayerAccountId ?? this.effectivePayerAccountId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'amount': config.encodeBigint(amount),
      'token_id': config.encodeMessage(tokenId),
      'fee_collector_account_id': config.encodeMessage(feeCollectorAccountId),
      'effective_payer_account_id': effectivePayerAccountId.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaAssessedCustomFee.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAssessedCustomFee(
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token_id',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      feeCollectorAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'fee_collector_account_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      effectivePayerAccountId: (json.valueEnsureAsList<dynamic>('effective_payer_account_id', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaAccountID, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaAssessedCustomFee.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAssessedCustomFee(
      amount: decode.getBigInt<BigInt?>(1),
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(2, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      feeCollectorAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(3, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      effectivePayerAccountId: decode.getListOfBytes(4).map((b) => proto_basic_types.HederaAccountID.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoAssessedCustomFee;

}


/// *
///  * A custom fee definition for a consensus topic.
///  * &lt;p&gt;
///  * This fee definition is specific to an Hedera Consensus Service (HCS) topic
///  * and SHOULD NOT be used in any other context.&lt;br/&gt;
///  * All fields for this message are REQUIRED.&lt;br/&gt;
///  * Only "fixed" fee definitions are supported because there is no basis for
///  * a fractional fee on a consensus submit transaction.
class HederaFixedCustomFee extends HederaProtoMessage with Equality {
    /// *
  ///    * A fixed custom fee.
  ///    * &lt;p&gt;
  ///    * The amount of HBAR or other token described by this `FixedFee` SHALL
  ///    * be charged to the transction payer for each message submitted to a
  ///    * topic that assigns this consensus custom fee.
  final HederaFixedFee? fixedFee;

    /// *
  ///    * A collection account identifier.
  ///    * &lt;p&gt;
  ///    * All amounts collected for this consensus custom fee SHALL be transferred
  ///    * to the account identified by this field.
  final proto_basic_types.HederaAccountID? feeCollectorAccountId;

  const HederaFixedCustomFee({
    this.fixedFee,
    this.feeCollectorAccountId,
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
        fixedFee,
        feeCollectorAccountId,
      ];


HederaFixedCustomFee copyWith(
{HederaFixedFee? fixedFee,

proto_basic_types.HederaAccountID? feeCollectorAccountId,

}) {
    return HederaFixedCustomFee(
fixedFee: fixedFee ?? this.fixedFee,
feeCollectorAccountId: feeCollectorAccountId ?? this.feeCollectorAccountId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'fixed_fee': config.encodeMessage(fixedFee),
      'fee_collector_account_id': config.encodeMessage(feeCollectorAccountId),
    };
  }


  factory HederaFixedCustomFee.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFixedCustomFee(
      fixedFee: json.valueTo<HederaFixedFee?, Object>(
        key: 'fixed_fee',
        parse: (v) => HederaFixedFee.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      feeCollectorAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'fee_collector_account_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaFixedCustomFee.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFixedCustomFee(
      fixedFee: decode.messageTo<HederaFixedFee?>(1, (b) => HederaFixedFee.deserialize(b)),
      feeCollectorAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFixedCustomFee;

}


/// *
///  * A wrapper around a consensus custom fee list.&lt;br/&gt;
///  * This wrapper exists to enable an update transaction to differentiate between
///  *  a field that is not set and an empty list of custom fees.
///  * &lt;p&gt;
///  * An _unset_ field of this type SHALL NOT modify existing values.&lt;br/&gt;
///  * A _set_ field of this type with an empty `fees` list SHALL remove any
///  *  existing values.
class HederaFixedCustomFeeList extends HederaProtoMessage with Equality {
    /// *
  ///    * A set of custom fee definitions.&lt;br/&gt;
  ///    * These are fees to be assessed for each submit to a topic.
  final List<HederaFixedCustomFee> fees;

  const HederaFixedCustomFeeList({
    this.fees = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fees,
      ];


HederaFixedCustomFeeList copyWith(
{List<HederaFixedCustomFee>? fees,

}) {
    return HederaFixedCustomFeeList(
fees: fees ?? this.fees,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'fees': fees.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaFixedCustomFeeList.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFixedCustomFeeList(
      fees: (json.valueEnsureAsList<dynamic>('fees', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaFixedCustomFee, Object>(
          value: e,
          parse: (v) => HederaFixedCustomFee.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaFixedCustomFeeList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFixedCustomFeeList(
      fees: decode.getListOfBytes(1).map((b) => HederaFixedCustomFee.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFixedCustomFeeList;

}


/// *
///  * A wrapper for fee exempt key list.&lt;br/&gt;
///  * This wrapper exists to enable an update transaction to differentiate between
///  * a field that is not set and an empty list of keys.
///  * &lt;p&gt;
///  * An _unset_ field of this type SHALL NOT modify existing values.&lt;br/&gt;
///  * A _set_ field of this type with an empty `keys` list SHALL remove any
///  * existing values.
class HederaFeeExemptKeyList extends HederaProtoMessage with Equality {
    /// *
  ///    * A set of keys.&lt;br/&gt;
  ///    * The keys in this list are permitted to submit messages to the
  ///    * topic without paying the topic's custom fees.
  ///    * &lt;p&gt;
  ///    * If a submit transaction is signed by _any_ key included in this set,
  ///    * custom fees SHALL NOT be charged for that transaction.
  final List<proto_basic_types.HederaKey> keys;

  const HederaFeeExemptKeyList({
    this.keys = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        keys,
      ];


HederaFeeExemptKeyList copyWith(
{List<proto_basic_types.HederaKey>? keys,

}) {
    return HederaFeeExemptKeyList(
keys: keys ?? this.keys,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'keys': keys.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaFeeExemptKeyList.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFeeExemptKeyList(
      keys: (json.valueEnsureAsList<dynamic>('keys', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaKey, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaFeeExemptKeyList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFeeExemptKeyList(
      keys: decode.getListOfBytes(1).map((b) => proto_basic_types.HederaKey.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFeeExemptKeyList;

}


/// *
///  * A maximum custom fee that the user is willing to pay.
///  * &lt;p&gt;
///  * This message is used to specify the maximum custom fee that given user is
///  * willing to pay.
class HederaCustomFeeLimit extends HederaProtoMessage with Equality {
    /// *
  ///      * A payer account identifier.
  final proto_basic_types.HederaAccountID? accountId;

    /// *
  ///      * The maximum fees that the user is willing to pay for the message.
  final List<HederaFixedFee> fees;

  const HederaCustomFeeLimit({
    this.accountId,
    this.fees = const [],
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
        accountId,
        fees,
      ];


HederaCustomFeeLimit copyWith(
{proto_basic_types.HederaAccountID? accountId,

List<HederaFixedFee>? fees,

}) {
    return HederaCustomFeeLimit(
accountId: accountId ?? this.accountId,
fees: fees ?? this.fees,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'account_id': config.encodeMessage(accountId),
      'fees': fees.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaCustomFeeLimit.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCustomFeeLimit(
      accountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      fees: (json.valueEnsureAsList<dynamic>('fees', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaFixedFee, Object>(
          value: e,
          parse: (v) => HederaFixedFee.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaCustomFeeLimit.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCustomFeeLimit(
      accountId: decode.messageTo<proto_basic_types.HederaAccountID?>(1, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      fees: decode.getListOfBytes(2).map((b) => HederaFixedFee.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoCustomFeeLimit;

}



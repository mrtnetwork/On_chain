import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;

/// *
///  * # Exchange Rates
///  * Exchange rates that define ratios between HBAR and USD.
///  *
///  * Fees are denominated in USD, but paid in HBAR, so accurate exchange
///  * rates are important and the exchange rates kept in state are updated
///  * frequently.&lt;br/&gt;
///  * Exchange rates are also reported in every receipt for fee transparency.
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
///  * An exchange rate as a ratio of USD cents per HBAR.
///  *
///  * This ratio SHALL be used to convert tinycent (`10&lt;sup&gt;-8&lt;/sup&gt;` USD cent)
///  * to tinybar for fees and other purposes.&lt;br/&gt;
///  * When applying an `ExchangeRate`, implementations SHOULD ensure input values
///  * are `tinycent` and/or `tinybar` before applying the exchange ratio.&lt;br/&gt;
///  * Exchange results MAY be converted to USD or HBAR via division if whole
///  * unit values are required.
///  *
///  * The ratio described here SHALL be assigned such that a value in `tinybar`
///  * may be obtained with the following equation.
///  * ```
///  *   amountInTinybar = (amountInTinycent * hbarEquiv) / centEquiv
///  * ```
class HederaExchangeRate extends HederaProtoMessage with Equality {
    /// *
  ///      * Denominator for a ratio of USD cents per HBAR.
  final int? hbarEquiv;

    /// *
  ///      * Numerator for a ratio of USD cents per HBAR.
  final int? centEquiv;

    /// *
  ///      * Expiration time stamp for this exchange rate.
  final proto_timestamp.HederaTimestampSeconds? expirationTime;

  const HederaExchangeRate({
    this.hbarEquiv,
    this.centEquiv,
    this.expirationTime,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int32(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        hbarEquiv,
        centEquiv,
        expirationTime,
      ];


HederaExchangeRate copyWith(
{int? hbarEquiv,

int? centEquiv,

proto_timestamp.HederaTimestampSeconds? expirationTime,

}) {
    return HederaExchangeRate(
hbarEquiv: hbarEquiv ?? this.hbarEquiv,
centEquiv: centEquiv ?? this.centEquiv,
expirationTime: expirationTime ?? this.expirationTime,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'hbarEquiv': hbarEquiv,
      'centEquiv': centEquiv,
      'expirationTime': config.encodeMessage(expirationTime),
    };
  }


  factory HederaExchangeRate.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaExchangeRate(
      hbarEquiv: json.valueAsInt<int?>('hbarEquiv', normalizeKeyLookup: config.normalizeKeys),
      centEquiv: json.valueAsInt<int?>('centEquiv', normalizeKeyLookup: config.normalizeKeys),
      expirationTime: json.valueTo<proto_timestamp.HederaTimestampSeconds?, Object>(
        key: 'expirationTime',
        parse: (v) => proto_timestamp.HederaTimestampSeconds.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaExchangeRate.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaExchangeRate(
      hbarEquiv: decode.getInt<int?>(1),
      centEquiv: decode.getInt<int?>(2),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestampSeconds?>(3, (b) => proto_timestamp.HederaTimestampSeconds.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoExchangeRate;

}


/// *
///  * A set of two exchange rates.&lt;br/&gt;
///  * The exchange rate for the network is stored and reported as a set of
///  * two rates; current and next. This structure supports the network cleanly
///  * switching between exchange rates when necessary. This also provides clear
///  * notice to clients when the exchange rate will change and the exchange
///  * rate that will be applied for the next time period.
///  *
///  * The difference in rate between `currentRate` and `nextRate` MUST NOT exceed
///  * the configured maximum percentage change. This limit SHALL be a
///  * network configuration value.
class HederaExchangeRateSet extends HederaProtoMessage with Equality {
    /// *
  ///      * A current exchange rate.
  ///      * &lt;p&gt;
  ///      * When present in a receipt, this SHALL be the exchange rate used to
  ///      * compute the fees for that transaction.
  final HederaExchangeRate? currentRate;

    /// *
  ///      * A future exchange rate.
  ///      * &lt;p&gt;
  ///      * This exchange rate SHALL be applied after the current exchange
  ///      * rate expires.
  final HederaExchangeRate? nextRate;

  const HederaExchangeRateSet({
    this.currentRate,
    this.nextRate,
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
        currentRate,
        nextRate,
      ];


HederaExchangeRateSet copyWith(
{HederaExchangeRate? currentRate,

HederaExchangeRate? nextRate,

}) {
    return HederaExchangeRateSet(
currentRate: currentRate ?? this.currentRate,
nextRate: nextRate ?? this.nextRate,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'currentRate': config.encodeMessage(currentRate),
      'nextRate': config.encodeMessage(nextRate),
    };
  }


  factory HederaExchangeRateSet.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaExchangeRateSet(
      currentRate: json.valueTo<HederaExchangeRate?, Object>(
        key: 'currentRate',
        parse: (v) => HederaExchangeRate.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      nextRate: json.valueTo<HederaExchangeRate?, Object>(
        key: 'nextRate',
        parse: (v) => HederaExchangeRate.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaExchangeRateSet.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaExchangeRateSet(
      currentRate: decode.messageTo<HederaExchangeRate?>(1, (b) => HederaExchangeRate.deserialize(b)),
      nextRate: decode.messageTo<HederaExchangeRate?>(2, (b) => HederaExchangeRate.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoExchangeRateSet;

}



import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # State Common
///  * Two older messages used in rare cases.
///  * - EntityNumber is used to store The last used entity number in state, so
///  *   that all entities in state have unique entity numbers, even across types.
///  * - EntityIDPair is used to store a Token/Account pair in certain rare cases.
///  *
///  * Where possible, these messages SHOULD NOT be used.  A primitive `int64` or
///  * `google.protobuf.Int64Value` wrapper is preferred instead of `EntityNumber
///  * and `TokenAssociation` is preferred instead of `EntityIDPair`.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.common"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A single 64-bit number identifying a Hedera native entity.
///  *
///  * Deprecated.&lt;br/&gt;
///  * A primitive `int64` or `google.protobuf.Int64Value` wrapper is preferred.
class HederaEntityNumber extends HederaProtoMessage with Equality {
  /// *
  ///      * The entity number to store.
  final BigInt? number;

  const HederaEntityNumber({this.number});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [ProtoFieldConfig.int64(1)],
    );
  }

  @override
  List<Object?> get protoValues => [number];

  HederaEntityNumber copyWith({BigInt? number}) {
    return HederaEntityNumber(number: number ?? this.number);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'number': config.encodeBigint(number)};
  }

  factory HederaEntityNumber.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEntityNumber(
      number: json.valueAsBigInt<BigInt?>(
        'number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaEntityNumber.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEntityNumber(number: decode.getBigInt<BigInt?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoEntityNumber;
}

/// *
///  * A Pair of AccountID and TokenID.&lt;br/&gt;
///  * This is used as a key in certain cases.
///  *
///  * Deprecated.&lt;br/&gt;
///  * The TokenAssociation message should be used instead of this message.
class HederaEntityIDPair extends HederaProtoMessage with Equality {
  /// *
  ///      * An account identifier for the associated account.
  final proto_basic_types.HederaAccountID? accountId;

  /// *
  ///      * A token identifier for the associated token.
  final proto_basic_types.HederaTokenID? tokenId;

  const HederaEntityIDPair({this.accountId, this.tokenId});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [accountId, tokenId];

  HederaEntityIDPair copyWith({
    proto_basic_types.HederaAccountID? accountId,

    proto_basic_types.HederaTokenID? tokenId,
  }) {
    return HederaEntityIDPair(
      accountId: accountId ?? this.accountId,
      tokenId: tokenId ?? this.tokenId,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'account_id': config.encodeMessage(accountId),
      'token_id': config.encodeMessage(tokenId),
    };
  }

  factory HederaEntityIDPair.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEntityIDPair(
      accountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token_id',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaEntityIDPair.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEntityIDPair(
      accountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(
        2,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoEntityIDPair;
}

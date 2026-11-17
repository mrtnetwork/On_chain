import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;

/// -
///  * ‌
///  * Hedera Network Services Protobuf
///  * ​
///  * Copyright (C) 2018 - 2021 Hedera Hashgraph, LLC
///  * ​
///  * Licensed under the Apache License, Version 2.0 (the "License");
///  * you may not use this file except in compliance with the License.
///  * You may obtain a copy of the License at
///  *
///  *      http://www.apache.org/licenses/LICENSE-2.0
///  *
///  * Unless required by applicable law or agreed to in writing, software
///  * distributed under the License is distributed on an "AS IS" BASIS,
///  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  * See the License for the specific language governing permissions and
///  * limitations under the License.
///  * ‍
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.streams"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
class HederaTokenUnitBalance extends HederaProtoMessage with Equality {
    /// *
  ///      * A unique token id
  final proto_basic_types.HederaTokenID? tokenId;

    /// *
  ///      * Number of transferable units of the identified token. For token of type FUNGIBLE_COMMON -
  ///      * balance in the smallest denomination. For token of type NON_FUNGIBLE_UNIQUE - the number of
  ///      * NFTs held by the account
  final BigInt? balance;

  const HederaTokenUnitBalance({
    this.tokenId,
    this.balance,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        tokenId,
        balance,
      ];


HederaTokenUnitBalance copyWith(
{proto_basic_types.HederaTokenID? tokenId,

BigInt? balance,

}) {
    return HederaTokenUnitBalance(
tokenId: tokenId ?? this.tokenId,
balance: balance ?? this.balance,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'tokenId': config.encodeMessage(tokenId),
      'balance': config.encodeBigint(balance),
    };
  }


  factory HederaTokenUnitBalance.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenUnitBalance(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'tokenId',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      balance: json.valueAsBigInt<BigInt?>('balance', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaTokenUnitBalance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenUnitBalance(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      balance: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenUnitBalance;

}


/// *
///  * Includes all currency balances (both hbar and token) of a single account in the ledger.
class HederaSingleAccountBalances extends HederaProtoMessage with Equality {
    /// *
  ///      * The account
  final proto_basic_types.HederaAccountID? accountID;

    /// *
  ///      * The account's hbar balance
  final BigInt? hbarBalance;

    /// *
  ///      * The list of the account's token balances
  final List<HederaTokenUnitBalance> tokenUnitBalances;

  const HederaSingleAccountBalances({
    this.accountID,
    this.hbarBalance,
    this.tokenUnitBalances = const [],
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
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        accountID,
        hbarBalance,
        tokenUnitBalances,
      ];


HederaSingleAccountBalances copyWith(
{proto_basic_types.HederaAccountID? accountID,

BigInt? hbarBalance,

List<HederaTokenUnitBalance>? tokenUnitBalances,

}) {
    return HederaSingleAccountBalances(
accountID: accountID ?? this.accountID,
hbarBalance: hbarBalance ?? this.hbarBalance,
tokenUnitBalances: tokenUnitBalances ?? this.tokenUnitBalances,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'accountID': config.encodeMessage(accountID),
      'hbarBalance': config.encodeBigint(hbarBalance),
      'tokenUnitBalances': tokenUnitBalances.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaSingleAccountBalances.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSingleAccountBalances(
      accountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountID',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      hbarBalance: json.valueAsBigInt<BigInt?>('hbarBalance', normalizeKeyLookup: config.normalizeKeys),
      tokenUnitBalances: (json.valueEnsureAsList<dynamic>('tokenUnitBalances', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaTokenUnitBalance, Object>(
          value: e,
          parse: (v) => HederaTokenUnitBalance.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaSingleAccountBalances.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSingleAccountBalances(
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(1, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      hbarBalance: decode.getBigInt<BigInt?>(2),
      tokenUnitBalances: decode.getListOfBytes(3).map((b) => HederaTokenUnitBalance.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSingleAccountBalances;

}


/// *
///  * Includes all currency balances (both hbar and token) of all accounts in the ledger.
class HederaAllAccountBalances extends HederaProtoMessage with Equality {
    /// *
  ///      * An instant in consensus time
  final proto_timestamp.HederaTimestamp? consensusTimestamp;

    /// *
  ///      * The list of account balances for all accounts, after handling all transactions with consensus
  ///      * timestamp up to and including the above instant
  final List<HederaSingleAccountBalances> allAccounts;

  const HederaAllAccountBalances({
    this.consensusTimestamp,
    this.allAccounts = const [],
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
        consensusTimestamp,
        allAccounts,
      ];


HederaAllAccountBalances copyWith(
{proto_timestamp.HederaTimestamp? consensusTimestamp,

List<HederaSingleAccountBalances>? allAccounts,

}) {
    return HederaAllAccountBalances(
consensusTimestamp: consensusTimestamp ?? this.consensusTimestamp,
allAccounts: allAccounts ?? this.allAccounts,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'consensusTimestamp': config.encodeMessage(consensusTimestamp),
      'allAccounts': allAccounts.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaAllAccountBalances.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAllAccountBalances(
      consensusTimestamp: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'consensusTimestamp',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      allAccounts: (json.valueEnsureAsList<dynamic>('allAccounts', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaSingleAccountBalances, Object>(
          value: e,
          parse: (v) => HederaSingleAccountBalances.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaAllAccountBalances.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAllAccountBalances(
      consensusTimestamp: decode.messageTo<proto_timestamp.HederaTimestamp?>(1, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      allAccounts: decode.getListOfBytes(2).map((b) => HederaSingleAccountBalances.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoAllAccountBalances;

}



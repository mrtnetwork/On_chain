import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Token Service
///  * Block stream messages that report the results of transactions
///  * handled by the `Token` service.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// * Copyright (C) 2024 Hedera Hashgraph, LLC
///  *
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
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream.output"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Block Stream data for a `createToken` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaCreateTokenOutput extends HederaProtoMessage with Equality {
  const HederaCreateTokenOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaCreateTokenOutput copyWith() {
    return HederaCreateTokenOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaCreateTokenOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCreateTokenOutput();
  }

  factory HederaCreateTokenOutput.deserialize(List<int> bytes) {
    return HederaCreateTokenOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputCreateTokenOutput;
}

/// *
///  * Block Stream data for a `freezeTokenAccount` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaFreezeTokenAccountOutput extends HederaProtoMessage with Equality {
  const HederaFreezeTokenAccountOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaFreezeTokenAccountOutput copyWith() {
    return HederaFreezeTokenAccountOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaFreezeTokenAccountOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaFreezeTokenAccountOutput();
  }

  factory HederaFreezeTokenAccountOutput.deserialize(List<int> bytes) {
    return HederaFreezeTokenAccountOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputFreezeTokenAccountOutput;
}

/// *
///  * Block Stream data for an `unfreezeTokenAccount` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaUnfreezeTokenAccountOutput extends HederaProtoMessage
    with Equality {
  const HederaUnfreezeTokenAccountOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaUnfreezeTokenAccountOutput copyWith() {
    return HederaUnfreezeTokenAccountOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaUnfreezeTokenAccountOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaUnfreezeTokenAccountOutput();
  }

  factory HederaUnfreezeTokenAccountOutput.deserialize(List<int> bytes) {
    return HederaUnfreezeTokenAccountOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputUnfreezeTokenAccountOutput;
}

/// *
///  * Block Stream data for a `grantKycToTokenAccount` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaGrantTokenKycOutput extends HederaProtoMessage with Equality {
  const HederaGrantTokenKycOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaGrantTokenKycOutput copyWith() {
    return HederaGrantTokenKycOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaGrantTokenKycOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGrantTokenKycOutput();
  }

  factory HederaGrantTokenKycOutput.deserialize(List<int> bytes) {
    return HederaGrantTokenKycOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputGrantTokenKycOutput;
}

/// *
///  * Block Stream data for a `revokeKycFromTokenAccount` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaRevokeTokenKycOutput extends HederaProtoMessage with Equality {
  const HederaRevokeTokenKycOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaRevokeTokenKycOutput copyWith() {
    return HederaRevokeTokenKycOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaRevokeTokenKycOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRevokeTokenKycOutput();
  }

  factory HederaRevokeTokenKycOutput.deserialize(List<int> bytes) {
    return HederaRevokeTokenKycOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputRevokeTokenKycOutput;
}

/// *
///  * Block Stream data for a `deleteToken` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaDeleteTokenOutput extends HederaProtoMessage with Equality {
  const HederaDeleteTokenOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaDeleteTokenOutput copyWith() {
    return HederaDeleteTokenOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaDeleteTokenOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaDeleteTokenOutput();
  }

  factory HederaDeleteTokenOutput.deserialize(List<int> bytes) {
    return HederaDeleteTokenOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputDeleteTokenOutput;
}

/// *
///  * Block Stream data for an `updateToken` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaUpdateTokenOutput extends HederaProtoMessage with Equality {
  const HederaUpdateTokenOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaUpdateTokenOutput copyWith() {
    return HederaUpdateTokenOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaUpdateTokenOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaUpdateTokenOutput();
  }

  factory HederaUpdateTokenOutput.deserialize(List<int> bytes) {
    return HederaUpdateTokenOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputUpdateTokenOutput;
}

/// *
///  * Block Stream data for a `mintToken` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaMintTokenOutput extends HederaProtoMessage with Equality {
  const HederaMintTokenOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaMintTokenOutput copyWith() {
    return HederaMintTokenOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaMintTokenOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaMintTokenOutput();
  }

  factory HederaMintTokenOutput.deserialize(List<int> bytes) {
    return HederaMintTokenOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputMintTokenOutput;
}

/// *
///  * Block Stream data for a `burnToken` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaBurnTokenOutput extends HederaProtoMessage with Equality {
  const HederaBurnTokenOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaBurnTokenOutput copyWith() {
    return HederaBurnTokenOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaBurnTokenOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaBurnTokenOutput();
  }

  factory HederaBurnTokenOutput.deserialize(List<int> bytes) {
    return HederaBurnTokenOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputBurnTokenOutput;
}

/// *
///  * Block Stream data for a `wipeTokenAccount` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaWipeTokenAccountOutput extends HederaProtoMessage with Equality {
  const HederaWipeTokenAccountOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaWipeTokenAccountOutput copyWith() {
    return HederaWipeTokenAccountOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaWipeTokenAccountOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaWipeTokenAccountOutput();
  }

  factory HederaWipeTokenAccountOutput.deserialize(List<int> bytes) {
    return HederaWipeTokenAccountOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputWipeTokenAccountOutput;
}

/// *
///  * Block Stream data for an `associateTokens` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaAssociateTokenOutput extends HederaProtoMessage with Equality {
  const HederaAssociateTokenOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaAssociateTokenOutput copyWith() {
    return HederaAssociateTokenOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaAssociateTokenOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaAssociateTokenOutput();
  }

  factory HederaAssociateTokenOutput.deserialize(List<int> bytes) {
    return HederaAssociateTokenOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputAssociateTokenOutput;
}

/// *
///  * Block Stream data for a `dissociateTokens` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaDissociateTokenOutput extends HederaProtoMessage with Equality {
  const HederaDissociateTokenOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaDissociateTokenOutput copyWith() {
    return HederaDissociateTokenOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaDissociateTokenOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaDissociateTokenOutput();
  }

  factory HederaDissociateTokenOutput.deserialize(List<int> bytes) {
    return HederaDissociateTokenOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputDissociateTokenOutput;
}

/// *
///  * Block Stream data for an `updateTokenFeeSchedule` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaUpdateTokenFeeScheduleOutput extends HederaProtoMessage
    with Equality {
  const HederaUpdateTokenFeeScheduleOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaUpdateTokenFeeScheduleOutput copyWith() {
    return HederaUpdateTokenFeeScheduleOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaUpdateTokenFeeScheduleOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaUpdateTokenFeeScheduleOutput();
  }

  factory HederaUpdateTokenFeeScheduleOutput.deserialize(List<int> bytes) {
    return HederaUpdateTokenFeeScheduleOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputUpdateTokenFeeScheduleOutput;
}

/// *
///  * Block Stream data for a `pauseToken` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaPauseTokenOutput extends HederaProtoMessage with Equality {
  const HederaPauseTokenOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaPauseTokenOutput copyWith() {
    return HederaPauseTokenOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaPauseTokenOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaPauseTokenOutput();
  }

  factory HederaPauseTokenOutput.deserialize(List<int> bytes) {
    return HederaPauseTokenOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputPauseTokenOutput;
}

/// *
///  * Block Stream data for an `unpauseToken` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaUnpauseTokenOutput extends HederaProtoMessage with Equality {
  const HederaUnpauseTokenOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaUnpauseTokenOutput copyWith() {
    return HederaUnpauseTokenOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaUnpauseTokenOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaUnpauseTokenOutput();
  }

  factory HederaUnpauseTokenOutput.deserialize(List<int> bytes) {
    return HederaUnpauseTokenOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputUnpauseTokenOutput;
}

/// *
///  * Block Stream data for an `updateNfts` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaUpdateTokenNftsOutput extends HederaProtoMessage with Equality {
  const HederaUpdateTokenNftsOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaUpdateTokenNftsOutput copyWith() {
    return HederaUpdateTokenNftsOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaUpdateTokenNftsOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaUpdateTokenNftsOutput();
  }

  factory HederaUpdateTokenNftsOutput.deserialize(List<int> bytes) {
    return HederaUpdateTokenNftsOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputUpdateTokenNftsOutput;
}

/// *
///  * Block Stream data for a `tokenAirdrop` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaTokenAirdropOutput extends HederaProtoMessage with Equality {
  const HederaTokenAirdropOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaTokenAirdropOutput copyWith() {
    return HederaTokenAirdropOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaTokenAirdropOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenAirdropOutput();
  }

  factory HederaTokenAirdropOutput.deserialize(List<int> bytes) {
    return HederaTokenAirdropOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputTokenAirdropOutput;
}

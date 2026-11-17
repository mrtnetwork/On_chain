import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Crypto Service
///  * Block stream messages that report the results of transactions handled by
///  * the `Crypto` service. This service primarily handles account management
///  * and HBAR transfers.
///  *
///  * &gt; Note
///  * &gt;&gt; Tokens other than HBAR, including all NFTs, are managed by the `Token` Service.
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
///  * Block Stream data for a `approveAllowances` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaApproveAllowanceOutput extends HederaProtoMessage with Equality {
  const HederaApproveAllowanceOutput();

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

  HederaApproveAllowanceOutput copyWith() {
    return HederaApproveAllowanceOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaApproveAllowanceOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaApproveAllowanceOutput();
  }

  factory HederaApproveAllowanceOutput.deserialize(List<int> bytes) {
    return HederaApproveAllowanceOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputApproveAllowanceOutput;
}

/// *
///  * Block Stream data for a `deleteAllowances` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaDeleteAllowanceOutput extends HederaProtoMessage with Equality {
  const HederaDeleteAllowanceOutput();

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

  HederaDeleteAllowanceOutput copyWith() {
    return HederaDeleteAllowanceOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaDeleteAllowanceOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaDeleteAllowanceOutput();
  }

  factory HederaDeleteAllowanceOutput.deserialize(List<int> bytes) {
    return HederaDeleteAllowanceOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputDeleteAllowanceOutput;
}

/// *
///  * Block Stream data for a `createAccount` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaCreateAccountOutput extends HederaProtoMessage with Equality {
  /// *
  ///      * A newly created account identifier.&lt;br/&gt;
  ///      * This is the account identifier for the account created as part of
  ///      * any transaction that creates a new account.&lt;br/&gt;
  ///      * This value is necessary due to the difficulty of otherwise identifying
  ///      * created accounts versus the other account updates necessary for every
  ///      * transaction (e.g. fee payment).
  ///      * &lt;p&gt;
  ///      * This value SHALL be set for every account creation.
  ///      * This value SHALL NOT be set if no account is created.
  final proto_basic_types.HederaAccountID? createdAccountId;

  const HederaCreateAccountOutput({this.createdAccountId});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1)],
    );
  }

  @override
  List<Object?> get protoValues => [createdAccountId];

  HederaCreateAccountOutput copyWith({
    proto_basic_types.HederaAccountID? createdAccountId,
  }) {
    return HederaCreateAccountOutput(
      createdAccountId: createdAccountId ?? this.createdAccountId,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'created_account_id': config.encodeMessage(createdAccountId)};
  }

  factory HederaCreateAccountOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCreateAccountOutput(
      createdAccountId: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'created_account_id',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaCreateAccountOutput.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCreateAccountOutput(
      createdAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputCreateAccountOutput;
}

/// *
///  * Block Stream data for a `cryptoDelete` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaDeleteAccountOutput extends HederaProtoMessage with Equality {
  const HederaDeleteAccountOutput();

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

  HederaDeleteAccountOutput copyWith() {
    return HederaDeleteAccountOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaDeleteAccountOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaDeleteAccountOutput();
  }

  factory HederaDeleteAccountOutput.deserialize(List<int> bytes) {
    return HederaDeleteAccountOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputDeleteAccountOutput;
}

/// *
///  * Block Stream data for a `cryptoTransfer` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaCryptoTransferOutput extends HederaProtoMessage with Equality {
  const HederaCryptoTransferOutput();

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

  HederaCryptoTransferOutput copyWith() {
    return HederaCryptoTransferOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaCryptoTransferOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoTransferOutput();
  }

  factory HederaCryptoTransferOutput.deserialize(List<int> bytes) {
    return HederaCryptoTransferOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputCryptoTransferOutput;
}

/// *
///  * Block Stream data for a `updateAccount` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaUpdateAccountOutput extends HederaProtoMessage with Equality {
  const HederaUpdateAccountOutput();

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

  HederaUpdateAccountOutput copyWith() {
    return HederaUpdateAccountOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaUpdateAccountOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaUpdateAccountOutput();
  }

  factory HederaUpdateAccountOutput.deserialize(List<int> bytes) {
    return HederaUpdateAccountOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputUpdateAccountOutput;
}

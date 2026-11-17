import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/sidecar_file.dart" as proto_sidecar_file;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_types.dart" as proto_contract_types;

/// *
///  * #  Service
///  * Block stream messages that report the results of transactions handled
///  * by the `smart contract` service.
///  *
///  * &gt; REVIEW NOTE
///  * &gt;&gt; The use of sidecar records is a bit odd here. We may find it more
///  * &gt;&gt; effective to extract the actual changes into proper output messages
///  * &gt;&gt; and fields included in the ethereum call output and/or related state
///  * &gt;&gt; changes items, and remove the whole sidecar concept going forward.
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
///  * Block Stream data for a `contractCallMethod` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaCallContractOutput extends HederaProtoMessage with Equality {
    /// *
  ///      * A list of additional outputs.
  ///      * &lt;p&gt;
  ///      * This field MAY record one or more additional outputs and smart
  ///      * contract state changes produced during the ethereum call
  ///      * transaction handling.&lt;br/&gt;
  ///      * This field SHALL NOT be set if the transaction handling did not
  ///      * produce additional outputs.&lt;br/&gt;
  ///      * This field is not settled and MAY be removed or modified.
  final List<proto_sidecar_file.HederaTransactionSidecarRecord> sidecars;

    /// *
  ///      * An EVM contract call result.
  ///      * &lt;p&gt;
  ///      * This field SHALL contain all of the data produced by the contract
  ///      * call transaction as well as basic accounting results.
  final proto_contract_types.HederaContractFunctionResult? contractCallResult;

  const HederaCallContractOutput({
    this.sidecars = const [],
    this.contractCallResult,
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
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        sidecars,
        contractCallResult,
      ];


HederaCallContractOutput copyWith(
{List<proto_sidecar_file.HederaTransactionSidecarRecord>? sidecars,

proto_contract_types.HederaContractFunctionResult? contractCallResult,

}) {
    return HederaCallContractOutput(
sidecars: sidecars ?? this.sidecars,
contractCallResult: contractCallResult ?? this.contractCallResult,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'sidecars': sidecars.map((e) => config.encodeMessage(e)).toList(),
      'contract_call_result': config.encodeMessage(contractCallResult),
    };
  }


  factory HederaCallContractOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCallContractOutput(
      sidecars: (json.valueEnsureAsList<dynamic>('sidecars', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_sidecar_file.HederaTransactionSidecarRecord, Object>(
          value: e,
          parse: (v) => proto_sidecar_file.HederaTransactionSidecarRecord.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      contractCallResult: json.valueTo<proto_contract_types.HederaContractFunctionResult?, Object>(
        key: 'contract_call_result',
        parse: (v) => proto_contract_types.HederaContractFunctionResult.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaCallContractOutput.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCallContractOutput(
      sidecars: decode.getListOfBytes(1).map((b) => proto_sidecar_file.HederaTransactionSidecarRecord.deserialize(b)).toList(),
      contractCallResult: decode.messageTo<proto_contract_types.HederaContractFunctionResult?>(2, (b) => proto_contract_types.HederaContractFunctionResult.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputCallContractOutput;

}


/// *
///  * Block Stream data for a `createContract` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaCreateContractOutput extends HederaProtoMessage with Equality {
    /// *
  ///      * A list of additional outputs.
  ///      * &lt;p&gt;
  ///      * This field MAY record one or more additional outputs and smart
  ///      * contract state changes produced during the ethereum call
  ///      * transaction handling.&lt;br/&gt;
  ///      * This field SHALL NOT be set if the transaction handling did not
  ///      * produce additional outputs.&lt;br/&gt;
  ///      * This field is not settled and MAY be removed or modified.
  final List<proto_sidecar_file.HederaTransactionSidecarRecord> sidecars;

    /// *
  ///      * An EVM contract call result.
  ///      * &lt;p&gt;
  ///      * This field SHALL contain all of the data produced by the contract
  ///      * create transaction as well as basic accounting results.
  final proto_contract_types.HederaContractFunctionResult? contractCreateResult;

  const HederaCreateContractOutput({
    this.sidecars = const [],
    this.contractCreateResult,
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
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        sidecars,
        contractCreateResult,
      ];


HederaCreateContractOutput copyWith(
{List<proto_sidecar_file.HederaTransactionSidecarRecord>? sidecars,

proto_contract_types.HederaContractFunctionResult? contractCreateResult,

}) {
    return HederaCreateContractOutput(
sidecars: sidecars ?? this.sidecars,
contractCreateResult: contractCreateResult ?? this.contractCreateResult,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'sidecars': sidecars.map((e) => config.encodeMessage(e)).toList(),
      'contract_create_result': config.encodeMessage(contractCreateResult),
    };
  }


  factory HederaCreateContractOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCreateContractOutput(
      sidecars: (json.valueEnsureAsList<dynamic>('sidecars', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_sidecar_file.HederaTransactionSidecarRecord, Object>(
          value: e,
          parse: (v) => proto_sidecar_file.HederaTransactionSidecarRecord.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      contractCreateResult: json.valueTo<proto_contract_types.HederaContractFunctionResult?, Object>(
        key: 'contract_create_result',
        parse: (v) => proto_contract_types.HederaContractFunctionResult.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaCreateContractOutput.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCreateContractOutput(
      sidecars: decode.getListOfBytes(1).map((b) => proto_sidecar_file.HederaTransactionSidecarRecord.deserialize(b)).toList(),
      contractCreateResult: decode.messageTo<proto_contract_types.HederaContractFunctionResult?>(2, (b) => proto_contract_types.HederaContractFunctionResult.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputCreateContractOutput;

}


/// no evm exec, only modified entity
/// *
///  * Block Stream data for a `updateContract` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaUpdateContractOutput extends HederaProtoMessage with Equality {
  const HederaUpdateContractOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaUpdateContractOutput copyWith(
) {
    return HederaUpdateContractOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaUpdateContractOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaUpdateContractOutput(
    );
  }

  factory HederaUpdateContractOutput.deserialize(List<int> bytes) {
    return HederaUpdateContractOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputUpdateContractOutput;

}


/// no evm exec, only modified entity
/// *
///  * Block Stream data for a `deleteContract` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaDeleteContractOutput extends HederaProtoMessage with Equality {
  const HederaDeleteContractOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaDeleteContractOutput copyWith(
) {
    return HederaDeleteContractOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaDeleteContractOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaDeleteContractOutput(
    );
  }

  factory HederaDeleteContractOutput.deserialize(List<int> bytes) {
    return HederaDeleteContractOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputDeleteContractOutput;

}


/// *
///  * Block Stream data for a contract `systemUndelete` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaSystemUnDeleteContractOutput extends HederaProtoMessage with Equality {
  const HederaSystemUnDeleteContractOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaSystemUnDeleteContractOutput copyWith(
) {
    return HederaSystemUnDeleteContractOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaSystemUnDeleteContractOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSystemUnDeleteContractOutput(
    );
  }

  factory HederaSystemUnDeleteContractOutput.deserialize(List<int> bytes) {
    return HederaSystemUnDeleteContractOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputSystemUnDeleteContractOutput;

}


/// *
///  * Block Stream data for a contract `systemDelete` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaSystemDeleteContractOutput extends HederaProtoMessage with Equality {
  const HederaSystemDeleteContractOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaSystemDeleteContractOutput copyWith(
) {
    return HederaSystemDeleteContractOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaSystemDeleteContractOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSystemDeleteContractOutput(
    );
  }

  factory HederaSystemDeleteContractOutput.deserialize(List<int> bytes) {
    return HederaSystemDeleteContractOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputSystemDeleteContractOutput;

}


/// *
///  * Block Stream data for a `callEthereum` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaEthereumOutput extends HederaProtoMessage with Equality {
    /// *
  ///      * A list of additional outputs.
  ///      * &lt;p&gt;
  ///      * This field MAY record one or more additional outputs and smart
  ///      * contract state changes produced during the ethereum call
  ///      * transaction handling.&lt;br/&gt;
  ///      * This field SHALL NOT be set if the transaction handling did not
  ///      * produce additional outputs.&lt;br/&gt;
  ///      * This field is not settled and MAY be removed or modified.
  final List<proto_sidecar_file.HederaTransactionSidecarRecord> sidecars;

    /// *
  ///      * An ethereum hash value.
  ///      * &lt;p&gt;
  ///      * This SHALL be a keccak256 hash of the ethereumData.
  final List<int>? ethereumHash;

    /// *
  ///          * A result for an Ethereum Transaction executed as a call.
  ///          * &lt;p&gt;
  ///          * This field SHALL contain all of the data produced by the contract
  ///          * call transaction as well as basic accounting results.
  final proto_contract_types.HederaContractFunctionResult? ethereumCallResult;

    /// *
  ///          * A result for an Ethereum Transaction executed as a create.
  ///          * &lt;p&gt;
  ///          * This field SHALL contain all of the data produced by the contract
  ///          * create transaction as well as basic accounting results.
  final proto_contract_types.HederaContractFunctionResult? ethereumCreateResult;

  const HederaEthereumOutput({
    this.sidecars = const [],
    this.ethereumHash,
    this.ethereumCallResult,
    this.ethereumCreateResult,
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
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        sidecars,
        ethereumHash,
        ethereumCallResult,
        ethereumCreateResult,
      ];


HederaEthereumOutput copyWith(
{List<proto_sidecar_file.HederaTransactionSidecarRecord>? sidecars,

List<int>? ethereumHash,

proto_contract_types.HederaContractFunctionResult? ethereumCallResult,

proto_contract_types.HederaContractFunctionResult? ethereumCreateResult,

}) {
    return HederaEthereumOutput(
sidecars: sidecars ?? this.sidecars,
ethereumHash: ethereumHash ?? this.ethereumHash,
ethereumCallResult: ethereumCallResult ?? this.ethereumCallResult,
ethereumCreateResult: ethereumCreateResult ?? this.ethereumCreateResult,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'sidecars': sidecars.map((e) => config.encodeMessage(e)).toList(),
      'ethereum_hash': config.encodeBinary(ethereumHash),
      'ethereum_call_result': config.encodeMessage(ethereumCallResult),
      'ethereum_create_result': config.encodeMessage(ethereumCreateResult),
    };
  }


  factory HederaEthereumOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaEthereumOutput(
      sidecars: (json.valueEnsureAsList<dynamic>('sidecars', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_sidecar_file.HederaTransactionSidecarRecord, Object>(
          value: e,
          parse: (v) => proto_sidecar_file.HederaTransactionSidecarRecord.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      ethereumHash: config.decodeBinary<List<int>?>(json.valueAs('ethereum_hash', normalizeKeyLookup: config.normalizeKeys)),
      ethereumCallResult: json.valueTo<proto_contract_types.HederaContractFunctionResult?, Object>(
        key: 'ethereum_call_result',
        parse: (v) => proto_contract_types.HederaContractFunctionResult.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      ethereumCreateResult: json.valueTo<proto_contract_types.HederaContractFunctionResult?, Object>(
        key: 'ethereum_create_result',
        parse: (v) => proto_contract_types.HederaContractFunctionResult.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaEthereumOutput.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEthereumOutput(
      sidecars: decode.getListOfBytes(1).map((b) => proto_sidecar_file.HederaTransactionSidecarRecord.deserialize(b)).toList(),
      ethereumHash: decode.getBytes<List<int>?>(2),
      ethereumCallResult: decode.messageTo<proto_contract_types.HederaContractFunctionResult?>(3, (b) => proto_contract_types.HederaContractFunctionResult.deserialize(b)),
      ethereumCreateResult: decode.messageTo<proto_contract_types.HederaContractFunctionResult?>(4, (b) => proto_contract_types.HederaContractFunctionResult.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputEthereumOutput;

}



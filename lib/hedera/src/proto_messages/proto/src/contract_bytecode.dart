import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// -
///  * ‌
///  * Hedera Network Services Protobuf
///  * ​
///  * Copyright (C) 2018 - 2022 Hedera Hashgraph, LLC
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
class HederaContractBytecode extends HederaProtoMessage with Equality {
    /// *
  ///   * The contract to which the bytecodes apply to
  final proto_basic_types.HederaContractID? contractId;

    /// *
  ///   * Contract bytecode during deployment
  final List<int>? initcode;

    /// *
  ///   * Contract bytecode after deployment
  final List<int>? runtimeBytecode;

  const HederaContractBytecode({
    this.contractId,
    this.initcode,
    this.runtimeBytecode,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        contractId,
        initcode,
        runtimeBytecode,
      ];


HederaContractBytecode copyWith(
{proto_basic_types.HederaContractID? contractId,

List<int>? initcode,

List<int>? runtimeBytecode,

}) {
    return HederaContractBytecode(
contractId: contractId ?? this.contractId,
initcode: initcode ?? this.initcode,
runtimeBytecode: runtimeBytecode ?? this.runtimeBytecode,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'contract_id': config.encodeMessage(contractId),
      'initcode': config.encodeBinary(initcode),
      'runtime_bytecode': config.encodeBinary(runtimeBytecode),
    };
  }


  factory HederaContractBytecode.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaContractBytecode(
      contractId: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contract_id',
        parse: (v) => proto_basic_types.HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      initcode: config.decodeBinary<List<int>?>(json.valueAs('initcode', normalizeKeyLookup: config.normalizeKeys)),
      runtimeBytecode: config.decodeBinary<List<int>?>(json.valueAs('runtime_bytecode', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaContractBytecode.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractBytecode(
      contractId: decode.messageTo<proto_basic_types.HederaContractID?>(1, (b) => proto_basic_types.HederaContractID.deserialize(b)),
      initcode: decode.getBytes<List<int>?>(2),
      runtimeBytecode: decode.getBytes<List<int>?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoContractBytecode;

}



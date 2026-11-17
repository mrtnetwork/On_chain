import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Network Admin
///  * Network Admin service transactions.
///  *
///  * The network service handles certain critical transactions, but the
///  * transaction output for those transactions is complex and may be difficult
///  * to handle, so this file is not yet filled in.
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
class HederaUpdateNodeStakeOutput extends HederaProtoMessage with Equality {
  const HederaUpdateNodeStakeOutput();

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


HederaUpdateNodeStakeOutput copyWith(
) {
    return HederaUpdateNodeStakeOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaUpdateNodeStakeOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaUpdateNodeStakeOutput(
    );
  }

  factory HederaUpdateNodeStakeOutput.deserialize(List<int> bytes) {
    return HederaUpdateNodeStakeOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputUpdateNodeStakeOutput;

}


class HederaFreezeOutput extends HederaProtoMessage with Equality {
  const HederaFreezeOutput();

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


HederaFreezeOutput copyWith(
) {
    return HederaFreezeOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaFreezeOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFreezeOutput(
    );
  }

  factory HederaFreezeOutput.deserialize(List<int> bytes) {
    return HederaFreezeOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputFreezeOutput;

}



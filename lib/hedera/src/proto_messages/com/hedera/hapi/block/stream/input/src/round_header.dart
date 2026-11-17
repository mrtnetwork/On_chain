import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Round Header
///  * This header delineates the start of a single consensus round.
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
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream.input"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A header for a single round.&lt;br/&gt;
///  * This message delivers information about a consensus round.
class HederaRoundHeader extends HederaProtoMessage with Equality {
    /// *
  ///      * A round number.&lt;br/&gt;
  ///      * This is the number assigned to the round for consensus.
  final BigInt? roundNumber;

  const HederaRoundHeader({
    this.roundNumber,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        roundNumber,
      ];


HederaRoundHeader copyWith(
{BigInt? roundNumber,

}) {
    return HederaRoundHeader(
roundNumber: roundNumber ?? this.roundNumber,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'round_number': config.encodeBigint(roundNumber),
    };
  }


  factory HederaRoundHeader.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRoundHeader(
      roundNumber: json.valueAsBigInt<BigInt?>('round_number', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaRoundHeader.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRoundHeader(
      roundNumber: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamInputRoundHeader;

}



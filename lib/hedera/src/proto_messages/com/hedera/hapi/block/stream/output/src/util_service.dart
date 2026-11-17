import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Util Service
///  * Block stream messages that report the results of transactions handled by
///  * the `Util` service.
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
///  * Block data produced by `prng` transactions submitted to the `Util` service.
///  *
///  * The `entropy` reported in this block stream message is deterministically
///  * produced, but has high dispersion and is very difficult to predict.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaUtilPrngOutput extends HederaProtoMessage with Equality {
    /// *
  ///      * A deterministic pseudo-random sequence of 48 bytes.
  ///      * &lt;p&gt;
  ///      * This value SHALL be the result of a corresponding
  ///      * `UtilService` `prng` transaction.
  final List<int>? prngBytes;

    /// *
  ///      * A deterministic pseudo-random number generated within a
  ///      * specified range.
  ///      * &lt;p&gt;
  ///      * This value SHALL be the result of a corresponding `UtilService`
  ///      * `prng` transaction.&lt;br/&gt;
  ///      * Note that the transaction only permits a non-negative range, the
  ///      * output SHALL always be a whole number.
  final int? prngNumber;

  const HederaUtilPrngOutput({
    this.prngBytes,
    this.prngNumber,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.uint32(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        prngBytes,
        prngNumber,
      ];


HederaUtilPrngOutput copyWith(
{List<int>? prngBytes,

int? prngNumber,

}) {
    return HederaUtilPrngOutput(
prngBytes: prngBytes ?? this.prngBytes,
prngNumber: prngNumber ?? this.prngNumber,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'prng_bytes': config.encodeBinary(prngBytes),
      'prng_number': prngNumber,
    };
  }


  factory HederaUtilPrngOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaUtilPrngOutput(
      prngBytes: config.decodeBinary<List<int>?>(json.valueAs('prng_bytes', normalizeKeyLookup: config.normalizeKeys)),
      prngNumber: json.valueAsInt<int?>('prng_number', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaUtilPrngOutput.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaUtilPrngOutput(
      prngBytes: decode.getBytes<List<int>?>(1),
      prngNumber: decode.getInt<int?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputUtilPrngOutput;

}



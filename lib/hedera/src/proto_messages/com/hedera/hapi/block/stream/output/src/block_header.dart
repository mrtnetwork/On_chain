import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;

/// *
///  * # Block Header
///  * The block header reports information required to correctly process a block.
///  * This includes versions, block number, and algorithms used.
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
///  * A Block Header.
///  *
///  * Each block in the block stream SHALL begin with a block header.&lt;br/&gt;
///  * The block header SHALL provide the base minimum information needed to
///  * correctly interpret and process that block, or stop processing
///  * if appropriate.&lt;br/&gt;
///  * The block header MUST describe, at minimum, the following items.
///  *  - The version of the block stream data
///  *  - The block number
///  *  - The hash of the previous block
///  *  - The hash algorithm used to generate the block hash
///  *
///  * All fields of this message are REQUIRED, with the exception that
///  * `hash_algorithm` MAY be _transmitted_ as a default value to improve
///  * data efficiency.
class HederaBlockHeader extends HederaProtoMessage with Equality {
  /// *
  ///      * A version of the HAPI specification.&lt;br/&gt;
  ///      * This is the API version that was used to serialize the block.
  final proto_basic_types.HederaSemanticVersion? hapiProtoVersion;

  /// *
  ///      * A version of the consensus node software.&lt;br/&gt;
  ///      * This is the software version that executed the transactions
  ///      * within this block.
  final proto_basic_types.HederaSemanticVersion? softwareVersion;

  /// *
  ///      * A block number for this block.
  ///      * &lt;p&gt;
  ///      * This value MUST be exactly `1` more than the previous block.&lt;br/&gt;
  ///      * Client systems SHOULD optimistically reject any block with a gap or
  ///      * reverse in `number` sequence, and MAY assume the block stream has
  ///      * encountered data loss, data corruption, or unauthorized modification.
  final BigInt? number;

  /// *
  ///      * The timestamp for this block.&lt;br/&gt;
  ///      * The block timestamp is the consensus time stamp of the first round
  ///      * in the block.
  ///      * &lt;p&gt;
  ///      * This SHALL be a timestamp for the block, determined as follows:&lt;br/&gt;
  ///      * Given the first round within a block
  ///      * &lt;ul&gt;
  ///      *  &lt;li&gt;If the round contains events and transactions, the
  ///      *       timestamp SHALL be the timestamp of the last transaction in
  ///      *       the round.&lt;/li&gt;
  ///      *  &lt;li&gt;If the round has events but no transactions the timestamp
  ///      *      SHALL be the timestamp of the last event in the round.&lt;/li&gt;
  ///      *  &lt;li&gt;If the round contains no events or transactions, the
  ///      *      timestamp SHALL be the timestamp of the previous round plus
  ///      *      1000 nanoseconds.&lt;/li&gt;
  ///      *  &lt;li&gt;If the round contains no events or transactions and there
  ///      *      is no previous round, the timestamp SHALL be the median of
  ///      *      the judge created timestamps for this round.&lt;/li&gt;
  ///      * &lt;/ul&gt;
  final proto_timestamp.HederaTimestamp? blockTimestamp;

  /// *
  ///      * A hash algorithm used for this block, including the block proof.
  ///      * &lt;p&gt;
  ///      * This SHOULD always be `SHA2_384`, currently.
  final proto_basic_types.HederaBlockHashAlgorithm? hashAlgorithm;

  const HederaBlockHeader({
    this.hapiProtoVersion,
    this.softwareVersion,
    this.number,
    this.blockTimestamp,
    this.hashAlgorithm,
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
        ProtoFieldConfig.uint64(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.enumType(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    hapiProtoVersion,
    softwareVersion,
    number,
    blockTimestamp,
    hashAlgorithm,
  ];

  HederaBlockHeader copyWith({
    proto_basic_types.HederaSemanticVersion? hapiProtoVersion,

    proto_basic_types.HederaSemanticVersion? softwareVersion,

    BigInt? number,

    proto_timestamp.HederaTimestamp? blockTimestamp,

    proto_basic_types.HederaBlockHashAlgorithm? hashAlgorithm,
  }) {
    return HederaBlockHeader(
      hapiProtoVersion: hapiProtoVersion ?? this.hapiProtoVersion,
      softwareVersion: softwareVersion ?? this.softwareVersion,
      number: number ?? this.number,
      blockTimestamp: blockTimestamp ?? this.blockTimestamp,
      hashAlgorithm: hashAlgorithm ?? this.hashAlgorithm,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'hapi_proto_version': config.encodeMessage(hapiProtoVersion),
      'software_version': config.encodeMessage(softwareVersion),
      'number': config.encodeBigint(number),
      'block_timestamp': config.encodeMessage(blockTimestamp),
      'hash_algorithm': config.encodeEnum(hashAlgorithm),
    };
  }

  factory HederaBlockHeader.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaBlockHeader(
      hapiProtoVersion: json
          .valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
            key: 'hapi_proto_version',
            parse:
                (v) => proto_basic_types.HederaSemanticVersion.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      softwareVersion: json
          .valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
            key: 'software_version',
            parse:
                (v) => proto_basic_types.HederaSemanticVersion.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      number: json.valueAsBigInt<BigInt?>(
        'number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockTimestamp: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'block_timestamp',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hashAlgorithm: json
          .valueTo<proto_basic_types.HederaBlockHashAlgorithm?, Object?>(
            key: 'hash_algorithm',
            parse: (v) => proto_basic_types.HederaBlockHashAlgorithm.from(v),
          ),
    );
  }

  factory HederaBlockHeader.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBlockHeader(
      hapiProtoVersion: decode
          .messageTo<proto_basic_types.HederaSemanticVersion?>(
            1,
            (b) => proto_basic_types.HederaSemanticVersion.deserialize(b),
          ),
      softwareVersion: decode
          .messageTo<proto_basic_types.HederaSemanticVersion?>(
            2,
            (b) => proto_basic_types.HederaSemanticVersion.deserialize(b),
          ),
      number: decode.getBigInt<BigInt?>(3),
      blockTimestamp: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        4,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      hashAlgorithm: decode
          .getEnum<proto_basic_types.HederaBlockHashAlgorithm?>(
            5,
            proto_basic_types.HederaBlockHashAlgorithm.values,
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputBlockHeader;
}

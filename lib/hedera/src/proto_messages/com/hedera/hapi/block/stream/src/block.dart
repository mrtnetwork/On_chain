import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/src/block_item.dart"
    as com_hedera_hapi_block_stream_block_item;

/// *
///  * # Block Stream
///  * The base element of the block stream _at rest_.
///  * A `Block` contains a record of all transactions, results, and outputs for
///  * a block in the chain. Each `Block` also contains a state proof for
///  * validation and a header with version and algorithm information.
///  *
///  * Block entries are not designed for streaming, but for storing blocks in
///  * persistent storage, verifying block stream data, and as query responses
///  * when a block is requested from a block node.
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
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A single complete Hedera block chain block.
///  *
///  * This is a single block structure and SHALL NOT represent the primary
///  * mechanism to transmit a block stream.&lt;br/&gt;
///  * The primary mechanism for transmitting block stream data SHALL be to
///  * stream individual block items to the block node(s).&lt;br/&gt;
///  * The only delimiter between blocks when streamed SHALL be the `BlockHeader`
///  * item and `BlockProof` item.
///  *
///  * This block SHALL be verifiable as correct using only data in the block,
///  * including the `BlockProof`, and public keys for the consensus nodes.
class HederaBlock extends HederaProtoMessage with Equality {
  /// *
  ///      * A list of items that, together, make up this block.
  ///      * &lt;p&gt;
  ///      * This list SHALL begin with a `BlockHeader`.&lt;br/&gt;
  ///      * This list SHALL end with a `BlockProof`.&lt;br/&gt;
  ///      * Items in this list SHALL be in exactly the same order produced by
  ///      * consensus.&lt;br/&gt;
  ///      * Items in this list MAY be filtered, if so requested.&lt;br/&gt;
  ///      * If this list is filtered, removed items SHALL be replaced with
  ///      * `FilteredBlockItem` entries.&lt;br/&gt;
  final List<com_hedera_hapi_block_stream_block_item.HederaBlockItem> items;

  const HederaBlock({this.items = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [items];

  HederaBlock copyWith({
    List<com_hedera_hapi_block_stream_block_item.HederaBlockItem>? items,
  }) {
    return HederaBlock(items: items ?? this.items);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'items': items.map((e) => config.encodeMessage(e)).toList()};
  }

  factory HederaBlock.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaBlock(
      items:
          (json.valueEnsureAsList<dynamic>(
                'items',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  com_hedera_hapi_block_stream_block_item.HederaBlockItem,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => com_hedera_hapi_block_stream_block_item
                          .HederaBlockItem.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaBlock.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBlock(
      items:
          decode
              .getListOfBytes(1)
              .map(
                (b) => com_hedera_hapi_block_stream_block_item
                    .HederaBlockItem.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamBlock;
}

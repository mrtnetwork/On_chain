import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.blockrecords"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Values needed to replay wrapped record hash progression while voting is in progress.
class HederaMigrationWrappedHashes extends HederaProtoMessage with Equality {
  /// *
  ///    * The block number these wrapped hashes belong to.
  final BigInt? blockNumber;

  /// *
  ///    * The wrapped-record consensus timestamp hash for a block.
  final List<int>? consensusTimestampHash;

  /// *
  ///    * The wrapped-record output items tree root hash for a block.
  final List<int>? outputItemsTreeRootHash;

  const HederaMigrationWrappedHashes({
    this.blockNumber,
    this.consensusTimestampHash,
    this.outputItemsTreeRootHash,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    blockNumber,
    consensusTimestampHash,
    outputItemsTreeRootHash,
  ];

  HederaMigrationWrappedHashes copyWith({
    BigInt? blockNumber,

    List<int>? consensusTimestampHash,

    List<int>? outputItemsTreeRootHash,
  }) {
    return HederaMigrationWrappedHashes(
      blockNumber: blockNumber ?? this.blockNumber,
      consensusTimestampHash:
          consensusTimestampHash ?? this.consensusTimestampHash,
      outputItemsTreeRootHash:
          outputItemsTreeRootHash ?? this.outputItemsTreeRootHash,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'block_number': config.encodeBigint(blockNumber),
      'consensus_timestamp_hash': config.encodeBinary(consensusTimestampHash),
      'output_items_tree_root_hash': config.encodeBinary(
        outputItemsTreeRootHash,
      ),
    };
  }

  factory HederaMigrationWrappedHashes.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaMigrationWrappedHashes(
      blockNumber: json.valueAsBigInt<BigInt?>(
        'block_number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consensusTimestampHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'consensus_timestamp_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      outputItemsTreeRootHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'output_items_tree_root_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaMigrationWrappedHashes.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaMigrationWrappedHashes(
      blockNumber: decode.getBigInt<BigInt?>(1),
      consensusTimestampHash: decode.getBytes<List<int>?>(2),
      outputItemsTreeRootHash: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeStateBlockrecordsMigrationWrappedHashes;
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Migration Root Hash Vote Transaction
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.rfc-editor.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.services.auxiliary.blockrecords"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body to publish a node's vote for wrapped record migration state.
class HederaMigrationRootHashVoteTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///    * The previous wrapped record block root hash from startup migration.
  final List<int>? previousWrappedRecordBlockRootHash;

  /// *
  ///    * Intermediate hashing state for wrapped previous block roots.
  final List<List<int>> wrappedIntermediatePreviousBlockRootHashes;

  /// *
  ///    * Leaf count of the wrapped previous block roots hasher.
  final BigInt? wrappedIntermediateBlockRootsLeafCount;

  const HederaMigrationRootHashVoteTransactionBody({
    this.previousWrappedRecordBlockRootHash,
    this.wrappedIntermediatePreviousBlockRootHashes = const [],
    this.wrappedIntermediateBlockRootsLeafCount,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.uint64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    previousWrappedRecordBlockRootHash,
    wrappedIntermediatePreviousBlockRootHashes,
    wrappedIntermediateBlockRootsLeafCount,
  ];

  HederaMigrationRootHashVoteTransactionBody copyWith({
    List<int>? previousWrappedRecordBlockRootHash,

    List<List<int>>? wrappedIntermediatePreviousBlockRootHashes,

    BigInt? wrappedIntermediateBlockRootsLeafCount,
  }) {
    return HederaMigrationRootHashVoteTransactionBody(
      previousWrappedRecordBlockRootHash:
          previousWrappedRecordBlockRootHash ??
          this.previousWrappedRecordBlockRootHash,
      wrappedIntermediatePreviousBlockRootHashes:
          wrappedIntermediatePreviousBlockRootHashes ??
          this.wrappedIntermediatePreviousBlockRootHashes,
      wrappedIntermediateBlockRootsLeafCount:
          wrappedIntermediateBlockRootsLeafCount ??
          this.wrappedIntermediateBlockRootsLeafCount,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'previous_wrapped_record_block_root_hash': config.encodeBinary(
        previousWrappedRecordBlockRootHash,
      ),
      'wrapped_intermediate_previous_block_root_hashes':
          wrappedIntermediatePreviousBlockRootHashes
              .map((e) => config.encodeBinary(e))
              .toList(),
      'wrapped_intermediate_block_roots_leaf_count': config.encodeBigint(
        wrappedIntermediateBlockRootsLeafCount,
      ),
    };
  }

  factory HederaMigrationRootHashVoteTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaMigrationRootHashVoteTransactionBody(
      previousWrappedRecordBlockRootHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'previous_wrapped_record_block_root_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      wrappedIntermediatePreviousBlockRootHashes:
          (json.valueEnsureAsList<dynamic>(
            'wrapped_intermediate_previous_block_root_hashes',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      wrappedIntermediateBlockRootsLeafCount: json.valueAsBigInt<BigInt?>(
        'wrapped_intermediate_block_roots_leaf_count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaMigrationRootHashVoteTransactionBody.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaMigrationRootHashVoteTransactionBody(
      previousWrappedRecordBlockRootHash: decode.getBytes<List<int>?>(1),
      wrappedIntermediatePreviousBlockRootHashes: decode.getListOfBytes(2),
      wrappedIntermediateBlockRootsLeafCount: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiServicesAuxiliaryBlockrecordsMigrationRootHashVoteTransactionBody;
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Block Proof
///  * A proof for the block streamed from a consensus node.
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
///  * A cryptographic proof for the "Block Merkle Tree".
///  *
///  * This message SHALL offer a proof for the "Block Merkle Tree".
///  * The information in the "Block Merkle Tree" SHALL be used to validate the
///  * full content of the most recent block, and, with chained validation,
///  * all prior blocks.
///  *
///  * ### Block Merkle Tree
///  * The Block Hash of any block is a merkle root hash comprised of a 4 leaf
///  * binary merkle tree. The 4 leaves represent
///  * 1. Previous block proof hash
///  * 1. Merkle root of transaction inputs tree
///  * 1. Merkle root of transaction outputs tree
///  * 1. Merkle rook of state tree
///  *
///  * #### Computing the hash
///  * The process for computing a block hash is somewhat complex, and involves
///  * creating a "virtual" merkle tree to obtain the root merkle hash of
///  * that virtual tree.&lt;br/&gt;
///  * The merkle tree SHALL have a 4 part structure with 2 internal nodes,
///  * structured in a strictly binary tree.
///  * - The merkle tree root SHALL be the parent of both
///  *   internal nodes.
///  *    1. The first "internal" node SHALL be the parent of the
///  *       two "left-most" nodes.
///  *       1. The first leaf MUST be the previous block hash, and is a
///  *          single 48-byte value.
///  *       1. The second leaf MUST be the root of a, strictly binary, merkle tree
///  *          composed of all "input" block items in the block.&lt;br/&gt;
///  *          Input items SHALL be transactions, system transactions,
///  *          and events.&lt;br/&gt;
///  *          Leaf nodes in this subtree SHALL be ordered in the same order
///  *          that the block items are encountered in the stream.
///  *    1. The second "internal" node SHALL be the parent of the two
///  *       "right-most" nodes.
///  *       1. The third leaf MUST be the root of a, strictly binary, merkle tree
///  *          composed of all "output" block items in the block.&lt;br/&gt;
///  *          Output items SHALL be transaction result, transaction
///  *          output, and state changes.&lt;br/&gt;
///  *          Leaf nodes in this subtree SHALL be ordered in the same order that
///  *          the block items are encountered in the stream.
///  *       1. The fourth leaf MUST be the merkle tree root hash for network state
///  *          at the start of the block, and is a single 48-byte value.
///  * - The block hash SHALL be the hash calculated for the root of this merkle
///  *   tree.
///  * - The hash algorithm used SHALL be the algorithm specified in the
///  *   corresponding block header.
///  *
///  * The "inputs" and "outputs" subtrees SHALL be "complete" binary merkle trees,
///  * with nodes that would otherwise be missing replaced by a "null" hash
///  * leaf.
class HederaBlockProof extends HederaProtoMessage with Equality {
    /// *
  ///      * The block this proof secures.&lt;br/&gt;
  ///      * We provide this because a proof for a future block can be used to prove
  ///      * the state of the ledger at that block and the blocks before it.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * This value SHOULD match the block number of the current block,
  ///      * under normal operation.
  final BigInt? block;

    /// *
  ///      * A merkle root hash of the previous block.
  ///      * &lt;p&gt;
  ///      * This MUST contain a hash of the "block" merkle tree root for the
  ///      * previous block.&lt;br/&gt;
  ///      * The hash algorithm used MUST match the algorithm declared in the
  ///      * block header _for that block_.
  final List<int>? previousBlockRootHash;

    /// *
  ///      * A merkle root hash of the network state.&lt;br/&gt;
  ///      * This is present to support validation of this block proof by clients
  ///      * that do not maintain a full copy of the network state.
  ///      * &lt;p&gt;
  ///      * This MUST contain a hash of the "state" merkle tree root at the start
  ///      * of the current block (which this block proof verifies).&lt;br/&gt;
  ///      * State processing clients SHOULD calculate the state root hash
  ///      * independently and SHOULD NOT rely on this value.&lt;br/&gt;
  ///      * State processing clients MUST validate the application of state changes
  ///      * for a block using the value present in the Block Proof of the
  ///      * _following_ block.
  ///      * Compliant consensus nodes MUST produce an "empty" block (containing
  ///      * only `BlockHeader` and `BlockProof` as the last block prior to a
  ///      * network "freeze" to ensure the final state hash is incorporated into
  ///      * the Block Stream correctly.
  ///      * Stateless (non-state-processing) clients MUST use this value to
  ///      * construct the block merkle tree.
  final List<int>? startOfBlockStateRootHash;

    /// *
  ///      * A TSS signature for one block.&lt;br/&gt;
  ///      * This is a single signature representing the collection of partial
  ///      * signatures from nodes holding strictly greater than 2/3 of the
  ///      * current network "weight" in aggregate. The signature is produced by
  ///      * cryptographic "aggregation" of the partial signatures to produce a
  ///      * single signature that can be verified with the network public key,
  ///      * but could not be produced by fewer nodes than required to meet the
  ///      * threshold for network stake "weight".
  ///      * &lt;p&gt;
  ///      * This message MUST make use of a threshold signature scheme like `BLS`
  ///      * which provides the necessary cryptographic guarantees.&lt;br/&gt;
  ///      * This signature SHALL use a TSS signature to provide a single signature
  ///      * that represents the consensus signature of consensus nodes.&lt;br/&gt;
  ///      * The exact subset of nodes that signed SHALL neither be known nor
  ///      * tracked, but it SHALL be cryptographically verifiable that the
  ///      * threshold was met if the signature itself can be validated with
  ///      * the network public key (a.k.a `LedgerID`).
  final List<int>? blockSignature;

    /// *
  ///      * A set of hash values along with ordering information.&lt;br/&gt;
  ///      * This list of hash values form the set of sibling hash values needed to
  ///      * correctly reconstruct the parent hash, and all hash values "above" that
  ///      * hash in the merkle tree.
  ///      * &lt;p&gt;
  ///      * A Block proof can be constructed by combining the sibling hashes for
  ///      * a previous block hash and sibling hashes for each entry "above" that
  ///      * node in the merkle tree of a block proof that incorporates that previous
  ///      * block hash. This form of block proof may be used to prove a chain of
  ///      * blocks when one or more older blocks is missing the original block
  ///      * proof that signed the block's merkle root directly.
  ///      * &lt;p&gt;
  ///      * This list MUST be ordered from the sibling of the node that contains
  ///      * this block's root node hash, and continues up the merkle tree to the
  ///      * root hash of the signed block proof.
  ///      * &lt;p&gt;
  ///      * If this block proof has a "direct" signature, then this list MUST be
  ///      * empty.&lt;br/&gt;
  ///      * If this list is not empty, then this block proof MUST be verified by
  ///      * first constructing the "block" merkle tree and computing the root hash
  ///      * of that tree, then combining that hash with the values in this list,
  ///      * paying attention to the first/second sibling ordering, until the root
  ///      * merkle hash is produced from the last pair of sibling hashes. That
  ///      * "secondary" root hash MUST then be verified using
  ///      * the value of `block_signature`.
  final List<HederaMerkleSiblingHash> siblingHashes;

    /// *
  ///          * The id of the hinTS scheme this signature verifies under.
  final BigInt? schemeId;

    /// *
  ///          * The explicit hinTS key this signature verifies under; useful when
  ///          * the verifier can easily check whether a chain-of-trust proof
  ///          * exists for a key, but does does not have any context of the
  ///          * latest hinTS schemes published in the block stream.
  final List<int>? verificationKey;

  const HederaBlockProof({
    this.block,
    this.previousBlockRootHash,
    this.startOfBlockStateRootHash,
    this.blockSignature,
    this.siblingHashes = const [],
    this.schemeId,
    this.verificationKey,
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
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.uint64(6),
        ProtoFieldConfig.bytes(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        block,
        previousBlockRootHash,
        startOfBlockStateRootHash,
        blockSignature,
        siblingHashes,
        schemeId,
        verificationKey,
      ];


HederaBlockProof copyWith(
{BigInt? block,

List<int>? previousBlockRootHash,

List<int>? startOfBlockStateRootHash,

List<int>? blockSignature,

List<HederaMerkleSiblingHash>? siblingHashes,

BigInt? schemeId,

List<int>? verificationKey,

}) {
    return HederaBlockProof(
block: block ?? this.block,
previousBlockRootHash: previousBlockRootHash ?? this.previousBlockRootHash,
startOfBlockStateRootHash: startOfBlockStateRootHash ?? this.startOfBlockStateRootHash,
blockSignature: blockSignature ?? this.blockSignature,
siblingHashes: siblingHashes ?? this.siblingHashes,
schemeId: schemeId ?? this.schemeId,
verificationKey: verificationKey ?? this.verificationKey,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'block': config.encodeBigint(block),
      'previous_block_root_hash': config.encodeBinary(previousBlockRootHash),
      'start_of_block_state_root_hash': config.encodeBinary(startOfBlockStateRootHash),
      'block_signature': config.encodeBinary(blockSignature),
      'sibling_hashes': siblingHashes.map((e) => config.encodeMessage(e)).toList(),
      'scheme_id': config.encodeBigint(schemeId),
      'verification_key': config.encodeBinary(verificationKey),
    };
  }


  factory HederaBlockProof.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaBlockProof(
      block: json.valueAsBigInt<BigInt?>('block', normalizeKeyLookup: config.normalizeKeys),
      previousBlockRootHash: config.decodeBinary<List<int>?>(json.valueAs('previous_block_root_hash', normalizeKeyLookup: config.normalizeKeys)),
      startOfBlockStateRootHash: config.decodeBinary<List<int>?>(json.valueAs('start_of_block_state_root_hash', normalizeKeyLookup: config.normalizeKeys)),
      blockSignature: config.decodeBinary<List<int>?>(json.valueAs('block_signature', normalizeKeyLookup: config.normalizeKeys)),
      siblingHashes: (json.valueEnsureAsList<dynamic>('sibling_hashes', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaMerkleSiblingHash, Object>(
          value: e,
          parse: (v) => HederaMerkleSiblingHash.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      schemeId: json.valueAsBigInt<BigInt?>('scheme_id', normalizeKeyLookup: config.normalizeKeys),
      verificationKey: config.decodeBinary<List<int>?>(json.valueAs('verification_key', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaBlockProof.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBlockProof(
      block: decode.getBigInt<BigInt?>(1),
      previousBlockRootHash: decode.getBytes<List<int>?>(2),
      startOfBlockStateRootHash: decode.getBytes<List<int>?>(3),
      blockSignature: decode.getBytes<List<int>?>(4),
      siblingHashes: decode.getListOfBytes(5).map((b) => HederaMerkleSiblingHash.deserialize(b)).toList(),
      schemeId: decode.getBigInt<BigInt?>(6),
      verificationKey: decode.getBytes<List<int>?>(7),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamBlockProof;

}


/// *
///  * A hash of a "sibling" to an entry in a Merkle tree.
///  *
///  * When constructing a binary merkle tree, each internal node is a hash
///  * constructed from the hash of two "descendant" nodes. Those two nodes
///  * are "siblings" and the order (first, second) in which the two hash values
///  * are combined affects the parent hash.&lt;br/&gt;
///  * This may be used to reconstruct a portion of a merkle tree starting from
///  * a node of interest up to the root of the tree.
class HederaMerkleSiblingHash extends HederaProtoMessage with Equality {
    /// *
  ///      * A flag for the position of this sibling.
  ///      * &lt;p&gt;
  ///      * If this is set then this sibling MUST be the first hash in the pair of
  ///      * sibling hashes of a binary merkle tree.&lt;br/&gt;
  ///      * If this is unset, then this sibling MUST be the second hash in the pair
  ///      * of sibling hashes of a binary merkle tree.
  final bool? isFirst;

    /// *
  ///      * A byte array of a sibling hash.&lt;br/&gt;
  ///      * This is the hash for the sibling at this point in the merkle tree.
  ///      * &lt;p&gt;
  ///      * The algorithm for this hash SHALL match the algorithm for the block that
  ///      * contains this sibling.&lt;br/&gt;
  ///      * This SHALL contain the raw (e.g.) 384 bits (48 bytes) of the hash value.
  final List<int>? siblingHash;

  const HederaMerkleSiblingHash({
    this.isFirst,
    this.siblingHash,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1),
        ProtoFieldConfig.bytes(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        isFirst,
        siblingHash,
      ];


HederaMerkleSiblingHash copyWith(
{bool? isFirst,

List<int>? siblingHash,

}) {
    return HederaMerkleSiblingHash(
isFirst: isFirst ?? this.isFirst,
siblingHash: siblingHash ?? this.siblingHash,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'is_first': isFirst,
      'sibling_hash': config.encodeBinary(siblingHash),
    };
  }


  factory HederaMerkleSiblingHash.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaMerkleSiblingHash(
      isFirst: json.valueAsBool<bool?>('is_first', normalizeKeyLookup: config.normalizeKeys),
      siblingHash: config.decodeBinary<List<int>?>(json.valueAs('sibling_hash', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaMerkleSiblingHash.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaMerkleSiblingHash(
      isFirst: decode.getBool<bool?>(1),
      siblingHash: decode.getBytes<List<int>?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamMerkleSiblingHash;

}



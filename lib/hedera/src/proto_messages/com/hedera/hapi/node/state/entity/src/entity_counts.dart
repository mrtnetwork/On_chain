import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// SPDX-License-Identifier: Apache-2.0
/// *
///  * This proto file contains primitive value messages.
///  * These are intended only for situations where the entire value to be stored in state is a single
///  * primitive.  These should never be used as components of another message; use the protobuf
///  * type instead.
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.entity"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Representation of a Hedera Entity Service entity counts in the network Merkle tree.
///  *
///  * This message is used to store the counts of various entities in the network.
class HederaEntityCounts extends HederaProtoMessage with Equality {
  /// *
  ///    * The number of accounts in the network.
  final BigInt? numAccounts;

  /// *
  ///    * The number of aliases in the network.
  final BigInt? numAliases;

  /// *
  ///    * The number of tokens in the network.
  final BigInt? numTokens;

  /// *
  ///    * The number of token relationships in the network.
  final BigInt? numTokenRelations;

  /// *
  ///    * The number of NFTs in the network.
  final BigInt? numNfts;

  /// *
  ///    * The number of airdrops in the network.
  final BigInt? numAirdrops;

  /// *
  ///    * The number of staking infos in the network.
  final BigInt? numStakingInfos;

  /// *
  ///    * The number of topics in the network.
  final BigInt? numTopics;

  /// *
  ///    * The number of files in the network.
  final BigInt? numFiles;

  /// *
  ///    * The number of nodes in the network.
  final BigInt? numNodes;

  /// *
  ///    * The number of schedules in the network.
  final BigInt? numSchedules;

  /// *
  ///    * The number of contract storage slots in the network.
  final BigInt? numContractStorageSlots;

  /// *
  ///    * The number of contract bytecodes in the network.
  final BigInt? numContractBytecodes;

  /// *
  ///    * The number of hooks in the network.
  final BigInt? numHooks;

  /// *
  ///    * The number of EVM hook storage slots in the network.
  final BigInt? numEvmHookStorageSlots;

  /// *
  ///    * The number of registered nodes in the network.
  final BigInt? numRegisteredNodes;

  const HederaEntityCounts({
    this.numAccounts,
    this.numAliases,
    this.numTokens,
    this.numTokenRelations,
    this.numNfts,
    this.numAirdrops,
    this.numStakingInfos,
    this.numTopics,
    this.numFiles,
    this.numNodes,
    this.numSchedules,
    this.numContractStorageSlots,
    this.numContractBytecodes,
    this.numHooks,
    this.numEvmHookStorageSlots,
    this.numRegisteredNodes,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.uint64(3),
        ProtoFieldConfig.uint64(4),
        ProtoFieldConfig.uint64(5),
        ProtoFieldConfig.uint64(6),
        ProtoFieldConfig.uint64(7),
        ProtoFieldConfig.uint64(8),
        ProtoFieldConfig.uint64(9),
        ProtoFieldConfig.uint64(10),
        ProtoFieldConfig.uint64(11),
        ProtoFieldConfig.uint64(12),
        ProtoFieldConfig.uint64(13),
        ProtoFieldConfig.uint64(14),
        ProtoFieldConfig.uint64(15),
        ProtoFieldConfig.uint64(16),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    numAccounts,
    numAliases,
    numTokens,
    numTokenRelations,
    numNfts,
    numAirdrops,
    numStakingInfos,
    numTopics,
    numFiles,
    numNodes,
    numSchedules,
    numContractStorageSlots,
    numContractBytecodes,
    numHooks,
    numEvmHookStorageSlots,
    numRegisteredNodes,
  ];

  HederaEntityCounts copyWith({
    BigInt? numAccounts,

    BigInt? numAliases,

    BigInt? numTokens,

    BigInt? numTokenRelations,

    BigInt? numNfts,

    BigInt? numAirdrops,

    BigInt? numStakingInfos,

    BigInt? numTopics,

    BigInt? numFiles,

    BigInt? numNodes,

    BigInt? numSchedules,

    BigInt? numContractStorageSlots,

    BigInt? numContractBytecodes,

    BigInt? numHooks,

    BigInt? numEvmHookStorageSlots,

    BigInt? numRegisteredNodes,
  }) {
    return HederaEntityCounts(
      numAccounts: numAccounts ?? this.numAccounts,
      numAliases: numAliases ?? this.numAliases,
      numTokens: numTokens ?? this.numTokens,
      numTokenRelations: numTokenRelations ?? this.numTokenRelations,
      numNfts: numNfts ?? this.numNfts,
      numAirdrops: numAirdrops ?? this.numAirdrops,
      numStakingInfos: numStakingInfos ?? this.numStakingInfos,
      numTopics: numTopics ?? this.numTopics,
      numFiles: numFiles ?? this.numFiles,
      numNodes: numNodes ?? this.numNodes,
      numSchedules: numSchedules ?? this.numSchedules,
      numContractStorageSlots:
          numContractStorageSlots ?? this.numContractStorageSlots,
      numContractBytecodes: numContractBytecodes ?? this.numContractBytecodes,
      numHooks: numHooks ?? this.numHooks,
      numEvmHookStorageSlots:
          numEvmHookStorageSlots ?? this.numEvmHookStorageSlots,
      numRegisteredNodes: numRegisteredNodes ?? this.numRegisteredNodes,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'num_accounts': config.encodeBigint(numAccounts),
      'num_aliases': config.encodeBigint(numAliases),
      'num_tokens': config.encodeBigint(numTokens),
      'num_token_relations': config.encodeBigint(numTokenRelations),
      'num_nfts': config.encodeBigint(numNfts),
      'num_airdrops': config.encodeBigint(numAirdrops),
      'num_staking_infos': config.encodeBigint(numStakingInfos),
      'num_topics': config.encodeBigint(numTopics),
      'num_files': config.encodeBigint(numFiles),
      'num_nodes': config.encodeBigint(numNodes),
      'num_schedules': config.encodeBigint(numSchedules),
      'num_contract_storage_slots': config.encodeBigint(
        numContractStorageSlots,
      ),
      'num_contract_bytecodes': config.encodeBigint(numContractBytecodes),
      'num_hooks': config.encodeBigint(numHooks),
      'num_evm_hook_storage_slots': config.encodeBigint(numEvmHookStorageSlots),
      'num_registered_nodes': config.encodeBigint(numRegisteredNodes),
    };
  }

  factory HederaEntityCounts.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEntityCounts(
      numAccounts: json.valueAsBigInt<BigInt?>(
        'num_accounts',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numAliases: json.valueAsBigInt<BigInt?>(
        'num_aliases',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numTokens: json.valueAsBigInt<BigInt?>(
        'num_tokens',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numTokenRelations: json.valueAsBigInt<BigInt?>(
        'num_token_relations',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numNfts: json.valueAsBigInt<BigInt?>(
        'num_nfts',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numAirdrops: json.valueAsBigInt<BigInt?>(
        'num_airdrops',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numStakingInfos: json.valueAsBigInt<BigInt?>(
        'num_staking_infos',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numTopics: json.valueAsBigInt<BigInt?>(
        'num_topics',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numFiles: json.valueAsBigInt<BigInt?>(
        'num_files',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numNodes: json.valueAsBigInt<BigInt?>(
        'num_nodes',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numSchedules: json.valueAsBigInt<BigInt?>(
        'num_schedules',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numContractStorageSlots: json.valueAsBigInt<BigInt?>(
        'num_contract_storage_slots',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numContractBytecodes: json.valueAsBigInt<BigInt?>(
        'num_contract_bytecodes',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numHooks: json.valueAsBigInt<BigInt?>(
        'num_hooks',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numEvmHookStorageSlots: json.valueAsBigInt<BigInt?>(
        'num_evm_hook_storage_slots',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numRegisteredNodes: json.valueAsBigInt<BigInt?>(
        'num_registered_nodes',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaEntityCounts.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEntityCounts(
      numAccounts: decode.getBigInt<BigInt?>(1),
      numAliases: decode.getBigInt<BigInt?>(2),
      numTokens: decode.getBigInt<BigInt?>(3),
      numTokenRelations: decode.getBigInt<BigInt?>(4),
      numNfts: decode.getBigInt<BigInt?>(5),
      numAirdrops: decode.getBigInt<BigInt?>(6),
      numStakingInfos: decode.getBigInt<BigInt?>(7),
      numTopics: decode.getBigInt<BigInt?>(8),
      numFiles: decode.getBigInt<BigInt?>(9),
      numNodes: decode.getBigInt<BigInt?>(10),
      numSchedules: decode.getBigInt<BigInt?>(11),
      numContractStorageSlots: decode.getBigInt<BigInt?>(12),
      numContractBytecodes: decode.getBigInt<BigInt?>(13),
      numHooks: decode.getBigInt<BigInt?>(14),
      numEvmHookStorageSlots: decode.getBigInt<BigInt?>(15),
      numRegisteredNodes: decode.getBigInt<BigInt?>(16),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateEntityEntityCounts;
}

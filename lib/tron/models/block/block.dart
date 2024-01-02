import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class BlockHeader extends TronProtocolBufferImpl {
  factory BlockHeader.fromJson(Map<String, dynamic> json) {
    return BlockHeader(
        rawData: BlockHeaderRaw.fromJson(json["raw_data"]),
        witnessSignature:
            BytesUtils.tryFromHexString(json["witness_signature"]));
  }
  BlockHeader({required this.rawData, this.witnessSignature});
  final BlockHeaderRaw rawData;
  final List<int>? witnessSignature;

  @override
  Map<String, dynamic> toJson() {
    return {
      "raw_data": rawData.toJson(),
      "witness_signature": BytesUtils.tryToHexString(witnessSignature)
    }..removeWhere((key, value) => value == null);
  }

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [rawData, witnessSignature];

  @override
  String toString() {
    return "BlockHeader{$toJson()}";
  }
}

class BlockHeaderRaw extends TronProtocolBufferImpl {
  factory BlockHeaderRaw.fromJson(Map<String, dynamic> json) {
    return BlockHeaderRaw(
        witnessAddress: BytesUtils.tryFromHexString(json["witness_address"]),
        number: BigintUtils.parse(json["number"]),
        parentHash: BytesUtils.tryFromHexString(json["parentHash"]),
        version: IntUtils.parse(json["version"]),
        timestamp: BigintUtils.parse(json["timestamp"]),
        txTrieRoot: BytesUtils.tryFromHexString(json["txTrieRoot"]),
        witnessId: BigintUtils.tryParse(json["witnessId"]),
        accountStateRoot:
            BytesUtils.tryFromHexString(json["accountStateRoot"]));
  }
  BlockHeaderRaw(
      {required this.timestamp,
      this.txTrieRoot,
      this.parentHash,
      required this.number,
      this.witnessId,
      this.witnessAddress,
      required this.version,
      this.accountStateRoot});

  @override
  List<int> get fieldIds => [1, 2, 3, 7, 8, 9, 10, 11];

  @override
  List get values => [
        timestamp,
        txTrieRoot,
        parentHash,
        number,
        witnessId,
        witnessAddress,
        version,
        accountStateRoot
      ];

  final BigInt timestamp;
  final List<int>? txTrieRoot;
  final List<int>? parentHash;
  final BigInt number;
  final BigInt? witnessId;
  final List<int>? witnessAddress;
  final int version;
  final List<int>? accountStateRoot;

  List<int> get refBlockHash =>
      QuickCrypto.sha256Hash(toBuffer()).sublist(8, 16);

  List<int> get refBlockBytes =>
      BigintUtils.toBytes(number, length: 8).sublist(6, 8);

  @override
  Map<String, dynamic> toJson() {
    return {
      "timestamp": timestamp,
      "tx_trie_root": BytesUtils.tryToHexString(txTrieRoot),
      "parent_hash": BytesUtils.tryToHexString(parentHash),
      "number": number,
      "witness_id": witnessId,
      "witness_address": BytesUtils.tryToHexString(witnessAddress),
      "version": version,
      "account_state_root": BytesUtils.tryToHexString(accountStateRoot),
    }..removeWhere((key, value) => value == null);
  }

  @override
  String toString() {
    return "BlockHeaderRaw{${toJson()}}";
  }
}

// TRON block ID vectors (Nile): blockId = sha256(header raw) with the
// first 8 bytes replaced by the big-endian block number (java-tron
// `BlockId` scheme). The raw `blockHash` alone only matches the last
// 24 bytes — hence it never equals a full block ID by itself.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

TronBlockHeaderraw _header({
  required String txTrieRoot,
  required String parentHash,
  required String witnessAddress,
  BigInt? number,
  BigInt? timestamp,
  int? version,
}) {
  return TronBlockHeaderraw(
    txTrieRoot: BytesUtils.fromHexString(txTrieRoot),
    parentHash: BytesUtils.fromHexString(parentHash),
    witnessAddress: BytesUtils.fromHexString(witnessAddress),
    number: number,
    timestamp: timestamp,
    version: version,
  );
}

void blockIdTest() {
  group('Tron/Block id', () {
    test('nile genesis (block 0)', () {
      // Genesis raw_data as returned by the node (note: no number field).
      final header = _header(
        txTrieRoot:
            '6556a96828248d6b89cfd0487d4cef82b134b5544dc428c8a218beb2db85ab24',
        parentHash:
            'e58f33f9baf9305dc6f82b9f1934ea8f0ade2defb951258d50167028c780351f',
        witnessAddress:
            '41206e65772073797374656d206d75737420616c6c6f77206578697374696e672073797374656d7320746f206265206c696e6b656420746f67657468657220776974686f757420726571756972696e6720616e792063656e7472616c20636f6e74726f6c206f7220636f6f7264696e6174696f6e',
        number: BigInt.zero,
      );
      expect(
        BytesUtils.toHexString(header.blockId),
        '0000000000000000d698d4192c56cb6be724a558448e2684802de4d6cd8690dc',
      );
      // The raw hash matches only the tail.
      final raw = BytesUtils.toHexString(header.blockHash);
      expect(
        raw.substring(16),
        'd698d4192c56cb6be724a558448e2684802de4d6cd8690dc',
      );
      expect(raw.substring(0, 16) == '0000000000000000', isFalse);
    });

    test('nile block 1 embeds its number', () {
      final header = _header(
        txTrieRoot:
            '0000000000000000000000000000000000000000000000000000000000000000',
        parentHash:
            '0000000000000000d698d4192c56cb6be724a558448e2684802de4d6cd8690dc',
        witnessAddress: '41f24cbabb5cf3e639e1869a5cc6be49614f8e6a14',
        number: BigInt.one,
        timestamp: BigInt.from(1572510117000),
        version: 9,
      );
      expect(
        BytesUtils.toHexString(header.blockId),
        '0000000000000001f1b9db4e1f7a39e5bcb4636382f3b24ee38a718e2bd4ddb0',
      );
    });

    test('blockId treats a missing number as zero (protobuf v3 genesis)', () {
      // In protobuf v3 the zero-valued `number` is omitted on the wire,
      // so a missing number means block zero — not an error.
      final header = _header(
        txTrieRoot:
            '6556a96828248d6b89cfd0487d4cef82b134b5544dc428c8a218beb2db85ab24',
        parentHash:
            'e58f33f9baf9305dc6f82b9f1934ea8f0ade2defb951258d50167028c780351f',
        witnessAddress: '41f24cbabb5cf3e639e1869a5cc6be49614f8e6a14',
      );
      final zeroNumber = _header(
        txTrieRoot:
            '6556a96828248d6b89cfd0487d4cef82b134b5544dc428c8a218beb2db85ab24',
        parentHash:
            'e58f33f9baf9305dc6f82b9f1934ea8f0ade2defb951258d50167028c780351f',
        witnessAddress: '41f24cbabb5cf3e639e1869a5cc6be49614f8e6a14',
        number: BigInt.zero,
      );
      expect(header.blockId, zeroNumber.blockId);
      expect(
        BytesUtils.toHexString(header.blockId).substring(0, 16),
        '0000000000000000',
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(blockIdTest, "Block Id");
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/helper/helper.dart';

import 'erc1155_transfer_logs.dart';

/// Global inbound-transfer scan result, classified by standard.
///
/// Contracts and token ids are collected into sets, so repeated logs from
/// the same sender are merged: each contract is classified once and each
/// token id is verified once downstream. ERC-721 holdings are decoded and
/// classified here but never emitted as tokens (non-fungible by
/// definition); the NFT import flow covers them.
class EvmInboundHoldings {
  final Set<String> erc20Contracts;
  final Map<String, Set<BigInt>> erc721;
  final Map<String, Set<BigInt>> erc1155;
  const EvmInboundHoldings({
    required this.erc20Contracts,
    required this.erc721,
    required this.erc1155,
  });

  bool get isEmpty =>
      erc20Contracts.isEmpty && erc721.isEmpty && erc1155.isEmpty;
}

/// ERC-20-shaped (3-topic) and ERC-721 (4-topic) `Transfer` logs with
/// `to == owner`, across every contract. The selector hash is identical
/// for both standards; the topic count splits them.
class EthereumRequestERC20ERC721InboundTransferLogs
    extends
        EthereumRequest<
          ({Set<String> erc20Contracts, Map<String, Set<BigInt>> erc721}),
          List<dynamic>
        > {
  EthereumRequestERC20ERC721InboundTransferLogs({
    required this.owner,
    required this.fromBlock,
    required this.toBlock,
  });

  @override
  String get method => EthereumMethods.getLogs.value;

  final ETHAddress owner;
  final BigInt fromBlock;
  final BigInt toBlock;

  static const String transferSignature =
      "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef";

  static String _ownerTopic(ETHAddress owner) {
    final padded = BigintUtils.toBytes(
      BigintUtils.parse(owner.toSolidityHex()),
      length: 32,
    );
    return BytesUtils.toHexString(padded, prefix: '0x');
  }

  @override
  ({Set<String> erc20Contracts, Map<String, Set<BigInt>> erc721}) onResponse(
    result,
  ) {
    final erc20Contracts = <String>{};
    final erc721 = <String, Set<BigInt>>{};
    for (final log in result) {
      if (log is! Map) continue;
      final topics = log["topics"];
      if (topics is! List) continue;
      if ((topics[0]?.toString().toLowerCase()) != transferSignature) continue;
      // Defensive: the node should already enforce `to == owner`.
      if (topics.length < 3 ||
          topics[2]?.toString().toLowerCase() != _ownerTopic(owner)) {
        continue;
      }
      final contract = log["address"]?.toString().toLowerCase();
      if (contract == null || contract.isEmpty) continue;
      if (topics.length == 3) {
        erc20Contracts.add(contract);
      } else if (topics.length == 4) {
        final tokenId = BigintUtils.tryParse(topics[3].toString());
        if (tokenId == null) continue;
        erc721.putIfAbsent(contract, () => <BigInt>{}).add(tokenId);
      }
    }
    return (erc20Contracts: erc20Contracts, erc721: erc721);
  }

  static String _blockHex(BigInt block) => block.toHexaDecimal;

  @override
  List<dynamic> toJson() {
    return [
      {
        "fromBlock": _blockHex(fromBlock),
        "toBlock": _blockHex(toBlock),
        "topics": [transferSignature, null, _ownerTopic(owner)],
      },
    ];
  }
}

/// ERC-1155 `TransferSingle`/`TransferBatch` legs with `to == owner`,
/// across every contract, each paired with its emitting contract.
class EthereumRequestERC1155InboundTransferLogs
    extends
        EthereumRequest<
          List<({String contract, Erc1155TransferLog leg})>,
          List<dynamic>
        > {
  EthereumRequestERC1155InboundTransferLogs({
    required this.owner,
    required this.fromBlock,
    required this.toBlock,
  });

  @override
  String get method => EthereumMethods.getLogs.value;

  final ETHAddress owner;
  final BigInt fromBlock;
  final BigInt toBlock;

  @override
  List<({String contract, Erc1155TransferLog leg})> onResponse(result) {
    final legs = <({String contract, Erc1155TransferLog leg})>[];
    final want = owner.address.toLowerCase();
    for (final log in result) {
      if (log is! Map) continue;
      final contract = log["address"]?.toString().toLowerCase();
      if (contract == null || contract.isEmpty) continue;
      List<Erc1155TransferLog> decoded;
      try {
        decoded = EthereumRequestERC1155TransferLogs.decodeLogs([log]);
      } catch (_) {
        continue;
      }
      for (final leg in decoded) {
        // Defensive: the node should already enforce `to == owner`.
        if (leg.to.address.toLowerCase() != want) continue;
        legs.add((contract: contract, leg: leg));
      }
    }
    return legs;
  }

  static String _blockHex(BigInt block) => block.toHexaDecimal;

  static String _ownerTopic(ETHAddress owner) {
    final padded = BigintUtils.toBytes(
      BigintUtils.parse(owner.toSolidityHex()),
      length: 32,
    );
    return BytesUtils.toHexString(padded, prefix: '0x');
  }

  @override
  List<dynamic> toJson() {
    return [
      {
        "fromBlock": _blockHex(fromBlock),
        "toBlock": _blockHex(toBlock),
        "topics": [
          [
            const ERC1155TransferSingleDecoder().signatureHex,
            const ERC1155TransferBatchDecoder().signatureHex,
          ],
          null,
          null,
          _ownerTopic(owner),
        ],
      },
    ];
  }
}

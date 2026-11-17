import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';

/// ERC-721 Transfer event, used to replay holdings when the contract has no
/// enumeration and ids are not sequential.
class Erc721TransferLog {
  const Erc721TransferLog({
    required this.from,
    required this.to,
    required this.tokenId,
  });
  final ETHAddress from;
  final ETHAddress to;
  final BigInt tokenId;
}

/// Fetches ERC-721 Transfer logs of [contractAddress] in [fromBlock]..[toBlock].
class EthereumRequestERC721TransferLogs
    extends EthereumRequest<List<Erc721TransferLog>, List<dynamic>> {
  EthereumRequestERC721TransferLogs(
    this.contractAddress, {
    required this.fromBlock,
    required this.toBlock,
  });

  static const String transferSignature =
      "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef";

  @override
  String get method => EthereumMethods.getLogs.value;

  final SolidityAddress contractAddress;
  final BigInt fromBlock;
  final BigInt toBlock;

  static ETHAddress _topicAddress(String topic) {
    final bytes = BytesUtils.fromHexString(topic);
    return ETHAddress.fromBytes(bytes.sublist(bytes.length - 20));
  }

  @override
  List<Erc721TransferLog> onResponse(result) {
    final logs = <Erc721TransferLog>[];
    for (final log in result) {
      if (log is! Map) continue;
      final topics = log["topics"];
      if (topics is! List || topics.length != 4) continue;
      if ((topics[0] as String?)?.toLowerCase() != transferSignature) continue;
      try {
        final from = _topicAddress(topics[1].toString());
        final to = _topicAddress(topics[2].toString());
        final tokenId = BigintUtils.tryParse(topics[3].toString());
        if (tokenId == null) continue;
        logs.add(Erc721TransferLog(from: from, to: to, tokenId: tokenId));
      } catch (_) {
        continue;
      }
    }
    return logs;
  }

  static String _blockHex(BigInt block) => block.toHexaDecimal;

  @override
  List<dynamic> toJson() {
    return [
      {
        "address": contractAddress.toSolidityHex(),
        "fromBlock": _blockHex(fromBlock),
        "toBlock": _blockHex(toBlock),
        "topics": [transferSignature],
      },
    ];
  }
}

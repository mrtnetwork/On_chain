import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

/// ERC-1155 transfer event leg (single or batch), decoded through the
/// on-chain ABI event fragments.
class Erc1155TransferLog {
  const Erc1155TransferLog({
    required this.from,
    required this.to,
    required this.tokenId,
    required this.value,
  });
  final ETHAddress from;
  final ETHAddress to;
  final BigInt tokenId;
  final BigInt value;
}

/// Fetches ERC-1155 TransferSingle/TransferBatch logs of [contractAddress] in
/// [fromBlock]..[toBlock].
class EthereumRequestERC1155TransferLogs
    extends EthereumRequest<List<Erc1155TransferLog>, List<dynamic>> {
  EthereumRequestERC1155TransferLogs(
    this.contractAddress, {
    required this.fromBlock,
    required this.toBlock,
  });

  @override
  String get method => EthereumMethods.getLogs.value;

  final SolidityAddress contractAddress;
  final BigInt fromBlock;
  final BigInt toBlock;

  static const ERC1155TransferSingleDecoder _singleDecoder =
      ERC1155TransferSingleDecoder();
  static const ERC1155TransferBatchDecoder _batchDecoder =
      ERC1155TransferBatchDecoder();

  static ETHAddress _toAddress(SolidityAddress value) {
    return value.toEthereumAddress();
  }

  static List<Erc1155TransferLog> _decodeSingle(
    List<int> data,
    List<List<int>?> topics,
  ) {
    late final ERC1155TransferSingleEvent decoded;
    try {
      decoded = _singleDecoder.decodeEvent(data, topics);
    } catch (_) {
      return [];
    }
    return [
      Erc1155TransferLog(
        from: _toAddress(decoded.from),
        to: _toAddress(decoded.to),
        tokenId: decoded.id,
        value: decoded.value,
      ),
    ];
  }

  static List<Erc1155TransferLog> _decodeBatch(
    List<int> data,
    List<List<int>?> topics,
  ) {
    late final ERC1155TransferBatchEvent decoded;
    try {
      decoded = _batchDecoder.decodeEvent(data, topics);
    } catch (_) {
      return [];
    }
    final legs = <Erc1155TransferLog>[];
    for (int i = 0; i < decoded.ids.length && i < decoded.values.length; i++) {
      legs.add(
        Erc1155TransferLog(
          from: _toAddress(decoded.from),
          to: _toAddress(decoded.to),
          tokenId: decoded.ids[i],
          value: decoded.values[i],
        ),
      );
    }
    return legs;
  }

  static String _normalizeHex(String hex) {
    return StringUtils.strip0x(hex).toLowerCase();
  }

  @override
  List<Erc1155TransferLog> onResponse(result) {
    // EthereumRequestGetFilterLogs(filterIdentifier: filterIdentifier)
    return EthereumRequestERC1155TransferLogs.decodeLogs(result);
  }

  /// Decodes TransferSingle/TransferBatch legs from raw `eth_getLogs`
  /// entries. Shared with the global inbound scan, which filters by
  /// recipient itself.
  static List<Erc1155TransferLog> decodeLogs(List<dynamic> result) {
    final logs = <Erc1155TransferLog>[];
    final singleSignature = _normalizeHex(_singleDecoder.signatureHex);
    final batchSignature = _normalizeHex(_batchDecoder.signatureHex);
    for (final log in result) {
      if (log is! Map) continue;
      final topics = log["topics"];
      if (topics is! List || topics.length != 4) continue;
      try {
        final topicBytes =
            topics
                .map((e) => BytesUtils.fromHexString(e.toString()))
                .map((e) => e as List<int>?)
                .toList();
        final signature = _normalizeHex(topics[0].toString());
        final data = BytesUtils.fromHexString(log["data"]?.toString() ?? "0x");
        if (signature == singleSignature) {
          logs.addAll(_decodeSingle(data, topicBytes));
        } else if (signature == batchSignature) {
          logs.addAll(_decodeBatch(data, topicBytes));
        }
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
        "topics": [
          [_singleDecoder.signatureHex, _batchDecoder.signatureHex],
        ],
      },
    ];
  }
}

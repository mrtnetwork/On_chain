import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/models/transaction.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns information about a transaction by block number and transaction index position.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getTransactionByBlockNumberAndIndex)
class EthereumRequestGetTransactionByBlockNumberAndIndex
    extends EthereumRequest<TransactionInfo?, Map<String, dynamic>?> {
  EthereumRequestGetTransactionByBlockNumberAndIndex({
    required BlockTagOrNumber blockNumber,
    required this.index,
  }) : super(blockNumber: blockNumber);

  /// eth_getTransactionByBlockNumberAndIndex
  @override
  String get method =>
      EthereumMethods.getTransactionByBlockNumberAndIndex.value;

  /// the transaction index position.
  final int index;

  @override
  List<dynamic> toJson() {
    return [blockNumber, index.toHexaDecimal];
  }

  @override
  TransactionInfo? onResponse(result) {
    if (result == null) return null;
    return TransactionInfo.fromJson(result);
  }

  @override
  String toString() {
    return 'EthereumRequestGetTransactionByBlockNumberAndIndex{${toJson()}}';
  }
}

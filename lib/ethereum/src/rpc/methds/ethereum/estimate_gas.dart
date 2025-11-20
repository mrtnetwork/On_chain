import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Generates and returns an estimate of how much gas is necessary to allow the transaction to complete.
/// The transaction will not be added to the blockchain.
/// Note that the estimate may be significantly more than the amount of gas actually used by the transaction,
/// for a variety of reasons including EVM mechanics and node performance.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_estimategas)
class EthereumRequestEstimateGas extends EthereumRequest<BigInt, Object> {
  EthereumRequestEstimateGas({
    required this.transaction,
    super.blockNumber = BlockTagOrNumber.pending,
  });

  /// eth_estimateGas
  @override
  String get method => EthereumMethods.estimateGas.value;

  final Map<String, dynamic> transaction;

  @override
  List<dynamic> toJson() {
    return [transaction, blockNumber];
  }

  @override
  BigInt onResonse(result) {
    return EthereumRequest.onBigintResponse(result);
  }

  @override
  String toString() {
    return 'EthereumRequestEstimateGas{${toJson()}}';
  }
}

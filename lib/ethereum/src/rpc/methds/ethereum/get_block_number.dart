import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the number of most recent block..
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_blocknumber)
class EthereumRequestGetBlockNumber extends EthereumRequest<int, Object> {
  /// eth_blockNumber
  @override
  String get method => EthereumMethods.getBlockNumber.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  int onResonse(dynamic result) {
    return EthereumRequest.onIntResponse(result);
  }

  @override
  String toString() {
    return 'EthereumRequestGetBlockNumber{${toJson()}}';
  }
}

import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the balance of the account of given address.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getbalance)
class EthereumRequestGetBalance extends EthereumRequest<BigInt, Object> {
  EthereumRequestGetBalance(
      {required this.address, BlockTagOrNumber? tag = BlockTagOrNumber.latest})
      : super(blockNumber: tag);

  /// eth_getBalance
  @override
  String get method => EthereumMethods.getBalance.value;

  ///  address to check for balance.
  final String address;

  @override
  List<dynamic> toJson() {
    return [address, blockNumber];
  }

  @override
  BigInt onResonse(dynamic result) {
    return EthereumRequest.onBigintResponse(result);
  }

  @override
  String toString() {
    return 'EthereumRequestGetBalance{${toJson()}}';
  }
}

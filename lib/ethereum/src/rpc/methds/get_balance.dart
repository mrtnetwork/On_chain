import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the balance of the account of given address.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getbalance)
class RPCGetBalance extends ETHRPCRequest<BigInt> {
  RPCGetBalance(
      {required this.address, BlockTagOrNumber? tag = BlockTagOrNumber.latest})
      : super(blockNumber: tag);

  /// eth_getBalance
  @override
  EthereumMethods get method => EthereumMethods.getBalance;

  ///  address to check for balance.
  final String address;

  @override
  List<dynamic> toJson() {
    return [address, blockNumber];
  }

  @override
  BigInt onResonse(dynamic result) {
    return ETHRPCRequest.onBigintResponse(result);
  }

  @override
  String toString() {
    return "RPCGetBalance{${toJson()}}";
  }
}

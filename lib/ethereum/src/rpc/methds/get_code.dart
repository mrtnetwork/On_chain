import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns code at a given address.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getCode)
class RPCGetCode extends ETHRPCRequest<String?> {
  RPCGetCode({
    required this.address,
    BlockTagOrNumber? tag = BlockTagOrNumber.pending,
  }) : super(blockNumber: tag);

  /// eth_getCode
  @override
  EthereumMethods get method => EthereumMethods.getCode;

  /// address
  final String address;

  @override
  List<dynamic> toJson() {
    return [address, blockNumber];
  }

  @override
  String? onResonse(result) {
    if (result == "0x") return null;
    return super.onResonse(result);
  }

  @override
  String toString() {
    return "RPCGetCode{${toJson()}}";
  }
}

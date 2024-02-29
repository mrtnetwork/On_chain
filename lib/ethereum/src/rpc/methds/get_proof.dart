import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class RPCGetProof extends ETHRPCRequest<dynamic> {
  RPCGetProof(
      {required this.address,
      required this.storageKeys,
      BlockTagOrNumber? blockNumber = BlockTagOrNumber.latest})
      : super(blockNumber: blockNumber);
  @override
  EthereumMethods get method => EthereumMethods.getProof;
  final String address;
  final List<String> storageKeys;

  @override
  List<dynamic> toJson() {
    return [address, storageKeys, blockNumber];
  }
}

import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestGetProof extends EthereumRequest<Object?, Object?> {
  EthereumRequestGetProof(
      {required this.address,
      required this.storageKeys,
      super.blockNumber = BlockTagOrNumber.latest});
  @override
  String get method => EthereumMethods.getProof.value;
  final String address;
  final List<String> storageKeys;

  @override
  List<dynamic> toJson() {
    return [address, storageKeys, blockNumber];
  }
}

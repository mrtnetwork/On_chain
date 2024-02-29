import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the value from a storage position at a given address.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getStorageAt)
class RPCGetStorageAt extends ETHRPCRequest<dynamic> {
  RPCGetStorageAt({
    required this.address,
    required this.storageSlot,
    BlockTagOrNumber? tag = BlockTagOrNumber.finalized,
  }) : super(blockNumber: tag);

  /// eth_getStorageAt
  @override
  EthereumMethods get method => EthereumMethods.getStorageAt;

  /// address of the storage.
  final String address;

  /// integer of the position in the storage.
  final BigInt storageSlot;

  @override
  List<dynamic> toJson() {
    return [address, storageSlot, blockNumber];
  }

  @override
  String toString() {
    return "RPCGetStorageAt{${toJson()}}";
  }
}

import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the value from a storage position at a given address.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getStorageAt)
class EthereumRequestGetStorageAt extends EthereumRequest<String, String> {
  EthereumRequestGetStorageAt({
    required this.address,
    required this.storageSlot,
    BlockTagOrNumber? tag = BlockTagOrNumber.finalized,
  }) : super(blockNumber: tag);

  /// eth_getStorageAt
  @override
  String get method => EthereumMethods.getStorageAt.value;

  /// address of the storage.
  final String address;

  /// integer of the position in the storage.
  final String storageSlot;

  @override
  List<dynamic> toJson() {
    return [address, storageSlot, blockNumber];
  }

  @override
  String toString() {
    return 'EthereumRequestGetStorageAt{${toJson()}}';
  }
}

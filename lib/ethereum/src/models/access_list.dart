import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';

/// Represents an entry in the access list, specifying addresses and storage keys.
class AccessEntry {
  final ETHAddress address;
  final List<String> storageKeys;

  const AccessEntry({required this.address, required this.storageKeys});

  /// Creates an [AccessEntry] from a JSON map.
  factory AccessEntry.fromJson(Map<String, dynamic> json) {
    return AccessEntry(
        address: ETHAddress(json.valueAs("address")),
        storageKeys: json.valueEnsureAsList<String>("storageKeys"));
  }

  /// Creates an [AccessEntry] from a serialized list of dynamic objects.
  factory AccessEntry.deserialize(List<dynamic> serialized) {
    try {
      final storageKeys = (serialized[1] as List)
          .map((e) => BytesUtils.toHexString(e, prefix: '0x'))
          .toList();
      return AccessEntry(
          address: ETHAddress.fromBytes(serialized[0]),
          storageKeys: storageKeys);
    } catch (e) {
      throw const ETHPluginException('invalid AccessEntry serialized');
    }
  }

  /// Serializes the access list entry to a list of dynamic objects.
  List<List<dynamic>> serialize() {
    return [
      address.toBytes(),
      storageKeys.map<List<int>>((e) => BytesUtils.fromHexString(e)).toList()
    ];
  }

  /// Converts the access list entry to a JSON map.
  Map<String, dynamic> toJson() {
    return {'address': address.address, 'storageKeys': storageKeys};
  }

  @override
  String toString() {
    return '''
      AccessEntry ${toJson()}
    ''';
  }
}

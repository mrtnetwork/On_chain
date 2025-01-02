import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';

/// Represents a list of access list entries.
typedef AccessList = List<AccessListEntry>;

/// Represents an entry in the access list, specifying addresses and storage keys.
class AccessListEntry {
  final String address;
  final List<String> storageKeys;

  const AccessListEntry({
    required this.address,
    required this.storageKeys,
  });

  /// Creates an [AccessListEntry] from a JSON map.
  factory AccessListEntry.fromJson(Map<String, dynamic> json) {
    return AccessListEntry(
        address: json['address'],
        storageKeys: (json['storageKeys'] as List).cast());
  }

  /// Creates an [AccessListEntry] from a serialized list of dynamic objects.
  factory AccessListEntry.fromSerialized(List<dynamic> serialized) {
    try {
      final addr = BytesUtils.toHexString(serialized[0], prefix: '0x');
      final storageKeys = (serialized[1] as List)
          .map((e) => BytesUtils.toHexString(e, prefix: '0x'))
          .toList();
      return AccessListEntry(address: addr, storageKeys: storageKeys);
    } catch (e) {
      throw const ETHPluginException('invalid AccessListEntry serialized');
    }
  }

  /// Serializes the access list entry to a list of dynamic objects.
  List<dynamic> serialize() {
    return [
      BytesUtils.fromHexString(address),
      storageKeys.map<List<int>>((e) => BytesUtils.fromHexString(e)).toList()
    ];
  }

  /// Converts the access list entry to a JSON map.
  Map<String, dynamic> toJson() {
    return {'address': address, 'storageKeys': storageKeys};
  }

  @override
  String toString() {
    return '''
      AccessListEntry {
        address: $address,
        storageKeys: $storageKeys,
      }
    ''';
  }
}

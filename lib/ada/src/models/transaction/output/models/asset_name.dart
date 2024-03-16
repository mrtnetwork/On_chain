import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents an asset name.
class AssetName with ADASerialization implements Comparable<AssetName> {
  /// The byte data of the asset name.
  final List<int> data;

  /// Constructs an [AssetName] instance.
  AssetName(List<int> data)
      : data = BytesUtils.toBytes(data, unmodifiable: true);

  /// Deserializes an [AssetName] instance from CBOR bytes value.
  factory AssetName.deserialize(CborBytesValue cbor) {
    return AssetName(cbor.value);
  }

  /// Constructs an [AssetName] instance from a hexadecimal string.
  factory AssetName.fromHex(String assetNameHex) {
    return AssetName(BytesUtils.fromHexString(assetNameHex));
  }
  AssetName copyWith({List<int>? data}) {
    return AssetName(data ?? this.data);
  }

  @override
  int compareTo(AssetName other) {
    final lenComparison = data.length.compareTo(other.data.length);
    if (lenComparison == 0) {
      return BytesUtils.compareBytes(data, other.data);
    }
    return lenComparison;
  }

  /// Converts the asset name to a hexadecimal string.
  String toHex() => BytesUtils.toHexString(data);

  @override
  CborObject toCbor() {
    return CborBytesValue(data);
  }

  @override
  String toJson() {
    return BytesUtils.toHexString(data);
  }

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        (other is AssetName && bytesEqual(data, other.data));
  }

  @override
  int get hashCode => data.hashCode;
}

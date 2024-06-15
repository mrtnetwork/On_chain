import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/asset_name.dart';

/// Represents a collection of assets with associated asset names and quantities.
class Assets with ADASerialization {
  /// Map of asset names to quantities.
  final Map<AssetName, BigInt> assets;

  /// Constructs an instance of Assets.
  Assets._(Map<AssetName, BigInt> assets)
      : assets = Map<AssetName, BigInt>.unmodifiable(assets);
  factory Assets(Map<AssetName, BigInt> assets) {
    final keys = assets.keys.toList()..sort();
    return Assets._({for (final i in keys) i: assets[i]!});
  }

  /// Constructs an instance of Assets from a CBOR object.
  factory Assets.deserialize(CborMapValue cbor) {
    final assets = {
      for (final entry in cbor.value.entries)
        AssetName.deserialize(entry.key):
            cbor.getValue<CborObject>(entry.key).getInteger()
    };
    return Assets(assets);
  }
  factory Assets.fromJson(Map<String, dynamic> json) {
    return Assets({
      for (final i in json.entries)
        AssetName.fromHex(i.key): BigintUtils.parse(i.value)
    });
  }

  Assets copyWith({
    Map<AssetName, BigInt>? assets,
  }) {
    return Assets(assets ?? this.assets);
  }

  @override
  CborObject toCbor() {
    return CborMapValue.fixedLength({
      for (final i in assets.entries)
        i.key.toCbor(): CborUnsignedValue.u64(i.value)
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {for (final i in assets.entries) i.key.toJson(): i.value.toString()};
  }

  Assets operator +(Assets other) {
    final values = Map<AssetName, BigInt>.from(assets);
    for (final i in other.assets.entries) {
      if (values.containsKey(i.key)) {
        values[i.key] = values[i.key]! + i.value;
      } else {
        values[i.key] = i.value;
      }
    }
    return Assets(values);
  }

  Assets operator -(Assets other) {
    final values = Map<AssetName, BigInt>.from(assets);
    for (final i in other.assets.entries) {
      if (!values.containsKey(i.key)) continue;
      final val = values[i.key]! - i.value;
      if (val <= BigInt.zero) {
        values.remove(i.key);
      } else {
        values[i.key] = val;
      }
    }
    return Assets(values);
  }

  @override
  operator ==(other) {
    if (other is! Assets) return false;
    if (other.assets.length != assets.length) return false;
    for (final i in other.assets.entries) {
      if (other.assets[i.key] != assets[i.key]) return false;
    }
    return true;
  }

  @override
  int get hashCode => assets.entries.fold(
      mask32,
      (previousValue, element) =>
          previousValue ^ (element.key.hashCode ^ element.value.hashCode));
}

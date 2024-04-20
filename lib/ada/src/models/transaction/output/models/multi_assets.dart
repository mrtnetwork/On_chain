import 'package:blockchain_utils/binary/binary.dart';
import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/asset_name.dart';
import 'assets.dart';

/// Represents a collection of multiple assets associated with policy IDs.
class MultiAsset with ADASerialization implements Comparable<MultiAsset> {
  static final MultiAsset empty = MultiAsset({});

  /// Map of policy IDs to assets.
  final Map<PolicyID, Assets> assets;
  MultiAsset._(Map<PolicyID, Assets> assets)
      : assets = Map<PolicyID, Assets>.unmodifiable(assets);

  /// Constructs an instance of MultiAsset.
  factory MultiAsset(Map<PolicyID, Assets> assets) {
    final keys = assets.keys.toList()..sort();
    return MultiAsset._({for (final i in keys) i: assets[i]!});
  }

  /// Constructs an instance of MultiAsset from a CBOR object.
  factory MultiAsset.deserialize(CborMapValue<CborObject, CborObject> cbor) {
    final assets = {
      for (final i in cbor.value.entries)
        PolicyID.deserialize(i.key.cast()): Assets.deserialize(i.value.cast())
    };
    return MultiAsset(assets);
  }

  factory MultiAsset.fromJson(Map<String, dynamic> json) {
    return MultiAsset({
      for (final i in json.entries)
        PolicyID.fromHex(i.key): Assets.fromJson(i.value)
    });
  }
  MultiAsset copyWith({Map<PolicyID, Assets>? assets}) {
    return MultiAsset(assets ?? this.assets);
  }

  MultiAsset operator +(MultiAsset other) {
    final currentAssets = Map<PolicyID, Assets>.from(assets);
    for (final i in other.assets.entries) {
      if (currentAssets.containsKey(i.key)) {
        currentAssets[i.key] = currentAssets[i.key]! + i.value;
      } else {
        currentAssets[i.key] = i.value;
      }
    }
    return MultiAsset(currentAssets);
  }

  MultiAsset operator -(MultiAsset other) {
    final currentAssets = Map<PolicyID, Assets>.from(assets);
    for (final i in other.assets.entries) {
      if (!currentAssets.containsKey(i.key)) {
        continue;
      }
      final val = currentAssets[i.key]! - i.value;
      if (val.assets.isEmpty) {
        currentAssets.remove(i.key);
      } else {
        currentAssets[i.key] = val;
      }
    }
    return MultiAsset(currentAssets);
  }

  BigInt _amount(MultiAsset ma, PolicyID pid, AssetName aname) {
    BigInt? amount = ma.assets[pid]?.assets[aname];
    return amount ?? BigInt.zero;
  }

  bool _compare(MultiAsset lhs, MultiAsset rhs) {
    for (var entry in lhs.assets.entries) {
      PolicyID pid = entry.key;
      Assets? assets = entry.value;
      for (var assetEntry in assets.assets.entries) {
        AssetName aname = assetEntry.key;
        BigInt amount = assetEntry.value;
        BigInt rhsAmount = _amount(rhs, pid, aname);
        if (amount - rhsAmount > BigInt.zero) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  int compareTo(MultiAsset other) {
    if (_compare(this, other) && _compare(other, this)) {
      return 0;
    } else if (_compare(this, other)) {
      return -1;
    } else if (_compare(other, this)) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  CborObject toCbor() {
    return CborMapValue.fixedLength(
        {for (final i in assets.entries) i.key.toCbor(): i.value.toCbor()});
  }

  @override
  Map<String, dynamic> toJson() {
    return {for (final i in assets.entries) i.key.toJson(): i.value.toJson()};
  }

  bool get hasAsset => assets.isNotEmpty;

  @override
  operator ==(other) {
    if (other is! MultiAsset) return false;
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

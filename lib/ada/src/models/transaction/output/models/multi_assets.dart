import 'package:blockchain_utils/helper/helper.dart';
import 'package:blockchain_utils/utils/utils.dart';
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

  MultiAsset updateAssetName(
      {required PolicyID polcyId,
      required AssetName assetName,
      required BigInt amount}) {
    final assets = this.assets.clone();
    if (assets.containsKey(polcyId)) {
      assets[polcyId] = assets[polcyId]!.updateAssetName(assetName, amount);
    } else {
      assets[polcyId] = Assets({assetName: amount});
    }
    return MultiAsset(assets);
  }

  MultiAsset removeAssetName(
      {required PolicyID polcyId, required AssetName assetName}) {
    final assets = this.assets.clone();
    if (assets.containsKey(polcyId)) {
      final updateAssets = assets[polcyId]!.removeAssetName(assetName);
      if (updateAssets.assets.isEmpty) {
        assets.remove(polcyId);
      } else {
        assets[polcyId] = updateAssets;
      }
    }
    return MultiAsset(assets);
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

  BigInt getAssetNameBalance(PolicyID id, AssetName name) {
    return assets[id]?.assets[name] ?? BigInt.zero;
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
    final BigInt? amount = ma.assets[pid]?.assets[aname];
    return amount ?? BigInt.zero;
  }

  bool _compare(MultiAsset lhs, MultiAsset rhs) {
    for (final entry in lhs.assets.entries) {
      final PolicyID pid = entry.key;
      final Assets assets = entry.value;
      for (final assetEntry in assets.assets.entries) {
        final AssetName aname = assetEntry.key;
        final BigInt amount = assetEntry.value;
        final BigInt rhsAmount = _amount(rhs, pid, aname);
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
  bool operator ==(other) {
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

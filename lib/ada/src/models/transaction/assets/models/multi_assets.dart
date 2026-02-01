import 'package:blockchain_utils/helper/helper.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/transaction/assets/models/asset_name.dart';
import 'assets.dart';

/// Represents a collection of multiple assets associated with policy IDs.
class MultiAsset
    with InternalCborSerialization
    implements Comparable<MultiAsset> {
  final AssetsSerializationConfig serializationConfig;
  static MultiAsset get empty => MultiAsset({});

  /// Map of policy IDs to assets.
  final Map<PolicyID, Assets> assets;
  MultiAsset._(Map<PolicyID, Assets> assets,
      {this.serializationConfig = const AssetsSerializationConfig()})
      : assets = Map<PolicyID, Assets>.unmodifiable(assets);

  /// Constructs an instance of MultiAsset.
  factory MultiAsset(Map<PolicyID, Assets> assets,
      {AssetsSerializationConfig serializationConfig =
          const AssetsSerializationConfig()}) {
    final keys = assets.keys.toList()..sort();
    return MultiAsset._({for (final i in keys) i: assets[i]!},
        serializationConfig: serializationConfig);
  }

  /// Constructs an instance of MultiAsset from a CBOR object.
  factory MultiAsset.deserialize(CborMapValue cbor) {
    final map = cbor.valueAsMap<CborBytesValue, CborMapValue>();
    final assets = {
      for (final i in map.entries)
        PolicyID.deserialize(i.key): Assets.deserialize(i.value)
    };
    return MultiAsset._(assets,
        serializationConfig: AssetsSerializationConfig(
            encoding: cbor.definite
                ? CborMapEncodingType.definite
                : CborMapEncodingType.inDefinite));
  }

  factory MultiAsset.fromJson(Map<String, dynamic> json) {
    return MultiAsset._({
      for (final i in (json["multiassets"] as Map).entries)
        PolicyID.fromHex(i.key): Assets.fromJson(i.value)
    },
        serializationConfig: AssetsSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }
  MultiAsset copyWith({Map<PolicyID, Assets>? assets}) {
    return MultiAsset._(assets ?? this.assets);
  }

  MultiAsset updateAssetName(
      {required PolicyID polcyId,
      required AssetName assetName,
      required BigInt amount}) {
    final assets = this.assets.clone();
    if (assets.containsKey(polcyId)) {
      assets[polcyId] = assets[polcyId]!.updateAssetName(assetName, amount);
    } else {
      assets[polcyId] =
          Assets({assetName: amount}, serializationConfig: serializationConfig);
    }
    return MultiAsset(assets, serializationConfig: serializationConfig);
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
    return MultiAsset(assets, serializationConfig: serializationConfig);
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
    return MultiAsset(currentAssets, serializationConfig: serializationConfig);
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
    return MultiAsset(currentAssets, serializationConfig: serializationConfig);
  }

  static BigInt _amount(MultiAsset ma, PolicyID pid, AssetName aname) {
    final BigInt? amount = ma.assets[pid]?.assets[aname];
    return amount ?? BigInt.zero;
  }

  static bool compare(MultiAsset lhs, MultiAsset rhs) {
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
    final l = compare(this, other);
    final r = compare(other, this);
    if (l && r) {
      return 0;
    } else if (l) {
      return -1;
    } else if (r) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  CborObject toCbor() {
    switch (serializationConfig.encoding) {
      case CborMapEncodingType.definite:
        return CborMapValue.definite(
            {for (final i in assets.entries) i.key.toCbor(): i.value.toCbor()});
      case CborMapEncodingType.inDefinite:
        return CborMapValue.inDefinite(
            {for (final i in assets.entries) i.key.toCbor(): i.value.toCbor()});
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "multiassets": {
        for (final i in assets.entries) i.key.toJson(): i.value.toJson()
      },
      "serialization_config": serializationConfig.toJson()
    };
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
      BinaryOps.mask32,
      (previousValue, element) =>
          previousValue ^ (element.key.hashCode ^ element.value.hashCode));
}

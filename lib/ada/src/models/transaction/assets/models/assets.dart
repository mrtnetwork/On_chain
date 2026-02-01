import 'package:blockchain_utils/helper/helper.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/transaction/assets/models/asset_name.dart';

class AssetsSerializationConfig {
  final CborMapEncodingType encoding;
  const AssetsSerializationConfig(
      {this.encoding = CborMapEncodingType.definite});
  factory AssetsSerializationConfig.fromJson(Map<String, dynamic> json) {
    return AssetsSerializationConfig(
        encoding: json["encoding"] == null
            ? CborMapEncodingType.definite
            : CborMapEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name};
  }
}

/// Represents a collection of assets with associated asset names and quantities.
class Assets with InternalCborSerialization {
  /// Map of asset names to quantities.
  final Map<AssetName, BigInt> assets;
  final AssetsSerializationConfig serializationConfig;

  /// Constructs an instance of Assets.
  Assets._(Map<AssetName, BigInt> assets,
      {this.serializationConfig = const AssetsSerializationConfig()})
      : assets = Map<AssetName, BigInt>.unmodifiable(assets);

  bool get hasAsset => assets.isNotEmpty;

  factory Assets(Map<AssetName, BigInt> assets,
      {AssetsSerializationConfig serializationConfig =
          const AssetsSerializationConfig()}) {
    final keys = assets.keys.toList()..sort();
    return Assets._({for (final i in keys) i: assets[i]!},
        serializationConfig: serializationConfig);
  }

  Assets updateAssetName(AssetName asset, BigInt amount) {
    final assets = this.assets.clone();
    assets[asset] = amount;
    return Assets(assets, serializationConfig: serializationConfig);
  }

  Assets removeAssetName(AssetName asset) {
    if (!this.assets.containsKey(asset)) {
      return this;
    }
    final assets = this.assets.clone();
    assets.remove(asset);
    return Assets(assets, serializationConfig: serializationConfig);
  }

  /// Constructs an instance of Assets from a CBOR object.
  factory Assets.deserialize(CborMapValue cbor) {
    final map = cbor.valueAsMap<CborBytesValue, CborNumeric>();
    final assets = {
      for (final entry in map.entries)
        AssetName.deserialize(entry.key): entry.value.toBigInt()
    };
    return Assets._(assets,
        serializationConfig: AssetsSerializationConfig(
            encoding: cbor.definite
                ? CborMapEncodingType.definite
                : CborMapEncodingType.inDefinite));
  }
  factory Assets.fromJson(Map<String, dynamic> json) {
    return Assets._({
      for (final i in (json["assets"] as Map).entries)
        AssetName.fromHex(i.key): BigintUtils.parse(i.value)
    },
        serializationConfig: AssetsSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  Assets copyWith({
    Map<AssetName, BigInt>? assets,
  }) {
    return Assets(assets ?? this.assets);
  }

  @override
  CborObject toCbor() {
    switch (serializationConfig.encoding) {
      case CborMapEncodingType.definite:
        return CborMapValue.definite({
          for (final i in assets.entries)
            i.key.toCbor(): CborUnsignedValue.u64(i.value)
        });
      case CborMapEncodingType.inDefinite:
        return CborMapValue.inDefinite({
          for (final i in assets.entries)
            i.key.toCbor(): CborUnsignedValue.u64(i.value)
        });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "assets": {
        for (final i in assets.entries) i.key.toJson(): i.value.toString()
      },
      "serialization_config": serializationConfig.toJson()
    };
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
    return Assets(values, serializationConfig: serializationConfig);
  }

  Assets operator -(Assets other) {
    final values = Map<AssetName, BigInt>.from(assets);
    for (final i in other.assets.entries) {
      if (!values.containsKey(i.key)) continue;
      final val = values[i.key]! - i.value;
      // assert(!val.isNegative, "invalid asset balance");
      if (val <= BigInt.zero) {
        values.remove(i.key);
      } else {
        values[i.key] = val;
      }
    }
    return Assets(values, serializationConfig: serializationConfig);
  }

  @override
  bool operator ==(other) {
    if (other is! Assets) return false;
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

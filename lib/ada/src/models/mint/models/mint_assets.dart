import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/transaction/assets/models/assets.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/transaction/assets/models/asset_name.dart';

/// Represents the assets to be minted.
class MintAssets with ADASerialization {
  final AssetsSerializationConfig serializationConfig;

  /// The map of asset names to amounts to be minted.
  final Map<AssetName, BigInt> assets;

  /// Constructs a [MintAssets] instance.
  MintAssets(Map<AssetName, BigInt> assets,
      {this.serializationConfig = const AssetsSerializationConfig()})
      : assets = Map<AssetName, BigInt>.unmodifiable(assets);

  /// Deserializes a [MintAssets] instance from a CBOR map value.
  factory MintAssets.deserialize(CborMapValue<CborObject, CborObject> cbor) {
    final Map<AssetName, BigInt> assets = {};
    for (final i in cbor.value.entries) {
      assets[AssetName.deserialize(i.key.as<CborBytesValue>("AssetName"))] =
          i.value.as<CborNumeric>("Value").toBigInt();
    }
    return MintAssets(assets,
        serializationConfig: AssetsSerializationConfig(
            encoding: cbor.definite
                ? CborMapEncodingType.definite
                : CborMapEncodingType.inDefinite));
  }
  factory MintAssets.fromJson(Map<String, dynamic> json) {
    final Map<AssetName, BigInt> assets = {};

    for (final i in (json["assets"] as Map).entries) {
      assets[AssetName.fromHex(i.key)] = BigintUtils.parse(i.value);
    }
    return MintAssets(assets,
        serializationConfig: AssetsSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }
  MintAssets copyWith(
      {Map<AssetName, BigInt>? assets,
      AssetsSerializationConfig? serializationConfig}) {
    return MintAssets(assets ?? this.assets,
        serializationConfig: serializationConfig ?? this.serializationConfig);
  }

  @override
  CborObject toCbor() {
    switch (serializationConfig.encoding) {
      case CborMapEncodingType.definite:
        return CborMapValue.definite({
          for (final i in assets.entries)
            i.key.toCbor(): CborSignedValue.i64(i.value)
        });
      case CborMapEncodingType.inDefinite:
        return CborMapValue.inDefinite({
          for (final i in assets.entries)
            i.key.toCbor(): CborSignedValue.i64(i.value)
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
}

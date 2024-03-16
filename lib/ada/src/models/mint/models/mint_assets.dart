import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/asset_name.dart';

/// Represents the assets to be minted.
class MintAssets with ADASerialization {
  /// The map of asset names to amounts to be minted.
  final Map<AssetName, BigInt> assets;

  /// Constructs a [MintAssets] instance.
  MintAssets(Map<AssetName, BigInt> assets)
      : assets = Map<AssetName, BigInt>.unmodifiable(assets);

  /// Deserializes a [MintAssets] instance from a CBOR map value.
  factory MintAssets.deserialize(CborMapValue<CborObject, CborObject> cbor) {
    final Map<AssetName, BigInt> assets = {};

    for (final i in cbor.value.entries) {
      assets[AssetName.deserialize(i.key.cast())] = i.value.getInteger();
    }
    return MintAssets(assets);
  }
  factory MintAssets.fromJson(Map<String, dynamic> json) {
    final Map<AssetName, BigInt> assets = {};

    for (final i in json.entries) {
      assets[AssetName.fromHex(i.key)] = BigintUtils.parse(i.value);
    }
    return MintAssets(assets);
  }
  MintAssets copyWith({Map<AssetName, BigInt>? assets}) {
    return MintAssets(assets ?? this.assets);
  }

  @override
  CborObject toCbor() {
    return CborMapValue.fixedLength({
      for (final i in assets.entries)
        i.key.toCbor(): CborSignedValue.i64(i.value)
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {for (final i in assets.entries) i.key.toJson(): i.value.toString()};
  }
}

import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/asset_name.dart';

/// Represents a collection of assets with associated asset names and quantities.
class Assets with ADASerialization {
  /// Map of asset names to quantities.
  final Map<AssetName, BigInt> assets;

  /// Constructs an instance of Assets.
  Assets(Map<AssetName, BigInt> assets)
      : assets = Map<AssetName, BigInt>.unmodifiable(assets);

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
  int get hashCode => assets.hashCode;
}

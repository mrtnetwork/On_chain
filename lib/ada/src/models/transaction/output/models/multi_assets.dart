import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/asset_name.dart';
import 'assets.dart';

/// Represents a collection of multiple assets associated with policy IDs.
class MultiAsset with ADASerialization implements Comparable<MultiAsset> {
  /// Map of policy IDs to assets.
  final Map<PolicyID, Assets> assets;

  /// Constructs an instance of MultiAsset.
  MultiAsset(Map<PolicyID, Assets> assets)
      : assets = Map<PolicyID, Assets>.unmodifiable(assets);

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
  MultiAsset copyWith({
    Map<PolicyID, Assets>? assets,
  }) {
    return MultiAsset(assets ?? this.assets);
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
}

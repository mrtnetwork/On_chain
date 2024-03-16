import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/types/map.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

import 'mint_assets.dart';

/// Represents information about minting assets.
class MintInfo {
  /// The policy ID associated with the minting.
  final PolicyID policyID;

  /// The assets to be minted.
  final MintAssets assets;

  /// Constructs a [MintInfo] instance.
  const MintInfo({required this.policyID, required this.assets});
  factory MintInfo.fromJson(Map<String, dynamic> json) {
    return MintInfo(
        policyID: PolicyID.fromHex(json.keys.first),
        assets: MintAssets.fromJson(json.values.first));
  }

  MintInfo copyWith({PolicyID? policyID, MintAssets? assets}) {
    return MintInfo(
        policyID: policyID ?? this.policyID, assets: assets ?? this.assets);
  }

  /// Converts [MintInfo] instance to JSON format.
  Map<String, dynamic> toJson() {
    return {policyID.toJson(): assets.toJson()};
  }
}

/// Represents a list of minting information.
class Mint with ADASerialization {
  /// The list of minting information.
  final List<MintInfo> mints;

  /// Constructs a [Mint] instance.
  Mint(List<MintInfo> mint) : mints = List<MintInfo>.unmodifiable(mint);

  /// Deserializes a [Mint] instance from a CBOR map value.
  factory Mint.deserialize(CborMapValue<CborObject, CborObject> cbor) {
    final List<MintInfo> mints = [];
    for (final i in cbor.value.entries) {
      mints.add(MintInfo(
          policyID: PolicyID.deserialize(i.key.cast()),
          assets: MintAssets.deserialize(i.value.cast())));
    }
    return Mint(mints);
  }
  factory Mint.fromJson(List<Map<String, dynamic>> json) {
    return Mint(json.map((e) => MintInfo.fromJson(e)).toList());
  }
  Mint copyWith({List<MintInfo>? mints}) {
    return Mint(mints ?? this.mints);
  }

  @override
  CborObject toCbor() {
    return CborMapValue.fixedLength(
        {for (final i in mints) i.policyID.toCbor(): i.assets.toCbor()});
  }

  @override
  List<Map<String, dynamic>> toJson() {
    return mints.map((e) => e.toJson()).toList();
  }
}

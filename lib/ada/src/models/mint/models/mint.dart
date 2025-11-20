import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/transaction/assets/models/assets.dart';
import 'package:on_chain/ada/src/models/transaction/assets/models/multi_assets.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

import 'mint_assets.dart';

/// Represents information about minting assets.
class MintInfo {
  /// The policy ID associated with the minting.
  final PolicyID policyID;

  /// The assets to be minted.
  final MintAssets assets;

  /// Constructs a [MintInfo] instance.
  MintInfo({required this.policyID, required this.assets});
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

  late final MultiAsset multiAsset =
      MultiAsset({policyID: Assets(assets.assets)});
}

/// Represents a list of minting information.
class Mint with InternalCborSerialization {
  final AssetsSerializationConfig serializationConfig;

  /// The list of minting information.
  final List<MintInfo> mints;

  /// Constructs a [Mint] instance.
  Mint(List<MintInfo> mint,
      {this.serializationConfig = const AssetsSerializationConfig()})
      : mints = List<MintInfo>.unmodifiable(mint);

  /// Deserializes a [Mint] instance from a CBOR map value.
  factory Mint.deserialize(CborMapValue<CborObject, CborObject> cbor) {
    final List<MintInfo> mints = [];
    for (final i in cbor.value.entries) {
      mints.add(MintInfo(
          policyID: PolicyID.deserialize(i.key.as<CborBytesValue>("PolicyID")),
          assets: MintAssets.deserialize(
              i.value.asMap<CborObject, CborObject>("Assets"))));
    }
    return Mint(mints,
        serializationConfig: AssetsSerializationConfig(
            encoding: cbor.definite
                ? CborMapEncodingType.definite
                : CborMapEncodingType.inDefinite));
  }
  factory Mint.fromJson(Map<String, dynamic> json) {
    return Mint(
        (json["assets"] as List).map((e) => MintInfo.fromJson(e)).toList(),
        serializationConfig: AssetsSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }
  Mint copyWith(
      {List<MintInfo>? mints, AssetsSerializationConfig? serializationConfig}) {
    return Mint(mints ?? this.mints,
        serializationConfig: serializationConfig ?? this.serializationConfig);
  }

  @override
  CborObject toCbor() {
    switch (serializationConfig.encoding) {
      case CborMapEncodingType.definite:
        return CborMapValue.definite(
            {for (final i in mints) i.policyID.toCbor(): i.assets.toCbor()});
      case CborMapEncodingType.inDefinite:
        return CborMapValue.inDefinite(
            {for (final i in mints) i.policyID.toCbor(): i.assets.toCbor()});
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "assets": mints.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}

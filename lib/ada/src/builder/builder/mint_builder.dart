import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/models/models.dart';

class ADAMinsBuilder {
  final Assets mintingAssets;
  final ADAAddress owner;
  final NativeScriptScriptPubkey minterScript;
  ADAMinsBuilder(
      {required this.minterScript,
      required this.mintingAssets,
      required this.owner});
  PolicyID toPolicyId() {
    return PolicyID(minterScript.toHash().data);
  }

  MultiAsset toMultiAssets() => MultiAsset({toPolicyId(): mintingAssets});

  MintAssets toMintAsset() {
    return MintAssets(mintingAssets.assets);
  }

  MintInfo toMintInfo() {
    return MintInfo(policyID: toPolicyId(), assets: toMintAsset());
  }
}

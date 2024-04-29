import 'package:blockchain_utils/binary/utils.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/models/ada_models.dart';

class ADAMinsBuilder {
  final Assets mintingAssets;
  final ADAAddress owner;
  final List<int> pubKeyBytes;
  ADAMinsBuilder(
      {required List<int> pubKeyBytes,
      required this.mintingAssets,
      required this.owner})
      : pubKeyBytes = BytesUtils.toBytes(pubKeyBytes);
  PolicyID toPolicyId() {
    return PolicyID(toScript().toHash().data);
  }

  MultiAsset toMultiAssets() => MultiAsset({toPolicyId(): mintingAssets});

  NativeScriptScriptPubkey toScript() {
    final publickKey = Ed25519KeyHash.fromPubkey(pubKeyBytes);
    return NativeScriptScriptPubkey(publickKey);
  }

  MintAssets toMintAsset() {
    return MintAssets(mintingAssets.assets);
  }

  MintInfo toMintInfo() {
    return MintInfo(policyID: toPolicyId(), assets: toMintAsset());
  }
}

import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';

class SolanaLayoutUtils {
  // /// [SolAddress] values.
  static CustomLayout publicKey([String? property]) {
    return CustomLayout<List<int>, SolAddress>(
        layout: LayoutConst.blob(32),
        decoder: (data) => SolAddress.uncheckBytes(data),
        encoder: (src) => src.toBytes(),
        property: property);
  }

  /// optional [SolAddress] values.
  static OptionalLayout optionPubkey(
      {String? property, bool keepSize = false}) {
    return OptionalLayout(publicKey(),
        property: property, keepLayoutSize: keepSize);
  }

  static COptionLayout cOptionPubkey(
      {String? property, Layout? discriminator}) {
    return LayoutConst.cOptionalPublicKey(publicKey());
  }
}

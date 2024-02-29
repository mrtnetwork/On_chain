import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseCancelLayout
    extends MetaplexAuctionHouseProgramLayout {
  final BigInt buyerPrice;
  final BigInt tokenSize;
  const MetaplexAuctionHouseCancelLayout(
      {required this.buyerPrice, required this.tokenSize});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseCancelLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction.cancel.insturction);
    return MetaplexAuctionHouseCancelLayout(
        buyerPrice: decode["buyerPrice"], tokenSize: decode["tokenSize"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u64("buyerPrice"),
    LayoutUtils.u64("tokenSize"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.cancel.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"tokenSize": tokenSize, "buyerPrice": buyerPrice};
  }
}

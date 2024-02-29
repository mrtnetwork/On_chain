import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexFixedPriceSaleChangeMarketLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  MetaplexFixedPriceSaleChangeMarketLayout(
      {this.newName,
      this.newDescription,
      this.mutable,
      this.newPrice,
      this.newPiecesInOneWallet});

  /// Constructs the layout from raw bytes.
  factory MetaplexFixedPriceSaleChangeMarketLayout.fromBuffer(List<int> data) {
    final decode = MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexFixedPriceSaleProgramInstruction.changeMarket.insturction);
    return MetaplexFixedPriceSaleChangeMarketLayout(
        newName: decode["newName"],
        newDescription: decode["newDescription"],
        mutable: decode["mutable"],
        newPrice: decode["newPrice"],
        newPiecesInOneWallet: decode["newPiecesInOneWallet"]);
  }
  final String? newName;
  final String? newDescription;
  final bool? mutable;
  final BigInt? newPrice;
  final BigInt? newPiecesInOneWallet;

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.optional(LayoutUtils.string(), property: "newName"),
    LayoutUtils.optional(LayoutUtils.string(), property: "newDescription"),
    LayoutUtils.optional(LayoutUtils.boolean(), property: "mutable"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "newPrice"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "newPiecesInOneWallet"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.changeMarket.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "newName": newName,
      "newDescription": newDescription,
      "mutable": mutable,
      "newPrice": newPrice,
      "newPiecesInOneWallet": newPiecesInOneWallet
    };
  }
}

import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.optional(LayoutConst.string(), property: "newName"),
    LayoutConst.optional(LayoutConst.string(), property: "newDescription"),
    LayoutConst.optional(LayoutConst.boolean(), property: "mutable"),
    LayoutConst.optional(LayoutConst.u64(), property: "newPrice"),
    LayoutConst.optional(LayoutConst.u64(), property: "newPiecesInOneWallet"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexFixedPriceSaleProgramInstruction get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.changeMarket;

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

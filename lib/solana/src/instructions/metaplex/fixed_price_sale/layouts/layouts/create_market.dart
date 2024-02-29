import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/gating_config.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexFixedPriceSaleCreateMarketLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  final int treasuryOwnerBump;
  final String name;
  final String description;
  final bool mutable;
  final BigInt price;
  final BigInt? piecesInOneWallet;
  final BigInt startDate;
  final BigInt? endDate;
  final GatingConfig? gatingConfig;
  MetaplexFixedPriceSaleCreateMarketLayout(
      {required this.treasuryOwnerBump,
      required this.name,
      required this.description,
      required this.mutable,
      required this.price,
      this.piecesInOneWallet,
      required this.startDate,
      this.endDate,
      this.gatingConfig});

  /// Constructs the layout from raw bytes.
  factory MetaplexFixedPriceSaleCreateMarketLayout.fromBuffer(List<int> data) {
    final decode = MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexFixedPriceSaleProgramInstruction.createMarket.insturction);
    return MetaplexFixedPriceSaleCreateMarketLayout(
        treasuryOwnerBump: decode["treasuryOwnerBump"],
        name: decode["name"],
        description: decode["description"],
        mutable: decode["mutable"],
        price: decode["price"],
        piecesInOneWallet: decode["piecesInOneWallet"],
        startDate: decode["startDate"],
        endDate: decode["endDate"],
        gatingConfig: decode["gatingConfig"] == null
            ? null
            : GatingConfig.fromJson(decode["gatingConfig"]));
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("treasuryOwnerBump"),
    LayoutUtils.string("name"),
    LayoutUtils.string("description"),
    LayoutUtils.boolean(property: "mutable"),
    LayoutUtils.u64("price"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "piecesInOneWallet"),
    LayoutUtils.u64("startDate"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "endDate"),
    LayoutUtils.optional(GatingConfig.staticLayout, property: "gatingConfig"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.createMarket.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "treasuryOwnerBump": treasuryOwnerBump,
      "name": name,
      "description": description,
      "mutable": mutable,
      "price": price,
      "piecesInOneWallet": piecesInOneWallet,
      "startDate": startDate,
      "endDate": endDate,
      "gatingConfig": gatingConfig?.serialize()
    };
  }
}

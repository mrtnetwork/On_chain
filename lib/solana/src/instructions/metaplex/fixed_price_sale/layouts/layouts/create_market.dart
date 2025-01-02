import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/gating_config.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
        treasuryOwnerBump: decode['treasuryOwnerBump'],
        name: decode['name'],
        description: decode['description'],
        mutable: decode['mutable'],
        price: decode['price'],
        piecesInOneWallet: decode['piecesInOneWallet'],
        startDate: decode['startDate'],
        endDate: decode['endDate'],
        gatingConfig: decode['gatingConfig'] == null
            ? null
            : GatingConfig.fromJson(decode['gatingConfig']));
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u8(property: 'treasuryOwnerBump'),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'description'),
    LayoutConst.boolean(property: 'mutable'),
    LayoutConst.u64(property: 'price'),
    LayoutConst.optional(LayoutConst.u64(), property: 'piecesInOneWallet'),
    LayoutConst.u64(property: 'startDate'),
    LayoutConst.optional(LayoutConst.u64(), property: 'endDate'),
    LayoutConst.optional(GatingConfig.staticLayout, property: 'gatingConfig'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexFixedPriceSaleProgramInstruction get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.createMarket;

  @override
  Map<String, dynamic> serialize() {
    return {
      'treasuryOwnerBump': treasuryOwnerBump,
      'name': name,
      'description': description,
      'mutable': mutable,
      'price': price,
      'piecesInOneWallet': piecesInOneWallet,
      'startDate': startDate,
      'endDate': endDate,
      'gatingConfig': gatingConfig?.serialize()
    };
  }
}

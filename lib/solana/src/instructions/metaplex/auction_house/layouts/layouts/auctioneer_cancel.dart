import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseAuctioneerCancelLayout
    extends MetaplexAuctionHouseProgramLayout {
  final BigInt buyerPrice;
  final BigInt tokenSize;
  const MetaplexAuctionHouseAuctioneerCancelLayout(
      {required this.buyerPrice, required this.tokenSize});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseAuctioneerCancelLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .auctioneerCancel.insturction);
    return MetaplexAuctionHouseAuctioneerCancelLayout(
        buyerPrice: decode['buyerPrice'], tokenSize: decode['tokenSize']);
  }

  /// StructLayout layout definition.
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.u64(property: 'buyerPrice'),
        LayoutConst.u64(property: 'tokenSize'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.auctioneerCancel;

  @override
  Map<String, dynamic> serialize() {
    return {'buyerPrice': buyerPrice, 'tokenSize': tokenSize};
  }
}

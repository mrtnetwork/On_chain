import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
        buyerPrice: decode['buyerPrice'], tokenSize: decode['tokenSize']);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u64(property: 'buyerPrice'),
    LayoutConst.u64(property: 'tokenSize'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.cancel;

  @override
  Map<String, dynamic> serialize() {
    return {'tokenSize': tokenSize, 'buyerPrice': buyerPrice};
  }
}

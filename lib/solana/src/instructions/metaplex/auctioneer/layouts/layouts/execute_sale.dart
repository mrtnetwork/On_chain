import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

/// auctioneer execute sale layput.
class MetaplexAuctioneerExecuteSaleLayout
    extends MetaplexAuctioneerProgramLayout {
  final int escrowPaymentBump;
  final int freeTradeStateBump;
  final int programAsSignerBump;
  final int auctioneerAuthorityBump;
  final BigInt buyerPrice;
  final BigInt tokenSize;
  const MetaplexAuctioneerExecuteSaleLayout(
      {required this.escrowPaymentBump,
      required this.freeTradeStateBump,
      required this.programAsSignerBump,
      required this.auctioneerAuthorityBump,
      required this.buyerPrice,
      required this.tokenSize});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctioneerExecuteSaleLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctioneerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexAuctioneerProgramInstruction.executeSale.insturction);
    return MetaplexAuctioneerExecuteSaleLayout(
        escrowPaymentBump: decode["escrowPaymentBump"],
        freeTradeStateBump: decode["freeTradeStateBump"],
        programAsSignerBump: decode["programAsSignerBump"],
        auctioneerAuthorityBump: decode["auctioneerAuthorityBump"],
        buyerPrice: decode["buyerPrice"],
        tokenSize: decode["tokenSize"]);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "escrowPaymentBump"),
    LayoutConst.u8(property: "freeTradeStateBump"),
    LayoutConst.u8(property: "programAsSignerBump"),
    LayoutConst.u8(property: "auctioneerAuthorityBump"),
    LayoutConst.u64(property: "buyerPrice"),
    LayoutConst.u64(property: "tokenSize"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctioneerProgramInstruction get instruction =>
      MetaplexAuctioneerProgramInstruction.executeSale;

  @override
  Map<String, dynamic> serialize() {
    return {
      "escrowPaymentBump": escrowPaymentBump,
      "freeTradeStateBump": freeTradeStateBump,
      "programAsSignerBump": programAsSignerBump,
      "auctioneerAuthorityBump": auctioneerAuthorityBump,
      "buyerPrice": buyerPrice,
      "tokenSize": tokenSize
    };
  }
}

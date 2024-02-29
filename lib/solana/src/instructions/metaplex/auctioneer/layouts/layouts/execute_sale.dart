import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("escrowPaymentBump"),
    LayoutUtils.u8("freeTradeStateBump"),
    LayoutUtils.u8("programAsSignerBump"),
    LayoutUtils.u8("auctioneerAuthorityBump"),
    LayoutUtils.u64("buyerPrice"),
    LayoutUtils.u64("tokenSize"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctioneerProgramInstruction.executeSale.insturction;

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

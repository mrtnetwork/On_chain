import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

/// Auctioneer buy layout.
class MetaplexAuctioneerBuyLayout extends MetaplexAuctioneerProgramLayout {
  final int tradeStateBump;
  final int escrowPaymentBump;
  final int auctioneerAuthorityBump;
  final BigInt buyerPrice;
  final BigInt tokenSize;
  const MetaplexAuctioneerBuyLayout(
      {required this.tradeStateBump,
      required this.escrowPaymentBump,
      required this.auctioneerAuthorityBump,
      required this.buyerPrice,
      required this.tokenSize});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctioneerBuyLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctioneerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctioneerProgramInstruction.buy.insturction);
    return MetaplexAuctioneerBuyLayout(
        tradeStateBump: decode["tradeStateBump"],
        escrowPaymentBump: decode["escrowPaymentBump"],
        auctioneerAuthorityBump: decode["auctioneerAuthorityBump"],
        buyerPrice: decode["buyerPrice"],
        tokenSize: decode["tokenSize"]);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "tradeStateBump"),
    LayoutConst.u8(property: "escrowPaymentBump"),
    LayoutConst.u8(property: "auctioneerAuthorityBump"),
    LayoutConst.u64(property: "buyerPrice"),
    LayoutConst.u64(property: "tokenSize"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctioneerProgramInstruction.buy.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tradeStateBump": tradeStateBump,
      "escrowPaymentBump": escrowPaymentBump,
      "auctioneerAuthorityBump": auctioneerAuthorityBump,
      "buyerPrice": buyerPrice,
      "tokenSize": tokenSize
    };
  }
}

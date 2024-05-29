import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

/// auctioneer cancel Layout.
class MetaplexAuctioneerCancelLayout extends MetaplexAuctioneerProgramLayout {
  final int auctioneerAuthorityBump;
  final BigInt buyerPrice;
  final BigInt tokenSize;
  const MetaplexAuctioneerCancelLayout(
      {required this.auctioneerAuthorityBump,
      required this.buyerPrice,
      required this.tokenSize});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctioneerCancelLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctioneerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctioneerProgramInstruction.cancel.insturction);
    return MetaplexAuctioneerCancelLayout(
        auctioneerAuthorityBump: decode["auctioneerAuthorityBump"],
        buyerPrice: decode["buyerPrice"],
        tokenSize: decode["tokenSize"]);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "auctioneerAuthorityBump"),
    LayoutConst.u64(property: "buyerPrice"),
    LayoutConst.u64(property: "tokenSize"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctioneerProgramInstruction.cancel.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "auctioneerAuthorityBump": auctioneerAuthorityBump,
      "buyerPrice": buyerPrice,
      "tokenSize": tokenSize
    };
  }
}

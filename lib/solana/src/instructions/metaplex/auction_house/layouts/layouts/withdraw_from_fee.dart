import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseWithdrawFromFeeLayout
    extends MetaplexAuctionHouseProgramLayout {
  final BigInt amount;
  const MetaplexAuctionHouseWithdrawFromFeeLayout({required this.amount});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseWithdrawFromFeeLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexAuctionHouseProgramInstruction.withdrawFromFee.insturction);
    return MetaplexAuctionHouseWithdrawFromFeeLayout(amount: decode["amount"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u64("amount"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.withdrawFromFee.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}

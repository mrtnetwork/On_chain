import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseWithdrawFromTreasuryLayout
    extends MetaplexAuctionHouseProgramLayout {
  final BigInt amount;
  MetaplexAuctionHouseWithdrawFromTreasuryLayout({required this.amount});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseWithdrawFromTreasuryLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .withdrawFromTreasury.insturction);
    return MetaplexAuctionHouseWithdrawFromTreasuryLayout(
        amount: decode['amount']);
  }

  /// StructLayout layout definition.
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.u64(property: 'amount'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.withdrawFromTreasury;

  @override
  Map<String, dynamic> serialize() {
    return {'amount': amount};
  }
}

import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseExecuteSaleRemainingAccountsLayout
    extends MetaplexAuctionHouseProgramLayout {
  const MetaplexAuctionHouseExecuteSaleRemainingAccountsLayout();

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseExecuteSaleRemainingAccountsLayout.fromBuffer(
      List<int> data) {
    MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .executeSaleRemainingAccounts.insturction);
    return const MetaplexAuctionHouseExecuteSaleRemainingAccountsLayout();
  }

  /// StructLayout layout definition.
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.executeSaleRemainingAccounts;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}

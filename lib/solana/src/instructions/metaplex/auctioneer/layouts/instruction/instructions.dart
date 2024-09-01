import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/constant.dart';

class MetaplexAuctioneerProgramInstruction implements ProgramLayoutInstruction {
  @override
  final List<int> insturction;
  @override
  final String name;
  const MetaplexAuctioneerProgramInstruction(this.insturction, this.name);
  static const MetaplexAuctioneerProgramInstruction authorize =
      MetaplexAuctioneerProgramInstruction(
          [173, 193, 102, 210, 219, 137, 113, 120], "Authorize");
  static const MetaplexAuctioneerProgramInstruction buy =
      MetaplexAuctioneerProgramInstruction(
          [102, 6, 61, 18, 1, 218, 235, 234], "Buy");
  static const MetaplexAuctioneerProgramInstruction cancel =
      MetaplexAuctioneerProgramInstruction(
          [232, 219, 223, 41, 219, 236, 220, 190], "Cancel");
  static const MetaplexAuctioneerProgramInstruction deposit =
      MetaplexAuctioneerProgramInstruction(
          [242, 35, 198, 137, 82, 225, 242, 182], "Deposit");
  static const MetaplexAuctioneerProgramInstruction executeSale =
      MetaplexAuctioneerProgramInstruction(
          [37, 74, 217, 157, 79, 49, 35, 6], "ExecuteSale");
  static const MetaplexAuctioneerProgramInstruction sell =
      MetaplexAuctioneerProgramInstruction(
          [51, 230, 133, 164, 1, 127, 131, 173], "Sell");
  static const MetaplexAuctioneerProgramInstruction withdraw =
      MetaplexAuctioneerProgramInstruction(
          [183, 18, 70, 156, 148, 109, 161, 34], "Withdraw");

  static const List<MetaplexAuctioneerProgramInstruction> values = [
    authorize,
    buy,
    cancel,
    deposit,
    executeSale,
    sell,
    withdraw
  ];
  static MetaplexAuctioneerProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere(
          (element) => BytesUtils.bytesEqual(element.insturction, value));
    } catch (_) {
      return null;
    }
  }

  @override
  String get programName => "MetaplexAuctioneer";

  @override
  SolAddress get programAddress => MetaplexAuctioneerProgramConst.programId;
}

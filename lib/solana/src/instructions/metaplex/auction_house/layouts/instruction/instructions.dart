import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/constant.dart';

class MetaplexAuctionHouseProgramInstruction
    implements ProgramLayoutInstruction {
  @override
  final List<int> insturction;
  @override
  final String name;
  const MetaplexAuctionHouseProgramInstruction(this.insturction, this.name);
  static const MetaplexAuctionHouseProgramInstruction auctioneerBuy =
      MetaplexAuctionHouseProgramInstruction(
          [17, 106, 133, 46, 229, 48, 45, 208], "AuctioneerBuy");

  static const MetaplexAuctionHouseProgramInstruction auctioneerCancel =
      MetaplexAuctionHouseProgramInstruction(
          [197, 97, 152, 196, 115, 204, 64, 215], "AuctioneerCancel");

  static const MetaplexAuctionHouseProgramInstruction auctioneerDeposit =
      MetaplexAuctionHouseProgramInstruction(
          [79, 122, 37, 162, 120, 173, 57, 127], "AuctioneerDeposit");
  static const MetaplexAuctionHouseProgramInstruction
      auctioneerExecutePartialSale = MetaplexAuctionHouseProgramInstruction(
          [9, 44, 46, 15, 161, 143, 21, 54], "AuctioneerExecutePartialSale");
  static const MetaplexAuctionHouseProgramInstruction auctioneerExecuteSale =
      MetaplexAuctionHouseProgramInstruction(
          [68, 125, 32, 65, 251, 43, 35, 53], "AuctioneerExecuteSale");
  static const MetaplexAuctionHouseProgramInstruction auctioneerPublicBuy =
      MetaplexAuctionHouseProgramInstruction(
          [221, 239, 99, 240, 86, 46, 213, 126], "AuctioneerPublicBuy");
  static const MetaplexAuctionHouseProgramInstruction auctioneerSell =
      MetaplexAuctionHouseProgramInstruction(
          [251, 60, 142, 195, 121, 203, 26, 183], "AuctioneerSell");
  static const MetaplexAuctionHouseProgramInstruction auctioneerWithdraw =
      MetaplexAuctionHouseProgramInstruction(
          [85, 166, 219, 110, 168, 143, 180, 236], "AuctioneerWithdraw");
  static const MetaplexAuctionHouseProgramInstruction buy =
      MetaplexAuctionHouseProgramInstruction(
          [102, 6, 61, 18, 1, 218, 235, 234], "Buy");
  static const MetaplexAuctionHouseProgramInstruction cancel =
      MetaplexAuctionHouseProgramInstruction(
          [232, 219, 223, 41, 219, 236, 220, 190], "Cancel");
  static const MetaplexAuctionHouseProgramInstruction cancelBidReceipt =
      MetaplexAuctionHouseProgramInstruction(
          [246, 108, 27, 229, 220, 42, 176, 43], "CancelBidReceipt");
  static const MetaplexAuctionHouseProgramInstruction cancelListingReceipt =
      MetaplexAuctionHouseProgramInstruction(
          [171, 59, 138, 126, 246, 189, 91, 11], "CancelListingReceipt");
  static const MetaplexAuctionHouseProgramInstruction cancelRemainingAccounts =
      MetaplexAuctionHouseProgramInstruction(
          [107, 77, 161, 251, 70, 129, 189, 156], "CancelRemainingAccounts");
  static const MetaplexAuctionHouseProgramInstruction closeEscrowAccount =
      MetaplexAuctionHouseProgramInstruction(
          [209, 42, 208, 179, 140, 78, 18, 43], "CloseEscrowAccount");
  static const MetaplexAuctionHouseProgramInstruction createAuctionHouse =
      MetaplexAuctionHouseProgramInstruction(
          [221, 66, 242, 159, 249, 206, 134, 241], "CreateAuctionHouse");
  static const MetaplexAuctionHouseProgramInstruction delegateAuctioneer =
      MetaplexAuctionHouseProgramInstruction(
          [106, 178, 12, 122, 74, 173, 251, 222], "DelegateAuctioneer");
  static const MetaplexAuctionHouseProgramInstruction deposit =
      MetaplexAuctionHouseProgramInstruction(
          [242, 35, 198, 137, 82, 225, 242, 182], "Deposit");
  static const MetaplexAuctionHouseProgramInstruction executePartialSale =
      MetaplexAuctionHouseProgramInstruction(
          [163, 18, 35, 157, 49, 164, 203, 133], "ExecutePartialSale");
  static const MetaplexAuctionHouseProgramInstruction executeSale =
      MetaplexAuctionHouseProgramInstruction(
          [37, 74, 217, 157, 79, 49, 35, 6], "ExecuteSale");
  static const MetaplexAuctionHouseProgramInstruction
      executeSaleRemainingAccounts = MetaplexAuctionHouseProgramInstruction(
          [159, 12, 171, 254, 141, 198, 122, 7],
          "ExecuteSaleRemainingAccounts");
  static const MetaplexAuctionHouseProgramInstruction printBidReceipt =
      MetaplexAuctionHouseProgramInstruction(
          [94, 249, 90, 230, 239, 64, 68, 218], "PrintBidReceipt");
  static const MetaplexAuctionHouseProgramInstruction printListingReceipt =
      MetaplexAuctionHouseProgramInstruction(
          [207, 107, 44, 160, 75, 222, 195, 27], "PrintListingReceipt");
  static const MetaplexAuctionHouseProgramInstruction printPurchaseReceipt =
      MetaplexAuctionHouseProgramInstruction(
          [227, 154, 251, 7, 180, 56, 100, 143], "PrintPurchaseReceipt");
  static const MetaplexAuctionHouseProgramInstruction publicBuy =
      MetaplexAuctionHouseProgramInstruction(
          [169, 84, 218, 35, 42, 206, 16, 171], "PublicBuy");
  static const MetaplexAuctionHouseProgramInstruction sell =
      MetaplexAuctionHouseProgramInstruction(
          [51, 230, 133, 164, 1, 127, 131, 173], "Sell");
  static const MetaplexAuctionHouseProgramInstruction sellRemainingAccounts =
      MetaplexAuctionHouseProgramInstruction(
          [113, 23, 199, 41, 25, 203, 234, 30], "SellRemainingAccounts");
  static const MetaplexAuctionHouseProgramInstruction updateAuctioneer =
      MetaplexAuctionHouseProgramInstruction(
          [103, 255, 80, 234, 94, 56, 168, 208], "UpdateAuctioneer");
  static const MetaplexAuctionHouseProgramInstruction updateAuctionHouse =
      MetaplexAuctionHouseProgramInstruction(
          [84, 215, 2, 172, 241, 0, 245, 219], "UpdateAuctionHouse");
  static const MetaplexAuctionHouseProgramInstruction withdraw =
      MetaplexAuctionHouseProgramInstruction(
          [183, 18, 70, 156, 148, 109, 161, 34], "Withdraw");
  static const MetaplexAuctionHouseProgramInstruction withdrawFromFee =
      MetaplexAuctionHouseProgramInstruction(
          [179, 208, 190, 154, 32, 179, 19, 59], "WithdrawFromFee");
  static const MetaplexAuctionHouseProgramInstruction withdrawFromTreasury =
      MetaplexAuctionHouseProgramInstruction(
          [0, 164, 86, 76, 56, 72, 12, 170], "WithdrawFromTreasury");
  static const List<MetaplexAuctionHouseProgramInstruction> values = [
    auctioneerBuy,
    auctioneerCancel,
    auctioneerDeposit,
    auctioneerExecutePartialSale,
    auctioneerExecuteSale,
    auctioneerPublicBuy,
    auctioneerSell,
    auctioneerWithdraw,
    buy,
    cancel,
    cancelBidReceipt,
    cancelListingReceipt,
    cancelRemainingAccounts,
    closeEscrowAccount,
    createAuctionHouse,
    delegateAuctioneer,
    deposit,
    executePartialSale,
    executeSale,
    executeSaleRemainingAccounts,
    printBidReceipt,
    printListingReceipt,
    printPurchaseReceipt,
    publicBuy,
    sell,
    sellRemainingAccounts,
    updateAuctioneer,
    updateAuctionHouse,
    withdraw,
    withdrawFromFee,
    withdrawFromTreasury
  ];
  static MetaplexAuctionHouseProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere(
          (element) => BytesUtils.bytesEqual(element.insturction, value));
    } catch (_) {
      return null;
    }
  }

  @override
  String get programName => "MetaplexAuctionHouse";

  @override
  SolAddress get programAddress => MetaplexAuctionHouseProgramConst.programId;
}

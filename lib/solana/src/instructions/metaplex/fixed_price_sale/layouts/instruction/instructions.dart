import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexFixedPriceSaleProgramInstruction
    implements ProgramLayoutInstruction {
  @override
  final List<int> insturction;
  @override
  final String name;
  const MetaplexFixedPriceSaleProgramInstruction(this.insturction, this.name);
  static const MetaplexFixedPriceSaleProgramInstruction buy =
      MetaplexFixedPriceSaleProgramInstruction(
          [102, 6, 61, 18, 1, 218, 235, 234], "Buy");
  static const MetaplexFixedPriceSaleProgramInstruction buyV2 =
      MetaplexFixedPriceSaleProgramInstruction(
          [184, 23, 238, 97, 103, 197, 211, 61], "BuyV2");
  static const MetaplexFixedPriceSaleProgramInstruction changeMarket =
      MetaplexFixedPriceSaleProgramInstruction(
          [130, 59, 109, 101, 85, 226, 37, 88], "ChangeMarket");
  static const MetaplexFixedPriceSaleProgramInstruction claimResource =
      MetaplexFixedPriceSaleProgramInstruction(
          [0, 160, 164, 96, 237, 118, 74, 27], "ClaimResource");
  static const MetaplexFixedPriceSaleProgramInstruction closeMarket =
      MetaplexFixedPriceSaleProgramInstruction(
          [88, 154, 248, 186, 48, 14, 123, 244], "CloseMarket");
  static const MetaplexFixedPriceSaleProgramInstruction createMarket =
      MetaplexFixedPriceSaleProgramInstruction(
          [103, 226, 97, 235, 200, 188, 251, 254], "CreateMarket");
  static const MetaplexFixedPriceSaleProgramInstruction createStore =
      MetaplexFixedPriceSaleProgramInstruction(
          [132, 152, 9, 27, 112, 19, 95, 83], "CreateStore");
  static const MetaplexFixedPriceSaleProgramInstruction initSellingResource =
      MetaplexFixedPriceSaleProgramInstruction(
          [56, 15, 222, 211, 147, 205, 4, 145], "InitSellingResource");
  static const MetaplexFixedPriceSaleProgramInstruction resumeMarket =
      MetaplexFixedPriceSaleProgramInstruction(
          [198, 120, 104, 87, 44, 103, 108, 143], "ResumeMarket");
  static const MetaplexFixedPriceSaleProgramInstruction
      savePrimaryMetadataCreators = MetaplexFixedPriceSaleProgramInstruction(
          [66, 240, 213, 46, 185, 60, 192, 254], "SavePrimaryMetadataCreators");
  static const MetaplexFixedPriceSaleProgramInstruction suspendMarket =
      MetaplexFixedPriceSaleProgramInstruction(
          [246, 27, 129, 46, 10, 196, 165, 118], "SuspendMarket");
  static const MetaplexFixedPriceSaleProgramInstruction withdraw =
      MetaplexFixedPriceSaleProgramInstruction(
          [183, 18, 70, 156, 148, 109, 161, 34], "Withdraw");
  static const List<MetaplexFixedPriceSaleProgramInstruction> values = [
    buy,
    buyV2,
    changeMarket,
    claimResource,
    closeMarket,
    createMarket,
    createStore,
    initSellingResource,
    resumeMarket,
    savePrimaryMetadataCreators,
    suspendMarket,
    withdraw
  ];
  static MetaplexFixedPriceSaleProgramInstruction? getInstruction(
      dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } on StateError {
      return null;
    }
  }
}

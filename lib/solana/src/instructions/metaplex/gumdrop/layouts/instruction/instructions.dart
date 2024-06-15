import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexGumdropProgramInstruction implements ProgramLayoutInstruction {
  @override
  final List<int> insturction;
  @override
  final String name;
  const MetaplexGumdropProgramInstruction(this.insturction, this.name);
  static const MetaplexGumdropProgramInstruction claim =
      MetaplexGumdropProgramInstruction(
          [62, 198, 214, 193, 213, 159, 108, 210], "Claim");
  static const MetaplexGumdropProgramInstruction claimCandy =
      MetaplexGumdropProgramInstruction(
          [87, 176, 177, 90, 136, 95, 83, 242], "ClaimCandy");

  static const MetaplexGumdropProgramInstruction proveClaim =
      MetaplexGumdropProgramInstruction(
          [52, 82, 123, 224, 40, 139, 230, 184], "ProveClaim");
  static const MetaplexGumdropProgramInstruction recoverUpdateAuthority =
      MetaplexGumdropProgramInstruction(
          [142, 251, 209, 116, 87, 100, 36, 191], "RecoverUpdateAuthority");
  static const MetaplexGumdropProgramInstruction claimCandyProven =
      MetaplexGumdropProgramInstruction(
          [1, 2, 30, 252, 145, 228, 67, 145], "ClaimCandyProven");
  static const MetaplexGumdropProgramInstruction claimEdition =
      MetaplexGumdropProgramInstruction(
          [150, 83, 124, 180, 53, 35, 144, 248], "ClaimEdition");
  static const MetaplexGumdropProgramInstruction closeDistributor =
      MetaplexGumdropProgramInstruction(
          [202, 56, 180, 143, 46, 104, 106, 112], "CloseDistributor");
  static const MetaplexGumdropProgramInstruction closeDistributorTokenAccount =
      MetaplexGumdropProgramInstruction(
          [156, 174, 153, 120, 102, 150, 134, 142],
          "CloseDistributorTokenAccount");
  static const MetaplexGumdropProgramInstruction newDistributor =
      MetaplexGumdropProgramInstruction(
          [32, 139, 112, 171, 0, 2, 225, 155], "NewDistributor");

  static const List<MetaplexGumdropProgramInstruction> values = [
    claim,
    claimCandy,
    claimEdition,
    closeDistributor,
    closeDistributorTokenAccount,
    newDistributor
  ];
  static MetaplexGumdropProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere(
          (element) => BytesUtils.bytesEqual(element.insturction, value));
    } on StateError {
      return null;
    }
  }
}

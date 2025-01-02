import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/constant.dart';

class MetaplexHydraProgramInstruction implements ProgramLayoutInstruction {
  @override
  final List<int> insturction;
  @override
  final String name;
  const MetaplexHydraProgramInstruction(this.insturction, this.name);
  static const MetaplexHydraProgramInstruction processAddMemberNft =
      MetaplexHydraProgramInstruction(
          [92, 255, 105, 209, 25, 41, 3, 7], 'ProcessAddMemberNft');
  static const MetaplexHydraProgramInstruction processAddMemberWallet =
      MetaplexHydraProgramInstruction(
          [201, 9, 59, 128, 69, 117, 220, 235], 'ProcessAddMemberWallet');
  static const MetaplexHydraProgramInstruction processDistributeNft =
      MetaplexHydraProgramInstruction(
          [108, 240, 68, 81, 144, 83, 58, 153], 'ProcessDistributeNft');
  static const MetaplexHydraProgramInstruction processDistributeToken =
      MetaplexHydraProgramInstruction(
          [126, 105, 46, 135, 28, 36, 117, 212], 'ProcessDistributeToken');
  static const MetaplexHydraProgramInstruction processDistributeWallet =
      MetaplexHydraProgramInstruction(
          [252, 168, 167, 66, 40, 201, 182, 163], 'ProcessDistributeWallet');
  static const MetaplexHydraProgramInstruction processInit =
      MetaplexHydraProgramInstruction(
          [172, 5, 165, 143, 86, 159, 50, 237], 'ProcessInit');
  static const MetaplexHydraProgramInstruction processInitForMint =
      MetaplexHydraProgramInstruction(
          [140, 150, 232, 195, 93, 219, 35, 170], 'ProcessInitForMint');
  static const MetaplexHydraProgramInstruction processRemoveMember =
      MetaplexHydraProgramInstruction(
          [9, 45, 36, 163, 245, 40, 150, 85], 'ProcessRemoveMember');
  static const MetaplexHydraProgramInstruction processSetForTokenMemberStake =
      MetaplexHydraProgramInstruction(
          [210, 40, 6, 254, 2, 80, 154, 109], 'ProcessSetForTokenMemberStake');
  static const MetaplexHydraProgramInstruction processSetTokenMemberStake =
      MetaplexHydraProgramInstruction(
          [167, 29, 12, 30, 44, 193, 249, 142], 'ProcessSetTokenMemberStake');
  static const MetaplexHydraProgramInstruction processSignMetadata =
      MetaplexHydraProgramInstruction(
          [188, 67, 163, 49, 0, 150, 63, 89], 'ProcessSignMetadata');
  static const MetaplexHydraProgramInstruction processTransferShares =
      MetaplexHydraProgramInstruction(
          [195, 175, 36, 50, 101, 22, 28, 87], 'ProcessTransferShares');
  static const MetaplexHydraProgramInstruction processUnstake =
      MetaplexHydraProgramInstruction(
          [217, 160, 136, 174, 149, 62, 79, 133], 'ProcessUnstake');

  static const List<MetaplexHydraProgramInstruction> values = [
    processAddMemberNft,
    processAddMemberWallet,
    processDistributeNft,
    processDistributeToken,
    processDistributeWallet,
    processInit,
    processInitForMint,
    processRemoveMember,
    processSetForTokenMemberStake,
    processSetTokenMemberStake,
    processSignMetadata,
    processTransferShares,
    processUnstake
  ];
  static MetaplexHydraProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere(
          (element) => BytesUtils.bytesEqual(element.insturction, value));
    } catch (_) {
      return null;
    }
  }

  @override
  String get programName => 'MetaplexHydra';

  @override
  SolAddress get programAddress => MetaplexHydraProgramConst.programId;
}

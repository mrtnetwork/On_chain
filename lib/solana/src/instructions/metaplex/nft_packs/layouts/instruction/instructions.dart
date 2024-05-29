import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexNFTPacksProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const MetaplexNFTPacksProgramInstruction(this.insturction, this.name);
  static const MetaplexNFTPacksProgramInstruction activate =
      MetaplexNFTPacksProgramInstruction(3, "Activate");
  static const MetaplexNFTPacksProgramInstruction addCardToPack =
      MetaplexNFTPacksProgramInstruction(1, "AddCardToPack");
  static const MetaplexNFTPacksProgramInstruction addVoucherToPack =
      MetaplexNFTPacksProgramInstruction(2, "AddVoucherToPack");
  static const MetaplexNFTPacksProgramInstruction claimPack =
      MetaplexNFTPacksProgramInstruction(6, "ClaimPack");
  static const MetaplexNFTPacksProgramInstruction cleanUp =
      MetaplexNFTPacksProgramInstruction(13, "CleanUp");
  static const MetaplexNFTPacksProgramInstruction closePack =
      MetaplexNFTPacksProgramInstruction(5, "ClosePack");
  static const MetaplexNFTPacksProgramInstruction deactivate =
      MetaplexNFTPacksProgramInstruction(4, "Deactivate");
  static const MetaplexNFTPacksProgramInstruction deletePack =
      MetaplexNFTPacksProgramInstruction(8, "DeletePack");
  static const MetaplexNFTPacksProgramInstruction deletePackCard =
      MetaplexNFTPacksProgramInstruction(9, "DeletePackCard");
  static const MetaplexNFTPacksProgramInstruction deletePackConfig =
      MetaplexNFTPacksProgramInstruction(14, "DeletePackConfig");
  static const MetaplexNFTPacksProgramInstruction deletePackVoucher =
      MetaplexNFTPacksProgramInstruction(10, "DeletePackVoucher");
  static const MetaplexNFTPacksProgramInstruction editPack =
      MetaplexNFTPacksProgramInstruction(11, "EditPack");
  static const MetaplexNFTPacksProgramInstruction initPack =
      MetaplexNFTPacksProgramInstruction(0, "InitPack");
  static const MetaplexNFTPacksProgramInstruction requestCardForRedeem =
      MetaplexNFTPacksProgramInstruction(12, "RequestCardForRedeem");
  static const MetaplexNFTPacksProgramInstruction transferPackAuthority =
      MetaplexNFTPacksProgramInstruction(7, "TransferPackAuthority");

  static const List<MetaplexNFTPacksProgramInstruction> values = [
    activate,
    addCardToPack,
    addVoucherToPack,
    claimPack,
    cleanUp,
    closePack,
    deactivate,
    deletePack,
    deletePackCard,
    deletePackConfig,
    deletePackVoucher,
    editPack,
    initPack,
    requestCardForRedeem,
    transferPackAuthority
  ];
  static MetaplexNFTPacksProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } on StateError {
      return null;
    }
  }
}

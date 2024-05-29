import 'package:blockchain_utils/compare/compare.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexBubblegumProgramInstruction implements ProgramLayoutInstruction {
  @override
  final List<int> insturction;
  @override
  final String name;
  const MetaplexBubblegumProgramInstruction(this.insturction, this.name);
  static const MetaplexBubblegumProgramInstruction burn =
      MetaplexBubblegumProgramInstruction(
          [116, 110, 29, 56, 107, 219, 42, 93], "Burn");

  static const MetaplexBubblegumProgramInstruction cancelRedeem =
      MetaplexBubblegumProgramInstruction(
          [111, 76, 232, 50, 39, 175, 48, 242], "CancelRedeem");
  static const MetaplexBubblegumProgramInstruction compress =
      MetaplexBubblegumProgramInstruction(
          [82, 193, 176, 117, 176, 21, 115, 253], "Compress");
  static const MetaplexBubblegumProgramInstruction createTreeConfig =
      MetaplexBubblegumProgramInstruction(
          [165, 83, 136, 142, 89, 202, 47, 220], "CreateTreeConfig");
  static const MetaplexBubblegumProgramInstruction decompressV1 =
      MetaplexBubblegumProgramInstruction(
          [54, 85, 76, 70, 228, 250, 164, 81], "DecompressV1");
  static const MetaplexBubblegumProgramInstruction delegate =
      MetaplexBubblegumProgramInstruction(
          [90, 147, 75, 178, 85, 88, 4, 137], "Delegate");
  static const MetaplexBubblegumProgramInstruction mintToCollectionV1 =
      MetaplexBubblegumProgramInstruction(
          [153, 18, 178, 47, 197, 158, 86, 15], "MintToCollectionV1");
  static const MetaplexBubblegumProgramInstruction mintV1 =
      MetaplexBubblegumProgramInstruction(
          [145, 98, 192, 118, 184, 147, 118, 104], "MintV1");
  static const MetaplexBubblegumProgramInstruction redeem =
      MetaplexBubblegumProgramInstruction(
          [184, 12, 86, 149, 70, 196, 97, 225], "Redeem");
  static const MetaplexBubblegumProgramInstruction setAndVerifyCollection =
      MetaplexBubblegumProgramInstruction(
          [235, 242, 121, 216, 158, 234, 180, 234], "SetAndVerifyCollection");
  static const MetaplexBubblegumProgramInstruction setDecompressibleState =
      MetaplexBubblegumProgramInstruction(
          [82, 104, 152, 6, 149, 111, 100, 13], "SetDecompressibleState");
  static const MetaplexBubblegumProgramInstruction setTreeDelegate =
      MetaplexBubblegumProgramInstruction(
          [253, 118, 66, 37, 190, 49, 154, 102], "SetTreeDelegate");
  static const MetaplexBubblegumProgramInstruction transfer =
      MetaplexBubblegumProgramInstruction(
          [163, 52, 200, 231, 140, 3, 69, 186], "Transfer");
  static const MetaplexBubblegumProgramInstruction unverifyCollection =
      MetaplexBubblegumProgramInstruction(
          [250, 251, 42, 106, 41, 137, 186, 168], "UnverifyCollection");
  static const MetaplexBubblegumProgramInstruction unverifyCreator =
      MetaplexBubblegumProgramInstruction(
          [107, 178, 57, 39, 105, 115, 112, 152], "UnverifyCreator");
  static const MetaplexBubblegumProgramInstruction updateMetadata =
      MetaplexBubblegumProgramInstruction(
          [170, 182, 43, 239, 97, 78, 225, 186], "UpdateMetadata");
  static const MetaplexBubblegumProgramInstruction verifyCollection =
      MetaplexBubblegumProgramInstruction(
          [56, 113, 101, 253, 79, 55, 122, 169], "VerifyCollection");
  static const MetaplexBubblegumProgramInstruction verifyCreator =
      MetaplexBubblegumProgramInstruction(
          [52, 17, 96, 132, 71, 4, 85, 194], "VerifyCreator");
  static const MetaplexBubblegumProgramInstruction verifyLeaf =
      MetaplexBubblegumProgramInstruction(
          [124, 220, 22, 223, 104, 10, 250, 224], "VerifyLeaf");

  static const List<MetaplexBubblegumProgramInstruction> values = [
    burn,
    cancelRedeem,
    createTreeConfig,
    decompressV1,
    delegate,
    mintToCollectionV1,
    mintV1,
    redeem,
    setAndVerifyCollection,
    setDecompressibleState,
    setTreeDelegate,
    transfer,
    unverifyCollection,
    unverifyCreator,
    updateMetadata,
    verifyCollection,
    verifyCreator,
  ];
  static MetaplexBubblegumProgramInstruction? getInstruction(dynamic value) {
    try {
      return values
          .firstWhere((element) => bytesEqual(element.insturction, value));
    } on StateError {
      return null;
    }
  }
}

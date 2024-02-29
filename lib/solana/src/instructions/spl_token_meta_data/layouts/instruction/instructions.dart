import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class SPLTokenMetaDataProgramSplDiscriminate
    implements ProgramLayoutInstruction {
  @override
  final List<int> insturction;
  @override
  final String name;
  const SPLTokenMetaDataProgramSplDiscriminate(this.insturction, this.name);
  static const SPLTokenMetaDataProgramSplDiscriminate initialize =
      SPLTokenMetaDataProgramSplDiscriminate(
          [210, 225, 30, 162, 88, 184, 77, 141], "Initialize");
  static const SPLTokenMetaDataProgramSplDiscriminate update =
      SPLTokenMetaDataProgramSplDiscriminate(
          [221, 233, 49, 45, 181, 202, 220, 200], "Update");
  static const SPLTokenMetaDataProgramSplDiscriminate emit =
      SPLTokenMetaDataProgramSplDiscriminate(
          [250, 166, 180, 250, 13, 12, 184, 70], "Emit");
  static const SPLTokenMetaDataProgramSplDiscriminate remove =
      SPLTokenMetaDataProgramSplDiscriminate(
          [234, 18, 32, 56, 89, 141, 37, 181], "Remove");
  static const SPLTokenMetaDataProgramSplDiscriminate updateAuthority =
      SPLTokenMetaDataProgramSplDiscriminate(
          [215, 228, 166, 228, 84, 100, 86, 123], "UpdateAuthority");
  static const List<SPLTokenMetaDataProgramSplDiscriminate> values = [
    initialize,
    update,
    remove,
    updateAuthority,
    emit
  ];
  static SPLTokenMetaDataProgramSplDiscriminate? getInstruction(dynamic value) {
    try {
      return values
          .firstWhere((element) => bytesEqual(value, element.insturction));
    } on StateError {
      return null;
    }
  }
}

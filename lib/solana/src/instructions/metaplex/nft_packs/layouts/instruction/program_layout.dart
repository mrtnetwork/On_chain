import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

abstract class MetaplexNFTPacksProgramLayout extends ProgramLayout {
  const MetaplexNFTPacksProgramLayout();
  @override
  abstract final int instruction;
  static ProgramLayout fromBytes(List<int> data) {
    return UnknownProgramLayout(data);
  }
}

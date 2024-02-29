import 'package:on_chain/solana/src/layout/layout.dart';

abstract class MetaplexTokenMetaDataProgramLayout extends ProgramLayout {
  const MetaplexTokenMetaDataProgramLayout();
  @override
  abstract final int instruction;

  static ProgramLayout fromBytes(List<int> data) {
    return UnknownProgramLayout(data);
  }
}

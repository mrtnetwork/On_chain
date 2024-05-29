import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

abstract class MetaplexAuctionHouseProgramLayout extends ProgramLayout {
  const MetaplexAuctionHouseProgramLayout();
  @override
  abstract final List<int> instruction;

  static ProgramLayout fromBytes(List<int> data) {
    return UnknownProgramLayout(data);
  }

  static Map<String, dynamic> decodeAndValidateStruct({
    required StructLayout layout,
    required List<int> bytes,
    required List<int> instruction,
  }) {
    return LayoutSerializable.decode(
        bytes: bytes, layout: layout, validator: {"instruction": instruction});
  }
}

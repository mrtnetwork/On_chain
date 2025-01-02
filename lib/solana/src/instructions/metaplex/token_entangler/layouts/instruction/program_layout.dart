import 'package:blockchain_utils/utils/utils.dart';

import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_entangler/layouts/layouts/create_entangled_pair.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_entangler/layouts/layouts/swap.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_entangler/layouts/layouts/update_entangled_pair.dart';

import 'instructions.dart';

abstract class MetaplexTokenEntanglerProgramLayout extends ProgramLayout {
  const MetaplexTokenEntanglerProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);
  @override
  abstract final MetaplexTokenEntanglerProgramInstruction instruction;
  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final MetaplexTokenEntanglerProgramInstruction? instruction =
        MetaplexTokenEntanglerProgramInstruction.getInstruction(
            decode['instruction']);
    switch (instruction) {
      case MetaplexTokenEntanglerProgramInstruction.createEntangledPair:
        return MetaplexTokenEntanglerCreateEntangledPairLayout.fromBuffer(data);
      case MetaplexTokenEntanglerProgramInstruction.swap:
        return MetaplexTokenEntanglerSwapLayout.fromBuffer(data);
      case MetaplexTokenEntanglerProgramInstruction.updateEntangledPair:
        return MetaplexTokenEntanglerUpdateEntangledPairLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }

  static Map<String, dynamic> decodeAndValidateStruct({
    required StructLayout layout,
    required List<int> bytes,
    required List<int> instruction,
  }) {
    final decode = layout.deserialize(bytes).value;
    final instcutionData = decode['instruction'];
    if (!BytesUtils.bytesEqual(instcutionData, instruction)) {
      throw SolanaPluginException('invalid instruction bytes', details: {
        'expected': BytesUtils.toHexString(instruction),
        'instruction': BytesUtils.toBinary(instcutionData)
      });
    }

    return decode;
  }
}

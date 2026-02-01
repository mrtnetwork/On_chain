import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/add_config_lines.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/create_candy_guard.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/delete_candy_guard.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/delete_candy_machine.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/initialize_candy_machine.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/initialize_candy_machine_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/mint.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/mint_from_candy_machine.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/mint_from_candy_machine_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/route.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/set_candy_guard_authority.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/set_candy_machine_authority.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/set_collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/set_collection_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/set_mint_authority.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/set_token_standard.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/unwrap.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/update_candy_guard.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/update_candy_machine.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/wrap.dart';

import 'instructions.dart';

abstract class MetaplexCandyMachineProgramLayout extends ProgramLayout {
  const MetaplexCandyMachineProgramLayout();
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);
  @override
  abstract final MetaplexCandyMachineProgramInstruction instruction;
  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final MetaplexCandyMachineProgramInstruction? instruction =
        MetaplexCandyMachineProgramInstruction.getInstruction(
            decode['instruction']);

    switch (instruction) {
      case MetaplexCandyMachineProgramInstruction.addConfigLines:
        return MetaplexCandyMachineAddConfigLinesLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.createCandyGuard:
        return MetaplexCandyMachineCreateCandyGuardLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.deleteCandyGuard:
        return MetaplexCandyMachineDeleteCandyGuardLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.deleteCandyMachine:
        return MetaplexCandyMachineDeleteCandyMachineLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.initializeCandyMachine:
        return MetaplexCandyMachineInitializeCandyMachineLayout.fromBuffer(
            data);
      case MetaplexCandyMachineProgramInstruction.initializeCandyMachineV2:
        return MetaplexCandyMachineInitializeCandyMachineV2Layout.fromBuffer(
            data);
      case MetaplexCandyMachineProgramInstruction.mint:
        return MetaplexCandyMachineMintLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.mintFromCandyMachine:
        return MetaplexCandyMachineMintFromCandyMachineLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.mintFromCandyMachineV2:
        return MetaplexCandyMachineMintFromCandyMachineV2Layout.fromBuffer(
            data);
      case MetaplexCandyMachineProgramInstruction.route:
        return MetaplexCandyMachineRouteLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.setCandyGuardAuthority:
        return MetaplexCandyMachineSetCandyGuardAuthorityLayout.fromBuffer(
            data);
      case MetaplexCandyMachineProgramInstruction.setCandyMachineAuthority:
        return MetaplexCandyMachineSetCandyMachineAuthorityLayout.fromBuffer(
            data);
      case MetaplexCandyMachineProgramInstruction.setCollection:
        return MetaplexCandyMachineSetCollectionLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.setCollectionV2:
        return MetaplexCandyMachineSetCollectionV2Layout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.setMintAuthority:
        return MetaplexCandyMachineSetMintAuthorityLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.setTokenStandard:
        return MetaplexCandyMachineSetTokenStandardLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.unwrap:
        return MetaplexCandyMachineUnwrapLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.updateCandyGuard:
        return MetaplexCandyMachineUpdateCandyGuardLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.updateCandyMachine:
        return MetaplexCandyMachineUpdateCandyMachineLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.wrap:
        return MetaplexCandyMachineWrapLayout.fromBuffer(data);
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

import 'package:blockchain_utils/blockchain_utils.dart';

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
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/mint_v2.dart';
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
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/withdraw_candy_guard.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/withdraw_candy_machine.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts/wrap.dart';

import 'instructions.dart';

abstract class MetaplexCandyMachineProgramLayout extends ProgramLayout {
  const MetaplexCandyMachineProgramLayout();
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);
  @override
  abstract final MetaplexCandyMachineProgramInstruction instruction;
  static ProgramLayout fromBytes(List<int> data) {
    final aliased = _decodeAliased(data);
    if (aliased != null) return aliased;
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
    );
    final MetaplexCandyMachineProgramInstruction? instruction =
        MetaplexCandyMachineProgramInstruction.getInstruction(
          decode['instruction'],
        );

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
          data,
        );
      case MetaplexCandyMachineProgramInstruction.initializeCandyMachineV2:
        return MetaplexCandyMachineInitializeCandyMachineV2Layout.fromBuffer(
          data,
        );
      case MetaplexCandyMachineProgramInstruction.mint:
        return MetaplexCandyMachineMintLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.mintFromCandyMachine:
        return MetaplexCandyMachineMintFromCandyMachineLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.mintFromCandyMachineV2:
        return MetaplexCandyMachineMintFromCandyMachineV2Layout.fromBuffer(
          data,
        );
      case MetaplexCandyMachineProgramInstruction.mintV2:
        return MetaplexCandyMachineMintV2Layout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.route:
        return MetaplexCandyMachineRouteLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.setCandyGuardAuthority:
        return MetaplexCandyMachineSetCandyGuardAuthorityLayout.fromBuffer(
          data,
        );
      case MetaplexCandyMachineProgramInstruction.setCandyMachineAuthority:
        return MetaplexCandyMachineSetCandyMachineAuthorityLayout.fromBuffer(
          data,
        );
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
      case MetaplexCandyMachineProgramInstruction.withdrawCandyMachine:
        return MetaplexCandyMachineWithdrawCandyMachineLayout.fromBuffer(data);
      case MetaplexCandyMachineProgramInstruction.withdrawCandyGuard:
        return MetaplexCandyMachineWithdrawCandyGuardLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }

  static ProgramLayout? _decodeAliased(List<int> data) {
    bool matches(List<int> disc) {
      if (data.length < disc.length) return false;
      for (var i = 0; i < disc.length; i++) {
        if (data[i] != disc[i]) return false;
      }
      return true;
    }

    // mint (machine, has args) vs mintFromCandyMachine (guard, empty).
    if (matches(MetaplexCandyMachineProgramInstruction.mint.instruction)) {
      if (data.length == 8) {
        return MetaplexCandyMachineMintFromCandyMachineLayout.fromBuffer(data);
      }
      return MetaplexCandyMachineMintLayout.fromBuffer(data);
    }
    // mintV2 (machine, has args) vs mintFromCandyMachineV2 (guard, empty).
    if (matches(MetaplexCandyMachineProgramInstruction.mintV2.instruction)) {
      if (data.length == 8) {
        return MetaplexCandyMachineMintFromCandyMachineV2Layout.fromBuffer(
          data,
        );
      }
      return MetaplexCandyMachineMintV2Layout.fromBuffer(data);
    }
    // initializeCandyMachine (strict struct) vs createCandyGuard (vecU8).
    if (matches(
      MetaplexCandyMachineProgramInstruction.initializeCandyMachine.instruction,
    )) {
      try {
        return MetaplexCandyMachineInitializeCandyMachineLayout.fromBuffer(
          data,
        );
      } catch (_) {
        return MetaplexCandyMachineCreateCandyGuardLayout.fromBuffer(data);
      }
    }
    // updateCandyMachine (strict struct) vs updateCandyGuard (vecU8).
    if (matches(
      MetaplexCandyMachineProgramInstruction.updateCandyMachine.instruction,
    )) {
      try {
        return MetaplexCandyMachineUpdateCandyMachineLayout.fromBuffer(data);
      } catch (_) {
        return MetaplexCandyMachineUpdateCandyGuardLayout.fromBuffer(data);
      }
    }
    if (matches(
      MetaplexCandyMachineProgramInstruction.withdrawCandyMachine.instruction,
    )) {
      return MetaplexCandyMachineWithdrawCandyMachineLayout.fromBuffer(data);
    }
    return null;
  }

  static Map<String, dynamic> decodeAndValidateStruct({
    required StructLayout layout,
    required List<int> bytes,
    required List<int> instruction,
  }) {
    final decode = layout.deserialize(bytes).value;
    final instcutionData = decode['instruction'];
    if (!BytesUtils.bytesEqual(instcutionData, instruction)) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'invalid instruction bytes',
        details: {
          'expected': BytesUtils.toHexString(instruction),
          'instruction': BytesUtils.toBinary(instcutionData),
        },
      );
    }

    return decode;
  }
}

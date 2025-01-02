import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class MetaplexCandyMachineSetCandyGuardAuthorityLayout
    extends MetaplexCandyMachineProgramLayout {
  final SolAddress newAuthority;

  const MetaplexCandyMachineSetCandyGuardAuthorityLayout(
      {required this.newAuthority});

  factory MetaplexCandyMachineSetCandyGuardAuthorityLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .setCandyGuardAuthority.insturction);
    return MetaplexCandyMachineSetCandyGuardAuthorityLayout(
        newAuthority: decode['newAuthority']);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    SolanaLayoutUtils.publicKey('newAuthority')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexCandyMachineProgramInstruction get instruction =>
      MetaplexCandyMachineProgramInstruction.setCandyGuardAuthority;

  @override
  Map<String, dynamic> serialize() {
    return {'newAuthority': newAuthority};
  }
}

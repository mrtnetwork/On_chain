import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexCandyMachineSetCandyMachineAuthorityLayout
    extends MetaplexCandyMachineProgramLayout {
  final SolAddress newAuthority;

  const MetaplexCandyMachineSetCandyMachineAuthorityLayout(
      {required this.newAuthority});

  factory MetaplexCandyMachineSetCandyMachineAuthorityLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .setCandyMachineAuthority.insturction);
    return MetaplexCandyMachineSetCandyMachineAuthorityLayout(
        newAuthority: decode["newAuthority"]);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.publicKey("newAuthority")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction => MetaplexCandyMachineProgramInstruction
      .setCandyMachineAuthority.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"newAuthority": newAuthority};
  }
}

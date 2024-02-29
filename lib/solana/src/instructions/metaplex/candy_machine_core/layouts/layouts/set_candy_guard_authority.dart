import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
        newAuthority: decode["newAuthority"]);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.publicKey("newAuthority")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.setCandyGuardAuthority.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"newAuthority": newAuthority};
  }
}

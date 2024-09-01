import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Update the group pointer extension for the given mint account layout.
class SPLToken2022UpdateGroupPointerLayout extends SPLTokenProgramLayout {
  ///  Account address that holds the group
  final SolAddress? groupAddress;
  SPLToken2022UpdateGroupPointerLayout({this.groupAddress});

  factory SPLToken2022UpdateGroupPointerLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.groupPointerExtension.insturction,
    );
    return SPLToken2022UpdateGroupPointerLayout(
        groupAddress: decode["groupAddress"] == SolAddress.defaultPubKey
            ? null
            : decode["groupAddress"]);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.wrap(GroupPointerInstruction.staticLayout,
        property: "groupPointer"),
    SolanaLayoutUtils.publicKey("groupAddress"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.groupPointerExtension;

  @override
  Map<String, dynamic> serialize() {
    return {
      "groupPointer": GroupPointerInstruction.update.serialize(),
      "groupAddress": groupAddress ?? SolAddress.defaultPubKey
    };
  }
}

import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(GroupPointerInstruction.staticLayout,
        property: "groupPointer"),
    LayoutUtils.publicKey("groupAddress"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.groupPointerExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "groupPointer": GroupPointerInstruction.update.serialize(),
      "groupAddress": groupAddress ?? SolAddress.defaultPubKey
    };
  }
}

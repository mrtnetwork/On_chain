import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Update the group member pointer extension for the given mint account layout.
class SPLToken2022UpdateGroupMemberPointerLayout extends SPLTokenProgramLayout {
  /// Account address that holds the member
  final SolAddress? memberAddress;
  SPLToken2022UpdateGroupMemberPointerLayout({this.memberAddress});

  factory SPLToken2022UpdateGroupMemberPointerLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.groupMemberPointerExtension.insturction,
    );
    return SPLToken2022UpdateGroupMemberPointerLayout(
        memberAddress: decode["memberAddress"] == SolAddress.defaultPubKey
            ? null
            : decode["memberAddress"]);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(GroupMemberPointerInstruction.staticLayout,
        property: "groupMemberPointer"),
    LayoutUtils.publicKey("memberAddress"),
  ]);

  /// Returns the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.groupMemberPointerExtension.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {
      "groupMemberPointer": GroupMemberPointerInstruction.update.serialize(),
      "memberAddress": memberAddress ?? SolAddress.defaultPubKey
    };
  }
}

import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Initialize the group member pointer extension for the given mint account layout.
class SPLToken2022InitializeGroupMemberPointerLayout
    extends SPLTokenProgramLayout {
  /// Authority that can set the member address
  final SolAddress? authority;

  /// Account address that holds the member
  final SolAddress? memberAddress;

  SPLToken2022InitializeGroupMemberPointerLayout(
      {this.authority, this.memberAddress});

  factory SPLToken2022InitializeGroupMemberPointerLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.groupMemberPointerExtension.insturction,
    );
    return SPLToken2022InitializeGroupMemberPointerLayout(
        authority: decode["authority"] == SolAddress.defaultPubKey
            ? null
            : decode["authority"],
        memberAddress: decode["memberAddress"] == SolAddress.defaultPubKey
            ? null
            : decode["memberAddress"]);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.wrap(GroupMemberPointerInstruction.staticLayout,
        property: "groupMemberPointer"),
    SolanaLayoutUtils.publicKey("authority"),
    SolanaLayoutUtils.publicKey("memberAddress"),
  ]);

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.groupMemberPointerExtension;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {
      "groupMemberPointer":
          GroupMemberPointerInstruction.initialize.serialize(),
      "memberAddress": memberAddress ?? SolAddress.defaultPubKey,
      "authority": authority ?? SolAddress.defaultPubKey
    };
  }
}

// Manages the layout structure for setting authority in SPL tokens.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Sets a new authority of a mint or account layout.
class SPLTokenSetAuthorityLayout extends SPLTokenProgramLayout {
  /// The new authority
  final SolAddress? newAuthority;

  /// The type of authority to update.
  final AuthorityType authorityType;

  /// Constructs an SPLTokenSetAuthorityLayout instance.
  SPLTokenSetAuthorityLayout({required this.authorityType, this.newAuthority});

  /// StructLayout structure for setting authority in SPL tokens.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "authorityType"),
    SolanaLayoutUtils.optionPubkey(property: "newAuthority", keepSize: true)
  ]);

  /// Constructs an SPLTokenSetAuthorityLayout instance from buffer.
  factory SPLTokenSetAuthorityLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.setAuthority.insturction);
    return SPLTokenSetAuthorityLayout(
        authorityType: AuthorityType.fromValue(decode["authorityType"]),
        newAuthority: decode["newAuthority"]);
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.setAuthority;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"authorityType": authorityType.value, "newAuthority": newAuthority};
  }
}

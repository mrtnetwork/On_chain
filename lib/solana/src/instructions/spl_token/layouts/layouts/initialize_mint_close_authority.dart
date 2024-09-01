// Manages the layout structure for initializing an SPL token mint with close authority.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Initialize the close account authority on a new mint layout.
class SPLTokenInitializeMintCloseAuthorityLayout extends SPLTokenProgramLayout {
  /// Authority that must sign the [SPLTokenProgram.closeAccount] instruction on a mint
  final SolAddress? closeAuthority;

  /// Constructs an SPLTokenInitializeMintCloseAuthorityLayout instance.
  SPLTokenInitializeMintCloseAuthorityLayout({this.closeAuthority});

  /// StructLayout structure for SPLTokenInitializeMintCloseAuthorityLayout.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    SolanaLayoutUtils.optionPubkey(property: "closeAuthority", keepSize: true)
  ]);

  /// Constructs an SPLTokenInitializeMintCloseAuthorityLayout instance from buffer.
  factory SPLTokenInitializeMintCloseAuthorityLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction
            .initializeMintCloseAuthority.insturction);
    return SPLTokenInitializeMintCloseAuthorityLayout(
        closeAuthority: decode["closeAuthority"]);
  }

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.initializeMintCloseAuthority;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"closeAuthority": closeAuthority};
  }
}

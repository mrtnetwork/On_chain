// Manages the layout structure for initializing an SPL token account with owner.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Initializes a new account to hold tokens layout.
class SPLTokenInitializeAccount2Layout extends SPLTokenProgramLayout {
  /// The new account's owner/multisignature.
  final SolAddress owner;

  /// Constructs an SPLTokenInitializeAccount2Layout instance.
  SPLTokenInitializeAccount2Layout({required this.owner});

  /// StructLayout structure for SPLTokenInitializeAccount2Layout.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    SolanaLayoutUtils.publicKey("owner")
  ]);

  /// Constructs an SPLTokenInitializeAccount2Layout instance from buffer.
  factory SPLTokenInitializeAccount2Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.initializeAccount2.insturction);
    return SPLTokenInitializeAccount2Layout(owner: decode["owner"]);
  }

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.initializeAccount2;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"owner": owner};
  }
}

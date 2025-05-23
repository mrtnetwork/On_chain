// Manages the layout structure for initializing an SPL token account with owner.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Initializes a new account to hold tokens layout.
class SPLTokenInitializeAccount3Layout extends SPLTokenProgramLayout {
  /// The new account's owner/multisignature.
  final SolAddress owner;

  /// Constructs an SPLTokenInitializeAccount3Layout instance.
  SPLTokenInitializeAccount3Layout({required this.owner});

  /// StructLayout structure for SPLTokenInitializeAccount3Layout.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    SolanaLayoutUtils.publicKey('owner')
  ]);

  /// Constructs an SPLTokenInitializeAccount3Layout instance from buffer.
  factory SPLTokenInitializeAccount3Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.initializeAccount3.insturction);
    return SPLTokenInitializeAccount3Layout(owner: decode['owner']);
  }

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.initializeAccount3;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {'owner': owner};
  }
}

// Manages the layout structure for initializing an SPL token account with owner.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initializes a new account to hold tokens layout.
class SPLTokenInitializeAccount2Layout extends SPLTokenProgramLayout {
  /// The new account's owner/multisignature.
  final SolAddress owner;

  /// Constructs an SPLTokenInitializeAccount2Layout instance.
  SPLTokenInitializeAccount2Layout({required this.owner});

  /// Structure structure for SPLTokenInitializeAccount2Layout.
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.publicKey("owner")]);

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
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.initializeAccount2.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"owner": owner};
  }
}

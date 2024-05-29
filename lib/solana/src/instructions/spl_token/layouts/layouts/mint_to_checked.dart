// Manages the layout structure for checked minting tokens to  account for an SPL token.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Mints new tokens to an account layout.
class SPLTokenMintToCheckedLayout extends SPLTokenProgramLayout {
  /// The amount of new tokens to mint.
  final BigInt amount;

  /// Expected number of base 10 digits to the right of the decimal place.
  final int decimals;

  /// Constructs an SPLTokenMintToCheckedLayout instance.
  SPLTokenMintToCheckedLayout({required this.amount, required this.decimals});

  /// StructLayout structure for minting tokens to a checked account.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u64(property: "amount"),
    LayoutConst.u8(property: "decimals")
  ]);

  /// Constructs an SPLTokenMintToCheckedLayout instance from buffer.
  factory SPLTokenMintToCheckedLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.mintToChecked.insturction,
    );
    return SPLTokenMintToCheckedLayout(
      amount: decode["amount"],
      decimals: decode["decimals"],
    );
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.mintToChecked.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount, "decimals": decimals};
  }
}

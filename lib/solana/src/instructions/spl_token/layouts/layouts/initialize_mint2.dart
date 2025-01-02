// Manages the layout structure for initializing an SPL token mint with a specific instruction.
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_mint.dart';

/// Initializes a new mint layout
class SPLTokenInitializeMint2Layout extends SPLTokenInitializeMintLayout {
  /// Constructs an SPLTokenInitializeMint2Layout instance.
  SPLTokenInitializeMint2Layout({
    required super.mintAuthority,
    required super.decimals,
    super.freezeAuthority,
  });

  /// Constructs an SPLTokenInitializeMint2Layout instance from buffer.
  factory SPLTokenInitializeMint2Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: SPLTokenInitializeMintLayout.staticLayout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.initializeMint2.insturction,
    );
    return SPLTokenInitializeMint2Layout(
      freezeAuthority: decode['freezeAuthority'],
      decimals: decode['decimals'],
      mintAuthority: decode['mintAuthority'],
    );
  }

  /// Instruction associated with the layout.
  @override
  SPLTokenProgramInstruction get instruction =>
      SPLTokenProgramInstruction.initializeMint2;
}

// Manages the layout structure for initializing an SPL token mint.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

///  Initializes a new mint layout.
class SPLTokenInitializeMintLayout extends SPLTokenProgramLayout {
  /// The authority/multisignature to mint tokens.
  final SolAddress mintAuthority;

  /// Number of base 10 digits to the right of the decimal place.
  final int decimals;

  /// The freeze authority/multisignature of the mint.
  final SolAddress? freezeAuthority;

  /// Constructs an SPLTokenInitializeMintLayout instance.
  SPLTokenInitializeMintLayout({
    required this.mintAuthority,
    required this.decimals,
    this.freezeAuthority,
  });

  /// StructLayout structure for SPLTokenInitializeMintLayout.
  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "decimals"),
    SolanaLayoutUtils.publicKey("mintAuthority"),
    SolanaLayoutUtils.optionPubkey(property: "freezeAuthority", keepSize: true)
  ]);

  /// Constructs an SPLTokenInitializeMintLayout instance from buffer.
  factory SPLTokenInitializeMintLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: staticLayout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.initializeMint.insturction);
    return SPLTokenInitializeMintLayout(
      freezeAuthority: decode["freezeAuthority"],
      decimals: decode["decimals"],
      mintAuthority: decode["mintAuthority"],
    );
  }

  /// Gets the layout structure.
  @override
  StructLayout get layout => staticLayout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.initializeMint;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {
      "mintAuthority": mintAuthority,
      "decimals": decimals,
      "freezeAuthority": freezeAuthority,
    };
  }
}

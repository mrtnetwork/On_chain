// Manages the layout structure for initializing a permanent delegate for an SPL token.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Initialize the permanent delegate on a new mint. layout.
class SPLTokenInitializePermanentDelegateLayout extends SPLTokenProgramLayout {
  /// Authority that may sign for `Transfer`s and `Burn`s on any account
  final SolAddress? delegate;

  /// Constructs an SPLTokenInitializePermanentDelegateLayout instance.
  SPLTokenInitializePermanentDelegateLayout({this.delegate});

  /// StructLayout structure for initializing a permanent delegate.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    SolanaLayoutUtils.publicKey("delegate")
  ]);

  /// Constructs an SPLTokenInitializePermanentDelegateLayout instance from buffer.
  factory SPLTokenInitializePermanentDelegateLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.initializePermanentDelegate.insturction,
    );
    final SolAddress delegate = decode["delegate"];
    return SPLTokenInitializePermanentDelegateLayout(
      delegate: delegate == SolAddress.defaultPubKey ? null : delegate,
    );
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.initializePermanentDelegate;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"delegate": delegate ?? SolAddress.defaultPubKey};
  }
}

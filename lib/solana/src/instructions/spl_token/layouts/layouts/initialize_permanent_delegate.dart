// Manages the layout structure for initializing a permanent delegate for an SPL token.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initialize the permanent delegate on a new mint. layout.
class SPLTokenInitializePermanentDelegateLayout extends SPLTokenProgramLayout {
  /// Authority that may sign for `Transfer`s and `Burn`s on any account
  final SolAddress? delegate;

  /// Constructs an SPLTokenInitializePermanentDelegateLayout instance.
  SPLTokenInitializePermanentDelegateLayout({this.delegate});

  /// Structure structure for initializing a permanent delegate.
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.publicKey("delegate")]);

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
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.initializePermanentDelegate.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"delegate": delegate ?? SolAddress.defaultPubKey};
  }
}

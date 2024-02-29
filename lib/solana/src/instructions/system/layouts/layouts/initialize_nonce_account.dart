import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initialize nonce account system layout
class SystemInitializeNonceAccountLayout extends SystemProgramLayout {
  /// address to set as authority of the created nonce account
  final SolAddress authorized;
  const SystemInitializeNonceAccountLayout({required this.authorized});
  factory SystemInitializeNonceAccountLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            SystemProgramInstruction.initializeNonceAccount.insturction);
    return SystemInitializeNonceAccountLayout(authorized: decode["authorized"]);
  }
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u32("instruction"), LayoutUtils.publicKey("authorized")]);

  @override
  Structure get layout => _layout;
  @override
  int get instruction =>
      SystemProgramInstruction.initializeNonceAccount.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"authorized": authorized};
  }
}

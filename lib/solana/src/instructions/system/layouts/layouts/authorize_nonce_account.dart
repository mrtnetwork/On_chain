import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Authorize nonce account system layout
class SystemAuthorizeNonceAccountLayout extends SystemProgramLayout {
  /// address of the current nonce authority
  final SolAddress authorized;
  const SystemAuthorizeNonceAccountLayout({required this.authorized});
  factory SystemAuthorizeNonceAccountLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            SystemProgramInstruction.authorizeNonceAccount.insturction);
    return SystemAuthorizeNonceAccountLayout(authorized: decode["authorized"]);
  }
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u32("instruction"), LayoutUtils.publicKey("authorized")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      SystemProgramInstruction.authorizeNonceAccount.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"authorized": authorized};
  }
}

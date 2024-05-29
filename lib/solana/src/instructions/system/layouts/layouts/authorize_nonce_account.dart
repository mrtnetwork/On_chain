import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    SolanaLayoutUtils.publicKey("authorized")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      SystemProgramInstruction.authorizeNonceAccount.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"authorized": authorized};
  }
}

import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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
    return SystemInitializeNonceAccountLayout(authorized: decode['authorized']);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: 'instruction'),
    SolanaLayoutUtils.publicKey('authorized')
  ]);

  @override
  StructLayout get layout => _layout;
  @override
  SystemProgramInstruction get instruction =>
      SystemProgramInstruction.initializeNonceAccount;
  @override
  Map<String, dynamic> serialize() {
    return {'authorized': authorized};
  }
}

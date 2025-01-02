import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Authorize layout
class VoteProgramAuthorizeLayout extends VoteProgramLayout {
  final SolAddress newAuthorized;
  final int voteAuthorizationType;
  const VoteProgramAuthorizeLayout(
      {required this.newAuthorized, required this.voteAuthorizationType});
  factory VoteProgramAuthorizeLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: VoteProgramInstruction.authorize.insturction);
    return VoteProgramAuthorizeLayout(
        newAuthorized: decode['newAuthorized'],
        voteAuthorizationType: decode['voteAuthorizationType']);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: 'instruction'),
    SolanaLayoutUtils.publicKey('newAuthorized'),
    LayoutConst.u32(property: 'voteAuthorizationType')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  VoteProgramInstruction get instruction => VoteProgramInstruction.authorize;

  @override
  Map<String, dynamic> serialize() {
    return {
      'newAuthorized': newAuthorized,
      'voteAuthorizationType': voteAuthorizationType
    };
  }
}

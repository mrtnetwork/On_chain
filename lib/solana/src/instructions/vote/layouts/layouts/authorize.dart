import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
        newAuthorized: decode["newAuthorized"],
        voteAuthorizationType: decode["voteAuthorizationType"]);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.publicKey("newAuthorized"),
    LayoutUtils.u32("voteAuthorizationType")
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => VoteProgramInstruction.authorize.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "newAuthorized": newAuthorized,
      "voteAuthorizationType": voteAuthorizationType
    };
  }
}

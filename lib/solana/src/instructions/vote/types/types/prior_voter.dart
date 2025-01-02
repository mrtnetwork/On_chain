import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class PriorVoter extends LayoutSerializable {
  final SolAddress authorizedPubkey;
  final BigInt epochOfLastAuthorizedSwitch;
  final BigInt targetEpoch;
  const PriorVoter(
      {required this.authorizedPubkey,
      required this.epochOfLastAuthorizedSwitch,
      required this.targetEpoch});
  factory PriorVoter.fromJson(Map<String, dynamic> json) {
    return PriorVoter(
        authorizedPubkey: json['authorizedPubkey'],
        epochOfLastAuthorizedSwitch: json['epochOfLastAuthorizedSwitch'],
        targetEpoch: json['targetEpoch']);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey('authorizedPubkey'),
    LayoutConst.u64(property: 'epochOfLastAuthorizedSwitch'),
    LayoutConst.u64(property: 'targetEpoch'),
  ], property: 'priorVoter');
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'authorizedPubkey': authorizedPubkey,
      'epochOfLastAuthorizedSwitch': epochOfLastAuthorizedSwitch,
      'targetEpoch': targetEpoch
    };
  }

  @override
  String toString() {
    return 'PriorVoter${serialize()}';
  }
}

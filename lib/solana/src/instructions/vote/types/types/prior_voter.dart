import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
        authorizedPubkey: json["authorizedPubkey"],
        epochOfLastAuthorizedSwitch: json["epochOfLastAuthorizedSwitch"],
        targetEpoch: json["targetEpoch"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.publicKey("authorizedPubkey"),
    LayoutUtils.u64("epochOfLastAuthorizedSwitch"),
    LayoutUtils.u64("targetEpoch"),
  ], "priorVoter");
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "authorizedPubkey": authorizedPubkey,
      "epochOfLastAuthorizedSwitch": epochOfLastAuthorizedSwitch,
      "targetEpoch": targetEpoch
    };
  }

  @override
  String toString() {
    return "PriorVoter${serialize()}";
  }
}

import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/numbers/numbers.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/models/governance/models/anchor.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/action.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class VotingProposal with ADASerialization {
  final GovernanceAction governanceAction;
  final Anchor anchor;
  final ADARewardAddress rewardAddress;
  final BigInt deposit;
  const VotingProposal({
    required this.anchor,
    required this.governanceAction,
    required this.rewardAddress,
    required this.deposit,
  });
  factory VotingProposal.deserialize(CborListValue cbor) {
    return VotingProposal(
      deposit: cbor.elementAsInteger(0),
      rewardAddress: ADAAddress.deserialize(cbor.elementAt<CborBytesValue>(1)),
      governanceAction:
          GovernanceAction.deserialize(cbor.elementAt<CborListValue>(2)),
      anchor: Anchor.deserialize(cbor.elementAt<CborListValue>(3)),
    );
  }
  factory VotingProposal.fromJson(Map<String, dynamic> json) {
    return VotingProposal(
        anchor: Anchor.fromJson(json["anchor"]),
        governanceAction: GovernanceAction.fromJson(json["governance_action"]),
        rewardAddress: ADARewardAddress(json["reward_account"]),
        deposit: BigintUtils.parse(json["deposit"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      CborUnsignedValue.u64(deposit),
      rewardAddress.toCbor(),
      governanceAction.toCbor(),
      anchor.toCbor()
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "anchor": anchor.toJson(),
      "governance_action": governanceAction.toJson(),
      "deposit": deposit.toString(),
      "reward_account": rewardAddress.address
    };
  }
}

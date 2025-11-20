import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/governance_action_type.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/treasury_withdrawals.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class TreasuryWithdrawalsAction extends GovernanceAction {
  final TreasuryWithdrawals withdrawals;
  final ScriptHash? policyHash;
  const TreasuryWithdrawalsAction({required this.withdrawals, this.policyHash})
      : super(type: GovernanceActionType.treasuryWithdrawalsAction);
  factory TreasuryWithdrawalsAction.deserialize(CborListValue cbor) {
    return TreasuryWithdrawalsAction(
        withdrawals:
            TreasuryWithdrawals.deserialize(cbor.elementAt<CborMapValue>(1)),
        policyHash: cbor
            .elementAt<CborObject?>(2)
            ?.convertTo<ScriptHash, CborBytesValue>(
                (e) => ScriptHash.deserialize(e)));
  }
  factory TreasuryWithdrawalsAction.fromJson(Map<String, dynamic> json) {
    final currentJson =
        json[GovernanceActionType.treasuryWithdrawalsAction.name] ?? json;
    return TreasuryWithdrawalsAction(
        withdrawals: TreasuryWithdrawals.fromJson(currentJson["withdrawals"]),
        policyHash: currentJson["policy_hash"] == null
            ? null
            : ScriptHash.fromHex(currentJson["policy_hash"]));
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      withdrawals.toCbor(),
      policyHash?.toCbor() ?? const CborNullValue()
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        "withdrawals": withdrawals.toJson(),
        "policy_hash": policyHash?.toJson()
      }
    };
  }
}

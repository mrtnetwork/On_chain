import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/crypto/cid/cid.dart';

/// On-chain state of a Multisig actor (decoded from `StateReadState`).
///
/// Field names follow the Filecoin actor JSON representation returned by Lotus.
class FilMultisigState {
  /// Initial balance that was locked at creation (for vesting).
  final BigInt initialBalance;

  /// Next transaction ID that will be assigned by Propose.
  final BigInt nextTxnID;

  /// Number of approvals required to execute a pending transaction.
  final BigInt numApprovalsThreshold;

  /// CID of the HAMT holding pending transactions (null when empty).
  final Cid? pendingTxns;

  /// Current list of signer addresses.
  final List<FilAddress> signers;

  /// Epoch at which vesting started (null when no vesting).
  final BigInt? startEpoch;

  /// Vesting duration in epochs (null when no vesting).
  final BigInt? unlockDuration;

  const FilMultisigState({
    required this.initialBalance,
    required this.nextTxnID,
    required this.numApprovalsThreshold,
    this.pendingTxns,
    required this.signers,
    this.startEpoch,
    this.unlockDuration,
  });

  /// Parses the JSON object returned inside `StateReadState.State`.
  factory FilMultisigState.fromJson(Map<String, dynamic> json) {
    return FilMultisigState(
      startEpoch: json.valueAsBigInt("StartEpoch"),
      unlockDuration: json.valueAsBigInt("UnlockDuration"),
      initialBalance: json.valueAsBigInt("InitialBalance"),
      nextTxnID: json.valueAsBigInt("NextTxnID"),
      numApprovalsThreshold: json.valueAsBigInt("NumApprovalsThreshold"),
      pendingTxns: json.valueTo<Cid?, Object>(
        key: "PendingTxns",
        parse: (e) => Cid.fromJson(e),
      ),
      signers:
          json
              .valueEnsureAsList<String>("Signers")
              .map((e) => FilAddress(e))
              .toList(),
    );
  }
}

/// Convenience wrapper that pairs Multisig state with actor balance and code CID.
///
/// Returned by [FilQuickMultisigApi.getMultisigState].
class FilMultisigStateInfo {
  /// Current FIL balance of the Multisig actor (attoFIL).
  final BigInt balance;

  /// Code CID of the Multisig actor (used to detect actor version).
  final Cid code;

  /// Decoded Multisig state.
  final FilMultisigState state;

  const FilMultisigStateInfo({
    required this.balance,
    required this.code,
    required this.state,
  });

  factory FilMultisigStateInfo.fromJson(Map<String, dynamic> json) {
    return FilMultisigStateInfo(
      balance: json.valueAsBigInt("Balance"),
      code: json.valueTo<Cid, Object>(
        key: "Code",
        parse: (e) => Cid.fromJson(e),
      ),
      state: json.valueTo<FilMultisigState, Map<String, dynamic>>(
        key: "State",
        parse: (e) => FilMultisigState.fromJson(e),
      ),
    );
  }
}

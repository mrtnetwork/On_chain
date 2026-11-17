import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/serialization/seriaization.dart';
import 'package:on_chain/fil/src/types/types/token_amount.dart';

// =============================================================================
// Multisig actor parameter types
//
// These classes encode the CBOR parameters expected by the built-in Multisig
// actor methods. They are used by FilQuickMultisigApi to build messages.
// =============================================================================

/// Parameters for **Multisig.Propose** (method 2).
///
/// Proposes an arbitrary message to be executed by the multisig once the
/// approval threshold is met. The proposer automatically counts as one approval.
class FilMultisigProposeParams with FilSerialization {
  /// Destination of the proposed message.
  final FilAddress to;

  /// Value (attoFIL) to send with the proposed message.
  final FilTokenAmount value;

  /// Method number to call on [to].
  final BigInt method;

  /// CBOR-encoded parameters for the inner method (may be empty).
  final BuBytes params;

  FilMultisigProposeParams({
    required this.to,
    required this.value,
    required this.method,
    List<int> params = const [],
  }) : params = params.asImmutableBytes;

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([
      to.toCbor(),
      value.toCbor(),
      method.toSafeIntCbor(),
      params.toCborBytes(),
    ]);
  }

  Map<String, dynamic> toJson() => {
    'To': to.address,
    'Value': value.toJson(),
    'Method': method,
    'Params': params,
  };
}

/// Parameters for **Multisig.Approve** (method 3) and **Multisig.Cancel** (method 4).
///
/// [proposalHash] is optional but strongly recommended – it binds the approval
/// to a specific proposal and prevents certain classes of race conditions.
class FilMultisigTxnIDParams with FilSerialization {
  /// Transaction ID returned by Propose.
  final BigInt id;

  /// Optional 32-byte blake2b-256 proposal hash.
  final BuBytes? proposalHash;

  FilMultisigTxnIDParams({required this.id, List<int>? proposalHash})
    : proposalHash = proposalHash?.asImmutableBytes;

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([
      id.toSafeIntCbor(),
      (proposalHash ?? <int>[]).toCborBytes(),
    ]);
  }

  Map<String, dynamic> toJson() => {'ID': id, 'ProposalHash': proposalHash};
}

/// Parameters for **Multisig.AddSigner** (method 5).
class FilMultisigAddSignerParams with FilSerialization {
  /// Address of the new signer to add.
  final FilAddress signer;

  /// If `true`, also increase the approval threshold by one.
  final bool increase;

  const FilMultisigAddSignerParams({
    required this.signer,
    this.increase = false,
  });

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([
      signer.toCbor(),
      increase.toCbor(),
    ]);
  }

  Map<String, dynamic> toJson() => {
    'Signer': signer.address,
    'Increase': increase,
  };
}

/// Parameters for **Multisig.RemoveSigner** (method 6).
class FilMultisigRemoveSignerParams with FilSerialization {
  /// Address of the signer to remove.
  final FilAddress signer;

  /// If `true`, also decrease the approval threshold by one.
  final bool decrease;

  const FilMultisigRemoveSignerParams({
    required this.signer,
    this.decrease = false,
  });

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([
      signer.toCbor(),
      decrease.toCbor(),
    ]);
  }

  Map<String, dynamic> toJson() => {
    'Signer': signer.address,
    'Decrease': decrease,
  };
}

/// Parameters for **Multisig.SwapSigner** (method 7).
class FilMultisigSwapSignerParams with FilSerialization {
  /// Address being replaced.
  final FilAddress from;

  /// Address that replaces [from].
  final FilAddress to;

  const FilMultisigSwapSignerParams({required this.from, required this.to});

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([from.toCbor(), to.toCbor()]);
  }

  Map<String, dynamic> toJson() => {'From': from.address, 'To': to.address};
}

/// Parameters for **Multisig.ChangeNumApprovalsThreshold** (method 8).
class FilMultisigChangeNumApprovalsThresholdParams with FilSerialization {
  /// New approval threshold (must be ≥ 1 and ≤ number of signers).
  final BigInt newThreshold;

  const FilMultisigChangeNumApprovalsThresholdParams(this.newThreshold);

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([newThreshold.toSafeIntCbor()]);
  }

  Map<String, dynamic> toJson() => {'NewThreshold': newThreshold};
}

/// Parameters for **Multisig.LockBalance** (method 9).
///
/// Locks [amount] so it cannot be spent until `startEpoch + unlockDuration`.
class FilMultisigLockBalanceParams with FilSerialization {
  /// Epoch at which vesting starts.
  final BigInt startEpoch;

  /// Number of epochs over which the locked balance linearly unlocks.
  final BigInt unlockDuration;

  /// Amount to lock (attoFIL).
  final FilTokenAmount amount;

  const FilMultisigLockBalanceParams({
    required this.startEpoch,
    required this.unlockDuration,
    required this.amount,
  });

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([
      startEpoch.toSafeIntCbor(),
      unlockDuration.toSafeIntCbor(),
      amount.toCbor(),
    ]);
  }

  Map<String, dynamic> toJson() => {
    'StartEpoch': startEpoch,
    'UnlockDuration': unlockDuration,
    'Amount': amount.toJson(),
  };
}

/// Constructor parameters used when creating a Multisig via **Init.Exec**.
class FilMultisigConstructorParams with FilSerialization {
  /// Initial set of signers (max 256).
  final List<FilAddress> signers;

  /// Number of approvals required to execute a transaction.
  final BigInt numApprovalsThreshold;

  /// Optional linear vesting duration (0 = no vesting).
  final BigInt unlockDuration;

  /// Epoch at which vesting starts (ignored when [unlockDuration] is 0).
  final BigInt startEpoch;

  const FilMultisigConstructorParams({
    required this.signers,
    required this.numApprovalsThreshold,
    required this.unlockDuration,
    required this.startEpoch,
  });

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([
      CborSerializable.listFromObjects(signers.map((a) => a.toCbor()).toList()),
      numApprovalsThreshold.toSafeIntCbor(),
      unlockDuration.toSafeIntCbor(),
      startEpoch.toSafeIntCbor(),
    ]);
  }

  Map<String, dynamic> toJson() => {
    'Signers': signers.map((a) => a.address).toList(),
    'NumApprovalsThreshold': numApprovalsThreshold,
    'UnlockDuration': unlockDuration,
    'StartEpoch': startEpoch,
  };
}

/// Data that is hashed to produce a Multisig **proposal hash**.
///
/// The hash is `blake2b-256(CBOR(this))` and should be supplied when
/// calling Approve / Cancel to bind the operation to a specific proposal.
class FilMultisigProposalHashData with FilSerialization {
  /// Address of the proposer (the signer that called Propose).
  final FilAddress requester;

  /// Destination of the proposed message.
  final FilAddress to;

  /// Value of the proposed message.
  final FilTokenAmount value;

  /// Method of the proposed message.
  final BigInt method;

  /// Params of the proposed message.
  final BuBytes params;

  FilMultisigProposalHashData({
    required this.requester,
    required this.to,
    required this.value,
    required this.method,
    List<int> params = const [],
  }) : params = params.asImmutableBytes;

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([
      requester.toCbor(),
      to.toCbor(),
      value.toCbor(),
      method.toSafeIntCbor(),
      params.toCborBytes(),
    ]);
  }

  /// Returns the 32-byte blake2b-256 hash of the CBOR encoding.
  List<int> hash() {
    final encoded = toCbor().encode();
    return QuickCrypto.blake2b256Hash(encoded);
  }
}

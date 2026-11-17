/// Second-byte discriminants of the Token-2022
/// ConfidentialTransferExtension (outer instruction 27). Order matches
/// `ConfidentialTransferInstruction` in spl-token-2022 (repr u8).
class ConfidentialTransferInstruction {
  final int value;
  const ConfidentialTransferInstruction._(this.value);

  /// Initialize confidential-transfer config on a mint. Must be in the same
  /// transaction as `TokenInstruction::InitializeMint`.
  static const ConfidentialTransferInstruction initializeMint =
      ConfidentialTransferInstruction._(0);

  /// Update the confidential-transfer mint config.
  static const ConfidentialTransferInstruction updateMint =
      ConfidentialTransferInstruction._(1);

  /// Configure a token account for confidential transfers.
  static const ConfidentialTransferInstruction configureAccount =
      ConfidentialTransferInstruction._(2);

  /// Approve a configured account when auto-approve is off.
  static const ConfidentialTransferInstruction approveAccount =
      ConfidentialTransferInstruction._(3);

  /// Empty a confidential balance so the account can be closed.
  static const ConfidentialTransferInstruction emptyAccount =
      ConfidentialTransferInstruction._(4);

  /// Deposit public balance into confidential pending balance.
  static const ConfidentialTransferInstruction deposit =
      ConfidentialTransferInstruction._(5);

  /// Withdraw from confidential available balance to public balance.
  static const ConfidentialTransferInstruction withdraw =
      ConfidentialTransferInstruction._(6);

  /// Confidential transfer between token accounts.
  static const ConfidentialTransferInstruction transfer =
      ConfidentialTransferInstruction._(7);

  /// Move pending balance to available balance.
  static const ConfidentialTransferInstruction applyPendingBalance =
      ConfidentialTransferInstruction._(8);

  /// Allow confidential credits on the account.
  static const ConfidentialTransferInstruction enableConfidentialCredits =
      ConfidentialTransferInstruction._(9);

  /// Block confidential credits on the account.
  static const ConfidentialTransferInstruction disableConfidentialCredits =
      ConfidentialTransferInstruction._(10);

  /// Allow non-confidential credits on the account.
  static const ConfidentialTransferInstruction enableNonConfidentialCredits =
      ConfidentialTransferInstruction._(11);

  /// Block non-confidential credits on the account.
  static const ConfidentialTransferInstruction disableNonConfidentialCredits =
      ConfidentialTransferInstruction._(12);

  /// Confidential transfer with transfer-fee withheld.
  static const ConfidentialTransferInstruction transferWithFee =
      ConfidentialTransferInstruction._(13);

  /// Configure via the ElGamal registry instead of a pubkey-validity proof.
  static const ConfidentialTransferInstruction configureAccountWithRegistry =
      ConfidentialTransferInstruction._(14);

  static const List<ConfidentialTransferInstruction> values = [
    initializeMint,
    updateMint,
    configureAccount,
    approveAccount,
    emptyAccount,
    deposit,
    withdraw,
    transfer,
    applyPendingBalance,
    enableConfidentialCredits,
    disableConfidentialCredits,
    enableNonConfidentialCredits,
    disableNonConfidentialCredits,
    transferWithFee,
    configureAccountWithRegistry,
  ];

  static ConfidentialTransferInstruction? fromValue(dynamic value) {
    for (final e in values) {
      if (e.value == value) return e;
    }
    return null;
  }
}

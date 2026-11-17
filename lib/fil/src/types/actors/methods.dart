/// Built-in actor method numbers used when constructing [FilMessage]s.
///
/// These numbers match the Filecoin actor ABI (exported method indices).
/// Prefer these constants over hard-coded integers so upgrades and
/// cross-version code stay readable.
///
/// See also:
/// - Multisig actor methods in `actors/multisig/`
/// - Payment channel methods in `actors/payment_channel/`
/// - Init actor methods in `actors/init/`
abstract final class FilMethods {
  // ---------------------------------------------------------------------------
  // Common (every actor)
  // ---------------------------------------------------------------------------

  /// Method 0 – plain value transfer (no params).
  static BigInt get send => BigInt.zero;

  /// Method 1 – constructor (only callable via Init.Exec / Exec4).
  static BigInt get constructor => BigInt.one;

  // ---------------------------------------------------------------------------
  // Multisig actor
  // ---------------------------------------------------------------------------

  /// Multisig.Propose (method 2).
  static BigInt get msigPropose => BigInt.from(2);

  /// Multisig.Approve (method 3).
  static BigInt get msigApprove => BigInt.from(3);

  /// Multisig.Cancel (method 4).
  static BigInt get msigCancel => BigInt.from(4);

  /// Multisig.AddSigner (method 5).
  static BigInt get msigAddSigner => BigInt.from(5);

  /// Multisig.RemoveSigner (method 6).
  static BigInt get msigRemoveSigner => BigInt.from(6);

  /// Multisig.SwapSigner (method 7).
  static BigInt get msigSwapSigner => BigInt.from(7);

  /// Multisig.ChangeNumApprovalsThreshold (method 8).
  static BigInt get msigChangeNumApprovalsThreshold => BigInt.from(8);

  /// Multisig.LockBalance (method 9).
  static BigInt get msigLockBalance => BigInt.from(9);

  // ---------------------------------------------------------------------------
  // Init actor
  // ---------------------------------------------------------------------------

  /// Init.Exec (method 2) – create a new actor from a code CID + constructor params.
  static BigInt get initExec => BigInt.from(2);

  // ---------------------------------------------------------------------------
  // Account actor
  // ---------------------------------------------------------------------------

  /// Account.PubkeyAddress (method 2) – resolve ID address → robust pubkey address.
  static BigInt get accountPubkeyAddress => BigInt.from(2);

  // ---------------------------------------------------------------------------
  // Payment channel actor
  // ---------------------------------------------------------------------------

  /// Paych.UpdateChannelState (method 2) – submit a signed voucher.
  static BigInt get paychUpdateChannelState => BigInt.from(2);

  /// Paych.Settle (method 3) – start the settlement period.
  static BigInt get paychSettle => BigInt.from(3);

  /// Paych.Collect (method 4) – collect funds after settlement.
  static BigInt get paychCollect => BigInt.from(4);
}

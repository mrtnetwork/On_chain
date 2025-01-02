import 'package:on_chain/solana/src/address/sol_address.dart';

/// Class representing metadata for an account, including its public key, signer status, and writability.
class AccountMeta {
  /// Constructor to create an AccountMeta instance.
  const AccountMeta({
    required this.publicKey,
    required this.isSigner,
    required this.isWritable,
  });

  /// Public key of the account.
  final SolAddress publicKey;

  /// True if an instruction requires a transaction signature matching [publicKey].
  final bool isSigner;

  /// True if the [publicKey] can be loaded as a read-write account..
  final bool isWritable;

  /// Method to create a copy of AccountMeta with optional parameters overridden.
  AccountMeta copyWith({
    SolAddress? publicKey,
    bool? isSigner,
    bool? isWritable,
  }) {
    return AccountMeta(
      publicKey: publicKey ?? this.publicKey,
      isSigner: isSigner ?? this.isSigner,
      isWritable: isWritable ?? this.isWritable,
    );
  }

  @override
  String toString() {
    return 'AccountMeta{publickey: $publicKey, isWritable: $isWritable, isSigner: $isSigner,}';
  }
}

/// Extension providing quick methods to create AccountMeta instances with predefined configurations.
extension QuickAccountMeta on SolAddress {
  /// Create an AccountMeta instance indicating the account is writable but not a signer.
  AccountMeta toWritable() {
    return AccountMeta(publicKey: this, isSigner: false, isWritable: true);
  }

  /// Create an AccountMeta instance indicating the account is a signer but not writable.
  AccountMeta toSigner() {
    return AccountMeta(publicKey: this, isSigner: true, isWritable: false);
  }

  /// Create an AccountMeta instance indicating the account is both a signer and writable.
  AccountMeta toSignerAndWritable() {
    return AccountMeta(publicKey: this, isSigner: true, isWritable: true);
  }

  /// Create an AccountMeta instance indicating the account is neither a signer nor writable.
  AccountMeta toReadOnly() {
    return AccountMeta(publicKey: this, isSigner: false, isWritable: false);
  }
}

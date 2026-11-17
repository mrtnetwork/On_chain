import 'package:on_chain/algorand/src/crypto/crypto.dart';
import 'package:on_chain/algorand/src/account/core/account.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/transaction/src/signatures.dart';
import 'package:on_chain/algorand/src/transaction/src/transaction.dart';

/// Marker interface for single-key (non-multisig) account public keys.
abstract class AlgoSingleAccountPublicKey<PK extends AlgoPublicKey>
    implements AlgoAccountPublicKey {
  /// Returns the underlying public key for this account.
  PK toPublicKey();
}

/// Marker interface for single-key accounts that hold a secret key and can sign.
abstract class AlgoSingleAccount<
  PK extends AlgoPublicKey,
  SK extends AlgoSecretKey<PK>,
  PA extends AlgoSingleAccountPublicKey<PK>
>
    extends AlgoAccount<PA> {
  /// Returns the underlying secret key for this account.
  SK toSecretKey();
}

/// Single Ed25519 public-key account (address = encode(publicKey)).
class AlgoSingleEd25519AccountPublicKey
    implements AlgoSingleAccountPublicKey<AlgoEd25519PublicKey> {
  /// The Ed25519 public key that defines this account's address.
  final AlgoEd25519PublicKey publicKey;

  const AlgoSingleEd25519AccountPublicKey(this.publicKey);

  /// Address derived from [publicKey].
  @override
  AlgoAddress toAddress() {
    return publicKey.toAddress();
  }

  @override
  AlgoEd25519PublicKey toPublicKey() {
    return publicKey;
  }
}

/// Single Ed25519 account holding a secret key for transaction signing.
class AlgoSingleEd25519Account
    implements
        AlgoSingleAccount<
          AlgoPublicKey,
          AlgoEd25519SecretKey,
          AlgoSingleEd25519AccountPublicKey
        > {
  /// The Ed25519 secret key used to sign transactions.
  final AlgoEd25519SecretKey secretKey;

  const AlgoSingleEd25519Account(this.secretKey);

  /// Signs [transaction] and returns an [AlgoSignedTxn].
  ///
  /// Sets [authAddr] when the transaction sender is not this key's address
  /// (rekey / delegated signing).
  AlgoSignedTxn signTransaction(AlgoTransaction transaction) {
    final signature = secretKey.rawSignTransaction(transaction);
    final addr = transaction.sender;
    final signerAddress = secretKey.toPublicKey().toAddress();
    if (addr != signerAddress) {
      return AlgoSignedTxn(
        transaction: transaction,
        signature: signature,
        authAddr: signerAddress,
      );
    }
    return AlgoSignedTxn(transaction: transaction, signature: signature);
  }

  @override
  AlgoEd25519SecretKey toSecretKey() {
    return secretKey;
  }

  /// Public-account view of this key (no secret material).
  @override
  AlgoSingleEd25519AccountPublicKey toPublicAccount() {
    return AlgoSingleEd25519AccountPublicKey(secretKey.toPublicKey());
  }

  /// Async wrapper around [signTransaction] for [AlgoAccount] compatibility.
  @override
  Future<AlgoSignedTxn> signTransactionsAsync(AlgoTransaction tx) async {
    return signTransaction(tx);
  }

  /// Builds a signed transaction for dry-run / simulate or fee calculation without a real signature.
  @override
  Future<AlgoSignedTxn> signSimulateTransactionsAsync(
    AlgoTransaction tx,
  ) async {
    return secretKey.signSimulateTransactionsAsync(tx);
  }
}

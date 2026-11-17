import 'package:on_chain/sui/src/account/core/account.dart';
import 'package:on_chain/sui/src/address/address/address.dart';

import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/object.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/transaction_execution_service.dart';
import 'package:on_chain/sui/src/transaction/types/types.dart';
import 'package:on_chain/transaction/transaction.dart';

/// Snapshot of a [SuiTransactionDataV1] as an [IOnchainTransaction].
class SuiOnchainTransaction implements IOnchainTransaction {
  final SuiTransactionDataV1 data;

  const SuiOnchainTransaction(this.data);
}

class SuiGetTransactionParams implements IOnchainTransactionParams {
  const SuiGetTransactionParams();
}

/// Parameters for [SuiTransactionBuilder.fillTransaction].
///
/// Resolves gas price, gas coins, budget and sponsor. Anything supplied is
/// used as-is; the rest is fetched/estimated through the quick client.
class SuiFillTransactionParams implements IOnchainFillTransactionParams {
  /// Transaction sender (also default gas owner).
  final SuiAddress sender;

  /// Explicit gas price; fetched via `getGasPrice()` when null.
  final BigInt? gasPrice;

  /// Explicit budget; estimated via `simulateTransaction()` when null.
  final BigInt? budget;

  /// Multiplier applied to the simulated gas cost.
  final double safetyMultiplier;

  /// Explicit gas coins; selected from the gas owner's coins when null.
  final List<SuiObject>? gasCoins;

  /// Gas sponsor (pays fees, owns the gas coins). Defaults to [sender].
  final SuiAddress? sponsor;

  /// Transaction expiration. Defaults to none.
  final SuiTransactionExpiration? expiration;

  const SuiFillTransactionParams({
    required this.sender,
    this.gasPrice,
    this.budget,
    this.safetyMultiplier = 1.2,
    this.gasCoins,
    this.sponsor,
    this.expiration,
  });
}

class SuiFillTransactionResult implements IOnchainFillTransactionResult {
  final BigInt gasPrice;
  final BigInt budget;
  final List<SuiObject> gasCoins;
  final SuiAddress gasOwner;

  const SuiFillTransactionResult({
    required this.gasPrice,
    required this.budget,
    required this.gasCoins,
    required this.gasOwner,
  });
}

/// Parameters for [SuiTransactionBuilder.signTransaction].
class SuiSignTransactionParams implements IOnchainSignTransactionParams {
  /// Signers in signature order (sender first for sponsored flows).
  final List<SuiAccount> signers;

  const SuiSignTransactionParams({required this.signers});
}

class SuiSignedTransactionResult implements IOnchainSignedTransactionResult {
  final SuiSenderSignedTransaction signedTransaction;

  /// Base64 BCS of the unsigned TransactionData (execute-ready; signatures
  /// ride separately).
  final String txBytes;

  /// Transaction digest.
  final String digest;

  const SuiSignedTransactionResult({
    required this.signedTransaction,
    required this.txBytes,
    required this.digest,
  });
}

class SuiFinalizeTransactionParams
    implements IOnchainFinalizeTransactionParams {
  const SuiFinalizeTransactionParams();
}

class SuiFinalizedTransactionResult
    implements IOnchainFinalizedTransactionResult {
  final SuiSenderSignedTransaction signedTransaction;
  final String txBytes;
  final String digest;

  const SuiFinalizedTransactionResult({
    required this.signedTransaction,
    required this.txBytes,
    required this.digest,
  });
}

class SuiSubmitTransactionParams implements IOnchainSubmitTransactionParams {
  const SuiSubmitTransactionParams();
}

class SuiSubmitTransactionResult implements IOnchainSubmitTransactionResult {
  final SuiExecuteTransactionResponse response;
  final String digest;

  const SuiSubmitTransactionResult({
    required this.response,
    required this.digest,
  });
}

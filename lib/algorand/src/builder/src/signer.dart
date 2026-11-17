import 'package:blockchain_utils/blockchain_utils.dart';

// transaction_signer.dart
import 'package:on_chain/algorand/src/abi/src/method.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';
import 'package:on_chain/algorand/src/transaction/src/fields.dart';
import 'package:on_chain/algorand/src/transaction/src/signatures.dart';
import 'package:on_chain/algorand/src/transaction/src/transaction.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Contract for any entity that can sign Algorand transactions.
///
/// Implemented by single-key accounts ([AlgoSingleEd25519Account]),
/// multi-sig accounts ([AlgoMultiEd25519Account]), and raw secret keys
/// ([AlgoSecretKey]).
abstract class AlgoTransactionSigner {
  /// Signs [tx] with a real cryptographic signature and returns an [AlgoSignedTxn].
  Future<AlgoSignedTxn> signTransactionsAsync(AlgoTransaction tx);

  /// Builds a signed transaction for dry-run / simulate or fee estimation
  /// without a real cryptographic signature.
  ///
  /// Uses non-zero placeholder signature bytes so msgpack still encodes the
  /// `sig` field. An all-zero or empty signature would be omitted by
  /// `.notNullValue` / empty-bytes elision, understating the encoded size and
  /// producing an incorrect fee estimate.
  Future<AlgoSignedTxn> signSimulateTransactionsAsync(AlgoTransaction tx);
}

/// Pairs an [AlgoTransaction] with the [AlgoTransactionSigner] that will sign it.
///
/// Optionally carries an [ABIMethod] for application-call transactions so
/// return values can be decoded after submission.
class TransactionWithSigner {
  /// The unsigned transaction to be signed.
  final AlgoTransaction txn;

  /// The signer responsible for producing the signature (single-key, multisig, etc.).
  final AlgoTransactionSigner signer;

  /// ABI method associated with this transaction, if any.
  ///
  /// Only valid for application-call (`appl`) transactions. Provide this when
  /// you need to decode the method's return value from the transaction result.
  final ABIMethod? abiMethod;

  const TransactionWithSigner._({
    required this.txn,
    required this.signer,
    this.abiMethod,
  });

  factory TransactionWithSigner({
    required AlgoTransaction txn,
    required AlgoTransactionSigner signer,
    ABIMethod? abiMethod,
  }) {
    if (abiMethod != null && txn.type != AlgoTxType.appl) {
      throw OnChainErrors.algoTx(
        "TransactionWithSigner",
        reason:
            "ABI methods are only supported for application call transactions.",
      );
    }
    return TransactionWithSigner._(
      txn: txn,
      signer: signer,
      abiMethod: abiMethod,
    );
  }
}

class ABIMethodResult {
  final String txId;
  final AlgoRestTypesPendingTransactionResponse?
  transactionInfo; // pending txn response
  final ABIMethod? method; // your ABI Method type
  final BuBytes? rawReturnValue;
  final Object? returnValue;

  ABIMethodResult({
    required this.txId,
    this.transactionInfo,
    this.method,
    List<int>? rawReturnValue = const [],
    this.returnValue,
  }) : rawReturnValue = rawReturnValue?.asImmutableBytes;

  Map<String, dynamic> toJson() {
    return {
      "txId": txId,
      "transactionInfo": transactionInfo?.toJson(),
      "method": method?.toJson(),
      "rawReturnValue": rawReturnValue,
      "returnValue": returnValue,
    };
  }
}

class ExecuteResult {
  final BigInt confirmedRound;
  final List<String> txIds;
  final List<ABIMethodResult?> methodResults;

  const ExecuteResult({
    required this.confirmedRound,
    required this.txIds,
    required this.methodResults,
  });
  Map<String, dynamic> toJson() {
    return {
      "confirmedRound": confirmedRound,
      "txIds": txIds,
      "methodResults": methodResults.map((e) => e?.toJson()).toList(),
    };
  }
}

class SimulateResult {
  final AlgoRestTypesSimulateTransactionGroupResult simulateResponse;
  final List<ABIMethodResult?> methodResults;

  const SimulateResult({
    required this.simulateResponse,
    required this.methodResults,
  });
  Map<String, dynamic> toJson() {
    return {
      "simulateResponse": simulateResponse.toJson(),
      "methodResults": methodResults.map((e) => e?.toJson()).toList(),
    };
  }
}

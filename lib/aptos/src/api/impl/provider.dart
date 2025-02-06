import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:on_chain/aptos/aptos.dart';
import 'package:on_chain/aptos/src/provider/constant/constants.dart';

/// A helper mixin for interacting with the Aptos API through an AptosProvider.
mixin AptosQuickApiProviderHelper {
  /// The Aptos provider used to make API requests.
  AptosProvider get provider;

  /// Retrieves account data for the given [address].
  Future<AptosApiAccountData> getAccountData(AptosAddress address) async {
    return await provider.request(AptosRequestGetAccount(address: address));
  }

  /// Checks if an account is active based on the provided [address].
  /// Returns `true` if the account exists, otherwise `false`.
  Future<bool> accountIsActive(AptosAddress address) async {
    try {
      await provider.request(AptosRequestGetAccount(address: address));
      return true;
    } on RPCError catch (e) {
      if (e.details?["error_code"] ==
          AptosProviderConst.accountNotFoundErrorCode) {
        return false;
      }
      rethrow;
    }
  }

  /// Retrieves the current estimated gas price from the Aptos network.
  Future<BigInt> getGasPrice() async {
    final r = await provider.request(AptosRequestEstimateGasPrice());
    return BigInt.from(r.gasEstimate);
  }

  /// Retrieves the chain ID of the current Aptos network.
  Future<int> getChainId() async {
    final r = await provider.request(AptosRequestGetLedgerInfo());
    return r.chainId;
  }

  /// Retrieves the current sequence number for the specified [address].
  Future<BigInt> getAccountSequence(AptosAddress address) async {
    final r = await getAccountData(address);
    return r.sequenceNumber;
  }

  /// Submits a signed transaction to the Aptos network.
  ///
  /// [transaction] is the signed transaction data to be submitted.
  Future<AptosApiPendingTransaction> submitTransaction(
      AptosSignedTransaction transaction) {
    return provider.request(AptosRequestSubmitTransaction(
        signedTransactionData: transaction.toBcs()));
  }

  /// Executes a view function from an Aptos module.
  ///
  /// [entry] defines the function to call, and [ledgerVersion] (optional)
  /// specifies the ledger version to query against.
  Future<List<T>> callFunction<T>(AptosTransactionEntryFunction entry,
      {BigInt? ledgerVersion}) {
    return provider.request(AptosRequestExecuteViewFunctionOfaModule<T>.bcs(
        entry: entry, ledgerVersion: ledgerVersion));
  }
}

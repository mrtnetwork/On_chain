import 'package:on_chain/on_chain.dart';
import 'provider_example.dart';

final AptosProvider aptosProvider =
    AptosProvider(AptosHttpService("https://api.testnet.aptoslabs.com/"));
Future<AptosApiAccountData> getAccountInfo(AptosAddress address) async {
  final r =
      await aptosProvider.request(AptosRequestGetAccount(address: address));
  return r;
}

Future<BigInt> getAccountSequence(AptosAddress address) async {
  final r =
      await aptosProvider.request(AptosRequestGetAccount(address: address));
  return r.sequenceNumber;
}

Future<String> simulate(AptosSignedTransaction transaction) async {
  final r = await aptosProvider.request(AptosRequestSubmitTransaction(
      signedTransactionData: transaction.toBcs()));
  return r.hash;
}

Future<int> getChainId() async {
  final r = await aptosProvider.request(AptosRequestGetLedgerInfo());
  return r.chainId;
}

Future<BigInt> gasEstimate() async {
  final r = await aptosProvider.request(AptosRequestEstimateGasPrice());
  return BigInt.from(r.gasEstimate);
}

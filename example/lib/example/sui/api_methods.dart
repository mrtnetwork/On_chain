import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'provider_example.dart';

final BigInt maxGas = BigInt.from(5e10);
final BigInt gasSafeOverHead = BigInt.from(1000);

final suiProvider =
    SuiProvider(SuiHttpService("https://fullnode.devnet.sui.io:443"));
Future<BigInt> getGasPrice() async {
  return await suiProvider.request(const SuiRequestGetReferenceGasPrice());
}

Future<List<SuiApiCoinResponse>> getAllCoins(SuiAddress address) async {
  final r = await suiProvider.request(SuiRequestGetAllCoins(owner: address));
  return r.data;
}

Future<List<SuiApiCoinResponse>> getCoins(SuiAddress address) async {
  final r = await suiProvider.request(SuiRequestGetCoins(
      owner: address, coinType: SuiTransactionConst.suiTypeArgs));
  return r.data;
}

Future<SuiTransactionDataV1> filledGasPayment(SuiTransactionDataV1 tx) async {
  final coins = await getCoins(tx.gasData.owner);
  final kind = tx.kind.cast<SuiTransactionKindProgrammableTransaction>();
  final ownedObjectAddresses = kind.transaction.inputs
      .whereType<SuiCallArgObject>()
      .map((e) => e.object)
      .whereType<SuiObjectArgImmOrOwnedObject>()
      .map((e) => e.immOrOwnedObject.address);

  List<SuiApiCoinResponse> filterCoins = coins
      .where((e) => !ownedObjectAddresses.contains(e.coinObjectId))
      .toList();
  assert(filterCoins.isNotEmpty, "leak of gas token");
  List<SuiObjectRef> gasTokens = [];
  final BigInt gasBudget = tx.gasData.budget;
  BigInt sum = BigInt.zero;
  for (final i in filterCoins) {
    gasTokens.add(i.toObjectRef());
    sum += i.balance;
    if (sum >= gasBudget) break;
  }
  assert(sum >= gasBudget,
      "Insufficient balance: required ${SuiHelper.toSui(gasBudget)} available: ${SuiHelper.toSui(sum)}");
  return tx.copyWith(gasData: tx.gasData.copyWith(payment: gasTokens));
}

Future<SuiApiTransactionBlockResponse> excuteTx(
    {required SuiTransactionDataV1 tx,
    required List<SuiBaseSignature> signatures}) async {
  return await suiProvider.request(SuiRequestExecuteTransactionBlock(
      txBytes: tx.toVariantBcsBase64(),
      signatures: signatures.map((e) => e.toVariantBcsBase64()).toList(),
      options: const SuiApiTransactionBlockResponseOptions(showEffects: true)));
}

Future<SuiTransactionDataV1> dryRunTx(SuiTransactionDataV1 tx) async {
  final r = await suiProvider.request(SuiRequestDryRunTransactionBlock(
      txBytes:
          StringUtils.decode(tx.toVariantBcs(), type: StringEncoding.base64)));
  assert(r.effects.status.status == SuiApiExecutionStatusType.success,
      r.effects.status.error);
  final safeOverHead = gasSafeOverHead * tx.gasData.price;
  final baseComputationGasOverHead =
      r.effects.gasUsed.computationCost + safeOverHead;
  BigInt gasBudget = baseComputationGasOverHead +
      r.effects.gasUsed.storageCost -
      r.effects.gasUsed.storageRebate;
  if (gasBudget < baseComputationGasOverHead) {
    gasBudget = baseComputationGasOverHead;
  }
  return tx.copyWith(gasData: tx.gasData.copyWith(budget: gasBudget));
}

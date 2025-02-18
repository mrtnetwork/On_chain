import 'package:example/example/sui/api_methods.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  final account = SuiSecp256r1Account(
      SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 64)));
  final destination = SuiSecp256r1Account(
      SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 65)));

  final coins = await getAllCoins(account.toAddress());
  final splitCoins = SuiCommandSplitCoins(
      amounts: [SuiArgumentInput(1)], coin: SuiArgumentInput(0));
  final amountInput = SuiCallArgPure.u64(BigInt.from(12000000));

  final receipmentInput = destination.toAddress();

  final transfer = SuiCommandTransferObjects(objects: [
    SuiArgumentNestedResult(commandIndex: 0, resultIndex: 0),
  ], address: SuiArgumentInput(2));

  final gasPrice = await getGasPrice();
  SuiTransactionDataV1 transaction = SuiTransactionDataV1(
      expiration: const SuiTransactionExpirationNone(),
      sender: account.toAddress(),
      gasData: SuiGasData(
          payment: [],
          owner: account.toAddress(),
          price: gasPrice,
          budget: maxGas),
      kind: SuiTransactionKindProgrammableTransaction(
          SuiProgrammableTransaction(inputs: [
        SuiCallArgObject(SuiObjectArgImmOrOwnedObject(coins[1].toObjectRef())),
        amountInput,
        receipmentInput,
      ], commands: [
        splitCoins,
        transfer
      ])));
  transaction = await dryRunTx(transaction);
  transaction = await filledGasPayment(transaction);
  final transactionDigest = transaction.serializeSign();

  final signature = account.signTransaction(transactionDigest);
  final r = await excuteTx(tx: transaction, signatures: [signature]);
  assert(r.effects?.status.status == SuiApiExecutionStatusType.success);
}

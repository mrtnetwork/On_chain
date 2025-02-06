import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  final account = SuiSecp256r1Account(
      SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 12)));
  final splitCoins = SuiCommandSplitCoins(
      amounts: [SuiArgumentInput(0), SuiArgumentInput(1)],
      coin: SuiArgumentGasCoin());
  final amountInput = SuiCallArgPure.sui("0.001");
  final amountInput2 = SuiCallArgPure.sui("0.002");

  final receipmentInput = SuiCallArgPure.address(SuiAddress(
      "0xcb214af0483b39c446690f19ae2da8ce703f52239ff94fd42553ceb48c4dda3d"));
  final receipmentInput2 = SuiCallArgPure.address(SuiAddress(
      "0xcc214af0483b39c446690f19ae2da8ce703f52239ff94fd42553ceb48c4dda3d"));
  final transfer = SuiCommandTransferObjects(objects: [
    SuiArgumentNestedResult(commandIndex: 0, resultIndex: 0),
  ], address: SuiArgumentInput(2));
  final transfer2 = SuiCommandTransferObjects(
      objects: [SuiArgumentNestedResult(commandIndex: 0, resultIndex: 1)],
      address: SuiArgumentInput(3));

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
        amountInput,
        amountInput2,
        receipmentInput,
        receipmentInput2
      ], commands: [
        splitCoins,
        transfer,
        transfer2
      ])));
  transaction = await dryRunTx(transaction);
  transaction = await filledGasPayment(transaction);
  final transactionDigest = transaction.serializeSign();

  final signature = account.signTransaction(transactionDigest);
  final r = await excuteTx(tx: transaction, signatures: [signature]);
  assert(r.effects?.status.status == SuiApiExecutionStatusType.success);

  /// https://suiscan.xyz/devnet/tx/5zjgD2SzRYqvXWbseJEa4ZmpATLFCSVe2Xpv6eoXc23J
}

Future<void> batch() async {
  final account = SuiSecp256r1Account(
      SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 12)));
  final splitCoins = SuiCommandSplitCoins(
      amounts: [SuiArgumentInput(0), SuiArgumentInput(1)],
      coin: SuiArgumentGasCoin());
  final amountInput = SuiCallArgPure.sui("0.001");
  final amountInput2 = SuiCallArgPure.sui("0.002");

  final receipmentInput = SuiCallArgPure.address(SuiAddress(
      "0xcb214af0483b39c446690f19ae2da8ce703f52239ff94fd42553ceb48c4dda3d"));
  final receipmentInput2 = SuiCallArgPure.address(SuiAddress(
      "0xcc214af0483b39c446690f19ae2da8ce703f52239ff94fd42553ceb48c4dda3d"));
  final transfer = SuiCommandTransferObjects(objects: [
    SuiArgumentNestedResult(commandIndex: 0, resultIndex: 0),
  ], address: SuiArgumentInput(2));
  final transfer2 = SuiCommandTransferObjects(
      objects: [SuiArgumentNestedResult(commandIndex: 0, resultIndex: 1)],
      address: SuiArgumentInput(3));

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
        amountInput,
        amountInput2,
        receipmentInput,
        receipmentInput2
      ], commands: [
        splitCoins,
        transfer,
        transfer2
      ])));
  transaction = await dryRunTx(transaction);
  transaction = await filledGasPayment(transaction);
  final transactionDigest = transaction.serializeSign();

  final signature = account.signTransaction(transactionDigest);
  final r = await excuteTx(tx: transaction, signatures: [signature]);
  assert(r.effects?.status.status == SuiApiExecutionStatusType.success,
      r.effects?.status.error);

  /// https://suiscan.xyz/devnet/tx/5zjgD2SzRYqvXWbseJEa4ZmpATLFCSVe2Xpv6eoXc23J
}

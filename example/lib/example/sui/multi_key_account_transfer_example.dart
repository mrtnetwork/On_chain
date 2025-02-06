import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  SuiSecp256r1PrivateKey getKeySecp256r1(int fill) {
    return SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, fill));
  }

  SuiED25519PrivateKey getKeyED25519(int fill) {
    return SuiED25519PrivateKey.fromBytes(List<int>.filled(32, fill));
  }

  SuiSecp256k1PrivateKey getKeySecp256k1(int fill) {
    return SuiSecp256k1PrivateKey.fromBytes(List<int>.filled(32, fill));
  }

  SuiMultisigAccount getAccount() {
    final key1 = getKeySecp256r1(12);
    final key2 = getKeyED25519(13);
    final key3 = getKeySecp256k1(14);
    final key4 = getKeyED25519(15);
    final multisigPubkey = SuiMultisigAccountPublicKey(publicKeys: [
      SuiMultisigPublicKeyInfo(publicKey: key1.publicKey, weight: 2),
      SuiMultisigPublicKeyInfo(publicKey: key2.publicKey, weight: 3),
      SuiMultisigPublicKeyInfo(publicKey: key3.publicKey, weight: 2),
      SuiMultisigPublicKeyInfo(publicKey: key4.publicKey, weight: 1)
    ], threshold: 7);
    return SuiMultisigAccount(
        privateKeys: [key1, key2, key3, key4], publicKey: multisigPubkey);
  }

  final account = getAccount();
  final splitCoins = SuiCommandSplitCoins(
      amounts: [SuiArgumentInput(0)], coin: SuiArgumentGasCoin());
  final amountInput = SuiCallArgPure.sui("0.0001");

  final receipmentInput = SuiAddress(
      "0xcc214af0483b39c446690f19ae2da8ce703f52239ff94fd42553ceb48c4dda3d");
  final transfer = SuiCommandTransferObjects(objects: [
    SuiArgumentNestedResult(commandIndex: 0, resultIndex: 0),
  ], address: SuiArgumentInput(1));
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
        receipmentInput,
      ], commands: [
        splitCoins,
        transfer,
      ])));
  transaction = await dryRunTx(transaction);
  transaction = await filledGasPayment(transaction);
  final transactionDigest = transaction.serializeSign();

  final signature = account.signTransaction(transactionDigest);
  final r = await excuteTx(tx: transaction, signatures: [signature]);
  assert(r.effects?.status.status == SuiApiExecutionStatusType.success,
      r.effects?.status.error);

  /// https://suiscan.xyz/devnet/tx/2AH7X9bnzi3Fq5UBEiZXmZTJJRT3b8d7aPT3xqnDUJiA
}

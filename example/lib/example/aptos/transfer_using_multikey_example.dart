import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  AptosMultiKeyAccount getAccount() {
    final privateKey1 =
        AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 12));
    final privateKey2 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));

    return AptosMultiKeyAccount(
        privateKeys: [privateKey1, privateKey2],
        publicKey: AptosMultiKeyAccountPublicKey(publicKeys: [
          privateKey1.publicKey,
          privateKey2.publicKey,
        ], requiredSignature: 2));
  }

  final recipient = AptosAddress(
      "0x89dd43dcedf165f975202fae5f8aecf03013ebc14bb3c09a1431313b4ee52b02");
  final account = getAccount();
  final transactionPayload = AptosTransactionPayloadEntryFunction(
      entryFunction: AptosTransactionEntryFunction(
          moduleId: AptosModuleId(address: AptosAddress.one, name: "coin"),
          functionName: 'transfer',
          typeArgs: [
        AptosTypeTagStruct(AptosStructTag(
            address: AptosAddress.one,
            moduleName: "aptos_coin",
            name: "AptosCoin"))
      ],
          args: [
        recipient,
        MoveU64.aptos("0.0001")
      ]));
  final gasUnitPrice = await gasEstimate();
  final sequenceNumber = await getAccountSequence(account.toAddress());
  final chainId = await getChainId();
  final expire =
      DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch ~/
          1000;
  final transaction = AptosRawTransaction(
      sender: account.toAddress(),
      sequenceNumber: sequenceNumber,
      transactionPayload: transactionPayload,
      maxGasAmount: BigInt.from(200000),
      gasUnitPrice: gasUnitPrice,
      expirationTimestampSecs: BigInt.from(expire),
      chainId: chainId);
  final authenticator = account.signWithAuth(transaction.signingSerialize());
  final signedTx = AptosSignedTransaction(
      rawTransaction: transaction,
      authenticator: AptosTransactionAuthenticatorSignleSender(authenticator));
  await submitTransaction(signedTx);

  /// https://explorer.aptoslabs.com/txn/0x315cde98b8a76bda21010f2049bbb5c1002ed7e10d54c97e1b663d810a52cbb0?network=testnet
}

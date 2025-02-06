import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  AptosMultiEd25519Account getAccount() {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final privateKey2 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13));
    final privateKey3 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 15));
    return AptosMultiEd25519Account(
        privateKeys: [
          privateKey1,
          privateKey2,
          privateKey3,
        ],
        publicKey: AptosMultiEd25519AccountPublicKey(publicKeys: [
          privateKey1.publicKey,
          privateKey2.publicKey,
          privateKey3.publicKey
        ], threshold: 2));
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
  await simulate(signedTx);

  /// https://explorer.aptoslabs.com/txn/0xec94e9f968a5534826626de0a3c7037e19d161dd9fec729ca580c854b9433dd9?network=testnet
}

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

  AptosEd25519Account getPayerAccount() {
    return AptosEd25519Account(
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12)));
  }

  final recipient = AptosAddress(
      "0x89dd43dcedf165f975202fae5f8aecf03013ebc14bb3c09a1431313b4ee52b02");
  final account = getAccount();
  final payerAccount = getPayerAccount();
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
  final signingDigest =
      transaction.signingSerialize(feePayerAddress: payerAccount.toAddress());
  final authenticator = account.signWithAuth(signingDigest);
  final payerAuthenticator = payerAccount.signWithAuth(signingDigest);
  final signedTx = AptosSignedTransaction(
      rawTransaction: transaction,
      authenticator: AptosTransactionAuthenticatorFeePayer(
          sender: authenticator,
          feePayerAuthenticator: payerAuthenticator,
          feePayerAddress: payerAccount.toAddress()));
  await simulate(signedTx);

  /// https://explorer.aptoslabs.com/txn/0x496884cf2aa8d2b47b17351a695edc996884dee7398f97e60e4bfa18d2575c21?network=testnet
}

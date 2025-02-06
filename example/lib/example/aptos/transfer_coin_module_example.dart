import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  AptosEd25519Account getAccount() {
    return AptosEd25519Account(
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12)));
  }

  AptosSingleKeyAccount getRecipient() {
    final account =
        AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 12));
    return AptosSingleKeyAccount(account);
  }

  final recipient = getRecipient();
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
        recipient.toAddress(),
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
      authenticator: AptosTransactionAuthenticatorEd25519(
          publicKey: authenticator.publicKey,
          signature: authenticator.signature));
  await simulate(signedTx);
}

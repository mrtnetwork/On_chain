import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  AptosEd25519Account getCurrentAccountAuthenticator() {
    final account = AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 44));
    return AptosEd25519Account(account);
  }

  AptosEd25519Account getNewAccountAuthenticator() {
    final account = AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 45));
    return AptosEd25519Account(account);
  }

  final currentAccountAuthenticator = getCurrentAccountAuthenticator();
  final newAccountAuthenticator = getNewAccountAuthenticator();
  final accountInfo =
      await getAccountInfo(currentAccountAuthenticator.publicKey.toAddress());
  final challange = RotationProofChallenge(
      orginator: currentAccountAuthenticator.publicKey.toAddress(),
      currentAuthKey: AptosAddress(accountInfo.authenticationKey),
      newPublicKey: newAccountAuthenticator.publicKey,
      sequenceNumber: accountInfo.sequenceNumber);
  final bytes = challange.toBcs();
  final currentAccountSignature = currentAccountAuthenticator.sign(bytes);
  final newAccountSignature = newAccountAuthenticator.sign(bytes);
  final transactionPayload = AptosTransactionPayloadEntryFunction(
      entryFunction: AptosTransactionEntryFunction(
          moduleId: AptosModuleId(address: AptosAddress.one, name: "account"),
          functionName: 'rotate_authentication_key',
          typeArgs: [],
          args: [
        MoveU8(currentAccountAuthenticator.scheme.value),
        MoveU8Vector(currentAccountAuthenticator.publicKey.toBytes()),
        MoveU8(newAccountAuthenticator.scheme.value),
        MoveU8Vector(newAccountAuthenticator.publicKey.toBytes()),
        MoveU8Vector(currentAccountSignature.signatureBytes()),
        MoveU8Vector(newAccountSignature.signatureBytes()),
      ]));
  final gasUnitPrice = await gasEstimate();
  final sequenceNumber = await getAccountSequence(
      currentAccountAuthenticator.publicKey.toAddress());
  final chainId = await getChainId();
  final expire =
      DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch ~/
          1000;
  final rawTransaction = AptosRawTransaction(
      sender: currentAccountAuthenticator.publicKey.toAddress(),
      sequenceNumber: sequenceNumber,
      transactionPayload: transactionPayload,
      maxGasAmount: BigInt.from(200000),
      gasUnitPrice: gasUnitPrice,
      expirationTimestampSecs: BigInt.from(expire),
      chainId: chainId);
  final signature = currentAccountAuthenticator
      .signWithAuth(rawTransaction.signingSerialize());
  final authenticator = AptosTransactionAuthenticatorSignleSender(signature);
  final signedTransaction = AptosSignedTransaction(
      rawTransaction: rawTransaction, authenticator: authenticator);
  await submitTransaction(signedTransaction);

  /// https://explorer.aptoslabs.com/txn/0xec00544f9957f3130f0142a28707d6a2c1c9bd0717e1a8c18195efdd39463e02?network=testnet
}

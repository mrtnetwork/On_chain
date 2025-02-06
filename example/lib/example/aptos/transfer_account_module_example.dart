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
          moduleId:
              AptosModuleId(address: AptosAddress.one, name: "aptos_account"),
          functionName: 'transfer',
          typeArgs: [],
          args: [recipient.toAddress(), MoveU64.aptos("0.001")]));
  final gasUnitPrice = await gasEstimate();
  final sequenceNumber = await getAccountSequence(account.toAddress());
  final chainId = await getChainId();
  final expire =
      DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch ~/
          1000;
  final tx = AptosRawTransaction(
      sender: account.toAddress(),
      sequenceNumber: sequenceNumber,
      transactionPayload: transactionPayload,
      maxGasAmount: BigInt.from(200000),
      gasUnitPrice: gasUnitPrice,
      expirationTimestampSecs: BigInt.from(expire),
      chainId: chainId);

  final authenticator = account.signWithAuth(tx.signingSerialize());
  final signedTx = AptosSignedTransaction(
      rawTransaction: tx,
      authenticator: AptosTransactionAuthenticatorEd25519(
          publicKey: authenticator.publicKey,
          signature: authenticator.signature));
  await simulate(signedTx);

  /// https://explorer.aptoslabs.com/txn/0xeeb34e1318db474aeff5a9d43d53a0203936346cb63e4731c9d75e18798d0501?network=testnet
}

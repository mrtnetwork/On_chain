import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  AptosEd25519Account getAccount() {
    return AptosEd25519Account(
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12)));
  }

  final recipient1 = AptosAddress(
      "0x89dd43dcedf165f975202fae5f8aecf03013ebc14bb3c09a1431313b4ee52b02");
  final recipient2 = AptosAddress(
      "0xf9761c71494a2c4e3f989302f68ed03f83cd521dc1c22441fcc1aee4b324723d");
  final account = getAccount();
  final transactionPayload = AptosTransactionPayloadEntryFunction(
      entryFunction: AptosTransactionEntryFunction(
          moduleId:
              AptosModuleId(address: AptosAddress.one, name: "aptos_account"),
          functionName: 'batch_transfer',
          typeArgs: [],
          args: [
        MoveVector<AptosAddress>([recipient1, recipient2]),
        MoveVector<MoveU64>([MoveU64.aptos("0.0001"), MoveU64.aptos("0.0002")])
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
  await submitTransaction(signedTx);

  /// https://explorer.aptoslabs.com/txn/0x392868c085edc7ee6e260996e235190d320d38b28eaa8a28e23a52f1362d66d5?network=testnet
}

import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  /// account authenticator has been updated in `update_account_authenticator_example` example
  final AptosAddress accountAddress = AptosAddress(
      "0xe967d28084eb10aee565c5f0fa2f60acb7f4476ab834475cead309d773b699f7");

  AptosEd25519Account getNewAccountAuthenticator() {
    final account = AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 45));
    return AptosEd25519Account(account);
  }

  final AptosAccount accountAuthenticator = getNewAccountAuthenticator();

  final recipient = AptosAddress(
      "0x89dd43dcedf165f975202fae5f8aecf03013ebc14bb3c09a1431313b4ee52b02");
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
  final sequenceNumber = await getAccountSequence(accountAddress);
  final chainId = await getChainId();
  final expire =
      DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch ~/
          1000;
  final transaction = AptosRawTransaction(
      sender: accountAddress,
      sequenceNumber: sequenceNumber,
      transactionPayload: transactionPayload,
      maxGasAmount: BigInt.from(200000),
      gasUnitPrice: gasUnitPrice,
      expirationTimestampSecs: BigInt.from(expire),
      chainId: chainId);
  final authenticator =
      accountAuthenticator.signWithAuth(transaction.signingSerialize());
  final signedTx = AptosSignedTransaction(
      rawTransaction: transaction,
      authenticator: AptosTransactionAuthenticatorSignleSender(authenticator));
  await simulate(signedTx);

  /// https://explorer.aptoslabs.com/txn/0xca98b094a215b68c1d1ef8f6a27111b9a6975b9ea7634a8323c3b40676855907?network=testnet
}

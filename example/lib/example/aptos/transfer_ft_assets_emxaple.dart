import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  /// the token created in `publish_ft_token_module_example` and minted in `mint_token_example` example.
  AptosEd25519Account getAccount() {
    final account = AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 36));
    return AptosEd25519Account(account);
  }

  final account = getAccount();
  final recipient = AptosAddress(
      "0x89dd43dcedf165f975202fae5f8aecf03013ebc14bb3c09a1431313b4ee52b02");
  final transactionPayload = AptosTransactionPayloadEntryFunction(
      entryFunction: AptosTransactionEntryFunction(
          moduleId: AptosModuleId(
              address: AptosAddress.one, name: "primary_fungible_store"),
          functionName: 'transfer',
          typeArgs: [
        AptosTypeTagStruct(AptosStructTag(
            address: AptosAddress.one,
            moduleName: "fungible_asset",
            name: "Metadata"))
      ],
          args: [
        AptosAddress(
            "0xad9e9d7ed3971180feed99db879adf99c4516f0a749b9f5903f26afd0fcb52aa"),
        recipient,
        MoveU64(BigInt.from(10)),
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
  final serializeSign = transaction.signingSerialize();
  final authenticator = account.signWithAuth(serializeSign);
  final signedTx = AptosSignedTransaction(
      rawTransaction: transaction,
      authenticator: AptosTransactionAuthenticatorEd25519(
          publicKey: authenticator.publicKey,
          signature: authenticator.signature));
  await simulate(signedTx);

  /// https://explorer.aptoslabs.com/txn/0xafb3c380d3d53e9fe29ecc3e780beb2b07b0f04713efed4b0cda16f2bf423736?network=testnet
}

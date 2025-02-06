import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  /// the token created in `publish_ft_token_module_example` example
  AptosEd25519Account getAccount() {
    final account = AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 36));
    return AptosEd25519Account(account);
  }

  final account = getAccount();

  final transactionPayload = AptosTransactionPayloadEntryFunction(
      entryFunction: AptosTransactionEntryFunction(
          moduleId: AptosModuleId(address: account.toAddress(), name: "dog"),
          functionName: 'mint',
          args: [account.toAddress(), MoveU64(BigInt.from(100000))]));
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

  /// https://explorer.aptoslabs.com/txn/0xf2e42c3bdff11f28c0e21884c9378cb20ac947880ca447d073c27b8cbc6a5a1b?network=testnet
}

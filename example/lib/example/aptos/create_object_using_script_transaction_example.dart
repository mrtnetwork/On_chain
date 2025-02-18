import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  AptosSingleKeyAccount getAccount() {
    final account =
        AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 25));
    return AptosSingleKeyAccount(account);
  }

  final sender = getAccount();
  const script =
      "0xa11ceb0b060000000601000402040403080a051209071b3608512000000001000302000102000200000402030001060c000105010800066f626a656374067369676e65720a616464726573735f6f660e436f6e7374727563746f725265660d6372656174655f6f626a6563740000000000000000000000000000000000000000000000000000000000000001000001050b00110011010102";
  final transactionPayload = AptosTransactionPayloadScript(
      script: AptosScript(
          byteCode: BytesUtils.fromHexString(script),
          typeArgs: [],
          arguments: []));
  final gasUnitPrice = await gasEstimate();
  final sequenceNumber = await getAccountSequence(sender.publicKey.toAddress());
  final chainId = await getChainId();
  final expire =
      DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch ~/
          1000;
  final transaction = AptosRawTransaction(
      sender: sender.publicKey.toAddress(),
      sequenceNumber: sequenceNumber,
      transactionPayload: transactionPayload,
      maxGasAmount: BigInt.from(200000),
      gasUnitPrice: gasUnitPrice,
      expirationTimestampSecs: BigInt.from(expire),
      chainId: chainId);
  final authenticator = sender.signWithAuth(transaction.signingSerialize());
  final signedTx = AptosSignedTransaction(
      rawTransaction: transaction,
      authenticator: AptosTransactionAuthenticatorSignleSender(authenticator));
  await submitTransaction(signedTx);

  /// https://explorer.aptoslabs.com/txn/0x9fc9c8bc59b7897a549ac39562393924cf1da916c1f91ade52261c9239dcca3a/changes?network=testnet
}

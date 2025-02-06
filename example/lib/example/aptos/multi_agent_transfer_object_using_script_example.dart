import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  AptosSingleKeyAccount getRecipient() {
    final account = AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 26));
    return AptosSingleKeyAccount(account);
  }

  AptosSingleKeyAccount getAccount() {
    final account =
        AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 25));
    return AptosSingleKeyAccount(account);
  }

  final sender = getAccount();
  final recipient = getRecipient();
  const String script =
      "0xa11ceb0b060000000701000602060a031017042706052d2d075a4b08a5012000000001000201030701000101040800020503040000060602010001070408010801060902010801050207030704060c060c0503010b000108010001060c010501090003060c0503010801010b0001090003060c0b000109000504636f696e066f626a656374067369676e6572064f626a6563740a4f626a656374436f72650a616464726573735f6f66087472616e7366657211616464726573735f746f5f6f626a6563740000000000000000000000000000000000000000000000000000000000000001010000010e0a010a0011000b0338000b0238010c040b000b040b011100380202";
  final AptosAddress objectAddress = AptosAddress(
      "0x25bee59257280e4361b733d2cf9f320a1a8e2e5a6e760a79875f9dfcab05a0b0");
  final transactionPayload = AptosTransactionPayloadScript(
      script:
          AptosScript(byteCode: BytesUtils.fromHexString(script), typeArgs: [
    AptosTypeTagStruct(AptosStructTag(
        address: AptosAddress("0x1"),
        moduleName: 'aptos_coin',
        name: 'AptosCoin'))
  ], arguments: [
    objectAddress,
    MoveU64(BigInt.from(100))
  ]));
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
  final digest = transaction.signingSerialize(
      secondarySignerAddresses: [recipient.publicKey.toAddress()]);
  final authenticator = sender.signWithAuth(digest);
  final recipientAuthenticator = recipient.signWithAuth(digest);
  final txauthenticator = AptosTransactionAuthenticatorMultiAgent(
      sender: authenticator,
      secondarySigner: [recipientAuthenticator],
      secondarySignerAddressess: [recipient.publicKey.toAddress()]);
  final signedTx = AptosSignedTransaction(
      rawTransaction: transaction, authenticator: txauthenticator);
  await simulate(signedTx);

  /// https://explorer.aptoslabs.com/txn/0xd23a797626830900976b198fcbce513ddd439ac9b3e8240630fdaee3a0feb42b?network=testnet
}

import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

/// For commonly used transactions such as Tron sending, account update,
/// and smart contract interactions, the provider is configured to automatically
/// generate the transaction upon receiving information from Tron. If your desired
/// transaction doesn't leverage this feature, you can manually create the transaction using the following steps.
///
/// I recommend employing this approach for all transactions, reserving the use of the API solely for transaction confirmation
void main() async {
  final mnemonic =
      Bip39MnemonicGenerator().fromWordsNumber(Bip39WordsNum.wordsNum24);
  final seed = Bip39SeedGenerator(mnemonic).generate();

  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final prv = TronPrivateKey.fromBytes(bip44.privateKey.raw);
  final publicKey = prv.publicKey();
  final address = publicKey.toAddress();

  final receiverAddress = TronAddress("TF3cDajEAaJ8jFXFB2KF3XSUbTpZWzuSrp");
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  /// create contract (i use TransferContract)
  final contract = TransferContract(
      amount: TronHelper.toSun("0.1"),
      ownerAddress: address,
      toAddress: receiverAddress);
  final parameter = Any(typeUrl: contract.typeURL, value: contract);
  final transactionContract =
      TransactionContract(type: contract.contractType, parameter: parameter);
  final block = await rpc.request(TronRequestGetNowBlock());

  /// maximum 24H
  final expireTime = DateTime.now().toUtc().add(const Duration(hours: 12));
  final rawTr = TransactionRaw(
      refBlockBytes: block.blockHeader.rawData.refBlockBytes,
      refBlockHash: block.blockHeader.rawData.refBlockHash,
      expiration: BigInt.from(expireTime.millisecondsSinceEpoch),
      // 10 TRX
      feeLimit: TronHelper.toSun("10"),

      /// memo
      data: utf8.encode("https://github.com/mrtnetwork"),
      contract: [transactionContract],
      timestamp: block.blockHeader.rawData.timestamp);

  // txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = prv.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  /// get raw data buffer
  final raw = BytesUtils.toHexString(transaction.toBuffer());

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: raw));

  /// https://shasta.tronscan.org/#/transaction/67f182a16da81473ff4410e6d0d4e84acd385bb279674fb3e1e6c7c1d32c7a06
}

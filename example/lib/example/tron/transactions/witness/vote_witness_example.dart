import 'dart:convert';
import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

/// For commonly used transactions such as Tron sending, account update,
/// and smart contract interactions, the provider is configured to automatically
/// generate the transaction upon receiving information from Tron. If your desired
/// transaction doesn't leverage this feature, you can manually create the transaction using the following steps.

void main() async {
// 102
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final prv = TronPrivateKey.fromBytes(bip44.privateKey.raw);
  final publicKey = prv.publicKey();
  final address = publicKey.toAddress();
  // print(address);
  // return;
  // final receiverAddress = TronAddress("TF3cDajEAaJ8jFXFB2KF3XSUbTpZWzuSrp");
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));
  final resource =
      await rpc.request(TronRequestGetAccountResource(address: address));

  /// get account votes
  final myVotes = resource.howManyVote;
  if (myVotes == 0) return;

  /// get list of witnesses
  final witnesses = await rpc.request(TronRequestListWitnesses());

  /// create contract
  final contract = VoteWitnessContract(ownerAddress: address, votes: [
    VoteWitnessContractVote(
      voteAddress: witnesses[0].address,
      voteCount: BigInt.from(1),
    ),
    VoteWitnessContractVote(
      voteAddress: witnesses[2].address,
      voteCount: BigInt.from(1),
    ),
    VoteWitnessContractVote(
      voteAddress: witnesses[3].address,
      voteCount: BigInt.from(1),
    ),
    VoteWitnessContractVote(
      voteAddress: witnesses[4].address,
      voteCount: BigInt.from(1),
    ),
  ]);
  final parameter = Any(typeUrl: contract.typeURL, value: contract);
  final transactionContract =
      TransactionContract(type: contract.contractType, parameter: parameter);
  final block = await rpc.request(TronRequestGetNowBlock());

  /// maximum 24H
  final expireTime = DateTime.now().toUtc().add(const Duration(hours: 12));
  TransactionRaw rawTr = TransactionRaw(
      refBlockBytes: block.blockHeader.rawData.refBlockBytes,
      refBlockHash: block.blockHeader.rawData.refBlockHash,
      expiration: BigInt.from(expireTime.millisecondsSinceEpoch),
      // 10 TRX
      feeLimit: TronHelper.toSun("10"),

      /// memo
      data: utf8.encode("https://github.com/mrtnetwork"),
      contract: [transactionContract],
      timestamp: block.blockHeader.rawData.timestamp);

  /// ok now we want to calculate fee limit before signing
  /// i create fake transaction to get size of tr
  /// in this case transaction is not multi-sig address and we just need one signature
  /// i add 65byte empty bytes to transaction beacuse each signature has fixed 65 bytes
  /// signer * 65 bytes (1 * 65)
  final fakeTr = Transaction(rawData: rawTr, signature: [Uint8List(65)]);

  /// transaction Size
  /// ok we now how much bandwidth need
  final trSize = fakeTr.length + 64;
  int needBandiwdth = trSize;

  /// ok now we got network parameters
  final chainParams = await rpc.request(TronRequestGetChainParameters());

  /// ok we got chain param and now  we need accounts resource
  final ownerAccountResource =
      await rpc.request(TronRequestGetAccountResource(address: address));

  /// total burn (transaction fee)
  int totalBurnInSun = 0;

  /// if we have note (memo) we calculate memo foo
  /// in this case we have note ("https://github.com/mrtnetwork")
  if (rawTr.data != null) {
    totalBurnInSun += chainParams.getMemoFee!;
  }

  /// for transfer trx we dont need anything but some special transaction has special values for fee
  /// 1. Issue a TRC10 token: 1,024 TRX
  /// 2. Apply to be an SR candidate: 9,999 TRX
  /// 3. Create a Bancor transaction: 1,024 TRX
  /// 4. Update the account permission: 100 TRX
  /// 5. Activate the account: 1 TRX (used in this transaction)
  /// 6. Multi-sig transaction: 1 TRX
  /// 7. Transaction note: 1 TRX (used in this transaction)

  /// ok now we need to reduce bandwidth with account bandwidth
  /// how much account have bandwidth
  final BigInt accountBandWidth = ownerAccountResource.howManyBandwIth;

  /// Only when we have the total bandwidth in our account, we will set the total amount of bandwidth to zero
  if (accountBandWidth >= BigInt.from(needBandiwdth)) {
    needBandiwdth = 0;
  }

  /// ok now we must add to total burn
  if (needBandiwdth > 0) {
    totalBurnInSun += needBandiwdth * chainParams.getTransactionFee!;
  }

  /// now we replace transaction fee limit with total burn
  rawTr = rawTr.copyWith(feeLimit: BigInt.from(totalBurnInSun));

  // txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = prv.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: transaction.toHex));

  /// https://shasta.tronscan.org/#/transaction/847d9cd34e76766ab93e93f7d6bd89e4530ca530e251d76909d81252ae32204b
}

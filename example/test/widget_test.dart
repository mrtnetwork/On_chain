void main() async {
  // final seed = BytesUtils.fromHexString(
  //     "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  // final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  // final prv = TronPrivateKey.fromBytes(bip44.privateKey.raw);
  // final publicKey = prv.publicKey();
  // final address = publicKey.toAddress();
  // final receiverAddress = TronAddress("TF3cDajEAaJ8jFXFB2KF3XSUbTpZWzuSrp");
  // final rpc =
  //     TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));
  // final block = await rpc.request(TronRequestGetNowBlock());

  // /// create contract (i use TransferContract)
  // final contract = TransferContract(
  //     amount: TronHelper.toSun("1"),
  //     ownerAddress: address,
  //     toAddress: receiverAddress);
  // final parameter = Any(typeUrl: contract.typeURL, value: contract);
  // final transactionContract =
  //     TransactionContract(type: contract.contractType, parameter: parameter);

  // /// maximum 24H
  // final expireTime = DateTime.now().toUtc().add(const Duration(hours: 12));
  // TransactionRaw rawTr = TransactionRaw(
  //     refBlockBytes: block.blockHeader.rawData.refBlockBytes,
  //     refBlockHash: block.blockHeader.rawData.refBlockHash,
  //     expiration: BigInt.from(expireTime.millisecondsSinceEpoch),
  //     // 10 TRX
  //     feeLimit: TronHelper.toSun("10"),

  //     /// memo
  //     data: utf8.encode("https://github.com/mrtnetwork"),
  //     contract: [transactionContract],
  //     timestamp: block.blockHeader.rawData.timestamp);

  // /// ok now we want to calculate fee limit before signing
  // /// i create fake transaction to get size of tr
  // /// in this case transaction is not multi-sig address and we just need one signature
  // /// i add 65byte empty bytes to transaction beacuse each signature has fixed 65 bytes
  // /// signer * 65 bytes (1 * 65)
  // final fakeTr = Transaction(rawData: rawTr, signature: [Uint8List(65)]);

  // /// transaction Size
  // /// ok we now how much bandwidth need
  // final trSize = fakeTr.length + 64;
  // int needBandiwdth = trSize;

  // /// we does not need energy (energy its only for smart contract and u can see in smart contract calculate fee example)
  // // ignore: unused_local_variable
  // final int? energyNeed;

  // /// sometimes when we want to send transaction to not active account, netwokr has required bandwidth for burn and
  // /// this cannot reduce with account bandwidth
  // int needBandWidthToBurn = 0;

  // /// ok now we got network parameters
  // final chainParams = await rpc.request(TronRequestGetChainParameters());

  // /// ok we got chain param and now  we need accounts resource
  // final ownerAccountResource =
  //     await rpc.request(TronRequestGetAccountResource(address: address));

  // /// ok we have owner account resource and now we got receiver account details for its active or not
  // /// in this case if accountIsActive is null, its mean account does not active
  // final accountIsActive =
  //     await rpc.request(TronRequestGetAccount(address: receiverAddress));

  // /// total burn (transaction fee)
  // int totalBurnInSun = 0;

  // /// ok in this case we calculate how much need for new account
  // if (accountIsActive == null) {
  //   needBandWidthToBurn += chainParams.getCreateNewAccountFeeInSystemContract!;
  //   totalBurnInSun += chainParams.getCreateAccountFee!;
  // }

  // /// if we have note (memo) we calculate memo foo
  // /// in this case we have note ("https://github.com/mrtnetwork")
  // if (rawTr.data != null) {
  //   totalBurnInSun += chainParams.getMemoFee!;
  // }

  // /// for transfer trx we dont need anything but some special transaction has special values for
  // /// 1. Issue a TRC10 token: 1,024 TRX
  // /// 2. Apply to be an SR candidate: 9,999 TRX
  // /// 3. Create a Bancor transaction: 1,024 TRX
  // /// 4. Update the account permission: 100 TRX
  // /// 5. Activate the account: 1 TRX (used in this transaction)
  // /// 6. Multi-sig transaction: 1 TRX
  // /// 7. Transaction note: 1 TRX (used in this transaction)

  // /// ok now we need to reduce bandwidth with account bandwidth
  // /// how much account have bandwidth
  // final BigInt accountBandWidth = ownerAccountResource.howManyBandwIth;

  // /// Only when we have the total bandwidth in our account, we will set the total amount of bandwidth to zero
  // if (accountBandWidth >= BigInt.from(needBandiwdth)) {
  //   needBandiwdth = 0;
  // }

  // /// ok now we must add to total burn
  // if (needBandiwdth > 0) {
  //   totalBurnInSun += needBandiwdth * chainParams.getTransactionFee!;
  // }
  // if (needBandWidthToBurn > 0) {
  //   totalBurnInSun += needBandWidthToBurn * chainParams.getTransactionFee!;
  // }

  // /// now we replace transaction fee limit with total burn
  // rawTr = rawTr.copyWith(feeLimit: BigInt.from(totalBurnInSun));

  // // txID
  // final _ = rawTr.txID;

  // /// get transaaction digest and sign with private key
  // final sign = prv.sign(rawTr.toBuffer());
  // print("sig ${sign.length}");
  // return;

  // /// create transaction object and add raw data and signature to this
  // final transaction = Transaction(rawData: rawTr, signature: [sign]);

  // /// get raw data buffer
  // final raw = BytesUtils.toHexString(transaction.toBuffer());

  // /// send transaction to network
  // await rpc.request(TronRequestBroadcastHex(transaction: raw));

  // /// https://shasta.tronscan.org/#/transaction/a7f39b66145aa2dd14f03557000e069230c91f60e46cc7b516ab00f87a854c31
}

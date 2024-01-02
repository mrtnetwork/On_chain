import 'dart:convert';
import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

import 'trc20_abi.dart';

// The cost of Tron transactions is determined by Bandwidth and Energy.
// Transactions involving smart contracts necessitate both bandwidth and energy,
// whereas transactions unrelated to smart contracts only require bandwidth.
// Bandwidth calculation involves the transaction size, signature (65 bytes)
// multiplied by the number of signers (for non-multisignature transactions, it is always 65 bytes),
// plus an additional 65 bytes.

// For all transactions, bandwidth is a factor, with only a few exceptions requiring a fixed amount and bandwidth.
// For instance, sending Tron to an inactive account incurs an
// additional one Tron as a transaction fee. Similarly, updating an account costs 100 Tron,
// and certain other contracts follow similar patterns.
// in this example i show you how to calculate bandwidth and energy for smart contract transactions
/// 1. Issue a TRC10 token: 1,024 TRX
/// 2. Apply to be an SR candidate: 9,999 TRX
/// 3. Create a Bancor transaction: 1,024 TRX
/// 4. Update the account permission: 100 TRX
/// 5. Activate the account: 1 TRX
/// 6. Multi-sig transaction: 1 TRX
/// 7. Transaction note: 1 TRX
///
void main() async {
  /// intialize private key, address, receiver and ....
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final ownerPrivateKey = TronPrivateKey.fromBytes(bip44.privateKey.raw);
  final ownerPublicKey = ownerPrivateKey.publicKey();
  final ownerAddress = ownerPublicKey.toAddress();
  final receiverAddress =
      TronPrivateKey.fromBytes(bip44.deriveDefaultPath.privateKey.raw)
          .publicKey()
          .toAddress();

  /// intialize shasta http provider to send and receive requests
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  /// get chain paramets
  final chainParameters = await rpc.request(TronRequestGetChainParameters());
  final bandWidthInSun = chainParameters.getTransactionFee!;
  final energyInSun = chainParameters.getEnergyFee!;

  int bandWidthNeed = 0;
  int energyNeed = 0;

  final contract = ContractABI.fromJson(trc20Abi, isTron: true);

  final function = contract.functionFromName("transfer");

  /// address /// amount
  final transferparams = [receiverAddress, BigInt.from(10000000000)];

  final contractAddress = TronAddress("TPVyWcQ6JERNnX2AaPwSSk9JkDhPXsUfg5");

  final request = await rpc.request(
    TronRequestTriggerConstantContract(
      ownerAddress: ownerAddress,
      contractAddress: contractAddress,
      data: function.encodeHex(transferparams),

      /// call witn trx value
      callValue: null,

      /// call with tc10 token
      callTokenValue: null,
      tokenId: null,
    ),
  );
  if (!request.isSuccess) {
    /// print("${request.error} \n ${request.respose}");
    return;
  }
  energyNeed = request.energyUsed!;

  /// get transactionRaw from response and make sure set fee limit
  TransactionRaw rawTr = request.transactionRaw!.copyWith(

      /// for fake tr we see fee limit to max
      /// for g
      feeLimit: TronHelper.toSun("25"),
      data: utf8.encode("https://github.com/mrtnetwork"));

  /// fake tr for calculate current fee before signing
  /// we us 1 signature becuse this transaction is not multi-sig
  final fakeTr = Transaction(rawData: rawTr, signature: [Uint8List(65)]);

  /// len of transacation
  final trSize = fakeTr.length + 64;

  /// append to bandwidth need
  bandWidthNeed += trSize;

  /// get account resource to check account bandwidth and enrgy
  final accountResource =
      await rpc.request(TronRequestGetAccountResource(address: ownerAddress));

  energyNeed -= accountResource.howManyEnergy.toInt();

  if (accountResource.howManyBandwIth > BigInt.from(bandWidthNeed)) {
    bandWidthNeed = 0;
  }

  if (energyNeed < 0) {
    energyNeed = 0;
  }

  final energyBurn = energyNeed * energyInSun.toInt();

  final bandWidthBurn = bandWidthNeed * bandWidthInSun;

  int totalBurn = energyBurn + bandWidthBurn;

  /// special contract fee
  /// for contract transcation we just need to check account receiver is active or not and check if we hame memo
  /// i add memo to transaction
  totalBurn += chainParameters.getMemoFee!;

  /// check receivers is active or not
  final receiverAccountInfo =
      await rpc.request(TronRequestGetAccount(address: receiverAddress));

  /// account does not active
  if (receiverAccountInfo == null) {
    totalBurn += chainParameters.getCreateNewAccountFeeInSystemContract!;

    /// new account have extra bandwidth and need to burn
    totalBurn += (chainParameters.getCreateAccountFee! * bandWidthInSun);
  }

  /// ok now we replace transaction with nee fee limit
  /// for tron native contracts(not smart contract) we dont have energy fee only we calculate bandwidth but
  /// some contacts need extra fee
  /// 1. Issue a TRC10 token: 1,024 TRX
  /// 2. Apply to be an SR candidate: 9,999 TRX
  /// 3. Create a Bancor transaction: 1,024 TRX
  /// 4. Update the account permission: 100 TRX
  /// 5. Activate the account: 1 TRX
  /// 6. Multi-sig transaction: 1 TRX
  /// 7. Transaction note: 1 TRX
  rawTr = rawTr.copyWith(feeLimit: BigInt.from(totalBurn));

  /// txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = ownerPrivateKey.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  /// get raw data buffer
  final raw = transaction.toHex;

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: raw));

  /// https://shasta.tronscan.org/#/transaction/16d32cb4ad4847b33006c1042e4f812a3e844c1b794eb07d28d8d47a04c1cff5
}

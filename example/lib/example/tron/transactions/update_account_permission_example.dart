import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  /// intialize private key, address, receiver and ....
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final ownerPrivateKey = TronPrivateKey.fromBytes(bip44.privateKey.raw);
  final ownerPublicKey = ownerPrivateKey.publicKey();
  final ownerAddress = ownerPublicKey.toAddress();

  /// intialize shasta http provider to send and receive requests
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  /// read account permissions
  final accountInfo =
      await rpc.request(TronRequestGetAccount(address: ownerAddress));
  if (accountInfo == null) {
    /// account does not active
    return;
  }

  /// convert to contract owner permission
  final ownerPermission = Permission(

      /// does not need for owner
      id: null,

      /// owner does not need operation ( has all permission)
      operations: null,

      /// signers
      keys: accountInfo.ownerPermission.keys
          .map(
              (e) => TronKey(address: TronAddress(e.address), weight: e.weight))
          .toList(),
      permissionName: accountInfo.ownerPermission.permissionName,
      threshold: accountInfo.ownerPermission.threshold);

  /// convert to actives permission
  final List<Permission> activePermation = accountInfo.activePermissions
      .map((e) => Permission(

          /// does not need
          id: null,

          /// active operations for this permission
          /// for decode operation use TronHelper.decodePermissionOperation
          operations: BytesUtils.fromHexString(e.operations!),

          /// set type for active permission
          /// owner and witness does not need type
          type: PermissionType.active,

          /// signers
          keys: accountInfo.ownerPermission.keys
              .map((e) =>
                  TronKey(address: TronAddress(e.address), weight: e.weight))
              .toList(),
          permissionName: accountInfo.ownerPermission.permissionName,
          threshold: accountInfo.ownerPermission.threshold))
      .toList();

  /// create new active operatio
  /// i initialize two address for this new permission
  final wallet1 = bip44.purpose.coin
      .account(0)
      .change(Bip44Changes.chainExt)
      .addressIndex(2);
  final signer1 =
      TronPrivateKey.fromBytes(wallet1.privateKey.raw).publicKey().toAddress();
  final wallet2 = bip44.purpose.coin
      .account(0)
      .change(Bip44Changes.chainExt)
      .addressIndex(3);
  final signer2 =
      TronPrivateKey.fromBytes(wallet2.privateKey.raw).publicKey().toAddress();

  /// new permision
  activePermation.add(Permission(
      id: null,

      /// set active permission
      type: PermissionType.active,

      /// create operation for this permission to access
      /// i access to this permission for transfer trx and trc10
      operations: TronHelper.encodePermissionOperations([
        TransactionContractType.transferAssetContract,
        TransactionContractType.transferContract
      ]),

      /// I assign 1 weight to each address
      keys: [
        TronKey(address: signer1, weight: BigInt.one),
        TronKey(address: signer2, weight: BigInt.one)
      ],

      /// This transaction necessitates approval from two
      /// distinct thresholds, implying that transactions
      /// under this authorization mandate the involvement and approval of both specified addresses.
      threshold: BigInt.two));

  /// create contract
  final contract = AccountPermissionUpdateContract(
      ownerAddress: ownerAddress,
      actives: activePermation,
      owner: ownerPermission);

  /// validate transacation and got required data like block hash and ....
  final request =
      await rpc.request(TronRequestAccountPermissionUpdate.fromContract(

          /// params: contract and permission ID (multi-sig Transaction)
          contract,
          permissionId: null));

  /// An error has occurred with the request, and we need to investigate the issue to determine what is happening.
  if (!request.isSuccess) {
    /// print(request.error);
    /// print(request.respose);
    return;
  }

  /// get transactionRaw from response and make sure set fee limit
  final rawTr = request.transactionRaw!.copyWith(
      feeLimit: TronHelper.toSun("1027"),
      data: utf8.encode("https://github.com/mrtnetwork"));

  /// txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = ownerPrivateKey.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  /// get raw data buffer
  final raw = BytesUtils.toHexString(transaction.toBuffer());

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: raw));

  /// https://shasta.tronscan.org/#/transaction/a54584eac4862d4210d2fb764c8be971395005d051c10aa89f0e1ab0da717aef
}

import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 406);
  SolAddress blockHash = await owner.recentBlockhash();
  final tableAddress =
      AddressLookupTableProgramUtils.findAddressLookupTableProgram(
          authority: owner.address, recentSlot: BigInt.from(277777145));
  final accountInfo = await QuickWalletForTest.rpc.request(
      SolanaRPCGetAccountInfo(
          account: tableAddress.address,
          encoding: SolanaRPCEncoding.base64));
  final tableAccount = AddressLookupTableAccount.fromBuffer(
      accountData: accountInfo!.toBytesData(),
      accountKey: tableAddress.address);
  final instractuions = tableAccount.addresses
      .map((e) => SystemProgram.transfer(
          layout:
              SystemTransferLayout(lamports: SolanaUtils.toLamports("0.001")),
          from: owner.address,
          to: e))
      .toList();
  final SolanaTransaction transaction = SolanaTransaction(
      instructions: instractuions,
      recentBlockhash: blockHash,
      payerKey: owner.address,
      addressLookupTableAccounts: [tableAccount],
      type: TransactionType.v0);
  transaction.sign([owner.privateKey]);
  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/4Vmux4xb8CxXSX5Lb37h2cYPWRKogkxDn3ZhBkUtik9pLE1RJ3zY7EnMFfx8hDQkbJG8Rzy38rA6B3LAXeXjRyfh?cluster=devnet
}

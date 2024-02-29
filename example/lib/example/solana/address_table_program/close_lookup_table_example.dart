import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 406);
  final account1 = QuickWalletForTest(index: 405);
  SolAddress blockHash = await owner.recentBlockhash();
  final tableAddress =
      AddressLookupTableProgramUtils.findAddressLookupTableProgram(
          authority: owner.address, recentSlot: BigInt.from(277777145));

  final program = AddressLookupTableProgram.closeLookupTable(
      authority: owner.address,
      lookupTable: tableAddress.address,
      recipient: account1.address);

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [program],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.v0);

  transaction.sign([owner.privateKey]);

  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/i8mmgt2YESAdYx6fxGXAjocpvyDoauNVgg2PpLQiC9H9Aj4a9H3HsAdC6V8EtNGgUkJNhkRMeTCGEJKy2gPMgiZ?cluster=devnet
}

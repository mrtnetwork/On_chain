import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 255);
  final nonceAccount = QuickWalletForTest(index: 300);

  SolAddress blockHash = await owner.recentBlockhash();
  final layout = SystemAuthorizeNonceAccountLayout(authorized: owner.address);

  final program = SystemProgram.nonceAuthorize(
      authorizedPubkey: owner.address,
      noncePubKey: nonceAccount.address,
      layout: layout);

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [program],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.v0);

  transaction.sign([owner.privateKey]);

  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/5cAoNCK7REpYJRk2dGKi4mEGwERmUE4dzu9Vs44WsQ1CpdqyCaRfFFL9H8cKA7VtNr2JUbFB2ZJaKnUKoVA3YD8h?cluster=devnet
}

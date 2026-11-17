// ignore_for_file: avoid_print

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';

class QuickWalletForTest {
  factory QuickWalletForTest({int index = 0, bool printAccount = false}) {
    final slp = Bip32Slip10Ed25519.fromSeed(
      BytesUtils.fromHexString(
        '379032751fabd9008d48fa167a07569c917d611e13324b64d709fb57f7608077513b32a97cec9abca3f98cc7448d6f60bf9501d4e505b4453672bb63db5ecd81',
      ),
    ).childKey(Bip32KeyIndex.hardenIndex(index));
    final w = QuickWalletForTest._(
      SolanaPrivateKey.fromBytes(slp.privateKey.toBytes()),
    );
    if (printAccount) {
      print(
        'wallet created with index $index:\n${w.address.address}\n${w.privateKey.seedHex()}\n=========================================',
      );
    }
    return w;
  }
  QuickWalletForTest._(this.privateKey);
  final SolanaPrivateKey privateKey;
  late final SolAddress address = privateKey.publicKey().toAddress();
}

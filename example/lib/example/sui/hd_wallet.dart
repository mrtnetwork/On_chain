// ignore_for_file: unused_local_variable

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';

void main() {
  const passphrase = "MRTNETWORK";
  final mnemonic =
      Bip39MnemonicGenerator().fromWordsNumber(Bip39WordsNum.wordsNum24);
  final seed = Bip39SeedGenerator(mnemonic).generate(passphrase);
  final wallet = Bip44.fromSeed(seed, Bip44Coins.sui);
  final defaultPath = wallet.deriveDefaultPath;
  final address = SuiAddress(defaultPath.publicKey.toAddress);
  final account = SuiEd25519Account(
      SuiED25519PrivateKey.fromBytes(defaultPath.privateKey.raw));
}

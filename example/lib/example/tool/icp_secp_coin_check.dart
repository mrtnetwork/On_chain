import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

void main() {
  const mnemonic =
      'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
  const expected = 'tgzar-4lpln-fq34h-6hxo4-wlm3x-6g3or-6hxvr-d6jbw-ooh2b-lzsw4-aqe';
  final seed = Bip39SeedGenerator(Bip39Mnemonic.fromString(mnemonic)).generate();
  final derived = Bip44.fromSeed(seed, Bip44Coins.internetComputerSecp256k1)
      .deriveDefaultPath;
  print('KDF ${derived.bip32.runtimeType}');
  final pub = List<int>.from(derived.bip32.publicKey.key.toBytes());
  final p = IcpPrincipalAddress.fromPublicKey(
      publicKey: pub, keyType: ICPKeyType.secp256k1);
  print('PRINCIPAL ${p.address}');
  print('COIN_MATCH ${p.address == expected}');

  // r1: convention-only path (no DFINITY reference). Check: derives without
  // throwing on the non-hardened levels and yields a usable key.
  final r1 = Bip44.fromSeed(seed, Bip44Coins.internetComputerSecp256r1)
      .deriveDefaultPath;
  print('R1_KDF ${r1.bip32.runtimeType}');
  final r1pub = List<int>.from(r1.bip32.publicKey.key.toBytes());
  final r1p = IcpPrincipalAddress.fromPublicKey(
      publicKey: r1pub, keyType: ICPKeyType.secp256r1);
  print('R1_PRINCIPAL ${r1p.address}');
}

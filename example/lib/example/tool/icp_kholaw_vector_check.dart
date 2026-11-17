import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

void main() {
  const mnemonic =
      'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
  const path = "m/44'/223'/0'/0/0";
  const expected =
      'tgzar-4lpln-fq34h-6hxo4-wlm3x-6g3or-6hxvr-d6jbw-ooh2b-lzsw4-aqe';

  final seed =
      Bip39SeedGenerator(Bip39Mnemonic.fromString(mnemonic)).generate();

  // 1. Current (broken) config path: plain ed25519 = SLIP-10.
  try {
    final slip10 = Bip32Slip10Ed25519.fromSeed(seed).derivePath(path);
    print('SLIP10_UNEXPECTED_OK ${(slip10).publicKey.key.toBytes().length}');
  } catch (e) {
    print('SLIP10_THROWS $e');
  }

  // 2. Proposed fix: kholaw KDF on the same path + wallet address encoding.
  final kholaw = Bip32KholawEd25519.fromSeed(seed).derivePath(path);
  final pubkey = kholaw.publicKey.key.toBytes();
  final principal = IcpPrincipalAddress.fromPublicKey(
      publicKey: pubkey, keyType: ICPKeyType.ed25519);
  print('KHOLAW_PRINCIPAL ${principal.address}');
  print('PUBKEY_HEX ${BytesUtils.toHexString(pubkey)}');
  print('MATCH ${principal.address == expected}');

  // 3. secp256k1 on the same path (what dfx actually imported).
  final secp = Bip32Slip10Secp256k1.fromSeed(seed).derivePath(path);
  final secPub = secp.publicKey.key.toBytes();
  final secPrincipal = IcpPrincipalAddress.fromPublicKey(
      publicKey: secPub, keyType: ICPKeyType.secp256k1);
  print('SECP_PUBKEY_HEX ${BytesUtils.toHexString(secPub)}');
  print('SECP_PRINCIPAL ${secPrincipal.address}');
  print('SECP_MATCH ${secPrincipal.address == expected}');
}

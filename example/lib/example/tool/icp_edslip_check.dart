import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

void main() {
  const mnemonic =
      'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
  final seed =
      Bip39SeedGenerator(Bip39Mnemonic.fromString(mnemonic)).generate();
  final derived = Bip44.fromSeed(seed, Bip44Coins.internetComputerEd25519Slip)
      .deriveDefaultPath;
  print('KDF ${derived.bip32.runtimeType}');
  final pub = List<int>.from(derived.bip32.publicKey.key.toBytes());
  final p = IcpPrincipalAddress.fromPublicKey(
      publicKey: pub, keyType: ICPKeyType.ed25519);
  print('PRINCIPAL ${p.address}');
  print('PUB_HEX ${BytesUtils.toHexString(pub)}');
}

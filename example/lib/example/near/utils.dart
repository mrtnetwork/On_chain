import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/near.dart';

NearSecretKey getAccountSigner() {
  final bytes = List<int>.filled(32, 12);
  return NearEd25519SecretKey.fromBytes(bytes);
}

BaseNearAddress getAccountAddress() {
  return getAccountSigner().toPublicKey().toImplicitAddress();
}

NearSecp256k1PublicKey getSecpPublicKey() {
  final bytes = List<int>.filled(32, 12);
  final bip = Bip44.fromSeed(bytes, Bip44Coins.tron);
  return NearSecp256k1PublicKey.fromBytes(
      bip.publicKey.pubKey.toPublicKeyBytes());
}

NearMLDSA65PublicKey getMlDsaPublicKey() {
  final bytes = MLDSA.mldsa65.keygen(List<int>.filled(32, 12));
  // final bip = Bip44.fromSeed(bytes, Bip44Coins.tron);
  return NearMLDSA65PublicKey.fromBytes(bytes.publicKey);
}

NearMLDSA65SecretKey getMlDsaSecretKey() {
  final bytes = MLDSA.mldsa65.keygen(List<int>.filled(32, 12));

  return NearMLDSA65SecretKey.fromBytes(bytes.secretKey);
}

NearSecp256k1SecretKey getSecpSecretKey() {
  final bytes = List<int>.filled(32, 12);
  final bip = Bip44.fromSeed(bytes, Bip44Coins.tron);
  return NearSecp256k1SecretKey.fromBytes(bip.privateKey.toBytes());
}

NearEd25519SecretKey destinationSigner() {
  final bytes = List<int>.filled(32, 13);
  return NearEd25519SecretKey.fromBytes(
    bytes,
  );
}

BaseNearAddress getDestinationAddress() {
  return destinationSigner().toPublicKey().toImplicitAddress();
}

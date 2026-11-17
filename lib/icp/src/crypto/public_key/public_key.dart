import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/public_key/ed25519.dart';
import 'package:on_chain/icp/src/crypto/public_key/ed25519_kholaw.dart';
import 'package:on_chain/icp/src/crypto/public_key/secp256k1.dart';
import 'package:on_chain/icp/src/crypto/public_key/secp256r1.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

abstract class ICPPublicKey with Equality implements Comparable<ICPPublicKey> {
  final ICPKeyType type;
  const ICPPublicKey({required this.type});

  BuBytes toBytes();

  BuBytes toDer();

  bool verifySignature(List<int> message, List<int> signature);

  bool verify(List<int> message, List<int> signature) =>
      verifySignature(message, signature);

  factory ICPPublicKey.fromBytes({
    required List<int> keyBytes,
    required ICPKeyType type,
  }) {
    return switch (type) {
      ICPKeyType.ed25519 => ICPEd25519PublicKey.fromBytes(keyBytes),
      ICPKeyType.secp256k1 => ICPSecp256k1PublicKey.fromBytes(keyBytes),
      ICPKeyType.secp256r1 => ICPSecp256r1PublicKey.fromBytes(keyBytes),
      ICPKeyType.ed25519Kholaw =>
        ICPEd25519KholawPublicKey.fromBytes(keyBytes),
    };
  }

  IcpPrincipalAddress toPrincipalAddress() =>
      IcpPrincipalAddress.fromPublicKey(publicKey: toBytes(), keyType: type);

  @override
  int compareTo(ICPPublicKey other) {
    final bytes = toBytes();
    final otherBytes = other.toBytes();
    return BytesUtils.compareBytes(bytes, otherBytes);
  }
}

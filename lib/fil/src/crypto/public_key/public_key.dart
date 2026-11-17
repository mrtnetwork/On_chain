import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/crypto/public_key/secp256k1.dart';
import 'package:on_chain/fil/src/crypto/public_key/bls12.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';

abstract class FilecoinPublicKey
    with Equality
    implements Comparable<FilecoinPublicKey> {
  final FilecoinKeyType type;
  const FilecoinPublicKey({required this.type});

  BuBytes toBytes();

  bool verifySignature(List<int> message, List<int> signature);

  bool verify(List<int> message, List<int> signature) =>
      verifySignature(message, signature);

  factory FilecoinPublicKey.fromBytes({
    required List<int> keyBytes,
    required FilecoinKeyType type,
  }) {
    return switch (type) {
      FilecoinKeyType.secp256k1 => FilecoinSecp256k1PublicKey.fromBytes(
        keyBytes,
      ),
      FilecoinKeyType.bls12 => FilBls12PublicKey.fromBytes(keyBytes),
    };
  }
  FilAddress toAddress({FilNetwork network = FilNetwork.mainnet}) =>
      FilAddress.fromPublickey(
        publicKey: toBytes(),
        keyType: type,
        network: network,
      );

  @override
  int compareTo(FilecoinPublicKey other) {
    final bytes = toBytes();
    final otherBytes = other.toBytes();
    return BytesUtils.compareBytes(bytes, otherBytes);
  }
}

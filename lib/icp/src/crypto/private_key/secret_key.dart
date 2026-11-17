import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/private_key/ed25519.dart';
import 'package:on_chain/icp/src/crypto/private_key/ed25519_kholaw.dart';
import 'package:on_chain/icp/src/crypto/private_key/secp256k1.dart';
import 'package:on_chain/icp/src/crypto/private_key/secp256r1.dart';
import 'package:on_chain/icp/src/crypto/public_key/public_key.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';
import 'package:on_chain/icp/src/crypto/utils/utils.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_content.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_envelope.dart';

abstract class ICPSecretKey<PK extends ICPPublicKey>
    with SecretState, Equality
    implements ICPSigner {
  final ICPKeyType type;
  const ICPSecretKey({required this.type});

  factory ICPSecretKey.fromBytes({
    required List<int> keyBytes,
    required ICPKeyType type,
  }) {
    final ICPSecretKey secretKey = switch (type) {
      ICPKeyType.ed25519 => ICPEd25519SecretKey.fromBytes(keyBytes),
      ICPKeyType.secp256k1 => ICPSecp256k1SecretKey.fromBytes(keyBytes),
      ICPKeyType.secp256r1 => ICPSecp256r1SecretKey.fromBytes(keyBytes),
      ICPKeyType.ed25519Kholaw => ICPEd25519KholawSecretKey.fromBytes(keyBytes),
    };
    return secretKey.cast();
  }

  SecretBytes toBytes();

  PK toPublicKey();

  BuBytes sign(List<int> message);

  bool verifySignature(List<int> message, List<int> signature) =>
      toPublicKey().verifySignature(message, signature);

  IcpPrincipalAddress toPrincipalAddress() =>
      toPublicKey().toPrincipalAddress();

  T cast<T extends ICPSecretKey>() {
    if (this is! T) {
      throw OnChainErrors.icpPlugin(
        "ICPSecretKey.cast",
        reason: "Invalid secret key cast.",
        details: {"expected": "$T", "actual": "$runtimeType"},
      );
    }
    return this as T;
  }

  BuBytes publicKeyDer() {
    return toPublicKey().toDer();
  }

  @override
  Future<BuBytes> signAsync(List<int> message) async {
    return sign(message);
  }

  @override
  Future<ICPHttpEnvelope> signContent(ICPHttpContent content) async {
    final message = ICPCryptoUtils.signContent(content);
    return ICPHttpEnvelope(
      senderPubkey: toPublicKey().toDer(),
      senderSig: sign(message),
      content: content,
    );
  }
}

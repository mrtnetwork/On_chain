import 'package:blockchain_utils/crypto/crypto/keys/bls12_381/minimal_signature_size/verify_signing.dart';

import 'package:blockchain_utils/crypto/crypto/keys/types/types.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_content.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_envelope.dart';

enum ICPKeyType {
  ed25519(0),
  secp256k1(1),
  secp256r1(2),
  ed25519Kholaw(3);

  final int value;
  const ICPKeyType(this.value);

  static ICPKeyType fromValue(int value) {
    return ICPKeyType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.icpPlugin(
                "ICPKeyType.fromValue",
                reason: "Invalid ICP key type value.",
                details: {"value": "$value"},
              ),
    );
  }

  CryptoKeyType curveType() => switch (this) {
    ICPKeyType.ed25519 => CryptoKeyType.ed25519,
    ICPKeyType.secp256k1 => CryptoKeyType.secp256k1,
    ICPKeyType.secp256r1 => CryptoKeyType.nist256p1,
    ICPKeyType.ed25519Kholaw => CryptoKeyType.ed25519Kholaw,
  };
}

typedef CbICPSigner = Future<ICPSigner> Function(IcpPrincipalAddress addr);

abstract class ICPSigner {
  Future<List<int>> signAsync(List<int> message);
  Future<ICPHttpEnvelope> signContent(ICPHttpContent content);
}

typedef CbBlsVerificationKey =
    Future<IBlsMinSigVerificationKey> Function(List<int> pubkeyBytes);

typedef CbED25519Verification =
    Future<bool> Function(List<int> pubkeyBytes, List<int> signature);

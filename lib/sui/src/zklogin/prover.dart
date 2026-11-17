import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/sui/src/keypair/keys/zklogin.dart';

/// Transport for prover calls. Implement with any HTTP client
/// (e.g. `package:http` in apps/tests).
mixin SuiProverService {
  /// POSTs a JSON body and returns the decoded JSON response.
  Future<Map<String, dynamic>> postProofRequest(
    Uri url,
    Map<String, dynamic> body,
  );
}

/// Prover provider: binds a transport to proof requests.
class SuiProverProvider {
  final SuiProverService service;
  const SuiProverProvider(this.service);
}

/// Known prover hosts (`{host}/v1` takes the proof request).
class SuiZkLoginProverHost {
  /// Development prover (works with the test issuer + devnet VKs).
  static const String dev = 'https://prover-dev.mystenlabs.com';

  /// Production prover (mainnet/testnet VKs).
  static const String prod = 'https://prover.mystenlabs.com';
}

/// Proof points + claim details as returned by the prover (camelCase wire
/// format: `proofPoints.{a,b,c}`, `issBase64Details.{value,indexMod4}`).
class SuiZkLoginProverProof {
  final SuiZkLoginProofPoints proofPoints;
  final SuiZkLoginClaim issBase64Details;
  const SuiZkLoginProverProof({
    required this.proofPoints,
    required this.issBase64Details,
  });
  factory SuiZkLoginProverProof.fromJson(Map<String, dynamic> json) {
    final proof = json['proofPoints'];
    final claim = json['issBase64Details'];
    if (proof is! Map || claim is! Map) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid prover proof response.',
        details: {'body': '$json'.substring(0, 120)},
      );
    }
    final claimMap = claim.cast<String, dynamic>();
    return SuiZkLoginProverProof(
      proofPoints: SuiZkLoginProofPoints.fromJson(
        proof.cast<String, dynamic>(),
      ),
      issBase64Details: SuiZkLoginClaim(
        value: claimMap['value'] as String,
        indexMod4: (claimMap['indexMod4'] as num).toInt(),
      ),
    );
  }
}

/// Minimal client for the Mysten zkLogin prover (`POST {host}/v1`).
class SuiZkLoginProverClient {
  SuiZkLoginProverClient({required this.provider, String? host})
    : host = host ?? SuiZkLoginProverHost.dev;
  SuiZkLoginProverClient.dev({required this.provider})
    : host = SuiZkLoginProverHost.dev;
  SuiZkLoginProverClient.prod({required this.provider})
    : host = SuiZkLoginProverHost.prod;

  final SuiProverProvider provider;
  final String host;

  /// Requests a proof. [extendedEphemeralPublicKey] is base64(`flag‖key`);
  /// [salt] and [jwtRandomness] are decimal strings; [keyClaimName] is
  /// usually `'sub'`.
  Future<SuiZkLoginProverProof> getProof({
    required String jwt,
    required String extendedEphemeralPublicKey,
    required BigInt maxEpoch,
    required String jwtRandomness,
    required String salt,
    String keyClaimName = 'sub',
  }) async {
    late final Map<String, dynamic> parsed;
    try {
      parsed = await provider.service.postProofRequest(Uri.parse('$host/v1'), {
        'jwt': jwt,
        'extendedEphemeralPublicKey': extendedEphemeralPublicKey,
        'maxEpoch': maxEpoch.toInt(),
        'jwtRandomness': jwtRandomness,
        'salt': salt,
        'keyClaimName': keyClaimName,
      });
    } catch (e) {
      throw BuError(
        DefaultErrorType.network,
        'zkLogin prover request failed.',
        details: {'host': host, 'error': '$e'},
      );
    }
    try {
      return SuiZkLoginProverProof.fromJson(parsed);
    } catch (e) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid prover proof response.',
        details: {'error': '$e'},
      );
    }
  }
}

/// Transport for the test issuer. Implement with any HTTP client.
mixin SuiTestIssuerService {
  /// POSTs to the issuer URL (empty body) and returns the decoded response.
  Future<Map<String, dynamic>> postTestIssuerJwt(Uri url);
}

/// Mysten's non-interactive test issuer (devnet/tests only, mirrors
/// fastcrypto `get_test_issuer_jwt_token`).
class SuiTestIssuer {
  SuiTestIssuer({required this.service});
  final SuiTestIssuerService service;

  /// Mints a JWT: `POST {base}/jwt?nonce=&iss=&sub=` (empty body).
  Future<String> mintJwt({
    required String nonce,
    required String iss,
    required String sub,
    String base = 'https://jwt-tester.mystenlabs.com',
  }) async {
    final uri = Uri.parse(
      '$base/jwt',
    ).replace(queryParameters: {'nonce': nonce, 'iss': iss, 'sub': sub});
    late final Map<String, dynamic> parsed;
    try {
      parsed = await service.postTestIssuerJwt(uri);
    } catch (e) {
      throw BuError(
        DefaultErrorType.network,
        'Test issuer JWT request failed.',
        details: {'error': '$e'},
      );
    }
    final jwt = parsed['jwt']?.toString() ?? '';
    if (jwt.isEmpty) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        'Test issuer returned no JWT.',
        details: {'body': '$parsed'},
      );
    }
    return jwt;
  }
}

import 'package:on_chain/aptos/src/account/keyless/account.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/keyless/ephemeral.dart';
import 'package:on_chain/aptos/src/account/keyless/jwks.dart';
import 'package:on_chain/aptos/src/account/keyless/jwt.dart';
import 'package:on_chain/aptos/src/account/keyless/public_key.dart';
import 'package:on_chain/aptos/src/account/keyless/signature.dart';

/// Implementations POST the JWT + ephemeral material to the pepper
/// endpoint and return the 31-byte pepper. The host app owns transport + URLs.
abstract class AptosPepperService {
  Future<List<int>> fetchPepper({
    required String jwt,
    required AptosEphemeralKeyPair ephemeral,
    String uidKey = 'sub',
    String? derivationPath,
  });
}

/// Prover service contract (REST-injected, never hardcoded).
///
/// Implementations POST the JWT + ephemeral material + pepper and return
/// the parsed zero-knowledge signature. Proof JSON mapping lives with the
/// implementation (prover response shapes are service-versioned).
abstract class AptosProverService {
  Future<AptosZeroKnowledgeSig> fetchProof({
    required String jwt,
    required AptosEphemeralKeyPair ephemeral,
    required List<int> pepper,
    String uidKey = 'sub',
  });
}

/// JWK service contract (REST- or chain-injected).
///
/// Resolves the verifying JWK for a JWT `kid`. The chain-backed
/// implementation ([AptosChainJwks]) reads the on-chain `0x1::jwks`
/// resources; federated issuers resolve against their own JWK address.
abstract class AptosJwksService {
  Future<AptosJwkKey> fetchJwk({required String iss, required String kid});
}

/// One-shot keyless session: JWT in, ready-to-sign account out.
class AptosKeylessSession {
  final AptosPepperService pepperService;
  final AptosProverService proverService;

  const AptosKeylessSession({
    required this.pepperService,
    required this.proverService,
  });

  /// Derives the account: parse JWT -> pepper -> identity commitment ->
  /// address, then proof. Throws on expired ephemeral keys.
  Future<AptosKeylessAccount> deriveAccount({
    required String jwt,
    required AptosEphemeralKeyPair ephemeral,
    String uidKey = 'sub',
    String? derivationPath,
  }) async {
    if (ephemeral.isExpired()) {
      throw BuError(
        DefaultErrorType.invalidState,
        'Ephemeral keypair has expired.',
        details: {'expiryDateSecs': '${ephemeral.expiryDateSecs}'},
      );
    }
    final claims = AptosJwtClaims.parse(jwt);
    final pepper = await pepperService.fetchPepper(
      jwt: jwt,
      ephemeral: ephemeral,
      uidKey: uidKey,
      derivationPath: derivationPath,
    );
    final proof = await proverService.fetchProof(
      jwt: jwt,
      ephemeral: ephemeral,
      pepper: pepper,
      uidKey: uidKey,
    );
    return AptosKeylessAccount(
      publicKey: AptosKeylessAccountPublicKey(
        iss: claims.iss,
        uidKey: uidKey,
        uidVal: claims.uidVal(uidKey),
        aud: claims.aud,
        pepper: pepper,
      ),
      ephemeral: ephemeral,
      proof: proof,
      jwtHeader: claims.headerJson,
    );
  }
}

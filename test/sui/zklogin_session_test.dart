// Offline zkLogin session tests: JWT parse, RSA verify (fixed 512-bit
// fixture key), provider registry, and session validation errors
// (nonce/claim checks run before any network use).

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

const String _jwt =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6InVuaXQtdGVzdC1rZXkiLCJ0eXAiOiJKV1QifQ'
    '.eyJpc3MiOiJodHRwczovL2V4YW1wbGUudGVzdCIsInN1YiI6InVzZXItMTIzIiwiYXVkIjoidW5pdC10ZXN0Iiwibm9uY2UiOiJ0ZXN0LW5vbmNlLTEifQ'
    '.Ge1xPJOIiwgG8FL_wLO6ZDzp1_u140aQySIOxBLdRuyFwMiRPp471Zm5hE25zFHAkjNNEC4r71ZHksf8RiftAQ';
const String _n =
    'l1omrgjBknDBRMxMydm5LWgiWWBcIUVc6HHFH5wWT8LGTe3E0_Vt7bA0GSMjs4qCn9-zIjc4IfdHRVHFn2cs2w';
const String _e = 'AQAB';

SuiJwkKey _fixtureKey() => const SuiJwkKey(
  kid: 'unit-test-key',
  kty: 'RSA',
  e: _e,
  n: _n,
  alg: 'RS256',
);

/// Never reached: session validation throws before any prover use.
class _UnreachableProverService with SuiProverService {
  @override
  Future<Map<String, dynamic>> postProofRequest(
    Uri url,
    Map<String, dynamic> body,
  ) {
    throw StateError('unreachable');
  }
}

void zkloginSessionTest() {
  final Object? poseidonSkip =
      blockchainUtils.backend == null
          ? 'Poseidon needs the Rust backend (ffi/wasm).'
          : null;
  group('Sui/ZkLogin session (offline)', () {
    test('JWT parse + claims', () {
      final parts = SuiJwtParts.parse(_jwt);
      expect(parts.kid, 'unit-test-key');
      expect(parts.alg, 'RS256');
      expect(parts.iss, 'https://example.test');
      expect(parts.sub, 'user-123');
      expect(parts.aud, 'unit-test');
      expect(parts.nonce, 'test-nonce-1');
      expect(parts.claimAsString('sub'), 'user-123');
      expect(
        () => SuiJwtParts.parse('not.a.jwt.at.all.extra'),
        throwsA(anything),
      );
      expect(() => SuiJwtParts.parse('a.b'), throwsA(anything));
    });

    test('RSA signature verifies; tampered fails', () {
      final parts = SuiJwtParts.parse(_jwt);
      expect(
        SuiZkLoginUtils.verifyJwtRsaSignature(parts: parts, jwk: _fixtureKey()),
        isTrue,
      );
      // Same signature over altered claims must not verify: re-encode the
      // payload with a different `sub` (still valid JSON).
      final segs = _jwt.split('.');
      final payloadMap = StringUtils.toJson<Map<String, dynamic>>(
        StringUtils.decode(
          StringUtils.encode(
            segs[1],
            encoding: StringEncoding.base64UrlSafe,
            validateB64Padding: false,
          ),
        ),
      );
      payloadMap['sub'] = 'user-999';
      final reEncoded = StringUtils.decode(
        StringUtils.encode(StringUtils.fromJson(payloadMap)),
        encoding: StringEncoding.base64UrlSafe,
        b64NoPadding: true,
      );
      final tampered = SuiJwtParts.parse('${segs[0]}.$reEncoded.${segs[2]}');
      expect(
        SuiZkLoginUtils.verifyJwtRsaSignature(
          parts: tampered,
          jwk: _fixtureKey(),
        ),
        isFalse,
      );
    });

    test('provider registry + unknown issuer', () {
      expect(
        SuiOidcProvider.google.jwksUrl,
        'https://www.googleapis.com/oauth2/v2/certs',
      );
      expect(SuiOidcProvider.testIssuer.iss, 'https://oauth.sui.io');
      final cache = SuiJwksCache();
      cache.register(
        const SuiOidcProvider(
          iss: 'https://example.test',
          jwksUrl: 'https://x',
        ),
      );
      expect(
        () => cache.getKey(SuiJwtParts.parse(_jwt)),
        throwsA(isA<BuError>()),
      );
    });

    test(
      'session rejects nonce mismatch before network',
      skip: poseidonSkip,
      () async {
        final ephemeral = SuiEd25519Account(
          SuiED25519PrivateKey.fromBytes(List<int>.generate(32, (i) => i + 7)),
        );
        await expectLater(
          SuiZkLoginSession.create(
            ephemeralAccount: ephemeral,
            jwt: _jwt,
            salt: BigInt.from(1234),
            maxEpoch: BigInt.from(100),
            jwtRandomness: BigInt.from(9999),
            prover: SuiZkLoginProverClient.dev(
              provider: SuiProverProvider(_UnreachableProverService()),
            ),
          ),
          throwsA(
            isA<BuError>().having(
              (e) => e.message,
              'message',
              contains('nonce'),
            ),
          ),
        );
      },
    );

    test('session rejects missing key claim', () {
      expect(SuiJwtParts.parse(_jwt).claimAsString('nope'), isEmpty);
    });

    test('extended ephemeral key shape', () {
      final ephemeral = SuiEd25519Account(
        SuiED25519PrivateKey.fromBytes(List<int>.generate(32, (i) => i + 7)),
      );
      final ext = SuiZkLoginSession.extendedEphemeralKey(ephemeral);
      expect(ext.length, 33);
      expect(ext.first, SuiSigningScheme.ed25519.value);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(zkloginSessionTest, "Zklogin Session");
}

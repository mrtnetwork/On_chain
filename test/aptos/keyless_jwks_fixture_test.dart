@TestOn('vm')
library;

// On-chain JWK fixture (needs the filesystem): real mainnet
// `PatchedJWKs` entries (Google + Apple, one key each) frozen in
// `patched_jwks.json`.

import 'package:blockchain_utils/blockchain_utils.dart';
import 'dart:io';

import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

void keylessJwksFixtureTest() {
  group('Aptos/JWK fixture (needs dart:io)', () {
    test('on-chain JWK fixture parses (Google + Apple)', () {
      final file = File('test/aptos/patched_jwks.json');
      final raw = StringUtils.toJson<Map<String, dynamic>>(
        file.readAsStringSync(),
      );
      final set = AptosPatchedJwks.fromResource(raw);
      expect(set.entries, hasLength(2));
      final google = set.findJwk(
        iss: 'https://accounts.google.com',
        kid: '943a3a5d7d919625a454e489b75c29adab57acba',
      );
      expect(google.kty, 'RSA');
      expect(google.alg, 'RS256');
      expect(google.e, 'AQAB');
      expect(google.n, isNotEmpty);
      final apple = set.findJwk(
        iss: 'https://appleid.apple.com',
        kid: '8nTlO3M2Bk',
      );
      expect(apple.kty, 'RSA');
      expect(
        () => set.findJwk(iss: 'https://nope.example', kid: 'x'),
        throwsA(isA<BuError>()),
      );
      expect(
        () => set.findJwk(iss: 'https://accounts.google.com', kid: 'unknown'),
        throwsA(isA<BuError>()),
      );
    });
  }, skip: !native ? 'filesystem fixtures unavailable' : null);
}

void main() {
  OnChainUtilsTestApi.runTest(keylessJwksFixtureTest, 'KeylessJwksFixture');
}

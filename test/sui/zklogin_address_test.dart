// zkLogin address vectors from MystenLabs/ts-sdks
// `packages/sui/test/unit/zklogin/address.test.ts` (authoritative).

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

void zkloginAddressTest() {
  final Object? poseidonSkip =
      blockchainUtils.backend == null
          ? 'Poseidon needs the Rust backend (ffi/wasm).'
          : null;

  group('Sui/ZkLogin address (official vectors)', () {
    test('seed vector 1 (legacy)', () {
      expect(
        SuiZkLoginUtils.computeAddressFromSeed(
          addressSeed: BigInt.parse(
            '13322897930163218532266430409510394316985274769125667290600321564259466511711',
          ),
          iss: 'https://accounts.google.com',
          legacyAddress: true,
        ).address,
        '0xf7badc2b245c7f74d7509a4aa357ecf80a29e7713fb4c44b0e7541ec43885ee1',
      );
    });

    test('seed vector 2, leading zeros (legacy)', () {
      expect(
        SuiZkLoginUtils.computeAddressFromSeed(
          addressSeed: BigInt.parse(
            '380704556853533152350240698167704405529973457670972223618755249929828551006',
          ),
          iss: 'https://accounts.google.com',
          legacyAddress: true,
        ).address,
        '0xbd8b8ed42d90aebc71518385d8a899af14cef8b5a171c380434dd6f5bbfe7bf3',
      );
    });

    test('jwt end-to-end vector (non-legacy)', skip: poseidonSkip, () {
      const jwt =
          'eyJraWQiOiJzdWkta2V5LWlkIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI4YzJkN2Q2Ni04N2FmLTQxZmEtYjZmYy02M2U4YmI3MWZhYjQiLCJhdWQiOiJ0ZXN0IiwibmJmIjoxNjk3NDY1NDQ1LCJpc3MiOiJodHRwczovL29hdXRoLnN1aS5pbyIsImV4cCI6MTY5NzU1MTg0NSwibm9uY2UiOiJoVFBwZ0Y3WEFLYlczN3JFVVM2cEVWWnFtb0kifQ.';
      final parts = jwt.split('.');
      final payload = StringUtils.toJson<Map<String, dynamic>>(
        StringUtils.decode(
          StringUtils.encode(
            parts[1],
            encoding: StringEncoding.base64UrlSafe,
            validateB64Padding: false,
          ),
        ),
      );
      final address = SuiZkLoginUtils.computeAddress(
        claimName: 'sub',
        claimValue: payload['sub'] as String,
        iss: payload['iss'] as String,
        aud: payload['aud'] as String,
        userSalt: BigInt.parse('248191903847969014646285995941615069143'),
        legacyAddress: false,
      );
      expect(
        address.address,
        '0x22cebcf68a9d75d508d50d553dd6bae378ef51177a3a6325b749e57e3ba237d6',
      );
    });

    test('google iss variants agree', skip: poseidonSkip, () {
      final a = SuiZkLoginUtils.computeAddress(
        claimName: 'sub',
        claimValue: '1234567890',
        iss: 'https://accounts.google.com',
        aud: '1234567890.apps.googleusercontent.com',
        userSalt: BigInt.zero,
        legacyAddress: false,
      );
      final b = SuiZkLoginUtils.computeAddress(
        claimName: 'sub',
        claimValue: '1234567890',
        iss: 'accounts.google.com',
        aud: '1234567890.apps.googleusercontent.com',
        userSalt: BigInt.zero,
        legacyAddress: false,
      );
      expect(a.address, b.address);
    });

    test('escaped claims throw', () {
      expect(
        () => SuiZkLoginUtils.genAddressSeed(
          salt: BigInt.one,
          name: 'su"b',
          value: '1234567890',
          aud: 'test',
        ),
        throwsA(isA<BuError>()),
      );
    });

    test('nonce has 27-char base64url shape', skip: poseidonSkip, () {
      final nonce = SuiZkLoginUtils.generateNonce(
        ephemeralPublicKey: [0x00, ...List<int>.filled(32, 7)],
        maxEpoch: 10,
        randomness: BigInt.zero,
      );
      expect(nonce.length, 27);
      expect(RegExp(r'^[A-Za-z0-9_-]{27}$').hasMatch(nonce), isTrue);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(zkloginAddressTest, "Zklogin Address");
}

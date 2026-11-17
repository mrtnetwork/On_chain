// Aptos keyless (AIP-61) verification.
//
// Address/identity vectors cross-checked against `@aptos-labs/ts-sdk@7.3.0`
// (`EphemeralKeyPair`, `KeylessPublicKey.create`,
// `FederatedKeylessPublicKey.fromJwtAndPepper`):
//   sk = 0x11 * 32, blinder = 0x07 * 31, expiry = 1900000000
//   pepper = 0x03 * 31, iss = https://accounts.google.com,
//   uidKey = sub, uidVal = 123456789, aud = my-dapp

import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

const String _tsNonce =
    '16662121684796906574972855387339464820629710764070791398388757147348999657276';
const String _tsEpkBcs =
    '0020d04ab232742bb4ab3a1368bd4615e4e6d0224ab71a016baf8520a332c9778737';
const String _tsIdc =
    '5580a7e7f0d0321a82f62c3a1acac35bb441fc5bc032d3a303fe815663fe9a1b';
const String _tsAddr =
    '0x2f3d4aa0784cbfe1e27dd073784df53ffe3902be8194c94dac55a6352cff36e7';
const String _tsPubkeyBcs =
    '1b68747470733a2f2f6163636f756e74732e676f6f676c652e636f6d205580a7e7f0d0321a82f62c3a1acac35bb441fc5bc032d3a303fe815663fe9a1b';
// Exact `ZeroKnowledgeSig` BCS from the TS SDK for a=0x01*32, b=0x02*64,
// c=0x03*32, expHorizonSecs=3600, no optionals.
const String _tsZkSigBcs =
    '000101010101010101010101010101010101010101010101010101010101010101020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020303030303030303030303030303030303030303030303030303030303030303100e000000000000000000';

const String _iss = 'https://accounts.google.com';

void keylessTest() {
  group('Aptos/Keyless', () {
    /// poseidon lives in the Rust backend only
    /// (`DartHashApi.poseidonBn254Hash` throws `UnimplementedError` on
    /// pure-Dart); declarative skips keep the Dart suite green while FFI/WASM
    /// runs verify for real. ('JWT claims parse' is decode-only: runs everywhere.)
    final Object? poseidonSkip =
        blockchainUtils.backend == null
            ? 'Poseidon needs the Rust backend (ffi/wasm).'
            : null;
    test('poseidon matches poseidon-lite reference vectors', skip: poseidonSkip, () {
      expect(
        AptosKeylessPoseidon.hashFields([BigInt.zero]).toString(),
        '19014214495641488759237505126948346942972912379615652741039992445865937985820',
      );
      expect(
        AptosKeylessPoseidon.hashFields([BigInt.one, BigInt.two]).toString(),
        '7853200120776062878684798364095072458815029376092732009249414926327459813530',
      );
      expect(
        AptosKeylessPoseidon.hashFields([
          BigInt.from(123456789),
          BigInt.from(987654321),
          BigInt.from(111111111),
          BigInt.from(222222222),
        ]).toString(),
        '9297181433811594356036069595889216462625653072557337479630963095408533116619',
      );
    });

    test('ephemeral nonce matches the TS SDK', skip: poseidonSkip, () {
      final sk = ED25519PrivateKey.fromBytes(List<int>.filled(32, 0x11));
      final ephemeral = AptosEphemeralKeyPair(
        privateKey: sk,
        expiryDateSecs: 1900000000,
        blinder: List<int>.filled(31, 0x07),
      );
      expect(ephemeral.nonce, _tsNonce);
      expect(
        BytesUtils.toHexString(ephemeral.ephemeralPublicKeyBcs),
        _tsEpkBcs,
      );
    });

    test(
      'identity commitment and address match the TS SDK',
      skip: poseidonSkip,
      () {
        final pepper = List<int>.filled(31, 0x03);
        final idc = AptosKeylessAccountPublicKey.computeIdCommitment(
          uidKey: 'sub',
          uidVal: '123456789',
          aud: 'my-dapp',
          pepper: pepper,
        );
        expect(BytesUtils.toHexString(idc), _tsIdc);
        final pubkey = AptosKeylessAccountPublicKey(
          iss: _iss,
          uidKey: 'sub',
          uidVal: '123456789',
          aud: 'my-dapp',
          pepper: pepper,
        );
        expect(pubkey.toAddress().address, _tsAddr);
        expect(BytesUtils.toHexString(pubkey.toInnerBcs()), _tsPubkeyBcs);
        expect(
          BytesUtils.toHexString(pubkey.toAnyPublicKeyBcs()),
          '03$_tsPubkeyBcs',
        );
      },
    );

    test('keyless public key BCS round-trips', skip: poseidonSkip, () {
      final pepper = List<int>.filled(31, 0x03);
      final pubkey = AptosKeylessAccountPublicKey(
        iss: _iss,
        uidKey: 'sub',
        uidVal: '123456789',
        aud: 'my-dapp',
        pepper: pepper,
      );
      final bytes = pubkey.toInnerBcs();
      final back = AptosKeylessAccountPublicKey.deserialize(bytes);
      expect(back.iss, _iss);
      expect(back.idCommitment, orderedEquals(pubkey.idCommitment));
      expect(back.toAddress().address, _tsAddr);
    });

    test('keyless signature BCS round-trips', skip: poseidonSkip, () {
      final zkSig = AptosZeroKnowledgeSig(
        proof: AptosZkProof(
          AptosGroth16Zkp(
            a: List<int>.filled(32, 0x01),
            b: List<int>.filled(64, 0x02),
            c: List<int>.filled(32, 0x03),
          ),
        ),
        expHorizonSecs: BigInt.from(3600),
      );
      // Exact bytes cross-checked against the TS SDK.
      expect(BytesUtils.toHexString(zkSig.toBcs()), _tsZkSigBcs);
      final sk = ED25519PrivateKey.fromBytes(List<int>.filled(32, 0x11));
      final ephemeral = AptosEphemeralKeyPair(
        privateKey: sk,
        expiryDateSecs: 4100000000,
        blinder: List<int>.filled(31, 0x07),
      );
      final sig = AptosKeylessSignature.sign(
        ephemeral: ephemeral,
        zkSig: zkSig,
        jwtHeader: '{"alg":"RS256","kid":"1"}',
        digest: List<int>.filled(32, 0x00),
      );
      final bytes = sig.toBcs();
      final back = AptosKeylessSignature.deserialize(bytes);
      expect(back.toBcs(), orderedEquals(bytes));
      expect(back.jwtHeader, '{"alg":"RS256","kid":"1"}');
      expect(back.expiryDateSecs, BigInt.from(4100000000));
      // Ephemeral component verifies locally.
      expect(
        AptosKeylessAccountPublicKey(
          iss: _iss,
          uidKey: 'sub',
          uidVal: '123456789',
          aud: 'my-dapp',
          pepper: List<int>.filled(31, 0x03),
        ).verifySignature(
          message: List<int>.filled(32, 0x00),
          signature: AptosKeylessAnySignature(sig).toVariantBcs(),
        ),
        isTrue,
      );
    });

    test(
      'single-key authenticator carries the keyless variants',
      skip: poseidonSkip,
      () {
        final pepper = List<int>.filled(31, 0x03);
        final pubkey = AptosKeylessAccountPublicKey(
          iss: _iss,
          uidKey: 'sub',
          uidVal: '123456789',
          aud: 'my-dapp',
          pepper: pepper,
        );
        final zkSig = AptosZeroKnowledgeSig(
          proof: AptosZkProof(
            AptosGroth16Zkp(
              a: List<int>.filled(32, 0x01),
              b: List<int>.filled(64, 0x02),
              c: List<int>.filled(32, 0x03),
            ),
          ),
          expHorizonSecs: BigInt.from(3600),
        );
        final ephemeral = AptosEphemeralKeyPair(
          privateKey: ED25519PrivateKey.fromBytes(List<int>.filled(32, 0x11)),
          expiryDateSecs: 4100000000,
          blinder: List<int>.filled(31, 0x07),
        );
        final auth = AptosAccountAuthenticatorSingleKey(
          publicKey: pubkey,
          signature: AptosKeylessAnySignature(
            AptosKeylessSignature.sign(
              ephemeral: ephemeral,
              zkSig: zkSig,
              jwtHeader: '{"alg":"RS256","kid":"1"}',
              digest: List<int>.filled(32, 0x00),
            ),
          ),
        );
        final bytes = auth.toVariantBcs();
        // SingleKey authenticator (0x02) + AnyPublicKey keyless (0x03).
        expect(bytes[0], 0x02);
        final back = AptosAccountAuthenticator.deserialize(bytes);
        expect(back.toVariantBcs(), orderedEquals(bytes));
        expect(
          (back as AptosAccountAuthenticatorSingleKey).publicKey,
          isA<AptosKeylessAccountPublicKey>(),
        );
      },
    );

    test('JWT claims parse (decode-only)', () {
      String b64(String s) => StringUtils.decode(
        StringUtils.encode(s),
        encoding: StringEncoding.base64UrlSafe,
        b64NoPadding: true,
      );
      // NOTE: unsigned fixture — signature never verified client-side.
      final jwt =
          '${b64('{"alg":"RS256","kid":"abc"}')}.${b64('{"iss":"$_iss","sub":"123456789","aud":"my-dapp","exp":1900000000}')}.e30';
      final claims = AptosJwtClaims.parse(jwt);
      expect(claims.iss, _iss);
      expect(claims.aud, 'my-dapp');
      expect(claims.uidVal(), '123456789');
      expect(claims.kid, 'abc');
      expect(claims.exp, 1900000000);
      expect(
        () => AptosJwtClaims.parse('not.a.jwt.at.all.extra'),
        throwsA(isA<BuError>()),
      );
    });

    test('federated address and BCS match the TS SDK', skip: poseidonSkip, () {
      String b64(String s) => StringUtils.decode(
        StringUtils.encode(s),
        encoding: StringEncoding.base64UrlSafe,
        b64NoPadding: true,
      );
      final jwt =
          '${b64('{"alg":"RS256","kid":"x"}')}.${b64('{"iss":"https://example.com","sub":"t1","aud":"dapp"}')}.c2ln';
      final pepper = List<int>.filled(31, 0x05);
      final jwkAddress = BytesUtils.fromHexString(
        '0x0000000000000000000000000000000000000000000000000000000000123400',
      );
      final pubkey = AptosFederatedKeylessPublicKey.fromJwtAndPepper(
        jwt: jwt,
        pepper: pepper,
        jwkAddress: jwkAddress,
      );
      expect(
        BytesUtils.toHexString(pubkey.toAnyPublicKeyBcs()),
        '040000000000000000000000000000000000000000000000000000000000123400'
        '1368747470733a2f2f6578616d706c652e636f6d'
        '209d89e2d5c1e1a236a8a65c670e10a1bfee2f51bc4db5e44b2e17f0e638210330',
      );
      expect(
        pubkey.toAddress().address,
        '0xb4cfb70bf1e177c1bc2d01fa3152b4a20e7deb0e91b069315a8e34c79ae6c142',
      );
      // BCS round-trip through the inner struct shape.
      final back = AptosFederatedKeylessPublicKey.fromStruct(
        BcsSerialization.deserialize(
          bytes: pubkey.toAnyPublicKeyBcs().sublist(1),
          layout: AptosFederatedKeylessPublicKey.layout(),
        ),
      );
      expect(back.toAddress().address, pubkey.toAddress().address);
    });

    test(
      'pepper/prover request bodies match the service shapes',
      skip: poseidonSkip,
      () {
        final ephemeral = AptosEphemeralKeyPair(
          privateKey: ED25519PrivateKey.fromBytes(List<int>.filled(32, 0x11)),
          expiryDateSecs: 1900000000,
          blinder: List<int>.filled(31, 0x07),
        );
        final pepperBody = AptosKeylessServiceUtils.buildPepperFetchBody(
          jwt: 'jwt.compact.sig',
          ephemeral: ephemeral,
        );
        expect(pepperBody['jwt_b64'], 'jwt.compact.sig');
        expect(pepperBody['epk'], _tsEpkBcs);
        expect(pepperBody['exp_date_secs'], 1900000000);
        expect(pepperBody['epk_blinder'], '07' * 31);
        expect(pepperBody['uid_key'], 'sub');
        expect(pepperBody.containsKey('derivation_path'), isFalse);

        final proofBody = AptosKeylessServiceUtils.buildProofRequestBody(
          jwt: 'jwt.compact.sig',
          ephemeral: ephemeral,
          pepper: List<int>.filled(31, 0x03),
          expHorizonSecs: 3600,
        );
        expect(proofBody['exp_horizon_secs'], 3600);
        expect(proofBody['pepper'], '03' * 31);

        expect(
          AptosKeylessServiceUtils.parsePepperFetchResponse({
            'pepper': '03' * 31,
          }),
          orderedEquals(List<int>.filled(31, 0x03)),
        );
        final sig = AptosKeylessServiceUtils.parseProofResponse({
          'proof': {'a': '01' * 32, 'b': '02' * 64, 'c': '03' * 32},
        }, expHorizonSecs: 3600);
        expect(sig.expHorizonSecs, BigInt.from(3600));
        expect(sig.trainingWheelsSignature, isNull);
        expect(BytesUtils.toHexString(sig.toBcs()), _tsZkSigBcs);
      },
    );

    test(
      'local keyless verification passes on a live devnet vector',
      skip: poseidonSkip,
      () {
        // Fresh devnet triple (Nov 13 2026): JWT sub 112097348406743460912,
        // pepper 2bd886…, prove response `prove_fresh.json`. The prover's
        // `public_inputs_hash` response field is NOT used (it echoed a stale
        // out-of-range value); the proof + training-wheels signature bind the
        // PIH below, which also matches the TS SDK `getPublicInputsHash` and
        // was accepted on-chain (0x0012b177…).
        const pepperHex =
            '2bd886bd0da9aec69b72a7328c2ff4450c7fdd588d74889bf91b7b5660fe5b';
        const epkBcsHex =
            '002047684b83c4cbcfb3f13efdabf4716d759ddffd32a24edbe45817d342a19b3503';
        const skHex =
            '5bc732ddcbd1317b56dc5c1cf2d45a0d3eb523b6c73f16e49f21266b39e1e80f';
        const headerJson =
            '{"alg":"RS256","kid":"943a3a5d7d919625a454e489b75c29adab57acba","typ":"JWT"}';
        const proofAHex =
            '6e549b614ec8507d8fcb59f55e1426d485de139e24b00a236334f792eff8669f';
        const proofBHex =
            'da1869762d56069f26f718d7db9444572f4a7b8a3c4dcac76e28bef4b4980d133d4e1b12e6060d851a0e9b43da6fa37ac4afdf57cd688d760001f022d113192d';
        const proofCHex =
            '49aca88b7a0ba0e3496e6a23e797a7725da2482c9668d9008c5346a4b40cef11';
        const twsHex =
            '00400df2ed599f57fed395309e894f128702832f8f8654654e67fb4e22125e56cad73e43b58edc60d87e032e56c498019f65fc5ebef445ad9f780832324e4391e90c';
        const n =
            'pIpnzA2ezyEERJSxiqpLBmMeIqATH-V6iuBtKIibXEyYovujrx8niqTeO6RIyXT6uDUUv0V2kJ8V_iWYFxzXY1BqK9IfcAmjg0XUDoyTVkoyLsF0gj299LH-zw5vCvy8jmamFIZKAbKcQ5hpHvSittM1vl-6vVL-i2GxyGbMA9aY6Hq15NylS1t7ELTYfQimlnvxcb7_DM0cuS5U1SfbCZMCpKhh0nrSlYds240oxpCJOV2rBahs_Ea5c7tezS1nwVC9W_E-bR9TF6BHkC_fv-E8DcWfkI_6geaJzBhINNxBfjx-w1-WUp2Jz3YYFWEfeQjxMqu-Fg6cGxwk7V16uQ';
        const expectedPihHex =
            '119a2ffe538bf026478d2b73f89b6228425ff7b9346e95fcbe85ca097df0e18d';

        final pepper = BytesUtils.fromHexString(pepperHex);
        final pubkey = AptosKeylessAccountPublicKey(
          iss: _iss,
          uidKey: 'sub',
          uidVal: '112097348406743460912',
          aud:
              '10679172605-2gsbfb6tbcjqlkjd9bh6tabvfbmqtfpj.apps.googleusercontent.com',
          pepper: pepper,
        );
        final zkSig = AptosZeroKnowledgeSig(
          proof: AptosZkProof(
            AptosGroth16Zkp(
              a: BytesUtils.fromHexString(proofAHex),
              b: BytesUtils.fromHexString(proofBHex),
              c: BytesUtils.fromHexString(proofCHex),
            ),
          ),
          expHorizonSecs: BigInt.from(3600),
          trainingWheelsSignature: BytesUtils.fromHexString(twsHex),
        );
        final sk = ED25519PrivateKey.fromBytes(BytesUtils.fromHexString(skHex));
        final message = List<int>.filled(32, 0xab);
        final epkSig = ED25519Signer(sk).sign(Uint8List.fromList(message));
        final sig = AptosKeylessSignature(
          ephemeralCertificate: AptosEphemeralCertificate(zkSig),
          jwtHeader: headerJson,
          expiryDateSecs: BigInt.from(1794599847),
          ephemeralPublicKey: AptosEphemeralPublicKey(
            List<int>.from(sk.publicKey.toBytes()),
          ),
          ephemeralSignature: AptosEphemeralSignature(
            List<int>.from(epkSig.signature.toBytes()),
          ),
        );
        expect(
          BytesUtils.toHexString(sig.ephemeralPublicKey.toVariantBcs()),
          epkBcsHex,
        );
        final jwk = AptosJwkKey(
          kid: '943a3a5d7d919625a454e489b75c29adab57acba',
          kty: 'RSA',
          alg: 'RS256',
          e: 'AQAB',
          n: n,
        );
        final config = AptosKeylessConfiguration(
          alphaG1:
              '0xe2f26dbea299f5223b646cb1fb33eadb059d9407559d7441dfd902e3a79a4d2d',
          betaG2:
              '0xabb73dc17fbc13021e2471e0c08bd67d8401f52b73d6d07483794cad4778180e0c06f33bbc4c79a9cadef253a68084d382f17788f885c9afd176f7cb2f036789',
          gammaG2:
              '0xedf692d95cbdde46ddda5ef7d422436779445c5e66006a42761e1f12efde0018c212f3aeb785e49712e7a9353349aaf1255dfb31b7bf60723a480d9293938e19',
          deltaG2:
              '0xb106619932d0ef372c46909a2492e246d5de739aa140e27f2c71c0470662f125219049cfe15e4d140d7e4bb911284aad1cad19880efb86f2d9dd4b1bb344ef8f',
          gammaAbcG1: const [
            '0x6123b6fea40de2a7e3595f9c35210da8a45a7e8c2f7da9eb4548e9210cfea81a',
            '0x32a9b8347c512483812ee922dc75952842f8f3083edb6fe8d5c3c07e1340b683',
          ],
          maxExpHorizonSecs: BigInt.from(10000000),
          maxCommitedEpkBytes: 93,
          maxIssValBytes: 120,
          maxExtraFieldBytes: 350,
          maxJwtHeaderB64Bytes: 300,
          trainingWheelsPubkey:
              BytesUtils.fromHexString(
                '0x1388de358cf4701696bd58ed4b96e9d670cbbb914b888be1ceda6374a3098ed4',
              ).toList(),
        );
        // The JWK scalar sits BEFORE the aud fields (TS `getPublicInputsHash`
        // order); putting it last yields 0ea96f… and fails verification.
        expect(
          AptosKeylessVerifyUtils.keylessPublicInputsHash(
            publicKey: pubkey,
            signature: sig,
            jwk: jwk,
            config: config,
          ).toRadixString(16).padLeft(64, '0'),
          expectedPihHex,
        );
        expect(
          AptosKeylessVerifyUtils.verifyKeylessSignatureLocally(
            publicKey: pubkey,
            signature: sig,
            message: message,
            jwk: jwk,
            config: config,
            nowSecs: 1794595000,
          ),
          isTrue,
        );
        expect(
          () => AptosKeylessVerifyUtils.verifyKeylessSignatureLocally(
            publicKey: pubkey,
            signature: sig,
            message: List<int>.filled(32, 0xac),
            jwk: jwk,
            config: config,
            nowSecs: 1794595000,
          ),
          throwsA(
            isA<BuError>().having(
              (e) => e.details?['check'],
              'check',
              'ephemeral-signature',
            ),
          ),
        );
      },
    );
  });
}

void main() {
  OnChainUtilsTestApi.runTest(keylessTest, 'Keyless');
}

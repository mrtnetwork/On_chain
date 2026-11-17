// zkLogin / passkey / multisig-verify tests (offline, synthetic inputs).
import 'package:on_chain/on_chain.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';

import '../utils.dart';
void authAccountsTest() {

  group('Sui/ZkLogin account (offline)', () {
    SuiZkLoginInputs inputs() {
      return SuiZkLoginInputs.fromProverJson({
        'proof_points': {
          'a': ['1', '2', '3'],
          'b': [
            ['4', '5'],
            ['6', '7'],
          ],
          'c': ['8', '9', '10'],
        },
        'iss_base64_details': {'value': 'KL9yTgtcVWhJJEfTgq0o', 'index_mod_4': 1},
        'header_base64': 'eyJhbGciOiJSUzI1NiJ9',
        'address_seed':
            '13322897930163218532266430409510394316985274769125667290600321564259466511711',
      });
    }

    SuiZkLoginAccount account() {
      final ephemeral = SuiEd25519Account(
        SuiED25519PrivateKey.fromBytes(List<int>.generate(32, (i) => i + 1)),
      );
      return SuiZkLoginAccount.fromClaims(
        ephemeralAccount: ephemeral,
        inputs: inputs(),
        maxEpoch: BigInt.from(100),
        iss: 'https://accounts.google.com',
      );
    }

    test('address matches seed derivation', () {
      final a = account();
      expect(
        a.toAddress().address,
        SuiZkLoginUtils.computeAddressFromSeed(
          addressSeed: BigInt.parse(
            '13322897930163218532266430409510394316985274769125667290600321564259466511711',
          ),
          iss: 'https://accounts.google.com',
          legacyAddress: false,
        ).address,
      );
    });

    test('sign + BCS round-trip + ephemeral verify', () {
      final a = account();
      final digest = List<int>.generate(32, (i) => i);
      final sig = a.signTransaction(digest, hashDigest: false);
      expect(sig.maxEpoch, BigInt.from(100));
      // BCS round-trip through the variant envelope.
      final bytes = sig.toVariantBcs();
      final back = SuiBaseSignature.deserialize(bytes);
      expect(back, isA<SuiZkLoginSignature>());
      final zk = back as SuiZkLoginSignature;
      expect(zk.maxEpoch, BigInt.from(100));
      expect(
        SuiZkLoginSignature.verifyEphemeralSignature(
          digest: digest,
          signature: zk,
          ephemeralPublicKey: a.ephemeralAccount.publicKey,
        ),
        isTrue,
      );
      // Tampered digest fails.
      expect(
        SuiZkLoginSignature.verifyEphemeralSignature(
          digest: List<int>.generate(32, (i) => 9),
          signature: zk,
          ephemeralPublicKey: a.ephemeralAccount.publicKey,
        ),
        isFalse,
      );
    });
  });

  group('Sui/Passkey account (offline)', () {
    SuiPasskeyAccount account() {
      return SuiPasskeyAccount.fromPrivateKey(
        SuiSecp256r1PrivateKey.fromBytes(List<int>.generate(32, (i) => i + 3)),
      );
    }

    test('assemble + verify round-trip, tamper fails', () {
      final a = account();
      const authData = [1, 2, 3, 4];
      const clientJson = '{"type":"webauthn.get"}';
      final sig = a.signWithAssertion(
        authenticatorData: authData,
        clientDataJSON: clientJson,
      );
      expect(
        SuiPasskeySignature.verify(signature: sig, publicKey: a.publicKey),
        isTrue,
      );
      // BCS round-trip.
      final back = SuiBaseSignature.deserialize(sig.toVariantBcs());
      expect(back, isA<SuiPasskeySignature>());
      expect(
        SuiPasskeySignature.verify(
          signature: back as SuiPasskeySignature,
          publicKey: a.publicKey,
        ),
        isTrue,
      );
      // Tampered client data fails.
      final tampered = SuiPasskeySignature(
        authenticatorData: authData,
        clientDataJSON: '{"type":"webauthn.create"}',
        signature: sig.signature,
      );
      expect(
        SuiPasskeySignature.verify(signature: tampered, publicKey: a.publicKey),
        isFalse,
      );
      // Raw signing is refused with guidance.
      expect(
        () => a.signTransaction([1, 2, 3]),
        throwsA(isA<BuError>()),
      );
    });
  });

  group('Sui/Multisig tx verify (offline)', () {
    test('threshold walk over intent digest', () {
      final k1 = SuiEd25519Account(
        SuiED25519PrivateKey.fromBytes(List<int>.generate(32, (i) => i + 1)),
      );
      final k2 = SuiSecp256k1Account(
        SuiSecp256k1PrivateKey.fromBytes(List<int>.generate(32, (i) => i + 2)),
      );
      final multisig = SuiMultisigAccount(
        privateKeys: [k1.privateKey, k2.privateKey],
        publicKey: SuiMultisigAccountPublicKey(
          publicKeys: [
            SuiMultisigPublicKeyInfo(
              publicKey: k1.privateKey.publicKey,
              weight: 1,
            ),
            SuiMultisigPublicKeyInfo(
              publicKey: k2.privateKey.publicKey,
              weight: 1,
            ),
          ],
          threshold: 2,
        ),
      );
      final digest = List<int>.generate(32, (i) => i + 5);
      final sig = multisig.signTransaction(digest, hashDigest: false);
      final bytes = sig.toVariantBcs();
      expect(
        multisig.publicKey.verify(message: digest, signature: bytes),
        isTrue,
      );
      expect(
        multisig.publicKey.verify(
          message: List<int>.generate(32, (i) => 9),
          signature: bytes,
        ),
        isFalse,
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(authAccountsTest, "Auth Accounts");
}


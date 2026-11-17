import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/crypto/crypto.dart';
import 'package:test/test.dart';

import '../../../utils.dart';
void cryptoTest() {
  group('Hedera/Crypto', () {
    final keys = List<HederaSecretKey>.generate(
      3,
      (i) =>
          i.isEven
              ? HederaEd25519SecretKey.random()
              : HederaSecp256k1SecretKey.random(),
    );
    final publicKeys = keys.map((e) => e.toPublicKey()).toList();
    test('Multisig account', () {
    final multiAccount = HederaMultiSigAccount.keyList(
      publicKeys: publicKeys,
      signers: keys,
    );
    final message = QuickCrypto.generateRandom();
    final signatures = multiAccount.signMessage(message);
    final verify = multiAccount.publicKeyAccount.verify(
      message: message,
      signatures: signatures,
    );
    expect(verify, isTrue);
  });
  test("Hedera key", () {
    {
      final multiAccount = HederaMultiSigAccount.keyList(
        publicKeys: publicKeys,
        signers: keys,
      );
      final hederaKey = multiAccount.publicKeyAccount.toHederaKey();
      expect(hederaKey.keyList?.keys.length, 3);
      expect(
        hederaKey.keyList?.keys.elementAtOrNull(2)?.ed25519,
        publicKeys[2].toBytes(),
      );
    }
    final multiAccount = HederaMultiSigAccount.threshold(
      publicKeys: publicKeys,
      signers: keys,
      threshold: 3,
    );
    final hederaKey = multiAccount.publicKeyAccount.toHederaKey();
    expect(hederaKey.thresholdKey?.keys?.keys.length, 3);
    expect(hederaKey.thresholdKey?.threshold, 3);
    expect(
      hederaKey.thresholdKey?.keys?.keys.elementAtOrNull(1)?.ecdsaSecp256k1,
      publicKeys[1].toBytes(),
    );
  });

  test("Bad threshold", () {
    expect(
      () =>
          HederaMultiSigAccount.threshold(publicKeys: publicKeys, threshold: 5),
      throwsA(isA<BuError>()),
    );
  });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(cryptoTest, "Crypto");
}


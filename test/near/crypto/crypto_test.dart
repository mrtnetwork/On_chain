import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/crypto/crypto.dart';
import 'package:on_chain/near/src/transaction/src/action.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void cryptoCryptoTest() {
  group('NEAR/Nep413', () {
    test('sign delegate action', () {
      final secretKey = NearSecretKey.deserialize(
        "secp256k1:2Gtcrpo9tLJL1jXuaNezix9bTtrp3Ufe7EuLixmtdx7FdJLdA7AAVwWPEdax8gtjF15Vjy6yjXaN8q6MgCy2YXkBcQ9pHXResmLLi26T2fRvUSyKPKXMFpo8oB9qm6SokFRQ",
      );
      final signature = secretKey.signDelegateAction(
        NearDelegateAction(
          senderId: "near.account",
          receiverId: "near.account2",
          actions: [],
          nonce: BigInt.one,
          maxBlockHeight: BigInt.one,
          publicKey: secretKey.toPublicKey(),
        ),
      );
      expect(
        signature.delegate.signature,
        TypeMatcher<NearSignatureSECP256K1>(),
      );
      expect(
        BytesUtils.fromHexString(
          "16dca464a9fd33bc549e43178e4ebf5f859824f5e9bcd3044c57713f42a01e4e2f2ba868b1c95579e02ec8ad4b21f9215a6033d7c13508b54589f12d5f11176901",
        ),
        signature.delegate.signature.data,
      );
    });

    test('sign message', () {
      final secretKey = NearSecretKey.deserialize(
        "secp256k1:PLh6xfE3XKxRL5AQmrffSdde6eo3MgaeV2mmjHS9eLWB6oh5NvEHXkcbS6rGA9x17fUzuwRiCsEzsKZwahLhShSsckz4gUQR5NXve6phFfjMncEHvUh2HebAggnDymD5oqf",
      );
      final message = Nep413MessagePayload(
        message: "message",
        nonce: List<int>.filled(32, 12),
        recipient: "near",
        callbackUrl: "https://google.com",
      );
      final signature = secretKey.signNep413Message("account.near", message);
      expect(
        BytesUtils.fromHexString(
          "fdb770c3829cf0191ea126b89606b0d4b3823c04f5ce06d6784e47f03517d6a13cd210c3e7f8ce7b057038e70271088c30cd0236c3326c00955b98ae5e781f2a00",
        ),
        signature.signature,
      );
    });
  });

  group("NEAR/Encoding public key", () {
    test('ml-dsa-65', () {
      final keyEncode =
          "ml-dsa-65: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";
      final key = NearPublicKey.deserialize(keyEncode);
      expect(key.type, NearKeyType.mldsa65);
      expect(key.encode(), keyEncode);
    });

    test('Invalid encoded public key', () {
      final keyEncode = "BcpiWNbTo4TB8UmaoY7qg76WhQ5YqKZZR9cjfDCR1V8v";
      expect(
        () => NearPublicKey.deserialize(keyEncode),
        throwsA(isA<BuError>()),
      );
    });

    test('ed25519 public key', () {
      final keyEncode = "ed25519:BcpiWNbTo4TB8UmaoY7qg76WhQ5YqKZZR9cjfDCR1V8v";
      final key = NearPublicKey.deserialize(keyEncode);
      expect(key.type, NearKeyType.ed25519);
      expect(key.encode(), keyEncode);
    });

    test('secp256k1', () {
      final keyEncode =
          "secp256k1:35sdgJST37sAVdXGzHodQtEAWx9PtLMMD4KKSjuMKZNQcf7FosNjx4Mr3GHjoyBk7L5kKLUdnX8ZS6qRdDa3RBai";
      final key = NearPublicKey.deserialize(keyEncode);
      expect(key.type, NearKeyType.secp256k1);
      expect(key.encode(), keyEncode);
    });
  });
  group("NEAR/Encoding secret key", () {
    test('ml-dsa-65', () {
      final keyEncode =
          "ml-dsa-65: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";
      final key = NearSecretKey.deserialize(keyEncode);
      expect(key.type, NearKeyType.mldsa65);
      expect(key.encode(), keyEncode);
    });

    test('ed25519 secret key', () {
      final keyEncode =
          "ed25519:3JYtZLw69h357TD8NeyNbBB8TxiPjUscwqpgdWPg8VQvZQuX6khvEfwSiUp6y8HvSbfVpU2obsmgJY7MVh6qPpiB";
      final key = NearSecretKey.deserialize(keyEncode);
      expect(key.type, NearKeyType.ed25519);
      expect(key.encode(), keyEncode);
    });

    test('secp256k1', () {
      final keyEncode =
          "secp256k1:25cXwqnLHV2so7vCFZoCPLaBCGfEnk4Y6v5NJJMtXKe7FxAiGKfwuqzcGmTF9Ee7Ky2WGv4TS2NhXsS18URq8ogLxwgXY2csHrQSFpbAJFqLGzAtntnpVXUq2QietzMNzMDr";
      final key = NearSecretKey.deserialize(keyEncode);
      expect(key.type, NearKeyType.secp256k1);
      expect(key.encode(), keyEncode);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(cryptoCryptoTest, "Crypto");
}

// Encrypted transaction payload models (Aptos).
//
// Shape-faithful fixtures for the `encrypted_transaction_payload` union:
// still-encrypted, failed-decryption, and successfully-decrypted variants.
// Each case parses, asserts load-bearing fields, and re-serializes with no
// dropped keys.

import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

Map<String, dynamic> _envelope(Map<String, dynamic> payload) {
  return {'type': 'encrypted_transaction_payload', 'payload': payload};
}

void encryptedPayloadTest() {
  group('Aptos/Encrypted payload', () {
    /// Every input key must survive parse -> serialize with an equal value
    /// (`toJson` may add explicit nulls for absent optional fields).
    void expectRoundTrip(Map<String, dynamic> raw) {
      final parsed = AptosApiTransactionPayloadEncrypted.fromJson(raw);
      final out = parsed.toJson();
      final outPayload = out['payload'] as Map;
      final rawPayload = raw['payload'] as Map;
      for (final k in rawPayload.keys) {
        expect(outPayload[k], equals(rawPayload[k]), reason: 'key $k');
      }
      final reparsed = AptosApiTransactionPayloadEncrypted.fromJson(out);
      expect(reparsed.payload.ciphertext, parsed.payload.ciphertext);
    }

    test('still-encrypted payload parses and round-trips', () {
      final raw = _envelope({
        'type': 'encrypted_payload',
        'payload_hash': "0x${'ab' * 32}",
        'ciphertext': "0x${'cd' * 64}",
        'encryption_epoch': '12',
        'claimed_entry_fun': {'module': '0x1::coin', 'name': 'transfer'},
      });
      final parsed = AptosApiTransactionPayloadEncrypted.fromJson(raw);
      expect(
        parsed.payload.type,
        AptosApiEncryptedTransactionPayloadType.encryptedPayload,
      );
      expect(parsed.payload.claimedEntryFunction?.module, '0x1::coin');
      expectRoundTrip(raw);
    });

    test('failed-decryption payload parses and round-trips', () {
      final raw = _envelope({
        'type': 'failed_decryption_payload',
        'payload_hash': "0x${'ab' * 32}",
        'ciphertext': "0x${'cd' * 64}",
        'encryption_epoch': '12',
      });
      final parsed = AptosApiTransactionPayloadEncrypted.fromJson(raw);
      expect(
        parsed.payload.type,
        AptosApiEncryptedTransactionPayloadType.failedDecryptionPayload,
      );
      expect(parsed.payload.claimedEntryFunction, isNull);
      expectRoundTrip(raw);
    });

    test('decrypted payload parses with nonce', () {
      final raw = _envelope({
        'type': 'decrypted_payload',
        'payload_hash': "0x${'ab' * 32}",
        'ciphertext': "0x${'cd' * 64}",
        'encryption_epoch': '12',
        'decryption_nonce': "0x${'00' * 12}",
      });
      final parsed = AptosApiTransactionPayloadEncrypted.fromJson(raw);
      final decrypted = parsed.payload as AptosApiDecryptedPayload;
      expect(decrypted.decryptionNonce, "0x${'00' * 12}");
      expect(decrypted.decryptedPayload, isNull);
      expectRoundTrip(raw);
    });

    test('unknown payload type throws the Aptos exception', () {
      expect(
        () => AptosApiEncryptedTransactionPayload.fromJson({'type': 'nope'}),
        throwsA(isA<BuError>()),
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(encryptedPayloadTest, 'EncryptedPayload');
}

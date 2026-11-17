import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void cryptoAddressTest() {
  group('NEAR/Address', () {
    test('address', () {
      {
        final addr = NearImplicitAddress.fromBytes(
          ED25519PrivateKey.fromBytes(
            QuickCrypto.generateRandom(),
          ).publicKey.toBytes(),
        );
        final decode = BaseNearAddress.deserializeIAddress(
          bytes: addr.encodeAsIAddress(),
        );
        expect(addr, decode);
      }
      {
        final addr = NearNamedAddress('account1.near');
        final decode = BaseNearAddress.deserializeIAddress(
          bytes: addr.encodeAsIAddress(),
        );
        expect(addr, decode);
      }
      {
        final addr = BaseNearAddress('account1.near');
        expect(addr, isA<NearNamedAddress>());
      }
      {
        final addr = BaseNearAddress(
          BytesUtils.toHexString(
            ED25519PrivateKey.fromBytes(
              QuickCrypto.generateRandom(),
            ).publicKey.toBytes(),
          ),
        );
        expect(addr, isA<NearImplicitAddress>());
      }
      {
        expect(
          () => BaseNearAddress(QuickCrypto.generateRandomHex(33)),
          throwsA(isA<BuError>()),
        );
      }
      {
        for (final valid in [
          'account1.near',
          'alice.near',
          'a-b_c.near',
          'a.b.near',
        ]) {
          expect(NearNamedAddress.isValidAccountId(valid), true, reason: valid);
          expect(BaseNearAddress(valid), isA<NearNamedAddress>());
        }
        for (final invalid in [
          '',
          'a',
          '.alice',
          'alice.',
          'alice..near',
          '-alice.near',
          'alice-.near',
          '_alice.near',
          'ALICE.near',
          'alice .near',
          ('a' * 65),
        ]) {
          expect(
            NearNamedAddress.isValidAccountId(invalid),
            false,
            reason: invalid,
          );
          expect(() => NearNamedAddress(invalid), throwsA(isA<BuError>()));
        }
      }
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(cryptoAddressTest, "Address");
}

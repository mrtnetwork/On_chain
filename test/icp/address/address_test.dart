import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/icp.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void icpAddressAddressTest() {
  group('ICP/Address', () {
    test("Address", () {
      {
        final addr = IcpPrincipalAddress.fromBytes([
          ...QuickCrypto.generateRandom(length: 28),
          0x02,
        ]);
        final decode = IcpPrincipalAddress.deserializeIAddress(
          bytes: addr.encodeAsIAddress(),
        );
        expect(addr, decode);
      }
      {
        final r = QuickCrypto.generateRandom(length: 28);
        final addr = IcpAccountIdentifier.fromBytes([
          ...Crc32().checksum(r),
          ...r,
        ]);
        final decode = BaseIcpAddress.deserializeIAddress(
          bytes: addr.encodeAsIAddress(),
        );
        expect(addr, decode);
      }
    });
    test("Invalid address bytes", () {
      {
        expect(
          () => IcpPrincipalAddress.fromBytes(
            QuickCrypto.generateRandom(length: 33),
          ),
          throwsA(isA<BuError>()),
        );

        expect(
          () => IcpAccountIdentifier.fromBytes(
            QuickCrypto.generateRandom(length: 33),
          ),
          throwsA(isA<BuError>()),
        );
      }
    });
    test("Invalid address", () {
      {
        expect(() => BaseIcpAddress("0-x"), throwsA(isA<BuError>()));
      }
      {
        expect(() => BaseIcpAddress("0x${'0' * 62}"), throwsA(isA<BuError>()));
      }
    });

    test("Valid address", () {
      {
        final addr = BaseIcpAddress("qaa6y-5yaaa-aaaaa-aaafa-cai");
        expect(addr.type, ICPAddressType.principal);
      }
      {
        final addr = IcpPrincipalAddress.fromBytes([]);
        expect(addr, IcpPrincipalAddress.management);
      }
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(icpAddressAddressTest, "Address");
}

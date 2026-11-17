import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/fil.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void testAddressTest() {
  group("Filecoin/Address", () {
    test("invalid", () {
      // final addr = ;
      expect(
        () => FilAddress.fromBytes(BigInt.one.toBeBytes()),
        throwsA(isA<BuError>()),
      );
      final g = FilAddress.fromBytes([
        FilAddrType.id.value,
        ...BigInt.one.toBeBytes(),
      ]);
      expect(g.address, "f01");
    });
    test("id", () {
      final addr = FilAddress("f03649217");
      expect(addr.network, FilNetwork.mainnet);
      expect(addr.type, FilAddrType.id);
    });
    test("t01", () {
      final addr = FilAddress.one(network: FilNetwork.testnet);
      expect(addr.address, "t01");
    });
    test("f01", () {
      final addr = FilAddress.one();
      expect(addr.address, "f01");
    });
    test("bls", () {
      final addr = FilAddress(
        "f3wqtrxyee6klaakuywwb34beagz5ijicx7twwe7ie7ulnwjn66qbwosrf3y775gb7ctt6gjtklr42hhsczijq",
      );
      expect(addr.network, FilNetwork.mainnet);
      expect(addr.type, FilAddrType.bls);
      final decode = FilAddress.deserializeIAddress(
        bytes: addr.encodeAsIAddress(),
      );
      expect(decode, addr);
    });
    test("bls", () {
      final addr = FilAddress(
        "t3w4jcqhfsdi4xoumokqgr5epof3huagj76gkzh3wlcn2pyp2zck2he6bhgmq3okflt65ry7btt2qkn7cgulra",
      );
      expect(addr.network, FilNetwork.testnet);
      expect(addr.type, FilAddrType.bls);
      final decode = FilAddress.deserializeIAddress(
        bytes: addr.encodeAsIAddress(),
      );
      expect(decode, addr);
    });
    test("secp256k1", () {
      final addr = FilAddress("f17sqoy7fvvdlpaffbsgv6rigonmqs3zulpd6tdxa");
      expect(addr.network, FilNetwork.mainnet);
      expect(addr.type, FilAddrType.secp256k1);
      final decode = FilAddress.deserializeIAddress(
        bytes: addr.encodeAsIAddress(),
      );
      expect(decode, addr);
    });
    test("secp256k1", () {
      final addr = FilAddress("t1ruziyrso3vejdggcnnyg5wmpwsdqkl5gyo5prua");
      expect(addr.network, FilNetwork.testnet);
      expect(addr.type, FilAddrType.secp256k1);
      final decode = FilAddress.deserializeIAddress(
        bytes: addr.encodeAsIAddress(),
      );
      expect(decode, addr);
    });
    test("ethereum conversions", () {
      // ID -> masked.
      final id = FilAddress("t01");
      final masked = id.toEthereumAddress();
      expect(masked.isMasked, true);
      expect(masked.address.toLowerCase(), "0xff${'00' * 11}0000000000000001");
      final backDispatch = FilAddress.fromEthereum(
        masked,
        network: FilNetwork.testnet,
      );
      expect(backDispatch.address, "t01");
      // Plain 0x -> delegated f410.
      final plain = FilEthereumAddress(
        "0x942b358d6a10c7f3988d0e2d69cf16029f731d02",
      );
      expect(plain.isMasked, false);
      final f410 = plain.toFilAddress(network: FilNetwork.testnet);
      expect(f410.type, FilAddrType.delegated);
      final f410Dispatch = FilAddress.fromEthereum(
        plain,
        network: FilNetwork.testnet,
      );
      expect(f410Dispatch.address, f410.address);
      // Delegated f410 -> plain 0x.
      final fwd = f410.toEthereumAddress();
      expect(fwd.isMasked, false);
      expect(fwd.address.toLowerCase(), plain.address.toLowerCase());
      // Non-ID native -> throws.
      final t1 = FilAddress("t1ruziyrso3vejdggcnnyg5wmpwsdqkl5gyo5prua");
      expect(() => t1.toEthereumAddress(), throwsA(isA<BuError>()));
      // Base dispatch.
      expect(BaseFilAddress("t01"), isA<FilAddress>());
      expect(BaseFilAddress(plain.address), isA<FilEthereumAddress>());
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(testAddressTest, "Address");
}

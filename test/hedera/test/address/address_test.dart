import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/hedera/src/address/src/address.dart';
import 'package:on_chain/hedera/src/crypto/crypto.dart';
import 'package:on_chain/hedera/src/types/network.dart';
import 'package:test/test.dart';

import '../../../utils.dart';

void addressAddressTest() {
  group('Hedera/Address', () {
    test('ETH address', () {
      final eth = ETHAddress.fromBytes(QuickCrypto.generateRandom(length: 20));
      final addr = HederaAddress("0.0.${eth.address.substring(2)}");
      expect(addr.entity.ethAddress, eth);
    });
    test('On-chain address', () {
      final addr = HederaAddress("0.0.1");
      expect(addr.entity.realm, BigInt.zero);
      expect(addr.entity.shard, BigInt.zero);
      expect(addr.entity.num, BigInt.one);
    });

    test("Checksum", () {
      expect(
        HederaAddress("0.0.9987629").withChecksum(HederaNetwork.testnet),
        "0.0.9987629-hdclt",
      );
      expect(
        HederaAddress(
          "0.0.9987629-hdclt",
          network: HederaNetwork.testnet,
        ).withChecksum(HederaNetwork.testnet),
        "0.0.9987629-hdclt",
      );
    });
    test("Deserialize", () {
      final addr = HederaAddress("0.0.9987629");
      expect(
        HederaAddress.deserializeIAddress(bytes: addr.encodeAsIAddress()),
        addr,
      );
    });
    test("To Ethereum", () {
      final addr = HederaAddress("0.0.9987794");
      expect(
        addr.toEthereumAddress(),
        ETHAddress("0x00000000000000000000000000000000009866d2"),
      );
    });
    test("From Ethereum address", () {
      final addr = ETHAddress("0x00000000000000000000000000000000009866d2");
      expect(HederaAddress.fromEthAddress(addr), HederaAddress("0.0.9987794"));
      expect(
        HederaAddress("0.0.00000000000000000000000000000000009866d2"),
        HederaAddress("0.0.9987794"),
      );
    });
    test("Key alias", () {
      final addr = HederaAddress(
        "0.0.5fe3560aadfd97586e3ed1628d14f3165e3fd1a7f18780d62a43294934367a0e",
      );
      expect(
        addr.entity.keyAlias?.toBytes(),
        BytesUtils.fromHexString(
          "0x5fe3560aadfd97586e3ed1628d14f3165e3fd1a7f18780d62a43294934367a0e",
        ),
      );
      expect(addr.entity.keyAlias?.type, HederaKeyType.ed25519);
    });
    test("Invalid address", () {
      expect(() => HederaAddress("0.0.-9987794"), throwsA(isA<BuError>()));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(addressAddressTest, "Address");
}

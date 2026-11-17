import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/account/account/multi_sig.dart';
import 'package:on_chain/algorand/src/crypto/keypair/public_key/ed25519.dart';
import 'package:test/test.dart';

import '../../utils.dart';
void algoAddressAddressTest() {
  group('Algorand/Address', () {
    test('algorand IAddress', () {
      final address = AlgoAddress.fromBytes(QuickCrypto.generateRandom());
      final decode = AlgoAddress.deserializeIAddress(
        bytes: address.encodeAsIAddress(),
      );
      expect(address, decode);
    });
    test('application address', () {
      final address = AlgoAddress.fromAppId(BigInt.from(77));
      expect(
        address,
        AlgoAddress(
          "PCYUFPA2ZTOYWTP43MX2MOX2OWAIAXUDNC2WFCXAGMRUZ3DYD6BWFDL5YM",
        ),
      );
    });
    test('multisig', () {
      final account = AlgoMultiEd25519AccountPublicKey(
        publicKeys: [
          AlgoEd25519PublicKey.fromBytes(
            AlgoAddress(
              "XMHLMNAVJIMAW2RHJXLXKKK4G3J3U6VONNO3BTAQYVDC3MHTGDP3J5OCRU",
            ).toBytes(),
          ),
          AlgoEd25519PublicKey.fromBytes(
            AlgoAddress(
              "HTNOX33OCQI2JCOLZ2IRM3BC2WZ6JUILSLEORBPFI6W7GU5Q4ZW6LINHLA",
            ).toBytes(),
          ),
          AlgoEd25519PublicKey.fromBytes(
            AlgoAddress(
              "E6JSNTY4PVCY3IRZ6XEDHEO6VIHCQ5KGXCIQKFQCMB2N6HXRY4IB43VSHI",
            ).toBytes(),
          ),
        ],
        threshold: 2,
      );
      expect(
        account.toAddress().address,
        "UCE2U2JC4O4ZR6W763GUQCG57HQCDZEUJY4J5I6VYY4HQZUJDF7AKZO5GM",
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(algoAddressAddressTest, "Address");
}


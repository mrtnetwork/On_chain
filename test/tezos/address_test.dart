import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/tezos.dart';
import 'package:test/test.dart';

import '../utils.dart';

void tezosAddressTest() {
  group('Tezos/IAddress', () {
    test('iAddress', () {
      {
        for (final i in XtzAddrPrefixes.values) {
          final addr = TezosAddress.fromBytes(
            QuickCrypto.generateRandom(length: 20),
            type: i,
          );
          final decode = TezosAddress.deserializeIAddress(
            bytes: addr.encodeAsIAddress(),
          );
          expect(decode, addr);
          expect(decode.type, i);
        }
      }
    });
  });
  group('Tezos/Secret key Base58 encoding / decoding', () {
    test('edsk 64-byte expanded secret key — pytezos tutorial', () {
      const b58 =
          'edskRwA8M7ZDQfRwt2bEUi2TxpbdDYYfLLYNHB8qMYX3kDD8srM5P4NDuMpkDk3oHFrxP4q6Yyw26t55TMQ7sbaKdKETpZtUyR';
      final decode = TezosSecretKey.decode(b58);
      expect(decode.type, TezosKeyType.ed25519);
      expect(decode.cast<TezosEd25519SecretKey>().encode(expanded: true), b58);
    });
  });

  group('Tezos/Prefix auto-detection sanity checks', () {
    test('test vector', () {
      final secrets = {
        'edsk34AV748RcC45ZgnUpky8qgBkus19wZA8hAL8dDyLrihsrnVbdT': 'edsk',
        'edsk2fuNzt29dPBwrTvES5JiKxLM8p4VTcKDF2oFZiwfJLEocqv1rb': 'edsk',
        'spsk1fiPFiC16wgdEgPP3eJm5guuognXnDpRRFVy32195A81f1nzoo': 'spsk',
        'p2sk3zqDakap9bXEqsTr4sM93ZehELQNGCMX1MXmBsJUi29tFQYijV': 'p2sk',
        'p2sk2q67S7xxYR8imTB6Ck2BbQ7aa7NFHDk7ifVLr4notJ5FGtUSPe': 'p2sk',
        'BLsk2EMkJsCG1pSP8Ud4QWeLT955RgVD1JPqPBM2H5zsj9CaKW37vv': 'BLsk',
      };

      final pubs = {
        'edpku61nGAwkeoA7PQJEFWmrVP1eWrSTVoHgCaF2isjWqDeGdux37k': 'edpk',
        'sppk7czKu6So3zDWjhBPBv9wgCrBAfbEFoKYzEaKUsjhNr5Ug6E4Sn1': 'sppk',
        'p2pk67BANWUUX2fod9EQbv8ev7GGLpb4UXvLHEVVMiHBSWPHgyzf1tv': 'p2pk',
        'BLpk1wiReQSN3PzrwQafTtFD4szTnszesNPSaro3q2myQETj2BH1HUUA76VytNqD8YczqX1DyX8t':
            'BLpk',
      };

      for (final e in secrets.entries) {
        final sk = TezosSecretKey.decode(e.key);
        expect(sk.encode(), e.key);
      }
      for (final e in pubs.entries) {
        final pk = TezosPublicKey.decode(e.key);
        expect(pk.encode(), e.key);
      }
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(tezosAddressTest, "Address");
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/crypto/cid/cid.dart';
import 'package:test/test.dart';

import '../../utils.dart';

// import your Multihash, CidBuilder, Multicodec, UVarint

void cidTest() {
  group('Filecoin/Multihash', () {
    // digest = blake2b-256("test") is not required; use fixed digest vector
    const digestHex =
        'f3331d4e3bc7d67f76e8d451ef7b9e32f216935a2dfa9b2d1397b359bfc9644e';
    final digest = _hexDecode(digestHex);

    test('blake2b-256 toBytes matches Filecoin multihash prefix', () {
      final mh = Multihash.blake2b256(digest);
      final bytes = mh.toBytes();

      // code 0xb220 → a0 e4 02, len 32 → 20, then digest
      expect(bytes.sublist(0, 4), [0xa0, 0xe4, 0x02, 0x20]);
      expect(bytes.sublist(4), digest);
      expect(bytes.length, 4 + 32);
    });

    test('fromBytes round-trip blake2b-256', () {
      final original = Multihash.blake2b256(digest);
      final decoded = Multihash.fromBytes(original.toBytes());
      expect(decoded.code.tryAsSafeInt, Multicodec.blake2b_256);
      expect(decoded.digest, digest);
      expect(decoded.length, 32);
    });

    test('sha2-256 multihash (CIDv0 style)', () {
      // empty sha2-256
      final emptySha256 = _hexDecode(
        'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      );
      final mh = Multihash.sha2256(emptySha256);
      final bytes = mh.toBytes();
      // 0x12 0x20 || digest
      expect(bytes[0], 0x12);
      expect(bytes[1], 0x20);
      expect(bytes.sublist(2), emptySha256);

      final again = Multihash.fromBytes(bytes);
      expect(again.code.tryAsSafeInt, Multicodec.sha2_256);
      expect(again.digest, emptySha256);
    });

    test('invalid digest length throws', () {
      expect(
        () => Multihash.blake2b256([1, 2, 3]),
        throwsA(isA<BuError>()),
      );
      expect(
        () => Multihash.sha2256([1, 2, 3]),
        throwsA(isA<BuError>()),
      );
    });

    test('truncated multihash throws', () {
      expect(
        () => Multihash.fromBytes([0x12, 0x20, 0x01]), // claims 32 bytes
        throwsA(isA<BuError>()),
      );
    });
  });

  group('Filecoin/CidBuilder', () {
    // Known CIDv1: dag-cbor + blake2b-256 (from Lotus-style message CID bytes)
    // binary: 01 71 a0 e4 02 20 || digest
    const digestHex =
        'f3331d4e3bc7d67f76e8d451ef7b9e32f216935a2dfa9b2d1397b359bfc9644e';
    final digest = _hexDecode(digestHex);
    final v1Binary = <int>[
      0x01, // version
      0x71, // dag-cbor
      0xa0, 0xe4, 0x02, // blake2b-256 code
      0x20, // len 32
      ...digest,
    ];

    test('CIDv1 fromBinary and toBinary round-trip', () {
      final cid = CidBuilder.fromBinary(v1Binary);
      expect(cid.version, CidVersion.v1);
      expect(cid.codec.tryAsSafeInt, Multicodec.dagCbor);
      expect(cid.multihash.code.tryAsSafeInt, Multicodec.blake2b_256);
      expect(cid.multihash.digest, digest);
      expect(cid.toBinary(), v1Binary);
      expect(cid.value.startsWith('b'), isTrue);
    });

    test('CIDv1 parse string round-trip', () {
      final cid1 = CidBuilder.fromBinary(v1Binary);
      final cid2 = CidBuilder.parse(cid1.value);
      expect(cid2.value, cid1.value);
      expect(cid2.toBinary(), v1Binary);
      expect(cid2.codec.tryAsSafeInt, Multicodec.dagCbor);
    });

    test('CIDv1 toCbor / fromCbor tag 42', () {
      final cid = CidBuilder.fromBinary(v1Binary);
      final cbor = cid.toCbor();

      // Must be tag 42
      expect(cbor, isA<CborTagValue>());
      final tag = cbor as CborTagValue;
      // adapt to your API:
      // final tags = (tag as dynamic).tags ?? [(tag as dynamic).tag];
      // final tagList = tags is List ? tags : [tags];
      expect(tag.tags, [42]);

      final inner = tag.value as CborBytesValue;
      final payload = inner.value;
      expect(payload.first, 0x00); // identity multibase
      expect(payload.sublist(1), v1Binary);

      final restored = CidBuilder.fromCbor(cbor);
      expect(restored.value, cid.value);
      expect(restored.toBinary(), v1Binary);
    });

    test('filecoinDagCbor helper matches blake2b + dag-cbor', () {
      final body = [0xa1, 0x61, 0x61, 0x01]; // tiny CBOR map {"a":1} example
      final cid = CidBuilder.filecoinDagCbor(body);
      expect(cid.version, CidVersion.v1);
      expect(cid.codec.tryAsSafeInt, Multicodec.dagCbor);
      expect(cid.multihash.code.tryAsSafeInt, Multicodec.blake2b_256);
      expect(cid.multihash.digest.length, 32);

      // signing payload = binary CID (no tag)
      final signBytes = cid.toBinary();
      expect(signBytes[0], 0x01);
      expect(signBytes[1], 0x71);
      expect(signBytes.sublist(2, 5), [0xa0, 0xe4, 0x02]);
    });

    // Classic CIDv0: sha2-256 of empty → QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn
    // (IPFS empty unixfs directory is different; use empty digest Qm…)
    test('CIDv0 from sha2-256 empty digest', () {
      final emptySha256 = _hexDecode(
        'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      );
      final cid = CidBuilder.v0(emptySha256);
      expect(cid.version, CidVersion.v0);
      expect(cid.codec.tryAsSafeInt, Multicodec.dagPb);
      expect(cid.multihash.code.tryAsSafeInt, Multicodec.sha2_256);
      expect(cid.value.startsWith('Qm'), isTrue);
      expect(cid.toBinary(), Multihash.sha2256(emptySha256).toBytes());

      final parsed = CidBuilder.parse(cid.value);
      expect(parsed.version, CidVersion.v0);
      expect(parsed.multihash.digest, emptySha256);
    });

    test(
      'CIDv0 known vector QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG',
      () {
        // Well-known CIDv0 (hello world directory in IPFS docs / fixtures)
        const s = 'QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG';
        final cid = CidBuilder.parse(s);
        expect(cid.version, CidVersion.v0);
        expect(cid.codec.tryAsSafeInt, Multicodec.dagPb);
        expect(cid.multihash.code.tryAsSafeInt, Multicodec.sha2_256);
        expect(cid.multihash.length, 32);
        expect(cid.value, s);

        final again = CidBuilder.parse(
          CidBuilder.fromBinary(cid.toBinary()).value,
        );
        // v0 from binary may re-encode same multihash as Qm...
        expect(again.multihash.digest, cid.multihash.digest);
      },
    );

    test('validate accepts good CIDs', () {
      final v1 = CidBuilder.fromBinary(v1Binary);
      expect(() => v1.validate(), returnsNormally);

      final emptySha256 = _hexDecode(
        'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      );
      final v0 = CidBuilder.v0(emptySha256);
      expect(() => v0.validate(), returnsNormally);
    });

    test('parse rejects garbage', () {
      expect(
        () => CidBuilder.parse('not-a-cid'),
        throwsA(isA<BuError>()),
      );
      expect(() => CidBuilder.parse(''), throwsA(isA<BuError>()));
    });

    test('fromJson IPLD link object', () {
      final cid = CidBuilder.fromBinary(v1Binary);
      final json = {'/': cid.value};
      final parsed = CidBuilder.fromJson(json);
      expect(parsed.value, cid.value);
      expect(parsed.toJson(), json);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(cidTest, "Cid");
}

List<int> _hexDecode(String hex) {
  return BytesUtils.fromHexString(hex);
}

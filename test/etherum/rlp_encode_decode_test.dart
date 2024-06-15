import 'package:on_chain/ethereum/ethereum.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("test 1", () {
    final obj = [
      <int>[1, 56, 129],
      <int>[19],
      <int>[126, 94, 63, 75],
      <int>[126, 94, 63, 90],
      <int>[83, 216],
      <int>[
        191,
        211,
        101,
        55,
        63,
        85,
        156,
        211,
        152,
        164,
        8,
        185,
        117,
        253,
        24,
        177,
        102,
        50,
        211,
        72
      ],
      <int>[23, 72, 118, 232, 0],
      <int>[
        104,
        116,
        116,
        112,
        115,
        58,
        47,
        47,
        103,
        105,
        116,
        104,
        117,
        98,
        46,
        99,
        111,
        109,
        47,
        109,
        114,
        116,
        110,
        101,
        116,
        119,
        111,
        114,
        107
      ],
      <dynamic>[]
    ];
    final encode = RLPEncoder.encode(obj);
    expect(BytesUtils.toHexString(encode),
        "f84c8301388113847e5e3f4b847e5e3f5a8253d894bfd365373f559cd398a408b975fd18b16632d34885174876e8009d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726bc0");
    final decode = RLPDecoder.decode(encode);
    for (int i = 0; i < decode.length; i++) {
      expect(
          CompareUtils.iterableIsEqual(decode.elementAt(i), obj.elementAt(i)),
          true);
    }
  });

  test("test 2", () {
    final obj = [
      <int>[20],
      <int>[117, 197, 176, 81],
      <int>[83, 216],
      <int>[
        191,
        211,
        101,
        55,
        63,
        85,
        156,
        211,
        152,
        164,
        8,
        185,
        117,
        253,
        24,
        177,
        102,
        50,
        211,
        72
      ],
      <int>[23, 72, 118, 232, 0],
      <int>[
        104,
        116,
        116,
        112,
        115,
        58,
        47,
        47,
        103,
        105,
        116,
        104,
        117,
        98,
        46,
        99,
        111,
        109,
        47,
        109,
        114,
        116,
        110,
        101,
        116,
        119,
        111,
        114,
        107
      ],
      <int>[2, 113, 37],
      <int>[
        237,
        83,
        204,
        44,
        218,
        90,
        58,
        192,
        217,
        85,
        164,
        71,
        184,
        210,
        43,
        17,
        239,
        31,
        48,
        41,
        124,
        55,
        22,
        36,
        41,
        111,
        48,
        167,
        204,
        109,
        50,
        149
      ],
      <int>[
        27,
        233,
        34,
        67,
        4,
        40,
        10,
        200,
        182,
        0,
        156,
        30,
        149,
        16,
        245,
        122,
        3,
        50,
        122,
        248,
        0,
        220,
        237,
        36,
        24,
        207,
        158,
        201,
        123,
        47,
        142,
        11
      ]
    ];
    final encode = RLPEncoder.encode(obj);
    expect(BytesUtils.toHexString(encode),
        "f888148475c5b0518253d894bfd365373f559cd398a408b975fd18b16632d34885174876e8009d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b83027125a0ed53cc2cda5a3ac0d955a447b8d22b11ef1f30297c371624296f30a7cc6d3295a01be9224304280ac8b6009c1e9510f57a03327af800dced2418cf9ec97b2f8e0b");
    final decode = RLPDecoder.decode(encode);
    for (int i = 0; i < decode.length; i++) {
      expect(
          CompareUtils.iterableIsEqual(decode.elementAt(i), obj.elementAt(i)),
          true);
    }
  });
}

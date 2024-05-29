void main() {}
// // https://github.com/solana-labs/buffer-layout/tree/master/test
// import 'package:blockchain_utils/blockchain_utils.dart';
// import 'package:blockchain_utils/layout/layout.dart';
// import 'package:test/scaffolding.dart';
// import 'package:test/expect.dart';

// void main() {
//   roundedUInt64();
//   roundedSigned64();
//   testIntBe();
//   testIntLe();
//   testUintBe();
//   testUint();
//   float();
//   testDouble();
//   sequence();
//   prefix();
//   replicate();
//   variantLayout();

//   greedyCount();
//   offsetLayout();
//   unionDiscriminator();
//   c();
// }

// void c() {
//   test('ctor', () {
//     final c = ConstantLayout('value', property: 'p');
//     expect(c.value, 'value');
//     expect(c.property, 'p');
//     expect(c.span, 0);
//   });
//   test('basics', () {
//     final b = LayoutByteWriter.filled(0, 0);
//     expect(LayoutConst.constant(true).decode(b.toBytes()), true);
//     expect(LayoutConst.constant(null).decode(b.toBytes()), null);
//     const obj = {"a": 23};
//     expect(LayoutConst.constant(obj).decode(b.toBytes()), obj);
//     expect(LayoutConst.constant(32).encode(0, b), 0);
//     expect(b.length, 0);
//   });
// }

// void utf() {
//   test('ctor', () {
//     final cst = LayoutConst.utf8();
//     assert(0 > cst.span);
//     expect(cst.maxSpan, -1);
//   });
//   test('ctor with maxSpan', () {
//     final cst = LayoutConst.utf8(maxSpan: 5);
//     expect(cst.maxSpan, 5);
//   });

//   test('#getSpan', () {
//     final cst = UTF8();
//     expect(cst.getSpan(BytesUtils.fromHexString('00')), 1);
//     expect(cst.getSpan(BytesUtils.fromHexString('4100')), 2);
//     expect(cst.getSpan(BytesUtils.fromHexString('4100'), offset: 1), 1);
//     expect(cst.getSpan(BytesUtils.fromHexString('4142')), 2);
//   });
//   test('#decode', () {
//     final cst = UTF8(maxSpan: 3);
//     expect(cst.decode(BytesUtils.fromHexString('00')), '\x00');
//     expect(cst.decode(BytesUtils.fromHexString('4100')), 'A\x00');
//     expect(cst.decode(BytesUtils.fromHexString('4100'), offset: 1), '\x00');
//     expect(cst.decode(BytesUtils.fromHexString('4142')), 'AB');
//   });
//   test('#encode', () {
//     final cst = UTF8();
//     final b = LayoutByteWriter.filled(3, 0xFF);

//     expect(cst.encode('', b), 0);
//     expect(bytesEqual(BytesUtils.fromHexString('ffffff'), b.toBytes()), true);
//     expect(cst.encode('A', b), 1);
//     expect(bytesEqual(BytesUtils.fromHexString('41ffff'), b.toBytes()), true);

//     expect(cst.encode('B', b, offset: 1), 1);
//     expect(bytesEqual(BytesUtils.fromHexString('4142ff'), b.toBytes()), true);

//     expect(cst.encode("5", b), 1);
//     expect(bytesEqual(BytesUtils.fromHexString('3542ff'), b.toBytes()), true);

//     expect(cst.encode('abc', b), 3);
//     expect(bytesEqual(BytesUtils.fromHexString('616263'), b.toBytes()), true);
//   });

//   test('in LayoutConst.struct', () {
//     final st = LayoutConst.struct(
//         [LayoutConst.utf8(property: 'k'), LayoutConst.utf8(property: 'v')]);
//     final b = LayoutByteWriter.fromHex('6162323334');
//     expect(st.fields[0].getSpan(b.toBytes()), b.length);
//     expect(st.fields[1].getSpan(b.toBytes(), offset: 2), b.length - 2);

//     expect(st.getSpan(b.toBytes()), b.length);
//     expect(st.decode(b.toBytes()), {"k": 'ab234', "v": ''});
//   });
//   test('in LayoutConst.seq', () {
//     final seqq = LayoutConst.seq(LayoutConst.utf8(), ConstantLayout(3));
//     final b = LayoutByteWriter.fromHex('4162633435');
//     expect(seqq.decode(b.toBytes()), ['Abc45', '', '']);
//     b.fillRange(0, b.length, 0xFF);
//     expect(seqq.encode(['hi', 'u', 'c'], b), 2 + 1 + 1);
//     expect(
//         bytesEqual(BytesUtils.fromHexString('68697563ff'), b.toBytes()), true);
//   });
// }

// void cString() {
//   test('in LayoutConst.seq', () {
//     final seqq = LayoutConst.seq(LayoutConst.cstr(), ConstantLayout(3));
//     final b = LayoutByteWriter.fromHex('61006263003500');
//     expect(seqq.decode(b.toBytes()), ['a', 'bc', '5']);
//     expect(seqq.encode(['hi', 'u', 'c'], b), (1 + 1) + (2 + 1) + (1 + 1));
//     expect(bytesEqual(BytesUtils.fromHexString("68690075006300"), b.toBytes()),
//         true);
//   });
//   test('in LayoutConst.struct', () {
//     final st = LayoutConst.struct(
//         [LayoutConst.cstr(property: 'k'), LayoutConst.cstr(property: 'v')]);
//     final b = LayoutByteWriter.fromHex('6100323300');
//     expect(st.fields[0].getSpan(b.toBytes()), 2);
//     expect(st.fields[1].getSpan(b.toBytes(), offset: 2), 3);
//     expect(st.getSpan(b.toBytes()), 5);
//     expect(st.decode(b.toBytes()), {"k": 'a', "v": '23'});
//     b.fillRange(0, b.length, 0xff);
//     expect(st.encode({"k": 'a', "v": 23}, b), (1 + 1) + (2 + 1));
//   });
//   test('#encode', () {
//     final cst = CString();
//     final b = LayoutByteWriter.filled(4, 0xFF);

//     expect(StringUtils.encode('A').length, 1);
//     expect(cst.encode('', b), 1);

//     expect(bytesEqual(BytesUtils.fromHexString('00ffffff'), b.toBytes()), true);
//     expect(cst.encode('A', b), 1 + 1);

//     expect(bytesEqual(BytesUtils.fromHexString('4100ffff'), b.toBytes()), true);
//     expect(cst.encode('B', b, offset: 1), 1 + 1);
//     expect(bytesEqual(BytesUtils.fromHexString('414200ff'), b.toBytes()), true);
//     expect(cst.encode("5", b), 1 + 1);
//     expect(bytesEqual(BytesUtils.fromHexString('350000ff'), b.toBytes()), true);
//   });
//   test('#decode', () {
//     final cst = CString();
//     expect(cst.decode(BytesUtils.fromHexString('00')), '');
//     expect(cst.decode(BytesUtils.fromHexString('4100')), 'A');
//     expect(cst.decode(BytesUtils.fromHexString('4100'), offset: 1), '');
//     expect(cst.decode(BytesUtils.fromHexString('4142')), 'AB');
//   });
//   test('#getSpan', () {
//     final cst = CString();
//     expect(cst.getSpan(BytesUtils.fromHexString('00')), 1);
//     expect(cst.getSpan(BytesUtils.fromHexString('4100')), 2);
//     expect(cst.getSpan(BytesUtils.fromHexString('4100'), offset: 1), 1);
//     expect(cst.getSpan(BytesUtils.fromHexString('4142')), 3);
//   });
// }

// void factories() {
//   test('anon', () {
//     final ver = LayoutConst.u8(property: 'ver');
//     final pld = LayoutConst.union(LayoutConst.offset(ver, -ver.span),
//         defaultLayout: LayoutConst.blob(8, property: 'LayoutConst.blob'));
//     expect(pld.defaultLayout?.property, 'LayoutConst.blob');
//   });
// }

// void issue() {
//   test('anon', () {
//     final ver = LayoutConst.u8(property: 'ver');
//     final hdr = StructLayout(
//         [LayoutConst.u8(property: 'id'), LayoutConst.u8(property: 'ver')]);
//     final pld = Union(LayoutConst.offset(ver, -ver.span),
//         defaultLayout: RawBytesLayout(8, property: 'LayoutConst.'));
//     final expectedBlob = BytesUtils.fromHexString('1011121314151617');
//     final b = LayoutByteWriter.fromHex('01021011121314151617');
//     expect(hdr.decode(b.toBytes()), {"id": 1, "ver": 2});
//     final du = pld.decode(b.toBytes(), offset: 2);
//     expect(du["ver"], 2);
//     expect(bytesEqual(expectedBlob, du["LayoutConst.blob"]), true);
//     pld.addVariant(
//         variant: 2,
//         layout: SequenceLayout(
//             elementLayout: LayoutConst.u32(),
//             count: ConstantLayout(2),
//             property: 'LayoutConst.u32'),
//         property: 'v3');
//     expect(pld.decode(b.toBytes(), offset: 2), {
//       "v3": [0x13121110, 0x17161514]
//     });
//   });

//   test('named', () {
//     final ver = LayoutConst.u8(property: 'ver');
//     final hdr = StructLayout(
//         [LayoutConst.u8(property: 'id'), LayoutConst.u8(property: 'ver')],
//         property: 'hdr');
//     final pld = Union(LayoutConst.offset(ver, -ver.span),
//         defaultLayout: RawBytesLayout(8, property: 'LayoutConst.blob'),
//         property: 'u');
//     final pkt = StructLayout([hdr, pld], property: 's');
//     final expectedBlob = BytesUtils.fromHexString('1011121314151617');
//     final b = LayoutByteWriter.fromHex('01021011121314151617');
//     expect(hdr.decode(b.toBytes()), {"id": 1, "ver": 2});
//     final du = pld.decode(b.toBytes(), offset: 2);
//     expect(du["ver"], 2);
//     expect(bytesEqual(expectedBlob, du["LayoutConst.blob"]), true);
//     var dp = pkt.decode(b.toBytes());
//     expect(dp["hdr"], {"id": 1, "ver": 2});
//     expect(dp["u"]["ver"], 2);
//     expect(bytesEqual(expectedBlob, dp["u"]["LayoutConst.blob"]), true);

//     pld.addVariant(
//         variant: 2,
//         layout: SequenceLayout(
//             elementLayout: LayoutConst.u32(),
//             count: ConstantLayout(2),
//             property: 'LayoutConst.u32'),
//         property: 'v3');
//     expect(pld.decode(b.toBytes(), offset: 2), {
//       "v3": [0x13121110, 0x17161514]
//     });

//     dp = pkt.decode(b.toBytes());
//     expect(dp, {
//       "hdr": {"id": 1, "ver": 2},
//       "u": {
//         "v3": [0x13121110, 0x17161514]
//       }
//     });
//   });
// }

// void blb() {
//   test('LayoutConst.greedy', () {
//     final blo = LayoutConst.blob(LayoutConst.greedy(), property: 'b');
//     final b = LayoutByteWriter.from(StringUtils.encode('ABCDx'));
//     expect(
//         bytesEqual(StringUtils.encode("ABCDx"), blo.decode(b.toBytes())), true);
//     expect(
//         bytesEqual(
//             StringUtils.encode("Dx"), blo.decode(b.toBytes(), offset: 3)),
//         true);

//     b.fillRange(0, b.length, 0);
//     expect(blo.encode(BytesUtils.fromHexString('0203'), b, offset: 2), 2);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("0000020300"), b.toBytes()), true);
//   });
//   test('final length', () {
//     final llo = LayoutConst.u8(property: 'l');
//     final blo = LayoutConst.blob(LayoutConst.offset(llo, -1), property: 'b');
//     final st = LayoutConst.struct([llo, blo]);
//     final b = LayoutByteWriter.filled(10, 0);
//     assert(0 > st.span);

//     expect(blo.length.layout, llo);
//     expect(st.encode({"b": BytesUtils.fromHexString('03040506')}, b),
//         llo.span + 4);
//     final span = st.getSpan(b.toBytes());
//     expect(span, 5);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("0403040506"),
//             b.toBytes().sublist(0, span)),
//         true);

//     final obj = st.decode(b.toBytes());
//     expect(obj["l"], 4);
//     expect(BytesUtils.toHexString(obj["b"]), '03040506');
//   });
//   test('basics', () {
//     final bl = RawBytesLayout(3, property: 'bl');
//     final b = LayoutByteWriter.fromHex("0102030405");
//     var bv = bl.decode(b.toBytes());
//     expect(bv.length, bl.span);
//     expect(bytesEqual(BytesUtils.fromHexString("010203"), bv), true);
//     bv = bl.decode(b.toBytes(), offset: 2);
//     expect(bl.getSpan(b.toBytes()), bl.span);
//     expect(bytesEqual(BytesUtils.fromHexString("030405"), bv), true);
//     expect(bl.encode(BytesUtils.fromHexString('112233'), b, offset: 1), 3);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("0111223305"), b.toBytes()), true);
//   });
//   test('ctor', () {
//     final bl = RawBytesLayout(3, property: 'bl');

//     expect(bl.span, 3);
//     expect(bl.property, 'bl');
//   });
// }

// void unionDiscriminator() {
//   group("UnionLayoutDiscriminatorLayout", () {
//     test('variable-external', () {
//       final dlo = LayoutConst.u8(property: 'v');
//       final ud =
//           LayoutConst.unionLayoutDiscriminator(LayoutConst.offset(dlo, -1));
//       final un = LayoutConst.union(ud, property: 'u');
//       assert(0 > un.span);
//       assert(!un.usesPrefixDiscriminator);
//       final st = LayoutConst.struct([dlo, un], property: 'st');
//       final v0 = un.addVariant(variant: 0, property: 'nul');
//       final v1 =
//           un.addVariant(variant: 1, layout: LayoutConst.cstr(), property: 's');
//       final v2 = un.addVariant(variant: 2);
//       var obj = {
//         "v": v1.variant,
//         "u": {"s": 'hi'}
//       };
//       final b = LayoutByteWriter.filled(6, 0xa5);

//       st.encode(obj, b, offset: 1);
//       expect(bytesEqual(BytesUtils.fromHexString('a501686900a5'), b.toBytes()),
//           true);

//       expect(st.decode(b.toBytes(), offset: 1), obj);
//       obj = {"v": v0.variant};
//       b.fillRange(0, b.length, 0x5a);

//       st.encode(obj, b, offset: 1);
//       expect(bytesEqual(BytesUtils.fromHexString('5a005a5a5a5a'), b.toBytes()),
//           true);
//       expect(
//           st.decode(b.toBytes(), offset: 1),
//           Map.from({
//             ...obj,
//             "u": {"nul": true}
//           }));
//       obj = {"v": v2.variant};
//       b.fillRange(0, b.length, 0x5a);
//       st.encode(obj, b, offset: 1);
//       expect(bytesEqual(BytesUtils.fromHexString('5a025a5a5a5a'), b.toBytes()),
//           true);
//       expect(st.decode(b.toBytes(), offset: 1), {...obj, "u": {}});
//     });
//     test('variable span', () {
//       final un = LayoutConst.union(LayoutConst.u8(property: 'v'));
//       final v0 = un.addVariant(variant: 0, property: 'nul');
//       final v1 = un.addVariant(
//           variant: 1, layout: LayoutConst.u32(), property: 'LayoutConst.u32');
//       final v2 = un.addVariant(
//           variant: 2, layout: LayoutConst.f64(), property: 'LayoutConst.f64');
//       final v3 = un.addVariant(
//           variant: 3, layout: LayoutConst.cstr(), property: 'str');
//       final v255 = un.addVariant(
//         variant: 255,
//       ); // unnamed contentless
//       final b = LayoutByteWriter.filled(16, 0xa5);
//       assert(0 > un.span);

//       Map<String, dynamic> obj = {"v": v255.variant};
//       expect(un.encode(obj, b), 1 + 0);
//       expect(
//           bytesEqual(
//               BytesUtils.fromHexString('ffa5a5'), b.toBytes().sublist(0, 3)),
//           true);
//       expect(v255.layout, null);
//       expect(un.decode(b.toBytes()), obj);
//       expect(v0.getSpan(b.toBytes()), 1);
//       expect(un.getSpan(b.toBytes()), 1);

//       obj = {'nul': true};
//       b.fillRange(0, b.length, 0xff);

//       expect(un.encode(obj, b), 1);

//       // expect(un.getSpan(b.toBytes()), 5);
//       expect(
//           bytesEqual(
//               BytesUtils.fromHexString('00ffff'), b.toBytes().sublist(0, 3)),
//           true);
//       expect(v0.layout, null);
//       expect(un.decode(b.toBytes()), obj);
//       expect(v0.getSpan(b.toBytes()), 1);
//       expect(un.getSpan(b.toBytes()), 1);
//       b.fillRange(0, b.length, 0xff);
//       obj = {"LayoutConst.u32": 0x12345678};
//       expect(un.encode(obj, b), 1 + 4);
//       expect(v1.getSpan(b.toBytes()), 5);
//       expect(un.getSpan(b.toBytes()), 5);
//       expect(
//           bytesEqual(BytesUtils.fromHexString('0178563412ffff'),
//               b.toBytes().sublist(0, 7)),
//           true);
//       expect(un.decode(b.toBytes()), obj);
//       b.fillRange(0, b.length, 0xff);
//       obj = {"LayoutConst.f64": 1234.5};
//       expect(un.encode(obj, b), 1 + 8);
//       expect(v2.getSpan(b.toBytes()), 9);
//       expect(un.getSpan(b.toBytes()), 9);
//       expect(
//           bytesEqual(BytesUtils.fromHexString('0200000000004a9340ffff'),
//               b.toBytes().sublist(0, 11)),
//           true);
//       expect(un.decode(b.toBytes()), obj);
//       b.fillRange(0, b.length, 0xff);

//       obj = {"str": "hi!"};
//       expect(un.encode(obj, b), 1 + 3 + 1);
//       expect(v3.getSpan(b.toBytes()), 5);
//       expect(un.getSpan(b.toBytes()), 5);
//       expect(
//           bytesEqual(BytesUtils.fromHexString('0368692100ffff'),
//               b.toBytes().sublist(0, 7)),
//           true);
//       expect(un.decode(b.toBytes()), obj);
//       b.fillRange(0, b.length, 0xa5);
//       expect(un.encode(obj, b, offset: 1), 1 + 3 + 1);
//       expect(v3.getSpan(b.toBytes(), offset: 1), 5);
//       expect(un.getSpan(b.toBytes(), offset: 1), 5);
//       expect(un.decode(b.toBytes(), offset: 1), obj);
//     });

//     test('from src', () {
//       final un = Union(LayoutConst.u8(property: 'v'),
//           defaultLayout: LayoutConst.u32(property: 'LayoutConst.u32'));
//       final v0 = un.addVariant(variant: 0, property: 'nul');
//       final v1 = un.addVariant(
//           variant: 1, layout: LayoutConst.f32(), property: 'LayoutConst.f32');
//       final v2 = un.addVariant(
//           variant: 2,
//           layout: LayoutConst.seq(LayoutConst.u8(), ConstantLayout(4)),
//           property: 'LayoutConst.u8.4');
//       final v3 = un.addVariant(
//           variant: 3, layout: LayoutConst.cstr(), property: 'str');
//       LayoutByteWriter b = LayoutByteWriter.filled(un.span, 0);

//       expect(un.span, 5);

//       // Unregistered variant with default content
//       Map<String, dynamic> src = {"v": 5, "LayoutConst.u32": 0x12345678};
//       VariantLayout? vlo = un.defaultGetSourceVariant(src);
//       expect(vlo, null);
//       expect(un.encode(src, b), un.span);
//       expect(bytesEqual(BytesUtils.fromHexString('0578563412'), b.toBytes()),
//           true);

//       // Unregistered variant without default content
//       src = {"v": 5};

//       // Registered variant with default content
//       src = {"v": 1, "LayoutConst.u32": 0x12345678};
//       expect(un.defaultGetSourceVariant(src), null);

//       // Registered variant with incompatible content
//       src = {"v": 2, "LayoutConst.f32": 26.5};

//       // Registered variant with no content
//       src = {"v": 0};
//       vlo = un.defaultGetSourceVariant(src);
//       expect(vlo, v0);
//       b.fillRange(0, b.length, 255);

//       expect(vlo?.encode(src, b), 1);
//       expect(un.getSpan(b.toBytes()), 5);
//       expect(bytesEqual(BytesUtils.fromHexString('00ffffffff'), b.toBytes()),
//           true);

//       // Registered variant with compatible content (ignore discriminator)
//       src = {"v": 1, "LayoutConst.f32": 26.5};
//       expect(un.defaultGetSourceVariant(src), v1);

//       // Inferred variant from content
//       src = {"LayoutConst.f32": 26.5};
//       vlo = un.defaultGetSourceVariant(src);
//       expect(vlo, v1);
//       expect(vlo?.encode(src, b), un.span);
//       expect(bytesEqual(BytesUtils.fromHexString('010000d441'), b.toBytes()),
//           true);
//       expect(un.encode(src, b), un.span);
//       expect(bytesEqual(BytesUtils.fromHexString('010000d441'), b.toBytes()),
//           true);

//       src = {
//         'LayoutConst.u8.4': [1, 2, 3, 4]
//       };
//       vlo = un.defaultGetSourceVariant(src);
//       expect(vlo, v2);
//       expect(vlo?.encode(src, b), un.span);
//       expect(bytesEqual(BytesUtils.fromHexString('0201020304'), b.toBytes()),
//           true);
//       expect(un.encode(src, b), un.span);
//       expect(bytesEqual(BytesUtils.fromHexString('0201020304'), b.toBytes()),
//           true);

//       src = {"str": 'hi'};
//       vlo = un.defaultGetSourceVariant(src);
//       expect(vlo, v3);
//       b.fillRange(0, b.length, 0xFF);
//       expect(vlo?.encode(src, b), 1 + 2 + 1);
//       expect(
//           bytesEqual(BytesUtils.fromHexString('03686900FF'),
//               b.toBytes().sublist(0, 5)),
//           true);
//       assert(0 > vlo!.layout!.span);
//       expect(vlo?.span, un.span);
//       expect(vlo?.layout?.getSpan(b.toBytes(), offset: 1), 3);
//       expect(vlo?.getSpan(b.toBytes()), un.span);

//       src = {"v": 6};
//     });
//     test('issue#7.external', () {
//       final dlo = LayoutConst.u8(property: 'vid');
//       final ud = UnionLayoutDiscriminatorLayout(LayoutConst.offset(dlo, -3),
//           property: 'uid');
//       final un = Union(ud,
//           defaultLayout: LayoutConst.u32(property: 'LayoutConst.u32'),
//           property: 'u');
//       final st = StructLayout([
//         dlo,
//         LayoutConst.u16(property: 'LayoutConst.u16'),
//         un,
//         LayoutConst.s16(property: 'LayoutConst.s16')
//       ]);
//       expect(un.span, 4);
//       expect(st.span, 9);
//       final b = LayoutByteWriter.fromHex('000102030405060708');
//       var obj = st.decode(b.toBytes());
//       expect(obj["vid"], 0);
//       expect(obj["LayoutConst.u16"], 0x201);
//       expect(obj["LayoutConst.s16"], 0x807);
//       expect(obj["u"]["uid"], 0);
//       expect(obj["u"]["LayoutConst.u32"], 0x06050403);
//       final b2 = LayoutByteWriter.filled(st.span, 0);
//       expect(st.encode(obj, b2), st.span);
//       expect(bytesEqual(b2.toBytes(), b.toBytes()), true);

//       un.addVariant(variant: 0, layout: LayoutConst.u32(), property: 'v0');
//       obj = st.decode(b.toBytes());
//       expect(obj["vid"], 0);
//       expect(obj["LayoutConst.u16"], 0x201);
//       expect(obj["LayoutConst.s16"], 0x807);
//       expect(obj["u"]["v0"], 0x06050403);

//       final flo = LayoutConst.f32(property: "LayoutConst.f32");
//       un.addVariant(variant: 1, layout: flo, property: 'vf');
//       final fb = BytesUtils.fromHexString('01234500805a429876');
//       final fobj = st.decode(fb);
//       expect(fobj["vid"], 1);
//       expect(fobj["LayoutConst.u16"], 0x4523);
//       expect(fobj["LayoutConst.s16"], 0x7698);
//       expect(fobj["u"]["vf"], 54.625);
//     });
//     test('issue#7.internal.named2', () {
//       final dlo = LayoutConst.u8(property: 'vid');
//       final plo = SequenceLayout(
//           elementLayout: LayoutConst.u8(),
//           count: ConstantLayout(8),
//           property: 'payload');
//       final vlo = StructLayout([plo, dlo]);
//       final un = Union(LayoutConst.offset(dlo, plo.span), defaultLayout: vlo);
//       final clo = un.defaultLayout;
//       final b = LayoutByteWriter.fromHex('000102030405060708');
//       final obj = un.decode(b.toBytes());
//       expect(un.usesPrefixDiscriminator, false);
//       expect(un.discriminator.property, 'vid');
//       expect(clo?.property, 'content');
//       expect((clo as StructLayout?)?.fields, vlo.fields);
//       expect(obj["content"], {
//         "payload": [0, 1, 2, 3, 4, 5, 6, 7],
//         "vid": 8
//       });
//       expect(obj["vid"], 8);
//     });
//     test('issue#7.internal.named', () {
//       final dlo = LayoutConst.u8();
//       final plo = SequenceLayout(
//           elementLayout: LayoutConst.u8(),
//           count: ConstantLayout(8),
//           property: 'payload');
//       final vlo = StructLayout([plo, dlo]);
//       final ud = UnionLayoutDiscriminatorLayout(
//           LayoutConst.offset(dlo, plo.span),
//           property: 'tag');
//       final un = Union(ud, defaultLayout: vlo);
//       final clo = un.defaultLayout;
//       final b = LayoutByteWriter.fromHex('000102030405060708');
//       final obj = un.decode(b.toBytes());
//       expect(un.usesPrefixDiscriminator, false);
//       expect(un.discriminator.property, 'tag');
//       expect(clo?.property, 'content');
//       // assert.notStrictEqual(clo, vlo);
//       expect((clo as StructLayout?)?.fields, vlo.fields);
//       expect(obj["content"], {
//         "payload": [0, 1, 2, 3, 4, 5, 6, 7]
//       });
//       expect(obj["tag"], 8);
//       expect(9, un.getSpan(b.toBytes()));
//     });
//     test('issue#7.internal.anon', () {
//       final dlo = LayoutConst.u8();
//       final plo = SequenceLayout(
//           elementLayout: LayoutConst.u8(),
//           count: ConstantLayout(8),
//           property: 'payload');
//       final vlo = StructLayout([plo, dlo]);
//       final un = Union(LayoutConst.offset(dlo, plo.span), defaultLayout: vlo);
//       final clo = un.defaultLayout;
//       final b = LayoutByteWriter.fromHex("000102030405060708");
//       final obj = un.decode(b.toBytes());
//       expect(un.usesPrefixDiscriminator, false);
//       expect(un.discriminator.property, 'variant');
//       expect(un.defaultLayout?.property, 'content');
//       // expect(clo, vlo);
//       expect((clo as StructLayout).fields, vlo.fields);
//       expect(obj["content"], {
//         "payload": [0, 1, 2, 3, 4, 5, 6, 7]
//       });
//       expect(obj["variant"], 8);
//     });
//     test('issue#6', () {
//       final dlo = LayoutConst.u8(property: 'number');
//       final vlo = SequenceLayout(
//           elementLayout: LayoutConst.u8(),
//           count: ConstantLayout(8),
//           property: 'payload');
//       final un = Union(dlo, defaultLayout: vlo);
//       final b = LayoutByteWriter.fromHex('000102030405060708');
//       final obj = un.decode(b.toBytes());
//       expect(obj["number"], 0);
//       expect(obj["payload"], [1, 2, 3, 4, 5, 6, 7, 8]);
//       LayoutByteWriter b2 = LayoutByteWriter.filled(un.span, 0);
//       expect(un.encode(obj, b2), dlo.span + vlo.span);
//       expect(bytesEqual(b2.toBytes(), b.toBytes()), true);
//     });
//     test('inStruct', () {
//       final dlo = LayoutConst.u8(property: 'uid');
//       final vlo = SequenceLayout(
//           elementLayout: LayoutConst.u8(),
//           count: ConstantLayout(3),
//           property: 'payload');
//       final un = Union(dlo, defaultLayout: vlo, property: 'u');
//       final st = StructLayout([
//         LayoutConst.u16(property: 'LayoutConst.u16'),
//         un,
//         LayoutConst.s16(property: 'LayoutConst.s16')
//       ]);
//       final b = LayoutByteWriter.fromHex('0001020304050607');
//       final obj = st.decode(b.toBytes());
//       expect(obj["LayoutConst.u16"], 0x0100);
//       expect(obj["u"]["uid"], 2);
//       expect(obj["u"]["payload"], [3, 4, 5]);
//       expect(obj["LayoutConst.s16"], 1798);
//       obj["LayoutConst.u16"] = 0x5432;
//       obj["LayoutConst.s16"] = -3;
//       obj["u"]["payload"][1] = 23;
//       LayoutByteWriter b2 = LayoutByteWriter.filled(st.span, 0);
//       expect(st.encode(obj, b2), st.span);
//       expect(
//           bytesEqual(
//               BytesUtils.fromHexString('325402031705fdff'), b2.toBytes()),
//           true);
//     });
//     test('custom default', () {
//       final dlo = LayoutConst.u8(property: 'number');
//       final vlo = SequenceLayout(
//           elementLayout: LayoutConst.u8(),
//           count: ConstantLayout(8),
//           property: 'payload');
//       final un = Union(dlo, defaultLayout: vlo);
//       assert(un.usesPrefixDiscriminator);
//       expect(un.discriminator.property, dlo.property);
//       expect((un.discriminator.layout as OffsetLayout).offset, 0);
//       expect(un.defaultLayout, vlo);
//       expect(un.discriminator.property, 'number');
//       expect(un.defaultLayout?.property, 'payload');
//     });
//     test('variants', () {
//       final dlo = LayoutConst.u8(property: 'v');
//       final vlo = SequenceLayout(
//           elementLayout: LayoutConst.u8(),
//           count: ConstantLayout(4),
//           property: 'c');
//       final un = Union(dlo, defaultLayout: vlo);
//       final b = LayoutByteWriter.filled(5, 0);
//       // expect(un.getVariant(1), null);

//       expect(un.decode(b.toBytes()), {
//         "v": 0,
//         "c": [0, 0, 0, 0]
//       });
//       final lo1 = LayoutConst.u32();
//       final v1 = un.addVariant(variant: 1, layout: lo1, property: 'v1');
//       expect(v1.variant, 1);
//       expect(v1.layout, lo1);
//       b.fillRange(0, b.length, 1);

//       expect(un.getVariant(b.toBytes()), v1);
//       expect(v1.decode(b.toBytes()), {"v1": 0x01010101});
//       expect(un.decode(b.toBytes()), {"v1": 0x01010101});
//       final lo2 = LayoutConst.f32();
//       final v2 = un.addVariant(variant: 2, layout: lo2, property: 'v2');
//       expect(un.discriminator.encode(v2.variant, b), dlo.span);
//       expect(un.getVariant(b.toBytes()), v2);
//       expect(v2.decode(b.toBytes()), {"v2": 2.3694278276172396e-38});
//       expect(un.decode(b.toBytes()), {"v2": 2.3694278276172396e-38});
//       final lo3 = StructLayout([
//         LayoutConst.u8(property: 'a'),
//         LayoutConst.u8(property: 'b'),
//         LayoutConst.u16(property: 'c')
//       ]);
//       final v3 = un.addVariant(variant: 3, layout: lo3, property: 'v3');
//       expect(un.discriminator.encode(v3.variant, b), dlo.span);
//       expect(un.getVariant(b.toBytes()), v3);
//       expect(v3.decode(b.toBytes()), {
//         "v3": {"a": 1, "b": 1, "c": 257}
//       });
//       expect(un.decode(b.toBytes()), {
//         "v3": {"a": 1, "b": 1, "c": 257}
//       });
//       expect(un.discriminator.encode(v2.variant, b), dlo.span);
//       expect(bytesEqual(BytesUtils.fromHexString('0201010101'), b.toBytes()),
//           true);
//       final obj = {
//         "v3": {"a": 5, "b": 6, "c": 1540}
//       };
//       expect(lo3.encode(obj["v3"]!, b), lo3.span);
//       expect(v3.encode(obj, b), un.span);
//       expect(un.span != vlo.span + lo3.span, true);
//       expect(un.decode(b.toBytes()), obj);
//       expect(bytesEqual(BytesUtils.fromHexString('0305060406'), b.toBytes()),
//           true);

//       final v0 = un.addVariant(variant: 0, property: 'v0');
//       expect(un.discriminator.encode(v0.variant, b), dlo.span);
//       expect(un.getVariant(b.toBytes()), v0);
//       expect(un.decode(b.toBytes()), {"v0": true});
//     });
//     test('basics', () {
//       final dlo = LayoutConst.u8();
//       final vlo = SequenceLayout(
//           elementLayout: LayoutConst.u8(), count: ConstantLayout(8));
//       final un = Union(dlo, defaultLayout: vlo);
//       final SequenceLayout clo = un.defaultLayout as SequenceLayout;
//       final b = LayoutByteWriter.filled(9, 0);

//       expect(un.span, 9);
//       expect(un.getSpan(null), un.span);
//       expect(un.usesPrefixDiscriminator, true);
//       // check
//       // expect(clo, vlo);
//       expect(clo.count, vlo.count);
//       expect(clo.elementLayout, vlo.elementLayout);
//       expect(un.discriminator.property, 'variant');
//       expect(un.defaultLayout?.property, 'content');
//       expect(dlo.span + vlo.span, un.span);
//       expect(un.property, null);

//       final o = un.decode(b.toBytes());
//       expect(o["variant"], 0);
//       expect(o["content"], [0, 0, 0, 0, 0, 0, 0, 0]);
//       o["variant"] = 5;
//       o["content"][3] = 3;
//       o["content"][7] = 7;
//       expect(un.encode(o, b), dlo.span + vlo.span);
//       expect(
//           bytesEqual(
//               BytesUtils.fromHexString("050000000300000007"), b.toBytes()),
//           true);
//     });
//   });
// }

// void offsetLayout() {
//   group("offsetLayout", () {
//     test('codec', () {
//       final u8_ = LayoutConst.u8();
//       final bl = LayoutConst.offset(u8_, -1, 'bl');
//       final al = LayoutConst.offset(u8_, 1, 'al');
//       LayoutByteWriter b = LayoutByteWriter.fromHex("0001020304050607");
//       expect(u8_.decode(b.toBytes()), 0);
//       expect(al.decode(b.toBytes()), 1);
//       expect(u8_.decode(b.toBytes(), offset: 4), 4);
//       expect(al.decode(b.toBytes(), offset: 4), 5);
//       expect(bl.decode(b.toBytes(), offset: 4), 3);
//       expect(u8_.encode(0x80, b), 1);
//       expect(al.encode(0x91, b), 1);
//       expect(u8_.encode(0x84, b, offset: 4), 1);
//       expect(al.encode(0x94, b, offset: 4), 1);
//       expect(bl.encode(0x74, b, offset: 4), 1);
//       expect(
//           bytesEqual(BytesUtils.fromHexString('8091027484940607'), b.toBytes()),
//           true);
//     });
//     test('ctor', () {
//       final u8_ = LayoutConst.u8();
//       final l0 = OffsetLayout(u8_);

//       final nl = OffsetLayout(u8_, offset: -3, property: 'nl');
//       final dl = OffsetLayout(LayoutConst.u8(property: 'ol'), offset: 5);
//       final al = OffsetLayout(u8_, offset: 21);
//       expect(l0.layout, u8_);
//       expect(l0.offset, 0);
//       expect(l0.property, null);
//       expect(nl.layout, u8_);
//       expect(nl.offset, -3);
//       expect(nl.property, 'nl');
//       expect(dl.offset, 5);
//       expect(dl.property, 'ol');
//       expect(al.layout, u8_);
//       expect(al.offset, 21);
//       expect(al.property, null);
//     });
//   });
// }

// void greedyCount() {
//   group("GreedyCount", () {
//     test('ctor', () {
//       final el = LayoutConst.greedy();
//       expect(el.elementSpan, 1);
//       expect(el.property, null);
//       final nel = LayoutConst.greedy(elementSpan: 5, property: 'name');
//       expect(nel.elementSpan, 5);
//       expect(nel.property, 'name');
//     });
//     test('#decode', () {
//       final el = LayoutConst.greedy();
//       final b = LayoutByteWriter.filled(10, 0);
//       expect(el.decode(b.toBytes()), b.length);
//       expect(el.decode(b.toBytes(), offset: 3), b.length - 3);

//       final nel = LayoutConst.greedy(elementSpan: 3);
//       expect(nel.decode(b.toBytes()), 3);
//       expect(nel.decode(b.toBytes(), offset: 1), 3);
//       expect(nel.decode(b.toBytes(), offset: 2), 2);
//     });
//   });
// }

// void variantLayout() {
//   group("VariantLayout", () {
//     test('span', () {
//       final un = Union(LayoutConst.u8(), defaultLayout: LayoutConst.u32());
//       final d = VariantLayout(
//           union: un, variant: 1, layout: LayoutConst.cstr(), property: 's');
//       final b = LayoutByteWriter.filled(12, 0);
//       expect(d.encode({"s": 'hi!'}, b), 5);
//       expect(un.getSpan(b.toBytes()), 5);
//       expect(
//           bytesEqual(BytesUtils.fromHexString('0168692100'),
//               b.toBytes().sublist(0, 5)),
//           true);
//     });

//     test('ctor without layout', () {
//       final un = Union(LayoutConst.u8(), defaultLayout: LayoutConst.u32());
//       final v0 = VariantLayout(union: un, variant: 0);
//       expect(v0.union, un);
//       expect(v0.span, 5);
//       expect(v0.layout, null);
//       expect(v0.variant, 0);
//       expect(v0.property, null);
//       final v1 = VariantLayout(union: un, variant: 1, property: 'nul');
//       expect(v1.union, un);
//       expect(v1.span, 5);
//       expect(v1.layout, null);
//       expect(v1.variant, 1);
//       expect(v1.property, 'nul');
//     });
//     test('ctor', () {
//       final un = Union(LayoutConst.u8(), defaultLayout: LayoutConst.u32());
//       final d = VariantLayout(
//           union: un, variant: 1, layout: LayoutConst.f32(), property: 'd');
//       expect(d.union, un);
//       expect(d.span, 5);
//       expect(d.variant, 1);
//       expect(d.property, 'd');
//     });
//   });
// }

// void replicate() {
//   group("replicate", () {
//     test('LayoutConst.nameWithProperty', () {
//       final s32_ = LayoutConst.s32(property: "LayoutConst.s32");
//       final u16_ = LayoutConst.u16(property: 'LayoutConst.u16');
//       final d =
//           LayoutConst.struct([s32_, LayoutConst.u16(), u16_], property: 's');
//       expect(LayoutConst.nameWithProperty('LayoutConst.struct', d),
//           'LayoutConst.struct[s]');
//       expect(LayoutConst.nameWithProperty('pfx', d.fields[1]), 'pfx');
//     });

//     test('remove', () {
//       final src = LayoutConst.u32(property: 'p');
//       final dst = src.clone();
//       expect(src.property, 'p');
//       expect(dst.property, null);
//     });
//     test('add', () {
//       final src = LayoutConst.u32();
//       final dst = src.clone(newProperty: 'p');
//       expect(dst.property, 'p');
//     });
//     test('sequence', () {
//       final src = SequenceLayout(
//           elementLayout: LayoutConst.u16(),
//           count: ConstantLayout(20),
//           property: 'hi');
//       final dst = src.clone(newProperty: '');
//       expect(dst.span, src.span);
//       expect(dst.count, src.count);
//       expect(dst.elementLayout, src.elementLayout);
//       expect(dst.property, '');
//     });
//     test('LayoutConst.struct', () {
//       final src = StructLayout(
//           [LayoutConst.u8(property: 'a'), LayoutConst.s32(property: 'b')],
//           property: 'hi');
//       final dst = src.clone(newProperty: '');
//       expect(dst.span, src.span);
//       expect(dst.property, '');
//     });
//     test('uint', () {
//       final src = LayoutConst.u32(property: 'hi');
//       final dst = src.clone(newProperty: '');
//       expect(dst.span, src.span);
//       expect(dst.property, '');
//     });
//   });
// }

// void prefix() {
//   group("prefix decoding", () {
//     final fields = [
//       LayoutConst.u32(property: 'LayoutConst.u32'),
//       LayoutConst.u16(property: 'LayoutConst.u16'),
//       LayoutConst.u8(property: 'LayoutConst.u8'),
//     ];
//     final b = LayoutByteWriter.fromHex("01020304111221");
//     test('preserved by replicate', () {
//       final property = 'name';
//       final slo =
//           LayoutConst.struct(fields, property: property, decodePrefixes: true);
//       expect(slo.property, property);
//       expect(slo.decodePrefixes, true);
//       final slo2 = slo.clone(newProperty: 'other');
//       expect(slo2.property, 'other');
//       expect(slo2.decodePrefixes, true);
//     });
//     test('accepts full fields if enabled', () {
//       final slo = LayoutConst.struct(fields, decodePrefixes: true);
//       expect(slo.decodePrefixes, true);
//       expect(slo.decode(b.toBytes()), {
//         "LayoutConst.u32": 0x04030201,
//         "LayoutConst.u16": 0x1211,
//         "LayoutConst.u8": 0x21,
//       });
//       expect(slo.decode(b.toBytes().sublist(0, 4)), {
//         "LayoutConst.u32": 0x04030201,
//       });
//       expect(slo.decode(b.toBytes().sublist(0, 6)), {
//         "LayoutConst.u32": 0x04030201,
//         "LayoutConst.u16": 0x1211,
//       });
//       // assert.throws(() => slo.decode(b.slice(0, 3)), RangeError);
//     });
//     test('rejects partial by default', () {
//       final slo = LayoutConst.struct(fields);
//       expect(slo.decodePrefixes, false);
//       expect(slo.decode(b.toBytes()), {
//         "LayoutConst.u32": 0x04030201,
//         "LayoutConst.u16": 0x1211,
//         "LayoutConst.u8": 0x21,
//       });
//     });
//   });
// }

// void stracture() {
//   test('empty encode variable span', () {
//     final slo = LayoutConst.struct(
//         [LayoutConst.u8(property: 'a'), LayoutConst.cstr(property: 's')]);
//     expect(slo.span, -1);
//     LayoutByteWriter b = LayoutByteWriter.filled(10, 0);
//     expect(slo.encode({}, b), 1);
//     expect(slo.encode({}, b, offset: 5), 1);
//     expect(slo.encode({"a": 5}, b), 1);
//     expect(slo.encode({"a": 5, "s": 'hi'}, b), 4);
//     expect(slo.encode({"a": 5, "s": 'hi'}, b, offset: 5), 4);
//   });
//   test('empty encode fixed span', () {
//     final slo = LayoutConst.struct(
//         [LayoutConst.u8(property: 'a'), LayoutConst.u8(property: 'b')]);
//     expect(slo.span, 2);
//     LayoutByteWriter b = LayoutByteWriter.filled(10, 0);
//     expect(slo.encode({}, b), slo.span);
//     expect(slo.encode({}, b, offset: 1), slo.span);
//   });
//   test('LayoutConst.offset-variant', () {
//     final c = LayoutConst.cstr(property: 's');
//     final st = LayoutConst.struct([c], property: "st");
//     assert(0 > st.span);
//     LayoutByteWriter b = LayoutByteWriter.filled(5, 0xa5);
//     final obj = {"s": 'ab'};
//     st.encode(obj, b, offset: 1);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("a5616200a5"), b.toBytes()), true);
//     expect(3, st.getSpan(b.toBytes(), offset: 1));
//     expect(st.decode(b.toBytes(), offset: 1), obj);
//   });
//   test('empty', () {
//     final st = LayoutConst.struct([], property: "st");
//     final b = LayoutByteWriter.filled(0, 0);
//     expect(st.span, 0);
//     expect(st.decode(b.toBytes()), {});
//   });
//   test('nested', () {
//     final st = StructLayout([
//       LayoutConst.u8(property: 'LayoutConst.u8'),
//       LayoutConst.u16(property: 'LayoutConst.u16'),
//       LayoutConst.s16be(property: 'LayoutConst.s16be')
//     ], property: 'st');
//     final cst = StructLayout([
//       LayoutConst.u32(property: 'LayoutConst.u32'),
//       st,
//       LayoutConst.s24(property: 'LayoutConst.s24')
//     ]);
//     final obj = {
//       "LayoutConst.u32": 0x12345678,
//       "st": {
//         "LayoutConst.u8": 23,
//         "LayoutConst.u16": 65432,
//         "LayoutConst.s16be": -12345,
//       },
//       "LayoutConst.s24": -123456
//     };
//     LayoutByteWriter b = LayoutByteWriter.filled(12, 0);
//     expect(st.span, 5);
//     expect(st.property, 'st');
//     expect(cst.span, 12);
//     expect(cst.encode(obj, b), cst.span);
//     expect(
//         bytesEqual(
//             BytesUtils.fromHexString("785634121798ffcfc7c01dfe"), b.toBytes()),
//         true);
//     expect(cst.decode(b.toBytes()), obj);
//   });
//   test('update', () {
//     final st = StructLayout([
//       LayoutConst.u8(property: 'LayoutConst.u8'),
//       LayoutConst.u16(property: 'LayoutConst.u16'),
//       LayoutConst.s16be(property: 'LayoutConst.s16be')
//     ]);
//     final b = LayoutByteWriter.fromHex("153412eac8");
//     final rc = st.decode(b.toBytes());
//     expect(rc, {
//       "LayoutConst.u8": 21,
//       "LayoutConst.u16": 0x1234,
//       "LayoutConst.s16be": -5432
//     });
//   });
//   test('missing', () {
//     final st = StructLayout([
//       LayoutConst.u16(property: 'LayoutConst.u16'),
//       LayoutConst.u8(property: 'LayoutConst.u8'),
//       LayoutConst.s16be(property: 'LayoutConst.s16be')
//     ]);
//     final b = LayoutByteWriter.filled(5, 0);
//     expect(st.span, 5);
//     var obj = st.decode(b.toBytes());
//     expect(obj,
//         {"LayoutConst.u16": 0, "LayoutConst.u8": 0, "LayoutConst.s16be": 0});
//     b.fillRange(0, b.length, 0xa5);
//     obj = {"LayoutConst.u16": 0x1234, "LayoutConst.s16be": -5432};
//     expect(st.encode(obj, b), st.span);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("3412a5eac8"), b.toBytes()), true);
//   });
//   test('padding', () {
//     final st = StructLayout([
//       LayoutConst.u16(property: 'LayoutConst.u16'),
//       LayoutConst.u8(),
//       LayoutConst.s16be(property: 'LayoutConst.s16be')
//     ]);
//     LayoutByteWriter b = LayoutByteWriter.filled(5, 0);
//     expect(st.span, 5);

//     var obj = st.decode(b.toBytes());
//     expect(obj, {"LayoutConst.u16": 0, "LayoutConst.s16be": 0});
//     b.fillRange(0, b.length, 0xFF);

//     obj = {"LayoutConst.u16": 0x1234, "LayoutConst.s16be": -5432};
//     expect(st.encode(obj, b), st.span);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("3412ffeac8"), b.toBytes()), true);
//     expect(st.decode(b.toBytes()), obj);
//   });
//   test('basics', () {
//     final st = StructLayout([
//       LayoutConst.u8(property: 'LayoutConst.u8'),
//       LayoutConst.u16(property: 'LayoutConst.u16'),
//       LayoutConst.s16be(property: 'LayoutConst.s16be')
//     ]);
//     final b = LayoutByteWriter.filled(5, 0);

//     expect(st.span, 5);
//     expect(st.getSpan(null), st.span);

//     var obj = st.decode(b.toBytes());
//     expect(obj,
//         {"LayoutConst.u8": 0, "LayoutConst.u16": 0, "LayoutConst.s16be": 0});
//     obj = {
//       "LayoutConst.u8": 21,
//       "LayoutConst.u16": 0x1234,
//       "LayoutConst.s16be": -5432
//     };
//     expect(st.encode(obj, b), st.span);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("153412eac8"), b.toBytes()), true);
//     expect(st.decode(b.toBytes()), obj);
//   });
// }

// void sequence() {
//   test('LayoutConst.greedy', () {
//     final seqq = LayoutConst.seq(
//         LayoutConst.u16(), LayoutConst.greedy(elementSpan: 2),
//         property: 'a');
//     final b = LayoutByteWriter.from(StringUtils.encode("ABCDE"));
//     final db = LayoutByteWriter.filled(6, "-".codeUnits.first);
//     expect(seqq.getSpan(b.toBytes()), 4);
//     expect(seqq.decode(b.toBytes()), [0x4241, 0x4443]);
//     expect(seqq.encode(seqq.decode(b.toBytes()), db, offset: 1), 4);
//     expect(bytesEqual(StringUtils.encode("-ABCD-"), db.toBytes()), true);
//     expect(seqq.getSpan(b.toBytes(), offset: 1), 4);
//     expect(seqq.decode(b.toBytes(), offset: 1), [0x4342, 0x4544]);
//   });
//   test('zero-count', () {
//     final seqq = LayoutConst.seq(LayoutConst.u8(), ConstantLayout(0));
//     final b = LayoutByteWriter.filled(0, 0);
//     expect(seqq.span, 0);
//     expect(seqq.decode(b.toBytes()), []);
//   });
//   test('final count+span', () {
//     final clo = LayoutConst.u8(property: 'n');
//     final seqq = LayoutConst.seq(
//         LayoutConst.cstr(), LayoutConst.offset(clo, -1),
//         property: 'a');
//     final st = LayoutConst.struct([clo, seqq]);
//     LayoutByteWriter b = LayoutByteWriter.fromHex('036100620063646500');
//     var obj = st.decode(b.toBytes());
//     expect(obj["n"], 3);
//     expect(obj["a"], ['a', 'b', 'cde']);
//     b = LayoutByteWriter.filled(10, 0);
//     obj = {
//       "n": 6,
//       "a": ['one', 'two']
//     };
//     expect(st.encode(obj, b), clo.span + 8);
//     final span = st.getSpan(b.toBytes());
//     expect(span, 9);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("026f6e650074776f00"),
//             b.toBytes().sublist(0, span)),
//         true);
//   });
//   test('final count', () {
//     final clo = LayoutConst.u8(property: 'n');

//     final seqq = LayoutConst.seq(LayoutConst.u8(), LayoutConst.offset(clo, -1),
//         property: 'a');

//     final st = LayoutConst.struct([clo, seqq]);
//     var b = LayoutByteWriter.fromHex('03010203');
//     var obj = st.decode(b.toBytes());
//     expect(obj["n"], 3);
//     expect(obj["a"], [1, 2, 3]);
//     b = LayoutByteWriter.filled(10, 0);
//     obj = {
//       "n": 3,
//       "a": [5, 6, 7, 8, 9]
//     };
//     expect(st.encode(obj, b), 6);
//     final span = st.getSpan(b.toBytes());
//     expect(span, 6);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("050506070809"),
//             b.toBytes().sublist(0, span)),
//         true);
//   });
//   test('LayoutConst.struct elts', () {
//     final st = StructLayout([
//       LayoutConst.u8(property: 'LayoutConst.u8'),
//       LayoutConst.s32(property: 'LayoutConst.s32')
//     ]);
//     final seq = SequenceLayout(elementLayout: st, count: ConstantLayout(3));
//     final tv = [
//       {"LayoutConst.u8": 1, "LayoutConst.s32": 10000},
//       {"LayoutConst.u8": 0, "LayoutConst.s32": 0},
//       {"LayoutConst.u8": 3, "LayoutConst.s32": -324}
//     ];
//     final b = LayoutByteWriter.filled(15, 0);
//     expect(st.span, 5);
//     // expect(seq.count, 3);
//     expect(seq.elementLayout, st);
//     expect(seq.span, 15);
//     expect(seq.encode(tv, b), seq.span);
//     expect(
//         bytesEqual(BytesUtils.fromHexString('0110270000000000000003bcfeffff'),
//             b.toBytes()),
//         true);
//     expect(seq.decode(b.toBytes()), tv);
//     expect(
//         seq.encode([
//           {"LayoutConst.u8": 2, "LayoutConst.s32": 0x12345678}
//         ], b, offset: st.span),
//         1 * st.span);
//     expect(
//         bytesEqual(BytesUtils.fromHexString('0110270000027856341203bcfeffff'),
//             b.toBytes()),
//         true);
//   });
//   test('in LayoutConst.struct', () {
//     final seqq =
//         LayoutConst.seq(LayoutConst.u8(), ConstantLayout(4), property: 'id');
//     final str = LayoutConst.struct([seqq]);
//     final d = str.decode(BytesUtils.fromHexString('01020304'));
//     expect(d, {
//       "id": [1, 2, 3, 4]
//     });
//   });
//   test('basics', () {
//     final seq = SequenceLayout(
//         elementLayout: LayoutConst.u8(),
//         count: ConstantLayout(4),
//         property: 'id');
//     final b = LayoutByteWriter.filled(4, 0);

//     // expect(seq.count, 4);
//     expect(seq.span, 4);
//     expect(seq.getSpan(null), seq.span);
//     expect(seq.property, 'id');
//     expect(seq.decode(b.toBytes()), [0, 0, 0, 0]);
//     expect(seq.encode([1, 2, 3, 4], b), 4);
//     expect(seq.decode(b.toBytes()), [1, 2, 3, 4]);
//     expect(seq.encode([5, 6], b, offset: 1), 2);
//     expect(seq.decode(b.toBytes()), [1, 5, 6, 4]);
//   });
// }

// void testDouble() {
//   test("double", () {
//     final be = LayoutConst.f64be(property: 'dee');
//     final le = LayoutConst.f64(property: 'eed');
//     final f = 123456789.125e+10;
//     final fe = 3.4283031083405533e-77;
//     LayoutByteWriter b = LayoutByteWriter.filled(8, 0);

//     expect(be.span, 8);
//     expect(be.property, 'dee');

//     expect(le.span, 8);
//     expect(le.property, 'eed');

//     expect(be.decode(b.toBytes()), 0);
//     expect(le.decode(b.toBytes()), 0);
//     expect(le.encode(f, b), 8);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("300fc1f41022b143"), b.toBytes()),
//         true);
//     expect(le.decode(b.toBytes()), f);
//     expect(be.decode(b.toBytes()), fe);
//     expect(be.encode(f, b), 8);
//     expect(
//         bytesEqual(BytesUtils.fromHexString("43b12210f4c10f30"), b.toBytes()),
//         true);
//     expect(be.decode(b.toBytes()), f);
//     expect(le.decode(b.toBytes()), fe);
//     b = LayoutByteWriter.filled(10, 0xa5);
//     le.encode(f, b, offset: 1);
//     expect(
//         bytesEqual(
//             BytesUtils.fromHexString("a5300fc1f41022b143a5"), b.toBytes()),
//         true);

//     expect(f, le.decode(b.toBytes(), offset: 1));
//     be.encode(f, b, offset: 1);
//     expect(
//         bytesEqual(
//             BytesUtils.fromHexString("a543b12210f4c10f30a5"), b.toBytes()),
//         true);
//     expect(f, be.decode(b.toBytes(), offset: 1));
//   });
// }

// void float() {
//   test("float", () {
//     final be = LayoutConst.f32be(property: 'eff');
//     final le = LayoutConst.f32(property: 'ffe');
//     final f = 123456.125;
//     final fe = 3.174030951333261e-29;
//     LayoutByteWriter b = LayoutByteWriter.filled(4, 0);

//     expect(be.span, 4);
//     expect(be.getSpan(null), be.span);
//     expect(be.property, 'eff');

//     expect(le.span, 4);
//     expect(le.property, 'ffe');

//     expect(be.decode(b.toBytes()), 0);
//     expect(le.decode(b.toBytes()), 0);
//     expect(le.encode(f, b), 4);
//     expect(le.decode(b.toBytes()), f);
//     expect(be.decode(b.toBytes()), fe);
//     expect(be.encode(f, b), 4);
//     expect(bytesEqual(BytesUtils.fromHexString('47f12010'), b.toBytes()), true);
//     expect(be.decode(b.toBytes()), f);
//     expect(le.decode(b.toBytes()), fe);

//     b = LayoutByteWriter.filled(6, 0xa5);
//     le.encode(f, b, offset: 1);
//     expect(bytesEqual(BytesUtils.fromHexString('a51020f147a5'), b.toBytes()),
//         true);
//     expect(f, le.decode(b.toBytes(), offset: 1));
//     be.encode(f, b, offset: 1);
//     expect(bytesEqual(BytesUtils.fromHexString('a547f12010a5'), b.toBytes()),
//         true);
//     expect(f, be.decode(b.toBytes(), offset: 1));
//   });
// }

// void roundedSigned64() {
//   test("be", () {
//     final be = LayoutConst.ns64be(property: "be");
//     final le = LayoutConst.ns64(property: "le");
//     expect(be.span, 8);
//     expect(le.span, 8);
//     expect(be.property, 'be');
//     expect(le.property, 'le');
//     LayoutByteWriter b = LayoutByteWriter.fromHex("ffffffff89abcdf0");
//     List<int> rb = b.toBytes().reversed.toList();
//     BigInt v = BigInt.from(-1985229328);
//     BigInt ev = v;
//     final eb = LayoutByteWriter.filled(be.span, 0);
//     expect(be.decode(b.toBytes()), ev);
//     expect(le.decode(rb), ev);
//     expect(be.encode(v, eb), 8);
//     expect(le.encode(v, eb), 8);
//     b = LayoutByteWriter.fromHex("ffffc4d5d555a345");
//     rb = b.toBytes().reversed.toList();
//     v = BigInt.from(-65052290473147);
//     ev = v;
//     expect(ev, v);
//     expect(be.decode(b.toBytes()), ev);
//     expect(le.decode(rb), ev);
//     expect(be.encode(v, eb), 8);
//     expect(be.decode(eb.toBytes()), ev);
//     expect(le.encode(v, eb), 8);
//     expect(le.decode(eb.toBytes()), ev);
//     b = LayoutByteWriter.fromHex('003b2a2aaa7fdcbb');
//     rb = b.toBytes().reversed.toList();
//     v = BigInt.parse("16653386363428027");
//     ev = v;
//     expect(ev, v);
//     expect(be.decode(b.toBytes()), ev);
//     expect(le.decode(rb), ev);
//     expect(be.encode(v, eb), 8);
//     expect(be.decode(eb.toBytes()), ev);
//     expect(le.encode(v, eb), 8);
//     expect(le.decode(eb.toBytes()), ev);
//     b = LayoutByteWriter.filled(10, 0xa5);
//     le.encode(BigInt.one, b, offset: 1);
//     expect(
//         bytesEqual(
//             BytesUtils.fromHexString("a50100000000000000a5"), b.toBytes()),
//         true);
//     expect(BigInt.one, le.decode(b.toBytes(), offset: 1));
//     be.encode(BigInt.one, b, offset: 1);
//     expect(
//         bytesEqual(
//             BytesUtils.fromHexString("a50000000000000001a5"), b.toBytes()),
//         true);
//     expect(BigInt.one, be.decode(b.toBytes(), offset: 1));
//     expect(le.decode(BytesUtils.fromHexString("0000007001000000")),
//         BigInt.from(6174015488));
//     expect(le.decode(BytesUtils.fromHexString("0000008001000000")),
//         BigInt.from(6442450944));
//     expect(le.encode(BigInt.zero, eb), 8);
//     expect(le.decode(eb.toBytes()), BigInt.zero);
//     expect(le.encode(-BigInt.one, eb), 8);
//     expect(le.decode(eb.toBytes()), -BigInt.one);
//   });
// }

// void roundedUInt64() {
//   test("be", () {
//     final be = LayoutConst.nu64be(property: "be");
//     final le = LayoutConst.nu64(property: "le");
//     expect(be.span, 8);
//     expect(le.span, 8);
//     expect(be.property, 'be');
//     expect(le.property, 'le');
//     LayoutByteWriter b = LayoutByteWriter.fromHex("0000003b2a2a873b");
//     List<int> rb = b.toBytes().reversed.toList();
//     BigInt v = BigInt.from(254110500667);
//     BigInt ev = v;
//     final eb = LayoutByteWriter.filled(be.span, 0);
//     expect(be.decode(b.toBytes()), ev);
//     expect(le.decode(rb), ev);
//     expect(be.encode(v, eb), 8);
//     expect(le.encode(v, eb), 8);
//     b = LayoutByteWriter.fromHex("001d9515553fdcbb");
//     rb = b.toBytes().reversed.toList();
//     v = BigInt.from(8326693181709499);
//     ev = v;
//     expect(ev, v);
//     expect(be.decode(b.toBytes()), ev);
//     expect(le.decode(rb), ev);
//     expect(be.encode(v, eb), 8);
//     expect(be.decode(eb.toBytes()), ev);
//     expect(le.encode(v, eb), 8);
//     expect(le.decode(eb.toBytes()), ev);
//     b = LayoutByteWriter.fromHex('003b2a2aaa7fdcbb');
//     rb = b.toBytes().reversed.toList();
//     v = BigInt.parse("16653386363428027");
//     ev = v;
//     expect(ev, v);
//     expect(be.decode(b.toBytes()), ev);
//     expect(le.decode(rb), ev);
//     expect(be.encode(v, eb), 8);
//     expect(be.decode(eb.toBytes()), ev);
//     expect(le.encode(v, eb), 8);
//     expect(le.decode(eb.toBytes()), ev);
//     b = LayoutByteWriter.filled(10, 0xa5);
//     le.encode(BigInt.one, b, offset: 1);
//     expect(
//         bytesEqual(
//             BytesUtils.fromHexString("a50100000000000000a5"), b.toBytes()),
//         true);
//     expect(BigInt.one, le.decode(b.toBytes(), offset: 1));
//     be.encode(BigInt.one, b, offset: 1);
//     expect(
//         bytesEqual(
//             BytesUtils.fromHexString("a50000000000000001a5"), b.toBytes()),
//         true);
//     expect(BigInt.one, be.decode(b.toBytes(), offset: 1));
//     expect(le.decode(BytesUtils.fromHexString("0000007001000000")),
//         BigInt.from(6174015488));
//     expect(le.decode(BytesUtils.fromHexString("0000008001000000")),
//         BigInt.from(6442450944));
//   });
// }

// void testIntBe() {
//   test("LayoutConst.s16", () {
//     final enc = LayoutConst.s16be(property: "t");
//     final bytes = LayoutByteWriter.filled(2, 0);
//     expect(enc.span, 2);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x1234, bytes), 2);
//     expect(enc.decode(bytes.toBytes()), 0x1234);
//     expect(enc.encode(-12345, bytes), 2);
//     expect(enc.decode(bytes.toBytes()), -12345);
//     expect(enc.encode(0, bytes), 2);
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(-1, bytes), 2);
//     expect(enc.decode(bytes.toBytes()), -1);
//   });
//   test("LayoutConst.s24", () {
//     final enc = LayoutConst.s24be(property: "t");
//     final bytes = LayoutByteWriter.filled(3, 0);
//     expect(enc.span, 3);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x563412, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), 0x563412);
//     expect(enc.encode(-0x800000, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), -0x800000);
//     expect(enc.encode(-1, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), -1);
//     expect(enc.encode(0, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
//   test("LayoutConst.s32", () {
//     final enc = LayoutConst.s32be(property: "t");
//     final bytes = LayoutByteWriter.filled(4, 0);
//     expect(enc.span, 4);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x563412, bytes), 4);
//     expect(enc.decode(bytes.toBytes()), 0x563412);
//     expect(enc.encode(-0x800000, bytes), 4);
//     expect(enc.decode(bytes.toBytes()), -0x800000);
//     expect(enc.encode(-1, bytes), 4);
//     expect(enc.decode(bytes.toBytes()), -1);
//     expect(enc.encode(0, bytes), 4);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
//   test("s40", () {
//     final enc = LayoutConst.s40be(property: "t");
//     final bytes = LayoutByteWriter.filled(5, 0);
//     expect(enc.span, 5);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x123456789a, bytes), 5);
//     expect(enc.decode(bytes.toBytes()), 0x123456789a);
//     expect(enc.encode(-0x8000000000, bytes), 5);
//     expect(enc.decode(bytes.toBytes()), -0x8000000000);
//     expect(enc.encode(-1, bytes), 5);
//     expect(enc.decode(bytes.toBytes()), -1);
//     expect(enc.encode(0, bytes), 5);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
//   test("s48", () {
//     final enc = LayoutConst.s48be(property: "t");
//     final bytes = LayoutByteWriter.filled(6, 0);
//     expect(enc.span, 6);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x123456789abc, bytes), 6);
//     expect(enc.decode(bytes.toBytes()), 0x123456789abc);
//     expect(enc.encode(-123456789012345, bytes), 6);
//     expect(enc.decode(bytes.toBytes()), -123456789012345);
//     expect(enc.encode(-1, bytes), 6);
//     expect(enc.decode(bytes.toBytes()), -1);
//     expect(enc.encode(0, bytes), 6);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
// }

// void testIntLe() {
//   test("s8", () {
//     final enc = LayoutConst.s8(property: "t");
//     final bytes = LayoutByteWriter.filled(1, 0);
//     expect(enc.span, 1);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(23, bytes), 1);
//     expect(enc.decode(bytes.toBytes()), 23);
//     expect(enc.encode(-97, bytes), 1);
//     expect(enc.decode(bytes.toBytes()), -97);
//     expect(enc.encode(0, bytes), 1);
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(-1, bytes), 1);
//     expect(enc.decode(bytes.toBytes()), -1);
//   });
//   test("LayoutConst.s16", () {
//     final enc = LayoutConst.s16(property: "t");
//     final bytes = LayoutByteWriter.filled(2, 0);
//     expect(enc.span, 2);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x1234, bytes), 2);
//     expect(enc.decode(bytes.toBytes()), 0x1234);
//     expect(enc.encode(-12345, bytes), 2);
//     expect(enc.decode(bytes.toBytes()), -12345);
//   });
//   test("LayoutConst.s24", () {
//     final enc = LayoutConst.s24(property: "t");
//     final bytes = LayoutByteWriter.filled(3, 0);
//     expect(enc.span, 3);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x563412, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), 0x563412);
//     expect(enc.encode(-0x800000, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), -0x800000);
//     expect(enc.encode(-1, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), -1);
//     expect(enc.encode(0, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
//   test("s40", () {
//     final enc = LayoutConst.s40(property: "t");
//     final bytes = LayoutByteWriter.filled(5, 0);
//     expect(enc.span, 5);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x123456789a, bytes), 5);
//     expect(enc.decode(bytes.toBytes()), 0x123456789a);
//     expect(enc.encode(-0x8000000000, bytes), 5);
//     expect(enc.decode(bytes.toBytes()), -0x8000000000);
//     expect(enc.encode(-1, bytes), 5);
//     expect(enc.decode(bytes.toBytes()), -1);
//     expect(enc.encode(0, bytes), 5);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
//   test("s48", () {
//     final enc = LayoutConst.s48(property: "t");
//     final bytes = LayoutByteWriter.filled(6, 0);
//     expect(enc.span, 6);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x123456789abc, bytes), 6);
//     expect(enc.decode(bytes.toBytes()), 0x123456789abc);
//     expect(enc.encode(-123456789012345, bytes), 6);
//     expect(enc.decode(bytes.toBytes()), -123456789012345);
//     expect(enc.encode(-1, bytes), 6);
//     expect(enc.decode(bytes.toBytes()), -1);
//     expect(enc.encode(0, bytes), 6);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
// }

// void testUintBe() {
//   test("LayoutConst.u16be", () {
//     final enc = LayoutConst.u16be(property: "t");
//     final bytes = LayoutByteWriter.filled(2, 0);
//     expect(enc.span, 2);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x1234, bytes), 2);
//     expect(enc.decode(bytes.toBytes()), 0x1234);
//     expect(enc.encode(0, bytes), 2);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
//   test("u24be", () {
//     final enc = LayoutConst.u24be(property: "t");
//     final bytes = LayoutByteWriter.filled(3, 0);
//     expect(enc.span, 3);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x123456, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), 0x123456);
//     expect(enc.encode(0, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
//   test("u32be", () {
//     final enc = LayoutConst.u32be(property: "t");
//     final bytes = LayoutByteWriter.filled(4, 0);
//     expect(enc.span, 4);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x12345678, bytes), 4);
//     expect(enc.decode(bytes.toBytes()), 0x12345678);
//   });
//   test("u40be", () {
//     final enc = LayoutConst.u40be(property: "t");
//     final bytes = LayoutByteWriter.filled(5, 0);
//     expect(enc.span, 5);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x123456789a, bytes), 5);
//     expect(enc.decode(bytes.toBytes()), 0x123456789a);
//   });
//   test("LayoutConst.u48be", () {
//     final enc = LayoutConst.u48be(property: "t");
//     final bytes = LayoutByteWriter.filled(6, 0);
//     expect(enc.span, 6);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x123456789abc, bytes), 6);
//     expect(enc.decode(bytes.toBytes()), 0x123456789abc);
//   });
//   test("LayoutConst.offset", () {
//     final enc = LayoutConst.u16be(property: "t");
//     final LayoutByteWriter bytes = LayoutByteWriter.filled(4, 0xa5);
//     enc.encode(0x1234, bytes, offset: 1);
//     expect(enc.decode(bytes.toBytes(), offset: 2), 0x34A5);
//   });
// }

// void testUint() {
//   test("LayoutConst.u8", () {
//     final enc = LayoutConst.u8(property: "t");
//     final LayoutByteWriter bytes = LayoutByteWriter.filled(1, 0);
//     expect(enc.span, 1);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(23, bytes), 1);
//     expect(enc.decode(bytes.toBytes()), 23);
//     expect(enc.encode(0, bytes), 1);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
//   test("LayoutConst.u16", () {
//     final enc = LayoutConst.u16(property: "t");
//     final LayoutByteWriter bytes = LayoutByteWriter.filled(2, 0);
//     expect(enc.span, 2);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x1234, bytes), 2);
//     expect(enc.decode(bytes.toBytes()), 0x1234);
//     expect(enc.encode(0, bytes), 2);
//     expect(enc.decode(bytes.toBytes()), 0);
//   });
//   test("LayoutConst.u24", () {
//     final enc = LayoutConst.u24(property: "t");
//     final bytes = LayoutByteWriter.filled(3, 0);
//     expect(enc.span, 3);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x563412, bytes), 3);
//     expect(enc.decode(bytes.toBytes()), 0x563412);
//   });
//   test("LayoutConst.u48", () {
//     final enc = LayoutConst.u48(property: "t");
//     final bytes = LayoutByteWriter.filled(6, 0);
//     expect(enc.span, 6);
//     expect(enc.getSpan(null), enc.span);
//     expect(enc.property, "t");
//     expect(enc.decode(bytes.toBytes()), 0);
//     expect(enc.encode(0x123456789abc, bytes), 6);
//     expect(enc.decode(bytes.toBytes()), 0x123456789abc);
//   });
//   test("LayoutConst.offset", () {
//     final enc = LayoutConst.u16(property: "t");
//     final bytes = LayoutByteWriter.filled(4, 0xa5);
//     enc.encode(0x3412, bytes, offset: 1);
//     expect(enc.decode(bytes.toBytes(), offset: 2), 0xA534);
//   });
// }


// void main() {
//   test("bitSequance", () {
//     final a = [
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1,
//       1
//     ];

//     final lay2 = BitSequenceLayout();
//     final ser = lay2.serialize(a);
//     expect(ser.tohex(), "080101010101010101010101010101010101010101010101");
//   });
// }

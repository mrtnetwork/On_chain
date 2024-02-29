import 'dart:typed_data';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/core/core.dart';

class LayoutUtils {
  /// [GreedyCount].
  static GreedyCount greedy({int elementSpan = 1, String? property}) =>
      GreedyCount(elementSpan, property);

  /// [OffsetLayout].
  static OffsetLayout offset(Layout layout, int offset, [String? property]) =>
      OffsetLayout(layout, offset: offset, property: property);

  /// [IntegerLayout] (unsigned int layouts) spanning one byte.
  static IntegerLayout u8([String? property]) =>
      IntegerLayout(1, property: property);

  /// [IntegerLayout] (signed int layouts) spanning one byte.
  static IntegerLayout i8([String? property]) =>
      IntegerLayout(1, property: property, sign: true);

  /// [IntegerLayout] (little-endian unsigned int layouts) spanning two bytes.
  static IntegerLayout u16([String? property]) =>
      IntegerLayout(2, property: property);

  /// [IntegerLayout] (little-endian unsigned int layouts) spanning two bytes.
  static IntegerLayout i16([String? property]) =>
      IntegerLayout(2, property: property, sign: true);

  /// [IntegerLayout] (little-endian unsigned int layouts) spanning three bytes.
  static IntegerLayout u24([String? property]) =>
      IntegerLayout(3, property: property);

  /// [IntegerLayout] (little-endian unsigned int layouts) spanning three bytes.
  static IntegerLayout i24([String? property]) =>
      IntegerLayout(3, property: property, sign: true);

  /// [IntegerLayout] (little-endian unsigned int layouts) spanning four bytes.
  static IntegerLayout u32([String? property]) =>
      IntegerLayout(4, property: property);

  /// [IntegerLayout] (little-endian unsigned int layouts) spanning four bytes.
  static IntegerLayout i32([String? property]) =>
      IntegerLayout(4, property: property, sign: true);

  /// [IntegerLayout] (little-endian unsigned int layouts) spanning five bytes.
  static IntegerLayout u40([String? property]) =>
      IntegerLayout(5, property: property);

  /// [IntegerLayout] (little-endian unsigned int layouts) spanning five bytes.
  static IntegerLayout i40([String? property]) =>
      IntegerLayout(5, property: property, sign: true);

  /// [IntegerLayout] (little-endian unsigned int layouts) spanning six bytes.
  static IntegerLayout u48([String? property]) =>
      IntegerLayout(6, property: property);

  /// [IntegerLayout] (little-endian unsigned int layouts) spanning six bytes.
  static IntegerLayout i48([String? property]) =>
      IntegerLayout(6, property: property, sign: true);

  /// [BigIntLayout] (little-endian unsigned int layouts) interpreted as Numbers.
  static BigIntLayout nu64([String? property]) =>
      BigIntLayout(8, property: property);

  /// [IntegerLayout] (big-endian unsigned int layouts) spanning two bytes.
  static IntegerLayout u16be([String? property]) =>
      IntegerLayout(2, property: property, order: Endian.big);

  /// [IntegerLayout] (big-endian unsigned int layouts) spanning three bytes.
  static IntegerLayout u24be([String? property]) =>
      IntegerLayout(3, property: property, order: Endian.big);

  /// [IntegerLayout] (big-endian unsigned int layouts) spanning four bytes.
  static IntegerLayout u32be([String? property]) =>
      IntegerLayout(4, property: property, order: Endian.big);

  /// [IntegerLayout] (big-endian unsigned int layouts) spanning five bytes.
  static IntegerLayout u40be([String? property]) =>
      IntegerLayout(5, property: property, order: Endian.big);

  /// [IntegerLayout] (big-endian unsigned int layouts) spanning six bytes.
  static IntegerLayout u48be([String? property]) =>
      IntegerLayout(6, property: property, order: Endian.big);

  /// [BigIntLayout] (big-endian unsigned int layouts) interpreted as Numbers.
  static BigIntLayout nu64be([String? property]) =>
      BigIntLayout(8, property: property, order: Endian.big);

  /// [IntegerLayout] (signed int layouts) spanning one byte.
  static IntegerLayout s8([String? property]) =>
      IntegerLayout(1, property: property, sign: true);

  /// [IntegerLayout] (little-endian signed int layouts) spanning two bytes.
  static IntegerLayout s16([String? property]) =>
      IntegerLayout(2, property: property, sign: true);

  /// [IntegerLayout] (little-endian signed int layouts) spanning three bytes.
  static IntegerLayout s24([String? property]) =>
      IntegerLayout(3, property: property, sign: true);

  /// [IntegerLayout] (little-endian signed int layouts) spanning four bytes.
  static IntegerLayout s32([String? property]) =>
      IntegerLayout(4, property: property, sign: true);

  /// [IntegerLayout] (little-endian signed int layouts) spanning five bytes.
  static IntegerLayout s40([String? property]) =>
      IntegerLayout(5, property: property, sign: true);

  /// [IntegerLayout] (little-endian signed int layouts) spanning six bytes.
  static IntegerLayout s48([String? property]) =>
      IntegerLayout(6, property: property, sign: true);

  /// [BigIntLayout] (little-endian signed int layouts) interpreted as Numbers.
  static BigIntLayout ns64([String? property]) =>
      BigIntLayout(8, property: property, sign: true);

  /// [IntegerLayout] (big-endian signed int layouts) spanning two bytes.
  static IntegerLayout s16be([String? property]) =>
      IntegerLayout(2, property: property, sign: true, order: Endian.big);

  /// [IntegerLayout] (big-endian signed int layouts) spanning three bytes.
  static IntegerLayout s24be([String? property]) =>
      IntegerLayout(3, property: property, sign: true, order: Endian.big);

  /// [IntegerLayout] (big-endian signed int layouts) spanning four bytes.
  static IntegerLayout s32be([String? property]) =>
      IntegerLayout(4, property: property, sign: true, order: Endian.big);

  /// [IntegerLayout] (big-endian signed int layouts) spanning five bytes.
  static IntegerLayout s40be([String? property]) =>
      IntegerLayout(5, property: property, sign: true, order: Endian.big);

  /// [IntegerLayout] (big-endian signed int layouts) spanning six bytes.
  static IntegerLayout s48be([String? property]) =>
      IntegerLayout(6, property: property, sign: true, order: Endian.big);

  /// [BigIntLayout] (big-endian signed int layouts) interpreted as Numbers.
  static BigIntLayout ns64be([String? property]) =>
      BigIntLayout(8, property: property, sign: true, order: Endian.big);

  /// [DoubleLayout] (little-endian 32-bit floating point) values.
  static DoubleLayout f32([String? property]) =>
      DoubleLayout.f32(property: property);

  /// [DoubleLayout] (big-endian 32-bit floating point) values.
  static DoubleLayout f32be([String? property]) =>
      DoubleLayout.f32(property: property, order: Endian.big);

  /// [DoubleLayout] (little-endian 64-bit floating point) values.
  static DoubleLayout f64([String? property]) =>
      DoubleLayout.f64(property: property);

  /// [DoubleLayout] (big-endian 64-bit floating point) values.
  static DoubleLayout f64be([String? property]) =>
      DoubleLayout.f64(property: property, order: Endian.big);

  /// [Structure] values.
  static Structure struct(List<Layout> fields,
          [String? property, bool decodePrefixes = false]) =>
      Structure(fields, property: property, decodePrefixes: decodePrefixes);

  /// [Sequence] values.
  static Sequence seq<T>(Layout elementLayout, Layout count,
          {String? property}) =>
      Sequence<T>(
          elementLayout: elementLayout, count: count, property: property);

  /// [Union] values.
  static Union union(dynamic discr,
          {Layout? defaultLayout, String? property}) =>
      Union(discr, defaultLayout: defaultLayout, property: property);

  /// [UnionLayoutDiscriminator] values.
  static UnionLayoutDiscriminator unionLayoutDiscriminator(
          ExternalLayout layout,
          {String? property}) =>
      UnionLayoutDiscriminator(layout, property: property);

  /// [Blob] values.
  static Blob blob(dynamic length, {String? property}) =>
      Blob(length, property: property);

  /// [CString] values.
  static CString cstr([String? property]) => CString(property: property);

  /// [UTF8] values.
  static UTF8 utf8({int? maxSpan, String? property}) =>
      UTF8(maxSpan: maxSpan ?? -1, property: property);

  /// [Constant] values.
  static Constant constant(dynamic value, {String? property}) =>
      Constant(value, property: property);
  static String nameWithProperty(String name, Layout? lo) {
    if (lo?.property != null) {
      return '$name[${lo!.property!}]';
    }
    return name;
  }

  /// [SolAddress] values.
  static CustomLayout publicKey([String? property]) {
    return CustomLayout<List<int>, SolAddress>(
        layout: blob(32),
        decoder: (data) => SolAddress.uncheckBytes(data),
        encoder: (src) => src.toBytes(),
        property: property);
  }

  /// optional [SolAddress] values.
  static OptionalLayout optionPubkey(
      {String? property, bool keepSize = false, Layout? discriminator}) {
    return OptionalLayout(publicKey(),
        property: property,
        keepLayoutSize: keepSize,
        discriminator: discriminator);
  }

  static COptionPublicKeyLayout cOptionalPublicKey(
      {String? property, bool keepSize = false, Layout? discriminator}) {
    return COptionPublicKeyLayout(property: property);
  }

  /// [BigIntLayout] (little-endian unsigned int layouts) interpreted as Numbers.
  static BigIntLayout u64([String? property]) =>
      BigIntLayout(8, property: property);

  /// [BigIntLayout] (little-endian signed int layouts) interpreted as Numbers.
  static BigIntLayout i64([String? property]) =>
      BigIntLayout(8, sign: true, property: property);

  /// [BigIntLayout] (little-endian unsigned int layouts) interpreted as Numbers.
  static BigIntLayout u128([String? property]) =>
      BigIntLayout(16, property: property);

  /// [BigIntLayout] (little-endian signed int layouts) interpreted as Numbers.
  static BigIntLayout i128([String? property]) =>
      BigIntLayout(16, sign: true, property: property);

  /// optional [BigIntLayout] (little-endian unsigned int layouts) interpreted as Numbers.
  static OptionalLayout optionU64([String? property]) {
    return OptionalLayout<BigInt>(u64(), property: property);
  }

  /// [OptionalLayout]
  static OptionalLayout optional(Layout layout,
      {String? property, bool keepSize = false, Layout? discriminator}) {
    return OptionalLayout(layout,
        property: property,
        discriminator: discriminator,
        keepLayoutSize: keepSize);
  }

  /// [bool] values
  static CustomLayout boolean({String? property, Layout<int>? layout}) {
    return CustomLayout<int, bool>(
        layout: layout ?? u8(),
        decoder: (data) {
          return data == 0 ? false : true;
        },
        encoder: (src) {
          return src ? 1 : 0;
        },
        property: property);
  }

  /// [bool] 4 bytes values
  static CustomLayout boolean32([String? property]) {
    return boolean(property: property, layout: u32());
  }

  /// Rust vector values
  static CustomLayout rustVecU8([String? property]) {
    final length = u32('length');
    final layout = struct([
      length,
      u32('lengthPadding'),
      blob(offset(length, -8), property: 'data'),
    ]);
    return CustomLayout(
      layout: layout,
      encoder: (data) => {"data": data},
      decoder: (data) => data["data"],
      property: property,
    );
  }

  /// vector bytes
  static CustomLayout vecU8([String? property]) {
    final length = u32('length');
    final layout = struct([
      length,
      blob(offset(length, -length.span), property: 'data'),
    ]);
    return CustomLayout(
      layout: layout,
      encoder: (data) => {"data": data},
      decoder: (data) => data["data"],
      property: property,
    );
  }

  /// enum values
  static Layout rustEnum(List<Layout> variants, Layout? discriminant,
      {String? property}) {
    final unionLayout = Union((discriminant != null) ? discriminant : u8());
    variants.asMap().forEach((index, variant) => unionLayout.addVariant(
        variant: index, layout: variant, property: variant.property));
    return CustomLayout<Map<String, dynamic>, dynamic>(
        layout: unionLayout,
        decoder: (value) {
          return {"key": value.keys.first, "value": value.values.first};
        },
        encoder: (src) {
          return src;
        },
        property: property);
  }

  /// Rust String values.
  static rustString([String? property]) {
    return CustomLayout(
        layout: rustVecU8(),
        decoder: (bytes) => StringUtils.decode(bytes as List<int>),
        encoder: (src) => StringUtils.encode(src as String),
        property: property);
  }

  /// String values
  static string([String? property]) {
    return CustomLayout(
        layout: vecU8(),
        decoder: (bytes) => StringUtils.decode(bytes as List<int>),
        encoder: (src) => StringUtils.encode(src as String),
        property: property);
  }

  /// vectors
  static CustomLayout vec(Layout elementLayout, {String? property}) {
    final length = u32('length');
    final layout = struct([
      length,
      seq(elementLayout, offset(length, -length.span), property: 'values'),
    ]);
    return CustomLayout<Map<String, dynamic>, dynamic>(
      layout: layout,
      encoder: (data) => {"values": data},
      decoder: (data) => data["values"],
      property: property,
    );
  }

  /// factory for Rust vectors
  static CustomLayout rustVec(Layout elementLayout, {String? property}) {
    final length = u32('length');
    final padding = u32('paddingLength');
    final layout = struct([
      length,
      padding,
      seq(elementLayout, offset(length, -8), property: 'values'),
    ]);
    return CustomLayout<Map<String, dynamic>, dynamic>(
      layout: layout,
      encoder: (data) => {"values": data},
      decoder: (data) => data["values"],
      property: property,
    );
  }

  /// map values
  static CustomLayout map(Layout keyLayout, Layout valueLayout,
      {String? property}) {
    final length = u32('length');
    final layout = struct([
      length,
      seq(
        MapEntryLayout(
            keyLayout: keyLayout, valueLayout: valueLayout, property: ""),
        offset(length, -length.span),
        property: 'values',
      ),
    ]);
    return CustomLayout<Map<String, dynamic>, Map<dynamic, dynamic>>(
      layout: layout,
      decoder: (data) {
        final List<MapEntry<dynamic, dynamic>> values =
            (data['values'] as List).cast();
        return Map.fromEntries(values);
      },
      encoder: (values) => {'values': values.entries.toList()},
      property: property,
    );
  }

  /// arrays
  static CustomLayout array(Layout elementLayout, int length,
      {String? property}) {
    final layout = struct([
      seq(elementLayout, Constant(length), property: 'values'),
    ]);
    return CustomLayout<Map<String, dynamic>, dynamic>(
      layout: layout,
      decoder: (data) => data['values'],
      encoder: (values) => {'values': values},
      property: property,
    );
  }

  /// arrays with greedy size layout.
  static CustomLayout greedyArray(Layout elementLayout, {String? property}) {
    final layout = struct([
      seq(elementLayout, greedy(elementSpan: elementLayout.span),
          property: 'values'),
    ]);
    return CustomLayout<Map<String, dynamic>, dynamic>(
      layout: layout,
      decoder: (data) => data['values'],
      encoder: (values) => {'values': values},
      property: property,
    );
  }

  /// tuple values
  static TupleLayout tuple(List<Layout> layouts, {String? property}) {
    return TupleLayout(layouts, property: property);
  }

  /// no data values
  static None none([String? property]) {
    return None(property: property);
  }

  /// wrap layouts for property handling
  static Layout wrap(Layout layout, {String? property}) {
    return CustomLayout(
        layout: layout,
        decoder: (value) => value,
        encoder: (src) => src,
        property: property);
  }
}

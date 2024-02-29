import 'dart:typed_data';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/byte_writer/layout_byte_write.dart';
import 'package:on_chain/solana/src/layout/core/core.dart';
import 'package:on_chain/solana/src/layout/encoder/double_utils.dart';
import 'package:on_chain/solana/src/layout/encoder/float_utils.dart';

/// Represents an external layout.
abstract class ExternalLayout extends Layout<int> {
  ExternalLayout(int span, {String? property})
      : super(span, property: property);
  bool isCount() => false;
}

/// Represents a layout that greedily consumes bytes until the end.
class GreedyCount extends ExternalLayout {
  int elementSpan;

  GreedyCount([this.elementSpan = 1, String? property])
      : assert(!elementSpan.isNegative),
        super(-1, property: property);

  @override
  bool isCount() {
    return true;
  }

  @override
  int decode(List<int> bytes, {int offset = 0}) {
    final rem = bytes.length - offset;
    return rem ~/ elementSpan;
  }

  @override
  int encode(int source, LayoutByteWriter writer, {int offset = 0}) {
    return 0;
  }

  @override
  Layout clone({String? newProperty}) {
    return GreedyCount(elementSpan, newProperty);
  }
}

/// Represents a layout for integers.
class IntegerLayout extends Layout<int> {
  final bool sign;
  final Endian order;
  void _validateSource(int value) {
    if (value.isNegative && !sign) {
      throw MessageException(
          "Negative value cannot be encoded with unsigned layout.");
    }
    if (value.bitLength > span * 8) {
      throw MessageException(
          "Value exceeds the maximum size for encoding with this layout.");
    }
  }

  IntegerLayout(int span,
      {this.sign = false, this.order = Endian.little, String? property})
      : super(span, property: property) {
    if (6 < this.span) {
      throw RangeError('span must not exceed 6 bytes');
    }
  }

  @override
  int decode(List<int>? bytes, {int offset = 0}) {
    final data = bytes!.sublist(offset, offset + span);
    if (span > 4) {
      final decode = BigintUtils.fromBytes(data, sign: sign, byteOrder: order);
      return decode.toInt();
    }

    final decode = IntUtils.fromBytes(data, sign: sign, byteOrder: order);
    return decode;
  }

  @override
  int encode(int source, LayoutByteWriter writer, {int offset = 0}) {
    _validateSource(source);
    final bytes = span > 4
        ? BigintUtils.toBytes(BigInt.from(source), length: span, order: order)
        : IntUtils.toBytes(source, length: span, byteOrder: order);
    writer.setAll(offset, bytes);
    return span;
  }

  @override
  Layout clone({String? newProperty}) {
    return IntegerLayout(span, sign: sign, order: order, property: newProperty);
  }
}

/// Represents a layout for double-precision floating point numbers.
class DoubleLayout extends Layout<double> {
  final Endian order;
  DoubleLayout.f32({String? property, this.order = Endian.little})
      : super(4, property: property);
  DoubleLayout.f64({String? property, this.order = Endian.little})
      : super(8, property: property);

  @override
  double decode(List<int> bytes, {int offset = 0}) {
    final data = bytes.sublist(offset, offset + span);
    if (span > 4) {
      return DoubleCoder.fromBytes(data, byteOrder: order);
    }
    return FloatCoder.fromBytes(data, byteOrder: order);
  }

  @override
  int encode(double source, LayoutByteWriter writer, {int offset = 0}) {
    final bytes = span > 4
        ? DoubleCoder.toBytes(source, byteOrder: order)
        : FloatCoder.toBytes(source, byteOrder: order);
    writer.setAll(offset, bytes);
    return span;
  }

  @override
  DoubleLayout clone({String? newProperty}) {
    if (span > 4) {
      return DoubleLayout.f64(property: newProperty, order: order);
    }
    return DoubleLayout.f32(property: newProperty, order: order);
  }
}

/// Represents a layout for big integers.
class BigIntLayout extends Layout<BigInt> {
  final bool sign;
  final Endian order;
  BigIntLayout(int span,
      {this.sign = false, this.order = Endian.little, String? property})
      : super(span, property: property);
  void _validateSource(BigInt value) {
    if (value.isNegative && !sign) {
      throw MessageException(
          "Negative value cannot be encoded with unsigned layout.");
    }
    if (value.bitLength > span * 8) {
      throw MessageException(
          "Value exceeds the maximum size for encoding with this layout.");
    }
  }

  @override
  BigInt decode(List<int> bytes, {int offset = 0}) {
    final toBigint = BigintUtils.fromBytes(bytes.sublist(offset, offset + span),
        byteOrder: order, sign: sign);
    return toBigint;
  }

  @override
  int encode(BigInt source, LayoutByteWriter writer, {int offset = 0}) {
    _validateSource(source);
    final toBytes = BigintUtils.toBytes(source, length: span, order: order);
    final Layout layout = Blob(span, property: property);
    layout.encode(toBytes, writer, offset: offset);
    return span;
  }

  @override
  Layout clone({String? newProperty}) {
    return BigIntLayout(span, sign: sign, order: order, property: newProperty);
  }
}

/// Represents a union discriminator layout.
abstract class UnionDiscriminator extends Layout<int> {
  UnionDiscriminator(String property) : super(0, property: property);
}

/// Represents a union layout discriminator.
class UnionLayoutDiscriminator extends UnionDiscriminator {
  final ExternalLayout layout;

  UnionLayoutDiscriminator(this.layout, {String? property})
      : assert(layout.isCount(),
            'layout must be an unsigned integer ExternalLayout'),
        super(property ?? layout.property ?? 'variant');

  @override
  int decode(List<int> bytes, {int offset = 0}) {
    return layout.decode(bytes, offset: offset);
  }

  @override
  int encode(int source, LayoutByteWriter writer, {int offset = 0}) {
    return layout.encode(source, writer, offset: offset);
  }

  @override
  Layout clone({String? newProperty}) {
    return UnionLayoutDiscriminator(layout, property: newProperty);
  }
}

/// Represents an offset layout.
class OffsetLayout extends ExternalLayout {
  final Layout layout;
  final int offset;

  OffsetLayout(this.layout, {this.offset = 0, String? property})
      : super(layout.span, property: property ?? layout.property);

  @override
  bool isCount() {
    return layout is IntegerLayout && !(layout as IntegerLayout).sign;
  }

  @override
  int decode(List<int> bytes, {int offset = 0}) {
    return layout.decode(bytes, offset: offset + this.offset);
  }

  @override
  int encode(int source, LayoutByteWriter writer, {int offset = 0}) {
    return layout.encode(source, writer, offset: offset + this.offset);
  }

  @override
  OffsetLayout clone({String? newProperty}) {
    return OffsetLayout(layout, offset: offset, property: newProperty);
  }
}

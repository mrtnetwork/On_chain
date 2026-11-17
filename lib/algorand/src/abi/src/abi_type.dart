import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/algorand/src/abi/src/constants.dart';
import 'package:on_chain/algorand/src/abi/src/types.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Values accepted by ABI encode/decode.
typedef ABIValue = Object?;

/// Abstract base for all Algorand ABI types.
abstract class ABIType with Equality implements ABIArgumentType {
  const ABIType();

  /// String representation of the type (e.g. `uint64`, `string[]`).
  @override
  String getName();

  /// Whether this type (or any child) has dynamic length.
  bool isDynamic();

  /// Fixed byte length. Throws if the type is dynamic.
  int byteLen();

  /// Encodes [value] according to the ABI specification.
  List<int> encode(ABIValue value);

  /// Decodes [bytes] according to the ABI specification.
  ABIValue decode(List<int> bytes);

  /// Parses an ABI type string into an [ABIType] instance.
  factory ABIType.from(String str) {
    final staticArrayRegexp = RegExp(r'^([a-z\d\[\](),]+)\[(0|[1-9][\d]*)]$');
    final ufixedRegexp = RegExp(r'^ufixed([1-9][\d]*)x([1-9][\d]*)$');

    if (str.endsWith('[]')) {
      final child = ABIType.from(str.substring(0, str.length - 2));
      return ABIArrayDynamicType(child);
    }

    if (str.endsWith(']')) {
      final match = staticArrayRegexp.firstMatch(str);
      if (match == null || match.groupCount != 2) {
        throw OnChainErrors.algoPlugin(
          'ABIType.from',
          reason: 'malformed static array string: $str',
        );
      }
      final length = IntUtils.parse(match.group(2)!);
      if (length > AlgoAbiUtils.maxLen) {
        throw OnChainErrors.algoPlugin(
          'ABIType.from',
          reason: 'array length exceeds limit ${AlgoAbiUtils.maxLen}',
        );
      }
      final child = ABIType.from(match.group(1)!);
      return ABIArrayStaticType(child, length);
    }

    if (str.startsWith('uint')) {
      final sizeStr = str.substring(4);
      if (!_digitsOnly(sizeStr)) {
        throw OnChainErrors.algoPlugin(
          'ABIType.from',
          reason: 'malformed uint string: $sizeStr',
        );
      }

      final size = IntUtils.parse(sizeStr);
      if (size > AlgoAbiUtils.maxLen) {
        throw OnChainErrors.algoPlugin(
          'ABIType.from',
          reason: 'malformed uint string: $size',
        );
      }
      return ABIUintType(size);
    }

    if (str == 'byte') return ABIByteType();

    if (str.startsWith('ufixed')) {
      final match = ufixedRegexp.firstMatch(str);
      if (match == null || match.groupCount != 2) {
        throw OnChainErrors.algoPlugin(
          'ABIType.from',
          reason: 'malformed ufixed type: $str',
        );
      }

      final size = IntUtils.parse(match.group(1)!);
      final precision = IntUtils.parse(match.group(2)!);
      return ABIUfixedType(size, precision);
    }

    if (str == 'bool') return ABIBoolType();
    if (str == 'address') return ABIAddressType();
    if (str == 'string') return ABIStringType();

    if (str.length >= 2 && str.startsWith('(') && str.endsWith(')')) {
      final content = ABITupleType.parseTupleContent(
        str.substring(1, str.length - 1),
      );
      final types = content.map(ABIType.from).toList();
      return ABITupleType(types);
    }

    throw OnChainErrors.algoPlugin(
      'ABIType.from',
      reason: 'cannot convert string "$str" to an ABI type',
    );
  }

  static bool _digitsOnly(String s) {
    if (s.isEmpty) return false;
    for (final c in s.codeUnits) {
      if (c < 0x30 || c > 0x39) return false;
    }
    return true;
  }

  @override
  List<dynamic> get variables => const [];
}

/// Unsigned integer type `uint<N>` (8 ≤ N ≤ 512, N % 8 == 0).
class ABIUintType extends ABIType {
  final int bitSize;

  ABIUintType(this.bitSize) {
    if (bitSize % 8 != 0 || bitSize < 8 || bitSize > 512) {
      throw OnChainErrors.algoPlugin(
        'ABIUintType',
        reason: 'unsupported uint bitSize: $bitSize',
      );
    }
  }

  @override
  String getName() => 'uint$bitSize';

  @override
  bool isDynamic() => false;

  @override
  int byteLen() => bitSize ~/ 8;

  @override
  List<int> encode(ABIValue value) {
    final BigInt bi = JsonParser.valueAsBigInt(value);
    final max = BigInt.one << bitSize;
    if (bi < BigInt.zero || bi >= max) {
      throw OnChainErrors.algoPlugin(
        'ABIUintType.encode',
        reason:
            '$value is not a non-negative int or too large for uint$bitSize',
      );
    }
    return bi.toBeBytes(length: byteLen());
  }

  @override
  BigInt decode(List<int> bytes) {
    if (bytes.length != byteLen()) {
      throw OnChainErrors.algoPlugin(
        'ABIUintType.decode',
        reason: 'byte string must be ${byteLen()} bytes for uint$bitSize',
      );
    }
    return BigintUtils.fromBytes(bytes);
  }

  @override
  List<dynamic> get variables => [bitSize];
}

/// Fixed-point unsigned type `ufixedNxM`.
class ABIUfixedType extends ABIType {
  final int bitSize;
  final int precision;

  ABIUfixedType(this.bitSize, this.precision) {
    if (bitSize % 8 != 0 || bitSize < 8 || bitSize > 512) {
      throw OnChainErrors.algoPlugin(
        'ABIUfixedType',
        reason: 'unsupported ufixed bitSize: $bitSize',
      );
    }
    if (precision < 1 || precision > 160) {
      throw OnChainErrors.algoPlugin(
        'ABIUfixedType',
        reason: 'unsupported ufixed precision: $precision',
      );
    }
  }

  @override
  String getName() => 'ufixed${bitSize}x$precision';

  @override
  bool isDynamic() => false;

  @override
  int byteLen() => bitSize ~/ 8;

  @override
  List<int> encode(ABIValue value) {
    final BigInt bi = JsonParser.valueAsBigInt(value);
    final max = BigInt.one << bitSize;
    if (bi < BigInt.zero || bi >= max) {
      throw OnChainErrors.algoPlugin(
        'ABIUfixedType.encode',
        reason:
            '$value is not a non-negative int or too large for ${getName()}',
      );
    }
    return bi.toBeBytes(length: byteLen());
  }

  @override
  BigInt decode(List<int> bytes) {
    if (bytes.length != byteLen()) {
      throw OnChainErrors.algoPlugin(
        'ABIUfixedType.decode',
        reason: 'byte string must be ${byteLen()} bytes for ${getName()}',
      );
    }
    return BigintUtils.fromBytes(bytes);
  }

  @override
  List<dynamic> get variables => [bitSize, precision];
}

/// 32-byte Algorand address type.
class ABIAddressType extends ABIType {
  @override
  String getName() => 'address';

  @override
  bool isDynamic() => false;

  @override
  int byteLen() => AlgoAddress.bytesLength;

  @override
  List<int> encode(ABIValue value) {
    if (value is String) return AlgoAddress(value).toBytes();
    if (value is AlgoAddress) return value.toBytes();
    if (value is List<int>) {
      if (value.length != AlgoAddress.bytesLength) {
        throw OnChainErrors.algoPlugin(
          'ABIAddressType.encode',
          reason: 'byte string must be 32 bytes long for an address',
        );
      }
      return value;
    }
    throw OnChainErrors.algoPlugin(
      'ABIAddressType.encode',
      reason: 'cannot encode value as address: $value',
    );
  }

  @override
  String decode(List<int> bytes) {
    if (bytes.length != 32) {
      throw OnChainErrors.algoPlugin(
        'ABIAddressType.decode',
        reason: 'byte string must be 32 bytes long for an address',
      );
    }
    return AlgoAddress.fromBytes(bytes).address;
  }
}

/// Boolean type.
class ABIBoolType extends ABIType {
  @override
  String getName() => 'bool';

  @override
  bool isDynamic() => false;

  @override
  int byteLen() => AlgoAbiUtils.singleBoolSize;

  @override
  List<int> encode(ABIValue value) {
    final bool v = JsonParser.valueAsBool(value);
    return [v ? 0x80 : 0x00];
  }

  @override
  bool decode(List<int> bytes) {
    if (bytes.length != 1) {
      throw OnChainErrors.algoPlugin(
        'ABIBoolType.decode',
        reason: 'bool string must be 1 byte long',
      );
    }
    final v = bytes[0];
    if (v == 0x80) return true;
    if (v == 0x00) return false;
    throw OnChainErrors.algoPlugin(
      'ABIBoolType.decode',
      reason: 'boolean could not be decoded from the byte string',
    );
  }
}

/// Single byte type (alias for uint8).
class ABIByteType extends ABIType {
  @override
  String getName() => 'byte';

  @override
  bool isDynamic() => false;

  @override
  int byteLen() => AlgoAbiUtils.singleByteSize;

  @override
  List<int> encode(ABIValue value) {
    final int n = JsonParser.valueAsInt(value, allowHex: false);
    if (n < 0 || n > 255) {
      throw OnChainErrors.algoPlugin(
        'ABIByteType.encode',
        reason: '$value cannot be encoded into a byte',
      );
    }
    return [n];
  }

  @override
  int decode(List<int> bytes) {
    if (bytes.length != 1) {
      throw OnChainErrors.algoPlugin(
        'ABIByteType.decode',
        reason: 'byte string must be 1 byte long',
      );
    }
    return bytes[0];
  }
}

/// Dynamic UTF-8 string type.
class ABIStringType extends ABIType {
  @override
  String getName() => 'string';

  @override
  bool isDynamic() => true;

  @override
  int byteLen() {
    throw OnChainErrors.algoPlugin(
      'ABIStringType.byteLen',
      reason: '${getName()} is a dynamic type',
    );
  }

  @override
  List<int> encode(ABIValue value) {
    final List<int> encoded = JsonParser.valueAsBytes(
      value,
      encoding: StringEncoding.utf8,
      allowHex: false,
    );
    final lengthBytes = encoded.length.toBeBytes(
      length: AlgoAbiUtils.lengthEncodeByteSize,
    );
    return [...lengthBytes, ...encoded];
  }

  @override
  String decode(List<int> bytes) {
    if (bytes.length < AlgoAbiUtils.lengthEncodeByteSize) {
      throw OnChainErrors.algoPlugin(
        'ABIStringType.decode',
        reason:
            'byte string is too short. Actual length is ${bytes.length}, '
            'expected at least ${AlgoAbiUtils.lengthEncodeByteSize}',
      );
    }
    final length = IntUtils.fromBytes(
      bytes.sublist(0, AlgoAbiUtils.lengthEncodeByteSize),
    );
    final value = bytes.sublist(AlgoAbiUtils.lengthEncodeByteSize);
    if (length != value.length) {
      throw OnChainErrors.algoPlugin(
        'ABIStringType.decode',
        reason:
            'string length bytes do not match actual length. '
            'Expected $length, got ${value.length}',
      );
    }
    return StringUtils.decode(value);
  }
}

/// Fixed-length array type `T[N]`.
class ABIArrayStaticType extends ABIType {
  final ABIType childType;
  final int staticLength;

  ABIArrayStaticType(this.childType, this.staticLength) {
    if (staticLength < 0) {
      throw OnChainErrors.algoPlugin(
        'ABIArrayStaticType',
        reason: 'static array must have a non-negative length: $staticLength',
      );
    }
  }

  @override
  String getName() => '${childType.getName()}[$staticLength]';

  @override
  bool isDynamic() => childType.isDynamic();

  @override
  int byteLen() {
    if (childType is ABIBoolType) {
      return (staticLength + 7) ~/ 8;
    }
    return staticLength * childType.byteLen();
  }

  @override
  List<int> encode(ABIValue value) {
    final list = JsonParser.valueEnsureAsList(value);
    if (list.length != staticLength) {
      throw OnChainErrors.algoPlugin(
        'ABIArrayStaticType.encode',
        reason:
            'value array length mismatch. Expected $staticLength, got ${list.length}',
      );
    }
    return toABITupleType().encode(list);
  }

  @override
  List<ABIValue> decode(List<int> bytes) => toABITupleType().decode(bytes);

  ABITupleType toABITupleType() =>
      ABITupleType(List.filled(staticLength, childType));

  @override
  List<dynamic> get variables => [childType];
}

/// Dynamic array type `T[]`.
class ABIArrayDynamicType extends ABIType {
  final ABIType childType;

  ABIArrayDynamicType(this.childType);

  @override
  String getName() => '${childType.getName()}[]';

  @override
  bool isDynamic() => true;

  @override
  int byteLen() {
    throw OnChainErrors.algoPlugin(
      'ABIArrayDynamicType.byteLen',
      reason: '${getName()} is a dynamic type',
    );
  }

  @override
  List<int> encode(ABIValue value) {
    final list = JsonParser.valueEnsureAsList(value);
    final tuple = toABITupleType(list.length);
    final encodedTuple = tuple.encode(list);
    final lengthBytes = list.length.toBeBytes(
      length: AlgoAbiUtils.lengthEncodeByteSize,
    );
    return [...lengthBytes, ...encodedTuple];
  }

  @override
  List<ABIValue> decode(List<int> bytes) {
    if (bytes.length < AlgoAbiUtils.lengthEncodeByteSize) {
      throw OnChainErrors.algoPlugin(
        'ABIArrayDynamicType.decode',
        reason: 'byte string too short for dynamic array',
      );
    }
    final length = IntUtils.fromBytes(
      bytes.sublist(0, AlgoAbiUtils.lengthEncodeByteSize),
    );
    final tuple = toABITupleType(length);
    return tuple.decode(bytes.sublist(AlgoAbiUtils.lengthEncodeByteSize));
  }

  ABITupleType toABITupleType(int length) =>
      ABITupleType(List.filled(length, childType));

  @override
  List<dynamic> get variables => [childType];
}

/// Tuple type `(T1,...,Tn)`.
class ABITupleType extends ABIType {
  final List<ABIType> childTypes;

  ABITupleType(List<ABIType> argTypes)
    : childTypes = List.unmodifiable(argTypes) {
    if (argTypes.length >= AlgoAbiUtils.maxLen) {
      throw OnChainErrors.algoPlugin(
        'ABITupleType',
        reason: 'tuple child type count exceeds maximum uint16',
      );
    }
  }

  @override
  String getName() => '(${childTypes.map((t) => t.getName()).join(',')})';

  @override
  bool isDynamic() => childTypes.any((c) => c.isDynamic());

  @override
  int byteLen() {
    var size = 0;
    var i = 0;
    while (i < childTypes.length) {
      if (childTypes[i] is ABIBoolType) {
        final after = AlgoAbiUtils.findBoolLR(childTypes, i, 1);
        final boolNum = after + 1;
        i += after;
        size += (boolNum + 7) ~/ 8;
      } else {
        size += childTypes[i].byteLen();
      }
      i++;
    }
    return size;
  }

  @override
  List<int> encode(ABIValue value) {
    final values = JsonParser.valueEnsureAsList(value);
    if (values.length > AlgoAbiUtils.maxLen) {
      throw OnChainErrors.algoPlugin(
        'ABITupleType.encode',
        reason: 'tuple length exceeds maximum uint16',
      );
    }
    if (values.length != childTypes.length) {
      throw OnChainErrors.algoPlugin(
        'ABITupleType.encode',
        reason:
            'tuple length mismatch: expected ${childTypes.length}, got ${values.length}',
      );
    }

    final heads = <List<int>>[];
    final tails = <List<int>>[];
    final isDynamicIndex = <int, bool>{};
    var i = 0;

    while (i < childTypes.length) {
      final type = childTypes[i];
      if (type.isDynamic()) {
        isDynamicIndex[heads.length] = true;
        heads.add(List<int>.filled(AlgoAbiUtils.lengthEncodeByteSize, 0));
        tails.add(type.encode(values[i]));
      } else if (type is ABIBoolType) {
        final before = AlgoAbiUtils.findBoolLR(childTypes, i, -1);
        var after = AlgoAbiUtils.findBoolLR(childTypes, i, 1);
        if (before % 8 != 0) {
          throw OnChainErrors.algoPlugin(
            'ABITupleType.encode',
            reason: 'expected before bool count mod 8 == 0',
          );
        }
        after = after > 7 ? 7 : after;
        final compressed = AlgoAbiUtils.compressMultipleBool(
          values.sublist(i, i + after + 1),
        );
        heads.add([compressed]);
        isDynamicIndex[heads.length - 1] = false;
        tails.add(const []);
        i += after;
      } else {
        heads.add(type.encode(values[i]));
        isDynamicIndex[heads.length - 1] = false;
        tails.add(const []);
      }
      i++;
    }

    var headLength = heads.fold<int>(0, (sum, h) => sum + h.length);
    var tailLength = 0;

    for (var j = 0; j < heads.length; j++) {
      if (isDynamicIndex[j] == true) {
        final offset = headLength + tailLength;
        if (offset > AlgoAbiUtils.maxLen) {
          throw OnChainErrors.algoPlugin(
            'ABITupleType.encode',
            reason: 'byte offset $offset exceeds maximum uint16',
          );
        }
        heads[j] = offset.toBeBytes(length: AlgoAbiUtils.lengthEncodeByteSize);
      }
      tailLength += tails[j].length;
    }

    return [...heads.expand((e) => e), ...tails.expand((e) => e)];
  }

  @override
  List<ABIValue> decode(List<int> bytes) {
    final dynamicSegments = <_Segment>[];
    final valuePartition = <List<int>?>[];
    var i = 0;
    var iterIndex = 0;

    while (i < childTypes.length) {
      final type = childTypes[i];
      if (type.isDynamic()) {
        if (bytes.length - iterIndex < AlgoAbiUtils.lengthEncodeByteSize) {
          throw OnChainErrors.algoPlugin(
            'ABITupleType.decode',
            reason: 'dynamic type in tuple is too short to be decoded',
          );
        }
        final dynamicIndex = IntUtils.fromBytes(
          bytes.sublist(
            iterIndex,
            iterIndex + AlgoAbiUtils.lengthEncodeByteSize,
          ),
        );
        if (dynamicSegments.isNotEmpty) {
          dynamicSegments.last.right = dynamicIndex;
          if (dynamicIndex < dynamicSegments.last.left) {
            throw OnChainErrors.algoPlugin(
              'ABITupleType.decode',
              reason: 'dynamic index segment miscalculation: left > right',
            );
          }
        }
        dynamicSegments.add(_Segment(dynamicIndex, -1));
        valuePartition.add(null);
        iterIndex += AlgoAbiUtils.lengthEncodeByteSize;
      } else if (type is ABIBoolType) {
        final before = AlgoAbiUtils.findBoolLR(childTypes, i, -1);
        var after = AlgoAbiUtils.findBoolLR(childTypes, i, 1);
        if (before % 8 != 0) {
          throw OnChainErrors.algoPlugin(
            'ABITupleType.decode',
            reason: 'expected before bool count mod 8 == 0',
          );
        }
        after = after > 7 ? 7 : after;
        for (var boolIndex = 0; boolIndex <= after; boolIndex++) {
          final mask = 0x80 >> boolIndex;
          valuePartition.add((bytes[iterIndex] & mask) != 0 ? [0x80] : [0x00]);
        }
        i += after;
        iterIndex += 1;
      } else {
        final currLen = type.byteLen();
        valuePartition.add(bytes.sublist(iterIndex, iterIndex + currLen));
        iterIndex += currLen;
      }

      if (i != childTypes.length - 1 && iterIndex >= bytes.length) {
        throw OnChainErrors.algoPlugin(
          'ABITupleType.decode',
          reason: 'input bytes not enough to decode',
        );
      }
      i++;
    }

    if (dynamicSegments.isNotEmpty) {
      dynamicSegments.last.right = bytes.length;
      iterIndex = bytes.length;
    }
    if (iterIndex < bytes.length) {
      throw OnChainErrors.algoPlugin(
        'ABITupleType.decode',
        reason: 'input bytes not fully consumed',
      );
    }

    for (var j = 0; j < dynamicSegments.length; j++) {
      final seg = dynamicSegments[j];
      if (seg.left > seg.right) {
        throw OnChainErrors.algoPlugin(
          'ABITupleType.decode',
          reason: 'dynamic segment must satisfy left <= right',
        );
      }
      if (j != dynamicSegments.length - 1 &&
          seg.right != dynamicSegments[j + 1].left) {
        throw OnChainErrors.algoPlugin(
          'ABITupleType.decode',
          reason: 'dynamic segments must be consecutive',
        );
      }
    }

    var segIndex = 0;
    for (var j = 0; j < childTypes.length; j++) {
      if (childTypes[j].isDynamic()) {
        valuePartition[j] = bytes.sublist(
          dynamicSegments[segIndex].left,
          dynamicSegments[segIndex].right,
        );
        segIndex++;
      }
    }

    return [
      for (var j = 0; j < childTypes.length; j++)
        childTypes[j].decode(valuePartition[j]!),
    ];
  }

  /// Parses the content of a tuple type string (without outer parentheses).
  static List<String> parseTupleContent(String str) {
    if (str.isEmpty) return const [];
    if (str.startsWith(',') || str.endsWith(',')) {
      throw OnChainErrors.algoPlugin(
        'ABITupleType.parseTupleContent',
        reason: 'tuple string must not start or end with a comma',
      );
    }
    if (str.contains(',,')) {
      throw OnChainErrors.algoPlugin(
        'ABITupleType.parseTupleContent',
        reason: 'tuple string must not contain consecutive commas',
      );
    }

    final result = <String>[];
    var depth = 0;
    var word = '';

    for (final char in str.split('')) {
      word += char;
      if (char == '(') {
        depth++;
      } else if (char == ')') {
        depth--;
      } else if (char == ',' && depth == 0) {
        result.add(word.substring(0, word.length - 1));
        word = '';
      }
    }
    if (word.isNotEmpty) result.add(word);
    if (depth != 0) {
      throw OnChainErrors.algoPlugin(
        'ABITupleType.parseTupleContent',
        reason: 'tuple string has mismatched parentheses',
      );
    }
    return result;
  }

  @override
  List<dynamic> get variables => [childTypes];
}

class _Segment {
  int left;
  int right;
  _Segment(this.left, this.right);
}

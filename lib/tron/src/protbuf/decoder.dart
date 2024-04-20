import 'package:blockchain_utils/exception/exception.dart';
import 'package:blockchain_utils/string/string.dart';

class ProtocolBufferDecoder {
  static List<ProtocolBufferDecoderResult> decode(List<int> bytes) {
    final List<ProtocolBufferDecoderResult> results = [];
    int index = 0;
    while (index < bytes.length) {
      int tag = bytes[index++];
      int fieldId = tag >> 3;
      int wireType = tag & 0x07;
      switch (wireType) {
        case 2:
          final decodeLength = _decodeVarint(bytes.sublist(index));
          index += decodeLength.consumed;
          results.add(ProtocolBufferDecoderResult(
              tagNumber: fieldId,
              value: bytes.sublist(index, index + decodeLength.value)));
          index += decodeLength.value;
          continue;

        case 0:
          final decodeInt = _decodeInt(bytes.sublist(index));
          index += decodeInt.consumed;
          final result = ProtocolBufferDecoderResult(
              tagNumber: fieldId, value: decodeInt.value);
          results.add(result);
          continue;
        default:
          throw UnimplementedError("protobuf wiretype not supported.");
      }
    }
    return results;
  }

  static _Result<int> _decodeVarint(List<int> data) {
    int value = 0;
    int shift = 0;
    int index = 0;
    while (true) {
      int byte = data[index++];
      value |= (byte & 0x7F) << shift;
      if ((byte & 0x80) == 0) {
        break;
      }
      shift += 7;
    }
    return _Result(value: value, consumed: index);
  }

  static _Result<BigInt> _decodeBigVarint(List<int> data) {
    BigInt value = BigInt.zero;
    int shift = 0;
    int index = 0;
    while (true) {
      int byte = data[index++];
      value |= BigInt.from((byte & 0x7F) << shift);
      if ((byte & 0x80) == 0) {
        break;
      }
      shift += 7;
    }
    return _Result(value: value, consumed: index);
  }

  static _Result _decodeInt(List<int> data) {
    final index = data.indexWhere((element) => (element & 0x80) == 0);
    if (index <= 4) {
      return _decodeVarint(data);
    }
    return _decodeBigVarint(data);
  }
}

class ProtocolBufferDecoderResult<T> {
  const ProtocolBufferDecoderResult(
      {required this.tagNumber, required this.value});
  final int tagNumber;
  final T value;
  @override
  String toString() {
    return "tagNumber: $tagNumber value: $value";
  }
}

class _Result<T> {
  const _Result({required this.value, required this.consumed});
  final T value;
  final int consumed;
  @override
  String toString() {
    return "value: $value consumed: $consumed";
  }
}

extension QuickProtocolBufferResults on List<ProtocolBufferDecoderResult> {
  bool hasTag(int tag) {
    try {
      firstWhere((element) => element.tagNumber == tag);
      return true;
    } on StateError {
      return false;
    }
  }

  T getField<T>(int tag) {
    try {
      final result = firstWhere((element) => element.tagNumber == tag);
      return result.get<T>();
    } on StateError {
      if (null is T) return null as T;
      throw MessageException("field id does not exist.",
          details: {"fieldIds": map((e) => e.tagNumber).join(", "), "id": tag});
    }
  }

  T getResult<T extends ProtocolBufferDecoderResult?>(int id) {
    try {
      final result = firstWhere((element) => element.tagNumber == id);
      return result as T;
    } on StateError {
      if (null is T) return null as T;
      throw MessageException("field id does not exist.",
          details: {"fieldIds": map((e) => e.tagNumber).join(", "), "id": id});
    }
  }

  List<T> getFields<T>(int tag, {bool allowNull = true}) {
    final result = where((element) => element.tagNumber == tag);
    if (result.isEmpty && !allowNull) {
      throw MessageException("field id does not exist.",
          details: {"fieldIds": map((e) => e.tagNumber).join(", "), "id": tag});
    }
    return result.map((e) => e.get<T>()).toList();
  }

  Map<K, V> getMap<K, V>(int tagId, {bool allowNull = true}) {
    final result = where((element) => element.tagNumber == tagId);
    if (result.isEmpty && !allowNull) {
      throw MessageException("field id does not exist.", details: {
        "fieldIds": map((e) => e.tagNumber).join(", "),
        "id": tagId
      });
    }
    final Map<K, V> data = {};
    for (final i in result) {
      final decode = ProtocolBufferDecoder.decode(i.value);
      data.addAll({decode.getField<K>(1): decode.getField<V>(2)});
    }
    return data;
  }
}

extension QuickProtocolBufferResult on ProtocolBufferDecoderResult {
  bool _isTypeString<T>() {
    return "" is T;
  }

  T get<T>() {
    if (value is T) return value;
    if (value is List<int> && _isTypeString<T>()) {
      return StringUtils.decode(value) as T;
    }
    if (value is int) {
      if (BigInt.zero is T) {
        return BigInt.from(value) as T;
      } else if (false is T) {
        if (value != 0 && value != 1) {
          throw MessageException("Invalid boolean value.",
              details: {"value": value});
        }
        return (value == 1 ? true : false) as T;
      }
    }
    throw MessageException("Invalid type.",
        details: {"type": "$T", "Excepted": value.runtimeType.toString()});
  }

  T cast<T>() {
    if (value is T) return value;
    if (value is int) {
      print("come here $T");
      if (BigInt.zero is T) {
        return BigInt.from(value) as T;
      } else if (T == bool) {
        if (value != 0 && value != 1) {
          throw MessageException("Invalid boolean value.",
              details: {"value": value});
        }
        return (value == 1 ? true : false) as T;
      }
    }
    if (value is BigInt && 0 is T) {
      value as BigInt;
      if ((value as BigInt).isValidInt) return value.toInt();
    }
    if (value is List<int> && T == String) {
      return StringUtils.decode(value) as T;
    }
    throw MessageException("cannot cast value.", details: {
      "Type": "$T",
      "Excepted": value.runtimeType.toString(),
      "value": value
    });
  }

  E to<E, T>(E Function(T e) toe) {
    return toe(cast<T>());
  }
}

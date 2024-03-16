part of "package:on_chain/solidity/abi/abi.dart";

/// Utility class providing helper methods for ABI encoding and decoding.
class _ABIUtils {
  /// Retrieves the size of bytes from the given ABI type name.
  /// Returns `null` if the size cannot be determined.
  static int? bytesSize(String name) {
    _ABIValidator.validateBytes(name);
    final size = _ABIValidator.sizeDetectRegex.firstMatch(name)?.group(0);
    if (size == null) return null;
    return int.parse(size);
  }

  /// Retrieves the size of numeric values from the given ABI type name.
  /// Optionally provides the size in bits if [bit] is set to true.
  /// Returns `null` if the size cannot be determined.
  static int? numericSize(String name, {bool bit = false}) {
    final size = _ABIValidator.sizeDetectRegex.firstMatch(name)?.group(0);
    if (size == null) return null;
    final bitSize = int.parse(size);
    if (bit) return bitSize;
    return bitSize ~/ 8;
  }

  /// Decodes a parameter from the given ABI parameter using the appropriate
  /// ABICoder based on the parameter's type.
  static DecoderResult<dynamic> decodeParamFromAbiParameter(
      AbiParameter param, List<int> bytes) {
    final abi = ABICoder.fromType(param.type);
    return abi.decode(param, bytes);
  }

  /// Encodes dynamic parameters by calculating the static and dynamic size,
  /// and arranging them in the appropriate order for ABI encoding.
  static List<int> encodeDynamicParams(List<EncoderResult> encodedParams) {
    int staticSize = 0;
    int dynamicSize = 0;
    List<EncoderResult> staticParams = [];
    List<EncoderResult> dynamicParams = [];

    for (EncoderResult encodedParam in encodedParams) {
      if (encodedParam.isDynamic) {
        staticSize += ABIConst.uintBytesLength;
      } else {
        staticSize += encodedParam.encoded.length;
      }
    }
    for (EncoderResult encodedParam in encodedParams) {
      if (encodedParam.isDynamic) {
        staticParams.add(const NumbersCoder().abiEncode(
            AbiParameter.uint256, BigInt.from(staticSize + dynamicSize)));
        dynamicParams.add(encodedParam);
        dynamicSize += encodedParam.encoded.length;
      } else {
        staticParams.add(encodedParam);
      }
    }

    return [
      ...staticParams.map((p) => p.encoded).expand((element) => element),
      ...dynamicParams.map((p) => p.encoded).expand((element) => element),
    ];
  }

  /// Extracts the array type and size information from the given ABI parameter.
  static Tuple<AbiParameter, int> toArrayType(AbiParameter abi) {
    int arrayParenthesisStart = abi.type.lastIndexOf('[');
    String arrayParamType = abi.type.substring(0, arrayParenthesisStart);
    String sizeString = abi.type.substring(arrayParenthesisStart);
    int size = -1;
    if (sizeString != '[]') {
      size = int.parse(sizeString.substring(1, sizeString.length - 1));
      if (size.isNaN) {
        throw ArgumentError('Invalid fixed array size');
      }
    }
    return Tuple(
        AbiParameter(
            type: arrayParamType,
            name: '',
            components: abi.components,
            tronTypes: abi.tronTypes),
        size);
  }
}

/// Constants used in the Ethereum ABI (Application Binary Interface).
class ABIConst {
  /// The length, in bytes, of a uint type in ABI.
  static const int uintBytesLength = 32;

  /// The length, in bytes, of a function selector.
  static const int selectorLength = 4;
}

/// Regular expressions and exception messages related to array detection,
/// size detection, and invalid arguments in Ethereum ABI.
class _ABIValidator {
  /// Regular expression for detecting arrays in ABI type.
  static final RegExp arrayDetectRegex = RegExp(r'\[(\d*)\]|\[\]');

  /// Regular expression for detecting size in ABI type.
  static final RegExp sizeDetectRegex = RegExp(r'\d+');

  /// Exception message for invalid argument length.
  static const MessageException invalidArgrumentsLength =
      MessageException("Invalid argument length detected.");

  /// Exception message for invalid bytes parameter.
  static const MessageException invalidBytesParam =
      MessageException("Invalid bytes input");

  /// Exception message for invalid bytes length.
  static const MessageException invalidBytesLength =
      MessageException("Invalid bytes length");

  /// Validates bytes based on type, checking for length constraints.
  ///
  /// Throws [invalidBytesParam] if the type is not "bytes" and
  /// [invalidBytesLength] if the length constraints are violated.
  static validateBytes(String typeName,
      {List<int>? bytes, int? maxLength, int? minLength}) {
    if (typeName.contains("bytes")) {
      if (bytes != null) {
        if (maxLength != null) {
          if (bytes.length > maxLength) {
            throw invalidBytesLength;
          }
        }
        if (minLength != null) {
          if (bytes.length < minLength) {
            throw invalidBytesLength;
          }
        }
      }
    } else {
      throw invalidBytesParam;
    }
  }

  /// Determines if a numeric type is signed based on its name.
  ///
  /// Throws [ArgumentException] for an invalid type that is not "int" or "uint".
  static bool isSignNumber(String type) {
    if (type.startsWith("int")) return true;
    if (type.startsWith("uint")) return false;
    throw ArgumentException("invalid type expected int or uint got $type");
  }

  /// Validates a boolean type.
  ///
  /// Throws [ArgumentException] if the type is "bool" and the value is not BigInt.one or BigInt.zero.
  static void validateBoolean(AbiParameter param, BigInt val) {
    if (param.type == "bool" && (val == BigInt.one || val == BigInt.zero)) {
      return;
    }
    throw const ArgumentException("invalid boolean");
  }

  /// Validates the length of bytes to avoid decoding errors.
  ///
  /// Throws [ArgumentError] if there are not enough bytes left to decode.
  static void validateBytesLength(List<int> bytes, int length) {
    if (bytes.length < length) {
      throw ArgumentError("Not enough bytes left to decode");
    }
  }

  /// Validates if a [BigInt] value conforms to the specified numeric type.
  ///
  /// This method ensures that the bit length and sign of the provided [value]
  /// match the expected characteristics based on the given [type].
  ///
  /// Throws [MessageException] if the provided [value] does not match the
  /// expected bit length and sign for the given [type].
  static void isValidNumber(String type, BigInt value) {
    int bitLength;
    bool sign;
    try {
      if (type.startsWith("int")) {
        final spl = type.split("int");
        bitLength = int.parse(spl[1]);
        sign = true;
      } else {
        final spl = type.split("uint");
        bitLength = int.parse(spl[1]);
        sign = true;
      }

      if (sign) {
        if (value.toSigned(bitLength) == value) {
          return;
        }
      } else {
        if (value.toUnsigned(bitLength) == value) {
          return;
        }
      }
      // ignore: empty_catches
    } catch (e) {}
    throw MessageException("invalid number for this type",
        details: {"type": type, "value": value});
  }
}

part of 'package:on_chain/solidity/abi/abi.dart';

/// Internal utility class for common operations related to EIP-712 encoding and decoding.
class _EIP712Utils {
  _EIP712Utils();

  /// Prefix bytes used in EIP-191 signatures.
  static const List<int> eip191PrefixBytes = [25, 1];

  /// Key name for the EIP-712 domain.
  static const String domainKeyName = 'EIP712Domain';

  /// Regular expression for extracting the base type from a type string.
  static final RegExp typeRegex = RegExp(r'^\w+');

  /// Regular expression for detecting array types and extracting the child type and size.
  static final RegExp arrayRegex = RegExp(r'^(.*)\[([0-9]*?)]$');

  /// Type name for bytes32.
  static const String bytes32TypeName = 'bytes32';

  /// Ensures the input value is represented as bytes, handling different types.
  static List<int> ensureBytes(String type, dynamic value) {
    if (!type.startsWith('bytes')) {
      throw const SolidityAbiException(
          'Invalid data provided for bytes codec.');
    }
    if (value is! String && value is! List<int>) {
      throw const SolidityAbiException(
          'Invalid data provided for bytes codec.');
    }
    if (value is List<int>) return BytesUtils.toBytes(value);
    return StringUtils.toBytes(value);
  }

  /// Ensures correct representation of values based on the specified type.
  static dynamic ensureCorrectValues(String type, dynamic value) {
    final match = arrayRegex.firstMatch(type);
    final childType = match?.group(1);
    if (match != null) {
      if (value is! List) {
        throw SolidityAbiException('Invalid data provided for array codec.',
            details: {'type': type, 'value': value});
      }
      return value.map((e) => ensureCorrectValues(childType!, e)).toList();
    }
    if (type.startsWith('uint') || type.startsWith('int')) {
      return BigintUtils.parse(value);
    }
    switch (type) {
      case 'address':
        return ensureIsAddress(value);
      case 'bool':
        return ensureBoolean(value);
      case 'string':
        return ensureString(value);
      default:
        if (type.startsWith('bytes')) {
          return ensureBytes(type, value);
        }
        throw SolidityAbiException('Unsuported type. codec not found.',
            details: {'type': type});
    }
  }

  /// Ensures correct representation of values based on the specified type.
  static dynamic eip712TypedDataV1ValueToJson(String type, dynamic value) {
    final match = arrayRegex.firstMatch(type);
    final childType = match?.group(1);
    if (match != null) {
      if (value is! List) {
        throw SolidityAbiException('Invalid data provided for array codec.',
            details: {'type': type, 'value': value});
      }
      return value
          .map((e) => eip712TypedDataV1ValueToJson(childType!, e))
          .toList();
    }
    if (type.startsWith('uint') || type.startsWith('int')) {
      return value.toString();
    }
    switch (type) {
      case 'address':
        if (value is String) {
          return value;
        }
        if (value is SolidityAddress) {
          return value.toHex();
        }
        break;
      case 'bool':
      case 'string':
        return value;
      default:
        return BytesUtils.toHexString(value, prefix: '0x');
    }
  }

  /// Ensures that the input value is represented as a valid Ethereum or Tron address.
  /// If the value is already an ETHAddress instance, it is returned as-is.
  /// If the value is a list of integers, it is interpreted as bytes and converted to an ETHAddress or TronAddress.
  /// If the value is a string, it is parsed to create an ETHAddress or TronAddress.
  /// Throws a [SolidityAbiException] for invalid input.
  static SolidityAddress ensureIsAddress(dynamic value) {
    try {
      if (value is SolidityAddress) return value;
      if (value is List<int>) {
        return SolidityAddress.fromBytes(value);
      } else if (value is String) {
        if (StringUtils.isHexBytes(value)) {
          return SolidityAddress(value);
        }
        return TronAddress(value);
      }
    } catch (_) {}
    throw SolidityAbiException('Invalid data provided for address codec.',
        details: {'input': value});
  }

  /// Ensures that the input value is a boolean.
  /// Throws a [SolidityAbiException] for invalid input.
  static bool ensureBoolean(dynamic value) {
    if (value is! bool) {
      throw SolidityAbiException('Invalid data provided for boolean codec.',
          details: {'input': value});
    }
    return value;
  }

  /// Ensures that the input value is a string.
  /// Throws a [SolidityAbiException] for invalid input.
  static String ensureString(dynamic value) {
    if (value is! String) {
      throw SolidityAbiException('invalid data provided for string codec.',
          details: {'input': value});
    }
    return value;
  }

  static EIP712Version detectVersion(Map<String, List<Eip712TypeDetails>> types,
      String type, Map<String, dynamic> data) {
    for (final Eip712TypeDetails field in types[type]!) {
      if (data[field.name] == null) return EIP712Version.v3;
    }
    return EIP712Version.v4;
  }

  /// Encodes a struct with the specified type and data, returning the result as a list of integers.
  /// The struct is defined in the Eip712TypedData, and the data parameter contains field values.
  static List<int> encodeStruct(
      Eip712TypedData typedData, String type, Map<String, dynamic> data) {
    final List<String> types = [bytes32TypeName];
    final List<dynamic> inputBytes = [getMethodSigature(typedData, type)];

    for (final Eip712TypeDetails field in typedData.types[type]!) {
      if (data[field.name] == null) {
        if (typedData.version == EIP712Version.v3) continue;
        throw SolidityAbiException(
            'Invalid Eip712TypedData data. data mising for field ${field.name}',
            details: {'data': data, 'field': field});
      }

      final dynamic value = data[field.name];
      final encodedValue = encodeValue(typedData, field.type, value);
      types.add(encodedValue.item1);
      inputBytes.add(encodedValue.item2);
    }

    return abiEncode(types, inputBytes);
  }

  /// Retrieves dependencies for a given type in the EIP-712 typed data structure.
  /// Recursively collects dependencies for the specified type and its subtypes.
  static List<String> getDependencies(Eip712TypedData typedData, String type,
      [List<String> dependencies = const []]) {
    final RegExpMatch? match = typeRegex.firstMatch(type);
    final String actualType = match != null ? match.group(0)! : type;

    if (dependencies.contains(actualType)) {
      return dependencies;
    }

    if (typedData.types[actualType] == null) {
      return dependencies;
    }
    return [
      actualType,
      ...typedData.types[actualType]!.fold<List<String>>(
        <String>[],
        (previous, t) => [
          ...previous,
          ...getDependencies(typedData, t.type, previous)
              .where((dependency) => !previous.contains(dependency)),
        ],
      ),
    ];
  }

  /// Extracts array type information from a given type name using a regular expression.
  /// The type name is expected to follow the pattern `typeName[length]` where `length` is an optional integer.
  /// Returns a Tuple containing the array type and its length, or null if the type name does not match the pattern.
  static Tuple<String, int>? extractArrayType(String typeName) {
    final RegExpMatch? match = arrayRegex.firstMatch(typeName);
    if (match == null) return null;
    final String arrayType = match.group(1)!;
    final int length = int.parse(match.group(2) ?? '0');
    return Tuple(arrayType, length);
  }

  /// Encodes a value according to its type in the context of EIP-712 structured data.
  /// The method handles array types, struct types, strings, and bytes.
  /// Returns a Tuple containing the encoded type and data.
  static Tuple<String, dynamic> encodeValue(
      Eip712TypedData typedData, String type, dynamic data) {
    final isArray = extractArrayType(type);
    if (isArray != null) {
      if (data is! List) {
        throw SolidityAbiException('Invalid data provided for array codec.',
            details: {'input': data});
      }

      if (isArray.item2 > 0 && data.length != isArray.item2) {
        throw SolidityAbiException(
          'Invalid array length: expected ${isArray.item2}, but got ${data.length}',
          details: {'input': data},
        );
      }

      final encodedData = data
          .map((item) => encodeValue(typedData, isArray.item1, item))
          .toList();
      final List<String> types = encodedData.map((item) => item.item1).toList();
      final List<dynamic> values =
          encodedData.map((item) => item.item2).toList();
      return Tuple(bytes32TypeName,
          QuickCrypto.keccack256Hash(_EIP712Utils.abiEncode(types, values)));
    }

    if (typedData.types[type] != null) {
      return Tuple(bytes32TypeName, structHash(typedData, type, data));
    }
    if (type == 'string' || type == 'bytes') {
      final List<int> bytesData =
          type == 'string' ? StringUtils.encode(data) : data;
      return Tuple(bytes32TypeName, QuickCrypto.keccack256Hash(bytesData));
    }
    return Tuple(type, data);
  }

  /// Calculates the Keccak256 hash of the encoded struct data for a given type.
  /// Uses the encodeStruct method to encode the struct data before hashing.
  static List<int> structHash(
      Eip712TypedData typedData, String type, Map<String, dynamic> data) {
    return QuickCrypto.keccack256Hash(encodeStruct(typedData, type, data));
  }

  /// Encodes data using the ABI encoding format based on the provided types and inputs.
  static List<int> abiEncode(List<String> types, List<dynamic> inputs) {
    final inp = [
      for (int i = 0; i < types.length; i++)
        ensureCorrectValues(types[i], inputs[i])
    ];
    final abiParams =
        types.map((e) => AbiParameter(name: '', type: e)).toList();
    final abi = AbiParameter(name: '', type: 'tuple', components: abiParams)
        .abiEncode(inp);
    return abi.encoded;
  }

  /// Encodes data using the legacy EIP-712 encoding format (used in EIP-712 V1)
  /// based on the provided types and inputs.
  static List<int> legacyV1encode(List<String> types, List<dynamic> inputs) {
    final abiParams =
        types.map((e) => AbiParameter(name: '', type: e)).toList();
    final abi = AbiParameter(name: '', type: 'tuple', components: abiParams)
        .legacyEip712Encode(inputs, false);
    return abi.encoded;
  }

  /// Generates the method signature hash for a given EIP-712 typed data and type.
  /// The method signature includes all dependencies and their corresponding types and names.
  static List<int> getMethodSigature(Eip712TypedData typedData, String type) {
    final List<String> dependencies =
        List.from(getDependencies(typedData, type));
    dependencies.sort();
    final encode = dependencies
        .map(
          (dependency) =>
              '$dependency(${typedData.types[dependency]!.map((t) => '${t.type} ${t.name}').join(',')})',
        )
        .join('');
    return QuickCrypto.keccack256Hash(StringUtils.encode(encode));
  }
}

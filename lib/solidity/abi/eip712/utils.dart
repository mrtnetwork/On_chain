part of 'package:on_chain/solidity/abi/abi.dart';

/// Internal utility class for common operations related to EIP-712 encoding and decoding.
class EIP712Utils {
  EIP712Utils();

  /// Prefix bytes used in EIP-191 signatures.
  static const List<int> eip191PrefixBytes = [25, 1];

  /// Key name for the EIP-712 domain.
  static const String domainKeyName = 'EIP712Domain';

  /// Regular expression for detecting array types and extracting the child type and size.
  static RegExp get arrayRegex => RegExp(r'^(.*)\[([0-9]*?)]$');

  /// Type name for bytes32.
  static const String bytes32TypeName = 'bytes32';

  /// Ensures correct representation of values based on the specified type.
  static dynamic _ensureCorrectValues(String type, dynamic value) {
    final match = arrayRegex.firstMatch(type);
    final childType = match?.group(1);
    try {
      if (match != null) {
        if (value is! List) {
          throw SolidityAbiException('Invalid input provided for array codec.',
              details: {'type': type, 'value': value});
        }
        return value.map((e) => _ensureCorrectValues(childType!, e)).toList();
      }
      if (type.startsWith('uint') ||
          type.startsWith('int') ||
          type.startsWith('trcToken')) {
        return JsonParser.valueAsBigInt<BigInt>(value);
      } else if (type.startsWith('bytes')) {
        return JsonParser.valueAsBytes<List<int>>(value);
      }
      switch (type) {
        case 'address':
          return _ensureIsAddress(value);
        case 'bool':
          return JsonParser.valueAsBool<bool>(value);
        case 'string':
          return JsonParser.valueAsString<String>(value);
        default:
          throw SolidityAbiException('Unsuported type. codec not found.',
              details: {'type': type});
      }
    } on SolidityAbiException {
      rethrow;
    } catch (e) {
      throw SolidityAbiException('Invalid input provided for $type.',
          details: {'type': type, 'value': value});
    }
  }

  /// Ensures correct representation of values based on the specified type.
  static dynamic eip712TypedDataV1ValueToJson(String type, dynamic value) {
    final match = arrayRegex.firstMatch(type);
    final childType = match?.group(1);
    if (match != null) {
      if (value is! List) {
        throw SolidityAbiException('Invalid input provided for array codec.',
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
  static SolidityAddress _ensureIsAddress(dynamic value) {
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
    throw SolidityAbiException('Invalid input provided for address codec.',
        details: {'input': value});
  }

  static EIP712Version _detectVersion(
      Map<String, List<Eip712TypeDetails>> types,
      String type,
      Map<String, dynamic> data) {
    if (types[type] == null) {
      throw SolidityAbiException(
          'EIP-712 type definition not found for "$type".');
    }
    for (final Eip712TypeDetails field in types[type]!) {
      if (data[field.name] == null) return EIP712Version.v3;
    }
    return EIP712Version.v4;
  }

  static const Map<String, Eip712TypeDetails> domainFields = {
    "name": Eip712TypeDetails(name: 'name', type: 'string'),
    "version": Eip712TypeDetails(name: 'version', type: 'string'),
    "chainId": Eip712TypeDetails(name: 'chainId', type: 'uint256'),
    "verifyingContract":
        Eip712TypeDetails(name: 'verifyingContract', type: 'address'),
    "salt": Eip712TypeDetails(name: 'salt', type: 'bytes32')
  };

  /// Encodes a struct with the specified type and data, returning the result as a list of integers.
  /// The struct is defined in the Eip712TypedData, and the data parameter contains field values.
  static List<int> encodeStruct(Map<String, List<Eip712TypeDetails>> fields,
      String type, Map<String, dynamic> data, EIP712Version version) {
    final List<String> typesName = [bytes32TypeName];
    final List<dynamic> inputBytes = [getMethodSigature(fields, type)];
    if (fields[type] == null) {
      throw SolidityAbiException(
          'EIP-712 type definition not found for "$type".');
    }
    for (final Eip712TypeDetails field in fields[type]!) {
      if (data[field.name] == null) {
        if (version == EIP712Version.v3) continue;
        throw SolidityAbiException(
            'Invalid Eip712TypedData data. data mising for field ${field.name}',
            details: {'data': data, 'field': field});
      }

      final dynamic value = data[field.name];
      final encodedValue = encodeValue(fields, field.type, value, version);
      typesName.add(encodedValue.$1);
      inputBytes.add(encodedValue.$2);
    }

    return abiEncode(typesName, inputBytes);
  }

  /// Retrieves dependencies for a given type in the EIP-712 typed data structure.
  /// Recursively collects dependencies for the specified type and its subtypes.
  static List<String> _getDependencies(
      Map<String, List<Eip712TypeDetails>> types, String type,
      [List<String> dependencies = const []]) {
    final RegExp typeRegex = RegExp(r'^\w+');
    final RegExpMatch? match = typeRegex.firstMatch(type);
    final String actualType = match != null ? match.group(0)! : type;

    if (dependencies.contains(actualType)) {
      return dependencies;
    }

    if (types[actualType] == null) {
      return dependencies;
    }
    return [
      actualType,
      ...types[actualType]!.fold<List<String>>(
        <String>[],
        (previous, t) => [
          ...previous,
          ..._getDependencies(types, t.type, previous)
              .where((dependency) => !previous.contains(dependency)),
        ],
      ),
    ];
  }

  /// Extracts array type information from a given type name using a regular expression.
  /// The type name is expected to follow the pattern `typeName[length]` where `length` is an optional integer.
  /// Returns a Tuple containing the array type and its length, or null if the type name does not match the pattern.
  static (String, int)? _extractArrayType(String typeName) {
    final RegExpMatch? match = arrayRegex.firstMatch(typeName);
    if (match == null) return null;
    final String arrayType = match.group(1)!;
    String? arrLength = match.group(2);
    if (arrLength == null || arrLength.isEmpty) {
      return (arrayType, 0);
    }
    final int length = int.parse(arrLength);
    return (arrayType, length);
  }

  /// Encodes a value according to its type in the context of EIP-712 structured data.
  /// The method handles array types, struct types, strings, and bytes.
  /// Returns a Tuple containing the encoded type and data.
  static (String, dynamic) encodeValue(
      Map<String, List<Eip712TypeDetails>> types,
      String type,
      dynamic data,
      EIP712Version version) {
    try {
      final isArray = _extractArrayType(type);
      if (isArray != null) {
        if (data is! List) {
          throw SolidityAbiException('Invalid input provided for array codec.',
              details: {'input': data});
        }

        if (isArray.$2 > 0 && data.length != isArray.$2) {
          throw SolidityAbiException(
            'Invalid array length: expected ${isArray.$2}, but got ${data.length}',
            details: {'input': data},
          );
        }

        final encodedData = data
            .map((item) => encodeValue(types, isArray.$1, item, version))
            .toList();
        final List<String> typesName =
            encodedData.map((item) => item.$1).toList();
        final List<dynamic> values =
            encodedData.map((item) => item.$2).toList();
        return (
          bytes32TypeName,
          QuickCrypto.keccack256Hash(EIP712Utils.abiEncode(typesName, values))
        );
      }

      if (types[type] != null) {
        return (bytes32TypeName, structHash(types, type, data, version));
      }
      if (type == 'string' || type == 'bytes') {
        final List<int> bytesData = JsonParser.valueAsBytes(data,
            encoding: type == 'string' ? StringEncoding.utf8 : null,
            allowHex: type == 'bytes');
        return (bytes32TypeName, QuickCrypto.keccack256Hash(bytesData));
      }
      return (type, data);
    } catch (e) {
      throw SolidityAbiException(
        "Failed to encode value.",
        details: {'input': data, 'type': type, 'error': e.toString()},
      );
    }
  }

  static Map<String, List<Eip712TypeDetails>> _getDomainFeilds(
      Map<String, dynamic> domain) {
    final List<Eip712TypeDetails> fields = [];
    for (final i in domain.keys) {
      final field = domainFields[i];
      if (field == null) {
        throw SolidityAbiException(
            "Invalid type-data domain key. type not found.",
            details: {"key": i});
      }
      fields.add(field);
    }
    return {EIP712Utils.domainKeyName: fields};
  }

  /// Calculates the Keccak256 hash of the encoded struct data for a given type.
  /// Uses the encodeStruct method to encode the struct data before hashing.
  static List<int> structHash(Map<String, List<Eip712TypeDetails>> types,
      String type, Map<String, dynamic> data, EIP712Version version) {
    return QuickCrypto.keccack256Hash(encodeStruct(types, type, data, version));
  }

  /// Calculates the Keccak256 hash of the encoded EIP712Domain struct data.
  /// Uses the encodeStruct method to encode the struct data before hashing.
  static List<int> structHashDomain(Map<String, List<Eip712TypeDetails>> types,
      Map<String, dynamic> data, EIP712Version version) {
    if (types[EIP712Utils.domainKeyName] == null) {
      return structHash({...types, ..._getDomainFeilds(data)},
          EIP712Utils.domainKeyName, data, version);
    }
    return structHash(types, EIP712Utils.domainKeyName, data, version);
  }

  /// Encodes data using the ABI encoding format based on the provided types and inputs.
  static List<int> abiEncode(List<String> types, List<dynamic> inputs) {
    final inp = [
      for (int i = 0; i < types.length; i++)
        _ensureCorrectValues(types[i], inputs[i])
    ];
    final abiParams =
        types.map((e) => AbiParameter(name: '', type: e)).toList();
    final abi = AbiParameter(name: '', type: 'tuple', components: abiParams)
        .abiEncode(inp);
    return abi.encoded;
  }

  /// Encodes data using the ABI encoding format based on the provided types and inputs.
  static List<dynamic> abiDecode(List<String> types, List<int> bytes) {
    final abiParams =
        types.map((e) => AbiParameter(name: '', type: e)).toList();
    final abi = AbiParameter(name: '', type: 'tuple', components: abiParams)
        .decode(bytes);
    return abi.result;
  }

  /// Encodes data using the legacy EIP-712 encoding format (used in EIP-712 V1)
  /// based on the provided types and inputs.
  static List<int> legacyV1Encode(List<String> types, List<dynamic> inputs) {
    final abiParams =
        types.map((e) => AbiParameter(name: '', type: e)).toList();
    final abi = AbiParameter(name: '', type: 'tuple', components: abiParams)
        .encodePacked(inputs);
    return abi.encoded;
  }

  /// Generates the method signature hash for a given EIP-712 typed data and type.
  /// The method signature includes all dependencies and their corresponding types and names.
  static List<int> getMethodSigature(
      Map<String, List<Eip712TypeDetails>> types, String type) {
    final List<String> dependencies = List.from(_getDependencies(types, type));
    final encode = dependencies
        .map((dependency) =>
            '$dependency(${types[dependency]!.map((t) => '${t.type} ${t.name}').join(',')})')
        .join('');
    return QuickCrypto.keccack256Hash(StringUtils.encode(encode));
  }
}

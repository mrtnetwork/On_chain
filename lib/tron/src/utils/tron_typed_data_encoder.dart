import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/exception/exception.dart';

class TronTypedDataDomain {
  /// The human-readable name of the signing domain.
  final String? name;

  /// The major version of the signing domain.
  final String? version;

  /// The chain ID of the signing domain.
  final BigInt? chainId;

  /// The address of the contract that will verify the signature.
  final String? verifyingContract;

  /// A salt used for purposes decided by the specific domain.
  final List<int>? salt;

  const TronTypedDataDomain({
    this.name,
    this.version,
    this.chainId,
    this.verifyingContract,
    this.salt,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    if (name != null) result['name'] = name;
    if (version != null) result['version'] = version;
    if (chainId != null) result['chainId'] = chainId;
    if (verifyingContract != null) {
      result['verifyingContract'] = verifyingContract;
    }
    if (salt != null) result['salt'] = salt;
    return result;
  }

  factory TronTypedDataDomain.fromJson(Map<String, dynamic> json) {
    return TronTypedDataDomain(
      name: json['name'],
      version: json['version'],
      chainId: json['chainId'] != null
          ? BigInt.parse(json['chainId'].toString())
          : null,
      verifyingContract: json['verifyingContract'],
      salt: json['salt'] != null ? List<int>.from(json['salt']) : null,
    );
  }
}

/// A specific field of a structured TIP-712 type.
class TronTypedDataField {
  /// The field name.
  final String name;

  /// The type of the field.
  final String type;

  const TronTypedDataField({
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }

  factory TronTypedDataField.fromJson(Map<String, dynamic> json) {
    return TronTypedDataField(
      name: json['name'],
      type: json['type'],
    );
  }
}

/// Helper class for encoding various data types
class _TronTypedDataUtils {
  static final List<int> padding = List<int>.filled(32, 0);

  static final BigInt maxUint256 = BigInt.parse(
      '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
  static final BigInt zero = BigInt.zero;
  static final BigInt one = BigInt.one;

  /// Convert hex string to padded 32-byte representation
  static String hexPadRight(List<int> value) {
    final padOffset = value.length % 32;
    if (padOffset != 0) {
      final paddedValue = [...value, ...padding.sublist(padOffset)];
      return BytesUtils.toHexString(paddedValue);
    }
    return BytesUtils.toHexString(value);
  }

  /// Convert Tron address to Ethereum compatible format
  static String getAddress(String address) {
    if (address.startsWith('0x')) {
      return address.toLowerCase();
    }

    try {
      final tronAddr = TronAddress(address);
      final hexAddr = tronAddr.toAddress(false);
      return '0x${hexAddr.substring(2)}';
    } catch (e) {
      throw TronPluginException('Invalid address format: $address');
    }
  }

  /// Get Tron address in hex format
  static String getTronAddress(String address) {
    try {
      return TronAddress(address).toAddress();
    } catch (e) {
      throw TronPluginException('Invalid Tron address: $address');
    }
  }
}

/// A TypedDataEncoder prepares and encodes TIP-712 payloads for signed typed data.
/// migrate from tronWeb typeData.ts
class TronTypedDataEncoder {
  /// The primary type for the structured types.
  late final String primaryType;

  final Map<String, List<TronTypedDataField>> _types;
  final Map<String, String> _fullTypes = {};
  final Map<String, String Function(dynamic)> _encoderCache = {};

  /// The types.
  Map<String, List<TronTypedDataField>> get types => Map.from(_types);

  /// Domain field types mapping
  static const Map<String, String> domainFieldTypes = {
    'name': 'string',
    'version': 'string',
    'chainId': 'uint256',
    'verifyingContract': 'address',
    'salt': 'bytes32',
  };

  /// Domain field names in order
  static const List<String> domainFieldNames = [
    'name',
    'version',
    'chainId',
    'verifyingContract',
    'salt'
  ];

  /// Create a new TypedDataEncoder for types.
  TronTypedDataEncoder(Map<String, List<TronTypedDataField>> types)
      : _types = Map.from(types) {
    // Link struct types to their direct child structs
    final Map<String, Set<String>> links = {};
    final Map<String, List<String>> parents = {};
    final Map<String, Set<String>> subtypes = {};

    // Initialize maps
    for (final type in types.keys) {
      links[type] = <String>{};
      parents[type] = <String>[];
      subtypes[type] = <String>{};
    }

    // Build dependency graph
    for (final MapEntry(:key, :value) in types.entries) {
      final Set<String> uniqueNames = {};

      for (final field in value) {
        if (uniqueNames.contains(field.name)) {
          throw TronPluginException(
              'Duplicate variable name "${field.name}" in "$key"');
        }
        uniqueNames.add(field.name);

        // Get the base type (drop any array specifiers)
        final match = RegExp(r'^([^\[]*)([\[]|$)').firstMatch(field.type);
        final baseType = match?.group(1);

        if (baseType == null) {
          throw TronPluginException('Invalid type: ${field.type}');
        }

        if (baseType == key) {
          throw TronPluginException('Circular type reference to "$baseType"');
        }

        // Is this a base encoding type?
        if (_getBaseEncoder(baseType) != null) {
          continue;
        }

        if (!parents.containsKey(baseType)) {
          throw TronPluginException('Unknown type "$baseType"');
        }

        // Add linkage
        parents[baseType]!.add(key);
        links[key]!.add(baseType);
      }
    }

    // Deduce the primary type
    final primaryTypes =
        parents.keys.where((n) => parents[n]!.isEmpty).toList();

    if (primaryTypes.isEmpty) {
      throw TronPluginException('Missing primary type');
    }
    if (primaryTypes.length > 1) {
      throw TronPluginException(
          'Ambiguous primary types or unused types: ${primaryTypes.join(', ')}');
    }

    primaryType = primaryTypes[0];

    // Check for circular type references
    void checkCircular(String type, Set<String> found) {
      if (found.contains(type)) {
        throw TronPluginException('Circular type reference to "$type"');
      }

      found.add(type);

      for (final child in links[type]!) {
        if (!parents.containsKey(child)) {
          continue;
        }

        // Recursively check children
        checkCircular(child, found);

        // Mark all ancestors as having this descendant
        for (final subtype in found) {
          subtypes[subtype]!.add(child);
        }
      }

      found.remove(type);
    }

    checkCircular(primaryType, <String>{});

    // Compute each fully described type
    for (final MapEntry(:key, :value) in subtypes.entries) {
      final st = value.toList()..sort();
      _fullTypes[key] = _encodeType(key, types[key]!) +
          st.map((t) => _encodeType(t, types[t]!)).join('');
    }
  }

  /// Get base encoder for primitive types
  String Function(dynamic)? _getBaseEncoder(String type) {
    // intXX and uintXX
    final intMatch = RegExp(r'^(u?)int(\d*)$').firstMatch(type);
    if (intMatch != null) {
      final signed = intMatch.group(1) != 'u';
      final width = int.parse(intMatch.group(2) ?? '256');

      if (width % 8 != 0 || width == 0 || width > 256) {
        throw TronPluginException('Invalid numeric width: $type');
      }

      final boundsUpper =
          _TronTypedDataUtils.maxUint256 >> (256 - (signed ? width - 1 : width));
      final boundsLower =
          signed ? -(boundsUpper + _TronTypedDataUtils.one) : _TronTypedDataUtils.zero;

      return (value) {
        final bigValue = BigInt.parse(value.toString());
        if (bigValue < boundsLower || bigValue > boundsUpper) {
          throw TronPluginException('Value out-of-bounds for $type: $value');
        }

        final paddedValue = signed ? _toTwos(bigValue, 256) : bigValue;
        return _toBeHex(paddedValue, 32);
      };
    }

    // bytesXX
    final bytesMatch = RegExp(r'^bytes(\d+)$').firstMatch(type);
    if (bytesMatch != null) {
      final width = int.parse(bytesMatch.group(1)!);
      if (width == 0 || width > 32) {
        throw TronPluginException('Invalid bytes width: $type');
      }

      return (value) {
        List<int> bytes;
        if (value is String) {
          bytes = BytesUtils.fromHexString(value);
        } else if (value is List<int>) {
          bytes = value;
        } else {
          throw TronPluginException('Invalid bytes value: $value');
        }

        if (bytes.length != width) {
          throw TronPluginException(
              'Invalid length for $type: ${bytes.length}');
        }
        return _TronTypedDataUtils.hexPadRight(bytes);
      };
    }

    // Special types
    switch (type) {
      case 'trcToken':
        return _getBaseEncoder('uint256');
      case 'address':
        return (value) {
          final addr = _TronTypedDataUtils.getAddress(value.toString());
          return _zeroPadValue(addr, 32);
        };
      case 'bool':
        return (value) {
          final boolValue = value is bool
              ? value
              : (value.toString().toLowerCase() == 'true');
          return boolValue
              ? _toBeHex(_TronTypedDataUtils.one, 32)
              : _toBeHex(_TronTypedDataUtils.zero, 32);
        };
      case 'bytes':
        return (value) {
          List<int> bytes;
          if (value is String) {
            bytes = BytesUtils.fromHexString(value);
          } else if (value is List<int>) {
            bytes = value;
          } else {
            throw TronPluginException('Invalid bytes value: $value');
          }
          return BytesUtils.toHexString(QuickCrypto.keccack256Hash(bytes));
        };
      case 'string':
        return (value) {
          final stringBytes = StringUtils.encode(value.toString());
          return BytesUtils.toHexString(
              QuickCrypto.keccack256Hash(stringBytes));
        };
    }

    return null;
  }

  /// Encode type string
  String _encodeType(String name, List<TronTypedDataField> fields) {
    final fieldStrings = fields.map((f) => '${f.type} ${f.name}').join(',');
    return '$name($fieldStrings)';
  }

  /// Convert BigInt to two's complement representation
  BigInt _toTwos(BigInt value, int width) {
    if (value >= BigInt.zero) {
      return value;
    }
    return (BigInt.one << width) + value;
  }

  /// Convert BigInt to hex with specified byte length
  String _toBeHex(BigInt value, int length) {
    final hex = value.toRadixString(16);
    final padded = hex.padLeft(length * 2, '0');
    return padded;
  }

  /// Zero pad value to specified length
  String _zeroPadValue(String value, int length) {
    if (value.startsWith('0x')) {
      value = value.substring(2);
    }
    return value.padLeft(length * 2, '0');
  }

  /// Return the encoder for the specific type.
  String Function(dynamic) getEncoder(String type) {
    String Function(dynamic)? encoder = _encoderCache[type];
    if (encoder == null) {
      encoder = _getEncoder(type);
      _encoderCache[type] = encoder;
    }
    return encoder;
  }

  String Function(dynamic) _getEncoder(String type) {
    // Basic encoder type
    final encoder = _getBaseEncoder(type);
    if (encoder != null) {
      return encoder;
    }

    // Array
    final arrayMatch = RegExp(r'^(.*)(\[(\d*)\])$').firstMatch(type);
    if (arrayMatch != null) {
      final subtype = arrayMatch.group(1)!;
      final subEncoder = getEncoder(subtype);

      return (value) {
        if (value is! List) {
          throw TronPluginException('Expected array for type $type');
        }

        final expectedLength = arrayMatch.group(3);
        if (expectedLength != null && expectedLength.isNotEmpty) {
          final length = int.parse(expectedLength);
          if (value.length != length) {
            throw TronPluginException(
                'Array length mismatch; expected length $length');
          }
        }

        final results = value.map(subEncoder).toList();

        if (_fullTypes.containsKey(subtype)) {
          final hashedResults = results
              .map((r) => BytesUtils.toHexString(
                  QuickCrypto.keccack256Hash(BytesUtils.fromHexString(r))))
              .toList();
          final concatenated = hashedResults.join('');
          return BytesUtils.toHexString(QuickCrypto.keccack256Hash(
              BytesUtils.fromHexString(concatenated)));
        }

        final concatenated = results.join('');
        return BytesUtils.toHexString(
            QuickCrypto.keccack256Hash(BytesUtils.fromHexString(concatenated)));
      };
    }

    // Struct
    final fields = _types[type];
    if (fields != null) {
      final encodedType = BytesUtils.toHexString(
          QuickCrypto.keccack256Hash(StringUtils.encode(_fullTypes[type]!)));

      return (value) {
        if (value is! Map<String, dynamic>) {
          throw TronPluginException('Expected object for type $type');
        }

        final values = <String>[encodedType];

        for (final field in fields) {
          final result = getEncoder(field.type)(value[field.name]);
          if (_fullTypes.containsKey(field.type)) {
            values.add(BytesUtils.toHexString(
                QuickCrypto.keccack256Hash(BytesUtils.fromHexString(result))));
          } else {
            values.add(result);
          }
        }

        final concatenated = values.join('');
        return concatenated;
      };
    }

    throw TronPluginException('Unknown type: $type');
  }

  /// Return the full type for name.
  String encodeType(String name) {
    final result = _fullTypes[name];
    if (result == null) {
      throw TronPluginException('Unknown type: $name');
    }
    return result;
  }

  /// Return the encoded value for the type.
  String encodeData(String type, dynamic value) {
    return getEncoder(type)(value);
  }

  /// Returns the hash of value for the type of name.
  String hashStruct(String name, Map<String, dynamic> value) {
    final encoded = encodeData(name, value);
    return BytesUtils.toHexString(
        QuickCrypto.keccack256Hash(BytesUtils.fromHexString(encoded)));
  }

  /// Return the fully encoded value for the types.
  String encode(Map<String, dynamic> value) {
    return encodeData(primaryType, value);
  }

  /// Return the hash of the fully encoded value for the types.
  String hash(Map<String, dynamic> value) {
    return hashStruct(primaryType, value);
  }

  /// Create a new TypedDataEncoder for types.
  static TronTypedDataEncoder from(Map<String, List<TronTypedDataField>> types) {
    return TronTypedDataEncoder(types);
  }

  /// Return the primary type for types.
  static String getPrimaryType(Map<String, List<TronTypedDataField>> types) {
    return TronTypedDataEncoder.from(types).primaryType;
  }

  /// Return the hashed struct for value using types and name.
  static String hashStructStatic(String name,
      Map<String, List<TronTypedDataField>> types, Map<String, dynamic> value) {
    return TronTypedDataEncoder.from(types).hashStruct(name, value);
  }

  /// Return the domain hash for domain.
  static String hashDomain(TronTypedDataDomain domain) {
    final domainFields = <TronTypedDataField>[];
    final domainMap = domain.toJson();

    for (final name in domainFieldNames) {
      if (domainMap[name] != null) {
        final type = domainFieldTypes[name]!;
        domainFields.add(TronTypedDataField(name: name, type: type));
      }
    }

    return TronTypedDataEncoder.hashStructStatic(
        'EIP712Domain', {'EIP712Domain': domainFields}, domainMap);
  }

  /// Return the fully encoded TIP-712 value for types with domain.
  static String encodeStatic(TronTypedDataDomain domain,
      Map<String, List<TronTypedDataField>> types, Map<String, dynamic> value) {
    final prefix = '1901';
    final domainHash = hashDomain(domain);
    final structHash = TronTypedDataEncoder.from(types).hash(value);

    return prefix + domainHash + structHash;
  }

  /// Return the hash of the fully encoded TIP-712 value for types with domain.
  static String hashTypedData(TronTypedDataDomain domain,
      Map<String, List<TronTypedDataField>> types, Map<String, dynamic> value) {
    final encoded = encodeStatic(domain, types, value);
    return BytesUtils.toHexString(
        QuickCrypto.keccack256Hash(BytesUtils.fromHexString(encoded)));
  }

  /// Returns the JSON-encoded payload expected by nodes which implement the JSON-RPC TIP-712 method.
  static Map<String, dynamic> getPayload(TronTypedDataDomain domain,
      Map<String, List<TronTypedDataField>> types, Map<String, dynamic> value) {
    // Validate the domain fields
    hashDomain(domain);

    // Derive the EIP712Domain Struct reference type
    final domainValues = <String, dynamic>{};
    final domainTypes = <TronTypedDataField>[];
    final domainMap = domain.toJson();

    for (final name in domainFieldNames) {
      final domainValue = domainMap[name];
      if (domainValue == null) {
        continue;
      }
      domainValues[name] = _processDomainValue(name, domainValue);
      domainTypes
          .add(TronTypedDataField(name: name, type: domainFieldTypes[name]!));
    }

    final encoder = TronTypedDataEncoder.from(types);
    final typesWithDomain = Map<String, List<TronTypedDataField>>.from(types);

    if (typesWithDomain.containsKey('EIP712Domain')) {
      throw TronPluginException('types must not contain EIP712Domain type');
    }

    typesWithDomain['EIP712Domain'] = domainTypes;

    // Validate the data structures and types
    encoder.encode(value);

    return {
      'types': typesWithDomain.map(
          (key, value) => MapEntry(key, value.map((f) => f.toJson()).toList())),
      'domain': domainValues,
      'primaryType': encoder.primaryType,
      'message': _processMessage(encoder, value),
    };
  }

  static dynamic _processDomainValue(String name, dynamic value) {
    switch (name) {
      case 'name':
      case 'version':
        if (value is! String) {
          throw TronPluginException('Invalid domain value for "$name"');
        }
        return value;
      case 'chainId':
        final bigValue = BigInt.parse(value.toString());
        if (bigValue < BigInt.zero) {
          throw TronPluginException('Invalid chain ID');
        }
        return bigValue.toString();
      case 'verifyingContract':
        try {
          return _TronTypedDataUtils.getTronAddress(value.toString()).toLowerCase();
        } catch (e) {
          throw TronPluginException('Invalid domain value "verifyingContract"');
        }
      case 'salt':
        List<int> bytes;
        if (value is String) {
          bytes = BytesUtils.fromHexString(value);
        } else if (value is List<int>) {
          bytes = value;
        } else {
          throw TronPluginException('Invalid salt value');
        }
        if (bytes.length != 32) {
          throw TronPluginException('Invalid domain value "salt"');
        }
        return BytesUtils.toHexString(bytes);
      default:
        return value;
    }
  }

  static Map<String, dynamic> _processMessage(
      TronTypedDataEncoder encoder, Map<String, dynamic> value) {
    return encoder._visit(encoder.primaryType, value, (type, data) {
      // bytes
      if (RegExp(r'^bytes(\d*)').hasMatch(type)) {
        if (data is String) {
          return data.startsWith('0x') ? data : '0x$data';
        } else if (data is List<int>) {
          return BytesUtils.toHexString(data);
        }
      }

      // uint or int
      if (RegExp(r'^u?int').hasMatch(type)) {
        return BigInt.parse(data.toString()).toString();
      }

      switch (type) {
        case 'trcToken':
          return BigInt.parse(data.toString()).toString();
        case 'address':
          return data.toString().toLowerCase();
        case 'bool':
          return data is bool
              ? data
              : (data.toString().toLowerCase() == 'true');
        case 'string':
          if (data is! String) {
            throw TronPluginException('Invalid string value');
          }
          return data;
      }

      throw TronPluginException('Unsupported type: $type');
    });
  }

  dynamic _visit(
      String type, dynamic value, dynamic Function(String, dynamic) callback) {
    // Basic encoder type
    if (_getBaseEncoder(type) != null) {
      return callback(type, value);
    }

    // Array
    final arrayMatch = RegExp(r'^(.*)(\[(\d*)\])$').firstMatch(type);
    if (arrayMatch != null) {
      final expectedLength = arrayMatch.group(3);
      if (expectedLength != null && expectedLength.isNotEmpty) {
        final length = int.parse(expectedLength);
        if ((value as List).length != length) {
          throw TronPluginException(
              'Array length mismatch; expected length $length');
        }
      }
      return (value as List)
          .map((v) => _visit(arrayMatch.group(1)!, v, callback))
          .toList();
    }

    // Struct
    final fields = _types[type];
    if (fields != null) {
      final result = <String, dynamic>{};
      for (final field in fields) {
        result[field.name] = _visit(
            field.type, (value as Map<String, dynamic>)[field.name], callback);
      }
      return result;
    }

    throw TronPluginException('Unknown type: $type');
  }

  /// Call callback for each value in value, passing the type and component within value.
  dynamic visit(
      Map<String, dynamic> value, dynamic Function(String, dynamic) callback) {
    return _visit(primaryType, value, callback);
  }
}
part of 'package:on_chain/solidity/abi/abi.dart';

/// Solidity contract for encoding and decoding data according to Ethereum ABI specifications.
abstract class ABICoder<INPUT extends Object, OUTPUT extends Object> {
  /// ABI encode method.
  EncoderResult abiEncode(AbiParameter params, INPUT input);

  /// EIP-712 Legacy Encode method with an option to keep a specific size.
  EncoderResult encodePacked(AbiParameter params, INPUT input);

  /// Decode method.
  DecoderResult<Object> decode(AbiParameter params, List<int> bytes);

  /// Static map associating type names with corresponding concrete ABICoder implementations.
  static const Map<String, ABICoder> _types = {
    'string': StringCoder(),
    'bool': BooleanCoder(),
    'address': AddressCoder(),
    'tuple': TupleCoder(),
    'array': ArrayCoder(),
    'bytes': BytesCoder(),
    'function': FunctionCoder(),
    'number': NumbersCoder(),
    'trcToken': NumbersCoder(),
  };

  /// Factory method to create an ABICoder instance based on the provided type string.
  factory ABICoder.fromType(String type) {
    String? correctType;
    // Check for array, bytes, and numeric types
    if (type.endsWith(']')) {
      correctType = 'array';
    } else if (type.startsWith('bytes')) {
      correctType = 'bytes';
    } else if (type.startsWith('uint') ||
        type.startsWith('int') ||
        type.startsWith("trcToken")) {
      correctType = 'number';
    }
    // Use the corrected type or the original type if not modified
    correctType ??= type;
    final t = _types[correctType];
    if (t == null) {
      throw SolidityAbiException('Unsuported ABI type. codec not found',
          details: {'type': type});
    }
    // Return the corresponding ABICoder instance
    return t as ABICoder<INPUT, OUTPUT>;
  }
}

class AbiParameter with InternalCborSerialization {
  /// Static constant representing an ABI parameter for generic bytes data.
  static const AbiParameter bytes = AbiParameter(name: '', type: 'bytes');

  /// Static constant representing an ABI parameter for a function signature (bytes24).
  static const AbiParameter function = AbiParameter(name: '', type: 'bytes24');

  /// Static constant representing an ABI parameter for a 256-bit unsigned integer.
  static const AbiParameter uint256 = AbiParameter(name: '', type: 'uint256');

  /// Static constant representing an ABI parameter for a 32-bit unsigned integer.
  static const AbiParameter uint32 = AbiParameter(name: '', type: 'uint32');

  /// The name of the parameter.
  final String? name;

  /// The type of the parameter.
  final String type;

  /// Flag indicating whether the parameter is indexed.
  final bool indexed;

  /// List of components if the parameter is a composite type.
  final List<AbiParameter> components;

  /// The internal type, if applicable.
  final String? internalType;

  /// Constructor for AbiParameter.
  const AbiParameter({
    /// The name of the parameter.
    required this.name,
    required this.type,
    this.indexed = false,
    this.components = const [],
    this.internalType,
  });

  /// Creates a new AbiParameter instance with updated values.
  /// If a parameter is not specified in the copy, the current value is retained.
  AbiParameter copyWith({
    String? name,
    String? type,
    bool? indexed,
    List<AbiParameter>? components,
    String? internalType,
  }) {
    return AbiParameter(
      name: name ?? this.name,
      type: type ?? this.type,
      indexed: indexed ?? this.indexed,
      components: components ??
          List<AbiParameter>.unmodifiable(components ?? this.components),
      internalType: internalType ?? this.internalType,
    );
  }

  /// Factory method to create an AbiParameter instance from a JSON representation.
  factory AbiParameter.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json.valueAsList<List?>("components") ?? [];
    final String name = json.valueAs<String?>("name") ?? '';
    return AbiParameter(
      name: name,
      type: json.valueAs("type"),
      internalType: json.valueAs("internalType"),
      indexed: json.valueAs<bool?>("indexed") ?? false,
      components: List<AbiParameter>.unmodifiable(
          inputs.map((e) => AbiParameter.fromJson(e)).toList()),
    );
  }

  factory AbiParameter.deserialize({List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes,
        object: cbor,
        tags: InternalCborSerializationConst.defaultTag);
    return AbiParameter(
      name: values.elementAtString<String?>(0),
      type: values.elementAtString<String>(1),
      indexed: values.elementAt<CborBoleanValue>(2).value,
      internalType: values.elementAtString<String?>(3),
      components: values
          .elementAsListOf<CborTagValue>(4)
          .map((e) => AbiParameter.deserialize(cbor: e))
          .toList(),
    );
  }

  /// Checks if the parameter represents a tuple.
  bool get isTupple => type.startsWith('tuple');

  /// Retrieves the argument name, considering tuple types.
  String get argName {
    if (isTupple) {
      /// Regular expression for detecting arrays in ABI type.
      final RegExp arrayDetectRegex = RegExp(r'\[(\d*)\]|\[\]');
      final String match = arrayDetectRegex.firstMatch(type)?.group(0) ?? '';
      return "(${components.map((e) => e.argName).join(",")})$match";
    }
    return type;
  }

  /// Encodes the given value using the specified ABI encoding.
  EncoderResult encodePacked(dynamic value) {
    final abi = ABICoder.fromType(type);
    return abi.encodePacked(this, value);
  }

  /// Encodes the given value using the ABI encoding.
  EncoderResult abiEncode(dynamic value) {
    final abi = ABICoder.fromType(type);
    return abi.abiEncode(this, value);
  }

  /// Decodes the byte array using the specified ABI decoding.
  DecoderResult decode(List<int> bytes) {
    final abi = ABICoder.fromType(type);
    final decode = abi.decode(this, bytes);

    return decode;
  }

  /// Checks whether the ABI parameter is dynamic.
  /// Dynamic parameters include strings, bytes, dynamic arrays, and tuples containing dynamic components.
  bool get isDynamic {
    if (type == 'string' || type == 'bytes' || type.endsWith('[]')) {
      return true;
    }

    if (type == 'tuple') {
      return components.any((component) => component.isDynamic);
    }

    if (type.endsWith(']')) {
      return ABIUtils._toArrayType(this).$1.isDynamic;
    }

    return false;
  }

  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          switch (name) {
            final String name => CborStringValue(name),
            _ => CborNullValue()
          },
          CborStringValue(type),
          CborBoleanValue(indexed),
          switch (internalType) {
            final String internalType => CborStringValue(internalType),
            _ => CborNullValue()
          },
          CborListValue.definite(components.map((e) => e.toCbor()).toList())
        ].cast()),
        InternalCborSerializationConst.defaultTag);
  }

  @override
  Map<String, dynamic> toJson({bool isEvent = false}) {
    return {
      "components": components.map((e) => e.toJson()).toList().emptyAsNull,
      "name": name,
      "type": type,
      "internalType": internalType,
      if (isEvent) "indexed": indexed
    }.notNullValue;
  }
}

/// Represents the result of encoding data using ABI encoding.
class EncoderResult {
  /// Indicates whether the encoded data is dynamic.
  final bool isDynamic;

  /// The encoded data as a bytes.
  final List<int> encoded;

  final String? name;

  /// Constructor for EncoderResult.
  const EncoderResult(
      {required this.isDynamic, required this.encoded, required this.name});
}

/// Represents the result of decoding data using ABI decoding.
class DecoderResult<T> {
  /// The decoded result of type T.
  final T result;

  /// The number of bytes consumed during decoding.
  final int consumed;

  final String? name;

  /// Constructor for DecoderResult.
  const DecoderResult(
      {required this.result, required this.consumed, required this.name});

  /// Overrides the default toString method to provide a readable representation of DecoderResult.
  @override
  String toString() {
    return 'consumed $consumed result $result';
  }
}

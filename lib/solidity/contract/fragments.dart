import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor/cbor_serialization.dart';
import 'package:on_chain/serialization/cbor/extension.dart';
import 'package:on_chain/solidity/abi/abi.dart';

/// Abstract class representing a base fragment in ABI, providing common properties and methods.
abstract class AbiBaseFragment with InternalCborSerialization {
  /// The list of input parameters for the fragment.
  final List<AbiParameter> inputs;

  /// The type of the fragment.
  final FragmentTypes type;

  AbiBaseFragment({required List<AbiParameter> inputs, required this.type})
      : inputs = inputs.immutable;

  /// Creates an instance of [AbiBaseFragment] from JSON representation.
  factory AbiBaseFragment.fromJson(Map<String, dynamic> json) {
    final type = FragmentTypes.fromName(json['type']);

    switch (type) {
      case FragmentTypes.event:
        return AbiEventFragment.fromJson(json);
      case FragmentTypes.function:
        return AbiFunctionFragment.fromJson(json);
      case FragmentTypes.receive:
        return AbiReceiveFragment.fromJson(json);
      case FragmentTypes.constructor:
        return AbiConstructorFragment.fromJson(json);
      case FragmentTypes.fallback:
        return AbiFallbackFragment.fromJson(json);
      case FragmentTypes.error:
        return AbiErrorFragment.fromJson(json);
    }
  }
  factory AbiBaseFragment.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final CborTagValue tag =
        QuickCborObject.decode(cborBytes: cborBytes, object: cbor);
    final type = FragmentTypes.fromValue(tag.tags);
    switch (type) {
      case FragmentTypes.event:
        return AbiEventFragment.deserialize(cbor: tag);
      case FragmentTypes.function:
        return AbiFunctionFragment.deserialize(cbor: tag);
      case FragmentTypes.receive:
        return AbiReceiveFragment.deserialize(cbor: tag);
      case FragmentTypes.constructor:
        return AbiConstructorFragment.deserialize(cbor: tag);
      case FragmentTypes.fallback:
        return AbiFallbackFragment.deserialize(cbor: tag);
      case FragmentTypes.error:
        return AbiErrorFragment.deserialize(cbor: tag);
    }
  }

  /// Gets the encoded function name for the given [name] and [fragment].
  static String funcName(String name, AbiBaseFragment fragment) {
    return "$name(${fragment.inputs.map((e) {
      if (e.argName == "function") {
        return "bytes24";
      }
      return e.argName;
    }).join(",")})";
  }

  @override
  Map<String, dynamic> toJson();
}

/// Class representing an ABI constructor fragment.
class AbiConstructorFragment extends AbiBaseFragment {
  factory AbiConstructorFragment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json.valueAsList<List?>("inputs") ?? [];
    return AbiConstructorFragment(
        stateMutability:
            StateMutability.fromName(json.valueAs("stateMutability")),
        inputs: inputs.map((e) => AbiParameter.fromJson(e)).toList(),
        payable: json.valueAs("payable"));
  }
  factory AbiConstructorFragment.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes,
        object: cbor,
        tags: FragmentTypes.constructor.tags);
    return AbiConstructorFragment(
        stateMutability: StateMutability.fromValue(values.elementAtBytes(0)),
        inputs: values
            .elementAsListOf<CborTagValue>(1)
            .map((e) => AbiParameter.deserialize(cbor: e))
            .toList(),
        payable: values.elementAt<CborBoleanValue?>(2)?.value);
  }

  final bool? payable;

  /// The state mutability of the constructor.
  final StateMutability stateMutability;

  /// Creates an [AbiConstructorFragment] instance.
  AbiConstructorFragment(
      {required this.stateMutability, super.inputs = const [], this.payable})
      : super(type: FragmentTypes.constructor);

  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          CborBytesValue(stateMutability.tags),
          CborListValue.definite(inputs.map((e) => e.toCbor()).toList()),
          switch (payable) {
            final bool payable => CborBoleanValue(payable),
            _ => CborNullValue(),
          },
        ].cast()),
        type.tags);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "stateMutability": stateMutability.name,
      "type": type.name,
      "inputs": inputs.map((e) => e.toJson()).toList(),
      "payable": payable
    }.notNullValue;
  }
}

/// Represents a function fragment in ABI, providing methods for working with function calls.
class AbiFunctionFragment extends AbiBaseFragment {
  /// Creates an instance of [AbiFunctionFragment] from JSON representation.
  factory AbiFunctionFragment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json.valueAsList<List?>("inputs") ?? [];
    final List<dynamic> outputs = json.valueAsList<List?>("outputs") ?? [];
    return AbiFunctionFragment(
        name: json.valueAs("name"),
        inputs: inputs.map((e) => AbiParameter.fromJson(e)).toList(),
        outputs: outputs.map((e) => AbiParameter.fromJson(e)).toList(),
        stateMutability: json.valueTo<StateMutability?, String>(
            key: "stateMutability", parse: (e) => StateMutability.fromName(e)),
        constant: json.valueAs("constant"),
        payable: json.valueAs("payable"));
  }
  factory AbiFunctionFragment.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes, object: cbor, tags: FragmentTypes.function.tags);
    return AbiFunctionFragment(
        name: values.elementAtString<String>(0),
        stateMutability: values.elementMaybeAt<StateMutability, CborBytesValue>(
            1, (e) => StateMutability.fromValue(e.value)),
        inputs: values
            .elementAsListOf<CborTagValue>(2)
            .map((e) => AbiParameter.deserialize(cbor: e))
            .toList(),
        outputs: values
            .elementAsListOf<CborTagValue>(3)
            .map((e) => AbiParameter.deserialize(cbor: e))
            .toList(),
        constant: values.elementAt<CborBoleanValue?>(4)?.value,
        payable: values.elementAt<CborBoleanValue?>(5)?.value);
  }

  /// Creates an [AbiFunctionFragment] instance.
  AbiFunctionFragment({
    required this.name,
    this.stateMutability,
    super.inputs = const [],
    this.outputs = const [],
    this.constant,
    this.payable,
  }) : super(type: FragmentTypes.function);

  /// The name of the function
  final String name;

  /// The state mutability of the function.
  final StateMutability? stateMutability;

  /// The list of output parameters for the function.
  final List<AbiParameter> outputs;

  /// Indicates whether the function is constant.
  final bool? constant;

  /// Indicates whether the function is payable.
  final bool? payable;

  /// Gets the encoded function name.
  String get functionName {
    return AbiBaseFragment.funcName(name, this);
  }

  /// The signature hash of the function.
  late final List<int> signature =
      QuickCrypto.keccack256Hash(StringUtils.encode(functionName));

  /// The function selector.
  List<int> get selector => signature.sublist(0, ABIConst.selectorLength);

  @override
  String toString() {
    return functionName;
  }

  /// Encodes the function with the provided parameters.
  List<int> encode(List params, [bool withSelector = true]) {
    final abi =
        AbiParameter(name: '', type: 'tuple', components: List.from(inputs))
            .abiEncode(params);
    if (!withSelector) {
      return abi.encoded;
    }
    return [...selector, ...abi.encoded];
  }

  /// Encodes the function as a hexadecimal string with the provided parameters.
  String encodeHex(List<dynamic> params, [bool withSelector = true]) {
    return BytesUtils.toHexString(encode(params, withSelector));
  }

  /// Decodes the output of the function from the encoded output bytes.
  List<dynamic> decodeOutput(List<int> encodedOutput) {
    final abi =
        AbiParameter(name: '', type: 'tuple', components: List.from(outputs))
            .decode(encodedOutput);
    return abi.result;
  }

  /// Decodes the output of the function from the encoded hexadecimal string output.
  List<dynamic> decodeOutputHex(String encodedOutput) {
    return decodeOutput(BytesUtils.fromHexString(encodedOutput));
  }

  /// Decodes the input parameters of the function from the encoded input bytes.
  List<dynamic> decodeInput(List<int> encodedParams) {
    List<int> encodeBytes = List.from(encodedParams);
    if (encodeBytes.length > ABIConst.selectorLength) {
      final encodeSelector = encodeBytes.sublist(0, ABIConst.selectorLength);
      if (BytesUtils.bytesEqual(encodeSelector, selector)) {
        encodeBytes = encodeBytes.sublist(ABIConst.selectorLength);
      }
    }
    final abi =
        AbiParameter(name: '', type: 'tuple', components: List.from(inputs))
            .decode(encodeBytes);
    return abi.result;
  }

  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          CborStringValue(name),
          switch (stateMutability) {
            final StateMutability stateMutability =>
              CborBytesValue(stateMutability.tags),
            _ => CborNullValue(),
          },
          CborListValue.definite(inputs.map((e) => e.toCbor()).toList()),
          CborListValue.definite(outputs.map((e) => e.toCbor()).toList()),
          switch (constant) {
            final bool constant => CborBoleanValue(constant),
            _ => CborNullValue(),
          },
          switch (payable) {
            final bool payable => CborBoleanValue(payable),
            _ => CborNullValue(),
          },
        ].cast()),
        type.tags);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "stateMutability": stateMutability?.name,
      "type": type.name,
      "outputs": outputs.map((e) => e.toJson()).toList(),
      "inputs": inputs.map((e) => e.toJson()).toList(),
      "constant": constant,
      "payable": payable
    }.notNullValue;
  }
}

class AbiReceiveFragment extends AbiFunctionFragment {
  AbiReceiveFragment({required super.name, required StateMutability mutability})
      : super(stateMutability: mutability);
  factory AbiReceiveFragment.fromJson(Map<String, dynamic> json) {
    return AbiReceiveFragment(
        name: 'receive',
        mutability: StateMutability.fromName(json.valueAs("stateMutability")));
  }

  factory AbiReceiveFragment.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes, object: cbor, tags: FragmentTypes.receive.tags);
    return AbiReceiveFragment(
        name: values.elementAtString(0),
        mutability: StateMutability.fromValue(values.elementAtBytes(1)));
  }
  @override
  FragmentTypes get type => FragmentTypes.receive;

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "stateMutability": stateMutability?.name}
        .notNullValue;
  }

  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          CborStringValue(name),
          CborBytesValue(stateMutability!.tags)
        ].cast()),
        type.tags);
  }
}

/// Represents a fallback function fragment in ABI, providing methods for working with fallback functions.
class AbiFallbackFragment extends AbiBaseFragment {
  /// Creates an instance of [AbiFallbackFragment] from JSON representation.
  factory AbiFallbackFragment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json.valueAsList<List?>("inputs") ?? [];
    final List<dynamic> outputs = json.valueAsList<List?>("outputs") ?? [];
    return AbiFallbackFragment(
        stateMutability:
            StateMutability.fromName(json.valueAs("stateMutability")),
        inputs: inputs.map((e) => AbiParameter.fromJson(e)).toList(),
        outputs: outputs.map((e) => AbiParameter.fromJson(e)).toList(),
        constant: json.valueAs("constant"),
        payable: json.valueAs("payable"));
  }

  factory AbiFallbackFragment.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes, object: cbor, tags: FragmentTypes.fallback.tags);
    return AbiFallbackFragment(
        stateMutability: StateMutability.fromValue(values.elementAtBytes(0)),
        inputs: values
            .elementAsListOf<CborTagValue>(1)
            .map((e) => AbiParameter.deserialize(cbor: e))
            .toList(),
        outputs: values
            .elementAsListOf<CborTagValue>(2)
            .map((e) => AbiParameter.deserialize(cbor: e))
            .toList(),
        constant: values.elementAt<CborBoleanValue?>(3)?.value,
        payable: values.elementAt<CborBoleanValue?>(4)?.value);
  }

  /// The state mutability of the fallback function.
  final StateMutability stateMutability;

  /// The list of output parameters for the fallback function.
  final List<AbiParameter> outputs;

  /// Indicates whether the fallback function is constant.
  final bool? constant;

  /// Indicates whether the fallback function is payable.
  final bool? payable;

  /// Creates an [AbiFallbackFragment] instance.
  AbiFallbackFragment({
    required this.stateMutability,
    super.inputs = const [],
    this.outputs = const [],
    this.constant,
    this.payable,
  }) : super(type: FragmentTypes.fallback);
  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          CborBytesValue(stateMutability.tags),
          CborListValue.definite(inputs.map((e) => e.toCbor()).toList()),
          CborListValue.definite(outputs.map((e) => e.toCbor()).toList()),
          switch (constant) {
            final bool constant => CborBoleanValue(constant),
            _ => CborNullValue(),
          },
          switch (payable) {
            final bool payable => CborBoleanValue(payable),
            _ => CborNullValue(),
          },
        ].cast()),
        type.tags);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "stateMutability": stateMutability.name,
      "type": type.name,
      "outputs": outputs.map((e) => e.toJson()).toList().emptyAsNull,
      "inputs": inputs.map((e) => e.toJson()).toList().emptyAsNull,
      "constant": constant,
      "payable": payable
    }.notNullValue;
  }
}

/// Represents an event fragment in ABI, providing methods for decoding event data.
class AbiEventFragment extends AbiBaseFragment {
  /// Creates an instance of [AbiEventFragment] from JSON representation.
  factory AbiEventFragment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json.valueAsList<List?>("inputs") ?? [];

    return AbiEventFragment(
      name: json.valueAs<String?>("name") ?? '',
      inputs: inputs.map((e) => AbiParameter.fromJson(e)).toList(),
      anonymous: json.valueAs("anonymous"),
    );
  }

  factory AbiEventFragment.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes, object: cbor, tags: FragmentTypes.event.tags);
    return AbiEventFragment(
        name: values.elementAtString(0),
        inputs: values
            .elementAsListOf<CborTagValue>(1)
            .map((e) => AbiParameter.deserialize(cbor: e))
            .toList(),
        anonymous: values.elementAt<CborBoleanValue?>(2)?.value);
  }

  /// The name of the event fragment.
  final String name;

  /// Indicates whether the event is anonymous.
  final bool? anonymous;

  /// Gets the event function name.
  String get eventName {
    return AbiBaseFragment.funcName(name, this);
  }

  /// The signature of the event.
  late final List<int> signature =
      QuickCrypto.keccack256Hash(StringUtils.encode(eventName));

  late final String signatureHex = BytesUtils.toHexString(signature);

  /// Decodes the event data from the encoded bytes and topics.
  /// Decodes the event parameters from `data` and `topics`.
  /// `inputs` = list of event ABI inputs (with .name, .type, .indexed, etc.)
  List<dynamic> decode(List<int> data, List<List<int>?> topics) {
    final List<dynamic> result = [];

    // Split inputs into indexed and non-indexed
    final nonIndexed = inputs.where((e) => !e.indexed).toList();
    // Decode non-indexed parameters from `data` as a tuple
    final nonIndexedDecoded = nonIndexed.isNotEmpty
        ? AbiParameter(name: '', type: 'tuple', components: nonIndexed)
            .decode(data)
            .result
        : [];

    int topicIndex = 1;
    int nonIndexedCounter = 0;

    for (final input in inputs) {
      if (input.indexed) {
        final topicBytes = topics[topicIndex++];
        if (topicBytes == null || input.isDynamic) {
          // Dynamic indexed parameters cannot be decoded; store hash
          result.add(topicBytes);
        } else {
          // Static indexed parameters can be decoded directly
          result.add(input.decode(topicBytes).result);
        }
      } else {
        // Non-indexed parameter: get from decoded data
        result.add(nonIndexedDecoded[nonIndexedCounter++]);
      }
    }

    return result;
  }

  /// Creates an [AbiEventFragment] instance.
  AbiEventFragment({
    required this.name,
    super.inputs = const [],
    this.anonymous,
  }) : super(type: FragmentTypes.event);

  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          CborStringValue(name),
          CborListValue.definite(inputs.map((e) => e.toCbor()).toList()),
          switch (anonymous) {
            final bool anonymous => CborBoleanValue(anonymous),
            _ => CborNullValue()
          },
        ].cast()),
        type.tags);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "inputs": inputs.map((e) => e.toJson(isEvent: true)).toList(),
      "name": name,
      "anonymous": anonymous,
    }.notNullValue;
  }
}

/// Represents an error fragment in ABI, providing methods for decoding errors.
class AbiErrorFragment extends AbiBaseFragment {
  /// Creates an instance of [AbiErrorFragment] from JSON representation.
  factory AbiErrorFragment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json.valueAs<List?>("inputs") ?? [];
    return AbiErrorFragment(
        inputs: inputs.map((e) => AbiParameter.fromJson(e)).toList(),
        name: json.valueAs("name"));
  }
  factory AbiErrorFragment.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes, object: cbor, tags: FragmentTypes.error.tags);
    return AbiErrorFragment(
        name: values.elementAtString(0),
        inputs: values
            .elementAsListOf<CborTagValue>(1)
            .map((e) => AbiParameter.deserialize(cbor: e))
            .toList());
  }

  /// The name of the error fragment.
  final String name;

  /// Creates an [AbiErrorFragment] instance.
  AbiErrorFragment({
    required this.name,
    super.inputs = const [],
  }) : super(type: FragmentTypes.error);

  /// Gets the error function name.
  String get errorName {
    return AbiBaseFragment.funcName(name, this);
  }

  /// The signature of the error.
  late final List<int> signature =
      QuickCrypto.keccack256Hash(StringUtils.encode(errorName));

  /// Gets the selector of the error.
  List<int> get selector => signature.sublist(0, ABIConst.selectorLength);

  /// Decodes the error parameters from the encoded bytes.
  List<dynamic> decodeError(List<int> encodedParams) {
    final List<int> encodeBytes =
        List.from(encodedParams.sublist(ABIConst.selectorLength));
    final abi =
        AbiParameter(name: '', type: 'tuple', components: List.from(inputs))
            .decode(encodeBytes);
    return abi.result;
  }

  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          CborStringValue(name),
          CborListValue.definite(inputs.map((e) => e.toCbor()).toList()),
        ].cast()),
        type.tags);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "inputs": inputs.map((e) => e.toJson()).toList(),
      "name": name,
    }.notNullValue;
  }
}

/// Enum class representing different state mutabilities of Ethereum functions.
enum StateMutability {
  /// Function with no side effects and doesn't read from or modify the blockchain state.
  pure('pure', [16]),

  /// Function that doesn't modify the blockchain state but can read from it.
  view('view', [17]),

  /// Function that can receive Ether and modify the blockchain state.
  payable('payable', [18]),

  /// Function that can modify the blockchain state but cannot receive Ether.
  nonpayable('nonpayable', [19]);

  final String name;
  final List<int> tags;
  bool get isExcutable => this == payable || this == nonpayable;

  const StateMutability(this.name, this.tags);

  /// Retrieves a StateMutability instance based on its name (case-insensitive).
  static StateMutability fromName(String? name) {
    return StateMutability.values.firstWhere(
      (e) => e.name == name?.toLowerCase(),
      orElse: () => throw MessageException('unsupported mutability',
          details: {'type': name}),
    );
  }

  static StateMutability fromValue(List<int>? tags) {
    return values.firstWhere((e) => CompareUtils.iterableIsEqual(tags, e.tags),
        orElse: () => throw ItemNotFoundException(value: tags));
  }
}

enum FragmentTypes {
  /// Constructor fragment type.
  constructor('constructor', [20]),

  /// Event fragment type.
  event('event', [21]),

  /// Function fragment type.
  function('function', [22]),

  /// Fallback fragment type.
  fallback('fallback', [23]),

  /// Error fragment type.
  error('error', [24]),

  /// Receive fragment type.
  receive('receive', [25]);

  final String name;
  final List<int> tags;

  const FragmentTypes(this.name, this.tags);

  /// Retrieves a FragmentTypes instance based on its name (case-insensitive).
  static FragmentTypes fromName(String? name) {
    try {
      return FragmentTypes.values
          .firstWhere((e) => e.name == name?.toLowerCase());
    } catch (e) {
      throw MessageException('unsupported fragment', details: {'type': name});
    }
  }

  static FragmentTypes fromValue(List<int>? tags) {
    return values.firstWhere((e) => CompareUtils.iterableIsEqual(tags, e.tags),
        orElse: () => throw ItemNotFoundException(value: tags));
  }
}

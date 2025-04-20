import 'package:on_chain/solidity/abi/abi.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Abstract class representing a base fragment in ABI, providing common properties and methods.
abstract class AbiBaseFragment {
  /// The list of input parameters for the fragment.
  abstract final List<AbiParameter> inputs;

  /// The type of the fragment.
  abstract final FragmentTypes type;

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

      default:
        throw MessageException('unsupported fragment $type');
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
}

/// Class representing an ABI constructor fragment.
class AbiConstructorFragment implements AbiBaseFragment {
  factory AbiConstructorFragment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json['inputs'] ?? [];
    return AbiConstructorFragment(
      stateMutability: StateMutability.fromName(json['stateMutability'])!,
      inputs: inputs.map((e) => AbiParameter.fromJson(e)).toList(),
    );
  }
  @override
  final FragmentTypes type = FragmentTypes.constructor;

  /// The state mutability of the constructor.
  final StateMutability stateMutability;
  @override
  final List<AbiParameter> inputs;

  /// Creates an [AbiConstructorFragment] instance.
  const AbiConstructorFragment({
    required this.stateMutability,
    this.inputs = const [],
  });
}

/// Represents a function fragment in ABI, providing methods for working with function calls.
class AbiFunctionFragment implements AbiBaseFragment {
  /// Creates an instance of [AbiFunctionFragment] from JSON representation.
  factory AbiFunctionFragment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json['inputs'] ?? [];
    final List<dynamic> outputs = json['outputs'] ?? [];
    return AbiFunctionFragment(
        name: json['name'],
        inputs: inputs.map((e) => AbiParameter.fromJson(e)).toList(),
        outputs: outputs.map((e) => AbiParameter.fromJson(e)).toList(),
        stateMutability: StateMutability.fromName(json['stateMutability']),
        constant: json['constant'],
        payable: json['payable']);
  }

  /// The name of the function
  final String name;
  @override
  final FragmentTypes type = FragmentTypes.function;

  /// The state mutability of the function.
  final StateMutability? stateMutability;
  @override
  final List<AbiParameter> inputs;

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

  /// Creates an [AbiFunctionFragment] instance.
  AbiFunctionFragment({
    required this.name,
    this.stateMutability,
    this.inputs = const [],
    this.outputs = const [],
    this.constant,
    this.payable,
  });

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
  String encodeHex(List params, [bool withSelector = true]) {
    return BytesUtils.toHexString(encode(params, withSelector));
  }

  /// Decodes the output of the function from the encoded output bytes.
  List<dynamic> decodeOutput(List<int> encodedOutput) {
    final abi =
        AbiParameter(name: '', type: 'tuple', components: List.from(outputs))
            .decode(encodedOutput);
    return abi.result;
  }

  // /// Decodes the output of the function from the encoded output bytes.
  // List<dynamic> decodeOutput(List<int> encodedOutput) {
  //   final abi =
  //       AbiParameter(name: "", type: "tuple", components: List.from(outputs))
  //           .decode(encodedOutput);
  //   return abi.result;
  // }

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
}

class AbiReceiveFragment extends AbiFunctionFragment {
  AbiReceiveFragment({required super.name, required StateMutability mutability})
      : super(stateMutability: mutability);
  factory AbiReceiveFragment.fromJson(Map<String, dynamic> json) {
    return AbiReceiveFragment(
        name: 'receive',
        mutability: StateMutability.fromName(json['stateMutability'])!);
  }
  @override
  FragmentTypes get type => FragmentTypes.receive;
}

/// Represents a fallback function fragment in ABI, providing methods for working with fallback functions.
class AbiFallbackFragment implements AbiBaseFragment {
  /// Creates an instance of [AbiFallbackFragment] from JSON representation.
  factory AbiFallbackFragment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json['inputs'] ?? [];
    final List<dynamic> outputs = json['outputs'] ?? [];
    return AbiFallbackFragment(
        stateMutability: StateMutability.fromName(json['stateMutability'])!,
        inputs: inputs.map((e) => AbiParameter.fromJson(e)).toList(),
        outputs: outputs.map((e) => AbiParameter.fromJson(e)).toList(),
        constant: json['constant'],
        payable: json['payable']);
  }

  @override
  final FragmentTypes type = FragmentTypes.fallback;

  /// The state mutability of the fallback function.
  final StateMutability stateMutability;

  @override
  final List<AbiParameter> inputs;

  /// The list of output parameters for the fallback function.
  final List<AbiParameter> outputs;

  /// Indicates whether the fallback function is constant.
  final bool? constant;

  /// Indicates whether the fallback function is payable.
  final bool? payable;

  /// Creates an [AbiFallbackFragment] instance.
  const AbiFallbackFragment({
    required this.stateMutability,
    this.inputs = const [],
    this.outputs = const [],
    this.constant,
    this.payable,
  });
}

/// Represents an event fragment in ABI, providing methods for decoding event data.
class AbiEventFragment implements AbiBaseFragment {
  /// Creates an instance of [AbiEventFragment] from JSON representation.
  factory AbiEventFragment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json['inputs'] ?? [];

    return AbiEventFragment(
        name: json['name'] ?? '',
        anonymous: json['anonymous'],
        inputs: inputs.map((e) => AbiParameter.fromJson(e)).toList());
  }

  /// The name of the event fragment.
  final String name;
  @override
  final FragmentTypes type = FragmentTypes.event;
  @override
  final List<AbiParameter> inputs;

  /// Indicates whether the event is anonymous.
  final bool? anonymous;

  /// Gets the event function name.
  String get eventName {
    return AbiBaseFragment.funcName(name, this);
  }

  /// The signature of the event.
  late final List<int> signature =
      QuickCrypto.keccack256Hash(StringUtils.encode(eventName));

  /// Decodes the event data from the encoded bytes and topics.
  List<dynamic> decode(List<int> data, List<List<int>?> topics) {
    final List<dynamic> result = [];
    final noIndexed = inputs.where((e) {
      return !e.indexed;
    }).toList();
    final indexed = inputs.where((e) {
      return e.indexed;
    }).toList();
    int nonIndexedCounter =
        topics.length > indexed.length ? topics.length - indexed.length : 0;
    int noneIndexCounter = 0;
    final abi = AbiParameter(name: '', type: 'tuple', components: noIndexed)
        .decode(data);
    for (int i = 0; i < inputs.length; i++) {
      final input = inputs.elementAt(i);
      if (input.indexed) {
        final topicBytes = topics.elementAt(nonIndexedCounter);
        nonIndexedCounter++;
        if (topicBytes == null || input.isDynamic) {
          result.add(topicBytes);
          continue;
        }
        final decode = input.decode(topicBytes).result;
        result.add(decode);
      } else {
        result.add(abi.result[noneIndexCounter]);
        noneIndexCounter++;
      }
    }

    return result;
  }

  /// Creates an [AbiEventFragment] instance.
  AbiEventFragment({
    required this.name,
    this.inputs = const [],
    this.anonymous,
  });
}

/// Represents an error fragment in ABI, providing methods for decoding errors.
class AbiErrorFragment implements AbiBaseFragment {
  /// Creates an instance of [AbiErrorFragment] from JSON representation.
  factory AbiErrorFragment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> inputs = json['inputs'] ?? [];
    return AbiErrorFragment(
        inputs: inputs.map((e) => AbiParameter.fromJson(e)).toList(),
        name: json['name']);
  }

  /// The name of the error fragment.
  final String name;
  @override
  final FragmentTypes type = FragmentTypes.error;
  @override
  final List<AbiParameter> inputs;

  /// Creates an [AbiErrorFragment] instance.
  AbiErrorFragment({
    required this.name,
    this.inputs = const [],
  });

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
}

/// Enum class representing different state mutabilities of Ethereum functions.
class StateMutability {
  final String name;
  const StateMutability._(this.name);

  /// Function with no side effects and doesn't read from or modify the blockchain state.
  static const StateMutability pure = StateMutability._('pure');

  /// Function that doesn't modify the blockchain state but can read from it.
  static const StateMutability view = StateMutability._('view');

  /// Function that can receive Ether and modify the blockchain state.
  static const StateMutability payable = StateMutability._('payable');

  /// Function that can modify the blockchain state but cannot receive Ether.
  static const StateMutability nonpayable = StateMutability._('nonpayable');

  /// List of all possible state mutabilities.
  static const List<StateMutability> values = [pure, view, payable, nonpayable];

  /// Retrieves a StateMutability instance based on its name (case-insensitive).
  static StateMutability? fromName(String? name) {
    try {
      return values
          .firstWhere((element) => element.name == name?.toLowerCase());
    } on StateError {
      return null;
    }
  }
}

/// Enum class representing different types of ABI fragments, such as constructor, event, function, fallback, and error.
class FragmentTypes {
  final String name;

  const FragmentTypes._(this.name);

  /// Constructor fragment type.
  static const FragmentTypes constructor = FragmentTypes._('constructor');

  /// Event fragment type.
  static const FragmentTypes event = FragmentTypes._('event');

  /// Function fragment type.
  static const FragmentTypes function = FragmentTypes._('function');

  /// Fallback fragment type.
  static const FragmentTypes fallback = FragmentTypes._('fallback');

  /// Error fragment type.
  static const FragmentTypes error = FragmentTypes._('error');

  static const FragmentTypes receive = FragmentTypes._('receive');

  /// List of all possible fragment types.
  static const List<FragmentTypes> values = [
    constructor,
    event,
    function,
    fallback,
    error,
    receive,
  ];

  /// Retrieves a FragmentTypes instance based on its name (case-insensitive).
  static FragmentTypes fromName(String? name) {
    try {
      return values
          .firstWhere((element) => element.name == name?.toLowerCase());
    } catch (e) {
      throw MessageException('unsupported fragment', details: {'type': name});
    }
  }
}

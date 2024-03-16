part of "package:on_chain/solidity/abi/abi.dart";

/// Represents different versions of the Ethereum Improvement Proposal (EIP) 712 specification.
class EIP712Version {
  /// Private constructor for creating instances of EIP712Version.
  const EIP712Version._(this.name, this.version);

  /// The name of the EIP712 version.
  final String name;

  /// The version number associated with the EIP712 version.
  final int version;

  /// EIP712 version 1.
  static const EIP712Version v1 = EIP712Version._("V1", 1);

  /// EIP712 version 3.
  static const EIP712Version v3 = EIP712Version._("V3", 3);

  /// EIP712 version 4.
  static const EIP712Version v4 = EIP712Version._("V4", 4);
}

/// Abstract base class for encoding data according to the Ethereum Improvement Proposal (EIP) 712 specification.
abstract class EIP712Base {
  /// Encodes the data into a list of integers according to EIP-712.
  List<int> encode();

  /// Represents the version of the EIP-712 specification used by the concrete implementation.
  abstract final EIP712Version version;
}

/// Represents details about a type used in EIP-712 encoding.
class Eip712TypeDetails {
  final String name;

  /// The type string representing the data type.
  final String type;

  const Eip712TypeDetails({
    required this.name,
    required this.type,
  });

  factory Eip712TypeDetails.fromJson(Map<String, dynamic> json) {
    return Eip712TypeDetails(name: json["name"], type: json["type"]);
  }
  @override
  String toString() {
    return "name: $name  type: $type";
  }
}

/// Represents typed data for EIP-712, implementing the EIP712Base interface.
class Eip712TypedData implements EIP712Base {
  /// Map of type names to their corresponding list of type details.
  final Map<String, List<Eip712TypeDetails>> types;

  /// The primary type for the typed data.
  final String primaryType;

  /// Domain parameters for the EIP-712 typed data.
  final Map<String, dynamic> domain;

  /// Message data for the EIP-712 typed data.
  final Map<String, dynamic> message;

  /// The version of the EIP-712 specification used.
  @override
  final EIP712Version version;

  /// Constructor for Eip712TypedData.
  const Eip712TypedData({
    required this.types,
    required this.primaryType,
    required this.domain,
    required this.message,
    this.version = EIP712Version.v4,
  }) : assert(version != EIP712Version.v1, "use EIP712V1 class for EIP712 V1");

  factory Eip712TypedData.fromJson(
    Map<String, dynamic> json, {
    EIP712Version version = EIP712Version.v4,
  }) {
    try {
      final jsonTypes = Map<String, List<dynamic>>.from(json["types"]);
      final Map<String, List<Eip712TypeDetails>> types = {};

      for (final i in jsonTypes.entries) {
        final List values = i.value;
        List<Eip712TypeDetails> eip712Types =
            values.map((e) => Eip712TypeDetails.fromJson(e)).toList();
        types[i.key] = eip712Types;
      }
      return Eip712TypedData(
          types: types,
          primaryType: json["primaryType"],
          domain: json["domain"],
          message: json["message"],
          version: version);
    } catch (e) {
      throw const MessageException("invalid EIP712 json struct");
    }
  }

  /// Encodes the typed data into a bytes, optionally hashing the result.
  /// If [hash] is true (default), the result is hashed using Keccak-256.
  @override
  List<int> encode([bool hash = true]) {
    final List<int> encode = [
      ..._EIP712Utils.eip191PrefixBytes,
      ..._EIP712Utils.structHash(this, _EIP712Utils.domainKeyName, domain),
      ..._EIP712Utils.structHash(this, primaryType, message)
    ];
    if (hash) {
      return QuickCrypto.keccack256Hash(encode);
    }

    return encode;
  }

  String encodeHex([bool hash = true]) {
    return BytesUtils.toHexString(encode(hash));
  }
}

/// Represents a typed data field for EIP-712 version 1.
/// This class is used to create instances of typed data fields with specified type, name, and value.
class Eip712TypedDataV1 {
  factory Eip712TypedDataV1(
      {required String type, required String name, required dynamic value}) {
    return Eip712TypedDataV1._(
        name: name,
        value: _EIP712Utils.ensureCorrectValues(type, value),
        type: type);
  }
  factory Eip712TypedDataV1.fromJson(Map<String, dynamic> json) {
    return Eip712TypedDataV1(
        type: json["type"], name: json["name"], value: json["value"]);
  }

  /// Private constructor for creating instances of Eip712TypedDataV1.
  const Eip712TypedDataV1._(
      {required this.name, required this.value, required this.type});

  /// The name of the typed data field.
  final String name;

  /// The type of the typed data field.
  final String type;

  /// The value of the typed data field.
  final dynamic value;
}

/// Represents a typed data structure for EIP-712 version 1.
/// This class implements the EIP712Base interface for encoding data according to EIP-712 specifications.
class EIP712Legacy implements EIP712Base {
  /// Constructor for EIP712Legacy, accepting a list of Eip712TypedDataV1 instances.
  const EIP712Legacy(this.typesData);

  factory EIP712Legacy.fromJson(List<Map<String, dynamic>> messages) {
    return EIP712Legacy(
        messages.map((e) => Eip712TypedDataV1.fromJson(e)).toList());
  }

  /// List of Eip712TypedDataV1 instances representing the typed data fields.
  final List<Eip712TypedDataV1> typesData;

  /// The version of the EIP-712 specification used by this implementation.
  @override
  final EIP712Version version = EIP712Version.v1;

  /// Encodes the typed data structure into a list of integers using EIP-712 version 1.
  @override
  List<int> encode() {
    // Extract values, types, and names from Eip712TypedDataV1 instances
    final values = typesData.map((e) => e.value).toList();
    final types = typesData.map((e) => e.type).toList();
    final names = typesData.map((e) => "${e.type} ${e.name}").toList();
    // Calculate hashes for types and names
    final typesHash =
        QuickCrypto.keccack256Hash(_EIP712Utils.legacyV1encode(types, values));
    final namesHash = QuickCrypto.keccack256Hash(_EIP712Utils.legacyV1encode(
        List.generate(names.length, (index) => "string"), names));
    return QuickCrypto.keccack256Hash(_EIP712Utils.legacyV1encode(
        ['bytes32', 'bytes32'], [namesHash, typesHash]));
  }

  String encodeHex() {
    return BytesUtils.toHexString(encode());
  }
}

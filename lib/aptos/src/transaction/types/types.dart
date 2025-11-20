import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/account.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/helper/helper.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/aptos/src/keypair/keys/ed25519.dart';
import 'package:on_chain/aptos/src/transaction/utils/utils.dart';
import 'package:on_chain/serialization/bcs/move/types/types.dart';
import 'package:on_chain/serialization/bcs/serialization/serialization.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosChainId extends BcsSerialization {
  final int chainId;
  AptosChainId(int chainId) : chainId = chainId.asUint8;
  factory AptosChainId.fromStruct(Map<String, dynamic> json) {
    return AptosChainId(json.as("chainId"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u8(property: "chainId"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"chainId": chainId};
  }
}

class AptosModuleId extends BcsSerialization {
  final AptosAddress address;
  final String name;
  const AptosModuleId._({required this.address, required this.name});
  factory AptosModuleId({required AptosAddress address, required String name}) {
    return AptosModuleId._(
        address: address, name: AptosTransactionUtils.validateIdentifier(name));
  }
  factory AptosModuleId.fromString(String module) {
    final parts = AptosTransactionUtils.getModuleIdPart(module);
    return AptosModuleId(address: parts.$1, name: parts.$2);
  }
  factory AptosModuleId.fromStruct(Map<String, dynamic> json) {
    return AptosModuleId(
        address: AptosAddress.fromStruct(json.asMap("address")),
        name: json.as("name"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosAddress.layout(property: "address"),
      LayoutConst.bcsString(property: "name"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"address": address.toLayoutStruct(), "name": name};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosModuleId) return false;
    return address == other.address && name == other.name;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([address, name]);
}

enum AptosTypeTags {
  boolean(value: 0),
  u8(value: 1),
  u64(value: 2),
  u128(value: 3),
  address(value: 4),
  signer(value: 5),
  vector(value: 6),
  struct(value: 7),
  u16(value: 8),
  u32(value: 9),
  u256(value: 10),
  reference(value: 254),
  generic(value: 255);

  bool get isNumber =>
      this == u8 ||
      this == u16 ||
      this == u32 ||
      this == u64 ||
      this == u128 ||
      this == u256;

  final int value;
  const AptosTypeTags({required this.value});
  static AptosTypeTags fromName(String? name) {
    return values.firstWhere((e) => e.name.toLowerCase() == name?.toLowerCase(),
        orElse: () => throw DartAptosPluginException(
            "cannot find correct TypeTag from the given name.",
            details: {"name": name}));
  }

  static AptosTypeTags? find(String? name) {
    try {
      if (name?.toLowerCase() == 'bool') return AptosTypeTags.boolean;
      return values
          .firstWhere((e) => e.name.toLowerCase() == name?.toLowerCase());
    } on StateError {
      return null;
    }
  }
}

abstract class AptosTypeTag extends BcsVariantSerialization {
  final AptosTypeTags type;
  const AptosTypeTag({required this.type});
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: AptosTypeTagNumeric.layout,
          property: AptosTypeTags.u8.name,
          index: AptosTypeTags.u8.value),
      LazyVariantModel(
          layout: AptosTypeTagNumeric.layout,
          property: AptosTypeTags.u16.name,
          index: AptosTypeTags.u16.value),
      LazyVariantModel(
          layout: AptosTypeTagNumeric.layout,
          property: AptosTypeTags.u32.name,
          index: AptosTypeTags.u32.value),
      LazyVariantModel(
          layout: AptosTypeTagNumeric.layout,
          property: AptosTypeTags.u64.name,
          index: AptosTypeTags.u64.value),
      LazyVariantModel(
          layout: AptosTypeTagNumeric.layout,
          property: AptosTypeTags.u128.name,
          index: AptosTypeTags.u128.value),
      LazyVariantModel(
          layout: AptosTypeTagNumeric.layout,
          property: AptosTypeTags.u256.name,
          index: AptosTypeTags.u256.value),
      LazyVariantModel(
          layout: AptosTypeTagNumeric.layout,
          property: AptosTypeTags.boolean.name,
          index: AptosTypeTags.boolean.value),
      LazyVariantModel(
          layout: AptosTypeTagSigner.layout,
          property: AptosTypeTags.signer.name,
          index: AptosTypeTags.signer.value),
      LazyVariantModel(
          layout: AptosTypeTagAddress.layout,
          property: AptosTypeTags.address.name,
          index: AptosTypeTags.address.value),
      LazyVariantModel(
          layout: AptosTypeTagStruct.layout,
          property: AptosTypeTags.struct.name,
          index: AptosTypeTags.struct.value),
      LazyVariantModel(
          layout: AptosTypeTagVector.layout,
          property: AptosTypeTags.vector.name,
          index: AptosTypeTags.vector.value),
      LazyVariantModel(
          layout: AptosTypeTagReference.layout,
          property: AptosTypeTags.reference.name,
          index: AptosTypeTags.reference.value),
      LazyVariantModel(
          layout: AptosTypeTagGeneric.layout,
          property: AptosTypeTags.generic.name,
          index: AptosTypeTags.generic.value),
    ], property: property);
  }

  factory AptosTypeTag.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = AptosTypeTags.fromName(decode.variantName);
    if (type.isNumber) {
      return AptosTypeTagNumeric._(type: type);
    }
    return switch (type) {
      AptosTypeTags.signer => AptosTypeTagSigner(),
      AptosTypeTags.address => AptosTypeTagAddress(),
      AptosTypeTags.vector => AptosTypeTagVector.fromStruct(decode.value),
      AptosTypeTags.struct => AptosTypeTagStruct.fromStruct(decode.value),
      AptosTypeTags.generic => AptosTypeTagGeneric.fromStruct(decode.value),
      AptosTypeTags.boolean => AptosTypeTagBoolean(),
      _ => throw DartAptosPluginException("Invalid type tag.",
          details: {"type": type.name}),
    };
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosTypeTag) return false;
    if (runtimeType != other.runtimeType) return false;
    return type == other.type;
  }

  @override
  int get hashCode => type.hashCode;

  /// Converts dynamic Dart values to Aptos Move [AptosEntryFunctionArguments].
  ///
  /// This method handles the transformation of generic Dart [value]s into a format
  /// compatible with Aptos Move entry function arguments, considering any provided
  /// [typeArgs] for generic types.
  AptosEntryFunctionArguments toEntryFunctionArguments(
      {Object? value, List<AptosTypeTag> genericTypeArgs = const []});
}

class AptosTypeTagNumeric extends AptosTypeTag {
  AptosTypeTagNumeric._({required super.type});
  factory AptosTypeTagNumeric.u8() {
    return AptosTypeTagNumeric._(type: AptosTypeTags.u8);
  }
  factory AptosTypeTagNumeric.u16() {
    return AptosTypeTagNumeric._(type: AptosTypeTags.u16);
  }
  factory AptosTypeTagNumeric.u32() {
    return AptosTypeTagNumeric._(type: AptosTypeTags.u32);
  }
  factory AptosTypeTagNumeric.u64() {
    return AptosTypeTagNumeric._(type: AptosTypeTags.u64);
  }
  factory AptosTypeTagNumeric.u128() {
    return AptosTypeTagNumeric._(type: AptosTypeTags.u128);
  }
  factory AptosTypeTagNumeric.u256() {
    return AptosTypeTagNumeric._(type: AptosTypeTags.u256);
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }

  @override
  MoveArgument toEntryFunctionArguments(
      {Object? value, List<AptosTypeTag> genericTypeArgs = const []}) {
    switch (type) {
      case AptosTypeTags.u8:
        return MoveU8.parse(value);
      case AptosTypeTags.u16:
        return MoveU16.parse(value);
      case AptosTypeTags.u32:
        return MoveU32.parse(value);
      case AptosTypeTags.u64:
        return MoveU64.parse(value);
      case AptosTypeTags.u128:
        return MoveU128.parse(value);
      case AptosTypeTags.u256:
        return MoveU256.parse(value);
      default:
        throw DartAptosPluginException("Invalid numeric type tag.",
            details: {"type": type.name});
    }
  }
}

class AptosTypeTagBoolean extends AptosTypeTag {
  AptosTypeTagBoolean() : super(type: AptosTypeTags.boolean);

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }

  @override
  MoveArgument toEntryFunctionArguments(
      {Object? value, List<AptosTypeTag> genericTypeArgs = const []}) {
    return MoveBool.parse(value);
  }
}

class AptosTypeTagAddress extends AptosTypeTag {
  AptosTypeTagAddress() : super(type: AptosTypeTags.address);

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }

  @override
  MoveArgument toEntryFunctionArguments(
      {Object? value, List<AptosTypeTag> genericTypeArgs = const []}) {
    return MoveAddress.parse(value);
  }
}

class AptosTypeTagSigner extends AptosTypeTag {
  AptosTypeTagSigner() : super(type: AptosTypeTags.signer);

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }

  @override
  MoveArgument toEntryFunctionArguments(
      {Object? value, List<AptosTypeTag> genericTypeArgs = const []}) {
    return MoveAddress.parse(value);
  }
}

class AptosTypeTagReference extends AptosTypeTag {
  final AptosTypeTag value;
  AptosTypeTagReference(this.value) : super(type: AptosTypeTags.reference);

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  factory AptosTypeTagReference.fromStruct(Map<String, dynamic> json) {
    return AptosTypeTagReference(AptosTypeTag.fromStruct(json.asMap("value")));
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosTypeTagReference) return false;
    return type == other.type && value == other.value;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([type, value]);

  /// Converts dynamic Dart values to Aptos Move [AptosEntryFunctionArguments].
  ///
  /// This method handles the transformation of generic Dart [value]s into a format
  /// compatible with Aptos Move entry function arguments, considering any provided
  /// [typeArgs] for generic types.
  @override
  AptosEntryFunctionArguments toEntryFunctionArguments(
      {Object? value, List<AptosTypeTag> genericTypeArgs = const []}) {
    if (value is AptosEntryFunctionArguments) return value;
    throw DartAptosPluginException(
        "Unsupported conversion: Cannot convert the provided value to an EntryFunctionArgument for reference type.");
  }
}

class AptosTypeTagGeneric extends AptosTypeTag {
  final int index;
  AptosTypeTagGeneric(int index)
      : index = index.asUint32,
        super(type: AptosTypeTags.generic);
  factory AptosTypeTagGeneric.fromStruct(Map<String, dynamic> json) {
    return AptosTypeTagGeneric(json.as("index"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([LayoutConst.u32(property: "index")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"index": index};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosTypeTagGeneric) return false;
    if (index != other.index) return false;
    return type == other.type;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([type, index]);

  /// Converts dynamic Dart values to Aptos Move [AptosEntryFunctionArguments].
  ///
  /// This method handles the transformation of generic Dart [value]s into a format
  /// compatible with Aptos Move entry function arguments, considering any provided
  /// [typeArgs] for generic types.
  @override
  AptosEntryFunctionArguments toEntryFunctionArguments(
      {Object? value, List<AptosTypeTag> genericTypeArgs = const []}) {
    final typeArg = genericTypeArgs.elementAtOrNull(index);
    if (typeArg == null) {
      throw DartAptosPluginException(
          "Missing generic type argument reference at index '$index'. ");
    }
    return typeArg.toEntryFunctionArguments(
        value: value, genericTypeArgs: genericTypeArgs);
  }
}

class AptosTypeTagVector extends AptosTypeTag {
  final AptosTypeTag value;
  AptosTypeTagVector(this.value) : super(type: AptosTypeTags.vector);
  factory AptosTypeTagVector.fromStruct(Map<String, dynamic> json) {
    return AptosTypeTagVector(AptosTypeTag.fromStruct(json.asMap("value")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([AptosTypeTag.layout(property: "value")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"value": value.toVariantLayoutStruct()};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosTypeTagVector) return false;
    if (value != other.value) return false;
    return type == other.type;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([type, value]);
  @override
  MoveVector toEntryFunctionArguments(
      {Object? value, List<AptosTypeTag> genericTypeArgs = const []}) {
    if (value is MoveVector) {
      return MoveVector((value.value as List)
          .map((e) => this.value.toEntryFunctionArguments(
              value: e, genericTypeArgs: genericTypeArgs))
          .toList());
    }
    return MoveVector((value as List)
        .map((e) => this.value.toEntryFunctionArguments(
            value: e, genericTypeArgs: genericTypeArgs))
        .toList());
  }
}

class AptosStructTag extends BcsSerialization {
  final AptosAddress address;
  final String moduleName;
  final String name;
  final List<AptosTypeTag> typeArgs;

  factory AptosStructTag.fromStruct(Map<String, dynamic> json) {
    return AptosStructTag(
        address: AptosAddress.fromStruct(json.asMap("address")),
        moduleName: json.as("moduleName"),
        name: json.as("name"),
        typeArgs: json
            .asListOfMap("typeArgs")!
            .map((e) => AptosTypeTag.fromStruct(e))
            .toList());
  }

  AptosStructTag(
      {required this.address,
      required this.moduleName,
      required this.name,
      List<AptosTypeTag> typeArgs = const []})
      : typeArgs = typeArgs.immutable;

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosAddress.layout(property: "address"),
      LayoutConst.bcsString(property: "moduleName"),
      LayoutConst.bcsString(property: "name"),
      LayoutConst.bcsVector(AptosTypeTag.layout(), property: "typeArgs")
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "address": address.toLayoutStruct(),
      "moduleName": moduleName,
      "name": name,
      "typeArgs": typeArgs.map((e) => e.toVariantLayoutStruct()).toList()
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosStructTag) return false;
    return address == other.address &&
        moduleName == other.moduleName &&
        name == other.name &&
        CompareUtils.iterableIsEqual(typeArgs, other.typeArgs);
  }

  /// Checks if the current type represents an Aptos `Option`.
  ///
  /// Returns `true` if the [address], [name], and [moduleName] match the Aptos `Option` type,
  /// indicating that this type is used for optional values (nullable-like behavior).
  bool get isOption =>
      address == AptosAddress.one && name == 'Option' && moduleName == 'option';

  /// Checks if the current type represents an Aptos `String`.
  ///
  /// Returns `true` if the [address], [name], and [moduleName] correspond to the Aptos `String` type,
  /// used for text data within Move smart contracts.
  bool get isString =>
      address == AptosAddress.one && name == 'String' && moduleName == 'string';

  /// Checks if the current type represents an Aptos `Object`.
  ///
  /// Returns `true` if the [address], [name], and [moduleName] match the Aptos `Object` type,
  /// indicating a generic data structure for handling complex objects.
  bool get isObject =>
      address == AptosAddress.one && name == 'Object' && moduleName == 'object';

  /// Converts dynamic Dart values to Aptos Move [AptosEntryFunctionArguments].
  ///
  /// This method handles the transformation of generic Dart [value]s into a format
  /// compatible with Aptos Move entry function arguments, considering any provided
  /// [typeArgs] for generic types.
  AptosEntryFunctionArguments toEntryFunctionArguments(
      {Object? value, List<AptosTypeTag> genericTypeArgs = const []}) {
    if (isObject) {
      return MoveAddress.parse(value);
    } else if (isString) {
      return MoveString.parse(value);
    } else if (isOption) {
      if (value == null) {
        return MoveOption<MoveBool>(null);
      }
      if (value is MoveOption) {
        if (value.value == null) {
          return MoveOption<MoveBool>(null);
        }
        return MoveOption<MoveType>(typeArgs[0].toEntryFunctionArguments(
            value: value.value, genericTypeArgs: genericTypeArgs));
      }
      return MoveOption<MoveType>(typeArgs[0].toEntryFunctionArguments(
          value: value, genericTypeArgs: genericTypeArgs));
    }
    throw DartAptosPluginException("Unsuported Struct tag.");
  }

  @override
  int get hashCode =>
      HashCodeGenerator.generateHashCode([address, moduleName, name, typeArgs]);
}

class AptosTypeTagStruct extends AptosTypeTag {
  final AptosStructTag value;
  AptosTypeTagStruct(this.value) : super(type: AptosTypeTags.struct);

  factory AptosTypeTagStruct.fromStruct(Map<String, dynamic> json) {
    return AptosTypeTagStruct(AptosStructTag.fromStruct(json.asMap("value")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([AptosStructTag.layout(property: "value")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"value": value.toLayoutStruct()};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosTypeTagStruct) return false;
    return value == other.value;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([type, value]);

  /// Converts dynamic Dart values to Aptos Move [AptosEntryFunctionArguments].
  ///
  /// This method handles the transformation of generic Dart [value]s into a format
  /// compatible with Aptos Move entry function arguments, considering any provided
  /// [typeArgs] for generic types.
  @override
  AptosEntryFunctionArguments toEntryFunctionArguments(
      {Object? value, List<AptosTypeTag> genericTypeArgs = const []}) {
    return this.value.toEntryFunctionArguments(
        value: value, genericTypeArgs: genericTypeArgs);
  }
}

/// Different kinds of transactions.
enum AptosTransactionPayloads {
  /// A transaction that executes code.
  script(value: 0),

  /// Deprecated.
  moduleBundle(value: 1),

  /// A transaction that executes an existing entry function published on-chain.
  entryFunction(value: 2),

  /// A multisig transaction that allows an owner of a multisig account to execute a pre-approved
  /// transaction as the multisig account.
  multisig(value: 3);

  final int value;
  const AptosTransactionPayloads({required this.value});
  static AptosTransactionPayloads fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartAptosPluginException(
            "cannot find correct transaction payload from the given name.",
            details: {"name": name}));
  }
}

abstract class AptosTransactionPayload extends BcsVariantSerialization {
  final AptosTransactionPayloads type;
  const AptosTransactionPayload({required this.type});
  factory AptosTransactionPayload.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = AptosTransactionPayloads.fromName(decode.variantName);
    return switch (type) {
      AptosTransactionPayloads.script =>
        AptosTransactionPayloadScript.fromStruct(decode.value),
      AptosTransactionPayloads.entryFunction =>
        AptosTransactionPayloadEntryFunction.fromStruct(decode.value),
      AptosTransactionPayloads.multisig =>
        AptosTransactionPayloadMultisig.fromStruct(decode.value),
      _ => throw DartAptosPluginException("unsuported transaction payload.",
          details: {"type": type.name})
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: AptosTransactionPayloadScript.layout,
          property: AptosTransactionPayloads.script.name,
          index: AptosTransactionPayloads.script.value),
      LazyVariantModel(
          layout: AptosTransactionPayloadEntryFunction.layout,
          property: AptosTransactionPayloads.entryFunction.name,
          index: AptosTransactionPayloads.entryFunction.value),
      LazyVariantModel(
          layout: AptosTransactionPayloadMultisig.layout,
          property: AptosTransactionPayloads.multisig.name,
          index: AptosTransactionPayloads.multisig.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class AptosScript extends BcsSerialization {
  final List<int> byteCode;
  final List<AptosTypeTag> typeArgs;
  final List<MoveArgument> arguments;
  AptosScript(
      {required List<int> byteCode,
      required List<AptosTypeTag> typeArgs,
      required List<AptosScriptArguments> arguments})
      : byteCode = byteCode.asImmutableBytes,
        typeArgs = typeArgs.immutable,
        arguments = arguments.map((e) => e.asMoveArgument()).toImutableList;

  factory AptosScript.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosScript.fromStruct(decode);
  }
  factory AptosScript.fromStruct(Map<String, dynamic> json) {
    return AptosScript(
        byteCode: json.asBytes("byteCode"),
        typeArgs: json
            .asListOfMap("typeArgs")!
            .map((e) => AptosTypeTag.fromStruct(e))
            .toList(),
        arguments: json
            .asListOfMap("args")!
            .map((e) => MoveArgument.fromStruct(e))
            .toList());
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsBytes(property: "byteCode"),
      LayoutConst.bcsVector(AptosTypeTag.layout(), property: "typeArgs"),
      LayoutConst.bcsVector(MoveArgument.layout(), property: "args")
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "byteCode": byteCode,
      "typeArgs": typeArgs.map((e) => e.toVariantLayoutStruct()).toList(),
      "args": arguments.map((e) => e.toVariantLayoutStruct()).toList()
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosScript) return false;
    return BytesUtils.bytesEqual(byteCode, other.byteCode) &&
        CompareUtils.iterableIsEqual(arguments, other.arguments) &&
        CompareUtils.iterableIsEqual(typeArgs, other.typeArgs);
  }

  @override
  int get hashCode =>
      HashCodeGenerator.generateBytesHashCode(byteCode, [arguments, typeArgs]);
}

/// Call a Move script.
class AptosTransactionPayloadScript extends AptosTransactionPayload {
  final AptosScript script;
  const AptosTransactionPayloadScript({required this.script})
      : super(type: AptosTransactionPayloads.script);
  factory AptosTransactionPayloadScript.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosTransactionPayloadScript.fromStruct(decode);
  }
  factory AptosTransactionPayloadScript.fromStruct(Map<String, dynamic> json) {
    return AptosTransactionPayloadScript(
        script: AptosScript.fromStruct(json.asMap("script")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosScript.layout(property: "script"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"script": script.toLayoutStruct()};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosTransactionPayloadScript) return false;
    return script == other.script;
  }

  @override
  int get hashCode => script.hashCode;
}

class AptosTransactionArgumentBytes
    extends AptosEntryFunctionArguments<List<int>> {
  AptosTransactionArgumentBytes(List<int> data) : super(data.asImmutableBytes);
  factory AptosTransactionArgumentBytes.fromStruct(Map<String, dynamic> json) {
    return AptosTransactionArgumentBytes(json.asBytes("data"));
  }
  static Layout<Map<String, dynamic>> layout(int length, {String? property}) {
    return LayoutConst.struct(
        [LayoutConst.fixedBlobN(length, property: 'data')],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(value.length, property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"data": value};
  }
}

class AptosTransactionEntryFunction extends BcsSerialization {
  final AptosModuleId moduleId;
  final String functionName;
  final List<AptosTypeTag> typeArgs;
  final List<AptosEntryFunctionArguments> args;

  AptosTransactionEntryFunction(
      {required this.moduleId,
      required String functionName,
      List<AptosTypeTag> typeArgs = const [],
      required List<AptosEntryFunctionArguments> args})
      : typeArgs = typeArgs.immutable,
        args = args.immutable,
        functionName = AptosTransactionUtils.validateIdentifier(functionName);
  factory AptosTransactionEntryFunction.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosTransactionEntryFunction.fromStruct(decode);
  }
  factory AptosTransactionEntryFunction.fromStruct(Map<String, dynamic> json) {
    return AptosTransactionEntryFunction(
        moduleId: AptosModuleId.fromStruct(json.asMap("moduleId")),
        functionName: json.as("functionName"),
        typeArgs: json
            .asListOfMap("typeArgs")!
            .map((e) => AptosTypeTag.fromStruct(e))
            .toList(),
        args: json
            .asListOfBytes("args")!
            .map((e) => AptosTransactionArgumentBytes(e))
            .toList());
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosModuleId.layout(property: "moduleId"),
      LayoutConst.bcsString(property: "functionName"),
      LayoutConst.bcsVector(AptosTypeTag.layout(), property: "typeArgs"),
      LayoutConst.bcsVector(LayoutConst.bcsBytes(), property: "args")
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "moduleId": moduleId.toLayoutStruct(),
      "functionName": functionName,
      "typeArgs": typeArgs.map((e) => e.toVariantLayoutStruct()).toList(),
      "args": args.map((e) => e.toBcs()).toList()
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosTransactionEntryFunction) return false;
    return moduleId == other.moduleId &&
        functionName == other.functionName &&
        CompareUtils.iterableIsEqual(typeArgs, other.typeArgs) &&
        CompareUtils.iterableIsEqual(args, other.args);
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode(
      [moduleId, functionName, typeArgs, args]);
}

class AptosTransactionPayloadEntryFunction extends AptosTransactionPayload {
  final AptosTransactionEntryFunction entryFunction;
  const AptosTransactionPayloadEntryFunction({required this.entryFunction})
      : super(type: AptosTransactionPayloads.entryFunction);
  factory AptosTransactionPayloadEntryFunction.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosTransactionPayloadEntryFunction.fromStruct(decode);
  }
  factory AptosTransactionPayloadEntryFunction.fromStruct(
      Map<String, dynamic> json) {
    return AptosTransactionPayloadEntryFunction(
        entryFunction: AptosTransactionEntryFunction.fromStruct(
            json.asMap("entryFunction")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosTransactionEntryFunction.layout(property: "entryFunction"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"entryFunction": entryFunction.toLayoutStruct()};
  }
}

enum AptosMultisigTransactionPayloads {
  entryFunction(value: 0);

  final int value;
  const AptosMultisigTransactionPayloads({required this.value});
  static AptosMultisigTransactionPayloads fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartAptosPluginException(
            "cannot find correct multisig transaction payload from the given name.",
            details: {"name": name}));
  }
}

abstract class AptosMultisigTransactionPayload extends BcsVariantSerialization {
  final AptosMultisigTransactionPayloads type;
  const AptosMultisigTransactionPayload({required this.type});

  factory AptosMultisigTransactionPayload.fromStruct(
      Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = AptosMultisigTransactionPayloads.fromName(decode.variantName);
    return switch (type) {
      AptosMultisigTransactionPayloads.entryFunction =>
        AptosMultisigTransactionPayloadEntryFunction.fromStruct(decode.value),
    };
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: AptosMultisigTransactionPayloadEntryFunction.layout,
          property: AptosMultisigTransactionPayloads.entryFunction.name,
          index: AptosMultisigTransactionPayloads.entryFunction.value)
    ]);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class AptosMultisigTransactionPayloadEntryFunction
    extends AptosMultisigTransactionPayload {
  final AptosTransactionEntryFunction entryFunction;
  const AptosMultisigTransactionPayloadEntryFunction(
      {required this.entryFunction})
      : super(type: AptosMultisigTransactionPayloads.entryFunction);

  factory AptosMultisigTransactionPayloadEntryFunction.fromStruct(
      Map<String, dynamic> json) {
    return AptosMultisigTransactionPayloadEntryFunction(
        entryFunction: AptosTransactionEntryFunction.fromStruct(
            json.asMap("entryFunction")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosTransactionEntryFunction.layout(property: "entryFunction"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"entryFunction": entryFunction.toLayoutStruct()};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosMultisigTransactionPayloadEntryFunction) return false;
    return type == other.type && entryFunction == other.entryFunction;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([type, entryFunction]);
}

class AptosMultisig extends BcsSerialization {
  final AptosAddress multisigAddress;
  final AptosMultisigTransactionPayload? transactionPayload;
  const AptosMultisig({required this.multisigAddress, this.transactionPayload});
  factory AptosMultisig.fromStruct(Map<String, dynamic> json) {
    return AptosMultisig(
        multisigAddress: AptosAddress.fromStruct(json.asMap("multisigAddress")),
        transactionPayload:
            json.mybeAs<AptosMultisigTransactionPayload, Map<String, dynamic>>(
                key: "transactionPayload",
                onValue: (e) => AptosMultisigTransactionPayload.fromStruct(e)));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosAddress.layout(property: "multisigAddress"),
      LayoutConst.optional(AptosMultisigTransactionPayload.layout(),
          property: "transactionPayload"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "multisigAddress": multisigAddress.toLayoutStruct(),
      "transactionPayload": transactionPayload?.toVariantLayoutStruct()
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosMultisig) return false;
    return multisigAddress == other.multisigAddress &&
        transactionPayload == other.transactionPayload;
  }

  @override
  int get hashCode =>
      HashCodeGenerator.generateHashCode([multisigAddress, transactionPayload]);
}

class AptosTransactionPayloadMultisig extends AptosTransactionPayload {
  final AptosMultisig multisig;
  const AptosTransactionPayloadMultisig({required this.multisig})
      : super(type: AptosTransactionPayloads.multisig);

  factory AptosTransactionPayloadMultisig.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosTransactionPayloadMultisig.fromStruct(decode);
  }
  factory AptosTransactionPayloadMultisig.fromStruct(
      Map<String, dynamic> json) {
    return AptosTransactionPayloadMultisig(
        multisig: AptosMultisig.fromStruct(json.asMap("multisig")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosMultisig.layout(property: "multisig"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"multisig": multisig.toLayoutStruct()};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosTransactionPayloadMultisig) return false;
    return multisig == other.multisig && type == other.type;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([type, multisig]);
}

/// RawTransaction is the portion of a transaction that a client signs.
class AptosRawTransaction extends BcsSerialization {
  /// Sender's address.
  final AptosAddress sender;

  /// Sequence number of this transaction. This must match the sequence number
  /// stored in the sender's account at the time the transaction executes
  final BigInt sequenceNumber;

  /// The transaction payload, e.g., a script to execute.
  final AptosTransactionPayload transactionPayload;

  /// Maximal total gas to spend for this transaction.
  final BigInt maxGasAmount;

  /// Price to be paid per gas unit.
  final BigInt gasUnitPrice;

  /// Expiration timestamp for this transaction, represented
  /// as seconds from the Unix Epoch. If the current blockchain timestamp
  /// is greater than or equal to this time, then the transaction has
  /// expired and will be discarded. This can be set to a large value far
  /// in the future to indicate that a transaction does not expire.
  final BigInt expirationTimestampSecs;

  /// Chain ID of the Aptos network this transaction is intended for.
  final int chainId;
  AptosRawTransaction(
      {required this.sender,
      required BigInt sequenceNumber,
      required this.transactionPayload,
      required BigInt maxGasAmount,
      required BigInt gasUnitPrice,
      required BigInt expirationTimestampSecs,
      required int chainId})
      : sequenceNumber = sequenceNumber.asUint64,
        maxGasAmount = maxGasAmount.asUint64,
        gasUnitPrice = gasUnitPrice.asUint64,
        expirationTimestampSecs = expirationTimestampSecs.asUint64,
        chainId = chainId.asUint8;
  factory AptosRawTransaction.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosRawTransaction.fromStruct(decode);
  }
  factory AptosRawTransaction.fromStruct(Map<String, dynamic> json) {
    return AptosRawTransaction(
        sender: AptosAddress.fromStruct(json.asMap("sender")),
        sequenceNumber: json.as("sequenceNumber"),
        transactionPayload: AptosTransactionPayload.fromStruct(
            json.asMap("transactionPayload")),
        maxGasAmount: json.as("maxGasAmount"),
        gasUnitPrice: json.as("gasUnitPrice"),
        expirationTimestampSecs: json.as("expirationTimestampSecs"),
        chainId: json.as("chainId"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosAddress.layout(property: "sender"),
      LayoutConst.u64(property: "sequenceNumber"),
      AptosTransactionPayload.layout(property: "transactionPayload"),
      LayoutConst.u64(property: "maxGasAmount"),
      LayoutConst.u64(property: "gasUnitPrice"),
      LayoutConst.u64(property: "expirationTimestampSecs"),
      LayoutConst.u8(property: "chainId"),
    ], property: property);
  }

  List<int> signingSerialize(
      {AptosAddress? feePayerAddress,
      List<AptosAddress>? secondarySignerAddresses}) {
    if (feePayerAddress != null) {
      final feePayerTx = AptosRawTransactionWithDataFeePayer(
          rawTransaction: this,
          secondarySignerAddresses: secondarySignerAddresses ?? [],
          feePayerAddress: feePayerAddress);
      return AptosTransactionUtils.generateSigningDigest(
          feePayerTx.toVariantBcs(),
          withData: true);
    } else if (secondarySignerAddresses != null) {
      final feePayerTx = AptosRawTransactionWithDataMultiAgent(
          rawTransaction: this,
          secondarySignerAddresses: secondarySignerAddresses);
      return AptosTransactionUtils.generateSigningDigest(
          feePayerTx.toVariantBcs(),
          withData: true);
    }
    return AptosTransactionUtils.generateSigningDigest(toBcs());
  }

  // List<int> asMultiAgentsigningSerialize() {
  //   return AptosTransactionUtils.generateMultiAgentDigest(this);
  // }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "sender": sender.toLayoutStruct(),
      "sequenceNumber": sequenceNumber,
      "transactionPayload": transactionPayload.toVariantLayoutStruct(),
      "maxGasAmount": maxGasAmount,
      "gasUnitPrice": gasUnitPrice,
      "expirationTimestampSecs": expirationTimestampSecs,
      "chainId": chainId,
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosRawTransaction) return false;
    return sender == other.sender &&
        sequenceNumber == other.sequenceNumber &&
        transactionPayload == other.transactionPayload &&
        maxGasAmount == other.maxGasAmount &&
        gasUnitPrice == other.gasUnitPrice &&
        expirationTimestampSecs == other.expirationTimestampSecs &&
        chainId == other.chainId;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([
        sender,
        sequenceNumber,
        transactionPayload,
        maxGasAmount,
        gasUnitPrice,
        expirationTimestampSecs,
        chainId
      ]);
}

abstract class AptosAnyTransaction extends BcsSerialization {
  const AptosAnyTransaction();
}

class AptosMultiAgentTransaction extends AptosAnyTransaction {
  final AptosRawTransaction rawTransaction;
  final List<AptosAddress> secondarySignerAddresses;
  final AptosAddress? feePayerAddress;

  AptosMultiAgentTransaction({
    required this.rawTransaction,
    required List<AptosAddress> secondarySignerAddresses,
    this.feePayerAddress,
  }) : secondarySignerAddresses = secondarySignerAddresses.immutable;

  factory AptosMultiAgentTransaction.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosMultiAgentTransaction.fromStruct(decode);
  }
  factory AptosMultiAgentTransaction.fromStruct(Map<String, dynamic> json) {
    return AptosMultiAgentTransaction(
        rawTransaction:
            AptosRawTransaction.fromStruct(json.asMap("rawTransaction")),
        secondarySignerAddresses: json
            .asListOfMap("secondarySignerAddresses")!
            .map((e) => AptosAddress.fromStruct(e))
            .toList(),
        feePayerAddress: json.mybeAs<AptosAddress, Map<String, dynamic>>(
            key: "feePayerAddress",
            onValue: (e) => AptosAddress.fromStruct(e)));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosRawTransaction.layout(property: "rawTransaction"),
      LayoutConst.bcsVector(AptosAddress.layout(),
          property: "secondarySignerAddresses"),
      LayoutConst.optional(AptosAddress.layout(), property: "feePayerAddress"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "rawTransaction": rawTransaction.toLayoutStruct(),
      "feePayerAddress": feePayerAddress?.toLayoutStruct(),
      "secondarySignerAddresses":
          secondarySignerAddresses.map((e) => e.toLayoutStruct()).toList()
    };
  }
}

class AptosSimpleTransaction extends AptosAnyTransaction {
  final AptosRawTransaction rawTransaction;
  final AptosAddress? feePayerAddress;

  AptosSimpleTransaction({required this.rawTransaction, this.feePayerAddress});

  factory AptosSimpleTransaction.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosSimpleTransaction.fromStruct(decode);
  }
  factory AptosSimpleTransaction.fromStruct(Map<String, dynamic> json) {
    return AptosSimpleTransaction(
        rawTransaction:
            AptosRawTransaction.fromStruct(json.asMap("rawTransaction")),
        feePayerAddress: json.mybeAs<AptosAddress, Map<String, dynamic>>(
            key: "feePayerAddress",
            onValue: (e) => AptosAddress.fromStruct(e)));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosRawTransaction.layout(property: "rawTransaction"),
      LayoutConst.optional(AptosAddress.layout(), property: "feePayerAddress"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "rawTransaction": rawTransaction.toLayoutStruct(),
      "feePayerAddress": feePayerAddress?.toLayoutStruct()
    };
  }
}

enum AptosTransactionAuthenticators {
  ed25519(value: 0),
  multiEd25519(value: 1),
  multiAgent(value: 2),
  feePayer(value: 3),
  singleSender(value: 4);

  final int value;
  const AptosTransactionAuthenticators({required this.value});
  static AptosTransactionAuthenticators fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartAptosPluginException(
            "cannot find correct transaction authenticator from the given name.",
            details: {"name": name}));
  }
}

abstract class AptosTransactionAuthenticator extends BcsVariantSerialization {
  final AptosTransactionAuthenticators type;
  const AptosTransactionAuthenticator({required this.type});
  factory AptosTransactionAuthenticator.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosTransactionAuthenticator.fromStruct(decode);
  }
  factory AptosTransactionAuthenticator.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = AptosTransactionAuthenticators.fromName(decode.variantName);
    return switch (type) {
      AptosTransactionAuthenticators.ed25519 =>
        AptosTransactionAuthenticatorEd25519.fromStruct(decode.value),
      AptosTransactionAuthenticators.multiEd25519 =>
        AptosTransactionAuthenticatorMultiEd25519.fromStruct(decode.value),
      AptosTransactionAuthenticators.multiAgent =>
        AptosTransactionAuthenticatorMultiAgent.fromStruct(decode.value),
      AptosTransactionAuthenticators.singleSender =>
        AptosTransactionAuthenticatorSignleSender.fromStruct(decode.value),
      AptosTransactionAuthenticators.feePayer =>
        AptosTransactionAuthenticatorFeePayer.fromStruct(decode.value),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: AptosTransactionAuthenticatorEd25519.layout,
          property: AptosTransactionAuthenticators.ed25519.name,
          index: AptosTransactionAuthenticators.ed25519.value),
      LazyVariantModel(
          layout: AptosTransactionAuthenticatorMultiEd25519.layout,
          property: AptosTransactionAuthenticators.multiEd25519.name,
          index: AptosTransactionAuthenticators.multiEd25519.value),
      LazyVariantModel(
          layout: AptosTransactionAuthenticatorMultiAgent.layout,
          property: AptosTransactionAuthenticators.multiAgent.name,
          index: AptosTransactionAuthenticators.multiAgent.value),
      LazyVariantModel(
          layout: AptosTransactionAuthenticatorSignleSender.layout,
          property: AptosTransactionAuthenticators.singleSender.name,
          index: AptosTransactionAuthenticators.singleSender.value),
      LazyVariantModel(
          layout: AptosTransactionAuthenticatorFeePayer.layout,
          property: AptosTransactionAuthenticators.feePayer.name,
          index: AptosTransactionAuthenticators.feePayer.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class AptosTransactionAuthenticatorEd25519
    extends AptosTransactionAuthenticator {
  final AptosED25519PublicKey publicKey;
  final AptosEd25519Signature signature;
  AptosTransactionAuthenticatorEd25519(
      {required this.publicKey, required this.signature})
      : super(type: AptosTransactionAuthenticators.ed25519);
  factory AptosTransactionAuthenticatorEd25519.fromStruct(
      Map<String, dynamic> json) {
    return AptosTransactionAuthenticatorEd25519(
        publicKey: AptosED25519PublicKey.fromStruct(json.asMap("publicKey")),
        signature: AptosEd25519Signature.fromStruct(json.asMap("signature")));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosED25519PublicKey.layout(property: "publicKey"),
      AptosEd25519Signature.layout(property: "signature"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "publicKey": publicKey.toLayoutStruct(),
      "signature": signature.toLayoutStruct()
    };
  }
}

class AptosTransactionAuthenticatorMultiEd25519
    extends AptosTransactionAuthenticator {
  final AptosMultiEd25519AccountPublicKey publicKey;
  final AptosMultiEd25519Signature signature;
  AptosTransactionAuthenticatorMultiEd25519(
      {required this.publicKey, required this.signature})
      : super(type: AptosTransactionAuthenticators.multiEd25519);
  factory AptosTransactionAuthenticatorMultiEd25519.fromStruct(
      Map<String, dynamic> json) {
    return AptosTransactionAuthenticatorMultiEd25519(
        publicKey: AptosMultiEd25519AccountPublicKey.fromStruct(
            json.asMap("publicKey")),
        signature:
            AptosMultiEd25519Signature.fromStruct(json.asMap("signature")));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosMultiEd25519AccountPublicKey.layout(property: "publicKey"),
      AptosMultiEd25519Signature.layout(property: "signature"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "publicKey": publicKey.toLayoutStruct(),
      "signature": signature.toLayoutStruct()
    };
  }
}

class AptosTransactionAuthenticatorMultiAgent
    extends AptosTransactionAuthenticator {
  final AptosAccountAuthenticator sender;
  final List<AptosAddress> secondarySignerAddressess;
  final List<AptosAccountAuthenticator> secondarySigner;
  AptosTransactionAuthenticatorMultiAgent({
    required this.sender,
    List<AptosAddress> secondarySignerAddressess = const [],
    List<AptosAccountAuthenticator> secondarySigner = const [],
  })  : secondarySignerAddressess = secondarySignerAddressess.toImutableList,
        secondarySigner = secondarySigner.toImutableList,
        super(type: AptosTransactionAuthenticators.multiAgent);
  factory AptosTransactionAuthenticatorMultiAgent.fromStruct(
      Map<String, dynamic> json) {
    return AptosTransactionAuthenticatorMultiAgent(
        sender: AptosAccountAuthenticator.fromStruct(json.asMap("sender")),
        secondarySignerAddressess: json
            .asListOfMap("secondarySignerAddressess")!
            .map((e) => AptosAddress.fromStruct(e))
            .toList(),
        secondarySigner: json
            .asListOfMap("secondarySigner")!
            .map((e) => AptosAccountAuthenticator.fromStruct(e))
            .toList());
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosAccountAuthenticator.layout(property: "sender"),
      LayoutConst.bcsVector(AptosAddress.layout(),
          property: "secondarySignerAddressess"),
      LayoutConst.bcsVector(AptosAccountAuthenticator.layout(),
          property: "secondarySigner"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "sender": sender.toVariantLayoutStruct(),
      "secondarySignerAddressess":
          secondarySignerAddressess.map((e) => e.toLayoutStruct()).toList(),
      "secondarySigner":
          secondarySigner.map((e) => e.toVariantLayoutStruct()).toList()
    };
  }
}

class AptosTransactionAuthenticatorFeePayer
    extends AptosTransactionAuthenticator {
  final AptosAccountAuthenticator sender;
  final List<AptosAddress> secondarySignerAddressess;
  final List<AptosAccountAuthenticator> secondarySigner;
  final AptosAddress feePayerAddress;
  final AptosAccountAuthenticator feePayerAuthenticator;
  AptosTransactionAuthenticatorFeePayer({
    required this.sender,
    List<AptosAddress> secondarySignerAddressess = const [],
    List<AptosAccountAuthenticator> secondarySigner = const [],
    required this.feePayerAddress,
    required this.feePayerAuthenticator,
  })  : secondarySignerAddressess = secondarySignerAddressess.toImutableList,
        secondarySigner = secondarySigner.toImutableList,
        super(type: AptosTransactionAuthenticators.feePayer);
  factory AptosTransactionAuthenticatorFeePayer.fromStruct(
      Map<String, dynamic> json) {
    return AptosTransactionAuthenticatorFeePayer(
        sender: AptosAccountAuthenticator.fromStruct(json.asMap("sender")),
        secondarySignerAddressess: json
            .asListOfMap("secondarySignerAddressess")!
            .map((e) => AptosAddress.fromStruct(e))
            .toList(),
        secondarySigner: json
            .asListOfMap("secondarySigner")!
            .map((e) => AptosAccountAuthenticator.fromStruct(e))
            .toList(),
        feePayerAddress: AptosAddress.fromStruct(json.asMap("feePayerAddress")),
        feePayerAuthenticator: AptosAccountAuthenticator.fromStruct(
            json.asMap("feePayerAuthenticator")));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosAccountAuthenticator.layout(property: "sender"),
      LayoutConst.bcsVector(AptosAddress.layout(),
          property: "secondarySignerAddressess"),
      LayoutConst.bcsVector(AptosAccountAuthenticator.layout(),
          property: "secondarySigner"),
      AptosAddress.layout(property: "feePayerAddress"),
      AptosAccountAuthenticator.layout(property: "feePayerAuthenticator"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "sender": sender.toVariantLayoutStruct(),
      "secondarySignerAddressess":
          secondarySignerAddressess.map((e) => e.toLayoutStruct()).toList(),
      "secondarySigner":
          secondarySigner.map((e) => e.toVariantLayoutStruct()).toList(),
      "feePayerAddress": feePayerAddress.toLayoutStruct(),
      "feePayerAuthenticator": feePayerAuthenticator.toVariantLayoutStruct(),
    };
  }
}

class AptosTransactionAuthenticatorSignleSender
    extends AptosTransactionAuthenticator {
  final AptosAccountAuthenticator sender;
  AptosTransactionAuthenticatorSignleSender(this.sender)
      : super(type: AptosTransactionAuthenticators.singleSender);
  factory AptosTransactionAuthenticatorSignleSender.fromStruct(
      Map<String, dynamic> json) {
    return AptosTransactionAuthenticatorSignleSender(
        AptosAccountAuthenticator.fromStruct(json.asMap("sender")));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosAccountAuthenticator.layout(property: "sender"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"sender": sender.toVariantLayoutStruct()};
  }
}

class AptosSignedTransaction extends BcsSerialization {
  final AptosRawTransaction rawTransaction;
  final AptosTransactionAuthenticator authenticator;

  const AptosSignedTransaction(
      {required this.rawTransaction, required this.authenticator});
  factory AptosSignedTransaction.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosSignedTransaction.fromStruct(decode);
  }
  factory AptosSignedTransaction.fromStruct(Map<String, dynamic> json) {
    return AptosSignedTransaction(
      rawTransaction:
          AptosRawTransaction.fromStruct(json.asMap("rawTransaction")),
      authenticator:
          AptosTransactionAuthenticator.fromStruct(json.asMap("authenticator")),
    );
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosRawTransaction.layout(property: "rawTransaction"),
      AptosTransactionAuthenticator.layout(property: "authenticator"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "rawTransaction": rawTransaction.toLayoutStruct(),
      "authenticator": authenticator.toVariantLayoutStruct()
    };
  }

  /// generate transaction hash
  String txHash() {
    return AptosTransactionUtils.generateTransactionHash(toBcs());
  }
}

class RotationProofChallenge extends BcsSerialization {
  static final AptosAddress accountAddress = AptosAddress.one;
  static final String moduleName = "account";
  static final String structName = "RotationProofChallenge";
  final BigInt sequenceNumber;
  final AptosAddress orginator;
  final AptosAddress currentAuthKey;
  final AptosPublicKey newPublicKey;

  factory RotationProofChallenge.fromStruct(Map<String, dynamic> json) {
    return RotationProofChallenge(
      sequenceNumber: json.as("sequenceNumber"),
      orginator: AptosAddress.fromStruct(json.asMap("orginator")),
      currentAuthKey: AptosAddress.fromStruct(json.asMap("currentAuthKey")),
      newPublicKey: json.asBytes("newPublicKey"),
    );
  }

  RotationProofChallenge(
      {required this.orginator,
      required this.currentAuthKey,
      required this.newPublicKey,
      required BigInt sequenceNumber})
      : sequenceNumber = sequenceNumber.asUint64;

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosAddress.layout(property: "accountAddress"),
      LayoutConst.bcsString(property: "moduleName"),
      LayoutConst.bcsString(property: "structName"),
      LayoutConst.u64(property: "sequenceNumber"),
      AptosAddress.layout(property: "orginator"),
      AptosAddress.layout(property: "currentAuthKey"),
      LayoutConst.bcsBytes(property: "newPublicKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "accountAddress": accountAddress.toLayoutStruct(),
      "moduleName": moduleName,
      "structName": structName,
      "orginator": orginator.toLayoutStruct(),
      "currentAuthKey": currentAuthKey.toLayoutStruct(),
      "newPublicKey": newPublicKey.toBytes(),
      "sequenceNumber": sequenceNumber
    };
  }
}

enum AptosRawTransactionType {
  multiAgentTransaction(value: 0),
  feePayerTransaction(value: 1);

  final int value;
  const AptosRawTransactionType({required this.value});
  static AptosRawTransactionType fromName(String? name) {
    return values.firstWhere((e) => e.name.toLowerCase() == name?.toLowerCase(),
        orElse: () => throw DartAptosPluginException(
            "cannot find correct raw transaction from the given name.",
            details: {"name": name}));
  }
}

abstract class AptosRawTransactionWithData extends BcsVariantSerialization {
  final AptosRawTransactionType type;
  const AptosRawTransactionWithData({required this.type});
  factory AptosRawTransactionWithData.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = AptosRawTransactionType.fromName(decode.variantName);
    return switch (type) {
      AptosRawTransactionType.multiAgentTransaction =>
        AptosRawTransactionWithDataMultiAgent.fromStruct(decode.value),
      AptosRawTransactionType.feePayerTransaction =>
        AptosRawTransactionWithDataFeePayer.fromStruct(decode.value)
    };
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: AptosRawTransactionWithDataMultiAgent.layout,
          property: AptosRawTransactionType.multiAgentTransaction.name,
          index: AptosRawTransactionType.multiAgentTransaction.value),
      LazyVariantModel(
          layout: AptosRawTransactionWithDataFeePayer.layout,
          property: AptosRawTransactionType.feePayerTransaction.name,
          index: AptosRawTransactionType.feePayerTransaction.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class AptosRawTransactionWithDataMultiAgent
    extends AptosRawTransactionWithData {
  final AptosRawTransaction rawTransaction;
  final List<AptosAddress> secondarySignerAddresses;

  AptosRawTransactionWithDataMultiAgent({
    required this.rawTransaction,
    required List<AptosAddress> secondarySignerAddresses,
  })  : secondarySignerAddresses = secondarySignerAddresses.immutable,
        super(type: AptosRawTransactionType.multiAgentTransaction);

  factory AptosRawTransactionWithDataMultiAgent.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosRawTransactionWithDataMultiAgent.fromStruct(decode);
  }
  factory AptosRawTransactionWithDataMultiAgent.fromStruct(
      Map<String, dynamic> json) {
    return AptosRawTransactionWithDataMultiAgent(
        rawTransaction:
            AptosRawTransaction.fromStruct(json.asMap("rawTransaction")),
        secondarySignerAddresses: json
            .asListOfMap("secondarySignerAddresses")!
            .map((e) => AptosAddress.fromStruct(e))
            .toList());
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosRawTransaction.layout(property: "rawTransaction"),
      LayoutConst.bcsVector(AptosAddress.layout(),
          property: "secondarySignerAddresses"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "rawTransaction": rawTransaction.toLayoutStruct(),
      "secondarySignerAddresses":
          secondarySignerAddresses.map((e) => e.toLayoutStruct()).toList()
    };
  }
}

class AptosRawTransactionWithDataFeePayer extends AptosRawTransactionWithData {
  final AptosRawTransaction rawTransaction;
  final List<AptosAddress> secondarySignerAddresses;
  final AptosAddress feePayerAddress;

  AptosRawTransactionWithDataFeePayer({
    required this.rawTransaction,
    required List<AptosAddress> secondarySignerAddresses,
    required this.feePayerAddress,
  })  : secondarySignerAddresses = secondarySignerAddresses.immutable,
        super(type: AptosRawTransactionType.feePayerTransaction);

  factory AptosRawTransactionWithDataFeePayer.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosRawTransactionWithDataFeePayer.fromStruct(decode);
  }
  factory AptosRawTransactionWithDataFeePayer.fromStruct(
      Map<String, dynamic> json) {
    return AptosRawTransactionWithDataFeePayer(
        rawTransaction:
            AptosRawTransaction.fromStruct(json.asMap("rawTransaction")),
        secondarySignerAddresses: json
            .asListOfMap("secondarySignerAddresses")!
            .map((e) => AptosAddress.fromStruct(e))
            .toList(),
        feePayerAddress:
            AptosAddress.fromStruct(json.asMap("feePayerAddress")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosRawTransaction.layout(property: "rawTransaction"),
      LayoutConst.bcsVector(AptosAddress.layout(),
          property: "secondarySignerAddresses"),
      AptosAddress.layout(property: "feePayerAddress")
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "rawTransaction": rawTransaction.toLayoutStruct(),
      "secondarySignerAddresses":
          secondarySignerAddresses.map((e) => e.toLayoutStruct()).toList(),
      "feePayerAddress": feePayerAddress.toLayoutStruct()
    };
  }
}

/// Represents the parameters required for an Aptos token transfer.
class AptosTransferParams {
  /// The amount of Aptos tokens to transfer, represented in the smallest unit (Octas).
  final BigInt apt;

  /// The destination address where the tokens will be sent.
  final AptosAddress destination;

  /// Determines whether the destination account should be created automatically if it does not exist.
  /// Defaults to `true`.
  final bool allowCreate;

  /// Creates an [AptosTransferParams] instance with a specified [apt] amount.
  ///
  /// - [apt]: The amount to transfer in Octas.
  /// - [destination]: The recipient's Aptos address.
  /// - [allowCreate]: If `true`, allows automatic creation of the destination account if needed.
  const AptosTransferParams.apt({
    required this.apt,
    required this.destination,
    this.allowCreate = true,
  });

  /// Factory constructor to create an [AptosTransferParams] instance from a human-readable Aptos amount.
  ///
  /// - [aptos]: The Aptos amount as a string (e.g., "1.5"), which will be converted to Octas.
  /// - [destination]: The recipient's Aptos address.
  /// - [allowCreate]: If `true`, allows automatic creation of the destination account if needed.
  factory AptosTransferParams.aptos({
    required String aptos,
    required AptosAddress destination,
    bool allowCreate = true,
  }) {
    return AptosTransferParams.apt(
        apt: AptosHelper.toApt(aptos),
        destination: destination,
        allowCreate: allowCreate);
  }
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/bcs/serialization.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/intent/intent.dart';
import 'package:on_chain/sui/src/utils/sui_helper.dart';
import 'package:on_chain/utils/utils/map_utils.dart';
import 'package:on_chain/sui/src/transaction/const/constant.dart';

class SuiObjectDigest extends BcsSerialization {
  final List<int> digest;
  SuiObjectDigest._(List<int> digest) : digest = digest.asImmutableBytes;
  factory SuiObjectDigest(List<int> digest) {
    if (digest.length != SuiTransactionConst.digestLength) {
      throw DartSuiPluginException("Invalid digest length.", details: {
        "expected": SuiTransactionConst.digestLength,
        "length": digest.length
      });
    }
    return SuiObjectDigest._(digest);
  }
  factory SuiObjectDigest.fromHex(String digestHex) {
    return SuiObjectDigest(BytesUtils.fromHexString(digestHex));
  }
  factory SuiObjectDigest.fromBase58(String digestHex) {
    return SuiObjectDigest(Base58Decoder.decode(digestHex));
  }
  factory SuiObjectDigest.fromStruct(Map<String, dynamic> json) {
    return SuiObjectDigest(json.asBytes("digest"));
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsBytes(property: "digest"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"digest": digest};
  }
}

class SuiObjectRef extends BcsSerialization {
  final SuiAddress address;
  final BigInt version;
  final SuiObjectDigest digest;
  SuiObjectRef(
      {required this.address, required BigInt version, required this.digest})
      : version = version.asUint64;
  factory SuiObjectRef.fromStruct(Map<String, dynamic> json) {
    return SuiObjectRef(
        address: SuiAddress.fromStruct(json.asMap("address")),
        version: json.as("version"),
        digest: SuiObjectDigest.fromStruct(json.asMap("digest")));
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiAddress.layout(property: "address"),
      LayoutConst.u64(property: "version"),
      SuiObjectDigest.layout(property: "digest")
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
      "version": version,
      "digest": digest.toLayoutStruct()
    };
  }
}

class SuiStructInput extends BcsSerialization {
  final SuiAddress address;
  final String module;
  final String name;
  final List<SuiTypeInput> typeParams;
  SuiStructInput(
      {required this.address,
      required this.module,
      required this.name,
      required List<SuiTypeInput> typeParams})
      : typeParams = typeParams.immutable;

  factory SuiStructInput.fromStruct(Map<String, dynamic> json) {
    return SuiStructInput(
        address: SuiAddress.fromStruct(json.asMap("address")),
        module: json.as("module"),
        name: json.as("name"),
        typeParams: json
            .asListOfMap("type_params")!
            .map((e) => SuiTypeInput.fromStruct(e))
            .toList());
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiAddress.layout(property: "address"),
      LayoutConst.bcsString(property: 'module'),
      LayoutConst.bcsString(property: 'name'),
      LayoutConst.bcsVector(SuiTypeInput.layout(), property: 'type_params')
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "type_params": typeParams.map((e) => e.toVariantLayoutStruct()).toList(),
      "name": name,
      "module": module,
      "address": address.toLayoutStruct()
    };
  }
}

enum SuiTypeInputs {
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
  u256(value: 10);

  const SuiTypeInputs({required this.value});
  final int value;
  bool get isPrimitive {
    return switch (this) {
      SuiTypeInputs.signer ||
      SuiTypeInputs.address ||
      SuiTypeInputs.vector ||
      SuiTypeInputs.struct =>
        false,
      _ => true
    };
  }

  static SuiTypeInputs? find(String? name) {
    if (name == 'bool') {
      return SuiTypeInputs.boolean;
    }
    return values
        .firstWhereNullable((e) => e.name.toLowerCase() == name?.toLowerCase());
  }

  static SuiTypeInputs fromName(String name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct typeInputs from the given name.",
            details: {"name": name}));
  }
}

abstract class SuiTypeInput extends BcsVariantSerialization {
  final SuiTypeInputs type;
  const SuiTypeInput({required this.type});
  factory SuiTypeInput.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = SuiTypeInputs.fromName(decode.variantName);
    return switch (type) {
      SuiTypeInputs.boolean ||
      SuiTypeInputs.u8 ||
      SuiTypeInputs.u32 ||
      SuiTypeInputs.u64 ||
      SuiTypeInputs.u128 ||
      SuiTypeInputs.u16 ||
      SuiTypeInputs.u256 =>
        SuiTypeInputPrimitive(type),
      SuiTypeInputs.signer => SuiTypeInputSigner(),
      SuiTypeInputs.address => SuiTypeInputAddress(),
      SuiTypeInputs.vector => SuiTypeInputVector.fromStruct(decode.value),
      SuiTypeInputs.struct => SuiTypeInputStruct.fromStruct(decode.value)
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiTypeInputPrimitive.layout,
          property: SuiTypeInputs.boolean.name,
          index: SuiTypeInputs.boolean.value),
      LazyVariantModel(
          layout: SuiTypeInputPrimitive.layout,
          property: SuiTypeInputs.u8.name,
          index: SuiTypeInputs.u8.value),
      LazyVariantModel(
          layout: SuiTypeInputPrimitive.layout,
          property: SuiTypeInputs.u64.name,
          index: SuiTypeInputs.u64.value),
      LazyVariantModel(
          layout: SuiTypeInputPrimitive.layout,
          property: SuiTypeInputs.u128.name,
          index: SuiTypeInputs.u128.value),
      LazyVariantModel(
          layout: SuiTypeInputPrimitive.layout,
          property: SuiTypeInputs.u16.name,
          index: SuiTypeInputs.u16.value),
      LazyVariantModel(
          layout: SuiTypeInputPrimitive.layout,
          property: SuiTypeInputs.u32.name,
          index: SuiTypeInputs.u32.value),
      LazyVariantModel(
          layout: SuiTypeInputPrimitive.layout,
          property: SuiTypeInputs.u256.name,
          index: SuiTypeInputs.u256.value),
      LazyVariantModel(
          layout: SuiTypeInputAddress.layout,
          property: SuiTypeInputs.address.name,
          index: SuiTypeInputs.address.value),
      LazyVariantModel(
          layout: SuiTypeInputSigner.layout,
          property: SuiTypeInputs.signer.name,
          index: SuiTypeInputs.signer.value),
      LazyVariantModel(
          layout: SuiTypeInputVector.layout,
          property: SuiTypeInputs.vector.name,
          index: SuiTypeInputs.vector.value),
      LazyVariantModel(
          layout: SuiTypeInputStruct.layout,
          property: SuiTypeInputs.struct.name,
          index: SuiTypeInputs.struct.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class SuiTypeInputPrimitive extends SuiTypeInput {
  const SuiTypeInputPrimitive._(SuiTypeInputs type) : super(type: type);
  factory SuiTypeInputPrimitive(SuiTypeInputs type) {
    if (!type.isPrimitive) {
      throw DartSuiPluginException("Invalid primitive type.",
          details: {"type": type.name});
    }
    return SuiTypeInputPrimitive._(type);
  }

  static StructLayout layout({String? property}) {
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
}

class SuiTypeInputAddress extends SuiTypeInput {
  const SuiTypeInputAddress() : super(type: SuiTypeInputs.address);

  static StructLayout layout({String? property}) {
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
}

class SuiTypeInputSigner extends SuiTypeInput {
  const SuiTypeInputSigner() : super(type: SuiTypeInputs.signer);

  static StructLayout layout({String? property}) {
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
}

class SuiTypeInputVector extends SuiTypeInput {
  final SuiTypeInput inputType;
  const SuiTypeInputVector(this.inputType) : super(type: SuiTypeInputs.vector);
  factory SuiTypeInputVector.fromStruct(Map<String, dynamic> json) {
    return SuiTypeInputVector(SuiTypeInput.fromStruct(json.asMap("inputType")));
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([SuiTypeInput.layout(property: "inputType")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"inputType": inputType.toVariantLayoutStruct()};
  }
}

class SuiTypeInputStruct extends SuiTypeInput {
  final SuiStructInput inputType;
  const SuiTypeInputStruct(this.inputType) : super(type: SuiTypeInputs.struct);
  factory SuiTypeInputStruct.fromStruct(Map<String, dynamic> json) {
    return SuiTypeInputStruct(
        SuiStructInput.fromStruct(json.asMap("inputType")));
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([SuiStructInput.layout(property: "inputType")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"inputType": inputType.toLayoutStruct()};
  }
}

/// An argument to a programmable transaction command
enum SuiArguments {
  /// The gas coin. The gas coin can only be used by-ref, except for with
  /// `TransferObjects`, which can use it by-value.
  gasCoin(value: 0),

  /// One of the input objects or primitive values (from
  /// `ProgrammableTransaction` inputs)
  input(value: 1),

  /// The result of another command (from `ProgrammableTransaction` commands)
  result(value: 2),

  /// Like a `TronResult` but it accesses a nested result. Currently, the only usage
  /// of this is to access a value from a Move call with multiple return values.
  nestedResult(value: 3);

  final int value;
  const SuiArguments({required this.value});

  static SuiArguments fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct Arguments from the given name.",
            details: {"name": name}));
  }
}

abstract class SuiArgument extends BcsVariantSerialization {
  final SuiArguments type;
  const SuiArgument({required this.type});
  factory SuiArgument.deserialize(List<int> bytes, {String? property}) {
    final decode = BcsSerialization.deserialize(
        bytes: bytes, layout: layout(property: property));
    return SuiArgument.fromStruct(decode);
  }
  factory SuiArgument.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = SuiArguments.fromName(decode.variantName);
    return switch (type) {
      SuiArguments.gasCoin => SuiArgumentGasCoin.fromStruct(decode.value),
      SuiArguments.input => SuiArgumentInput.fromStruct(decode.value),
      SuiArguments.result => SuiArgumentResult.fromStruct(decode.value),
      SuiArguments.nestedResult =>
        SuiArgumentNestedResult.fromStruct(decode.value),
    };
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiArgumentGasCoin.layout,
          property: SuiArguments.gasCoin.name,
          index: SuiArguments.gasCoin.value),
      LazyVariantModel(
          layout: SuiArgumentInput.layout,
          property: SuiArguments.input.name,
          index: SuiArguments.input.value),
      LazyVariantModel(
          layout: SuiArgumentResult.layout,
          property: SuiArguments.result.name,
          index: SuiArguments.result.value),
      LazyVariantModel(
          layout: SuiArgumentNestedResult.layout,
          property: SuiArguments.nestedResult.name,
          index: SuiArguments.nestedResult.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class SuiArgumentGasCoin extends SuiArgument {
  SuiArgumentGasCoin() : super(type: SuiArguments.gasCoin);
  factory SuiArgumentGasCoin.fromStruct(Map<String, dynamic> json) {
    return SuiArgumentGasCoin();
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }
}

class SuiArgumentInput extends SuiArgument {
  final int input;
  SuiArgumentInput(int input)
      : input = input.asUint16,
        super(type: SuiArguments.input);
  factory SuiArgumentInput.fromStruct(Map<String, dynamic> json) {
    return SuiArgumentInput(json.as("input"));
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([LayoutConst.u16(property: "input")],
        property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"input": input};
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }
}

class SuiArgumentResult extends SuiArgument {
  final int result;
  SuiArgumentResult(int result)
      : result = result.asUint16,
        super(type: SuiArguments.result);

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([LayoutConst.u16(property: "result")],
        property: property);
  }

  factory SuiArgumentResult.fromStruct(Map<String, dynamic> json) {
    return SuiArgumentResult(json.as("result"));
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"result": result};
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }
}

class SuiArgumentNestedResult extends SuiArgument {
  final int commandIndex;
  final int resultIndex;
  SuiArgumentNestedResult({required int commandIndex, required int resultIndex})
      : commandIndex = commandIndex.asUint16,
        resultIndex = resultIndex.asUint16,
        super(type: SuiArguments.nestedResult);

  factory SuiArgumentNestedResult.fromStruct(Map<String, dynamic> json) {
    return SuiArgumentNestedResult(
        commandIndex: json.as("commandIndex"),
        resultIndex: json.as("resultIndex"));
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u16(property: "commandIndex"),
      LayoutConst.u16(property: "resultIndex"),
    ], property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"commandIndex": commandIndex, "resultIndex": resultIndex};
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }
}

class SuiGasData extends BcsSerialization {
  final List<SuiObjectRef> payment;
  final SuiAddress owner;
  final BigInt price;
  final BigInt budget;
  SuiGasData copyWith(
      {List<SuiObjectRef>? payment,
      SuiAddress? owner,
      BigInt? price,
      BigInt? budget}) {
    return SuiGasData(
      payment: payment ?? this.payment,
      owner: owner ?? this.owner,
      price: price ?? this.price,
      budget: budget ?? this.budget,
    );
  }

  SuiGasData(
      {required List<SuiObjectRef> payment,
      required this.owner,
      required BigInt price,
      required BigInt budget})
      : payment = payment.immutable,
        price = price.asUint64,
        budget = budget.asUint64;
  factory SuiGasData.fromStruct(Map<String, dynamic> json) {
    return SuiGasData(
        payment: json
            .asListOfMap("payment")!
            .map((e) => SuiObjectRef.fromStruct(e))
            .toList(),
        owner: SuiAddress.fromStruct(json.asMap("owner")),
        price: json.as("price"),
        budget: json.as("budget"));
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(SuiObjectRef.layout(), property: "payment"),
      SuiAddress.layout(property: "owner"),
      LayoutConst.u64(property: "price"),
      LayoutConst.u64(property: "budget"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "payment": payment.map((e) => e.toLayoutStruct()).toList(),
      "owner": owner.toLayoutStruct(),
      "price": price,
      "budget": budget
    };
  }
}

/// The command for calling a Move function, either an entry function or a public
/// function (which cannot return references).
class SuiProgrammableMoveCall extends BcsSerialization {
  /// The package containing the module and function.
  final SuiAddress package;

  /// The specific module in the package containing the function.
  final String module;

  /// The function to be called.
  final String function;

  /// The type arguments to the function.
  final List<SuiTypeInput> typeArguments;

  /// The arguments to the function.
  final List<SuiArgument> arguments;
  SuiProgrammableMoveCall(
      {required this.package,
      required this.module,
      required this.function,
      List<SuiTypeInput> typeArguments = const [],
      required List<SuiArgument> arguments})
      : typeArguments = typeArguments.immutable,
        arguments = arguments.immutable;
  factory SuiProgrammableMoveCall.fromStruct(Map<String, dynamic> json) {
    return SuiProgrammableMoveCall(
        package: SuiAddress.fromStruct(json.asMap("package")),
        module: json.as("module"),
        function: json.as("function"),
        typeArguments: json
            .asListOfMap("type_arguments")!
            .map((e) => SuiTypeInput.fromStruct(e))
            .toList(),
        arguments: json
            .asListOfMap("arguments")!
            .map((e) => SuiArgument.fromStruct(e))
            .toList());
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiAddress.layout(property: "package"),
      LayoutConst.bcsString(property: "module"),
      LayoutConst.bcsString(property: "function"),
      LayoutConst.bcsVector(SuiTypeInput.layout(), property: "type_arguments"),
      LayoutConst.bcsVector(SuiArgument.layout(), property: "arguments"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "package": package.toLayoutStruct(),
      "module": module,
      "function": function,
      "type_arguments":
          typeArguments.map((e) => e.toVariantLayoutStruct()).toList(),
      "arguments": arguments.map((e) => e.toVariantLayoutStruct()).toList()
    };
  }
}

/// A single command in a programmable transaction.
enum SuiCommands {
  /// A call to either an entry or a public Move function
  moveCall(value: 0),

  /// It sends n-objects to the specified address. These objects must have store
  /// (public transfer) and either the previous owner must be an address or the object must
  /// be newly created.
  transferObject(value: 1),

  /// It splits off some amounts into a new coins with those amounts
  splitCoins(value: 2),

  /// It merges n-coins into the first coin
  mergeCoins(value: 3),

  /// dependencies to link against on-chain.
  publish(value: 4),

  /// Given n-values of the same type, it constructs a vector. For non objects or an empty vector,
  /// the type tag must be specified.
  makeMoveVec(value: 5),

  /// Upgrades a Move package
  /// Takes (in order):
  /// 1. A vector of serialized modules for the package.
  /// 2. A vector of object ids for the transitive dependencies of the new package.
  /// 3. The object ID of the package being upgraded.
  /// 4. An argument holding the `UpgradeTicket` that must have been produced from an earlier command in the same
  ///    programmable transaction.
  upgrade(value: 6);

  final int value;
  const SuiCommands({required this.value});
  static SuiCommands fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct Commands from the given name.",
            details: {"name": name}));
  }
}

abstract class SuiCommand extends BcsVariantSerialization {
  final SuiCommands type;
  const SuiCommand({required this.type});
  @override
  String get variantName => type.name;
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiCommandMoveCall.layout,
          property: SuiCommands.moveCall.name,
          index: SuiCommands.moveCall.value),
      LazyVariantModel(
          layout: SuiCommandTransferObjects.layout,
          property: SuiCommands.transferObject.name,
          index: SuiCommands.transferObject.value),
      LazyVariantModel(
          layout: SuiCommandSplitCoins.layout,
          property: SuiCommands.splitCoins.name,
          index: SuiCommands.splitCoins.value),
      LazyVariantModel(
          layout: SuiCommandMergeCoins.layout,
          property: SuiCommands.mergeCoins.name,
          index: SuiCommands.mergeCoins.value),
      LazyVariantModel(
          layout: SuiCommandPublish.layout,
          property: SuiCommands.publish.name,
          index: SuiCommands.publish.value),
      LazyVariantModel(
          layout: SuiCommandMakeMoveVec.layout,
          property: SuiCommands.makeMoveVec.name,
          index: SuiCommands.makeMoveVec.value),
      LazyVariantModel(
          layout: SuiCommandUpgrade.layout,
          property: SuiCommands.upgrade.name,
          index: SuiCommands.upgrade.value),
    ], property: property);
  }

  factory SuiCommand.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = SuiCommands.fromName(decode.variantName);
    return switch (type) {
      SuiCommands.moveCall => SuiCommandMoveCall.fromStruct(decode.value),
      SuiCommands.transferObject =>
        SuiCommandTransferObjects.fromStruct(decode.value),
      SuiCommands.splitCoins => SuiCommandSplitCoins.fromStruct(decode.value),
      SuiCommands.mergeCoins => SuiCommandMergeCoins.fromStruct(decode.value),
      SuiCommands.publish => SuiCommandPublish.fromStruct(decode.value),
      SuiCommands.makeMoveVec => SuiCommandMakeMoveVec.fromStruct(decode.value),
      SuiCommands.upgrade => SuiCommandUpgrade.fromStruct(decode.value),
    };
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }
}

class SuiCommandMoveCall extends SuiCommand {
  /// A call to either an entry or a public Move function
  final SuiProgrammableMoveCall moveCall;
  const SuiCommandMoveCall(this.moveCall) : super(type: SuiCommands.moveCall);
  factory SuiCommandMoveCall.fromStruct(Map<String, dynamic> json) {
    return SuiCommandMoveCall(
        SuiProgrammableMoveCall.fromStruct(json.asMap("moveCall")));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiProgrammableMoveCall.layout(property: "moveCall"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"moveCall": moveCall.toLayoutStruct()};
  }
}

/// It sends n-objects to the specified address. These objects must have store
/// (public transfer) and either the previous owner must be an address or the object must
/// be newly created.
class SuiCommandTransferObjects extends SuiCommand {
  final List<SuiArgument> objects;
  final SuiArgument address;
  SuiCommandTransferObjects(
      {required List<SuiArgument> objects, required this.address})
      : objects = objects.immutable,
        super(type: SuiCommands.transferObject);
  factory SuiCommandTransferObjects.fromStruct(Map<String, dynamic> json) {
    return SuiCommandTransferObjects(
        objects: json
            .asListOfMap("objects")!
            .map((e) => SuiArgument.fromStruct(e))
            .toList(),
        address: SuiArgument.fromStruct(json.asMap("address")));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(SuiArgument.layout(), property: "objects"),
      SuiArgument.layout(property: "address")
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "objects": objects.map((e) => e.toVariantLayoutStruct()).toList(),
      "address": address.toVariantLayoutStruct()
    };
  }
}

/// It splits off some amounts into a new coins with those amounts
class SuiCommandSplitCoins extends SuiCommand {
  final SuiArgument coin;
  final List<SuiArgument> amounts;

  SuiCommandSplitCoins({required List<SuiArgument> amounts, required this.coin})
      : amounts = amounts.immutable,
        super(type: SuiCommands.splitCoins);
  factory SuiCommandSplitCoins.fromStruct(Map<String, dynamic> json) {
    return SuiCommandSplitCoins(
        amounts: json
            .asListOfMap("amounts")!
            .map((e) => SuiArgument.fromStruct(e))
            .toList(),
        coin: SuiArgument.fromStruct(json.asMap("coin")));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiArgument.layout(property: "coin"),
      LayoutConst.bcsVector(SuiArgument.layout(), property: "amounts"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "amounts": amounts.map((e) => e.toVariantLayoutStruct()).toList(),
      "coin": coin.toVariantLayoutStruct()
    };
  }
}

/// It merges n-coins into the first coin
class SuiCommandMergeCoins extends SuiCommand {
  final SuiArgument destination;
  final List<SuiArgument> sources;

  SuiCommandMergeCoins(
      {required List<SuiArgument> sources, required this.destination})
      : sources = sources.immutable,
        super(type: SuiCommands.mergeCoins);
  factory SuiCommandMergeCoins.fromStruct(Map<String, dynamic> json) {
    return SuiCommandMergeCoins(
        sources: json
            .asListOfMap("sources")!
            .map((e) => SuiArgument.fromStruct(e))
            .toList(),
        destination: SuiArgument.fromStruct(json.asMap("destination")));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiArgument.layout(property: "destination"),
      LayoutConst.bcsVector(SuiArgument.layout(), property: "sources"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "sources": sources.map((e) => e.toVariantLayoutStruct()).toList(),
      "destination": destination.toVariantLayoutStruct()
    };
  }
}

/// Publishes a Move package. It takes the package bytes and a list of the package's transitive
/// dependencies to link against on-chain.
class SuiCommandPublish extends SuiCommand {
  final List<List<int>> modules;
  final List<SuiAddress> dependencies;

  SuiCommandPublish(
      {required List<List<int>> modules,
      required List<SuiAddress> dependencies})
      : modules = modules.map((e) => e.asImmutableBytes).toImutableList,
        dependencies = dependencies.immutable,
        super(type: SuiCommands.publish);
  factory SuiCommandPublish.fromStruct(Map<String, dynamic> json) {
    return SuiCommandPublish(
        modules: json.asListOfBytes("modules")!,
        dependencies: json
            .asListOfMap("dependencies")!
            .map((e) => SuiAddress.fromStruct(e))
            .toList());
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(LayoutConst.bcsBytes(), property: "modules"),
      LayoutConst.bcsVector(SuiAddress.layout(), property: "dependencies"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "dependencies": dependencies.map((e) => e.toLayoutStruct()).toList(),
      "modules": modules
    };
  }
}

/// Given n-values of the same type, it constructs a vector. For non objects or an empty vector,
/// the type tag must be specified.
class SuiCommandMakeMoveVec extends SuiCommand {
  final SuiTypeInput? typeInput;
  final List<SuiArgument> elements;

  SuiCommandMakeMoveVec(
      {required this.typeInput, required List<SuiArgument> elements})
      : elements = elements.immutable,
        super(type: SuiCommands.makeMoveVec);
  factory SuiCommandMakeMoveVec.fromStruct(Map<String, dynamic> json) {
    return SuiCommandMakeMoveVec(
        typeInput: json.mybeAs<SuiTypeInput, Map<String, dynamic>>(
          key: "typeInput",
          onValue: (e) => SuiTypeInput.fromStruct(e),
        ),
        elements: json
            .asListOfMap("elements")!
            .map((e) => SuiArgument.fromStruct(e))
            .toList());
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.optional(SuiTypeInput.layout(), property: "typeInput"),
      LayoutConst.bcsVector(SuiArgument.layout(), property: "elements"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "elements": elements.map((e) => e.toVariantLayoutStruct()).toList(),
      "typeInput": typeInput?.toVariantLayoutStruct()
    };
  }
}

/// Upgrades a Move package
class SuiCommandUpgrade extends SuiCommand {
  /// A vector of serialized modules for the package.
  final List<List<int>> modules;

  /// A vector of object ids for the transitive dependencies of the new package.
  final List<SuiAddress> dependencies;

  /// The object ID of the package being upgraded.
  final SuiAddress package;

  /// An argument holding the `UpgradeTicket` that must have been produced from an earlier command in the same
  /// programmable transaction.
  final SuiArgument ticket;
  SuiCommandUpgrade(
      {required List<List<int>> modules,
      required List<SuiAddress> dependencies,
      required this.package,
      required this.ticket})
      : modules = modules.map((e) => e.asImmutableBytes).toImutableList,
        dependencies = dependencies.immutable,
        super(type: SuiCommands.upgrade);
  factory SuiCommandUpgrade.fromStruct(Map<String, dynamic> json) {
    return SuiCommandUpgrade(
        modules: json.asListOfBytes("modules")!,
        dependencies: json
            .asListOfMap("dependencies")!
            .map((e) => SuiAddress.fromStruct(e))
            .toList(),
        package: SuiAddress.fromStruct(json.asMap("package")),
        ticket: SuiArgument.fromStruct(json.asMap("ticket")));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(LayoutConst.bcsBytes(), property: "modules"),
      LayoutConst.bcsVector(SuiAddress.layout(), property: "dependencies"),
      SuiAddress.layout(property: "package"),
      SuiArgument.layout(property: "ticket"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "modules": modules,
      "dependencies": dependencies.map((e) => e.toLayoutStruct()).toList(),
      "package": package.toLayoutStruct(),
      "ticket": ticket.toVariantLayoutStruct()
    };
  }
}

enum SuiObjectArgs {
  /// A Move object from fastpath.
  immOrOwnedObject(value: 0),

  /// A Move object from consensus (historically consensus objects were always shared).
  /// SharedObject::mutable controls whether caller asks for a mutable reference to shared object.
  sharedObject(value: 1),

  /// A Move object that can be received in this transaction.
  receiving(value: 2);

  const SuiObjectArgs({required this.value});
  final int value;
  static SuiObjectArgs fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct ObjectArgs from the given name.",
            details: {"name": name}));
  }
}

abstract class SuiObjectArg extends BcsVariantSerialization {
  final SuiObjectArgs type;
  const SuiObjectArg({required this.type});
  factory SuiObjectArg.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = SuiObjectArgs.fromName(decode.variantName);
    return switch (type) {
      SuiObjectArgs.immOrOwnedObject =>
        SuiObjectArgImmOrOwnedObject.fromStruct(decode.value),
      SuiObjectArgs.sharedObject =>
        SuiObjectArgSharedObject.fromStruct(decode.value),
      SuiObjectArgs.receiving => SuiObjectArgReceiving.fromStruct(decode.value)
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiObjectArgImmOrOwnedObject.layout,
          property: SuiObjectArgs.immOrOwnedObject.name,
          index: SuiObjectArgs.immOrOwnedObject.value),
      LazyVariantModel(
          layout: SuiObjectArgSharedObject.layout,
          property: SuiObjectArgs.sharedObject.name,
          index: SuiObjectArgs.sharedObject.value),
      LazyVariantModel(
          layout: SuiObjectArgReceiving.layout,
          property: SuiObjectArgs.receiving.name,
          index: SuiObjectArgs.receiving.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
  T cast<T extends SuiObjectArg>() {
    if (this is! T) {
      throw DartSuiPluginException("Object arg casting failed.",
          details: {"expected": "$T", "arg": type.name});
    }
    return this as T;
  }
}

/// A Move object from fastpath.
class SuiObjectArgImmOrOwnedObject extends SuiObjectArg {
  final SuiObjectRef immOrOwnedObject;

  SuiObjectArgImmOrOwnedObject(this.immOrOwnedObject)
      : super(type: SuiObjectArgs.immOrOwnedObject);
  factory SuiObjectArgImmOrOwnedObject.fromStruct(Map<String, dynamic> json) {
    return SuiObjectArgImmOrOwnedObject(
        SuiObjectRef.fromStruct(json.asMap("immOrOwnedObject")));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct(
        [SuiObjectRef.layout(property: "immOrOwnedObject")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"immOrOwnedObject": immOrOwnedObject.toLayoutStruct()};
  }
}

/// A Move object from consensus (historically consensus objects were always shared).
/// SharedObject::mutable controls whether caller asks for a mutable reference to shared object.
class SuiObjectArgSharedObject extends SuiObjectArg {
  final SuiAddress id;
  final BigInt initialSharedVersion;
  final bool mutable;

  SuiObjectArgSharedObject(
      {required this.id,
      required BigInt initialSharedVersion,
      required this.mutable})
      : initialSharedVersion = initialSharedVersion.asUint64,
        super(type: SuiObjectArgs.sharedObject);
  factory SuiObjectArgSharedObject.fromStruct(Map<String, dynamic> json) {
    return SuiObjectArgSharedObject(
        id: SuiAddress.fromStruct(json.asMap("id")),
        initialSharedVersion: json.as("initialSharedVersion"),
        mutable: json.as("mutable"));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiAddress.layout(property: "id"),
      LayoutConst.u64(property: "initialSharedVersion"),
      LayoutConst.boolean(property: "mutable"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "id": id.toLayoutStruct(),
      "initialSharedVersion": initialSharedVersion,
      "mutable": mutable
    };
  }
}

/// A Move object that can be received in this transaction.
class SuiObjectArgReceiving extends SuiObjectArg {
  final SuiObjectRef receiving;

  SuiObjectArgReceiving(this.receiving) : super(type: SuiObjectArgs.receiving);
  factory SuiObjectArgReceiving.fromStruct(Map<String, dynamic> json) {
    return SuiObjectArgReceiving(
        SuiObjectRef.fromStruct(json.asMap("receiving")));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([SuiObjectRef.layout(property: "receiving")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"receiving": receiving.toLayoutStruct()};
  }
}

enum SuiCallArgs {
  /// contains no structs or objects
  pure(value: 0),

  /// an object
  object(value: 1);

  const SuiCallArgs({required this.value});
  final int value;
  static SuiCallArgs fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct CallArgs from the given name.",
            details: {"name": name}));
  }
}

abstract class SuiCallArg<T> extends BcsVariantSerialization
    implements SuiCallArguments<T> {
  final SuiCallArgs type;
  const SuiCallArg({required this.type});
  factory SuiCallArg.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = SuiCallArgs.fromName(decode.variantName);
    final arg = switch (type) {
      SuiCallArgs.pure => SuiCallArgPure.fromStruct(decode.value),
      SuiCallArgs.object => SuiCallArgObject.fromStruct(decode.value)
    };
    if (arg is! SuiCallArg<T>) {
      throw DartSuiPluginException("Invalid argument.",
          details: {"excpected": "$T", "arg": arg.runtimeType});
    }
    return arg;
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiCallArgPure.layout,
          property: SuiCallArgs.pure.name,
          index: SuiCallArgs.pure.value),
      LazyVariantModel(
          layout: SuiCallArgObject.layout,
          property: SuiCallArgs.object.name,
          index: SuiCallArgs.object.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
  E cast<E extends SuiCallArg>() {
    if (this is! T) {
      throw DartSuiPluginException("CallArg casting failed.",
          details: {"expected": "$T", "arg": type.name});
    }
    return this as E;
  }
}

class SuiCallArgPure extends SuiCallArg<List<int>> {
  final List<int> bytes;

  SuiCallArgPure(List<int> bytes)
      : bytes = bytes.asImmutableBytes,
        super(type: SuiCallArgs.pure);
  factory SuiCallArgPure.fromStruct(Map<String, dynamic> json) {
    return SuiCallArgPure(json.asBytes("bytes"));
  }
  factory SuiCallArgPure.string(String value) {
    return SuiCallArgPure(LayoutConst.bcsString().serialize(value));
  }
  factory SuiCallArgPure.u64(BigInt num) {
    return SuiCallArgPure(LayoutConst.u64().serialize(num));
  }
  factory SuiCallArgPure.u16(int num) {
    return SuiCallArgPure(LayoutConst.u16().serialize(num));
  }
  factory SuiCallArgPure.u32(int num) {
    return SuiCallArgPure(LayoutConst.u32().serialize(num));
  }
  factory SuiCallArgPure.u128(BigInt num) {
    return SuiCallArgPure(LayoutConst.u128().serialize(num));
  }
  factory SuiCallArgPure.u256(BigInt num) {
    return SuiCallArgPure(LayoutConst.u256().serialize(num));
  }
  factory SuiCallArgPure.bytes(List<int> bytes) {
    return SuiCallArgPure(LayoutConst.bcsBytes().serialize(bytes));
  }
  factory SuiCallArgPure.boolean(bool cond) {
    return SuiCallArgPure(LayoutConst.boolean().serialize(cond));
  }
  factory SuiCallArgPure.address(SuiAddress address) {
    return SuiCallArgPure(address.toBytes());
  }
  factory SuiCallArgPure.sui(String suiAmount) {
    return SuiCallArgPure.u64(SuiHelper.toMist(suiAmount));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([LayoutConst.bcsBytes(property: "bytes")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"bytes": bytes};
  }

  @override
  List<int> get value => bytes;
}

class SuiCallArgObject extends SuiCallArg<SuiObjectArg> {
  final SuiObjectArg object;

  SuiCallArgObject(this.object) : super(type: SuiCallArgs.object);
  factory SuiCallArgObject.fromStruct(Map<String, dynamic> json) {
    return SuiCallArgObject(SuiObjectArg.fromStruct(json.asMap("object")));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([SuiObjectArg.layout(property: "object")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"object": object.toVariantLayoutStruct()};
  }

  @override
  SuiObjectArg get value => object;
}

/// A series of commands where the results of one command can be used in future
/// commands
class SuiProgrammableTransaction extends BcsSerialization {
  /// Input objects or primitive values
  final List<SuiCallArguments> inputs;

  /// The commands to be executed sequentially. A failure in any command will
  /// result in the failure of the entire transaction.
  final List<SuiCommand> commands;
  SuiProgrammableTransaction(
      {required List<SuiCallArguments> inputs,
      required List<SuiCommand> commands})
      : inputs = inputs.immutable,
        commands = commands.immutable;
  factory SuiProgrammableTransaction.fromStruct(Map<String, dynamic> json) {
    return SuiProgrammableTransaction(
      inputs: json
          .asListOfMap("inputs")!
          .map((e) => SuiCallArg.fromStruct(e))
          .toList(),
      commands: json
          .asListOfMap("commands")!
          .map((e) => SuiCommand.fromStruct(e))
          .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(SuiCallArg.layout(), property: "inputs"),
      LayoutConst.bcsVector(SuiCommand.layout(), property: 'commands'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "inputs": inputs
          .map((e) => e is SuiCallArg ? e : SuiCallArgPure(e.toBcs()))
          .map((e) => e.toVariantLayoutStruct())
          .toList(),
      "commands": commands.map((e) => e.toVariantLayoutStruct()).toList()
    };
  }
}

enum SuiTransactionKinds {
  /// A transaction that allows the interleaving of native commands and Move calls
  programmableTransaction(value: 0),

  /// A system transaction that will update epoch information on-chain.
  /// It will only ever be executed once in an epoch.
  /// The argument is the next epoch number, which is critical
  /// because it ensures that this transaction has a unique digest.
  /// This will eventually be translated to a Move call during execution.
  /// It also doesn't require/use a gas object.
  /// A validator will not sign a transaction of this kind from outside. It only
  /// signs internally during epoch changes.
  ///
  /// The ChangeEpoch enumerant is now deprecated (but the ChangeEpoch struct is still used by
  /// EndOfEpochTransaction below).
  changeEpoch(value: 1),
  genesis(value: 2),
  consensusCommitPrologue(value: 3),
  euthenticatorStateUpdate(value: 4),

  /// EndOfEpochTransaction replaces ChangeEpoch with a list of transactions that are allowed to
  /// run at the end of the epoch.
  endOfEpochTransaction(value: 5),
  randomnessStateUpdate(value: 6),

  /// V2 ConsensusCommitPrologue also includes the digest of the current consensus output.
  consensusCommitPrologueV2(value: 7),
  consensusCommitPrologueV3(value: 8);

  const SuiTransactionKinds({required this.value});
  final int value;
  static SuiTransactionKinds fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct TransactionKid from the given name.",
            details: {"name": name}));
  }
}

abstract class SuiTransactionKind extends BcsVariantSerialization {
  final SuiTransactionKinds type;
  const SuiTransactionKind({required this.type});
  factory SuiTransactionKind.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = SuiTransactionKinds.fromName(decode.variantName);
    return switch (type) {
      SuiTransactionKinds.programmableTransaction =>
        SuiTransactionKindProgrammableTransaction.fromStruct(decode.value),
      _ => throw UnimplementedError()
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiTransactionKindProgrammableTransaction.layout,
          property: SuiTransactionKinds.programmableTransaction.name,
          index: SuiTransactionKinds.programmableTransaction.value)
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;

  T cast<T extends SuiTransactionKind>() {
    if (this is! T) {
      throw DartSuiPluginException("Transaction kind casting failed.",
          details: {"expected": "$T", "kind": type.name});
    }
    return this as T;
  }
}

class SuiTransactionKindProgrammableTransaction extends SuiTransactionKind {
  final SuiProgrammableTransaction transaction;

  SuiTransactionKindProgrammableTransaction(this.transaction)
      : super(type: SuiTransactionKinds.programmableTransaction);
  factory SuiTransactionKindProgrammableTransaction.fromStruct(
      Map<String, dynamic> json) {
    return SuiTransactionKindProgrammableTransaction(
        SuiProgrammableTransaction.fromStruct(json.asMap("transaction")));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct(
        [SuiProgrammableTransaction.layout(property: "transaction")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"transaction": transaction.toLayoutStruct()};
  }
}

enum SuiTransactionV2TransactionExpirations {
  /// The transaction has no expiration
  none(value: 0),

  /// Validators wont sign a transaction unless the expiration Epoch
  /// is greater than or equal to the current epoch
  epoch(value: 1);

  const SuiTransactionV2TransactionExpirations({required this.value});
  final int value;
  static SuiTransactionV2TransactionExpirations fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct TransactionExpiration from the given name.",
            details: {"name": name}));
  }
}

abstract class SuiTransactionExpiration extends BcsVariantSerialization {
  final SuiTransactionV2TransactionExpirations type;
  const SuiTransactionExpiration({required this.type});
  factory SuiTransactionExpiration.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type =
        SuiTransactionV2TransactionExpirations.fromName(decode.variantName);
    return switch (type) {
      SuiTransactionV2TransactionExpirations.none =>
        SuiTransactionExpirationNone(),
      SuiTransactionV2TransactionExpirations.epoch =>
        SuiTransactionExpirationEpoch.fromStruct(decode.value),
    };
  }
  @override
  String get variantName => type.name;

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiTransactionExpirationNone.layout,
          property: SuiTransactionV2TransactionExpirations.none.name,
          index: SuiTransactionV2TransactionExpirations.none.value),
      LazyVariantModel(
          layout: SuiTransactionExpirationEpoch.layout,
          property: SuiTransactionV2TransactionExpirations.epoch.name,
          index: SuiTransactionV2TransactionExpirations.epoch.value)
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }
}

class SuiTransactionExpirationNone extends SuiTransactionExpiration {
  const SuiTransactionExpirationNone()
      : super(type: SuiTransactionV2TransactionExpirations.none);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiTransactionExpirationEpoch extends SuiTransactionExpiration {
  final BigInt epochId;
  SuiTransactionExpirationEpoch({required BigInt epochId})
      : epochId = epochId.asUint64,
        super(type: SuiTransactionV2TransactionExpirations.epoch);
  factory SuiTransactionExpirationEpoch.fromStruct(Map<String, dynamic> json) {
    return SuiTransactionExpirationEpoch(epochId: json.as("epochId"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([LayoutConst.u64(property: 'epochId')],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"epochId": epochId};
  }
}

enum SuiTransactionDataVersion {
  v1(value: 0);

  final int value;
  const SuiTransactionDataVersion({required this.value});

  static SuiTransactionDataVersion fromName(String name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct transaction version from the given name.",
            details: {"name": name}));
  }
}

abstract class SuiTransactionData extends BcsVariantSerialization {
  final SuiTransactionDataVersion version;
  const SuiTransactionData({required this.version});
  factory SuiTransactionData.deserialize(List<int> bytes, {String? property}) {
    final decode = BcsVariantSerialization.deserialize(
        bytes: bytes, layout: layout(property: property));

    return SuiTransactionData.fromStruct(decode);
  }
  factory SuiTransactionData.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final version = SuiTransactionDataVersion.fromName(decode.variantName);
    return switch (version) {
      SuiTransactionDataVersion.v1 =>
        SuiTransactionDataV1.fromStruct(decode.value),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiTransactionDataV1.layout,
          property: SuiTransactionDataVersion.v1.name,
          index: SuiTransactionDataVersion.v1.value)
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  List<int> serializeSign() {
    return toIntent().toBcs().asImmutableBytes;
  }

  SuiIntentMessage toIntent() {
    return SuiIntentMessage.transactionData(transaction: this);
  }

  @override
  String get variantName => version.name;

  String txHash() {
    return SuiHelper.generateTransactionDigest(toVariantBcs());
  }
}

class SuiTransactionDataV1 extends SuiTransactionData {
  final SuiTransactionKind kind;
  final SuiAddress sender;
  final SuiGasData gasData;
  final SuiTransactionExpiration expiration;
  SuiTransactionDataV1 copyWith(
      {SuiTransactionKind? kind,
      SuiAddress? sender,
      SuiGasData? gasData,
      SuiTransactionExpiration? expiration}) {
    return SuiTransactionDataV1(
        expiration: expiration ?? this.expiration,
        sender: sender ?? this.sender,
        gasData: gasData ?? this.gasData,
        kind: kind ?? this.kind);
  }

  const SuiTransactionDataV1(
      {required this.expiration,
      required this.sender,
      required this.gasData,
      required this.kind})
      : super(version: SuiTransactionDataVersion.v1);
  factory SuiTransactionDataV1.deserialize(List<int> bytes,
      {String? property}) {
    final decode = BcsSerialization.deserialize(
        bytes: bytes, layout: layout(property: property));
    return SuiTransactionDataV1.fromStruct(decode);
  }
  factory SuiTransactionDataV1.fromStruct(Map<String, dynamic> json) {
    return SuiTransactionDataV1(
      kind: SuiTransactionKind.fromStruct(json.asMap("kind")),
      sender: SuiAddress.fromStruct(json.asMap("sender")),
      gasData: SuiGasData.fromStruct(json.asMap("gas_data")),
      expiration: SuiTransactionExpiration.fromStruct(json.asMap("expiration")),
    );
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiTransactionKind.layout(property: "kind"),
      SuiAddress.layout(property: "sender"),
      SuiGasData.layout(property: "gas_data"),
      SuiTransactionExpiration.layout(property: "expiration")
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "kind": kind.toVariantLayoutStruct(),
      "sender": sender.toLayoutStruct(),
      "gas_data": gasData.toLayoutStruct(),
      "expiration": expiration.toVariantLayoutStruct()
    };
  }
}

class SuiSenderSignedTransaction extends BcsSerialization {
  final SuiIntentMessage intentMessage;
  final List<List<int>> signatures;
  SuiSenderSignedTransaction(
      {required this.intentMessage, required List<List<int>> signatures})
      : signatures = signatures.map((e) => e.asImmutableBytes).toImutableList;
  factory SuiSenderSignedTransaction.deserialize(List<int> bytes) {
    final intentMessage = SuiIntentMessage.deserializeWithConsumedLength(bytes);
    final signatures = LayoutConst.bcsVector(LayoutConst.bcsBytes())
        .deserialize(bytes.sublist(intentMessage.$2));
    return SuiSenderSignedTransaction(
        intentMessage: intentMessage.$1, signatures: signatures.value);
  }

  static Layout<Map<String, dynamic>> layout(
      {String? property, required SuiIntentMessage message}) {
    return LayoutConst.struct([
      message.createLayout(property: "intent_message"),
      LayoutConst.bcsVector(
        LayoutConst.bcsBytes(),
        property: 'signatures',
      ),
    ]);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(message: intentMessage, property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "signatures": signatures,
      "intent_message": intentMessage.toLayoutStruct()
    };
  }
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/transaction/utils/utils.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class TableItemRequestParams {
  /// ^(bool|u8|u64|u128|address|signer|vector<.+>|0x[0-9a-zA-Z:_<, >]+)$
  /// String representation of an on-chain Move type tag that is exposed in transaction payload.
  ///  Values: - bool - u8 - u16 - u32 - u64 - u128 - u256 - address - signer -
  /// vector: vector<{non-reference MoveTypeId}> - struct: {address}::{module_name}::{struct_name}::<{generic types}>
  final Object keyType;

  /// ^(bool|u8|u64|u128|address|signer|vector<.+>|0x[0-9a-zA-Z:_<, >]+)$
  /// String representation of an on-chain Move type tag that is exposed in transaction payload.
  ///  Values: - bool - u8 - u16 - u32 - u64 - u128 - u256 - address - signer -
  /// vector: vector<{non-reference MoveTypeId}> - struct: {address}::{module_name}::{struct_name}::<{generic types}>
  final Object valueType;

  /// The value of the table item's key
  final Object key;
  const TableItemRequestParams(
      {required this.key, required this.keyType, required this.valueType});

  Map<String, dynamic> toJson() {
    return {"key_type": keyType, "value_type": valueType, "key": key};
  }
}

class ExecuteViewFunctionOfAModuleRequestParams {
  /// Entry function id is string representation of a entry function defined on-chain.
  final String function;

  /// Type arguments of the function
  final List<String> typeArguments;

  /// Arguments of the function
  final List<Object> arguments;
  ExecuteViewFunctionOfAModuleRequestParams(
      {required String function,
      required List<String> typeArguments,
      required List<Object> arguments})
      : typeArguments = typeArguments.immutable,
        arguments = arguments.immutable,
        function = AptosTransactionUtils.validateFunction(function);
  Map<String, dynamic> toJson() {
    return {"function": function, "type_arguments": [], "arguments": arguments};
  }
}

class AptosApiAccountData {
  final BigInt sequenceNumber;
  final String authenticationKey;
  const AptosApiAccountData(
      {required this.sequenceNumber, required this.authenticationKey});
  factory AptosApiAccountData.fromJson(Map<String, dynamic> json) {
    return AptosApiAccountData(
        sequenceNumber: json.asBigInt("sequence_number"),
        authenticationKey: json.as("authentication_key"));
  }
  Map<String, dynamic> toJson() {
    return {
      "sequence_number": sequenceNumber.toString(),
      "authentication_key": authenticationKey
    };
  }
}

class AptosApiMoveResource {
  final String type;
  final Map<dynamic, dynamic> data;
  const AptosApiMoveResource({required this.type, required this.data});
  factory AptosApiMoveResource.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveResource(type: json.as("type"), data: json.as("data"));
  }
  Map<String, dynamic> toJson() {
    return {"type": type, "data": data};
  }
}

enum AptosApiMoveFunctionVisibilty {
  private,
  public,
  friend;

  static AptosApiMoveFunctionVisibilty fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct MoveFunctionVisibilty from the given name.",
            details: {"name": name}));
  }
}

enum AptosApiMoveAbility {
  store,
  drop,
  key,
  copy;

  static AptosApiMoveAbility fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct MoveFunctionVisibilty from the given name.",
            details: {"name": name}));
  }
}

class AptosApiMoveFunctionGenericTypeParams {
  final List<AptosApiMoveAbility> constraints;
  AptosApiMoveFunctionGenericTypeParams(
      {required List<AptosApiMoveAbility> constraints})
      : constraints = constraints.immutable;
  factory AptosApiMoveFunctionGenericTypeParams.fromJson(
      Map<String, dynamic> json) {
    return AptosApiMoveFunctionGenericTypeParams(
        constraints: json
            .asListOfString("constraints")!
            .map((e) => AptosApiMoveAbility.fromName(e))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {"constraints": constraints.map((e) => e.name).toList()};
  }
}

class AptosApiMoveFunction {
  final String name;
  final AptosApiMoveFunctionVisibilty visibility;
  final bool isEntry;
  final bool isView;
  final List<AptosApiMoveFunctionGenericTypeParams> genericTypeParams;
  final List<String> params;
  final List<String> returnTypes;
  AptosApiMoveFunction(
      {required this.name,
      required this.visibility,
      required this.isEntry,
      required this.isView,
      required List<AptosApiMoveFunctionGenericTypeParams> genericTypeParams,
      required List<String> params,
      required List<String> returnTypes})
      : genericTypeParams = genericTypeParams.immutable,
        params = params.immutable,
        returnTypes = returnTypes.immutable;
  factory AptosApiMoveFunction.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveFunction(
        name: json.as("name"),
        visibility:
            AptosApiMoveFunctionVisibilty.fromName(json.as("visibility")),
        isEntry: json.as("is_entry"),
        isView: json.as("is_view"),
        genericTypeParams: json
            .asListOfMap("generic_type_params")!
            .map((e) => AptosApiMoveFunctionGenericTypeParams.fromJson(e))
            .toList(),
        params: json.asListOfString("params")!,
        returnTypes: json.asListOfString("return")!);
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "visibility": visibility.name,
      "is_entry": isEntry,
      "is_view": isView,
      "generic_type_params": genericTypeParams.map((e) => e.toJson()),
      "params": params,
      "return": returnTypes
    };
  }
}

class AptosApiMoveStrictField {
  final String name;
  final String type;
  const AptosApiMoveStrictField({required this.name, required this.type});
  factory AptosApiMoveStrictField.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveStrictField(
        name: json.as("name"), type: json.as("type"));
  }
  Map<String, dynamic> toJson() {
    return {"name": name, "type": type};
  }
}

class AptosApiMoveStrunct {
  final String name;
  final bool isNative;
  final bool isEvent;
  final List<AptosApiMoveAbility> abilities;
  final List<AptosApiMoveFunctionGenericTypeParams> genericTypeParams;
  final List<AptosApiMoveStrictField> fields;
  AptosApiMoveStrunct(
      {required this.name,
      required this.isNative,
      required this.isEvent,
      required List<AptosApiMoveAbility> abilities,
      required List<AptosApiMoveFunctionGenericTypeParams> genericTypeParams,
      required List<AptosApiMoveStrictField> fields})
      : genericTypeParams = genericTypeParams.immutable,
        abilities = abilities.immutable,
        fields = fields.immutable;
  factory AptosApiMoveStrunct.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveStrunct(
        name: json.as("name"),
        isEvent: json.as("is_event"),
        isNative: json.as("is_native"),
        abilities: json
            .asListOfString("abilities")!
            .map((e) => AptosApiMoveAbility.fromName(e))
            .toList(),
        genericTypeParams: json
            .asListOfMap("generic_type_params")!
            .map((e) => AptosApiMoveFunctionGenericTypeParams.fromJson(e))
            .toList(),
        fields: json
            .asListOfMap("fields")!
            .map((e) => AptosApiMoveStrictField.fromJson(e))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "is_event": isEvent,
      "is_native": isNative,
      "abilities": abilities.map((e) => e.name).toList(),
      "generic_type_params": genericTypeParams.map((e) => e.toJson()),
      "fields": fields.map((e) => e.toJson()).toList()
    };
  }
}

class AptosApiMoveModule {
  final String address;
  final String name;
  final List<String> friends;
  final List<AptosApiMoveFunction> exposedFunctions;
  final List<AptosApiMoveStrunct> structs;

  /// Finds an Aptos Move entry function by its [functionName].
  ///
  /// - [functionName]: The name of the entry function to search for.
  ///
  /// Returns the [AptosApiMoveFunction] if found.
  ///
  /// Throws [DartSuiPluginException] if no matching entry function is found,
  /// including details about the searched function name and available entry functions.
  AptosApiMoveFunction findEntryFunction(String functionName) {
    return exposedFunctions.firstWhere(
      (e) => e.isEntry && e.name.toLowerCase() == functionName.toLowerCase(),
      orElse: () {
        throw DartSuiPluginException(
          "Entry function '$functionName' not found.",
          details: {
            "searchedFunctionName": functionName,
            "availableEntryFunctions": exposedFunctions
                .where((e) => e.isEntry)
                .map((e) => e.name)
                .join(", "), // Join with comma for better readability
          },
        );
      },
    );
  }

  /// Finds an Aptos Move view function by its [functionName].
  ///
  /// - [functionName]: The name of the view function to search for.
  ///
  /// Returns the [AptosApiMoveFunction] if found.
  ///
  /// Throws [DartSuiPluginException] if no matching view function is found,
  /// including details about the searched function name and available view functions.
  AptosApiMoveFunction findViewFunction(String functionName) {
    return exposedFunctions.firstWhere(
      (e) => e.isView && e.name.toLowerCase() == functionName.toLowerCase(),
      orElse: () {
        throw DartSuiPluginException(
          "View function '$functionName' not found.",
          details: {
            "searchedFunctionName": functionName,
            "availableViewFunctions": exposedFunctions
                .where((e) => e.isView)
                .map((e) => e.name)
                .join(", "), // Join with comma for consistency
          },
        );
      },
    );
  }

  AptosApiMoveModule(
      {required this.address,
      required this.name,
      required List<String> friends,
      required List<AptosApiMoveFunction> exposedFunctions,
      required List<AptosApiMoveStrunct> structs})
      : friends = friends.immutable,
        exposedFunctions = exposedFunctions.immutable,
        structs = structs.immutable;
  factory AptosApiMoveModule.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveModule(
        address: json.as("address"),
        name: json.as("name"),
        friends: json.asListOfString("friends")!,
        exposedFunctions: json
            .asListOfMap("exposed_functions")!
            .map((e) => AptosApiMoveFunction.fromJson(e))
            .toList(),
        structs: json
            .asListOfMap("structs")!
            .map((e) => AptosApiMoveStrunct.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "name": name,
      "friends": friends,
      "exposed_functions": exposedFunctions.map((e) => e.toJson()).toList(),
      "structs": structs.map((e) => e.toJson()).toList()
    };
  }
}

class AptosApiMoveModuleByteCode {
  final AptosApiMoveModule abi;
  final String byteCode;
  const AptosApiMoveModuleByteCode({required this.abi, required this.byteCode});
  factory AptosApiMoveModuleByteCode.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveModuleByteCode(
        abi: AptosApiMoveModule.fromJson(json.asMap("abi")),
        byteCode: json.as("bytecode"));
  }
  Map<String, dynamic> toJson() {
    return {"abi": abi.toJson(), "bytecode": byteCode};
  }
}

class AptosApiMoveScruptByteCode {
  final AptosApiMoveFunction? abi;
  final String byteCode;
  const AptosApiMoveScruptByteCode({required this.abi, required this.byteCode});
  factory AptosApiMoveScruptByteCode.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveScruptByteCode(
        abi: json.mybeAs<AptosApiMoveFunction, Map<String, dynamic>>(
            key: "abi", onValue: (e) => AptosApiMoveFunction.fromJson(e)),
        byteCode: json.as("bytecode"));
  }
  Map<String, dynamic> toJson() {
    return {"abi": abi?.toJson(), "bytecode": byteCode};
  }
}

enum AptosApiTransactionPayloadTye {
  entryFunctionPayload("entry_function_payload"),
  multisigPayload("multisig_payload"),
  scriptPayload("script_payload");

  /// entry_function_payload
  final String name;
  const AptosApiTransactionPayloadTye(this.name);
  static AptosApiTransactionPayloadTye fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct transaction payload from the given name.",
            details: {"name": name}));
  }
}

abstract class AptosApiTransactionPayload {
  final AptosApiTransactionPayloadTye type;
  const AptosApiTransactionPayload({required this.type});
  factory AptosApiTransactionPayload.froMJson(Map<String, dynamic> json) {
    final type = AptosApiTransactionPayloadTye.fromName(json.as("type"));
    return switch (type) {
      AptosApiTransactionPayloadTye.entryFunctionPayload =>
        AptosApiTransactionPayloadEntryFunction.fromJson(json),
      AptosApiTransactionPayloadTye.scriptPayload =>
        AptosApiTransactionPayloadScript.fromJson(json),
      AptosApiTransactionPayloadTye.multisigPayload =>
        AptosApiTransactionPayloadMultisig.fromJson(json)
    };
  }
  Map<String, dynamic> toJson();
}

class AptosApiTransactionPayloadEntryFunction
    extends AptosApiTransactionPayload {
  final String function;
  final List<String> typeArguments;
  final List<Object> arguments;
  AptosApiTransactionPayloadEntryFunction(
      {required this.function,
      required List<String> typeArguments,
      required List<Object> arguments})
      : typeArguments = typeArguments.immutable,
        arguments = arguments.immutable,
        super(type: AptosApiTransactionPayloadTye.entryFunctionPayload);
  factory AptosApiTransactionPayloadEntryFunction.fromJson(
      Map<String, dynamic> json) {
    return AptosApiTransactionPayloadEntryFunction(
        function: json.as("function"),
        typeArguments: json.asListOfString("type_arguments")!,
        arguments: json.as<List>("arguments").cast());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "function": function,
      "type_arguments": typeArguments,
      "arguments": arguments
    };
  }
}

class AptosApiTransactionPayloadScript extends AptosApiTransactionPayload {
  final AptosApiMoveScruptByteCode code;
  final List<String> typeArguments;
  final List<Object> arguments;
  AptosApiTransactionPayloadScript(
      {required this.code,
      required List<String> typeArguments,
      required List<Object> arguments})
      : typeArguments = typeArguments.immutable,
        arguments = arguments.immutable,
        super(type: AptosApiTransactionPayloadTye.scriptPayload);
  factory AptosApiTransactionPayloadScript.fromJson(Map<String, dynamic> json) {
    return AptosApiTransactionPayloadScript(
        code: AptosApiMoveScruptByteCode.fromJson(json.asMap("code")),
        typeArguments: json.asListOfString("type_arguments")!,
        arguments: json.as<List>("arguments").cast());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "code": code.toJson(),
      "type_arguments": typeArguments,
      "arguments": arguments
    };
  }
}

class AptosApiTransactionPayloadMultisig extends AptosApiTransactionPayload {
  final AptosApiTransactionPayloadEntryFunction? transactionPayload;
  final String multisigAddress;
  AptosApiTransactionPayloadMultisig(
      {required this.transactionPayload, required this.multisigAddress})
      : super(type: AptosApiTransactionPayloadTye.multisigPayload);
  factory AptosApiTransactionPayloadMultisig.fromJson(
      Map<String, dynamic> json) {
    return AptosApiTransactionPayloadMultisig(
        transactionPayload: json.mybeAs<AptosApiTransactionPayloadEntryFunction,
                Map<String, dynamic>>(
            key: "transaction_payload",
            onValue: (e) =>
                AptosApiTransactionPayloadEntryFunction.fromJson(e)),
        multisigAddress: json.as("multisig_address"));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "multisig_address": multisigAddress,
      "transaction_payload": transactionPayload?.toJson()
    };
  }
}

enum AptoApiTransactionSignatureType {
  ed25519Signature("ed25519_signature"),
  secp256k1EcdsaSignature("secp256k1_ecdsa_signature"),
  multiEd25519Signature("multi_ed25519_signature"),
  multiAgentSignature("multi_agent_signature"),
  feePayerSignature("fee_payer_signature"),
  singleSender("single_sender"),
  noAccountSignature("no_account_signature");

  final String name;
  const AptoApiTransactionSignatureType(this.name);
  static AptoApiTransactionSignatureType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct transaction signature from the given name.",
            details: {"name": name}));
  }
}

enum AptoApiAccountSignatureType {
  ed25519Signature("ed25519_signature"),
  multiEd25519Signature("multi_ed25519_signature"),
  singleKeySignature("single_key_signature"),
  multiKeySignature("multi_key_signature"),
  noAccountSignature("no_account_signature"),
  abstractionSignature("abstraction_signature");

  final String name;
  const AptoApiAccountSignatureType(this.name);
  static AptoApiAccountSignatureType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct account signature from the given name.",
            details: {"name": name}));
  }
}

abstract class AptosApiAccountSignature {
  final AptoApiAccountSignatureType type;
  const AptosApiAccountSignature({required this.type});
  Map<String, dynamic> toJson();
  factory AptosApiAccountSignature.fromJson(Map<String, dynamic> json) {
    final type = AptoApiAccountSignatureType.fromName(json.as("type"));
    return switch (type) {
      AptoApiAccountSignatureType.ed25519Signature =>
        AptosApiAccountSignatureEd25519Signature.fromJson(json),
      AptoApiAccountSignatureType.abstractionSignature =>
        AptosApiAccountSignatureAbstractionSignature.fromJson(json),
      AptoApiAccountSignatureType.multiEd25519Signature =>
        AptosApiAccountSignatureMultiEd25519Signature.fromJson(json),
      AptoApiAccountSignatureType.multiKeySignature =>
        AptosApiAccountSignatureMultiKeySignature.fromJson(json),
      AptoApiAccountSignatureType.singleKeySignature =>
        AptosApiAccountSingleKeySignature.fromJson(json),
      AptoApiAccountSignatureType.noAccountSignature =>
        AptosApiAccountSignatureNoAccountSignature(),
    };
  }
}

class AptosApiAccountSignatureEd25519Signature
    extends AptosApiAccountSignature {
  final String publicKey;
  final String signature;
  AptosApiAccountSignatureEd25519Signature(
      {required this.publicKey, required this.signature})
      : super(type: AptoApiAccountSignatureType.ed25519Signature);
  factory AptosApiAccountSignatureEd25519Signature.fromJson(
      Map<String, dynamic> json) {
    return AptosApiAccountSignatureEd25519Signature(
        publicKey: json.as("public_key"), signature: json.as("signature"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"public_key": publicKey, "signature": signature, "type": type.name};
  }
}

class AptosApiAccountSignatureAbstractionSignature
    extends AptosApiAccountSignature {
  final String functionInfo;
  final String authData;
  AptosApiAccountSignatureAbstractionSignature(
      {required this.functionInfo, required this.authData})
      : super(type: AptoApiAccountSignatureType.abstractionSignature);
  factory AptosApiAccountSignatureAbstractionSignature.fromJson(
      Map<String, dynamic> json) {
    return AptosApiAccountSignatureAbstractionSignature(
        functionInfo: json.as("function_info"), authData: json.as("auth_data"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "function_info": functionInfo,
      "auth_data": authData,
      "type": type.name
    };
  }
}

class AptosApiAccountSignatureMultiEd25519Signature
    extends AptosApiAccountSignature {
  final List<String> publicKeys;
  final List<String> signatures;
  final int threshold;
  final String bitmap;
  AptosApiAccountSignatureMultiEd25519Signature(
      {required List<String> publicKeys,
      required List<String> signatures,
      required this.threshold,
      required this.bitmap})
      : publicKeys = publicKeys.immutable,
        signatures = signatures.immutable,
        super(type: AptoApiAccountSignatureType.multiEd25519Signature);
  factory AptosApiAccountSignatureMultiEd25519Signature.fromJson(
      Map<String, dynamic> json) {
    return AptosApiAccountSignatureMultiEd25519Signature(
        publicKeys: json.asListOfString("public_keys")!,
        signatures: json.asListOfString("signatures")!,
        threshold: json.as("threshold"),
        bitmap: json.as("bitmap"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "public_keys": publicKeys,
      "signatures": signatures,
      "bitmap": bitmap,
      "threshold": threshold,
      "type": type.name
    };
  }
}

class AptosApiAccountSignatureMultiKeySignature
    extends AptosApiAccountSignature {
  final List<AptosApiPublicKey> publicKeys;
  final List<AptosApiIndexedSignature> signatures;
  final int signaturesRequired;
  AptosApiAccountSignatureMultiKeySignature({
    required List<AptosApiPublicKey> publicKeys,
    required List<AptosApiIndexedSignature> signatures,
    required this.signaturesRequired,
  })  : publicKeys = publicKeys.immutable,
        signatures = signatures.immutable,
        super(type: AptoApiAccountSignatureType.multiKeySignature);
  factory AptosApiAccountSignatureMultiKeySignature.fromJson(
      Map<String, dynamic> json) {
    return AptosApiAccountSignatureMultiKeySignature(
        publicKeys: json
            .asListOfMap("public_keys")!
            .map((e) => AptosApiPublicKey.fromJson(e))
            .toList(),
        signatures: json
            .asListOfMap("signatures")!
            .map((e) => AptosApiIndexedSignature.fromJson(e))
            .toList(),
        signaturesRequired: json.as("signatures_required"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "public_keys": publicKeys.map((e) => e.toJson()).toList(),
      "signatures": signatures.map((e) => e.toJson()).toList(),
      "signatures_required": signaturesRequired,
      "type": type.name
    };
  }
}

class AptosApiTransactionNoAccountSignature
    extends AptosApiTransactionSignature {
  AptosApiTransactionNoAccountSignature()
      : super(type: AptoApiTransactionSignatureType.noAccountSignature);

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }
}

class AptosApiAccountSignatureNoAccountSignature
    extends AptosApiAccountSignature {
  AptosApiAccountSignatureNoAccountSignature()
      : super(type: AptoApiAccountSignatureType.noAccountSignature);

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }
}

class AptosApiIndexedSignature extends AptosApiAccountSignature {
  final AptosApiSignature signature;
  final int index;
  AptosApiIndexedSignature({
    required this.signature,
    required this.index,
  }) : super(type: AptoApiAccountSignatureType.multiKeySignature);
  factory AptosApiIndexedSignature.fromJson(Map<String, dynamic> json) {
    return AptosApiIndexedSignature(
        signature: AptosApiSignature.fromJson(json.asMap("signature")),
        index: json.as("index"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"signature": signature.toJson(), "index": index};
  }
}

enum AptoApiPublicKeyType {
  ed25519("ed25519"),
  secp256k1Ecdsa("secp256k1_ecdsa"),
  secp256r1Ecdsa("secp256r1_ecdsa"),
  keyless("keyless"),
  federatedKeyless("federated_keyless");

  final String name;
  const AptoApiPublicKeyType(this.name);
  static AptoApiPublicKeyType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct public key from the given name.",
            details: {"name": name}));
  }
}

class AptosApiPublicKey {
  final AptoApiPublicKeyType type;
  final String value;
  const AptosApiPublicKey({required this.type, required this.value});
  factory AptosApiPublicKey.fromJson(Map<String, dynamic> json) {
    return AptosApiPublicKey(
        type: AptoApiPublicKeyType.fromName(json.as("type")),
        value: json.as("value"));
  }
  Map<String, dynamic> toJson() {
    return {"value": value, "type": type.name};
  }
}

class AptosApiAccountSingleKeySignature extends AptosApiAccountSignature {
  final AptosApiPublicKey publicKey;
  final AptosApiSignature signature;
  const AptosApiAccountSingleKeySignature(
      {required this.publicKey, required this.signature})
      : super(type: AptoApiAccountSignatureType.singleKeySignature);
  factory AptosApiAccountSingleKeySignature.fromJson(
      Map<String, dynamic> json) {
    return AptosApiAccountSingleKeySignature(
        publicKey: AptosApiPublicKey.fromJson(json.as("public_key")),
        signature: AptosApiSignature.fromJson(json.as("signature")));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "public_key": publicKey.toJson(),
      "signature": signature.toJson(),
      "type": type.name
    };
  }
}

enum AptoApiSignatureType {
  ed25519("ed25519"),
  secp256k1Ecdsa("secp256k1_ecdsa"),
  webAuthn("web_authn"),
  keyless("keyless");

  final String name;
  const AptoApiSignatureType(this.name);
  static AptoApiSignatureType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct signature from the given name.",
            details: {"name": name}));
  }
}

class AptosApiSignature {
  final AptoApiSignatureType type;
  final String value;
  const AptosApiSignature({required this.type, required this.value});
  factory AptosApiSignature.fromJson(Map<String, dynamic> json) {
    return AptosApiSignature(
        type: AptoApiSignatureType.fromName(json.as("type")),
        value: json.as("value"));
  }
  Map<String, dynamic> toJson() {
    return {"value": value, "type": type.name};
  }
}

abstract class AptosApiTransactionSignature {
  final AptoApiTransactionSignatureType type;
  const AptosApiTransactionSignature({required this.type});
  factory AptosApiTransactionSignature.fromJson(Map<String, dynamic> json) {
    final type = AptoApiTransactionSignatureType.fromName(json.as("type"));
    return switch (type) {
      AptoApiTransactionSignatureType.ed25519Signature =>
        AptosApiTransactionEd25519Signature.fromJson(json),
      AptoApiTransactionSignatureType.secp256k1EcdsaSignature =>
        AptosApiTransactionSecp256k1EcdsaSignature.fromJson(json),
      AptoApiTransactionSignatureType.multiEd25519Signature =>
        AptosApiTransactionMultiEd25519Signature.fromJson(json),
      AptoApiTransactionSignatureType.multiAgentSignature =>
        AptosApiTransactionMultiAgentSignature.fromJson(json),
      AptoApiTransactionSignatureType.feePayerSignature =>
        AptosApiTransactionFeePayerSignature.fromJson(json),
      AptoApiTransactionSignatureType.singleSender =>
        AptosApiTransactionSingleSenderSignature.fromJson(json),
      AptoApiTransactionSignatureType.noAccountSignature =>
        AptosApiTransactionNoAccountSignature(),
    };
  }
  Map<String, dynamic> toJson();
}

class AptosApiTransactionEd25519Signature extends AptosApiTransactionSignature {
  final String publicKey;
  final String signature;
  AptosApiTransactionEd25519Signature(
      {required this.publicKey, required this.signature})
      : super(type: AptoApiTransactionSignatureType.ed25519Signature);
  factory AptosApiTransactionEd25519Signature.fromJson(
      Map<String, dynamic> json) {
    return AptosApiTransactionEd25519Signature(
        publicKey: json.as("public_key"), signature: json.as("signature"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"public_key": publicKey, "signature": signature};
  }
}

class AptosApiTransactionSecp256k1EcdsaSignature
    extends AptosApiTransactionSignature {
  final String publicKey;
  final String signature;
  AptosApiTransactionSecp256k1EcdsaSignature(
      {required this.publicKey, required this.signature})
      : super(type: AptoApiTransactionSignatureType.secp256k1EcdsaSignature);
  factory AptosApiTransactionSecp256k1EcdsaSignature.fromJson(
      Map<String, dynamic> json) {
    return AptosApiTransactionSecp256k1EcdsaSignature(
        publicKey: json.as("public_key"), signature: json.as("signature"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"public_key": publicKey, "signature": signature};
  }
}

class AptosApiTransactionMultiEd25519Signature
    extends AptosApiTransactionSignature {
  final List<String> publicKeys;
  final List<String> signatures;
  final int threshold;
  final String bitmap;
  AptosApiTransactionMultiEd25519Signature(
      {required List<String> publicKeys,
      required List<String> signatures,
      required this.threshold,
      required this.bitmap})
      : publicKeys = publicKeys.immutable,
        signatures = signatures.immutable,
        super(type: AptoApiTransactionSignatureType.multiEd25519Signature);
  factory AptosApiTransactionMultiEd25519Signature.fromJson(
      Map<String, dynamic> json) {
    return AptosApiTransactionMultiEd25519Signature(
        publicKeys: json.asListOfString("public_keys")!,
        signatures: json.asListOfString("signatures")!,
        threshold: json.as("threshold"),
        bitmap: json.as("bitmap"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "public_keys": publicKeys,
      "signatures": signatures,
      "bitmap": bitmap,
      "threshold": threshold
    };
  }
}

class AptosApiTransactionMultiAgentSignature
    extends AptosApiTransactionSignature {
  final List<String> secondarySignerAddresses;
  final List<AptosApiAccountSignature> secondarySigners;
  final AptosApiAccountSignature sender;
  AptosApiTransactionMultiAgentSignature(
      {required List<String> secondarySignerAddresses,
      required List<AptosApiAccountSignature> secondarySigners,
      required this.sender})
      : secondarySignerAddresses = secondarySignerAddresses.immutable,
        secondarySigners = secondarySigners.immutable,
        super(type: AptoApiTransactionSignatureType.multiAgentSignature);
  factory AptosApiTransactionMultiAgentSignature.fromJson(
      Map<String, dynamic> json) {
    return AptosApiTransactionMultiAgentSignature(
        secondarySignerAddresses:
            json.asListOfString("secondary_signer_addresses")!,
        secondarySigners: json
            .asListOfMap("secondary_signers")!
            .map((e) => AptosApiAccountSignature.fromJson(e))
            .toList(),
        sender: AptosApiAccountSignature.fromJson(json.asMap("sender")));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "secondary_signer_addresses": secondarySignerAddresses,
      "secondary_signers": secondarySigners.map((e) => e.toJson()).toList(),
      "sender": sender.toJson()
    };
  }
}

class AptosApiTransactionFeePayerSignature
    extends AptosApiTransactionSignature {
  final List<String> secondarySignerAddresses;
  final List<AptosApiAccountSignature> secondarySigners;
  final AptosApiAccountSignature sender;
  final String feePayerAddress;
  final AptosApiAccountSignature feePayerSigner;
  AptosApiTransactionFeePayerSignature(
      {required List<String> secondarySignerAddresses,
      required List<AptosApiAccountSignature> secondarySigners,
      required this.sender,
      required this.feePayerAddress,
      required this.feePayerSigner})
      : secondarySignerAddresses = secondarySignerAddresses.immutable,
        secondarySigners = secondarySigners.immutable,
        super(type: AptoApiTransactionSignatureType.feePayerSignature);
  factory AptosApiTransactionFeePayerSignature.fromJson(
      Map<String, dynamic> json) {
    return AptosApiTransactionFeePayerSignature(
        secondarySignerAddresses:
            json.asListOfString("secondary_signer_addresses")!,
        secondarySigners: json
            .asListOfMap("secondary_signers")!
            .map((e) => AptosApiAccountSignature.fromJson(e))
            .toList(),
        sender: AptosApiAccountSignature.fromJson(json.asMap("sender")),
        feePayerAddress: json.as("fee_payer_address"),
        feePayerSigner:
            AptosApiAccountSignature.fromJson(json.asMap("fee_payer_signer")));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "secondary_signer_addresses": secondarySignerAddresses,
      "secondary_signers": secondarySigners.map((e) => e.toJson()).toList(),
      "sender": sender.toJson(),
      "fee_payer_address": feePayerAddress,
      "fee_payer_signer": feePayerSigner.toJson(),
      "type": type.name
    };
  }
}

class AptosApiTransactionSingleSenderSignature
    extends AptosApiTransactionSignature {
  final AptosApiAccountSignature signature;
  AptosApiTransactionSingleSenderSignature({required this.signature})
      : super(type: AptoApiTransactionSignatureType.singleSender);
  factory AptosApiTransactionSingleSenderSignature.fromJson(
      Map<String, dynamic> json) {
    if (json.containsKey("signatures_required")) {
      return AptosApiTransactionSingleSenderSignature(
          signature: AptosApiAccountSignatureMultiKeySignature.fromJson(json));
    }
    if (json.containsKey("threshold")) {
      return AptosApiTransactionSingleSenderSignature(
          signature:
              AptosApiAccountSignatureMultiEd25519Signature.fromJson(json));
    }
    if (json.containsKey("function_info")) {
      return AptosApiTransactionSingleSenderSignature(
          signature:
              AptosApiAccountSignatureAbstractionSignature.fromJson(json));
    }
    if (json["public_key"] is String) {
      return AptosApiTransactionSingleSenderSignature(
          signature: AptosApiAccountSignatureEd25519Signature.fromJson(json));
    }
    if (json.containsKey("public_key")) {
      return AptosApiTransactionSingleSenderSignature(
          signature: AptosApiAccountSingleKeySignature.fromJson(json));
    }
    return AptosApiTransactionSingleSenderSignature(
        signature: AptosApiAccountSignatureNoAccountSignature());
  }
  @override
  Map<String, dynamic> toJson() {
    final toJson = signature.toJson();
    toJson["type"] = type.name;
    return toJson;
  }
}

enum AptoApiTransactionType {
  pendingTransaction("pending_transaction"),
  userTransaction("user_transaction"),
  genesisTransaction("genesis_transaction"),
  blockMetadataTransaction("block_metadata_transaction"),
  stateCheckpointTransaction("state_checkpoint_transaction"),
  validatorTransaction("validator_transaction"),
  blockEpilogueTransaction("block_epilogue_transaction");

  final String name;
  const AptoApiTransactionType(this.name);
  static AptoApiTransactionType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct transaction from the given name.",
            details: {"name": name}));
  }
}

abstract class AptosApiTransaction {
  final AptoApiTransactionType type;
  const AptosApiTransaction({required this.type});
  Map<String, dynamic> toJson();
  factory AptosApiTransaction.fromJson(Map<String, dynamic> json) {
    final type = AptoApiTransactionType.fromName(json.as("type"));
    return switch (type) {
      AptoApiTransactionType.pendingTransaction =>
        AptosApiPendingTransaction.fromJson(json),
      AptoApiTransactionType.userTransaction =>
        AptosApiUserTransaction.fromJson(json),
      AptoApiTransactionType.genesisTransaction =>
        AptosApiGenesisTransaction.fromJson(json),
      AptoApiTransactionType.blockMetadataTransaction =>
        AptosApiBlockMetadataTransaction.fromJson(json),
      AptoApiTransactionType.stateCheckpointTransaction =>
        AptosApiStateCheckpointTransaction.fromJson(json),
      AptoApiTransactionType.validatorTransaction =>
        AptosApiValidatorTransaction.fromJson(json),
      AptoApiTransactionType.blockEpilogueTransaction =>
        AptosApiBlockEpilogueTransaction.fromJson(json),
    };
  }
}

class AptosApiPendingTransaction extends AptosApiTransaction {
  final String hash;
  final String sender;
  final String sequenceNumber;
  final String maxGasAmount;
  final String gasUnitPrice;
  final String expirationTimestampSecs;
  final AptosApiTransactionPayload payload;
  final AptosApiTransactionSignature? signature;
  AptosApiPendingTransaction(
      {required this.hash,
      required this.sender,
      required this.sequenceNumber,
      required this.maxGasAmount,
      required this.gasUnitPrice,
      required this.expirationTimestampSecs,
      required this.payload,
      this.signature})
      : super(type: AptoApiTransactionType.pendingTransaction);
  factory AptosApiPendingTransaction.fromJson(Map<String, dynamic> json) {
    return AptosApiPendingTransaction(
      hash: json.as("hash"),
      sender: json.as("sender"),
      sequenceNumber: json.as("sequence_number"),
      maxGasAmount: json.as("max_gas_amount"),
      gasUnitPrice: json.as("gas_unit_price"),
      expirationTimestampSecs: json.as("expiration_timestamp_secs"),
      payload: AptosApiTransactionPayload.froMJson(json.asMap("payload")),
      signature:
          json.mybeAs<AptosApiTransactionSignature, Map<String, dynamic>>(
              key: "signature",
              onValue: (e) => AptosApiTransactionSignature.fromJson(e)),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "hash": hash,
      "sender": sender,
      "sequence_number": sequenceNumber,
      "max_gas_amount": maxGasAmount,
      "gas_unit_price": gasUnitPrice,
      "expiration_timestamp_secs": expirationTimestampSecs,
      "payload": payload.toJson(),
      "signature": signature?.toJson(),
    };
  }
}

class AptosApiUserTransaction extends AptosApiTransaction {
  final String version;
  final String hash;
  final String stateChangeHash;
  final String eventRootHash;
  final String? stateCheckpointHash;
  final String gasUsed;
  final bool success;
  final String vmStatus;
  final String accumulatorRootHash;
  final List<AptosApiWriteSetChange> changes;
  final String sender;
  final String sequenceNumber;
  final String maxGasAmount;
  final String gasUnitPrice;
  final String expirationTimestampSecs;
  final AptosApiTransactionPayload payload;
  final AptosApiTransactionSignature? signature;
  final List<AptosApiEvent> events;
  final String timeStamp;
  AptosApiUserTransaction({
    required this.version,
    required this.hash,
    required this.stateChangeHash,
    required this.eventRootHash,
    required this.stateCheckpointHash,
    required this.gasUsed,
    required this.success,
    required this.vmStatus,
    required this.accumulatorRootHash,
    required this.changes,
    required this.sender,
    required this.sequenceNumber,
    required this.maxGasAmount,
    required this.gasUnitPrice,
    required this.expirationTimestampSecs,
    required this.payload,
    required this.signature,
    required this.events,
    required this.timeStamp,
  }) : super(type: AptoApiTransactionType.userTransaction);
  factory AptosApiUserTransaction.fromJson(Map<String, dynamic> json) {
    return AptosApiUserTransaction(
        version: json.as("version"),
        hash: json.as("hash"),
        stateChangeHash: json.as("state_change_hash"),
        eventRootHash: json.as("event_root_hash"),
        stateCheckpointHash: json.as("state_checkpoint_hash"),
        gasUsed: json.as("gas_used"),
        success: json.as("success"),
        vmStatus: json.as("vm_status"),
        accumulatorRootHash: json.as("accumulator_root_hash"),
        changes: json
            .asListOfMap("changes")!
            .map((e) => AptosApiWriteSetChange.fromJson(e))
            .toList(),
        sender: json.as("sender"),
        sequenceNumber: json.as("sequence_number"),
        maxGasAmount: json.as("max_gas_amount"),
        gasUnitPrice: json.as("gas_unit_price"),
        expirationTimestampSecs: json.as("expiration_timestamp_secs"),
        payload: AptosApiTransactionPayload.froMJson(json.asMap("payload")),
        signature:
            json.mybeAs<AptosApiTransactionSignature, Map<String, dynamic>>(
                key: "signature",
                onValue: (e) => AptosApiTransactionSignature.fromJson(e)),
        events: json
            .asListOfMap("events")!
            .map((e) => AptosApiEvent.fromJson(e))
            .toList(),
        timeStamp: json.as("timestamp"));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "type": type.name,
      "hash": hash,
      "state_change_hash": stateChangeHash,
      "event_root_hash": eventRootHash,
      "state_checkpoint_hash": stateCheckpointHash,
      "success": success,
      "vm_status": vmStatus,
      "accumulator_root_hash": accumulatorRootHash,
      "changes": changes.map((e) => e.toJson()).toList(),
      "gas_used": gasUsed,
      "sender": sender,
      "sequence_number": sequenceNumber,
      "max_gas_amount": maxGasAmount,
      "gas_unit_price": gasUnitPrice,
      "expiration_timestamp_secs": expirationTimestampSecs,
      "payload": payload.toJson(),
      "signature": signature?.toJson(),
      "events": events.map((e) => e.toJson()).toList(),
      "timestamp": timeStamp
    };
  }
}

class AptosApiGenesisTransaction extends AptosApiTransaction {
  final String version;
  final String hash;
  final String stateChangeHash;
  final String eventRootHash;
  final String? stateCheckpointHash;
  final String gasUsed;
  final bool success;
  final String vmStatus;
  final String accumulatorRootHash;
  final List<AptosApiWriteSetChange> changes;
  final AptosApiTransactionPayload payload;
  final List<AptosApiEvent> events;
  AptosApiGenesisTransaction({
    required this.version,
    required this.hash,
    required this.stateChangeHash,
    required this.eventRootHash,
    required this.stateCheckpointHash,
    required this.gasUsed,
    required this.success,
    required this.vmStatus,
    required this.accumulatorRootHash,
    required this.changes,
    required this.payload,
    required this.events,
  }) : super(type: AptoApiTransactionType.genesisTransaction);
  factory AptosApiGenesisTransaction.fromJson(Map<String, dynamic> json) {
    return AptosApiGenesisTransaction(
        version: json.as("version"),
        hash: json.as("hash"),
        stateChangeHash: json.as("state_change_hash"),
        eventRootHash: json.as("event_root_hash"),
        stateCheckpointHash: json.as("state_checkpoint_hash"),
        gasUsed: json.as("gas_used"),
        success: json.as("success"),
        vmStatus: json.as("vm_status"),
        accumulatorRootHash: json.as("accumulator_root_hash"),
        changes: json
            .asListOfMap("changes")!
            .map((e) => AptosApiWriteSetChange.fromJson(e))
            .toList(),
        payload: AptosApiTransactionPayload.froMJson(json.asMap("payload")),
        events: json
            .asListOfMap("events")!
            .map((e) => AptosApiEvent.fromJson(e))
            .toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "type": type.name,
      "hash": hash,
      "state_change_hash": stateChangeHash,
      "event_root_hash": eventRootHash,
      "state_checkpoint_hash": stateCheckpointHash,
      "gas_used": gasUsed,
      "success": success,
      "vm_status": vmStatus,
      "accumulator_root_hash": accumulatorRootHash,
      "changes": changes.map((e) => e.toJson()).toList(),
      "payload": payload.toJson(),
      "events": events.map((e) => e.toJson()).toList(),
    };
  }
}

class AptosApiBlockMetadataTransaction extends AptosApiTransaction {
  final String version;
  final String hash;
  final String stateChangeHash;
  final String eventRootHash;
  final String? stateCheckpointHash;
  final String gasUsed;
  final bool success;
  final String vmStatus;
  final String accumulatorRootHash;
  final List<AptosApiWriteSetChange> changes;
  final String id;
  final String epoch;
  final String round;
  final List<AptosApiEvent> events;
  final List<int> previousBlockVotesBitVec;
  final String proposer;
  final List<int> failedProposerIndices;
  final String timestamp;
  AptosApiBlockMetadataTransaction(
      {required this.version,
      required this.hash,
      required this.stateChangeHash,
      required this.eventRootHash,
      required this.stateCheckpointHash,
      required this.gasUsed,
      required this.success,
      required this.vmStatus,
      required this.accumulatorRootHash,
      required this.changes,
      required this.id,
      required this.epoch,
      required this.round,
      required this.proposer,
      required this.previousBlockVotesBitVec,
      required this.failedProposerIndices,
      required this.events,
      required this.timestamp})
      : super(type: AptoApiTransactionType.blockMetadataTransaction);
  factory AptosApiBlockMetadataTransaction.fromJson(Map<String, dynamic> json) {
    return AptosApiBlockMetadataTransaction(
        version: json.as("version"),
        hash: json.as("hash"),
        stateChangeHash: json.as("state_change_hash"),
        eventRootHash: json.as("event_root_hash"),
        stateCheckpointHash: json.as("state_checkpoint_hash"),
        gasUsed: json.as("gas_used"),
        success: json.as("success"),
        vmStatus: json.as("vm_status"),
        accumulatorRootHash: json.as("accumulator_root_hash"),
        changes: json
            .asListOfMap("changes")!
            .map((e) => AptosApiWriteSetChange.fromJson(e))
            .toList(),
        epoch: json.as("epoch"),
        id: json.as("id"),
        proposer: json.as("proposer"),
        round: json.as("round"),
        timestamp: json.as("timestamp"),
        previousBlockVotesBitVec: json.asBytes("previous_block_votes_bitvec"),
        failedProposerIndices: json.as<List>("failed_proposer_indices").cast(),
        events: json
            .asListOfMap("events")!
            .map((e) => AptosApiEvent.fromJson(e))
            .toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "type": type.name,
      "hash": hash,
      "state_change_hash": stateChangeHash,
      "event_root_hash": eventRootHash,
      "state_checkpoint_hash": stateCheckpointHash,
      "gas_used": gasUsed,
      "success": success,
      "vm_status": vmStatus,
      "accumulator_root_hash": accumulatorRootHash,
      "changes": changes.map((e) => e.toJson()).toList(),
      "id": id,
      "epoch": epoch,
      "round": round,
      "proposer": proposer,
      "previous_block_votes_bitvec": previousBlockVotesBitVec,
      "failed_proposer_indices": failedProposerIndices,
      "timestamp": timestamp,
      "events": events.map((e) => e.toJson()).toList(),
    };
  }
}

class AptosApiStateCheckpointTransaction extends AptosApiTransaction {
  final String version;
  final String hash;
  final String stateChangeHash;
  final String eventRootHash;
  final String? stateCheckpointHash;
  final String gasUsed;
  final bool success;
  final String vmStatus;
  final String accumulatorRootHash;
  final List<AptosApiWriteSetChange> changes;
  final String timestamp;
  AptosApiStateCheckpointTransaction({
    required this.version,
    required this.hash,
    required this.stateChangeHash,
    required this.eventRootHash,
    required this.stateCheckpointHash,
    required this.gasUsed,
    required this.success,
    required this.vmStatus,
    required this.accumulatorRootHash,
    required this.changes,
    required this.timestamp,
  }) : super(type: AptoApiTransactionType.stateCheckpointTransaction);
  factory AptosApiStateCheckpointTransaction.fromJson(
      Map<String, dynamic> json) {
    return AptosApiStateCheckpointTransaction(
        version: json.as("version"),
        hash: json.as("hash"),
        stateChangeHash: json.as("state_change_hash"),
        eventRootHash: json.as("event_root_hash"),
        stateCheckpointHash: json.as("state_checkpoint_hash"),
        gasUsed: json.as("gas_used"),
        success: json.as("success"),
        vmStatus: json.as("vm_status"),
        accumulatorRootHash: json.as("accumulator_root_hash"),
        changes: json
            .asListOfMap("changes")!
            .map((e) => AptosApiWriteSetChange.fromJson(e))
            .toList(),
        timestamp: json.as("timestamp"));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "type": type.name,
      "hash": hash,
      "state_change_hash": stateChangeHash,
      "event_root_hash": eventRootHash,
      "state_checkpoint_hash": stateCheckpointHash,
      "gas_used": gasUsed,
      "success": success,
      "vm_status": vmStatus,
      "accumulator_root_hash": accumulatorRootHash,
      "changes": changes.map((e) => e.toJson()).toList(),
      "timestamp": timestamp
    };
  }
}

class AptosApiValidatorTransaction extends AptosApiTransaction {
  final String version;
  final String hash;
  final String stateChangeHash;
  final String eventRootHash;
  final String? stateCheckpointHash;
  final String gasUsed;
  final bool success;
  final String vmStatus;
  final String accumulatorRootHash;
  final List<AptosApiWriteSetChange> changes;
  final List<AptosApiEvent> events;
  final String timestamp;
  AptosApiValidatorTransaction({
    required this.version,
    required this.hash,
    required this.stateChangeHash,
    required this.eventRootHash,
    required this.stateCheckpointHash,
    required this.gasUsed,
    required this.success,
    required this.vmStatus,
    required this.accumulatorRootHash,
    required this.changes,
    required this.timestamp,
    required this.events,
  }) : super(type: AptoApiTransactionType.validatorTransaction);
  factory AptosApiValidatorTransaction.fromJson(Map<String, dynamic> json) {
    return AptosApiValidatorTransaction(
        version: json.as("version"),
        hash: json.as("hash"),
        stateChangeHash: json.as("state_change_hash"),
        eventRootHash: json.as("event_root_hash"),
        stateCheckpointHash: json.as("state_checkpoint_hash"),
        gasUsed: json.as("gas_used"),
        success: json.as("success"),
        vmStatus: json.as("vm_status"),
        accumulatorRootHash: json.as("accumulator_root_hash"),
        changes: json
            .asListOfMap("changes")!
            .map((e) => AptosApiWriteSetChange.fromJson(e))
            .toList(),
        events: json
            .asListOfMap("events")!
            .map((e) => AptosApiEvent.fromJson(e))
            .toList(),
        timestamp: json.as("timestamp"));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "type": type.name,
      "hash": hash,
      "state_change_hash": stateChangeHash,
      "event_root_hash": eventRootHash,
      "state_checkpoint_hash": stateCheckpointHash,
      "gas_used": gasUsed,
      "success": success,
      "vm_status": vmStatus,
      "accumulator_root_hash": accumulatorRootHash,
      "changes": changes.map((e) => e.toJson()).toList(),
      "events": events.map((e) => e.toJson()).toList(),
      "timestamp": timestamp
    };
  }
}

class AptosApiBlockEpilogueTransaction extends AptosApiTransaction {
  final String version;
  final String hash;
  final String stateChangeHash;
  final String eventRootHash;
  final String? stateCheckpointHash;
  final String gasUsed;
  final bool success;
  final String vmStatus;
  final String accumulatorRootHash;
  final List<AptosApiWriteSetChange> changes;
  final String timestamp;
  final AptosApiBlockEndInfo? blockEndInfo;
  AptosApiBlockEpilogueTransaction({
    required this.version,
    required this.hash,
    required this.stateChangeHash,
    required this.eventRootHash,
    required this.stateCheckpointHash,
    required this.gasUsed,
    required this.success,
    required this.vmStatus,
    required this.accumulatorRootHash,
    required this.changes,
    required this.timestamp,
    required this.blockEndInfo,
  }) : super(type: AptoApiTransactionType.blockEpilogueTransaction);
  factory AptosApiBlockEpilogueTransaction.fromJson(Map<String, dynamic> json) {
    return AptosApiBlockEpilogueTransaction(
        version: json.as("version"),
        hash: json.as("hash"),
        stateChangeHash: json.as("state_change_hash"),
        eventRootHash: json.as("event_root_hash"),
        stateCheckpointHash: json.as("state_checkpoint_hash"),
        gasUsed: json.as("gas_used"),
        success: json.as("success"),
        vmStatus: json.as("vm_status"),
        accumulatorRootHash: json.as("accumulator_root_hash"),
        changes: json
            .asListOfMap("changes")!
            .map((e) => AptosApiWriteSetChange.fromJson(e))
            .toList(),
        blockEndInfo: json.mybeAs<AptosApiBlockEndInfo, Map<String, dynamic>>(
          key: "block_end_info",
          onValue: (e) => AptosApiBlockEndInfo.fromJson(e),
        ),
        timestamp: json.as("timestamp"));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "type": type.name,
      "hash": hash,
      "state_change_hash": stateChangeHash,
      "event_root_hash": eventRootHash,
      "state_checkpoint_hash": stateCheckpointHash,
      "gas_used": gasUsed,
      "success": success,
      "vm_status": vmStatus,
      "accumulator_root_hash": accumulatorRootHash,
      "changes": changes.map((e) => e.toJson()).toList(),
      "block_end_info": blockEndInfo?.toJson(),
      "timestamp": timestamp
    };
  }
}

class AptosApiBlockEndInfo {
  final bool blockGasLimitReached;
  final bool blockOutputLimitReached;
  final int blockEffectiveBlockGasUnits;
  final int blockApproxOutputSize;
  const AptosApiBlockEndInfo(
      {required this.blockApproxOutputSize,
      required this.blockOutputLimitReached,
      required this.blockEffectiveBlockGasUnits,
      required this.blockGasLimitReached});
  factory AptosApiBlockEndInfo.fromJson(Map<String, dynamic> json) {
    return AptosApiBlockEndInfo(
        blockGasLimitReached: json.as("block_gas_limit_reached"),
        blockApproxOutputSize: json.as("block_approx_output_size"),
        blockEffectiveBlockGasUnits: json.as("block_effective_block_gas_units"),
        blockOutputLimitReached: json.as("block_output_limit_reached"));
  }
  Map<String, dynamic> toJson() {
    return {
      "block_gas_limit_reached": blockGasLimitReached,
      "block_approx_output_size": blockApproxOutputSize,
      "block_effective_block_gas_units": blockEffectiveBlockGasUnits,
      "block_output_limit_reached": blockOutputLimitReached
    };
  }
}

class AptosApiEventGuid {
  final String creationNumber;
  final String accountAddress;
  const AptosApiEventGuid(
      {required this.creationNumber, required this.accountAddress});
  factory AptosApiEventGuid.fromJson(Map<String, dynamic> json) {
    return AptosApiEventGuid(
        creationNumber: json.as("creation_number"),
        accountAddress: json.as("account_address"));
  }
  Map<String, dynamic> toJson() {
    return {
      "creation_number": creationNumber,
      "account_address": accountAddress
    };
  }
}

class AptosApiEvent {
  final AptosApiEventGuid guid;
  final String sequenceNumber;
  final String type;
  final Object data;
  const AptosApiEvent(
      {required this.guid,
      required this.sequenceNumber,
      required this.type,
      required this.data});
  factory AptosApiEvent.fromJson(Map<String, dynamic> json) {
    return AptosApiEvent(
        guid: AptosApiEventGuid.fromJson(json.asMap("guid")),
        sequenceNumber: json.as("sequence_number"),
        data: json.as("data"),
        type: json.as("type"));
  }
  Map<String, dynamic> toJson() {
    return {
      "guid": guid.toJson(),
      "sequence_number": sequenceNumber,
      "data": data,
      "type": type
    };
  }
}

enum AptosApiWriteSetChangeType {
  deleteModule("delete_module"),
  deleteResource("delete_resource"),
  deleteTableItem("delete_table_item"),
  writeModule("write_module"),
  writeResource("write_resource"),
  writeTableItem("write_table_item");

  final String name;
  const AptosApiWriteSetChangeType(this.name);
  static AptosApiWriteSetChangeType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct write set change from the given name.",
            details: {"name": name}));
  }
}

abstract class AptosApiWriteSetChange {
  final AptosApiWriteSetChangeType type;
  const AptosApiWriteSetChange({required this.type});
  Map<String, dynamic> toJson();
  factory AptosApiWriteSetChange.fromJson(Map<String, dynamic> json) {
    final type = AptosApiWriteSetChangeType.fromName(json.as("type"));
    return switch (type) {
      AptosApiWriteSetChangeType.deleteModule =>
        AptosApiWriteSetChangeDeleteModule.fromJson(json),
      AptosApiWriteSetChangeType.deleteResource =>
        AptosApiWriteSetChangeDeleteResource.fromJson(json),
      AptosApiWriteSetChangeType.deleteTableItem =>
        AptosApiWriteSetChangeDeleteTableItem.fromJson(json),
      AptosApiWriteSetChangeType.writeModule =>
        AptosApiWriteSetChangeWriteModule.fromJson(json),
      AptosApiWriteSetChangeType.writeResource =>
        AptosApiWriteSetChangeWriteResource.fromJson(json),
      AptosApiWriteSetChangeType.writeTableItem =>
        AptosApiWriteSetChangeWriteTableItem.fromJson(json),
    };
  }
}

class AptosApiWriteSetChangeDeleteModule extends AptosApiWriteSetChange {
  AptosApiWriteSetChangeDeleteModule(
      {required this.address, required this.stateKeyHash, required this.module})
      : super(type: AptosApiWriteSetChangeType.deleteModule);
  factory AptosApiWriteSetChangeDeleteModule.fromJson(
      Map<String, dynamic> json) {
    return AptosApiWriteSetChangeDeleteModule(
        address: json.as("address"),
        stateKeyHash: json.as("state_key_hash"),
        module: json.as("module"));
  }
  final String address;
  final String stateKeyHash;
  final String module;

  @override
  Map<String, dynamic> toJson() {
    return {
      "state_key_hash": stateKeyHash,
      "address": address,
      "module": module
    };
  }
}

class AptosApiWriteSetChangeDeleteResource extends AptosApiWriteSetChange {
  AptosApiWriteSetChangeDeleteResource(
      {required this.address,
      required this.stateKeyHash,
      required this.resource})
      : super(type: AptosApiWriteSetChangeType.deleteResource);
  factory AptosApiWriteSetChangeDeleteResource.fromJson(
      Map<String, dynamic> json) {
    return AptosApiWriteSetChangeDeleteResource(
        address: json.as("address"),
        stateKeyHash: json.as("state_key_hash"),
        resource: json.as("resource"));
  }
  final String address;
  final String stateKeyHash;
  final String resource;

  @override
  Map<String, dynamic> toJson() {
    return {
      "state_key_hash": stateKeyHash,
      "address": address,
      "resource": resource
    };
  }
}

class AptosApiDeleteTableData {
  AptosApiDeleteTableData({required this.key, required this.keyType});
  factory AptosApiDeleteTableData.fromJson(Map<String, dynamic> json) {
    return AptosApiDeleteTableData(
        key: json.as("key"), keyType: json.as("key_type"));
  }
  final Object key;
  final String keyType;

  Map<String, dynamic> toJson() {
    return {"key": key, "key_type": keyType};
  }
}

class AptosApiWriteSetChangeDeleteTableItem extends AptosApiWriteSetChange {
  AptosApiWriteSetChangeDeleteTableItem(
      {required this.handle,
      required this.stateKeyHash,
      required this.key,
      this.data})
      : super(type: AptosApiWriteSetChangeType.deleteTableItem);
  factory AptosApiWriteSetChangeDeleteTableItem.fromJson(
      Map<String, dynamic> json) {
    return AptosApiWriteSetChangeDeleteTableItem(
        handle: json.as("handle"),
        key: json.as("key"),
        stateKeyHash: json.as("state_key_hash"),
        data: json.mybeAs<AptosApiDeleteTableData, Map<String, dynamic>>(
            key: "data", onValue: (e) => AptosApiDeleteTableData.fromJson(e)));
  }
  final String stateKeyHash;
  final String handle;
  final String key;
  final AptosApiDeleteTableData? data;

  @override
  Map<String, dynamic> toJson() {
    return {
      "state_key_hash": stateKeyHash,
      "handle": handle,
      "key": key,
      "data": data?.toJson()
    };
  }
}

class AptosApiWriteSetChangeWriteModule extends AptosApiWriteSetChange {
  AptosApiWriteSetChangeWriteModule(
      {required this.address, required this.stateKeyHash, required this.data})
      : super(type: AptosApiWriteSetChangeType.writeModule);
  factory AptosApiWriteSetChangeWriteModule.fromJson(
      Map<String, dynamic> json) {
    return AptosApiWriteSetChangeWriteModule(
        address: json.as("address"),
        stateKeyHash: json.as("state_key_hash"),
        data: AptosApiMoveModuleByteCode.fromJson(json.asMap("data")));
  }
  final String stateKeyHash;
  final String address;
  final AptosApiMoveModuleByteCode data;

  @override
  Map<String, dynamic> toJson() {
    return {
      "state_key_hash": stateKeyHash,
      "address": address,
      "data": data.toJson()
    };
  }
}

class AptosApiWriteSetChangeWriteResource extends AptosApiWriteSetChange {
  AptosApiWriteSetChangeWriteResource(
      {required this.address, required this.stateKeyHash, required this.data})
      : super(type: AptosApiWriteSetChangeType.writeResource);
  factory AptosApiWriteSetChangeWriteResource.fromJson(
      Map<String, dynamic> json) {
    return AptosApiWriteSetChangeWriteResource(
        address: json.as("address"),
        stateKeyHash: json.as("state_key_hash"),
        data: AptosApiMoveResource.fromJson(json.asMap("data")));
  }
  final String stateKeyHash;
  final String address;
  final AptosApiMoveResource data;

  @override
  Map<String, dynamic> toJson() {
    return {
      "state_key_hash": stateKeyHash,
      "address": address,
      "data": data.toJson()
    };
  }
}

class AptosApiDecodeTableData {
  final Object key;
  final String keyType;
  final Object value;
  final String valueType;
  const AptosApiDecodeTableData(
      {required this.key,
      required this.keyType,
      required this.value,
      required this.valueType});
  factory AptosApiDecodeTableData.fromJson(Map<String, dynamic> json) {
    return AptosApiDecodeTableData(
        key: json.as("key"),
        value: json.as("value"),
        keyType: json.as("key_type"),
        valueType: json.as("value_type"));
  }
  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "value": value,
      "key_type": keyType,
      "value_type": valueType
    };
  }
}

class AptosApiWriteSetChangeWriteTableItem extends AptosApiWriteSetChange {
  AptosApiWriteSetChangeWriteTableItem({
    required this.handle,
    required this.stateKeyHash,
    required this.key,
    required this.value,
    required this.data,
  }) : super(type: AptosApiWriteSetChangeType.writeTableItem);
  factory AptosApiWriteSetChangeWriteTableItem.fromJson(
      Map<String, dynamic> json) {
    return AptosApiWriteSetChangeWriteTableItem(
        handle: json.as("handle"),
        stateKeyHash: json.as("state_key_hash"),
        key: json.as("key"),
        value: json.as("value"),
        data: json.mybeAs<AptosApiDecodeTableData, Map<String, dynamic>>(
            key: "data", onValue: (e) => AptosApiDecodeTableData.fromJson(e)));
  }
  final String stateKeyHash;
  final String handle;
  final String key;
  final String value;

  final AptosApiDecodeTableData? data;

  @override
  Map<String, dynamic> toJson() {
    return {
      "state_key_hash": stateKeyHash,
      "handle": handle,
      "key": key,
      "value": value,
      "data": data?.toJson()
    };
  }
}

class AptosApiBlock {
  final String blockHeight;
  final String blockHash;
  final String blockTimestamp;
  final String firstVersion;
  final String lastVersion;
  final List<AptosApiTransaction>? transactions;
  AptosApiBlock(
      {required this.blockHash,
      required this.blockHeight,
      required this.blockTimestamp,
      required this.firstVersion,
      required this.lastVersion,
      required List<AptosApiTransaction>? transactions})
      : transactions = transactions?.immutable;
  factory AptosApiBlock.fromJson(Map<String, dynamic> json) {
    return AptosApiBlock(
        blockHash: json.as("block_hash"),
        blockHeight: json.as("block_height"),
        blockTimestamp: json.as("block_timestamp"),
        firstVersion: json.as("first_version"),
        lastVersion: json.as("last_version"),
        transactions: json
            .asListOfMap("transactions", throwOnNull: false)
            ?.map((e) => AptosApiTransaction.fromJson(e))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {
      "block_hash": blockHash,
      "block_height": blockHeight,
      "block_timestamp": blockTimestamp,
      "first_version": firstVersion,
      "last_version": lastVersion,
      "transactions": transactions?.map((e) => e.toJson()).toList()
    };
  }
}

class AptosApiGasEstimation {
  final int? deprioritizedGasEstimate;
  final int gasEstimate;
  final int prioritizedGasEstimate;
  AptosApiGasEstimation({
    required this.deprioritizedGasEstimate,
    required this.gasEstimate,
    required this.prioritizedGasEstimate,
  });
  factory AptosApiGasEstimation.fromJson(Map<String, dynamic> json) {
    return AptosApiGasEstimation(
        deprioritizedGasEstimate: json.as("deprioritized_gas_estimate"),
        gasEstimate: json.as("gas_estimate"),
        prioritizedGasEstimate: json.as("prioritized_gas_estimate"));
  }
  Map<String, dynamic> toJson() {
    return {
      "deprioritized_gas_estimate": deprioritizedGasEstimate,
      "gas_estimate": gasEstimate,
      "prioritized_gas_estimate": prioritizedGasEstimate
    };
  }
}

enum AptosApiRoleType {
  validator("validator"),
  fullNode("full_node");

  final String name;
  const AptosApiRoleType(this.name);
  static AptosApiRoleType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct role type from the given name.",
            details: {"name": name}));
  }
}

class AptosApiLedgerInfo {
  final int chainId;
  final String epoch;
  final String ledgerVersion;
  final String oldestLedgerVersion;
  final String ledgerTimestamp;
  final AptosApiRoleType nodeRole;
  final String oldestBlockHeight;
  final String blockHeight;
  final String? gitHash;

  AptosApiLedgerInfo(
      {required this.chainId,
      required this.epoch,
      required this.ledgerVersion,
      required this.oldestLedgerVersion,
      required this.ledgerTimestamp,
      required this.nodeRole,
      required this.oldestBlockHeight,
      required this.blockHeight,
      required this.gitHash});
  factory AptosApiLedgerInfo.fromJson(Map<String, dynamic> json) {
    return AptosApiLedgerInfo(
        chainId: json.as("chain_id"),
        epoch: json.as("epoch"),
        ledgerVersion: json.as("ledger_version"),
        oldestLedgerVersion: json.as("oldest_ledger_version"),
        ledgerTimestamp: json.as("ledger_timestamp"),
        nodeRole: AptosApiRoleType.fromName(json.as("node_role")),
        oldestBlockHeight: json.as("oldest_block_height"),
        blockHeight: json.as("block_height"),
        gitHash: json.as("git_hash"));
  }
  Map<String, dynamic> toJson() {
    return {
      "chain_id": chainId,
      "epoch": epoch,
      "ledger_version": ledgerVersion,
      "oldest_ledger_version": oldestLedgerVersion,
      "ledger_timestamp": ledgerTimestamp,
      "node_role": nodeRole.name,
      "oldest_block_height": oldestBlockHeight,
      "block_height": blockHeight,
      "git_hash": gitHash
    };
  }
}

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/aptos/src/transaction/utils/utils.dart';

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
  const TableItemRequestParams({
    required this.key,
    required this.keyType,
    required this.valueType,
  });

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
  ExecuteViewFunctionOfAModuleRequestParams({
    required String function,
    required List<String> typeArguments,
    required List<Object> arguments,
  }) : typeArguments = typeArguments.immutable,
       arguments = arguments.immutable,
       function = AptosTransactionUtils.validateFunction(function);
  Map<String, dynamic> toJson() {
    return {"function": function, "type_arguments": [], "arguments": arguments};
  }
}

class AptosApiAccountData {
  final BigInt sequenceNumber;
  final String authenticationKey;
  const AptosApiAccountData({
    required this.sequenceNumber,
    required this.authenticationKey,
  });
  factory AptosApiAccountData.fromJson(Map<String, dynamic> json) {
    return AptosApiAccountData(
      sequenceNumber: json.valueAsBigInt("sequence_number"),
      authenticationKey: json.valueAs("authentication_key"),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "sequence_number": sequenceNumber.toString(),
      "authentication_key": authenticationKey,
    };
  }
}

class AptosApiMoveResource {
  final String type;
  final Map<dynamic, dynamic> data;
  const AptosApiMoveResource({required this.type, required this.data});
  factory AptosApiMoveResource.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveResource(
      type: json.valueAs("type"),
      data: json.valueAs("data"),
    );
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
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              /// Enum name itself (Visibilty) left untouched to avoid a breaking public-API rename.
              throw BuError(
                DefaultErrorType.notFound,
                "Cannot find Move function visibility from the given name.",
                details: {"name": name},
              ),
    );
  }
}

enum AptosApiMoveAbility {
  store,
  drop,
  key,
  copy;

  static AptosApiMoveAbility fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "Cannot find Move ability from the given name.",
                details: {"name": name},
              ),
    );
  }
}

class AptosApiMoveFunctionGenericTypeParams {
  final List<AptosApiMoveAbility> constraints;
  AptosApiMoveFunctionGenericTypeParams({
    required List<AptosApiMoveAbility> constraints,
  }) : constraints = constraints.immutable;
  factory AptosApiMoveFunctionGenericTypeParams.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiMoveFunctionGenericTypeParams(
      constraints:
          json
              .valueEnsureAsList<String>("constraints")
              .map((e) => AptosApiMoveAbility.fromName(e))
              .toList(),
    );
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
  AptosApiMoveFunction({
    required this.name,
    required this.visibility,
    required this.isEntry,
    required this.isView,
    required List<AptosApiMoveFunctionGenericTypeParams> genericTypeParams,
    required List<String> params,
    required List<String> returnTypes,
  }) : genericTypeParams = genericTypeParams.immutable,
       params = params.immutable,
       returnTypes = returnTypes.immutable;
  factory AptosApiMoveFunction.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveFunction(
      name: json.valueAs("name"),
      visibility: AptosApiMoveFunctionVisibilty.fromName(
        json.valueAs("visibility"),
      ),
      isEntry: json.valueAs("is_entry"),
      isView: json.valueAs("is_view"),
      genericTypeParams:
          json
              .valueEnsureAsList<Map<String, dynamic>>("generic_type_params")
              .map((e) => AptosApiMoveFunctionGenericTypeParams.fromJson(e))
              .toList(),
      params: json.valueEnsureAsList<String>("params"),
      returnTypes: json.valueEnsureAsList<String>("return"),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "visibility": visibility.name,
      "is_entry": isEntry,
      "is_view": isView,
      "generic_type_params": genericTypeParams.map((e) => e.toJson()).toList(),
      "params": params,
      "return": returnTypes,
    };
  }
}

class AptosApiMoveStrictField {
  final String name;
  final String type;
  const AptosApiMoveStrictField({required this.name, required this.type});
  factory AptosApiMoveStrictField.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveStrictField(
      name: json.valueAs("name"),
      type: json.valueAs("type"),
    );
  }
  Map<String, dynamic> toJson() {
    return {"name": name, "type": type};
  }
}

class AptosApiMoveStrunct {
  final String name;
  final bool isNative;
  final bool isEvent;

  final bool? isEnum;
  final List<AptosApiMoveAbility> abilities;
  final List<AptosApiMoveFunctionGenericTypeParams> genericTypeParams;
  final List<AptosApiMoveStrictField> fields;

  final List<AptosApiMoveStructVariant>? variants;
  AptosApiMoveStrunct({
    required this.name,
    required this.isNative,
    required this.isEvent,
    this.isEnum,
    required List<AptosApiMoveAbility> abilities,
    required List<AptosApiMoveFunctionGenericTypeParams> genericTypeParams,
    required List<AptosApiMoveStrictField> fields,
    List<AptosApiMoveStructVariant>? variants,
  }) : genericTypeParams = genericTypeParams.immutable,
       abilities = abilities.immutable,
       fields = fields.immutable,
       variants = variants?.immutable;
  factory AptosApiMoveStrunct.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveStrunct(
      name: json.valueAs("name"),
      isEvent: json.valueAs("is_event"),
      isNative: json.valueAs("is_native"),
      isEnum: json.valueAs<bool?>("is_enum"),
      abilities:
          json
              .valueEnsureAsList<String>("abilities")
              .map((e) => AptosApiMoveAbility.fromName(e))
              .toList(),
      genericTypeParams:
          json
              .valueEnsureAsList<Map<String, dynamic>>("generic_type_params")
              .map((e) => AptosApiMoveFunctionGenericTypeParams.fromJson(e))
              .toList(),
      fields:
          json
              .valueEnsureAsList<Map<String, dynamic>>("fields")
              .map((e) => AptosApiMoveStrictField.fromJson(e))
              .toList(),
      variants:
          json
              .valueAsList<List<Map<String, dynamic>>?>("variants")
              ?.map((e) => AptosApiMoveStructVariant.fromJson(e))
              .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "is_event": isEvent,
      "is_native": isNative,
      "is_enum": isEnum,
      "abilities": abilities.map((e) => e.name).toList(),
      "generic_type_params": genericTypeParams.map((e) => e.toJson()).toList(),
      "fields": fields.map((e) => e.toJson()).toList(),
      "variants": variants?.map((e) => e.toJson()).toList(),
    };
  }
}

class AptosApiMoveStructVariant {
  final String name;
  final List<AptosApiMoveStrictField> fields;
  AptosApiMoveStructVariant({
    required this.name,
    required List<AptosApiMoveStrictField> fields,
  }) : fields = fields.immutable;
  factory AptosApiMoveStructVariant.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveStructVariant(
      name: json.valueAs("name"),
      fields:
          json
              .valueEnsureAsList<Map<String, dynamic>>("fields")
              .map((e) => AptosApiMoveStrictField.fromJson(e))
              .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {"name": name, "fields": fields.map((e) => e.toJson()).toList()};
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
  /// Throws [BuError] if no matching entry function is found,
  /// including details about the searched function name and available entry functions.
  AptosApiMoveFunction findEntryFunction(String functionName) {
    return exposedFunctions.firstWhere(
      (e) => e.isEntry && e.name.toLowerCase() == functionName.toLowerCase(),
      orElse: () {
        throw BuError(
          DefaultErrorType.notFound,
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
  /// Throws [BuError] if no matching view function is found,
  /// including details about the searched function name and available view functions.
  AptosApiMoveFunction findViewFunction(String functionName) {
    return exposedFunctions.firstWhere(
      (e) => e.isView && e.name.toLowerCase() == functionName.toLowerCase(),
      orElse: () {
        throw BuError(
          DefaultErrorType.notFound,
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

  AptosApiMoveModule({
    required this.address,
    required this.name,
    required List<String> friends,
    required List<AptosApiMoveFunction> exposedFunctions,
    required List<AptosApiMoveStrunct> structs,
  }) : friends = friends.immutable,
       exposedFunctions = exposedFunctions.immutable,
       structs = structs.immutable;
  factory AptosApiMoveModule.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveModule(
      address: json.valueAs("address"),
      name: json.valueAs("name"),
      friends: json.valueEnsureAsList<String>("friends"),
      exposedFunctions:
          json
              .valueEnsureAsList<Map<String, dynamic>>("exposed_functions")
              .map((e) => AptosApiMoveFunction.fromJson(e))
              .toList(),
      structs:
          json
              .valueEnsureAsList<Map<String, dynamic>>("structs")
              .map((e) => AptosApiMoveStrunct.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "name": name,
      "friends": friends,
      "exposed_functions": exposedFunctions.map((e) => e.toJson()).toList(),
      "structs": structs.map((e) => e.toJson()).toList(),
    };
  }
}

class AptosApiMoveModuleByteCode {
  final AptosApiMoveModule abi;
  final String byteCode;
  const AptosApiMoveModuleByteCode({required this.abi, required this.byteCode});
  factory AptosApiMoveModuleByteCode.fromJson(Map<String, dynamic> json) {
    return AptosApiMoveModuleByteCode(
      abi: AptosApiMoveModule.fromJson(
        json.valueEnsureAsMap<String, dynamic>("abi"),
      ),
      byteCode: json.valueAs("bytecode"),
    );
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
      abi: json.valueTo<AptosApiMoveFunction?, Map<String, dynamic>>(
        key: "abi",
        parse: (e) => AptosApiMoveFunction.fromJson(e),
      ),
      byteCode: json.valueAs("bytecode"),
    );
  }
  Map<String, dynamic> toJson() {
    return {"abi": abi?.toJson(), "bytecode": byteCode};
  }
}

enum AptosApiTransactionPayloadTye {
  entryFunctionPayload("entry_function_payload"),
  multisigPayload("multisig_payload"),
  scriptPayload("script_payload"),
  encryptedTransactionPayload("encrypted_transaction_payload");

  /// entry_function_payload
  final String name;
  const AptosApiTransactionPayloadTye(this.name);
  static AptosApiTransactionPayloadTye fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct transaction payload from the given name.",
                details: {"name": name},
              ),
    );
  }
}

abstract class AptosApiTransactionPayload {
  final AptosApiTransactionPayloadTye type;
  const AptosApiTransactionPayload({required this.type});
  factory AptosApiTransactionPayload.froMJson(Map<String, dynamic> json) {
    final type = AptosApiTransactionPayloadTye.fromName(json.valueAs("type"));
    return switch (type) {
      AptosApiTransactionPayloadTye.entryFunctionPayload =>
        AptosApiTransactionPayloadEntryFunction.fromJson(json),
      AptosApiTransactionPayloadTye.scriptPayload =>
        AptosApiTransactionPayloadScript.fromJson(json),
      AptosApiTransactionPayloadTye.multisigPayload =>
        AptosApiTransactionPayloadMultisig.fromJson(json),
      AptosApiTransactionPayloadTye.encryptedTransactionPayload =>
        AptosApiTransactionPayloadEncrypted.fromJson(json),
    };
  }
  Map<String, dynamic> toJson();
}

class AptosApiTransactionPayloadEntryFunction
    extends AptosApiTransactionPayload {
  final String function;
  final List<String> typeArguments;
  final List<Object> arguments;
  AptosApiTransactionPayloadEntryFunction({
    required this.function,
    required List<String> typeArguments,
    required List<Object> arguments,
  }) : typeArguments = typeArguments.immutable,
       arguments = arguments.immutable,
       super(type: AptosApiTransactionPayloadTye.entryFunctionPayload);
  factory AptosApiTransactionPayloadEntryFunction.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiTransactionPayloadEntryFunction(
      function: json.valueAs("function"),
      typeArguments: json.valueEnsureAsList<String>("type_arguments"),
      arguments: json.valueAs<List>("arguments").cast(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "function": function,
      "type_arguments": typeArguments,
      "arguments": arguments,
    };
  }
}

class AptosApiTransactionPayloadScript extends AptosApiTransactionPayload {
  final AptosApiMoveScruptByteCode code;
  final List<String> typeArguments;
  final List<Object> arguments;
  AptosApiTransactionPayloadScript({
    required this.code,
    required List<String> typeArguments,
    required List<Object> arguments,
  }) : typeArguments = typeArguments.immutable,
       arguments = arguments.immutable,
       super(type: AptosApiTransactionPayloadTye.scriptPayload);
  factory AptosApiTransactionPayloadScript.fromJson(Map<String, dynamic> json) {
    return AptosApiTransactionPayloadScript(
      code: AptosApiMoveScruptByteCode.fromJson(
        json.valueEnsureAsMap<String, dynamic>("code"),
      ),
      typeArguments: json.valueEnsureAsList<String>("type_arguments"),
      arguments: json.valueAs<List>("arguments").cast(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "code": code.toJson(),
      "type_arguments": typeArguments,
      "arguments": arguments,
    };
  }
}

class AptosApiTransactionPayloadMultisig extends AptosApiTransactionPayload {
  final AptosApiTransactionPayloadEntryFunction? transactionPayload;
  final String multisigAddress;
  AptosApiTransactionPayloadMultisig({
    required this.transactionPayload,
    required this.multisigAddress,
  }) : super(type: AptosApiTransactionPayloadTye.multisigPayload);
  factory AptosApiTransactionPayloadMultisig.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiTransactionPayloadMultisig(
      transactionPayload: json.valueTo<
        AptosApiTransactionPayloadEntryFunction?,
        Map<String, dynamic>
      >(
        key: "transaction_payload",
        parse: (e) => AptosApiTransactionPayloadEntryFunction.fromJson(e),
      ),
      multisigAddress: json.valueAs("multisig_address"),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "multisig_address": multisigAddress,
      "transaction_payload": transactionPayload?.toJson(),
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
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct transaction signature from the given name.",
                details: {"name": name},
              ),
    );
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
    // The OpenAPI spec names this variant `abstract_signature` while older
    // nodes answer `abstraction_signature`; accept both, never break parsing.
    if (name == "abstract_signature") {
      return AptoApiAccountSignatureType.abstractionSignature;
    }
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct account signature from the given name.",
                details: {"name": name},
              ),
    );
  }
}

abstract class AptosApiAccountSignature {
  final AptoApiAccountSignatureType type;
  const AptosApiAccountSignature({required this.type});
  Map<String, dynamic> toJson();
  factory AptosApiAccountSignature.fromJson(Map<String, dynamic> json) {
    final type = AptoApiAccountSignatureType.fromName(json.valueAs("type"));
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
  AptosApiAccountSignatureEd25519Signature({
    required this.publicKey,
    required this.signature,
  }) : super(type: AptoApiAccountSignatureType.ed25519Signature);
  factory AptosApiAccountSignatureEd25519Signature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiAccountSignatureEd25519Signature(
      publicKey: json.valueAs("public_key"),
      signature: json.valueAs("signature"),
    );
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
  AptosApiAccountSignatureAbstractionSignature({
    required this.functionInfo,
    required this.authData,
  }) : super(type: AptoApiAccountSignatureType.abstractionSignature);
  factory AptosApiAccountSignatureAbstractionSignature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiAccountSignatureAbstractionSignature(
      functionInfo: json.valueAs("function_info"),
      authData: json.valueAs("auth_data"),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "function_info": functionInfo,
      "auth_data": authData,
      "type": type.name,
    };
  }
}

class AptosApiAccountSignatureMultiEd25519Signature
    extends AptosApiAccountSignature {
  final List<String> publicKeys;
  final List<String> signatures;
  final int threshold;
  final String bitmap;
  AptosApiAccountSignatureMultiEd25519Signature({
    required List<String> publicKeys,
    required List<String> signatures,
    required this.threshold,
    required this.bitmap,
  }) : publicKeys = publicKeys.immutable,
       signatures = signatures.immutable,
       super(type: AptoApiAccountSignatureType.multiEd25519Signature);
  factory AptosApiAccountSignatureMultiEd25519Signature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiAccountSignatureMultiEd25519Signature(
      publicKeys: json.valueEnsureAsList<String>("public_keys"),
      signatures: json.valueEnsureAsList<String>("signatures"),
      threshold: json.valueAs("threshold"),
      bitmap: json.valueAs("bitmap"),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "public_keys": publicKeys,
      "signatures": signatures,
      "bitmap": bitmap,
      "threshold": threshold,
      "type": type.name,
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
  }) : publicKeys = publicKeys.immutable,
       signatures = signatures.immutable,
       super(type: AptoApiAccountSignatureType.multiKeySignature);
  factory AptosApiAccountSignatureMultiKeySignature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiAccountSignatureMultiKeySignature(
      publicKeys:
          json
              .valueEnsureAsList<Map<String, dynamic>>("public_keys")
              .map((e) => AptosApiPublicKey.fromJson(e))
              .toList(),
      signatures:
          json
              .valueEnsureAsList<Map<String, dynamic>>("signatures")
              .map((e) => AptosApiIndexedSignature.fromJson(e))
              .toList(),
      signaturesRequired: json.valueAs("signatures_required"),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "public_keys": publicKeys.map((e) => e.toJson()).toList(),
      "signatures": signatures.map((e) => e.toJson()).toList(),
      "signatures_required": signaturesRequired,
      "type": type.name,
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
  AptosApiIndexedSignature({required this.signature, required this.index})
    : super(type: AptoApiAccountSignatureType.multiKeySignature);
  factory AptosApiIndexedSignature.fromJson(Map<String, dynamic> json) {
    return AptosApiIndexedSignature(
      signature: AptosApiSignature.fromJson(
        json.valueEnsureAsMap<String, dynamic>("signature"),
      ),
      index: json.valueAs("index"),
    );
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
  federatedKeyless("federated_keyless"),
  slhDsaSha2128s("slh_dsa__sha2_128s");

  final String name;
  const AptoApiPublicKeyType(this.name);
  static AptoApiPublicKeyType fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct public key from the given name.",
                details: {"name": name},
              ),
    );
  }
}

class AptosApiPublicKey {
  final AptoApiPublicKeyType type;
  final String value;
  const AptosApiPublicKey({required this.type, required this.value});
  factory AptosApiPublicKey.fromJson(Map<String, dynamic> json) {
    return AptosApiPublicKey(
      type: AptoApiPublicKeyType.fromName(json.valueAs("type")),
      value: json.valueAs("value"),
    );
  }
  Map<String, dynamic> toJson() {
    return {"value": value, "type": type.name};
  }
}

class AptosApiAccountSingleKeySignature extends AptosApiAccountSignature {
  final AptosApiPublicKey publicKey;
  final AptosApiSignature signature;
  const AptosApiAccountSingleKeySignature({
    required this.publicKey,
    required this.signature,
  }) : super(type: AptoApiAccountSignatureType.singleKeySignature);
  factory AptosApiAccountSingleKeySignature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiAccountSingleKeySignature(
      publicKey: AptosApiPublicKey.fromJson(json.valueAs("public_key")),
      signature: AptosApiSignature.fromJson(json.valueAs("signature")),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "public_key": publicKey.toJson(),
      "signature": signature.toJson(),
      "type": type.name,
    };
  }
}

enum AptoApiSignatureType {
  ed25519("ed25519"),
  secp256k1Ecdsa("secp256k1_ecdsa"),
  secp256r1Ecdsa("secp256r1_ecdsa"),
  webAuthn("web_authn"),
  keyless("keyless"),
  slhDsaSha2128s("slh_dsa__sha2_128s");

  final String name;
  const AptoApiSignatureType(this.name);
  static AptoApiSignatureType fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct signature from the given name.",
                details: {"name": name},
              ),
    );
  }
}

class AptosApiSignature {
  final AptoApiSignatureType type;
  final String value;
  const AptosApiSignature({required this.type, required this.value});
  factory AptosApiSignature.fromJson(Map<String, dynamic> json) {
    return AptosApiSignature(
      type: AptoApiSignatureType.fromName(json.valueAs("type")),
      value: json.valueAs("value"),
    );
  }
  Map<String, dynamic> toJson() {
    return {"value": value, "type": type.name};
  }
}

abstract class AptosApiTransactionSignature {
  final AptoApiTransactionSignatureType type;
  const AptosApiTransactionSignature({required this.type});
  factory AptosApiTransactionSignature.fromJson(Map<String, dynamic> json) {
    final type = AptoApiTransactionSignatureType.fromName(json.valueAs("type"));
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
  AptosApiTransactionEd25519Signature({
    required this.publicKey,
    required this.signature,
  }) : super(type: AptoApiTransactionSignatureType.ed25519Signature);
  factory AptosApiTransactionEd25519Signature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiTransactionEd25519Signature(
      publicKey: json.valueAs("public_key"),
      signature: json.valueAs("signature"),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "public_key": publicKey, "signature": signature};
  }
}

class AptosApiTransactionSecp256k1EcdsaSignature
    extends AptosApiTransactionSignature {
  final String publicKey;
  final String signature;
  AptosApiTransactionSecp256k1EcdsaSignature({
    required this.publicKey,
    required this.signature,
  }) : super(type: AptoApiTransactionSignatureType.secp256k1EcdsaSignature);
  factory AptosApiTransactionSecp256k1EcdsaSignature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiTransactionSecp256k1EcdsaSignature(
      publicKey: json.valueAs("public_key"),
      signature: json.valueAs("signature"),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "public_key": publicKey, "signature": signature};
  }
}

class AptosApiTransactionMultiEd25519Signature
    extends AptosApiTransactionSignature {
  final List<String> publicKeys;
  final List<String> signatures;
  final int threshold;
  final String bitmap;
  AptosApiTransactionMultiEd25519Signature({
    required List<String> publicKeys,
    required List<String> signatures,
    required this.threshold,
    required this.bitmap,
  }) : publicKeys = publicKeys.immutable,
       signatures = signatures.immutable,
       super(type: AptoApiTransactionSignatureType.multiEd25519Signature);
  factory AptosApiTransactionMultiEd25519Signature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiTransactionMultiEd25519Signature(
      publicKeys: json.valueEnsureAsList<String>("public_keys"),
      signatures: json.valueEnsureAsList<String>("signatures"),
      threshold: json.valueAs("threshold"),
      bitmap: json.valueAs("bitmap"),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "public_keys": publicKeys,
      "signatures": signatures,
      "bitmap": bitmap,
      "threshold": threshold,
    };
  }
}

class AptosApiTransactionMultiAgentSignature
    extends AptosApiTransactionSignature {
  final List<String> secondarySignerAddresses;
  final List<AptosApiAccountSignature> secondarySigners;
  final AptosApiAccountSignature sender;
  AptosApiTransactionMultiAgentSignature({
    required List<String> secondarySignerAddresses,
    required List<AptosApiAccountSignature> secondarySigners,
    required this.sender,
  }) : secondarySignerAddresses = secondarySignerAddresses.immutable,
       secondarySigners = secondarySigners.immutable,
       super(type: AptoApiTransactionSignatureType.multiAgentSignature);
  factory AptosApiTransactionMultiAgentSignature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiTransactionMultiAgentSignature(
      secondarySignerAddresses: json.valueEnsureAsList<String>(
        "secondary_signer_addresses",
      ),
      secondarySigners:
          json
              .valueEnsureAsList<Map<String, dynamic>>("secondary_signers")
              .map((e) => AptosApiAccountSignature.fromJson(e))
              .toList(),
      sender: AptosApiAccountSignature.fromJson(
        json.valueEnsureAsMap<String, dynamic>("sender"),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "secondary_signer_addresses": secondarySignerAddresses,
      "secondary_signers": secondarySigners.map((e) => e.toJson()).toList(),
      "sender": sender.toJson(),
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
  AptosApiTransactionFeePayerSignature({
    required List<String> secondarySignerAddresses,
    required List<AptosApiAccountSignature> secondarySigners,
    required this.sender,
    required this.feePayerAddress,
    required this.feePayerSigner,
  }) : secondarySignerAddresses = secondarySignerAddresses.immutable,
       secondarySigners = secondarySigners.immutable,
       super(type: AptoApiTransactionSignatureType.feePayerSignature);
  factory AptosApiTransactionFeePayerSignature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiTransactionFeePayerSignature(
      secondarySignerAddresses: json.valueEnsureAsList<String>(
        "secondary_signer_addresses",
      ),
      secondarySigners:
          json
              .valueEnsureAsList<Map<String, dynamic>>("secondary_signers")
              .map((e) => AptosApiAccountSignature.fromJson(e))
              .toList(),
      sender: AptosApiAccountSignature.fromJson(
        json.valueEnsureAsMap<String, dynamic>("sender"),
      ),
      feePayerAddress: json.valueAs("fee_payer_address"),
      feePayerSigner: AptosApiAccountSignature.fromJson(
        json.valueEnsureAsMap<String, dynamic>("fee_payer_signer"),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "secondary_signer_addresses": secondarySignerAddresses,
      "secondary_signers": secondarySigners.map((e) => e.toJson()).toList(),
      "sender": sender.toJson(),
      "fee_payer_address": feePayerAddress,
      "fee_payer_signer": feePayerSigner.toJson(),
      "type": type.name,
    };
  }
}

class AptosApiTransactionSingleSenderSignature
    extends AptosApiTransactionSignature {
  final AptosApiAccountSignature signature;
  AptosApiTransactionSingleSenderSignature({required this.signature})
    : super(type: AptoApiTransactionSignatureType.singleSender);
  factory AptosApiTransactionSingleSenderSignature.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey("signatures_required")) {
      return AptosApiTransactionSingleSenderSignature(
        signature: AptosApiAccountSignatureMultiKeySignature.fromJson(json),
      );
    }
    if (json.containsKey("threshold")) {
      return AptosApiTransactionSingleSenderSignature(
        signature: AptosApiAccountSignatureMultiEd25519Signature.fromJson(json),
      );
    }
    if (json.containsKey("function_info")) {
      return AptosApiTransactionSingleSenderSignature(
        signature: AptosApiAccountSignatureAbstractionSignature.fromJson(json),
      );
    }
    if (json["public_key"] is String) {
      return AptosApiTransactionSingleSenderSignature(
        signature: AptosApiAccountSignatureEd25519Signature.fromJson(json),
      );
    }
    if (json.containsKey("public_key")) {
      return AptosApiTransactionSingleSenderSignature(
        signature: AptosApiAccountSingleKeySignature.fromJson(json),
      );
    }
    return AptosApiTransactionSingleSenderSignature(
      signature: AptosApiAccountSignatureNoAccountSignature(),
    );
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
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct transaction from the given name.",
                details: {"name": name},
              ),
    );
  }
}

abstract class AptosApiTransaction {
  final AptoApiTransactionType type;
  const AptosApiTransaction({required this.type});
  Map<String, dynamic> toJson();
  factory AptosApiTransaction.fromJson(Map<String, dynamic> json) {
    final type = AptoApiTransactionType.fromName(json.valueAs("type"));
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
  AptosApiPendingTransaction({
    required this.hash,
    required this.sender,
    required this.sequenceNumber,
    required this.maxGasAmount,
    required this.gasUnitPrice,
    required this.expirationTimestampSecs,
    required this.payload,
    this.signature,
  }) : super(type: AptoApiTransactionType.pendingTransaction);
  factory AptosApiPendingTransaction.fromJson(Map<String, dynamic> json) {
    return AptosApiPendingTransaction(
      hash: json.valueAs("hash"),
      sender: json.valueAs("sender"),
      sequenceNumber: json.valueAs("sequence_number"),
      maxGasAmount: json.valueAs("max_gas_amount"),
      gasUnitPrice: json.valueAs("gas_unit_price"),
      expirationTimestampSecs: json.valueAs("expiration_timestamp_secs"),
      payload: AptosApiTransactionPayload.froMJson(
        json.valueEnsureAsMap<String, dynamic>("payload"),
      ),
      signature: json
          .valueTo<AptosApiTransactionSignature?, Map<String, dynamic>>(
            key: "signature",
            parse: (e) => AptosApiTransactionSignature.fromJson(e),
          ),
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
  final BigInt gasUsed;
  final bool success;
  final String vmStatus;
  final String accumulatorRootHash;
  final List<AptosApiWriteSetChange> changes;
  final String sender;
  final String sequenceNumber;
  final BigInt maxGasAmount;
  final BigInt gasUnitPrice;
  final String expirationTimestampSecs;
  final AptosApiTransactionPayload payload;
  final AptosApiTransactionSignature? signature;
  final List<AptosApiEvent> events;
  final String timeStamp;
  final String? replayProtectionNonce;
  final AptosApiUserTxnLimitsRequest? txnLimitsRequest;
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
    this.replayProtectionNonce,
    this.txnLimitsRequest,
  }) : super(type: AptoApiTransactionType.userTransaction);
  factory AptosApiUserTransaction.fromJson(Map<String, dynamic> json) {
    return AptosApiUserTransaction(
      version: json.valueAs("version"),
      hash: json.valueAs("hash"),
      stateChangeHash: json.valueAs("state_change_hash"),
      eventRootHash: json.valueAs("event_root_hash"),
      stateCheckpointHash: json.valueAs("state_checkpoint_hash"),
      gasUsed: json.valueAsBigInt("gas_used"),
      success: json.valueAs("success"),
      vmStatus: json.valueAs("vm_status"),
      accumulatorRootHash: json.valueAs("accumulator_root_hash"),
      changes:
          json
              .valueEnsureAsList<Map<String, dynamic>>("changes")
              .map((e) => AptosApiWriteSetChange.fromJson(e))
              .toList(),
      sender: json.valueAs("sender"),
      sequenceNumber: json.valueAs("sequence_number"),
      maxGasAmount: json.valueAsBigInt("max_gas_amount"),
      gasUnitPrice: json.valueAsBigInt("gas_unit_price"),
      expirationTimestampSecs: json.valueAs("expiration_timestamp_secs"),
      payload: AptosApiTransactionPayload.froMJson(
        json.valueEnsureAsMap<String, dynamic>("payload"),
      ),
      signature: json
          .valueTo<AptosApiTransactionSignature?, Map<String, dynamic>>(
            key: "signature",
            parse: (e) => AptosApiTransactionSignature.fromJson(e),
          ),
      events:
          json
              .valueEnsureAsList<Map<String, dynamic>>("events")
              .map((e) => AptosApiEvent.fromJson(e))
              .toList(),
      timeStamp: json.valueAs("timestamp"),
      replayProtectionNonce: json.valueAs<String?>("replay_protection_nonce"),
      txnLimitsRequest: json
          .valueTo<AptosApiUserTxnLimitsRequest?, Map<String, dynamic>>(
            key: "txn_limits_request",
            parse: (e) => AptosApiUserTxnLimitsRequest.fromJson(e),
          ),
    );
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
      "timestamp": timeStamp,
      "replay_protection_nonce": replayProtectionNonce,
      "txn_limits_request": txnLimitsRequest?.toJson(),
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
      version: json.valueAs("version"),
      hash: json.valueAs("hash"),
      stateChangeHash: json.valueAs("state_change_hash"),
      eventRootHash: json.valueAs("event_root_hash"),
      stateCheckpointHash: json.valueAs("state_checkpoint_hash"),
      gasUsed: json.valueAs("gas_used"),
      success: json.valueAs("success"),
      vmStatus: json.valueAs("vm_status"),
      accumulatorRootHash: json.valueAs("accumulator_root_hash"),
      changes:
          json
              .valueEnsureAsList<Map<String, dynamic>>("changes")
              .map((e) => AptosApiWriteSetChange.fromJson(e))
              .toList(),
      payload: AptosApiTransactionPayload.froMJson(
        json.valueEnsureAsMap<String, dynamic>("payload"),
      ),
      events:
          json
              .valueEnsureAsList<Map<String, dynamic>>("events")
              .map((e) => AptosApiEvent.fromJson(e))
              .toList(),
    );
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
  final BuBytes previousBlockVotesBitVec;
  final String proposer;
  final List<int> failedProposerIndices;
  final String timestamp;
  final AptosApiBlockMetadataExtension? blockMetadataExtension;
  AptosApiBlockMetadataTransaction({
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
    required this.id,
    required this.epoch,
    required this.round,
    required this.proposer,
    required List<int> previousBlockVotesBitVec,
    required this.failedProposerIndices,
    required this.events,
    required this.timestamp,
    this.blockMetadataExtension,
  }) : previousBlockVotesBitVec = previousBlockVotesBitVec.asImmutableBytes,
       super(type: AptoApiTransactionType.blockMetadataTransaction);
  factory AptosApiBlockMetadataTransaction.fromJson(Map<String, dynamic> json) {
    return AptosApiBlockMetadataTransaction(
      version: json.valueAs("version"),
      hash: json.valueAs("hash"),
      stateChangeHash: json.valueAs("state_change_hash"),
      eventRootHash: json.valueAs("event_root_hash"),
      stateCheckpointHash: json.valueAs("state_checkpoint_hash"),
      gasUsed: json.valueAs("gas_used"),
      success: json.valueAs("success"),
      vmStatus: json.valueAs("vm_status"),
      accumulatorRootHash: json.valueAs("accumulator_root_hash"),
      changes:
          json
              .valueEnsureAsList<Map<String, dynamic>>("changes")
              .map((e) => AptosApiWriteSetChange.fromJson(e))
              .toList(),
      epoch: json.valueAs("epoch"),
      id: json.valueAs("id"),
      proposer: json.valueAs("proposer"),
      round: json.valueAs("round"),
      timestamp: json.valueAs("timestamp"),
      previousBlockVotesBitVec: json.valueAsBytes(
        "previous_block_votes_bitvec",
      ),
      failedProposerIndices:
          json.valueAs<List>("failed_proposer_indices").cast(),
      events:
          json
              .valueEnsureAsList<Map<String, dynamic>>("events")
              .map((e) => AptosApiEvent.fromJson(e))
              .toList(),
      blockMetadataExtension: json
          .valueTo<AptosApiBlockMetadataExtension?, Map<String, dynamic>>(
            key: "block_metadata_extension",
            parse: (e) => AptosApiBlockMetadataExtension.fromJson(e),
          ),
    );
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
      "block_metadata_extension": blockMetadataExtension?.toJson(),
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
    Map<String, dynamic> json,
  ) {
    return AptosApiStateCheckpointTransaction(
      version: json.valueAs("version"),
      hash: json.valueAs("hash"),
      stateChangeHash: json.valueAs("state_change_hash"),
      eventRootHash: json.valueAs("event_root_hash"),
      stateCheckpointHash: json.valueAs("state_checkpoint_hash"),
      gasUsed: json.valueAs("gas_used"),
      success: json.valueAs("success"),
      vmStatus: json.valueAs("vm_status"),
      accumulatorRootHash: json.valueAs("accumulator_root_hash"),
      changes:
          json
              .valueEnsureAsList<Map<String, dynamic>>("changes")
              .map((e) => AptosApiWriteSetChange.fromJson(e))
              .toList(),
      timestamp: json.valueAs("timestamp"),
    );
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
      "timestamp": timestamp,
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
      version: json.valueAs("version"),
      hash: json.valueAs("hash"),
      stateChangeHash: json.valueAs("state_change_hash"),
      eventRootHash: json.valueAs("event_root_hash"),
      stateCheckpointHash: json.valueAs("state_checkpoint_hash"),
      gasUsed: json.valueAs("gas_used"),
      success: json.valueAs("success"),
      vmStatus: json.valueAs("vm_status"),
      accumulatorRootHash: json.valueAs("accumulator_root_hash"),
      changes:
          json
              .valueEnsureAsList<Map<String, dynamic>>("changes")
              .map((e) => AptosApiWriteSetChange.fromJson(e))
              .toList(),
      events:
          json
              .valueEnsureAsList<Map<String, dynamic>>("events")
              .map((e) => AptosApiEvent.fromJson(e))
              .toList(),
      timestamp: json.valueAs("timestamp"),
    );
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
      "timestamp": timestamp,
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
      version: json.valueAs("version"),
      hash: json.valueAs("hash"),
      stateChangeHash: json.valueAs("state_change_hash"),
      eventRootHash: json.valueAs("event_root_hash"),
      stateCheckpointHash: json.valueAs("state_checkpoint_hash"),
      gasUsed: json.valueAs("gas_used"),
      success: json.valueAs("success"),
      vmStatus: json.valueAs("vm_status"),
      accumulatorRootHash: json.valueAs("accumulator_root_hash"),
      changes:
          json
              .valueEnsureAsList<Map<String, dynamic>>("changes")
              .map((e) => AptosApiWriteSetChange.fromJson(e))
              .toList(),
      blockEndInfo: json.valueTo<AptosApiBlockEndInfo?, Map<String, dynamic>>(
        key: "block_end_info",
        parse: (e) => AptosApiBlockEndInfo.fromJson(e),
      ),
      timestamp: json.valueAs("timestamp"),
    );
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
      "timestamp": timestamp,
    };
  }
}

class AptosApiBlockEndInfo {
  final bool blockGasLimitReached;
  final bool blockOutputLimitReached;
  final int blockEffectiveBlockGasUnits;
  final int blockApproxOutputSize;
  const AptosApiBlockEndInfo({
    required this.blockApproxOutputSize,
    required this.blockOutputLimitReached,
    required this.blockEffectiveBlockGasUnits,
    required this.blockGasLimitReached,
  });
  factory AptosApiBlockEndInfo.fromJson(Map<String, dynamic> json) {
    return AptosApiBlockEndInfo(
      blockGasLimitReached: json.valueAs("block_gas_limit_reached"),
      blockApproxOutputSize: json.valueAs("block_approx_output_size"),
      blockEffectiveBlockGasUnits: json.valueAs(
        "block_effective_block_gas_units",
      ),
      blockOutputLimitReached: json.valueAs("block_output_limit_reached"),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "block_gas_limit_reached": blockGasLimitReached,
      "block_approx_output_size": blockApproxOutputSize,
      "block_effective_block_gas_units": blockEffectiveBlockGasUnits,
      "block_output_limit_reached": blockOutputLimitReached,
    };
  }
}

class AptosApiEventGuid {
  final String creationNumber;
  final String accountAddress;
  const AptosApiEventGuid({
    required this.creationNumber,
    required this.accountAddress,
  });
  factory AptosApiEventGuid.fromJson(Map<String, dynamic> json) {
    return AptosApiEventGuid(
      creationNumber: json.valueAs("creation_number"),
      accountAddress: json.valueAs("account_address"),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "creation_number": creationNumber,
      "account_address": accountAddress,
    };
  }
}

class AptosApiEvent {
  final AptosApiEventGuid guid;
  final String sequenceNumber;
  final String type;
  final Object data;
  const AptosApiEvent({
    required this.guid,
    required this.sequenceNumber,
    required this.type,
    required this.data,
  });
  factory AptosApiEvent.fromJson(Map<String, dynamic> json) {
    return AptosApiEvent(
      guid: AptosApiEventGuid.fromJson(
        json.valueEnsureAsMap<String, dynamic>("guid"),
      ),
      sequenceNumber: json.valueAs("sequence_number"),
      data: json.valueAs("data"),
      type: json.valueAs("type"),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "guid": guid.toJson(),
      "sequence_number": sequenceNumber,
      "data": data,
      "type": type,
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
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct write set change from the given name.",
                details: {"name": name},
              ),
    );
  }
}

abstract class AptosApiWriteSetChange {
  final AptosApiWriteSetChangeType type;
  const AptosApiWriteSetChange({required this.type});
  Map<String, dynamic> toJson();
  factory AptosApiWriteSetChange.fromJson(Map<String, dynamic> json) {
    final type = AptosApiWriteSetChangeType.fromName(json.valueAs("type"));
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
  AptosApiWriteSetChangeDeleteModule({
    required this.address,
    required this.stateKeyHash,
    required this.module,
  }) : super(type: AptosApiWriteSetChangeType.deleteModule);
  factory AptosApiWriteSetChangeDeleteModule.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiWriteSetChangeDeleteModule(
      address: json.valueAs("address"),
      stateKeyHash: json.valueAs("state_key_hash"),
      module: json.valueAs("module"),
    );
  }
  final String address;
  final String stateKeyHash;
  final String module;

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "state_key_hash": stateKeyHash,
      "address": address,
      "module": module,
    };
  }
}

class AptosApiWriteSetChangeDeleteResource extends AptosApiWriteSetChange {
  AptosApiWriteSetChangeDeleteResource({
    required this.address,
    required this.stateKeyHash,
    required this.resource,
  }) : super(type: AptosApiWriteSetChangeType.deleteResource);
  factory AptosApiWriteSetChangeDeleteResource.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiWriteSetChangeDeleteResource(
      address: json.valueAs("address"),
      stateKeyHash: json.valueAs("state_key_hash"),
      resource: json.valueAs("resource"),
    );
  }
  final String address;
  final String stateKeyHash;
  final String resource;

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "state_key_hash": stateKeyHash,
      "address": address,
      "resource": resource,
    };
  }
}

class AptosApiDeleteTableData {
  AptosApiDeleteTableData({required this.key, required this.keyType});
  factory AptosApiDeleteTableData.fromJson(Map<String, dynamic> json) {
    return AptosApiDeleteTableData(
      key: json.valueAs("key"),
      keyType: json.valueAs("key_type"),
    );
  }
  final Object key;
  final String keyType;

  Map<String, dynamic> toJson() {
    return {"key": key, "key_type": keyType};
  }
}

class AptosApiWriteSetChangeDeleteTableItem extends AptosApiWriteSetChange {
  AptosApiWriteSetChangeDeleteTableItem({
    required this.handle,
    required this.stateKeyHash,
    required this.key,
    this.data,
  }) : super(type: AptosApiWriteSetChangeType.deleteTableItem);
  factory AptosApiWriteSetChangeDeleteTableItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiWriteSetChangeDeleteTableItem(
      handle: json.valueAs("handle"),
      key: json.valueAs("key"),
      stateKeyHash: json.valueAs("state_key_hash"),
      data: json.valueTo<AptosApiDeleteTableData?, Map<String, dynamic>>(
        key: "data",
        parse: (e) => AptosApiDeleteTableData.fromJson(e),
      ),
    );
  }
  final String stateKeyHash;
  final String handle;
  final String key;
  final AptosApiDeleteTableData? data;

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "state_key_hash": stateKeyHash,
      "handle": handle,
      "key": key,
      "data": data?.toJson(),
    };
  }
}

class AptosApiWriteSetChangeWriteModule extends AptosApiWriteSetChange {
  AptosApiWriteSetChangeWriteModule({
    required this.address,
    required this.stateKeyHash,
    required this.data,
  }) : super(type: AptosApiWriteSetChangeType.writeModule);
  factory AptosApiWriteSetChangeWriteModule.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiWriteSetChangeWriteModule(
      address: json.valueAs("address"),
      stateKeyHash: json.valueAs("state_key_hash"),
      data: AptosApiMoveModuleByteCode.fromJson(
        json.valueEnsureAsMap<String, dynamic>("data"),
      ),
    );
  }
  final String stateKeyHash;
  final String address;
  final AptosApiMoveModuleByteCode data;

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "state_key_hash": stateKeyHash,
      "address": address,
      "data": data.toJson(),
    };
  }
}

class AptosApiWriteSetChangeWriteResource extends AptosApiWriteSetChange {
  AptosApiWriteSetChangeWriteResource({
    required this.address,
    required this.stateKeyHash,
    required this.data,
  }) : super(type: AptosApiWriteSetChangeType.writeResource);
  factory AptosApiWriteSetChangeWriteResource.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiWriteSetChangeWriteResource(
      address: json.valueAs("address"),
      stateKeyHash: json.valueAs("state_key_hash"),
      data: AptosApiMoveResource.fromJson(
        json.valueEnsureAsMap<String, dynamic>("data"),
      ),
    );
  }
  final String stateKeyHash;
  final String address;
  final AptosApiMoveResource data;

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "state_key_hash": stateKeyHash,
      "address": address,
      "data": data.toJson(),
    };
  }
}

class AptosApiDecodeTableData {
  final Object key;
  final String keyType;
  final Object value;
  final String valueType;
  const AptosApiDecodeTableData({
    required this.key,
    required this.keyType,
    required this.value,
    required this.valueType,
  });
  factory AptosApiDecodeTableData.fromJson(Map<String, dynamic> json) {
    return AptosApiDecodeTableData(
      key: json.valueAs("key"),
      value: json.valueAs("value"),
      keyType: json.valueAs("key_type"),
      valueType: json.valueAs("value_type"),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "value": value,
      "key_type": keyType,
      "value_type": valueType,
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
    Map<String, dynamic> json,
  ) {
    return AptosApiWriteSetChangeWriteTableItem(
      handle: json.valueAs("handle"),
      stateKeyHash: json.valueAs("state_key_hash"),
      key: json.valueAs("key"),
      value: json.valueAs("value"),
      data: json.valueTo<AptosApiDecodeTableData?, Map<String, dynamic>>(
        key: "data",
        parse: (e) => AptosApiDecodeTableData.fromJson(e),
      ),
    );
  }
  final String stateKeyHash;
  final String handle;
  final String key;
  final String value;

  final AptosApiDecodeTableData? data;

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "state_key_hash": stateKeyHash,
      "handle": handle,
      "key": key,
      "value": value,
      "data": data?.toJson(),
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
  AptosApiBlock({
    required this.blockHash,
    required this.blockHeight,
    required this.blockTimestamp,
    required this.firstVersion,
    required this.lastVersion,
    required List<AptosApiTransaction>? transactions,
  }) : transactions = transactions?.immutable;
  factory AptosApiBlock.fromJson(Map<String, dynamic> json) {
    return AptosApiBlock(
      blockHash: json.valueAs("block_hash"),
      blockHeight: json.valueAs("block_height"),
      blockTimestamp: json.valueAs("block_timestamp"),
      firstVersion: json.valueAs("first_version"),
      lastVersion: json.valueAs("last_version"),
      transactions:
          json
              .valueAsList<List<Map<String, dynamic>>?>("transactions")
              ?.map((e) => AptosApiTransaction.fromJson(e))
              .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "block_hash": blockHash,
      "block_height": blockHeight,
      "block_timestamp": blockTimestamp,
      "first_version": firstVersion,
      "last_version": lastVersion,
      "transactions": transactions?.map((e) => e.toJson()).toList(),
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
      deprioritizedGasEstimate: json.valueAs("deprioritized_gas_estimate"),
      gasEstimate: json.valueAs("gas_estimate"),
      prioritizedGasEstimate: json.valueAs("prioritized_gas_estimate"),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "deprioritized_gas_estimate": deprioritizedGasEstimate,
      "gas_estimate": gasEstimate,
      "prioritized_gas_estimate": prioritizedGasEstimate,
    };
  }
}

enum AptosApiRoleType {
  validator("validator"),
  fullNode("full_node");

  final String name;
  const AptosApiRoleType(this.name);
  static AptosApiRoleType fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct role type from the given name.",
                details: {"name": name},
              ),
    );
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
  final Object? encryptionKey;

  AptosApiLedgerInfo({
    required this.chainId,
    required this.epoch,
    required this.ledgerVersion,
    required this.oldestLedgerVersion,
    required this.ledgerTimestamp,
    required this.nodeRole,
    required this.oldestBlockHeight,
    required this.blockHeight,
    required this.gitHash,
    this.encryptionKey,
  });
  factory AptosApiLedgerInfo.fromJson(Map<String, dynamic> json) {
    return AptosApiLedgerInfo(
      chainId: json.valueAs("chain_id"),
      epoch: json.valueAs("epoch"),
      ledgerVersion: json.valueAs("ledger_version"),
      oldestLedgerVersion: json.valueAs("oldest_ledger_version"),
      ledgerTimestamp: json.valueAs("ledger_timestamp"),
      nodeRole: AptosApiRoleType.fromName(json.valueAs("node_role")),
      oldestBlockHeight: json.valueAs("oldest_block_height"),
      blockHeight: json.valueAs("block_height"),
      gitHash: json.valueAs("git_hash"),
      encryptionKey: json["encryption_key"],
    );
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
      "git_hash": gitHash,
      "encryption_key": encryptionKey,
    };
  }
}

/// Multipliers for higher transaction limits, expressed as percent of the
/// base limit (100 = 1x, 200 = 2x, 250 = 2.5x).
class AptosApiRequestedMultipliers {
  final String executionMultiplierPercent;
  final String ioMultiplierPercent;
  const AptosApiRequestedMultipliers({
    required this.executionMultiplierPercent,
    required this.ioMultiplierPercent,
  });
  factory AptosApiRequestedMultipliers.fromJson(Map<String, dynamic> json) {
    return AptosApiRequestedMultipliers(
      executionMultiplierPercent: json.valueAs("execution_multiplier_percent"),
      ioMultiplierPercent: json.valueAs("io_multiplier_percent"),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "execution_multiplier_percent": executionMultiplierPercent,
      "io_multiplier_percent": ioMultiplierPercent,
    };
  }
}

enum AptosApiUserTxnLimitsRequestType {
  stakePoolOwner("stake_pool_owner"),
  delegatedVoter("delegated_voter"),
  delegationPoolDelegator("delegation_pool_delegator");

  final String name;
  const AptosApiUserTxnLimitsRequestType(this.name);
  static AptosApiUserTxnLimitsRequestType fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct user txn limits request from the given name.",
                details: {"name": name},
              ),
    );
  }
}

abstract class AptosApiUserTxnLimitsRequest {
  final AptosApiUserTxnLimitsRequestType type;
  final AptosApiRequestedMultipliers multipliers;
  const AptosApiUserTxnLimitsRequest({
    required this.type,
    required this.multipliers,
  });
  Map<String, dynamic> toJson();
  factory AptosApiUserTxnLimitsRequest.fromJson(Map<String, dynamic> json) {
    final type = AptosApiUserTxnLimitsRequestType.fromName(
      json.valueAs("type"),
    );
    return switch (type) {
      AptosApiUserTxnLimitsRequestType.stakePoolOwner =>
        AptosApiStakePoolOwnerLimitsRequest.fromJson(json),
      AptosApiUserTxnLimitsRequestType.delegatedVoter =>
        AptosApiDelegatedVoterLimitsRequest.fromJson(json),
      AptosApiUserTxnLimitsRequestType.delegationPoolDelegator =>
        AptosApiDelegationPoolDelegatorLimitsRequest.fromJson(json),
    };
  }
}

class AptosApiStakePoolOwnerLimitsRequest extends AptosApiUserTxnLimitsRequest {
  const AptosApiStakePoolOwnerLimitsRequest({required super.multipliers})
    : super(type: AptosApiUserTxnLimitsRequestType.stakePoolOwner);
  factory AptosApiStakePoolOwnerLimitsRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiStakePoolOwnerLimitsRequest(
      multipliers: AptosApiRequestedMultipliers.fromJson(
        json.valueEnsureAsMap<String, dynamic>("multipliers"),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "multipliers": multipliers.toJson()};
  }
}

class AptosApiDelegatedVoterLimitsRequest extends AptosApiUserTxnLimitsRequest {
  final String poolAddress;
  const AptosApiDelegatedVoterLimitsRequest({
    required this.poolAddress,
    required super.multipliers,
  }) : super(type: AptosApiUserTxnLimitsRequestType.delegatedVoter);
  factory AptosApiDelegatedVoterLimitsRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiDelegatedVoterLimitsRequest(
      poolAddress: json.valueAs("pool_address"),
      multipliers: AptosApiRequestedMultipliers.fromJson(
        json.valueEnsureAsMap<String, dynamic>("multipliers"),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "pool_address": poolAddress,
      "multipliers": multipliers.toJson(),
    };
  }
}

class AptosApiDelegationPoolDelegatorLimitsRequest
    extends AptosApiUserTxnLimitsRequest {
  final String poolAddress;
  const AptosApiDelegationPoolDelegatorLimitsRequest({
    required this.poolAddress,
    required super.multipliers,
  }) : super(type: AptosApiUserTxnLimitsRequestType.delegationPoolDelegator);
  factory AptosApiDelegationPoolDelegatorLimitsRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiDelegationPoolDelegatorLimitsRequest(
      poolAddress: json.valueAs("pool_address"),
      multipliers: AptosApiRequestedMultipliers.fromJson(
        json.valueEnsureAsMap<String, dynamic>("multipliers"),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "pool_address": poolAddress,
      "multipliers": multipliers.toJson(),
    };
  }
}

enum AptosApiBlockMetadataExtensionType {
  v0("v0"),
  v1("v1"),
  v2("v2"),
  v3("v3");

  final String name;
  const AptosApiBlockMetadataExtensionType(this.name);
  static AptosApiBlockMetadataExtensionType fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct block metadata extension from the given name.",
                details: {"name": name},
              ),
    );
  }
}

abstract class AptosApiBlockMetadataExtension {
  final AptosApiBlockMetadataExtensionType type;
  final String? randomness;
  final String? decryptionKey;
  final String? decryptionRound;
  const AptosApiBlockMetadataExtension({
    required this.type,
    this.randomness,
    this.decryptionKey,
    this.decryptionRound,
  });
  Map<String, dynamic> toJson();
  factory AptosApiBlockMetadataExtension.fromJson(Map<String, dynamic> json) {
    final type = AptosApiBlockMetadataExtensionType.fromName(
      json.valueAs("type"),
    );
    return switch (type) {
      AptosApiBlockMetadataExtensionType.v0 =>
        AptosApiBlockMetadataExtensionEmpty.fromJson(json),
      AptosApiBlockMetadataExtensionType.v1 =>
        AptosApiBlockMetadataExtensionRandomness.fromJson(json),
      AptosApiBlockMetadataExtensionType.v2 =>
        AptosApiBlockMetadataExtensionRandomnessAndDecKey.fromJson(json),
      AptosApiBlockMetadataExtensionType.v3 =>
        AptosApiBlockMetadataExtensionRandomnessAndDecPayload.fromJson(json),
    };
  }
}

class AptosApiBlockMetadataExtensionEmpty
    extends AptosApiBlockMetadataExtension {
  const AptosApiBlockMetadataExtensionEmpty()
    : super(type: AptosApiBlockMetadataExtensionType.v0);
  factory AptosApiBlockMetadataExtensionEmpty.fromJson(
    Map<String, dynamic> json,
  ) {
    return const AptosApiBlockMetadataExtensionEmpty();
  }
  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }
}

class AptosApiBlockMetadataExtensionRandomness
    extends AptosApiBlockMetadataExtension {
  const AptosApiBlockMetadataExtensionRandomness({required super.randomness})
    : super(type: AptosApiBlockMetadataExtensionType.v1);
  factory AptosApiBlockMetadataExtensionRandomness.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiBlockMetadataExtensionRandomness(
      randomness: json.valueAs("randomness"),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "randomness": randomness};
  }
}

class AptosApiBlockMetadataExtensionRandomnessAndDecKey
    extends AptosApiBlockMetadataExtension {
  const AptosApiBlockMetadataExtensionRandomnessAndDecKey({
    required super.randomness,
    required super.decryptionKey,
  }) : super(type: AptosApiBlockMetadataExtensionType.v2);
  factory AptosApiBlockMetadataExtensionRandomnessAndDecKey.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiBlockMetadataExtensionRandomnessAndDecKey(
      randomness: json.valueAs("randomness"),
      decryptionKey: json.valueAs("decryption_key"),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "randomness": randomness,
      "decryption_key": decryptionKey,
    };
  }
}

class AptosApiBlockMetadataExtensionRandomnessAndDecPayload
    extends AptosApiBlockMetadataExtension {
  const AptosApiBlockMetadataExtensionRandomnessAndDecPayload({
    required super.randomness,
    required super.decryptionKey,
    required super.decryptionRound,
  }) : super(type: AptosApiBlockMetadataExtensionType.v3);
  factory AptosApiBlockMetadataExtensionRandomnessAndDecPayload.fromJson(
    Map<String, dynamic> json,
  ) {
    return AptosApiBlockMetadataExtensionRandomnessAndDecPayload(
      randomness: json.valueAs("randomness"),
      decryptionKey: json.valueAs("decryption_key"),
      decryptionRound: json.valueAs("decryption_round"),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "randomness": randomness,
      "decryption_key": decryptionKey,
      "decryption_round": decryptionRound,
    };
  }
}

/// An encrypted payload's claim about the entry function being invoked.
class AptosApiClaimedEntryFunction {
  final String module;
  final String? name;
  const AptosApiClaimedEntryFunction({required this.module, this.name});
  factory AptosApiClaimedEntryFunction.fromJson(Map<String, dynamic> json) {
    return AptosApiClaimedEntryFunction(
      module: json.valueAs("module"),
      name: json.valueAs<String?>("name"),
    );
  }
  Map<String, dynamic> toJson() {
    return {"module": module, "name": name};
  }
}

enum AptosApiEncryptedTransactionPayloadType {
  encryptedPayload("encrypted_payload"),
  decryptedPayload("decrypted_payload"),
  failedDecryptionPayload("failed_decryption_payload");

  final String name;
  const AptosApiEncryptedTransactionPayloadType(this.name);
  static AptosApiEncryptedTransactionPayloadType fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "cannot find correct encrypted transaction payload from the given name.",
                details: {"name": name},
              ),
    );
  }
}

abstract class AptosApiEncryptedTransactionPayload {
  final AptosApiEncryptedTransactionPayloadType type;
  final String payloadHash;
  final String ciphertext;
  final String encryptionEpoch;
  final AptosApiClaimedEntryFunction? claimedEntryFunction;
  const AptosApiEncryptedTransactionPayload({
    required this.type,
    required this.payloadHash,
    required this.ciphertext,
    required this.encryptionEpoch,
    this.claimedEntryFunction,
  });
  Map<String, dynamic> toJson();
  factory AptosApiEncryptedTransactionPayload.fromJson(
    Map<String, dynamic> json,
  ) {
    // REST uses `encrypted_state` to discriminate (flat payload object).
    // Accept legacy `type` as fallback, including the nested envelope
    // shape {"type": "encrypted_transaction_payload", "payload": {...}}
    // where the state tag lives on the inner payload.
    final inner =
        json["payload"] is Map<String, dynamic>
            ? json["payload"] as Map<String, dynamic>
            : json;
    final state =
        inner.valueAs<String?>("encrypted_state") ??
        inner.valueAs<String?>("type");
    final type = AptosApiEncryptedTransactionPayloadType.fromName(state);
    return switch (type) {
      AptosApiEncryptedTransactionPayloadType.encryptedPayload =>
        AptosApiEncryptedPayload.fromJson(inner),
      AptosApiEncryptedTransactionPayloadType.decryptedPayload =>
        AptosApiDecryptedPayload.fromJson(inner),
      AptosApiEncryptedTransactionPayloadType.failedDecryptionPayload =>
        AptosApiFailedDecryptionPayload.fromJson(inner),
    };
  }

  Map<String, dynamic> toJsonBase() {
    return {
      "type": type.name,
      "encrypted_state": type.name,
      "payload_hash": payloadHash,
      "ciphertext": ciphertext,
      "encryption_epoch": encryptionEpoch,
      "claimed_entry_fun": claimedEntryFunction?.toJson(),
    };
  }
}

/// Payload is still encrypted and cannot be read.
class AptosApiEncryptedPayload extends AptosApiEncryptedTransactionPayload {
  const AptosApiEncryptedPayload({
    required super.payloadHash,
    required super.ciphertext,
    required super.encryptionEpoch,
    super.claimedEntryFunction,
  }) : super(type: AptosApiEncryptedTransactionPayloadType.encryptedPayload);
  factory AptosApiEncryptedPayload.fromJson(Map<String, dynamic> json) {
    return AptosApiEncryptedPayload(
      payloadHash: json.valueAs("payload_hash"),
      ciphertext: json.valueAs("ciphertext"),
      encryptionEpoch: json.valueAs("encryption_epoch"),
      claimedEntryFunction: json
          .valueTo<AptosApiClaimedEntryFunction?, Map<String, dynamic>>(
            key: "claimed_entry_fun",
            parse: (e) => AptosApiClaimedEntryFunction.fromJson(e),
          ),
    );
  }
  @override
  Map<String, dynamic> toJson() => toJsonBase();
}

/// Decryption was attempted but failed.
class AptosApiFailedDecryptionPayload
    extends AptosApiEncryptedTransactionPayload {
  const AptosApiFailedDecryptionPayload({
    required super.payloadHash,
    required super.ciphertext,
    required super.encryptionEpoch,
    super.claimedEntryFunction,
  }) : super(
         type: AptosApiEncryptedTransactionPayloadType.failedDecryptionPayload,
       );
  factory AptosApiFailedDecryptionPayload.fromJson(Map<String, dynamic> json) {
    return AptosApiFailedDecryptionPayload(
      payloadHash: json.valueAs("payload_hash"),
      ciphertext: json.valueAs("ciphertext"),
      encryptionEpoch: json.valueAs("encryption_epoch"),
      claimedEntryFunction: json
          .valueTo<AptosApiClaimedEntryFunction?, Map<String, dynamic>>(
            key: "claimed_entry_fun",
            parse: (e) => AptosApiClaimedEntryFunction.fromJson(e),
          ),
    );
  }
  @override
  Map<String, dynamic> toJson() => toJsonBase();
}

/// Payload has been successfully decrypted.
class AptosApiDecryptedPayload extends AptosApiEncryptedTransactionPayload {
  final String decryptionNonce;

  /// The decrypted inner payload, parsed with the regular payload models
  /// when the node exposes it in readable form.
  final AptosApiTransactionPayload? decryptedPayload;
  const AptosApiDecryptedPayload({
    required super.payloadHash,
    required super.ciphertext,
    required super.encryptionEpoch,
    super.claimedEntryFunction,
    required this.decryptionNonce,
    this.decryptedPayload,
  }) : super(type: AptosApiEncryptedTransactionPayloadType.decryptedPayload);
  factory AptosApiDecryptedPayload.fromJson(Map<String, dynamic> json) {
    return AptosApiDecryptedPayload(
      payloadHash: json.valueAs("payload_hash"),
      ciphertext: json.valueAs("ciphertext"),
      encryptionEpoch: json.valueAs("encryption_epoch"),
      claimedEntryFunction: json
          .valueTo<AptosApiClaimedEntryFunction?, Map<String, dynamic>>(
            key: "claimed_entry_fun",
            parse: (e) => AptosApiClaimedEntryFunction.fromJson(e),
          ),
      decryptionNonce: json.valueAs("decryption_nonce"),
      decryptedPayload: json
          .valueTo<AptosApiTransactionPayload?, Map<String, dynamic>>(
            key: "decrypted_payload",
            parse: (e) => AptosApiTransactionPayload.froMJson(e),
          ),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      ...toJsonBase(),
      "decryption_nonce": decryptionNonce,
      "decrypted_payload": decryptedPayload?.toJson(),
    };
  }
}

class AptosApiTransactionPayloadEncrypted extends AptosApiTransactionPayload {
  final AptosApiEncryptedTransactionPayload payload;
  AptosApiTransactionPayloadEncrypted({required this.payload})
    : super(type: AptosApiTransactionPayloadTye.encryptedTransactionPayload);
  factory AptosApiTransactionPayloadEncrypted.fromJson(
    Map<String, dynamic> json,
  ) {
    // Flat REST shape: {"type": "encrypted_transaction_payload",
    // "encrypted_state": ..., "payload_hash": ..., ...}.
    return AptosApiTransactionPayloadEncrypted(
      payload: AptosApiEncryptedTransactionPayload.fromJson(json),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    // Nested envelope shape mirroring fromJson, so inner state tags
    // round-trip: {"type": "encrypted_transaction_payload", "payload": {...}}.
    return {"type": type.name, "payload": payload.toJson()};
  }
}

/// Lightweight per-transaction summary (sender, version, hash, replay protector).
class AptosApiTransactionSummary {
  final String sender;
  final String version;
  final String transactionHash;

  /// Response-flattened replay protector (U64 nonce as string, when present).
  final String? replayProtector;
  const AptosApiTransactionSummary({
    required this.sender,
    required this.version,
    required this.transactionHash,
    this.replayProtector,
  });
  factory AptosApiTransactionSummary.fromJson(Map<String, dynamic> json) {
    return AptosApiTransactionSummary(
      sender: json.valueAs("sender"),
      version: json.valueAs("version"),
      transactionHash: json.valueAs("transaction_hash"),
      replayProtector: json.valueAs<String?>("replay_protector"),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "sender": sender,
      "version": version,
      "transaction_hash": transactionHash,
      "replay_protector": replayProtector,
    };
  }
}

/// API representation of persisted auxiliary transaction information.
class AptosApiPersistedAuxiliaryInfo {
  final int? transactionIndex;
  const AptosApiPersistedAuxiliaryInfo({this.transactionIndex});
  factory AptosApiPersistedAuxiliaryInfo.fromJson(Map<String, dynamic> json) {
    return AptosApiPersistedAuxiliaryInfo(
      transactionIndex: json.valueAs<int?>("transaction_index"),
    );
  }
  Map<String, dynamic> toJson() {
    return {"transaction_index": transactionIndex};
  }
}

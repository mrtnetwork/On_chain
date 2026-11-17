import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

enum SuiDatatypeDescriptorDatatypeKind implements ProtoEnumVariant {
  datatypeKindUnknown(0, 'DATATYPE_KIND_UNKNOWN'),
  struct(1, 'STRUCT'),
  enum_(2, 'ENUM');

  const SuiDatatypeDescriptorDatatypeKind(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiDatatypeDescriptorDatatypeKind fromValue(int? value) {
    value ??= 0;
    return SuiDatatypeDescriptorDatatypeKind.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiDatatypeDescriptorDatatypeKind found for the given value. $value",
                details: {
                  "name": "SuiDatatypeDescriptorDatatypeKind",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiDatatypeDescriptorDatatypeKind from(Object? value) {
    value ??= 0;
    return SuiDatatypeDescriptorDatatypeKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiDatatypeDescriptorDatatypeKind found for the given value. $value",
                details: {
                  "name": "SuiDatatypeDescriptorDatatypeKind",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// An `Ability` classifies what operations are permitted for a given type
enum SuiAbility implements ProtoEnumVariant {
  abilityUnknown(0, 'ABILITY_UNKNOWN'),

  /// Allows values of types with this ability to be copied
  copy(1, 'COPY'),

  /// Allows values of types with this ability to be dropped.
  drop(2, 'DROP'),

  /// Allows values of types with this ability to exist inside a struct in global storage
  store(3, 'STORE'),

  /// Allows the type to serve as a key for global storage operations
  key(4, 'KEY');

  const SuiAbility(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiAbility fromValue(int? value) {
    value ??= 0;
    return SuiAbility.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiAbility found for the given value. $value",
                details: {"name": "SuiAbility", "value": value?.toString()},
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiAbility from(Object? value) {
    value ??= 0;
    return SuiAbility.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiAbility found for the given value. $value",
                details: {"name": "SuiAbility", "value": value?.toString()},
              ),
    );
  }
}

enum SuiOpenSignatureBodyType implements ProtoEnumVariant {
  typeUnknown(0, 'TYPE_UNKNOWN'),
  address(1, 'ADDRESS'),
  bool(2, 'BOOL'),
  u8(3, 'U8'),
  u16(4, 'U16'),
  u32(5, 'U32'),
  u64(6, 'U64'),
  u128(7, 'U128'),
  u256(8, 'U256'),
  vector(9, 'VECTOR'),
  datatype(10, 'DATATYPE'),
  typeParameter(11, 'TYPE_PARAMETER');

  const SuiOpenSignatureBodyType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiOpenSignatureBodyType fromValue(int? value) {
    value ??= 0;
    return SuiOpenSignatureBodyType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiOpenSignatureBodyType found for the given value. $value",
                details: {
                  "name": "SuiOpenSignatureBodyType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiOpenSignatureBodyType from(Object? value) {
    value ??= 0;
    return SuiOpenSignatureBodyType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiOpenSignatureBodyType found for the given value. $value",
                details: {
                  "name": "SuiOpenSignatureBodyType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum SuiFunctionDescriptorVisibility implements ProtoEnumVariant {
  visibilityUnknown(0, 'VISIBILITY_UNKNOWN'),
  private(1, 'PRIVATE'),
  public(2, 'PUBLIC'),
  friend(3, 'FRIEND');

  const SuiFunctionDescriptorVisibility(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiFunctionDescriptorVisibility fromValue(int? value) {
    value ??= 0;
    return SuiFunctionDescriptorVisibility.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiFunctionDescriptorVisibility found for the given value. $value",
                details: {
                  "name": "SuiFunctionDescriptorVisibility",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiFunctionDescriptorVisibility from(Object? value) {
    value ??= 0;
    return SuiFunctionDescriptorVisibility.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiFunctionDescriptorVisibility found for the given value. $value",
                details: {
                  "name": "SuiFunctionDescriptorVisibility",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum SuiOpenSignatureReference implements ProtoEnumVariant {
  referenceUnknown(0, 'REFERENCE_UNKNOWN'),
  immutable(1, 'IMMUTABLE'),
  mutable(2, 'MUTABLE');

  const SuiOpenSignatureReference(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiOpenSignatureReference fromValue(int? value) {
    value ??= 0;
    return SuiOpenSignatureReference.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiOpenSignatureReference found for the given value. $value",
                details: {
                  "name": "SuiOpenSignatureReference",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiOpenSignatureReference from(Object? value) {
    value ??= 0;
    return SuiOpenSignatureReference.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiOpenSignatureReference found for the given value. $value",
                details: {
                  "name": "SuiOpenSignatureReference",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// A Move Package
class SuiPackage extends SuiProtoMessage {
  /// The PackageId of this package
  ///
  /// A package's `storage_id` is the Sui ObjectId of the package on-chain.
  /// Outside of system packages the `storage_id` for every package version is
  /// different.
  final String? storageId;

  /// The PackageId of the first published version of this package.
  ///
  /// A package's `original_id` (sometimes also called its `runtime_id`) is the
  /// `storage_id` of the first version of this package that has been published.
  /// The `original_id`/`runtime_id` is stable across all versions of the
  /// package and does not ever change.
  final String? originalId;

  /// The version of this package
  final BigInt? version;

  /// The modules defined by this package
  final List<SuiModule> modules;

  /// List of datatype origins for mapping datatypes to a package version where
  /// it was first defined
  final List<SuiTypeOrigin> typeOrigins;

  /// The package's transitive dependencies as a mapping from the package's
  /// runtime Id (the Id it is referred to by in other packages) to its
  /// storage Id (the Id it is loaded from on chain).
  final List<SuiLinkage> linkage;

  const SuiPackage({
    this.storageId,
    this.originalId,
    this.version,
    this.modules = const [],
    this.typeOrigins = const [],
    this.linkage = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    storageId,
    originalId,
    version,
    modules,
    typeOrigins,
    linkage,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'storage_id': storageId,
      'original_id': originalId,
      'version': config.encodeBigint(version),
      'modules': modules.map((e) => config.encodeMessage(e)).toList(),
      'type_origins': typeOrigins.map((e) => config.encodeMessage(e)).toList(),
      'linkage': linkage.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiPackage.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiPackage(
      storageId: json.valueAsString<String?>(
        'storage_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      originalId: json.valueAsString<String?>(
        'original_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      version: json.valueAsBigInt<BigInt?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      modules:
          (json.valueEnsureAsList<dynamic>(
                'modules',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiModule, Object>(
                  value: e,
                  parse:
                      (v) => SuiModule.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      typeOrigins:
          (json.valueEnsureAsList<dynamic>(
                'type_origins',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiTypeOrigin, Object>(
                  value: e,
                  parse:
                      (v) => SuiTypeOrigin.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      linkage:
          (json.valueEnsureAsList<dynamic>(
                'linkage',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiLinkage, Object>(
                  value: e,
                  parse:
                      (v) => SuiLinkage.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiPackage.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiPackage(
      storageId: decode.getString<String?>(1),
      originalId: decode.getString<String?>(2),
      version: decode.getBigInt<BigInt?>(3),
      modules:
          decode
              .getListOfBytes(4)
              .map((b) => SuiModule.deserialize(b))
              .toList(),
      typeOrigins:
          decode
              .getListOfBytes(5)
              .map((b) => SuiTypeOrigin.deserialize(b))
              .toList(),
      linkage:
          decode
              .getListOfBytes(6)
              .map((b) => SuiLinkage.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Package;
}

/// A Move Module.
class SuiModule extends SuiProtoMessage {
  /// Name of this module.
  final String? name;

  /// Serialized bytecode of the module.
  final BuBytes? contents;

  /// List of DataTypes defined by this module.
  final List<SuiDatatypeDescriptor> datatypes;

  /// List of Functions defined by this module.
  final List<SuiFunctionDescriptor> functions;

  SuiModule({
    this.name,
    List<int>? contents,
    this.datatypes = const [],
    this.functions = const [],
  }) : contents = contents?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [name, contents, datatypes, functions];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'name': name,
      'contents': config.encodeBinary(contents),
      'datatypes': datatypes.map((e) => config.encodeMessage(e)).toList(),
      'functions': functions.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiModule.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiModule(
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contents: config.decodeBinary<List<int>?>(
        json.valueAs('contents', normalizeKeyLookup: config.normalizeKeys),
      ),
      datatypes:
          (json.valueEnsureAsList<dynamic>(
                'datatypes',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiDatatypeDescriptor, Object>(
                  value: e,
                  parse:
                      (v) => SuiDatatypeDescriptor.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      functions:
          (json.valueEnsureAsList<dynamic>(
                'functions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiFunctionDescriptor, Object>(
                  value: e,
                  parse:
                      (v) => SuiFunctionDescriptor.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiModule.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiModule(
      name: decode.getString<String?>(1),
      contents: decode.getBytes<List<int>?>(2),
      datatypes:
          decode
              .getListOfBytes(3)
              .map((b) => SuiDatatypeDescriptor.deserialize(b))
              .toList(),
      functions:
          decode
              .getListOfBytes(4)
              .map((b) => SuiFunctionDescriptor.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Module;
}

/// List of Constants defined by this module.
/// repeated Constant constants = 5;
/// Describes a Move Datatype.
class SuiDatatypeDescriptor extends SuiProtoMessage {
  /// Fully qualified name of this Datatype.
  ///
  /// This is `&lt;defining_id&gt;::&lt;module&gt;::&lt;name&gt;`
  final String? typeName;

  /// PackageId of the package where this Datatype is defined.
  ///
  /// A type's `defining_id` is the `storage_id` of the package version that first introduced or added that type.
  final String? definingId;

  /// Name of the module where this Datatype is defined
  final String? module;

  /// Name of this Datatype
  final String? name;

  /// This type's abilities
  final List<SuiAbility> abilities;

  /// Ability constraints and phantom status for this type's generic type parameters
  final List<SuiTypeParameter> typeParameters;

  /// Indicates whether this datatype is a 'STRUCT' or an 'ENUM'
  final SuiDatatypeDescriptorDatatypeKind? kind;

  /// Set of fields if this Datatype is a struct.
  ///
  /// The order of the entries is the order of how the fields are defined.
  final List<SuiFieldDescriptor> fields;

  /// Set of variants if this Datatype is an enum.
  ///
  /// The order of the entries is the order of how the variants are defined.
  final List<SuiVariantDescriptor> variants;

  const SuiDatatypeDescriptor({
    this.typeName,
    this.definingId,
    this.module,
    this.name,
    this.abilities = const [],
    this.typeParameters = const [],
    this.kind,
    this.fields = const [],
    this.variants = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.enumType,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.enumType(7, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 9,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    typeName,
    definingId,
    module,
    name,
    abilities,
    typeParameters,
    kind,
    fields,
    variants,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'type_name': typeName,
      'defining_id': definingId,
      'module': module,
      'name': name,
      'abilities': abilities.map((e) => config.encodeEnum(e)).toList(),
      'type_parameters':
          typeParameters.map((e) => config.encodeMessage(e)).toList(),
      'kind': config.encodeEnum(kind),
      'fields': fields.map((e) => config.encodeMessage(e)).toList(),
      'variants': variants.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiDatatypeDescriptor.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiDatatypeDescriptor(
      typeName: json.valueAsString<String?>(
        'type_name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      definingId: json.valueAsString<String?>(
        'defining_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      module: json.valueAsString<String?>(
        'module',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      abilities:
          (json.valueEnsureAsList<dynamic>(
                'abilities',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiAbility, Object>(
                  value: e,
                  parse: (v) => SuiAbility.from(v),
                ),
              )
              .toList(),
      typeParameters:
          (json.valueEnsureAsList<dynamic>(
                'type_parameters',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiTypeParameter, Object>(
                  value: e,
                  parse:
                      (v) => SuiTypeParameter.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      kind: json.valueTo<SuiDatatypeDescriptorDatatypeKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiDatatypeDescriptorDatatypeKind.from(v),
      ),
      fields:
          (json.valueEnsureAsList<dynamic>(
                'fields',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiFieldDescriptor, Object>(
                  value: e,
                  parse:
                      (v) => SuiFieldDescriptor.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      variants:
          (json.valueEnsureAsList<dynamic>(
                'variants',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiVariantDescriptor, Object>(
                  value: e,
                  parse:
                      (v) => SuiVariantDescriptor.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiDatatypeDescriptor.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiDatatypeDescriptor(
      typeName: decode.getString<String?>(1),
      definingId: decode.getString<String?>(2),
      module: decode.getString<String?>(3),
      name: decode.getString<String?>(4),
      abilities: decode.getReapeatedEnum<SuiAbility>(5, SuiAbility.values),
      typeParameters:
          decode
              .getListOfBytes(6)
              .map((b) => SuiTypeParameter.deserialize(b))
              .toList(),
      kind: decode.getEnum<SuiDatatypeDescriptorDatatypeKind?>(
        7,
        SuiDatatypeDescriptorDatatypeKind.values,
      ),
      fields:
          decode
              .getListOfBytes(8)
              .map((b) => SuiFieldDescriptor.deserialize(b))
              .toList(),
      variants:
          decode
              .getListOfBytes(9)
              .map((b) => SuiVariantDescriptor.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2DatatypeDescriptor;
}

/// A generic type parameter used in the declaration of a struct or enum.
class SuiTypeParameter extends SuiProtoMessage {
  /// The type parameter constraints
  final List<SuiAbility> constraints;

  /// Whether the parameter is declared as phantom
  final bool? isPhantom;

  const SuiTypeParameter({this.constraints = const [], this.isPhantom});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.enumType,
        ),
        ProtoFieldConfig.bool(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [constraints, isPhantom];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'constraints': constraints.map((e) => config.encodeEnum(e)).toList(),
      'is_phantom': isPhantom,
    };
  }

  factory SuiTypeParameter.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiTypeParameter(
      constraints:
          (json.valueEnsureAsList<dynamic>(
                'constraints',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiAbility, Object>(
                  value: e,
                  parse: (v) => SuiAbility.from(v),
                ),
              )
              .toList(),
      isPhantom: json.valueAsBool<bool?>(
        'is_phantom',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiTypeParameter.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTypeParameter(
      constraints: decode.getReapeatedEnum<SuiAbility>(1, SuiAbility.values),
      isPhantom: decode.getBool<bool?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2TypeParameter;
}

/// Descriptor of a field that belongs to a struct or enum variant
class SuiFieldDescriptor extends SuiProtoMessage {
  /// Name of the field
  final String? name;

  /// Order or position of the field in the struct or enum variant definition.
  final int? position;

  /// The type of the field
  final SuiOpenSignatureBody? type;

  const SuiFieldDescriptor({this.name, this.position, this.type});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [name, position, type];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'name': name,
      'position': position,
      'type': config.encodeMessage(type),
    };
  }

  factory SuiFieldDescriptor.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiFieldDescriptor(
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      position: json.valueAsInt<int?>(
        'position',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      type: json.valueTo<SuiOpenSignatureBody?, Object>(
        key: 'type',
        parse:
            (v) => SuiOpenSignatureBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiFieldDescriptor.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiFieldDescriptor(
      name: decode.getString<String?>(1),
      position: decode.getInt<int?>(2),
      type: decode.messageTo<SuiOpenSignatureBody?>(
        3,
        (b) => SuiOpenSignatureBody.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2FieldDescriptor;
}

/// Descriptor of an enum variant
class SuiVariantDescriptor extends SuiProtoMessage {
  /// Name of the variant
  final String? name;

  /// Order or position of the variant in the enum definition.
  final int? position;

  /// Set of fields defined by this variant.
  final List<SuiFieldDescriptor> fields;

  const SuiVariantDescriptor({
    this.name,
    this.position,
    this.fields = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [name, position, fields];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'name': name,
      'position': position,
      'fields': fields.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiVariantDescriptor.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiVariantDescriptor(
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      position: json.valueAsInt<int?>(
        'position',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fields:
          (json.valueEnsureAsList<dynamic>(
                'fields',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiFieldDescriptor, Object>(
                  value: e,
                  parse:
                      (v) => SuiFieldDescriptor.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiVariantDescriptor.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiVariantDescriptor(
      name: decode.getString<String?>(1),
      position: decode.getInt<int?>(2),
      fields:
          decode
              .getListOfBytes(3)
              .map((b) => SuiFieldDescriptor.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2VariantDescriptor;
}

/// Representation of a type signature that could appear as a field type for a struct or enum
class SuiOpenSignatureBody extends SuiProtoMessage {
  /// Type of this signature
  final SuiOpenSignatureBodyType? type;

  /// Fully qualified name of the datatype when `type` is `DATATYPE`
  final String? typeName;

  /// Set when `type` is `VECTOR` or `DATATYPE`
  final List<SuiOpenSignatureBody> typeParameterInstantiation;

  /// Position of the type parameter as defined in the containing data type descriptor when `type` is `TYPE_PARAMETER`
  final int? typeParameter;

  const SuiOpenSignatureBody({
    this.type,
    this.typeName,
    this.typeParameterInstantiation = const [],
    this.typeParameter,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.uint32(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    type,
    typeName,
    typeParameterInstantiation,
    typeParameter,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'type': config.encodeEnum(type),
      'type_name': typeName,
      'type_parameter_instantiation':
          typeParameterInstantiation
              .map((e) => config.encodeMessage(e))
              .toList(),
      'type_parameter': typeParameter,
    };
  }

  factory SuiOpenSignatureBody.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiOpenSignatureBody(
      type: json.valueTo<SuiOpenSignatureBodyType?, Object?>(
        key: 'type',
        parse: (v) => SuiOpenSignatureBodyType.from(v),
      ),
      typeName: json.valueAsString<String?>(
        'type_name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      typeParameterInstantiation:
          (json.valueEnsureAsList<dynamic>(
                'type_parameter_instantiation',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiOpenSignatureBody, Object>(
                  value: e,
                  parse:
                      (v) => SuiOpenSignatureBody.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      typeParameter: json.valueAsInt<int?>(
        'type_parameter',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiOpenSignatureBody.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiOpenSignatureBody(
      type: decode.getEnum<SuiOpenSignatureBodyType?>(
        1,
        SuiOpenSignatureBodyType.values,
      ),
      typeName: decode.getString<String?>(2),
      typeParameterInstantiation:
          decode
              .getListOfBytes(3)
              .map((b) => SuiOpenSignatureBody.deserialize(b))
              .toList(),
      typeParameter: decode.getInt<int?>(4),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2OpenSignatureBody;
}

/// Descriptor of a Move function
class SuiFunctionDescriptor extends SuiProtoMessage {
  /// Name of the function
  final String? name;

  /// Whether the function is `public`, `private` or `public(friend)`
  final SuiFunctionDescriptorVisibility? visibility;

  /// Whether the function is marked `entry` or not.
  final bool? isEntry;

  /// Ability constraints for type parameters
  final List<SuiTypeParameter> typeParameters;

  /// Formal parameter types.
  final List<SuiOpenSignature> parameters;

  /// Return types.
  final List<SuiOpenSignature> returns;

  const SuiFunctionDescriptor({
    this.name,
    this.visibility,
    this.isEntry,
    this.typeParameters = const [],
    this.parameters = const [],
    this.returns = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(5, hasOptionalFlags: true),
        ProtoFieldConfig.bool(6, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 7,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 9,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    name,
    visibility,
    isEntry,
    typeParameters,
    parameters,
    returns,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'name': name,
      'visibility': config.encodeEnum(visibility),
      'is_entry': isEntry,
      'type_parameters':
          typeParameters.map((e) => config.encodeMessage(e)).toList(),
      'parameters': parameters.map((e) => config.encodeMessage(e)).toList(),
      'returns': returns.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiFunctionDescriptor.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiFunctionDescriptor(
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      visibility: json.valueTo<SuiFunctionDescriptorVisibility?, Object?>(
        key: 'visibility',
        parse: (v) => SuiFunctionDescriptorVisibility.from(v),
      ),
      isEntry: json.valueAsBool<bool?>(
        'is_entry',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      typeParameters:
          (json.valueEnsureAsList<dynamic>(
                'type_parameters',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiTypeParameter, Object>(
                  value: e,
                  parse:
                      (v) => SuiTypeParameter.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      parameters:
          (json.valueEnsureAsList<dynamic>(
                'parameters',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiOpenSignature, Object>(
                  value: e,
                  parse:
                      (v) => SuiOpenSignature.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      returns:
          (json.valueEnsureAsList<dynamic>(
                'returns',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiOpenSignature, Object>(
                  value: e,
                  parse:
                      (v) => SuiOpenSignature.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiFunctionDescriptor.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiFunctionDescriptor(
      name: decode.getString<String?>(1),
      visibility: decode.getEnum<SuiFunctionDescriptorVisibility?>(
        5,
        SuiFunctionDescriptorVisibility.values,
      ),
      isEntry: decode.getBool<bool?>(6),
      typeParameters:
          decode
              .getListOfBytes(7)
              .map((b) => SuiTypeParameter.deserialize(b))
              .toList(),
      parameters:
          decode
              .getListOfBytes(8)
              .map((b) => SuiOpenSignature.deserialize(b))
              .toList(),
      returns:
          decode
              .getListOfBytes(9)
              .map((b) => SuiOpenSignature.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2FunctionDescriptor;
}

/// Representation of a type signature that could appear as a function parameter or return value.
class SuiOpenSignature extends SuiProtoMessage {
  final SuiOpenSignatureReference? reference;

  final SuiOpenSignatureBody? body;

  const SuiOpenSignature({this.reference, this.body});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [reference, body];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'reference': config.encodeEnum(reference),
      'body': config.encodeMessage(body),
    };
  }

  factory SuiOpenSignature.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiOpenSignature(
      reference: json.valueTo<SuiOpenSignatureReference?, Object?>(
        key: 'reference',
        parse: (v) => SuiOpenSignatureReference.from(v),
      ),
      body: json.valueTo<SuiOpenSignatureBody?, Object>(
        key: 'body',
        parse:
            (v) => SuiOpenSignatureBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiOpenSignature.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiOpenSignature(
      reference: decode.getEnum<SuiOpenSignatureReference?>(
        1,
        SuiOpenSignatureReference.values,
      ),
      body: decode.messageTo<SuiOpenSignatureBody?>(
        2,
        (b) => SuiOpenSignatureBody.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2OpenSignature;
}

/// Identifies a struct and the module it was defined in.
class SuiTypeOrigin extends SuiProtoMessage {
  final String? moduleName;

  final String? datatypeName;

  final String? packageId;

  const SuiTypeOrigin({this.moduleName, this.datatypeName, this.packageId});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [moduleName, datatypeName, packageId];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'module_name': moduleName,
      'datatype_name': datatypeName,
      'package_id': packageId,
    };
  }

  factory SuiTypeOrigin.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiTypeOrigin(
      moduleName: json.valueAsString<String?>(
        'module_name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      datatypeName: json.valueAsString<String?>(
        'datatype_name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      packageId: json.valueAsString<String?>(
        'package_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiTypeOrigin.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTypeOrigin(
      moduleName: decode.getString<String?>(1),
      datatypeName: decode.getString<String?>(2),
      packageId: decode.getString<String?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2TypeOrigin;
}

/// Upgraded package info for the linkage table.
class SuiLinkage extends SuiProtoMessage {
  /// Id of the original package.
  final String? originalId;

  /// Id of the upgraded package.
  final String? upgradedId;

  /// Version of the upgraded package.
  final BigInt? upgradedVersion;

  const SuiLinkage({this.originalId, this.upgradedId, this.upgradedVersion});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [originalId, upgradedId, upgradedVersion];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'original_id': originalId,
      'upgraded_id': upgradedId,
      'upgraded_version': config.encodeBigint(upgradedVersion),
    };
  }

  factory SuiLinkage.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiLinkage(
      originalId: json.valueAsString<String?>(
        'original_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      upgradedId: json.valueAsString<String?>(
        'upgraded_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      upgradedVersion: json.valueAsBigInt<BigInt?>(
        'upgraded_version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiLinkage.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiLinkage(
      originalId: decode.getString<String?>(1),
      upgradedId: decode.getString<String?>(2),
      upgradedVersion: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Linkage;
}

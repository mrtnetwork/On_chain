import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/move_package.dart" as sui_rpc_v2_move_package;

class SuiGetPackageRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiGetPackageResponse> {
    /// Required. The `storage_id` of any version of the requested package.
  ///
  /// When no `selector` is set, the package stored at exactly this id is
  /// returned. When a `selector` is set, `package_id` only identifies the
  /// package's upgrade lineage (via its original id), and the selected
  /// version within that lineage is returned.
  final String? packageId;

    /// Optional. Return the package in `package_id`'s upgrade lineage that
  /// matches one of the following:
  ///
  /// - `version`: the package with exactly this version.
  /// - `at_checkpoint`: the latest package that existed at or before this
  /// checkpoint. The checkpoint must be at or below the highest checkpoint
  /// the server has indexed; larger values fail with `NOT_FOUND` instead of
  /// resolving to the latest known version, so a successful response is
  /// exact as of `at_checkpoint`. Servers that prune history may also fail
  /// with `NOT_FOUND` for checkpoints below their lowest available one.
  ///
  /// If neither is set, the package stored at `package_id` is returned.
  final BigInt? version;

  final BigInt? atCheckpoint;

  const SuiGetPackageRequest({
    this.packageId,
    this.version,
    this.atCheckpoint,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.uint64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        packageId,
        version,
        atCheckpoint,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'package_id': packageId,
      'version': config.encodeBigint(version),
      'at_checkpoint': config.encodeBigint(atCheckpoint),
    };
  }


  factory SuiGetPackageRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetPackageRequest(
      packageId: json.valueAsString<String?>('package_id', normalizeKeyLookup: config.normalizeKeys),
      version: json.valueAsBigInt<BigInt?>('version', normalizeKeyLookup: config.normalizeKeys),
      atCheckpoint: json.valueAsBigInt<BigInt?>('at_checkpoint', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiGetPackageRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetPackageRequest(
      packageId: decode.getString<String?>(1),
      version: decode.getBigInt<BigInt?>(2),
      atCheckpoint: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetPackageRequest;
  @override
  SuiGetPackageResponse onServiceResponse(List<int> bytes) {
    return SuiGetPackageResponse.deserialize(bytes);
  }
  @override
  SuiGetPackageResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiGetPackageResponse.fromJson(json);
  }

}


class SuiGetPackageResponse extends SuiProtoMessage {
    /// The package.
  final sui_rpc_v2_move_package.SuiPackage? package;

  const SuiGetPackageResponse({
    this.package,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        package,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'package': config.encodeMessage(package),
    };
  }


  factory SuiGetPackageResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetPackageResponse(
      package: json.valueTo<sui_rpc_v2_move_package.SuiPackage?, Object>(
        key: 'package',
        parse: (v) => sui_rpc_v2_move_package.SuiPackage.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetPackageResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetPackageResponse(
      package: decode.messageTo<sui_rpc_v2_move_package.SuiPackage?>(1, (b) => sui_rpc_v2_move_package.SuiPackage.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetPackageResponse;

}


class SuiGetDatatypeRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiGetDatatypeResponse> {
    /// Required. The `storage_id` of the requested package.
  final String? packageId;

    /// Required. The name of the requested module.
  final String? moduleName;

    /// Required. The name of the requested datatype.
  final String? name;

  const SuiGetDatatypeRequest({
    this.packageId,
    this.moduleName,
    this.name,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        packageId,
        moduleName,
        name,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'package_id': packageId,
      'module_name': moduleName,
      'name': name,
    };
  }


  factory SuiGetDatatypeRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetDatatypeRequest(
      packageId: json.valueAsString<String?>('package_id', normalizeKeyLookup: config.normalizeKeys),
      moduleName: json.valueAsString<String?>('module_name', normalizeKeyLookup: config.normalizeKeys),
      name: json.valueAsString<String?>('name', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiGetDatatypeRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetDatatypeRequest(
      packageId: decode.getString<String?>(1),
      moduleName: decode.getString<String?>(2),
      name: decode.getString<String?>(3),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetDatatypeRequest;
  @override
  SuiGetDatatypeResponse onServiceResponse(List<int> bytes) {
    return SuiGetDatatypeResponse.deserialize(bytes);
  }
  @override
  SuiGetDatatypeResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiGetDatatypeResponse.fromJson(json);
  }

}


class SuiGetDatatypeResponse extends SuiProtoMessage {
    /// The datatype.
  final sui_rpc_v2_move_package.SuiDatatypeDescriptor? datatype;

  const SuiGetDatatypeResponse({
    this.datatype,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        datatype,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'datatype': config.encodeMessage(datatype),
    };
  }


  factory SuiGetDatatypeResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetDatatypeResponse(
      datatype: json.valueTo<sui_rpc_v2_move_package.SuiDatatypeDescriptor?, Object>(
        key: 'datatype',
        parse: (v) => sui_rpc_v2_move_package.SuiDatatypeDescriptor.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetDatatypeResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetDatatypeResponse(
      datatype: decode.messageTo<sui_rpc_v2_move_package.SuiDatatypeDescriptor?>(1, (b) => sui_rpc_v2_move_package.SuiDatatypeDescriptor.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetDatatypeResponse;

}


class SuiGetFunctionRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiGetFunctionResponse> {
    /// Required. The `storage_id` of the requested package.
  final String? packageId;

    /// Required. The name of the requested module.
  final String? moduleName;

    /// Required. The name of the requested function.
  final String? name;

  const SuiGetFunctionRequest({
    this.packageId,
    this.moduleName,
    this.name,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        packageId,
        moduleName,
        name,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'package_id': packageId,
      'module_name': moduleName,
      'name': name,
    };
  }


  factory SuiGetFunctionRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetFunctionRequest(
      packageId: json.valueAsString<String?>('package_id', normalizeKeyLookup: config.normalizeKeys),
      moduleName: json.valueAsString<String?>('module_name', normalizeKeyLookup: config.normalizeKeys),
      name: json.valueAsString<String?>('name', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiGetFunctionRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetFunctionRequest(
      packageId: decode.getString<String?>(1),
      moduleName: decode.getString<String?>(2),
      name: decode.getString<String?>(3),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetFunctionRequest;
  @override
  SuiGetFunctionResponse onServiceResponse(List<int> bytes) {
    return SuiGetFunctionResponse.deserialize(bytes);
  }
  @override
  SuiGetFunctionResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiGetFunctionResponse.fromJson(json);
  }

}


class SuiGetFunctionResponse extends SuiProtoMessage {
    /// The function.
  final sui_rpc_v2_move_package.SuiFunctionDescriptor? function;

  const SuiGetFunctionResponse({
    this.function,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        function,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'function': config.encodeMessage(function),
    };
  }


  factory SuiGetFunctionResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetFunctionResponse(
      function: json.valueTo<sui_rpc_v2_move_package.SuiFunctionDescriptor?, Object>(
        key: 'function',
        parse: (v) => sui_rpc_v2_move_package.SuiFunctionDescriptor.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetFunctionResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetFunctionResponse(
      function: decode.messageTo<sui_rpc_v2_move_package.SuiFunctionDescriptor?>(1, (b) => sui_rpc_v2_move_package.SuiFunctionDescriptor.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetFunctionResponse;

}


class SuiListPackageVersionsRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiListPackageVersionsResponse> {
    /// Required. The `storage_id` of any version of the package.
  final String? packageId;

    /// The maximum number of versions to return. The service may return fewer than this value.
  /// If unspecified, at most `1000` entries will be returned.
  /// The maximum value is `10000`; values above `10000` will be coerced to `10000`.
  final int? pageSize;

    /// A page token, received from a previous `ListPackageVersions` call.
  /// Provide this to retrieve the subsequent page.
  ///
  /// When paginating, all other parameters provided to `ListPackageVersions` must
  /// match the call that provided the page token.
  final BuBytes? pageToken;

  SuiListPackageVersionsRequest({
    this.packageId,
    this.pageSize,
    List<int>? pageToken,
  }) : 
    pageToken = pageToken?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        packageId,
        pageSize,
        pageToken,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'package_id': packageId,
      'page_size': pageSize,
      'page_token': config.encodeBinary(pageToken),
    };
  }


  factory SuiListPackageVersionsRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiListPackageVersionsRequest(
      packageId: json.valueAsString<String?>('package_id', normalizeKeyLookup: config.normalizeKeys),
      pageSize: json.valueAsInt<int?>('page_size', normalizeKeyLookup: config.normalizeKeys),
      pageToken: config.decodeBinary<List<int>?>(json.valueAs('page_token', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory SuiListPackageVersionsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListPackageVersionsRequest(
      packageId: decode.getString<String?>(1),
      pageSize: decode.getInt<int?>(2),
      pageToken: decode.getBytes<List<int>?>(3),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ListPackageVersionsRequest;
  @override
  SuiListPackageVersionsResponse onServiceResponse(List<int> bytes) {
    return SuiListPackageVersionsResponse.deserialize(bytes);
  }
  @override
  SuiListPackageVersionsResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiListPackageVersionsResponse.fromJson(json);
  }

}


class SuiListPackageVersionsResponse extends SuiProtoMessage {
    /// List of all package versions, ordered by version.
  final List<SuiPackageVersion> versions;

    /// A token, which can be sent as `page_token` to retrieve the next page.
  /// If this field is omitted, there are no subsequent pages.
  final BuBytes? nextPageToken;

  SuiListPackageVersionsResponse({
    this.versions = const [],
    List<int>? nextPageToken,
  }) : 
    nextPageToken = nextPageToken?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        versions,
        nextPageToken,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'versions': versions.map((e) => config.encodeMessage(e)).toList(),
      'next_page_token': config.encodeBinary(nextPageToken),
    };
  }


  factory SuiListPackageVersionsResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiListPackageVersionsResponse(
      versions: (json.valueEnsureAsList<dynamic>('versions', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiPackageVersion, Object>(
          value: e,
          parse: (v) => SuiPackageVersion.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      nextPageToken: config.decodeBinary<List<int>?>(json.valueAs('next_page_token', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory SuiListPackageVersionsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListPackageVersionsResponse(
      versions: decode.getListOfBytes(1).map((b) => SuiPackageVersion.deserialize(b)).toList(),
      nextPageToken: decode.getBytes<List<int>?>(2),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ListPackageVersionsResponse;

}


/// A simplified representation of a package version
class SuiPackageVersion extends SuiProtoMessage {
    /// The storage ID of this package version
  final String? packageId;

    /// The version number
  final BigInt? version;

  const SuiPackageVersion({
    this.packageId,
    this.version,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        packageId,
        version,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'package_id': packageId,
      'version': config.encodeBigint(version),
    };
  }


  factory SuiPackageVersion.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiPackageVersion(
      packageId: json.valueAsString<String?>('package_id', normalizeKeyLookup: config.normalizeKeys),
      version: json.valueAsBigInt<BigInt?>('version', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiPackageVersion.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiPackageVersion(
      packageId: decode.getString<String?>(1),
      version: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2PackageVersion;

}



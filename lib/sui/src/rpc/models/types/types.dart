import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/bcs/move/move.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/transaction/types/types.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class SuiApiRequestPagination {
  final String? cursor;
  final int? limit;
  const SuiApiRequestPagination({this.cursor, this.limit});
  List<dynamic> toJson() {
    return [cursor, limit];
  }
}

abstract class SuiApiResponsePagination {
  final bool hasNextPage;
  final String? nextCursor;
  const SuiApiResponsePagination({this.hasNextPage = false, this.nextCursor});
  SuiApiResponsePagination.fromJson(Map<String, dynamic> json)
      : hasNextPage = json.as("hasNextPage"),
        nextCursor = json.as("nextCursor");
  Map<String, dynamic> toJson() {
    return {"hasNextPage": hasNextPage, "nextCursor": nextCursor};
  }
}

class SuiApiCoinResponse {
  final BigInt balance;
  final SuiAddress coinObjectId;
  final String coinType;
  final String digest;
  final String previousTransaction;
  final BigInt version;
  SuiObjectRef toObjectRef() {
    return SuiObjectRef(
        address: coinObjectId,
        version: version,
        digest: SuiObjectDigest.fromBase58(digest));
  }

  const SuiApiCoinResponse(
      {required this.balance,
      required this.coinObjectId,
      required this.coinType,
      required this.digest,
      required this.previousTransaction,
      required this.version});
  factory SuiApiCoinResponse.fromJson(Map<String, dynamic> json) {
    return SuiApiCoinResponse(
        balance: json.asBigInt("balance"),
        coinObjectId: SuiAddress(json.as("coinObjectId")),
        coinType: json.as("coinType"),
        digest: json.as("digest"),
        previousTransaction: json.as("previousTransaction"),
        version: json.asBigInt("version"));
  }
  Map<String, dynamic> toJson() {
    return {
      "balance": balance.toString(),
      "coinObjectId": coinObjectId,
      "coinType": coinType,
      "digest": digest,
      "previousTransaction": previousTransaction,
      "version": version.toString()
    };
  }
}

class SuiApiBalanceResponse {
  final int coinObjectCount;
  final String coinType;
  final BigInt totalBalance;
  final Map<String, dynamic> lockedBalance;
  const SuiApiBalanceResponse({
    required this.coinObjectCount,
    required this.coinType,
    required this.totalBalance,
    required this.lockedBalance,
  });
  factory SuiApiBalanceResponse.fromJson(Map<String, dynamic> json) {
    return SuiApiBalanceResponse(
        coinObjectCount: json.asInt("coinObjectCount"),
        coinType: json["coinType"],
        totalBalance: json.asBigInt('totalBalance'),
        lockedBalance: json.asMap("lockedBalance"));
  }
  Map<String, dynamic> toJson() {
    return {
      "coinObjectCount": coinObjectCount,
      "coinType": coinType,
      "totalBalance": totalBalance.toString(),
      "lockedBalance": lockedBalance
    };
  }
}

class SuiApiGetCoinResponse extends SuiApiResponsePagination {
  final List<SuiApiCoinResponse> data;
  const SuiApiGetCoinResponse({required this.data});
  SuiApiGetCoinResponse.fromJson(super.json)
      : data = json
            .asListOfMap("data")!
            .map((e) => SuiApiCoinResponse.fromJson(e))
            .toList(),
        super.fromJson();
  @override
  Map<String, dynamic> toJson() {
    return {"data": data.map((e) => e.toJson()).toList(), ...super.toJson()};
  }
}

class SuiApiCoinMetadataResponse {
  /// Number of decimal places the coin uses.
  final int decimals;

  /// Description of the token
  final String description;

  /// URL for the token logo
  final String? iconUrl;

  /// Object id for the CoinMetadata object
  final String? id;

  /// Name for the token
  final String name;

  /// Symbol for the token
  final String symbol;
  const SuiApiCoinMetadataResponse(
      {required this.decimals,
      required this.description,
      required this.iconUrl,
      required this.id,
      required this.name,
      required this.symbol});
  factory SuiApiCoinMetadataResponse.fromJson(Map<String, dynamic> json) {
    return SuiApiCoinMetadataResponse(
        decimals: json.asInt("decimals"),
        description: json.as("description"),
        iconUrl: json.as("iconUrl"),
        id: json.as("id"),
        name: json.as("name"),
        symbol: json.as("symbol"));
  }
  Map<String, dynamic> toJson() {
    return {
      "decimals": decimals,
      "description": description,
      "iconUrl": iconUrl,
      "id": id,
      "name": name,
      "symbol": symbol
    };
  }
}

class SuiApiDynamicFieldName {
  final String type;
  final Object value;
  const SuiApiDynamicFieldName({required this.type, required this.value});
  factory SuiApiDynamicFieldName.fromJson(Map<String, dynamic> json) {
    return SuiApiDynamicFieldName(
        type: json.as("type"), value: json.as("value"));
  }
  Map<String, dynamic> toJson() {
    return {"type": type, "value": value};
  }
}

enum SuiApiDataType {
  moveObject,
  package;

  static SuiApiDataType fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse: () => throw DartSuiPluginException(
          "cannot find correct DataType from the given name.",
          details: {"name": name}),
    );
  }
}

abstract class SuiApiRawDataResponse {
  final SuiApiDataType dataType;
  Map<String, dynamic> toJson();
  const SuiApiRawDataResponse({required this.dataType});
  factory SuiApiRawDataResponse.fromJson(Map<String, dynamic> json) {
    final type = SuiApiDataType.fromName(json.as("dataType"));
    return switch (type) {
      SuiApiDataType.moveObject => SuiApiMoveObject.fromJson(json),
      SuiApiDataType.package => SuiApiRawDataPackage.fromJson(json)
    };
  }
  T cast<T extends SuiApiRawDataResponse>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiRawDataResponse casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiMoveObject extends SuiApiRawDataResponse {
  final String bcsBytes;
  final bool hasPublicTransfer;
  final String type;
  final String version;
  const SuiApiMoveObject(
      {required this.bcsBytes,
      required this.hasPublicTransfer,
      required this.type,
      required this.version})
      : super(dataType: SuiApiDataType.moveObject);
  factory SuiApiMoveObject.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveObject(
        bcsBytes: json.as("bcsBytes"),
        hasPublicTransfer: json.as("hasPublicTransfer"),
        type: json.as("type"),
        version: json.as("version"));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "bcsBytes": bcsBytes,
      "hasPublicTransfer": hasPublicTransfer,
      "type": type,
      "version": version,
      "dataType": dataType.name
    };
  }
}

/// Upgraded package info for the linkage table
class SuiApiUpgradeInfo {
  /// ID of the upgraded packages
  final String upgradeId;

  /// Version of the upgraded package
  final String upgradeVersion;
  const SuiApiUpgradeInfo(
      {required this.upgradeId, required this.upgradeVersion});
  factory SuiApiUpgradeInfo.fromJson(Map<String, dynamic> json) {
    return SuiApiUpgradeInfo(
        upgradeId: json.as("upgraded_id"),
        upgradeVersion: json.as("upgraded_version"));
  }

  Map<String, dynamic> toJson() {
    return {
      "upgraded_version": upgradeVersion,
      "upgraded_id": upgradeId,
    };
  }
}

class SuiApiTypeOrigin {
  final String dataTypeName;
  final String moduleName;
  final String package;
  const SuiApiTypeOrigin(
      {required this.dataTypeName,
      required this.moduleName,
      required this.package});
  factory SuiApiTypeOrigin.fromJson(Map<String, dynamic> json) {
    return SuiApiTypeOrigin(
      dataTypeName: json["datatype_name"],
      moduleName: json["module_name"],
      package: json["package"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "datatype_name": dataTypeName,
      "package": package,
      "module_name": moduleName,
    };
  }
}

class SuiApiRawDataPackage extends SuiApiRawDataResponse {
  final String id;
  final Map<String, SuiApiUpgradeInfo> linkageTable;
  final Map<String, String> moduleMap;
  final List<SuiApiTypeOrigin> typeOriginTable;
  final String version;

  const SuiApiRawDataPackage(
      {required this.id,
      required this.linkageTable,
      required this.moduleMap,
      required this.typeOriginTable,
      required this.version})
      : super(dataType: SuiApiDataType.package);
  factory SuiApiRawDataPackage.fromJson(Map<String, dynamic> json) {
    return SuiApiRawDataPackage(
        id: json.as("id"),
        moduleMap: json.as<Map>("moduleMap").cast<String, String>(),
        version: json.as("version"),
        typeOriginTable: json
            .asListOfMap("typeOriginTable")!
            .map((e) => SuiApiTypeOrigin.fromJson(e))
            .toList(),
        linkageTable: json.asMap<Map<String, dynamic>>("linkageTable").map(
              (k, v) => MapEntry(k, SuiApiUpgradeInfo.fromJson(v)),
            ));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "linkageTable": linkageTable.map((k, v) => MapEntry(k, v.toJson())),
      "id": id,
      "typeOriginTable": typeOriginTable.map((e) => e.toJson()).toList(),
      "moduleMap": moduleMap
    };
  }
}

abstract class SuiApiParsedData {
  final SuiApiDataType dataType;
  Map<String, dynamic> toJson();
  const SuiApiParsedData({required this.dataType});
  factory SuiApiParsedData.fromJson(Map<String, dynamic> json) {
    final type = SuiApiDataType.fromName(json.as("dataType"));
    return switch (type) {
      SuiApiDataType.moveObject => SuiApiParsedDataMoveObject.fromJson(json),
      SuiApiDataType.package => SuiApiParsedDataPackage.fromJson(json)
    };
  }
  T cast<T extends SuiApiParsedData>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiParsedData casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiParsedDataMoveObject extends SuiApiParsedData {
  final Object fields;
  final bool hasPublicTransfer;
  final String type;
  const SuiApiParsedDataMoveObject(
      {required this.fields,
      required this.hasPublicTransfer,
      required this.type})
      : super(dataType: SuiApiDataType.moveObject);
  factory SuiApiParsedDataMoveObject.fromJson(Map<String, dynamic> json) {
    return SuiApiParsedDataMoveObject(
        fields: json.as("fields"),
        hasPublicTransfer: json.as("hasPublicTransfer"),
        type: json.as("type"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "fields": fields,
      "hasPublicTransfer": hasPublicTransfer,
      "type": type,
      "dataType": dataType.name
    };
  }
}

class SuiApiParsedDataPackage extends SuiApiParsedData {
  final Map<String, dynamic> disassembled;
  const SuiApiParsedDataPackage(this.disassembled)
      : super(dataType: SuiApiDataType.package);
  factory SuiApiParsedDataPackage.fromJson(Map<String, dynamic> json) {
    return SuiApiParsedDataPackage(json.asMap("disassembled"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"disassembled": disassembled};
  }
}

enum SuiApiObjectErrors {
  notExists,
  dynamicFieldNotFound,
  deleted,
  unknown,
  displayError;

  static SuiApiObjectErrors fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse: () => throw DartSuiPluginException(
          "cannot find correct Error type from the given name.",
          details: {"name": name}),
    );
  }
}

abstract class SuiApiObjectError {
  final SuiApiObjectErrors code;
  Map<String, dynamic> toJson();
  const SuiApiObjectError({required this.code});
  factory SuiApiObjectError.fromJson(Map<String, dynamic> json) {
    final type = SuiApiObjectErrors.fromName(json.as("code"));
    return switch (type) {
      SuiApiObjectErrors.notExists => SuiApiObjectErrorNotExists.fromJson(json),
      SuiApiObjectErrors.dynamicFieldNotFound =>
        SuiApiObjectErrorDynamicFieldNotFound.fromJson(json),
      SuiApiObjectErrors.deleted => SuiApiObjectErrorDeleted.fromJson(json),
      SuiApiObjectErrors.unknown => SuiApiObjectErrorUnknown(),
      SuiApiObjectErrors.displayError =>
        SuiApiObjectErrorDisplayError.fromJson(json)
    };
  }
  T cast<T extends SuiApiObjectError>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiObjectError casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }

  String get errorMessage;
}

class SuiApiObjectErrorNotExists extends SuiApiObjectError {
  final String objectId;
  const SuiApiObjectErrorNotExists({required this.objectId})
      : super(code: SuiApiObjectErrors.notExists);
  factory SuiApiObjectErrorNotExists.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectErrorNotExists(objectId: json.as("object_id"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"object_id": objectId, "code": code.name};
  }

  @override
  String get errorMessage => "Object $objectId does not exists.";
}

class SuiApiObjectErrorDynamicFieldNotFound extends SuiApiObjectError {
  final String parentObjectId;
  const SuiApiObjectErrorDynamicFieldNotFound({required this.parentObjectId})
      : super(code: SuiApiObjectErrors.dynamicFieldNotFound);
  factory SuiApiObjectErrorDynamicFieldNotFound.fromJson(
      Map<String, dynamic> json) {
    return SuiApiObjectErrorDynamicFieldNotFound(
        parentObjectId: json.as("parent_object_id"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"parent_object_id": parentObjectId, "code": code.name};
  }

  @override
  String get errorMessage => "Dynamic field $parentObjectId not found.";
}

class SuiApiObjectErrorDeleted extends SuiApiObjectError {
  final String digest;
  final String objectId;
  final String version;
  const SuiApiObjectErrorDeleted(
      {required this.digest, required this.objectId, required this.version})
      : super(code: SuiApiObjectErrors.deleted);
  factory SuiApiObjectErrorDeleted.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectErrorDeleted(
        digest: json.as("digest"),
        objectId: json.as("object_id"),
        version: json.as("version"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "digest": digest,
      "object_id": objectId,
      "version": version,
      "code": code.name
    };
  }

  @override
  String get errorMessage => "Object $objectId deleted.";
}

class SuiApiObjectErrorUnknown extends SuiApiObjectError {
  const SuiApiObjectErrorUnknown() : super(code: SuiApiObjectErrors.unknown);
  @override
  Map<String, dynamic> toJson() {
    return {"code": code.name};
  }

  @override
  String get errorMessage => "Unknown error";
}

class SuiApiObjectErrorDisplayError extends SuiApiObjectError {
  final String error;
  const SuiApiObjectErrorDisplayError(this.error)
      : super(code: SuiApiObjectErrors.displayError);
  factory SuiApiObjectErrorDisplayError.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectErrorDisplayError(json.as("error"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"code": code.name, "error": error};
  }

  @override
  String get errorMessage => error;
}

class SuiApiDisplayFields {
  final Map<String, String>? data;
  final SuiApiObjectError? error;
  const SuiApiDisplayFields({required this.data, required this.error});
  factory SuiApiDisplayFields.fromJson(Map<String, dynamic> json) {
    return SuiApiDisplayFields(
        data: json.as<Map?>("data")?.cast<String, String>(),
        error: json["error"] == null
            ? null
            : SuiApiObjectError.fromJson(
                json.asMap<Map<String, dynamic>>("error")));
  }

  Map<String, dynamic> toJson() {
    return {"data": data, "error": error?.toJson()};
  }
}

enum SuiApiObjectOwnerType {
  addressOwner,
  objectOwner,
  shared,
  immutable,
  consensusV2;

  static SuiApiObjectOwnerType fromName(String? name) {
    return values.firstWhere(
      (e) => e.name.toLowerCase() == name?.toLowerCase(),
      orElse: () => throw DartSuiPluginException(
          "cannot find correct Object owner from the given name.",
          details: {"name": name}),
    );
  }
}

abstract class SuiApiObjectOwner {
  Map<String, dynamic> toJson();
  final SuiApiObjectOwnerType type;
  const SuiApiObjectOwner({required this.type});
  factory SuiApiObjectOwner.fromJson(Object json) {
    SuiApiObjectOwnerType type;
    if (json is String) {
      type = SuiApiObjectOwnerType.fromName(json);
      if (type != SuiApiObjectOwnerType.immutable) {
        throw DartSuiPluginException("Unsuported object owner types.");
      }
      return SuiApiObjectOwnerImmutable();
    } else {
      final jsonMap = json as Map<String, dynamic>;
      type = SuiApiObjectOwnerType.fromName(jsonMap.keys.first);
      return switch (type) {
        SuiApiObjectOwnerType.addressOwner =>
          SuiApiObjectOwnerAddressOwner.fromJson(jsonMap),
        SuiApiObjectOwnerType.objectOwner =>
          SuiApiObjectOwnerObjectOwner.fromJson(jsonMap),
        SuiApiObjectOwnerType.consensusV2 =>
          SuiApiObjectOwnerConsensusV2.fromJson(jsonMap),
        SuiApiObjectOwnerType.shared =>
          SuiApiObjectOwnerShared.fromJson(jsonMap),
        _ => throw DartSuiPluginException("Invalid object owner type.")
      };
    }
  }

  T cast<T extends SuiApiObjectOwner>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiObjectOwner casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiObjectOwnerAddressOwner extends SuiApiObjectOwner {
  final String addressOwner;
  const SuiApiObjectOwnerAddressOwner(this.addressOwner)
      : super(type: SuiApiObjectOwnerType.addressOwner);
  factory SuiApiObjectOwnerAddressOwner.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectOwnerAddressOwner(json.as("AddressOwner"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"AddressOwner": addressOwner, "type": type.name};
  }
}

class SuiApiObjectOwnerObjectOwner extends SuiApiObjectOwner {
  final String objectOwner;
  const SuiApiObjectOwnerObjectOwner(this.objectOwner)
      : super(type: SuiApiObjectOwnerType.objectOwner);
  factory SuiApiObjectOwnerObjectOwner.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectOwnerObjectOwner(json.as("ObjectOwner"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"ObjectOwner": objectOwner, "type": type.name};
  }
}

class SuiApiShared {
  final BigInt initialSharedVersion;
  const SuiApiShared(this.initialSharedVersion);
  factory SuiApiShared.fromJson(Map<String, dynamic> json) {
    return SuiApiShared(json.asBigInt("initial_shared_version"));
  }

  Map<String, dynamic> toJson() {
    return {"initial_shared_version": initialSharedVersion.toString()};
  }
}

class SuiApiAuthenticator {
  final String singleOwner;
  const SuiApiAuthenticator(this.singleOwner);
  factory SuiApiAuthenticator.fromJson(Map<String, dynamic> json) {
    return SuiApiAuthenticator(json.as("SingleOwner"));
  }

  Map<String, dynamic> toJson() {
    return {"SingleOwner": singleOwner};
  }
}

class SuiApiObjectOwnerConsensusV2 extends SuiApiObjectOwner {
  final SuiApiConsensusV2 consensusV2;
  const SuiApiObjectOwnerConsensusV2(this.consensusV2)
      : super(type: SuiApiObjectOwnerType.shared);
  factory SuiApiObjectOwnerConsensusV2.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectOwnerConsensusV2(
      SuiApiConsensusV2.fromJson(json.asMap("ConsensusV2")),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {"ConsensusV2": consensusV2.toJson(), "type": type.name};
  }
}

class SuiApiConsensusV2 {
  final SuiApiAuthenticator authenticator;
  final String startVersion;
  const SuiApiConsensusV2({
    required this.authenticator,
    required this.startVersion,
  });
  factory SuiApiConsensusV2.fromJson(Map<String, dynamic> json) {
    return SuiApiConsensusV2(
        authenticator:
            SuiApiAuthenticator.fromJson(json.asMap("authenticator")),
        startVersion: json.as("start_version"));
  }

  Map<String, dynamic> toJson() {
    return {
      "authenticator": authenticator.toJson(),
      "start_version": startVersion
    };
  }
}

class SuiApiObjectOwnerImmutable extends SuiApiObjectOwner {
  const SuiApiObjectOwnerImmutable()
      : super(type: SuiApiObjectOwnerType.immutable);
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}

class SuiApiObjectOwnerShared extends SuiApiObjectOwner {
  final SuiApiShared shared;
  const SuiApiObjectOwnerShared(this.shared)
      : super(type: SuiApiObjectOwnerType.shared);
  factory SuiApiObjectOwnerShared.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectOwnerShared(
      SuiApiShared.fromJson(json.asMap("Shared")),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {"Shared": shared.toJson(), "type": type.name};
  }
}

class SuiApiObjectData {
  final SuiApiRawDataResponse? bcs;
  final SuiApiParsedData? content;
  final String digest;
  final SuiApiDisplayFields? display;
  final SuiAddress objectId;
  final SuiApiObjectOwner? owner;
  final String? previousTransaction;
  final String? storageRebate;
  final String? type;
  final BigInt version;

  SuiObjectRef toObjectRef() {
    return SuiObjectRef(
        address: objectId,
        version: version,
        digest: SuiObjectDigest.fromBase58(digest));
  }

  SuiApiObjectData(
      {required this.bcs,
      required this.content,
      required this.digest,
      required this.display,
      required this.objectId,
      required this.owner,
      required this.previousTransaction,
      required this.storageRebate,
      required this.type,
      required this.version});
  factory SuiApiObjectData.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectData(
        bcs: json["bcs"] == null
            ? null
            : SuiApiRawDataResponse.fromJson(json.asMap("bcs")),
        content: json["content"] == null
            ? null
            : SuiApiParsedData.fromJson(json.asMap("content")),
        digest: json.as("digest"),
        display: json["display"] == null
            ? null
            : SuiApiDisplayFields.fromJson(json.asMap("display")),
        objectId: SuiAddress(json.as("objectId")),
        owner: json["owner"] == null
            ? null
            : SuiApiObjectOwner.fromJson(json.as("owner")),
        previousTransaction: json.as("previousTransaction"),
        storageRebate: json.as("storageRebate"),
        type: json.as("type"),
        version: json.asBigInt("version"));
  }
  Map<String, dynamic> toJson() {
    return {
      "bcs": bcs?.toJson(),
      "content": content?.toJson(),
      "digest": digest,
      "display": display?.toJson(),
      "objectId": objectId.address,
      "owner": owner?.toJson(),
      "previousTransaction": previousTransaction,
      "storageRebate": storageRebate,
      "type": type,
      "version": version.toString()
    };
  }
}

class SuiApiGetDynamicFieldObjectResponse {
  final SuiApiObjectData? data;
  final SuiApiObjectError? error;
  const SuiApiGetDynamicFieldObjectResponse(
      {required this.error, required this.data});
  factory SuiApiGetDynamicFieldObjectResponse.fromJson(
      Map<String, dynamic> json) {
    return SuiApiGetDynamicFieldObjectResponse(
        error: json["error"] == null
            ? null
            : SuiApiObjectError.fromJson(json.asMap("error")),
        data: json["data"] == null
            ? null
            : SuiApiObjectData.fromJson(json.asMap("data")));
  }
}

class SuiApiDynamicFieldInfo {
  final String digest;
  final SuiApiDynamicFieldName name;
  final String objectId;
  final String objectType;
  final String type;
  final String version;
  final String bcsEncoding;
  final String bcsName;
  const SuiApiDynamicFieldInfo(
      {required this.digest,
      required this.name,
      required this.objectId,
      required this.objectType,
      required this.type,
      required this.version,
      required this.bcsEncoding,
      required this.bcsName});
  factory SuiApiDynamicFieldInfo.fromJson(Map<String, dynamic> json) {
    return SuiApiDynamicFieldInfo(
        digest: json.as("digest"),
        name: SuiApiDynamicFieldName.fromJson(json.asMap("name")),
        objectId: json.as("objectId"),
        objectType: json.as("objectType"),
        type: json.as("type"),
        version: json.as("version"),
        bcsEncoding: json.as("bcsEncoding"),
        bcsName: json.as("bcsName"));
  }
}

class SuiApiGetDynamicFieldsResponse extends SuiApiResponsePagination {
  final List<SuiApiDynamicFieldInfo> data;
  SuiApiGetDynamicFieldsResponse.fromJson(super.json)
      : data = json
            .asListOfMap("data")!
            .map((e) => SuiApiDynamicFieldInfo.fromJson(e))
            .toImutableList,
        super.fromJson();
}

abstract class SuiApiObjectDataFilter {
  Map<String, dynamic> toJson();
  const SuiApiObjectDataFilter();
  T cast<T extends SuiApiObjectDataFilter>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiObjectDataFilter casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiObjectDataFilterMatchAll extends SuiApiObjectDataFilter {
  final List<SuiApiObjectDataFilter> matchAll;
  const SuiApiObjectDataFilterMatchAll(this.matchAll);

  @override
  Map<String, dynamic> toJson() {
    return {"MatchAll": matchAll.map((e) => e.toJson()).toList()};
  }
}

class SuiApiObjectDataFilterMatchAny extends SuiApiObjectDataFilter {
  final List<SuiApiObjectDataFilter> matchAny;
  const SuiApiObjectDataFilterMatchAny(this.matchAny);

  @override
  Map<String, dynamic> toJson() {
    return {"MatchAny": matchAny.map((e) => e.toJson()).toList()};
  }
}

class SuiApiObjectDataFilterMatchNone extends SuiApiObjectDataFilter {
  final List<SuiApiObjectDataFilter> matchNone;
  const SuiApiObjectDataFilterMatchNone(this.matchNone);

  @override
  Map<String, dynamic> toJson() {
    return {"MatchNone": matchNone.map((e) => e.toJson()).toList()};
  }
}

class SuiApiObjectDataFilterPackage extends SuiApiObjectDataFilter {
  final String package;
  const SuiApiObjectDataFilterPackage(this.package);

  @override
  Map<String, dynamic> toJson() {
    return {"package": package};
  }
}

class SuiApiObjectDataFilterMoveModule extends SuiApiObjectDataFilter {
  final String module;
  final String package;
  const SuiApiObjectDataFilterMoveModule(
      {required this.module, required this.package});

  @override
  Map<String, dynamic> toJson() {
    return {
      "MoveModule": {"module": module, "package": package}
    };
  }
}

class SuiApiObjectDataFilterStructType extends SuiApiObjectDataFilter {
  final String structType;
  const SuiApiObjectDataFilterStructType(this.structType);

  @override
  Map<String, dynamic> toJson() {
    return {"StructType": structType};
  }
}

class SuiApiObjectDataFilterAddressOwner extends SuiApiObjectDataFilter {
  final String addressOwner;
  const SuiApiObjectDataFilterAddressOwner(this.addressOwner);

  @override
  Map<String, dynamic> toJson() {
    return {"AddressOwner": addressOwner};
  }
}

class SuiApiObjectDataFilterObjectOwner extends SuiApiObjectDataFilter {
  final String objectOwner;
  const SuiApiObjectDataFilterObjectOwner(this.objectOwner);

  @override
  Map<String, dynamic> toJson() {
    return {"ObjectOwner": objectOwner};
  }
}

class SuiApiObjectDataFilterObjectId extends SuiApiObjectDataFilter {
  final String objectId;
  const SuiApiObjectDataFilterObjectId(this.objectId);

  @override
  Map<String, dynamic> toJson() {
    return {"ObjectId": objectId};
  }
}

class SuiApiObjectDataFilterObjectIds extends SuiApiObjectDataFilter {
  final List<String> objectIds;
  const SuiApiObjectDataFilterObjectIds(this.objectIds);

  @override
  Map<String, dynamic> toJson() {
    return {"ObjectIds": objectIds};
  }
}

class SuiApiObjectDataFilterObjectVersion extends SuiApiObjectDataFilter {
  final String version;
  const SuiApiObjectDataFilterObjectVersion(this.version);

  @override
  Map<String, dynamic> toJson() {
    return {"version": version};
  }
}

class SuiApiObjectDataOptions {
  final bool? showBcs;
  final bool? showContent;
  final bool? showDisplay;
  final bool? showOwner;
  final bool? showPreviousTransaction;
  final bool? showStorageRebate;
  final bool? showType;
  const SuiApiObjectDataOptions(
      {this.showBcs,
      this.showContent,
      this.showDisplay,
      this.showOwner,
      this.showPreviousTransaction,
      this.showStorageRebate,
      this.showType});
  Map<String, dynamic> toJson() {
    return {
      "showBcs": showBcs,
      "showContent": showContent,
      "showDisplay": showDisplay,
      "showOwner": showOwner,
      "showPreviousTransaction": showPreviousTransaction,
      "showStorageRebate": showStorageRebate,
      "showType": showType
    }..removeWhere((k, v) => v == null);
  }
}

class SuiApiObjectResponseQuery {
  final SuiApiObjectDataFilter? filter;
  final SuiApiObjectDataOptions? options;
  const SuiApiObjectResponseQuery({this.filter, this.options});
  Map<String, dynamic> toJson() {
    return {"filter": filter?.toJson(), "options": options?.toJson()};
  }
}

class SuiApiPaginatedObjectResponse extends SuiApiResponsePagination {
  final List<SuiApiObjectResponse> data;
  const SuiApiPaginatedObjectResponse({required this.data});
  SuiApiPaginatedObjectResponse.fromJson(super.json)
      : data = json
            .asListOfMap("data")!
            .map((e) => SuiApiObjectResponse.fromJson(e))
            .toImutableList,
        super.fromJson();
  @override
  Map<String, dynamic> toJson() {
    return {"data": data.map((e) => e.toJson()).toList(), ...super.toJson()};
  }
}

class SuiApiObjectResponse extends SuiApiResponsePagination {
  final SuiApiObjectData? data;
  final SuiApiObjectError? error;
  const SuiApiObjectResponse({required this.error, required this.data});
  SuiApiObjectResponse.fromJson(Map<String, dynamic> json)
      : error = json["error"] == null
            ? null
            : SuiApiObjectError.fromJson(json.asMap("error")),
        data = json["data"] == null
            ? null
            : SuiApiObjectData.fromJson(json.asMap("data"));
  @override
  Map<String, dynamic> toJson() {
    return {"error": error?.toJson(), "data": data?.toJson()};
  }
}

class SuiApiEventId {
  final String eventSeq;
  final String txDigest;
  const SuiApiEventId({required this.eventSeq, required this.txDigest});
  factory SuiApiEventId.fromJson(Map<String, dynamic> json) {
    return SuiApiEventId(
        eventSeq: json.as("eventSeq"), txDigest: json.as("txDigest"));
  }
  Map<String, dynamic> toJson() {
    return {"eventSeq": eventSeq, "txDigest": txDigest};
  }
}

abstract class SuiApiEventFilter {
  Map<String, dynamic> toJson();
  const SuiApiEventFilter();
  T cast<T extends SuiApiEventFilter>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiEventFilter casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiEventFilterAll extends SuiApiEventFilter {
  final List<SuiApiEventFilter> all;
  const SuiApiEventFilterAll(this.all);

  @override
  Map<String, dynamic> toJson() {
    return {"All": all.map((e) => e.toJson()).toList()};
  }
}

class SuiApiEventFilterAny extends SuiApiEventFilter {
  final List<SuiApiEventFilter> any;
  const SuiApiEventFilterAny(this.any);

  @override
  Map<String, dynamic> toJson() {
    return {"Any": any.map((e) => e.toJson()).toList()};
  }
}

class SuiApiEventFilterSender extends SuiApiEventFilter {
  final String sender;
  const SuiApiEventFilterSender(this.sender);

  @override
  Map<String, dynamic> toJson() {
    return {"Sender": sender};
  }
}

class SuiApiEventFilterTransaction extends SuiApiEventFilter {
  final String transaction;
  const SuiApiEventFilterTransaction(this.transaction);

  @override
  Map<String, dynamic> toJson() {
    return {"Transaction": transaction};
  }
}

class SuiApiEventFilterMoveModule extends SuiApiEventFilter {
  final String module;
  final String package;
  const SuiApiEventFilterMoveModule(
      {required this.module, required this.package});

  @override
  Map<String, dynamic> toJson() {
    return {
      "MoveModule": {"module": module, "package": package}
    };
  }
}

class SuiApiEventFilterMoveEventType extends SuiApiEventFilter {
  final String moveEventType;
  const SuiApiEventFilterMoveEventType(this.moveEventType);

  @override
  Map<String, dynamic> toJson() {
    return {"MoveEventType": moveEventType};
  }
}

class SuiApiEventFilterMoveEventModule extends SuiApiEventFilter {
  final String module;
  final String package;
  const SuiApiEventFilterMoveEventModule(
      {required this.module, required this.package});

  @override
  Map<String, dynamic> toJson() {
    return {
      "MoveEventModule": {"module": module, "package": package}
    };
  }
}

class SuiApiEventFilterTimeRange extends SuiApiEventFilter {
  final String endTime;
  final String startTime;
  const SuiApiEventFilterTimeRange(
      {required this.endTime, required this.startTime});

  @override
  Map<String, dynamic> toJson() {
    return {
      "TimeRange": {"endTime": endTime, "startTime": startTime}
    };
  }
}

class SuiApiEvent {
  final SuiApiEventId id;
  final String packageId;
  final Object? parsedJson;
  final String sender;
  final String? timestampMs;
  final String transactionModule;
  final String type;
  final String bcs;
  final String bcsEncoding;
  const SuiApiEvent(
      {required this.id,
      required this.packageId,
      required this.parsedJson,
      required this.sender,
      required this.timestampMs,
      required this.transactionModule,
      required this.type,
      required this.bcs,
      required this.bcsEncoding});
  factory SuiApiEvent.fromJson(Map<String, dynamic> json) {
    return SuiApiEvent(
        id: SuiApiEventId.fromJson(json.asMap("id")),
        packageId: json.as("packageId"),
        parsedJson: json.as("parsedJson"),
        sender: json.as("sender"),
        timestampMs: json.as("timestampMs"),
        transactionModule: json.as("transactionModule"),
        type: json.as("type"),
        bcs: json.as("bcs"),
        bcsEncoding: json.as("bcsEncoding"));
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id.toJson(),
      "packageId": packageId,
      "parsedJson": parsedJson,
      "sender": sender,
      "timestampMs": timestampMs,
      "transactionModule": transactionModule,
      "type": type,
      "bcs": bcs,
      "bcsEncoding": bcsEncoding
    };
  }
}

class SuiApiQueryEventsRepose extends SuiApiResponsePagination {
  final List<SuiApiEvent> data;
  const SuiApiQueryEventsRepose(this.data);
  SuiApiQueryEventsRepose.fromJson(super.json)
      : data = json
            .asListOfMap("data")!
            .map((e) => SuiApiEvent.fromJson(e))
            .toImutableList,
        super.fromJson();
}

abstract class SuiApiTransactionFilter {
  Map<String, dynamic> toJson();
  const SuiApiTransactionFilter();
  T cast<T extends SuiApiTransactionFilter>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiTransactionFilter casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiTransactionFilterCheckPoint extends SuiApiTransactionFilter {
  final String checkPoint;
  const SuiApiTransactionFilterCheckPoint(this.checkPoint);

  @override
  Map<String, dynamic> toJson() {
    return {"Checkpoint": checkPoint};
  }
}

class SuiApiTransactionFilterMoveFunction extends SuiApiTransactionFilter {
  final String? function;
  final String? module;
  final String package;
  const SuiApiTransactionFilterMoveFunction(
      {this.function, this.module, required this.package});

  @override
  Map<String, dynamic> toJson() {
    return {
      "MoveFunction": {
        "function": function,
        "module": module,
        "package": package
      }
    };
  }
}

class SuiApiTransactionFilterInputObject extends SuiApiTransactionFilter {
  final String inputObject;
  const SuiApiTransactionFilterInputObject(this.inputObject);

  @override
  Map<String, dynamic> toJson() {
    return {"InputObject": inputObject};
  }
}

class SuiApiTransactionFilterChangeObject extends SuiApiTransactionFilter {
  final String changeObject;
  const SuiApiTransactionFilterChangeObject(this.changeObject);

  @override
  Map<String, dynamic> toJson() {
    return {"ChangeObject": changeObject};
  }
}

class SuiApiTransactionFilterAffectedObject extends SuiApiTransactionFilter {
  final String affectedObject;
  const SuiApiTransactionFilterAffectedObject(this.affectedObject);

  @override
  Map<String, dynamic> toJson() {
    return {"AffectedObject": affectedObject};
  }
}

class SuiApiTransactionFilterFromAddress extends SuiApiTransactionFilter {
  final String fromAddress;
  const SuiApiTransactionFilterFromAddress(this.fromAddress);

  @override
  Map<String, dynamic> toJson() {
    return {"FromAddress": fromAddress};
  }
}

class SuiApiTransactionFilterToAddress extends SuiApiTransactionFilter {
  final String toAddress;
  const SuiApiTransactionFilterToAddress(this.toAddress);

  @override
  Map<String, dynamic> toJson() {
    return {"ToAddress": toAddress};
  }
}

class SuiApiTransactionFilterFromAndToAddress extends SuiApiTransactionFilter {
  final String from;
  final String to;
  const SuiApiTransactionFilterFromAndToAddress(
      {required this.from, required this.to});

  @override
  Map<String, dynamic> toJson() {
    return {
      "FromAndToAddress": {"from": from, "to": to},
    };
  }
}

class SuiApiTransactionFilterFromOrToAddress extends SuiApiTransactionFilter {
  final String addr;
  const SuiApiTransactionFilterFromOrToAddress(this.addr);

  @override
  Map<String, dynamic> toJson() {
    return {
      "FromOrToAddress": {"addr": addr}
    };
  }
}

class SuiApiTransactionFilterTransactionKind extends SuiApiTransactionFilter {
  final String transactionKind;
  const SuiApiTransactionFilterTransactionKind(this.transactionKind);

  @override
  Map<String, dynamic> toJson() {
    return {"TransactionKind": transactionKind};
  }
}

class SuiApiTransactionFilterTransactionKindIn extends SuiApiTransactionFilter {
  final List<String> transactionKindIn;
  const SuiApiTransactionFilterTransactionKindIn(this.transactionKindIn);

  @override
  Map<String, dynamic> toJson() {
    return {"TransactionKindIn": transactionKindIn};
  }
}

class SuiApiTransactionBlockResponseOptions {
  final bool? showBalanceChange;
  final bool? showEffects;
  final bool? showEvents;
  final bool? showInput;
  final bool? showObjectChanges;
  final bool? showRawEffects;
  final bool? showRawInput;
  const SuiApiTransactionBlockResponseOptions(
      {this.showBalanceChange,
      this.showEffects,
      this.showEvents,
      this.showInput,
      this.showObjectChanges,
      this.showRawEffects,
      this.showRawInput});
  factory SuiApiTransactionBlockResponseOptions.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockResponseOptions(
        showBalanceChange: json["showBalanceChange"],
        showEffects: json["showEffects"],
        showEvents: json["showEvents"],
        showInput: json["showInput"],
        showObjectChanges: json["showObjectChanges"],
        showRawEffects: json["showRawEffects"],
        showRawInput: json["showRawInput"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "showBalanceChange": showBalanceChange,
      "showEffects": showEffects,
      "showEvents": showEvents,
      "showInput": showInput,
      "showObjectChanges": showObjectChanges,
      "showRawEffects": showRawEffects,
      "showRawInput": showRawInput
    }..removeWhere((k, v) => v == null);
  }
}

class SuiApiTransactionBlockResponseQuery {
  final SuiApiTransactionFilter? filter;
  final SuiApiTransactionBlockResponseOptions? options;
  const SuiApiTransactionBlockResponseQuery({this.filter, this.options});
  Map<String, dynamic> toJson() {
    return {"filter": filter?.toJson(), "options": options?.toJson()};
  }
}

class SuiApiBalanceChange {
  final String amount;
  final String coinType;
  final SuiApiObjectOwner owner;
  const SuiApiBalanceChange(
      {required this.amount, required this.coinType, required this.owner});

  factory SuiApiBalanceChange.fromJson(Map<String, dynamic> json) {
    return SuiApiBalanceChange(
        amount: json.as("amount"),
        coinType: json.as("coinType"),
        owner: SuiApiObjectOwner.fromJson(json.as("owner")));
  }

  Map<String, dynamic> toJson() {
    return {"amount": amount, "coinType": coinType, "owner": owner.toJson()};
  }
}

class SuiApiObjectRef {
  final String digest;
  final String objectId;
  final String version;
  const SuiApiObjectRef(
      {required this.digest, required this.objectId, required this.version});

  factory SuiApiObjectRef.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectRef(
        digest: json.as("digest"),
        objectId: json.as("objectId"),
        version: json.asBigInt<BigInt>("version").toString());
  }

  Map<String, dynamic> toJson() {
    return {"digest": digest, "objectId": objectId, "version": version};
  }
}

class SuiApiOwnedObjectRef {
  final SuiApiObjectOwner owner;
  final SuiApiObjectRef reference;
  const SuiApiOwnedObjectRef({required this.owner, required this.reference});

  factory SuiApiOwnedObjectRef.fromJson(Map<String, dynamic> json) {
    return SuiApiOwnedObjectRef(
        owner: SuiApiObjectOwner.fromJson(json.as("owner")),
        reference: SuiApiObjectRef.fromJson(json.asMap("reference")));
  }

  Map<String, dynamic> toJson() {
    return {"owner": owner.toJson(), "reference": reference.toJson()};
  }
}

class SuiApiGasCostSummary {
  final BigInt computationCost;
  final BigInt nonRefundableStorageFee;
  final BigInt storageCost;
  final BigInt storageRebate;
  const SuiApiGasCostSummary(
      {required this.computationCost,
      required this.nonRefundableStorageFee,
      required this.storageCost,
      required this.storageRebate});

  factory SuiApiGasCostSummary.fromJson(Map<String, dynamic> json) {
    return SuiApiGasCostSummary(
        computationCost: json.asBigInt("computationCost"),
        nonRefundableStorageFee: json.asBigInt("nonRefundableStorageFee"),
        storageCost: json.asBigInt("storageCost"),
        storageRebate: json.asBigInt("storageRebate"));
  }

  Map<String, dynamic> toJson() {
    return {
      "computationCost": computationCost.toString(),
      "nonRefundableStorageFee": nonRefundableStorageFee.toString(),
      "storageCost": storageCost.toString(),
      "storageRebate": storageRebate.toString()
    };
  }
}

class SuiApiTransactionBlockEffectsModifiedAtVersion {
  final String objectId;
  final String sequenceNumber;
  const SuiApiTransactionBlockEffectsModifiedAtVersion(
      {required this.objectId, required this.sequenceNumber});

  factory SuiApiTransactionBlockEffectsModifiedAtVersion.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockEffectsModifiedAtVersion(
        objectId: json.as("objectId"),
        sequenceNumber: json.as("sequenceNumber"));
  }

  Map<String, dynamic> toJson() {
    return {"objectId": objectId, "sequenceNumber": sequenceNumber};
  }
}

enum SuiApiExecutionStatusType {
  success,
  failure;

  bool get isSuccess => this == success;

  static SuiApiExecutionStatusType fromName(String? name) {
    return values.firstWhere(
      (e) => e.name.toLowerCase() == name?.toLowerCase(),
      orElse: () => throw DartSuiPluginException(
          "cannot find correct SuiApiExecutionStatusType from the given name.",
          details: {"name": name}),
    );
  }
}

class SuiApiExecutionStatus {
  final SuiApiExecutionStatusType status;
  final String? error;
  const SuiApiExecutionStatus({required this.status, required this.error});

  factory SuiApiExecutionStatus.fromJson(Map<String, dynamic> json) {
    return SuiApiExecutionStatus(
        status: SuiApiExecutionStatusType.fromName(json.as("status")),
        error: json.as("error"));
  }

  Map<String, dynamic> toJson() {
    return {"status": status.name, "error": error};
  }
}

class SuiApiTransactionEffects {
  final List<SuiApiOwnedObjectRef>? created;
  final List<SuiApiObjectRef>? deleted;
  final List<String>? dependencies;
  final String? eventsDigest;
  final String executedEpoch;
  final SuiApiOwnedObjectRef gasObject;
  final SuiApiGasCostSummary gasUsed;
  final SuiApiTransactionBlockEffectsModifiedAtVersion? modifiedAtVersion;
  final List<SuiApiOwnedObjectRef>? mutated;
  final List<SuiApiObjectRef>? sharedObjects;
  final SuiApiExecutionStatus status;
  final String transactionDigest;
  final List<SuiApiOwnedObjectRef>? unwrapped;
  final List<SuiApiObjectRef>? unwrappedThenDeleted;
  final List<SuiApiObjectRef>? wrapped;
  const SuiApiTransactionEffects(
      {required this.created,
      required this.deleted,
      required this.dependencies,
      required this.eventsDigest,
      required this.executedEpoch,
      required this.gasObject,
      required this.gasUsed,
      required this.modifiedAtVersion,
      required this.mutated,
      required this.sharedObjects,
      required this.status,
      required this.transactionDigest,
      required this.unwrapped,
      required this.unwrappedThenDeleted,
      required this.wrapped});
  factory SuiApiTransactionEffects.fromJson(Map<String, dynamic> json) {
    return SuiApiTransactionEffects(
        created: json
            .asListOfMap("created", throwOnNull: false)
            ?.map((e) => SuiApiOwnedObjectRef.fromJson(e))
            .toList(),
        deleted: json
            .asListOfMap("deleted", throwOnNull: false)
            ?.map((e) => SuiApiObjectRef.fromJson(e))
            .toList(),
        dependencies: json.asListOfString("dependencies", throwOnNull: false),
        eventsDigest: json.as("eventsDigest"),
        executedEpoch: json.as("executedEpoch"),
        gasObject: SuiApiOwnedObjectRef.fromJson(json.asMap("gasObject")),
        gasUsed: SuiApiGasCostSummary.fromJson(json.asMap("gasUsed")),
        modifiedAtVersion: json["modifiedAtVersion"] == null
            ? null
            : SuiApiTransactionBlockEffectsModifiedAtVersion.fromJson(
                json.asMap("modifiedAtVersion")),
        mutated: json
            .asListOfMap("mutated", throwOnNull: false)
            ?.map((e) => SuiApiOwnedObjectRef.fromJson(e))
            .toList(),
        sharedObjects: json
            .asListOfMap("sharedObjects", throwOnNull: false)
            ?.map((e) => SuiApiObjectRef.fromJson(e))
            .toList(),
        status: SuiApiExecutionStatus.fromJson(json.asMap("status")),
        transactionDigest: json.as("transactionDigest"),
        unwrapped: json
            .asListOfMap("unwrapped", throwOnNull: false)
            ?.map((e) => SuiApiOwnedObjectRef.fromJson(e))
            .toList(),
        unwrappedThenDeleted: json
            .asListOfMap("unwrappedThenDeleted", throwOnNull: false)
            ?.map((e) => SuiApiObjectRef.fromJson(e))
            .toList(),
        wrapped: json
            .asListOfMap("wrapped", throwOnNull: false)
            ?.map((e) => SuiApiObjectRef.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      "created": created?.map((e) => e.toJson()).toList(),
      "deleted": deleted?.map((e) => e.toJson()).toList(),
      "dependencies": dependencies,
      "eventsDigest": eventsDigest,
      "executedEpoch": executedEpoch,
      "gasObject": gasObject.toJson(),
      "gasUsed": gasUsed.toJson(),
      "modifiedAtVersion": modifiedAtVersion?.toJson(),
      "mutated": mutated?.map((e) => e.toJson()).toList(),
      "sharedObjects": sharedObjects?.map((e) => e.toJson()).toList(),
      "status": status.toJson(),
      "transactionDigest": transactionDigest,
      "unwrapped": unwrapped?.map((e) => e.toJson()).toList(),
      "unwrappedThenDeleted":
          unwrappedThenDeleted?.map((e) => e.toJson()).toList(),
      "wrapped": wrapped?.map((e) => e.toJson()).toList()
    };
  }
}

enum SuiApiObjectChanges {
  published,
  transferred,
  mutated,
  deleted,
  wrapped,
  created;

  static SuiApiObjectChanges fromName(String? name) {
    return values.firstWhere(
      (e) => e.name.toLowerCase() == name?.toLowerCase(),
      orElse: () => throw DartSuiPluginException(
          "cannot find correct ObjectChange from the given name.",
          details: {"name": name}),
    );
  }
}

abstract class SuiApiObjectChange {
  final SuiApiObjectChanges type;
  const SuiApiObjectChange({required this.type});
  Map<String, dynamic> toJson();
  factory SuiApiObjectChange.fromJson(Map<String, dynamic> json) {
    final type = SuiApiObjectChanges.fromName(json.as("type"));
    return switch (type) {
      SuiApiObjectChanges.published =>
        SuiApiObjectChangePublished.fromJson(json),
      SuiApiObjectChanges.transferred =>
        SuiApiObjectChangeTransferred.fromJson(json),
      SuiApiObjectChanges.mutated => SuiApiObjectChangeMutated.fromJson(json),
      SuiApiObjectChanges.deleted => SuiApiObjectChangeDeleted.fromJson(json),
      SuiApiObjectChanges.wrapped => SuiApiObjectChangeWrapped.fromJson(json),
      SuiApiObjectChanges.created => SuiApiObjectChangeCreated.fromJson(json)
    };
  }
  T cast<T extends SuiApiObjectChange>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiObjectChange casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiObjectChangePublished extends SuiApiObjectChange {
  final String digest;
  final List<String> modules;
  final String packageId;
  final String version;
  const SuiApiObjectChangePublished({
    required this.digest,
    required this.modules,
    required this.packageId,
    required this.version,
  }) : super(type: SuiApiObjectChanges.published);
  factory SuiApiObjectChangePublished.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectChangePublished(
        digest: json.as("digest"),
        modules: json.asListOfString("modules")!,
        packageId: json.as("packageId"),
        version: json.as("version"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "digest": digest,
      "modules": modules,
      "packageId": packageId,
      "version": version
    };
  }
}

class SuiApiObjectChangeTransferred extends SuiApiObjectChange {
  final String digest;
  final String objectId;
  final String objectType;
  final SuiApiObjectOwner recipient;
  final String sender;
  final String version;
  const SuiApiObjectChangeTransferred({
    required this.digest,
    required this.objectId,
    required this.objectType,
    required this.recipient,
    required this.sender,
    required this.version,
  }) : super(type: SuiApiObjectChanges.transferred);
  factory SuiApiObjectChangeTransferred.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectChangeTransferred(
      digest: json.as("digest"),
      recipient: SuiApiObjectOwner.fromJson(json.as("recipient")),
      objectType: json.as("objectType"),
      version: json.as("version"),
      objectId: json.as("objectId"),
      sender: json.as("sender"),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "digest": digest,
      "recipient": recipient.toJson(),
      "objectType": objectType,
      "objectId": objectId,
      "sender": sender,
      "version": version,
      "type": type.name
    };
  }
}

class SuiApiObjectChangeMutated extends SuiApiObjectChange {
  final String digest;
  final String objectId;
  final String objectType;
  final SuiApiObjectOwner owner;
  final String previousVersion;
  final String sender;
  final String version;
  const SuiApiObjectChangeMutated({
    required this.digest,
    required this.objectId,
    required this.objectType,
    required this.owner,
    required this.sender,
    required this.version,
    required this.previousVersion,
  }) : super(type: SuiApiObjectChanges.mutated);
  factory SuiApiObjectChangeMutated.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectChangeMutated(
        digest: json.as("digest"),
        owner: SuiApiObjectOwner.fromJson(json.as("owner")),
        objectType: json.as("objectType"),
        version: json.as("version"),
        objectId: json.as("objectId"),
        sender: json.as("sender"),
        previousVersion: json.as("previousVersion"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "digest": digest,
      "owner": owner.toJson(),
      "objectType": objectType,
      "objectId": objectId,
      "sender": sender,
      "version": version,
      "previousVersion": previousVersion,
      "type": type.name
    };
  }
}

class SuiApiObjectChangeDeleted extends SuiApiObjectChange {
  final String objectId;
  final String objectType;
  final String sender;
  final String version;
  const SuiApiObjectChangeDeleted({
    required this.objectId,
    required this.objectType,
    required this.sender,
    required this.version,
  }) : super(type: SuiApiObjectChanges.deleted);
  factory SuiApiObjectChangeDeleted.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectChangeDeleted(
        objectType: json.as("objectType"),
        version: json.as("version"),
        objectId: json.as("objectId"),
        sender: json.as("sender"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "objectType": objectType,
      "objectId": objectId,
      "sender": sender,
      "version": version,
      "type": type.name
    };
  }
}

class SuiApiObjectChangeWrapped extends SuiApiObjectChange {
  final String objectId;
  final String objectType;
  final String sender;
  final String version;
  const SuiApiObjectChangeWrapped({
    required this.objectId,
    required this.objectType,
    required this.sender,
    required this.version,
  }) : super(type: SuiApiObjectChanges.wrapped);
  factory SuiApiObjectChangeWrapped.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectChangeWrapped(
        objectType: json.as("objectType"),
        version: json.as("version"),
        objectId: json.as("objectId"),
        sender: json.as("sender"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "objectType": objectType,
      "objectId": objectId,
      "sender": sender,
      "version": version,
      "type": type.name
    };
  }
}

class SuiApiObjectChangeCreated extends SuiApiObjectChange {
  final String digest;
  final String objectId;
  final String objectType;
  final SuiApiObjectOwner owner;
  final String sender;
  final String version;
  const SuiApiObjectChangeCreated({
    required this.digest,
    required this.objectId,
    required this.objectType,
    required this.owner,
    required this.sender,
    required this.version,
  }) : super(type: SuiApiObjectChanges.created);
  factory SuiApiObjectChangeCreated.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectChangeCreated(
        digest: json.as("digest"),
        owner: SuiApiObjectOwner.fromJson(json.as("owner")),
        objectType: json.as("objectType"),
        version: json.as("version"),
        objectId: json.as("objectId"),
        sender: json.as("sender"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "digest": digest,
      "owner": owner.toJson(),
      "objectType": objectType,
      "objectId": objectId,
      "sender": sender,
      "version": version,
      "type": type.name
    };
  }
}

class SuiApiGasData {
  final String budget;
  final String owner;
  final List<SuiApiObjectRef> payment;
  final String price;
  const SuiApiGasData(
      {required this.budget,
      required this.owner,
      required this.payment,
      required this.price});
  factory SuiApiGasData.fromJson(Map<String, dynamic> json) {
    return SuiApiGasData(
        budget: json.as("budget"),
        owner: json.as("owner"),
        payment: json
            .asListOfMap("payment")!
            .map((e) => SuiApiObjectRef.fromJson(e))
            .toList(),
        price: json.as("price"));
  }
  Map<String, dynamic> toJson() {
    return {
      "budget": budget,
      "owner": owner,
      "payment": payment.map((e) => e.toJson()).toList(),
      "price": price
    };
  }
}

enum SuiApiCallArgs {
  sharedObject,
  immOrOwnedObject,
  receiving,
  pure;

  static SuiApiCallArgs fromName(String? name, {SuiApiCallArgs? defaultArg}) {
    if (name == null && defaultArg != null) return defaultArg;
    return values.firstWhere(
      (e) => e.name.toLowerCase() == name?.toLowerCase(),
      orElse: () => throw DartSuiPluginException(
          "cannot find correct CallArg from the given name.",
          details: {"name": name}),
    );
  }
}

abstract class SuiApiCallArg {
  final SuiApiCallArgs objectType;
  const SuiApiCallArg({required this.objectType});
  Map<String, dynamic> toJson();
  factory SuiApiCallArg.fromJson(Map<String, dynamic> json) {
    final type = SuiApiCallArgs.fromName(json.as("objectType"),
        defaultArg: SuiApiCallArgs.pure);
    return switch (type) {
      SuiApiCallArgs.immOrOwnedObject =>
        SuiApiCallArgImmOrOwnedObject.fromJson(json),
      SuiApiCallArgs.sharedObject => SuiApiCallArgSharedObject.fromJson(json),
      SuiApiCallArgs.receiving => SuiApiCallArgReceiving.fromJson(json),
      SuiApiCallArgs.pure => SuiApiCallArgPure.fromJson(json)
    };
  }
  T cast<T extends SuiApiCallArg>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiCallArg casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiCallArgImmOrOwnedObject extends SuiApiCallArg {
  final String digest;
  final String objectId;
  final String version;
  const SuiApiCallArgImmOrOwnedObject(
      {required this.digest, required this.objectId, required this.version})
      : super(objectType: SuiApiCallArgs.immOrOwnedObject);
  factory SuiApiCallArgImmOrOwnedObject.fromJson(Map<String, dynamic> json) {
    return SuiApiCallArgImmOrOwnedObject(
        digest: json.as("digest"),
        objectId: json.as("objectId"),
        version: json.as("version"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "digest": digest,
      "objectId": objectId,
      "version": version,
      "objectType": objectType.name
    };
  }
}

///
class SuiApiCallArgSharedObject extends SuiApiCallArg {
  final String initialSharedVersion;
  final bool mutable;
  final String objectId;
  const SuiApiCallArgSharedObject(
      {required this.initialSharedVersion,
      required this.objectId,
      required this.mutable})
      : super(objectType: SuiApiCallArgs.sharedObject);
  factory SuiApiCallArgSharedObject.fromJson(Map<String, dynamic> json) {
    return SuiApiCallArgSharedObject(
        initialSharedVersion: json.as("initialSharedVersion"),
        objectId: json.as("objectId"),
        mutable: json.as("mutable"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "mutable": mutable,
      "objectId": objectId,
      "initialSharedVersion": initialSharedVersion,
      "objectType": objectType.name
    };
  }
}

class SuiApiCallArgReceiving extends SuiApiCallArg {
  final String digest;
  final String objectId;
  final String version;
  const SuiApiCallArgReceiving(
      {required this.digest, required this.objectId, required this.version})
      : super(objectType: SuiApiCallArgs.receiving);
  factory SuiApiCallArgReceiving.fromJson(Map<String, dynamic> json) {
    return SuiApiCallArgReceiving(
        digest: json.as("digest"),
        objectId: json.as("objectId"),
        version: json.as("version"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "digest": digest,
      "objectId": objectId,
      "version": version,
      "objectType": objectType.name
    };
  }
}

class SuiApiCallArgPure extends SuiApiCallArg {
  final Object? unknown;
  final String? valueType;
  const SuiApiCallArgPure({required this.unknown, required this.valueType})
      : super(objectType: SuiApiCallArgs.pure);
  factory SuiApiCallArgPure.fromJson(Map<String, dynamic> json) {
    return SuiApiCallArgPure(
        unknown: json.as("unknown"), valueType: json.as("valueType"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"valueType": valueType, "unknown": unknown};
  }
}

class SuiApiArgument {
  final int? input;
  final int? result;
  final List<int>? nestedResult;
  const SuiApiArgument({this.input, this.result, this.nestedResult});
  factory SuiApiArgument.fromJson(Object json) {
    if (json == "GasCoin") return SuiApiArgument();
    if (json is! Map<String, dynamic>) {
      throw DartSuiPluginException("Invalid Argument json data.",
          details: {"expected": "Map", "data": json});
    }
    return SuiApiArgument(
        input: json.as("Input"),
        result: json.as("TronResult"),
        nestedResult: json["NestedResult"] == null
            ? null
            : (json["NestedResult"] as List).cast());
  }
  Map<String, dynamic> toJson() {
    return {"Input": input, "TronResult": result, "NestedResult": nestedResult};
  }
}

class SuiApiMoveCallTransaction {
  final List<SuiApiArgument>? arguments;
  final String function;
  final String module;
  final String package;
  final List<String>? typeArguments;
  const SuiApiMoveCallTransaction(
      {required this.arguments,
      required this.function,
      required this.module,
      required this.package,
      required this.typeArguments});
  factory SuiApiMoveCallTransaction.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveCallTransaction(
        arguments: json
            .asListOfMap("arguments", throwOnNull: false)
            ?.map((e) => SuiApiArgument.fromJson(e))
            .toList(),
        function: json.as("function"),
        module: json.as("module"),
        package: json.as("package"),
        typeArguments:
            json.asListOfString("type_arguments", throwOnNull: false));
  }
  Map<String, dynamic> toJson() {
    return {
      "arguments": arguments?.map((e) => e.toJson()).toList(),
      "function": function,
      "module": module,
      "package": package,
      "type_arguments": typeArguments
    };
  }
}

/// A single command in a programmable transaction.
enum SuiApiTransactionCommands {
  /// A call to either an entry or a public Move function
  moveCall(value: 0),

  /// It sends n-objects to the specified address. These objects must have store
  /// (public transfer) and either the previous owner must be an address or the object must
  /// be newly created.
  transferObjects(value: 1),

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
  const SuiApiTransactionCommands({required this.value});
  static SuiApiTransactionCommands fromName(String? name) {
    return values.firstWhere((e) => e.name.toLowerCase() == name?.toLowerCase(),
        orElse: () => throw DartSuiPluginException(
            "cannot find correct Commands from the given name.",
            details: {"name": name}));
  }
}

abstract class SuiApiTransaction {
  Map<String, dynamic> toJson();
  final SuiApiTransactionCommands type;
  const SuiApiTransaction({required this.type});
  factory SuiApiTransaction.fromJson(Map<String, dynamic> json) {
    final key = json.keys.first;
    final type = SuiApiTransactionCommands.fromName(key);
    return switch (type) {
      SuiApiTransactionCommands.moveCall =>
        SuiApiTransactionMoveCall.fromJson(json),
      SuiApiTransactionCommands.transferObjects =>
        SuiApiTransactionTransferObjects.fromJson(json),
      SuiApiTransactionCommands.splitCoins =>
        SuiApiTransactionSplitCoins.fromJson(json),
      SuiApiTransactionCommands.mergeCoins =>
        SuiApiTransactionMergeCoins.fromJson(json),
      SuiApiTransactionCommands.publish =>
        SuiApiTransactionPublish.fromJson(json),
      SuiApiTransactionCommands.upgrade =>
        SuiApiTransactionUpgrade.fromJson(json),
      SuiApiTransactionCommands.makeMoveVec =>
        SuiApiTransactionMakeMoveVec.fromJson(json),
    };
  }

  T cast<T extends SuiApiTransaction>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiTransaction casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiTransactionMoveCall extends SuiApiTransaction {
  final SuiApiMoveCallTransaction moveCall;
  const SuiApiTransactionMoveCall(this.moveCall)
      : super(type: SuiApiTransactionCommands.moveCall);
  factory SuiApiTransactionMoveCall.fromJson(Map<String, dynamic> json) {
    return SuiApiTransactionMoveCall(
        SuiApiMoveCallTransaction.fromJson(json.as("MoveCall")));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"MoveCall": moveCall.toJson()};
  }
}

class SuiApiTransactionTransferObjects extends SuiApiTransaction {
  final List<SuiApiArgument> objects;
  final SuiApiArgument address;
  const SuiApiTransactionTransferObjects(
      {required this.objects, required this.address})
      : super(type: SuiApiTransactionCommands.transferObjects);
  factory SuiApiTransactionTransferObjects.fromJson(Map<String, dynamic> json) {
    final object = json["TransferObjects"] as List;
    return SuiApiTransactionTransferObjects(
        objects:
            (object[0] as List).map((e) => SuiApiArgument.fromJson(e)).toList(),
        address: SuiApiArgument.fromJson(object[1]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "TransferObjects": [
        objects.map((e) => e.toJson()).toList(),
        address.toJson()
      ]
    };
  }
}

class SuiApiTransactionSplitCoins extends SuiApiTransaction {
  final List<SuiApiArgument> amounts;
  final SuiApiArgument coin;
  const SuiApiTransactionSplitCoins({required this.coin, required this.amounts})
      : super(type: SuiApiTransactionCommands.splitCoins);
  factory SuiApiTransactionSplitCoins.fromJson(Map<String, dynamic> json) {
    final object = json["SplitCoins"] as List;
    return SuiApiTransactionSplitCoins(
        amounts:
            (object[1] as List).map((e) => SuiApiArgument.fromJson(e)).toList(),
        coin: SuiApiArgument.fromJson(object[0]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "SplitCoins": [
        coin.toJson(),
        amounts.map((e) => e.toJson()).toList(),
      ]
    };
  }
}

class SuiApiTransactionMergeCoins extends SuiApiTransaction {
  final List<SuiApiArgument> sources;
  final SuiApiArgument destination;
  const SuiApiTransactionMergeCoins(
      {required this.destination, required this.sources})
      : super(type: SuiApiTransactionCommands.mergeCoins);
  factory SuiApiTransactionMergeCoins.fromJson(Map<String, dynamic> json) {
    final object = json["MergeCoins"] as List;
    return SuiApiTransactionMergeCoins(
        sources:
            (object[1] as List).map((e) => SuiApiArgument.fromJson(e)).toList(),
        destination: SuiApiArgument.fromJson(object[0]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "MergeCoins": [
        destination.toJson(),
        sources.map((e) => e.toJson()).toList(),
      ]
    };
  }
}

class SuiApiTransactionPublish extends SuiApiTransaction {
  final List<String> publish;
  const SuiApiTransactionPublish(this.publish)
      : super(type: SuiApiTransactionCommands.publish);
  factory SuiApiTransactionPublish.fromJson(Map<String, dynamic> json) {
    return SuiApiTransactionPublish(json.asListOfString("Publish")!);
  }
  @override
  Map<String, dynamic> toJson() {
    return {"Publish": publish};
  }
}

class SuiApiTransactionUpgrade extends SuiApiTransaction {
  final List<String> modules;
  final String package;
  final SuiApiArgument ticket;
  const SuiApiTransactionUpgrade(
      {required this.modules, required this.package, required this.ticket})
      : super(type: SuiApiTransactionCommands.upgrade);
  factory SuiApiTransactionUpgrade.fromJson(Map<String, dynamic> json) {
    final object = json["Upgrade"] as List;
    return SuiApiTransactionUpgrade(
        modules: (object[0] as List).cast(),
        package: object[1],
        ticket: SuiApiArgument.fromJson(object[2]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "Upgrade": [modules, package, ticket.toJson()]
    };
  }
}

class SuiApiTransactionMakeMoveVec extends SuiApiTransaction {
  final List<SuiApiArgument> elements;
  final String? inputType;
  const SuiApiTransactionMakeMoveVec(
      {required this.inputType, required this.elements})
      : super(type: SuiApiTransactionCommands.makeMoveVec);
  factory SuiApiTransactionMakeMoveVec.fromJson(Map<String, dynamic> json) {
    final object = json["MakeMoveVec"] as List;
    return SuiApiTransactionMakeMoveVec(
        elements:
            (object[1] as List).map((e) => SuiApiArgument.fromJson(e)).toList(),
        inputType: object[0]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "MakeMoveVec": [
        inputType,
        elements.map((e) => e.toJson()).toList(),
      ]
    };
  }
}

class SuiApiJWK {
  final String alg;
  final String e;
  final String kty;
  final String n;
  const SuiApiJWK(
      {required this.alg, required this.e, required this.kty, required this.n});
  factory SuiApiJWK.fromJson(Map<String, dynamic> json) {
    return SuiApiJWK(
        alg: json.as("alg"),
        e: json.as("e"),
        kty: json.as("kty"),
        n: json.as("n"));
  }
  Map<String, dynamic> toJson() {
    return {"alg": alg, "e": e, "kty": kty, "n": n};
  }
}

class SuiApiJwkId {
  final String iss;
  final String kid;
  const SuiApiJwkId({required this.iss, required this.kid});
  factory SuiApiJwkId.fromJson(Map<String, dynamic> json) {
    return SuiApiJwkId(iss: json.as("iss"), kid: json.as("kid"));
  }
  Map<String, dynamic> toJson() {
    return {"iss": iss, "kid": kid};
  }
}

class SuiApiActiveJWK {
  final String epoch;
  final SuiApiJWK jwk;
  final SuiApiJwkId jwkId;
  const SuiApiActiveJWK(
      {required this.epoch, required this.jwk, required this.jwkId});
  factory SuiApiActiveJWK.fromJson(Map<String, dynamic> json) {
    return SuiApiActiveJWK(
        epoch: json.as("epoch"),
        jwk: SuiApiJWK.fromJson(json.asMap("jwk")),
        jwkId: SuiApiJwkId.fromJson(json.asMap("jwk_id")));
  }
  Map<String, dynamic> toJson() {
    return {"epoch": epoch, "jwk": jwk.toJson(), "jwk_id": jwkId.toJson()};
  }
}

class SuiApiChangeEpoch {
  final String computationCharge;
  final String epoch;
  final String epochStartTimestampMS;
  final String storageCharge;
  final String storageRebate;
  const SuiApiChangeEpoch(
      {required this.computationCharge,
      required this.epoch,
      required this.epochStartTimestampMS,
      required this.storageCharge,
      required this.storageRebate});
  factory SuiApiChangeEpoch.fromJson(Map<String, dynamic> json) {
    return SuiApiChangeEpoch(
        computationCharge: json.as("computation_charge"),
        epoch: json.as("epoch"),
        epochStartTimestampMS: json.as("epoch_start_timestamp_ms"),
        storageCharge: json.as("storage_charge"),
        storageRebate: json.as("storage_rebate"));
  }
  Map<String, dynamic> toJson() {
    return {
      "computation_charge": computationCharge,
      "epoch": epoch,
      "epoch_start_timestamp_ms": epochStartTimestampMS,
      "storage_charge": storageCharge,
      "storage_rebate": storageRebate
    };
  }
}

class SuiApiAuthenticatorStateExpire {
  final String minEpoch;
  const SuiApiAuthenticatorStateExpire(this.minEpoch);
  factory SuiApiAuthenticatorStateExpire.fromJson(Map<String, dynamic> json) {
    return SuiApiAuthenticatorStateExpire(json.as("min_epoch"));
  }
  Map<String, dynamic> toJson() {
    return {"min_epoch": minEpoch};
  }
}

enum SuiApiEndOfEpochTransactionKinds {
  authenticatorStateCreate,
  randomNessStateCreate,
  coinDenyListStateCreate,
  changeEpoch,
  authenticatorStateExpire,
  bridgeStateCreate,
  bridgeCommitteeUpdate;

  static SuiApiEndOfEpochTransactionKinds fromName(String? name) {
    return values.firstWhere(
      (e) => e.name.toLowerCase() == name?.toLowerCase(),
      orElse: () => throw DartSuiPluginException(
          "cannot find correct EndOfEpochTransactionKind from the given name.",
          details: {"name": name}),
    );
  }
}

abstract class SuiApiEndOfEpochTransactionKind {
  final SuiApiEndOfEpochTransactionKinds type;
  const SuiApiEndOfEpochTransactionKind({required this.type});
  Map<String, dynamic> toJson();
  factory SuiApiEndOfEpochTransactionKind.fromJson(Map<String, dynamic> json) {
    final key = json.keys.first;
    final type = SuiApiEndOfEpochTransactionKinds.fromName(key);
    return switch (type) {
      SuiApiEndOfEpochTransactionKinds.authenticatorStateCreate =>
        SuiApiEndOfEpochTransactionKindAuthenticatorStateCreate(),
      SuiApiEndOfEpochTransactionKinds.randomNessStateCreate =>
        SuiApiEndOfEpochTransactionKindRandomNessStateCreate(),
      SuiApiEndOfEpochTransactionKinds.coinDenyListStateCreate =>
        SuiApiEndOfEpochTransactionKindCoinDenyListStateCreate(),
      SuiApiEndOfEpochTransactionKinds.changeEpoch =>
        SuiApiEndOfEpochTransactionKindChangeEpoch.fromJson(json),
      SuiApiEndOfEpochTransactionKinds.authenticatorStateExpire =>
        SuiApiEndOfEpochTransactionKindAuthenticatorStateExpire.fromJson(json),
      SuiApiEndOfEpochTransactionKinds.bridgeStateCreate =>
        SuiApiEndOfEpochTransactionKindBridgeStateCreate.fromJson(json),
      SuiApiEndOfEpochTransactionKinds.bridgeCommitteeUpdate =>
        SuiApiEndOfEpochTransactionKindBridgeCommitteeUpdate.fromJson(json),
    };
  }
  T cast<T extends SuiApiEndOfEpochTransactionKind>() {
    if (this is! T) {
      throw DartSuiPluginException(
          "SuiApiEndOfEpochTransactionKind casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiEndOfEpochTransactionKindAuthenticatorStateCreate
    extends SuiApiEndOfEpochTransactionKind {
  SuiApiEndOfEpochTransactionKindAuthenticatorStateCreate()
      : super(type: SuiApiEndOfEpochTransactionKinds.authenticatorStateCreate);

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }
}

class SuiApiEndOfEpochTransactionKindRandomNessStateCreate
    extends SuiApiEndOfEpochTransactionKind {
  SuiApiEndOfEpochTransactionKindRandomNessStateCreate()
      : super(type: SuiApiEndOfEpochTransactionKinds.randomNessStateCreate);

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }
}

class SuiApiEndOfEpochTransactionKindCoinDenyListStateCreate
    extends SuiApiEndOfEpochTransactionKind {
  SuiApiEndOfEpochTransactionKindCoinDenyListStateCreate()
      : super(type: SuiApiEndOfEpochTransactionKinds.coinDenyListStateCreate);

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }
}

class SuiApiEndOfEpochTransactionKindChangeEpoch
    extends SuiApiEndOfEpochTransactionKind {
  final SuiApiChangeEpoch changeEpoch;
  SuiApiEndOfEpochTransactionKindChangeEpoch(this.changeEpoch)
      : super(type: SuiApiEndOfEpochTransactionKinds.changeEpoch);
  factory SuiApiEndOfEpochTransactionKindChangeEpoch.fromJson(
      Map<String, dynamic> json) {
    return SuiApiEndOfEpochTransactionKindChangeEpoch(
        SuiApiChangeEpoch.fromJson(json.asMap("ChangeEpoch")));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "ChangeEpoch": changeEpoch.toJson()};
  }
}

class SuiApiEndOfEpochTransactionKindAuthenticatorStateExpire
    extends SuiApiEndOfEpochTransactionKind {
  final SuiApiAuthenticatorStateExpire authenticatorStateExpire;
  SuiApiEndOfEpochTransactionKindAuthenticatorStateExpire(
      this.authenticatorStateExpire)
      : super(type: SuiApiEndOfEpochTransactionKinds.authenticatorStateExpire);
  factory SuiApiEndOfEpochTransactionKindAuthenticatorStateExpire.fromJson(
      Map<String, dynamic> json) {
    return SuiApiEndOfEpochTransactionKindAuthenticatorStateExpire(
        SuiApiAuthenticatorStateExpire.fromJson(
            json.asMap("AuthenticatorStateExpire")));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "AuthenticatorStateExpire": authenticatorStateExpire.toJson()
    };
  }
}

class SuiApiEndOfEpochTransactionKindBridgeStateCreate
    extends SuiApiEndOfEpochTransactionKind {
  final String bridgeStateCreate;
  SuiApiEndOfEpochTransactionKindBridgeStateCreate(this.bridgeStateCreate)
      : super(type: SuiApiEndOfEpochTransactionKinds.bridgeStateCreate);
  factory SuiApiEndOfEpochTransactionKindBridgeStateCreate.fromJson(
      Map<String, dynamic> json) {
    return SuiApiEndOfEpochTransactionKindBridgeStateCreate(
        json.as("BridgeStateCreate"));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "BridgeStateCreate": bridgeStateCreate};
  }
}

class SuiApiEndOfEpochTransactionKindBridgeCommitteeUpdate
    extends SuiApiEndOfEpochTransactionKind {
  final String bridgeCommitteeUpdate;
  SuiApiEndOfEpochTransactionKindBridgeCommitteeUpdate(
      this.bridgeCommitteeUpdate)
      : super(type: SuiApiEndOfEpochTransactionKinds.bridgeCommitteeUpdate);
  factory SuiApiEndOfEpochTransactionKindBridgeCommitteeUpdate.fromJson(
      Map<String, dynamic> json) {
    return SuiApiEndOfEpochTransactionKindBridgeCommitteeUpdate(
        json.as("BridgeCommitteeUpdate"));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "BridgeCommitteeUpdate": bridgeCommitteeUpdate};
  }
}

enum SuiApiTransactionBlockKinds {
  changeEpoch,
  genesis,
  consensusCommitPrologue,
  programmableTransaction,
  authenticatorStateUpdate,
  randomNessStateUpdate,
  endOfEpochTransaction,
  consensusCommitPrologueV2,
  consensusCommitPrologueV3;

  static SuiApiTransactionBlockKinds fromName(String? name) {
    return values.firstWhere(
      (e) => e.name.toLowerCase() == name?.toLowerCase(),
      orElse: () => throw DartSuiPluginException(
          "cannot find correct TransactionBlockKind from the given name.",
          details: {"name": name}),
    );
  }
}

abstract class SuiApiTransactionBlockKind {
  final SuiApiTransactionBlockKinds kind;
  const SuiApiTransactionBlockKind({required this.kind});
  Map<String, dynamic> toJson();
  factory SuiApiTransactionBlockKind.fromJson(Map<String, dynamic> json) {
    final kind = SuiApiTransactionBlockKinds.fromName(json.as("kind"));
    return switch (kind) {
      SuiApiTransactionBlockKinds.changeEpoch =>
        SuiApiTransactionBlockKindChangeEpoch.fromJson(json),
      SuiApiTransactionBlockKinds.genesis =>
        SuiApiTransactionBlockKindGenesis.fromJson(json),
      SuiApiTransactionBlockKinds.consensusCommitPrologue =>
        SuiApiTransactionBlockKindConsensusCommitPrologue.fromJson(json),
      SuiApiTransactionBlockKinds.consensusCommitPrologueV2 =>
        SuiApiTransactionBlockKindConsensusCommitPrologueV2.fromJson(json),
      SuiApiTransactionBlockKinds.consensusCommitPrologueV3 =>
        SuiApiTransactionBlockKindConsensusCommitPrologueV3.fromJson(json),
      SuiApiTransactionBlockKinds.programmableTransaction =>
        SuiApiTransactionBlockKindProgrammableTransaction.fromJson(json),
      SuiApiTransactionBlockKinds.authenticatorStateUpdate =>
        SuiApiTransactionBlockKindAuthenticatorStateUpdate.fromJson(json),
      SuiApiTransactionBlockKinds.randomNessStateUpdate =>
        SuiApiTransactionBlockKindRandomNessStateUpdate.fromJson(json),
      SuiApiTransactionBlockKinds.endOfEpochTransaction =>
        SuiApiTransactionBlockKindEndOfEpochTransaction.fromJson(json),
    };
  }
  T cast<T extends SuiApiTransactionBlockKind>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiTransactionBlockKind casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiTransactionBlockKindChangeEpoch extends SuiApiTransactionBlockKind {
  final String computationCharge;
  final String epoch;
  final String epochStartTimestampMS;
  final String storageCharge;
  final String storageRebate;
  const SuiApiTransactionBlockKindChangeEpoch(
      {required this.computationCharge,
      required this.epoch,
      required this.epochStartTimestampMS,
      required this.storageCharge,
      required this.storageRebate})
      : super(kind: SuiApiTransactionBlockKinds.changeEpoch);
  factory SuiApiTransactionBlockKindChangeEpoch.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockKindChangeEpoch(
        computationCharge: json.as("computation_charge"),
        epoch: json.as("epoch"),
        epochStartTimestampMS: json.as("epoch_start_timestamp_ms"),
        storageCharge: json.as("storage_charge"),
        storageRebate: json.as("storage_rebate"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "kind": kind.name,
      "computation_charge": computationCharge,
      "epoch": epoch,
      "epoch_start_timestamp_ms": epochStartTimestampMS,
      "storage_charge": storageCharge,
      "storage_rebate": storageRebate
    };
  }
}

class SuiApiTransactionBlockKindGenesis extends SuiApiTransactionBlockKind {
  final List<String> objects;
  const SuiApiTransactionBlockKindGenesis(this.objects)
      : super(kind: SuiApiTransactionBlockKinds.genesis);
  factory SuiApiTransactionBlockKindGenesis.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockKindGenesis(json.asListOfString("objects")!);
  }
  @override
  Map<String, dynamic> toJson() {
    return {"kind": kind.name, "objects": objects};
  }
}

class SuiApiTransactionBlockKindConsensusCommitPrologue
    extends SuiApiTransactionBlockKind {
  final String commitTimestampMs;
  final String epoch;
  final String round;
  const SuiApiTransactionBlockKindConsensusCommitPrologue(
      {required this.commitTimestampMs,
      required this.epoch,
      required this.round})
      : super(kind: SuiApiTransactionBlockKinds.consensusCommitPrologue);
  factory SuiApiTransactionBlockKindConsensusCommitPrologue.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockKindConsensusCommitPrologue(
        commitTimestampMs: json.as("commit_timestamp_ms"),
        epoch: json.as("epoch"),
        round: json.as("round"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "kind": kind.name,
      "commit_timestamp_ms": commitTimestampMs,
      "epoch": epoch,
      "round": round
    };
  }
}

class SuiApiTransactionBlockKindProgrammableTransaction
    extends SuiApiTransactionBlockKind {
  final List<SuiApiCallArg> inputs;
  final List<SuiApiTransaction> transactions;
  const SuiApiTransactionBlockKindProgrammableTransaction(
      {required this.inputs, required this.transactions})
      : super(kind: SuiApiTransactionBlockKinds.programmableTransaction);
  factory SuiApiTransactionBlockKindProgrammableTransaction.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockKindProgrammableTransaction(
      inputs: json
          .asListOfMap("inputs")!
          .map((e) => SuiApiCallArg.fromJson(e))
          .toList(),
      transactions: json
          .asListOfMap("transactions")!
          .map((e) => SuiApiTransaction.fromJson(e))
          .toList(),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "kind": kind.name,
      "transactions": transactions.map((e) => e.toJson()).toList(),
      "inputs": inputs.map((e) => e.toJson()).toList()
    };
  }
}

class SuiApiTransactionBlockKindAuthenticatorStateUpdate
    extends SuiApiTransactionBlockKind {
  final List<SuiApiActiveJWK> newActiveJwks;
  final String epoch;
  final String round;
  const SuiApiTransactionBlockKindAuthenticatorStateUpdate(
      {required this.newActiveJwks, required this.epoch, required this.round})
      : super(kind: SuiApiTransactionBlockKinds.authenticatorStateUpdate);
  factory SuiApiTransactionBlockKindAuthenticatorStateUpdate.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockKindAuthenticatorStateUpdate(
        newActiveJwks: json
            .asListOfMap("new_active_jwks")!
            .map((e) => SuiApiActiveJWK.fromJson(e))
            .toList(),
        epoch: json.as("epoch"),
        round: json.as("round"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "kind": kind.name,
      "new_active_jwks": newActiveJwks.map((e) => e.toJson()).toList(),
      "round": round,
      "epoch": epoch
    };
  }
}

class SuiApiTransactionBlockKindRandomNessStateUpdate
    extends SuiApiTransactionBlockKind {
  final List<int> randomBytes;
  final String epoch;
  final String randomNessRound;
  const SuiApiTransactionBlockKindRandomNessStateUpdate(
      {required this.randomBytes,
      required this.epoch,
      required this.randomNessRound})
      : super(kind: SuiApiTransactionBlockKinds.randomNessStateUpdate);
  factory SuiApiTransactionBlockKindRandomNessStateUpdate.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockKindRandomNessStateUpdate(
        randomBytes: (json["random_bytes"] as List).cast(),
        epoch: json.as("epoch"),
        randomNessRound: json.as("randomness_round"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "kind": kind.name,
      "random_bytes": randomBytes,
      "randomness_round": randomNessRound,
      "epoch": epoch
    };
  }
}

class SuiApiTransactionBlockKindEndOfEpochTransaction
    extends SuiApiTransactionBlockKind {
  final List<SuiApiEndOfEpochTransactionKind> transactions;

  const SuiApiTransactionBlockKindEndOfEpochTransaction(this.transactions)
      : super(kind: SuiApiTransactionBlockKinds.endOfEpochTransaction);
  factory SuiApiTransactionBlockKindEndOfEpochTransaction.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockKindEndOfEpochTransaction(json
        .asListOfMap("transactions")!
        .map((e) => SuiApiEndOfEpochTransactionKind.fromJson(e))
        .toList());
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "kind": kind.name,
      "transactions": transactions.map((e) => e.toJson()).toList()
    };
  }
}

class SuiApiTransactionBlockKindConsensusCommitPrologueV2
    extends SuiApiTransactionBlockKind {
  final String commitTimestampMs;
  final String consensusCommitDigest;
  final String epoch;
  final String round;

  const SuiApiTransactionBlockKindConsensusCommitPrologueV2(
      {required this.commitTimestampMs,
      required this.consensusCommitDigest,
      required this.epoch,
      required this.round})
      : super(kind: SuiApiTransactionBlockKinds.consensusCommitPrologueV2);
  factory SuiApiTransactionBlockKindConsensusCommitPrologueV2.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockKindConsensusCommitPrologueV2(
        commitTimestampMs: json.as("commit_timestamp_ms"),
        consensusCommitDigest: json.as("consensus_commit_digest"),
        epoch: json.as("epoch"),
        round: json.as("round"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "kind": kind.name,
      "epoch": epoch,
      "round": round,
      "consensus_commit_digest": consensusCommitDigest,
      "commit_timestamp_ms": commitTimestampMs
    };
  }
}

class ConsensusDeterminedVersionAssignments {
  final List<dynamic> canceledTransactions;
  const ConsensusDeterminedVersionAssignments(this.canceledTransactions);
  factory ConsensusDeterminedVersionAssignments.fromJson(
      Map<String, dynamic> json) {
    return ConsensusDeterminedVersionAssignments(json["CancelledTransactions"]);
  }
  Map<String, dynamic> toJson() {
    return {"CancelledTransactions": canceledTransactions};
  }
}

class SuiApiTransactionBlockKindConsensusCommitPrologueV3
    extends SuiApiTransactionBlockKind {
  final String commitTimestampMs;
  final String consensusCommitDigest;
  final ConsensusDeterminedVersionAssignments
      consensusDeterminedVersionAssignments;
  final String epoch;
  final String round;
  final String? subDgIndex;

  const SuiApiTransactionBlockKindConsensusCommitPrologueV3(
      {required this.commitTimestampMs,
      required this.consensusCommitDigest,
      required this.consensusDeterminedVersionAssignments,
      required this.subDgIndex,
      required this.epoch,
      required this.round})
      : super(kind: SuiApiTransactionBlockKinds.consensusCommitPrologueV3);
  factory SuiApiTransactionBlockKindConsensusCommitPrologueV3.fromJson(
      Map<String, dynamic> json) {
    return SuiApiTransactionBlockKindConsensusCommitPrologueV3(
        commitTimestampMs: json.as("commit_timestamp_ms"),
        consensusCommitDigest: json.as("consensus_commit_digest"),
        epoch: json.as("epoch"),
        round: json.as("round"),
        consensusDeterminedVersionAssignments:
            ConsensusDeterminedVersionAssignments.fromJson(
                json.as("consensus_determined_version_assignments")),
        subDgIndex: json.as("sub_dg_index"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "kind": kind.name,
      "epoch": epoch,
      "round": round,
      "consensus_commit_digest": consensusCommitDigest,
      "commit_timestamp_ms": commitTimestampMs,
      "consensus_determined_version_assignments":
          consensusDeterminedVersionAssignments.toJson(),
      "sub_dg_index": subDgIndex
    };
  }
}

class SuiApiTransactionBlockData {
  final SuiApiGasData gasData;
  final String sender;
  final SuiApiTransactionBlockKind transaction;
  const SuiApiTransactionBlockData(
      {required this.gasData, required this.sender, required this.transaction});
  factory SuiApiTransactionBlockData.fromJson(Map<String, dynamic> json) {
    return SuiApiTransactionBlockData(
        gasData: SuiApiGasData.fromJson(json.asMap("gasData")),
        sender: json.as("sender"),
        transaction:
            SuiApiTransactionBlockKind.fromJson(json.asMap("transaction")));
  }
  Map<String, dynamic> toJson() {
    return {
      "gasData": gasData.toJson(),
      "sender": sender,
      "transaction": transaction.toJson()
    };
  }
}

class SuiApiTransactionBlock {
  final SuiApiTransactionBlockData data;
  final List<String> txSignatures;
  const SuiApiTransactionBlock(
      {required this.data, required this.txSignatures});
  factory SuiApiTransactionBlock.fromJson(Map<String, dynamic> json) {
    return SuiApiTransactionBlock(
        data: SuiApiTransactionBlockData.fromJson(json.asMap("data")),
        txSignatures: json.asListOfString("txSignatures")!);
  }
  Map<String, dynamic> toJson() {
    return {"data": data.toJson(), "txSignatures": txSignatures};
  }
}

class SuiApiTransactionBlockResponse {
  final List<SuiApiBalanceChange>? balanceChanges;
  final String? checkpoint;
  final bool? confirmedLocalExecution;
  final String digest;
  final SuiApiTransactionEffects? effects;
  final List<String>? errors;
  final List<SuiApiEvent>? events;
  final List<SuiApiObjectChange>? objectChanges;
  final List<int>? rawEffects;
  final String? rawTransaction;
  final String? timestampMs;
  final SuiApiTransactionBlock? transaction;
  const SuiApiTransactionBlockResponse(
      {required this.balanceChanges,
      required this.checkpoint,
      required this.confirmedLocalExecution,
      required this.digest,
      required this.effects,
      required this.errors,
      required this.events,
      required this.objectChanges,
      required this.rawEffects,
      required this.rawTransaction,
      required this.timestampMs,
      required this.transaction});
  factory SuiApiTransactionBlockResponse.fromJson(Map<String, dynamic> json) {
    return SuiApiTransactionBlockResponse(
        balanceChanges: json
            .asListOfMap("balanceChanges", throwOnNull: false)
            ?.map((e) => SuiApiBalanceChange.fromJson(e))
            .toList(),
        checkpoint: json.as("checkpoint"),
        confirmedLocalExecution: json.as("confirmedLocalExecution"),
        digest: json.as("digest"),
        effects: json["effects"] == null
            ? null
            : SuiApiTransactionEffects.fromJson(json.asMap("effects")),
        errors: (json["errors"] as List?)?.cast(),
        events: json
            .asListOfMap("events", throwOnNull: false)
            ?.map((e) => SuiApiEvent.fromJson(e))
            .toList(),
        objectChanges: json
            .asListOfMap("objectChanges", throwOnNull: false)
            ?.map((e) => SuiApiObjectChange.fromJson(e))
            .toList(),
        rawEffects: (json["rawEffects"] as List?)?.cast(),
        rawTransaction: json.as("rawTransaction"),
        timestampMs: json.as("timestampMs"),
        transaction: json["transaction"] == null
            ? null
            : SuiApiTransactionBlock.fromJson(json.asMap("transaction")));
  }
  Map<String, dynamic> toJson() {
    return {
      "balanceChanges": balanceChanges?.map((e) => e.toJson()).toList(),
      "checkpoint": checkpoint,
      "confirmedLocalExecution": confirmedLocalExecution,
      "digest": digest,
      "effects": effects?.toJson(),
      "errors": errors,
      "events": events?.map((e) => e.toJson()).toList(),
      "objectChanges": objectChanges?.map((e) => e.toJson()).toList(),
      "rawEffects": rawEffects,
      "rawTransaction": rawTransaction,
      "timestampMs": timestampMs,
      "transaction": transaction?.toJson()
    };
  }
}

class SuiApiPaginatedTransactionResponse extends SuiApiResponsePagination {
  final List<SuiApiTransactionBlockResponse> data;
  const SuiApiPaginatedTransactionResponse({required this.data});
  SuiApiPaginatedTransactionResponse.fromJson(super.json)
      : data = json
            .asListOfMap("data")!
            .map((e) => SuiApiTransactionBlockResponse.fromJson(e))
            .toImutableList,
        super.fromJson();
}

class SuiApiResolveNameServiceNamesResponse extends SuiApiResponsePagination {
  final List<String> data;
  const SuiApiResolveNameServiceNamesResponse({required this.data});
  SuiApiResolveNameServiceNamesResponse.fromJson(super.json)
      : data = json.asListOfString("data")!,
        super.fromJson();
}

class SuiApiCommitteeInfo {
  final String epoch;
  final List<List<String>> validators;
  const SuiApiCommitteeInfo({required this.epoch, required this.validators});
  factory SuiApiCommitteeInfo.fromJson(Map<String, dynamic> json) {
    return SuiApiCommitteeInfo(
        epoch: json.as("epoch"),
        validators: (json["validators"] as List)
            .map((e) => (e as List).cast<String>())
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {"epoch": epoch, "validators": validators};
  }
}

class SuiApiStakeObject {
  final String principal;
  final String stakeActiveEpoch;
  final String stakeRequestEpoch;
  final String stakedSuiId;
  final String status;
  final String? estimatedReward;
  const SuiApiStakeObject(
      {required this.principal,
      required this.stakeActiveEpoch,
      required this.stakeRequestEpoch,
      required this.stakedSuiId,
      required this.status,
      required this.estimatedReward});
  factory SuiApiStakeObject.fromJson(Map<String, dynamic> json) {
    return SuiApiStakeObject(
        principal: json.as("principal"),
        stakeActiveEpoch: json.as("stakeActiveEpoch"),
        stakeRequestEpoch: json.as("stakeRequestEpoch"),
        stakedSuiId: json.as("stakedSuiId"),
        status: json.as("status"),
        estimatedReward: json.as("estimatedReward"));
  }

  Map<String, dynamic> toJson() {
    return {
      "principal": principal,
      "stakeActiveEpoch": stakeActiveEpoch,
      "stakeRequestEpoch": stakeRequestEpoch,
      "stakedSuiId": stakedSuiId,
      "status": status,
      "estimatedReward": estimatedReward
    };
  }
}

class SuiApiDelegatedStake {
  final List<SuiApiStakeObject> stakes;
  final String stakingPool;
  final String validatorAddress;
  const SuiApiDelegatedStake(
      {required this.stakes,
      required this.stakingPool,
      required this.validatorAddress});
  factory SuiApiDelegatedStake.fromJson(Map<String, dynamic> json) {
    return SuiApiDelegatedStake(
        stakes: json
            .asListOfMap("stakes")!
            .map((e) => SuiApiStakeObject.fromJson(e))
            .toList(),
        stakingPool: json.as("stakingPool"),
        validatorAddress: json.as("validatorAddress"));
  }

  Map<String, dynamic> toJson() {
    return {
      "stakes": stakes.map((e) => e.toJson()).toList(),
      "stakingPool": stakingPool,
      "validatorAddress": validatorAddress
    };
  }
}

class SuiApiValidatorApy {
  final num apy;
  final String address;
  const SuiApiValidatorApy({required this.apy, required this.address});
  factory SuiApiValidatorApy.fromJson(Map<String, dynamic> json) {
    return SuiApiValidatorApy(apy: json.as("apy"), address: json.as("address"));
  }

  Map<String, dynamic> toJson() {
    return {"apy": apy, "address": address};
  }
}

class SuiApiValidatorsApy {
  final List<SuiApiValidatorApy> apys;
  final String epoch;
  const SuiApiValidatorsApy({required this.apys, required this.epoch});
  factory SuiApiValidatorsApy.fromJson(Map<String, dynamic> json) {
    return SuiApiValidatorsApy(
        apys: json
            .asListOfMap("apys")!
            .map((e) => SuiApiValidatorApy.fromJson(e))
            .toList(),
        epoch: json.as("epoch"));
  }

  Map<String, dynamic> toJson() {
    return {"apys": apys.map((e) => e.toJson()).toList(), "epoch": epoch};
  }
}

class SuiApiECMHLiveObjectSetDigest {
  final List<int> digest;
  const SuiApiECMHLiveObjectSetDigest(this.digest);
  factory SuiApiECMHLiveObjectSetDigest.fromJson(Map<String, dynamic> json) {
    return SuiApiECMHLiveObjectSetDigest((json["digest"] as List).cast());
  }
  Map<String, dynamic> toJson() {
    return {"digest": digest};
  }
}

class SuiApiCheckpointCommitment {
  final SuiApiECMHLiveObjectSetDigest ecmhLiveObjectSetDigest;
  const SuiApiCheckpointCommitment(this.ecmhLiveObjectSetDigest);
  factory SuiApiCheckpointCommitment.fromJson(Map<String, dynamic> json) {
    return SuiApiCheckpointCommitment(SuiApiECMHLiveObjectSetDigest.fromJson(
        json.asMap("SuiApiECMHLiveObjectSetDigest")));
  }
  Map<String, dynamic> toJson() {
    return {"SuiApiECMHLiveObjectSetDigest": ecmhLiveObjectSetDigest.toJson()};
  }
}

class SuiApiEndOfEpochData {
  final List<SuiApiCheckpointCommitment> epochCommitments;
  final List<List<String>> nextEpochCommittee;
  final String nextEpochProtocolVersion;
  const SuiApiEndOfEpochData(
      {required this.epochCommitments,
      required this.nextEpochCommittee,
      required this.nextEpochProtocolVersion});
  factory SuiApiEndOfEpochData.fromJson(Map<String, dynamic> json) {
    return SuiApiEndOfEpochData(
        epochCommitments: json
            .asListOfMap("epochCommitments")!
            .map((e) => SuiApiCheckpointCommitment.fromJson(e))
            .toList(),
        nextEpochCommittee: (json["nextEpochCommittee"] as List)
            .map((e) => (e as List).cast<String>())
            .toList(),
        nextEpochProtocolVersion: json.as("nextEpochProtocolVersion"));
  }
  Map<String, dynamic> toJson() {
    return {
      "epochCommitments": epochCommitments.map((e) => e.toJson()).toList(),
      "nextEpochCommittee": nextEpochCommittee,
      "nextEpochProtocolVersion": nextEpochProtocolVersion
    };
  }
}

class SuiApiCheckPoint {
  final List<SuiApiCheckpointCommitment> checkpointCommitments;
  final String digest;
  final SuiApiEndOfEpochData? endOfEpochData;
  final String epoch;
  final SuiApiGasCostSummary epochRollingGasCostSummary;
  final String networkTotalTransactions;
  final String? previousDigest;
  final String sequenceNumber;
  final String timestampMs;
  final List<String> transactions;
  final String validatorSignature;
  const SuiApiCheckPoint(
      {required this.checkpointCommitments,
      required this.digest,
      required this.endOfEpochData,
      required this.epoch,
      required this.epochRollingGasCostSummary,
      required this.networkTotalTransactions,
      required this.previousDigest,
      required this.sequenceNumber,
      required this.timestampMs,
      required this.transactions,
      required this.validatorSignature});
  factory SuiApiCheckPoint.fromJson(Map<String, dynamic> json) {
    return SuiApiCheckPoint(
        checkpointCommitments: json
            .asListOfMap("checkpointCommitments")!
            .map((e) => SuiApiCheckpointCommitment.fromJson(e))
            .toList(),
        digest: json.as("digest"),
        endOfEpochData: json["endOfEpochData"] == null
            ? null
            : SuiApiEndOfEpochData.fromJson(json.asMap("endOfEpochData")),
        epoch: json.as("epoch"),
        epochRollingGasCostSummary: SuiApiGasCostSummary.fromJson(
            json.asMap("epochRollingGasCostSummary")),
        networkTotalTransactions: json.as("networkTotalTransactions"),
        previousDigest: json.as("previousDigest"),
        sequenceNumber: json.as("sequenceNumber"),
        timestampMs: json.as("timestampMs"),
        transactions: json.asListOfString("transactions")!,
        validatorSignature: json.as("validatorSignature"));
  }

  Map<String, dynamic> toJson() {
    return {
      "checkpointCommitments":
          checkpointCommitments.map((e) => e.toJson()).toList(),
      "digest": digest,
      "endOfEpochData": endOfEpochData?.toJson(),
      "epoch": epoch,
      "epochRollingGasCostSummary": epochRollingGasCostSummary.toJson(),
      "networkTotalTransactions": networkTotalTransactions,
      "previousDigest": previousDigest,
      "sequenceNumber": sequenceNumber,
      "timestampMs": timestampMs,
      "transactions": transactions,
      "validatorSignature": validatorSignature
    };
  }
}

class SuiApiPaginatedCheckPointResponse extends SuiApiResponsePagination {
  final List<SuiApiCheckPoint> data;
  const SuiApiPaginatedCheckPointResponse({required this.data});
  SuiApiPaginatedCheckPointResponse.fromJson(super.json)
      : data = json
            .asListOfMap("data")!
            .map((e) => SuiApiCheckPoint.fromJson(e))
            .toImutableList,
        super.fromJson();
  @override
  Map<String, dynamic> toJson() {
    return {"data": data.map((e) => e.toJson()).toList(), ...super.toJson()};
  }
}

class SuiApiProtocolConfig {
  final Map<String, dynamic> attributes;
  final Map<String, bool> featureFlags;
  final String maxSupportedProtocolVersion;
  final String minSupportedProtocolVersion;
  final String protocolVersion;
  const SuiApiProtocolConfig(
      {required this.attributes,
      required this.featureFlags,
      required this.maxSupportedProtocolVersion,
      required this.minSupportedProtocolVersion,
      required this.protocolVersion});

  Map<String, dynamic> toJson() {
    return {
      "attributes": attributes,
      "featureFlags": featureFlags,
      "maxSupportedProtocolVersion": maxSupportedProtocolVersion,
      "minSupportedProtocolVersion": minSupportedProtocolVersion,
      "protocolVersion": protocolVersion
    };
  }

  factory SuiApiProtocolConfig.fromJson(Map<String, dynamic> json) {
    return SuiApiProtocolConfig(
        attributes: json.asMap("attributes"),
        featureFlags: json.asMap<Map<String, dynamic>>("featureFlags").cast(),
        maxSupportedProtocolVersion: json.as("maxSupportedProtocolVersion"),
        minSupportedProtocolVersion: json.as("minSupportedProtocolVersion"),
        protocolVersion: json.as("protocolVersion"));
  }
}

enum SuiApiObjectReadStatus {
  versionFound,
  objectNotExists,
  objectDeleted,
  versionNotFound,
  versionToHigh;

  static SuiApiObjectReadStatus fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse: () => throw DartSuiPluginException(
          "cannot find correct ObjectReadStatus from the given name.",
          details: {"name": name}),
    );
  }
}

abstract class SuiApiObjectRead {
  final SuiApiObjectReadStatus status;
  const SuiApiObjectRead({required this.status});
  Map<String, dynamic> toJson();
  factory SuiApiObjectRead.fromJson(Map<String, dynamic> json) {
    final status = SuiApiObjectReadStatus.fromName(json.as("status"));
    return switch (status) {
      SuiApiObjectReadStatus.versionFound =>
        SuiApiObjectReadVersionFound.fromJson(json),
      SuiApiObjectReadStatus.objectNotExists =>
        SuiApiObjectReadObjectNotExists.fromJson(json),
      SuiApiObjectReadStatus.objectDeleted =>
        SuiApiObjectReadObjectDeleted.fromJson(json),
      SuiApiObjectReadStatus.versionNotFound =>
        SuiApiObjectReadObjectVersionNoFound.fromJson(json),
      SuiApiObjectReadStatus.versionToHigh =>
        SuiApiObjectReadObjectVersionToHigh.fromJson(json)
    };
  }
  T cast<T extends SuiApiObjectRead>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiObjectRead casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiObjectReadVersionFound extends SuiApiObjectRead {
  final SuiApiObjectData details;
  const SuiApiObjectReadVersionFound({required this.details})
      : super(status: SuiApiObjectReadStatus.versionFound);
  factory SuiApiObjectReadVersionFound.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectReadVersionFound(
        details: SuiApiObjectData.fromJson(json.asMap("details")));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"details": details.toJson(), "status": status.name};
  }
}

class SuiApiObjectReadObjectNotExists extends SuiApiObjectRead {
  final String details;
  const SuiApiObjectReadObjectNotExists({required this.details})
      : super(status: SuiApiObjectReadStatus.objectNotExists);
  factory SuiApiObjectReadObjectNotExists.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectReadObjectNotExists(details: json.as("details"));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"details": details, "status": status.name};
  }
}

class SuiApiObjectReadObjectDeleted extends SuiApiObjectRead {
  final SuiApiObjectRef details;
  const SuiApiObjectReadObjectDeleted({required this.details})
      : super(status: SuiApiObjectReadStatus.objectDeleted);
  factory SuiApiObjectReadObjectDeleted.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectReadObjectDeleted(
        details: SuiApiObjectRef.fromJson(json.asMap("details")));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"details": details.toJson(), "status": status.name};
  }
}

class SuiApiObjectVersionHighResponse {
  final String askedVersion;
  final String latestVersion;
  final String objectId;
  const SuiApiObjectVersionHighResponse(
      {required this.askedVersion,
      required this.latestVersion,
      required this.objectId});
  factory SuiApiObjectVersionHighResponse.fromJson(Map<String, dynamic> json) {
    return SuiApiObjectVersionHighResponse(
        askedVersion: json.as("asked_version"),
        latestVersion: json.as("latest_version"),
        objectId: json.as("object_id"));
  }
  Map<String, dynamic> toJson() {
    return {
      "asked_version": askedVersion,
      "latest_version": latestVersion,
      "object_id": objectId
    };
  }
}

class SuiApiObjectReadObjectVersionNoFound extends SuiApiObjectRead {
  final List<String> details;
  const SuiApiObjectReadObjectVersionNoFound({required this.details})
      : super(status: SuiApiObjectReadStatus.versionNotFound);
  factory SuiApiObjectReadObjectVersionNoFound.fromJson(
      Map<String, dynamic> json) {
    return SuiApiObjectReadObjectVersionNoFound(
        details: json.asListOfString("details")!);
  }
  @override
  Map<String, dynamic> toJson() {
    return {"details": details, "status": status.name};
  }
}

class SuiApiObjectReadObjectVersionToHigh extends SuiApiObjectRead {
  final SuiApiObjectVersionHighResponse details;
  const SuiApiObjectReadObjectVersionToHigh({required this.details})
      : super(status: SuiApiObjectReadStatus.versionToHigh);
  factory SuiApiObjectReadObjectVersionToHigh.fromJson(
      Map<String, dynamic> json) {
    return SuiApiObjectReadObjectVersionToHigh(
        details:
            SuiApiObjectVersionHighResponse.fromJson(json.asMap("details")!));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"details": details.toJson(), "status": status.name};
  }
}

class SuiApiGetPastObjectRequest {
  final String objectId;
  final String version;
  const SuiApiGetPastObjectRequest(
      {required this.objectId, required this.version});
  Map<String, dynamic> toJson() {
    return {"objectId": objectId, "version": version};
  }
}

abstract class SuiApiMoveFunctionArgType {
  const SuiApiMoveFunctionArgType();
  factory SuiApiMoveFunctionArgType.fromJson(Object json) {
    if (json == "Pure") return SuiApiMoveFunctionArgTypePure();
    return SuiApiMoveFunctionArgTypeObject.fromJson((json as Map).cast());
  }
  Map<String, dynamic> toJson();
  T cast<T extends SuiApiMoveFunctionArgType>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiMoveFunctionArgType casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }
}

class SuiApiMoveFunctionArgTypePure extends SuiApiMoveFunctionArgType {
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}

class SuiApiMoveFunctionArgTypeObject extends SuiApiMoveFunctionArgType {
  final String object;
  const SuiApiMoveFunctionArgTypeObject({required this.object});
  factory SuiApiMoveFunctionArgTypeObject.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveFunctionArgTypeObject(object: json.as("Object"));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"Object": object};
  }
}

enum SuiApiMoveNormalizedTypes {
  bool,
  u8,
  u16,
  u32,
  u64,
  u128,
  u256,
  address,
  signer,
  struct,
  vector,
  typeParameter,
  reference,
  mutableReference;

  static SuiApiMoveNormalizedTypes fromName(String? name) {
    return values.firstWhere(
      (e) => e.name.toLowerCase() == name?.toLowerCase(),
      orElse: () => throw DartSuiPluginException(
          "cannot find correct SuiApiMoveNormalizedType from the given name.",
          details: {"name": name}),
    );
  }
}

abstract class SuiApiMoveNormalizedType {
  final SuiApiMoveNormalizedTypes type;
  const SuiApiMoveNormalizedType({required this.type});
  factory SuiApiMoveNormalizedType.fromJson(Object json) {
    if (json is String) {
      final type = SuiApiMoveNormalizedTypes.fromName(json);
      return SuiApiMoveNormalizedTypePrimitive(type: type);
    }
    final key = (json as Map<String, dynamic>).keys.first;
    final type = SuiApiMoveNormalizedTypes.fromName(key);
    return switch (type) {
      SuiApiMoveNormalizedTypes.struct =>
        SuiApiMoveNormalizedTypeStruct.fromJson(json),
      SuiApiMoveNormalizedTypes.vector =>
        SuiApiMoveNormalizedTypeVector.fromJson(json),
      SuiApiMoveNormalizedTypes.typeParameter =>
        SuiApiMoveNormalizedTypeTypeParameter.fromJson(json),
      SuiApiMoveNormalizedTypes.reference =>
        SuiApiMoveNormalizedTypeReference.fromJson(json),
      SuiApiMoveNormalizedTypes.mutableReference =>
        SuiApiMoveNormalizedTypeMutableReference.fromJson(json),
      _ => throw DartSuiPluginException("Invalid SuiApiMoveNormalizedTypes.",
          details: {"type": type.name})
    };
  }
  Map<String, dynamic> toJson();
  T cast<T extends SuiApiMoveNormalizedType>() {
    if (this is! T) {
      throw DartSuiPluginException("SuiApiMoveNormalizedType casting failed.",
          details: {"expected": "$T", "type": "$runtimeType"});
    }
    return this as T;
  }

  MoveType? toSuiCallArgPrue({Object? value});
}

class SuiApiMoveNormalizedTypePrimitive extends SuiApiMoveNormalizedType {
  SuiApiMoveNormalizedTypePrimitive({required super.type});
  factory SuiApiMoveNormalizedTypePrimitive.fromJson(String json) {
    return SuiApiMoveNormalizedTypePrimitive(
        type: SuiApiMoveNormalizedTypes.fromName(json));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }

  @override
  MoveType? toSuiCallArgPrue({Object? value}) {
    return switch (type) {
      SuiApiMoveNormalizedTypes.u8 => MoveU8.parse(value),
      SuiApiMoveNormalizedTypes.u16 => MoveU16.parse(value),
      SuiApiMoveNormalizedTypes.u32 => MoveU32.parse(value),
      SuiApiMoveNormalizedTypes.u64 => MoveU64.parse(value),
      SuiApiMoveNormalizedTypes.u128 => MoveU128.parse(value),
      SuiApiMoveNormalizedTypes.u256 => MoveU256.parse(value),
      SuiApiMoveNormalizedTypes.address => MoveAddress.parse(value),
      _ => null
    } as MoveType?;
  }
}

class SuiApiMoveNormalizedTypeStructObject {
  final SuiAddress address;
  final String module;
  final String name;
  final List<SuiApiMoveNormalizedType> typeArguments;

  bool get isOption =>
      address == SuiAddress.one && name == 'Option' && module == 'option';
  bool get isTxContext =>
      address == SuiAddress.two &&
      name == 'TxContext' &&
      module == 'tx_context';
  bool get isString =>
      address == SuiAddress.one &&
      name == 'String' &&
      (module == 'string' || module == "ascii");

  bool get isObject =>
      address == SuiAddress.two && name == 'ID' && module == 'object';

  bool get isReceiving =>
      address == SuiAddress.two && name == 'Receiving' && module == 'transfer';

  const SuiApiMoveNormalizedTypeStructObject(
      {required this.address,
      required this.module,
      required this.name,
      required this.typeArguments});
  factory SuiApiMoveNormalizedTypeStructObject.fromJson(
      Map<String, dynamic> json) {
    return SuiApiMoveNormalizedTypeStructObject(
        address: SuiAddress(json.as("address")),
        module: json.as("module"),
        name: json.as("name"),
        typeArguments: (json["typeArguments"] as List)
            .map((e) => SuiApiMoveNormalizedType.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "module": module,
      "name": name,
      "typeArguments": typeArguments.map((e) => e.toJson()).toList()
    };
  }

  MoveType? toSuiCallArgPrue({Object? value}) {
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
        return MoveOption<MoveType>(
            typeArguments[0].toSuiCallArgPrue(value: value.value)!);
      }
      final type = typeArguments[0].toSuiCallArgPrue(value: value);
      if (type == null) {
        return MoveOption<MoveBool>(null);
      }
      return MoveOption<MoveType>(type);
    }
    return null;
  }
}

class SuiApiMoveNormalizedTypeStruct extends SuiApiMoveNormalizedType {
  final SuiApiMoveNormalizedTypeStructObject struct;
  SuiApiMoveNormalizedTypeStruct(this.struct)
      : super(type: SuiApiMoveNormalizedTypes.struct);
  factory SuiApiMoveNormalizedTypeStruct.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveNormalizedTypeStruct(
        SuiApiMoveNormalizedTypeStructObject.fromJson(json.asMap("Struct")));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "struct": struct.toJson(),
    };
  }

  @override
  MoveType? toSuiCallArgPrue({Object? value}) {
    return struct.toSuiCallArgPrue(value: value);
  }
}

class SuiApiMoveNormalizedTypeVector extends SuiApiMoveNormalizedType {
  final SuiApiMoveNormalizedType vector;
  SuiApiMoveNormalizedTypeVector(this.vector)
      : super(type: SuiApiMoveNormalizedTypes.vector);
  factory SuiApiMoveNormalizedTypeVector.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveNormalizedTypeVector(
        SuiApiMoveNormalizedType.fromJson(json.as("Vector")));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "Vector": vector.toJson(),
    };
  }

  @override
  MoveType? toSuiCallArgPrue({Object? value}) {
    if (value is MoveVector) {
      return MoveVector((value.value as List).map((e) {
        return vector.toSuiCallArgPrue(value: e)!;
      }).toList());
    }
    return MoveVector((value as List)
        .map((e) => vector.toSuiCallArgPrue(value: e)!)
        .toList());
  }
}

class SuiApiMoveNormalizedTypeTypeParameter extends SuiApiMoveNormalizedType {
  final int typeParameter;
  SuiApiMoveNormalizedTypeTypeParameter(this.typeParameter)
      : super(type: SuiApiMoveNormalizedTypes.typeParameter);
  factory SuiApiMoveNormalizedTypeTypeParameter.fromJson(
      Map<String, dynamic> json) {
    return SuiApiMoveNormalizedTypeTypeParameter(json.as("TypeParameter"));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "TypeParameter": typeParameter,
    };
  }

  @override
  MoveType? toSuiCallArgPrue({Object? value}) {
    return null;
  }
}

class SuiApiMoveNormalizedTypeReference extends SuiApiMoveNormalizedType {
  final SuiApiMoveNormalizedType reference;
  SuiApiMoveNormalizedTypeReference(this.reference)
      : super(type: SuiApiMoveNormalizedTypes.reference);
  factory SuiApiMoveNormalizedTypeReference.fromJson(
      Map<String, dynamic> json) {
    return SuiApiMoveNormalizedTypeReference(
        SuiApiMoveNormalizedType.fromJson(json.as("Reference")));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "Reference": reference.toJson(),
    };
  }

  @override
  MoveType? toSuiCallArgPrue({Object? value}) {
    return reference.toSuiCallArgPrue(value: value);
  }
}

class SuiApiMoveNormalizedTypeMutableReference
    extends SuiApiMoveNormalizedType {
  final SuiApiMoveNormalizedType mutableReference;
  SuiApiMoveNormalizedTypeMutableReference(this.mutableReference)
      : super(type: SuiApiMoveNormalizedTypes.mutableReference);
  factory SuiApiMoveNormalizedTypeMutableReference.fromJson(
      Map<String, dynamic> json) {
    return SuiApiMoveNormalizedTypeMutableReference(
        SuiApiMoveNormalizedType.fromJson(json.as("MutableReference")));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "MutableReference": mutableReference.toJson(),
    };
  }

  @override
  MoveType? toSuiCallArgPrue({Object? value}) {
    return mutableReference.toSuiCallArgPrue(value: value);
  }
}

class SuiApiMoveAbilitySet {
  final List<String> abilities;
  const SuiApiMoveAbilitySet(this.abilities);
  factory SuiApiMoveAbilitySet.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveAbilitySet(json.asListOfString("abilities")!);
  }

  Map<String, dynamic> toJson() {
    return {
      "abilities": abilities,
    };
  }
}

class SuiApiMoveNormalizedFunction {
  final bool isEntry;
  final List<SuiApiMoveNormalizedType> parameters;
  final List<SuiApiMoveNormalizedType> returnParameters;
  final List<SuiApiMoveAbilitySet> typeParameters;
  final String visibility;

  factory SuiApiMoveNormalizedFunction.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveNormalizedFunction(
        isEntry: json.as("isEntry"),
        parameters: (json["parameters"] as List)
            .map((e) => SuiApiMoveNormalizedType.fromJson(e))
            .toList(),
        returnParameters: (json["return"] as List)
            .map((e) => SuiApiMoveNormalizedType.fromJson(e))
            .toList(),
        typeParameters: (json["typeParameters"] as List)
            .map((e) => SuiApiMoveAbilitySet.fromJson(e))
            .toList(),
        visibility: json.as("visibility"));
  }
  const SuiApiMoveNormalizedFunction(
      {required this.isEntry,
      required this.parameters,
      required this.returnParameters,
      required this.typeParameters,
      required this.visibility});
  Map<String, dynamic> toJson() {
    return {
      "isEntry": isEntry,
      "parameters": parameters.map((e) => e.toJson()).toList(),
      "return": returnParameters.map((e) => e.toJson()).toList(),
      "typeParameters": typeParameters.map((e) => e.toJson()).toList(),
      "visibility": visibility
    };
  }
}

class SuiApiMoveStructTypeParameter {
  final SuiApiMoveAbilitySet constraints;
  final bool isPhantom;
  const SuiApiMoveStructTypeParameter(
      {required this.constraints, required this.isPhantom});
  factory SuiApiMoveStructTypeParameter.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveStructTypeParameter(
        constraints: SuiApiMoveAbilitySet.fromJson(json.asMap("constraints")),
        isPhantom: json.as("isPhantom"));
  }

  Map<String, dynamic> toJson() {
    return {"isPhantom": isPhantom, "constraints": constraints.toJson()};
  }
}

class SuiApiMoveNormalizedField {
  final String name;
  final SuiApiMoveNormalizedType type;
  const SuiApiMoveNormalizedField({required this.name, required this.type});
  factory SuiApiMoveNormalizedField.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveNormalizedField(
        type: SuiApiMoveNormalizedType.fromJson(json.as("type")),
        name: json.as("name"));
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "type": type.toJson()};
  }
}

class SuiApiMoveModuleId {
  final String address;
  final String name;
  const SuiApiMoveModuleId({required this.name, required this.address});
  factory SuiApiMoveModuleId.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveModuleId(
        address: json.as("address"), name: json.as("name"));
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "address": address};
  }
}

class SuiApiMoveNormalizedEnum {
  final SuiApiMoveAbilitySet abilities;
  final List<SuiApiMoveStructTypeParameter> typeParameters;
  final Map<String, SuiApiMoveNormalizedField> variants;
  const SuiApiMoveNormalizedEnum(
      {required this.abilities,
      required this.typeParameters,
      required this.variants});
  factory SuiApiMoveNormalizedEnum.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveNormalizedEnum(
        abilities: SuiApiMoveAbilitySet.fromJson(json.asMap("abilities")),
        typeParameters: json
            .asListOfMap("typeParameters")!
            .map((e) => SuiApiMoveStructTypeParameter.fromJson(e))
            .toList(),
        variants: json
            .asMap<Map<String, dynamic>>("variants")
            .map((k, v) => MapEntry(k, SuiApiMoveNormalizedField.fromJson(v))));
  }

  Map<String, dynamic> toJson() {
    return {
      "abilities": abilities.toJson(),
      "typeParameters": typeParameters.map((e) => e.toJson()).toList(),
      "variants":
          variants.map((k, v) => MapEntry<String, dynamic>(k, v.toJson()))
    };
  }
}

class SuiApiMoveNormalizedStruct {
  final SuiApiMoveAbilitySet abilities;
  final List<SuiApiMoveStructTypeParameter> typeParameters;
  final List<SuiApiMoveNormalizedField> fields;
  const SuiApiMoveNormalizedStruct(
      {required this.abilities,
      required this.typeParameters,
      required this.fields});
  factory SuiApiMoveNormalizedStruct.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveNormalizedStruct(
        abilities: SuiApiMoveAbilitySet.fromJson(json.asMap("abilities")),
        typeParameters: json
            .asListOfMap("typeParameters")!
            .map((e) => SuiApiMoveStructTypeParameter.fromJson(e))
            .toList(),
        fields: json
            .asListOfMap("fields")!
            .map((e) => SuiApiMoveNormalizedField.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      "abilities": abilities.toJson(),
      "typeParameters": typeParameters.map((e) => e.toJson()).toList(),
      "fields": fields.map((e) => e.toJson()).toList()
    };
  }
}

class SuiApiMoveNormalizedModule {
  final String address;
  final Map<String, SuiApiMoveNormalizedEnum>? enums;
  final Map<String, SuiApiMoveNormalizedFunction> exposedFunctions;
  final int fileFormatVersion;
  final List<SuiApiMoveModuleId> friends;
  final String name;
  final Map<String, SuiApiMoveNormalizedStruct> structs;

  const SuiApiMoveNormalizedModule(
      {required this.address,
      required this.enums,
      required this.exposedFunctions,
      required this.fileFormatVersion,
      required this.friends,
      required this.name,
      required this.structs});
  factory SuiApiMoveNormalizedModule.fromJson(Map<String, dynamic> json) {
    return SuiApiMoveNormalizedModule(
        address: json.as("address"),
        name: json.as("name"),
        fileFormatVersion: json.as("fileFormatVersion"),
        friends: json
            .asListOfMap("friends")!
            .map((e) => SuiApiMoveModuleId.fromJson(e))
            .toList(),
        exposedFunctions: json
            .asMap<Map<String, dynamic>>("exposedFunctions")
            .map((k, v) =>
                MapEntry(k, SuiApiMoveNormalizedFunction.fromJson(v))),
        structs: json
            .asMap<Map<String, dynamic>>("structs")
            .map((k, v) => MapEntry(k, SuiApiMoveNormalizedStruct.fromJson(v))),
        enums: json["enums"] == null
            ? null
            : json.asMap<Map<String, dynamic>>("enums").map(
                (k, v) => MapEntry(k, SuiApiMoveNormalizedEnum.fromJson(v))));
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "name": name,
      "fileFormatVersion": fileFormatVersion,
      "friends": friends.map((e) => e.toJson()).toList(),
      "exposedFunctions": exposedFunctions
          .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      "structs":
          structs.map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      "enums": enums?.map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
  }
}

class SuiApiExecutionResult {
  final List<List<dynamic>>? mutableReferenceOutputs;
  final List<List<dynamic>>? returnValues;
  const SuiApiExecutionResult(
      {required this.mutableReferenceOutputs, required this.returnValues});
  factory SuiApiExecutionResult.fromJson(Map<String, dynamic> json) {
    final List<List<dynamic>> mutableReferenceOutputs = [];
    final List<List<dynamic>> returnValues = [];
    if (json["mutableReferenceOutputs"] != null) {
      final reference = json["mutableReferenceOutputs"] as List;
      for (List i in reference) {
        final values = [];
        values.add(SuiApiArgument.fromJson(i[0]));
        values.add((i[1] as List).cast<int>());
        values.add(i[2]);
        mutableReferenceOutputs.add(values);
      }
    }
    if (json["returnValues"] != null) {
      final rValues = json["returnValues"] as List;
      for (List i in rValues) {
        final values = [];
        values.add((i[0] as List).cast<int>());
        values.add(i[1]);
        returnValues.add(values);
      }
    }
    return SuiApiExecutionResult(
        mutableReferenceOutputs:
            mutableReferenceOutputs.isEmpty ? null : mutableReferenceOutputs,
        returnValues: returnValues);
  }
  Map<String, dynamic> toJson() {
    return {
      "returnValues": returnValues,
      "mutableReferenceOutputs": mutableReferenceOutputs == null
          ? null
          : [
              (mutableReferenceOutputs![0] as SuiApiArgument).toJson(),
              mutableReferenceOutputs![1],
              mutableReferenceOutputs![2]
            ]
    };
  }
}

class SuiApiDevInspectArgs {
  final String? gasBudget;
  final List<List<String>>? gasObjects;
  final String? gasSponsor;
  final bool? showRawTxnDataAndEffects;
  final bool? skipChecks;
  const SuiApiDevInspectArgs(
      {this.gasBudget,
      this.gasObjects,
      this.gasSponsor,
      this.showRawTxnDataAndEffects,
      this.skipChecks});
  Map<String, dynamic> toJson() {
    return {
      "gasBudget": gasBudget,
      "gasObjects": gasObjects,
      "gasSponsor": gasSponsor,
      "showRawTxnDataAndEffects": showRawTxnDataAndEffects,
      "skipChecks": skipChecks
    }..removeWhere((k, v) => v == null);
  }
}

class SuiApiDevInspectResult {
  final SuiApiTransactionEffects effects;
  final String? error;
  final List<SuiApiEvent> events;
  final List<int>? rawEffects;
  final List<int>? rawTxnData;
  final List<SuiApiExecutionResult>? results;

  const SuiApiDevInspectResult(
      {required this.effects,
      required this.error,
      required this.events,
      required this.rawEffects,
      required this.rawTxnData,
      required this.results});
  factory SuiApiDevInspectResult.fromJson(Map<String, dynamic> json) {
    return SuiApiDevInspectResult(
        effects: SuiApiTransactionEffects.fromJson(json.asMap("effects")),
        error: json.as("error"),
        events: json
            .asListOfMap("events")!
            .map((e) => SuiApiEvent.fromJson(e))
            .toList(),
        rawEffects: (json["rawEffects"] as List?)?.cast(),
        rawTxnData: (json["rawTxnData"] as List?)?.cast(),
        results: json
            .asListOfMap("results", throwOnNull: false)
            ?.map((e) => SuiApiExecutionResult.fromJson(e))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {
      "effects": effects.toJson(),
      "error": error,
      "events": events.map((e) => e.toJson()).toList(),
      "rawEffects": rawEffects,
      "rawTxnData": rawTxnData,
      "results": results?.map((e) => e.toJson()).toList()
    };
  }
}

class SuiApiDryRunTransactionBlockResponse {
  final List<SuiApiBalanceChange> balanceChanges;
  final SuiApiTransactionEffects effects;
  final List<SuiApiEvent> events;
  final SuiApiTransactionBlockData input;
  final List<SuiApiObjectChange> objectChanges;
  const SuiApiDryRunTransactionBlockResponse(
      {required this.balanceChanges,
      required this.effects,
      required this.events,
      required this.input,
      required this.objectChanges});
  Map<String, dynamic> toJson() {
    return {
      "balanceChanges": balanceChanges.map((e) => e.toJson()).toList(),
      "effects": effects.toJson(),
      "events": events.map((e) => e.toJson()).toList(),
      "input": input.toJson(),
      "objectChanges": objectChanges.map((e) => e.toJson()).toList()
    };
  }

  factory SuiApiDryRunTransactionBlockResponse.fromJson(
      Map<String, dynamic> json) {
    return SuiApiDryRunTransactionBlockResponse(
        balanceChanges: json
            .asListOfMap("balanceChanges")!
            .map((e) => SuiApiBalanceChange.fromJson(e))
            .toList(),
        effects: SuiApiTransactionEffects.fromJson(json.asMap("effects")),
        events: json
            .asListOfMap("events")!
            .map((e) => SuiApiEvent.fromJson(e))
            .toList(),
        input: SuiApiTransactionBlockData.fromJson(json.asMap("input")),
        objectChanges: json
            .asListOfMap("objectChanges")!
            .map((e) => SuiApiObjectChange.fromJson(e))
            .toList());
  }
}

enum SuiApiExecuteTransactionRequestType {
  waitForEffectsCert("WaitForEffectsCert"),
  waitForLocalExecution("WaitForLocalExecution");

  final String name;
  const SuiApiExecuteTransactionRequestType(this.name);
}

class SuiApiValidatorSummary {
  const SuiApiValidatorSummary({
    required this.commissionRate,
    required this.description,
    required this.exchangeRatesId,
    required this.exchangeRatesSize,
    required this.gasPrice,
    required this.imageUrl,
    required this.name,
    required this.netAddress,
    required this.networkPubkeyBytes,
    required this.nextEpochCommissionRate,
    required this.nextEpochGasPrice,
    required this.nextEpochNetAddress,
    required this.nextEpochNetworkPubkeyBytes,
    required this.nextEpochP2pAddress,
    required this.nextEpochPrimaryAddress,
    required this.nextEpochProofOfPossession,
    required this.nextEpochProtocolPubkeyBytes,
    required this.nextEpochStake,
    required this.nextEpochWorkerAddress,
    required this.nextEpochWorkerPubkeyBytes,
    required this.operationCapId,
    required this.p2pAddress,
    required this.pendingPoolTokenWithdraw,
    required this.pendingStake,
    required this.pendingTotalSuiWithdraw,
    required this.poolTokenBalance,
    required this.primaryAddress,
    required this.projectUrl,
    required this.proofOfPossessionBytes,
    required this.protocolPubkeyBytes,
    required this.rewardsPool,
    required this.stakingPoolActivationEpoch,
    required this.stakingPoolDeactivationEpoch,
    required this.stakingPoolId,
    required this.stakingPoolSuiBalance,
    required this.suiAddress,
    required this.votingPower,
    required this.workerAddress,
    required this.workerPubkeyBytes,
  });

  final String commissionRate;
  final String description;
  final String exchangeRatesId;
  final String exchangeRatesSize;
  final String gasPrice;
  final String imageUrl;
  final String name;
  final String netAddress;
  final String networkPubkeyBytes;
  final String nextEpochCommissionRate;
  final String nextEpochGasPrice;
  final String? nextEpochNetAddress;
  final String? nextEpochNetworkPubkeyBytes;
  final String? nextEpochP2pAddress;
  final String? nextEpochPrimaryAddress;
  final String? nextEpochProofOfPossession;
  final String? nextEpochProtocolPubkeyBytes;
  final String nextEpochStake;
  final String? nextEpochWorkerAddress;
  final String? nextEpochWorkerPubkeyBytes;
  final String operationCapId;
  final String p2pAddress;
  final String pendingPoolTokenWithdraw;
  final String pendingStake;
  final String pendingTotalSuiWithdraw;
  final String poolTokenBalance;
  final String primaryAddress;
  final String projectUrl;
  final String proofOfPossessionBytes;
  final String protocolPubkeyBytes;
  final String rewardsPool;
  final String? stakingPoolActivationEpoch;
  final String? stakingPoolDeactivationEpoch;
  final String stakingPoolId;
  final String stakingPoolSuiBalance;
  final String suiAddress;
  final String votingPower;
  final String workerAddress;
  final String workerPubkeyBytes;

  // Factory constructor for creating an instance from JSON
  factory SuiApiValidatorSummary.fromJson(Map<String, dynamic> json) {
    return SuiApiValidatorSummary(
      commissionRate: json['commissionRate'],
      description: json['description'],
      exchangeRatesId: json['exchangeRatesId'],
      exchangeRatesSize: json['exchangeRatesSize'],
      gasPrice: json['gasPrice'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      netAddress: json['netAddress'],
      networkPubkeyBytes: json['networkPubkeyBytes'],
      nextEpochCommissionRate: json['nextEpochCommissionRate'],
      nextEpochGasPrice: json['nextEpochGasPrice'],
      nextEpochNetAddress: json['nextEpochNetAddress'],
      nextEpochNetworkPubkeyBytes: json['nextEpochNetworkPubkeyBytes'],
      nextEpochP2pAddress: json['nextEpochP2pAddress'],
      nextEpochPrimaryAddress: json['nextEpochPrimaryAddress'],
      nextEpochProofOfPossession: json['nextEpochProofOfPossession'],
      nextEpochProtocolPubkeyBytes: json['nextEpochProtocolPubkeyBytes'],
      nextEpochStake: json['nextEpochStake'],
      nextEpochWorkerAddress: json['nextEpochWorkerAddress'],
      nextEpochWorkerPubkeyBytes: json['nextEpochWorkerPubkeyBytes'],
      operationCapId: json['operationCapId'],
      p2pAddress: json['p2pAddress'],
      pendingPoolTokenWithdraw: json['pendingPoolTokenWithdraw'],
      pendingStake: json['pendingStake'],
      pendingTotalSuiWithdraw: json['pendingTotalSuiWithdraw'],
      poolTokenBalance: json['poolTokenBalance'],
      primaryAddress: json['primaryAddress'],
      projectUrl: json['projectUrl'],
      proofOfPossessionBytes: json['proofOfPossessionBytes'],
      protocolPubkeyBytes: json['protocolPubkeyBytes'],
      rewardsPool: json['rewardsPool'],
      stakingPoolActivationEpoch: json['stakingPoolActivationEpoch'],
      stakingPoolDeactivationEpoch: json['stakingPoolDeactivationEpoch'],
      stakingPoolId: json['stakingPoolId'],
      stakingPoolSuiBalance: json['stakingPoolSuiBalance'],
      suiAddress: json['suiAddress'],
      votingPower: json['votingPower'],
      workerAddress: json['workerAddress'],
      workerPubkeyBytes: json['workerPubkeyBytes'],
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'commissionRate': commissionRate,
      'description': description,
      'exchangeRatesId': exchangeRatesId,
      'exchangeRatesSize': exchangeRatesSize,
      'gasPrice': gasPrice,
      'imageUrl': imageUrl,
      'name': name,
      'netAddress': netAddress,
      'networkPubkeyBytes': networkPubkeyBytes,
      'nextEpochCommissionRate': nextEpochCommissionRate,
      'nextEpochGasPrice': nextEpochGasPrice,
      'nextEpochNetAddress': nextEpochNetAddress,
      'nextEpochNetworkPubkeyBytes': nextEpochNetworkPubkeyBytes,
      'nextEpochP2pAddress': nextEpochP2pAddress,
      'nextEpochPrimaryAddress': nextEpochPrimaryAddress,
      'nextEpochProofOfPossession': nextEpochProofOfPossession,
      'nextEpochProtocolPubkeyBytes': nextEpochProtocolPubkeyBytes,
      'nextEpochStake': nextEpochStake,
      'nextEpochWorkerAddress': nextEpochWorkerAddress,
      'nextEpochWorkerPubkeyBytes': nextEpochWorkerPubkeyBytes,
      'operationCapId': operationCapId,
      'p2pAddress': p2pAddress,
      'pendingPoolTokenWithdraw': pendingPoolTokenWithdraw,
      'pendingStake': pendingStake,
      'pendingTotalSuiWithdraw': pendingTotalSuiWithdraw,
      'poolTokenBalance': poolTokenBalance,
      'primaryAddress': primaryAddress,
      'projectUrl': projectUrl,
      'proofOfPossessionBytes': proofOfPossessionBytes,
      'protocolPubkeyBytes': protocolPubkeyBytes,
      'rewardsPool': rewardsPool,
      'stakingPoolActivationEpoch': stakingPoolActivationEpoch,
      'stakingPoolDeactivationEpoch': stakingPoolDeactivationEpoch,
      'stakingPoolId': stakingPoolId,
      'stakingPoolSuiBalance': stakingPoolSuiBalance,
      'suiAddress': suiAddress,
      'votingPower': votingPower,
      'workerAddress': workerAddress,
      'workerPubkeyBytes': workerPubkeyBytes,
    };
  }
}

class SuiApiSystemStateSummary {
  const SuiApiSystemStateSummary({
    required this.activeValidators,
    required this.atRiskValidators,
    required this.epoch,
    required this.epochDurationMs,
    required this.epochStartTimestampMs,
    required this.inactivePoolsId,
    required this.inactivePoolsSize,
    required this.maxValidatorCount,
    required this.minValidatorJoiningStake,
    required this.pendingActiveValidatorsId,
    required this.pendingActiveValidatorsSize,
    required this.pendingRemovals,
    required this.protocolVersion,
    required this.referenceGasPrice,
    required this.safeMode,
    required this.safeModeComputationRewards,
    required this.safeModeNonRefundableStorageFee,
    required this.safeModeStorageRebates,
    required this.safeModeStorageRewards,
    required this.stakeSubsidyBalance,
    required this.stakeSubsidyCurrentDistributionAmount,
    required this.stakeSubsidyDecreaseRate,
    required this.stakeSubsidyDistributionCounter,
    required this.stakeSubsidyPeriodLength,
    required this.stakeSubsidyStartEpoch,
    required this.stakingPoolMappingsId,
    required this.stakingPoolMappingsSize,
    required this.storageFundNonRefundableBalance,
    required this.storageFundTotalObjectStorageRebates,
    required this.systemStateVersion,
    required this.totalStake,
    required this.validatorCandidatesId,
    required this.validatorCandidatesSize,
    required this.validatorLowStakeGracePeriod,
    required this.validatorLowStakeThreshold,
    required this.validatorReportRecords,
    required this.validatorVeryLowStakeThreshold,
  });

  final List<SuiApiValidatorSummary> activeValidators;
  final List<String> atRiskValidators;
  final String epoch;
  final String epochDurationMs;
  final String epochStartTimestampMs;
  final String inactivePoolsId;
  final String inactivePoolsSize;
  final String maxValidatorCount;
  final String minValidatorJoiningStake;
  final String pendingActiveValidatorsId;
  final String pendingActiveValidatorsSize;
  final List<String> pendingRemovals;
  final String protocolVersion;
  final String referenceGasPrice;
  final bool safeMode;
  final String safeModeComputationRewards;
  final String safeModeNonRefundableStorageFee;
  final String safeModeStorageRebates;
  final String safeModeStorageRewards;
  final String stakeSubsidyBalance;
  final String stakeSubsidyCurrentDistributionAmount;
  final int stakeSubsidyDecreaseRate;
  final String stakeSubsidyDistributionCounter;
  final String stakeSubsidyPeriodLength;
  final String stakeSubsidyStartEpoch;
  final String stakingPoolMappingsId;
  final String stakingPoolMappingsSize;
  final String storageFundNonRefundableBalance;
  final String storageFundTotalObjectStorageRebates;
  final String systemStateVersion;
  final String totalStake;
  final String validatorCandidatesId;
  final String validatorCandidatesSize;
  final String validatorLowStakeGracePeriod;
  final String validatorLowStakeThreshold;
  final List<dynamic> validatorReportRecords;
  final String validatorVeryLowStakeThreshold;

  // Factory constructor for creating an instance from JSON
  factory SuiApiSystemStateSummary.fromJson(Map<String, dynamic> json) {
    return SuiApiSystemStateSummary(
      activeValidators: json
          .asListOfMap("activeValidators")!
          .map((e) => SuiApiValidatorSummary.fromJson(e))
          .toList(),
      atRiskValidators: json.asListOfString("atRiskValidators")!,
      epoch: json['epoch'],
      epochDurationMs: json['epochDurationMs'],
      epochStartTimestampMs: json['epochStartTimestampMs'],
      inactivePoolsId: json['inactivePoolsId'],
      inactivePoolsSize: json['inactivePoolsSize'],
      maxValidatorCount: json['maxValidatorCount'],
      minValidatorJoiningStake: json['minValidatorJoiningStake'],
      pendingActiveValidatorsId: json['pendingActiveValidatorsId'],
      pendingActiveValidatorsSize: json['pendingActiveValidatorsSize'],
      pendingRemovals: json.asListOfString("pendingRemovals")!,
      protocolVersion: json['protocolVersion'],
      referenceGasPrice: json['referenceGasPrice'],
      safeMode: json['safeMode'],
      safeModeComputationRewards: json['safeModeComputationRewards'],
      safeModeNonRefundableStorageFee: json['safeModeNonRefundableStorageFee'],
      safeModeStorageRebates: json['safeModeStorageRebates'],
      safeModeStorageRewards: json['safeModeStorageRewards'],
      stakeSubsidyBalance: json['stakeSubsidyBalance'],
      stakeSubsidyCurrentDistributionAmount:
          json['stakeSubsidyCurrentDistributionAmount'],
      stakeSubsidyDecreaseRate: json['stakeSubsidyDecreaseRate'],
      stakeSubsidyDistributionCounter: json['stakeSubsidyDistributionCounter'],
      stakeSubsidyPeriodLength: json['stakeSubsidyPeriodLength'],
      stakeSubsidyStartEpoch: json['stakeSubsidyStartEpoch'],
      stakingPoolMappingsId: json['stakingPoolMappingsId'],
      stakingPoolMappingsSize: json['stakingPoolMappingsSize'],
      storageFundNonRefundableBalance: json['storageFundNonRefundableBalance'],
      storageFundTotalObjectStorageRebates:
          json['storageFundTotalObjectStorageRebates'],
      systemStateVersion: json['systemStateVersion'],
      totalStake: json['totalStake'],
      validatorCandidatesId: json['validatorCandidatesId'],
      validatorCandidatesSize: json['validatorCandidatesSize'],
      validatorLowStakeGracePeriod: json['validatorLowStakeGracePeriod'],
      validatorLowStakeThreshold: json['validatorLowStakeThreshold'],
      validatorReportRecords:
          List<dynamic>.from(json['validatorReportRecords']),
      validatorVeryLowStakeThreshold: json['validatorVeryLowStakeThreshold'],
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'activeValidators': activeValidators.map((e) => e.toJson()).toList(),
      'atRiskValidators': atRiskValidators,
      'epoch': epoch,
      'epochDurationMs': epochDurationMs,
      'epochStartTimestampMs': epochStartTimestampMs,
      'inactivePoolsId': inactivePoolsId,
      'inactivePoolsSize': inactivePoolsSize,
      'maxValidatorCount': maxValidatorCount,
      'minValidatorJoiningStake': minValidatorJoiningStake,
      'pendingActiveValidatorsId': pendingActiveValidatorsId,
      'pendingActiveValidatorsSize': pendingActiveValidatorsSize,
      'pendingRemovals': pendingRemovals,
      'protocolVersion': protocolVersion,
      'referenceGasPrice': referenceGasPrice,
      'safeMode': safeMode,
      'safeModeComputationRewards': safeModeComputationRewards,
      'safeModeNonRefundableStorageFee': safeModeNonRefundableStorageFee,
      'safeModeStorageRebates': safeModeStorageRebates,
      'safeModeStorageRewards': safeModeStorageRewards,
      'stakeSubsidyBalance': stakeSubsidyBalance,
      'stakeSubsidyCurrentDistributionAmount':
          stakeSubsidyCurrentDistributionAmount,
      'stakeSubsidyDecreaseRate': stakeSubsidyDecreaseRate,
      'stakeSubsidyDistributionCounter': stakeSubsidyDistributionCounter,
      'stakeSubsidyPeriodLength': stakeSubsidyPeriodLength,
      'stakeSubsidyStartEpoch': stakeSubsidyStartEpoch,
      'stakingPoolMappingsId': stakingPoolMappingsId,
      'stakingPoolMappingsSize': stakingPoolMappingsSize,
      'storageFundNonRefundableBalance': storageFundNonRefundableBalance,
      'storageFundTotalObjectStorageRebates':
          storageFundTotalObjectStorageRebates,
      'systemStateVersion': systemStateVersion,
      'totalStake': totalStake,
      'validatorCandidatesId': validatorCandidatesId,
      'validatorCandidatesSize': validatorCandidatesSize,
      'validatorLowStakeGracePeriod': validatorLowStakeGracePeriod,
      'validatorLowStakeThreshold': validatorLowStakeThreshold,
      'validatorReportRecords': validatorReportRecords,
      'validatorVeryLowStakeThreshold': validatorVeryLowStakeThreshold,
    };
  }
}

import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/account/key.dart';
import 'package:on_chain/tron/src/models/contract/account/permission_type.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class Permission extends TronProtocolBufferImpl {
  /// Create a new [Permission] instance by parsing a JSON map.
  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
        type: PermissionType.fromName(json["type"]),
        id: json["id"],
        permissionName: json["permission_name"],
        operations: BytesUtils.tryFromHexString(json["operations"]),
        keys: (json["keys"] as List?)?.map((e) => TronKey.fromJson(e)).toList(),
        parentId: json["parent_id"],
        threshold: BigintUtils.tryParse(json["threshold"]));
  }

  /// Factory method to create a new [Permission] instance with specified parameters.
  Permission({
    this.type,
    this.id,
    this.permissionName,
    this.threshold,
    this.parentId,
    List<int>? operations,
    List<TronKey>? keys,
  })  : operations = BytesUtils.tryToBytes(operations, unmodifiable: true),
        keys = keys == null ? null : List<TronKey>.unmodifiable(keys);
  final PermissionType? type;
  final int? id;
  final String? permissionName;
  final BigInt? threshold;
  final int? parentId;
  final List<int>? operations;
  final List<TronKey>? keys;

  Permission copyWith({
    PermissionType? type,
    int? id,
    String? permissionName,
    BigInt? threshold,
    int? parentId,
    List<int>? operations,
    List<TronKey>? keys,
  }) {
    return Permission(
      type: type ?? this.type,
      id: id ?? this.id,
      permissionName: permissionName ?? this.permissionName,
      threshold: threshold ?? this.threshold,
      parentId: parentId ?? this.parentId,
      operations: operations ?? this.operations,
      keys: keys ?? this.keys,
    );
  }

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5, 6, 7];

  @override
  List get values =>
      [type, id, permissionName, threshold, parentId, operations, keys];

  /// Convert the [Permission] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "threshold": threshold,
      "permission_name": permissionName,
      "type": type?.name,
      "keys": keys?.map((e) => e.toJson()).toList(),
      "id": id,
      "parent_id": parentId,
      "operations": BytesUtils.tryToHexString(operations),
    };
  }

  /// Convert the [Permission] object to its string representation.
  @override
  String toString() {
    return "Permission{${toJson()}}";
  }
}

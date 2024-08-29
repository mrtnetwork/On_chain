import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/account/key.dart';
import 'package:on_chain/tron/src/models/contract/account/permission_type.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils/utils.dart';

class Permission extends TronProtocolBufferImpl {
  /// Create a new [Permission] instance by parsing a JSON map.
  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
        type: PermissionType.fromName(
            OnChainUtils.parseString(value: json["type"], name: "type"),
            defaultPermission: PermissionType.owner),
        id: OnChainUtils.parseInt(value: json["id"], name: "id"),
        permissionName: OnChainUtils.parseString(
            value: json["permission_name"], name: "permission_name"),
        operations: OnChainUtils.parseHex(
            value: json["operations"], name: "operations"),
        keys: OnChainUtils.parseList(value: json["keys"], name: "keys")
            ?.map((e) => TronKey.fromJson(e))
            .toList(),
        parentId:
            OnChainUtils.parseInt(value: json["parent_id"], name: "parent_id"),
        threshold: OnChainUtils.parseBigInt(
            value: json["threshold"], name: "threshold"));
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
  factory Permission.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return Permission(
        type: PermissionType.fromValue(decode.getField(1),
            defaultPermission: PermissionType.owner),
        id: decode.getField(2),
        permissionName: decode.getField(3),
        operations: decode.getField(6),
        keys: decode
            .getFields<List<int>>(7)
            .map((e) => TronKey.deserialize(e))
            .toList(),
        parentId: decode.getField(5),
        threshold: decode.getField(4));
  }
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
  List get values => [
        type == PermissionType.owner ? null : type,
        id,
        permissionName,
        threshold,
        parentId,
        operations,
        keys,
      ];

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
    }..removeWhere((k, v) => v == null);
  }

  /// Convert the [Permission] object to its string representation.
  @override
  String toString() {
    return "Permission{${toJson()}}";
  }
}

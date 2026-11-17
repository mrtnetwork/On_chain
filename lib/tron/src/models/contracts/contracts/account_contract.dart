import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/models.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/proto_messages/protocol/src/tron.dart"
    as protocol_tron;

class TronAccountCreateContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final TronAddress accountAddress;

  final protocol_tron.TronAccountType? type;

  const TronAccountCreateContract({
    required this.ownerAddress,
    required this.accountAddress,
    this.type,
  }) : super(TronTransactionContractContractType.accountCreateContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.enumType(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    accountAddress.toBytes(),
    type,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'account_address': accountAddress.toAddress(config.visible),
      'type': type?.protoName,
    }.notNullValue;
  }

  factory TronAccountCreateContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountCreateContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      accountAddress: TronAddress(
        json.valueAsString(
          "account_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      type: json.valueTo<protocol_tron.TronAccountType?, Object?>(
        key: 'type',
        parse: (v) => protocol_tron.TronAccountType.from(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronAccountCreateContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountCreateContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      accountAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(2)),
      type: decode.getEnum<protocol_tron.TronAccountType?>(
        3,
        protocol_tron.TronAccountType.values,
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountCreateContract;
}

/// Update account name. Account name is not unique now.
class TronAccountUpdateContract extends ITronContract {
  final BuBytes? accountName;

  @override
  final TronAddress ownerAddress;

  TronAccountUpdateContract({
    List<int>? accountName,
    required this.ownerAddress,
  }) : accountName = accountName?.asImmutableBytes,
       super(TronTransactionContractContractType.accountUpdateContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [accountName, ownerAddress.toBytes()];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'account_name': config.encodeBinary(accountName),
      'owner_address': ownerAddress.toAddress(config.visible),
    }.notNullValue;
  }

  factory TronAccountUpdateContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountUpdateContract(
      accountName: config.decodeBinary(
        json.valueAs("account_name", normalizeKeyLookup: config.normalizeKeys),
      ),
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronAccountUpdateContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountUpdateContract(
      accountName: decode.getBytes<List<int>?>(1),
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(2)),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountUpdateContract;
}

/// Set account id if the account has no id. Account id is unique and case insensitive.
class TronSetAccountIdContract extends ITronContract {
  final BuBytes? accountId;

  @override
  final TronAddress ownerAddress;

  TronSetAccountIdContract({List<int>? accountId, required this.ownerAddress})
    : accountId = accountId?.asImmutableBytes,
      super(TronTransactionContractContractType.setAccountIdContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [accountId, ownerAddress.toBytes()];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'account_id': config.encodeBinary(accountId),
      'owner_address': ownerAddress.toAddress(config.visible),
    }.notNullValue;
  }

  factory TronSetAccountIdContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSetAccountIdContract(
      accountId: config.decodeBinary(
        json.valueAs("account_id", normalizeKeyLookup: config.normalizeKeys),
      ),
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronSetAccountIdContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSetAccountIdContract(
      accountId: decode.getBytes<List<int>?>(1),
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(2)),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSetAccountIdContract;
}

class TronAccountPermissionUpdateContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final TronPermission? owner;

  /// Empty means invalid.
  final TronPermission? witness;

  /// May be empty.
  final List<TronPermission> actives;

  const TronAccountPermissionUpdateContract({
    required this.ownerAddress,
    this.owner,
    this.witness,
    this.actives = const [],
  }) : super(
         TronTransactionContractContractType.accountPermissionUpdateContract,
       );

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    owner,
    witness,
    actives,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'owner': config.encodeMessage(owner),
      'witness': config.encodeMessage(witness),
      'actives': actives.map(config.encodeMessage).toList(),
    }.notNullValue;
  }

  factory TronAccountPermissionUpdateContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountPermissionUpdateContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      owner: json.valueTo<TronPermission?, Map<String, dynamic>>(
        key: 'owner',
        parse: (v) => TronPermission.fromJson(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      witness: json.valueTo<TronPermission?, Map<String, dynamic>>(
        key: 'witness',
        parse: (v) => TronPermission.fromJson(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      actives:
          (json.valueEnsureAsList<dynamic>(
                'actives',
                normalizeKeyLookup: config.normalizeKeys,
              ))
              .map(
                (e) => JsonParser.valueTo<TronPermission, Map<String, dynamic>>(
                  value: e,
                  parse: (v) => TronPermission.fromJson(v),
                ),
              )
              .toList(),
    );
  }

  factory TronAccountPermissionUpdateContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountPermissionUpdateContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      owner: decode.messageTo<TronPermission?>(
        2,
        (b) => TronPermission.deserialize(b),
      ),
      witness: decode.messageTo<TronPermission?>(
        3,
        (b) => TronPermission.deserialize(b),
      ),
      actives:
          decode
              .getListOfBytes(4)
              .map((b) => TronPermission.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountPermissionUpdateContract;
}

class TronKey extends TronProtoMessage {
  final TronAddress? address;

  final BigInt? weight;

  const TronKey({this.address, this.weight});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [address?.toBytes(), weight];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'address': address?.toAddress(config.visible),
      'weight': config.encodeBigint(weight),
    }.notNullValue;
  }

  factory TronKey.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronKey(
      address: json.valueTo<TronAddress?, String>(
        key: "address",
        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
      weight: json.valueAsBigInt<BigInt?>(
        'weight',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronKey.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronKey(
      address: decode.bytesTo<TronAddress?>(1, TronAddress.fromBytes),
      weight: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolKey;
}

class TronPermission extends TronProtoMessage {
  final TronPermissionPermissionType? type;

  final int? id;

  /// Owner id is 0, witness id is 1, active ids start from 2.
  final String? permissionName;

  final BigInt? threshold;

  final int? parentId;

  final BuBytes? operations;

  /// Permission bitmask: one bit per contract type.
  final List<TronKey> keys;

  TronPermission({
    this.type,
    this.id,
    this.permissionName,
    this.threshold,
    this.parentId,
    List<int>? operations,
    this.keys = const [],
  }) : operations = operations?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int32(5),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.repeated(
          fieldNumber: 7,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    type,
    id,
    permissionName,
    threshold,
    parentId,
    operations,
    keys,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'type': config.encodeEnum(type),
      'id': id,
      'permission_name': permissionName,
      'threshold': config.encodeBigint(threshold),
      'parent_id': parentId,
      'operations': config.encodeBinary(operations),
      'keys': keys.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronPermission.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPermission(
      type: json.valueTo<TronPermissionPermissionType?, Object?>(
        key: 'type',
        parse: (v) => TronPermissionPermissionType.from(v),
      ),
      id: json.valueAsInt<int?>('id', normalizeKeyLookup: config.normalizeKeys),
      permissionName: json.valueAsString<String?>(
        'permission_name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      threshold: json.valueAsBigInt<BigInt?>(
        'threshold',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      parentId: json.valueAsInt<int?>(
        'parent_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      operations: config.decodeBinary<List<int>?>(
        json.valueAs('operations', normalizeKeyLookup: config.normalizeKeys),
      ),
      keys:
          (json.valueEnsureAsList<dynamic>(
                'keys',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronKey, Object>(
                  value: e,
                  parse:
                      (v) => TronKey.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronPermission.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPermission(
      type: decode.getEnum<TronPermissionPermissionType?>(
        1,
        TronPermissionPermissionType.values,
      ),
      id: decode.getInt<int?>(2),
      permissionName: decode.getString<String?>(3),
      threshold: decode.getBigInt<BigInt?>(4),
      parentId: decode.getInt<int?>(5),
      operations: decode.getBytes<List<int>?>(6),
      keys:
          decode.getListOfBytes(7).map((b) => TronKey.deserialize(b)).toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPermission;
}

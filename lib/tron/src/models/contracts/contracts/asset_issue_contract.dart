import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/models.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

class TronAssetIssueContract extends ITronContract {
  final String? id;

  @override
  final TronAddress ownerAddress;

  final BuBytes? name;

  final BuBytes? abbr;

  final BigInt? totalSupply;

  final List<TronAssetIssueContractFrozenSupply> frozenSupply;

  final int? trxNum;

  /// The fields trx_num and num define the exchange rate: num tokens can be purchased with trx_num TRX. This avoids using decimals.
  final int? precision;

  final int? num;

  final BigInt? startTime;

  final BigInt? endTime;

  final BigInt? order;

  /// useless
  final int? voteScore;

  final BuBytes? description;

  final BuBytes? url;

  final BigInt? freeAssetNetLimit;

  final BigInt? publicFreeAssetNetLimit;

  final BigInt? publicFreeAssetNetUsage;

  final BigInt? publicLatestFreeNetTime;

  TronAssetIssueContract({
    this.id,
    required this.ownerAddress,
    List<int>? name,
    List<int>? abbr,
    this.totalSupply,
    this.frozenSupply = const [],
    this.trxNum,
    this.precision,
    this.num,
    this.startTime,
    this.endTime,
    this.order,
    this.voteScore,
    List<int>? description,
    List<int>? url,
    this.freeAssetNetLimit,
    this.publicFreeAssetNetLimit,
    this.publicFreeAssetNetUsage,
    this.publicLatestFreeNetTime,
  }) : name = name?.asImmutableBytes,
       abbr = abbr?.asImmutableBytes,
       description = description?.asImmutableBytes,
       url = url?.asImmutableBytes,
       super(TronTransactionContractContractType.assetIssueContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(41),
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int32(6),
        ProtoFieldConfig.int32(7),
        ProtoFieldConfig.int32(8),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.int32(16),
        ProtoFieldConfig.bytes(20),
        ProtoFieldConfig.bytes(21),
        ProtoFieldConfig.int64(22),
        ProtoFieldConfig.int64(23),
        ProtoFieldConfig.int64(24),
        ProtoFieldConfig.int64(25),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    id,
    ownerAddress.toBytes(),
    name,
    abbr,
    totalSupply,
    frozenSupply,
    trxNum,
    precision,
    num,
    startTime,
    endTime,
    order,
    voteScore,
    description,
    url,
    freeAssetNetLimit,
    publicFreeAssetNetLimit,
    publicFreeAssetNetUsage,
    publicLatestFreeNetTime,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'id': id,
      'owner_address': ownerAddress.toAddress(config.visible),
      'name': config.encodeBinary(name),
      'abbr': config.encodeBinary(abbr),
      'total_supply': config.encodeBigint(totalSupply),
      'frozen_supply': frozenSupply.map(config.encodeMessage).toList(),
      'trx_num': trxNum,
      'precision': precision,
      'num': num,
      'start_time': config.encodeBigint(startTime),
      'end_time': config.encodeBigint(endTime),
      'order': config.encodeBigint(order),
      'vote_score': voteScore,
      'description': config.encodeBinary(description),
      'url': config.encodeBinary(url),
      'free_asset_net_limit': config.encodeBigint(freeAssetNetLimit),
      'public_free_asset_net_limit': config.encodeBigint(
        publicFreeAssetNetLimit,
      ),
      'public_free_asset_net_usage': config.encodeBigint(
        publicFreeAssetNetUsage,
      ),
      'public_latest_free_net_time': config.encodeBigint(
        publicLatestFreeNetTime,
      ),
    }.notNullValue;
  }

  factory TronAssetIssueContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAssetIssueContract(
      id: json.valueAsString<String?>(
        'id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      abbr: config.decodeBinary<List<int>?>(
        json.valueAs("abbr", normalizeKeyLookup: config.normalizeKeys),
      ),
      name: config.decodeBinary<List<int>?>(
        json.valueAs("name", normalizeKeyLookup: config.normalizeKeys),
      ),
      totalSupply: json.valueAsBigInt<BigInt?>(
        'total_supply',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      frozenSupply:
          (json.valueEnsureAsList<dynamic>(
                'frozen_supply',
                normalizeKeyLookup: config.normalizeKeys,
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronAssetIssueContractFrozenSupply,
                  Map<String, dynamic>
                >(
                  value: e,
                  parse: (v) => TronAssetIssueContractFrozenSupply.fromJson(v),
                ),
              )
              .toList(),
      trxNum: json.valueAsInt<int?>(
        'trx_num',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      precision: json.valueAsInt<int?>(
        'precision',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      num: json.valueAsInt<int?>(
        'num',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      startTime: json.valueAsBigInt<BigInt?>('start_time'),
      endTime: json.valueAsBigInt<BigInt?>(
        'end_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      order: json.valueAsBigInt<BigInt?>(
        'order',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      voteScore: json.valueAsInt<int?>(
        'vote_score',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      description: config.decodeBinary<List<int>?>(
        json.valueAs("description", normalizeKeyLookup: config.normalizeKeys),
      ),
      url: config.decodeBinary<List<int>?>(
        json.valueAs("url", normalizeKeyLookup: config.normalizeKeys),
      ),
      freeAssetNetLimit: json.valueAsBigInt<BigInt?>(
        'free_asset_net_limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      publicFreeAssetNetLimit: json.valueAsBigInt<BigInt?>(
        'public_free_asset_net_limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      publicFreeAssetNetUsage: json.valueAsBigInt<BigInt?>(
        'public_free_asset_net_usage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      publicLatestFreeNetTime: json.valueAsBigInt<BigInt?>(
        'public_latest_free_net_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronAssetIssueContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAssetIssueContract(
      id: decode.getString<String?>(41),
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      name: decode.getBytes<List<int>?>(2),
      abbr: decode.getBytes<List<int>?>(3),
      totalSupply: decode.getBigInt<BigInt?>(4),
      frozenSupply:
          decode
              .getListOfBytes(5)
              .map((b) => TronAssetIssueContractFrozenSupply.deserialize(b))
              .toList(),
      trxNum: decode.getInt<int?>(6),
      precision: decode.getInt<int?>(7),
      num: decode.getInt<int?>(8),
      startTime: decode.getBigInt<BigInt?>(9),
      endTime: decode.getBigInt<BigInt?>(10),
      order: decode.getBigInt<BigInt?>(11),
      voteScore: decode.getInt<int?>(16),
      description: decode.getBytes<List<int>?>(20),
      url: decode.getBytes<List<int>?>(21),
      freeAssetNetLimit: decode.getBigInt<BigInt?>(22),
      publicFreeAssetNetLimit: decode.getBigInt<BigInt?>(23),
      publicFreeAssetNetUsage: decode.getBigInt<BigInt?>(24),
      publicLatestFreeNetTime: decode.getBigInt<BigInt?>(25),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAssetIssueContract;
}

class TronTransferAssetContract extends ITronContract {
  final BuBytes? assetName;

  /// this field is token name before the proposal ALLOW_SAME_TOKEN_NAME is active, otherwise it is token id and token is should be in string format.
  @override
  final TronAddress ownerAddress;

  final TronAddress? toAddress;

  final BigInt? amount;

  TronTransferAssetContract({
    List<int>? assetName,
    required this.ownerAddress,
    this.toAddress,
    this.amount,
  }) : assetName = assetName?.asImmutableBytes,
       super(TronTransactionContractContractType.transferAssetContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    assetName,
    ownerAddress.toBytes(),
    toAddress?.toBytes(),
    amount,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'asset_name': config.encodeBinary(assetName),
      'owner_address': ownerAddress.toAddress(config.visible),
      'to_address': toAddress?.toAddress(config.visible),
      'amount': config.encodeBigint(amount),
    }.notNullValue;
  }

  factory TronTransferAssetContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransferAssetContract(
      assetName: config.decodeBinary<List<int>?>(
        json.valueAs("asset_name", normalizeKeyLookup: config.normalizeKeys),
      ),
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      toAddress: json.valueTo<TronAddress?, String>(
        key: 'to_address',

        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransferAssetContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransferAssetContract(
      assetName: decode.getBytes<List<int>?>(1),
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(2)),
      toAddress: decode.bytesTo<TronAddress?>(3, TronAddress.fromBytes),
      amount: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransferAssetContract;
}

class TronUnfreezeAssetContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  const TronUnfreezeAssetContract({required this.ownerAddress})
    : super(TronTransactionContractContractType.unfreezeAssetContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1)],
    );
  }

  @override
  List<Object?> get protoValues => [ownerAddress.toBytes()];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
    }.notNullValue;
  }

  factory TronUnfreezeAssetContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronUnfreezeAssetContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronUnfreezeAssetContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronUnfreezeAssetContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolUnfreezeAssetContract;
}

class TronUpdateAssetContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BuBytes? description;

  final BuBytes? url;

  final BigInt? newLimit;

  final BigInt? newPublicLimit;

  TronUpdateAssetContract({
    required this.ownerAddress,
    List<int>? description,
    List<int>? url,
    this.newLimit,
    this.newPublicLimit,
  }) : description = description?.asImmutableBytes,
       url = url?.asImmutableBytes,
       super(TronTransactionContractContractType.updateAssetContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    description,
    url,
    newLimit,
    newPublicLimit,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'description': config.encodeBinary(description),
      'url': config.encodeBinary(url),
      'new_limit': config.encodeBigint(newLimit),
      'new_public_limit': config.encodeBigint(newPublicLimit),
    }.notNullValue;
  }

  factory TronUpdateAssetContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronUpdateAssetContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      description: config.decodeBinary<List<int>?>(
        json.valueAs("description", normalizeKeyLookup: config.normalizeKeys),
      ),

      url: config.decodeBinary<List<int>?>(
        json.valueAs("url", normalizeKeyLookup: config.normalizeKeys),
      ),
      newLimit: json.valueAsBigInt<BigInt?>(
        'new_limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      newPublicLimit: json.valueAsBigInt<BigInt?>(
        'new_public_limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronUpdateAssetContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronUpdateAssetContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      description: decode.getBytes<List<int>?>(2),
      url: decode.getBytes<List<int>?>(3),
      newLimit: decode.getBigInt<BigInt?>(4),
      newPublicLimit: decode.getBigInt<BigInt?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolUpdateAssetContract;
}

class TronParticipateAssetIssueContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final TronAddress? toAddress;

  final BuBytes? assetName;

  /// this field is token name before the proposal ALLOW_SAME_TOKEN_NAME is active, otherwise it is token id and token is should be in string format.
  final BigInt? amount;

  TronParticipateAssetIssueContract({
    required this.ownerAddress,
    this.toAddress,
    List<int>? assetName,
    this.amount,
  }) : assetName = assetName?.asImmutableBytes,
       super(TronTransactionContractContractType.participateAssetIssueContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    toAddress?.toBytes(),
    assetName,
    amount,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'to_address': toAddress?.toAddress(config.visible),
      'asset_name': config.encodeBinary(assetName),
      'amount': config.encodeBigint(amount),
    }.notNullValue;
  }

  factory TronParticipateAssetIssueContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronParticipateAssetIssueContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      toAddress: json.valueTo<TronAddress?, String>(
        key: "to_address",
        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
      assetName: config.decodeBinary<List<int>?>(
        json.valueAs("asset_name", normalizeKeyLookup: config.normalizeKeys),
      ),
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronParticipateAssetIssueContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronParticipateAssetIssueContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      toAddress: decode.bytesTo<TronAddress?>(2, TronAddress.fromBytes),
      assetName: decode.getBytes<List<int>?>(3),
      amount: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolParticipateAssetIssueContract;
}

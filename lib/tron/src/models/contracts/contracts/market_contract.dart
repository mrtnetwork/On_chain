import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart'
    show TronTransactionContractContractType;
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';

class TronMarketSellAssetContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BuBytes? sellTokenId;

  final BigInt? sellTokenQuantity;

  final BuBytes? buyTokenId;

  final BigInt? buyTokenQuantity;

  TronMarketSellAssetContract({
    required this.ownerAddress,
    List<int>? sellTokenId,
    this.sellTokenQuantity,
    List<int>? buyTokenId,
    this.buyTokenQuantity,
  }) : sellTokenId = sellTokenId?.asImmutableBytes,
       buyTokenId = buyTokenId?.asImmutableBytes,
       super(TronTransactionContractContractType.marketSellAssetContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.int64(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    sellTokenId,
    sellTokenQuantity,
    buyTokenId,
    buyTokenQuantity,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'sell_token_id': config.encodeBinary(sellTokenId),
      'sell_token_quantity': config.encodeBigint(sellTokenQuantity),
      'buy_token_id': config.encodeBinary(buyTokenId),
      'buy_token_quantity': config.encodeBigint(buyTokenQuantity),
    }.notNullValue;
  }

  factory TronMarketSellAssetContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketSellAssetContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      sellTokenId: config.decodeBinary<List<int>?>(
        json.valueAs("sell_token_id", normalizeKeyLookup: config.normalizeKeys),
      ),
      sellTokenQuantity: json.valueAsBigInt<BigInt?>(
        'sell_token_quantity',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      buyTokenId: config.decodeBinary<List<int>?>(
        json.valueAs('buy_token_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      buyTokenQuantity: json.valueAsBigInt<BigInt?>(
        'buy_token_quantity',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMarketSellAssetContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketSellAssetContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      sellTokenId: decode.getBytes<List<int>?>(2),
      sellTokenQuantity: decode.getBigInt<BigInt?>(3),
      buyTokenId: decode.getBytes<List<int>?>(4),
      buyTokenQuantity: decode.getBigInt<BigInt?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketSellAssetContract;
}

/// min to receive
class TronMarketCancelOrderContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BuBytes? orderId;

  TronMarketCancelOrderContract({
    required this.ownerAddress,
    List<int>? orderId,
  }) : orderId = orderId?.asImmutableBytes,
       super(TronTransactionContractContractType.marketCancelOrderContract);

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
  List<Object?> get protoValues => [ownerAddress.toBytes(), orderId];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'order_id': config.encodeBinary(orderId),
    }.notNullValue;
  }

  factory TronMarketCancelOrderContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketCancelOrderContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      orderId: config.decodeBinary<List<int>?>(
        json.valueAs('order_id', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronMarketCancelOrderContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketCancelOrderContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      orderId: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketCancelOrderContract;
}

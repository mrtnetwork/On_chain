import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

class MarketSellAssetContract extends TronBaseContract {
  /// Create a new [MarketSellAssetContract] instance by parsing a JSON map.
  factory MarketSellAssetContract.fromJson(Map<String, dynamic> json) {
    return MarketSellAssetContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      sellTokenId: OnChainUtils.parseBytes(
          value: json['sell_token_id'], name: 'sell_token_id'),
      sellTokenQuantity: OnChainUtils.parseBigInt(
          value: json['sell_token_quantity'], name: 'sell_token_quantity'),
      buyTokenId: OnChainUtils.parseBytes(
          value: json['buy_token_id'], name: 'buy_token_id'),
      buyTokenQuantity: OnChainUtils.parseBigInt(
          value: json['buy_token_quantity'], name: 'buy_token_quantity'),
    );
  }

  /// Create a new [MarketSellAssetContract] instance with specified parameters.
  MarketSellAssetContract(
      {required this.ownerAddress,
      List<int>? sellTokenId,
      this.sellTokenQuantity,
      List<int>? buyTokenId,
      this.buyTokenQuantity})
      : sellTokenId = BytesUtils.tryToBytes(sellTokenId, unmodifiable: true),
        buyTokenId = BytesUtils.tryToBytes(buyTokenId, unmodifiable: true);
  factory MarketSellAssetContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return MarketSellAssetContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        sellTokenId: decode.getField(2),
        sellTokenQuantity: decode.getField(3),
        buyTokenId: decode.getField(4),
        buyTokenQuantity: decode.getField(5));
  }

  /// Account address
  @override
  final TronAddress ownerAddress;
  final List<int>? sellTokenId;
  final BigInt? sellTokenQuantity;
  final List<int>? buyTokenId;
  final BigInt? buyTokenQuantity;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5];

  @override
  List get values => [
        ownerAddress,
        sellTokenId,
        sellTokenQuantity,
        buyTokenId,
        buyTokenQuantity
      ];

  /// Convert the [MarketSellAssetContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toString(),
      'sell_token_id': BytesUtils.tryToHexString(sellTokenId),
      'sell_token_quantity': sellTokenQuantity?.toString(),
      'buy_token_id': BytesUtils.tryToHexString(buyTokenId),
      'buy_token_quantity': buyTokenQuantity?.toString(),
    }..removeWhere((k, v) => v == null);
  }

  /// Convert the [MarketSellAssetContract] object to its string representation.
  @override
  String toString() {
    return 'MarketSellAssetContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.marketSellAssetContract;
}

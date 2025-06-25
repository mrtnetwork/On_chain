import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

class MarketCancelOrderContract extends TronBaseContract {
  /// Create a new [MarketCancelOrderContract] instance by parsing a JSON map.
  factory MarketCancelOrderContract.fromJson(Map<String, dynamic> json) {
    return MarketCancelOrderContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      orderId:
          OnChainUtils.parseBytes(value: json['order_id'], name: 'order_id'),
    );
  }

  /// Create a new [MarketCancelOrderContract] instance with specified parameters.
  MarketCancelOrderContract({required this.ownerAddress, List<int>? orderId})
      : orderId = BytesUtils.tryToBytes(orderId, unmodifiable: true);
  factory MarketCancelOrderContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return MarketCancelOrderContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        orderId: decode.getField(2));
  }

  /// Account address
  @override
  final TronAddress ownerAddress;
  final List<int>? orderId;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [ownerAddress, orderId];

  /// Convert the [MarketCancelOrderContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'order_id': BytesUtils.tryToHexString(orderId)
    }..removeWhere((k, v) => v == null);
  }

  /// Convert the [MarketCancelOrderContract] object to its string representation.
  @override
  String toString() {
    return 'MarketCancelOrderContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.marketCancelOrderContract;
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/models/contracts/contracts.dart" as protocol_contracts;
import "package:on_chain/tron/src/proto_messages/protocol/src/api.dart" as protocol_api;

class TronWalletMarketSellAsset extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronMarketSellAssetContract? marketSellAsset;

  const TronWalletMarketSellAsset({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.marketSellAsset,
  });

  @override
  ProtoMessageConfig protoConfig() =>marketSellAsset?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => marketSellAsset?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(marketSellAsset) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletMarketSellAsset;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}


class TronWalletMarketCancelOrder extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronMarketCancelOrderContract? marketCancelOrder;

  const TronWalletMarketCancelOrder({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.marketCancelOrder,
  });

  @override
  ProtoMessageConfig protoConfig() =>marketCancelOrder?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => marketCancelOrder?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(marketCancelOrder) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletMarketCancelOrder;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}



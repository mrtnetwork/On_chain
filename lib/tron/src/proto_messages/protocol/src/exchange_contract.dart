import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/models/contracts/contracts.dart" as protocol_contracts;
import "package:on_chain/tron/src/proto_messages/protocol/src/api.dart" as protocol_api;

class TronWalletExchangeCreate extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronExchangeCreateContract? exchangeCreate;

  const TronWalletExchangeCreate({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.exchangeCreate,
  });

  @override
  ProtoMessageConfig protoConfig() =>exchangeCreate?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => exchangeCreate?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(exchangeCreate) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletExchangeCreate;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}


class TronWalletExchangeInject extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronExchangeInjectContract? exchangeInject;

  const TronWalletExchangeInject({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.exchangeInject,
  });

  @override
  ProtoMessageConfig protoConfig() =>exchangeInject?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => exchangeInject?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(exchangeInject) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletExchangeInject;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}


class TronWalletExchangeWithdraw extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronExchangeWithdrawContract? exchangeWithdraw;

  const TronWalletExchangeWithdraw({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.exchangeWithdraw,
  });

  @override
  ProtoMessageConfig protoConfig() =>exchangeWithdraw?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => exchangeWithdraw?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(exchangeWithdraw) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletExchangeWithdraw;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}


class TronWalletExchangeTransaction extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronExchangeTransactionContract? exchangeTransaction;

  const TronWalletExchangeTransaction({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.exchangeTransaction,
  });

  @override
  ProtoMessageConfig protoConfig() =>exchangeTransaction?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => exchangeTransaction?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(exchangeTransaction) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletExchangeTransaction;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}



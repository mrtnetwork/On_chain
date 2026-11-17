import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/models/contracts/contracts.dart" as protocol_contracts;
import "package:on_chain/tron/src/proto_messages/protocol/src/api.dart" as protocol_api;

class TronAssetIssueContractFrozenSupply extends TronProtoMessage {
  final BigInt? frozenAmount;

    /// asset amount
  final BigInt? frozenDays;

  const TronAssetIssueContractFrozenSupply({
    this.frozenAmount,
    this.frozenDays,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        frozenAmount,
        frozenDays,
      ];


  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return {
      'frozen_amount': config.encodeBigint(frozenAmount),
      'frozen_days': config.encodeBigint(frozenDays),
    }.notNullValue;
  }


  factory TronAssetIssueContractFrozenSupply.fromJson(Map<String, dynamic> json, {TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return TronAssetIssueContractFrozenSupply(
      frozenAmount: json.valueAsBigInt<BigInt?>('frozen_amount', normalizeKeyLookup: config.normalizeKeys),
      frozenDays: json.valueAsBigInt<BigInt?>('frozen_days', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory TronAssetIssueContractFrozenSupply.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAssetIssueContractFrozenSupply(
      frozenAmount: decode.getBigInt<BigInt?>(1),
      frozenDays: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolAssetIssueContractFrozenSupply;

}


class TronWalletCreateAssetIssue extends TronProtoMessage with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

    /// Please use CreateAssetIssue2 instead of this function.
  final protocol_contracts.TronAssetIssueContract? createAssetIssue;

  const TronWalletCreateAssetIssue({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.createAssetIssue,
  });

  @override
  ProtoMessageConfig protoConfig() =>createAssetIssue?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createAssetIssue?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(createAssetIssue) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletCreateAssetIssue;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }
  @override
  protocol_contracts.TronTransaction onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_contracts.TronTransaction.fromJson(json, config: jsonConfig);
  }

}


class TronWalletCreateAssetIssue2 extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

    /// Use this function instead of CreateAssetIssue.
  final protocol_contracts.TronAssetIssueContract? createAssetIssue2;

  const TronWalletCreateAssetIssue2({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.createAssetIssue2,
  });

  @override
  ProtoMessageConfig protoConfig() =>createAssetIssue2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createAssetIssue2?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(createAssetIssue2) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletCreateAssetIssue2;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}


class TronWalletTransferAsset extends TronProtoMessage with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

    /// Please use TransferAsset2 instead of this function.
  final protocol_contracts.TronTransferAssetContract? transferAsset;

  const TronWalletTransferAsset({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.transferAsset,
  });

  @override
  ProtoMessageConfig protoConfig() =>transferAsset?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => transferAsset?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(transferAsset) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletTransferAsset;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }
  @override
  protocol_contracts.TronTransaction onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_contracts.TronTransaction.fromJson(json, config: jsonConfig);
  }

}


class TronWalletTransferAsset2 extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

    /// Use this function instead of TransferAsset.
  final protocol_contracts.TronTransferAssetContract? transferAsset2;

  const TronWalletTransferAsset2({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.transferAsset2,
  });

  @override
  ProtoMessageConfig protoConfig() =>transferAsset2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => transferAsset2?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(transferAsset2) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletTransferAsset2;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}


class TronWalletParticipateAssetIssue extends TronProtoMessage with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

    /// Please use ParticipateAssetIssue2 instead of this function.
  final protocol_contracts.TronParticipateAssetIssueContract? participateAssetIssue;

  const TronWalletParticipateAssetIssue({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.participateAssetIssue,
  });

  @override
  ProtoMessageConfig protoConfig() =>participateAssetIssue?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => participateAssetIssue?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(participateAssetIssue) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletParticipateAssetIssue;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }
  @override
  protocol_contracts.TronTransaction onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_contracts.TronTransaction.fromJson(json, config: jsonConfig);
  }

}


class TronWalletParticipateAssetIssue2 extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

    /// Use this function instead of ParticipateAssetIssue.
  final protocol_contracts.TronParticipateAssetIssueContract? participateAssetIssue2;

  const TronWalletParticipateAssetIssue2({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.participateAssetIssue2,
  });

  @override
  ProtoMessageConfig protoConfig() =>participateAssetIssue2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => participateAssetIssue2?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(participateAssetIssue2) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletParticipateAssetIssue2;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}


class TronWalletUnfreezeAsset extends TronProtoMessage with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

    /// Please use UnfreezeAsset2 instead of this function.
  final protocol_contracts.TronUnfreezeAssetContract? unfreezeAsset;

  const TronWalletUnfreezeAsset({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.unfreezeAsset,
  });

  @override
  ProtoMessageConfig protoConfig() =>unfreezeAsset?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => unfreezeAsset?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(unfreezeAsset) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletUnfreezeAsset;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }
  @override
  protocol_contracts.TronTransaction onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_contracts.TronTransaction.fromJson(json, config: jsonConfig);
  }

}


class TronWalletUnfreezeAsset2 extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

    /// Use this function instead of UnfreezeAsset.
  final protocol_contracts.TronUnfreezeAssetContract? unfreezeAsset2;

  const TronWalletUnfreezeAsset2({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.unfreezeAsset2,
  });

  @override
  ProtoMessageConfig protoConfig() =>unfreezeAsset2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => unfreezeAsset2?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(unfreezeAsset2) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletUnfreezeAsset2;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}


class TronWalletUpdateAsset extends TronProtoMessage with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

    /// Please use UpdateAsset2 instead of this function.
  final protocol_contracts.TronUpdateAssetContract? updateAsset;

  const TronWalletUpdateAsset({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.updateAsset,
  });

  @override
  ProtoMessageConfig protoConfig() =>updateAsset?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateAsset?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(updateAsset) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletUpdateAsset;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }
  @override
  protocol_contracts.TronTransaction onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_contracts.TronTransaction.fromJson(json, config: jsonConfig);
  }

}


class TronWalletUpdateAsset2 extends TronProtoMessage with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

    /// Use this function instead of UpdateAsset.
  final protocol_contracts.TronUpdateAssetContract? updateAsset2;

  const TronWalletUpdateAsset2({
     this.jsonConfig =  TronProtoJsonConfig.config,
    this.updateAsset2,
  });

  @override
  ProtoMessageConfig protoConfig() =>updateAsset2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateAsset2?.protoValues?? [];

  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return config.encodeMessage(updateAsset2) ?? {};
   }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolWalletUpdateAsset2;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }
  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
     return protocol_api.TronTransactionExtention.fromJson(json, config: jsonConfig);
  }

}



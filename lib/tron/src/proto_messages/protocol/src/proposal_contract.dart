import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/models/contracts/contracts.dart"
    as protocol_contracts;
import "package:on_chain/tron/src/proto_messages/protocol/src/api.dart"
    as protocol_api;

class TronWalletProposalCreate extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronProposalCreateContract? proposalCreate;

  const TronWalletProposalCreate({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.proposalCreate,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      proposalCreate?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => proposalCreate?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(proposalCreate) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletProposalCreate;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletProposalApprove extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronProposalApproveContract? proposalApprove;

  const TronWalletProposalApprove({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.proposalApprove,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      proposalApprove?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => proposalApprove?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(proposalApprove) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletProposalApprove;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletProposalDelete extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronProposalDeleteContract? proposalDelete;

  const TronWalletProposalDelete({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.proposalDelete,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      proposalDelete?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => proposalDelete?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(proposalDelete) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletProposalDelete;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

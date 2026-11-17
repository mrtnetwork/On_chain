import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/models/contracts/contracts.dart"
    as protocol_contracts;
import "package:on_chain/tron/src/proto_messages/protocol/src/api.dart"
    as protocol_api;

class TronWalletVoteWitnessAccount extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use VoteWitnessAccount2 instead of this function.
  final protocol_contracts.TronVoteWitnessContract? voteWitnessAccount;

  const TronWalletVoteWitnessAccount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.voteWitnessAccount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      voteWitnessAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => voteWitnessAccount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(voteWitnessAccount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletVoteWitnessAccount;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }

  @override
  protocol_contracts.TronTransaction onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronTransaction.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletVoteWitnessAccount2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of VoteWitnessAccount.
  final protocol_contracts.TronVoteWitnessContract? voteWitnessAccount2;

  const TronWalletVoteWitnessAccount2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.voteWitnessAccount2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      voteWitnessAccount2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => voteWitnessAccount2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(voteWitnessAccount2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletVoteWitnessAccount2;
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

class TronWalletUpdateWitness extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use UpdateWitness2 instead of this function.
  final protocol_contracts.TronWitnessUpdateContract? updateWitness;

  const TronWalletUpdateWitness({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.updateWitness,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      updateWitness?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateWitness?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(updateWitness) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUpdateWitness;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }

  @override
  protocol_contracts.TronTransaction onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronTransaction.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletUpdateWitness2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of UpdateWitness.
  final protocol_contracts.TronWitnessUpdateContract? updateWitness2;

  const TronWalletUpdateWitness2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.updateWitness2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      updateWitness2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateWitness2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(updateWitness2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUpdateWitness2;
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

class TronWalletCreateWitness extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use CreateWitness2 instead of this function.
  final protocol_contracts.TronWitnessCreateContract? createWitness;

  const TronWalletCreateWitness({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createWitness,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createWitness?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createWitness?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createWitness) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateWitness;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }

  @override
  protocol_contracts.TronTransaction onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronTransaction.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletCreateWitness2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of CreateWitness.
  final protocol_contracts.TronWitnessCreateContract? createWitness2;

  const TronWalletCreateWitness2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createWitness2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createWitness2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createWitness2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createWitness2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateWitness2;
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

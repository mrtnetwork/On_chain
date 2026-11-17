import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/models/contracts/contracts.dart"
    as protocol_contracts;
import "package:on_chain/tron/src/proto_messages/protocol/src/api.dart"
    as protocol_api;

class TronWalletUpdateAccount extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use UpdateAccount2 instead of this function.
  final protocol_contracts.TronAccountUpdateContract? updateAccount;

  const TronWalletUpdateAccount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.updateAccount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      updateAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateAccount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(updateAccount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUpdateAccount;
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

class TronWalletSetAccountId extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronSetAccountIdContract? setAccountId;

  const TronWalletSetAccountId({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.setAccountId,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      setAccountId?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => setAccountId?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(setAccountId) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSetAccountId;
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

class TronWalletUpdateAccount2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of UpdateAccount.
  final protocol_contracts.TronAccountUpdateContract? updateAccount2;

  const TronWalletUpdateAccount2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.updateAccount2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      updateAccount2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateAccount2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(updateAccount2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUpdateAccount2;
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

class TronWalletCreateAccount extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use CreateAccount2 instead of this function.
  final protocol_contracts.TronAccountCreateContract? createAccount;

  const TronWalletCreateAccount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createAccount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createAccount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createAccount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateAccount;
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

class TronWalletCreateAccount2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of CreateAccount.
  final protocol_contracts.TronAccountCreateContract? createAccount2;

  const TronWalletCreateAccount2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createAccount2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createAccount2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createAccount2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createAccount2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateAccount2;
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

class TronWalletAccountPermissionUpdate extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronAccountPermissionUpdateContract?
  accountPermissionUpdate;

  const TronWalletAccountPermissionUpdate({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.accountPermissionUpdate,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      accountPermissionUpdate?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => accountPermissionUpdate?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(accountPermissionUpdate) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletAccountPermissionUpdate;
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

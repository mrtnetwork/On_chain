import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/models/contracts/contracts.dart"
    as protocol_contracts;
import "package:on_chain/tron/src/proto_messages/protocol/src/api.dart"
    as protocol_api;

class TronTransactionBalanceTrace extends TronProtoMessage {
  final List<int>? transactionIdentifier;

  final List<TronTransactionBalanceTraceOperation> operation;

  final String? type;

  final String? status;

  const TronTransactionBalanceTrace({
    this.transactionIdentifier,
    this.operation = const [],
    this.type,
    this.status,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.string(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    transactionIdentifier,
    operation,
    type,
    status,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transaction_identifier': config.encodeBinary(transactionIdentifier),
      'operation': operation.map((e) => config.encodeMessage(e)).toList(),
      'type': type,
      'status': status,
    }.notNullValue;
  }

  factory TronTransactionBalanceTrace.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionBalanceTrace(
      transactionIdentifier: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transaction_identifier',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      operation:
          (json.valueEnsureAsList<dynamic>(
                'operation',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronTransactionBalanceTraceOperation,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => TronTransactionBalanceTraceOperation.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      type: json.valueAsString<String?>(
        'type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      status: json.valueAsString<String?>(
        'status',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransactionBalanceTrace.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionBalanceTrace(
      transactionIdentifier: decode.getBytes<List<int>?>(1),
      operation:
          decode
              .getListOfBytes(2)
              .map((b) => TronTransactionBalanceTraceOperation.deserialize(b))
              .toList(),
      type: decode.getString<String?>(3),
      status: decode.getString<String?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionBalanceTrace;
}

class TronTransactionBalanceTraceOperation extends TronProtoMessage {
  final BigInt? operationIdentifier;

  final List<int>? address;

  final BigInt? amount;

  const TronTransactionBalanceTraceOperation({
    this.operationIdentifier,
    this.address,
    this.amount,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [operationIdentifier, address, amount];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'operation_identifier': config.encodeBigint(operationIdentifier),
      'address': config.encodeBinary(address),
      'amount': config.encodeBigint(amount),
    }.notNullValue;
  }

  factory TronTransactionBalanceTraceOperation.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionBalanceTraceOperation(
      operationIdentifier: json.valueAsBigInt<BigInt?>(
        'operation_identifier',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      address: config.decodeBinary<List<int>?>(
        json.valueAs('address', normalizeKeyLookup: config.normalizeKeys),
      ),
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransactionBalanceTraceOperation.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionBalanceTraceOperation(
      operationIdentifier: decode.getBigInt<BigInt?>(1),
      address: decode.getBytes<List<int>?>(2),
      amount: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionBalanceTraceOperation;
}

class TronBlockBalanceTrace extends TronProtoMessage {
  final TronBlockBalanceTraceBlockIdentifier? blockIdentifier;

  final BigInt? timestamp;

  final List<TronTransactionBalanceTrace> transactionBalanceTrace;

  const TronBlockBalanceTrace({
    this.blockIdentifier,
    this.timestamp,
    this.transactionBalanceTrace = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    blockIdentifier,
    timestamp,
    transactionBalanceTrace,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'block_identifier': config.encodeMessage(blockIdentifier),
      'timestamp': config.encodeBigint(timestamp),
      'transaction_balance_trace':
          transactionBalanceTrace.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronBlockBalanceTrace.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockBalanceTrace(
      blockIdentifier: json
          .valueTo<TronBlockBalanceTraceBlockIdentifier?, Object>(
            key: 'block_identifier',
            parse:
                (v) => TronBlockBalanceTraceBlockIdentifier.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      timestamp: json.valueAsBigInt<BigInt?>(
        'timestamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionBalanceTrace:
          (json.valueEnsureAsList<dynamic>(
                'transaction_balance_trace',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronTransactionBalanceTrace, Object>(
                  value: e,
                  parse:
                      (v) => TronTransactionBalanceTrace.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronBlockBalanceTrace.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockBalanceTrace(
      blockIdentifier: decode.messageTo<TronBlockBalanceTraceBlockIdentifier?>(
        1,
        (b) => TronBlockBalanceTraceBlockIdentifier.deserialize(b),
      ),
      timestamp: decode.getBigInt<BigInt?>(2),
      transactionBalanceTrace:
          decode
              .getListOfBytes(3)
              .map((b) => TronTransactionBalanceTrace.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockBalanceTrace;
}

class TronBlockBalanceTraceBlockIdentifier extends TronProtoMessage {
  final List<int>? hash;

  final BigInt? number;

  const TronBlockBalanceTraceBlockIdentifier({this.hash, this.number});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [hash, number];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'hash': config.encodeBinary(hash),
      'number': config.encodeBigint(number),
    }.notNullValue;
  }

  factory TronBlockBalanceTraceBlockIdentifier.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockBalanceTraceBlockIdentifier(
      hash: config.decodeBinary<List<int>?>(
        json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      number: json.valueAsBigInt<BigInt?>(
        'number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronBlockBalanceTraceBlockIdentifier.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockBalanceTraceBlockIdentifier(
      hash: decode.getBytes<List<int>?>(1),
      number: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockBalanceTraceBlockIdentifier;
}

/// BlockIdentifier parent_block_identifier = 4;
class TronAccountTrace extends TronProtoMessage {
  final BigInt? balance;

  final BigInt? placeholder;

  const TronAccountTrace({this.balance, this.placeholder});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.int64(99)],
    );
  }

  @override
  List<Object?> get protoValues => [balance, placeholder];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'balance': config.encodeBigint(balance),
      'placeholder': config.encodeBigint(placeholder),
    }.notNullValue;
  }

  factory TronAccountTrace.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountTrace(
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      placeholder: json.valueAsBigInt<BigInt?>(
        'placeholder',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronAccountTrace.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountTrace(
      balance: decode.getBigInt<BigInt?>(1),
      placeholder: decode.getBigInt<BigInt?>(99),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountTrace;
}

class TronAccountIdentifier extends TronProtoMessage {
  final List<int>? address;

  const TronAccountIdentifier({this.address});

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
  List<Object?> get protoValues => [address];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'address': config.encodeBinary(address)}.notNullValue;
  }

  factory TronAccountIdentifier.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountIdentifier(
      address: config.decodeBinary<List<int>?>(
        json.valueAs('address', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronAccountIdentifier.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountIdentifier(address: decode.getBytes<List<int>?>(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountIdentifier;
}

class TronAccountBalanceRequest extends TronProtoMessage {
  final TronAccountIdentifier? accountIdentifier;

  final TronBlockBalanceTraceBlockIdentifier? blockIdentifier;

  const TronAccountBalanceRequest({
    this.accountIdentifier,
    this.blockIdentifier,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [accountIdentifier, blockIdentifier];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'account_identifier': config.encodeMessage(accountIdentifier),
      'block_identifier': config.encodeMessage(blockIdentifier),
    }.notNullValue;
  }

  factory TronAccountBalanceRequest.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountBalanceRequest(
      accountIdentifier: json.valueTo<TronAccountIdentifier?, Object>(
        key: 'account_identifier',
        parse:
            (v) => TronAccountIdentifier.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockIdentifier: json
          .valueTo<TronBlockBalanceTraceBlockIdentifier?, Object>(
            key: 'block_identifier',
            parse:
                (v) => TronBlockBalanceTraceBlockIdentifier.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory TronAccountBalanceRequest.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountBalanceRequest(
      accountIdentifier: decode.messageTo<TronAccountIdentifier?>(
        1,
        (b) => TronAccountIdentifier.deserialize(b),
      ),
      blockIdentifier: decode.messageTo<TronBlockBalanceTraceBlockIdentifier?>(
        2,
        (b) => TronBlockBalanceTraceBlockIdentifier.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountBalanceRequest;
}

class TronAccountBalanceResponse extends TronProtoMessage {
  final BigInt? balance;

  final TronBlockBalanceTraceBlockIdentifier? blockIdentifier;

  const TronAccountBalanceResponse({this.balance, this.blockIdentifier});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [balance, blockIdentifier];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'balance': config.encodeBigint(balance),
      'block_identifier': config.encodeMessage(blockIdentifier),
    }.notNullValue;
  }

  factory TronAccountBalanceResponse.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountBalanceResponse(
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockIdentifier: json
          .valueTo<TronBlockBalanceTraceBlockIdentifier?, Object>(
            key: 'block_identifier',
            parse:
                (v) => TronBlockBalanceTraceBlockIdentifier.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory TronAccountBalanceResponse.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountBalanceResponse(
      balance: decode.getBigInt<BigInt?>(1),
      blockIdentifier: decode.messageTo<TronBlockBalanceTraceBlockIdentifier?>(
        2,
        (b) => TronBlockBalanceTraceBlockIdentifier.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountBalanceResponse;
}

class TronWalletGetAccountBalance extends TronProtoMessage
    with ITronProtoServiceMessage<TronAccountBalanceResponse> {
  final TronProtoJsonConfig jsonConfig;

  final TronAccountBalanceRequest? getAccountBalance;

  const TronWalletGetAccountBalance({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAccountBalance,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAccountBalance?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAccountBalance?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAccountBalance) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAccountBalance;
  @override
  TronAccountBalanceResponse onServiceResponse(List<int> bytes) {
    return TronAccountBalanceResponse.deserialize(bytes);
  }

  @override
  TronAccountBalanceResponse onServiceResponseJson(Map<String, dynamic> json) {
    return TronAccountBalanceResponse.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBlockBalanceTrace extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockBalanceTrace> {
  final TronProtoJsonConfig jsonConfig;

  final TronBlockBalanceTraceBlockIdentifier? getBlockBalanceTrace;

  const TronWalletGetBlockBalanceTrace({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlockBalanceTrace,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlockBalanceTrace?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlockBalanceTrace?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlockBalanceTrace) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBlockBalanceTrace;
  @override
  TronBlockBalanceTrace onServiceResponse(List<int> bytes) {
    return TronBlockBalanceTrace.deserialize(bytes);
  }

  @override
  TronBlockBalanceTrace onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockBalanceTrace.fromJson(json, config: jsonConfig);
  }
}

class TronWalletCreateTransaction extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use CreateTransaction2 instead of this function.
  final protocol_contracts.TronTransferContract? createTransaction;

  const TronWalletCreateTransaction({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createTransaction,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createTransaction?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createTransaction?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createTransaction) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateTransaction;
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

class TronWalletCreateTransaction2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of CreateTransaction.
  final protocol_contracts.TronTransferContract? createTransaction2;

  const TronWalletCreateTransaction2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createTransaction2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createTransaction2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createTransaction2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createTransaction2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateTransaction2;
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

class TronWalletFreezeBalance extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use FreezeBalance2 instead of this function.
  final protocol_contracts.TronFreezeBalanceContract? freezeBalance;

  const TronWalletFreezeBalance({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.freezeBalance,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      freezeBalance?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => freezeBalance?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(freezeBalance) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletFreezeBalance;
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

class TronWalletFreezeBalance2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of FreezeBalance.
  final protocol_contracts.TronFreezeBalanceContract? freezeBalance2;

  const TronWalletFreezeBalance2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.freezeBalance2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      freezeBalance2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => freezeBalance2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(freezeBalance2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletFreezeBalance2;
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

class TronWalletFreezeBalanceV2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function when FreezeBalanceV2.
  final protocol_contracts.TronFreezeBalanceV2Contract? freezeBalanceV2;

  const TronWalletFreezeBalanceV2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.freezeBalanceV2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      freezeBalanceV2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => freezeBalanceV2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(freezeBalanceV2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletFreezeBalanceV2;
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

class TronWalletUnfreezeBalance extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use UnfreezeBalance2 instead of this function.
  final protocol_contracts.TronUnfreezeBalanceContract? unfreezeBalance;

  const TronWalletUnfreezeBalance({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.unfreezeBalance,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      unfreezeBalance?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => unfreezeBalance?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(unfreezeBalance) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUnfreezeBalance;
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

class TronWalletUnfreezeBalance2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of UnfreezeBalance.
  final protocol_contracts.TronUnfreezeBalanceContract? unfreezeBalance2;

  const TronWalletUnfreezeBalance2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.unfreezeBalance2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      unfreezeBalance2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => unfreezeBalance2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(unfreezeBalance2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUnfreezeBalance2;
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

class TronWalletUnfreezeBalanceV2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function when UnfreezeBalanceV2.
  final protocol_contracts.TronUnfreezeBalanceV2Contract? unfreezeBalanceV2;

  const TronWalletUnfreezeBalanceV2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.unfreezeBalanceV2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      unfreezeBalanceV2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => unfreezeBalanceV2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(unfreezeBalanceV2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUnfreezeBalanceV2;
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

class TronWalletWithdrawBalance extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use WithdrawBalance2 instead of this function.
  final protocol_contracts.TronWithdrawBalanceContract? withdrawBalance;

  const TronWalletWithdrawBalance({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.withdrawBalance,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      withdrawBalance?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => withdrawBalance?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(withdrawBalance) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletWithdrawBalance;
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

class TronWalletWithdrawBalance2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of WithdrawBalance.
  final protocol_contracts.TronWithdrawBalanceContract? withdrawBalance2;

  const TronWalletWithdrawBalance2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.withdrawBalance2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      withdrawBalance2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => withdrawBalance2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(withdrawBalance2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletWithdrawBalance2;
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

class TronWalletWithdrawExpireUnfreeze extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronWithdrawExpireUnfreezeContract?
  withdrawExpireUnfreeze;

  const TronWalletWithdrawExpireUnfreeze({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.withdrawExpireUnfreeze,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      withdrawExpireUnfreeze?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => withdrawExpireUnfreeze?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(withdrawExpireUnfreeze) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletWithdrawExpireUnfreeze;
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

class TronWalletDelegateResource extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronDelegateResourceContract? delegateResource;

  const TronWalletDelegateResource({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.delegateResource,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      delegateResource?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => delegateResource?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(delegateResource) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletDelegateResource;
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

class TronWalletUnDelegateResource extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronUnDelegateResourceContract? unDelegateResource;

  const TronWalletUnDelegateResource({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.unDelegateResource,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      unDelegateResource?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => unDelegateResource?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(unDelegateResource) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUnDelegateResource;
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

class TronWalletCancelAllUnfreezeV2 extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronCancelAllUnfreezeV2Contract? cancelAllUnfreezeV2;

  const TronWalletCancelAllUnfreezeV2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.cancelAllUnfreezeV2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      cancelAllUnfreezeV2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => cancelAllUnfreezeV2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(cancelAllUnfreezeV2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCancelAllUnfreezeV2;
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

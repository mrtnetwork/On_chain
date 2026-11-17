import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/proto_messages/protocol/src/api.dart"
    as protocol_api;
import "package:on_chain/tron/src/models/contracts/contracts.dart"
    as protocol_contracts;

/// Specify the name of the package that generated the Java file
/// option java_outer_classname = "BuyStorageBytesContract"; //Specify the class name of the generated Java file
class TronBuyStorageBytesContract extends TronProtoMessage {
  final List<int>? ownerAddress;

  final BigInt? bytes;

  const TronBuyStorageBytesContract({this.ownerAddress, this.bytes});

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
  List<Object?> get protoValues => [ownerAddress, bytes];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': config.encodeBinary(ownerAddress),
      'bytes': config.encodeBigint(bytes),
    }.notNullValue;
  }

  factory TronBuyStorageBytesContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBuyStorageBytesContract(
      ownerAddress: config.decodeBinary<List<int>?>(
        json.valueAs('owner_address', normalizeKeyLookup: config.normalizeKeys),
      ),
      bytes: json.valueAsBigInt<BigInt?>(
        'bytes',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronBuyStorageBytesContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBuyStorageBytesContract(
      ownerAddress: decode.getBytes<List<int>?>(1),
      bytes: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBuyStorageBytesContract;
}

/// storage bytes for buy
class TronBuyStorageContract extends TronProtoMessage {
  final List<int>? ownerAddress;

  final BigInt? quant;

  const TronBuyStorageContract({this.ownerAddress, this.quant});

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
  List<Object?> get protoValues => [ownerAddress, quant];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': config.encodeBinary(ownerAddress),
      'quant': config.encodeBigint(quant),
    }.notNullValue;
  }

  factory TronBuyStorageContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBuyStorageContract(
      ownerAddress: config.decodeBinary<List<int>?>(
        json.valueAs('owner_address', normalizeKeyLookup: config.normalizeKeys),
      ),
      quant: json.valueAsBigInt<BigInt?>(
        'quant',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronBuyStorageContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBuyStorageContract(
      ownerAddress: decode.getBytes<List<int>?>(1),
      quant: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBuyStorageContract;
}

/// trx quantity for buy storage (sun)
class TronSellStorageContract extends TronProtoMessage {
  final List<int>? ownerAddress;

  final BigInt? storageBytes;

  const TronSellStorageContract({this.ownerAddress, this.storageBytes});

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
  List<Object?> get protoValues => [ownerAddress, storageBytes];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': config.encodeBinary(ownerAddress),
      'storage_bytes': config.encodeBigint(storageBytes),
    }.notNullValue;
  }

  factory TronSellStorageContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSellStorageContract(
      ownerAddress: config.decodeBinary<List<int>?>(
        json.valueAs('owner_address', normalizeKeyLookup: config.normalizeKeys),
      ),
      storageBytes: json.valueAsBigInt<BigInt?>(
        'storage_bytes',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronSellStorageContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSellStorageContract(
      ownerAddress: decode.getBytes<List<int>?>(1),
      storageBytes: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSellStorageContract;
}

class TronWalletBuyStorage extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final TronBuyStorageContract? buyStorage;

  const TronWalletBuyStorage({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.buyStorage,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      buyStorage?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => buyStorage?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(buyStorage) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletBuyStorage;
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

class TronWalletBuyStorageBytes extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final TronBuyStorageBytesContract? buyStorageBytes;

  const TronWalletBuyStorageBytes({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.buyStorageBytes,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      buyStorageBytes?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => buyStorageBytes?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(buyStorageBytes) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletBuyStorageBytes;
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

class TronWalletSellStorage extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final TronSellStorageContract? sellStorage;

  const TronWalletSellStorage({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.sellStorage,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      sellStorage?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => sellStorage?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(sellStorage) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSellStorage;
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

class TronWalletUpdateBrokerage extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronUpdateBrokerageContract? updateBrokerage;

  const TronWalletUpdateBrokerage({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.updateBrokerage,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      updateBrokerage?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateBrokerage?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(updateBrokerage) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletUpdateBrokerage;
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

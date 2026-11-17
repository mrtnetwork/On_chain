import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart'
    show TronTransactionContractContractType;
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';

class TronExchangeCreateContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BuBytes? firstTokenId;

  final BigInt? firstTokenBalance;

  final BuBytes? secondTokenId;

  final BigInt? secondTokenBalance;

  TronExchangeCreateContract({
    required this.ownerAddress,
    List<int>? firstTokenId,
    this.firstTokenBalance,
    List<int>? secondTokenId,
    this.secondTokenBalance,
  }) : firstTokenId = firstTokenId?.asImmutableBytes,
       secondTokenId = secondTokenId?.asImmutableBytes,
       super(TronTransactionContractContractType.exchangeCreateContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.int64(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    firstTokenId,
    firstTokenBalance,
    secondTokenId,
    secondTokenBalance,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'first_token_id': config.encodeBinary(firstTokenId),
      'first_token_balance': config.encodeBigint(firstTokenBalance),
      'second_token_id': config.encodeBinary(secondTokenId),
      'second_token_balance': config.encodeBigint(secondTokenBalance),
    }.notNullValue;
  }

  factory TronExchangeCreateContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronExchangeCreateContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      firstTokenId: config.decodeBinary(
        json.valueAs(
          "first_token_id",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      firstTokenBalance: json.valueAsBigInt<BigInt?>(
        'first_token_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      secondTokenId: config.decodeBinary(
        json.valueAs(
          "second_token_id",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      secondTokenBalance: json.valueAsBigInt<BigInt?>(
        'second_token_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronExchangeCreateContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronExchangeCreateContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      firstTokenId: decode.getBytes<List<int>?>(2),
      firstTokenBalance: decode.getBigInt<BigInt?>(3),
      secondTokenId: decode.getBytes<List<int>?>(4),
      secondTokenBalance: decode.getBigInt<BigInt?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolExchangeCreateContract;
}

class TronExchangeInjectContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BigInt? exchangeId;

  final BuBytes? tokenId;

  final BigInt? quant;

  TronExchangeInjectContract({
    required this.ownerAddress,
    this.exchangeId,
    List<int>? tokenId,
    this.quant,
  }) : tokenId = tokenId?.asImmutableBytes,
       super(TronTransactionContractContractType.exchangeInjectContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    exchangeId,
    tokenId,
    quant,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'exchange_id': config.encodeBigint(exchangeId),
      'token_id': config.encodeBinary(tokenId),
      'quant': config.encodeBigint(quant),
    }.notNullValue;
  }

  factory TronExchangeInjectContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronExchangeInjectContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      exchangeId: json.valueAsBigInt<BigInt?>(
        'exchange_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenId: config.decodeBinary(
        json.valueAs("token_id", normalizeKeyLookup: config.normalizeKeys),
      ),
      quant: json.valueAsBigInt<BigInt?>(
        'quant',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronExchangeInjectContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronExchangeInjectContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      exchangeId: decode.getBigInt<BigInt?>(2),
      tokenId: decode.getBytes<List<int>?>(3),
      quant: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolExchangeInjectContract;
}

class TronExchangeWithdrawContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BigInt? exchangeId;

  final BuBytes? tokenId;

  final BigInt? quant;

  TronExchangeWithdrawContract({
    required this.ownerAddress,
    this.exchangeId,
    List<int>? tokenId,
    this.quant,
  }) : tokenId = tokenId?.asImmutableBytes,
       super(TronTransactionContractContractType.exchangeWithdrawContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    exchangeId,
    tokenId,
    quant,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'exchange_id': config.encodeBigint(exchangeId),
      'token_id': config.encodeBinary(tokenId),
      'quant': config.encodeBigint(quant),
    }.notNullValue;
  }

  factory TronExchangeWithdrawContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronExchangeWithdrawContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      exchangeId: json.valueAsBigInt<BigInt?>(
        'exchange_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenId: config.decodeBinary(
        json.valueAs("token_id", normalizeKeyLookup: config.normalizeKeys),
      ),
      quant: json.valueAsBigInt<BigInt?>(
        'quant',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronExchangeWithdrawContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronExchangeWithdrawContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      exchangeId: decode.getBigInt<BigInt?>(2),
      tokenId: decode.getBytes<List<int>?>(3),
      quant: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolExchangeWithdrawContract;
}

class TronExchangeTransactionContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BigInt? exchangeId;

  final BuBytes? tokenId;

  final BigInt? quant;

  final BigInt? expected;

  TronExchangeTransactionContract({
    required this.ownerAddress,
    this.exchangeId,
    List<int>? tokenId,
    this.quant,
    this.expected,
  }) : tokenId = tokenId?.asImmutableBytes,
       super(TronTransactionContractContractType.exchangeTransactionContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    exchangeId,
    tokenId,
    quant,
    expected,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'exchange_id': config.encodeBigint(exchangeId),
      'token_id': config.encodeBinary(tokenId),
      'quant': config.encodeBigint(quant),
      'expected': config.encodeBigint(expected),
    }.notNullValue;
  }

  factory TronExchangeTransactionContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronExchangeTransactionContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      exchangeId: json.valueAsBigInt<BigInt?>(
        'exchange_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenId: config.decodeBinary(
        json.valueAs("token_id", normalizeKeyLookup: config.normalizeKeys),
      ),
      quant: json.valueAsBigInt<BigInt?>(
        'quant',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expected: json.valueAsBigInt<BigInt?>(
        'expected',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronExchangeTransactionContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronExchangeTransactionContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      exchangeId: decode.getBigInt<BigInt?>(2),
      tokenId: decode.getBytes<List<int>?>(3),
      quant: decode.getBigInt<BigInt?>(4),
      expected: decode.getBigInt<BigInt?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolExchangeTransactionContract;
}

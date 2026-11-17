import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/smart_contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart'
    show TronTransactionContractContractType;
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';

class TronCreateSmartContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final TronSmartContract? newContract;

  final BigInt? callTokenValue;

  final BigInt? tokenId;
  @override
  BigInt get trxAmount => newContract?.callValue ?? super.trxAmount;
  const TronCreateSmartContract({
    required this.ownerAddress,
    this.newContract,
    this.callTokenValue,
    this.tokenId,
  }) : super(TronTransactionContractContractType.createSmartContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    newContract,
    callTokenValue,
    tokenId,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'new_contract': config.encodeMessage(newContract),
      'call_token_value': config.encodeBigint(callTokenValue),
      'token_id': config.encodeBigint(tokenId),
    }.notNullValue;
  }

  factory TronCreateSmartContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronCreateSmartContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      newContract: json.valueTo<TronSmartContract?, Map<String, dynamic>>(
        key: 'new_contract',
        parse: (v) => TronSmartContract.fromJson(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      callTokenValue: json.valueAsBigInt<BigInt?>('call_token_value'),
      tokenId: json.valueAsBigInt<BigInt?>(
        'token_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronCreateSmartContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronCreateSmartContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      newContract: decode.messageTo<TronSmartContract?>(
        2,
        (b) => TronSmartContract.deserialize(b),
      ),
      callTokenValue: decode.getBigInt<BigInt?>(3),
      tokenId: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolCreateSmartContract;
  bool get hasTokenTransfer => tokenId != null;
}

class TronTriggerSmartContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final TronAddress? contractAddress;

  final BigInt? callValue;

  final BuBytes? data;

  final BigInt? callTokenValue;

  final BigInt? tokenId;
  @override
  BigInt get trxAmount => callValue ?? super.trxAmount;
  TronTriggerSmartContract({
    required this.ownerAddress,
    this.contractAddress,
    this.callValue,
    List<int>? data,
    this.callTokenValue,
    this.tokenId,
  }) : data = data?.asImmutableBytes,
       super(TronTransactionContractContractType.triggerSmartContract);

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
        ProtoFieldConfig.int64(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    contractAddress?.toBytes(),
    callValue,
    data,
    callTokenValue,
    tokenId,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'contract_address': contractAddress?.toAddress(config.visible),
      'call_value': config.encodeBigint(callValue),
      'data': config.encodeBinary(data),
      'call_token_value': config.encodeBigint(callTokenValue),
      'token_id': config.encodeBigint(tokenId),
    }.notNullValue;
  }

  factory TronTriggerSmartContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTriggerSmartContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      contractAddress: json.valueTo<TronAddress?, String>(
        key: 'contract_address',

        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
      callValue: json.valueAsBigInt<BigInt?>(
        'call_value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      data: config.decodeBinary<List<int>?>(
        json.valueAs('data', normalizeKeyLookup: config.normalizeKeys),
      ),
      callTokenValue: json.valueAsBigInt<BigInt?>(
        'call_token_value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenId: json.valueAsBigInt<BigInt?>(
        'token_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTriggerSmartContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTriggerSmartContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      contractAddress: decode.bytesTo<TronAddress?>(2, TronAddress.fromBytes),
      callValue: decode.getBigInt<BigInt?>(3),
      data: decode.getBytes<List<int>?>(4),
      callTokenValue: decode.getBigInt<BigInt?>(5),
      tokenId: decode.getBigInt<BigInt?>(6),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTriggerSmartContract;
}

class TronClearABIContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final TronAddress? contractAddress;

  const TronClearABIContract({required this.ownerAddress, this.contractAddress})
    : super(TronTransactionContractContractType.clearABIContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    contractAddress?.toBytes(),
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'contract_address': contractAddress?.toAddress(config.visible),
    }.notNullValue;
  }

  factory TronClearABIContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronClearABIContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      contractAddress: json.valueTo<TronAddress?, String>(
        key: 'contract_address',

        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronClearABIContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronClearABIContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      contractAddress: decode.bytesTo<TronAddress?>(2, TronAddress.fromBytes),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolClearABIContract;
}

class TronUpdateSettingContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final TronAddress? contractAddress;

  final BigInt? consumeUserResourcePercent;

  const TronUpdateSettingContract({
    required this.ownerAddress,
    this.contractAddress,
    this.consumeUserResourcePercent,
  }) : super(TronTransactionContractContractType.updateSettingContract);

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    contractAddress?.toBytes(),
    consumeUserResourcePercent,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'contract_address': contractAddress?.toAddress(config.visible),
      'consume_user_resource_percent': config.encodeBigint(
        consumeUserResourcePercent,
      ),
    }.notNullValue;
  }

  factory TronUpdateSettingContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronUpdateSettingContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      contractAddress: json.valueTo<TronAddress?, String>(
        key: 'contract_address',

        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consumeUserResourcePercent: json.valueAsBigInt<BigInt?>(
        'consume_user_resource_percent',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronUpdateSettingContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronUpdateSettingContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      contractAddress: decode.bytesTo<TronAddress?>(2, TronAddress.fromBytes),
      consumeUserResourcePercent: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolUpdateSettingContract;
}

class TronUpdateEnergyLimitContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final TronAddress? contractAddress;

  final BigInt? originEnergyLimit;

  const TronUpdateEnergyLimitContract({
    required this.ownerAddress,
    this.contractAddress,
    this.originEnergyLimit,
  }) : super(TronTransactionContractContractType.updateEnergyLimitContract);

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    contractAddress?.toBytes(),
    originEnergyLimit,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'contract_address': contractAddress?.toAddress(config.visible),
      'origin_energy_limit': config.encodeBigint(originEnergyLimit),
    }.notNullValue;
  }

  factory TronUpdateEnergyLimitContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronUpdateEnergyLimitContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      contractAddress: json.valueTo<TronAddress?, String>(
        key: 'contract_address',

        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
      originEnergyLimit: json.valueAsBigInt<BigInt?>(
        'origin_energy_limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronUpdateEnergyLimitContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronUpdateEnergyLimitContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      contractAddress: decode.bytesTo<TronAddress?>(2, TronAddress.fromBytes),
      originEnergyLimit: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolUpdateEnergyLimitContract;
}

class TronSmartContract extends TronProtoMessage {
  final TronAddress? originAddress;

  final TronAddress? contractAddress;

  final TronSmartContractABI? abi;

  final BuBytes? bytecode;

  final BigInt? callValue;

  final BigInt? consumeUserResourcePercent;

  final String? name;

  final BigInt? originEnergyLimit;

  final BuBytes? codeHash;

  final BuBytes? trxHash;

  final int? version;

  TronSmartContract({
    this.originAddress,
    this.contractAddress,
    this.abi,
    List<int>? bytecode,
    this.callValue,
    this.consumeUserResourcePercent,
    this.name,
    this.originEnergyLimit,
    List<int>? codeHash,
    List<int>? trxHash,
    this.version,
  }) : bytecode = bytecode?.asImmutableBytes,
       codeHash = codeHash?.asImmutableBytes,
       trxHash = trxHash?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.int64(6),
        ProtoFieldConfig.string(7),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.bytes(9),
        ProtoFieldConfig.bytes(10),
        ProtoFieldConfig.int32(11),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    originAddress?.toBytes(),
    contractAddress?.toBytes(),
    abi,
    bytecode,
    callValue,
    consumeUserResourcePercent,
    name,
    originEnergyLimit,
    codeHash,
    trxHash,
    version,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'origin_address': originAddress?.toAddress(config.visible),
      'contract_address': contractAddress?.toAddress(config.visible),
      'abi': config.encodeMessage(abi),
      'bytecode': config.encodeBinary(bytecode),
      'call_value': config.encodeBigint(callValue),
      'consume_user_resource_percent': config.encodeBigint(
        consumeUserResourcePercent,
      ),
      'name': name,
      'origin_energy_limit': config.encodeBigint(originEnergyLimit),
      'code_hash': config.encodeBinary(codeHash),
      'trx_hash': config.encodeBinary(trxHash),
      'version': version,
    }.notNullValue;
  }

  factory TronSmartContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSmartContract(
      originAddress: json.valueTo<TronAddress?, String>(
        key: "origin_address",
        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractAddress: json.valueTo<TronAddress?, String>(
        key: "contract_address",
        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),

      abi: json.valueTo<TronSmartContractABI?, Object>(
        key: 'abi',
        parse:
            (v) => TronSmartContractABI.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      bytecode: config.decodeBinary<List<int>?>(
        json.valueAs('bytecode', normalizeKeyLookup: config.normalizeKeys),
      ),
      callValue: json.valueAsBigInt<BigInt?>(
        'call_value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consumeUserResourcePercent: json.valueAsBigInt<BigInt?>(
        'consume_user_resource_percent',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      originEnergyLimit: json.valueAsBigInt<BigInt?>(
        'origin_energy_limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      codeHash: config.decodeBinary<List<int>?>(
        json.valueAs('code_hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      trxHash: config.decodeBinary<List<int>?>(
        json.valueAs('trx_hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      version: json.valueAsInt<int?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronSmartContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSmartContract(
      originAddress: decode.bytesTo<TronAddress?>(1, TronAddress.fromBytes),
      contractAddress: decode.bytesTo<TronAddress?>(2, TronAddress.fromBytes),
      abi: decode.messageTo<TronSmartContractABI?>(
        3,
        (b) => TronSmartContractABI.deserialize(b),
      ),
      bytecode: decode.getBytes<List<int>?>(4),
      callValue: decode.getBigInt<BigInt?>(5),
      consumeUserResourcePercent: decode.getBigInt<BigInt?>(6),
      name: decode.getString<String?>(7),
      originEnergyLimit: decode.getBigInt<BigInt?>(8),
      codeHash: decode.getBytes<List<int>?>(9),
      trxHash: decode.getBytes<List<int>?>(10),
      version: decode.getInt<int?>(11),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSmartContract;
}

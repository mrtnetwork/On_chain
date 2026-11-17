import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import "package:on_chain/tron/src/proto_messages/protocol/src/tron.dart";
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

class TronTransaction extends TronProtoMessage {
  final TronTransactionraw rawData;

  /// Only single-signature transactions are currently supported; the repeated
  /// field exists for a future multi-signature extension.
  final List<BuBytes> signature;

  final List<TronTransactionResult> ret;

  TronTransaction({
    required this.rawData,
    List<List<int>> signature = const [],
    this.ret = const [],
  }) : signature = signature.map((e) => e.asImmutableBytes).toImutableList;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [rawData, signature, ret];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
    bool signatures = true,
    bool rawDataHex = false,
    bool txID = false,
    bool? withVisible,
  }) {
    return {
      'raw_data': config.encodeMessage(rawData),
      'signature': signature.map((e) => config.encodeBinary(e)).toList(),
      'ret': ret.map((e) => config.encodeMessage(e)).toList(),
      if (withVisible != null) 'visible': config.visible,
      if (txID) 'txID': rawData.txID,
      if (rawDataHex) 'raw_data_hex': rawData.toBuffer().toHex(),
    };
  }

  factory TronTransaction.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransaction(
      rawData: json.valueTo<TronTransactionraw, Map<String, dynamic>>(
        key: 'raw_data',
        parse: (v) => TronTransactionraw.fromJson(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signature:
          (json.valueEnsureAsList<dynamic>(
            'signature',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      ret:
          (json.valueEnsureAsList<dynamic>(
                'ret',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronTransactionResult,
                  Map<String, dynamic>
                >(value: e, parse: (v) => TronTransactionResult.fromJson(v)),
              )
              .toList(),
    );
  }

  factory TronTransaction.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransaction(
      rawData: decode.messageTo<TronTransactionraw>(
        1,
        (b) => TronTransactionraw.deserialize(b),
      ),
      signature: decode.getListOfBytes(2),
      ret:
          decode
              .getListOfBytes(5)
              .map((b) => TronTransactionResult.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransaction;

  int get length => toBuffer().length;
}

class TronTransactionContract extends TronProtoMessage {
  final ITronContract? parameter;

  TronTransactionContractContractType? get type => parameter?.contractType;

  final BuBytes? provider;

  final BuBytes? contractName;

  final int? permissionId;

  TronTransactionContract({
    required this.parameter,
    List<int>? provider,
    List<int>? contractName,
    this.permissionId,
  }) : provider = provider?.asImmutableBytes,
       contractName = contractName?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.int32(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    type,
    parameter?.toAny(),
    provider,
    contractName,
    permissionId,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    final p = this.parameter;
    Map<String, dynamic>? parameter;
    if (p != null) {
      if (config.encoding == TronJsonEncoding.tron) {
        final typeUrl = p.typeUrl();
        parameter = {"type_url": typeUrl, "value": p.toJson(config: config)};
      } else {
        parameter = config.encodeMessage(p.toAnyJson(config: config));
      }
    }
    return {
      'type': type?.protoName,
      'parameter': parameter,
      'provider': config.encodeBinary(provider),
      'ContractName': config.encodeBinary(contractName),
      'Permission_id': permissionId,
    }.notNullValue;
  }

  factory TronTransactionContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    final TronTransactionContractContractType type = json
        .valueTo<TronTransactionContractContractType, Object?>(
          key: 'type',
          onMissing:
              () => TronTransactionContractContractType.accountCreateContract,
          parse: (v) => TronTransactionContractContractType.from(v),
          normalizeKeyLookup: config.normalizeKeys,
        );
    return TronTransactionContract(
      parameter: json.valueTo<ITronContract?, Map<String, dynamic>>(
        key: 'parameter',
        normalizeKeyLookup: config.normalizeKeys,
        parse: (v) {
          final decode = ProtoGoogleAny.fromJson(v, config: config);
          final value = decode.value;
          final bool isBinary = decode.isBinary;
          final parts = decode.typeUrl.split('type.googleapis.com/protocol.');
          if (parts.length != 2) {
            throw BuError(
              DefaultErrorType.invalidArgument,
              'Invalid contract type URL: ${decode.typeUrl}.',
            );
          }
          final contractType = TronTransactionContractContractType.from(
            parts.last,
          );
          ITronContract? contract;
          if (isBinary) {
            contract = ITronContract.deserializeBytes(
              contractType: contractType,
              contractBytes: JsonParser.valueAsBytes(value),
            );
          }
          if (contract == null) {
            final Map<String, dynamic> contractJson =
                JsonParser.valueEnsureAsMap<String, dynamic>(v);
            if (contractJson.hasValue("value")) {
              contract = ITronContract.deserializeJson(
                contractType: contractType,
                json: contractJson.valueEnsureAsMap("value"),
              );
            } else {
              contract = ITronContract.deserializeJson(
                contractType: contractType,
                json: contractJson,
              );
            }
          }
          if (contract.contractType != type) {
            throw BuError(
              DefaultErrorType.invalidArgument,
              'Invalid contract type: expected $type, got ${contract.contractType}.',
            );
          }
          return contract;
        },
      ),
      provider: config.decodeBinary<List<int>?>(
        json.valueAs('provider', normalizeKeyLookup: config.normalizeKeys),
      ),
      contractName: config.decodeBinary<List<int>?>(
        json.valueAs('ContractName', normalizeKeyLookup: config.normalizeKeys),
      ),
      permissionId: json.valueAsInt<int?>(
        "Permission_id",
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransactionContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    final type = decode.getEnum<TronTransactionContractContractType>(
      1,
      TronTransactionContractContractType.values,
    );
    return TronTransactionContract(
      parameter: decode.messageTo<ITronContract>(2, (b) {
        final message = ProtoGoogleAny.deserialize(b);
        final value = message.value;
        final parts = message.typeUrl.split('type.googleapis.com/protocol.');
        if (parts.length != 2 || value == null) {
          throw BuError(
            DefaultErrorType.invalidArgument,
            'Invalid contract type URL: ${message.typeUrl}.',
          );
        }
        final contractType = TronTransactionContractContractType.from(
          parts.last,
        );
        final contract = ITronContract.deserializeBytes(
          contractType: contractType,
          contractBytes: JsonParser.valueAsBytes(value),
        );
        if (contract.contractType != type) {
          throw BuError(
            DefaultErrorType.invalidArgument,
            'Invalid contract type: expected $type, got ${contract.contractType}.',
          );
        }
        return contract;
      }),
      provider: decode.getBytes<List<int>?>(3),
      contractName: decode.getBytes<List<int>?>(4),
      permissionId: decode.getInt<int?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionContract;
}

class TronTransactionraw extends TronProtoMessage {
  final BuBytes? refBlockBytes;

  final BigInt? refBlockNum;

  final BuBytes? refBlockHash;

  final BigInt? expiration;

  final List<TronAuthority> auths;

  /// Unused transaction memo data.
  final BuBytes? data;

  /// Only single-contract transactions are currently supported; the repeated
  /// field exists for extension.
  final List<TronTransactionContract> contract;

  /// Unused scripts field.
  final BuBytes? scripts;

  final BigInt? timestamp;

  final BigInt? feeLimit;

  TronTransactionraw({
    List<int>? refBlockBytes,
    this.refBlockNum,
    List<int>? refBlockHash,
    this.expiration,
    this.auths = const [],
    List<int>? data,
    this.contract = const [],
    List<int>? scripts,
    this.timestamp,
    this.feeLimit,
  }) : refBlockBytes = refBlockBytes?.asImmutableBytes,
       refBlockHash = refBlockHash?.asImmutableBytes,
       data = data?.asImmutableBytes,
       scripts = scripts?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.repeated(
          fieldNumber: 9,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(10),
        ProtoFieldConfig.repeated(
          fieldNumber: 11,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(12),
        ProtoFieldConfig.int64(14),
        ProtoFieldConfig.int64(18),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    refBlockBytes,
    refBlockNum,
    refBlockHash,
    expiration,
    auths,
    data,
    contract,
    scripts,
    timestamp,
    feeLimit,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ref_block_bytes': config.encodeBinary(refBlockBytes),
      'ref_block_num': config.encodeBigint(refBlockNum),
      'ref_block_hash': config.encodeBinary(refBlockHash),
      'expiration': config.encodeBigint(expiration),
      'auths': auths.map((e) => config.encodeMessage(e)).toList(),
      'data': config.encodeBinary(data),
      'contract': contract.map((e) => config.encodeMessage(e)).toList(),
      'scripts': config.encodeBinary(scripts),
      'timestamp': config.encodeBigint(timestamp),
      'fee_limit': config.encodeBigint(feeLimit),
    }.notNullValue;
  }

  factory TronTransactionraw.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionraw(
      refBlockBytes: config.decodeBinary<List<int>?>(
        json.valueAs(
          'ref_block_bytes',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      refBlockNum: json.valueAsBigInt<BigInt?>(
        'ref_block_num',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      refBlockHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'ref_block_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      expiration: json.valueAsBigInt<BigInt?>(
        'expiration',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      auths:
          (json.valueEnsureAsList<dynamic>(
                'auths',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronAuthority, Map<String, dynamic>>(
                  value: e,
                  parse: (v) => TronAuthority.fromJson(v),
                ),
              )
              .toList(),
      data: config.decodeBinary<List<int>?>(
        json.valueAs('data', normalizeKeyLookup: config.normalizeKeys),
      ),
      contract:
          (json.valueEnsureAsList<dynamic>(
                'contract',
                normalizeKeyLookup: config.normalizeKeys,
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronTransactionContract,
                  Map<String, dynamic>
                >(value: e, parse: (v) => TronTransactionContract.fromJson(v)),
              )
              .toList(),
      scripts: config.decodeBinary<List<int>?>(
        json.valueAs('scripts', normalizeKeyLookup: config.normalizeKeys),
      ),
      timestamp: json.valueAsBigInt<BigInt?>('timestamp'),
      feeLimit: json.valueAsBigInt<BigInt?>(
        'fee_limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransactionraw.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionraw(
      refBlockBytes: decode.getBytes<List<int>?>(1),
      refBlockNum: decode.getBigInt<BigInt?>(3),
      refBlockHash: decode.getBytes<List<int>?>(4),
      expiration: decode.getBigInt<BigInt?>(8),
      auths:
          decode
              .getListOfBytes(9)
              .map((b) => TronAuthority.deserialize(b))
              .toList(),
      data: decode.getBytes<List<int>?>(10),
      contract:
          decode
              .getListOfBytes(11)
              .map((b) => TronTransactionContract.deserialize(b))
              .toList(),
      scripts: decode.getBytes<List<int>?>(12),
      timestamp: decode.getBigInt<BigInt?>(14),
      feeLimit: decode.getBigInt<BigInt?>(18),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionRaw;

  /// Transaction ID (SHA-256 of the raw data).
  late final String txID = BytesUtils.toHexString(
    QuickCrypto.sha256Hash(toBuffer()),
  );

  /// Length of the encoded transaction in bytes.
  late final int length = toBuffer().length;

  TronAddress get ownerAddress {
    return getContract().ownerAddress;
  }

  T getContract<T extends ITronContract>() {
    final contract = this.contract.elementAtOrNull(0)?.parameter;
    if (contract == null) {
      throw const BuError(
        OnChainErrorType.tronPlugin,
        'Transaction contains no contract (getContract).',
      );
    }
    return contract.cast();
  }

  int? permissionId() {
    if (contract.isEmpty) {
      throw const BuError(
        OnChainErrorType.tronPlugin,
        'Transaction contains no contract (permissionId).',
      );
    }
    return contract[0].permissionId;
  }

  TronTransactionContractContractType get type {
    return getContract().contractType;
  }

  TronTransactionraw copyWith({
    List<int>? refBlockBytes,
    BigInt? refBlockNum,
    List<int>? refBlockHash,
    BigInt? expiration,
    List<TronAuthority>? auths,
    List<int>? data,
    List<TronTransactionContract>? contract,
    List<int>? scripts,
    BigInt? timestamp,
    BigInt? feeLimit,
  }) {
    return TronTransactionraw(
      refBlockBytes: refBlockBytes ?? this.refBlockBytes,
      refBlockNum: refBlockNum ?? this.refBlockNum,
      refBlockHash: refBlockHash ?? this.refBlockHash,
      expiration: expiration ?? this.expiration,
      auths: auths ?? this.auths,
      data: data ?? this.data,
      contract: contract ?? this.contract,
      scripts: scripts ?? this.scripts,
      timestamp: timestamp ?? this.timestamp,
      feeLimit: feeLimit ?? this.feeLimit,
    );
  }
}

import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/exception/exception.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/account/authority.dart';
import 'package:on_chain/tron/src/models/contract/transaction/transaction_contract.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

class TransactionRaw extends TronProtocolBufferImpl {
  /// Create a new [TransactionRaw] instance by parsing a JSON map.
  factory TransactionRaw.fromJson(Map<String, dynamic> json) {
    final contractList = OnChainUtils.parseList(
            value: json["contract"], name: "contract", throwOnNull: true)!
        .map((e) => TransactionContract.fromJson(OnChainUtils.parseMap(
            value: e, name: "contract", throwOnNull: true)!))
        .toList();
    if (contractList.length != 1) {
      throw const TronPluginException(
          "Transaction must contain exactly one contract.");
    }

    return TransactionRaw(
      contract: contractList,
      refBlockBytes: OnChainUtils.parseHex(
          value: json['ref_block_bytes'], name: "ref_block_bytes"),
      refBlockHash: OnChainUtils.parseHex(
          value: json['ref_block_hash'], name: "ref_block_hash"),
      expiration: OnChainUtils.parseBigInt(
          value: json['expiration'], name: "expiration"),
      timestamp:
          OnChainUtils.parseBigInt(value: json['timestamp'], name: "timestamp"),
      data: OnChainUtils.parseBytes(value: json["data"], name: "data"),
      feeLimit:
          OnChainUtils.parseBigInt(value: json["fee_limit"], name: "fee_limit"),
      refBlockNum: OnChainUtils.parseBigInt(
          value: json["ref_block_num"], name: "ref_block_num"),
      scripts: OnChainUtils.parseHex(value: json["scripts"], name: "scripts"),
      auths: OnChainUtils.parseList(value: json["auths"], name: "auths")
          ?.map((e) => Authority.fromJson(OnChainUtils.parseMap(
              value: e, name: "auths", throwOnNull: true)!))
          .toList(),
    );
  }
  factory TransactionRaw.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    final contracts = decode
        .getFields<List<int>>(11)
        .map((e) => TransactionContract.deserialize(e))
        .toList();
    if (contracts.length != 1) {
      throw const TronPluginException(
          "Transaction must contain exactly one contract.");
    }
    return TransactionRaw(
        refBlockBytes: decode.getField(1),
        refBlockNum: decode.getField(3),
        refBlockHash: decode.getField(4),
        expiration: decode.getField(8),
        auths: decode
            .getFields<List<int>>(9)
            .map((e) => Authority.deserialize(e))
            .toList(),
        data: decode.getField(10),
        contract: contracts,
        scripts: decode.getField(12),
        timestamp: decode.getField(14),
        feeLimit: decode.getField(18));
  }

  /// Create a new [TransactionRaw] instance with specified parameters.
  TransactionRaw(
      {required List<int> refBlockBytes,
      this.refBlockNum,
      required List<int> refBlockHash,
      required this.expiration,
      List<Authority>? auths,
      List<int>? data,
      required List<TransactionContract> contract,
      List<int>? scripts,
      required this.timestamp,
      this.feeLimit})
      : refBlockBytes = BytesUtils.toBytes(refBlockBytes, unmodifiable: true),
        refBlockHash = BytesUtils.toBytes(refBlockHash, unmodifiable: true),
        data = BytesUtils.tryToBytes(data, unmodifiable: true),
        scripts = BytesUtils.tryToBytes(scripts, unmodifiable: true),
        auths = auths == null ? null : List<Authority>.unmodifiable(auths),
        contract = List<TransactionContract>.unmodifiable(contract);

  /// The reference block bytes of the transaction.
  final List<int> refBlockBytes;

  /// The reference block number of the transaction.
  final BigInt? refBlockNum;

  /// The reference block hash of the transaction.
  final List<int> refBlockHash;

  /// The expiration time of the transaction.
  final BigInt expiration;

  /// List of authorities authorizing the transaction.
  final List<Authority>? auths;

  /// Additional data associated with the transaction.
  final List<int>? data;

  /// List of contracts included in the transaction.
  final List<TransactionContract> contract;

  /// List of scripts associated with the transaction.
  final List<int>? scripts;

  /// The timestamp when the transaction is created.
  final BigInt timestamp;

  /// The maximum fee limit for the transaction.
  final BigInt? feeLimit;

  /// Convert the [TransactionRaw] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "ref_block_bytes": BytesUtils.toHexString(refBlockBytes),
      "ref_block_num": refBlockNum?.toString(),
      "ref_block_hash": BytesUtils.toHexString(refBlockHash),
      "expiration": expiration.toString(),
      "auths": auths?.map((auth) => auth.toJson()).toList(),
      "data": StringUtils.tryDecode(data),
      "contract": contract.map((c) => c.toJson()).toList(),
      "scripts": BytesUtils.tryToHexString(scripts),
      "timestamp": timestamp.toString(),
      "fee_limit": feeLimit?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  TransactionRaw copyWith({
    List<int>? refBlockBytes,
    BigInt? refBlockNum,
    List<int>? refBlockHash,
    BigInt? expiration,
    List<Authority>? auths,
    List<int>? data,
    List<TransactionContract>? contract,
    List<int>? scripts,
    BigInt? timestamp,
    BigInt? feeLimit,
  }) {
    return TransactionRaw(
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

  @override
  List<int> get fieldIds => [1, 3, 4, 8, 9, 10, 11, 12, 14, 18];

  @override
  List get values => [
        refBlockBytes,
        refBlockNum,
        refBlockHash,
        expiration,
        auths,
        data,
        contract,
        scripts,
        timestamp,
        feeLimit
      ];

  /// transaction ID
  late final String txID =
      BytesUtils.toHexString(QuickCrypto.sha256Hash(toBuffer()));

  /// bytes length of encoded transaction
  late final int length = toBuffer().length;

  TronAddress get ownerAddress {
    if (contract.isEmpty) {
      throw const TronPluginException("Transaction contains no contract.");
    }
    return contract[0].parameter.value.ownerAddress;
  }

  T getContract<T extends TronBaseContract>() {
    if (contract.isEmpty) {
      throw const TronPluginException("Transaction contains no contract.");
    }
    return contract[0].parameter.value.cast();
  }

  int? permissionId() {
    if (contract.isEmpty) {
      throw const TronPluginException("Transaction contains no contract.");
    }
    return contract[0].permissionId;
  }

  TransactionContractType get type {
    if (contract.isEmpty) {
      throw const TronPluginException("Transaction contains no contract.");
    }
    return contract[0].type;
  }

  /// Convert the [TransactionRaw] object to its string representation.
  @override
  String toString() {
    return "TransactionRaw{${toJson()}}";
  }
}

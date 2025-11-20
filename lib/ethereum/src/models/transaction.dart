import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/models/autorization.dart';
import 'package:on_chain/ethereum/src/models/models.dart';
import 'package:on_chain/ethereum/src/transaction/eth_transaction.dart';
import 'package:on_chain/utils/utils/number_utils.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Represents information about an Ethereum transaction.
class TransactionInfo {
  /// The list of access list entries for the transaction.
  final List<AccessEntry>? accessList;

  final List<String>? blobVersionedHashes;
  final List<AuthorizationEntry>? authorizationList;

  final BigInt? maxFeePerBlobGas;

  /// The hash of the block where the transaction was included.
  final String blockHash;

  /// The block number where the transaction was included.
  final int blockNumber;

  /// The chain ID of the blockchain.
  final BigInt? chainId;

  /// The sender's address.
  final String from;

  /// The gas limit for the transaction.
  final int gas;

  /// The gas price for the transaction.
  final int? gasPrice;

  /// The transaction hash.
  final String hash;

  /// The transaction input data.
  final String input;

  /// The maximum fee per gas unit that the sender is willing to pay.
  final int? maxFeePerGas;

  /// The maximum priority fee per gas unit that the sender is willing to pay.
  final int? maxPriorityFeePerGas;

  /// The transaction nonce.
  final int nonce;

  /// The ECDSA signature component 'r'.
  final String? r;

  /// The ECDSA signature component 's'.
  final String? s;

  ETHSignature toSignature() {
    final v = this.v >= 27
        ? this.v
        : ETHTransactionUtils.parityToV(yParity ?? this.v);
    return ETHSignature(
        PluginBigintUtils.hexToBigint(r),
        PluginBigintUtils.hexToBigint(s),
        ETHSignatureUtils.getSignatureV(yParity ?? v));
  }

  ETHTransaction? toTransaction() {
    if (ETHTransactionType.values.any((e) => e.prefix == type)) {
      final type = ETHTransactionType.fromPrefix(this.type);
      return ETHTransaction(
          chainId: chainId ?? BigInt.zero,
          data: BytesUtils.fromHexString(input),
          gasLimit: BigInt.from(gas),
          nonce: nonce,
          value: value,
          accessList: accessList,
          authorizationList: authorizationList,
          blobVersionedHashes: blobVersionedHashes
              ?.map((e) => BytesUtils.fromHexString(e))
              .toList(),
          maxFeePerBlobGas: maxFeePerBlobGas,
          signature: toSignature(),
          from: ETHAddress(from),
          gasPrice: type == ETHTransactionType.eip2930 ||
                  type == ETHTransactionType.legacy
              ? (gasPrice == null ? null : BigInt.from(gasPrice!))
              : null,
          maxFeePerGas:
              maxFeePerGas == null ? null : BigInt.from(maxFeePerGas!),
          maxPriorityFeePerGas: maxPriorityFeePerGas == null
              ? null
              : BigInt.from(maxPriorityFeePerGas!),
          to: to == null ? null : ETHAddress(to!),
          type: type);
    }
    return null;
  }

  /// The recipient's address, if applicable.
  final String? to;

  /// The index of the transaction within the block.
  final int transactionIndex;

  /// The transaction type.
  final int type;

  /// The ECDSA signature component 'v'.
  final int v;

  /// The value sent with the transaction.
  final BigInt value;

  /// Parity of the 'y' coordinate of the sender's public key.
  final int? yParity;

  final int? l1BatchNumber;

  final int? l1BatchTxIndex;

  /// Creates a new instance of the [TransactionInfo] class.
  const TransactionInfo(
      {required this.accessList,
      required this.blockHash,
      required this.blockNumber,
      required this.chainId,
      required this.from,
      required this.gas,
      required this.gasPrice,
      required this.hash,
      required this.input,
      required this.maxFeePerGas,
      required this.maxPriorityFeePerGas,
      required this.nonce,
      required this.r,
      required this.s,
      required this.to,
      required this.transactionIndex,
      required this.type,
      required this.v,
      required this.value,
      required this.yParity,
      this.l1BatchNumber,
      this.l1BatchTxIndex,
      this.authorizationList,
      this.blobVersionedHashes,
      this.maxFeePerBlobGas});

  /// Creates a [TransactionInfo] instance from a JSON map.
  factory TransactionInfo.fromJson(Map<String, dynamic> json) {
    return TransactionInfo(
        accessList: (json['accessList'] as List?)
            ?.map((e) => AccessEntry.fromJson(e))
            .toList(),
        blockHash: json.valueAs("blockHash"),
        blockNumber: PluginIntUtils.hexToInt(json['blockNumber']),
        chainId: PluginBigintUtils.tryHexToBigint(json['chainId']),
        from: json.valueAs("from"),
        gas: PluginIntUtils.hexToInt(json['gas']),
        gasPrice: PluginIntUtils.tryHexToInt(json['gasPrice']),
        hash: json.valueAs("hash"),
        input: json.valueAs("input"),
        maxFeePerGas: PluginIntUtils.tryHexToInt(json['maxFeePerGas']),
        maxPriorityFeePerGas:
            PluginIntUtils.tryHexToInt(json['maxPriorityFeePerGas']),
        nonce: PluginIntUtils.hexToInt(json['nonce']),
        r: json.valueAs("r"),
        s: json.valueAs("s"),
        to: json.valueAs("to"),
        transactionIndex: PluginIntUtils.hexToInt(json['transactionIndex']),
        type: PluginIntUtils.hexToInt(json['type']),
        v: PluginIntUtils.hexToInt(json['v']),
        value: PluginBigintUtils.hexToBigint(json['value']),
        yParity: PluginIntUtils.tryHexToInt(json['yParity']),
        maxFeePerBlobGas:
            PluginBigintUtils.tryHexToBigint(json['maxFeePerBlobGas']),
        blobVersionedHashes: json.valueAsList("blobVersionedHashes"),
        l1BatchNumber: PluginIntUtils.tryHexToInt(json['l1BatchNumber']),
        l1BatchTxIndex: PluginIntUtils.tryHexToInt(json['l1BatchTxIndex']),
        authorizationList: json
            .valueAsList<List?>("authorizationList")
            ?.map((e) => AuthorizationEntry.fromJson(e))
            .toList());
  }

  // Convert the object to a JSON map, with numeric values in hexadecimal format
  Map<String, dynamic> toJson() {
    return {
      'accessList': accessList?.map((e) => e.toJson()).toList(),
      'authorizationList': authorizationList?.map((e) => e.toJson()).toList(),
      'blobVersionedHashes': blobVersionedHashes,
      'maxFeePerBlobGas': maxFeePerBlobGas != null
          ? '0x${maxFeePerBlobGas!.toRadixString(16)}'
          : null,
      'blockHash': blockHash,
      'blockNumber': '0x${blockNumber.toRadixString(16)}',
      'chainId': chainId != null ? '0x${chainId!.toRadixString(16)}' : null,
      'from': from,
      'gas': '0x${gas.toRadixString(16)}',
      'gasPrice': gasPrice != null ? '0x${gasPrice!.toRadixString(16)}' : null,
      'hash': hash,
      'input': input,
      'maxFeePerGas':
          maxFeePerGas != null ? '0x${maxFeePerGas!.toRadixString(16)}' : null,
      'maxPriorityFeePerGas': maxPriorityFeePerGas != null
          ? '0x${maxPriorityFeePerGas!.toRadixString(16)}'
          : null,
      'nonce': '0x${nonce.toRadixString(16)}',
      'r': r,
      's': r,
      'to': to,
      'transactionIndex': '0x${transactionIndex.toRadixString(16)}',
      'type': '0x${type.toRadixString(16)}',
      'v': '0x${v.toRadixString(16)}',
      'value': '0x${value.toRadixString(16)}',
      'yParity': yParity != null ? '0x${yParity!.toRadixString(16)}' : null,
      'l1BatchNumber': l1BatchNumber != null
          ? '0x${l1BatchNumber!.toRadixString(16)}'
          : null,
      'l1BatchTxIndex': l1BatchTxIndex != null
          ? '0x${l1BatchTxIndex!.toRadixString(16)}'
          : null,
    }.notNullValue;
  }

  /// Returns a string representation of the [TransactionInfo] object.
  @override
  String toString() {
    return '''
      TransactionInfo${toJson()}
    ''';
  }
}

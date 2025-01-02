import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/models/models.dart';
import 'package:on_chain/ethereum/src/transaction/eth_transaction.dart';
import 'package:on_chain/utils/utils/number_utils.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Represents information about an Ethereum transaction.
class TransactionInfo {
  /// The list of access list entries for the transaction.
  final List<AccessListEntry> accessList;

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
  final String r;

  /// The ECDSA signature component 's'.
  final String s;

  ETHSignature toSignature() {
    final sigBytes = [
      ...BytesUtils.fromHexString(r),
      ...BytesUtils.fromHexString(s)
    ];
    return ETHSignature.fromBytes(sigBytes);
  }

  ETHTransaction toTransaction() {
    return ETHTransaction(
        chainId: chainId ?? BigInt.zero,
        data: BytesUtils.fromHexString(input),
        gasLimit: BigInt.from(gas),
        nonce: nonce,
        value: value,
        accessList: accessList,
        from: ETHAddress(from),
        gasPrice: gasPrice == null ? null : BigInt.from(gasPrice!),
        maxFeePerGas: maxFeePerGas == null ? null : BigInt.from(maxFeePerGas!),
        maxPriorityFeePerGas: maxPriorityFeePerGas == null
            ? null
            : BigInt.from(maxPriorityFeePerGas!),
        // signature: toSignature(),
        to: to == null ? null : ETHAddress(to!),
        type: ETHTransactionType.fromPrefix(type));
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

  /// Creates a new instance of the [TransactionInfo] class.
  const TransactionInfo({
    required this.accessList,
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
  });

  /// Creates a [TransactionInfo] instance from a JSON map.
  factory TransactionInfo.fromJson(Map<String, dynamic> json) {
    return TransactionInfo(
      accessList: (json['accessList'] as List?)
              ?.map((e) => AccessListEntry.fromJson(e))
              .toList() ??
          <AccessListEntry>[],
      blockHash: json['blockHash'],
      blockNumber: PluginIntUtils.hexToInt(json['blockNumber']),
      chainId: PluginBigintUtils.tryHexToBigint(json['chainId']),
      from: json['from'],
      gas: PluginIntUtils.hexToInt(json['gas']),
      gasPrice: PluginIntUtils.tryHexToInt(json['gasPrice']),
      hash: json['hash'],
      input: json['input'],
      maxFeePerGas: PluginIntUtils.tryHexToInt(json['maxFeePerGas']),
      maxPriorityFeePerGas: PluginIntUtils.tryHexToInt(json['maxFeePerGas']),
      nonce: PluginIntUtils.hexToInt(json['nonce']),
      r: json['r'],
      s: json['s'],
      to: json['to'],
      transactionIndex: PluginIntUtils.hexToInt(json['transactionIndex']),
      type: PluginIntUtils.hexToInt(json['type']),
      v: PluginIntUtils.hexToInt(json['v']),
      value: PluginBigintUtils.hexToBigint(json['value']),
      yParity: PluginIntUtils.tryHexToInt(json['yParity']),
    );
  }

  /// Returns a string representation of the [TransactionInfo] object.
  @override
  String toString() {
    return '''
      TransactionInfo {
        accessList: $accessList,
        blockHash: $blockHash,
        blockNumber: $blockNumber,
        chainId: $chainId,
        from: $from,
        gas: $gas,
        gasPrice: $gasPrice,
        hash: $hash,
        input: $input,
        maxFeePerGas: $maxFeePerGas,
        value: $value,
        maxPriorityFeePerGas: $maxPriorityFeePerGas,
        nonce: $nonce,
        to: $to,
        transactionIndex: $transactionIndex,
        type: $type,
        r: $r,
        s: $s,
        v: $v,
        yParity: $yParity,
      }
    ''';
  }
}

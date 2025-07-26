import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/ethereum/src/rlp/decode.dart';
import 'package:on_chain/ethereum/src/rlp/encode.dart';
import 'package:on_chain/ethereum/src/models/access_list.dart';
import 'package:on_chain/utils/utils/number_utils.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Represents the type of an Ethereum transaction.
class ETHTransactionType {
  const ETHTransactionType._(this.name, this.prefix);

  /// The name of the transaction type.
  final String name;

  /// The prefix associated with the transaction type.
  final int prefix;

  /// Represents a legacy Ethereum transaction.
  static const ETHTransactionType legacy = ETHTransactionType._('Legacy', 0);

  /// Represents an EIP-2930 Ethereum transaction (Berlin hard fork).
  static const ETHTransactionType eip2930 =
      ETHTransactionType._('Berlin', 0x01);

  /// Represents an EIP-1559 Ethereum transaction (London hard fork).
  static const ETHTransactionType eip1559 =
      ETHTransactionType._('London', 0x02);

  @override
  String toString() {
    return '0x${prefix.toRadixString(16)}';
  }

  /// A list of all supported Ethereum transaction types.
  static const List<ETHTransactionType> values = [legacy, eip1559, eip2930];

  /// Returns the [ETHTransactionType] corresponding to the given prefix.
  static ETHTransactionType fromPrefix(int prefix) {
    return values.firstWhere((element) => element.prefix == prefix);
  }
}

/// Utility class for Ethereum transaction-related operations.
class _ETHTransactionUtils {
  /// Converts a [BigInt] to a byte list with a maximum length of 32 bytes.
  static List<int> bigintToBytes(BigInt value) {
    final toBytes =
        BigintUtils.toBytes(value, length: BigintUtils.bitlengthInBytes(value));
    assert(toBytes.length <= 32, 'value too large');
    return toBytes;
  }

  /// Converts an integer to a byte list with a maximum length of 32 bytes.
  /// Returns an empty list if the value is 0.
  static List<int> intToBytes(int value) {
    if (value == 0) return [];
    final toBytes =
        IntUtils.toBytes(value, length: IntUtils.bitlengthInBytes(value));
    assert(toBytes.length <= 32, 'value too large');
    return toBytes;
  }

  /// Parses the legacy chain ID from a given integer [v].
  static BigInt parseLegacyChainId(int v) {
    return (BigInt.from(v) - BigInt.from(35)) ~/ BigInt.two;
  }

  static List<int> trimLeadingZero(List<int> bytes) {
    List<int> data = bytes;
    while (data.isNotEmpty) {
      if (data[0] != 0) break;
      data = data.sublist(1);
    }
    return data;
  }

  static List<int> leadingZero32Bytes(List<int> bytes) {
    if (bytes.length >= 32) return bytes;
    final data = List.filled(32, 0);
    data.setAll(32 - bytes.length, bytes);
    return data;
  }

  /// Returns the parity for a given integer [v].
  /// Returns 0 if [v] is 27, otherwise returns 1.
  static int parity(int v) => (v == 27) ? 0 : 1;

  /// Gets the legacy chain ID based on the input values [v] and [chainId].
  static BigInt getLegacyChainId(int v, BigInt chainId) {
    return (chainId * BigInt.two) + BigInt.from(35 + v - 27);
  }

  /// Creates an [ETHTransaction] instance from a legacy encoded transaction.
  ///
  /// The method takes a decoded list [decode] and extracts the necessary
  /// components such as nonce, gas price, gas limit, recipient address (to),
  /// value, data, signature, and chain ID.
  ///
  /// Returns an [ETHTransaction] object representing the legacy transaction.
  static ETHTransaction _fromLegacy(List<dynamic> decode) {
    final int nonce = IntUtils.fromBytes(decode[0]);
    final BigInt gasPrice = BigintUtils.fromBytes(decode[1]);
    final BigInt gasLimit = BigintUtils.fromBytes(decode[2]);
    final ETHAddress? to =
        (decode[3] as List).isEmpty ? null : ETHAddress.fromBytes(decode[3]);
    final value = BigintUtils.fromBytes(decode[4]);
    final data = List<int>.from(decode[5]);
    ETHSignature? sig;
    BigInt chainId = BigInt.zero;
    if (decode.length > 6) {
      final List<int> rBytes =
          _ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[7]));
      final List<int> sBytes =
          _ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[8]));
      final v = IntUtils.fromBytes(decode[6]);
      if (rBytes.isEmpty && sBytes.isEmpty) {
        chainId = BigInt.from(v);
      } else {
        chainId = parseLegacyChainId(v);
        if (chainId.isNegative) chainId = BigInt.zero;
        sig = ETHSignature.fromBytes([...rBytes, ...sBytes, ...decode[6]]);
      }
    }
    return ETHTransaction._(
        nonce: nonce,
        gasLimit: gasLimit,
        gasPrice: gasPrice,
        to: to,
        value: value,
        chainId: chainId,
        signature: sig,
        data: data,
        type: ETHTransactionType.legacy);
  }

  /// Converts the decoded data to an EIP-2930 transaction.
  static ETHTransaction _fromEIP2930(List<dynamic> decode) {
    final BigInt chainId = BigintUtils.fromBytes(decode[0]);
    final int nonce = IntUtils.fromBytes(decode[1]);
    final BigInt gasPrice = BigintUtils.fromBytes(decode[2]);
    final BigInt gasLimit = BigintUtils.fromBytes(decode[3]);
    final ETHAddress? to =
        (decode[4] as List).isEmpty ? null : ETHAddress.fromBytes(decode[4]);
    final value = BigintUtils.fromBytes(decode[5]);
    final data = List<int>.from(decode[6]);
    final accessList = (decode[7] as List)
        .map((e) => AccessListEntry.fromSerialized(e))
        .toList();
    ETHSignature? sig;
    if (decode.length > 8) {
      final List<int> rBytes =
          _ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[9]));
      final List<int> sBytes =
          _ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[10]));
      final sigBytes = List<int>.from([...rBytes, ...sBytes, ...decode[8]]);
      sig = ETHSignature.fromBytes(sigBytes);
    }
    return ETHTransaction._(
      nonce: nonce,
      gasLimit: gasLimit,
      accessList: accessList,
      gasPrice: gasPrice,
      type: ETHTransactionType.eip2930,
      to: to,
      value: value,
      chainId: chainId,
      signature: sig,
      data: data,
    );
  }

  /// Converts the decoded data to an EIP-1559 transaction.
  static ETHTransaction _fromEIP1559(List<dynamic> decode) {
    final BigInt chainId = BigintUtils.fromBytes(decode[0]);
    final int nonce = IntUtils.fromBytes(decode[1]);
    final BigInt maxPriorityFeePerGas = BigintUtils.fromBytes(decode[2]);
    final BigInt maxFeePerGas = BigintUtils.fromBytes(decode[3]);
    final BigInt gasLimit = BigintUtils.fromBytes(decode[4]);
    final ETHAddress? to =
        (decode[5] as List).isEmpty ? null : ETHAddress.fromBytes(decode[5]);
    final value = BigintUtils.fromBytes(decode[6]);
    final data = List<int>.from(decode[7]);
    final accessList = (decode[8] as List)
        .map((e) => AccessListEntry.fromSerialized(e))
        .toList();
    ETHSignature? sig;
    if (decode.length > 9) {
      final List<int> rBytes =
          _ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[10]));
      final List<int> sBytes =
          _ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[11]));
      final sigBytes = List<int>.from([...rBytes, ...sBytes, ...decode[9]]);
      sig = ETHSignature.fromBytes(sigBytes);
    }
    return ETHTransaction._(
      nonce: nonce,
      gasLimit: gasLimit,
      accessList: accessList,
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
      type: ETHTransactionType.eip1559,
      to: to,
      value: value,
      chainId: chainId,
      signature: sig,
      data: data,
    );
  }
}

/// Represents an Ethereum transaction with EIP-1559 support.
class ETHTransaction {
  /// The type of the transaction (legacy, EIP-1559, EIP-2930).
  final ETHTransactionType? type;

  /// The recipient's address.
  final ETHAddress? to;

  /// The sender's address.
  final ETHAddress? from;

  /// The transaction nonce.
  final int nonce;

  /// The maximum amount of gas that can be used in the transaction.
  final BigInt gasLimit;

  /// The gas price for the transaction (applicable to legacy transactions).
  final BigInt? gasPrice;

  /// The maximum fee per gas unit that the sender is willing to pay.
  final BigInt? maxPriorityFeePerGas;

  /// The maximum fee that the sender is willing to pay for the entire block.
  final BigInt? maxFeePerGas;

  /// The input data for the transaction.
  final List<int> data;

  /// The amount of Ether to transfer with the transaction.
  final BigInt value;

  /// The chain ID to which the transaction is intended.
  final BigInt chainId;

  /// List of access list entries for EIP-2930 transactions.
  final AccessList? accessList;

  /// The transaction signature.
  final ETHSignature? signature;

  /// Private constructor for creating an ETHTransaction.
  ETHTransaction._({
    required this.nonce,
    required this.gasLimit,
    required this.value,
    required this.chainId,
    List<int>? data,
    this.from,
    this.type,
    this.to,
    this.gasPrice,
    this.maxPriorityFeePerGas,
    this.maxFeePerGas,
    this.signature,
    List<AccessListEntry>? accessList,
  })  : data = (data ?? <int>[]).asImmutableBytes,
        accessList = accessList == null
            ? null
            : List<AccessListEntry>.unmodifiable(accessList);

  /// Factory constructor for creating an ETHTransaction.
  factory ETHTransaction(
          {required int nonce,
          required BigInt gasLimit,
          required List<int> data,
          required BigInt value,
          required BigInt chainId,
          ETHAddress? from,
          ETHAddress? to,
          ETHTransactionType? type,
          AccessList? accessList,
          BigInt? gasPrice,
          BigInt? maxPriorityFeePerGas,
          BigInt? maxFeePerGas,
          ETHSignature? signature}) =>
      ETHTransaction._(
          type: type,
          to: to,
          from: from,
          nonce: nonce,
          gasLimit: gasLimit,
          gasPrice: gasPrice,
          maxPriorityFeePerGas: maxPriorityFeePerGas,
          maxFeePerGas: maxFeePerGas,
          data: data,
          value: value,
          chainId: chainId,
          accessList: accessList,
          signature: signature);

  /// Factory constructor to create an [ETHTransaction] from serialized transaction bytes.
  factory ETHTransaction.fromSerialized(List<int> transactionBytes) {
    if (transactionBytes.isEmpty) {
      throw const ETHPluginException('invalid transaction bytes');
    }
    List<int> bytes = List.from(transactionBytes);
    final int prefix = bytes[0];
    if (prefix == 1 || prefix == 2) {
      bytes = bytes.sublist(1);
    } else {
      if (prefix < 0x7f) {
        throw const ETHPluginException('unsupported transaction type');
      }
    }
    final decode = RLPDecoder.decode(bytes);
    if (prefix == 1) {
      return _ETHTransactionUtils._fromEIP2930(decode);
    } else if (prefix == 2) {
      return _ETHTransactionUtils._fromEIP1559(decode);
    }
    return _ETHTransactionUtils._fromLegacy(decode);
  }

  /// Factory constructor to create an [ETHTransaction] from JSON.
  factory ETHTransaction.fromJson(Map<String, dynamic> json) {
    return ETHTransaction(
        nonce: PluginIntUtils.hexToInt(json['nonce']),
        gasLimit: PluginBigintUtils.hexToBigint(json['gasLimit']),
        data: BytesUtils.tryFromHexString(json['data']) ?? const <int>[],
        value: PluginBigintUtils.hexToBigint(json['value']),
        chainId: PluginBigintUtils.hexToBigint(json['chainId']),
        gasPrice: PluginBigintUtils.tryHexToBigint(json['gasPrice']),
        maxFeePerGas: PluginBigintUtils.tryHexToBigint(json['maxFeePerGas']),
        maxPriorityFeePerGas:
            PluginBigintUtils.tryHexToBigint(json['maxPriorityFeePerGas']),
        from: ETHAddress(json['from']),
        to: json['to'] == null ? null : ETHAddress(json['to']),
        type: json['type'] == null
            ? null
            : ETHTransactionType.fromPrefix(
                PluginIntUtils.hexToInt(json['type'])),
        accessList: (json['accessList'] as List?)
            ?.map((e) => AccessListEntry.fromJson(e))
            .toList(),
        signature: json['signature'] == null
            ? null
            : ETHSignature(BigInt.parse(json['signature']['r']),
                BigInt.parse(json['signature']['s']), json['signature']['v']));
  }

  /// Creates a copy of the [ETHTransaction] with updated fields.
  ETHTransaction copyWith(
          {ETHTransactionType? type,
          ETHAddress? to,
          ETHAddress? from,
          int? nonce,
          BigInt? gasLimit,
          BigInt? gasPrice,
          BigInt? maxPriorityFeePerGas,
          BigInt? maxFeePerGas,
          List<int>? data,
          BigInt? value,
          BigInt? chainId,
          List<int>? hash,
          List<AccessListEntry>? accessList,
          ETHSignature? signature}) =>
      ETHTransaction._(
          type: type ?? this.type,
          to: to ?? this.to,
          from: from ?? this.from,
          nonce: nonce ?? this.nonce,
          accessList: accessList ?? this.accessList,
          gasLimit: gasLimit ?? this.gasLimit,
          gasPrice: gasPrice ?? this.gasPrice,
          maxPriorityFeePerGas:
              maxPriorityFeePerGas ?? this.maxPriorityFeePerGas,
          maxFeePerGas: maxFeePerGas ?? this.maxFeePerGas,
          data: data ?? this.data,
          value: value ?? this.value,
          chainId: chainId ?? this.chainId,
          signature: signature ?? this.signature);

  /// Converts the [ETHTransaction] to its EIP-1559 serialized form.
  /// If [sig] is provided, includes the signature fields in the serialization.
  List<int> _toEIP1559([ETHSignature? sig]) {
    final List<List<dynamic>> fields = [
      _ETHTransactionUtils.bigintToBytes(chainId),
      _ETHTransactionUtils.intToBytes(nonce),
      _ETHTransactionUtils.bigintToBytes(maxPriorityFeePerGas!),
      _ETHTransactionUtils.bigintToBytes(maxFeePerGas!),
      _ETHTransactionUtils.bigintToBytes(gasLimit),
      to?.toBytes() ?? <int>[],
      _ETHTransactionUtils.bigintToBytes(value),
      data,
      accessList?.map((e) => e.serialize()).toList() ?? <dynamic>[],
    ];
    if (sig != null) {
      fields.add(
          _ETHTransactionUtils.intToBytes(_ETHTransactionUtils.parity(sig.v)));
      fields.add(_ETHTransactionUtils.trimLeadingZero(sig.rBytes));
      fields.add(_ETHTransactionUtils.trimLeadingZero(sig.sBytes));
    }

    return [ETHTransactionType.eip1559.prefix, ...RLPEncoder.encode(fields)];
  }

  /// Converts the [ETHTransaction] to its EIP-2930 serialized form.
  /// If [sig] is provided, includes the signature fields in the serialization.
  List<int> _toEip2930([ETHSignature? sig]) {
    final List<List<dynamic>> fields = [
      _ETHTransactionUtils.bigintToBytes(chainId),
      _ETHTransactionUtils.intToBytes(nonce),
      _ETHTransactionUtils.bigintToBytes(gasPrice!),
      _ETHTransactionUtils.bigintToBytes(gasLimit),
      to?.toBytes() ?? List<int>.empty(),
      _ETHTransactionUtils.bigintToBytes(value),
      data,
      accessList?.map((e) => e.serialize()).toList() ?? <dynamic>[],
    ];
    if (sig != null) {
      fields.add(
          _ETHTransactionUtils.intToBytes(_ETHTransactionUtils.parity(sig.v)));
      fields.add(_ETHTransactionUtils.trimLeadingZero(sig.rBytes));
      fields.add(_ETHTransactionUtils.trimLeadingZero(sig.sBytes));
    }
    return [ETHTransactionType.eip2930.prefix, ...RLPEncoder.encode(fields)];
  }

  /// Converts the [ETHTransaction] to its legacy (pre-EIP-155) serialized form.
  /// If [sig] is provided, includes the signature fields in the serialization.
  List<int> _toLegacy([ETHSignature? sig]) {
    final List<List<int>> fields = [
      _ETHTransactionUtils.intToBytes(nonce),
      _ETHTransactionUtils.bigintToBytes(gasPrice!),
      _ETHTransactionUtils.bigintToBytes(gasLimit),
      to?.toBytes() ?? List<int>.empty(),
      _ETHTransactionUtils.bigintToBytes(value),
      data
    ];

    // Requesting an unsigned transaction
    if (sig == null) {
      // We have an EIP-155 transaction (chainId was specified and non-zero)
      if (chainId != BigInt.zero) {
        fields.add(BigintUtils.toBytes(chainId,
            length: BigintUtils.bitlengthInBytes(chainId)));
        fields.add(<int>[]);
        fields.add(<int>[]);
      }
      return RLPEncoder.encode(fields);
    }
    BigInt v = BigInt.from(27 + _ETHTransactionUtils.parity(sig.v));
    if (chainId != BigInt.zero) {
      v = _ETHTransactionUtils.getLegacyChainId(sig.v, chainId);
    } else if (BigInt.from(sig.v) != v) {
      throw const ETHPluginException('Mismatch chainID/Signature.V');
    }
    fields.add(BigintUtils.toBytes(v, length: BigintUtils.bitlengthInBytes(v)));
    fields.add(_ETHTransactionUtils.trimLeadingZero(sig.rBytes));
    fields.add(_ETHTransactionUtils.trimLeadingZero(sig.sBytes));
    return RLPEncoder.encode(fields);
  }

  /// Determines the [ETHTransactionType] based on the transaction's properties.
  ETHTransactionType get transactionType {
    final hasGasPrice = gasPrice != null;
    final isEIP1559 = maxFeePerGas != null || maxPriorityFeePerGas != null;
    final hasAccessList = accessList?.isNotEmpty ?? false;

    if (maxFeePerGas != null && maxPriorityFeePerGas != null) {
      if (maxPriorityFeePerGas! > maxFeePerGas!) {
        throw ETHPluginException('priorityFee cannot be more than maxFee',
            details: {
              'priorityFee': maxFeePerGas,
              'maxFee': maxPriorityFeePerGas
            });
      }
    }
    if (type != null) {
      if (type == ETHTransactionType.legacy ||
          type == ETHTransactionType.eip2930) {
        if (gasPrice == null) {
          throw const ETHPluginException(
              'Gas price must not be null for legacy transactions.');
        }
        if (maxFeePerGas != null || maxPriorityFeePerGas != null) {
          throw ETHPluginException(
              'maxFeePerGas and maxPriorityFeePerGas must be null for legacy transactions.',
              details: {
                'maxFeePerGas': maxFeePerGas,
                'maxPriorityFeePerGas': maxPriorityFeePerGas
              });
        }
        if (type == ETHTransactionType.legacy && hasAccessList) {
          throw ETHPluginException(
              'accsesslist must be null or empty for legacy transactions',
              details: {'accessList': accessList});
        }
      } else {
        if (gasPrice != null) {
          throw ETHPluginException(
              'Gas price must be null for EIP1559 transactions.',
              details: {'gasPrice': gasPrice});
        }
        if (maxFeePerGas == null || maxPriorityFeePerGas == null) {
          throw const ETHPluginException(
              'maxFeePerGas and maxPriorityFeePerGas must not be null for EIP1559 transactions.');
        }
      }
    } else {
      if (!hasGasPrice && !isEIP1559) {
        throw const ETHPluginException(
            'use gasPrice for legacy or Eip2930 transaction or priorityFee and maxFee for Eip1559 transactions');
      }
    }

    if (type != null) {
      return type!;
    } else {
      if (isEIP1559) {
        return ETHTransactionType.eip1559;
      } else if (hasGasPrice) {
        if (!hasAccessList) {
          return ETHTransactionType.legacy;
        }
        return ETHTransactionType.eip2930;
      } else {
        return ETHTransactionType.eip1559;
      }
    }
  }

  /// Serializes the transaction based on its type.
  List<int> _serialized([ETHSignature? signature]) {
    switch (transactionType) {
      case ETHTransactionType.legacy:
        return _toLegacy(signature);
      case ETHTransactionType.eip2930:
        return _toEip2930(signature);
      default:
        return _toEIP1559(signature);
    }
  }

  /// Gets the serialized transaction.
  List<int> get serialized => _serialized();

  /// Gets the serialized transaction for signing.
  List<int> signedSerialized([ETHSignature? sig]) {
    sig ??= signature;
    if (sig == null) {
      throw const ETHPluginException(
          'The transaction signed serialized cannot be obtained before the signing process.');
    }
    return _serialized(sig);
  }

  /// Generates the transaction ID using the Keccak256 hash of the serialized transaction.
  String get transactionID {
    return BytesUtils.toHexString(
        QuickCrypto.keccack256Hash(signedSerialized()),
        prefix: '0x');
  }

  /// Converts the transaction details into a map for estimating gas.
  Map<String, dynamic> toEstimate() {
    return {
      if (from != null) 'from': from?.address,
      if (to != null) 'to': to?.address,
      'value': '0x${value.toRadixString(16)}',
      if (data.isNotEmpty) 'data': BytesUtils.toHexString(data, prefix: '0x'),
      if (accessList?.isNotEmpty ?? false)
        'accessList': accessList?.map((e) => e.toJson()).toList()
    };
  }

  /// Converts the transaction details into a json.
  Map<String, dynamic> toJson() {
    return {
      'type': type?.name,
      'to': to?.address,
      'from': from?.address,
      'nonce': '0x${nonce.toRadixString(16)}',
      'gasLimit': '0x${gasLimit.toRadixString(16)}',
      'gasPrice': gasPrice == null ? null : '0x${gasPrice!.toRadixString(16)}',
      'maxPriorityFeePerGas': maxPriorityFeePerGas == null
          ? null
          : '0x${maxPriorityFeePerGas!.toRadixString(16)}',
      'maxFeePerGas':
          maxFeePerGas == null ? null : '0x${maxFeePerGas!.toRadixString(16)}',
      'data': data.isEmpty ? null : BytesUtils.toHexString(data, prefix: '0x'),
      'value': '0x${value.toRadixString(16)}',
      'chainId': '0x${chainId.toRadixString(16)}',
      'accessList': accessList?.map((e) => e.toJson()).toList(),
      'signature': signature == null
          ? null
          : {
              's': signature!.s.toString(),
              'r': signature!.r.toString(),
              'v': signature!.v
            }
    };
  }
}

import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/ethereum/src/models/autorization.dart';
import 'package:on_chain/ethereum/src/rlp/decode.dart';
import 'package:on_chain/ethereum/src/rlp/encode.dart';
import 'package:on_chain/ethereum/src/models/access_list.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/transaction/zksync.dart';
import 'package:on_chain/solidity/abi/abi.dart';

/// Represents the type of an Ethereum transaction.
enum ETHTransactionType {
  /// Represents a legacy Ethereum transaction (pre-EIP-2718).
  legacy(0x00, 'Legacy'),

  /// Represents an EIP-2930 Ethereum transaction (Berlin hard fork).
  eip2930(0x01, 'EIP-2930'),

  /// Represents an EIP-1559 Ethereum transaction (London hard fork).
  eip1559(0x02, 'EIP-1559'),

  /// Represents an EIP-4844 Ethereum transaction (Blob / Cancun hard fork).
  eip4844(0x03, 'EIP-4844'),

  /// Represents an EIP-7702 Ethereum transaction (Authorization list / Prague hard fork).
  eip7702(0x04, 'EIP-7702'),

  /// Represents an EIP-7702 ZKsync Chains transaction.
  /// ZKsync Chains use this for features like native account abstraction and paymasters.
  eip712(0x71, 'EIP-712');

  const ETHTransactionType(this.prefix, this.name);

  /// The numeric prefix (type byte) associated with the transaction type.
  final int prefix;

  /// The human-readable name of the transaction type.
  final String name;

  /// Returns a transaction type from its prefix byte, or `null` if unknown.
  static ETHTransactionType fromPrefix(int prefix) {
    return ETHTransactionType.values.firstWhere((type) => type.prefix == prefix,
        orElse: () => throw ItemNotFoundException(value: prefix));
  }

  bool get isEIP1559 => this == eip1559;
  bool get isLegacy => this == legacy;
  bool get isEIP4844 => this == eip4844;
  bool get isEIP7702 => this == eip7702;
  bool get isEIP712 => this == eip712;
  bool get isEIP2930 => this == eip2930;
}

/// Utility class for Ethereum transaction-related operations.
class ETHTransactionUtils {
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

  static int parityToV(int parity) => parity + 27;

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
    try {
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
            ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[7]));
        final List<int> sBytes =
            ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[8]));
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
    } catch (e) {
      throw ETHPluginException(
          "Failed to deserialize transaction as legacy format.",
          details: {"error": e.toString()});
    }
  }

  /// Converts the decoded data to an EIP-2930 transaction.
  static ETHTransaction _fromEIP2930(List<dynamic> decode) {
    try {
      final BigInt chainId = BigintUtils.fromBytes(decode[0]);
      final int nonce = IntUtils.fromBytes(decode[1]);
      final BigInt gasPrice = BigintUtils.fromBytes(decode[2]);
      final BigInt gasLimit = BigintUtils.fromBytes(decode[3]);
      final ETHAddress? to =
          (decode[4] as List).isEmpty ? null : ETHAddress.fromBytes(decode[4]);
      final value = BigintUtils.fromBytes(decode[5]);
      final data = List<int>.from(decode[6]);
      final accessList =
          (decode[7] as List).map((e) => AccessEntry.deserialize(e)).toList();
      ETHSignature? sig;
      if (decode.length > 8) {
        final List<int> rBytes =
            ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[9]));
        final List<int> sBytes =
            ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[10]));
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
    } catch (e) {
      throw ETHPluginException(
          "Failed to deserialize transaction as EIP-2930 format.",
          details: {"error": e.toString()});
    }
  }

  /// Converts the decoded data to an EIP-1559 transaction.
  static ETHTransaction _fromEIP1559(List<dynamic> decode) {
    try {
      final BigInt chainId = BigintUtils.fromBytes(decode[0]);
      final int nonce = IntUtils.fromBytes(decode[1]);
      final BigInt maxPriorityFeePerGas = BigintUtils.fromBytes(decode[2]);
      final BigInt maxFeePerGas = BigintUtils.fromBytes(decode[3]);
      final BigInt gasLimit = BigintUtils.fromBytes(decode[4]);
      final ETHAddress? to =
          (decode[5] as List).isEmpty ? null : ETHAddress.fromBytes(decode[5]);
      final value = BigintUtils.fromBytes(decode[6]);
      final data = List<int>.from(decode[7]);
      final accessList =
          (decode[8] as List).map((e) => AccessEntry.deserialize(e)).toList();
      ETHSignature? sig;
      if (decode.length > 9) {
        final List<int> rBytes =
            ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[10]));
        final List<int> sBytes =
            ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[11]));
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
    } catch (e) {
      throw ETHPluginException(
          "Failed to deserialize transaction as EIP-1559 format.",
          details: {"error": e.toString()});
    }
  }

  /// Converts the decoded RLP data to an EIP-4844 (Type 3) Ethereum transaction.
  static ETHTransaction _fromEIP4844(List<dynamic> decode) {
    try {
      final BigInt chainId = BigintUtils.fromBytes(decode[0]);
      final int nonce = IntUtils.fromBytes(decode[1]);
      final BigInt maxPriorityFeePerGas = BigintUtils.fromBytes(decode[2]);
      final BigInt maxFeePerGas = BigintUtils.fromBytes(decode[3]);
      final BigInt gasLimit = BigintUtils.fromBytes(decode[4]);

      final ETHAddress? to =
          (decode[5] as List).isEmpty ? null : ETHAddress.fromBytes(decode[5]);

      final BigInt value = BigintUtils.fromBytes(decode[6]);
      final List<int> data = List<int>.from(decode[7]);

      final List<AccessEntry> accessList =
          (decode[8] as List).map((e) => AccessEntry.deserialize(e)).toList();

      final BigInt maxFeePerBlobGas = BigintUtils.fromBytes(decode[9]);

      final List<List<int>> blobVersionedHashes =
          (decode[10] as List).map((e) => List<int>.from(e)).toList();

      ETHSignature? sig;
      if (decode.length > 11) {
        final List<int> yParity = List<int>.from(decode[11]);
        final List<int> rBytes =
            ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[12]));
        final List<int> sBytes =
            ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[13]));

        final sigBytes = <int>[...rBytes, ...sBytes, ...yParity];
        sig = ETHSignature.fromBytes(sigBytes);
      }

      return ETHTransaction._(
        nonce: nonce,
        gasLimit: gasLimit,
        accessList: accessList,
        maxFeePerGas: maxFeePerGas,
        maxPriorityFeePerGas: maxPriorityFeePerGas,
        maxFeePerBlobGas: maxFeePerBlobGas,
        blobVersionedHashes: blobVersionedHashes,
        type: ETHTransactionType.eip4844,
        to: to,
        value: value,
        chainId: chainId,
        signature: sig,
        data: data,
      );
    } catch (e) {
      throw ETHPluginException(
          "Failed to deserialize transaction as EIP-4844 format.",
          details: {"error": e.toString()});
    }
  }

  /// Converts the decoded RLP data to an EIP-7702 (Type 4) Ethereum transaction.
  static ETHTransaction _fromEIP7702(List<dynamic> decode) {
    try {
      final BigInt chainId = BigintUtils.fromBytes(decode[0]);
      final int nonce = IntUtils.fromBytes(decode[1]);
      final BigInt maxPriorityFeePerGas = BigintUtils.fromBytes(decode[2]);
      final BigInt maxFeePerGas = BigintUtils.fromBytes(decode[3]);
      final BigInt gasLimit = BigintUtils.fromBytes(decode[4]);

      final ETHAddress? to =
          (decode[5] as List).isEmpty ? null : ETHAddress.fromBytes(decode[5]);

      final BigInt value = BigintUtils.fromBytes(decode[6]);
      final List<int> data = List<int>.from(decode[7]);

      final List<AccessEntry> accessList =
          (decode[8] as List).map((e) => AccessEntry.deserialize(e)).toList();

      // Decode authorization_list: List of authorizations
      final List<AuthorizationEntry> authorizationList = (decode[9] as List)
          .map((e) => AuthorizationEntry.deserialize(e))
          .toList();

      ETHSignature? sig;
      if (decode.length > 10) {
        final List<int> yParity = List<int>.from(decode[10]);
        final List<int> rBytes =
            ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[11]));
        final List<int> sBytes =
            ETHTransactionUtils.leadingZero32Bytes(List<int>.from(decode[12]));
        final sigBytes = <int>[...rBytes, ...sBytes, ...yParity];
        sig = ETHSignature.fromBytes(sigBytes);
      }

      return ETHTransaction._(
        nonce: nonce,
        gasLimit: gasLimit,
        accessList: accessList,
        maxFeePerGas: maxFeePerGas,
        maxPriorityFeePerGas: maxPriorityFeePerGas,
        authorizationList: authorizationList,
        type: ETHTransactionType.eip712,
        to: to,
        value: value,
        chainId: chainId,
        signature: sig,
        data: data,
      );
    } catch (e) {
      throw ETHPluginException(
          "Failed to deserialize transaction as EIP-712 format.",
          details: {"error": e.toString()});
    }
  }

  /// Converts the decoded RLP data to an EIP-7702 (Type 4) Ethereum transaction.
  static ETHTransaction _fromEIP712(List<dynamic> decode) {
    try {
      final int nonce = IntUtils.fromBytes(decode[0]);
      final BigInt maxPriorityFeePerGas = BigintUtils.fromBytes(decode[1]);
      final BigInt maxFeePerGas = BigintUtils.fromBytes(decode[2]);
      final BigInt gasLimit = BigintUtils.fromBytes(decode[3]);

      final ETHAddress? to =
          (decode[4] as List).isEmpty ? null : ETHAddress.fromBytes(decode[4]);

      final BigInt value = BigintUtils.fromBytes(decode[5]);
      final List<int> data = List<int>.from(decode[6]);
      final yParityBytes = JsonParser.valueAsBytes<List<int>>(decode[7]);
      ETHSignature? sig;
      final rBytes = JsonParser.valueAsBytes<List<int>>(decode[8]);
      final sBytes = JsonParser.valueAsBytes<List<int>>(decode[9]);
      if (rBytes.isNotEmpty && sBytes.isNotEmpty) {
        sig = ETHSignature.fromBytes(
            <int>[...rBytes, ...sBytes, ...yParityBytes]);
      }
      final BigInt chainId = BigintUtils.fromBytes(decode[10]);
      final ETHAddress? from = (decode[11] as List).isEmpty
          ? null
          : ETHAddress.fromBytes(decode[11]);
      final paymaster = JsonParser.valueAsList<List>(decode[15]);
      final customSignatureBytes =
          JsonParser.valueAsBytes<List<int>>(decode[14]);
      if (customSignatureBytes.isNotEmpty) {
        sig = ETHSignature.fromBytes(customSignatureBytes);
      }
      final zsync = ZKSyncE712Parameters(
          gasPerPubdata: BigintUtils.fromBytes(
              JsonParser.valueAsBytes<List<int>>(decode[12])),
          factoryDeps: JsonParser.valueAsList<List>(decode[13])
              .map((e) => JsonParser.valueAsBytes<List<int>>(e))
              .toList(),
          paymaster: paymaster.isEmpty
              ? null
              : ZKSyncPaymaster(
                  address: ETHAddress.fromBytes(
                      JsonParser.valueAsBytes<List<int>>(paymaster[0])),
                  input: JsonParser.valueAsBytes<List<int>>(paymaster[1])));

      return ETHTransaction._(
        nonce: nonce,
        gasLimit: gasLimit,
        maxFeePerGas: maxFeePerGas,
        maxPriorityFeePerGas: maxPriorityFeePerGas,
        type: ETHTransactionType.eip7702,
        zkSyncParameters: zsync,
        from: from,
        to: to,
        value: value,
        chainId: chainId,
        signature: sig,
        data: data,
      );
    } catch (e) {
      throw ETHPluginException(
          "Failed to deserialize transaction as EIP-712 format.",
          details: {"error": e.toString()});
    }
  }

  static void validateTxParameters(
      {BigInt? gasPrice,
      BigInt? maxPriorityFeePerGas,
      BigInt? maxFeePerGas,
      List<AccessEntry>? accessList,
      List<AuthorizationEntry>? authorizationList,
      List<List<int>>? blobVersionedHashes,
      BigInt? maxFeePerBlobGas,
      ZKSyncE712Parameters? zkParams}) {
    ETHTransactionType.eip1559;
    if ([maxFeePerGas, maxPriorityFeePerGas].whereType<BigInt>().length == 1) {
      throw ETHPluginException(
          'both maxFeePerGas and maxPriorityFeePerGas required for ${ETHTransactionType.eip1559.name} transaction.',
          details: {
            'maxFeePerGas': maxFeePerGas,
            'maxPriorityFeePerGas': maxPriorityFeePerGas
          });
    }
    bool isEIP1559 = maxFeePerGas != null;
    bool isLegacy = gasPrice != null;
    bool isEIP4844 = maxFeePerBlobGas != null;
    bool isEIP7702 = authorizationList != null;
    bool isEIP712 = zkParams != null;
    if (isEIP1559 && gasPrice != null) {
      throw ETHPluginException(
          'Gas price must be null for Non-legacy transaction.',
          details: {'gasPrice': gasPrice});
    }
    if (isEIP712 &&
        (isEIP7702 || isEIP4844 || isLegacy || accessList != null)) {
      String? current;
      if (isEIP7702) {
        current = ETHTransactionType.eip7702.name;
      } else if (isEIP4844) {
        current = ETHTransactionType.eip4844.name;
      } else if (isLegacy) {
        current = ETHTransactionType.legacy.name;
      } else {
        current = ETHTransactionType.eip2930.name;
      }
      throw ETHPluginException(
          'Cannot create a ${ETHTransactionType.eip712.name} transaction with $current parameters. ');
    }

    if ([maxFeePerBlobGas, blobVersionedHashes?.emptyAsNull]
            .where((e) => e != null)
            .length ==
        1) {
      throw ETHPluginException(
          'both maxFeePerBlobGas and blobVersionedHashes required for ${ETHTransactionType.eip4844.name} transaction.',
          details: {
            'maxFeePerBlobGas': maxFeePerBlobGas,
            'blobVersionedHashes': blobVersionedHashes
                ?.map((e) => BytesUtils.toHexString(e))
                .toList()
          });
    }
    if (isEIP4844 && isEIP7702) {
      throw ETHPluginException(
          'Cannot create a ${ETHTransactionType.eip7702.name} transaction with EIP-4844 parameters. ');
    }
    if (isLegacy && (isEIP4844 || isEIP7702)) {
      throw ETHPluginException(
          'Cannot create a legacy transaction with ${isEIP4844 ? ETHTransactionType.eip4844.name : ETHTransactionType.eip7702.name} parameters. ');
    }
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
  final List<AccessEntry>? accessList;

  /// The transaction signature.
  final ETHSignature? signature;

  final BigInt? maxFeePerBlobGas;

  final List<List<int>>? blobVersionedHashes;

  final List<AuthorizationEntry>? authorizationList;

  final ZKSyncE712Parameters? zkSyncParameters;

  /// Private constructor for creating an ETHTransaction.
  ETHTransaction._(
      {required this.nonce,
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
      List<AccessEntry>? accessList,
      List<List<int>>? blobVersionedHashes,
      List<AuthorizationEntry>? authorizationList,
      this.zkSyncParameters,
      this.maxFeePerBlobGas})
      : data = (data ?? <int>[]).asImmutableBytes,
        blobVersionedHashes =
            blobVersionedHashes?.map((e) => e.asImmutableBytes).toImutableList,
        authorizationList = authorizationList?.immutable,
        accessList = accessList?.immutable;

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
          List<AccessEntry>? accessList,
          BigInt? gasPrice,
          BigInt? maxPriorityFeePerGas,
          BigInt? maxFeePerGas,
          ETHSignature? signature,
          BigInt? maxFeePerBlobGas,
          List<AuthorizationEntry>? authorizationList,
          List<List<int>>? blobVersionedHashes,
          ZKSyncE712Parameters? zkSyncParameters}) =>
      ETHTransaction._(
          type: type,
          to: to,
          from: from,
          nonce: nonce,
          maxFeePerBlobGas: maxFeePerBlobGas,
          authorizationList: authorizationList,
          blobVersionedHashes: blobVersionedHashes,
          gasLimit: gasLimit,
          gasPrice: gasPrice,
          maxPriorityFeePerGas: maxPriorityFeePerGas,
          maxFeePerGas: maxFeePerGas,
          data: data,
          value: value,
          chainId: chainId,
          accessList: accessList,
          signature: signature,
          zkSyncParameters: zkSyncParameters);

  /// Factory constructor to create an [ETHTransaction] from serialized transaction bytes.
  factory ETHTransaction.fromSerialized(List<int> transactionBytes) {
    if (transactionBytes.isEmpty) {
      throw const ETHPluginException('invalid transaction bytes');
    }
    final int prefix = transactionBytes[0];
    ETHTransactionType type = ETHTransactionType.legacy;
    if (prefix <= 0x7f) {
      type = ETHTransactionType.fromPrefix(prefix);
      transactionBytes = transactionBytes.sublist(1);
    }
    final decode = RLPDecoder.decode(transactionBytes);
    return switch (type) {
      ETHTransactionType.legacy => ETHTransactionUtils._fromLegacy(decode),
      ETHTransactionType.eip2930 => ETHTransactionUtils._fromEIP2930(decode),
      ETHTransactionType.eip1559 => ETHTransactionUtils._fromEIP1559(decode),
      ETHTransactionType.eip7702 => ETHTransactionUtils._fromEIP7702(decode),
      ETHTransactionType.eip4844 => ETHTransactionUtils._fromEIP4844(decode),
      ETHTransactionType.eip712 => ETHTransactionUtils._fromEIP712(decode),
    };
  }

  /// Factory constructor to create an [ETHTransaction] from JSON.
  factory ETHTransaction.fromJson(Map<String, dynamic> json) {
    return ETHTransaction(
        nonce: json.valueAsInt("nonce", allowHex: true),
        gasLimit: json.valueAsBigInt("gasLimit", allowHex: true),
        data: BytesUtils.tryFromHexString(json['data']) ?? const <int>[],
        value: json.valueAsBigInt("value", allowHex: true),
        chainId: json.valueAsBigInt("chainId", allowHex: true),
        gasPrice: json.valueAsBigInt("gasPrice", allowHex: true),
        maxFeePerGas: json.valueAsBigInt("maxFeePerGas", allowHex: true),
        maxPriorityFeePerGas:
            json.valueAsBigInt("maxPriorityFeePerGas", allowHex: true),
        from: ETHAddress(json['from']),
        to: json['to'] == null ? null : ETHAddress(json['to']),
        type: json['type'] == null
            ? null
            : ETHTransactionType.fromPrefix(
                json.valueAsInt("type", allowHex: true)),
        accessList: (json['accessList'] as List?)
            ?.map((e) => AccessEntry.fromJson(e))
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
          List<AccessEntry>? accessList,
          ETHSignature? signature,
          List<AuthorizationEntry>? authorizationList,
          List<List<int>>? blobVersionedHashes,
          BigInt? maxFeePerBlobGas,
          ZKSyncE712Parameters? zkSyncParams}) =>
      ETHTransaction._(
          type: type ?? this.type,
          to: to ?? this.to,
          from: from ?? this.from,
          nonce: nonce ?? this.nonce,
          authorizationList: authorizationList ?? this.authorizationList,
          blobVersionedHashes: blobVersionedHashes ?? this.blobVersionedHashes,
          maxFeePerBlobGas: maxFeePerBlobGas ?? this.maxFeePerBlobGas,
          accessList: accessList ?? this.accessList,
          gasLimit: gasLimit ?? this.gasLimit,
          gasPrice: gasPrice ?? this.gasPrice,
          maxPriorityFeePerGas:
              maxPriorityFeePerGas ?? this.maxPriorityFeePerGas,
          maxFeePerGas: maxFeePerGas ?? this.maxFeePerGas,
          data: data ?? this.data,
          value: value ?? this.value,
          chainId: chainId ?? this.chainId,
          signature: signature ?? this.signature,
          zkSyncParameters: zkSyncParams);

  /// Converts the [ETHTransaction] to its EIP-1559 serialized form.
  /// If [sig] is provided, includes the signature fields in the serialization.
  List<int> _toEIP1559([ETHSignature? sig]) {
    final List<List<dynamic>> fields = [
      ETHTransactionUtils.bigintToBytes(chainId),
      ETHTransactionUtils.intToBytes(nonce),
      ETHTransactionUtils.bigintToBytes(maxPriorityFeePerGas!),
      ETHTransactionUtils.bigintToBytes(maxFeePerGas!),
      ETHTransactionUtils.bigintToBytes(gasLimit),
      to?.toBytes() ?? <int>[],
      ETHTransactionUtils.bigintToBytes(value),
      data,
      accessList?.map((e) => e.serialize()).toList() ?? <dynamic>[],
    ];
    if (sig != null) {
      fields.add(
          ETHTransactionUtils.intToBytes(ETHTransactionUtils.parity(sig.v)));
      fields.add(ETHTransactionUtils.trimLeadingZero(sig.rBytes));
      fields.add(ETHTransactionUtils.trimLeadingZero(sig.sBytes));
    }

    return [ETHTransactionType.eip1559.prefix, ...RLPEncoder.encode(fields)];
  }

  /// Converts the [ETHTransaction] to its EIP-712 serialized form.
  /// If [sig] is provided, includes the signature fields in the serialization.
  List<int> _toEIP712([ETHSignature? sig]) {
    final List<List<dynamic>> fields = [
      ETHTransactionUtils.intToBytes(nonce),
      ETHTransactionUtils.bigintToBytes(maxPriorityFeePerGas!),
      ETHTransactionUtils.bigintToBytes(maxFeePerGas!),
      ETHTransactionUtils.bigintToBytes(gasLimit),
      to?.toBytes() ?? <int>[],
      ETHTransactionUtils.bigintToBytes(value),
      data,
      ETHTransactionUtils.bigintToBytes(chainId),
      <int>[],
      <int>[],
      ETHTransactionUtils.bigintToBytes(chainId),
      from?.toBytes() ?? [],
      ETHTransactionUtils.bigintToBytes(zkSyncParameters!.gasPerPubdata),
      zkSyncParameters!.factoryDeps,
      sig?.toBytes() ?? [],
      zkSyncParameters!.paymaster?.serialize() ?? []
    ];

    return [ETHTransactionType.eip712.prefix, ...RLPEncoder.encode(fields)];
  }

  /// Converts the [ETHTransaction] to its EIP-2930 serialized form.
  /// If [sig] is provided, includes the signature fields in the serialization.
  List<int> _toEip2930([ETHSignature? sig]) {
    final List<List<dynamic>> fields = [
      ETHTransactionUtils.bigintToBytes(chainId),
      ETHTransactionUtils.intToBytes(nonce),
      ETHTransactionUtils.bigintToBytes(gasPrice!),
      ETHTransactionUtils.bigintToBytes(gasLimit),
      to?.toBytes() ?? List<int>.empty(),
      ETHTransactionUtils.bigintToBytes(value),
      data,
      accessList?.map((e) => e.serialize()).toList() ?? <dynamic>[],
    ];
    if (sig != null) {
      fields.add(
          ETHTransactionUtils.intToBytes(ETHTransactionUtils.parity(sig.v)));
      fields.add(ETHTransactionUtils.trimLeadingZero(sig.rBytes));
      fields.add(ETHTransactionUtils.trimLeadingZero(sig.sBytes));
    }
    return [ETHTransactionType.eip2930.prefix, ...RLPEncoder.encode(fields)];
  }

  /// Converts the [ETHTransaction] to its legacy (pre-EIP-155) serialized form.
  /// If [sig] is provided, includes the signature fields in the serialization.
  List<int> _toLegacy([ETHSignature? sig]) {
    final List<List<int>> fields = [
      ETHTransactionUtils.intToBytes(nonce),
      ETHTransactionUtils.bigintToBytes(gasPrice!),
      ETHTransactionUtils.bigintToBytes(gasLimit),
      to?.toBytes() ?? List<int>.empty(),
      ETHTransactionUtils.bigintToBytes(value),
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
    BigInt v = BigInt.from(27 + ETHTransactionUtils.parity(sig.v));
    if (chainId != BigInt.zero) {
      v = ETHTransactionUtils.getLegacyChainId(sig.v, chainId);
    } else if (BigInt.from(sig.v) != v) {
      throw const ETHPluginException('Mismatch chainID/Signature.V');
    }
    fields.add(BigintUtils.toBytes(v, length: BigintUtils.bitlengthInBytes(v)));
    fields.add(ETHTransactionUtils.trimLeadingZero(sig.rBytes));
    fields.add(ETHTransactionUtils.trimLeadingZero(sig.sBytes));
    return RLPEncoder.encode(fields);
  }

  /// Converts the [ETHTransaction] to its EIP-4844 (Type 3) serialized form.
  /// Includes blob-related fields and optionally the signature.
  List<int> _toEIP4844([ETHSignature? sig]) {
    final List<List<dynamic>> fields = [
      ETHTransactionUtils.bigintToBytes(chainId),
      ETHTransactionUtils.intToBytes(nonce),
      ETHTransactionUtils.bigintToBytes(maxPriorityFeePerGas!),
      ETHTransactionUtils.bigintToBytes(maxFeePerGas!),
      ETHTransactionUtils.bigintToBytes(gasLimit),
      to?.toBytes() ?? <int>[],
      ETHTransactionUtils.bigintToBytes(value),
      data,
      accessList?.map((e) => e.serialize()).toList() ?? <dynamic>[],
      ETHTransactionUtils.bigintToBytes(maxFeePerBlobGas!),
      blobVersionedHashes ?? <dynamic>[],
    ];

    if (sig != null) {
      fields.add(
          ETHTransactionUtils.intToBytes(ETHTransactionUtils.parity(sig.v)));
      fields.add(ETHTransactionUtils.trimLeadingZero(sig.rBytes));
      fields.add(ETHTransactionUtils.trimLeadingZero(sig.sBytes));
    }
    return [ETHTransactionType.eip4844.prefix, ...RLPEncoder.encode(fields)];
  }

  /// Converts the [ETHTransaction] to its EIP-7702 (Type 4) serialized form.
  /// Includes authorization_list and optionally the signature.
  List<int> _toEIP7702([ETHSignature? sig]) {
    final List<List<dynamic>> fields = [
      ETHTransactionUtils.bigintToBytes(chainId),
      ETHTransactionUtils.intToBytes(nonce),
      ETHTransactionUtils.bigintToBytes(maxPriorityFeePerGas!),
      ETHTransactionUtils.bigintToBytes(maxFeePerGas!),
      ETHTransactionUtils.bigintToBytes(gasLimit),
      to?.toBytes() ?? <int>[],
      ETHTransactionUtils.bigintToBytes(value),
      data,
      accessList?.map((e) => e.serialize()).toList() ?? <dynamic>[],
      authorizationList?.map((auth) => auth.serialize()).toList() ??
          <dynamic>[],
    ];

    if (sig != null) {
      fields.add(
          ETHTransactionUtils.intToBytes(ETHTransactionUtils.parity(sig.v)));
      fields.add(ETHTransactionUtils.trimLeadingZero(sig.rBytes));
      fields.add(ETHTransactionUtils.trimLeadingZero(sig.sBytes));
    }

    return [ETHTransactionType.eip7702.prefix, ...RLPEncoder.encode(fields)];
  }

  ETHTransactionType _detectTxType({bool allowEIP712 = true}) {
    final hasAccessList = accessList?.isNotEmpty ?? false;
    final hasAutorizationList = authorizationList?.isNotEmpty ?? false;
    final hasBlob = blobVersionedHashes?.isNotEmpty ?? false;
    final isEIP712 = zkSyncParameters != null;
    final isEIP1559 = maxFeePerGas != null || maxPriorityFeePerGas != null;
    if (allowEIP712 && isEIP712) {
      return ETHTransactionType.eip712;
    } else if (hasAutorizationList) {
      return ETHTransactionType.eip7702;
    } else if (hasBlob) {
      return ETHTransactionType.eip4844;
    } else if (isEIP1559) {
      return ETHTransactionType.eip1559;
    } else if (hasAccessList) {
      return ETHTransactionType.eip2930;
    } else {
      return ETHTransactionType.legacy;
    }
  }

  /// Determines the [ETHTransactionType] based on the transaction's properties.
  ETHTransactionType get transactionType {
    final hasAccessList = accessList?.isNotEmpty ?? false;
    final hasAutorizationList = authorizationList?.isNotEmpty ?? false;
    final hasBlob = blobVersionedHashes?.isNotEmpty ?? false;
    final isEIP712 = zkSyncParameters != null;
    bool isLegacy = gasPrice != null;
    if (hasBlob && hasAutorizationList) {
      throw ETHPluginException(
          'Cannot create a transaction with both EIP-7702 and EIP-4844 parameters. ');
    }

    if (isEIP712 &&
        (hasBlob || hasAutorizationList || isLegacy || hasAccessList)) {
      throw ETHPluginException(
          'Cannot create a ${ETHTransactionType.eip712.name} transaction with ${_detectTxType(allowEIP712: false).name} parameters. ');
    }

    ETHTransactionType validateTxType(ETHTransactionType transactionType) {
      if (transactionType.isLegacy || transactionType.isEIP2930) {
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
        if (transactionType.isLegacy && hasAccessList) {
          throw ETHPluginException(
              'accsesslist must be null or empty for legacy transactions',
              details: {'accessList': accessList});
        }
        if (hasBlob || hasAutorizationList || zkSyncParameters != null) {
          throw ETHPluginException(
              'Cannot create a ${transactionType.name} transaction with ${hasBlob ? 'EIP-4844 ' : 'EIP-7702'} parameters. ');
        }
      } else {
        if (gasPrice != null) {
          throw ETHPluginException(
              'Gas price must be null for ${transactionType.name} transactions.',
              details: {'gasPrice': gasPrice});
        }
        if (maxFeePerGas == null || maxPriorityFeePerGas == null) {
          throw ETHPluginException(
              'maxFeePerGas and maxPriorityFeePerGas must not be null for ${transactionType.name} transactions.');
        }
        if (maxPriorityFeePerGas! > maxFeePerGas!) {
          throw ETHPluginException('priorityFee cannot be more than maxFee',
              details: {
                'priorityFee': maxFeePerGas,
                'maxFee': maxPriorityFeePerGas
              });
        }
        switch (transactionType) {
          case ETHTransactionType.eip712:
            if (zkSyncParameters == null) {
              throw ETHPluginException(
                  'zkSyncParameters must not be null for EIP-712 transaction.');
            }
            break;
          case ETHTransactionType.eip4844:
            if (maxFeePerBlobGas == null) {
              throw ETHPluginException(
                  'maxGasPerBlob must not be null for EIP-4844 transaction.');
            }
            if (hasAutorizationList) {
              throw ETHPluginException(
                  'Cannot create a ${transactionType.name} transaction with EIP-7702 parameters. ');
            }
            break;
          case ETHTransactionType.eip7702:
            if (hasBlob || maxFeePerBlobGas != null) {
              throw ETHPluginException(
                  'Cannot create a ${transactionType.name} transaction with EIP-4844 parameters. ');
            }
          default:
            break;
        }
      }
      return transactionType;
    }

    ETHTransactionType transactionType = type ?? _detectTxType();
    return validateTxType(transactionType);
  }

  /// Serializes the transaction based on its type.
  List<int> _serialized([ETHSignature? signature]) {
    switch (transactionType) {
      case ETHTransactionType.legacy:
        return _toLegacy(signature);
      case ETHTransactionType.eip2930:
        return _toEip2930(signature);
      case ETHTransactionType.eip4844:
        return _toEIP4844(signature);
      case ETHTransactionType.eip7702:
        return _toEIP7702(signature);
      case ETHTransactionType.eip1559:
        return _toEIP1559(signature);
      case ETHTransactionType.eip712:
        if (signature == null) {
          return getEIP712TypeData().encode(hash: false);
        }
        return _toEIP712(signature);
    }
  }

  Eip712TypedData getEIP712TypeData() {
    ETHTransactionType transactionType = type ?? _detectTxType();
    if (!transactionType.isEIP712) {
      throw ETHPluginException(
          "cannot create ${ETHTransactionType.eip712.name} typed-data from ${transactionType.name} transaction.");
    }
    transactionType = this.transactionType;
    if (!transactionType.isEIP712) {
      throw ETHPluginException(
          "cannot create ${ETHTransactionType.eip712.name} typed-data from ${transactionType.name} transaction.");
    }

    return ZksyncUtils.getTypeData(
        chainId: chainId,
        from: from,
        to: to,
        gasLimit: gasLimit,
        maxFeePerGas: maxFeePerGas!,
        nonce: nonce,
        maxPriorityFeePerGas: maxPriorityFeePerGas,
        data: data,
        value: value,
        zkParams: zkSyncParameters!);
  }

  /// Gets the serialized transaction for signing.
  List<int> get serialized => _serialized();

  /// Gets the serialized transaction.
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
        'accessList': accessList?.map((e) => e.toJson()).toList(),
      if (authorizationList?.isNotEmpty ?? false)
        'authorizationList': authorizationList?.map((e) => e.toJson()).toList(),
      if (blobVersionedHashes?.isNotEmpty ?? false)
        "blobVersionedHashes": blobVersionedHashes
            ?.map((e) => BytesUtils.toHexString(e, prefix: "0x"))
            .toList(),
      if (maxFeePerBlobGas != null) "maxFeePerBlobGas": maxFeePerBlobGas
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
      "blobVersionedHashes": blobVersionedHashes
          ?.map((e) => BytesUtils.toHexString(e, prefix: "0x"))
          .toList(),
      'maxFeePerGas':
          maxFeePerGas == null ? null : '0x${maxFeePerGas!.toRadixString(16)}',
      "maxFeePerBlobGas": maxFeePerBlobGas == null
          ? null
          : '0x${maxFeePerBlobGas!.toRadixString(16)}',
      'data': data.isEmpty ? null : BytesUtils.toHexString(data, prefix: '0x'),
      'value': '0x${value.toRadixString(16)}',
      'chainId': '0x${chainId.toRadixString(16)}',
      'accessList': accessList?.map((e) => e.toJson()).toList(),
      'authorizationList': authorizationList?.map((e) => e.toJson()).toList(),
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

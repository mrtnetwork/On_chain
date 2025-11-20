import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/ethereum/src/transaction/eth_transaction.dart';

class AuthorizationEntry {
  final BigInt chainId;
  final ETHAddress address;
  final BigInt nonce;
  final ETHSignature signature;

  const AuthorizationEntry(
      {required this.chainId,
      required this.address,
      required this.nonce,
      required this.signature});

  /// Creates an [AuthorizationEntry] from a JSON map.
  factory AuthorizationEntry.fromJson(Map<String, dynamic> json) {
    return AuthorizationEntry(
        address: ETHAddress(json.valueAs("address")),
        chainId: json.valueAsBigInt("chainId"),
        nonce: json.valueAsBigInt("nonce"),
        signature: ETHSignature(
            json.valueAsBigInt("r", allowHex: true),
            json.valueAsBigInt("s", allowHex: true),
            ETHTransactionUtils.parityToV(
                json.valueAsInt("yParity", allowHex: true))));
  }

  /// Creates an [AuthorizationEntry] from a serialized list of dynamic objects.
  factory AuthorizationEntry.deserialize(List<dynamic> serialized) {
    try {
      return AuthorizationEntry(
          chainId:
              BigintUtils.fromBytes(JsonParser.valueAsBytes(serialized[0])),
          address: ETHAddress.fromBytes(JsonParser.valueAsBytes(serialized[1])),
          nonce: BigintUtils.fromBytes(JsonParser.valueAsBytes(serialized[2])),
          signature: ETHSignature(
              BigintUtils.fromBytes(JsonParser.valueAsBytes(serialized[4])),
              BigintUtils.fromBytes(JsonParser.valueAsBytes(serialized[5])),
              ETHTransactionUtils.parityToV(
                  IntUtils.fromBytes(JsonParser.valueAsBytes(serialized[3])))));
    } catch (e) {
      throw const ETHPluginException('invalid AuthorizationEntry serialized');
    }
  }

  /// Serializes the access list entry to a list of dynamic objects.
  List<dynamic> serialize() {
    return [
      ETHTransactionUtils.bigintToBytes(chainId),
      address.toBytes(),
      ETHTransactionUtils.bigintToBytes(nonce),
      ETHTransactionUtils.intToBytes(ETHTransactionUtils.parity(signature.v)),
      ETHTransactionUtils.trimLeadingZero(signature.rBytes),
      ETHTransactionUtils.trimLeadingZero(signature.sBytes)
    ];
  }

  /// Converts the access list entry to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'address': address.address,
      "chainId": "0x${chainId.toRadixString(16)}",
      "nonce": "0x${nonce.toRadixString(16)}",
      "yParity":
          "0x${ETHTransactionUtils.parity(signature.v).toRadixString(16)}",
      "r": "0x${signature.r.toRadixString(16)}",
      "s": "0x${signature.r.toRadixString(16)}"
    };
  }

  @override
  String toString() {
    return '''
      AuthorizationEntry${toJson()}
    ''';
  }
}

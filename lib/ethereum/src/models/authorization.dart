import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';

import 'package:on_chain/ethereum/src/transaction/eth_transaction.dart';

class AuthorizationEntry {
  final BigInt chainId;
  final ETHAddress address;
  final BigInt nonce;
  final IECDSASignature signature;

  const AuthorizationEntry({
    required this.chainId,
    required this.address,
    required this.nonce,
    required this.signature,
  });

  /// Creates an [AuthorizationEntry] from a JSON map.
  factory AuthorizationEntry.fromJson(Map<String, dynamic> json) {
    return AuthorizationEntry(
      address: ETHAddress(json.valueAs("address")),
      chainId: json.valueAsBigInt("chainId"),
      nonce: json.valueAsBigInt("nonce"),
      signature: IECDSASignature(
        r: json.valueAsBytes("r", allowHex: true),
        s: json.valueAsBytes("s", allowHex: true),
        recoveryId: json.valueAsInt("yParity", allowHex: true),
      ),
    );
  }

  /// Creates an [AuthorizationEntry] from a serialized list of dynamic objects.
  factory AuthorizationEntry.deserialize(List<dynamic> serialized) {
    try {
      return AuthorizationEntry(
        chainId: BigintUtils.fromBytes(JsonParser.valueAsBytes(serialized[0])),
        address: ETHAddress.fromBytes(JsonParser.valueAsBytes(serialized[1])),
        nonce: BigintUtils.fromBytes(JsonParser.valueAsBytes(serialized[2])),
        signature: IECDSASignature(
          r: JsonParser.valueAsBytes(serialized[4]),
          s: JsonParser.valueAsBytes(serialized[5]),
          recoveryId: IntUtils.fromBytes(
            JsonParser.valueAsBytes(serialized[3]),
          ),
        ),
      );
    } catch (e) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid AuthorizationEntry serialized.',
      );
    }
  }

  /// Serializes the authorization entry to a list of dynamic objects.
  List<dynamic> serialize() {
    final rId = signature.recoveryId;
    if (rId == null) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Missing signature recovery id.',
      );
    }
    return [
      ETHTransactionUtils.bigintToBytes(chainId),
      address.toBytes(),
      ETHTransactionUtils.bigintToBytes(nonce),
      ETHTransactionUtils.intToBytes(ETHTransactionUtils.getSignatureY(rId)),
      ETHTransactionUtils.trimLeadingZero(signature.r),
      ETHTransactionUtils.trimLeadingZero(signature.s),
    ];
  }

  /// Converts the authorization entry to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'address': address.address,
      "chainId": chainId.toHexaDecimal,
      "nonce": nonce.toHexaDecimal,
      "yParity": signature.recoveryId?.toHexaDecimal,
      "r": signature.r.toBigInt().toHexaDecimal,
      "s": signature.s.toBigInt().toHexaDecimal,
    };
  }

  @override
  String toString() {
    return '''
      AuthorizationEntry${toJson()}
    ''';
  }
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';
import 'package:on_chain/fil/src/serialization/seriaization.dart';
import 'package:on_chain/fil/src/types/types/token_amount.dart';

/// Unsigned Filecoin message (the on-chain transaction envelope).
///
/// Fields mirror the Lotus / go-state-types `types.Message` structure.
/// After gas estimation the message is signed by a [FilSigner] to produce
/// a [FilSignedMessage] that can be pushed to the mempool.
class FilMessage with FilSerialization {
  final BigInt? version;
  final FilAddress to;
  final FilAddress from;
  final BigInt nonce;
  final FilTokenAmount value;
  final BigInt gasLimit;
  final FilTokenAmount gasFeeCap;
  final FilTokenAmount gasPremium;
  final BigInt method;
  final BuBytes? params;
  FilMessage({
    BigInt? version,
    required this.to,
    required this.from,
    required BigInt nonce,
    required this.value,
    required this.gasLimit,
    required this.gasFeeCap,
    required this.gasPremium,
    required BigInt method,
    List<int>? params,
  }) : version = version?.asU64,
       nonce = nonce.asU64,
       method = method.asU64,
       params =
           params
               ?.max(
                 length: 2097152,
                 reason: "Invalid params bytes length.",
                 name: "params",
                 operation: "FilMessage",
               )
               .asImmutableBytes;
  factory FilMessage.fromJson(Map<String, dynamic> json) {
    return FilMessage(
      version: json.valueAsBigInt("Version"),
      to: FilAddress(json.valueAsString("To")),
      from: FilAddress(json.valueAsString("From")),
      nonce: json.valueAsBigInt("Nonce", onMissing: () => BigInt.zero),
      value: FilTokenAmount(json.valueAsBigInt("Value")),
      gasLimit: json.valueAsBigInt("GasLimit", onMissing: () => BigInt.zero),
      gasFeeCap: FilTokenAmount(json.valueAsBigInt("GasFeeCap")),
      gasPremium: FilTokenAmount(json.valueAsBigInt("GasPremium")),
      method: json.valueAsBigInt("Method", onMissing: () => BigInt.zero),
      params: json.valueAsBytes("Params", encoding: StringEncoding.base64),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      if (version != null) "Version": version,
      "To": to.address,
      "From": from.address,
      "Nonce": nonce,
      "Value": value.toJson(),
      "GasLimit": gasLimit,
      "GasFeeCap": gasFeeCap.toJson(),
      "GasPremium": gasPremium.toJson(),
      "Method": method,
      if (params != null)
        "Params": StringUtils.decode(params!, encoding: StringEncoding.base64),
    };
  }

  @override
  CborListValue<CborObject<Object?>> toCbor() {
    return CborSerializable.listFromObjects([
      (version ?? BigInt.zero).toSafeIntCbor(),
      to.toCbor(),
      from.toCbor(),
      nonce.toSafeIntCbor(),
      value.toCbor(),
      gasLimit.toSafeIntCbor(),
      gasFeeCap.toCbor(),
      gasPremium.toCbor(),
      method.toSafeIntCbor(),
      (params ?? <int>[]).toCborBytes(),
    ]);
  }
}

class FilSignedMessage with FilSerialization {
  final FilMessage message;
  final FilSignature signature;

  FilSignedMessage({required this.message, required this.signature});
  factory FilSignedMessage.fromJson(Map<String, dynamic> json) {
    return FilSignedMessage(
      message: json.valueTo<FilMessage, Map<String, dynamic>>(
        key: "Message",
        parse: (e) => FilMessage.fromJson(e),
      ),
      signature: json.valueTo<FilSignature, Map<String, dynamic>>(
        key: "Signature",
        parse: (e) => FilSignature.fromJson(e),
      ),
    );
  }

  @override
  CborListValue<CborObject<Object?>> toCbor() {
    return CborSerializable.listFromObjects([
      message.toCbor(),
      signature.toCbor(),
    ]);
  }

  Map<String, dynamic> toJson() => {
    "Signature": signature.toJson(),
    "Message": message.toJson(),
  };
}

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/serialization/seriaization.dart';
import 'package:on_chain/fil/src/types/message/message.dart';

enum FilecoinKeyType {
  secp256k1(1),
  bls12(2);

  final int value;
  const FilecoinKeyType(this.value);

  static FilecoinKeyType fromValue(int value) {
    return FilecoinKeyType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.filPlugin(
                "FilecoinKeyType.fromValue",
                reason: "Invalid Filecoin key type value.",
                details: {"value": "$value"},
              ),
    );
  }

  CryptoKeyType curveType() => switch (this) {
    FilecoinKeyType.secp256k1 => CryptoKeyType.secp256k1,
    FilecoinKeyType.bls12 => CryptoKeyType.bls12G1,
  };

  static FilecoinKeyType fromKeyType(CryptoKeyType type) {
    return values.firstWhere(
      (e) => e.curveType() == type,
      orElse:
          () =>
              throw OnChainErrors.filPlugin(
                "FilecoinKeyType.fromKeyType",
                reason: "Unsupported key type.",
                details: {"type": type.name},
              ),
    );
  }
}

typedef CbFilecoinSigner = Future<FilSigner> Function(FilAddress addr);

abstract class FilSigner {
  Future<FilSignature> signAsync(List<int> message);
  Future<FilSignedMessage> signFilMessage(FilMessage msg);
}

enum FilSigType {
  secp256k1(1),
  bls(2),
  delegated(3),

  unknown(255);

  final int value;
  const FilSigType(this.value);

  static FilSigType fromValue(int? value) {
    if (value == null || value > BinaryOps.mask8) {
      throw OnChainErrors.filPlugin(
        "FilSigType.fromValue",
        reason: "Invalid signature type.",
        details: {"value": "$value"},
      );
    }
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => FilSigType.unknown,
    );
  }
}

class FilSignature with FilSerialization {
  final FilSigType type;
  final BuBytes data;
  FilSignature({required this.type, required List<int> data})
    : data = data.asImmutableBytes;
  factory FilSignature.fromJson(Map<String, dynamic> json) {
    return FilSignature(
      type: FilSigType.fromValue(json.valueAsInt("Type")),
      data: json.valueAsBytes("Data", encoding: StringEncoding.base64),
    );
  }
  @override
  CborBytesValue toCbor() {
    return CborBytesValue([type.value, ...data]);
  }

  Map<String, dynamic> toJson() => {"Type": type.value, "Data": data};
}

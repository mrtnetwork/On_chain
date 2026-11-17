import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/ada/src/models/constants/constant.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/utils/utils.dart';

/// Evolving nonce type (used for Update's crypto)
class Nonce with InternalCborSerialization {
  final BuBytes? hash;
  Nonce([List<int>? nonce])
    : hash =
          nonce == null
              ? null
              : AdaTransactionUtils.validateFixedLengthBytes(
                bytes: nonce,
                length: AdaTransactionConstant.blake2b256DigestSize,
              );
  factory Nonce.deserialize(CborListValue cbor) {
    final int hasHash = cbor.objectAt<CborNumeric>(0).toInt();
    if (hasHash != 0 && hasHash != 1) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid Nonce cbor bytes.',
      );
    }
    return Nonce(hasHash == 0 ? null : cbor.rawValueAt(1));
  }
  factory Nonce.fromJson(Map<String, dynamic> json) {
    return Nonce(BytesUtils.tryFromHexString(json['hash']));
  }
  Nonce copyWith({List<int>? hash}) {
    return Nonce(hash ?? this.hash);
  }

  @override
  CborObject toCbor() {
    return CborListValue<CborObject>.definite([
      CborIntValue(hash == null ? 0 : 1),
      if (hash != null) CborBytesValue(hash!),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'hash': BytesUtils.tryToHexString(hash)};
  }
}

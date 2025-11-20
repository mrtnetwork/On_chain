import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/types/types.dart';
import 'package:on_chain/ada/src/exception/exception.dart';

import 'package:on_chain/ada/src/models/constants/constant.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/utils/utils.dart';

/// Evolving nonce type (used for Update's crypto)
class Nonce with InternalCborSerialization {
  final List<int>? hash;
  Nonce([List<int>? nonce])
      : hash = nonce == null
            ? null
            : AdaTransactionUtils.validateFixedLengthBytes(
                bytes: nonce,
                length: AdaTransactionConstant.blake2b256DigestSize);
  factory Nonce.deserialize(CborListValue cbor) {
    final int hasHash = cbor.elementAt<CborNumeric>(0).toInt();
    if (hasHash != 0 && hasHash != 1) {
      throw const ADAPluginException('Invalid Nonce cbor bytes.');
    }
    return Nonce(hasHash == 0 ? null : cbor.elementAtBytes(1));
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
      if (hash != null) CborBytesValue(hash!)
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'hash': BytesUtils.tryToHexString(hash)};
  }
}

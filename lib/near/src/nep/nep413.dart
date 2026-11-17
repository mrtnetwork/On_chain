import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

class Nep413Payload {
  // 2^31 + 413: makes the payload undecodable as a NEAR transaction.
  static const int messageTag = 2147484061;
  final String message;
  final BuBytes nonce;
  final String recipient;
  final String? callbackUrl;
  Nep413Payload({
    required this.message,
    required List<int> nonce,
    required this.recipient,
    this.callbackUrl,
  }) : nonce = nonce.asImmutableBytes;

  static void _writeU32(BytesBuilder builder, int value) {
    builder.add(IntUtils.toBytes(value, length: 4, byteOrder: Endian.little));
  }

  static void _writeString(BytesBuilder builder, String value) {
    final bytes = StringUtils.encode(value);
    _writeU32(builder, bytes.length);
    builder.add(bytes);
  }

  /// Borsh(tag) + Borsh(Payload{message, nonce[32], recipient, callbackUrl?}).
  List<int> toSerializeBytes() {
    if (nonce.length != 32) {
      throw OnChainErrors.nearPlugin(
        'Nep413Payload.toSerializeBytes',
        reason: 'NEP-413 nonce must be 32 bytes.',
        details: {'actual': '${nonce.length}'},
      );
    }
    final builder = BytesBuilder();
    _writeU32(builder, messageTag);
    _writeString(builder, message);
    builder.add(nonce);
    _writeString(builder, recipient);
    final callback = callbackUrl;
    if (callback == null) {
      builder.addByte(0);
    } else {
      builder.addByte(1);
      _writeString(builder, callback);
    }
    return builder.toBytes();
  }

  /// SHA-256 digest over the serialized bytes, ready for wallet signing.
  List<int> toDigest() => QuickCrypto.sha256Hash(toSerializeBytes());
}

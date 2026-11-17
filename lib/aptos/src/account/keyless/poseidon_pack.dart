import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';

/// Mirrors `@aptos-labs/ts-sdk` `poseidon.ts` exactly:
/// - 31 bytes per scalar, little-endian chunks,
/// - inputs padded with zeros to `maxSizeBytes`, original length appended,
/// - permutation itself is circomlib-compatible BN254 Poseidon routed
///   through `blockchainUtils.api` (shared backend — no duplicate
///   permutation code here).
class AptosKeylessPoseidon {
  /// 31 bytes packed per BN254 scalar.
  static const int bytesPackedPerScalar = 31;

  /// circomlib-compatible BN254 Poseidon over [fields], routed through
  /// `blockchainUtils.api` (Dart / native backends).
  static BigInt hashFields(List<BigInt> fields) {
    return BigintUtils.fromBytes(
      blockchainUtils.api.hash.poseidonBn254Hash([
        for (final f in fields)
          ...BigintUtils.toBytes(f, length: 32, byteOrder: Endian.little),
      ]),
      byteOrder: Endian.little,
    );
  }

  /// Little-endian bytes to [BigInt].
  static BigInt bytesToBigIntLE(List<int> bytes) {
    return BigintUtils.fromBytes(bytes, byteOrder: Endian.little);
  }

  /// [BigInt] to little-endian bytes of exactly [length].
  static List<int> bigIntToBytesLE(BigInt value, int length) {
    return BigintUtils.toBytes(
      value,
      length: length,
      byteOrder: Endian.little,
    ).toList();
  }

  /// Pads [bytes] with zeros to [maxSizeBytes], packs into 31-byte
  /// little-endian scalars and appends the original length.
  static List<BigInt> padAndPackBytesWithLen(
    List<int> bytes,
    int maxSizeBytes,
  ) {
    if (bytes.length > maxSizeBytes) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Keyless input longer than $maxSizeBytes bytes.',
        details: {'length': bytes.length.toString()},
      );
    }
    final padded = List<int>.filled(maxSizeBytes, 0);
    padded.setRange(0, bytes.length, bytes);
    final fields = <BigInt>[];
    for (int i = 0; i < padded.length; i += bytesPackedPerScalar) {
      final end =
          i + bytesPackedPerScalar > padded.length
              ? padded.length
              : i + bytesPackedPerScalar;
      fields.add(bytesToBigIntLE(padded.sublist(i, end)));
    }
    fields.add(BigintUtils.parse(bytes.length));
    return fields;
  }

  /// Hashes a UTF-8 string to a field element (length-checked packing).
  static BigInt hashStrToField(String str, int maxSizeBytes) {
    final bytes = StringUtils.encode(str);
    if (bytes.length > maxSizeBytes) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Keyless string longer than $maxSizeBytes bytes.',
        details: {'length': bytes.length.toString()},
      );
    }
    return hashFields(padAndPackBytesWithLen(bytes, maxSizeBytes));
  }
}

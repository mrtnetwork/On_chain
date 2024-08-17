part of "package:on_chain/solidity/abi/abi.dart";

/// ABICoder implementation for encoding and decoding byte arrays.
class BytesCoder implements ABICoder<List<int>> {
  /// Creates an instance of the BytesCoder class.
  const BytesCoder();

  /// Decodes a byte array from the given ABI-encoded bytes.
  @override
  DecoderResult<List<int>> decode(AbiParameter params, List<int> bytes) {
    int partsCount = 1;
    int consumed = 0;
    List<int> remainingBytes = List<int>.from(bytes);
    int? size = _ABIUtils.bytesSize(params.type);
    if (size == null) {
      final decode =
          const NumbersCoder().decode(AbiParameter.uint32, remainingBytes);
      consumed = decode.consumed;
      size = decode.result.toInt();
      partsCount = (size / ABIConst.uintBytesLength).ceil();
      remainingBytes = bytes.sublist(decode.consumed);
    }
    _ABIValidator.validateBytesLength(bytes, size);
    return DecoderResult(
        result: remainingBytes.sublist(0, size),
        consumed: consumed + partsCount * ABIConst.uintBytesLength,
        name: params.name);
  }

  /// Encodes a byte array to ABI-encoded bytes.
  @override
  EncoderResult abiEncode(AbiParameter params, List<int> input) {
    if (params.isDynamic) {
      final parseLength = (input.length / ABIConst.uintBytesLength).ceil();
      final encoded = List<int>.filled(
          ABIConst.uintBytesLength + parseLength * ABIConst.uintBytesLength, 0);
      final number = const NumbersCoder()
          .abiEncode(AbiParameter.uint32, BigInt.from(input.length))
          .encoded;
      encoded.setAll(0, number);
      encoded.setAll(ABIConst.uintBytesLength, input);
      return EncoderResult(
          isDynamic: true, encoded: encoded, name: params.name);
    }
    final size = _ABIUtils.bytesSize(params.type);
    _ABIValidator.validateBytes(params.type,
        bytes: input, minLength: size!, maxLength: size);
    final bytes = List<int>.filled(ABIConst.uintBytesLength, 0);
    bytes.setAll(0, input);
    return EncoderResult(isDynamic: false, encoded: bytes, name: params.name);
  }

  /// Legacy EIP-712 encoding for byte arrays.
  /// Optionally keeps the size unchanged based on the `keepSize` parameter.
  @override
  EncoderResult legacyEip712Encode(
      AbiParameter params, List<int> input, bool keepSize) {
    final size = _ABIUtils.bytesSize(params.type);
    if (size != null && input.length != size) {
      throw const SolidityAbiException("Invalid bytes length");
    }
    return EncoderResult(isDynamic: false, encoded: input, name: params.name);
  }
}

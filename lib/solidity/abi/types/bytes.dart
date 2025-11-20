part of 'package:on_chain/solidity/abi/abi.dart';

/// ABICoder implementation for encoding and decoding byte arrays.
class BytesCoder implements ABICoder<Object, List<int>> {
  /// Creates an instance of the BytesCoder class.
  const BytesCoder();

  /// Decodes a byte array from the given ABI-encoded bytes.
  @override
  DecoderResult<List<int>> decode(AbiParameter params, List<int> bytes) {
    int partsCount = 1;
    int consumed = 0;
    List<int> remainingBytes = List<int>.from(bytes);
    int? size = ABIUtils._bytesSize(params.type);
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
  EncoderResult abiEncode(AbiParameter params, Object input) {
    final inputAsBytes =
        JsonParser.valueAsBytes<List<int>>(input, allowHex: true);
    if (params.isDynamic) {
      final parseLength =
          (inputAsBytes.length / ABIConst.uintBytesLength).ceil();
      final encoded = List<int>.filled(
          ABIConst.uintBytesLength + parseLength * ABIConst.uintBytesLength, 0);
      final number = const NumbersCoder()
          .abiEncode(AbiParameter.uint32, BigInt.from(inputAsBytes.length))
          .encoded;
      encoded.setAll(0, number);
      encoded.setAll(ABIConst.uintBytesLength, inputAsBytes);
      return EncoderResult(
          isDynamic: true, encoded: encoded, name: params.name);
    }
    final size = ABIUtils._bytesSize(params.type);
    _ABIValidator.validateBytes(params.type,
        bytes: inputAsBytes, minLength: size!, maxLength: size);
    final bytes = List<int>.filled(ABIConst.uintBytesLength, 0);
    bytes.setAll(0, inputAsBytes);
    return EncoderResult(isDynamic: false, encoded: bytes, name: params.name);
  }

  /// Legacy EIP-712 encoding for byte arrays.
  /// Optionally keeps the size unchanged based on the `keepSize` parameter.
  @override
  EncoderResult encodePacked(AbiParameter params, Object input) {
    final inputAsBytes =
        JsonParser.valueAsBytes<List<int>>(input, allowHex: true);
    final size = ABIUtils._bytesSize(params.type);
    if (size != null && inputAsBytes.length != size) {
      throw const SolidityAbiException('Invalid bytes length');
    }
    return EncoderResult(
        isDynamic: false, encoded: inputAsBytes, name: params.name);
  }
}

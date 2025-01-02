part of 'package:on_chain/solidity/abi/abi.dart';

/// ABICoder implementation for encoding and decoding string types.
class StringCoder implements ABICoder<String> {
  /// Creates an instance of the StringCoder class.
  const StringCoder();

  /// Decodes a string value from the given ABI-encoded bytes.
  @override
  DecoderResult<String> decode(AbiParameter params, List<int> bytes) {
    final decode = const BytesCoder().decode(AbiParameter.bytes, bytes);
    return DecoderResult(
        result: StringUtils.decode(decode.result),
        consumed: decode.consumed,
        name: params.name);
  }

  /// Encodes a string value to ABI-encoded bytes.
  @override
  EncoderResult abiEncode(AbiParameter params, String input) {
    return const BytesCoder()
        .abiEncode(AbiParameter.bytes, StringUtils.encode(input));
  }

  /// Legacy EIP-712 encoding for string values.
  /// Optionally keeps the size unchanged based on the `keepSize` parameter.
  @override
  EncoderResult legacyEip712Encode(
      AbiParameter params, String input, bool keepSize) {
    return const BytesCoder().legacyEip712Encode(
        AbiParameter.bytes, StringUtils.encode(input), keepSize);
  }
}

part of "package:on_chain/solidity/abi/abi.dart";

/// ABICoder implementation for encoding and decoding function signatures (bytes).
class FunctionCoder implements ABICoder<List<int>> {
  /// Creates an instance of the FunctionCoder class.
  const FunctionCoder();

  /// Decodes a function signature (bytes) from the given ABI-encoded bytes.
  @override
  DecoderResult<List<int>> decode(AbiParameter params, List<int> bytes) {
    final decode = const BytesCoder().decode(AbiParameter.function, bytes);
    return DecoderResult(result: decode.result, consumed: decode.consumed);
  }

  /// Encodes a function signature (bytes) to ABI-encoded bytes.
  @override
  EncoderResult abiEncode(AbiParameter params, List<int> input) {
    return const BytesCoder().abiEncode(AbiParameter.function, input);
  }

  /// Legacy EIP-712 encoding for function signatures (bytes).
  /// Optionally keeps the size unchanged based on the `keepSize` parameter.
  @override
  EncoderResult legacyEip712Encode(
      AbiParameter params, List<int> input, bool keepSize) {
    return const BytesCoder()
        .legacyEip712Encode(AbiParameter.function, input, keepSize);
  }
}

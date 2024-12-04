part of "package:on_chain/solidity/abi/abi.dart";

/// ABICoder implementation for encoding and decoding tuple types.
class TupleCoder implements ABICoder<List<dynamic>> {
  /// Creates an instance of the TupleCoder class.
  const TupleCoder();

  /// Encodes a tuple of dynamic values to ABI-encoded bytes.
  @override
  EncoderResult abiEncode(AbiParameter params, List<dynamic> input) {
    bool isDynamic = false;
    final List<EncoderResult> encoded = [];
    if (input.length != params.components.length) {
      throw const SolidityAbiException("Invalid argument length detected.");
    }
    for (int i = 0; i < params.components.length; i++) {
      final paramComponent = params.components[i];
      final EncoderResult result = paramComponent.abiEncode(input[i]);
      if (result.isDynamic) {
        isDynamic = true;
      }
      encoded.add(result);
    }
    if (isDynamic) {
      return EncoderResult(
          isDynamic: true,
          encoded: _ABIUtils.encodeDynamicParams(encoded),
          name: params.name);
    }
    final re = encoded.map((e) => e.encoded).toList();
    return EncoderResult(
        isDynamic: false,
        encoded: [for (final i in re) ...i],
        name: params.name);
  }

  /// Decodes a tuple of dynamic values from the given ABI-encoded bytes.
  @override
  DecoderResult<List<dynamic>> decode(AbiParameter params, List<int> bytes) {
    int consumed = 0;

    if (params.components.isEmpty) {
      return DecoderResult(result: [], consumed: consumed, name: params.name);
    }
    int dynamicConsumed = 0;
    final List<dynamic> result = [];
    for (int index = 0; index < params.components.length; index++) {
      final AbiParameter childParam = params.components[index];
      DecoderResult<dynamic> decodedResult;

      if (childParam.isDynamic) {
        final DecoderResult<BigInt> offsetResult = const NumbersCoder()
            .decode(AbiParameter.uint32, bytes.sublist(consumed));

        decodedResult = _ABIUtils.decodeParamFromAbiParameter(
          childParam,
          bytes.sublist(offsetResult.result.toInt()),
        );

        consumed += offsetResult.consumed;
        dynamicConsumed += decodedResult.consumed;
      } else {
        decodedResult = _ABIUtils.decodeParamFromAbiParameter(
            childParam, bytes.sublist(consumed));
        consumed += decodedResult.consumed;
      }

      result.add(decodedResult.result);
    }
    return DecoderResult(
        result: result,
        consumed: consumed + dynamicConsumed,
        name: params.name);
  }

  /// Legacy EIP-712 encoding for tuple values.
  /// Optionally keeps the size unchanged based on the `keepSize` parameter.
  @override
  EncoderResult legacyEip712Encode(
      AbiParameter params, List<dynamic> input, bool keepSize) {
    final List<EncoderResult> encoded = [];
    if (input.length != params.components.length) {
      throw const SolidityAbiException("Invalid argument length detected.");
    }
    for (int i = 0; i < params.components.length; i++) {
      final paramComponent = params.components[i];
      final EncoderResult result =
          paramComponent.legacyEip712Encode(input[i], keepSize);
      encoded.add(result);
    }
    final re = encoded.map((e) => e.encoded).toList();
    return EncoderResult(
        isDynamic: false,
        encoded: [for (final i in re) ...i],
        name: params.name);
  }
}

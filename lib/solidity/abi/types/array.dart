part of "package:on_chain/solidity/abi/abi.dart";

/// ABICoder implementation for encoding and decoding arrays of arbitrary types.
class ArrayCoder implements ABICoder<List<dynamic>> {
  const ArrayCoder();

  /// Encodes a array of arbitrary types to ABI-encoded bytes.
  @override
  EncoderResult abiEncode(AbiParameter params, List<dynamic> input) {
    final param = _ABIUtils.toArrayType(params);
    final encodedParams = input.map((e) => param.item1.abiEncode(e)).toList();
    final dynamicItems =
        encodedParams.isNotEmpty && encodedParams.first.isDynamic;
    bool isDynamic = param.item2 == -1;
    if (!isDynamic && input.length != param.item2) {
      throw const SolidityAbiException("Invalid argument length detected.");
    }
    if (isDynamic || dynamicItems) {
      final encode = _ABIUtils.encodeDynamicParams(encodedParams);
      if (isDynamic) {
        final length = const NumbersCoder()
            .abiEncode(AbiParameter.uint256, BigInt.from(encodedParams.length))
            .encoded;
        return EncoderResult(
            isDynamic: true,
            encoded: encodedParams.isEmpty ? length : [...length, ...encode],
            name: params.name);
      }
      return EncoderResult(isDynamic: true, encoded: encode, name: params.name);
    }
    final resultBytes = encodedParams.map((e) => e.encoded);
    return EncoderResult(
        isDynamic: false,
        encoded: [for (final i in resultBytes) ...i],
        name: params.name);
  }

  /// Decodes an ABI-encoded array of arbitrary types.
  @override
  DecoderResult<List<dynamic>> decode(AbiParameter params, List<int> bytes) {
    final extract = _ABIUtils.toArrayType(params);
    int consumed = 0;
    int size = extract.item2;
    List<int> remainingBytes = List<int>.from(bytes);
    List<dynamic> result = [];
    if (size.isNegative) {
      final length = const NumbersCoder().decode(AbiParameter.uint32, bytes);
      size = length.result.toInt();
      consumed = length.consumed;
      remainingBytes = bytes.sublist(length.consumed);
    }
    if (extract.item1.isDynamic) {
      for (int i = 0; i < size; i += 1) {
        final decodeOffset = const NumbersCoder().decode(AbiParameter.uint32,
            remainingBytes.sublist(i * ABIConst.uintBytesLength));
        consumed += decodeOffset.consumed;
        final decodeChild = _ABIUtils.decodeParamFromAbiParameter(
            extract.item1, remainingBytes.sublist(decodeOffset.result.toInt()));
        consumed += decodeChild.consumed;
        result.add(decodeChild.result);
      }
      return DecoderResult(
          result: result, consumed: consumed, name: params.name);
    }
    for (int i = 0; i < size; i++) {
      final decodeChild = _ABIUtils.decodeParamFromAbiParameter(
          extract.item1, bytes.sublist(consumed));
      consumed += decodeChild.consumed;
      result.add(decodeChild.result);
    }
    return DecoderResult(result: result, consumed: consumed, name: params.name);
  }

  /// Legacy EIP-712 encoding for arrays of arbitrary types.
  /// Optionally keeps the size unchanged based on the `keepSize` parameter.
  @override
  EncoderResult legacyEip712Encode(
      AbiParameter params, List<dynamic> input, bool keepSize) {
    final param = _ABIUtils.toArrayType(params);
    final encodedParams =
        input.map((e) => param.item1.legacyEip712Encode(e, true)).toList();
    final resultBytes = encodedParams.map((e) => e.encoded);
    return EncoderResult(
        isDynamic: false,
        encoded: [for (final i in resultBytes) ...i],
        name: params.name);
  }
}

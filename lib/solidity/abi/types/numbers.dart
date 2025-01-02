part of 'package:on_chain/solidity/abi/abi.dart';

/// ABICoder implementation for encoding and decoding numeric types represented by BigInt.
class NumbersCoder implements ABICoder<BigInt> {
  /// Creates an instance of the NumbersCoder class.
  const NumbersCoder();

  /// Decodes a numeric value (BigInt) from the given ABI-encoded bytes.
  @override
  DecoderResult<BigInt> decode(AbiParameter params, List<int> bytes) {
    _ABIValidator.validateBytesLength(bytes, ABIConst.uintBytesLength);
    final sign = _ABIValidator.isSignNumber(params.type);
    final nBytes = bytes.sublist(0, ABIConst.uintBytesLength);
    final big = BigintUtils.fromBytes(nBytes, sign: sign);
    _ABIValidator.isValidNumber(params.type, big);
    return DecoderResult(
        result: big, consumed: ABIConst.uintBytesLength, name: params.name);
  }

  /// Encodes a numeric value (BigInt) to ABI-encoded bytes.
  @override
  EncoderResult abiEncode(AbiParameter params, BigInt input) {
    _ABIValidator.isValidNumber(params.type, input);
    return EncoderResult(
        isDynamic: false,
        encoded: BigintUtils.toBytes(input, length: 32),
        name: params.name);
  }

  /// Legacy EIP-712 encoding for numeric values (BigInt).
  /// Optionally keeps the size unchanged based on the `keepSize` parameter.
  @override
  EncoderResult legacyEip712Encode(
      AbiParameter params, BigInt input, bool keepSize) {
    _ABIValidator.isValidNumber(params.type, input);
    final size = _ABIUtils.numericSize(params.type) ?? 32;
    return EncoderResult(
        isDynamic: false,
        encoded: BigintUtils.toBytes(input.toUnsigned(size * 8),
            length: keepSize ? 32 : size),
        name: params.name);
  }
}

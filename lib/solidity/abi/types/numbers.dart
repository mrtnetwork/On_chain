part of 'package:on_chain/solidity/abi/abi.dart';

/// ABICoder implementation for encoding and decoding numeric types represented by BigInt.
class NumbersCoder implements ABICoder<Object, BigInt> {
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
  EncoderResult abiEncode(AbiParameter params, Object input) {
    final number = BigintUtils.parse(input, allowHex: false);
    _ABIValidator.isValidNumber(params.type, number);
    return EncoderResult(
        isDynamic: false,
        encoded: BigintUtils.toBytes(number, length: 32),
        name: params.name);
  }

  /// Legacy EIP-712 encoding for numeric values (BigInt).
  /// Optionally keeps the size unchanged based on the `keepSize` parameter.
  @override
  EncoderResult encodePacked(AbiParameter params, Object input) {
    final number = BigintUtils.parse(input, allowHex: false);
    _ABIValidator.isValidNumber(params.type, number);
    final size = ABIUtils._numericSize(params.type) ?? 32;
    return EncoderResult(
        isDynamic: false,
        encoded: BigintUtils.toBytes(number.toUnsigned(size * 8), length: size),
        name: params.name);
  }
}

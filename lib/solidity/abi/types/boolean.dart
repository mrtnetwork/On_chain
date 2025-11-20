part of 'package:on_chain/solidity/abi/abi.dart';

/// ABICoder implementation for encoding and decoding boolean values.
class BooleanCoder implements ABICoder<bool, bool> {
  /// Creates an instance of the BooleanCoder class.
  const BooleanCoder();

  /// Decodes a boolean value from the given ABI-encoded bytes.
  /// Validates the decoded value using _ABIValidator.
  @override
  DecoderResult<bool> decode(AbiParameter params, List<int> bytes) {
    final toBigInt =
        BigintUtils.fromBytes(bytes.sublist(0, ABIConst.uintBytesLength));
    _ABIValidator.validateBoolean(params, toBigInt);
    return DecoderResult(
        result: toBigInt == BigInt.one,
        consumed: ABIConst.uintBytesLength,
        name: params.name);
  }

  /// Encodes a boolean value to ABI-encoded bytes.
  @override
  EncoderResult abiEncode(AbiParameter params, bool input) {
    final bytes = List<int>.filled(ABIConst.uintBytesLength, 0);
    if (input) {
      bytes[bytes.length - 1] = 1;
    }
    return EncoderResult(isDynamic: false, encoded: bytes, name: params.name);
  }

  /// Legacy EIP-712 encoding for boolean values.
  /// Optionally keeps the size unchanged based on the `keepSize` parameter.
  @override
  EncoderResult encodePacked(AbiParameter params, bool input) {
    // if (keepSize) {
    //   return abiEncode(params, input);
    // }
    final bytes = List<int>.filled(1, 0);
    bytes[0] = input ? 1 : 0;
    return EncoderResult(isDynamic: false, encoded: bytes, name: params.name);
  }
}

part of 'package:on_chain/solidity/abi/abi.dart';

/// ABICoder implementation for encoding and decoding Ethereum and Tron addresses.
class AddressCoder implements ABICoder<Object> {
  /// Creates an instance of the AddressCoder class.
  const AddressCoder();

  /// Constant defining the length of Ethereum and Tron addresses in bytes.
  static const int addrLength = 20;

  /// Decodes a BaseHexAddress from the given ABI-encoded bytes.
  /// Supports both Ethereum and Tron address formats based on the `tronTypes` flag.
  @override
  DecoderResult<SolidityAddress> decode(AbiParameter params, List<int> bytes) {
    final addrBytes = bytes.sublist(
        ABIConst.uintBytesLength - addrLength, ABIConst.uintBytesLength);
    return DecoderResult(
        result: SolidityAddress.fromBytes(addrBytes),
        consumed: ABIConst.uintBytesLength,
        name: params.name);
  }

  List<int> _addressToBytes(Object object) {
    try {
      if (object is SolidityAddress) {
        return object.toBytes();
      } else if (object is List<int>) {
        return object.asImmutableBytes;
      } else if (object is String) {
        return BytesUtils.fromHexString(object);
      }
    } catch (_) {}
    throw SolidityAbiException(
        'Invalid address format: Expected a SolidityAddress, '
        'List<int>, or a hexadecimal String. ',
        details: {"address": object});
  }

  /// Encodes a BaseHexAddress to ABI-encoded bytes.
  /// The resulting bytes include Ethereum or Tron address bytes
  @override
  EncoderResult abiEncode(AbiParameter params, Object input) {
    final bytes = List<int>.filled(ABIConst.uintBytesLength, 0);
    List<int> addrBytes = _addressToBytes(input);
    if (addrBytes.length == TronAddress.lengthInBytes) {
      addrBytes = addrBytes.sublist(TronAddress.lengthInBytes - addrLength);
    }
    bytes.setAll(ABIConst.uintBytesLength - addrLength, addrBytes);
    return EncoderResult(isDynamic: false, encoded: bytes, name: params.name);
  }

  /// Legacy EIP-712 encoding for BaseHexAddress.
  /// Optionally keeps the size unchanged based on the `keepSize` parameter.
  @override
  EncoderResult legacyEip712Encode(
      AbiParameter params, Object input, bool keepSize) {
    if (keepSize) return abiEncode(params, input);
    final asBytes = _addressToBytes(input);
    List<int> addrBytes = asBytes;
    addrBytes = addrBytes.sublist(addrBytes.length - addrLength);
    return EncoderResult(isDynamic: false, encoded: asBytes, name: params.name);
  }
}

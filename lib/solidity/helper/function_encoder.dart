import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solidity/abi/abi.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/contract/fragments.dart';

/// Base contract for a typed Solidity function encoder/decoder.
///
/// [Input] is the typed call parameters (use [Null] when the function
/// takes no arguments) and [Output] is the typed return value
/// (use [Null] when the function has no outputs).
///
/// Each known function (ERC-20/721/1155, ERC-165, ...) gets a small
/// concrete subclass that only describes how its typed input/output maps
/// to the raw ABI positional params. Encoding, decoding, selectors and
/// hex variants are shared here.
abstract class SolidityFunctionEncoder<
  Input extends Object?,
  Output extends Object?
> {
  const SolidityFunctionEncoder();

  /// The underlying ABI fragment (selector, inputs, outputs).
  AbiFunctionFragment get fragment;

  /// Typed input -> positional ABI params for [AbiFunctionFragment.encode].
  List<dynamic> toAbiInput(Input input);

  /// Positional ABI params from [AbiFunctionFragment.decodeInput] -> typed input.
  Input fromAbiInput(List<dynamic> values);

  /// Typed output -> positional ABI params (used by [encodeOutput]).
  List<dynamic> toAbiOutput(Output output);

  /// Positional ABI params from [AbiFunctionFragment.decodeOutput] -> typed output.
  Output fromAbiOutput(List<dynamic> values);

  /// 4-byte selector of the function.
  BuBytes get selector => fragment.selector;

  /// Hex selector (no `0x` prefix, same as [BytesUtils.toHexString]).
  String get selectorHex => BytesUtils.toHexString(selector);

  /// Canonical signature, e.g. `transfer(address,uint256)`.
  String get functionSignature => fragment.functionName;

  /// Encode a call (selector + ABI-encoded params).
  BuBytes encode(Input input) {
    return fragment.encode(toAbiInput(input));
  }

  /// Encode a call as hex string (no `0x` prefix handling left to caller).
  String encodeHex(Input input, [bool withSelector = true]) {
    return fragment.encodeHex(toAbiInput(input), withSelector);
  }

  /// Decode calldata (with or without selector) back to typed input.
  Input decodeInput(List<int> data) {
    return fromAbiInput(fragment.decodeInput(data));
  }

  /// Hex variant of [decodeInput].
  Input decodeInputHex(String data) {
    return decodeInput(BytesUtils.fromHexString(data));
  }

  /// Decode raw return data (output bytes, no selector) to typed output.
  Output decodeOutput(List<int> data) {
    return fromAbiOutput(fragment.decodeOutput(data));
  }

  /// Hex variant of [decodeOutput].
  Output decodeOutputHex(String data) {
    return decodeOutput(BytesUtils.fromHexString(data));
  }

  /// Encode a return value (no selector). Useful for tests/mocks.
  BuBytes encodeOutput(Output output) {
    final params = toAbiOutput(output);
    if (fragment.outputs.isEmpty) {
      if (params.isNotEmpty) {
        throw const BuError(
          OnChainErrorType.solidityAbi,
          'Function has no outputs but values were provided.',
        );
      }
      return BuBytes.empty();
    }
    if (fragment.outputs.length != params.length) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Function expects ${fragment.outputs.length} outputs, got ${params.length}.',
      );
    }
    return AbiParameter(
      name: '',
      type: 'tuple',
      components: List<AbiParameter>.from(fragment.outputs),
    ).abiEncode(params).encoded.asImmutableBytes;
  }
}

/// Convenience for parameter-less functions (`Input == Null`).
///
/// Allows `const ERC20SymbolEncoder().encodeCall()` instead of
/// `encode(null)`.
extension SolidityParameterlessEncoderX<Output extends Object?>
    on SolidityFunctionEncoder<Null, Output> {
  BuBytes encodeCall() => encode(null);
  String encodeCallHex() => encodeHex(null);
}

/// Selector helpers (moved from the old `SolidityContractUtils`).
class SoliditySelector {
  const SoliditySelector._();

  static const int abiSelectorLength = ABIConst.selectorLength;

  static List<int>? getSelector(List<int> data) {
    if (data.length >= abiSelectorLength) {
      return data.sublist(0, abiSelectorLength);
    }
    return null;
  }

  static String? getSelectorHex(String dataHex) {
    return getSelectorHexFromBytes(BytesUtils.fromHexString(dataHex));
  }

  static String? getSelectorHexFromBytes(List<int> data) {
    final selector = getSelector(data);
    if (selector == null) return null;
    return BytesUtils.toHexString(selector);
  }
}

/// Shared parsing helpers for concrete encoders.
class SolidityCodec {
  const SolidityCodec._();

  static BigInt asBigInt(Object? value) {
    return JsonParser.valueAs<BigInt>(value);
  }

  static List<BigInt> asBigIntList(Object? value) {
    final list = JsonParser.valueAsList<List>(value);
    return list.map(asBigInt).toList();
  }

  static String asString(Object? value) {
    return JsonParser.valueAs<String>(value);
  }

  static bool asBool(Object? value) {
    return JsonParser.valueAs<bool>(value);
  }

  static SolidityAddress asAddress(Object? value) {
    if (value is SolidityAddress) return value;
    if (value is List<int>) return SolidityAddress.fromBytes(value);
    return SolidityAddress(JsonParser.valueAs<String>(value, asBytes: false));
  }

  static List<int> asBytes(Object? value) {
    return JsonParser.valueAs<List<int>>(value, asBytes: true);
  }

  static T single<T extends Object?>(List<dynamic> values, int index) {
    return JsonParser.valueAs<T>(values[index]);
  }
}

/// Base contract for a typed Solidity event decoder.
abstract class SolidityEventDecoder<Event extends Object?> {
  const SolidityEventDecoder();

  AbiEventFragment get fragment;

  Event fromDecodedValues(List<dynamic> values);

  Event decodeEvent(List<int> data, List<List<int>?> topics) {
    return fromDecodedValues(fragment.decode(data, topics));
  }

  String get signatureHex => fragment.signatureHex;
  String get eventSignature => fragment.eventName;
}

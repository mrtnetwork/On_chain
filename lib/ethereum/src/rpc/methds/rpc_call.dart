import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/contract/fragments.dart';

/// Executes a new message call immediately, without creating a transaction on the block chain.
/// The eth_call method can be used to query internal contract state, to execute validations
///   coded into a contract or even to test what the effect of a transaction would be without running it live.
/// [geth.ethereum.org](https://geth.ethereum.org/docs/interacting-with-geth/rpc/ns-eth#eth-call)
class EthereumRequestCall extends EthereumRequest<Object?, String?> {
  EthereumRequestCall._(this.contractAddress, this.raw, this.from,
      this._function, BlockTagOrNumber? blockNumber)
      : super(blockNumber: blockNumber);
  factory EthereumRequestCall.fromRaw(
      {required String contractAddress,
      required String raw,
      String? from,
      BlockTagOrNumber? blockNumber = BlockTagOrNumber.latest}) {
    return EthereumRequestCall._(contractAddress, raw, from, null, blockNumber);
  }
  @Deprecated("Use EthereumRequestFunctionCall instead.")
  factory EthereumRequestCall.fromMethod(
      {required String contractAddress,
      required AbiFunctionFragment function,
      required List<dynamic> params,
      String? from,
      BlockTagOrNumber? blockNumber = BlockTagOrNumber.latest}) {
    final rawBytes = function.encode(params);

    return EthereumRequestCall._(
        contractAddress,
        BytesUtils.toHexString(rawBytes, prefix: '0x'),
        from,
        function,
        blockNumber);
  }
  // EthereumRequestCall.fromM
  @override
  String get method => EthereumMethods.call.value;

  final String contractAddress;
  final String? from;
  final String raw;
  final AbiFunctionFragment? _function;

  @override
  dynamic onResonse(result) {
    if (_function != null) {
      return _function.decodeOutput(BytesUtils.fromHexString(result ?? ''));
    }

    return super.onResonse(result);
  }

  @override
  List<dynamic> toJson() {
    return [
      {
        'to': contractAddress,
        'data': raw,
        if (from != null) 'from': from,
      },
      blockNumber
    ];
  }
}

class EthereumRequestFunctionCall
    extends EthereumRequest<List<dynamic>, String?> {
  EthereumRequestFunctionCall(
      {required this.contractAddress,
      required this.function,
      List<dynamic>? params,
      this.from,
      super.blockNumber = BlockTagOrNumber.latest})
      : raw =
            BytesUtils.toHexString(function.encode(params ?? []), prefix: "0x");
  @override
  String get method => EthereumMethods.call.value;

  final String contractAddress;
  final String? from;
  final String raw;
  final AbiFunctionFragment function;

  @override
  List<dynamic> onResonse(String? result) {
    try {
      return function.decodeOutput(BytesUtils.fromHexString(result ?? ''));
    } catch (e) {
      print("error $result ${function.functionName} $contractAddress $raw");
      return [BigInt.zero];
    }
  }

  /// 0x70a0823100000000000000000000000095f56aa4472a0a9f290fa5b25a86e6a53e
  @override
  List<dynamic> toJson() {
    return [
      {'to': contractAddress, 'data': raw, if (from != null) 'from': from},
      blockNumber
    ];
  }
}

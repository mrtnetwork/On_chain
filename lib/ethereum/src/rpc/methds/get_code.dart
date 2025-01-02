import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns code at a given address.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getCode)
class EthereumRequestGetCode extends EthereumRequest<String?, String?> {
  EthereumRequestGetCode({
    required this.address,
    BlockTagOrNumber? tag = BlockTagOrNumber.pending,
  }) : super(blockNumber: tag);

  /// eth_getCode
  @override
  String get method => EthereumMethods.getCode.value;

  /// address
  final String address;

  @override
  List<dynamic> toJson() {
    return [address, blockNumber];
  }

  @override
  String? onResonse(result) {
    if (result == '0x') return null;
    return super.onResonse(result);
  }

  @override
  String toString() {
    return 'EthereumRequestGetCode{${toJson()}}';
  }
}

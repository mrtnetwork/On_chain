import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

class EthereumRequestERC20Decimals extends EthereumRequest<int?, String> {
  EthereumRequestERC20Decimals(this.contractAddress,
      {BlockTagOrNumber? blockNumber})
      : super(blockNumber: blockNumber ?? BlockTagOrNumber.latest);

  @override
  String get method => EthereumMethods.call.value;

  final SolidityAddress contractAddress;

  static const ERC20DecimalsEncoder _encoder = ERC20DecimalsEncoder();

  @override
  int? onResponse(result) {
    if (result == "0x") return null;
    return _encoder.decodeOutputHex(result).toInt();
  }

  @override
  List<dynamic> toJson() {
    return [
      {
        "to": contractAddress.toSolidityHex(),
        "data": BytesUtils.toHexString(_encoder.encodeCall(), prefix: "0x"),
      },
      blockNumber
    ];
  }
}

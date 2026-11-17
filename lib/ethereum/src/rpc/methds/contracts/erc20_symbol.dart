import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

class EthereumRequestERC20Symbol extends EthereumRequest<String?, String?> {
  EthereumRequestERC20Symbol(
    this.contractAddress, {
    BlockTagOrNumber? blockNumber,
  }) : super(blockNumber: blockNumber ?? BlockTagOrNumber.pending);

  @override
  String get method => EthereumMethods.call.value;

  final SolidityAddress contractAddress;

  static const ERC20SymbolEncoder _encoder = ERC20SymbolEncoder();

  @override
  String? onResponse(result) {
    if (result == null || result == "0x") return null;
    return _encoder.decodeOutputHex(result);
  }

  @override
  List<dynamic> toJson() {
    return [
      {
        "to": contractAddress.toSolidityHex(),
        "data": BytesUtils.toHexString(_encoder.encodeCall(), prefix: "0x"),
      },
      blockNumber,
    ];
  }
}

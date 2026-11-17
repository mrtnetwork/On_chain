import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

class EthereumRequestERC20Name extends EthereumRequest<String?, String?> {
  EthereumRequestERC20Name(this.contractAddress, {super.blockNumber});

  @override
  String get method => EthereumMethods.call.value;

  final SolidityAddress contractAddress;

  static const ERC20NameEncoder _encoder = ERC20NameEncoder();

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
      blockNumber
    ];
  }
}

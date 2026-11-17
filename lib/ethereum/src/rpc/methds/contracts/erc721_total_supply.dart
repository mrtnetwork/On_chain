import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

/// Returns the total supply (ERC-721 Enumerable). Reverts when unsupported.
class EthereumRequestERC721TotalSupply extends EthereumRequest<BigInt, String> {
  EthereumRequestERC721TotalSupply(this.contractAddress, {super.blockNumber});

  @override
  String get method => EthereumMethods.call.value;

  final SolidityAddress contractAddress;

  static const ERC721TotalSupplyEncoder _encoder = ERC721TotalSupplyEncoder();

  @override
  BigInt onResponse(result) {
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

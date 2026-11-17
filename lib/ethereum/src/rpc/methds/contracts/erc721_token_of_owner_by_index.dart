import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

/// Returns the token id owned by [owner] at [index]
/// (ERC-721 Enumerable). Reverts out of range.
class EthereumRequestERC721TokenOfOwnerByIndex
    extends EthereumRequest<BigInt, String> {
  EthereumRequestERC721TokenOfOwnerByIndex(
      this.contractAddress, this.owner, this.index,
      {super.blockNumber});

  @override
  String get method => EthereumMethods.call.value;

  final SolidityAddress contractAddress;
  final SolidityAddress owner;
  final BigInt index;

  static const ERC721TokenOfOwnerByIndexEncoder _encoder =
      ERC721TokenOfOwnerByIndexEncoder();

  @override
  BigInt onResponse(result) {
    return _encoder.decodeOutputHex(result);
  }

  @override
  List<dynamic> toJson() {
    return [
      {
        "to": contractAddress.toSolidityHex(),
        "data": BytesUtils.toHexString(
            _encoder.encode((owner: owner, index: index)),
            prefix: "0x"),
      },
      blockNumber
    ];
  }
}

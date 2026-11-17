import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

/// Returns the owner of an ERC-721 token, or null when the call reverts
/// (unknown contract or token id) or the result is not an address.
///
/// The ABI decoder yields a [SolidityAddress] for `address` outputs, so
/// the response maps it straight to [ETHAddress].
class EthereumRequestERC721OwnerOf
    extends EthereumRequest<ETHAddress?, String?> {
  EthereumRequestERC721OwnerOf(this.contractAddress, this.tokenId,
      {super.blockNumber});

  @override
  String get method => EthereumMethods.call.value;

  final SolidityAddress contractAddress;
  final BigInt tokenId;

  static const ERC721OwnerOfEncoder _encoder = ERC721OwnerOfEncoder();

  @override
  ETHAddress? onResponse(result) {
    if (result == null || result == "0x") return null;
    return _encoder.decodeOutputHex(result).toEthereumAddress();
  }

  @override
  List<dynamic> toJson() {
    return [
      {
        "to": contractAddress.toSolidityHex(),
        "data": BytesUtils.toHexString(_encoder.encode(tokenId), prefix: "0x"),
      },
      blockNumber
    ];
  }
}

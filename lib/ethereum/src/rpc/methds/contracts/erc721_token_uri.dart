import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

/// ERC-721 `tokenURI(tokenId)`. Null when the call reverts, returns empty
/// data, or the result is not a string.
class EthereumRequestERC721TokenUri
    extends EthereumRequest<String?, String?> {
  EthereumRequestERC721TokenUri(this.contractAddress, this.tokenId,
      {super.blockNumber = BlockTagOrNumber.latest});

  @override
  String get method => EthereumMethods.call.value;

  final SolidityAddress contractAddress;
  final BigInt tokenId;

  static const ERC721TokenUriEncoder _encoder = ERC721TokenUriEncoder();

  @override
  String? onResponse(result) {
    if (result == null || result == "0x") return null;
    final uri = _encoder.decodeOutputHex(result);
    if (uri.isEmpty) return null;
    return uri;
  }

  @override
  List<dynamic> toJson() {
    return [
      {
        "to": contractAddress.toSolidityHex(),
        "data":
            BytesUtils.toHexString(_encoder.encode(tokenId), prefix: "0x"),
      },
      blockNumber
    ];
  }
}

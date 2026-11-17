import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

/// ERC-165 `supportsInterface(bytes4)`. Takes the raw interface id hex
/// (e.g. `"0xd9b67a26"`); callers map their own standard enum to ids.
class EthereumRequestSupportsInterface extends EthereumRequest<bool, String> {
  EthereumRequestSupportsInterface({
    required this.interfaceId,
    required this.contractAddress,
    required this.from,
    super.blockNumber = BlockTagOrNumber.latest,
  });

  @override
  String get method => EthereumMethods.call.value;
  final SolidityAddress from;

  final SolidityAddress contractAddress;

  /// Hex interface id, e.g. `"0x80ac58cd"` for ERC-721.
  final String interfaceId;

  static const SupportsInterfaceEncoder _encoder = SupportsInterfaceEncoder();

  @override
  bool onResponse(result) {
    return _encoder.decodeOutputHex(result);
  }

  @override
  List<dynamic> toJson() {
    final data = BytesUtils.toHexString(
      _encoder.encode(BytesUtils.fromHexString(interfaceId)),
      prefix: "0x",
    );
    return [
      {
        "from": from.toSolidityHex(),
        "to": contractAddress.toSolidityHex(),
        "data": data,
      },
      blockNumber,
    ];
  }
}

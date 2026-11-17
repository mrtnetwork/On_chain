import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

/// Returns the ERC-1155 balance of [accountAddress] for [tokenId].
class EthereumRequestERC1155BalanceOf
    extends EthereumRequest<BigInt, String> {
  EthereumRequestERC1155BalanceOf(
      this.contractAddress, this.accountAddress, this.tokenId,
      {super.blockNumber});

  @override
  String get method => EthereumMethods.call.value;

  final SolidityAddress contractAddress;
  final SolidityAddress accountAddress;
  final BigInt tokenId;

  static const ERC1155BalanceOfEncoder _encoder = ERC1155BalanceOfEncoder();

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
            _encoder.encode((account: accountAddress, id: tokenId)),
            prefix: "0x"),
      },
      blockNumber
    ];
  }
}

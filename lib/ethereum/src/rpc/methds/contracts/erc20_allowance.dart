import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

/// `allowance(owner,spender) -> uint256`.
class EthereumRequestERC20Allowance extends EthereumRequest<BigInt, String> {
  EthereumRequestERC20Allowance(
    this.contractAddress,
    this.owner,
    this.spender, {
    super.blockNumber,
  });

  @override
  String get method => EthereumMethods.call.value;

  final SolidityAddress contractAddress;
  final SolidityAddress owner;
  final SolidityAddress spender;

  static const ERC20AllowanceEncoder _encoder = ERC20AllowanceEncoder();

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
          _encoder.encode((owner: owner, spender: spender)),
          prefix: "0x",
        ),
      },
      blockNumber,
    ];
  }
}

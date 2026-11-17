import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

class EthereumRequestERC20Balance extends EthereumRequest<BigInt, String> {
  EthereumRequestERC20Balance(
    this.contractAddress,
    this.accountAddress, {
    BlockTagOrNumber? blockNumber,
  }) : super(blockNumber: blockNumber ?? BlockTagOrNumber.latest);

  @override
  String get method => EthereumMethods.call.value;

  final String contractAddress;
  final SolidityAddress accountAddress;

  static const ERC20BalanceOfEncoder _encoder = ERC20BalanceOfEncoder();

  @override
  BigInt onResponse(result) {
    return _encoder.decodeOutputHex(result);
  }

  @override
  List<dynamic> toJson() {
    return [
      {
        "to": contractAddress,
        "data": BytesUtils.toHexString(
          _encoder.encode(accountAddress),
          prefix: "0x",
        ),
      },
      blockNumber,
    ];
  }
}

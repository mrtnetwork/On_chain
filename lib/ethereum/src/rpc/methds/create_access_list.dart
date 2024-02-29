import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/ethereum/src/models/access_list.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// This method creates an EIP2930 type accessList based on a given Transaction.
/// The accessList contains all storage slots and addresses read and written by
/// the transaction, except for the sender account and the precompiles.
/// This method uses the same transaction call object and blockNumberOrTag object as eth_call.
/// An accessList can be used to unstuck contracts that became inaccessible due to gas cost increases.
/// [geth.ethereum.org](https://geth.ethereum.org/docs/interacting-with-geth/rpc/ns-eth#eth-createaccesslist)
class RPCCreateAccessList
    extends ETHRPCRequest<Tuple<List<AccessListEntry>, BigInt>> {
  RPCCreateAccessList({
    required this.transaction,

    /// Optional, blocknumber or latest or pending
    BlockTagOrNumber? blockNumber = BlockTagOrNumber.pending,
  }) : super(blockNumber: blockNumber);

  /// eth_createAccessList
  @override
  EthereumMethods get method => EthereumMethods.createAccessList;

  /// TransactionCall object
  final Map<String, dynamic> transaction;

  @override
  List<dynamic> toJson() {
    return [transaction, blockNumber];
  }

  /// The method eth_createAccessList returns list of addresses and storage keys used by the transaction, plus the gas consumed when the access list is added.
  @override
  Tuple<List<AccessListEntry>, BigInt> onResonse(result) {
    return Tuple(
        (result["accessList"] as List)
            .map((e) => AccessListEntry.fromJson(e))
            .toList(),
        ETHRPCRequest.onBigintResponse(result["gasUsed"]));
  }
}

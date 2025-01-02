import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Queries a contract's information from the blockchain. The difference from the wallet/getcontract interface is that this interface returns not only the bytecode but also the runtime bytecode of the contract.
/// Compared with bytecode, runtime bytecode does not contain constructor and constructor parameter information.
/// [developers.tron.network](https://developers.tron.network/reference/getcontractinfo).
class TronRequestGetContractInfo
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetContractInfo({required this.value, this.visible = true});

  /// Contract address
  final TronAddress value;
  @override
  final bool visible;

  /// wallet/getcontractinfo
  @override
  TronHTTPMethods get method => TronHTTPMethods.getcontractinfo;

  @override
  Map<String, dynamic> toJson() {
    return {'value': value.toAddress(visible), 'visible': visible};
  }

  @override
  String toString() {
    return 'TronRequestGetContractInfo{${toJson()}}';
  }
}

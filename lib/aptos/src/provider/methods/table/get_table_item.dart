import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Get a table item at a specific ledger version from the table identified by {table_handle} in the path and the
/// \"key\" (TableItemRequest) provided in the request body.This is a POST endpoint because the \"key\"
/// for requesting a specifictable item (TableItemRequest) could be quite complex, as each of its
/// fields could themselves be composed of other structs. This makes itimpractical to express using query params,
/// meaning GET isn't an option.The Aptos nodes prune account state history, via a configurable time window.
/// If the requested ledger version has been pruned, the server responds with a 410.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetTableItem extends AptosPostRequest<dynamic, dynamic> {
  /// Table handle hex encoded 32-byte string
  final AptosAddress tableHandle;

  /// Ledger version to get state of accountIf not provided, it will be the latest version
  final BigInt? ledgerVersion;

  final TableItemRequestParams data;
  AptosRequestGetTableItem(
      {required this.tableHandle, required this.data, this.ledgerVersion});

  @override
  String get method => AptosApiMethod.getTableItem.url;

  @override
  List<String> get pathParameters => [tableHandle.address];

  @override
  Map<String, String?> get queryParameters =>
      {"ledger_version": ledgerVersion?.toString()};

  @override
  Map<String, dynamic> get body => data.toJson();
}

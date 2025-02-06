import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';

/// Get a table item at a specific ledger version from the table identified by {table_handle}in
/// the path and the \"key\" (RawTableItemRequest) provided in the request body.The `get_raw_table_item`
/// requires only a serialized key comparing to the full move type informationcomparing
/// to the `get_table_item` api, and can only return the query in the bcs format.
/// The Aptos nodes prune account state history, via a configurable time window.
/// If the requested ledger version has been pruned, the server responds with a 410.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetRawTableItem extends AptosPostRequest<dynamic, dynamic> {
  /// Table handle hex encoded 32-byte string
  final AptosAddress tableHandle;

  /// Ledger version to get state of accountIf not provided, it will be the latest version
  final BigInt? ledgerVersion;

  /// All bytes (Vec) data is represented as hex-encoded string prefixed with 0x
  /// and fulfilled with two hex digits per byte. Unlike the Address type, HexEncodedBytes will not trim any zeros.
  final String key;
  AptosRequestGetRawTableItem(
      {required this.tableHandle, required this.key, this.ledgerVersion});

  @override
  String get method => AptosApiMethod.getRawTableItem.url;

  @override
  List<String> get pathParameters => [tableHandle.toString()];

  @override
  Map<String, String?> get queryParameters =>
      {"ledger_version": ledgerVersion?.toString()};

  @override
  Map<String, dynamic> get body => {"key": key};
}

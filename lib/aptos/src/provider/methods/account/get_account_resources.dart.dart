import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Retrieves all account resources for a given account and a specific ledger version.
/// If the ledger version is not specified in the request, the latest ledger version is used
/// The Aptos nodes prune account state history, via a configurable time window.
/// If the requested ledger version has been pruned, the server responds with a 410.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetAccountResources extends AptosRequest<
    List<AptosApiMoveResource>, List<Map<String, dynamic>>> {
  AptosRequestGetAccountResources(
      {required this.address, this.ledgetVersion, this.start, this.limit});

  /// Address of account with or without a `0x` prefix
  final AptosAddress address;

  /// Ledger version to get state of accountIf not provided, it will be the latest version
  final BigInt? ledgetVersion;

  /// Cursor specifying where to start for paginationThis cursor cannot be derived manually client-side.
  /// Instead, you mustcall this endpoint once without this query parameter specified,
  /// andthen use the cursor returned in the X-Aptos-Cursor header in theresponse.
  final String? start;

  /// Max number of account resources to retrieveIf not provided, defaults to default page size.
  final int? limit;

  @override
  String get method => AptosApiMethod.getAccountResources.url;

  @override
  List<String> get pathParameters => [address.address];
  @override
  Map<String, String?> get queryParameters => {
        "ledger_version": ledgetVersion?.toString(),
        "start": start,
        "limit": limit?.toString()
      };

  @override
  List<AptosApiMoveResource> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => AptosApiMoveResource.fromJson(e)).toList();
  }
}

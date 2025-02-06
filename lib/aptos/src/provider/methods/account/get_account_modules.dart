import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/models/types.dart';

/// Retrieves all account modules' bytecode for a given account at a specific ledger version.
/// If the ledger version is not specified in the request, the latest ledger version is used.
/// The Aptos nodes prune account state history, via a configurable time window.
/// If the requested ledger version has been pruned, the server responds with a 410.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetAccountModules extends AptosRequest<
    List<AptosApiMoveModuleByteCode>, List<Map<String, dynamic>>> {
  AptosRequestGetAccountModules(
      {required this.address, this.ledgetVersion, this.start, this.limit});
  final AptosAddress address;

  /// Address of account with or without a `0x` prefix
  final BigInt? ledgetVersion;

  /// Cursor specifying where to start for paginationThis cursor cannot be
  /// derived manually client-side. Instead, you mustcall this endpoint once
  /// without this query parameter specified, andthen use the cursor returned
  /// in the X-Aptos-Cursor header in theresponse.
  final String? start;

  /// Max number of account modules to retrieveIf not provided, defaults to default page size.
  final int? limit;
  @override
  String get method => AptosApiMethod.getAccountModules.url;

  @override
  List<String> get pathParameters => [address.toString()];
  @override
  Map<String, String?> get queryParameters => {
        "ledgetVersion": ledgetVersion?.toString(),
        "start": start,
        "limit": limit?.toString()
      };

  @override
  List<AptosApiMoveModuleByteCode> onResonse(
      List<Map<String, dynamic>> result) {
    return result.map((e) => AptosApiMoveModuleByteCode.fromJson(e)).toList();
  }
}

import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Retrieves an individual resource from a given account and at a specific ledger version.
/// If theledger version is not specified in the request, the latest ledger version is used.
/// The Aptos nodes prune account state history, via a configurable time window.
/// If the requested ledger version has been pruned, the server responds with a 410.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetAccountResource
    extends AptosRequest<AptosApiMoveResource, Map<String, dynamic>> {
  AptosRequestGetAccountResource(
      {required this.address, required this.resourceType, this.ledgetVersion});

  /// Address of account with or without a `0x` prefix
  final AptosAddress address;

  /// Name of struct to retrieve e.g. `0x1::account::Account`
  final String resourceType;

  /// Ledger version to get state of accountIf not provided, it will be the latest version
  final BigInt? ledgetVersion;

  @override
  String get method => AptosApiMethod.getAccountResource.url;

  @override
  List<String> get pathParameters => [address.toString(), resourceType];
  @override
  Map<String, String?> get queryParameters =>
      {"ledger_version": ledgetVersion?.toString()};

  @override
  AptosApiMoveResource onResonse(Map<String, dynamic> result) {
    return AptosApiMoveResource.fromJson(result);
  }
}

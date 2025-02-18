import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Retrieves an individual module from a given account and at a specific ledger version.
/// If theledger version is not specified in the request, the latest ledger version is used.
/// The Aptos nodes prune account state history, via a configurable time window.
/// If the requested ledger version has been pruned, the server responds with a 410.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetAccountModule
    extends AptosRequest<AptosApiMoveModuleByteCode, Map<String, dynamic>> {
  AptosRequestGetAccountModule(
      {required this.address, required this.moduleName, this.ledgetVersion});

  /// Address of account with or without a `0x` prefix
  final AptosAddress address;

  /// Name of module to retrieve e.g. `coin`
  final String moduleName;

  /// Ledger version to get state of accountIf not provided, it will be the latest version
  final BigInt? ledgetVersion;

  @override
  String get method => AptosApiMethod.getAccountModule.url;

  @override
  List<String> get pathParameters => [address.toString(), moduleName];
  @override
  Map<String, String?> get queryParameters =>
      {"ledger_version": ledgetVersion?.toString()};

  @override
  AptosApiMoveModuleByteCode onResonse(Map<String, dynamic> result) {
    return AptosApiMoveModuleByteCode.fromJson(result);
  }
}

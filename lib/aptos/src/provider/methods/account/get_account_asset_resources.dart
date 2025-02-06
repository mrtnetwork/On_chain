import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';

/// Retrieves all account resources for a given account and a specific ledger version.
/// If the ledger version is not specified in the request, the latest ledger version is used
/// The Aptos nodes prune account state history, via a configurable time window.
/// If the requested ledger version has been pruned, the server responds with a 410.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetAccountAssetResources
    extends AptosRequest<BigInt, dynamic> {
  AptosRequestGetAccountAssetResources({
    required this.address,
    required this.assetType,
    this.ledgetVersion,
  });

  /// Address of account with or without a `0x` prefix
  final AptosAddress address;
  final String assetType;

  /// Ledger version to get state of accountIf not provided, it will be the latest version
  final BigInt? ledgetVersion;

  @override
  String get method => AptosApiMethod.getAccountResources2.url;

  @override
  List<String> get pathParameters => [address.toString(), assetType];
  @override
  Map<String, String?> get queryParameters => {
        "ledger_version": ledgetVersion?.toString(),
      };

  @override
  BigInt onResonse(result) {
    return BigintUtils.parse(result);
  }
}

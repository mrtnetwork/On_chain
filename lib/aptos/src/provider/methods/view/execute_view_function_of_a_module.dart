import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/provider/constant/constants.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';
import 'package:on_chain/aptos/src/transaction/types/types.dart';

/// Execute the Move function with the given parameters and return its execution result.
/// The Aptos nodes prune account state history, via a configurable time window.
/// If the requested ledger version has been pruned, the server responds with a 410.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestExecuteViewFunctionOfaModule<T>
    extends AptosPostRequest<List<T>, List<dynamic>> {
  /// Ledger version to get state of accountIf not provided, it will be the latest version
  final BigInt? ledgerVersion;

  AptosRequestExecuteViewFunctionOfaModule.json(
      {required ExecuteViewFunctionOfAModuleRequestParams data,
      this.ledgerVersion})
      : body = data.toJson(),
        headers = null;
  AptosRequestExecuteViewFunctionOfaModule.bcs(
      {required AptosTransactionEntryFunction entry, this.ledgerVersion})
      : body = entry.toBcs(),
        headers = {
          "Content-Type": AptosProviderConst.viewFunctionBcsContentType
        };
  AptosRequestExecuteViewFunctionOfaModule.bcsBytes(
      {required List<int> bcsBytes, this.ledgerVersion})
      : body = bcsBytes.asImmutableBytes,
        headers = {
          "Content-Type": AptosProviderConst.viewFunctionBcsContentType
        };

  @override
  String get method => AptosApiMethod.executeViewFunctionOfAModule.url;
  @override
  final Map<String, String>? headers;

  @override
  Map<String, String?> get queryParameters =>
      {"ledger_version": ledgerVersion?.toString()};

  @override
  final Object body;

  @override
  List<T> onResonse(List result) {
    if (BigInt.zero is T) {
      return result.map((e) => BigintUtils.tryParse(e)).toList().cast<T>();
    }
    if (0 is T) {
      return result.map((e) => IntUtils.tryParse(e)).toList().cast<T>();
    }
    if (<String, dynamic>{} is T) {
      return result
          .map((e) => (e == null) ? null : (e as Map).cast<String, dynamic>())
          .toList()
          .cast<T>();
    }
    return result.cast<T>();
  }
}

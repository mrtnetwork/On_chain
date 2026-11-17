import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Retrieves persisted auxiliary information (such as transaction indices
/// within blocks) for transactions in a given version range.
/// If the version range has been pruned, a 410 will be returned.

/// [aptos documentation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetTransactionsAuxiliaryInfo
    extends
        AptosRequest<
          List<AptosApiPersistedAuxiliaryInfo>,
          List<Map<String, dynamic>>
        > {
  AptosRequestGetTransactionsAuxiliaryInfo({
    required this.startVersion,
    this.limit,
  });

  /// Starting ledger version to retrieve auxiliary info for.
  final BigInt startVersion;

  /// Max number of transactions to retrieve auxiliary info for.
  final int? limit;

  @override
  String get method => AptosApiMethod.getTransactionsAuxiliaryInfo.url;

  @override
  Map<String, String?> get queryParameters => {
    "start_version": startVersion.toString(),
    "limit": limit?.toString(),
  };

  @override
  List<AptosApiPersistedAuxiliaryInfo> onResponse(
    List<Map<String, dynamic>> result,
  ) {
    return result
        .map((e) => AptosApiPersistedAuxiliaryInfo.fromJson(e))
        .toList();
  }
}

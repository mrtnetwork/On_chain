import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Retrieves summaries of on-chain committed transactions (both sequence
/// number based and orderless transactions) from an account.
/// Each summary contains the sender address, transaction hash, version and
/// replay protector, ordered ascending by version.

/// [aptos documentation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetAccountTransactionSummaries
    extends
        AptosRequest<
          List<AptosApiTransactionSummary>,
          List<Map<String, dynamic>>
        > {
  AptosRequestGetAccountTransactionSummaries({
    required this.address,
    this.startVersion,
    this.endVersion,
    this.limit,
  });

  /// Address of account with or without a `0x` prefix
  final AptosAddress address;

  /// Starting ledger version. If provided, output starts from that version.
  final BigInt? startVersion;

  /// Ending ledger version. Used when [startVersion] is not provided.
  final BigInt? endVersion;

  /// Max number of summaries to retrieve.
  final int? limit;

  @override
  String get method => AptosApiMethod.getAccountTransactionSummaries.url;

  @override
  List<String> get pathParameters => [address.address];
  @override
  Map<String, String?> get queryParameters => {
    "start_version": startVersion?.toString(),
    "end_version": endVersion?.toString(),
    "limit": limit?.toString(),
  };

  @override
  List<AptosApiTransactionSummary> onResponse(
    List<Map<String, dynamic>> result,
  ) {
    return result.map((e) => AptosApiTransactionSummary.fromJson(e)).toList();
  }
}

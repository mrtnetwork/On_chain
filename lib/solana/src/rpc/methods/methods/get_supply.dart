import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns information about the current supply.
/// https://solana.com/docs/rpc/http/getsupply
class SolanaRequestGetSupply
    extends SolanaRequest<SupplyResponse, Map<String, dynamic>> {
  const SolanaRequestGetSupply({
    this.excludeNonCirculatingAccountsList,
    super.commitment,
  });

  /// getSupply
  @override
  String get method => SolanaRequestMethods.getSupply.value;

  /// exclude non circulating accounts list from response
  final bool? excludeNonCirculatingAccountsList;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        {'excludeNonCirculatingAccountsList': excludeNonCirculatingAccountsList}
      ])
    ];
  }

  @override
  SupplyResponse onResonse(Map<String, dynamic> result) {
    return SupplyResponse.fromJson(result);
  }
}

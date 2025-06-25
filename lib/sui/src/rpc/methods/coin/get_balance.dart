import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the total coin balance for one coin type, owned by the address owner.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getbalance)
class SuiRequestGetBalance
    extends SuiRequest<SuiApiBalanceResponse, Map<String, dynamic>> {
  const SuiRequestGetBalance({required this.owner, this.coinType});

  /// The owner's Sui address
  final SuiAddress owner;

  /// Optional type names for the coin (e.g., 0x168da5bf1f48dafc111b0a488fa454aca95e0b5e::usdc::USDC), default to 0x2::sui::SUI if not specified.
  final String? coinType;

  @override
  String get method => 'suix_getBalance';

  @override
  List<dynamic> toJson() {
    return [owner.address, coinType];
  }

  @override
  SuiApiBalanceResponse onResonse(Map<String, dynamic> result) {
    return SuiApiBalanceResponse.fromJson(result);
  }
}

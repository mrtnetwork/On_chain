import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return metadata (e.g., symbol, decimals) for a coin.
/// Note that if the coin's metadata was wrapped in the transaction that published its marker type,
/// or the latest version of the metadata object is wrapped or deleted, it will not be found.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getcoinmetadata)
class SuiRequestGetCoinMetadata
    extends SuiRequest<SuiApiCoinMetadataResponse?, Map<String, dynamic>?> {
  const SuiRequestGetCoinMetadata({required this.coinType});

  /// Type name for the coin (e.g., 0x168da5bf1f48dafc111b0a488fa454aca95e0b5e::usdc::USDC)
  final String coinType;

  @override
  String get method => 'suix_getCoinMetadata';

  @override
  List<dynamic> toJson() {
    return [coinType];
  }

  @override
  SuiApiCoinMetadataResponse? onResonse(Map<String, dynamic>? result) {
    if (result == null) return null;
    return SuiApiCoinMetadataResponse.fromJson(result);
  }
}

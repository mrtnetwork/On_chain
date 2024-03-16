import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Transactions on the address.
/// https://blockfrost.dev/api/address-transactions
class BlockfrostRequestAddressTransactions extends BlockforestRequestParam<
    List<ADATransactionSummaryInfoResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAddressTransactions(this.address,
      {BlockforestRequestTransactionFilterParams? filter});

  final ADAAddress address;

  /// Address transactions
  @override
  String get method => BlockfrostMethods.addressTransactions.url;

  @override
  List<String> get pathParameters => [address.bech32Address];

  @override
  List<ADATransactionSummaryInfoResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADATransactionSummaryInfoResponse.fromJson(e)).toList();
  }
}

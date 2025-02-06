import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the list of objects owned by an address. Note that if the address owns more
/// than QUERY_MAX_RESULT_LIMIT objects, the pagination is not accurate,
/// because previous page may have been updated when the next page is fetched.
/// Please use suix_queryObjects if this is a concern.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getownedobjects)
class SuiRequestGetOwnedObjects
    extends SuiRequest<SuiApiPaginatedObjectResponse, Map<String, dynamic>> {
  const SuiRequestGetOwnedObjects(
      {required this.address, this.query, super.pagination});

  /// The owner's Sui address
  final SuiAddress address;

  ///  The objects query criteria.
  final SuiApiObjectResponseQuery? query;

  @override
  String get method => 'suix_getOwnedObjects';

  @override
  List<dynamic> toJson() {
    return [address.toString(), query?.toJson(), ...pagination?.toJson() ?? []];
  }

  @override
  SuiApiPaginatedObjectResponse onResonse(Map<String, dynamic> result) {
    return SuiApiPaginatedObjectResponse.fromJson(result);
  }
}

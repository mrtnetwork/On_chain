import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// AptosGraphQLEvent types are globally identifiable by an account `address` andmonotonically increasing `creationNumber`,
/// one per event type emittedto the given account. This API returns events corresponding to thatthat event type.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetEventsByCreationNumber
    extends AptosRequest<List<AptosApiEvent>, List<Map<String, dynamic>>> {
  AptosRequestGetEventsByCreationNumber(
      {required this.address,
      required this.creationNumber,
      this.start,
      this.limit});

  /// Hex-encoded 32 byte Aptos account, with or without a `0x` prefix,
  /// for which events are queried. This refers to the account that events wereemitted to,
  /// not the account hosting the move module that emits thatevent type.
  final AptosAddress address;

  /// Creation number corresponding to the event stream originatingfrom the given account.
  final BigInt creationNumber;

  /// Starting sequence number of events.If unspecified, by default will retrieve the most recent events
  final BigInt? start;

  /// Max number of events to retrieve.If unspecified, defaults to default page size
  final int? limit;

  @override
  String get method => AptosApiMethod.getEventsByCreationNumber.url;

  @override
  List<String> get pathParameters =>
      [address.address, creationNumber.toString()];
  @override
  Map<String, String?> get queryParameters =>
      {"start": start?.toString(), "limit": limit?.toString()};

  @override
  List<AptosApiEvent> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => AptosApiEvent.fromJson(e)).toList();
  }
}

import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// This API uses the given account `address`, `eventHandle`, and `fieldName`to build a key that
/// can globally identify an event types. It then uses thiskey to return events emitted to
/// the given account matching that event type.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetEventsByEventHandle
    extends AptosRequest<List<AptosApiEvent>, List<Map<String, dynamic>>> {
  AptosRequestGetEventsByEventHandle(
      {required this.address,
      required this.eventHandle,
      required this.fieldName,
      this.start,
      this.limit});

  /// Hex-encoded 32 byte Aptos account, with or without a `0x` prefix,
  /// for which events are queried. This refers to the account that events wereemitted to,
  /// not the account hosting the move module that emits that event type.
  final AptosAddress address;

  /// Name of struct to lookup event handle e.g. `0x1::account::Account`.
  final String eventHandle;

  /// Name of field to lookup event handle e.g. `withdraw_events`
  final String fieldName;

  /// Starting sequence number of events.If unspecified, by default will retrieve the most recent
  final BigInt? start;

  /// Max number of events to retrieve.If unspecified, defaults to default page size
  final int? limit;

  @override
  String get method => AptosApiMethod.getEventsByEventHandle.url;

  @override
  List<String> get pathParameters =>
      [address.toString(), eventHandle, fieldName];
  @override
  Map<String, String?> get queryParameters =>
      {"start": start?.toString(), "limit": limit?.toString()};

  @override
  List<AptosApiEvent> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => AptosApiEvent.fromJson(e)).toList();
  }
}

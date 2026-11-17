import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/schedules
class HederaMirrorRequestGetSchedules
    extends
        HederaMirrorRequest<
          HederaMirrorTypesSchedulesResponse,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesEntityIdQuery? accountId;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final HederaMirrorTypesEntityIdQuery? scheduleId;

  const HederaMirrorRequestGetSchedules({
    this.accountId,
    this.limit,
    this.order,
    this.scheduleId,
  });

  @override
  String? get path => '/api/v1/schedules';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account.id': accountId,
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'schedule.id': scheduleId,
  };

  @override
  HederaMirrorTypesSchedulesResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesSchedulesResponse.fromJson(result);
  }
}

/// GET /api/v1/schedules/{scheduleId}
class HederaMirrorRequestGetSchedule
    extends
        HederaMirrorRequest<HederaMirrorTypesSchedule, Map<String, dynamic>> {
  final HederaMirrorTypesEntityId scheduleId;

  const HederaMirrorRequestGetSchedule({required this.scheduleId});

  @override
  String? get path => '/api/v1/schedules/$scheduleId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  HederaMirrorTypesSchedule onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesSchedule.fromJson(result);
  }
}

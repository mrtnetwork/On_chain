import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/topics/{topicId}
class HederaMirrorRequestGetTopic
    extends HederaMirrorRequest<HederaMirrorTypesTopic, Map<String, dynamic>> {
  final HederaMirrorTypesEntityId topicId;

  const HederaMirrorRequestGetTopic({required this.topicId});

  @override
  String? get path => '/api/v1/topics/$topicId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  HederaMirrorTypesTopic onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesTopic.fromJson(result);
  }
}

import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/topics/{topicId}/messages
class HederaMirrorRequestGetTopicMessages
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTopicMessagesResponse,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesEntityId topicId;
  final String? encoding;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final int? sequencenumber;
  final List<String>? timestamp;

  const HederaMirrorRequestGetTopicMessages({
    required this.topicId,
    this.encoding,
    this.limit,
    this.order,
    this.sequencenumber,
    this.timestamp,
  });

  @override
  String? get path => '/api/v1/topics/$topicId/messages';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'encoding': encoding,
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'sequencenumber': sequencenumber?.toString(),
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesTopicMessagesResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesTopicMessagesResponse.fromJson(result);
  }
}

/// GET /api/v1/topics/{topicId}/messages/{sequenceNumber}
class HederaMirrorRequestGetTopicMessageByIdAndSequenceNumber
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTopicMessage,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesEntityId topicId;
  final int sequenceNumber;

  const HederaMirrorRequestGetTopicMessageByIdAndSequenceNumber({
    required this.topicId,
    required this.sequenceNumber,
  });

  @override
  String? get path => '/api/v1/topics/$topicId/messages/$sequenceNumber';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  HederaMirrorTypesTopicMessage onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesTopicMessage.fromJson(result);
  }
}

/// GET /api/v1/topics/messages/{timestamp}
class HederaMirrorRequestGetTopicMessageByTimestamp
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTopicMessage,
          Map<String, dynamic>
        > {
  final String timestamp;

  const HederaMirrorRequestGetTopicMessageByTimestamp({
    required this.timestamp,
  });

  @override
  String? get path => '/api/v1/topics/messages/$timestamp';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  HederaMirrorTypesTopicMessage onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesTopicMessage.fromJson(result);
  }
}

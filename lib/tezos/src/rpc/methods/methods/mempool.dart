// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/rpc/core/core.dart';
import 'package:on_chain/tezos/src/rpc/types/types/mempool.dart';

/// POST /chains/{chain_id}/mempool/ban_operation
class OctezMempoolRequestBanOperation
    extends OctezMempoolRequest<dynamic, dynamic> {
  final String chainId;
  final OctezMempoolUnistring requestBody;

  const OctezMempoolRequestBanOperation({
    this.chainId = 'main',
    required this.requestBody,
  });

  @override
  String? get path => '/chains/$chainId/mempool/ban_operation';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /chains/{chain_id}/mempool/filter
class OctezMempoolRequestFilter extends OctezMempoolRequest<dynamic, dynamic> {
  final String includeDefault;
  final String chainId;

  const OctezMempoolRequestFilter({
    required this.includeDefault,
    this.chainId = 'main',
  });

  @override
  String? get path => '/chains/$chainId/mempool/filter';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {
    'include_default': includeDefault,
  };

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// POST /chains/{chain_id}/mempool/filter
class OctezMempoolRequestPostFilter
    extends OctezMempoolRequest<dynamic, dynamic> {
  final String chainId;
  final dynamic requestBody;

  const OctezMempoolRequestPostFilter({
    this.chainId = 'main',
    required this.requestBody,
  });

  @override
  String? get path => '/chains/$chainId/mempool/filter';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /chains/{chain_id}/mempool/monitor_operations
class OctezMempoolRequestMonitorOperations
    extends
        OctezMempoolRequest<
          List<OctezMempoolResponseMonitorOperationsItem>,
          List<dynamic>
        > {
  final String version;
  final String validated;
  final String refused;
  final String outdated;
  final String branchRefused;
  final String branchDelayed;
  final String? validationPass;
  final String? sources;
  final String chainId;

  const OctezMempoolRequestMonitorOperations({
    required this.version,
    required this.validated,
    required this.refused,
    required this.outdated,
    required this.branchRefused,
    required this.branchDelayed,
    this.validationPass,
    this.sources,
    this.chainId = 'main',
  });

  @override
  String? get path => '/chains/$chainId/mempool/monitor_operations';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'version': version,
    'validated': validated,
    'refused': refused,
    'outdated': outdated,
    'branch_refused': branchRefused,
    'branch_delayed': branchDelayed,
    'validation_pass': validationPass,
    'sources': sources,
  };

  @override
  List<OctezMempoolResponseMonitorOperationsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezMempoolResponseMonitorOperationsItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/mempool/pending_operations
class OctezMempoolRequestPendingOperations
    extends
        OctezMempoolRequest<
          OctezMempoolResponsePendingOperations,
          Map<String, dynamic>
        > {
  final String? version;
  final String? validated;
  final String? refused;
  final String? outdated;
  final String? branchRefused;
  final String? branchDelayed;
  final String? validationPass;
  final String? source;
  final String? operationHash;
  final String chainId;

  const OctezMempoolRequestPendingOperations({
    this.version,
    this.validated,
    this.refused,
    this.outdated,
    this.branchRefused,
    this.branchDelayed,
    this.validationPass,
    this.source,
    this.operationHash,
    this.chainId = 'main',
  });

  @override
  String? get path => '/chains/$chainId/mempool/pending_operations';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'version': version,
    'validated': validated,
    'refused': refused,
    'outdated': outdated,
    'branch_refused': branchRefused,
    'branch_delayed': branchDelayed,
    'validation_pass': validationPass,
    'source': source,
    'operation_hash': operationHash,
  };

  @override
  OctezMempoolResponsePendingOperations onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezMempoolResponsePendingOperations.fromJson(result);
  }
}

/// POST /chains/{chain_id}/mempool/request_operations
class OctezMempoolRequestRequestOperations
    extends
        OctezMempoolRequest<
          OctezMempoolResponseRequestOperations,
          Map<String, dynamic>
        > {
  final String? peerId;
  final String chainId;
  final OctezMempoolResponseRequestOperations requestBody;

  const OctezMempoolRequestRequestOperations({
    this.peerId,
    this.chainId = 'main',
    required this.requestBody,
  });

  @override
  String? get path => '/chains/$chainId/mempool/request_operations';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'peer_id': peerId};

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezMempoolResponseRequestOperations onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezMempoolResponseRequestOperations.fromJson(result);
  }
}

/// POST /chains/{chain_id}/mempool/unban_all_operations
class OctezMempoolRequestUnbanAllOperations
    extends OctezMempoolRequest<dynamic, dynamic> {
  final String chainId;
  final OctezMempoolResponseRequestOperations requestBody;

  const OctezMempoolRequestUnbanAllOperations({
    this.chainId = 'main',
    required this.requestBody,
  });

  @override
  String? get path => '/chains/$chainId/mempool/unban_all_operations';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// POST /chains/{chain_id}/mempool/unban_operation
class OctezMempoolRequestUnbanOperation
    extends OctezMempoolRequest<dynamic, dynamic> {
  final String chainId;
  final OctezMempoolUnistring requestBody;

  const OctezMempoolRequestUnbanOperation({
    this.chainId = 'main',
    required this.requestBody,
  });

  @override
  String? get path => '/chains/$chainId/mempool/unban_operation';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

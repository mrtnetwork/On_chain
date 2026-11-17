// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/rpc/core/core.dart';
import 'package:on_chain/tezos/src/rpc/types/types/rollup.dart';

/// DELETE /admin/batcher/queue
class OctezRollupRequestAdminBatcherQueue
    extends OctezRollupRequest<dynamic, dynamic> {
  final String? orderBelow;
  final String dropNoOrder;

  const OctezRollupRequestAdminBatcherQueue({
    this.orderBelow,
    required this.dropNoOrder,
  });

  @override
  String? get path => '/admin/batcher/queue';

  @override
  RequestMethod get requestMethod => RequestMethod.delete;

  @override
  Map<String, String?> get queryParameters => {
    'order_below': orderBelow,
    'drop_no_order': dropNoOrder,
  };

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /admin/cancel_gc
class OctezRollupRequestAdminCancelGc extends OctezRollupRequest<bool, bool> {
  const OctezRollupRequestAdminCancelGc();

  @override
  String? get path => '/admin/cancel_gc';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  bool onResponse(bool result) {
    return result;
  }
}

/// GET /admin/injector/queues
class OctezRollupRequestAdminInjectorQueues
    extends
        OctezRollupRequest<
          List<OctezRollupResponseAdminInjectorQueuesItem>,
          List<dynamic>
        > {
  final String? tag;

  const OctezRollupRequestAdminInjectorQueues({this.tag});

  @override
  String? get path => '/admin/injector/queues';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'tag': tag};

  @override
  List<OctezRollupResponseAdminInjectorQueuesItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezRollupResponseAdminInjectorQueuesItem.fromJson(e))
        .toList();
  }
}

/// DELETE /admin/injector/queues
class OctezRollupRequestDeleteAdminInjectorQueues
    extends OctezRollupRequest<dynamic, dynamic> {
  final String? orderBelow;
  final String? tag;
  final String dropNoOrder;

  const OctezRollupRequestDeleteAdminInjectorQueues({
    this.orderBelow,
    this.tag,
    required this.dropNoOrder,
  });

  @override
  String? get path => '/admin/injector/queues';

  @override
  RequestMethod get requestMethod => RequestMethod.delete;

  @override
  Map<String, String?> get queryParameters => {
    'order_below': orderBelow,
    'tag': tag,
    'drop_no_order': dropNoOrder,
  };

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /admin/injector/queues/total
class OctezRollupRequestAdminInjectorQueuesTotal
    extends
        OctezRollupRequest<
          OctezRollupResponseAdminInjectorQueuesTotal,
          Map<String, dynamic>
        > {
  const OctezRollupRequestAdminInjectorQueuesTotal();

  @override
  String? get path => '/admin/injector/queues/total';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseAdminInjectorQueuesTotal onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezRollupResponseAdminInjectorQueuesTotal.fromJson(result);
  }
}

/// GET /config
class OctezRollupRequestConfig
    extends
        OctezRollupRequest<OctezRollupResponseConfig, Map<String, dynamic>> {
  const OctezRollupRequestConfig();

  @override
  String? get path => '/config';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseConfig onResponse(Map<String, dynamic> result) {
    return OctezRollupResponseConfig.fromJson(result);
  }
}

/// GET /describe
class OctezRollupRequestDescribe
    extends OctezRollupRequest<OctezRollupServiceTree, dynamic> {
  final String recurse;

  const OctezRollupRequestDescribe({required this.recurse});

  @override
  String? get path => '/describe';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'recurse': recurse};

  @override
  OctezRollupServiceTree onResponse(dynamic result) {
    return OctezRollupServiceTree.fromJson(result);
  }
}

/// GET /global/block/{block_id}
class OctezRollupRequestGlobalBlockBlockId
    extends
        OctezRollupRequest<
          OctezRollupResponseGlobalBlockBlockId,
          Map<String, dynamic>
        > {
  final String blockId;
  final String outbox;

  const OctezRollupRequestGlobalBlockBlockId({
    required this.blockId,
    required this.outbox,
  });

  @override
  String? get path => '/global/block/$blockId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'outbox': outbox};

  @override
  OctezRollupResponseGlobalBlockBlockId onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezRollupResponseGlobalBlockBlockId.fromJson(result);
  }
}

/// GET /global/block/{block_id}/committed_status
class OctezRollupRequestGlobalBlockBlockIdCommittedStatus
    extends
        OctezRollupRequest<
          OctezRollupResponseGlobalBlockBlockIdCommittedStatus,
          dynamic
        > {
  final String blockId;

  const OctezRollupRequestGlobalBlockBlockIdCommittedStatus({
    required this.blockId,
  });

  @override
  String? get path => '/global/block/$blockId/committed_status';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseGlobalBlockBlockIdCommittedStatus onResponse(
    dynamic result,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdCommittedStatus.fromJson(
      result,
    );
  }
}

/// GET /global/block/{block_id}/durable/wasm_2_0_0/length
class OctezRollupRequestGlobalBlockBlockIdDurableWasm200Length
    extends OctezRollupRequest<OctezRollupInt64?, OctezRollupInt64?> {
  final String blockId;
  final String key;

  const OctezRollupRequestGlobalBlockBlockIdDurableWasm200Length({
    required this.blockId,
    required this.key,
  });

  @override
  String? get path => '/global/block/$blockId/durable/wasm_2_0_0/length';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'key': key};

  @override
  OctezRollupInt64? onResponse(OctezRollupInt64? result) {
    return result;
  }
}

/// GET /global/block/{block_id}/durable/wasm_2_0_0/subkeys
class OctezRollupRequestGlobalBlockBlockIdDurableWasm200Subkeys
    extends OctezRollupRequest<List<OctezRollupUnistring>, List<dynamic>> {
  final String blockId;
  final String key;

  const OctezRollupRequestGlobalBlockBlockIdDurableWasm200Subkeys({
    required this.blockId,
    required this.key,
  });

  @override
  String? get path => '/global/block/$blockId/durable/wasm_2_0_0/subkeys';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'key': key};

  @override
  List<OctezRollupUnistring> onResponse(List<dynamic> result) {
    return result.map((e) => OctezRollupUnistring.fromJson(e)).toList();
  }
}

/// GET /global/block/{block_id}/durable/wasm_2_0_0/value
class OctezRollupRequestGlobalBlockBlockIdDurableWasm200Value
    extends OctezRollupRequest<String?, String?> {
  final String blockId;
  final String key;

  const OctezRollupRequestGlobalBlockBlockIdDurableWasm200Value({
    required this.blockId,
    required this.key,
  });

  @override
  String? get path => '/global/block/$blockId/durable/wasm_2_0_0/value';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'key': key};

  @override
  String? onResponse(String? result) {
    return result;
  }
}

/// GET /global/block/{block_id}/durable/wasm_2_0_0/values
class OctezRollupRequestGlobalBlockBlockIdDurableWasm200Values
    extends
        OctezRollupRequest<
          List<
            OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStoragePatchDurableStorage
          >,
          List<dynamic>
        > {
  final String blockId;
  final String key;

  const OctezRollupRequestGlobalBlockBlockIdDurableWasm200Values({
    required this.blockId,
    required this.key,
  });

  @override
  String? get path => '/global/block/$blockId/durable/wasm_2_0_0/values';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'key': key};

  @override
  List<
    OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStoragePatchDurableStorage
  >
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezRollupResponseConfigUnsafePvmPatchesItemPatchDurableStoragePatchDurableStorage.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /global/block/{block_id}/hash
class OctezRollupRequestGlobalBlockBlockIdHash
    extends OctezRollupRequest<OctezRollupUnistring, dynamic> {
  final String blockId;

  const OctezRollupRequestGlobalBlockBlockIdHash({required this.blockId});

  @override
  String? get path => '/global/block/$blockId/hash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupUnistring onResponse(dynamic result) {
    return OctezRollupUnistring.fromJson(result);
  }
}

/// GET /global/block/{block_id}/helpers/proofs/outbox/{level}/messages
class OctezRollupRequestGlobalBlockBlockIdHelpersProofsOutboxLevelMessages
    extends
        OctezRollupRequest<
          OctezRollupResponseGlobalBlockBlockIdHelpersProofsOutboxLevelMessages,
          Map<String, dynamic>
        > {
  final String blockId;
  final String level;
  final String? index;

  const OctezRollupRequestGlobalBlockBlockIdHelpersProofsOutboxLevelMessages({
    required this.blockId,
    required this.level,
    this.index,
  });

  @override
  String? get path =>
      '/global/block/$blockId/helpers/proofs/outbox/$level/messages';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'index': index};

  @override
  OctezRollupResponseGlobalBlockBlockIdHelpersProofsOutboxLevelMessages
  onResponse(Map<String, dynamic> result) {
    return OctezRollupResponseGlobalBlockBlockIdHelpersProofsOutboxLevelMessages.fromJson(
      result,
    );
  }
}

/// GET /global/block/{block_id}/inbox
class OctezRollupRequestGlobalBlockBlockIdInbox
    extends
        OctezRollupRequest<
          OctezRollupResponseGlobalBlockBlockIdInbox,
          Map<String, dynamic>
        > {
  final String blockId;

  const OctezRollupRequestGlobalBlockBlockIdInbox({required this.blockId});

  @override
  String? get path => '/global/block/$blockId/inbox';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseGlobalBlockBlockIdInbox onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdInbox.fromJson(result);
  }
}

/// GET /global/block/{block_id}/level
class OctezRollupRequestGlobalBlockBlockIdLevel
    extends OctezRollupRequest<int, int> {
  final String blockId;

  const OctezRollupRequestGlobalBlockBlockIdLevel({required this.blockId});

  @override
  String? get path => '/global/block/$blockId/level';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int onResponse(int result) {
    return result;
  }
}

/// GET /global/block/{block_id}/num_messages
class OctezRollupRequestGlobalBlockBlockIdNumMessages
    extends OctezRollupRequest<String, String> {
  final String blockId;

  const OctezRollupRequestGlobalBlockBlockIdNumMessages({
    required this.blockId,
  });

  @override
  String? get path => '/global/block/$blockId/num_messages';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /global/block/{block_id}/outbox
class OctezRollupRequestGlobalBlockBlockIdOutbox
    extends
        OctezRollupRequest<
          List<OctezRollupResponseGlobalBlockBlockIdOutboxItem108>,
          List<dynamic>
        > {
  final String blockId;
  final String? outboxLevel;

  const OctezRollupRequestGlobalBlockBlockIdOutbox({
    required this.blockId,
    this.outboxLevel,
  });

  @override
  String? get path => '/global/block/$blockId/outbox';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'outbox_level': outboxLevel};

  @override
  List<OctezRollupResponseGlobalBlockBlockIdOutboxItem108> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) => OctezRollupResponseGlobalBlockBlockIdOutboxItem108.fromJson(e),
        )
        .toList();
  }
}

/// GET /global/block/{block_id}/outbox/{level}/messages
class OctezRollupRequestGlobalBlockBlockIdOutboxLevelMessages
    extends
        OctezRollupRequest<
          List<OctezRollupResponseGlobalBlockBlockIdOutboxItem108>,
          List<dynamic>
        > {
  final String blockId;
  final String level;

  const OctezRollupRequestGlobalBlockBlockIdOutboxLevelMessages({
    required this.blockId,
    required this.level,
  });

  @override
  String? get path => '/global/block/$blockId/outbox/$level/messages';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezRollupResponseGlobalBlockBlockIdOutboxItem108> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) => OctezRollupResponseGlobalBlockBlockIdOutboxItem108.fromJson(e),
        )
        .toList();
  }
}

/// POST /global/block/{block_id}/simulate
class OctezRollupRequestGlobalBlockBlockIdSimulate
    extends
        OctezRollupRequest<
          OctezRollupResponseGlobalBlockBlockIdSimulate,
          Map<String, dynamic>
        > {
  final String blockId;
  final OctezRollupGlobalBlockBlockIdSimulateBody requestBody;

  const OctezRollupRequestGlobalBlockBlockIdSimulate({
    required this.blockId,
    required this.requestBody,
  });

  @override
  String? get path => '/global/block/$blockId/simulate';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezRollupResponseGlobalBlockBlockIdSimulate onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezRollupResponseGlobalBlockBlockIdSimulate.fromJson(result);
  }
}

/// GET /global/block/{block_id}/state
class OctezRollupRequestGlobalBlockBlockIdState
    extends OctezRollupRequest<String, String> {
  final String blockId;
  final String key;

  const OctezRollupRequestGlobalBlockBlockIdState({
    required this.blockId,
    required this.key,
  });

  @override
  String? get path => '/global/block/$blockId/state';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'key': key};

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /global/block/{block_id}/state_current_level
class OctezRollupRequestGlobalBlockBlockIdStateCurrentLevel
    extends OctezRollupRequest<int?, int?> {
  final String blockId;

  const OctezRollupRequestGlobalBlockBlockIdStateCurrentLevel({
    required this.blockId,
  });

  @override
  String? get path => '/global/block/$blockId/state_current_level';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int? onResponse(int? result) {
    return result;
  }
}

/// GET /global/block/{block_id}/state_hash
class OctezRollupRequestGlobalBlockBlockIdStateHash
    extends OctezRollupRequest<OctezRollupUnistring, dynamic> {
  final String blockId;

  const OctezRollupRequestGlobalBlockBlockIdStateHash({required this.blockId});

  @override
  String? get path => '/global/block/$blockId/state_hash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupUnistring onResponse(dynamic result) {
    return OctezRollupUnistring.fromJson(result);
  }
}

/// GET /global/block/{block_id}/status
class OctezRollupRequestGlobalBlockBlockIdStatus
    extends
        OctezRollupRequest<
          OctezRollupResponseGlobalBlockBlockIdStatus,
          dynamic
        > {
  final String blockId;

  const OctezRollupRequestGlobalBlockBlockIdStatus({required this.blockId});

  @override
  String? get path => '/global/block/$blockId/status';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseGlobalBlockBlockIdStatus onResponse(dynamic result) {
    return OctezRollupResponseGlobalBlockBlockIdStatus.fromJson(result);
  }
}

/// GET /global/block/{block_id}/ticks
class OctezRollupRequestGlobalBlockBlockIdTicks
    extends OctezRollupRequest<String, String> {
  final String blockId;

  const OctezRollupRequestGlobalBlockBlockIdTicks({required this.blockId});

  @override
  String? get path => '/global/block/$blockId/ticks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /global/block/{block_id}/total_ticks
class OctezRollupRequestGlobalBlockBlockIdTotalTicks
    extends OctezRollupRequest<String, String> {
  final String blockId;

  const OctezRollupRequestGlobalBlockBlockIdTotalTicks({required this.blockId});

  @override
  String? get path => '/global/block/$blockId/total_ticks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /global/last_cemented_commitment
class OctezRollupRequestGlobalLastCementedCommitment
    extends
        OctezRollupRequest<
          OctezRollupResponseGlobalLastCementedCommitment?,
          Map<String, dynamic>?
        > {
  const OctezRollupRequestGlobalLastCementedCommitment();

  @override
  String? get path => '/global/last_cemented_commitment';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseGlobalLastCementedCommitment? onResponse(
    Map<String, dynamic>? result,
  ) {
    if (result == null) return null;
    return OctezRollupResponseGlobalLastCementedCommitment.fromJson(result);
  }
}

/// GET /global/last_stored_commitment
class OctezRollupRequestGlobalLastStoredCommitment
    extends
        OctezRollupRequest<
          OctezRollupResponseGlobalLastCementedCommitment?,
          Map<String, dynamic>?
        > {
  const OctezRollupRequestGlobalLastStoredCommitment();

  @override
  String? get path => '/global/last_stored_commitment';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseGlobalLastCementedCommitment? onResponse(
    Map<String, dynamic>? result,
  ) {
    if (result == null) return null;
    return OctezRollupResponseGlobalLastCementedCommitment.fromJson(result);
  }
}

/// GET /global/monitor_blocks
class OctezRollupRequestGlobalMonitorBlocks
    extends
        OctezRollupRequest<
          OctezRollupResponseGlobalMonitorBlocks,
          Map<String, dynamic>
        > {
  const OctezRollupRequestGlobalMonitorBlocks();

  @override
  String? get path => '/global/monitor_blocks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseGlobalMonitorBlocks onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezRollupResponseGlobalMonitorBlocks.fromJson(result);
  }
}

/// GET /global/monitor_finalized_blocks
class OctezRollupRequestGlobalMonitorFinalizedBlocks
    extends
        OctezRollupRequest<
          OctezRollupResponseGlobalMonitorBlocks,
          Map<String, dynamic>
        > {
  const OctezRollupRequestGlobalMonitorFinalizedBlocks();

  @override
  String? get path => '/global/monitor_finalized_blocks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseGlobalMonitorBlocks onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezRollupResponseGlobalMonitorBlocks.fromJson(result);
  }
}

/// GET /global/smart_rollup_address
class OctezRollupRequestGlobalSmartRollupAddress
    extends OctezRollupRequest<OctezRollupUnistring, dynamic> {
  const OctezRollupRequestGlobalSmartRollupAddress();

  @override
  String? get path => '/global/smart_rollup_address';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupUnistring onResponse(dynamic result) {
    return OctezRollupUnistring.fromJson(result);
  }
}

/// GET /global/tezos_head
class OctezRollupRequestGlobalTezosHead
    extends OctezRollupRequest<OctezRollupBlockHash?, dynamic> {
  const OctezRollupRequestGlobalTezosHead();

  @override
  String? get path => '/global/tezos_head';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupBlockHash? onResponse(dynamic result) {
    if (result == null) return null;
    return OctezRollupUnistring.fromJson(result);
  }
}

/// GET /global/tezos_level
class OctezRollupRequestGlobalTezosLevel
    extends OctezRollupRequest<int?, int?> {
  const OctezRollupRequestGlobalTezosLevel();

  @override
  String? get path => '/global/tezos_level';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int? onResponse(int? result) {
    return result;
  }
}

/// GET /health
class OctezRollupRequestHealth
    extends
        OctezRollupRequest<OctezRollupResponseHealth, Map<String, dynamic>> {
  const OctezRollupRequestHealth();

  @override
  String? get path => '/health';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseHealth onResponse(Map<String, dynamic> result) {
    return OctezRollupResponseHealth.fromJson(result);
  }
}

/// POST /local/batcher/injection
class OctezRollupRequestLocalBatcherInjection
    extends
        OctezRollupRequest<
          List<OctezRollupScRollupL2MessageId>,
          List<dynamic>
        > {
  final String? order;
  final String dropDuplicate;
  final List<OctezRollupScL2Message> requestBody;

  const OctezRollupRequestLocalBatcherInjection({
    this.order,
    required this.dropDuplicate,
    required this.requestBody,
  });

  @override
  String? get path => '/local/batcher/injection';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {
    'order': order,
    'drop_duplicate': dropDuplicate,
  };

  @override
  dynamic body() => requestBody;

  @override
  List<OctezRollupScRollupL2MessageId> onResponse(List<dynamic> result) {
    return result.map((e) => OctezRollupUnistring.fromJson(e)).toList();
  }
}

/// GET /local/batcher/queue
class OctezRollupRequestLocalBatcherQueue
    extends
        OctezRollupRequest<
          List<OctezRollupResponseLocalBatcherQueueItem>,
          List<dynamic>
        > {
  const OctezRollupRequestLocalBatcherQueue();

  @override
  String? get path => '/local/batcher/queue';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezRollupResponseLocalBatcherQueueItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezRollupResponseLocalBatcherQueueItem.fromJson(e))
        .toList();
  }
}

/// GET /local/batcher/queue/{l2_message_id}
class OctezRollupRequestLocalBatcherQueueL2MessageId
    extends
        OctezRollupRequest<
          OctezRollupResponseLocalBatcherQueueL2MessageId,
          dynamic
        > {
  final String l2MessageId;

  const OctezRollupRequestLocalBatcherQueueL2MessageId({
    required this.l2MessageId,
  });

  @override
  String? get path => '/local/batcher/queue/$l2MessageId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseLocalBatcherQueueL2MessageId onResponse(dynamic result) {
    return OctezRollupResponseLocalBatcherQueueL2MessageId.fromJson(result);
  }
}

/// GET /local/commitments/{commitment_hash}
class OctezRollupRequestLocalCommitmentsCommitmentHash
    extends
        OctezRollupRequest<
          OctezRollupResponseLocalCommitmentsCommitmentHash?,
          Map<String, dynamic>?
        > {
  final String commitmentHash;

  const OctezRollupRequestLocalCommitmentsCommitmentHash({
    required this.commitmentHash,
  });

  @override
  String? get path => '/local/commitments/$commitmentHash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseLocalCommitmentsCommitmentHash? onResponse(
    Map<String, dynamic>? result,
  ) {
    if (result == null) return null;
    return OctezRollupResponseLocalCommitmentsCommitmentHash.fromJson(result);
  }
}

/// POST /local/dal/batcher/injection
class OctezRollupRequestLocalDalBatcherInjection
    extends OctezRollupRequest<dynamic, dynamic> {
  final List<OctezRollupUnistring> requestBody;

  const OctezRollupRequestLocalDalBatcherInjection({required this.requestBody});

  @override
  String? get path => '/local/dal/batcher/injection';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.map((e) => e.toJson()).toList();

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /local/dal/injected/operations/statuses
class OctezRollupRequestLocalDalInjectedOperationsStatuses
    extends
        OctezRollupRequest<
          List<OctezRollupResponseLocalDalInjectedOperationsStatusesItem>,
          List<dynamic>
        > {
  const OctezRollupRequestLocalDalInjectedOperationsStatuses();

  @override
  String? get path => '/local/dal/injected/operations/statuses';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezRollupResponseLocalDalInjectedOperationsStatusesItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) =>
              OctezRollupResponseLocalDalInjectedOperationsStatusesItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// POST /local/dal/injection/{injector_operation_hash}/forget
class OctezRollupRequestLocalDalInjectionInjectorOperationHashForget
    extends OctezRollupRequest<dynamic, dynamic> {
  final String injectorOperationHash;
  final dynamic requestBody;

  const OctezRollupRequestLocalDalInjectionInjectorOperationHashForget({
    required this.injectorOperationHash,
    required this.requestBody,
  });

  @override
  String? get path => '/local/dal/injection/$injectorOperationHash/forget';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// POST /local/dal/slot/indices
class OctezRollupRequestLocalDalSlotIndices
    extends OctezRollupRequest<dynamic, dynamic> {
  final OctezRollupLocalDalSlotIndicesBody requestBody;

  const OctezRollupRequestLocalDalSlotIndices({required this.requestBody});

  @override
  String? get path => '/local/dal/slot/indices';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /local/gc_info
class OctezRollupRequestLocalGcInfo
    extends
        OctezRollupRequest<
          OctezRollupResponseLocalGcInfo,
          Map<String, dynamic>
        > {
  const OctezRollupRequestLocalGcInfo();

  @override
  String? get path => '/local/gc_info';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseLocalGcInfo onResponse(Map<String, dynamic> result) {
    return OctezRollupResponseLocalGcInfo.fromJson(result);
  }
}

/// GET /local/injector/operation/{injector_operation_hash}/status
class OctezRollupRequestLocalInjectorOperationInjectorOperationHashStatus
    extends
        OctezRollupRequest<
          OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus,
          dynamic
        > {
  final String injectorOperationHash;

  const OctezRollupRequestLocalInjectorOperationInjectorOperationHashStatus({
    required this.injectorOperationHash,
  });

  @override
  String? get path => '/local/injector/operation/$injectorOperationHash/status';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus onResponse(
    dynamic result,
  ) {
    return OctezRollupResponseLocalDalInjectedOperationsStatusesItemStatus.fromJson(
      result,
    );
  }
}

/// GET /local/last_published_commitment
class OctezRollupRequestLocalLastPublishedCommitment
    extends
        OctezRollupRequest<
          OctezRollupResponseLocalCommitmentsCommitmentHash?,
          Map<String, dynamic>?
        > {
  const OctezRollupRequestLocalLastPublishedCommitment();

  @override
  String? get path => '/local/last_published_commitment';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseLocalCommitmentsCommitmentHash? onResponse(
    Map<String, dynamic>? result,
  ) {
    if (result == null) return null;
    return OctezRollupResponseLocalCommitmentsCommitmentHash.fromJson(result);
  }
}

/// GET /local/outbox/pending
class OctezRollupRequestLocalOutboxPending
    extends
        OctezRollupRequest<
          List<OctezRollupResponseLocalOutboxPendingItem>,
          List<dynamic>
        > {
  final String? outboxLevel;

  const OctezRollupRequestLocalOutboxPending({this.outboxLevel});

  @override
  String? get path => '/local/outbox/pending';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'outbox_level': outboxLevel};

  @override
  List<OctezRollupResponseLocalOutboxPendingItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezRollupResponseLocalOutboxPendingItem.fromJson(e))
        .toList();
  }
}

/// GET /local/outbox/pending/executable
class OctezRollupRequestLocalOutboxPendingExecutable
    extends
        OctezRollupRequest<
          List<OctezRollupResponseLocalOutboxPendingExecutableItem>,
          List<dynamic>
        > {
  final String? outboxLevel;

  const OctezRollupRequestLocalOutboxPendingExecutable({this.outboxLevel});

  @override
  String? get path => '/local/outbox/pending/executable';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'outbox_level': outboxLevel};

  @override
  List<OctezRollupResponseLocalOutboxPendingExecutableItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) =>
              OctezRollupResponseLocalOutboxPendingExecutableItem.fromJson(e),
        )
        .toList();
  }
}

/// GET /local/outbox/pending/unexecutable
class OctezRollupRequestLocalOutboxPendingUnexecutable
    extends
        OctezRollupRequest<
          List<OctezRollupResponseLocalOutboxPendingExecutableItem>,
          List<dynamic>
        > {
  final String? outboxLevel;

  const OctezRollupRequestLocalOutboxPendingUnexecutable({this.outboxLevel});

  @override
  String? get path => '/local/outbox/pending/unexecutable';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'outbox_level': outboxLevel};

  @override
  List<OctezRollupResponseLocalOutboxPendingExecutableItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) =>
              OctezRollupResponseLocalOutboxPendingExecutableItem.fromJson(e),
        )
        .toList();
  }
}

/// GET /local/synchronized
class OctezRollupRequestLocalSynchronized
    extends OctezRollupRequest<OctezRollupResponseLocalSynchronized, dynamic> {
  const OctezRollupRequestLocalSynchronized();

  @override
  String? get path => '/local/synchronized';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseLocalSynchronized onResponse(dynamic result) {
    return OctezRollupResponseLocalSynchronized.fromJson(result);
  }
}

/// GET /openapi
class OctezRollupRequestOpenapi extends OctezRollupRequest<dynamic, dynamic> {
  final String? protocol;

  const OctezRollupRequestOpenapi({this.protocol});

  @override
  String? get path => '/openapi';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'protocol': protocol};

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /ping
class OctezRollupRequestPing extends OctezRollupRequest<dynamic, dynamic> {
  const OctezRollupRequestPing();

  @override
  String? get path => '/ping';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /stats/memory
class OctezRollupRequestStatsMemory
    extends OctezRollupRequest<OctezRollupResponseStatsMemory, dynamic> {
  const OctezRollupRequestStatsMemory();

  @override
  String? get path => '/stats/memory';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseStatsMemory onResponse(dynamic result) {
    return OctezRollupResponseStatsMemory.fromJson(result);
  }
}

/// GET /stats/ocaml_gc
class OctezRollupRequestStatsOcamlGc
    extends
        OctezRollupRequest<
          OctezRollupResponseStatsOcamlGc,
          Map<String, dynamic>
        > {
  const OctezRollupRequestStatsOcamlGc();

  @override
  String? get path => '/stats/ocaml_gc';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseStatsOcamlGc onResponse(Map<String, dynamic> result) {
    return OctezRollupResponseStatsOcamlGc.fromJson(result);
  }
}

/// GET /version
class OctezRollupRequestVersion
    extends
        OctezRollupRequest<OctezRollupResponseVersion, Map<String, dynamic>> {
  const OctezRollupRequestVersion();

  @override
  String? get path => '/version';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezRollupResponseVersion onResponse(Map<String, dynamic> result) {
    return OctezRollupResponseVersion.fromJson(result);
  }
}

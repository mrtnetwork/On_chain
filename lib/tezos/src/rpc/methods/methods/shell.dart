// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/rpc/core/core.dart';
import 'package:on_chain/tezos/src/rpc/types/types.dart';

/// POST /bls/aggregate_proofs
class OctezShellRequestBlsAggregateProofs
    extends OctezShellRequest<OctezShellBls12381Signature?, dynamic> {
  final OctezShellBlsAggregateProofsBody requestBody;

  const OctezShellRequestBlsAggregateProofs({required this.requestBody});

  @override
  String? get path => '/bls/aggregate_proofs';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezShellBls12381Signature? onResponse(dynamic result) {
    if (result == null) return null;
    return OctezShellBls12381Signature.fromJson(result);
  }
}

/// POST /bls/aggregate_public_keys
class OctezShellRequestBlsAggregatePublicKeys
    extends
        OctezShellRequest<
          OctezShellResponseBlsAggregatePublicKeys?,
          Map<String, dynamic>?
        > {
  final List<OctezShellBlsAggregatePublicKeysBodyItem> requestBody;

  const OctezShellRequestBlsAggregatePublicKeys({required this.requestBody});

  @override
  String? get path => '/bls/aggregate_public_keys';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.map((e) => e.toJson()).toList();

  @override
  OctezShellResponseBlsAggregatePublicKeys? onResponse(
    Map<String, dynamic>? result,
  ) {
    if (result == null) return null;
    return OctezShellResponseBlsAggregatePublicKeys.fromJson(result);
  }
}

/// POST /bls/aggregate_signatures
class OctezShellRequestBlsAggregateSignatures
    extends OctezShellRequest<OctezShellBls12381Signature?, dynamic> {
  final OctezShellBlsAggregateSignaturesBody requestBody;

  const OctezShellRequestBlsAggregateSignatures({required this.requestBody});

  @override
  String? get path => '/bls/aggregate_signatures';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezShellBls12381Signature? onResponse(dynamic result) {
    if (result == null) return null;
    return OctezShellBls12381Signature.fromJson(result);
  }
}

/// POST /bls/check_proof
class OctezShellRequestBlsCheckProof extends OctezShellRequest<bool, bool> {
  final OctezShellBlsAggregatePublicKeysBodyItem requestBody;

  const OctezShellRequestBlsCheckProof({required this.requestBody});

  @override
  String? get path => '/bls/check_proof';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  bool onResponse(bool result) {
    return result;
  }
}

/// POST /bls/threshold_signatures
class OctezShellRequestBlsThresholdSignatures
    extends OctezShellRequest<OctezShellBls12381Signature?, dynamic> {
  final OctezShellBlsThresholdSignaturesBody requestBody;

  const OctezShellRequestBlsThresholdSignatures({required this.requestBody});

  @override
  String? get path => '/bls/threshold_signatures';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezShellBls12381Signature? onResponse(dynamic result) {
    if (result == null) return null;
    return OctezShellBls12381Signature.fromJson(result);
  }
}

/// PATCH /chains/{chain_id}
class OctezShellRequestChainsChainId
    extends OctezShellRequest<dynamic, dynamic> {
  final String chainId;
  final OctezShellChainsChainIdBody requestBody;

  const OctezShellRequestChainsChainId({
    required this.chainId,
    required this.requestBody,
  });

  @override
  String? get path => '/chains/$chainId';

  @override
  RequestMethod get requestMethod => RequestMethod.patch;

  @override
  dynamic body() => requestBody.toJson();

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /chains/{chain_id}/active_peers_heads
class OctezShellRequestChainsChainIdActivePeersHeads
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdActivePeersHeads,
          Map<String, dynamic>
        > {
  final String chainId;

  const OctezShellRequestChainsChainIdActivePeersHeads({required this.chainId});

  @override
  String? get path => '/chains/$chainId/active_peers_heads';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseChainsChainIdActivePeersHeads onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdActivePeersHeads.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks
class OctezShellRequestChainsChainIdBlocks
    extends OctezShellRequest<List<List<OctezShellBlockHash>>, List<dynamic>> {
  final String chainId;
  final String? length;
  final String? head;
  final String? minDate;

  const OctezShellRequestChainsChainIdBlocks({
    required this.chainId,
    this.length,
    this.head,
    this.minDate,
  });

  @override
  String? get path => '/chains/$chainId/blocks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'length': length,
    'head': head,
    'min_date': minDate,
  };

  @override
  List<List<OctezShellBlockHash>> onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              (e as List).map((x) => OctezShellBlockHash.fromJson(x)).toList(),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/chain_id
class OctezShellRequestChainsChainIdChainId
    extends OctezShellRequest<String, String> {
  final String chainId;

  const OctezShellRequestChainsChainIdChainId({required this.chainId});

  @override
  String? get path => '/chains/$chainId/chain_id';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) => result.replaceAll('"', '').trim();
}

/// GET /chains/{chain_id}/delegators_contribution/{int32}/{pkh}
class OctezShellRequestChainsChainIdDelegatorsContributionInt32Pkh
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdDelegatorsContributionInt32Pkh,
          Map<String, dynamic>
        > {
  final String chainId;
  final String int32;
  final String pkh;

  const OctezShellRequestChainsChainIdDelegatorsContributionInt32Pkh({
    required this.chainId,
    required this.int32,
    required this.pkh,
  });

  @override
  String? get path => '/chains/$chainId/delegators_contribution/$int32/$pkh';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseChainsChainIdDelegatorsContributionInt32Pkh onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdDelegatorsContributionInt32Pkh.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/invalid_blocks
class OctezShellRequestChainsChainIdInvalidBlocks
    extends
        OctezShellRequest<
          List<OctezShellResponseChainsChainIdInvalidBlocksItem>,
          List<dynamic>
        > {
  final String chainId;

  const OctezShellRequestChainsChainIdInvalidBlocks({required this.chainId});

  @override
  String? get path => '/chains/$chainId/invalid_blocks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellResponseChainsChainIdInvalidBlocksItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) => OctezShellResponseChainsChainIdInvalidBlocksItem.fromJson(e),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/invalid_blocks/{block_hash}
class OctezShellRequestChainsChainIdInvalidBlocksBlockHash
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdInvalidBlocksItem,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockHash;

  const OctezShellRequestChainsChainIdInvalidBlocksBlockHash({
    required this.chainId,
    required this.blockHash,
  });

  @override
  String? get path => '/chains/$chainId/invalid_blocks/$blockHash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseChainsChainIdInvalidBlocksItem onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdInvalidBlocksItem.fromJson(result);
  }
}

/// DELETE /chains/{chain_id}/invalid_blocks/{block_hash}
class OctezShellRequestDeleteChainsChainIdInvalidBlocksBlockHash
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdInvalidBlocksBlockHash,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockHash;

  const OctezShellRequestDeleteChainsChainIdInvalidBlocksBlockHash({
    required this.chainId,
    required this.blockHash,
  });

  @override
  String? get path => '/chains/$chainId/invalid_blocks/$blockHash';

  @override
  RequestMethod get requestMethod => RequestMethod.delete;

  @override
  OctezShellResponseChainsChainIdInvalidBlocksBlockHash onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdInvalidBlocksBlockHash.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/is_bootstrapped
class OctezShellRequestChainsChainIdIsBootstrapped
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdIsBootstrapped,
          Map<String, dynamic>
        > {
  final String chainId;

  const OctezShellRequestChainsChainIdIsBootstrapped({required this.chainId});

  @override
  String? get path => '/chains/$chainId/is_bootstrapped';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseChainsChainIdIsBootstrapped onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdIsBootstrapped.fromJson(result);
  }
}

/// GET /chains/{chain_id}/levels/caboose
class OctezShellRequestChainsChainIdLevelsCaboose
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdLevelsCaboose,
          Map<String, dynamic>
        > {
  final String chainId;

  const OctezShellRequestChainsChainIdLevelsCaboose({required this.chainId});

  @override
  String? get path => '/chains/$chainId/levels/caboose';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseChainsChainIdLevelsCaboose onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdLevelsCaboose.fromJson(result);
  }
}

/// GET /chains/{chain_id}/levels/checkpoint
class OctezShellRequestChainsChainIdLevelsCheckpoint
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdLevelsCaboose,
          Map<String, dynamic>
        > {
  final String chainId;

  const OctezShellRequestChainsChainIdLevelsCheckpoint({required this.chainId});

  @override
  String? get path => '/chains/$chainId/levels/checkpoint';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseChainsChainIdLevelsCaboose onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdLevelsCaboose.fromJson(result);
  }
}

/// GET /chains/{chain_id}/levels/savepoint
class OctezShellRequestChainsChainIdLevelsSavepoint
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdLevelsCaboose,
          Map<String, dynamic>
        > {
  final String chainId;

  const OctezShellRequestChainsChainIdLevelsSavepoint({required this.chainId});

  @override
  String? get path => '/chains/$chainId/levels/savepoint';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseChainsChainIdLevelsCaboose onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdLevelsCaboose.fromJson(result);
  }
}

/// GET /chains/{chain_id}/protocols
class OctezShellRequestChainsChainIdProtocols
    extends
        OctezShellRequest<
          List<OctezShellResponseChainsChainIdProtocolsItem>,
          List<dynamic>
        > {
  final String chainId;

  const OctezShellRequestChainsChainIdProtocols({required this.chainId});

  @override
  String? get path => '/chains/$chainId/protocols';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellResponseChainsChainIdProtocolsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezShellResponseChainsChainIdProtocolsItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/protocols/{Protocol_hash}
class OctezShellRequestChainsChainIdProtocolsProtocolHash
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdProtocolsItem,
          Map<String, dynamic>
        > {
  final String chainId;
  final String protocolHash;

  const OctezShellRequestChainsChainIdProtocolsProtocolHash({
    required this.chainId,
    required this.protocolHash,
  });

  @override
  String? get path => '/chains/$chainId/protocols/$protocolHash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseChainsChainIdProtocolsItem onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdProtocolsItem.fromJson(result);
  }
}

/// GET /config
class OctezShellRequestConfig
    extends OctezShellRequest<OctezShellResponseConfig, Map<String, dynamic>> {
  const OctezShellRequestConfig();

  @override
  String? get path => '/config';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseConfig onResponse(Map<String, dynamic> result) {
    return OctezShellResponseConfig.fromJson(result);
  }
}

/// GET /config/history_mode
class OctezShellRequestConfigHistoryMode
    extends
        OctezShellRequest<
          OctezShellResponseConfigHistoryMode,
          Map<String, dynamic>
        > {
  const OctezShellRequestConfigHistoryMode();

  @override
  String? get path => '/config/history_mode';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseConfigHistoryMode onResponse(Map<String, dynamic> result) {
    return OctezShellResponseConfigHistoryMode.fromJson(result);
  }
}

/// PUT /config/logging
class OctezShellRequestConfigLogging
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdInvalidBlocksBlockHash,
          Map<String, dynamic>
        > {
  final OctezShellResponseConfigInternalEvents requestBody;

  const OctezShellRequestConfigLogging({required this.requestBody});

  @override
  String? get path => '/config/logging';

  @override
  RequestMethod get requestMethod => RequestMethod.put;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezShellResponseChainsChainIdInvalidBlocksBlockHash onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdInvalidBlocksBlockHash.fromJson(
      result,
    );
  }
}

/// GET /config/network/dal
class OctezShellRequestConfigNetworkDal
    extends
        OctezShellRequest<
          OctezShellResponseConfigNetworkCustomDalConfig,
          Map<String, dynamic>
        > {
  const OctezShellRequestConfigNetworkDal();

  @override
  String? get path => '/config/network/dal';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseConfigNetworkCustomDalConfig onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseConfigNetworkCustomDalConfig.fromJson(result);
  }
}

/// GET /config/network/user_activated_protocol_overrides
class OctezShellRequestConfigNetworkUserActivatedProtocolOverrides
    extends
        OctezShellRequest<
          List<OctezShellUserActivatedProtocolOverridesItem>,
          List<dynamic>
        > {
  const OctezShellRequestConfigNetworkUserActivatedProtocolOverrides();

  @override
  String? get path => '/config/network/user_activated_protocol_overrides';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellUserActivatedProtocolOverridesItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezShellUserActivatedProtocolOverridesItem.fromJson(e))
        .toList();
  }
}

/// GET /config/network/user_activated_upgrades
class OctezShellRequestConfigNetworkUserActivatedUpgrades
    extends
        OctezShellRequest<
          List<OctezShellUserActivatedUpgradesItem>,
          List<dynamic>
        > {
  const OctezShellRequestConfigNetworkUserActivatedUpgrades();

  @override
  String? get path => '/config/network/user_activated_upgrades';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellUserActivatedUpgradesItem> onResponse(List<dynamic> result) {
    return result
        .map((e) => OctezShellUserActivatedUpgradesItem.fromJson(e))
        .toList();
  }
}

/// GET /errors
class OctezShellRequestErrors extends OctezShellRequest<dynamic, dynamic> {
  const OctezShellRequestErrors();

  @override
  String? get path => '/errors';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /fetch_protocol/{Protocol_hash}
class OctezShellRequestFetchProtocolProtocolHash
    extends OctezShellRequest<dynamic, dynamic> {
  final String protocolHash;

  const OctezShellRequestFetchProtocolProtocolHash({
    required this.protocolHash,
  });

  @override
  String? get path => '/fetch_protocol/$protocolHash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// POST /gc/full
class OctezShellRequestGcFull extends OctezShellRequest<dynamic, dynamic> {
  final dynamic requestBody;

  const OctezShellRequestGcFull({required this.requestBody});

  @override
  String? get path => '/gc/full';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /health/ready
class OctezShellRequestHealthReady
    extends
        OctezShellRequest<OctezShellResponseHealthReady, Map<String, dynamic>> {
  const OctezShellRequestHealthReady();

  @override
  String? get path => '/health/ready';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseHealthReady onResponse(Map<String, dynamic> result) {
    return OctezShellResponseHealthReady.fromJson(result);
  }
}

/// POST /injection/block
class OctezShellRequestInjectionBlock
    extends OctezShellRequest<OctezShellUnistring, dynamic> {
  final String? async_;
  final String? force;
  final String? chain;
  final OctezShellInjectionBlockBody requestBody;

  const OctezShellRequestInjectionBlock({
    this.async_,
    this.force,
    this.chain,
    required this.requestBody,
  });

  @override
  String? get path => '/injection/block';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {
    'async': async_,
    'force': force,
    'chain': chain,
  };

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezShellUnistring onResponse(dynamic result) {
    return OctezShellUnistring.fromJson(result);
  }
}

/// POST /injection/operation
class OctezShellRequestInjectionOperation
    extends OctezShellRequest<String, String> {
  final String? async_;
  final String? chain;
  final String requestBody;

  const OctezShellRequestInjectionOperation({
    this.async_,
    this.chain,
    required this.requestBody,
  });

  @override
  String? get path => '/injection/operation';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'async': async_, 'chain': chain};

  @override
  dynamic body() => requestBody;

  @override
  String onResponse(String result) => result.replaceAll('"', '').trim();
}

/// POST /injection/protocol
class OctezShellRequestInjectionProtocol
    extends OctezShellRequest<OctezShellUnistring, dynamic> {
  final String? async_;
  final OctezShellInjectionProtocolBody requestBody;

  const OctezShellRequestInjectionProtocol({
    this.async_,
    required this.requestBody,
  });

  @override
  String? get path => '/injection/protocol';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'async': async_};

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezShellUnistring onResponse(dynamic result) {
    return OctezShellUnistring.fromJson(result);
  }
}

/// GET /monitor/active_chains
class OctezShellRequestMonitorActiveChains
    extends
        OctezShellRequest<
          List<OctezShellResponseMonitorActiveChainsItem>,
          List<dynamic>
        > {
  const OctezShellRequestMonitorActiveChains();

  @override
  String? get path => '/monitor/active_chains';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellResponseMonitorActiveChainsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezShellResponseMonitorActiveChainsItem.fromJson(e))
        .toList();
  }
}

/// GET /monitor/applied_blocks
class OctezShellRequestMonitorAppliedBlocks
    extends
        OctezShellRequest<
          OctezShellResponseMonitorAppliedBlocks,
          Map<String, dynamic>
        > {
  final String? protocol;
  final String? nextProtocol;
  final String? chain;

  const OctezShellRequestMonitorAppliedBlocks({
    this.protocol,
    this.nextProtocol,
    this.chain,
  });

  @override
  String? get path => '/monitor/applied_blocks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'protocol': protocol,
    'next_protocol': nextProtocol,
    'chain': chain,
  };

  @override
  OctezShellResponseMonitorAppliedBlocks onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseMonitorAppliedBlocks.fromJson(result);
  }
}

/// GET /monitor/bootstrapped
class OctezShellRequestMonitorBootstrapped
    extends
        OctezShellRequest<
          OctezShellResponseMonitorBootstrapped,
          Map<String, dynamic>
        > {
  const OctezShellRequestMonitorBootstrapped();

  @override
  String? get path => '/monitor/bootstrapped';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseMonitorBootstrapped onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseMonitorBootstrapped.fromJson(result);
  }
}

/// GET /monitor/heads/{chain_id}
class OctezShellRequestMonitorHeadsChainId
    extends
        OctezShellRequest<
          OctezShellResponseMonitorHeadsChainId,
          Map<String, dynamic>
        > {
  final String chainId;
  final String? protocol;
  final String? nextProtocol;

  const OctezShellRequestMonitorHeadsChainId({
    required this.chainId,
    this.protocol,
    this.nextProtocol,
  });

  @override
  String? get path => '/monitor/heads/$chainId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'protocol': protocol,
    'next_protocol': nextProtocol,
  };

  @override
  OctezShellResponseMonitorHeadsChainId onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseMonitorHeadsChainId.fromJson(result);
  }
}

/// GET /monitor/protocols
class OctezShellRequestMonitorProtocols
    extends OctezShellRequest<OctezShellUnistring, dynamic> {
  const OctezShellRequestMonitorProtocols();

  @override
  String? get path => '/monitor/protocols';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellUnistring onResponse(dynamic result) {
    return OctezShellUnistring.fromJson(result);
  }
}

/// GET /monitor/received_blocks/{chain_id}
class OctezShellRequestMonitorReceivedBlocksChainId
    extends
        OctezShellRequest<
          OctezShellResponseMonitorReceivedBlocksChainId,
          Map<String, dynamic>
        > {
  final String chainId;

  const OctezShellRequestMonitorReceivedBlocksChainId({required this.chainId});

  @override
  String? get path => '/monitor/received_blocks/$chainId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseMonitorReceivedBlocksChainId onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseMonitorReceivedBlocksChainId.fromJson(result);
  }
}

/// GET /monitor/validated_blocks
class OctezShellRequestMonitorValidatedBlocks
    extends
        OctezShellRequest<
          OctezShellResponseMonitorAppliedBlocks,
          Map<String, dynamic>
        > {
  final String? protocol;
  final String? nextProtocol;
  final String? chain;

  const OctezShellRequestMonitorValidatedBlocks({
    this.protocol,
    this.nextProtocol,
    this.chain,
  });

  @override
  String? get path => '/monitor/validated_blocks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'protocol': protocol,
    'next_protocol': nextProtocol,
    'chain': chain,
  };

  @override
  OctezShellResponseMonitorAppliedBlocks onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseMonitorAppliedBlocks.fromJson(result);
  }
}

/// GET /network/connections
class OctezShellRequestNetworkConnections
    extends
        OctezShellRequest<
          List<OctezShellResponseNetworkConnectionsItem>,
          List<dynamic>
        > {
  const OctezShellRequestNetworkConnections();

  @override
  String? get path => '/network/connections';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellResponseNetworkConnectionsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezShellResponseNetworkConnectionsItem.fromJson(e))
        .toList();
  }
}

/// GET /network/connections/{peer_id}
class OctezShellRequestNetworkConnectionsPeerId
    extends
        OctezShellRequest<
          OctezShellResponseNetworkConnectionsItem,
          Map<String, dynamic>
        > {
  final String peerId;

  const OctezShellRequestNetworkConnectionsPeerId({required this.peerId});

  @override
  String? get path => '/network/connections/$peerId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseNetworkConnectionsItem onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseNetworkConnectionsItem.fromJson(result);
  }
}

/// DELETE /network/connections/{peer_id}
class OctezShellRequestDeleteNetworkConnectionsPeerId
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdInvalidBlocksBlockHash,
          Map<String, dynamic>
        > {
  final String peerId;
  final String? wait;

  const OctezShellRequestDeleteNetworkConnectionsPeerId({
    required this.peerId,
    this.wait,
  });

  @override
  String? get path => '/network/connections/$peerId';

  @override
  RequestMethod get requestMethod => RequestMethod.delete;

  @override
  Map<String, String?> get queryParameters => {'wait': wait};

  @override
  OctezShellResponseChainsChainIdInvalidBlocksBlockHash onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdInvalidBlocksBlockHash.fromJson(
      result,
    );
  }
}

/// GET /network/full_stat
class OctezShellRequestNetworkFullStat
    extends
        OctezShellRequest<
          OctezShellResponseNetworkFullStat,
          Map<String, dynamic>
        > {
  const OctezShellRequestNetworkFullStat();

  @override
  String? get path => '/network/full_stat';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseNetworkFullStat onResponse(Map<String, dynamic> result) {
    return OctezShellResponseNetworkFullStat.fromJson(result);
  }
}

/// DELETE /network/greylist
class OctezShellRequestNetworkGreylist
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdInvalidBlocksBlockHash,
          Map<String, dynamic>
        > {
  const OctezShellRequestNetworkGreylist();

  @override
  String? get path => '/network/greylist';

  @override
  RequestMethod get requestMethod => RequestMethod.delete;

  @override
  OctezShellResponseChainsChainIdInvalidBlocksBlockHash onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdInvalidBlocksBlockHash.fromJson(
      result,
    );
  }
}

/// GET /network/greylist/ips
class OctezShellRequestNetworkGreylistIps
    extends
        OctezShellRequest<
          OctezShellResponseNetworkGreylistIps,
          Map<String, dynamic>
        > {
  const OctezShellRequestNetworkGreylistIps();

  @override
  String? get path => '/network/greylist/ips';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseNetworkGreylistIps onResponse(Map<String, dynamic> result) {
    return OctezShellResponseNetworkGreylistIps.fromJson(result);
  }
}

/// GET /network/greylist/peers
class OctezShellRequestNetworkGreylistPeers
    extends
        OctezShellRequest<
          List<OctezShellCryptoBoxPublicKeyHash>,
          List<dynamic>
        > {
  const OctezShellRequestNetworkGreylistPeers();

  @override
  String? get path => '/network/greylist/peers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellCryptoBoxPublicKeyHash> onResponse(List<dynamic> result) {
    return result
        .map((e) => OctezShellCryptoBoxPublicKeyHash.fromJson(e))
        .toList();
  }
}

/// GET /network/log
class OctezShellRequestNetworkLog
    extends OctezShellRequest<OctezShellResponseNetworkLog, dynamic> {
  const OctezShellRequestNetworkLog();

  @override
  String? get path => '/network/log';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseNetworkLog onResponse(dynamic result) {
    return OctezShellResponseNetworkLog.fromJson(result);
  }
}

/// GET /network/peers
class OctezShellRequestNetworkPeers
    extends
        OctezShellRequest<
          List<List<OctezShellResponseNetworkFullStatPeersItemItem>>,
          List<dynamic>
        > {
  final String? filter;

  const OctezShellRequestNetworkPeers({this.filter});

  @override
  String? get path => '/network/peers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'filter': filter};

  @override
  List<List<OctezShellResponseNetworkFullStatPeersItemItem>> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) =>
              (e as List)
                  .map(
                    (x) =>
                        OctezShellResponseNetworkFullStatPeersItemItem.fromJson(
                          x,
                        ),
                  )
                  .toList(),
        )
        .toList();
  }
}

/// GET /network/peers/{peer_id}
class OctezShellRequestNetworkPeersPeerId
    extends
        OctezShellRequest<
          OctezShellResponseNetworkPeersPeerId,
          Map<String, dynamic>
        > {
  final String peerId;

  const OctezShellRequestNetworkPeersPeerId({required this.peerId});

  @override
  String? get path => '/network/peers/$peerId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseNetworkPeersPeerId onResponse(Map<String, dynamic> result) {
    return OctezShellResponseNetworkPeersPeerId.fromJson(result);
  }
}

/// PATCH /network/peers/{peer_id}
class OctezShellRequestPatchNetworkPeersPeerId
    extends
        OctezShellRequest<
          OctezShellResponseNetworkPeersPeerId,
          Map<String, dynamic>
        > {
  final String peerId;
  final OctezShellNetworkPeersPeerIdBody requestBody;

  const OctezShellRequestPatchNetworkPeersPeerId({
    required this.peerId,
    required this.requestBody,
  });

  @override
  String? get path => '/network/peers/$peerId';

  @override
  RequestMethod get requestMethod => RequestMethod.patch;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezShellResponseNetworkPeersPeerId onResponse(Map<String, dynamic> result) {
    return OctezShellResponseNetworkPeersPeerId.fromJson(result);
  }
}

/// GET /network/peers/{peer_id}/banned
class OctezShellRequestNetworkPeersPeerIdBanned
    extends OctezShellRequest<bool, bool> {
  final String peerId;

  const OctezShellRequestNetworkPeersPeerIdBanned({required this.peerId});

  @override
  String? get path => '/network/peers/$peerId/banned';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  bool onResponse(bool result) {
    return result;
  }
}

/// GET /network/peers/{peer_id}/log
class OctezShellRequestNetworkPeersPeerIdLog
    extends OctezShellRequest<List<OctezShellP2pPeerPoolEvent>, List<dynamic>> {
  final String peerId;
  final String? monitor;

  const OctezShellRequestNetworkPeersPeerIdLog({
    required this.peerId,
    this.monitor,
  });

  @override
  String? get path => '/network/peers/$peerId/log';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'monitor': monitor};

  @override
  List<OctezShellP2pPeerPoolEvent> onResponse(List<dynamic> result) {
    return result.map((e) => OctezShellP2pPeerPoolEvent.fromJson(e)).toList();
  }
}

/// GET /network/points
class OctezShellRequestNetworkPoints
    extends
        OctezShellRequest<
          List<List<OctezShellResponseNetworkFullStatPointsItemItem>>,
          List<dynamic>
        > {
  final String? filter;

  const OctezShellRequestNetworkPoints({this.filter});

  @override
  String? get path => '/network/points';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'filter': filter};

  @override
  List<List<OctezShellResponseNetworkFullStatPointsItemItem>> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) =>
              (e as List)
                  .map(
                    (x) =>
                        OctezShellResponseNetworkFullStatPointsItemItem.fromJson(
                          x,
                        ),
                  )
                  .toList(),
        )
        .toList();
  }
}

/// GET /network/points/{point}
class OctezShellRequestNetworkPointsPoint
    extends
        OctezShellRequest<
          OctezShellResponseNetworkPointsPoint,
          Map<String, dynamic>
        > {
  final String point;

  const OctezShellRequestNetworkPointsPoint({required this.point});

  @override
  String? get path => '/network/points/$point';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseNetworkPointsPoint onResponse(Map<String, dynamic> result) {
    return OctezShellResponseNetworkPointsPoint.fromJson(result);
  }
}

/// PUT /network/points/{point}
class OctezShellRequestPutNetworkPointsPoint
    extends
        OctezShellRequest<
          OctezShellResponseChainsChainIdInvalidBlocksBlockHash,
          Map<String, dynamic>
        > {
  final String point;
  final String timeout;
  final OctezShellResponseChainsChainIdInvalidBlocksBlockHash requestBody;

  const OctezShellRequestPutNetworkPointsPoint({
    required this.point,
    required this.timeout,
    required this.requestBody,
  });

  @override
  String? get path => '/network/points/$point';

  @override
  RequestMethod get requestMethod => RequestMethod.put;

  @override
  Map<String, String> get queryParameters => {'timeout': timeout};

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezShellResponseChainsChainIdInvalidBlocksBlockHash onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseChainsChainIdInvalidBlocksBlockHash.fromJson(
      result,
    );
  }
}

/// PATCH /network/points/{point}
class OctezShellRequestPatchNetworkPointsPoint
    extends
        OctezShellRequest<
          OctezShellResponseNetworkPointsPoint,
          Map<String, dynamic>
        > {
  final String point;
  final OctezShellNetworkPointsPointBody requestBody;

  const OctezShellRequestPatchNetworkPointsPoint({
    required this.point,
    required this.requestBody,
  });

  @override
  String? get path => '/network/points/$point';

  @override
  RequestMethod get requestMethod => RequestMethod.patch;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezShellResponseNetworkPointsPoint onResponse(Map<String, dynamic> result) {
    return OctezShellResponseNetworkPointsPoint.fromJson(result);
  }
}

/// GET /network/points/{point}/banned
class OctezShellRequestNetworkPointsPointBanned
    extends OctezShellRequest<bool, bool> {
  final String point;

  const OctezShellRequestNetworkPointsPointBanned({required this.point});

  @override
  String? get path => '/network/points/$point/banned';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  bool onResponse(bool result) {
    return result;
  }
}

/// GET /network/points/{point}/log
class OctezShellRequestNetworkPointsPointLog
    extends
        OctezShellRequest<List<OctezShellP2pPointPoolEvent>, List<dynamic>> {
  final String point;
  final String? monitor;

  const OctezShellRequestNetworkPointsPointLog({
    required this.point,
    this.monitor,
  });

  @override
  String? get path => '/network/points/$point/log';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'monitor': monitor};

  @override
  List<OctezShellP2pPointPoolEvent> onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              (e as List)
                  .map((x) => OctezShellP2pPointPoolEventItem.fromJson(x))
                  .toList(),
        )
        .toList();
  }
}

/// GET /network/self
class OctezShellRequestNetworkSelf
    extends OctezShellRequest<OctezShellUnistring, dynamic> {
  const OctezShellRequestNetworkSelf();

  @override
  String? get path => '/network/self';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellUnistring onResponse(dynamic result) {
    return OctezShellUnistring.fromJson(result);
  }
}

/// GET /network/stat
class OctezShellRequestNetworkStat
    extends
        OctezShellRequest<OctezShellResponseNetworkStat, Map<String, dynamic>> {
  const OctezShellRequestNetworkStat();

  @override
  String? get path => '/network/stat';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseNetworkStat onResponse(Map<String, dynamic> result) {
    return OctezShellResponseNetworkStat.fromJson(result);
  }
}

/// GET /profiler/registered_backend
class OctezShellRequestProfilerRegisteredBackend
    extends
        OctezShellRequest<
          OctezShellResponseProfilerRegisteredBackend,
          Map<String, dynamic>
        > {
  const OctezShellRequestProfilerRegisteredBackend();

  @override
  String? get path => '/profiler/registered_backend';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseProfilerRegisteredBackend onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseProfilerRegisteredBackend.fromJson(result);
  }
}

/// GET /protocols
class OctezShellRequestProtocols
    extends OctezShellRequest<List<OctezShellProtocolHash>, List<dynamic>> {
  const OctezShellRequestProtocols();

  @override
  String? get path => '/protocols';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellProtocolHash> onResponse(List<dynamic> result) {
    return result.map((e) => OctezShellProtocolHash.fromJson(e)).toList();
  }
}

/// GET /protocols/{Protocol_hash}
class OctezShellRequestProtocolsProtocolHash
    extends
        OctezShellRequest<
          OctezShellInjectionProtocolBody,
          Map<String, dynamic>
        > {
  final String protocolHash;

  const OctezShellRequestProtocolsProtocolHash({required this.protocolHash});

  @override
  String? get path => '/protocols/$protocolHash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellInjectionProtocolBody onResponse(Map<String, dynamic> result) {
    return OctezShellInjectionProtocolBody.fromJson(result);
  }
}

/// GET /protocols/{Protocol_hash}/environment
class OctezShellRequestProtocolsProtocolHashEnvironment
    extends OctezShellRequest<int, int> {
  final String protocolHash;

  const OctezShellRequestProtocolsProtocolHashEnvironment({
    required this.protocolHash,
  });

  @override
  String? get path => '/protocols/$protocolHash/environment';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int onResponse(int result) {
    return result;
  }
}

/// GET /stats/gc
class OctezShellRequestStatsGc
    extends OctezShellRequest<OctezShellResponseStatsGc, Map<String, dynamic>> {
  const OctezShellRequestStatsGc();

  @override
  String? get path => '/stats/gc';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseStatsGc onResponse(Map<String, dynamic> result) {
    return OctezShellResponseStatsGc.fromJson(result);
  }
}

/// GET /stats/memory
class OctezShellRequestStatsMemory
    extends OctezShellRequest<OctezShellResponseStatsMemory, dynamic> {
  const OctezShellRequestStatsMemory();

  @override
  String? get path => '/stats/memory';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseStatsMemory onResponse(dynamic result) {
    return OctezShellResponseStatsMemory.fromJson(result);
  }
}

/// GET /version
class OctezShellRequestVersion
    extends OctezShellRequest<OctezShellResponseVersion, Map<String, dynamic>> {
  const OctezShellRequestVersion();

  @override
  String? get path => '/version';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseVersion onResponse(Map<String, dynamic> result) {
    return OctezShellResponseVersion.fromJson(result);
  }
}

/// GET /workers/block_validator
class OctezShellRequestWorkersBlockValidator
    extends
        OctezShellRequest<
          OctezShellResponseWorkersBlockValidator,
          Map<String, dynamic>
        > {
  const OctezShellRequestWorkersBlockValidator();

  @override
  String? get path => '/workers/block_validator';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseWorkersBlockValidator onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseWorkersBlockValidator.fromJson(result);
  }
}

/// GET /workers/chain_validators
class OctezShellRequestWorkersChainValidators
    extends
        OctezShellRequest<
          List<OctezShellResponseWorkersChainValidatorsItem>,
          List<dynamic>
        > {
  const OctezShellRequestWorkersChainValidators();

  @override
  String? get path => '/workers/chain_validators';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellResponseWorkersChainValidatorsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezShellResponseWorkersChainValidatorsItem.fromJson(e))
        .toList();
  }
}

/// GET /workers/chain_validators/{chain_id}
class OctezShellRequestWorkersChainValidatorsChainId
    extends
        OctezShellRequest<
          OctezShellResponseWorkersChainValidatorsChainId,
          Map<String, dynamic>
        > {
  final String chainId;

  const OctezShellRequestWorkersChainValidatorsChainId({required this.chainId});

  @override
  String? get path => '/workers/chain_validators/$chainId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseWorkersChainValidatorsChainId onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainId.fromJson(result);
  }
}

/// GET /workers/chain_validators/{chain_id}/ddb
class OctezShellRequestWorkersChainValidatorsChainIdDdb
    extends
        OctezShellRequest<
          OctezShellResponseWorkersChainValidatorsChainIdDdb,
          Map<String, dynamic>
        > {
  final String chainId;

  const OctezShellRequestWorkersChainValidatorsChainIdDdb({
    required this.chainId,
  });

  @override
  String? get path => '/workers/chain_validators/$chainId/ddb';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseWorkersChainValidatorsChainIdDdb onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdDdb.fromJson(result);
  }
}

/// GET /workers/chain_validators/{chain_id}/peers_validators
class OctezShellRequestWorkersChainValidatorsChainIdPeersValidators
    extends
        OctezShellRequest<
          List<
            OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItem
          >,
          List<dynamic>
        > {
  final String chainId;

  const OctezShellRequestWorkersChainValidatorsChainIdPeersValidators({
    required this.chainId,
  });

  @override
  String? get path => '/workers/chain_validators/$chainId/peers_validators';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItem>
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /workers/chain_validators/{chain_id}/peers_validators/{peer_id}
class OctezShellRequestWorkersChainValidatorsChainIdPeersValidatorsPeerId
    extends
        OctezShellRequest<
          OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerId,
          Map<String, dynamic>
        > {
  final String chainId;
  final String peerId;

  const OctezShellRequestWorkersChainValidatorsChainIdPeersValidatorsPeerId({
    required this.chainId,
    required this.peerId,
  });

  @override
  String? get path =>
      '/workers/chain_validators/$chainId/peers_validators/$peerId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerId
  onResponse(Map<String, dynamic> result) {
    return OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerId.fromJson(
      result,
    );
  }
}

/// GET /workers/prevalidators
class OctezShellRequestWorkersPrevalidators
    extends
        OctezShellRequest<
          List<OctezShellResponseWorkersChainValidatorsItem>,
          List<dynamic>
        > {
  const OctezShellRequestWorkersPrevalidators();

  @override
  String? get path => '/workers/prevalidators';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezShellResponseWorkersChainValidatorsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezShellResponseWorkersChainValidatorsItem.fromJson(e))
        .toList();
  }
}

/// GET /workers/prevalidators/{chain_id}
class OctezShellRequestWorkersPrevalidatorsChainId
    extends
        OctezShellRequest<
          OctezShellResponseWorkersPrevalidatorsChainId,
          Map<String, dynamic>
        > {
  final String chainId;

  const OctezShellRequestWorkersPrevalidatorsChainId({required this.chainId});

  @override
  String? get path => '/workers/prevalidators/$chainId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezShellResponseWorkersPrevalidatorsChainId onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainId.fromJson(result);
  }
}

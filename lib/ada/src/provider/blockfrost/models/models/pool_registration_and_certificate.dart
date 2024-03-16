import 'pool_metadata.dart';
import 'relay_info.dart';

class ADAPoolRegistrationCertificateResponse {
  /// Index of the certificate within the transaction
  final int certIndex;

  /// Bech32 encoded pool ID
  final String poolId;

  /// VRF key hash
  final String vrfKey;

  /// Stake pool certificate pledge in Lovelaces
  final String pledge;

  /// Margin tax cost of the stake pool
  final double marginCost;

  /// Fixed tax cost of the stake pool in Lovelaces
  final String fixedCost;

  /// Bech32 reward account of the stake pool
  final String rewardAccount;

  /// Stake pool metadata
  final ADAPoolMetadataResponse? metadata;

  /// Relays of the stake pool
  final List<ADAStakePoolRelayInfoResponse> relays;

  /// Epoch in which the update becomes active
  final int activeEpoch;

  ADAPoolRegistrationCertificateResponse({
    required this.certIndex,
    required this.poolId,
    required this.vrfKey,
    required this.pledge,
    required this.marginCost,
    required this.fixedCost,
    required this.rewardAccount,
    required this.activeEpoch,
    required this.relays,
    this.metadata,
  });

  factory ADAPoolRegistrationCertificateResponse.fromJson(
      Map<String, dynamic> json) {
    return ADAPoolRegistrationCertificateResponse(
      certIndex: json['cert_index'],
      poolId: json['pool_id'],
      vrfKey: json['vrf_key'],
      pledge: json['pledge'],
      marginCost: json['margin_cost'],
      fixedCost: json['fixed_cost'],
      rewardAccount: json['reward_account'],
      activeEpoch: json['active_epoch'],
      relays: (json['relays'] as List<dynamic>)
          .map((relayJson) => ADAStakePoolRelayInfoResponse.fromJson(relayJson))
          .toList(),
      metadata: json['metadata'] != null
          ? ADAPoolMetadataResponse.fromJson(json['metadata'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cert_index': certIndex,
      'pool_id': poolId,
      'vrf_key': vrfKey,
      'pledge': pledge,
      'margin_cost': marginCost,
      'fixed_cost': fixedCost,
      'reward_account': rewardAccount,
      'active_epoch': activeEpoch,
      'metadata': metadata?.toJson(),
      'relays': relays.map((relay) => relay.toJson()).toList(),
    };
  }
}

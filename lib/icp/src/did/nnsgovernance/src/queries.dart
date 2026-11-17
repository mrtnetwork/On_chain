// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `NnsGovernance`.
abstract class NnsGovernanceQueryMessage<RESULT>
    extends IICPQueryMessage<RESULT> {
  const NnsGovernanceQueryMessage();
}

class NnsGovernanceQueryGetBuildMetadata
    extends NnsGovernanceQueryMessage<String> {
  const NnsGovernanceQueryGetBuildMetadata();

  @override
  String get methodName => 'get_build_metadata';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  String onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.text) as String;
  }
}

class NnsGovernanceQueryGetFullNeuron
    extends NnsGovernanceQueryMessage<NnsGovernanceResult2> {
  final BigInt args;
  const NnsGovernanceQueryGetFullNeuron(this.args);

  @override
  String get methodName => 'get_full_neuron';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsGovernanceResult2 onResponse(List<int> bytes) {
    return NnsGovernanceResult2.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetFullNeuronByIdOrSubaccount
    extends NnsGovernanceQueryMessage<NnsGovernanceResult2> {
  final NnsGovernanceNeuronIdOrSubaccount args;
  const NnsGovernanceQueryGetFullNeuronByIdOrSubaccount(this.args);

  @override
  String get methodName => 'get_full_neuron_by_id_or_subaccount';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceResult2 onResponse(List<int> bytes) {
    return NnsGovernanceResult2.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetLatestRewardEvent
    extends NnsGovernanceQueryMessage<NnsGovernanceRewardEvent> {
  const NnsGovernanceQueryGetLatestRewardEvent();

  @override
  String get methodName => 'get_latest_reward_event';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsGovernanceRewardEvent onResponse(List<int> bytes) {
    return NnsGovernanceRewardEvent.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetMaturityModulation
    extends
        NnsGovernanceQueryMessage<NnsGovernanceGetMaturityModulationResponse> {
  final NnsGovernanceGetMaturityModulationRequest args;
  const NnsGovernanceQueryGetMaturityModulation(this.args);

  @override
  String get methodName => 'get_maturity_modulation';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceGetMaturityModulationResponse onResponse(List<int> bytes) {
    return NnsGovernanceGetMaturityModulationResponse.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetMetrics
    extends NnsGovernanceQueryMessage<NnsGovernanceResult3> {
  const NnsGovernanceQueryGetMetrics();

  @override
  String get methodName => 'get_metrics';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsGovernanceResult3 onResponse(List<int> bytes) {
    return NnsGovernanceResult3.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetMostRecentMonthlyNodeProviderRewards
    extends
        NnsGovernanceQueryMessage<NnsGovernanceMonthlyNodeProviderRewards?> {
  const NnsGovernanceQueryGetMostRecentMonthlyNodeProviderRewards();

  @override
  String get methodName => 'get_most_recent_monthly_node_provider_rewards';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsGovernanceMonthlyNodeProviderRewards? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(NnsGovernanceMonthlyNodeProviderRewards.ctype),
    );
    if (decode == null) return null;
    return NnsGovernanceMonthlyNodeProviderRewards.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class NnsGovernanceQueryGetNetworkEconomicsParameters
    extends NnsGovernanceQueryMessage<NnsGovernanceNetworkEconomics> {
  const NnsGovernanceQueryGetNetworkEconomicsParameters();

  @override
  String get methodName => 'get_network_economics_parameters';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsGovernanceNetworkEconomics onResponse(List<int> bytes) {
    return NnsGovernanceNetworkEconomics.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetNeuronIds
    extends NnsGovernanceQueryMessage<List<BigInt>> {
  const NnsGovernanceQueryGetNeuronIds();

  @override
  String get methodName => 'get_neuron_ids';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<BigInt> onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.vec(CType.nat64))
        as List<BigInt>;
  }
}

class NnsGovernanceQueryGetNeuronIndex
    extends NnsGovernanceQueryMessage<NnsGovernanceGetNeuronIndexResult> {
  final NnsGovernanceGetNeuronIndexRequest args;
  const NnsGovernanceQueryGetNeuronIndex(this.args);

  @override
  String get methodName => 'get_neuron_index';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceGetNeuronIndexResult onResponse(List<int> bytes) {
    return NnsGovernanceGetNeuronIndexResult.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetNeuronInfo
    extends NnsGovernanceQueryMessage<NnsGovernanceResult5> {
  final BigInt args;
  const NnsGovernanceQueryGetNeuronInfo(this.args);

  @override
  String get methodName => 'get_neuron_info';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsGovernanceResult5 onResponse(List<int> bytes) {
    return NnsGovernanceResult5.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetNeuronInfoByIdOrSubaccount
    extends NnsGovernanceQueryMessage<NnsGovernanceResult5> {
  final NnsGovernanceNeuronIdOrSubaccount args;
  const NnsGovernanceQueryGetNeuronInfoByIdOrSubaccount(this.args);

  @override
  String get methodName => 'get_neuron_info_by_id_or_subaccount';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceResult5 onResponse(List<int> bytes) {
    return NnsGovernanceResult5.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetNeuronsFundAuditInfo
    extends
        NnsGovernanceQueryMessage<
          NnsGovernanceGetNeuronsFundAuditInfoResponse
        > {
  final NnsGovernanceGetNeuronsFundAuditInfoRequest args;
  const NnsGovernanceQueryGetNeuronsFundAuditInfo(this.args);

  @override
  String get methodName => 'get_neurons_fund_audit_info';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceGetNeuronsFundAuditInfoResponse onResponse(List<int> bytes) {
    return NnsGovernanceGetNeuronsFundAuditInfoResponse.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetNodeProviderByCaller
    extends NnsGovernanceQueryMessage<NnsGovernanceResult7> {
  final Null args;
  const NnsGovernanceQueryGetNodeProviderByCaller(this.args);

  @override
  String get methodName => 'get_node_provider_by_caller';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.null_, args);
  }

  @override
  NnsGovernanceResult7 onResponse(List<int> bytes) {
    return NnsGovernanceResult7.fromBytes(bytes);
  }
}

class NnsGovernanceQueryGetPendingProposals
    extends NnsGovernanceQueryMessage<List<NnsGovernanceProposalInfo>> {
  final NnsGovernanceGetPendingProposalsRequest? args;
  const NnsGovernanceQueryGetPendingProposals(this.args);

  @override
  String get methodName => 'get_pending_proposals';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(
      CType.opt(NnsGovernanceGetPendingProposalsRequest.ctype),
      args,
    );
  }

  @override
  List<NnsGovernanceProposalInfo> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(NnsGovernanceProposalInfo.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => NnsGovernanceProposalInfo.fromCandid(e)).toList();
  }
}

class NnsGovernanceQueryGetProposalInfo
    extends NnsGovernanceQueryMessage<NnsGovernanceProposalInfo?> {
  final BigInt args;
  const NnsGovernanceQueryGetProposalInfo(this.args);

  @override
  String get methodName => 'get_proposal_info';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsGovernanceProposalInfo? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(NnsGovernanceProposalInfo.ctype),
    );
    if (decode == null) return null;
    return NnsGovernanceProposalInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class NnsGovernanceQueryGetRestoreAgingSummary
    extends NnsGovernanceQueryMessage<NnsGovernanceRestoreAgingSummary> {
  const NnsGovernanceQueryGetRestoreAgingSummary();

  @override
  String get methodName => 'get_restore_aging_summary';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsGovernanceRestoreAgingSummary onResponse(List<int> bytes) {
    return NnsGovernanceRestoreAgingSummary.fromBytes(bytes);
  }
}

class NnsGovernanceQueryListKnownNeurons
    extends NnsGovernanceQueryMessage<NnsGovernanceListKnownNeuronsResponse> {
  const NnsGovernanceQueryListKnownNeurons();

  @override
  String get methodName => 'list_known_neurons';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsGovernanceListKnownNeuronsResponse onResponse(List<int> bytes) {
    return NnsGovernanceListKnownNeuronsResponse.fromBytes(bytes);
  }
}

class NnsGovernanceQueryListNeurons
    extends NnsGovernanceQueryMessage<NnsGovernanceListNeuronsResponse> {
  final NnsGovernanceListNeurons args;
  const NnsGovernanceQueryListNeurons(this.args);

  @override
  String get methodName => 'list_neurons';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceListNeuronsResponse onResponse(List<int> bytes) {
    return NnsGovernanceListNeuronsResponse.fromBytes(bytes);
  }
}

class NnsGovernanceQueryListNodeProviderRewards
    extends
        NnsGovernanceQueryMessage<
          NnsGovernanceListNodeProviderRewardsResponse
        > {
  final NnsGovernanceListNodeProviderRewardsRequest args;
  const NnsGovernanceQueryListNodeProviderRewards(this.args);

  @override
  String get methodName => 'list_node_provider_rewards';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceListNodeProviderRewardsResponse onResponse(List<int> bytes) {
    return NnsGovernanceListNodeProviderRewardsResponse.fromBytes(bytes);
  }
}

class NnsGovernanceQueryListNodeProviders
    extends NnsGovernanceQueryMessage<NnsGovernanceListNodeProvidersResponse> {
  const NnsGovernanceQueryListNodeProviders();

  @override
  String get methodName => 'list_node_providers';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsGovernanceListNodeProvidersResponse onResponse(List<int> bytes) {
    return NnsGovernanceListNodeProvidersResponse.fromBytes(bytes);
  }
}

class NnsGovernanceQueryListProposals
    extends NnsGovernanceQueryMessage<NnsGovernanceListProposalInfoResponse> {
  final NnsGovernanceListProposalInfoRequest args;
  const NnsGovernanceQueryListProposals(this.args);

  @override
  String get methodName => 'list_proposals';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceListProposalInfoResponse onResponse(List<int> bytes) {
    return NnsGovernanceListProposalInfoResponse.fromBytes(bytes);
  }
}

class NnsGovernanceQueryListNeuronVotes
    extends NnsGovernanceQueryMessage<NnsGovernanceListNeuronVotesResponse> {
  final NnsGovernanceListNeuronVotesRequest args;
  const NnsGovernanceQueryListNeuronVotes(this.args);

  @override
  String get methodName => 'list_neuron_votes';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceListNeuronVotesResponse onResponse(List<int> bytes) {
    return NnsGovernanceListNeuronVotesResponse.fromBytes(bytes);
  }
}

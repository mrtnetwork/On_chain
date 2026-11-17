// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Update messages for service `NnsGovernance`.
abstract class NnsGovernanceUpdateMessage<RESULT>
    extends IICPUpdateMessage<RESULT> {
  const NnsGovernanceUpdateMessage();
}

class NnsGovernanceUpdateClaimGtcNeurons
    extends NnsGovernanceUpdateMessage<NnsGovernanceResult> {
  final IcpPrincipalAddress arg0;
  final List<NnsGovernanceNeuronId> arg1;
  const NnsGovernanceUpdateClaimGtcNeurons({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'claim_gtc_neurons';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.principal, CType.vec(NnsGovernanceNeuronId.ctype)],
      [arg0, arg1],
    );
  }

  @override
  NnsGovernanceResult onResponse(List<int> bytes) {
    return NnsGovernanceResult.fromBytes(bytes);
  }
}

class NnsGovernanceUpdateClaimOrRefreshNeuronFromAccount
    extends
        NnsGovernanceUpdateMessage<
          NnsGovernanceClaimOrRefreshNeuronFromAccountResponse
        > {
  final NnsGovernanceClaimOrRefreshNeuronFromAccount args;
  const NnsGovernanceUpdateClaimOrRefreshNeuronFromAccount(this.args);

  @override
  String get methodName => 'claim_or_refresh_neuron_from_account';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceClaimOrRefreshNeuronFromAccountResponse onResponse(
    List<int> bytes,
  ) {
    return NnsGovernanceClaimOrRefreshNeuronFromAccountResponse.fromBytes(
      bytes,
    );
  }
}

class NnsGovernanceUpdateGetMonthlyNodeProviderRewards
    extends NnsGovernanceUpdateMessage<NnsGovernanceResult4> {
  const NnsGovernanceUpdateGetMonthlyNodeProviderRewards();

  @override
  String get methodName => 'get_monthly_node_provider_rewards';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsGovernanceResult4 onResponse(List<int> bytes) {
    return NnsGovernanceResult4.fromBytes(bytes);
  }
}

class NnsGovernanceUpdateManageNeuron
    extends NnsGovernanceUpdateMessage<NnsGovernanceManageNeuronResponse> {
  final NnsGovernanceManageNeuronRequest args;
  const NnsGovernanceUpdateManageNeuron(this.args);

  @override
  String get methodName => 'manage_neuron';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceManageNeuronResponse onResponse(List<int> bytes) {
    return NnsGovernanceManageNeuronResponse.fromBytes(bytes);
  }
}

class NnsGovernanceUpdateCreateNeuron
    extends NnsGovernanceUpdateMessage<NnsGovernanceCreateNeuronResponse> {
  final NnsGovernanceCreateNeuronRequest args;
  const NnsGovernanceUpdateCreateNeuron(this.args);

  @override
  String get methodName => 'create_neuron';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceCreateNeuronResponse onResponse(List<int> bytes) {
    return NnsGovernanceCreateNeuronResponse.fromBytes(bytes);
  }
}

class NnsGovernanceUpdateSettleCommunityFundParticipation
    extends NnsGovernanceUpdateMessage<NnsGovernanceResult> {
  final NnsGovernanceSettleCommunityFundParticipation args;
  const NnsGovernanceUpdateSettleCommunityFundParticipation(this.args);

  @override
  String get methodName => 'settle_community_fund_participation';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceResult onResponse(List<int> bytes) {
    return NnsGovernanceResult.fromBytes(bytes);
  }
}

class NnsGovernanceUpdateSettleNeuronsFundParticipation
    extends
        NnsGovernanceUpdateMessage<
          NnsGovernanceSettleNeuronsFundParticipationResponse
        > {
  final NnsGovernanceSettleNeuronsFundParticipationRequest args;
  const NnsGovernanceUpdateSettleNeuronsFundParticipation(this.args);

  @override
  String get methodName => 'settle_neurons_fund_participation';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceSettleNeuronsFundParticipationResponse onResponse(
    List<int> bytes,
  ) {
    return NnsGovernanceSettleNeuronsFundParticipationResponse.fromBytes(bytes);
  }
}

class NnsGovernanceUpdateSimulateManageNeuron
    extends NnsGovernanceUpdateMessage<NnsGovernanceManageNeuronResponse> {
  final NnsGovernanceManageNeuronRequest args;
  const NnsGovernanceUpdateSimulateManageNeuron(this.args);

  @override
  String get methodName => 'simulate_manage_neuron';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceManageNeuronResponse onResponse(List<int> bytes) {
    return NnsGovernanceManageNeuronResponse.fromBytes(bytes);
  }
}

class NnsGovernanceUpdateTransferGtcNeuron
    extends NnsGovernanceUpdateMessage<NnsGovernanceResult> {
  final NnsGovernanceNeuronId arg0;
  final NnsGovernanceNeuronId arg1;
  const NnsGovernanceUpdateTransferGtcNeuron({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'transfer_gtc_neuron';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [NnsGovernanceNeuronId.ctype, NnsGovernanceNeuronId.ctype],
      [arg0.candidValue, arg1.candidValue],
    );
  }

  @override
  NnsGovernanceResult onResponse(List<int> bytes) {
    return NnsGovernanceResult.fromBytes(bytes);
  }
}

class NnsGovernanceUpdateUpdateNodeProvider
    extends NnsGovernanceUpdateMessage<NnsGovernanceResult> {
  final NnsGovernanceUpdateNodeProvider args;
  const NnsGovernanceUpdateUpdateNodeProvider(this.args);

  @override
  String get methodName => 'update_node_provider';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsGovernanceResult onResponse(List<int> bytes) {
    return NnsGovernanceResult.fromBytes(bytes);
  }
}

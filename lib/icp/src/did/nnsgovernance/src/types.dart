// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid record `NnsGovernanceGovernance.default_followees`.
final class NnsGovernanceGovernanceDefaultFollowees with CandidSerializable {
  final int field0;
  final NnsGovernanceFollowees field1;

  const NnsGovernanceGovernanceDefaultFollowees({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.int32),
    LazyField(Label.id(1), () => NnsGovernanceFollowees.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory NnsGovernanceGovernanceDefaultFollowees.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGovernanceDefaultFollowees(
      field0: json.valueAsInt<int>('0'),
      field1: json.valueTo<NnsGovernanceFollowees, Map>(
        key: '1',
        parse:
            (e) => NnsGovernanceFollowees.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceGovernanceDefaultFollowees.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGovernanceDefaultFollowees.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsGovernanceGovernance.proposals`.
final class NnsGovernanceGovernanceProposals with CandidSerializable {
  final BigInt field0;
  final NnsGovernanceProposalData field1;

  const NnsGovernanceGovernanceProposals({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.nat64),
    LazyField(Label.id(1), () => NnsGovernanceProposalData.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory NnsGovernanceGovernanceProposals.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGovernanceProposals(
      field0: json.valueAsBigInt<BigInt>('0'),
      field1: json.valueTo<NnsGovernanceProposalData, Map>(
        key: '1',
        parse:
            (e) => NnsGovernanceProposalData.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceGovernanceProposals.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGovernanceProposals.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsGovernanceGovernance.in_flight_commands`.
final class NnsGovernanceGovernanceInFlightCommands with CandidSerializable {
  final BigInt field0;
  final NnsGovernanceNeuronInFlightCommand field1;

  const NnsGovernanceGovernanceInFlightCommands({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.nat64),
    LazyField(Label.id(1), () => NnsGovernanceNeuronInFlightCommand.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory NnsGovernanceGovernanceInFlightCommands.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGovernanceInFlightCommands(
      field0: json.valueAsBigInt<BigInt>('0'),
      field1: json.valueTo<NnsGovernanceNeuronInFlightCommand, Map>(
        key: '1',
        parse:
            (e) => NnsGovernanceNeuronInFlightCommand.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceGovernanceInFlightCommands.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGovernanceInFlightCommands.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsGovernanceGovernance.neurons`.
final class NnsGovernanceGovernanceNeurons with CandidSerializable {
  final BigInt field0;
  final NnsGovernanceNeuron field1;

  const NnsGovernanceGovernanceNeurons({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.nat64),
    LazyField(Label.id(1), () => NnsGovernanceNeuron.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory NnsGovernanceGovernanceNeurons.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceGovernanceNeurons(
      field0: json.valueAsBigInt<BigInt>('0'),
      field1: json.valueTo<NnsGovernanceNeuron, Map>(
        key: '1',
        parse:
            (e) => NnsGovernanceNeuron.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceGovernanceNeurons.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGovernanceNeurons.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsGovernanceGovernanceCachedMetrics.not_dissolving_neurons_e8s_buckets`.
final class NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
    with CandidSerializable {
  final BigInt field0;
  final double field1;

  const NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.nat64),
    Field(Label.id(1), CType.float64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1};

  factory NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets(
      field0: json.valueAsBigInt<BigInt>('0'),
      field1: json.valueAsDouble<double>('1'),
    );
  }

  factory NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsGovernanceGovernanceCachedMetrics.not_dissolving_neurons_count_buckets`.
final class NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
    with CandidSerializable {
  final BigInt field0;
  final BigInt field1;

  const NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.nat64),
    Field(Label.id(1), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1};

  factory NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets(
      field0: json.valueAsBigInt<BigInt>('0'),
      field1: json.valueAsBigInt<BigInt>('1'),
    );
  }

  factory NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsGovernanceListNeuronsResponse.neuron_infos`.
final class NnsGovernanceListNeuronsResponseNeuronInfos
    with CandidSerializable {
  final BigInt field0;
  final NnsGovernanceNeuronInfo field1;

  const NnsGovernanceListNeuronsResponseNeuronInfos({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.nat64),
    LazyField(Label.id(1), () => NnsGovernanceNeuronInfo.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory NnsGovernanceListNeuronsResponseNeuronInfos.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceListNeuronsResponseNeuronInfos(
      field0: json.valueAsBigInt<BigInt>('0'),
      field1: json.valueTo<NnsGovernanceNeuronInfo, Map>(
        key: '1',
        parse:
            (e) => NnsGovernanceNeuronInfo.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceListNeuronsResponseNeuronInfos.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListNeuronsResponseNeuronInfos.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsGovernanceProposalData.ballots`.
final class NnsGovernanceProposalDataBallots with CandidSerializable {
  final BigInt field0;
  final NnsGovernanceBallot field1;

  const NnsGovernanceProposalDataBallots({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.nat64),
    LazyField(Label.id(1), () => NnsGovernanceBallot.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory NnsGovernanceProposalDataBallots.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceProposalDataBallots(
      field0: json.valueAsBigInt<BigInt>('0'),
      field1: json.valueTo<NnsGovernanceBallot, Map>(
        key: '1',
        parse:
            (e) => NnsGovernanceBallot.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceProposalDataBallots.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceProposalDataBallots.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsGovernanceSelfDescribingValue.Map`.
final class NnsGovernanceSelfDescribingValueMap with CandidSerializable {
  final String field0;
  final NnsGovernanceSelfDescribingValue field1;

  const NnsGovernanceSelfDescribingValueMap({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => NnsGovernanceSelfDescribingValue.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory NnsGovernanceSelfDescribingValueMap.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSelfDescribingValueMap(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<NnsGovernanceSelfDescribingValue, Map>(
        key: '1',
        parse:
            (e) => NnsGovernanceSelfDescribingValue.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceSelfDescribingValueMap.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSelfDescribingValueMap.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AccountIdentifier`.
final class NnsGovernanceAccountIdentifier with CandidSerializable {
  final List<int> hash;

  const NnsGovernanceAccountIdentifier({required this.hash});

  static CType get ctype =>
      CType.record([Field(Label.named('hash'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'hash': hash};

  Map<String, dynamic> toJson() => {'hash': hash};

  factory NnsGovernanceAccountIdentifier.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceAccountIdentifier(
      hash: json.valueAsBytes<List<int>>(
        'hash',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsGovernanceAccountIdentifier.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceAccountIdentifier.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Action`.
sealed class NnsGovernanceAction with CandidSerializable {
  const NnsGovernanceAction();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('RegisterKnownNeuron'),
      () => NnsGovernanceKnownNeuron.ctype,
    ),
    LazyField(
      Label.named('DeregisterKnownNeuron'),
      () => NnsGovernanceDeregisterKnownNeuron.ctype,
    ),
    LazyField(
      Label.named('ManageNeuron'),
      () => NnsGovernanceManageNeuronProposal.ctype,
    ),
    LazyField(
      Label.named('UpdateCanisterSettings'),
      () => NnsGovernanceUpdateCanisterSettings.ctype,
    ),
    LazyField(Label.named('InstallCode'), () => NnsGovernanceInstallCode.ctype),
    LazyField(
      Label.named('StopOrStartCanister'),
      () => NnsGovernanceStopOrStartCanister.ctype,
    ),
    LazyField(
      Label.named('CreateServiceNervousSystem'),
      () => NnsGovernanceCreateServiceNervousSystem.ctype,
    ),
    LazyField(
      Label.named('ExecuteNnsFunction'),
      () => NnsGovernanceExecuteNnsFunction.ctype,
    ),
    LazyField(
      Label.named('RewardNodeProvider'),
      () => NnsGovernanceRewardNodeProvider.ctype,
    ),
    LazyField(
      Label.named('OpenSnsTokenSwap'),
      () => NnsGovernanceOpenSnsTokenSwap.ctype,
    ),
    LazyField(
      Label.named('SetSnsTokenSwapOpenTimeWindow'),
      () => NnsGovernanceSetSnsTokenSwapOpenTimeWindow.ctype,
    ),
    LazyField(
      Label.named('SetDefaultFollowees'),
      () => NnsGovernanceSetDefaultFollowees.ctype,
    ),
    LazyField(
      Label.named('RewardNodeProviders'),
      () => NnsGovernanceRewardNodeProviders.ctype,
    ),
    LazyField(
      Label.named('ManageNetworkEconomics'),
      () => NnsGovernanceNetworkEconomics.ctype,
    ),
    LazyField(
      Label.named('ApproveGenesisKyc'),
      () => NnsGovernancePrincipals.ctype,
    ),
    LazyField(
      Label.named('AddOrRemoveNodeProvider'),
      () => NnsGovernanceAddOrRemoveNodeProvider.ctype,
    ),
    LazyField(Label.named('Motion'), () => NnsGovernanceMotion.ctype),
    LazyField(
      Label.named('FulfillSubnetRentalRequest'),
      () => NnsGovernanceFulfillSubnetRentalRequest.ctype,
    ),
    LazyField(
      Label.named('BlessAlternativeGuestOsVersion'),
      () => NnsGovernanceBlessAlternativeGuestOsVersion.ctype,
    ),
    LazyField(
      Label.named('TakeCanisterSnapshot'),
      () => NnsGovernanceTakeCanisterSnapshot.ctype,
    ),
    LazyField(
      Label.named('LoadCanisterSnapshot'),
      () => NnsGovernanceLoadCanisterSnapshot.ctype,
    ),
    LazyField(
      Label.named('CreateCanisterAndInstallCode'),
      () => NnsGovernanceCreateCanisterAndInstallCode.ctype,
    ),
    LazyField(
      Label.named('UpdateStandardEngineReplicaVersion'),
      () => NnsGovernanceUpdateStandardEngineReplicaVersion.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceAction.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('RegisterKnownNeuron')) {
      return NnsGovernanceActionRegisterKnownNeuron(
        json.valueTo<NnsGovernanceKnownNeuron, Map>(
          key: 'RegisterKnownNeuron',
          parse:
              (e) => NnsGovernanceKnownNeuron.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DeregisterKnownNeuron')) {
      return NnsGovernanceActionDeregisterKnownNeuron(
        json.valueTo<NnsGovernanceDeregisterKnownNeuron, Map>(
          key: 'DeregisterKnownNeuron',
          parse:
              (e) => NnsGovernanceDeregisterKnownNeuron.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ManageNeuron')) {
      return NnsGovernanceActionManageNeuron(
        json.valueTo<NnsGovernanceManageNeuronProposal, Map>(
          key: 'ManageNeuron',
          parse:
              (e) => NnsGovernanceManageNeuronProposal.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('UpdateCanisterSettings')) {
      return NnsGovernanceActionUpdateCanisterSettings(
        json.valueTo<NnsGovernanceUpdateCanisterSettings, Map>(
          key: 'UpdateCanisterSettings',
          parse:
              (e) => NnsGovernanceUpdateCanisterSettings.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('InstallCode')) {
      return NnsGovernanceActionInstallCode(
        json.valueTo<NnsGovernanceInstallCode, Map>(
          key: 'InstallCode',
          parse:
              (e) => NnsGovernanceInstallCode.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('StopOrStartCanister')) {
      return NnsGovernanceActionStopOrStartCanister(
        json.valueTo<NnsGovernanceStopOrStartCanister, Map>(
          key: 'StopOrStartCanister',
          parse:
              (e) => NnsGovernanceStopOrStartCanister.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('CreateServiceNervousSystem')) {
      return NnsGovernanceActionCreateServiceNervousSystem(
        json.valueTo<NnsGovernanceCreateServiceNervousSystem, Map>(
          key: 'CreateServiceNervousSystem',
          parse:
              (e) => NnsGovernanceCreateServiceNervousSystem.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ExecuteNnsFunction')) {
      return NnsGovernanceActionExecuteNnsFunction(
        json.valueTo<NnsGovernanceExecuteNnsFunction, Map>(
          key: 'ExecuteNnsFunction',
          parse:
              (e) => NnsGovernanceExecuteNnsFunction.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('RewardNodeProvider')) {
      return NnsGovernanceActionRewardNodeProvider(
        json.valueTo<NnsGovernanceRewardNodeProvider, Map>(
          key: 'RewardNodeProvider',
          parse:
              (e) => NnsGovernanceRewardNodeProvider.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('OpenSnsTokenSwap')) {
      return NnsGovernanceActionOpenSnsTokenSwap(
        json.valueTo<NnsGovernanceOpenSnsTokenSwap, Map>(
          key: 'OpenSnsTokenSwap',
          parse:
              (e) => NnsGovernanceOpenSnsTokenSwap.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('SetSnsTokenSwapOpenTimeWindow')) {
      return NnsGovernanceActionSetSnsTokenSwapOpenTimeWindow(
        json.valueTo<NnsGovernanceSetSnsTokenSwapOpenTimeWindow, Map>(
          key: 'SetSnsTokenSwapOpenTimeWindow',
          parse:
              (e) => NnsGovernanceSetSnsTokenSwapOpenTimeWindow.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('SetDefaultFollowees')) {
      return NnsGovernanceActionSetDefaultFollowees(
        json.valueTo<NnsGovernanceSetDefaultFollowees, Map>(
          key: 'SetDefaultFollowees',
          parse:
              (e) => NnsGovernanceSetDefaultFollowees.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('RewardNodeProviders')) {
      return NnsGovernanceActionRewardNodeProviders(
        json.valueTo<NnsGovernanceRewardNodeProviders, Map>(
          key: 'RewardNodeProviders',
          parse:
              (e) => NnsGovernanceRewardNodeProviders.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ManageNetworkEconomics')) {
      return NnsGovernanceActionManageNetworkEconomics(
        json.valueTo<NnsGovernanceNetworkEconomics, Map>(
          key: 'ManageNetworkEconomics',
          parse:
              (e) => NnsGovernanceNetworkEconomics.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ApproveGenesisKyc')) {
      return NnsGovernanceActionApproveGenesisKyc(
        json.valueTo<NnsGovernancePrincipals, Map>(
          key: 'ApproveGenesisKyc',
          parse:
              (e) => NnsGovernancePrincipals.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('AddOrRemoveNodeProvider')) {
      return NnsGovernanceActionAddOrRemoveNodeProvider(
        json.valueTo<NnsGovernanceAddOrRemoveNodeProvider, Map>(
          key: 'AddOrRemoveNodeProvider',
          parse:
              (e) => NnsGovernanceAddOrRemoveNodeProvider.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Motion')) {
      return NnsGovernanceActionMotion(
        json.valueTo<NnsGovernanceMotion, Map>(
          key: 'Motion',
          parse:
              (e) => NnsGovernanceMotion.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('FulfillSubnetRentalRequest')) {
      return NnsGovernanceActionFulfillSubnetRentalRequest(
        json.valueTo<NnsGovernanceFulfillSubnetRentalRequest, Map>(
          key: 'FulfillSubnetRentalRequest',
          parse:
              (e) => NnsGovernanceFulfillSubnetRentalRequest.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('BlessAlternativeGuestOsVersion')) {
      return NnsGovernanceActionBlessAlternativeGuestOsVersion(
        json.valueTo<NnsGovernanceBlessAlternativeGuestOsVersion, Map>(
          key: 'BlessAlternativeGuestOsVersion',
          parse:
              (e) => NnsGovernanceBlessAlternativeGuestOsVersion.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('TakeCanisterSnapshot')) {
      return NnsGovernanceActionTakeCanisterSnapshot(
        json.valueTo<NnsGovernanceTakeCanisterSnapshot, Map>(
          key: 'TakeCanisterSnapshot',
          parse:
              (e) => NnsGovernanceTakeCanisterSnapshot.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('LoadCanisterSnapshot')) {
      return NnsGovernanceActionLoadCanisterSnapshot(
        json.valueTo<NnsGovernanceLoadCanisterSnapshot, Map>(
          key: 'LoadCanisterSnapshot',
          parse:
              (e) => NnsGovernanceLoadCanisterSnapshot.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('CreateCanisterAndInstallCode')) {
      return NnsGovernanceActionCreateCanisterAndInstallCode(
        json.valueTo<NnsGovernanceCreateCanisterAndInstallCode, Map>(
          key: 'CreateCanisterAndInstallCode',
          parse:
              (e) => NnsGovernanceCreateCanisterAndInstallCode.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('UpdateStandardEngineReplicaVersion')) {
      return NnsGovernanceActionUpdateStandardEngineReplicaVersion(
        json.valueTo<NnsGovernanceUpdateStandardEngineReplicaVersion, Map>(
          key: 'UpdateStandardEngineReplicaVersion',
          parse:
              (e) => NnsGovernanceUpdateStandardEngineReplicaVersion.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceAction.fromCandid',
      reason: 'Unknown NnsGovernanceAction arm',
    );
  }

  factory NnsGovernanceAction.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceAction.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Action.RegisterKnownNeuron`.
final class NnsGovernanceActionRegisterKnownNeuron extends NnsGovernanceAction {
  final NnsGovernanceKnownNeuron value;
  const NnsGovernanceActionRegisterKnownNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('RegisterKnownNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RegisterKnownNeuron': value.toJson()};
}

/// Variant arm `Action.DeregisterKnownNeuron`.
final class NnsGovernanceActionDeregisterKnownNeuron
    extends NnsGovernanceAction {
  final NnsGovernanceDeregisterKnownNeuron value;
  const NnsGovernanceActionDeregisterKnownNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue =>
      Variant('DeregisterKnownNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DeregisterKnownNeuron': value.toJson()};
}

/// Variant arm `Action.ManageNeuron`.
final class NnsGovernanceActionManageNeuron extends NnsGovernanceAction {
  final NnsGovernanceManageNeuronProposal value;
  const NnsGovernanceActionManageNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('ManageNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ManageNeuron': value.toJson()};
}

/// Variant arm `Action.UpdateCanisterSettings`.
final class NnsGovernanceActionUpdateCanisterSettings
    extends NnsGovernanceAction {
  final NnsGovernanceUpdateCanisterSettings value;
  const NnsGovernanceActionUpdateCanisterSettings(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue =>
      Variant('UpdateCanisterSettings', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'UpdateCanisterSettings': value.toJson()};
}

/// Variant arm `Action.InstallCode`.
final class NnsGovernanceActionInstallCode extends NnsGovernanceAction {
  final NnsGovernanceInstallCode value;
  const NnsGovernanceActionInstallCode(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('InstallCode', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'InstallCode': value.toJson()};
}

/// Variant arm `Action.StopOrStartCanister`.
final class NnsGovernanceActionStopOrStartCanister extends NnsGovernanceAction {
  final NnsGovernanceStopOrStartCanister value;
  const NnsGovernanceActionStopOrStartCanister(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('StopOrStartCanister', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'StopOrStartCanister': value.toJson()};
}

/// Variant arm `Action.CreateServiceNervousSystem`.
final class NnsGovernanceActionCreateServiceNervousSystem
    extends NnsGovernanceAction {
  final NnsGovernanceCreateServiceNervousSystem value;
  const NnsGovernanceActionCreateServiceNervousSystem(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreateServiceNervousSystem', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'CreateServiceNervousSystem': value.toJson(),
  };
}

/// Variant arm `Action.ExecuteNnsFunction`.
final class NnsGovernanceActionExecuteNnsFunction extends NnsGovernanceAction {
  final NnsGovernanceExecuteNnsFunction value;
  const NnsGovernanceActionExecuteNnsFunction(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('ExecuteNnsFunction', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ExecuteNnsFunction': value.toJson()};
}

/// Variant arm `Action.RewardNodeProvider`.
final class NnsGovernanceActionRewardNodeProvider extends NnsGovernanceAction {
  final NnsGovernanceRewardNodeProvider value;
  const NnsGovernanceActionRewardNodeProvider(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('RewardNodeProvider', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RewardNodeProvider': value.toJson()};
}

/// Variant arm `Action.OpenSnsTokenSwap`.
final class NnsGovernanceActionOpenSnsTokenSwap extends NnsGovernanceAction {
  final NnsGovernanceOpenSnsTokenSwap value;
  const NnsGovernanceActionOpenSnsTokenSwap(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('OpenSnsTokenSwap', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'OpenSnsTokenSwap': value.toJson()};
}

/// Variant arm `Action.SetSnsTokenSwapOpenTimeWindow`.
final class NnsGovernanceActionSetSnsTokenSwapOpenTimeWindow
    extends NnsGovernanceAction {
  final NnsGovernanceSetSnsTokenSwapOpenTimeWindow value;
  const NnsGovernanceActionSetSnsTokenSwapOpenTimeWindow(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue =>
      Variant('SetSnsTokenSwapOpenTimeWindow', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'SetSnsTokenSwapOpenTimeWindow': value.toJson(),
  };
}

/// Variant arm `Action.SetDefaultFollowees`.
final class NnsGovernanceActionSetDefaultFollowees extends NnsGovernanceAction {
  final NnsGovernanceSetDefaultFollowees value;
  const NnsGovernanceActionSetDefaultFollowees(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('SetDefaultFollowees', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'SetDefaultFollowees': value.toJson()};
}

/// Variant arm `Action.RewardNodeProviders`.
final class NnsGovernanceActionRewardNodeProviders extends NnsGovernanceAction {
  final NnsGovernanceRewardNodeProviders value;
  const NnsGovernanceActionRewardNodeProviders(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('RewardNodeProviders', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RewardNodeProviders': value.toJson()};
}

/// Variant arm `Action.ManageNetworkEconomics`.
final class NnsGovernanceActionManageNetworkEconomics
    extends NnsGovernanceAction {
  final NnsGovernanceNetworkEconomics value;
  const NnsGovernanceActionManageNetworkEconomics(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue =>
      Variant('ManageNetworkEconomics', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ManageNetworkEconomics': value.toJson()};
}

/// Variant arm `Action.ApproveGenesisKyc`.
final class NnsGovernanceActionApproveGenesisKyc extends NnsGovernanceAction {
  final NnsGovernancePrincipals value;
  const NnsGovernanceActionApproveGenesisKyc(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('ApproveGenesisKyc', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ApproveGenesisKyc': value.toJson()};
}

/// Variant arm `Action.AddOrRemoveNodeProvider`.
final class NnsGovernanceActionAddOrRemoveNodeProvider
    extends NnsGovernanceAction {
  final NnsGovernanceAddOrRemoveNodeProvider value;
  const NnsGovernanceActionAddOrRemoveNodeProvider(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue =>
      Variant('AddOrRemoveNodeProvider', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'AddOrRemoveNodeProvider': value.toJson()};
}

/// Variant arm `Action.Motion`.
final class NnsGovernanceActionMotion extends NnsGovernanceAction {
  final NnsGovernanceMotion value;
  const NnsGovernanceActionMotion(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('Motion', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Motion': value.toJson()};
}

/// Variant arm `Action.FulfillSubnetRentalRequest`.
final class NnsGovernanceActionFulfillSubnetRentalRequest
    extends NnsGovernanceAction {
  final NnsGovernanceFulfillSubnetRentalRequest value;
  const NnsGovernanceActionFulfillSubnetRentalRequest(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue =>
      Variant('FulfillSubnetRentalRequest', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'FulfillSubnetRentalRequest': value.toJson(),
  };
}

/// Variant arm `Action.BlessAlternativeGuestOsVersion`.
final class NnsGovernanceActionBlessAlternativeGuestOsVersion
    extends NnsGovernanceAction {
  final NnsGovernanceBlessAlternativeGuestOsVersion value;
  const NnsGovernanceActionBlessAlternativeGuestOsVersion(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue =>
      Variant('BlessAlternativeGuestOsVersion', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'BlessAlternativeGuestOsVersion': value.toJson(),
  };
}

/// Variant arm `Action.TakeCanisterSnapshot`.
final class NnsGovernanceActionTakeCanisterSnapshot
    extends NnsGovernanceAction {
  final NnsGovernanceTakeCanisterSnapshot value;
  const NnsGovernanceActionTakeCanisterSnapshot(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('TakeCanisterSnapshot', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'TakeCanisterSnapshot': value.toJson()};
}

/// Variant arm `Action.LoadCanisterSnapshot`.
final class NnsGovernanceActionLoadCanisterSnapshot
    extends NnsGovernanceAction {
  final NnsGovernanceLoadCanisterSnapshot value;
  const NnsGovernanceActionLoadCanisterSnapshot(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue => Variant('LoadCanisterSnapshot', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'LoadCanisterSnapshot': value.toJson()};
}

/// Variant arm `Action.CreateCanisterAndInstallCode`.
final class NnsGovernanceActionCreateCanisterAndInstallCode
    extends NnsGovernanceAction {
  final NnsGovernanceCreateCanisterAndInstallCode value;
  const NnsGovernanceActionCreateCanisterAndInstallCode(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreateCanisterAndInstallCode', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'CreateCanisterAndInstallCode': value.toJson(),
  };
}

/// Variant arm `Action.UpdateStandardEngineReplicaVersion`.
final class NnsGovernanceActionUpdateStandardEngineReplicaVersion
    extends NnsGovernanceAction {
  final NnsGovernanceUpdateStandardEngineReplicaVersion value;
  const NnsGovernanceActionUpdateStandardEngineReplicaVersion(this.value);

  @override
  CType get candidType => NnsGovernanceAction.ctype;

  @override
  dynamic get candidValue =>
      Variant('UpdateStandardEngineReplicaVersion', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'UpdateStandardEngineReplicaVersion': value.toJson(),
  };
}

/// Candid record `AddHotKey`.
final class NnsGovernanceAddHotKey with CandidSerializable {
  final IcpPrincipalAddress? newHotKey;

  const NnsGovernanceAddHotKey({this.newHotKey});

  static CType get ctype => CType.record([
    Field(Label.named('new_hot_key'), CType.opt(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'new_hot_key': newHotKey};

  Map<String, dynamic> toJson() => {'new_hot_key': newHotKey?.address};

  factory NnsGovernanceAddHotKey.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceAddHotKey(
      newHotKey: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'new_hot_key',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsGovernanceAddHotKey.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceAddHotKey.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AddOrRemoveNodeProvider`.
final class NnsGovernanceAddOrRemoveNodeProvider with CandidSerializable {
  final NnsGovernanceChange? change;

  const NnsGovernanceAddOrRemoveNodeProvider({this.change});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('change'),
      () => CType.opt(NnsGovernanceChange.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'change': change?.candidValue};

  Map<String, dynamic> toJson() => {'change': change?.toJson()};

  factory NnsGovernanceAddOrRemoveNodeProvider.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceAddOrRemoveNodeProvider(
      change: json.valueTo<NnsGovernanceChange?, Map>(
        key: 'change',
        parse:
            (e) => NnsGovernanceChange.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceAddOrRemoveNodeProvider.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceAddOrRemoveNodeProvider.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Amount`.
final class NnsGovernanceAmount with CandidSerializable {
  final BigInt e8s;

  const NnsGovernanceAmount({required this.e8s});

  static CType get ctype =>
      CType.record([Field(Label.named('e8s'), CType.nat64)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'e8s': e8s};

  Map<String, dynamic> toJson() => {'e8s': e8s};

  factory NnsGovernanceAmount.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceAmount(e8s: json.valueAsBigInt<BigInt>('e8s'));
  }

  factory NnsGovernanceAmount.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceAmount.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ApproveGenesisKyc`.
final class NnsGovernanceApproveGenesisKyc with CandidSerializable {
  final List<IcpPrincipalAddress> principals;

  const NnsGovernanceApproveGenesisKyc({required this.principals});

  static CType get ctype => CType.record([
    Field(Label.named('principals'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'principals': principals};

  Map<String, dynamic> toJson() => {
    'principals': principals.map((el) => el.address).toList(),
  };

  factory NnsGovernanceApproveGenesisKyc.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceApproveGenesisKyc(
      principals: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'principals',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceApproveGenesisKyc.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceApproveGenesisKyc.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Ballot`.
final class NnsGovernanceBallot with CandidSerializable {
  final int vote;
  final BigInt votingPower;

  const NnsGovernanceBallot({required this.vote, required this.votingPower});

  static CType get ctype => CType.record([
    Field(Label.named('vote'), CType.int32),
    Field(Label.named('voting_power'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'vote': vote, 'voting_power': votingPower};

  Map<String, dynamic> toJson() => {'vote': vote, 'voting_power': votingPower};

  factory NnsGovernanceBallot.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceBallot(
      vote: json.valueAsInt<int>('vote'),
      votingPower: json.valueAsBigInt<BigInt>('voting_power'),
    );
  }

  factory NnsGovernanceBallot.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceBallot.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `BallotInfo`.
final class NnsGovernanceBallotInfo with CandidSerializable {
  final int vote;
  final NnsGovernanceProposalId? proposalId;

  const NnsGovernanceBallotInfo({required this.vote, this.proposalId});

  static CType get ctype => CType.record([
    Field(Label.named('vote'), CType.int32),
    LazyField(
      Label.named('proposal_id'),
      () => CType.opt(NnsGovernanceProposalId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'vote': vote,
    'proposal_id': proposalId?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'vote': vote,
    'proposal_id': proposalId?.toJson(),
  };

  factory NnsGovernanceBallotInfo.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceBallotInfo(
      vote: json.valueAsInt<int>('vote'),
      proposalId: json.valueTo<NnsGovernanceProposalId?, Map>(
        key: 'proposal_id',
        parse:
            (e) => NnsGovernanceProposalId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceBallotInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceBallotInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `By`.
sealed class NnsGovernanceBy with CandidSerializable {
  const NnsGovernanceBy();

  static CType get ctype => CType.variant([
    Field(Label.named('NeuronIdOrSubaccount'), CType.record(const [])),
    LazyField(
      Label.named('MemoAndController'),
      () => NnsGovernanceClaimOrRefreshNeuronFromAccount.ctype,
    ),
    Field(Label.named('Memo'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceBy.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('NeuronIdOrSubaccount')) {
      return NnsGovernanceByNeuronIdOrSubaccount.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['NeuronIdOrSubaccount'],
        ),
      );
    }
    if (json.containsKey('MemoAndController')) {
      return NnsGovernanceByMemoAndController(
        json.valueTo<NnsGovernanceClaimOrRefreshNeuronFromAccount, Map>(
          key: 'MemoAndController',
          parse:
              (e) => NnsGovernanceClaimOrRefreshNeuronFromAccount.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Memo')) {
      return NnsGovernanceByMemo(json.valueAsBigInt<BigInt>('Memo'));
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceBy.fromCandid',
      reason: 'Unknown NnsGovernanceBy arm',
    );
  }

  factory NnsGovernanceBy.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceBy.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `By.NeuronIdOrSubaccount`.
final class NnsGovernanceByNeuronIdOrSubaccount extends NnsGovernanceBy {
  const NnsGovernanceByNeuronIdOrSubaccount();

  @override
  CType get candidType => NnsGovernanceBy.ctype;

  @override
  dynamic get candidValue => Variant('NeuronIdOrSubaccount', {});

  @override
  Map<String, dynamic> toJson() => {'NeuronIdOrSubaccount': {}};

  factory NnsGovernanceByNeuronIdOrSubaccount.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceByNeuronIdOrSubaccount();
  }
}

/// Variant arm `By.MemoAndController`.
final class NnsGovernanceByMemoAndController extends NnsGovernanceBy {
  final NnsGovernanceClaimOrRefreshNeuronFromAccount value;
  const NnsGovernanceByMemoAndController(this.value);

  @override
  CType get candidType => NnsGovernanceBy.ctype;

  @override
  dynamic get candidValue => Variant('MemoAndController', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'MemoAndController': value.toJson()};
}

/// Variant arm `By.Memo`.
final class NnsGovernanceByMemo extends NnsGovernanceBy {
  final BigInt value;
  const NnsGovernanceByMemo(this.value);

  @override
  CType get candidType => NnsGovernanceBy.ctype;

  @override
  dynamic get candidValue => Variant('Memo', value);

  @override
  Map<String, dynamic> toJson() => {'Memo': value};
}

/// Candid record `Canister`.
final class NnsGovernanceCanister with CandidSerializable {
  final IcpPrincipalAddress? id;

  const NnsGovernanceCanister({this.id});

  static CType get ctype =>
      CType.record([Field(Label.named('id'), CType.opt(CType.principal))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'id': id};

  Map<String, dynamic> toJson() => {'id': id?.address};

  factory NnsGovernanceCanister.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceCanister(
      id: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsGovernanceCanister.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCanister.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CanisterSettings`.
final class NnsGovernanceCanisterSettings with CandidSerializable {
  final BigInt? freezingThreshold;
  final NnsGovernanceControllers? controllers;
  final int? logVisibility;
  final int? snapshotVisibility;
  final BigInt? wasmMemoryLimit;
  final BigInt? memoryAllocation;
  final BigInt? computeAllocation;
  final BigInt? wasmMemoryThreshold;

  const NnsGovernanceCanisterSettings({
    this.freezingThreshold,
    this.controllers,
    this.logVisibility,
    this.snapshotVisibility,
    this.wasmMemoryLimit,
    this.memoryAllocation,
    this.computeAllocation,
    this.wasmMemoryThreshold,
  });

  static CType get ctype => CType.record([
    Field(Label.named('freezing_threshold'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('controllers'),
      () => CType.opt(NnsGovernanceControllers.ctype),
    ),
    Field(Label.named('log_visibility'), CType.opt(CType.int32)),
    Field(Label.named('snapshot_visibility'), CType.opt(CType.int32)),
    Field(Label.named('wasm_memory_limit'), CType.opt(CType.nat64)),
    Field(Label.named('memory_allocation'), CType.opt(CType.nat64)),
    Field(Label.named('compute_allocation'), CType.opt(CType.nat64)),
    Field(Label.named('wasm_memory_threshold'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'freezing_threshold': freezingThreshold,
    'controllers': controllers?.candidValue,
    'log_visibility': logVisibility,
    'snapshot_visibility': snapshotVisibility,
    'wasm_memory_limit': wasmMemoryLimit,
    'memory_allocation': memoryAllocation,
    'compute_allocation': computeAllocation,
    'wasm_memory_threshold': wasmMemoryThreshold,
  };

  Map<String, dynamic> toJson() => {
    'freezing_threshold': freezingThreshold,
    'controllers': controllers?.toJson(),
    'log_visibility': logVisibility,
    'snapshot_visibility': snapshotVisibility,
    'wasm_memory_limit': wasmMemoryLimit,
    'memory_allocation': memoryAllocation,
    'compute_allocation': computeAllocation,
    'wasm_memory_threshold': wasmMemoryThreshold,
  };

  factory NnsGovernanceCanisterSettings.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceCanisterSettings(
      freezingThreshold: json.valueAsBigInt<BigInt?>('freezing_threshold'),
      controllers: json.valueTo<NnsGovernanceControllers?, Map>(
        key: 'controllers',
        parse:
            (e) => NnsGovernanceControllers.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      logVisibility: json.valueAsInt<int?>('log_visibility'),
      snapshotVisibility: json.valueAsInt<int?>('snapshot_visibility'),
      wasmMemoryLimit: json.valueAsBigInt<BigInt?>('wasm_memory_limit'),
      memoryAllocation: json.valueAsBigInt<BigInt?>('memory_allocation'),
      computeAllocation: json.valueAsBigInt<BigInt?>('compute_allocation'),
      wasmMemoryThreshold: json.valueAsBigInt<BigInt?>('wasm_memory_threshold'),
    );
  }

  factory NnsGovernanceCanisterSettings.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCanisterSettings.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CanisterStatusResultV2`.
final class NnsGovernanceCanisterStatusResultV2 with CandidSerializable {
  final int? status;
  final BigInt? freezingThreshold;
  final List<IcpPrincipalAddress> controllers;
  final BigInt? memorySize;
  final BigInt? cycles;
  final BigInt? idleCyclesBurnedPerDay;
  final List<int> moduleHash;

  const NnsGovernanceCanisterStatusResultV2({
    this.status,
    this.freezingThreshold,
    required this.controllers,
    this.memorySize,
    this.cycles,
    this.idleCyclesBurnedPerDay,
    required this.moduleHash,
  });

  static CType get ctype => CType.record([
    Field(Label.named('status'), CType.opt(CType.int32)),
    Field(Label.named('freezing_threshold'), CType.opt(CType.nat64)),
    Field(Label.named('controllers'), CType.vec(CType.principal)),
    Field(Label.named('memory_size'), CType.opt(CType.nat64)),
    Field(Label.named('cycles'), CType.opt(CType.nat64)),
    Field(Label.named('idle_cycles_burned_per_day'), CType.opt(CType.nat64)),
    Field(Label.named('module_hash'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'status': status,
    'freezing_threshold': freezingThreshold,
    'controllers': controllers,
    'memory_size': memorySize,
    'cycles': cycles,
    'idle_cycles_burned_per_day': idleCyclesBurnedPerDay,
    'module_hash': moduleHash,
  };

  Map<String, dynamic> toJson() => {
    'status': status,
    'freezing_threshold': freezingThreshold,
    'controllers': controllers.map((el) => el.address).toList(),
    'memory_size': memorySize,
    'cycles': cycles,
    'idle_cycles_burned_per_day': idleCyclesBurnedPerDay,
    'module_hash': moduleHash,
  };

  factory NnsGovernanceCanisterStatusResultV2.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceCanisterStatusResultV2(
      status: json.valueAsInt<int?>('status'),
      freezingThreshold: json.valueAsBigInt<BigInt?>('freezing_threshold'),
      controllers: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'controllers',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      memorySize: json.valueAsBigInt<BigInt?>('memory_size'),
      cycles: json.valueAsBigInt<BigInt?>('cycles'),
      idleCyclesBurnedPerDay: json.valueAsBigInt<BigInt?>(
        'idle_cycles_burned_per_day',
      ),
      moduleHash: json.valueAsBytes<List<int>>(
        'module_hash',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsGovernanceCanisterStatusResultV2.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCanisterStatusResultV2.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CanisterSummary`.
final class NnsGovernanceCanisterSummary with CandidSerializable {
  final NnsGovernanceCanisterStatusResultV2? status;
  final IcpPrincipalAddress? canisterId;

  const NnsGovernanceCanisterSummary({this.status, this.canisterId});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('status'),
      () => CType.opt(NnsGovernanceCanisterStatusResultV2.ctype),
    ),
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'status': status?.candidValue,
    'canister_id': canisterId,
  };

  Map<String, dynamic> toJson() => {
    'status': status?.toJson(),
    'canister_id': canisterId?.address,
  };

  factory NnsGovernanceCanisterSummary.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceCanisterSummary(
      status: json.valueTo<NnsGovernanceCanisterStatusResultV2?, Map>(
        key: 'status',
        parse:
            (e) => NnsGovernanceCanisterStatusResultV2.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsGovernanceCanisterSummary.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCanisterSummary.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CanisterUpgradeOptions`.
final class NnsGovernanceCanisterUpgradeOptions with CandidSerializable {
  final bool? skipPreUpgrade;
  final int? wasmMemoryPersistence;

  const NnsGovernanceCanisterUpgradeOptions({
    this.skipPreUpgrade,
    this.wasmMemoryPersistence,
  });

  static CType get ctype => CType.record([
    Field(Label.named('skip_pre_upgrade'), CType.opt(CType.bool_)),
    Field(Label.named('wasm_memory_persistence'), CType.opt(CType.int32)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'skip_pre_upgrade': skipPreUpgrade,
    'wasm_memory_persistence': wasmMemoryPersistence,
  };

  Map<String, dynamic> toJson() => {
    'skip_pre_upgrade': skipPreUpgrade,
    'wasm_memory_persistence': wasmMemoryPersistence,
  };

  factory NnsGovernanceCanisterUpgradeOptions.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceCanisterUpgradeOptions(
      skipPreUpgrade: json.valueAsBool<bool?>('skip_pre_upgrade'),
      wasmMemoryPersistence: json.valueAsInt<int?>('wasm_memory_persistence'),
    );
  }

  factory NnsGovernanceCanisterUpgradeOptions.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCanisterUpgradeOptions.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Change`.
sealed class NnsGovernanceChange with CandidSerializable {
  const NnsGovernanceChange();

  static CType get ctype => CType.variant([
    LazyField(Label.named('ToRemove'), () => NnsGovernanceNodeProvider.ctype),
    LazyField(Label.named('ToAdd'), () => NnsGovernanceNodeProvider.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceChange.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('ToRemove')) {
      return NnsGovernanceChangeToRemove(
        json.valueTo<NnsGovernanceNodeProvider, Map>(
          key: 'ToRemove',
          parse:
              (e) => NnsGovernanceNodeProvider.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ToAdd')) {
      return NnsGovernanceChangeToAdd(
        json.valueTo<NnsGovernanceNodeProvider, Map>(
          key: 'ToAdd',
          parse:
              (e) => NnsGovernanceNodeProvider.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceChange.fromCandid',
      reason: 'Unknown NnsGovernanceChange arm',
    );
  }

  factory NnsGovernanceChange.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceChange.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Change.ToRemove`.
final class NnsGovernanceChangeToRemove extends NnsGovernanceChange {
  final NnsGovernanceNodeProvider value;
  const NnsGovernanceChangeToRemove(this.value);

  @override
  CType get candidType => NnsGovernanceChange.ctype;

  @override
  dynamic get candidValue => Variant('ToRemove', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ToRemove': value.toJson()};
}

/// Variant arm `Change.ToAdd`.
final class NnsGovernanceChangeToAdd extends NnsGovernanceChange {
  final NnsGovernanceNodeProvider value;
  const NnsGovernanceChangeToAdd(this.value);

  @override
  CType get candidType => NnsGovernanceChange.ctype;

  @override
  dynamic get candidValue => Variant('ToAdd', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ToAdd': value.toJson()};
}

/// Candid record `ChangeAutoStakeMaturity`.
final class NnsGovernanceChangeAutoStakeMaturity with CandidSerializable {
  final bool requestedSettingForAutoStakeMaturity;

  const NnsGovernanceChangeAutoStakeMaturity({
    required this.requestedSettingForAutoStakeMaturity,
  });

  static CType get ctype => CType.record([
    Field(
      Label.named('requested_setting_for_auto_stake_maturity'),
      CType.bool_,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'requested_setting_for_auto_stake_maturity':
        requestedSettingForAutoStakeMaturity,
  };

  Map<String, dynamic> toJson() => {
    'requested_setting_for_auto_stake_maturity':
        requestedSettingForAutoStakeMaturity,
  };

  factory NnsGovernanceChangeAutoStakeMaturity.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceChangeAutoStakeMaturity(
      requestedSettingForAutoStakeMaturity: json.valueAsBool<bool>(
        'requested_setting_for_auto_stake_maturity',
      ),
    );
  }

  factory NnsGovernanceChangeAutoStakeMaturity.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceChangeAutoStakeMaturity.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ClaimOrRefresh`.
final class NnsGovernanceClaimOrRefresh with CandidSerializable {
  final NnsGovernanceBy? by;

  const NnsGovernanceClaimOrRefresh({this.by});

  static CType get ctype => CType.record([
    LazyField(Label.named('by'), () => CType.opt(NnsGovernanceBy.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'by': by?.candidValue};

  Map<String, dynamic> toJson() => {'by': by?.toJson()};

  factory NnsGovernanceClaimOrRefresh.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceClaimOrRefresh(
      by: json.valueTo<NnsGovernanceBy?, Map>(
        key: 'by',
        parse:
            (e) => NnsGovernanceBy.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceClaimOrRefresh.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceClaimOrRefresh.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ClaimOrRefreshNeuronFromAccount`.
final class NnsGovernanceClaimOrRefreshNeuronFromAccount
    with CandidSerializable {
  final IcpPrincipalAddress? controller;
  final BigInt memo;

  const NnsGovernanceClaimOrRefreshNeuronFromAccount({
    this.controller,
    required this.memo,
  });

  static CType get ctype => CType.record([
    Field(Label.named('controller'), CType.opt(CType.principal)),
    Field(Label.named('memo'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'controller': controller, 'memo': memo};

  Map<String, dynamic> toJson() => {
    'controller': controller?.address,
    'memo': memo,
  };

  factory NnsGovernanceClaimOrRefreshNeuronFromAccount.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceClaimOrRefreshNeuronFromAccount(
      controller: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'controller',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      memo: json.valueAsBigInt<BigInt>('memo'),
    );
  }

  factory NnsGovernanceClaimOrRefreshNeuronFromAccount.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceClaimOrRefreshNeuronFromAccount.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ClaimOrRefreshNeuronFromAccountResponse`.
final class NnsGovernanceClaimOrRefreshNeuronFromAccountResponse
    with CandidSerializable {
  final NnsGovernanceResult1? result;

  const NnsGovernanceClaimOrRefreshNeuronFromAccountResponse({this.result});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('result'),
      () => CType.opt(NnsGovernanceResult1.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'result': result?.candidValue};

  Map<String, dynamic> toJson() => {'result': result?.toJson()};

  factory NnsGovernanceClaimOrRefreshNeuronFromAccountResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceClaimOrRefreshNeuronFromAccountResponse(
      result: json.valueTo<NnsGovernanceResult1?, Map>(
        key: 'result',
        parse:
            (e) => NnsGovernanceResult1.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceClaimOrRefreshNeuronFromAccountResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceClaimOrRefreshNeuronFromAccountResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ClaimOrRefreshResponse`.
final class NnsGovernanceClaimOrRefreshResponse with CandidSerializable {
  final NnsGovernanceNeuronId? refreshedNeuronId;

  const NnsGovernanceClaimOrRefreshResponse({this.refreshedNeuronId});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('refreshed_neuron_id'),
      () => CType.opt(NnsGovernanceNeuronId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'refreshed_neuron_id': refreshedNeuronId?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'refreshed_neuron_id': refreshedNeuronId?.toJson(),
  };

  factory NnsGovernanceClaimOrRefreshResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceClaimOrRefreshResponse(
      refreshedNeuronId: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'refreshed_neuron_id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceClaimOrRefreshResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceClaimOrRefreshResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RefreshVotingPower`.
final class NnsGovernanceRefreshVotingPower with CandidSerializable {
  const NnsGovernanceRefreshVotingPower();

  static CType get ctype => CType.record(const []);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => <String, dynamic>{};

  Map<String, dynamic> toJson() => <String, dynamic>{};

  factory NnsGovernanceRefreshVotingPower.fromCandid(
    Map<String, dynamic> json,
  ) {
    return const NnsGovernanceRefreshVotingPower();
  }

  factory NnsGovernanceRefreshVotingPower.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRefreshVotingPower.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RefreshVotingPowerResponse`.
final class NnsGovernanceRefreshVotingPowerResponse with CandidSerializable {
  const NnsGovernanceRefreshVotingPowerResponse();

  static CType get ctype => CType.record(const []);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => <String, dynamic>{};

  Map<String, dynamic> toJson() => <String, dynamic>{};

  factory NnsGovernanceRefreshVotingPowerResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return const NnsGovernanceRefreshVotingPowerResponse();
  }

  factory NnsGovernanceRefreshVotingPowerResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRefreshVotingPowerResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DisburseMaturity`.
final class NnsGovernanceDisburseMaturity with CandidSerializable {
  final int percentageToDisburse;
  final NnsGovernanceAccount? toAccount;
  final NnsGovernanceAccountIdentifier? toAccountIdentifier;

  const NnsGovernanceDisburseMaturity({
    required this.percentageToDisburse,
    this.toAccount,
    this.toAccountIdentifier,
  });

  static CType get ctype => CType.record([
    Field(Label.named('percentage_to_disburse'), CType.nat32),
    LazyField(
      Label.named('to_account'),
      () => CType.opt(NnsGovernanceAccount.ctype),
    ),
    LazyField(
      Label.named('to_account_identifier'),
      () => CType.opt(NnsGovernanceAccountIdentifier.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'percentage_to_disburse': percentageToDisburse,
    'to_account': toAccount?.candidValue,
    'to_account_identifier': toAccountIdentifier?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'percentage_to_disburse': percentageToDisburse,
    'to_account': toAccount?.toJson(),
    'to_account_identifier': toAccountIdentifier?.toJson(),
  };

  factory NnsGovernanceDisburseMaturity.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceDisburseMaturity(
      percentageToDisburse: json.valueAsInt<int>('percentage_to_disburse'),
      toAccount: json.valueTo<NnsGovernanceAccount?, Map>(
        key: 'to_account',
        parse:
            (e) => NnsGovernanceAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      toAccountIdentifier: json.valueTo<NnsGovernanceAccountIdentifier?, Map>(
        key: 'to_account_identifier',
        parse:
            (e) => NnsGovernanceAccountIdentifier.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceDisburseMaturity.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDisburseMaturity.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Account`.
final class NnsGovernanceAccount with CandidSerializable {
  final IcpPrincipalAddress? owner;
  final List<int>? subaccount;

  const NnsGovernanceAccount({this.owner, this.subaccount});

  static CType get ctype => CType.record([
    Field(Label.named('owner'), CType.opt(CType.principal)),
    Field(Label.named('subaccount'), CType.opt(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'owner': owner, 'subaccount': subaccount};

  Map<String, dynamic> toJson() => {
    'owner': owner?.address,
    'subaccount': subaccount,
  };

  factory NnsGovernanceAccount.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceAccount(
      owner: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'owner',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      subaccount: json.valueAsBytes<List<int>?>(
        'subaccount',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsGovernanceAccount.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceAccount.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DisburseMaturityResponse`.
final class NnsGovernanceDisburseMaturityResponse with CandidSerializable {
  final BigInt? amountDisbursedE8s;

  const NnsGovernanceDisburseMaturityResponse({this.amountDisbursedE8s});

  static CType get ctype => CType.record([
    Field(Label.named('amount_disbursed_e8s'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'amount_disbursed_e8s': amountDisbursedE8s};

  Map<String, dynamic> toJson() => {'amount_disbursed_e8s': amountDisbursedE8s};

  factory NnsGovernanceDisburseMaturityResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceDisburseMaturityResponse(
      amountDisbursedE8s: json.valueAsBigInt<BigInt?>('amount_disbursed_e8s'),
    );
  }

  factory NnsGovernanceDisburseMaturityResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDisburseMaturityResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SetFollowing`.
final class NnsGovernanceSetFollowing with CandidSerializable {
  final List<NnsGovernanceFolloweesForTopic>? topicFollowing;

  const NnsGovernanceSetFollowing({this.topicFollowing});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('topic_following'),
      () => CType.opt(CType.vec(NnsGovernanceFolloweesForTopic.ctype)),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'topic_following': topicFollowing?.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'topic_following': topicFollowing?.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceSetFollowing.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceSetFollowing(
      topicFollowing: json.valueTo<List<NnsGovernanceFolloweesForTopic>?, List>(
        key: 'topic_following',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceFolloweesForTopic>(
                      (x) => NnsGovernanceFolloweesForTopic.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceSetFollowing.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSetFollowing.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `FolloweesForTopic`.
final class NnsGovernanceFolloweesForTopic with CandidSerializable {
  final List<NnsGovernanceNeuronId>? followees;
  final int? topic;

  const NnsGovernanceFolloweesForTopic({this.followees, this.topic});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('followees'),
      () => CType.opt(CType.vec(NnsGovernanceNeuronId.ctype)),
    ),
    Field(Label.named('topic'), CType.opt(CType.int32)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'followees': followees?.map((el) => el.candidValue).toList(),
    'topic': topic,
  };

  Map<String, dynamic> toJson() => {
    'followees': followees?.map((el) => el.toJson()).toList(),
    'topic': topic,
  };

  factory NnsGovernanceFolloweesForTopic.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceFolloweesForTopic(
      followees: json.valueTo<List<NnsGovernanceNeuronId>?, List>(
        key: 'followees',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceNeuronId>(
                      (x) => NnsGovernanceNeuronId.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      topic: json.valueAsInt<int?>('topic'),
    );
  }

  factory NnsGovernanceFolloweesForTopic.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceFolloweesForTopic.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SetFollowingResponse`.
final class NnsGovernanceSetFollowingResponse with CandidSerializable {
  const NnsGovernanceSetFollowingResponse();

  static CType get ctype => CType.record(const []);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => <String, dynamic>{};

  Map<String, dynamic> toJson() => <String, dynamic>{};

  factory NnsGovernanceSetFollowingResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return const NnsGovernanceSetFollowingResponse();
  }

  factory NnsGovernanceSetFollowingResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSetFollowingResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ManageNeuronProposalCommand`.
sealed class NnsGovernanceManageNeuronProposalCommand with CandidSerializable {
  const NnsGovernanceManageNeuronProposalCommand();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Spawn'), () => NnsGovernanceSpawn.ctype),
    LazyField(Label.named('Split'), () => NnsGovernanceSplit.ctype),
    LazyField(Label.named('Follow'), () => NnsGovernanceFollow.ctype),
    LazyField(
      Label.named('ClaimOrRefresh'),
      () => NnsGovernanceClaimOrRefresh.ctype,
    ),
    LazyField(Label.named('Configure'), () => NnsGovernanceConfigure.ctype),
    LazyField(
      Label.named('RegisterVote'),
      () => NnsGovernanceRegisterVote.ctype,
    ),
    LazyField(Label.named('Merge'), () => NnsGovernanceMerge.ctype),
    LazyField(
      Label.named('DisburseToNeuron'),
      () => NnsGovernanceDisburseToNeuron.ctype,
    ),
    LazyField(Label.named('MakeProposal'), () => NnsGovernanceProposal.ctype),
    LazyField(
      Label.named('StakeMaturity'),
      () => NnsGovernanceStakeMaturity.ctype,
    ),
    LazyField(
      Label.named('MergeMaturity'),
      () => NnsGovernanceMergeMaturity.ctype,
    ),
    LazyField(Label.named('Disburse'), () => NnsGovernanceDisburse.ctype),
    LazyField(
      Label.named('RefreshVotingPower'),
      () => NnsGovernanceRefreshVotingPower.ctype,
    ),
    LazyField(
      Label.named('DisburseMaturity'),
      () => NnsGovernanceDisburseMaturity.ctype,
    ),
    LazyField(
      Label.named('SetFollowing'),
      () => NnsGovernanceSetFollowing.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceManageNeuronProposalCommand.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Spawn')) {
      return NnsGovernanceManageNeuronProposalCommandSpawn(
        json.valueTo<NnsGovernanceSpawn, Map>(
          key: 'Spawn',
          parse:
              (e) => NnsGovernanceSpawn.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Split')) {
      return NnsGovernanceManageNeuronProposalCommandSplit(
        json.valueTo<NnsGovernanceSplit, Map>(
          key: 'Split',
          parse:
              (e) => NnsGovernanceSplit.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Follow')) {
      return NnsGovernanceManageNeuronProposalCommandFollow(
        json.valueTo<NnsGovernanceFollow, Map>(
          key: 'Follow',
          parse:
              (e) => NnsGovernanceFollow.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ClaimOrRefresh')) {
      return NnsGovernanceManageNeuronProposalCommandClaimOrRefresh(
        json.valueTo<NnsGovernanceClaimOrRefresh, Map>(
          key: 'ClaimOrRefresh',
          parse:
              (e) => NnsGovernanceClaimOrRefresh.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Configure')) {
      return NnsGovernanceManageNeuronProposalCommandConfigure(
        json.valueTo<NnsGovernanceConfigure, Map>(
          key: 'Configure',
          parse:
              (e) => NnsGovernanceConfigure.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('RegisterVote')) {
      return NnsGovernanceManageNeuronProposalCommandRegisterVote(
        json.valueTo<NnsGovernanceRegisterVote, Map>(
          key: 'RegisterVote',
          parse:
              (e) => NnsGovernanceRegisterVote.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Merge')) {
      return NnsGovernanceManageNeuronProposalCommandMerge(
        json.valueTo<NnsGovernanceMerge, Map>(
          key: 'Merge',
          parse:
              (e) => NnsGovernanceMerge.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DisburseToNeuron')) {
      return NnsGovernanceManageNeuronProposalCommandDisburseToNeuron(
        json.valueTo<NnsGovernanceDisburseToNeuron, Map>(
          key: 'DisburseToNeuron',
          parse:
              (e) => NnsGovernanceDisburseToNeuron.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('MakeProposal')) {
      return NnsGovernanceManageNeuronProposalCommandMakeProposal(
        json.valueTo<NnsGovernanceProposal, Map>(
          key: 'MakeProposal',
          parse:
              (e) => NnsGovernanceProposal.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('StakeMaturity')) {
      return NnsGovernanceManageNeuronProposalCommandStakeMaturity(
        json.valueTo<NnsGovernanceStakeMaturity, Map>(
          key: 'StakeMaturity',
          parse:
              (e) => NnsGovernanceStakeMaturity.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('MergeMaturity')) {
      return NnsGovernanceManageNeuronProposalCommandMergeMaturity(
        json.valueTo<NnsGovernanceMergeMaturity, Map>(
          key: 'MergeMaturity',
          parse:
              (e) => NnsGovernanceMergeMaturity.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Disburse')) {
      return NnsGovernanceManageNeuronProposalCommandDisburse(
        json.valueTo<NnsGovernanceDisburse, Map>(
          key: 'Disburse',
          parse:
              (e) => NnsGovernanceDisburse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('RefreshVotingPower')) {
      return NnsGovernanceManageNeuronProposalCommandRefreshVotingPower(
        json.valueTo<NnsGovernanceRefreshVotingPower, Map>(
          key: 'RefreshVotingPower',
          parse:
              (e) => NnsGovernanceRefreshVotingPower.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DisburseMaturity')) {
      return NnsGovernanceManageNeuronProposalCommandDisburseMaturity(
        json.valueTo<NnsGovernanceDisburseMaturity, Map>(
          key: 'DisburseMaturity',
          parse:
              (e) => NnsGovernanceDisburseMaturity.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('SetFollowing')) {
      return NnsGovernanceManageNeuronProposalCommandSetFollowing(
        json.valueTo<NnsGovernanceSetFollowing, Map>(
          key: 'SetFollowing',
          parse:
              (e) => NnsGovernanceSetFollowing.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceManageNeuronProposalCommand.fromCandid',
      reason: 'Unknown NnsGovernanceManageNeuronProposalCommand arm',
    );
  }

  factory NnsGovernanceManageNeuronProposalCommand.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceManageNeuronProposalCommand.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ManageNeuronProposalCommand.Spawn`.
final class NnsGovernanceManageNeuronProposalCommandSpawn
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceSpawn value;
  const NnsGovernanceManageNeuronProposalCommandSpawn(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('Spawn', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Spawn': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.Split`.
final class NnsGovernanceManageNeuronProposalCommandSplit
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceSplit value;
  const NnsGovernanceManageNeuronProposalCommandSplit(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('Split', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Split': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.Follow`.
final class NnsGovernanceManageNeuronProposalCommandFollow
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceFollow value;
  const NnsGovernanceManageNeuronProposalCommandFollow(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('Follow', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Follow': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.ClaimOrRefresh`.
final class NnsGovernanceManageNeuronProposalCommandClaimOrRefresh
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceClaimOrRefresh value;
  const NnsGovernanceManageNeuronProposalCommandClaimOrRefresh(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('ClaimOrRefresh', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ClaimOrRefresh': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.Configure`.
final class NnsGovernanceManageNeuronProposalCommandConfigure
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceConfigure value;
  const NnsGovernanceManageNeuronProposalCommandConfigure(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('Configure', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Configure': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.RegisterVote`.
final class NnsGovernanceManageNeuronProposalCommandRegisterVote
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceRegisterVote value;
  const NnsGovernanceManageNeuronProposalCommandRegisterVote(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('RegisterVote', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RegisterVote': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.Merge`.
final class NnsGovernanceManageNeuronProposalCommandMerge
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceMerge value;
  const NnsGovernanceManageNeuronProposalCommandMerge(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('Merge', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Merge': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.DisburseToNeuron`.
final class NnsGovernanceManageNeuronProposalCommandDisburseToNeuron
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceDisburseToNeuron value;
  const NnsGovernanceManageNeuronProposalCommandDisburseToNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('DisburseToNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DisburseToNeuron': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.MakeProposal`.
final class NnsGovernanceManageNeuronProposalCommandMakeProposal
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceProposal value;
  const NnsGovernanceManageNeuronProposalCommandMakeProposal(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('MakeProposal', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'MakeProposal': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.StakeMaturity`.
final class NnsGovernanceManageNeuronProposalCommandStakeMaturity
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceStakeMaturity value;
  const NnsGovernanceManageNeuronProposalCommandStakeMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('StakeMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'StakeMaturity': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.MergeMaturity`.
final class NnsGovernanceManageNeuronProposalCommandMergeMaturity
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceMergeMaturity value;
  const NnsGovernanceManageNeuronProposalCommandMergeMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('MergeMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'MergeMaturity': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.Disburse`.
final class NnsGovernanceManageNeuronProposalCommandDisburse
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceDisburse value;
  const NnsGovernanceManageNeuronProposalCommandDisburse(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('Disburse', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Disburse': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.RefreshVotingPower`.
final class NnsGovernanceManageNeuronProposalCommandRefreshVotingPower
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceRefreshVotingPower value;
  const NnsGovernanceManageNeuronProposalCommandRefreshVotingPower(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('RefreshVotingPower', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RefreshVotingPower': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.DisburseMaturity`.
final class NnsGovernanceManageNeuronProposalCommandDisburseMaturity
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceDisburseMaturity value;
  const NnsGovernanceManageNeuronProposalCommandDisburseMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('DisburseMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DisburseMaturity': value.toJson()};
}

/// Variant arm `ManageNeuronProposalCommand.SetFollowing`.
final class NnsGovernanceManageNeuronProposalCommandSetFollowing
    extends NnsGovernanceManageNeuronProposalCommand {
  final NnsGovernanceSetFollowing value;
  const NnsGovernanceManageNeuronProposalCommandSetFollowing(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronProposalCommand.ctype;

  @override
  dynamic get candidValue => Variant('SetFollowing', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'SetFollowing': value.toJson()};
}

/// Candid variant `Command_1`.
sealed class NnsGovernanceCommand1 with CandidSerializable {
  const NnsGovernanceCommand1();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Error'), () => NnsGovernanceGovernanceError.ctype),
    LazyField(Label.named('Spawn'), () => NnsGovernanceSpawnResponse.ctype),
    LazyField(Label.named('Split'), () => NnsGovernanceSpawnResponse.ctype),
    Field(Label.named('Follow'), CType.record(const [])),
    LazyField(
      Label.named('ClaimOrRefresh'),
      () => NnsGovernanceClaimOrRefreshResponse.ctype,
    ),
    Field(Label.named('Configure'), CType.record(const [])),
    Field(Label.named('RegisterVote'), CType.record(const [])),
    LazyField(Label.named('Merge'), () => NnsGovernanceMergeResponse.ctype),
    LazyField(
      Label.named('DisburseToNeuron'),
      () => NnsGovernanceSpawnResponse.ctype,
    ),
    LazyField(
      Label.named('MakeProposal'),
      () => NnsGovernanceMakeProposalResponse.ctype,
    ),
    LazyField(
      Label.named('StakeMaturity'),
      () => NnsGovernanceStakeMaturityResponse.ctype,
    ),
    LazyField(
      Label.named('MergeMaturity'),
      () => NnsGovernanceMergeMaturityResponse.ctype,
    ),
    LazyField(
      Label.named('Disburse'),
      () => NnsGovernanceDisburseResponse.ctype,
    ),
    LazyField(
      Label.named('RefreshVotingPower'),
      () => NnsGovernanceRefreshVotingPowerResponse.ctype,
    ),
    LazyField(
      Label.named('DisburseMaturity'),
      () => NnsGovernanceDisburseMaturityResponse.ctype,
    ),
    LazyField(
      Label.named('SetFollowing'),
      () => NnsGovernanceSetFollowingResponse.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceCommand1.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Error')) {
      return NnsGovernanceCommand1Error(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Error',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Spawn')) {
      return NnsGovernanceCommand1Spawn(
        json.valueTo<NnsGovernanceSpawnResponse, Map>(
          key: 'Spawn',
          parse:
              (e) => NnsGovernanceSpawnResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Split')) {
      return NnsGovernanceCommand1Split(
        json.valueTo<NnsGovernanceSpawnResponse, Map>(
          key: 'Split',
          parse:
              (e) => NnsGovernanceSpawnResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Follow')) {
      return NnsGovernanceCommand1Follow.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Follow']),
      );
    }
    if (json.containsKey('ClaimOrRefresh')) {
      return NnsGovernanceCommand1ClaimOrRefresh(
        json.valueTo<NnsGovernanceClaimOrRefreshResponse, Map>(
          key: 'ClaimOrRefresh',
          parse:
              (e) => NnsGovernanceClaimOrRefreshResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Configure')) {
      return NnsGovernanceCommand1Configure.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Configure']),
      );
    }
    if (json.containsKey('RegisterVote')) {
      return NnsGovernanceCommand1RegisterVote.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['RegisterVote']),
      );
    }
    if (json.containsKey('Merge')) {
      return NnsGovernanceCommand1Merge(
        json.valueTo<NnsGovernanceMergeResponse, Map>(
          key: 'Merge',
          parse:
              (e) => NnsGovernanceMergeResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DisburseToNeuron')) {
      return NnsGovernanceCommand1DisburseToNeuron(
        json.valueTo<NnsGovernanceSpawnResponse, Map>(
          key: 'DisburseToNeuron',
          parse:
              (e) => NnsGovernanceSpawnResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('MakeProposal')) {
      return NnsGovernanceCommand1MakeProposal(
        json.valueTo<NnsGovernanceMakeProposalResponse, Map>(
          key: 'MakeProposal',
          parse:
              (e) => NnsGovernanceMakeProposalResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('StakeMaturity')) {
      return NnsGovernanceCommand1StakeMaturity(
        json.valueTo<NnsGovernanceStakeMaturityResponse, Map>(
          key: 'StakeMaturity',
          parse:
              (e) => NnsGovernanceStakeMaturityResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('MergeMaturity')) {
      return NnsGovernanceCommand1MergeMaturity(
        json.valueTo<NnsGovernanceMergeMaturityResponse, Map>(
          key: 'MergeMaturity',
          parse:
              (e) => NnsGovernanceMergeMaturityResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Disburse')) {
      return NnsGovernanceCommand1Disburse(
        json.valueTo<NnsGovernanceDisburseResponse, Map>(
          key: 'Disburse',
          parse:
              (e) => NnsGovernanceDisburseResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('RefreshVotingPower')) {
      return NnsGovernanceCommand1RefreshVotingPower(
        json.valueTo<NnsGovernanceRefreshVotingPowerResponse, Map>(
          key: 'RefreshVotingPower',
          parse:
              (e) => NnsGovernanceRefreshVotingPowerResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DisburseMaturity')) {
      return NnsGovernanceCommand1DisburseMaturity(
        json.valueTo<NnsGovernanceDisburseMaturityResponse, Map>(
          key: 'DisburseMaturity',
          parse:
              (e) => NnsGovernanceDisburseMaturityResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('SetFollowing')) {
      return NnsGovernanceCommand1SetFollowing(
        json.valueTo<NnsGovernanceSetFollowingResponse, Map>(
          key: 'SetFollowing',
          parse:
              (e) => NnsGovernanceSetFollowingResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceCommand1.fromCandid',
      reason: 'Unknown NnsGovernanceCommand1 arm',
    );
  }

  factory NnsGovernanceCommand1.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCommand1.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Command_1.Error`.
final class NnsGovernanceCommand1Error extends NnsGovernanceCommand1 {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceCommand1Error(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('Error', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Error': value.toJson()};
}

/// Variant arm `Command_1.Spawn`.
final class NnsGovernanceCommand1Spawn extends NnsGovernanceCommand1 {
  final NnsGovernanceSpawnResponse value;
  const NnsGovernanceCommand1Spawn(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('Spawn', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Spawn': value.toJson()};
}

/// Variant arm `Command_1.Split`.
final class NnsGovernanceCommand1Split extends NnsGovernanceCommand1 {
  final NnsGovernanceSpawnResponse value;
  const NnsGovernanceCommand1Split(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('Split', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Split': value.toJson()};
}

/// Variant arm `Command_1.Follow`.
final class NnsGovernanceCommand1Follow extends NnsGovernanceCommand1 {
  const NnsGovernanceCommand1Follow();

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('Follow', {});

  @override
  Map<String, dynamic> toJson() => {'Follow': {}};

  factory NnsGovernanceCommand1Follow.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceCommand1Follow();
  }
}

/// Variant arm `Command_1.ClaimOrRefresh`.
final class NnsGovernanceCommand1ClaimOrRefresh extends NnsGovernanceCommand1 {
  final NnsGovernanceClaimOrRefreshResponse value;
  const NnsGovernanceCommand1ClaimOrRefresh(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('ClaimOrRefresh', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ClaimOrRefresh': value.toJson()};
}

/// Variant arm `Command_1.Configure`.
final class NnsGovernanceCommand1Configure extends NnsGovernanceCommand1 {
  const NnsGovernanceCommand1Configure();

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('Configure', {});

  @override
  Map<String, dynamic> toJson() => {'Configure': {}};

  factory NnsGovernanceCommand1Configure.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceCommand1Configure();
  }
}

/// Variant arm `Command_1.RegisterVote`.
final class NnsGovernanceCommand1RegisterVote extends NnsGovernanceCommand1 {
  const NnsGovernanceCommand1RegisterVote();

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('RegisterVote', {});

  @override
  Map<String, dynamic> toJson() => {'RegisterVote': {}};

  factory NnsGovernanceCommand1RegisterVote.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceCommand1RegisterVote();
  }
}

/// Variant arm `Command_1.Merge`.
final class NnsGovernanceCommand1Merge extends NnsGovernanceCommand1 {
  final NnsGovernanceMergeResponse value;
  const NnsGovernanceCommand1Merge(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('Merge', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Merge': value.toJson()};
}

/// Variant arm `Command_1.DisburseToNeuron`.
final class NnsGovernanceCommand1DisburseToNeuron
    extends NnsGovernanceCommand1 {
  final NnsGovernanceSpawnResponse value;
  const NnsGovernanceCommand1DisburseToNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('DisburseToNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DisburseToNeuron': value.toJson()};
}

/// Variant arm `Command_1.MakeProposal`.
final class NnsGovernanceCommand1MakeProposal extends NnsGovernanceCommand1 {
  final NnsGovernanceMakeProposalResponse value;
  const NnsGovernanceCommand1MakeProposal(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('MakeProposal', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'MakeProposal': value.toJson()};
}

/// Variant arm `Command_1.StakeMaturity`.
final class NnsGovernanceCommand1StakeMaturity extends NnsGovernanceCommand1 {
  final NnsGovernanceStakeMaturityResponse value;
  const NnsGovernanceCommand1StakeMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('StakeMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'StakeMaturity': value.toJson()};
}

/// Variant arm `Command_1.MergeMaturity`.
final class NnsGovernanceCommand1MergeMaturity extends NnsGovernanceCommand1 {
  final NnsGovernanceMergeMaturityResponse value;
  const NnsGovernanceCommand1MergeMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('MergeMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'MergeMaturity': value.toJson()};
}

/// Variant arm `Command_1.Disburse`.
final class NnsGovernanceCommand1Disburse extends NnsGovernanceCommand1 {
  final NnsGovernanceDisburseResponse value;
  const NnsGovernanceCommand1Disburse(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('Disburse', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Disburse': value.toJson()};
}

/// Variant arm `Command_1.RefreshVotingPower`.
final class NnsGovernanceCommand1RefreshVotingPower
    extends NnsGovernanceCommand1 {
  final NnsGovernanceRefreshVotingPowerResponse value;
  const NnsGovernanceCommand1RefreshVotingPower(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('RefreshVotingPower', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RefreshVotingPower': value.toJson()};
}

/// Variant arm `Command_1.DisburseMaturity`.
final class NnsGovernanceCommand1DisburseMaturity
    extends NnsGovernanceCommand1 {
  final NnsGovernanceDisburseMaturityResponse value;
  const NnsGovernanceCommand1DisburseMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('DisburseMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DisburseMaturity': value.toJson()};
}

/// Variant arm `Command_1.SetFollowing`.
final class NnsGovernanceCommand1SetFollowing extends NnsGovernanceCommand1 {
  final NnsGovernanceSetFollowingResponse value;
  const NnsGovernanceCommand1SetFollowing(this.value);

  @override
  CType get candidType => NnsGovernanceCommand1.ctype;

  @override
  dynamic get candidValue => Variant('SetFollowing', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'SetFollowing': value.toJson()};
}

/// Candid variant `Command_2`.
sealed class NnsGovernanceCommand2 with CandidSerializable {
  const NnsGovernanceCommand2();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Spawn'), () => NnsGovernanceNeuronId.ctype),
    LazyField(Label.named('Split'), () => NnsGovernanceSplit.ctype),
    LazyField(Label.named('Configure'), () => NnsGovernanceConfigure.ctype),
    LazyField(Label.named('Merge'), () => NnsGovernanceMerge.ctype),
    LazyField(
      Label.named('DisburseToNeuron'),
      () => NnsGovernanceDisburseToNeuron.ctype,
    ),
    Field(Label.named('SyncCommand'), CType.record(const [])),
    LazyField(
      Label.named('ClaimOrRefreshNeuron'),
      () => NnsGovernanceClaimOrRefresh.ctype,
    ),
    LazyField(
      Label.named('MergeMaturity'),
      () => NnsGovernanceMergeMaturity.ctype,
    ),
    LazyField(Label.named('Disburse'), () => NnsGovernanceDisburse.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceCommand2.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Spawn')) {
      return NnsGovernanceCommand2Spawn(
        json.valueTo<NnsGovernanceNeuronId, Map>(
          key: 'Spawn',
          parse:
              (e) => NnsGovernanceNeuronId.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Split')) {
      return NnsGovernanceCommand2Split(
        json.valueTo<NnsGovernanceSplit, Map>(
          key: 'Split',
          parse:
              (e) => NnsGovernanceSplit.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Configure')) {
      return NnsGovernanceCommand2Configure(
        json.valueTo<NnsGovernanceConfigure, Map>(
          key: 'Configure',
          parse:
              (e) => NnsGovernanceConfigure.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Merge')) {
      return NnsGovernanceCommand2Merge(
        json.valueTo<NnsGovernanceMerge, Map>(
          key: 'Merge',
          parse:
              (e) => NnsGovernanceMerge.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DisburseToNeuron')) {
      return NnsGovernanceCommand2DisburseToNeuron(
        json.valueTo<NnsGovernanceDisburseToNeuron, Map>(
          key: 'DisburseToNeuron',
          parse:
              (e) => NnsGovernanceDisburseToNeuron.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('SyncCommand')) {
      return NnsGovernanceCommand2SyncCommand.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['SyncCommand']),
      );
    }
    if (json.containsKey('ClaimOrRefreshNeuron')) {
      return NnsGovernanceCommand2ClaimOrRefreshNeuron(
        json.valueTo<NnsGovernanceClaimOrRefresh, Map>(
          key: 'ClaimOrRefreshNeuron',
          parse:
              (e) => NnsGovernanceClaimOrRefresh.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('MergeMaturity')) {
      return NnsGovernanceCommand2MergeMaturity(
        json.valueTo<NnsGovernanceMergeMaturity, Map>(
          key: 'MergeMaturity',
          parse:
              (e) => NnsGovernanceMergeMaturity.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Disburse')) {
      return NnsGovernanceCommand2Disburse(
        json.valueTo<NnsGovernanceDisburse, Map>(
          key: 'Disburse',
          parse:
              (e) => NnsGovernanceDisburse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceCommand2.fromCandid',
      reason: 'Unknown NnsGovernanceCommand2 arm',
    );
  }

  factory NnsGovernanceCommand2.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCommand2.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Command_2.Spawn`.
final class NnsGovernanceCommand2Spawn extends NnsGovernanceCommand2 {
  final NnsGovernanceNeuronId value;
  const NnsGovernanceCommand2Spawn(this.value);

  @override
  CType get candidType => NnsGovernanceCommand2.ctype;

  @override
  dynamic get candidValue => Variant('Spawn', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Spawn': value.toJson()};
}

/// Variant arm `Command_2.Split`.
final class NnsGovernanceCommand2Split extends NnsGovernanceCommand2 {
  final NnsGovernanceSplit value;
  const NnsGovernanceCommand2Split(this.value);

  @override
  CType get candidType => NnsGovernanceCommand2.ctype;

  @override
  dynamic get candidValue => Variant('Split', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Split': value.toJson()};
}

/// Variant arm `Command_2.Configure`.
final class NnsGovernanceCommand2Configure extends NnsGovernanceCommand2 {
  final NnsGovernanceConfigure value;
  const NnsGovernanceCommand2Configure(this.value);

  @override
  CType get candidType => NnsGovernanceCommand2.ctype;

  @override
  dynamic get candidValue => Variant('Configure', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Configure': value.toJson()};
}

/// Variant arm `Command_2.Merge`.
final class NnsGovernanceCommand2Merge extends NnsGovernanceCommand2 {
  final NnsGovernanceMerge value;
  const NnsGovernanceCommand2Merge(this.value);

  @override
  CType get candidType => NnsGovernanceCommand2.ctype;

  @override
  dynamic get candidValue => Variant('Merge', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Merge': value.toJson()};
}

/// Variant arm `Command_2.DisburseToNeuron`.
final class NnsGovernanceCommand2DisburseToNeuron
    extends NnsGovernanceCommand2 {
  final NnsGovernanceDisburseToNeuron value;
  const NnsGovernanceCommand2DisburseToNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceCommand2.ctype;

  @override
  dynamic get candidValue => Variant('DisburseToNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DisburseToNeuron': value.toJson()};
}

/// Variant arm `Command_2.SyncCommand`.
final class NnsGovernanceCommand2SyncCommand extends NnsGovernanceCommand2 {
  const NnsGovernanceCommand2SyncCommand();

  @override
  CType get candidType => NnsGovernanceCommand2.ctype;

  @override
  dynamic get candidValue => Variant('SyncCommand', {});

  @override
  Map<String, dynamic> toJson() => {'SyncCommand': {}};

  factory NnsGovernanceCommand2SyncCommand.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceCommand2SyncCommand();
  }
}

/// Variant arm `Command_2.ClaimOrRefreshNeuron`.
final class NnsGovernanceCommand2ClaimOrRefreshNeuron
    extends NnsGovernanceCommand2 {
  final NnsGovernanceClaimOrRefresh value;
  const NnsGovernanceCommand2ClaimOrRefreshNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceCommand2.ctype;

  @override
  dynamic get candidValue => Variant('ClaimOrRefreshNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ClaimOrRefreshNeuron': value.toJson()};
}

/// Variant arm `Command_2.MergeMaturity`.
final class NnsGovernanceCommand2MergeMaturity extends NnsGovernanceCommand2 {
  final NnsGovernanceMergeMaturity value;
  const NnsGovernanceCommand2MergeMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceCommand2.ctype;

  @override
  dynamic get candidValue => Variant('MergeMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'MergeMaturity': value.toJson()};
}

/// Variant arm `Command_2.Disburse`.
final class NnsGovernanceCommand2Disburse extends NnsGovernanceCommand2 {
  final NnsGovernanceDisburse value;
  const NnsGovernanceCommand2Disburse(this.value);

  @override
  CType get candidType => NnsGovernanceCommand2.ctype;

  @override
  dynamic get candidValue => Variant('Disburse', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Disburse': value.toJson()};
}

/// Candid record `Committed`.
final class NnsGovernanceCommitted with CandidSerializable {
  final BigInt? totalDirectContributionIcpE8s;
  final BigInt? totalNeuronsFundContributionIcpE8s;
  final IcpPrincipalAddress? snsGovernanceCanisterId;

  const NnsGovernanceCommitted({
    this.totalDirectContributionIcpE8s,
    this.totalNeuronsFundContributionIcpE8s,
    this.snsGovernanceCanisterId,
  });

  static CType get ctype => CType.record([
    Field(
      Label.named('total_direct_contribution_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(
      Label.named('total_neurons_fund_contribution_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(
      Label.named('sns_governance_canister_id'),
      CType.opt(CType.principal),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'total_direct_contribution_icp_e8s': totalDirectContributionIcpE8s,
    'total_neurons_fund_contribution_icp_e8s':
        totalNeuronsFundContributionIcpE8s,
    'sns_governance_canister_id': snsGovernanceCanisterId,
  };

  Map<String, dynamic> toJson() => {
    'total_direct_contribution_icp_e8s': totalDirectContributionIcpE8s,
    'total_neurons_fund_contribution_icp_e8s':
        totalNeuronsFundContributionIcpE8s,
    'sns_governance_canister_id': snsGovernanceCanisterId?.address,
  };

  factory NnsGovernanceCommitted.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceCommitted(
      totalDirectContributionIcpE8s: json.valueAsBigInt<BigInt?>(
        'total_direct_contribution_icp_e8s',
      ),
      totalNeuronsFundContributionIcpE8s: json.valueAsBigInt<BigInt?>(
        'total_neurons_fund_contribution_icp_e8s',
      ),
      snsGovernanceCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'sns_governance_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsGovernanceCommitted.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCommitted.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Committed_1`.
final class NnsGovernanceCommitted1 with CandidSerializable {
  final BigInt? totalDirectParticipationIcpE8s;
  final BigInt? totalNeuronsFundParticipationIcpE8s;
  final IcpPrincipalAddress? snsGovernanceCanisterId;

  const NnsGovernanceCommitted1({
    this.totalDirectParticipationIcpE8s,
    this.totalNeuronsFundParticipationIcpE8s,
    this.snsGovernanceCanisterId,
  });

  static CType get ctype => CType.record([
    Field(
      Label.named('total_direct_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(
      Label.named('total_neurons_fund_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(
      Label.named('sns_governance_canister_id'),
      CType.opt(CType.principal),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'total_direct_participation_icp_e8s': totalDirectParticipationIcpE8s,
    'total_neurons_fund_participation_icp_e8s':
        totalNeuronsFundParticipationIcpE8s,
    'sns_governance_canister_id': snsGovernanceCanisterId,
  };

  Map<String, dynamic> toJson() => {
    'total_direct_participation_icp_e8s': totalDirectParticipationIcpE8s,
    'total_neurons_fund_participation_icp_e8s':
        totalNeuronsFundParticipationIcpE8s,
    'sns_governance_canister_id': snsGovernanceCanisterId?.address,
  };

  factory NnsGovernanceCommitted1.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceCommitted1(
      totalDirectParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'total_direct_participation_icp_e8s',
      ),
      totalNeuronsFundParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'total_neurons_fund_participation_icp_e8s',
      ),
      snsGovernanceCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'sns_governance_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsGovernanceCommitted1.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCommitted1.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Configure`.
final class NnsGovernanceConfigure with CandidSerializable {
  final NnsGovernanceOperation? operation;

  const NnsGovernanceConfigure({this.operation});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('operation'),
      () => CType.opt(NnsGovernanceOperation.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'operation': operation?.candidValue};

  Map<String, dynamic> toJson() => {'operation': operation?.toJson()};

  factory NnsGovernanceConfigure.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceConfigure(
      operation: json.valueTo<NnsGovernanceOperation?, Map>(
        key: 'operation',
        parse:
            (e) => NnsGovernanceOperation.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceConfigure.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceConfigure.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Controllers`.
final class NnsGovernanceControllers with CandidSerializable {
  final List<IcpPrincipalAddress> controllers;

  const NnsGovernanceControllers({required this.controllers});

  static CType get ctype => CType.record([
    Field(Label.named('controllers'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'controllers': controllers};

  Map<String, dynamic> toJson() => {
    'controllers': controllers.map((el) => el.address).toList(),
  };

  factory NnsGovernanceControllers.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceControllers(
      controllers: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'controllers',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceControllers.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceControllers.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Countries`.
final class NnsGovernanceCountries with CandidSerializable {
  final List<String> isoCodes;

  const NnsGovernanceCountries({required this.isoCodes});

  static CType get ctype =>
      CType.record([Field(Label.named('iso_codes'), CType.vec(CType.text))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'iso_codes': isoCodes};

  Map<String, dynamic> toJson() => {'iso_codes': isoCodes};

  factory NnsGovernanceCountries.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceCountries(
      isoCodes: json.valueTo<List<String>, List>(
        key: 'iso_codes',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceCountries.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCountries.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CreateCanisterAndInstallCode`.
final class NnsGovernanceCreateCanisterAndInstallCode with CandidSerializable {
  final IcpPrincipalAddress? hostSubnetId;
  final NnsGovernanceCanisterSettings? canisterSettings;
  final List<int>? wasmModuleHash;
  final List<int>? installArgHash;

  const NnsGovernanceCreateCanisterAndInstallCode({
    this.hostSubnetId,
    this.canisterSettings,
    this.wasmModuleHash,
    this.installArgHash,
  });

  static CType get ctype => CType.record([
    Field(Label.named('host_subnet_id'), CType.opt(CType.principal)),
    LazyField(
      Label.named('canister_settings'),
      () => CType.opt(NnsGovernanceCanisterSettings.ctype),
    ),
    Field(Label.named('wasm_module_hash'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('install_arg_hash'), CType.opt(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'host_subnet_id': hostSubnetId,
    'canister_settings': canisterSettings?.candidValue,
    'wasm_module_hash': wasmModuleHash,
    'install_arg_hash': installArgHash,
  };

  Map<String, dynamic> toJson() => {
    'host_subnet_id': hostSubnetId?.address,
    'canister_settings': canisterSettings?.toJson(),
    'wasm_module_hash': wasmModuleHash,
    'install_arg_hash': installArgHash,
  };

  factory NnsGovernanceCreateCanisterAndInstallCode.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceCreateCanisterAndInstallCode(
      hostSubnetId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'host_subnet_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      canisterSettings: json.valueTo<NnsGovernanceCanisterSettings?, Map>(
        key: 'canister_settings',
        parse:
            (e) => NnsGovernanceCanisterSettings.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      wasmModuleHash: json.valueAsBytes<List<int>?>(
        'wasm_module_hash',
        encoding: StringEncoding.base64,
      ),
      installArgHash: json.valueAsBytes<List<int>?>(
        'install_arg_hash',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsGovernanceCreateCanisterAndInstallCode.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCreateCanisterAndInstallCode.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CreateCanisterAndInstallCodeRequest`.
final class NnsGovernanceCreateCanisterAndInstallCodeRequest
    with CandidSerializable {
  final IcpPrincipalAddress? hostSubnetId;
  final NnsGovernanceCanisterSettings? canisterSettings;
  final NnsGovernanceWasmModule? wasmModule;
  final List<int>? installArg;

  const NnsGovernanceCreateCanisterAndInstallCodeRequest({
    this.hostSubnetId,
    this.canisterSettings,
    this.wasmModule,
    this.installArg,
  });

  static CType get ctype => CType.record([
    Field(Label.named('host_subnet_id'), CType.opt(CType.principal)),
    LazyField(
      Label.named('canister_settings'),
      () => CType.opt(NnsGovernanceCanisterSettings.ctype),
    ),
    LazyField(
      Label.named('wasm_module'),
      () => CType.opt(NnsGovernanceWasmModule.ctype),
    ),
    Field(Label.named('install_arg'), CType.opt(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'host_subnet_id': hostSubnetId,
    'canister_settings': canisterSettings?.candidValue,
    'wasm_module': wasmModule?.candidValue,
    'install_arg': installArg,
  };

  Map<String, dynamic> toJson() => {
    'host_subnet_id': hostSubnetId?.address,
    'canister_settings': canisterSettings?.toJson(),
    'wasm_module': wasmModule?.toJson(),
    'install_arg': installArg,
  };

  factory NnsGovernanceCreateCanisterAndInstallCodeRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceCreateCanisterAndInstallCodeRequest(
      hostSubnetId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'host_subnet_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      canisterSettings: json.valueTo<NnsGovernanceCanisterSettings?, Map>(
        key: 'canister_settings',
        parse:
            (e) => NnsGovernanceCanisterSettings.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      wasmModule: json.valueTo<NnsGovernanceWasmModule?, Map>(
        key: 'wasm_module',
        parse:
            (e) => NnsGovernanceWasmModule.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      installArg: json.valueAsBytes<List<int>?>(
        'install_arg',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsGovernanceCreateCanisterAndInstallCodeRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCreateCanisterAndInstallCodeRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CreateCanisterAndInstallCodeOk`.
final class NnsGovernanceCreateCanisterAndInstallCodeOk
    with CandidSerializable {
  final IcpPrincipalAddress? canisterId;

  const NnsGovernanceCreateCanisterAndInstallCodeOk({this.canisterId});

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId?.address};

  factory NnsGovernanceCreateCanisterAndInstallCodeOk.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceCreateCanisterAndInstallCodeOk(
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsGovernanceCreateCanisterAndInstallCodeOk.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCreateCanisterAndInstallCodeOk.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TakeCanisterSnapshotOk`.
final class NnsGovernanceTakeCanisterSnapshotOk with CandidSerializable {
  final List<int> snapshotId;

  const NnsGovernanceTakeCanisterSnapshotOk({required this.snapshotId});

  static CType get ctype =>
      CType.record([Field(Label.named('snapshot_id'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'snapshot_id': snapshotId};

  Map<String, dynamic> toJson() => {'snapshot_id': snapshotId};

  factory NnsGovernanceTakeCanisterSnapshotOk.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceTakeCanisterSnapshotOk(
      snapshotId: json.valueAsBytes<List<int>>(
        'snapshot_id',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsGovernanceTakeCanisterSnapshotOk.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceTakeCanisterSnapshotOk.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `SuccessfulProposalExecutionValue`.
sealed class NnsGovernanceSuccessfulProposalExecutionValue
    with CandidSerializable {
  const NnsGovernanceSuccessfulProposalExecutionValue();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('CreateCanisterAndInstallCode'),
      () => NnsGovernanceCreateCanisterAndInstallCodeOk.ctype,
    ),
    LazyField(
      Label.named('TakeCanisterSnapshot'),
      () => NnsGovernanceTakeCanisterSnapshotOk.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceSuccessfulProposalExecutionValue.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('CreateCanisterAndInstallCode')) {
      return NnsGovernanceSuccessfulProposalExecutionValueCreateCanisterAndInstallCode(
        json.valueTo<NnsGovernanceCreateCanisterAndInstallCodeOk, Map>(
          key: 'CreateCanisterAndInstallCode',
          parse:
              (e) => NnsGovernanceCreateCanisterAndInstallCodeOk.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('TakeCanisterSnapshot')) {
      return NnsGovernanceSuccessfulProposalExecutionValueTakeCanisterSnapshot(
        json.valueTo<NnsGovernanceTakeCanisterSnapshotOk, Map>(
          key: 'TakeCanisterSnapshot',
          parse:
              (e) => NnsGovernanceTakeCanisterSnapshotOk.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceSuccessfulProposalExecutionValue.fromCandid',
      reason: 'Unknown NnsGovernanceSuccessfulProposalExecutionValue arm',
    );
  }

  factory NnsGovernanceSuccessfulProposalExecutionValue.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSuccessfulProposalExecutionValue.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `SuccessfulProposalExecutionValue.CreateCanisterAndInstallCode`.
final class NnsGovernanceSuccessfulProposalExecutionValueCreateCanisterAndInstallCode
    extends NnsGovernanceSuccessfulProposalExecutionValue {
  final NnsGovernanceCreateCanisterAndInstallCodeOk value;
  const NnsGovernanceSuccessfulProposalExecutionValueCreateCanisterAndInstallCode(
    this.value,
  );

  @override
  CType get candidType => NnsGovernanceSuccessfulProposalExecutionValue.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreateCanisterAndInstallCode', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'CreateCanisterAndInstallCode': value.toJson(),
  };
}

/// Variant arm `SuccessfulProposalExecutionValue.TakeCanisterSnapshot`.
final class NnsGovernanceSuccessfulProposalExecutionValueTakeCanisterSnapshot
    extends NnsGovernanceSuccessfulProposalExecutionValue {
  final NnsGovernanceTakeCanisterSnapshotOk value;
  const NnsGovernanceSuccessfulProposalExecutionValueTakeCanisterSnapshot(
    this.value,
  );

  @override
  CType get candidType => NnsGovernanceSuccessfulProposalExecutionValue.ctype;

  @override
  dynamic get candidValue => Variant('TakeCanisterSnapshot', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'TakeCanisterSnapshot': value.toJson()};
}

/// Candid record `CreateServiceNervousSystem`.
final class NnsGovernanceCreateServiceNervousSystem with CandidSerializable {
  final String? url;
  final NnsGovernanceGovernanceParameters? governanceParameters;
  final List<IcpPrincipalAddress> fallbackControllerPrincipalIds;
  final NnsGovernanceImage? logo;
  final String? name;
  final NnsGovernanceLedgerParameters? ledgerParameters;
  final String? description;
  final List<NnsGovernanceCanister> dappCanisters;
  final NnsGovernanceSwapParameters? swapParameters;
  final NnsGovernanceInitialTokenDistribution? initialTokenDistribution;

  const NnsGovernanceCreateServiceNervousSystem({
    this.url,
    this.governanceParameters,
    required this.fallbackControllerPrincipalIds,
    this.logo,
    this.name,
    this.ledgerParameters,
    this.description,
    required this.dappCanisters,
    this.swapParameters,
    this.initialTokenDistribution,
  });

  static CType get ctype => CType.record([
    Field(Label.named('url'), CType.opt(CType.text)),
    LazyField(
      Label.named('governance_parameters'),
      () => CType.opt(NnsGovernanceGovernanceParameters.ctype),
    ),
    Field(
      Label.named('fallback_controller_principal_ids'),
      CType.vec(CType.principal),
    ),
    LazyField(Label.named('logo'), () => CType.opt(NnsGovernanceImage.ctype)),
    Field(Label.named('name'), CType.opt(CType.text)),
    LazyField(
      Label.named('ledger_parameters'),
      () => CType.opt(NnsGovernanceLedgerParameters.ctype),
    ),
    Field(Label.named('description'), CType.opt(CType.text)),
    LazyField(
      Label.named('dapp_canisters'),
      () => CType.vec(NnsGovernanceCanister.ctype),
    ),
    LazyField(
      Label.named('swap_parameters'),
      () => CType.opt(NnsGovernanceSwapParameters.ctype),
    ),
    LazyField(
      Label.named('initial_token_distribution'),
      () => CType.opt(NnsGovernanceInitialTokenDistribution.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'url': url,
    'governance_parameters': governanceParameters?.candidValue,
    'fallback_controller_principal_ids': fallbackControllerPrincipalIds,
    'logo': logo?.candidValue,
    'name': name,
    'ledger_parameters': ledgerParameters?.candidValue,
    'description': description,
    'dapp_canisters': dappCanisters.map((el) => el.candidValue).toList(),
    'swap_parameters': swapParameters?.candidValue,
    'initial_token_distribution': initialTokenDistribution?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'url': url,
    'governance_parameters': governanceParameters?.toJson(),
    'fallback_controller_principal_ids':
        fallbackControllerPrincipalIds.map((el) => el.address).toList(),
    'logo': logo?.toJson(),
    'name': name,
    'ledger_parameters': ledgerParameters?.toJson(),
    'description': description,
    'dapp_canisters': dappCanisters.map((el) => el.toJson()).toList(),
    'swap_parameters': swapParameters?.toJson(),
    'initial_token_distribution': initialTokenDistribution?.toJson(),
  };

  factory NnsGovernanceCreateServiceNervousSystem.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceCreateServiceNervousSystem(
      url: json.valueAsString<String?>('url'),
      governanceParameters: json
          .valueTo<NnsGovernanceGovernanceParameters?, Map>(
            key: 'governance_parameters',
            parse:
                (e) => NnsGovernanceGovernanceParameters.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      fallbackControllerPrincipalIds: json
          .valueTo<List<IcpPrincipalAddress>, List>(
            key: 'fallback_controller_principal_ids',
            parse:
                (e) =>
                    e
                        .map<IcpPrincipalAddress>(
                          (x) => GeneratorParserUtils.principalFromCandid(x),
                        )
                        .toList(),
          ),
      logo: json.valueTo<NnsGovernanceImage?, Map>(
        key: 'logo',
        parse:
            (e) => NnsGovernanceImage.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      name: json.valueAsString<String?>('name'),
      ledgerParameters: json.valueTo<NnsGovernanceLedgerParameters?, Map>(
        key: 'ledger_parameters',
        parse:
            (e) => NnsGovernanceLedgerParameters.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      description: json.valueAsString<String?>('description'),
      dappCanisters: json.valueTo<List<NnsGovernanceCanister>, List>(
        key: 'dapp_canisters',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceCanister>(
                      (x) => NnsGovernanceCanister.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      swapParameters: json.valueTo<NnsGovernanceSwapParameters?, Map>(
        key: 'swap_parameters',
        parse:
            (e) => NnsGovernanceSwapParameters.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      initialTokenDistribution: json
          .valueTo<NnsGovernanceInitialTokenDistribution?, Map>(
            key: 'initial_token_distribution',
            parse:
                (e) => NnsGovernanceInitialTokenDistribution.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceCreateServiceNervousSystem.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCreateServiceNervousSystem.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DateRangeFilter`.
final class NnsGovernanceDateRangeFilter with CandidSerializable {
  final BigInt? startTimestampSeconds;
  final BigInt? endTimestampSeconds;

  const NnsGovernanceDateRangeFilter({
    this.startTimestampSeconds,
    this.endTimestampSeconds,
  });

  static CType get ctype => CType.record([
    Field(Label.named('start_timestamp_seconds'), CType.opt(CType.nat64)),
    Field(Label.named('end_timestamp_seconds'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'start_timestamp_seconds': startTimestampSeconds,
    'end_timestamp_seconds': endTimestampSeconds,
  };

  Map<String, dynamic> toJson() => {
    'start_timestamp_seconds': startTimestampSeconds,
    'end_timestamp_seconds': endTimestampSeconds,
  };

  factory NnsGovernanceDateRangeFilter.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceDateRangeFilter(
      startTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'start_timestamp_seconds',
      ),
      endTimestampSeconds: json.valueAsBigInt<BigInt?>('end_timestamp_seconds'),
    );
  }

  factory NnsGovernanceDateRangeFilter.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDateRangeFilter.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Decimal`.
final class NnsGovernanceDecimal with CandidSerializable {
  final String? humanReadable;

  const NnsGovernanceDecimal({this.humanReadable});

  static CType get ctype => CType.record([
    Field(Label.named('human_readable'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'human_readable': humanReadable};

  Map<String, dynamic> toJson() => {'human_readable': humanReadable};

  factory NnsGovernanceDecimal.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceDecimal(
      humanReadable: json.valueAsString<String?>('human_readable'),
    );
  }

  factory NnsGovernanceDecimal.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDecimal.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DerivedProposalInformation`.
final class NnsGovernanceDerivedProposalInformation with CandidSerializable {
  final NnsGovernanceSwapBackgroundInformation? swapBackgroundInformation;

  const NnsGovernanceDerivedProposalInformation({
    this.swapBackgroundInformation,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('swap_background_information'),
      () => CType.opt(NnsGovernanceSwapBackgroundInformation.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'swap_background_information': swapBackgroundInformation?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'swap_background_information': swapBackgroundInformation?.toJson(),
  };

  factory NnsGovernanceDerivedProposalInformation.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceDerivedProposalInformation(
      swapBackgroundInformation: json
          .valueTo<NnsGovernanceSwapBackgroundInformation?, Map>(
            key: 'swap_background_information',
            parse:
                (e) => NnsGovernanceSwapBackgroundInformation.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceDerivedProposalInformation.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDerivedProposalInformation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DeveloperDistribution`.
final class NnsGovernanceDeveloperDistribution with CandidSerializable {
  final List<NnsGovernanceNeuronDistribution> developerNeurons;

  const NnsGovernanceDeveloperDistribution({required this.developerNeurons});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('developer_neurons'),
      () => CType.vec(NnsGovernanceNeuronDistribution.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'developer_neurons': developerNeurons.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'developer_neurons': developerNeurons.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceDeveloperDistribution.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceDeveloperDistribution(
      developerNeurons: json
          .valueTo<List<NnsGovernanceNeuronDistribution>, List>(
            key: 'developer_neurons',
            parse:
                (e) =>
                    e
                        .map<NnsGovernanceNeuronDistribution>(
                          (x) => NnsGovernanceNeuronDistribution.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsGovernanceDeveloperDistribution.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDeveloperDistribution.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Disburse`.
final class NnsGovernanceDisburse with CandidSerializable {
  final NnsGovernanceAccountIdentifier? toAccount;
  final NnsGovernanceAmount? amount;

  const NnsGovernanceDisburse({this.toAccount, this.amount});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('to_account'),
      () => CType.opt(NnsGovernanceAccountIdentifier.ctype),
    ),
    LazyField(
      Label.named('amount'),
      () => CType.opt(NnsGovernanceAmount.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'to_account': toAccount?.candidValue,
    'amount': amount?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'to_account': toAccount?.toJson(),
    'amount': amount?.toJson(),
  };

  factory NnsGovernanceDisburse.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceDisburse(
      toAccount: json.valueTo<NnsGovernanceAccountIdentifier?, Map>(
        key: 'to_account',
        parse:
            (e) => NnsGovernanceAccountIdentifier.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      amount: json.valueTo<NnsGovernanceAmount?, Map>(
        key: 'amount',
        parse:
            (e) => NnsGovernanceAmount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceDisburse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDisburse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DisburseResponse`.
final class NnsGovernanceDisburseResponse with CandidSerializable {
  final BigInt transferBlockHeight;

  const NnsGovernanceDisburseResponse({required this.transferBlockHeight});

  static CType get ctype =>
      CType.record([Field(Label.named('transfer_block_height'), CType.nat64)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'transfer_block_height': transferBlockHeight};

  Map<String, dynamic> toJson() => {
    'transfer_block_height': transferBlockHeight,
  };

  factory NnsGovernanceDisburseResponse.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceDisburseResponse(
      transferBlockHeight: json.valueAsBigInt<BigInt>('transfer_block_height'),
    );
  }

  factory NnsGovernanceDisburseResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDisburseResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DisburseToNeuron`.
final class NnsGovernanceDisburseToNeuron with CandidSerializable {
  final BigInt dissolveDelaySeconds;
  final bool kycVerified;
  final BigInt amountE8s;
  final IcpPrincipalAddress? newController;
  final BigInt nonce;

  const NnsGovernanceDisburseToNeuron({
    required this.dissolveDelaySeconds,
    required this.kycVerified,
    required this.amountE8s,
    this.newController,
    required this.nonce,
  });

  static CType get ctype => CType.record([
    Field(Label.named('dissolve_delay_seconds'), CType.nat64),
    Field(Label.named('kyc_verified'), CType.bool_),
    Field(Label.named('amount_e8s'), CType.nat64),
    Field(Label.named('new_controller'), CType.opt(CType.principal)),
    Field(Label.named('nonce'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'dissolve_delay_seconds': dissolveDelaySeconds,
    'kyc_verified': kycVerified,
    'amount_e8s': amountE8s,
    'new_controller': newController,
    'nonce': nonce,
  };

  Map<String, dynamic> toJson() => {
    'dissolve_delay_seconds': dissolveDelaySeconds,
    'kyc_verified': kycVerified,
    'amount_e8s': amountE8s,
    'new_controller': newController?.address,
    'nonce': nonce,
  };

  factory NnsGovernanceDisburseToNeuron.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceDisburseToNeuron(
      dissolveDelaySeconds: json.valueAsBigInt<BigInt>(
        'dissolve_delay_seconds',
      ),
      kycVerified: json.valueAsBool<bool>('kyc_verified'),
      amountE8s: json.valueAsBigInt<BigInt>('amount_e8s'),
      newController: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'new_controller',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      nonce: json.valueAsBigInt<BigInt>('nonce'),
    );
  }

  factory NnsGovernanceDisburseToNeuron.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDisburseToNeuron.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `DissolveState`.
sealed class NnsGovernanceDissolveState with CandidSerializable {
  const NnsGovernanceDissolveState();

  static CType get ctype => CType.variant([
    Field(Label.named('DissolveDelaySeconds'), CType.nat64),
    Field(Label.named('WhenDissolvedTimestampSeconds'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceDissolveState.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('DissolveDelaySeconds')) {
      return NnsGovernanceDissolveStateDissolveDelaySeconds(
        json.valueAsBigInt<BigInt>('DissolveDelaySeconds'),
      );
    }
    if (json.containsKey('WhenDissolvedTimestampSeconds')) {
      return NnsGovernanceDissolveStateWhenDissolvedTimestampSeconds(
        json.valueAsBigInt<BigInt>('WhenDissolvedTimestampSeconds'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceDissolveState.fromCandid',
      reason: 'Unknown NnsGovernanceDissolveState arm',
    );
  }

  factory NnsGovernanceDissolveState.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDissolveState.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `DissolveState.DissolveDelaySeconds`.
final class NnsGovernanceDissolveStateDissolveDelaySeconds
    extends NnsGovernanceDissolveState {
  final BigInt value;
  const NnsGovernanceDissolveStateDissolveDelaySeconds(this.value);

  @override
  CType get candidType => NnsGovernanceDissolveState.ctype;

  @override
  dynamic get candidValue => Variant('DissolveDelaySeconds', value);

  @override
  Map<String, dynamic> toJson() => {'DissolveDelaySeconds': value};
}

/// Variant arm `DissolveState.WhenDissolvedTimestampSeconds`.
final class NnsGovernanceDissolveStateWhenDissolvedTimestampSeconds
    extends NnsGovernanceDissolveState {
  final BigInt value;
  const NnsGovernanceDissolveStateWhenDissolvedTimestampSeconds(this.value);

  @override
  CType get candidType => NnsGovernanceDissolveState.ctype;

  @override
  dynamic get candidValue => Variant('WhenDissolvedTimestampSeconds', value);

  @override
  Map<String, dynamic> toJson() => {'WhenDissolvedTimestampSeconds': value};
}

/// Candid record `Duration`.
final class NnsGovernanceDuration with CandidSerializable {
  final BigInt? seconds;

  const NnsGovernanceDuration({this.seconds});

  static CType get ctype =>
      CType.record([Field(Label.named('seconds'), CType.opt(CType.nat64))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'seconds': seconds};

  Map<String, dynamic> toJson() => {'seconds': seconds};

  factory NnsGovernanceDuration.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceDuration(
      seconds: json.valueAsBigInt<BigInt?>('seconds'),
    );
  }

  factory NnsGovernanceDuration.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDuration.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ExecuteNnsFunction`.
final class NnsGovernanceExecuteNnsFunction with CandidSerializable {
  final int nnsFunction;
  final List<int> payload;

  const NnsGovernanceExecuteNnsFunction({
    required this.nnsFunction,
    required this.payload,
  });

  static CType get ctype => CType.record([
    Field(Label.named('nns_function'), CType.int32),
    Field(Label.named('payload'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'nns_function': nnsFunction, 'payload': payload};

  Map<String, dynamic> toJson() => {
    'nns_function': nnsFunction,
    'payload': payload,
  };

  factory NnsGovernanceExecuteNnsFunction.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceExecuteNnsFunction(
      nnsFunction: json.valueAsInt<int>('nns_function'),
      payload: json.valueAsBytes<List<int>>(
        'payload',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsGovernanceExecuteNnsFunction.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceExecuteNnsFunction.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Follow`.
final class NnsGovernanceFollow with CandidSerializable {
  final int topic;
  final List<NnsGovernanceNeuronId> followees;

  const NnsGovernanceFollow({required this.topic, required this.followees});

  static CType get ctype => CType.record([
    Field(Label.named('topic'), CType.int32),
    LazyField(
      Label.named('followees'),
      () => CType.vec(NnsGovernanceNeuronId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'topic': topic,
    'followees': followees.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'topic': topic,
    'followees': followees.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceFollow.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceFollow(
      topic: json.valueAsInt<int>('topic'),
      followees: json.valueTo<List<NnsGovernanceNeuronId>, List>(
        key: 'followees',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceNeuronId>(
                      (x) => NnsGovernanceNeuronId.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceFollow.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceFollow.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Followees`.
final class NnsGovernanceFollowees with CandidSerializable {
  final List<NnsGovernanceNeuronId> followees;

  const NnsGovernanceFollowees({required this.followees});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('followees'),
      () => CType.vec(NnsGovernanceNeuronId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'followees': followees.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'followees': followees.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceFollowees.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceFollowees(
      followees: json.valueTo<List<NnsGovernanceNeuronId>, List>(
        key: 'followees',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceNeuronId>(
                      (x) => NnsGovernanceNeuronId.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceFollowees.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceFollowees.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetNeuronsFundAuditInfoRequest`.
final class NnsGovernanceGetNeuronsFundAuditInfoRequest
    with CandidSerializable {
  final NnsGovernanceProposalId? nnsProposalId;

  const NnsGovernanceGetNeuronsFundAuditInfoRequest({this.nnsProposalId});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('nns_proposal_id'),
      () => CType.opt(NnsGovernanceProposalId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'nns_proposal_id': nnsProposalId?.candidValue};

  Map<String, dynamic> toJson() => {'nns_proposal_id': nnsProposalId?.toJson()};

  factory NnsGovernanceGetNeuronsFundAuditInfoRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGetNeuronsFundAuditInfoRequest(
      nnsProposalId: json.valueTo<NnsGovernanceProposalId?, Map>(
        key: 'nns_proposal_id',
        parse:
            (e) => NnsGovernanceProposalId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceGetNeuronsFundAuditInfoRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGetNeuronsFundAuditInfoRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `MaturityModulation`.
final class NnsGovernanceMaturityModulation with CandidSerializable {
  final int? currentValuePermyriad;
  final BigInt? updatedAtTimestampSeconds;

  const NnsGovernanceMaturityModulation({
    this.currentValuePermyriad,
    this.updatedAtTimestampSeconds,
  });

  static CType get ctype => CType.record([
    Field(Label.named('current_value_permyriad'), CType.opt(CType.int32)),
    Field(Label.named('updated_at_timestamp_seconds'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'current_value_permyriad': currentValuePermyriad,
    'updated_at_timestamp_seconds': updatedAtTimestampSeconds,
  };

  Map<String, dynamic> toJson() => {
    'current_value_permyriad': currentValuePermyriad,
    'updated_at_timestamp_seconds': updatedAtTimestampSeconds,
  };

  factory NnsGovernanceMaturityModulation.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceMaturityModulation(
      currentValuePermyriad: json.valueAsInt<int?>('current_value_permyriad'),
      updatedAtTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'updated_at_timestamp_seconds',
      ),
    );
  }

  factory NnsGovernanceMaturityModulation.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceMaturityModulation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetMaturityModulationRequest`.
final class NnsGovernanceGetMaturityModulationRequest with CandidSerializable {
  const NnsGovernanceGetMaturityModulationRequest();

  static CType get ctype => CType.record(const []);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => <String, dynamic>{};

  Map<String, dynamic> toJson() => <String, dynamic>{};

  factory NnsGovernanceGetMaturityModulationRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return const NnsGovernanceGetMaturityModulationRequest();
  }

  factory NnsGovernanceGetMaturityModulationRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGetMaturityModulationRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetMaturityModulationResponse`.
final class NnsGovernanceGetMaturityModulationResponse with CandidSerializable {
  final NnsGovernanceMaturityModulation? maturityModulation;

  const NnsGovernanceGetMaturityModulationResponse({this.maturityModulation});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('maturity_modulation'),
      () => CType.opt(NnsGovernanceMaturityModulation.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'maturity_modulation': maturityModulation?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'maturity_modulation': maturityModulation?.toJson(),
  };

  factory NnsGovernanceGetMaturityModulationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGetMaturityModulationResponse(
      maturityModulation: json.valueTo<NnsGovernanceMaturityModulation?, Map>(
        key: 'maturity_modulation',
        parse:
            (e) => NnsGovernanceMaturityModulation.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceGetMaturityModulationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGetMaturityModulationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetNeuronsFundAuditInfoResponse`.
final class NnsGovernanceGetNeuronsFundAuditInfoResponse
    with CandidSerializable {
  final NnsGovernanceResult6? result;

  const NnsGovernanceGetNeuronsFundAuditInfoResponse({this.result});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('result'),
      () => CType.opt(NnsGovernanceResult6.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'result': result?.candidValue};

  Map<String, dynamic> toJson() => {'result': result?.toJson()};

  factory NnsGovernanceGetNeuronsFundAuditInfoResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGetNeuronsFundAuditInfoResponse(
      result: json.valueTo<NnsGovernanceResult6?, Map>(
        key: 'result',
        parse:
            (e) => NnsGovernanceResult6.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceGetNeuronsFundAuditInfoResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGetNeuronsFundAuditInfoResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GlobalTimeOfDay`.
final class NnsGovernanceGlobalTimeOfDay with CandidSerializable {
  final BigInt? secondsAfterUtcMidnight;

  const NnsGovernanceGlobalTimeOfDay({this.secondsAfterUtcMidnight});

  static CType get ctype => CType.record([
    Field(Label.named('seconds_after_utc_midnight'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'seconds_after_utc_midnight': secondsAfterUtcMidnight,
  };

  Map<String, dynamic> toJson() => {
    'seconds_after_utc_midnight': secondsAfterUtcMidnight,
  };

  factory NnsGovernanceGlobalTimeOfDay.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceGlobalTimeOfDay(
      secondsAfterUtcMidnight: json.valueAsBigInt<BigInt?>(
        'seconds_after_utc_midnight',
      ),
    );
  }

  factory NnsGovernanceGlobalTimeOfDay.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGlobalTimeOfDay.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Governance`.
final class NnsGovernanceGovernance with CandidSerializable {
  final List<NnsGovernanceGovernanceDefaultFollowees> defaultFollowees;
  final NnsGovernanceMonthlyNodeProviderRewards?
  mostRecentMonthlyNodeProviderRewards;
  final BigInt? maturityModulationLastUpdatedAtTimestampSeconds;
  final BigInt waitForQuietThresholdSeconds;
  final NnsGovernanceGovernanceCachedMetrics? metrics;
  final BigInt? neuronManagementVotingPeriodSeconds;
  final List<NnsGovernanceNodeProvider> nodeProviders;
  final int? cachedDailyMaturityModulationBasisPoints;
  final NnsGovernanceNetworkEconomics? economics;
  final NnsGovernanceRestoreAgingSummary? restoreAgingSummary;
  final bool? spawningNeurons;
  final NnsGovernanceRewardEvent? latestRewardEvent;
  final List<NnsGovernanceNeuronStakeTransfer> toClaimTransfers;
  final BigInt shortVotingPeriodSeconds;
  final List<NnsGovernanceGovernanceProposals> proposals;
  final NnsGovernanceXdrConversionRate? xdrConversionRate;
  final List<NnsGovernanceGovernanceInFlightCommands> inFlightCommands;
  final List<NnsGovernanceGovernanceNeurons> neurons;
  final BigInt genesisTimestampSeconds;

  const NnsGovernanceGovernance({
    required this.defaultFollowees,
    this.mostRecentMonthlyNodeProviderRewards,
    this.maturityModulationLastUpdatedAtTimestampSeconds,
    required this.waitForQuietThresholdSeconds,
    this.metrics,
    this.neuronManagementVotingPeriodSeconds,
    required this.nodeProviders,
    this.cachedDailyMaturityModulationBasisPoints,
    this.economics,
    this.restoreAgingSummary,
    this.spawningNeurons,
    this.latestRewardEvent,
    required this.toClaimTransfers,
    required this.shortVotingPeriodSeconds,
    required this.proposals,
    this.xdrConversionRate,
    required this.inFlightCommands,
    required this.neurons,
    required this.genesisTimestampSeconds,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('default_followees'),
      () => CType.vec(NnsGovernanceGovernanceDefaultFollowees.ctype),
    ),
    LazyField(
      Label.named('most_recent_monthly_node_provider_rewards'),
      () => CType.opt(NnsGovernanceMonthlyNodeProviderRewards.ctype),
    ),
    Field(
      Label.named('maturity_modulation_last_updated_at_timestamp_seconds'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('wait_for_quiet_threshold_seconds'), CType.nat64),
    LazyField(
      Label.named('metrics'),
      () => CType.opt(NnsGovernanceGovernanceCachedMetrics.ctype),
    ),
    Field(
      Label.named('neuron_management_voting_period_seconds'),
      CType.opt(CType.nat64),
    ),
    LazyField(
      Label.named('node_providers'),
      () => CType.vec(NnsGovernanceNodeProvider.ctype),
    ),
    Field(
      Label.named('cached_daily_maturity_modulation_basis_points'),
      CType.opt(CType.int32),
    ),
    LazyField(
      Label.named('economics'),
      () => CType.opt(NnsGovernanceNetworkEconomics.ctype),
    ),
    LazyField(
      Label.named('restore_aging_summary'),
      () => CType.opt(NnsGovernanceRestoreAgingSummary.ctype),
    ),
    Field(Label.named('spawning_neurons'), CType.opt(CType.bool_)),
    LazyField(
      Label.named('latest_reward_event'),
      () => CType.opt(NnsGovernanceRewardEvent.ctype),
    ),
    LazyField(
      Label.named('to_claim_transfers'),
      () => CType.vec(NnsGovernanceNeuronStakeTransfer.ctype),
    ),
    Field(Label.named('short_voting_period_seconds'), CType.nat64),
    LazyField(
      Label.named('proposals'),
      () => CType.vec(NnsGovernanceGovernanceProposals.ctype),
    ),
    LazyField(
      Label.named('xdr_conversion_rate'),
      () => CType.opt(NnsGovernanceXdrConversionRate.ctype),
    ),
    LazyField(
      Label.named('in_flight_commands'),
      () => CType.vec(NnsGovernanceGovernanceInFlightCommands.ctype),
    ),
    LazyField(
      Label.named('neurons'),
      () => CType.vec(NnsGovernanceGovernanceNeurons.ctype),
    ),
    Field(Label.named('genesis_timestamp_seconds'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'default_followees': defaultFollowees.map((el) => el.candidValue).toList(),
    'most_recent_monthly_node_provider_rewards':
        mostRecentMonthlyNodeProviderRewards?.candidValue,
    'maturity_modulation_last_updated_at_timestamp_seconds':
        maturityModulationLastUpdatedAtTimestampSeconds,
    'wait_for_quiet_threshold_seconds': waitForQuietThresholdSeconds,
    'metrics': metrics?.candidValue,
    'neuron_management_voting_period_seconds':
        neuronManagementVotingPeriodSeconds,
    'node_providers': nodeProviders.map((el) => el.candidValue).toList(),
    'cached_daily_maturity_modulation_basis_points':
        cachedDailyMaturityModulationBasisPoints,
    'economics': economics?.candidValue,
    'restore_aging_summary': restoreAgingSummary?.candidValue,
    'spawning_neurons': spawningNeurons,
    'latest_reward_event': latestRewardEvent?.candidValue,
    'to_claim_transfers': toClaimTransfers.map((el) => el.candidValue).toList(),
    'short_voting_period_seconds': shortVotingPeriodSeconds,
    'proposals': proposals.map((el) => el.candidValue).toList(),
    'xdr_conversion_rate': xdrConversionRate?.candidValue,
    'in_flight_commands': inFlightCommands.map((el) => el.candidValue).toList(),
    'neurons': neurons.map((el) => el.candidValue).toList(),
    'genesis_timestamp_seconds': genesisTimestampSeconds,
  };

  Map<String, dynamic> toJson() => {
    'default_followees': defaultFollowees.map((el) => el.toJson()).toList(),
    'most_recent_monthly_node_provider_rewards':
        mostRecentMonthlyNodeProviderRewards?.toJson(),
    'maturity_modulation_last_updated_at_timestamp_seconds':
        maturityModulationLastUpdatedAtTimestampSeconds,
    'wait_for_quiet_threshold_seconds': waitForQuietThresholdSeconds,
    'metrics': metrics?.toJson(),
    'neuron_management_voting_period_seconds':
        neuronManagementVotingPeriodSeconds,
    'node_providers': nodeProviders.map((el) => el.toJson()).toList(),
    'cached_daily_maturity_modulation_basis_points':
        cachedDailyMaturityModulationBasisPoints,
    'economics': economics?.toJson(),
    'restore_aging_summary': restoreAgingSummary?.toJson(),
    'spawning_neurons': spawningNeurons,
    'latest_reward_event': latestRewardEvent?.toJson(),
    'to_claim_transfers': toClaimTransfers.map((el) => el.toJson()).toList(),
    'short_voting_period_seconds': shortVotingPeriodSeconds,
    'proposals': proposals.map((el) => el.toJson()).toList(),
    'xdr_conversion_rate': xdrConversionRate?.toJson(),
    'in_flight_commands': inFlightCommands.map((el) => el.toJson()).toList(),
    'neurons': neurons.map((el) => el.toJson()).toList(),
    'genesis_timestamp_seconds': genesisTimestampSeconds,
  };

  factory NnsGovernanceGovernance.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceGovernance(
      defaultFollowees: json.valueTo<
        List<NnsGovernanceGovernanceDefaultFollowees>,
        List
      >(
        key: 'default_followees',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceGovernanceDefaultFollowees>(
                      (x) => NnsGovernanceGovernanceDefaultFollowees.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      mostRecentMonthlyNodeProviderRewards: json
          .valueTo<NnsGovernanceMonthlyNodeProviderRewards?, Map>(
            key: 'most_recent_monthly_node_provider_rewards',
            parse:
                (e) => NnsGovernanceMonthlyNodeProviderRewards.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      maturityModulationLastUpdatedAtTimestampSeconds: json
          .valueAsBigInt<BigInt?>(
            'maturity_modulation_last_updated_at_timestamp_seconds',
          ),
      waitForQuietThresholdSeconds: json.valueAsBigInt<BigInt>(
        'wait_for_quiet_threshold_seconds',
      ),
      metrics: json.valueTo<NnsGovernanceGovernanceCachedMetrics?, Map>(
        key: 'metrics',
        parse:
            (e) => NnsGovernanceGovernanceCachedMetrics.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      neuronManagementVotingPeriodSeconds: json.valueAsBigInt<BigInt?>(
        'neuron_management_voting_period_seconds',
      ),
      nodeProviders: json.valueTo<List<NnsGovernanceNodeProvider>, List>(
        key: 'node_providers',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceNodeProvider>(
                      (x) => NnsGovernanceNodeProvider.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      cachedDailyMaturityModulationBasisPoints: json.valueAsInt<int?>(
        'cached_daily_maturity_modulation_basis_points',
      ),
      economics: json.valueTo<NnsGovernanceNetworkEconomics?, Map>(
        key: 'economics',
        parse:
            (e) => NnsGovernanceNetworkEconomics.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      restoreAgingSummary: json.valueTo<NnsGovernanceRestoreAgingSummary?, Map>(
        key: 'restore_aging_summary',
        parse:
            (e) => NnsGovernanceRestoreAgingSummary.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      spawningNeurons: json.valueAsBool<bool?>('spawning_neurons'),
      latestRewardEvent: json.valueTo<NnsGovernanceRewardEvent?, Map>(
        key: 'latest_reward_event',
        parse:
            (e) => NnsGovernanceRewardEvent.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      toClaimTransfers: json
          .valueTo<List<NnsGovernanceNeuronStakeTransfer>, List>(
            key: 'to_claim_transfers',
            parse:
                (e) =>
                    e
                        .map<NnsGovernanceNeuronStakeTransfer>(
                          (x) => NnsGovernanceNeuronStakeTransfer.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
      shortVotingPeriodSeconds: json.valueAsBigInt<BigInt>(
        'short_voting_period_seconds',
      ),
      proposals: json.valueTo<List<NnsGovernanceGovernanceProposals>, List>(
        key: 'proposals',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceGovernanceProposals>(
                      (x) => NnsGovernanceGovernanceProposals.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      xdrConversionRate: json.valueTo<NnsGovernanceXdrConversionRate?, Map>(
        key: 'xdr_conversion_rate',
        parse:
            (e) => NnsGovernanceXdrConversionRate.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      inFlightCommands: json.valueTo<
        List<NnsGovernanceGovernanceInFlightCommands>,
        List
      >(
        key: 'in_flight_commands',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceGovernanceInFlightCommands>(
                      (x) => NnsGovernanceGovernanceInFlightCommands.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      neurons: json.valueTo<List<NnsGovernanceGovernanceNeurons>, List>(
        key: 'neurons',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceGovernanceNeurons>(
                      (x) => NnsGovernanceGovernanceNeurons.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      genesisTimestampSeconds: json.valueAsBigInt<BigInt>(
        'genesis_timestamp_seconds',
      ),
    );
  }

  factory NnsGovernanceGovernance.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGovernance.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GovernanceCachedMetrics`.
final class NnsGovernanceGovernanceCachedMetrics with CandidSerializable {
  final BigInt totalMaturityE8sEquivalent;
  final List<NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets>
  notDissolvingNeuronsE8sBuckets;
  final BigInt dissolvingNeuronsStakedMaturityE8sEquivalentSum;
  final BigInt garbageCollectableNeuronsCount;
  final List<NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets>
  dissolvingNeuronsStakedMaturityE8sEquivalentBuckets;
  final BigInt neuronsWithInvalidStakeCount;
  final List<
    NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
  >
  notDissolvingNeuronsCountBuckets;
  final BigInt ectNeuronCount;
  final BigInt totalSupplyIcp;
  final BigInt neuronsWithLessThan6MonthsDissolveDelayCount;
  final BigInt dissolvedNeuronsCount;
  final BigInt communityFundTotalMaturityE8sEquivalent;
  final BigInt totalStakedE8sSeed;
  final BigInt totalStakedMaturityE8sEquivalentEct;
  final BigInt totalStakedE8s;
  final BigInt notDissolvingNeuronsCount;
  final BigInt totalLockedE8s;
  final BigInt neuronsFundTotalActiveNeurons;
  final BigInt? totalVotingPowerNonSelfAuthenticatingController;
  final BigInt totalStakedMaturityE8sEquivalent;
  final List<NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets>
  notDissolvingNeuronsE8sBucketsEct;
  final BigInt totalStakedE8sEct;
  final BigInt notDissolvingNeuronsStakedMaturityE8sEquivalentSum;
  final BigInt dissolvedNeuronsE8s;
  final BigInt? totalStakedE8sNonSelfAuthenticatingController;
  final List<NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets>
  dissolvingNeuronsE8sBucketsSeed;
  final BigInt neuronsWithLessThan6MonthsDissolveDelayE8s;
  final List<NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets>
  notDissolvingNeuronsStakedMaturityE8sEquivalentBuckets;
  final List<
    NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
  >
  dissolvingNeuronsCountBuckets;
  final List<NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets>
  dissolvingNeuronsE8sBucketsEct;
  final BigInt dissolvingNeuronsCount;
  final List<NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets>
  dissolvingNeuronsE8sBuckets;
  final BigInt totalStakedMaturityE8sEquivalentSeed;
  final BigInt communityFundTotalStakedE8s;
  final List<NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets>
  notDissolvingNeuronsE8sBucketsSeed;
  final BigInt timestampSeconds;
  final BigInt seedNeuronCount;
  final BigInt spawningNeuronsCount;
  final BigInt totalMaturityDisbursementsInProgressE8sEquivalent;
  final NnsGovernanceNeuronSubsetMetrics?
  nonSelfAuthenticatingControllerNeuronSubsetMetrics;
  final NnsGovernanceNeuronSubsetMetrics? publicNeuronSubsetMetrics;
  final NnsGovernanceNeuronSubsetMetrics?
  decliningVotingPowerNeuronSubsetMetrics;
  final NnsGovernanceNeuronSubsetMetrics?
  fullyLostVotingPowerNeuronSubsetMetrics;

  const NnsGovernanceGovernanceCachedMetrics({
    required this.totalMaturityE8sEquivalent,
    required this.notDissolvingNeuronsE8sBuckets,
    required this.dissolvingNeuronsStakedMaturityE8sEquivalentSum,
    required this.garbageCollectableNeuronsCount,
    required this.dissolvingNeuronsStakedMaturityE8sEquivalentBuckets,
    required this.neuronsWithInvalidStakeCount,
    required this.notDissolvingNeuronsCountBuckets,
    required this.ectNeuronCount,
    required this.totalSupplyIcp,
    required this.neuronsWithLessThan6MonthsDissolveDelayCount,
    required this.dissolvedNeuronsCount,
    required this.communityFundTotalMaturityE8sEquivalent,
    required this.totalStakedE8sSeed,
    required this.totalStakedMaturityE8sEquivalentEct,
    required this.totalStakedE8s,
    required this.notDissolvingNeuronsCount,
    required this.totalLockedE8s,
    required this.neuronsFundTotalActiveNeurons,
    this.totalVotingPowerNonSelfAuthenticatingController,
    required this.totalStakedMaturityE8sEquivalent,
    required this.notDissolvingNeuronsE8sBucketsEct,
    required this.totalStakedE8sEct,
    required this.notDissolvingNeuronsStakedMaturityE8sEquivalentSum,
    required this.dissolvedNeuronsE8s,
    this.totalStakedE8sNonSelfAuthenticatingController,
    required this.dissolvingNeuronsE8sBucketsSeed,
    required this.neuronsWithLessThan6MonthsDissolveDelayE8s,
    required this.notDissolvingNeuronsStakedMaturityE8sEquivalentBuckets,
    required this.dissolvingNeuronsCountBuckets,
    required this.dissolvingNeuronsE8sBucketsEct,
    required this.dissolvingNeuronsCount,
    required this.dissolvingNeuronsE8sBuckets,
    required this.totalStakedMaturityE8sEquivalentSeed,
    required this.communityFundTotalStakedE8s,
    required this.notDissolvingNeuronsE8sBucketsSeed,
    required this.timestampSeconds,
    required this.seedNeuronCount,
    required this.spawningNeuronsCount,
    required this.totalMaturityDisbursementsInProgressE8sEquivalent,
    this.nonSelfAuthenticatingControllerNeuronSubsetMetrics,
    this.publicNeuronSubsetMetrics,
    this.decliningVotingPowerNeuronSubsetMetrics,
    this.fullyLostVotingPowerNeuronSubsetMetrics,
  });

  static CType get ctype => CType.record([
    Field(Label.named('total_maturity_e8s_equivalent'), CType.nat64),
    LazyField(
      Label.named('not_dissolving_neurons_e8s_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
            .ctype,
      ),
    ),
    Field(
      Label.named('dissolving_neurons_staked_maturity_e8s_equivalent_sum'),
      CType.nat64,
    ),
    Field(Label.named('garbage_collectable_neurons_count'), CType.nat64),
    LazyField(
      Label.named('dissolving_neurons_staked_maturity_e8s_equivalent_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
            .ctype,
      ),
    ),
    Field(Label.named('neurons_with_invalid_stake_count'), CType.nat64),
    LazyField(
      Label.named('not_dissolving_neurons_count_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
            .ctype,
      ),
    ),
    Field(Label.named('ect_neuron_count'), CType.nat64),
    Field(Label.named('total_supply_icp'), CType.nat64),
    Field(
      Label.named('neurons_with_less_than_6_months_dissolve_delay_count'),
      CType.nat64,
    ),
    Field(Label.named('dissolved_neurons_count'), CType.nat64),
    Field(
      Label.named('community_fund_total_maturity_e8s_equivalent'),
      CType.nat64,
    ),
    Field(Label.named('total_staked_e8s_seed'), CType.nat64),
    Field(Label.named('total_staked_maturity_e8s_equivalent_ect'), CType.nat64),
    Field(Label.named('total_staked_e8s'), CType.nat64),
    Field(Label.named('not_dissolving_neurons_count'), CType.nat64),
    Field(Label.named('total_locked_e8s'), CType.nat64),
    Field(Label.named('neurons_fund_total_active_neurons'), CType.nat64),
    Field(
      Label.named('total_voting_power_non_self_authenticating_controller'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('total_staked_maturity_e8s_equivalent'), CType.nat64),
    LazyField(
      Label.named('not_dissolving_neurons_e8s_buckets_ect'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
            .ctype,
      ),
    ),
    Field(Label.named('total_staked_e8s_ect'), CType.nat64),
    Field(
      Label.named('not_dissolving_neurons_staked_maturity_e8s_equivalent_sum'),
      CType.nat64,
    ),
    Field(Label.named('dissolved_neurons_e8s'), CType.nat64),
    Field(
      Label.named('total_staked_e8s_non_self_authenticating_controller'),
      CType.opt(CType.nat64),
    ),
    LazyField(
      Label.named('dissolving_neurons_e8s_buckets_seed'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
            .ctype,
      ),
    ),
    Field(
      Label.named('neurons_with_less_than_6_months_dissolve_delay_e8s'),
      CType.nat64,
    ),
    LazyField(
      Label.named(
        'not_dissolving_neurons_staked_maturity_e8s_equivalent_buckets',
      ),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
            .ctype,
      ),
    ),
    LazyField(
      Label.named('dissolving_neurons_count_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
            .ctype,
      ),
    ),
    LazyField(
      Label.named('dissolving_neurons_e8s_buckets_ect'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
            .ctype,
      ),
    ),
    Field(Label.named('dissolving_neurons_count'), CType.nat64),
    LazyField(
      Label.named('dissolving_neurons_e8s_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
            .ctype,
      ),
    ),
    Field(
      Label.named('total_staked_maturity_e8s_equivalent_seed'),
      CType.nat64,
    ),
    Field(Label.named('community_fund_total_staked_e8s'), CType.nat64),
    LazyField(
      Label.named('not_dissolving_neurons_e8s_buckets_seed'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
            .ctype,
      ),
    ),
    Field(Label.named('timestamp_seconds'), CType.nat64),
    Field(Label.named('seed_neuron_count'), CType.nat64),
    Field(Label.named('spawning_neurons_count'), CType.nat64),
    Field(
      Label.named('total_maturity_disbursements_in_progress_e8s_equivalent'),
      CType.nat64,
    ),
    LazyField(
      Label.named('non_self_authenticating_controller_neuron_subset_metrics'),
      () => CType.opt(NnsGovernanceNeuronSubsetMetrics.ctype),
    ),
    LazyField(
      Label.named('public_neuron_subset_metrics'),
      () => CType.opt(NnsGovernanceNeuronSubsetMetrics.ctype),
    ),
    LazyField(
      Label.named('declining_voting_power_neuron_subset_metrics'),
      () => CType.opt(NnsGovernanceNeuronSubsetMetrics.ctype),
    ),
    LazyField(
      Label.named('fully_lost_voting_power_neuron_subset_metrics'),
      () => CType.opt(NnsGovernanceNeuronSubsetMetrics.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'total_maturity_e8s_equivalent': totalMaturityE8sEquivalent,
    'not_dissolving_neurons_e8s_buckets':
        notDissolvingNeuronsE8sBuckets.map((el) => el.candidValue).toList(),
    'dissolving_neurons_staked_maturity_e8s_equivalent_sum':
        dissolvingNeuronsStakedMaturityE8sEquivalentSum,
    'garbage_collectable_neurons_count': garbageCollectableNeuronsCount,
    'dissolving_neurons_staked_maturity_e8s_equivalent_buckets':
        dissolvingNeuronsStakedMaturityE8sEquivalentBuckets
            .map((el) => el.candidValue)
            .toList(),
    'neurons_with_invalid_stake_count': neuronsWithInvalidStakeCount,
    'not_dissolving_neurons_count_buckets':
        notDissolvingNeuronsCountBuckets.map((el) => el.candidValue).toList(),
    'ect_neuron_count': ectNeuronCount,
    'total_supply_icp': totalSupplyIcp,
    'neurons_with_less_than_6_months_dissolve_delay_count':
        neuronsWithLessThan6MonthsDissolveDelayCount,
    'dissolved_neurons_count': dissolvedNeuronsCount,
    'community_fund_total_maturity_e8s_equivalent':
        communityFundTotalMaturityE8sEquivalent,
    'total_staked_e8s_seed': totalStakedE8sSeed,
    'total_staked_maturity_e8s_equivalent_ect':
        totalStakedMaturityE8sEquivalentEct,
    'total_staked_e8s': totalStakedE8s,
    'not_dissolving_neurons_count': notDissolvingNeuronsCount,
    'total_locked_e8s': totalLockedE8s,
    'neurons_fund_total_active_neurons': neuronsFundTotalActiveNeurons,
    'total_voting_power_non_self_authenticating_controller':
        totalVotingPowerNonSelfAuthenticatingController,
    'total_staked_maturity_e8s_equivalent': totalStakedMaturityE8sEquivalent,
    'not_dissolving_neurons_e8s_buckets_ect':
        notDissolvingNeuronsE8sBucketsEct.map((el) => el.candidValue).toList(),
    'total_staked_e8s_ect': totalStakedE8sEct,
    'not_dissolving_neurons_staked_maturity_e8s_equivalent_sum':
        notDissolvingNeuronsStakedMaturityE8sEquivalentSum,
    'dissolved_neurons_e8s': dissolvedNeuronsE8s,
    'total_staked_e8s_non_self_authenticating_controller':
        totalStakedE8sNonSelfAuthenticatingController,
    'dissolving_neurons_e8s_buckets_seed':
        dissolvingNeuronsE8sBucketsSeed.map((el) => el.candidValue).toList(),
    'neurons_with_less_than_6_months_dissolve_delay_e8s':
        neuronsWithLessThan6MonthsDissolveDelayE8s,
    'not_dissolving_neurons_staked_maturity_e8s_equivalent_buckets':
        notDissolvingNeuronsStakedMaturityE8sEquivalentBuckets
            .map((el) => el.candidValue)
            .toList(),
    'dissolving_neurons_count_buckets':
        dissolvingNeuronsCountBuckets.map((el) => el.candidValue).toList(),
    'dissolving_neurons_e8s_buckets_ect':
        dissolvingNeuronsE8sBucketsEct.map((el) => el.candidValue).toList(),
    'dissolving_neurons_count': dissolvingNeuronsCount,
    'dissolving_neurons_e8s_buckets':
        dissolvingNeuronsE8sBuckets.map((el) => el.candidValue).toList(),
    'total_staked_maturity_e8s_equivalent_seed':
        totalStakedMaturityE8sEquivalentSeed,
    'community_fund_total_staked_e8s': communityFundTotalStakedE8s,
    'not_dissolving_neurons_e8s_buckets_seed':
        notDissolvingNeuronsE8sBucketsSeed.map((el) => el.candidValue).toList(),
    'timestamp_seconds': timestampSeconds,
    'seed_neuron_count': seedNeuronCount,
    'spawning_neurons_count': spawningNeuronsCount,
    'total_maturity_disbursements_in_progress_e8s_equivalent':
        totalMaturityDisbursementsInProgressE8sEquivalent,
    'non_self_authenticating_controller_neuron_subset_metrics':
        nonSelfAuthenticatingControllerNeuronSubsetMetrics?.candidValue,
    'public_neuron_subset_metrics': publicNeuronSubsetMetrics?.candidValue,
    'declining_voting_power_neuron_subset_metrics':
        decliningVotingPowerNeuronSubsetMetrics?.candidValue,
    'fully_lost_voting_power_neuron_subset_metrics':
        fullyLostVotingPowerNeuronSubsetMetrics?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'total_maturity_e8s_equivalent': totalMaturityE8sEquivalent,
    'not_dissolving_neurons_e8s_buckets':
        notDissolvingNeuronsE8sBuckets.map((el) => el.toJson()).toList(),
    'dissolving_neurons_staked_maturity_e8s_equivalent_sum':
        dissolvingNeuronsStakedMaturityE8sEquivalentSum,
    'garbage_collectable_neurons_count': garbageCollectableNeuronsCount,
    'dissolving_neurons_staked_maturity_e8s_equivalent_buckets':
        dissolvingNeuronsStakedMaturityE8sEquivalentBuckets
            .map((el) => el.toJson())
            .toList(),
    'neurons_with_invalid_stake_count': neuronsWithInvalidStakeCount,
    'not_dissolving_neurons_count_buckets':
        notDissolvingNeuronsCountBuckets.map((el) => el.toJson()).toList(),
    'ect_neuron_count': ectNeuronCount,
    'total_supply_icp': totalSupplyIcp,
    'neurons_with_less_than_6_months_dissolve_delay_count':
        neuronsWithLessThan6MonthsDissolveDelayCount,
    'dissolved_neurons_count': dissolvedNeuronsCount,
    'community_fund_total_maturity_e8s_equivalent':
        communityFundTotalMaturityE8sEquivalent,
    'total_staked_e8s_seed': totalStakedE8sSeed,
    'total_staked_maturity_e8s_equivalent_ect':
        totalStakedMaturityE8sEquivalentEct,
    'total_staked_e8s': totalStakedE8s,
    'not_dissolving_neurons_count': notDissolvingNeuronsCount,
    'total_locked_e8s': totalLockedE8s,
    'neurons_fund_total_active_neurons': neuronsFundTotalActiveNeurons,
    'total_voting_power_non_self_authenticating_controller':
        totalVotingPowerNonSelfAuthenticatingController,
    'total_staked_maturity_e8s_equivalent': totalStakedMaturityE8sEquivalent,
    'not_dissolving_neurons_e8s_buckets_ect':
        notDissolvingNeuronsE8sBucketsEct.map((el) => el.toJson()).toList(),
    'total_staked_e8s_ect': totalStakedE8sEct,
    'not_dissolving_neurons_staked_maturity_e8s_equivalent_sum':
        notDissolvingNeuronsStakedMaturityE8sEquivalentSum,
    'dissolved_neurons_e8s': dissolvedNeuronsE8s,
    'total_staked_e8s_non_self_authenticating_controller':
        totalStakedE8sNonSelfAuthenticatingController,
    'dissolving_neurons_e8s_buckets_seed':
        dissolvingNeuronsE8sBucketsSeed.map((el) => el.toJson()).toList(),
    'neurons_with_less_than_6_months_dissolve_delay_e8s':
        neuronsWithLessThan6MonthsDissolveDelayE8s,
    'not_dissolving_neurons_staked_maturity_e8s_equivalent_buckets':
        notDissolvingNeuronsStakedMaturityE8sEquivalentBuckets
            .map((el) => el.toJson())
            .toList(),
    'dissolving_neurons_count_buckets':
        dissolvingNeuronsCountBuckets.map((el) => el.toJson()).toList(),
    'dissolving_neurons_e8s_buckets_ect':
        dissolvingNeuronsE8sBucketsEct.map((el) => el.toJson()).toList(),
    'dissolving_neurons_count': dissolvingNeuronsCount,
    'dissolving_neurons_e8s_buckets':
        dissolvingNeuronsE8sBuckets.map((el) => el.toJson()).toList(),
    'total_staked_maturity_e8s_equivalent_seed':
        totalStakedMaturityE8sEquivalentSeed,
    'community_fund_total_staked_e8s': communityFundTotalStakedE8s,
    'not_dissolving_neurons_e8s_buckets_seed':
        notDissolvingNeuronsE8sBucketsSeed.map((el) => el.toJson()).toList(),
    'timestamp_seconds': timestampSeconds,
    'seed_neuron_count': seedNeuronCount,
    'spawning_neurons_count': spawningNeuronsCount,
    'total_maturity_disbursements_in_progress_e8s_equivalent':
        totalMaturityDisbursementsInProgressE8sEquivalent,
    'non_self_authenticating_controller_neuron_subset_metrics':
        nonSelfAuthenticatingControllerNeuronSubsetMetrics?.toJson(),
    'public_neuron_subset_metrics': publicNeuronSubsetMetrics?.toJson(),
    'declining_voting_power_neuron_subset_metrics':
        decliningVotingPowerNeuronSubsetMetrics?.toJson(),
    'fully_lost_voting_power_neuron_subset_metrics':
        fullyLostVotingPowerNeuronSubsetMetrics?.toJson(),
  };

  factory NnsGovernanceGovernanceCachedMetrics.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGovernanceCachedMetrics(
      totalMaturityE8sEquivalent: json.valueAsBigInt<BigInt>(
        'total_maturity_e8s_equivalent',
      ),
      notDissolvingNeuronsE8sBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
        >,
        List
      >(
        key: 'not_dissolving_neurons_e8s_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      dissolvingNeuronsStakedMaturityE8sEquivalentSum: json
          .valueAsBigInt<BigInt>(
            'dissolving_neurons_staked_maturity_e8s_equivalent_sum',
          ),
      garbageCollectableNeuronsCount: json.valueAsBigInt<BigInt>(
        'garbage_collectable_neurons_count',
      ),
      dissolvingNeuronsStakedMaturityE8sEquivalentBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
        >,
        List
      >(
        key: 'dissolving_neurons_staked_maturity_e8s_equivalent_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      neuronsWithInvalidStakeCount: json.valueAsBigInt<BigInt>(
        'neurons_with_invalid_stake_count',
      ),
      notDissolvingNeuronsCountBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
        >,
        List
      >(
        key: 'not_dissolving_neurons_count_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      ectNeuronCount: json.valueAsBigInt<BigInt>('ect_neuron_count'),
      totalSupplyIcp: json.valueAsBigInt<BigInt>('total_supply_icp'),
      neuronsWithLessThan6MonthsDissolveDelayCount: json.valueAsBigInt<BigInt>(
        'neurons_with_less_than_6_months_dissolve_delay_count',
      ),
      dissolvedNeuronsCount: json.valueAsBigInt<BigInt>(
        'dissolved_neurons_count',
      ),
      communityFundTotalMaturityE8sEquivalent: json.valueAsBigInt<BigInt>(
        'community_fund_total_maturity_e8s_equivalent',
      ),
      totalStakedE8sSeed: json.valueAsBigInt<BigInt>('total_staked_e8s_seed'),
      totalStakedMaturityE8sEquivalentEct: json.valueAsBigInt<BigInt>(
        'total_staked_maturity_e8s_equivalent_ect',
      ),
      totalStakedE8s: json.valueAsBigInt<BigInt>('total_staked_e8s'),
      notDissolvingNeuronsCount: json.valueAsBigInt<BigInt>(
        'not_dissolving_neurons_count',
      ),
      totalLockedE8s: json.valueAsBigInt<BigInt>('total_locked_e8s'),
      neuronsFundTotalActiveNeurons: json.valueAsBigInt<BigInt>(
        'neurons_fund_total_active_neurons',
      ),
      totalVotingPowerNonSelfAuthenticatingController: json
          .valueAsBigInt<BigInt?>(
            'total_voting_power_non_self_authenticating_controller',
          ),
      totalStakedMaturityE8sEquivalent: json.valueAsBigInt<BigInt>(
        'total_staked_maturity_e8s_equivalent',
      ),
      notDissolvingNeuronsE8sBucketsEct: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
        >,
        List
      >(
        key: 'not_dissolving_neurons_e8s_buckets_ect',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      totalStakedE8sEct: json.valueAsBigInt<BigInt>('total_staked_e8s_ect'),
      notDissolvingNeuronsStakedMaturityE8sEquivalentSum: json
          .valueAsBigInt<BigInt>(
            'not_dissolving_neurons_staked_maturity_e8s_equivalent_sum',
          ),
      dissolvedNeuronsE8s: json.valueAsBigInt<BigInt>('dissolved_neurons_e8s'),
      totalStakedE8sNonSelfAuthenticatingController: json
          .valueAsBigInt<BigInt?>(
            'total_staked_e8s_non_self_authenticating_controller',
          ),
      dissolvingNeuronsE8sBucketsSeed: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
        >,
        List
      >(
        key: 'dissolving_neurons_e8s_buckets_seed',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      neuronsWithLessThan6MonthsDissolveDelayE8s: json.valueAsBigInt<BigInt>(
        'neurons_with_less_than_6_months_dissolve_delay_e8s',
      ),
      notDissolvingNeuronsStakedMaturityE8sEquivalentBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
        >,
        List
      >(
        key: 'not_dissolving_neurons_staked_maturity_e8s_equivalent_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      dissolvingNeuronsCountBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
        >,
        List
      >(
        key: 'dissolving_neurons_count_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      dissolvingNeuronsE8sBucketsEct: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
        >,
        List
      >(
        key: 'dissolving_neurons_e8s_buckets_ect',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      dissolvingNeuronsCount: json.valueAsBigInt<BigInt>(
        'dissolving_neurons_count',
      ),
      dissolvingNeuronsE8sBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
        >,
        List
      >(
        key: 'dissolving_neurons_e8s_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      totalStakedMaturityE8sEquivalentSeed: json.valueAsBigInt<BigInt>(
        'total_staked_maturity_e8s_equivalent_seed',
      ),
      communityFundTotalStakedE8s: json.valueAsBigInt<BigInt>(
        'community_fund_total_staked_e8s',
      ),
      notDissolvingNeuronsE8sBucketsSeed: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
        >,
        List
      >(
        key: 'not_dissolving_neurons_e8s_buckets_seed',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsE8sBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      timestampSeconds: json.valueAsBigInt<BigInt>('timestamp_seconds'),
      seedNeuronCount: json.valueAsBigInt<BigInt>('seed_neuron_count'),
      spawningNeuronsCount: json.valueAsBigInt<BigInt>(
        'spawning_neurons_count',
      ),
      totalMaturityDisbursementsInProgressE8sEquivalent: json
          .valueAsBigInt<BigInt>(
            'total_maturity_disbursements_in_progress_e8s_equivalent',
          ),
      nonSelfAuthenticatingControllerNeuronSubsetMetrics: json
          .valueTo<NnsGovernanceNeuronSubsetMetrics?, Map>(
            key: 'non_self_authenticating_controller_neuron_subset_metrics',
            parse:
                (e) => NnsGovernanceNeuronSubsetMetrics.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      publicNeuronSubsetMetrics: json
          .valueTo<NnsGovernanceNeuronSubsetMetrics?, Map>(
            key: 'public_neuron_subset_metrics',
            parse:
                (e) => NnsGovernanceNeuronSubsetMetrics.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      decliningVotingPowerNeuronSubsetMetrics: json
          .valueTo<NnsGovernanceNeuronSubsetMetrics?, Map>(
            key: 'declining_voting_power_neuron_subset_metrics',
            parse:
                (e) => NnsGovernanceNeuronSubsetMetrics.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      fullyLostVotingPowerNeuronSubsetMetrics: json
          .valueTo<NnsGovernanceNeuronSubsetMetrics?, Map>(
            key: 'fully_lost_voting_power_neuron_subset_metrics',
            parse:
                (e) => NnsGovernanceNeuronSubsetMetrics.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceGovernanceCachedMetrics.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGovernanceCachedMetrics.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GovernanceError`.
final class NnsGovernanceGovernanceError with CandidSerializable {
  final String errorMessage;
  final int errorType;

  const NnsGovernanceGovernanceError({
    required this.errorMessage,
    required this.errorType,
  });

  static CType get ctype => CType.record([
    Field(Label.named('error_message'), CType.text),
    Field(Label.named('error_type'), CType.int32),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'error_message': errorMessage,
    'error_type': errorType,
  };

  Map<String, dynamic> toJson() => {
    'error_message': errorMessage,
    'error_type': errorType,
  };

  factory NnsGovernanceGovernanceError.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceGovernanceError(
      errorMessage: json.valueAsString<String>('error_message'),
      errorType: json.valueAsInt<int>('error_type'),
    );
  }

  factory NnsGovernanceGovernanceError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGovernanceError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GovernanceParameters`.
final class NnsGovernanceGovernanceParameters with CandidSerializable {
  final NnsGovernancePercentage? neuronMaximumDissolveDelayBonus;
  final NnsGovernanceDuration? neuronMaximumAgeForAgeBonus;
  final NnsGovernanceDuration? neuronMaximumDissolveDelay;
  final NnsGovernanceDuration? neuronMinimumDissolveDelayToVote;
  final NnsGovernancePercentage? neuronMaximumAgeBonus;
  final NnsGovernanceTokens? neuronMinimumStake;
  final NnsGovernanceDuration? proposalWaitForQuietDeadlineIncrease;
  final NnsGovernanceDuration? proposalInitialVotingPeriod;
  final NnsGovernanceTokens? proposalRejectionFee;
  final NnsGovernanceVotingRewardParameters? votingRewardParameters;
  final NnsGovernanceCustomProposalCriticality? customProposalCriticality;

  const NnsGovernanceGovernanceParameters({
    this.neuronMaximumDissolveDelayBonus,
    this.neuronMaximumAgeForAgeBonus,
    this.neuronMaximumDissolveDelay,
    this.neuronMinimumDissolveDelayToVote,
    this.neuronMaximumAgeBonus,
    this.neuronMinimumStake,
    this.proposalWaitForQuietDeadlineIncrease,
    this.proposalInitialVotingPeriod,
    this.proposalRejectionFee,
    this.votingRewardParameters,
    this.customProposalCriticality,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('neuron_maximum_dissolve_delay_bonus'),
      () => CType.opt(NnsGovernancePercentage.ctype),
    ),
    LazyField(
      Label.named('neuron_maximum_age_for_age_bonus'),
      () => CType.opt(NnsGovernanceDuration.ctype),
    ),
    LazyField(
      Label.named('neuron_maximum_dissolve_delay'),
      () => CType.opt(NnsGovernanceDuration.ctype),
    ),
    LazyField(
      Label.named('neuron_minimum_dissolve_delay_to_vote'),
      () => CType.opt(NnsGovernanceDuration.ctype),
    ),
    LazyField(
      Label.named('neuron_maximum_age_bonus'),
      () => CType.opt(NnsGovernancePercentage.ctype),
    ),
    LazyField(
      Label.named('neuron_minimum_stake'),
      () => CType.opt(NnsGovernanceTokens.ctype),
    ),
    LazyField(
      Label.named('proposal_wait_for_quiet_deadline_increase'),
      () => CType.opt(NnsGovernanceDuration.ctype),
    ),
    LazyField(
      Label.named('proposal_initial_voting_period'),
      () => CType.opt(NnsGovernanceDuration.ctype),
    ),
    LazyField(
      Label.named('proposal_rejection_fee'),
      () => CType.opt(NnsGovernanceTokens.ctype),
    ),
    LazyField(
      Label.named('voting_reward_parameters'),
      () => CType.opt(NnsGovernanceVotingRewardParameters.ctype),
    ),
    LazyField(
      Label.named('custom_proposal_criticality'),
      () => CType.opt(NnsGovernanceCustomProposalCriticality.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'neuron_maximum_dissolve_delay_bonus':
        neuronMaximumDissolveDelayBonus?.candidValue,
    'neuron_maximum_age_for_age_bonus':
        neuronMaximumAgeForAgeBonus?.candidValue,
    'neuron_maximum_dissolve_delay': neuronMaximumDissolveDelay?.candidValue,
    'neuron_minimum_dissolve_delay_to_vote':
        neuronMinimumDissolveDelayToVote?.candidValue,
    'neuron_maximum_age_bonus': neuronMaximumAgeBonus?.candidValue,
    'neuron_minimum_stake': neuronMinimumStake?.candidValue,
    'proposal_wait_for_quiet_deadline_increase':
        proposalWaitForQuietDeadlineIncrease?.candidValue,
    'proposal_initial_voting_period': proposalInitialVotingPeriod?.candidValue,
    'proposal_rejection_fee': proposalRejectionFee?.candidValue,
    'voting_reward_parameters': votingRewardParameters?.candidValue,
    'custom_proposal_criticality': customProposalCriticality?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'neuron_maximum_dissolve_delay_bonus':
        neuronMaximumDissolveDelayBonus?.toJson(),
    'neuron_maximum_age_for_age_bonus': neuronMaximumAgeForAgeBonus?.toJson(),
    'neuron_maximum_dissolve_delay': neuronMaximumDissolveDelay?.toJson(),
    'neuron_minimum_dissolve_delay_to_vote':
        neuronMinimumDissolveDelayToVote?.toJson(),
    'neuron_maximum_age_bonus': neuronMaximumAgeBonus?.toJson(),
    'neuron_minimum_stake': neuronMinimumStake?.toJson(),
    'proposal_wait_for_quiet_deadline_increase':
        proposalWaitForQuietDeadlineIncrease?.toJson(),
    'proposal_initial_voting_period': proposalInitialVotingPeriod?.toJson(),
    'proposal_rejection_fee': proposalRejectionFee?.toJson(),
    'voting_reward_parameters': votingRewardParameters?.toJson(),
    'custom_proposal_criticality': customProposalCriticality?.toJson(),
  };

  factory NnsGovernanceGovernanceParameters.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGovernanceParameters(
      neuronMaximumDissolveDelayBonus: json
          .valueTo<NnsGovernancePercentage?, Map>(
            key: 'neuron_maximum_dissolve_delay_bonus',
            parse:
                (e) => NnsGovernancePercentage.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      neuronMaximumAgeForAgeBonus: json.valueTo<NnsGovernanceDuration?, Map>(
        key: 'neuron_maximum_age_for_age_bonus',
        parse:
            (e) => NnsGovernanceDuration.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      neuronMaximumDissolveDelay: json.valueTo<NnsGovernanceDuration?, Map>(
        key: 'neuron_maximum_dissolve_delay',
        parse:
            (e) => NnsGovernanceDuration.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      neuronMinimumDissolveDelayToVote: json
          .valueTo<NnsGovernanceDuration?, Map>(
            key: 'neuron_minimum_dissolve_delay_to_vote',
            parse:
                (e) => NnsGovernanceDuration.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      neuronMaximumAgeBonus: json.valueTo<NnsGovernancePercentage?, Map>(
        key: 'neuron_maximum_age_bonus',
        parse:
            (e) => NnsGovernancePercentage.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      neuronMinimumStake: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'neuron_minimum_stake',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      proposalWaitForQuietDeadlineIncrease: json
          .valueTo<NnsGovernanceDuration?, Map>(
            key: 'proposal_wait_for_quiet_deadline_increase',
            parse:
                (e) => NnsGovernanceDuration.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      proposalInitialVotingPeriod: json.valueTo<NnsGovernanceDuration?, Map>(
        key: 'proposal_initial_voting_period',
        parse:
            (e) => NnsGovernanceDuration.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      proposalRejectionFee: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'proposal_rejection_fee',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      votingRewardParameters: json
          .valueTo<NnsGovernanceVotingRewardParameters?, Map>(
            key: 'voting_reward_parameters',
            parse:
                (e) => NnsGovernanceVotingRewardParameters.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      customProposalCriticality: json
          .valueTo<NnsGovernanceCustomProposalCriticality?, Map>(
            key: 'custom_proposal_criticality',
            parse:
                (e) => NnsGovernanceCustomProposalCriticality.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceGovernanceParameters.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGovernanceParameters.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `IdealMatchedParticipationFunction`.
final class NnsGovernanceIdealMatchedParticipationFunction
    with CandidSerializable {
  final String? serializedRepresentation;

  const NnsGovernanceIdealMatchedParticipationFunction({
    this.serializedRepresentation,
  });

  static CType get ctype => CType.record([
    Field(Label.named('serialized_representation'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'serialized_representation': serializedRepresentation,
  };

  Map<String, dynamic> toJson() => {
    'serialized_representation': serializedRepresentation,
  };

  factory NnsGovernanceIdealMatchedParticipationFunction.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceIdealMatchedParticipationFunction(
      serializedRepresentation: json.valueAsString<String?>(
        'serialized_representation',
      ),
    );
  }

  factory NnsGovernanceIdealMatchedParticipationFunction.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceIdealMatchedParticipationFunction.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Image`.
final class NnsGovernanceImage with CandidSerializable {
  final String? base64Encoding;

  const NnsGovernanceImage({this.base64Encoding});

  static CType get ctype => CType.record([
    Field(Label.named('base64_encoding'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'base64_encoding': base64Encoding};

  Map<String, dynamic> toJson() => {'base64_encoding': base64Encoding};

  factory NnsGovernanceImage.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceImage(
      base64Encoding: json.valueAsString<String?>('base64_encoding'),
    );
  }

  factory NnsGovernanceImage.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceImage.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `IncreaseDissolveDelay`.
final class NnsGovernanceIncreaseDissolveDelay with CandidSerializable {
  final int additionalDissolveDelaySeconds;

  const NnsGovernanceIncreaseDissolveDelay({
    required this.additionalDissolveDelaySeconds,
  });

  static CType get ctype => CType.record([
    Field(Label.named('additional_dissolve_delay_seconds'), CType.nat32),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'additional_dissolve_delay_seconds': additionalDissolveDelaySeconds,
  };

  Map<String, dynamic> toJson() => {
    'additional_dissolve_delay_seconds': additionalDissolveDelaySeconds,
  };

  factory NnsGovernanceIncreaseDissolveDelay.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceIncreaseDissolveDelay(
      additionalDissolveDelaySeconds: json.valueAsInt<int>(
        'additional_dissolve_delay_seconds',
      ),
    );
  }

  factory NnsGovernanceIncreaseDissolveDelay.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceIncreaseDissolveDelay.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `InitialTokenDistribution`.
final class NnsGovernanceInitialTokenDistribution with CandidSerializable {
  final NnsGovernanceSwapDistribution? treasuryDistribution;
  final NnsGovernanceDeveloperDistribution? developerDistribution;
  final NnsGovernanceSwapDistribution? swapDistribution;

  const NnsGovernanceInitialTokenDistribution({
    this.treasuryDistribution,
    this.developerDistribution,
    this.swapDistribution,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('treasury_distribution'),
      () => CType.opt(NnsGovernanceSwapDistribution.ctype),
    ),
    LazyField(
      Label.named('developer_distribution'),
      () => CType.opt(NnsGovernanceDeveloperDistribution.ctype),
    ),
    LazyField(
      Label.named('swap_distribution'),
      () => CType.opt(NnsGovernanceSwapDistribution.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'treasury_distribution': treasuryDistribution?.candidValue,
    'developer_distribution': developerDistribution?.candidValue,
    'swap_distribution': swapDistribution?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'treasury_distribution': treasuryDistribution?.toJson(),
    'developer_distribution': developerDistribution?.toJson(),
    'swap_distribution': swapDistribution?.toJson(),
  };

  factory NnsGovernanceInitialTokenDistribution.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceInitialTokenDistribution(
      treasuryDistribution: json.valueTo<NnsGovernanceSwapDistribution?, Map>(
        key: 'treasury_distribution',
        parse:
            (e) => NnsGovernanceSwapDistribution.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      developerDistribution: json
          .valueTo<NnsGovernanceDeveloperDistribution?, Map>(
            key: 'developer_distribution',
            parse:
                (e) => NnsGovernanceDeveloperDistribution.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      swapDistribution: json.valueTo<NnsGovernanceSwapDistribution?, Map>(
        key: 'swap_distribution',
        parse:
            (e) => NnsGovernanceSwapDistribution.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceInitialTokenDistribution.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceInitialTokenDistribution.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `InstallCode`.
final class NnsGovernanceInstallCode with CandidSerializable {
  final bool? skipStoppingBeforeInstalling;
  final List<int>? wasmModuleHash;
  final IcpPrincipalAddress? canisterId;
  final List<int>? argHash;
  final int? installMode;
  final NnsGovernanceCanisterUpgradeOptions? canisterUpgradeOptions;

  const NnsGovernanceInstallCode({
    this.skipStoppingBeforeInstalling,
    this.wasmModuleHash,
    this.canisterId,
    this.argHash,
    this.installMode,
    this.canisterUpgradeOptions,
  });

  static CType get ctype => CType.record([
    Field(
      Label.named('skip_stopping_before_installing'),
      CType.opt(CType.bool_),
    ),
    Field(Label.named('wasm_module_hash'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
    Field(Label.named('arg_hash'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('install_mode'), CType.opt(CType.int32)),
    LazyField(
      Label.named('canister_upgrade_options'),
      () => CType.opt(NnsGovernanceCanisterUpgradeOptions.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'skip_stopping_before_installing': skipStoppingBeforeInstalling,
    'wasm_module_hash': wasmModuleHash,
    'canister_id': canisterId,
    'arg_hash': argHash,
    'install_mode': installMode,
    'canister_upgrade_options': canisterUpgradeOptions?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'skip_stopping_before_installing': skipStoppingBeforeInstalling,
    'wasm_module_hash': wasmModuleHash,
    'canister_id': canisterId?.address,
    'arg_hash': argHash,
    'install_mode': installMode,
    'canister_upgrade_options': canisterUpgradeOptions?.toJson(),
  };

  factory NnsGovernanceInstallCode.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceInstallCode(
      skipStoppingBeforeInstalling: json.valueAsBool<bool?>(
        'skip_stopping_before_installing',
      ),
      wasmModuleHash: json.valueAsBytes<List<int>?>(
        'wasm_module_hash',
        encoding: StringEncoding.base64,
      ),
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      argHash: json.valueAsBytes<List<int>?>(
        'arg_hash',
        encoding: StringEncoding.base64,
      ),
      installMode: json.valueAsInt<int?>('install_mode'),
      canisterUpgradeOptions: json
          .valueTo<NnsGovernanceCanisterUpgradeOptions?, Map>(
            key: 'canister_upgrade_options',
            parse:
                (e) => NnsGovernanceCanisterUpgradeOptions.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceInstallCode.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceInstallCode.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `InstallCodeRequest`.
final class NnsGovernanceInstallCodeRequest with CandidSerializable {
  final List<int>? arg;
  final List<int>? wasmModule;
  final bool? skipStoppingBeforeInstalling;
  final IcpPrincipalAddress? canisterId;
  final int? installMode;
  final NnsGovernanceCanisterUpgradeOptions? canisterUpgradeOptions;

  const NnsGovernanceInstallCodeRequest({
    this.arg,
    this.wasmModule,
    this.skipStoppingBeforeInstalling,
    this.canisterId,
    this.installMode,
    this.canisterUpgradeOptions,
  });

  static CType get ctype => CType.record([
    Field(Label.named('arg'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('wasm_module'), CType.opt(CType.vec(CType.nat8))),
    Field(
      Label.named('skip_stopping_before_installing'),
      CType.opt(CType.bool_),
    ),
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
    Field(Label.named('install_mode'), CType.opt(CType.int32)),
    LazyField(
      Label.named('canister_upgrade_options'),
      () => CType.opt(NnsGovernanceCanisterUpgradeOptions.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'arg': arg,
    'wasm_module': wasmModule,
    'skip_stopping_before_installing': skipStoppingBeforeInstalling,
    'canister_id': canisterId,
    'install_mode': installMode,
    'canister_upgrade_options': canisterUpgradeOptions?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'arg': arg,
    'wasm_module': wasmModule,
    'skip_stopping_before_installing': skipStoppingBeforeInstalling,
    'canister_id': canisterId?.address,
    'install_mode': installMode,
    'canister_upgrade_options': canisterUpgradeOptions?.toJson(),
  };

  factory NnsGovernanceInstallCodeRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceInstallCodeRequest(
      arg: json.valueAsBytes<List<int>?>(
        'arg',
        encoding: StringEncoding.base64,
      ),
      wasmModule: json.valueAsBytes<List<int>?>(
        'wasm_module',
        encoding: StringEncoding.base64,
      ),
      skipStoppingBeforeInstalling: json.valueAsBool<bool?>(
        'skip_stopping_before_installing',
      ),
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      installMode: json.valueAsInt<int?>('install_mode'),
      canisterUpgradeOptions: json
          .valueTo<NnsGovernanceCanisterUpgradeOptions?, Map>(
            key: 'canister_upgrade_options',
            parse:
                (e) => NnsGovernanceCanisterUpgradeOptions.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceInstallCodeRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceInstallCodeRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `KnownNeuron`.
final class NnsGovernanceKnownNeuron with CandidSerializable {
  final NnsGovernanceNeuronId? id;
  final NnsGovernanceKnownNeuronData? knownNeuronData;

  const NnsGovernanceKnownNeuron({this.id, this.knownNeuronData});

  static CType get ctype => CType.record([
    LazyField(Label.named('id'), () => CType.opt(NnsGovernanceNeuronId.ctype)),
    LazyField(
      Label.named('known_neuron_data'),
      () => CType.opt(NnsGovernanceKnownNeuronData.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'id': id?.candidValue,
    'known_neuron_data': knownNeuronData?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'id': id?.toJson(),
    'known_neuron_data': knownNeuronData?.toJson(),
  };

  factory NnsGovernanceKnownNeuron.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceKnownNeuron(
      id: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      knownNeuronData: json.valueTo<NnsGovernanceKnownNeuronData?, Map>(
        key: 'known_neuron_data',
        parse:
            (e) => NnsGovernanceKnownNeuronData.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceKnownNeuron.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceKnownNeuron.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DeregisterKnownNeuron`.
final class NnsGovernanceDeregisterKnownNeuron with CandidSerializable {
  final NnsGovernanceNeuronId? id;

  const NnsGovernanceDeregisterKnownNeuron({this.id});

  static CType get ctype => CType.record([
    LazyField(Label.named('id'), () => CType.opt(NnsGovernanceNeuronId.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'id': id?.candidValue};

  Map<String, dynamic> toJson() => {'id': id?.toJson()};

  factory NnsGovernanceDeregisterKnownNeuron.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceDeregisterKnownNeuron(
      id: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceDeregisterKnownNeuron.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDeregisterKnownNeuron.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `KnownNeuronData`.
final class NnsGovernanceKnownNeuronData with CandidSerializable {
  final String name;
  final String? description;
  final List<String>? links;
  final List<NnsGovernanceTopicToFollow?>? committedTopics;

  const NnsGovernanceKnownNeuronData({
    required this.name,
    this.description,
    this.links,
    this.committedTopics,
  });

  static CType get ctype => CType.record([
    Field(Label.named('name'), CType.text),
    Field(Label.named('description'), CType.opt(CType.text)),
    Field(Label.named('links'), CType.opt(CType.vec(CType.text))),
    LazyField(
      Label.named('committed_topics'),
      () => CType.opt(CType.vec(CType.opt(NnsGovernanceTopicToFollow.ctype))),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'name': name,
    'description': description,
    'links': links,
    'committed_topics': committedTopics?.map((el) => el?.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'links': links,
    'committed_topics': committedTopics?.map((el) => el?.toJson()).toList(),
  };

  factory NnsGovernanceKnownNeuronData.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceKnownNeuronData(
      name: json.valueAsString<String>('name'),
      description: json.valueAsString<String?>('description'),
      links: json.valueTo<List<String>?, List>(
        key: 'links',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
      committedTopics: json.valueTo<List<NnsGovernanceTopicToFollow?>?, List>(
        key: 'committed_topics',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceTopicToFollow?>(
                      (x) =>
                          x == null
                              ? null
                              : NnsGovernanceTopicToFollow.fromCandid(
                                JsonParser.valueEnsureAsMap<String, dynamic>(x),
                              ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceKnownNeuronData.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceKnownNeuronData.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `LedgerParameters`.
final class NnsGovernanceLedgerParameters with CandidSerializable {
  final NnsGovernanceTokens? transactionFee;
  final String? tokenSymbol;
  final NnsGovernanceImage? tokenLogo;
  final String? tokenName;

  const NnsGovernanceLedgerParameters({
    this.transactionFee,
    this.tokenSymbol,
    this.tokenLogo,
    this.tokenName,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('transaction_fee'),
      () => CType.opt(NnsGovernanceTokens.ctype),
    ),
    Field(Label.named('token_symbol'), CType.opt(CType.text)),
    LazyField(
      Label.named('token_logo'),
      () => CType.opt(NnsGovernanceImage.ctype),
    ),
    Field(Label.named('token_name'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'transaction_fee': transactionFee?.candidValue,
    'token_symbol': tokenSymbol,
    'token_logo': tokenLogo?.candidValue,
    'token_name': tokenName,
  };

  Map<String, dynamic> toJson() => {
    'transaction_fee': transactionFee?.toJson(),
    'token_symbol': tokenSymbol,
    'token_logo': tokenLogo?.toJson(),
    'token_name': tokenName,
  };

  factory NnsGovernanceLedgerParameters.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceLedgerParameters(
      transactionFee: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'transaction_fee',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      tokenSymbol: json.valueAsString<String?>('token_symbol'),
      tokenLogo: json.valueTo<NnsGovernanceImage?, Map>(
        key: 'token_logo',
        parse:
            (e) => NnsGovernanceImage.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      tokenName: json.valueAsString<String?>('token_name'),
    );
  }

  factory NnsGovernanceLedgerParameters.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceLedgerParameters.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListKnownNeuronsResponse`.
final class NnsGovernanceListKnownNeuronsResponse with CandidSerializable {
  final List<NnsGovernanceKnownNeuron> knownNeurons;

  const NnsGovernanceListKnownNeuronsResponse({required this.knownNeurons});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('known_neurons'),
      () => CType.vec(NnsGovernanceKnownNeuron.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'known_neurons': knownNeurons.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'known_neurons': knownNeurons.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceListKnownNeuronsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceListKnownNeuronsResponse(
      knownNeurons: json.valueTo<List<NnsGovernanceKnownNeuron>, List>(
        key: 'known_neurons',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceKnownNeuron>(
                      (x) => NnsGovernanceKnownNeuron.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceListKnownNeuronsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListKnownNeuronsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `LoadCanisterSnapshot`.
final class NnsGovernanceLoadCanisterSnapshot with CandidSerializable {
  final IcpPrincipalAddress? canisterId;
  final List<int>? snapshotId;

  const NnsGovernanceLoadCanisterSnapshot({this.canisterId, this.snapshotId});

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
    Field(Label.named('snapshot_id'), CType.opt(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'snapshot_id': snapshotId,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId?.address,
    'snapshot_id': snapshotId,
  };

  factory NnsGovernanceLoadCanisterSnapshot.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceLoadCanisterSnapshot(
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      snapshotId: json.valueAsBytes<List<int>?>(
        'snapshot_id',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsGovernanceLoadCanisterSnapshot.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceLoadCanisterSnapshot.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListNeurons`.
final class NnsGovernanceListNeurons with CandidSerializable {
  final List<BigInt> neuronIds;
  final bool includeNeuronsReadableByCaller;
  final bool? includeEmptyNeuronsReadableByCaller;
  final bool? includePublicNeuronsInFullNeurons;
  final BigInt? pageNumber;
  final BigInt? pageSize;
  final List<NnsGovernanceNeuronSubaccount>? neuronSubaccounts;

  const NnsGovernanceListNeurons({
    required this.neuronIds,
    required this.includeNeuronsReadableByCaller,
    this.includeEmptyNeuronsReadableByCaller,
    this.includePublicNeuronsInFullNeurons,
    this.pageNumber,
    this.pageSize,
    this.neuronSubaccounts,
  });

  static CType get ctype => CType.record([
    Field(Label.named('neuron_ids'), CType.vec(CType.nat64)),
    Field(Label.named('include_neurons_readable_by_caller'), CType.bool_),
    Field(
      Label.named('include_empty_neurons_readable_by_caller'),
      CType.opt(CType.bool_),
    ),
    Field(
      Label.named('include_public_neurons_in_full_neurons'),
      CType.opt(CType.bool_),
    ),
    Field(Label.named('page_number'), CType.opt(CType.nat64)),
    Field(Label.named('page_size'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('neuron_subaccounts'),
      () => CType.opt(CType.vec(NnsGovernanceNeuronSubaccount.ctype)),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'neuron_ids': neuronIds,
    'include_neurons_readable_by_caller': includeNeuronsReadableByCaller,
    'include_empty_neurons_readable_by_caller':
        includeEmptyNeuronsReadableByCaller,
    'include_public_neurons_in_full_neurons': includePublicNeuronsInFullNeurons,
    'page_number': pageNumber,
    'page_size': pageSize,
    'neuron_subaccounts':
        neuronSubaccounts?.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'neuron_ids': neuronIds,
    'include_neurons_readable_by_caller': includeNeuronsReadableByCaller,
    'include_empty_neurons_readable_by_caller':
        includeEmptyNeuronsReadableByCaller,
    'include_public_neurons_in_full_neurons': includePublicNeuronsInFullNeurons,
    'page_number': pageNumber,
    'page_size': pageSize,
    'neuron_subaccounts': neuronSubaccounts?.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceListNeurons.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceListNeurons(
      neuronIds: json.valueTo<List<BigInt>, List>(
        key: 'neuron_ids',
        parse:
            (e) =>
                e
                    .map<BigInt>((x) => JsonParser.valueAsBigInt<BigInt>(x))
                    .toList(),
      ),
      includeNeuronsReadableByCaller: json.valueAsBool<bool>(
        'include_neurons_readable_by_caller',
      ),
      includeEmptyNeuronsReadableByCaller: json.valueAsBool<bool?>(
        'include_empty_neurons_readable_by_caller',
      ),
      includePublicNeuronsInFullNeurons: json.valueAsBool<bool?>(
        'include_public_neurons_in_full_neurons',
      ),
      pageNumber: json.valueAsBigInt<BigInt?>('page_number'),
      pageSize: json.valueAsBigInt<BigInt?>('page_size'),
      neuronSubaccounts: json
          .valueTo<List<NnsGovernanceNeuronSubaccount>?, List>(
            key: 'neuron_subaccounts',
            parse:
                (e) =>
                    e
                        .map<NnsGovernanceNeuronSubaccount>(
                          (x) => NnsGovernanceNeuronSubaccount.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsGovernanceListNeurons.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListNeurons.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronSubaccount`.
final class NnsGovernanceNeuronSubaccount with CandidSerializable {
  final List<int> subaccount;

  const NnsGovernanceNeuronSubaccount({required this.subaccount});

  static CType get ctype =>
      CType.record([Field(Label.named('subaccount'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'subaccount': subaccount};

  Map<String, dynamic> toJson() => {'subaccount': subaccount};

  factory NnsGovernanceNeuronSubaccount.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceNeuronSubaccount(
      subaccount: json.valueAsBytes<List<int>>(
        'subaccount',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsGovernanceNeuronSubaccount.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronSubaccount.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListNeuronsResponse`.
final class NnsGovernanceListNeuronsResponse with CandidSerializable {
  final List<NnsGovernanceListNeuronsResponseNeuronInfos> neuronInfos;
  final List<NnsGovernanceNeuron> fullNeurons;
  final BigInt? totalPagesAvailable;

  const NnsGovernanceListNeuronsResponse({
    required this.neuronInfos,
    required this.fullNeurons,
    this.totalPagesAvailable,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('neuron_infos'),
      () => CType.vec(NnsGovernanceListNeuronsResponseNeuronInfos.ctype),
    ),
    LazyField(
      Label.named('full_neurons'),
      () => CType.vec(NnsGovernanceNeuron.ctype),
    ),
    Field(Label.named('total_pages_available'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'neuron_infos': neuronInfos.map((el) => el.candidValue).toList(),
    'full_neurons': fullNeurons.map((el) => el.candidValue).toList(),
    'total_pages_available': totalPagesAvailable,
  };

  Map<String, dynamic> toJson() => {
    'neuron_infos': neuronInfos.map((el) => el.toJson()).toList(),
    'full_neurons': fullNeurons.map((el) => el.toJson()).toList(),
    'total_pages_available': totalPagesAvailable,
  };

  factory NnsGovernanceListNeuronsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceListNeuronsResponse(
      neuronInfos: json.valueTo<
        List<NnsGovernanceListNeuronsResponseNeuronInfos>,
        List
      >(
        key: 'neuron_infos',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceListNeuronsResponseNeuronInfos>(
                      (x) =>
                          NnsGovernanceListNeuronsResponseNeuronInfos.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      fullNeurons: json.valueTo<List<NnsGovernanceNeuron>, List>(
        key: 'full_neurons',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceNeuron>(
                      (x) => NnsGovernanceNeuron.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      totalPagesAvailable: json.valueAsBigInt<BigInt?>('total_pages_available'),
    );
  }

  factory NnsGovernanceListNeuronsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListNeuronsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListNodeProviderRewardsRequest`.
final class NnsGovernanceListNodeProviderRewardsRequest
    with CandidSerializable {
  final NnsGovernanceDateRangeFilter? dateFilter;

  const NnsGovernanceListNodeProviderRewardsRequest({this.dateFilter});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('date_filter'),
      () => CType.opt(NnsGovernanceDateRangeFilter.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'date_filter': dateFilter?.candidValue};

  Map<String, dynamic> toJson() => {'date_filter': dateFilter?.toJson()};

  factory NnsGovernanceListNodeProviderRewardsRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceListNodeProviderRewardsRequest(
      dateFilter: json.valueTo<NnsGovernanceDateRangeFilter?, Map>(
        key: 'date_filter',
        parse:
            (e) => NnsGovernanceDateRangeFilter.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceListNodeProviderRewardsRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListNodeProviderRewardsRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListNodeProviderRewardsResponse`.
final class NnsGovernanceListNodeProviderRewardsResponse
    with CandidSerializable {
  final List<NnsGovernanceMonthlyNodeProviderRewards> rewards;

  const NnsGovernanceListNodeProviderRewardsResponse({required this.rewards});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('rewards'),
      () => CType.vec(NnsGovernanceMonthlyNodeProviderRewards.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'rewards': rewards.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'rewards': rewards.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceListNodeProviderRewardsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceListNodeProviderRewardsResponse(
      rewards: json.valueTo<
        List<NnsGovernanceMonthlyNodeProviderRewards>,
        List
      >(
        key: 'rewards',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceMonthlyNodeProviderRewards>(
                      (x) => NnsGovernanceMonthlyNodeProviderRewards.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceListNodeProviderRewardsResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListNodeProviderRewardsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListNodeProvidersResponse`.
final class NnsGovernanceListNodeProvidersResponse with CandidSerializable {
  final List<NnsGovernanceNodeProvider> nodeProviders;

  const NnsGovernanceListNodeProvidersResponse({required this.nodeProviders});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('node_providers'),
      () => CType.vec(NnsGovernanceNodeProvider.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'node_providers': nodeProviders.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'node_providers': nodeProviders.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceListNodeProvidersResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceListNodeProvidersResponse(
      nodeProviders: json.valueTo<List<NnsGovernanceNodeProvider>, List>(
        key: 'node_providers',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceNodeProvider>(
                      (x) => NnsGovernanceNodeProvider.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceListNodeProvidersResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListNodeProvidersResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListProposalInfoRequest`.
final class NnsGovernanceListProposalInfoRequest with CandidSerializable {
  final List<int> includeRewardStatus;
  final bool? omitLargeFields;
  final NnsGovernanceProposalId? beforeProposal;
  final int limit;
  final List<int> excludeTopic;
  final bool? includeAllManageNeuronProposals;
  final List<int> includeStatus;
  final bool? returnSelfDescribingAction;

  const NnsGovernanceListProposalInfoRequest({
    required this.includeRewardStatus,
    this.omitLargeFields,
    this.beforeProposal,
    required this.limit,
    required this.excludeTopic,
    this.includeAllManageNeuronProposals,
    required this.includeStatus,
    this.returnSelfDescribingAction,
  });

  static CType get ctype => CType.record([
    Field(Label.named('include_reward_status'), CType.vec(CType.int32)),
    Field(Label.named('omit_large_fields'), CType.opt(CType.bool_)),
    LazyField(
      Label.named('before_proposal'),
      () => CType.opt(NnsGovernanceProposalId.ctype),
    ),
    Field(Label.named('limit'), CType.nat32),
    Field(Label.named('exclude_topic'), CType.vec(CType.int32)),
    Field(
      Label.named('include_all_manage_neuron_proposals'),
      CType.opt(CType.bool_),
    ),
    Field(Label.named('include_status'), CType.vec(CType.int32)),
    Field(Label.named('return_self_describing_action'), CType.opt(CType.bool_)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'include_reward_status': includeRewardStatus,
    'omit_large_fields': omitLargeFields,
    'before_proposal': beforeProposal?.candidValue,
    'limit': limit,
    'exclude_topic': excludeTopic,
    'include_all_manage_neuron_proposals': includeAllManageNeuronProposals,
    'include_status': includeStatus,
    'return_self_describing_action': returnSelfDescribingAction,
  };

  Map<String, dynamic> toJson() => {
    'include_reward_status': includeRewardStatus,
    'omit_large_fields': omitLargeFields,
    'before_proposal': beforeProposal?.toJson(),
    'limit': limit,
    'exclude_topic': excludeTopic,
    'include_all_manage_neuron_proposals': includeAllManageNeuronProposals,
    'include_status': includeStatus,
    'return_self_describing_action': returnSelfDescribingAction,
  };

  factory NnsGovernanceListProposalInfoRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceListProposalInfoRequest(
      includeRewardStatus: json.valueTo<List<int>, List>(
        key: 'include_reward_status',
        parse: (e) => e.map<int>((x) => JsonParser.valueAsInt<int>(x)).toList(),
      ),
      omitLargeFields: json.valueAsBool<bool?>('omit_large_fields'),
      beforeProposal: json.valueTo<NnsGovernanceProposalId?, Map>(
        key: 'before_proposal',
        parse:
            (e) => NnsGovernanceProposalId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      limit: json.valueAsInt<int>('limit'),
      excludeTopic: json.valueTo<List<int>, List>(
        key: 'exclude_topic',
        parse: (e) => e.map<int>((x) => JsonParser.valueAsInt<int>(x)).toList(),
      ),
      includeAllManageNeuronProposals: json.valueAsBool<bool?>(
        'include_all_manage_neuron_proposals',
      ),
      includeStatus: json.valueTo<List<int>, List>(
        key: 'include_status',
        parse: (e) => e.map<int>((x) => JsonParser.valueAsInt<int>(x)).toList(),
      ),
      returnSelfDescribingAction: json.valueAsBool<bool?>(
        'return_self_describing_action',
      ),
    );
  }

  factory NnsGovernanceListProposalInfoRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListProposalInfoRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListProposalInfoResponse`.
final class NnsGovernanceListProposalInfoResponse with CandidSerializable {
  final List<NnsGovernanceProposalInfo> proposalInfo;

  const NnsGovernanceListProposalInfoResponse({required this.proposalInfo});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('proposal_info'),
      () => CType.vec(NnsGovernanceProposalInfo.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'proposal_info': proposalInfo.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'proposal_info': proposalInfo.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceListProposalInfoResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceListProposalInfoResponse(
      proposalInfo: json.valueTo<List<NnsGovernanceProposalInfo>, List>(
        key: 'proposal_info',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceProposalInfo>(
                      (x) => NnsGovernanceProposalInfo.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceListProposalInfoResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListProposalInfoResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `MakeProposalRequest`.
final class NnsGovernanceMakeProposalRequest with CandidSerializable {
  final String url;
  final String? title;
  final NnsGovernanceProposalActionRequest? action;
  final String summary;

  const NnsGovernanceMakeProposalRequest({
    required this.url,
    this.title,
    this.action,
    required this.summary,
  });

  static CType get ctype => CType.record([
    Field(Label.named('url'), CType.text),
    Field(Label.named('title'), CType.opt(CType.text)),
    LazyField(
      Label.named('action'),
      () => CType.opt(NnsGovernanceProposalActionRequest.ctype),
    ),
    Field(Label.named('summary'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'url': url,
    'title': title,
    'action': action?.candidValue,
    'summary': summary,
  };

  Map<String, dynamic> toJson() => {
    'url': url,
    'title': title,
    'action': action?.toJson(),
    'summary': summary,
  };

  factory NnsGovernanceMakeProposalRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceMakeProposalRequest(
      url: json.valueAsString<String>('url'),
      title: json.valueAsString<String?>('title'),
      action: json.valueTo<NnsGovernanceProposalActionRequest?, Map>(
        key: 'action',
        parse:
            (e) => NnsGovernanceProposalActionRequest.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      summary: json.valueAsString<String>('summary'),
    );
  }

  factory NnsGovernanceMakeProposalRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceMakeProposalRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `MakeProposalResponse`.
final class NnsGovernanceMakeProposalResponse with CandidSerializable {
  final String? message;
  final NnsGovernanceProposalId? proposalId;

  const NnsGovernanceMakeProposalResponse({this.message, this.proposalId});

  static CType get ctype => CType.record([
    Field(Label.named('message'), CType.opt(CType.text)),
    LazyField(
      Label.named('proposal_id'),
      () => CType.opt(NnsGovernanceProposalId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'message': message,
    'proposal_id': proposalId?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'message': message,
    'proposal_id': proposalId?.toJson(),
  };

  factory NnsGovernanceMakeProposalResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceMakeProposalResponse(
      message: json.valueAsString<String?>('message'),
      proposalId: json.valueTo<NnsGovernanceProposalId?, Map>(
        key: 'proposal_id',
        parse:
            (e) => NnsGovernanceProposalId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceMakeProposalResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceMakeProposalResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ManageNeuronProposal`.
final class NnsGovernanceManageNeuronProposal with CandidSerializable {
  final NnsGovernanceNeuronId? id;
  final NnsGovernanceManageNeuronProposalCommand? command;
  final NnsGovernanceNeuronIdOrSubaccount? neuronIdOrSubaccount;

  const NnsGovernanceManageNeuronProposal({
    this.id,
    this.command,
    this.neuronIdOrSubaccount,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('id'), () => CType.opt(NnsGovernanceNeuronId.ctype)),
    LazyField(
      Label.named('command'),
      () => CType.opt(NnsGovernanceManageNeuronProposalCommand.ctype),
    ),
    LazyField(
      Label.named('neuron_id_or_subaccount'),
      () => CType.opt(NnsGovernanceNeuronIdOrSubaccount.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'id': id?.candidValue,
    'command': command?.candidValue,
    'neuron_id_or_subaccount': neuronIdOrSubaccount?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'id': id?.toJson(),
    'command': command?.toJson(),
    'neuron_id_or_subaccount': neuronIdOrSubaccount?.toJson(),
  };

  factory NnsGovernanceManageNeuronProposal.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceManageNeuronProposal(
      id: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      command: json.valueTo<NnsGovernanceManageNeuronProposalCommand?, Map>(
        key: 'command',
        parse:
            (e) => NnsGovernanceManageNeuronProposalCommand.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      neuronIdOrSubaccount: json
          .valueTo<NnsGovernanceNeuronIdOrSubaccount?, Map>(
            key: 'neuron_id_or_subaccount',
            parse:
                (e) => NnsGovernanceNeuronIdOrSubaccount.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceManageNeuronProposal.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceManageNeuronProposal.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ManageNeuronCommandRequest`.
sealed class NnsGovernanceManageNeuronCommandRequest with CandidSerializable {
  const NnsGovernanceManageNeuronCommandRequest();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Spawn'), () => NnsGovernanceSpawn.ctype),
    LazyField(Label.named('Split'), () => NnsGovernanceSplit.ctype),
    LazyField(Label.named('Follow'), () => NnsGovernanceFollow.ctype),
    LazyField(
      Label.named('ClaimOrRefresh'),
      () => NnsGovernanceClaimOrRefresh.ctype,
    ),
    LazyField(Label.named('Configure'), () => NnsGovernanceConfigure.ctype),
    LazyField(
      Label.named('RegisterVote'),
      () => NnsGovernanceRegisterVote.ctype,
    ),
    LazyField(Label.named('Merge'), () => NnsGovernanceMerge.ctype),
    LazyField(
      Label.named('DisburseToNeuron'),
      () => NnsGovernanceDisburseToNeuron.ctype,
    ),
    LazyField(
      Label.named('MakeProposal'),
      () => NnsGovernanceMakeProposalRequest.ctype,
    ),
    LazyField(
      Label.named('StakeMaturity'),
      () => NnsGovernanceStakeMaturity.ctype,
    ),
    LazyField(
      Label.named('MergeMaturity'),
      () => NnsGovernanceMergeMaturity.ctype,
    ),
    LazyField(Label.named('Disburse'), () => NnsGovernanceDisburse.ctype),
    LazyField(
      Label.named('RefreshVotingPower'),
      () => NnsGovernanceRefreshVotingPower.ctype,
    ),
    LazyField(
      Label.named('DisburseMaturity'),
      () => NnsGovernanceDisburseMaturity.ctype,
    ),
    LazyField(
      Label.named('SetFollowing'),
      () => NnsGovernanceSetFollowing.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceManageNeuronCommandRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Spawn')) {
      return NnsGovernanceManageNeuronCommandRequestSpawn(
        json.valueTo<NnsGovernanceSpawn, Map>(
          key: 'Spawn',
          parse:
              (e) => NnsGovernanceSpawn.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Split')) {
      return NnsGovernanceManageNeuronCommandRequestSplit(
        json.valueTo<NnsGovernanceSplit, Map>(
          key: 'Split',
          parse:
              (e) => NnsGovernanceSplit.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Follow')) {
      return NnsGovernanceManageNeuronCommandRequestFollow(
        json.valueTo<NnsGovernanceFollow, Map>(
          key: 'Follow',
          parse:
              (e) => NnsGovernanceFollow.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ClaimOrRefresh')) {
      return NnsGovernanceManageNeuronCommandRequestClaimOrRefresh(
        json.valueTo<NnsGovernanceClaimOrRefresh, Map>(
          key: 'ClaimOrRefresh',
          parse:
              (e) => NnsGovernanceClaimOrRefresh.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Configure')) {
      return NnsGovernanceManageNeuronCommandRequestConfigure(
        json.valueTo<NnsGovernanceConfigure, Map>(
          key: 'Configure',
          parse:
              (e) => NnsGovernanceConfigure.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('RegisterVote')) {
      return NnsGovernanceManageNeuronCommandRequestRegisterVote(
        json.valueTo<NnsGovernanceRegisterVote, Map>(
          key: 'RegisterVote',
          parse:
              (e) => NnsGovernanceRegisterVote.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Merge')) {
      return NnsGovernanceManageNeuronCommandRequestMerge(
        json.valueTo<NnsGovernanceMerge, Map>(
          key: 'Merge',
          parse:
              (e) => NnsGovernanceMerge.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DisburseToNeuron')) {
      return NnsGovernanceManageNeuronCommandRequestDisburseToNeuron(
        json.valueTo<NnsGovernanceDisburseToNeuron, Map>(
          key: 'DisburseToNeuron',
          parse:
              (e) => NnsGovernanceDisburseToNeuron.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('MakeProposal')) {
      return NnsGovernanceManageNeuronCommandRequestMakeProposal(
        json.valueTo<NnsGovernanceMakeProposalRequest, Map>(
          key: 'MakeProposal',
          parse:
              (e) => NnsGovernanceMakeProposalRequest.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('StakeMaturity')) {
      return NnsGovernanceManageNeuronCommandRequestStakeMaturity(
        json.valueTo<NnsGovernanceStakeMaturity, Map>(
          key: 'StakeMaturity',
          parse:
              (e) => NnsGovernanceStakeMaturity.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('MergeMaturity')) {
      return NnsGovernanceManageNeuronCommandRequestMergeMaturity(
        json.valueTo<NnsGovernanceMergeMaturity, Map>(
          key: 'MergeMaturity',
          parse:
              (e) => NnsGovernanceMergeMaturity.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Disburse')) {
      return NnsGovernanceManageNeuronCommandRequestDisburse(
        json.valueTo<NnsGovernanceDisburse, Map>(
          key: 'Disburse',
          parse:
              (e) => NnsGovernanceDisburse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('RefreshVotingPower')) {
      return NnsGovernanceManageNeuronCommandRequestRefreshVotingPower(
        json.valueTo<NnsGovernanceRefreshVotingPower, Map>(
          key: 'RefreshVotingPower',
          parse:
              (e) => NnsGovernanceRefreshVotingPower.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DisburseMaturity')) {
      return NnsGovernanceManageNeuronCommandRequestDisburseMaturity(
        json.valueTo<NnsGovernanceDisburseMaturity, Map>(
          key: 'DisburseMaturity',
          parse:
              (e) => NnsGovernanceDisburseMaturity.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('SetFollowing')) {
      return NnsGovernanceManageNeuronCommandRequestSetFollowing(
        json.valueTo<NnsGovernanceSetFollowing, Map>(
          key: 'SetFollowing',
          parse:
              (e) => NnsGovernanceSetFollowing.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceManageNeuronCommandRequest.fromCandid',
      reason: 'Unknown NnsGovernanceManageNeuronCommandRequest arm',
    );
  }

  factory NnsGovernanceManageNeuronCommandRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceManageNeuronCommandRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ManageNeuronCommandRequest.Spawn`.
final class NnsGovernanceManageNeuronCommandRequestSpawn
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceSpawn value;
  const NnsGovernanceManageNeuronCommandRequestSpawn(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('Spawn', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Spawn': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.Split`.
final class NnsGovernanceManageNeuronCommandRequestSplit
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceSplit value;
  const NnsGovernanceManageNeuronCommandRequestSplit(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('Split', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Split': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.Follow`.
final class NnsGovernanceManageNeuronCommandRequestFollow
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceFollow value;
  const NnsGovernanceManageNeuronCommandRequestFollow(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('Follow', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Follow': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.ClaimOrRefresh`.
final class NnsGovernanceManageNeuronCommandRequestClaimOrRefresh
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceClaimOrRefresh value;
  const NnsGovernanceManageNeuronCommandRequestClaimOrRefresh(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('ClaimOrRefresh', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ClaimOrRefresh': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.Configure`.
final class NnsGovernanceManageNeuronCommandRequestConfigure
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceConfigure value;
  const NnsGovernanceManageNeuronCommandRequestConfigure(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('Configure', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Configure': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.RegisterVote`.
final class NnsGovernanceManageNeuronCommandRequestRegisterVote
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceRegisterVote value;
  const NnsGovernanceManageNeuronCommandRequestRegisterVote(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('RegisterVote', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RegisterVote': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.Merge`.
final class NnsGovernanceManageNeuronCommandRequestMerge
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceMerge value;
  const NnsGovernanceManageNeuronCommandRequestMerge(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('Merge', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Merge': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.DisburseToNeuron`.
final class NnsGovernanceManageNeuronCommandRequestDisburseToNeuron
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceDisburseToNeuron value;
  const NnsGovernanceManageNeuronCommandRequestDisburseToNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('DisburseToNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DisburseToNeuron': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.MakeProposal`.
final class NnsGovernanceManageNeuronCommandRequestMakeProposal
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceMakeProposalRequest value;
  const NnsGovernanceManageNeuronCommandRequestMakeProposal(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('MakeProposal', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'MakeProposal': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.StakeMaturity`.
final class NnsGovernanceManageNeuronCommandRequestStakeMaturity
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceStakeMaturity value;
  const NnsGovernanceManageNeuronCommandRequestStakeMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('StakeMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'StakeMaturity': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.MergeMaturity`.
final class NnsGovernanceManageNeuronCommandRequestMergeMaturity
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceMergeMaturity value;
  const NnsGovernanceManageNeuronCommandRequestMergeMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('MergeMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'MergeMaturity': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.Disburse`.
final class NnsGovernanceManageNeuronCommandRequestDisburse
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceDisburse value;
  const NnsGovernanceManageNeuronCommandRequestDisburse(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('Disburse', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Disburse': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.RefreshVotingPower`.
final class NnsGovernanceManageNeuronCommandRequestRefreshVotingPower
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceRefreshVotingPower value;
  const NnsGovernanceManageNeuronCommandRequestRefreshVotingPower(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('RefreshVotingPower', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RefreshVotingPower': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.DisburseMaturity`.
final class NnsGovernanceManageNeuronCommandRequestDisburseMaturity
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceDisburseMaturity value;
  const NnsGovernanceManageNeuronCommandRequestDisburseMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('DisburseMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DisburseMaturity': value.toJson()};
}

/// Variant arm `ManageNeuronCommandRequest.SetFollowing`.
final class NnsGovernanceManageNeuronCommandRequestSetFollowing
    extends NnsGovernanceManageNeuronCommandRequest {
  final NnsGovernanceSetFollowing value;
  const NnsGovernanceManageNeuronCommandRequestSetFollowing(this.value);

  @override
  CType get candidType => NnsGovernanceManageNeuronCommandRequest.ctype;

  @override
  dynamic get candidValue => Variant('SetFollowing', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'SetFollowing': value.toJson()};
}

/// Candid record `ManageNeuronRequest`.
final class NnsGovernanceManageNeuronRequest with CandidSerializable {
  final NnsGovernanceNeuronIdOrSubaccount? neuronIdOrSubaccount;
  final NnsGovernanceManageNeuronCommandRequest? command;
  final NnsGovernanceNeuronId? id;

  const NnsGovernanceManageNeuronRequest({
    this.neuronIdOrSubaccount,
    this.command,
    this.id,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('neuron_id_or_subaccount'),
      () => CType.opt(NnsGovernanceNeuronIdOrSubaccount.ctype),
    ),
    LazyField(
      Label.named('command'),
      () => CType.opt(NnsGovernanceManageNeuronCommandRequest.ctype),
    ),
    LazyField(Label.named('id'), () => CType.opt(NnsGovernanceNeuronId.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'neuron_id_or_subaccount': neuronIdOrSubaccount?.candidValue,
    'command': command?.candidValue,
    'id': id?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'neuron_id_or_subaccount': neuronIdOrSubaccount?.toJson(),
    'command': command?.toJson(),
    'id': id?.toJson(),
  };

  factory NnsGovernanceManageNeuronRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceManageNeuronRequest(
      neuronIdOrSubaccount: json
          .valueTo<NnsGovernanceNeuronIdOrSubaccount?, Map>(
            key: 'neuron_id_or_subaccount',
            parse:
                (e) => NnsGovernanceNeuronIdOrSubaccount.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      command: json.valueTo<NnsGovernanceManageNeuronCommandRequest?, Map>(
        key: 'command',
        parse:
            (e) => NnsGovernanceManageNeuronCommandRequest.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      id: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceManageNeuronRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceManageNeuronRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ManageNeuronResponse`.
final class NnsGovernanceManageNeuronResponse with CandidSerializable {
  final NnsGovernanceCommand1? command;

  const NnsGovernanceManageNeuronResponse({this.command});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('command'),
      () => CType.opt(NnsGovernanceCommand1.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'command': command?.candidValue};

  Map<String, dynamic> toJson() => {'command': command?.toJson()};

  factory NnsGovernanceManageNeuronResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceManageNeuronResponse(
      command: json.valueTo<NnsGovernanceCommand1?, Map>(
        key: 'command',
        parse:
            (e) => NnsGovernanceCommand1.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceManageNeuronResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceManageNeuronResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Merge`.
final class NnsGovernanceMerge with CandidSerializable {
  final NnsGovernanceNeuronId? sourceNeuronId;

  const NnsGovernanceMerge({this.sourceNeuronId});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('source_neuron_id'),
      () => CType.opt(NnsGovernanceNeuronId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'source_neuron_id': sourceNeuronId?.candidValue};

  Map<String, dynamic> toJson() => {
    'source_neuron_id': sourceNeuronId?.toJson(),
  };

  factory NnsGovernanceMerge.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceMerge(
      sourceNeuronId: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'source_neuron_id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceMerge.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceMerge.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `MergeMaturity`.
final class NnsGovernanceMergeMaturity with CandidSerializable {
  final int percentageToMerge;

  const NnsGovernanceMergeMaturity({required this.percentageToMerge});

  static CType get ctype =>
      CType.record([Field(Label.named('percentage_to_merge'), CType.nat32)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'percentage_to_merge': percentageToMerge};

  Map<String, dynamic> toJson() => {'percentage_to_merge': percentageToMerge};

  factory NnsGovernanceMergeMaturity.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceMergeMaturity(
      percentageToMerge: json.valueAsInt<int>('percentage_to_merge'),
    );
  }

  factory NnsGovernanceMergeMaturity.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceMergeMaturity.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `MergeMaturityResponse`.
final class NnsGovernanceMergeMaturityResponse with CandidSerializable {
  final BigInt mergedMaturityE8s;
  final BigInt newStakeE8s;

  const NnsGovernanceMergeMaturityResponse({
    required this.mergedMaturityE8s,
    required this.newStakeE8s,
  });

  static CType get ctype => CType.record([
    Field(Label.named('merged_maturity_e8s'), CType.nat64),
    Field(Label.named('new_stake_e8s'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'merged_maturity_e8s': mergedMaturityE8s,
    'new_stake_e8s': newStakeE8s,
  };

  Map<String, dynamic> toJson() => {
    'merged_maturity_e8s': mergedMaturityE8s,
    'new_stake_e8s': newStakeE8s,
  };

  factory NnsGovernanceMergeMaturityResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceMergeMaturityResponse(
      mergedMaturityE8s: json.valueAsBigInt<BigInt>('merged_maturity_e8s'),
      newStakeE8s: json.valueAsBigInt<BigInt>('new_stake_e8s'),
    );
  }

  factory NnsGovernanceMergeMaturityResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceMergeMaturityResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `MergeResponse`.
final class NnsGovernanceMergeResponse with CandidSerializable {
  final NnsGovernanceNeuron? targetNeuron;
  final NnsGovernanceNeuron? sourceNeuron;
  final NnsGovernanceNeuronInfo? targetNeuronInfo;
  final NnsGovernanceNeuronInfo? sourceNeuronInfo;

  const NnsGovernanceMergeResponse({
    this.targetNeuron,
    this.sourceNeuron,
    this.targetNeuronInfo,
    this.sourceNeuronInfo,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('target_neuron'),
      () => CType.opt(NnsGovernanceNeuron.ctype),
    ),
    LazyField(
      Label.named('source_neuron'),
      () => CType.opt(NnsGovernanceNeuron.ctype),
    ),
    LazyField(
      Label.named('target_neuron_info'),
      () => CType.opt(NnsGovernanceNeuronInfo.ctype),
    ),
    LazyField(
      Label.named('source_neuron_info'),
      () => CType.opt(NnsGovernanceNeuronInfo.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'target_neuron': targetNeuron?.candidValue,
    'source_neuron': sourceNeuron?.candidValue,
    'target_neuron_info': targetNeuronInfo?.candidValue,
    'source_neuron_info': sourceNeuronInfo?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'target_neuron': targetNeuron?.toJson(),
    'source_neuron': sourceNeuron?.toJson(),
    'target_neuron_info': targetNeuronInfo?.toJson(),
    'source_neuron_info': sourceNeuronInfo?.toJson(),
  };

  factory NnsGovernanceMergeResponse.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceMergeResponse(
      targetNeuron: json.valueTo<NnsGovernanceNeuron?, Map>(
        key: 'target_neuron',
        parse:
            (e) => NnsGovernanceNeuron.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      sourceNeuron: json.valueTo<NnsGovernanceNeuron?, Map>(
        key: 'source_neuron',
        parse:
            (e) => NnsGovernanceNeuron.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      targetNeuronInfo: json.valueTo<NnsGovernanceNeuronInfo?, Map>(
        key: 'target_neuron_info',
        parse:
            (e) => NnsGovernanceNeuronInfo.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      sourceNeuronInfo: json.valueTo<NnsGovernanceNeuronInfo?, Map>(
        key: 'source_neuron_info',
        parse:
            (e) => NnsGovernanceNeuronInfo.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceMergeResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceMergeResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DateUtc`.
final class NnsGovernanceDateUtc with CandidSerializable {
  final int year;
  final int month;
  final int day;

  const NnsGovernanceDateUtc({
    required this.year,
    required this.month,
    required this.day,
  });

  static CType get ctype => CType.record([
    Field(Label.named('year'), CType.nat32),
    Field(Label.named('month'), CType.nat32),
    Field(Label.named('day'), CType.nat32),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'year': year, 'month': month, 'day': day};

  Map<String, dynamic> toJson() => {'year': year, 'month': month, 'day': day};

  factory NnsGovernanceDateUtc.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceDateUtc(
      year: json.valueAsInt<int>('year'),
      month: json.valueAsInt<int>('month'),
      day: json.valueAsInt<int>('day'),
    );
  }

  factory NnsGovernanceDateUtc.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceDateUtc.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `MonthlyNodeProviderRewards`.
final class NnsGovernanceMonthlyNodeProviderRewards with CandidSerializable {
  final BigInt? minimumXdrPermyriadPerIcp;
  final BigInt? registryVersion;
  final int? algorithmVersion;
  final List<NnsGovernanceNodeProvider> nodeProviders;
  final BigInt timestamp;
  final NnsGovernanceDateUtc? startDate;
  final NnsGovernanceDateUtc? endDate;
  final List<NnsGovernanceRewardNodeProvider> rewards;
  final NnsGovernanceXdrConversionRate? xdrConversionRate;
  final BigInt? maximumNodeProviderRewardsE8s;

  const NnsGovernanceMonthlyNodeProviderRewards({
    this.minimumXdrPermyriadPerIcp,
    this.registryVersion,
    this.algorithmVersion,
    required this.nodeProviders,
    required this.timestamp,
    this.startDate,
    this.endDate,
    required this.rewards,
    this.xdrConversionRate,
    this.maximumNodeProviderRewardsE8s,
  });

  static CType get ctype => CType.record([
    Field(Label.named('minimum_xdr_permyriad_per_icp'), CType.opt(CType.nat64)),
    Field(Label.named('registry_version'), CType.opt(CType.nat64)),
    Field(Label.named('algorithm_version'), CType.opt(CType.nat32)),
    LazyField(
      Label.named('node_providers'),
      () => CType.vec(NnsGovernanceNodeProvider.ctype),
    ),
    Field(Label.named('timestamp'), CType.nat64),
    LazyField(
      Label.named('start_date'),
      () => CType.opt(NnsGovernanceDateUtc.ctype),
    ),
    LazyField(
      Label.named('end_date'),
      () => CType.opt(NnsGovernanceDateUtc.ctype),
    ),
    LazyField(
      Label.named('rewards'),
      () => CType.vec(NnsGovernanceRewardNodeProvider.ctype),
    ),
    LazyField(
      Label.named('xdr_conversion_rate'),
      () => CType.opt(NnsGovernanceXdrConversionRate.ctype),
    ),
    Field(
      Label.named('maximum_node_provider_rewards_e8s'),
      CType.opt(CType.nat64),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'minimum_xdr_permyriad_per_icp': minimumXdrPermyriadPerIcp,
    'registry_version': registryVersion,
    'algorithm_version': algorithmVersion,
    'node_providers': nodeProviders.map((el) => el.candidValue).toList(),
    'timestamp': timestamp,
    'start_date': startDate?.candidValue,
    'end_date': endDate?.candidValue,
    'rewards': rewards.map((el) => el.candidValue).toList(),
    'xdr_conversion_rate': xdrConversionRate?.candidValue,
    'maximum_node_provider_rewards_e8s': maximumNodeProviderRewardsE8s,
  };

  Map<String, dynamic> toJson() => {
    'minimum_xdr_permyriad_per_icp': minimumXdrPermyriadPerIcp,
    'registry_version': registryVersion,
    'algorithm_version': algorithmVersion,
    'node_providers': nodeProviders.map((el) => el.toJson()).toList(),
    'timestamp': timestamp,
    'start_date': startDate?.toJson(),
    'end_date': endDate?.toJson(),
    'rewards': rewards.map((el) => el.toJson()).toList(),
    'xdr_conversion_rate': xdrConversionRate?.toJson(),
    'maximum_node_provider_rewards_e8s': maximumNodeProviderRewardsE8s,
  };

  factory NnsGovernanceMonthlyNodeProviderRewards.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceMonthlyNodeProviderRewards(
      minimumXdrPermyriadPerIcp: json.valueAsBigInt<BigInt?>(
        'minimum_xdr_permyriad_per_icp',
      ),
      registryVersion: json.valueAsBigInt<BigInt?>('registry_version'),
      algorithmVersion: json.valueAsInt<int?>('algorithm_version'),
      nodeProviders: json.valueTo<List<NnsGovernanceNodeProvider>, List>(
        key: 'node_providers',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceNodeProvider>(
                      (x) => NnsGovernanceNodeProvider.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      timestamp: json.valueAsBigInt<BigInt>('timestamp'),
      startDate: json.valueTo<NnsGovernanceDateUtc?, Map>(
        key: 'start_date',
        parse:
            (e) => NnsGovernanceDateUtc.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      endDate: json.valueTo<NnsGovernanceDateUtc?, Map>(
        key: 'end_date',
        parse:
            (e) => NnsGovernanceDateUtc.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      rewards: json.valueTo<List<NnsGovernanceRewardNodeProvider>, List>(
        key: 'rewards',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceRewardNodeProvider>(
                      (x) => NnsGovernanceRewardNodeProvider.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      xdrConversionRate: json.valueTo<NnsGovernanceXdrConversionRate?, Map>(
        key: 'xdr_conversion_rate',
        parse:
            (e) => NnsGovernanceXdrConversionRate.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      maximumNodeProviderRewardsE8s: json.valueAsBigInt<BigInt?>(
        'maximum_node_provider_rewards_e8s',
      ),
    );
  }

  factory NnsGovernanceMonthlyNodeProviderRewards.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceMonthlyNodeProviderRewards.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Motion`.
final class NnsGovernanceMotion with CandidSerializable {
  final String motionText;

  const NnsGovernanceMotion({required this.motionText});

  static CType get ctype =>
      CType.record([Field(Label.named('motion_text'), CType.text)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'motion_text': motionText};

  Map<String, dynamic> toJson() => {'motion_text': motionText};

  factory NnsGovernanceMotion.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceMotion(
      motionText: json.valueAsString<String>('motion_text'),
    );
  }

  factory NnsGovernanceMotion.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceMotion.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NetworkEconomics`.
final class NnsGovernanceNetworkEconomics with CandidSerializable {
  final BigInt neuronMinimumStakeE8s;
  final int maxProposalsToKeepPerTopic;
  final BigInt neuronManagementFeePerProposalE8s;
  final BigInt rejectCostE8s;
  final BigInt transactionFeeE8s;
  final BigInt neuronSpawnDissolveDelaySeconds;
  final BigInt minimumIcpXdrRate;
  final BigInt maximumNodeProviderRewardsE8s;
  final NnsGovernanceNeuronsFundEconomics? neuronsFundEconomics;
  final NnsGovernanceVotingPowerEconomics? votingPowerEconomics;

  const NnsGovernanceNetworkEconomics({
    required this.neuronMinimumStakeE8s,
    required this.maxProposalsToKeepPerTopic,
    required this.neuronManagementFeePerProposalE8s,
    required this.rejectCostE8s,
    required this.transactionFeeE8s,
    required this.neuronSpawnDissolveDelaySeconds,
    required this.minimumIcpXdrRate,
    required this.maximumNodeProviderRewardsE8s,
    this.neuronsFundEconomics,
    this.votingPowerEconomics,
  });

  static CType get ctype => CType.record([
    Field(Label.named('neuron_minimum_stake_e8s'), CType.nat64),
    Field(Label.named('max_proposals_to_keep_per_topic'), CType.nat32),
    Field(Label.named('neuron_management_fee_per_proposal_e8s'), CType.nat64),
    Field(Label.named('reject_cost_e8s'), CType.nat64),
    Field(Label.named('transaction_fee_e8s'), CType.nat64),
    Field(Label.named('neuron_spawn_dissolve_delay_seconds'), CType.nat64),
    Field(Label.named('minimum_icp_xdr_rate'), CType.nat64),
    Field(Label.named('maximum_node_provider_rewards_e8s'), CType.nat64),
    LazyField(
      Label.named('neurons_fund_economics'),
      () => CType.opt(NnsGovernanceNeuronsFundEconomics.ctype),
    ),
    LazyField(
      Label.named('voting_power_economics'),
      () => CType.opt(NnsGovernanceVotingPowerEconomics.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'neuron_minimum_stake_e8s': neuronMinimumStakeE8s,
    'max_proposals_to_keep_per_topic': maxProposalsToKeepPerTopic,
    'neuron_management_fee_per_proposal_e8s': neuronManagementFeePerProposalE8s,
    'reject_cost_e8s': rejectCostE8s,
    'transaction_fee_e8s': transactionFeeE8s,
    'neuron_spawn_dissolve_delay_seconds': neuronSpawnDissolveDelaySeconds,
    'minimum_icp_xdr_rate': minimumIcpXdrRate,
    'maximum_node_provider_rewards_e8s': maximumNodeProviderRewardsE8s,
    'neurons_fund_economics': neuronsFundEconomics?.candidValue,
    'voting_power_economics': votingPowerEconomics?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'neuron_minimum_stake_e8s': neuronMinimumStakeE8s,
    'max_proposals_to_keep_per_topic': maxProposalsToKeepPerTopic,
    'neuron_management_fee_per_proposal_e8s': neuronManagementFeePerProposalE8s,
    'reject_cost_e8s': rejectCostE8s,
    'transaction_fee_e8s': transactionFeeE8s,
    'neuron_spawn_dissolve_delay_seconds': neuronSpawnDissolveDelaySeconds,
    'minimum_icp_xdr_rate': minimumIcpXdrRate,
    'maximum_node_provider_rewards_e8s': maximumNodeProviderRewardsE8s,
    'neurons_fund_economics': neuronsFundEconomics?.toJson(),
    'voting_power_economics': votingPowerEconomics?.toJson(),
  };

  factory NnsGovernanceNetworkEconomics.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceNetworkEconomics(
      neuronMinimumStakeE8s: json.valueAsBigInt<BigInt>(
        'neuron_minimum_stake_e8s',
      ),
      maxProposalsToKeepPerTopic: json.valueAsInt<int>(
        'max_proposals_to_keep_per_topic',
      ),
      neuronManagementFeePerProposalE8s: json.valueAsBigInt<BigInt>(
        'neuron_management_fee_per_proposal_e8s',
      ),
      rejectCostE8s: json.valueAsBigInt<BigInt>('reject_cost_e8s'),
      transactionFeeE8s: json.valueAsBigInt<BigInt>('transaction_fee_e8s'),
      neuronSpawnDissolveDelaySeconds: json.valueAsBigInt<BigInt>(
        'neuron_spawn_dissolve_delay_seconds',
      ),
      minimumIcpXdrRate: json.valueAsBigInt<BigInt>('minimum_icp_xdr_rate'),
      maximumNodeProviderRewardsE8s: json.valueAsBigInt<BigInt>(
        'maximum_node_provider_rewards_e8s',
      ),
      neuronsFundEconomics: json
          .valueTo<NnsGovernanceNeuronsFundEconomics?, Map>(
            key: 'neurons_fund_economics',
            parse:
                (e) => NnsGovernanceNeuronsFundEconomics.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      votingPowerEconomics: json
          .valueTo<NnsGovernanceVotingPowerEconomics?, Map>(
            key: 'voting_power_economics',
            parse:
                (e) => NnsGovernanceVotingPowerEconomics.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceNetworkEconomics.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNetworkEconomics.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `VotingPowerEconomics`.
final class NnsGovernanceVotingPowerEconomics with CandidSerializable {
  final BigInt? startReducingVotingPowerAfterSeconds;
  final BigInt? clearFollowingAfterSeconds;
  final BigInt? neuronMinimumDissolveDelayToVoteSeconds;

  const NnsGovernanceVotingPowerEconomics({
    this.startReducingVotingPowerAfterSeconds,
    this.clearFollowingAfterSeconds,
    this.neuronMinimumDissolveDelayToVoteSeconds,
  });

  static CType get ctype => CType.record([
    Field(
      Label.named('start_reducing_voting_power_after_seconds'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('clear_following_after_seconds'), CType.opt(CType.nat64)),
    Field(
      Label.named('neuron_minimum_dissolve_delay_to_vote_seconds'),
      CType.opt(CType.nat64),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'start_reducing_voting_power_after_seconds':
        startReducingVotingPowerAfterSeconds,
    'clear_following_after_seconds': clearFollowingAfterSeconds,
    'neuron_minimum_dissolve_delay_to_vote_seconds':
        neuronMinimumDissolveDelayToVoteSeconds,
  };

  Map<String, dynamic> toJson() => {
    'start_reducing_voting_power_after_seconds':
        startReducingVotingPowerAfterSeconds,
    'clear_following_after_seconds': clearFollowingAfterSeconds,
    'neuron_minimum_dissolve_delay_to_vote_seconds':
        neuronMinimumDissolveDelayToVoteSeconds,
  };

  factory NnsGovernanceVotingPowerEconomics.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceVotingPowerEconomics(
      startReducingVotingPowerAfterSeconds: json.valueAsBigInt<BigInt?>(
        'start_reducing_voting_power_after_seconds',
      ),
      clearFollowingAfterSeconds: json.valueAsBigInt<BigInt?>(
        'clear_following_after_seconds',
      ),
      neuronMinimumDissolveDelayToVoteSeconds: json.valueAsBigInt<BigInt?>(
        'neuron_minimum_dissolve_delay_to_vote_seconds',
      ),
    );
  }

  factory NnsGovernanceVotingPowerEconomics.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceVotingPowerEconomics.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Neuron`.
final class NnsGovernanceNeuron with CandidSerializable {
  final NnsGovernanceNeuronId? id;
  final BigInt? stakedMaturityE8sEquivalent;
  final IcpPrincipalAddress? controller;
  final List<NnsGovernanceBallotInfo> recentBallots;
  final bool kycVerified;
  final int? neuronType;
  final bool notForProfit;
  final BigInt maturityE8sEquivalent;
  final BigInt cachedNeuronStakeE8s;
  final BigInt createdTimestampSeconds;
  final bool? autoStakeMaturity;
  final BigInt agingSinceTimestampSeconds;
  final List<IcpPrincipalAddress> hotKeys;
  final List<int> account;
  final BigInt? joinedCommunityFundTimestampSeconds;
  final NnsGovernanceDissolveState? dissolveState;
  final List<NnsGovernanceGovernanceDefaultFollowees> followees;
  final BigInt neuronFeesE8s;
  final int? visibility;
  final NnsGovernanceNeuronStakeTransfer? transfer;
  final NnsGovernanceKnownNeuronData? knownNeuronData;
  final BigInt? spawnAtTimestampSeconds;
  final BigInt? votingPowerRefreshedTimestampSeconds;
  final BigInt? decidingVotingPower;
  final BigInt? potentialVotingPower;
  final BigInt? eightYearGangBonusBaseE8s;
  final List<NnsGovernanceMaturityDisbursement>?
  maturityDisbursementsInProgress;

  const NnsGovernanceNeuron({
    this.id,
    this.stakedMaturityE8sEquivalent,
    this.controller,
    required this.recentBallots,
    required this.kycVerified,
    this.neuronType,
    required this.notForProfit,
    required this.maturityE8sEquivalent,
    required this.cachedNeuronStakeE8s,
    required this.createdTimestampSeconds,
    this.autoStakeMaturity,
    required this.agingSinceTimestampSeconds,
    required this.hotKeys,
    required this.account,
    this.joinedCommunityFundTimestampSeconds,
    this.dissolveState,
    required this.followees,
    required this.neuronFeesE8s,
    this.visibility,
    this.transfer,
    this.knownNeuronData,
    this.spawnAtTimestampSeconds,
    this.votingPowerRefreshedTimestampSeconds,
    this.decidingVotingPower,
    this.potentialVotingPower,
    this.eightYearGangBonusBaseE8s,
    this.maturityDisbursementsInProgress,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('id'), () => CType.opt(NnsGovernanceNeuronId.ctype)),
    Field(
      Label.named('staked_maturity_e8s_equivalent'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('controller'), CType.opt(CType.principal)),
    LazyField(
      Label.named('recent_ballots'),
      () => CType.vec(NnsGovernanceBallotInfo.ctype),
    ),
    Field(Label.named('kyc_verified'), CType.bool_),
    Field(Label.named('neuron_type'), CType.opt(CType.int32)),
    Field(Label.named('not_for_profit'), CType.bool_),
    Field(Label.named('maturity_e8s_equivalent'), CType.nat64),
    Field(Label.named('cached_neuron_stake_e8s'), CType.nat64),
    Field(Label.named('created_timestamp_seconds'), CType.nat64),
    Field(Label.named('auto_stake_maturity'), CType.opt(CType.bool_)),
    Field(Label.named('aging_since_timestamp_seconds'), CType.nat64),
    Field(Label.named('hot_keys'), CType.vec(CType.principal)),
    Field(Label.named('account'), CType.vec(CType.nat8)),
    Field(
      Label.named('joined_community_fund_timestamp_seconds'),
      CType.opt(CType.nat64),
    ),
    LazyField(
      Label.named('dissolve_state'),
      () => CType.opt(NnsGovernanceDissolveState.ctype),
    ),
    LazyField(
      Label.named('followees'),
      () => CType.vec(NnsGovernanceGovernanceDefaultFollowees.ctype),
    ),
    Field(Label.named('neuron_fees_e8s'), CType.nat64),
    Field(Label.named('visibility'), CType.opt(CType.int32)),
    LazyField(
      Label.named('transfer'),
      () => CType.opt(NnsGovernanceNeuronStakeTransfer.ctype),
    ),
    LazyField(
      Label.named('known_neuron_data'),
      () => CType.opt(NnsGovernanceKnownNeuronData.ctype),
    ),
    Field(Label.named('spawn_at_timestamp_seconds'), CType.opt(CType.nat64)),
    Field(
      Label.named('voting_power_refreshed_timestamp_seconds'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('deciding_voting_power'), CType.opt(CType.nat64)),
    Field(Label.named('potential_voting_power'), CType.opt(CType.nat64)),
    Field(
      Label.named('eight_year_gang_bonus_base_e8s'),
      CType.opt(CType.nat64),
    ),
    LazyField(
      Label.named('maturity_disbursements_in_progress'),
      () => CType.opt(CType.vec(NnsGovernanceMaturityDisbursement.ctype)),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'id': id?.candidValue,
    'staked_maturity_e8s_equivalent': stakedMaturityE8sEquivalent,
    'controller': controller,
    'recent_ballots': recentBallots.map((el) => el.candidValue).toList(),
    'kyc_verified': kycVerified,
    'neuron_type': neuronType,
    'not_for_profit': notForProfit,
    'maturity_e8s_equivalent': maturityE8sEquivalent,
    'cached_neuron_stake_e8s': cachedNeuronStakeE8s,
    'created_timestamp_seconds': createdTimestampSeconds,
    'auto_stake_maturity': autoStakeMaturity,
    'aging_since_timestamp_seconds': agingSinceTimestampSeconds,
    'hot_keys': hotKeys,
    'account': account,
    'joined_community_fund_timestamp_seconds':
        joinedCommunityFundTimestampSeconds,
    'dissolve_state': dissolveState?.candidValue,
    'followees': followees.map((el) => el.candidValue).toList(),
    'neuron_fees_e8s': neuronFeesE8s,
    'visibility': visibility,
    'transfer': transfer?.candidValue,
    'known_neuron_data': knownNeuronData?.candidValue,
    'spawn_at_timestamp_seconds': spawnAtTimestampSeconds,
    'voting_power_refreshed_timestamp_seconds':
        votingPowerRefreshedTimestampSeconds,
    'deciding_voting_power': decidingVotingPower,
    'potential_voting_power': potentialVotingPower,
    'eight_year_gang_bonus_base_e8s': eightYearGangBonusBaseE8s,
    'maturity_disbursements_in_progress':
        maturityDisbursementsInProgress?.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'id': id?.toJson(),
    'staked_maturity_e8s_equivalent': stakedMaturityE8sEquivalent,
    'controller': controller?.address,
    'recent_ballots': recentBallots.map((el) => el.toJson()).toList(),
    'kyc_verified': kycVerified,
    'neuron_type': neuronType,
    'not_for_profit': notForProfit,
    'maturity_e8s_equivalent': maturityE8sEquivalent,
    'cached_neuron_stake_e8s': cachedNeuronStakeE8s,
    'created_timestamp_seconds': createdTimestampSeconds,
    'auto_stake_maturity': autoStakeMaturity,
    'aging_since_timestamp_seconds': agingSinceTimestampSeconds,
    'hot_keys': hotKeys.map((el) => el.address).toList(),
    'account': account,
    'joined_community_fund_timestamp_seconds':
        joinedCommunityFundTimestampSeconds,
    'dissolve_state': dissolveState?.toJson(),
    'followees': followees.map((el) => el.toJson()).toList(),
    'neuron_fees_e8s': neuronFeesE8s,
    'visibility': visibility,
    'transfer': transfer?.toJson(),
    'known_neuron_data': knownNeuronData?.toJson(),
    'spawn_at_timestamp_seconds': spawnAtTimestampSeconds,
    'voting_power_refreshed_timestamp_seconds':
        votingPowerRefreshedTimestampSeconds,
    'deciding_voting_power': decidingVotingPower,
    'potential_voting_power': potentialVotingPower,
    'eight_year_gang_bonus_base_e8s': eightYearGangBonusBaseE8s,
    'maturity_disbursements_in_progress':
        maturityDisbursementsInProgress?.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceNeuron.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceNeuron(
      id: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      stakedMaturityE8sEquivalent: json.valueAsBigInt<BigInt?>(
        'staked_maturity_e8s_equivalent',
      ),
      controller: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'controller',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      recentBallots: json.valueTo<List<NnsGovernanceBallotInfo>, List>(
        key: 'recent_ballots',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceBallotInfo>(
                      (x) => NnsGovernanceBallotInfo.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      kycVerified: json.valueAsBool<bool>('kyc_verified'),
      neuronType: json.valueAsInt<int?>('neuron_type'),
      notForProfit: json.valueAsBool<bool>('not_for_profit'),
      maturityE8sEquivalent: json.valueAsBigInt<BigInt>(
        'maturity_e8s_equivalent',
      ),
      cachedNeuronStakeE8s: json.valueAsBigInt<BigInt>(
        'cached_neuron_stake_e8s',
      ),
      createdTimestampSeconds: json.valueAsBigInt<BigInt>(
        'created_timestamp_seconds',
      ),
      autoStakeMaturity: json.valueAsBool<bool?>('auto_stake_maturity'),
      agingSinceTimestampSeconds: json.valueAsBigInt<BigInt>(
        'aging_since_timestamp_seconds',
      ),
      hotKeys: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'hot_keys',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      account: json.valueAsBytes<List<int>>(
        'account',
        encoding: StringEncoding.base64,
      ),
      joinedCommunityFundTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'joined_community_fund_timestamp_seconds',
      ),
      dissolveState: json.valueTo<NnsGovernanceDissolveState?, Map>(
        key: 'dissolve_state',
        parse:
            (e) => NnsGovernanceDissolveState.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      followees: json.valueTo<
        List<NnsGovernanceGovernanceDefaultFollowees>,
        List
      >(
        key: 'followees',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceGovernanceDefaultFollowees>(
                      (x) => NnsGovernanceGovernanceDefaultFollowees.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      neuronFeesE8s: json.valueAsBigInt<BigInt>('neuron_fees_e8s'),
      visibility: json.valueAsInt<int?>('visibility'),
      transfer: json.valueTo<NnsGovernanceNeuronStakeTransfer?, Map>(
        key: 'transfer',
        parse:
            (e) => NnsGovernanceNeuronStakeTransfer.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      knownNeuronData: json.valueTo<NnsGovernanceKnownNeuronData?, Map>(
        key: 'known_neuron_data',
        parse:
            (e) => NnsGovernanceKnownNeuronData.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      spawnAtTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'spawn_at_timestamp_seconds',
      ),
      votingPowerRefreshedTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'voting_power_refreshed_timestamp_seconds',
      ),
      decidingVotingPower: json.valueAsBigInt<BigInt?>('deciding_voting_power'),
      potentialVotingPower: json.valueAsBigInt<BigInt?>(
        'potential_voting_power',
      ),
      eightYearGangBonusBaseE8s: json.valueAsBigInt<BigInt?>(
        'eight_year_gang_bonus_base_e8s',
      ),
      maturityDisbursementsInProgress: json
          .valueTo<List<NnsGovernanceMaturityDisbursement>?, List>(
            key: 'maturity_disbursements_in_progress',
            parse:
                (e) =>
                    e
                        .map<NnsGovernanceMaturityDisbursement>(
                          (x) => NnsGovernanceMaturityDisbursement.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsGovernanceNeuron.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuron.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronBasketConstructionParameters`.
final class NnsGovernanceNeuronBasketConstructionParameters
    with CandidSerializable {
  final NnsGovernanceDuration? dissolveDelayInterval;
  final BigInt? count;

  const NnsGovernanceNeuronBasketConstructionParameters({
    this.dissolveDelayInterval,
    this.count,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('dissolve_delay_interval'),
      () => CType.opt(NnsGovernanceDuration.ctype),
    ),
    Field(Label.named('count'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'dissolve_delay_interval': dissolveDelayInterval?.candidValue,
    'count': count,
  };

  Map<String, dynamic> toJson() => {
    'dissolve_delay_interval': dissolveDelayInterval?.toJson(),
    'count': count,
  };

  factory NnsGovernanceNeuronBasketConstructionParameters.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronBasketConstructionParameters(
      dissolveDelayInterval: json.valueTo<NnsGovernanceDuration?, Map>(
        key: 'dissolve_delay_interval',
        parse:
            (e) => NnsGovernanceDuration.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      count: json.valueAsBigInt<BigInt?>('count'),
    );
  }

  factory NnsGovernanceNeuronBasketConstructionParameters.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronBasketConstructionParameters.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronBasketConstructionParameters_1`.
final class NnsGovernanceNeuronBasketConstructionParameters1
    with CandidSerializable {
  final BigInt dissolveDelayIntervalSeconds;
  final BigInt count;

  const NnsGovernanceNeuronBasketConstructionParameters1({
    required this.dissolveDelayIntervalSeconds,
    required this.count,
  });

  static CType get ctype => CType.record([
    Field(Label.named('dissolve_delay_interval_seconds'), CType.nat64),
    Field(Label.named('count'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'dissolve_delay_interval_seconds': dissolveDelayIntervalSeconds,
    'count': count,
  };

  Map<String, dynamic> toJson() => {
    'dissolve_delay_interval_seconds': dissolveDelayIntervalSeconds,
    'count': count,
  };

  factory NnsGovernanceNeuronBasketConstructionParameters1.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronBasketConstructionParameters1(
      dissolveDelayIntervalSeconds: json.valueAsBigInt<BigInt>(
        'dissolve_delay_interval_seconds',
      ),
      count: json.valueAsBigInt<BigInt>('count'),
    );
  }

  factory NnsGovernanceNeuronBasketConstructionParameters1.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronBasketConstructionParameters1.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronDistribution`.
final class NnsGovernanceNeuronDistribution with CandidSerializable {
  final IcpPrincipalAddress? controller;
  final NnsGovernanceDuration? dissolveDelay;
  final BigInt? memo;
  final NnsGovernanceDuration? vestingPeriod;
  final NnsGovernanceTokens? stake;

  const NnsGovernanceNeuronDistribution({
    this.controller,
    this.dissolveDelay,
    this.memo,
    this.vestingPeriod,
    this.stake,
  });

  static CType get ctype => CType.record([
    Field(Label.named('controller'), CType.opt(CType.principal)),
    LazyField(
      Label.named('dissolve_delay'),
      () => CType.opt(NnsGovernanceDuration.ctype),
    ),
    Field(Label.named('memo'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('vesting_period'),
      () => CType.opt(NnsGovernanceDuration.ctype),
    ),
    LazyField(Label.named('stake'), () => CType.opt(NnsGovernanceTokens.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'controller': controller,
    'dissolve_delay': dissolveDelay?.candidValue,
    'memo': memo,
    'vesting_period': vestingPeriod?.candidValue,
    'stake': stake?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'controller': controller?.address,
    'dissolve_delay': dissolveDelay?.toJson(),
    'memo': memo,
    'vesting_period': vestingPeriod?.toJson(),
    'stake': stake?.toJson(),
  };

  factory NnsGovernanceNeuronDistribution.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronDistribution(
      controller: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'controller',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      dissolveDelay: json.valueTo<NnsGovernanceDuration?, Map>(
        key: 'dissolve_delay',
        parse:
            (e) => NnsGovernanceDuration.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      memo: json.valueAsBigInt<BigInt?>('memo'),
      vestingPeriod: json.valueTo<NnsGovernanceDuration?, Map>(
        key: 'vesting_period',
        parse:
            (e) => NnsGovernanceDuration.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      stake: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'stake',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceNeuronDistribution.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronDistribution.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronId`.
final class NnsGovernanceNeuronId with CandidSerializable {
  final BigInt id;

  const NnsGovernanceNeuronId({required this.id});

  static CType get ctype =>
      CType.record([Field(Label.named('id'), CType.nat64)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'id': id};

  Map<String, dynamic> toJson() => {'id': id};

  factory NnsGovernanceNeuronId.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceNeuronId(id: json.valueAsBigInt<BigInt>('id'));
  }

  factory NnsGovernanceNeuronId.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronId.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ProposalId`.
final class NnsGovernanceProposalId with CandidSerializable {
  final BigInt id;

  const NnsGovernanceProposalId({required this.id});

  static CType get ctype =>
      CType.record([Field(Label.named('id'), CType.nat64)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'id': id};

  Map<String, dynamic> toJson() => {'id': id};

  factory NnsGovernanceProposalId.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceProposalId(id: json.valueAsBigInt<BigInt>('id'));
  }

  factory NnsGovernanceProposalId.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceProposalId.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `NeuronIdOrSubaccount`.
sealed class NnsGovernanceNeuronIdOrSubaccount with CandidSerializable {
  const NnsGovernanceNeuronIdOrSubaccount();

  static CType get ctype => CType.variant([
    Field(Label.named('Subaccount'), CType.vec(CType.nat8)),
    LazyField(Label.named('NeuronId'), () => NnsGovernanceNeuronId.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceNeuronIdOrSubaccount.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Subaccount')) {
      return NnsGovernanceNeuronIdOrSubaccountSubaccount(
        json.valueAsBytes<List<int>>(
          'Subaccount',
          encoding: StringEncoding.base64,
        ),
      );
    }
    if (json.containsKey('NeuronId')) {
      return NnsGovernanceNeuronIdOrSubaccountNeuronId(
        json.valueTo<NnsGovernanceNeuronId, Map>(
          key: 'NeuronId',
          parse:
              (e) => NnsGovernanceNeuronId.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceNeuronIdOrSubaccount.fromCandid',
      reason: 'Unknown NnsGovernanceNeuronIdOrSubaccount arm',
    );
  }

  factory NnsGovernanceNeuronIdOrSubaccount.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronIdOrSubaccount.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NeuronIdOrSubaccount.Subaccount`.
final class NnsGovernanceNeuronIdOrSubaccountSubaccount
    extends NnsGovernanceNeuronIdOrSubaccount {
  final List<int> value;
  const NnsGovernanceNeuronIdOrSubaccountSubaccount(this.value);

  @override
  CType get candidType => NnsGovernanceNeuronIdOrSubaccount.ctype;

  @override
  dynamic get candidValue => Variant('Subaccount', value);

  @override
  Map<String, dynamic> toJson() => {'Subaccount': value};
}

/// Variant arm `NeuronIdOrSubaccount.NeuronId`.
final class NnsGovernanceNeuronIdOrSubaccountNeuronId
    extends NnsGovernanceNeuronIdOrSubaccount {
  final NnsGovernanceNeuronId value;
  const NnsGovernanceNeuronIdOrSubaccountNeuronId(this.value);

  @override
  CType get candidType => NnsGovernanceNeuronIdOrSubaccount.ctype;

  @override
  dynamic get candidValue => Variant('NeuronId', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'NeuronId': value.toJson()};
}

/// Candid record `NeuronInFlightCommand`.
final class NnsGovernanceNeuronInFlightCommand with CandidSerializable {
  final NnsGovernanceCommand2? command;
  final BigInt timestamp;

  const NnsGovernanceNeuronInFlightCommand({
    this.command,
    required this.timestamp,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('command'),
      () => CType.opt(NnsGovernanceCommand2.ctype),
    ),
    Field(Label.named('timestamp'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'command': command?.candidValue,
    'timestamp': timestamp,
  };

  Map<String, dynamic> toJson() => {
    'command': command?.toJson(),
    'timestamp': timestamp,
  };

  factory NnsGovernanceNeuronInFlightCommand.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronInFlightCommand(
      command: json.valueTo<NnsGovernanceCommand2?, Map>(
        key: 'command',
        parse:
            (e) => NnsGovernanceCommand2.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      timestamp: json.valueAsBigInt<BigInt>('timestamp'),
    );
  }

  factory NnsGovernanceNeuronInFlightCommand.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronInFlightCommand.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetNeuronIndexRequest`.
final class NnsGovernanceGetNeuronIndexRequest with CandidSerializable {
  final NnsGovernanceNeuronId? exclusiveStartNeuronId;
  final int? pageSize;

  const NnsGovernanceGetNeuronIndexRequest({
    this.exclusiveStartNeuronId,
    this.pageSize,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('exclusive_start_neuron_id'),
      () => CType.opt(NnsGovernanceNeuronId.ctype),
    ),
    Field(Label.named('page_size'), CType.opt(CType.nat32)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'exclusive_start_neuron_id': exclusiveStartNeuronId?.candidValue,
    'page_size': pageSize,
  };

  Map<String, dynamic> toJson() => {
    'exclusive_start_neuron_id': exclusiveStartNeuronId?.toJson(),
    'page_size': pageSize,
  };

  factory NnsGovernanceGetNeuronIndexRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGetNeuronIndexRequest(
      exclusiveStartNeuronId: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'exclusive_start_neuron_id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      pageSize: json.valueAsInt<int?>('page_size'),
    );
  }

  factory NnsGovernanceGetNeuronIndexRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGetNeuronIndexRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronIndexData`.
final class NnsGovernanceNeuronIndexData with CandidSerializable {
  final List<NnsGovernanceNeuronInfo> neurons;

  const NnsGovernanceNeuronIndexData({required this.neurons});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('neurons'),
      () => CType.vec(NnsGovernanceNeuronInfo.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'neurons': neurons.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'neurons': neurons.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceNeuronIndexData.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceNeuronIndexData(
      neurons: json.valueTo<List<NnsGovernanceNeuronInfo>, List>(
        key: 'neurons',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceNeuronInfo>(
                      (x) => NnsGovernanceNeuronInfo.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceNeuronIndexData.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronIndexData.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `GetNeuronIndexResult`.
sealed class NnsGovernanceGetNeuronIndexResult with CandidSerializable {
  const NnsGovernanceGetNeuronIndexResult();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsGovernanceNeuronIndexData.ctype),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceGetNeuronIndexResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsGovernanceGetNeuronIndexResultOk(
        json.valueTo<NnsGovernanceNeuronIndexData, Map>(
          key: 'Ok',
          parse:
              (e) => NnsGovernanceNeuronIndexData.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceGetNeuronIndexResultErr(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceGetNeuronIndexResult.fromCandid',
      reason: 'Unknown NnsGovernanceGetNeuronIndexResult arm',
    );
  }

  factory NnsGovernanceGetNeuronIndexResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGetNeuronIndexResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetNeuronIndexResult.Ok`.
final class NnsGovernanceGetNeuronIndexResultOk
    extends NnsGovernanceGetNeuronIndexResult {
  final NnsGovernanceNeuronIndexData value;
  const NnsGovernanceGetNeuronIndexResultOk(this.value);

  @override
  CType get candidType => NnsGovernanceGetNeuronIndexResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `GetNeuronIndexResult.Err`.
final class NnsGovernanceGetNeuronIndexResultErr
    extends NnsGovernanceGetNeuronIndexResult {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceGetNeuronIndexResultErr(this.value);

  @override
  CType get candidType => NnsGovernanceGetNeuronIndexResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `NeuronInfo`.
final class NnsGovernanceNeuronInfo with CandidSerializable {
  final NnsGovernanceNeuronId? id;
  final BigInt dissolveDelaySeconds;
  final List<NnsGovernanceBallotInfo> recentBallots;
  final int? neuronType;
  final BigInt createdTimestampSeconds;
  final int state;
  final BigInt stakeE8s;
  final BigInt? joinedCommunityFundTimestampSeconds;
  final BigInt retrievedAtTimestampSeconds;
  final int? visibility;
  final NnsGovernanceKnownNeuronData? knownNeuronData;
  final BigInt ageSeconds;
  final BigInt votingPower;
  final BigInt? votingPowerRefreshedTimestampSeconds;
  final BigInt? decidingVotingPower;
  final BigInt? potentialVotingPower;
  final BigInt? eightYearGangBonusBaseE8s;
  final BigInt? stakedMaturityE8sEquivalent;

  const NnsGovernanceNeuronInfo({
    this.id,
    required this.dissolveDelaySeconds,
    required this.recentBallots,
    this.neuronType,
    required this.createdTimestampSeconds,
    required this.state,
    required this.stakeE8s,
    this.joinedCommunityFundTimestampSeconds,
    required this.retrievedAtTimestampSeconds,
    this.visibility,
    this.knownNeuronData,
    required this.ageSeconds,
    required this.votingPower,
    this.votingPowerRefreshedTimestampSeconds,
    this.decidingVotingPower,
    this.potentialVotingPower,
    this.eightYearGangBonusBaseE8s,
    this.stakedMaturityE8sEquivalent,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('id'), () => CType.opt(NnsGovernanceNeuronId.ctype)),
    Field(Label.named('dissolve_delay_seconds'), CType.nat64),
    LazyField(
      Label.named('recent_ballots'),
      () => CType.vec(NnsGovernanceBallotInfo.ctype),
    ),
    Field(Label.named('neuron_type'), CType.opt(CType.int32)),
    Field(Label.named('created_timestamp_seconds'), CType.nat64),
    Field(Label.named('state'), CType.int32),
    Field(Label.named('stake_e8s'), CType.nat64),
    Field(
      Label.named('joined_community_fund_timestamp_seconds'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('retrieved_at_timestamp_seconds'), CType.nat64),
    Field(Label.named('visibility'), CType.opt(CType.int32)),
    LazyField(
      Label.named('known_neuron_data'),
      () => CType.opt(NnsGovernanceKnownNeuronData.ctype),
    ),
    Field(Label.named('age_seconds'), CType.nat64),
    Field(Label.named('voting_power'), CType.nat64),
    Field(
      Label.named('voting_power_refreshed_timestamp_seconds'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('deciding_voting_power'), CType.opt(CType.nat64)),
    Field(Label.named('potential_voting_power'), CType.opt(CType.nat64)),
    Field(
      Label.named('eight_year_gang_bonus_base_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(
      Label.named('staked_maturity_e8s_equivalent'),
      CType.opt(CType.nat64),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'id': id?.candidValue,
    'dissolve_delay_seconds': dissolveDelaySeconds,
    'recent_ballots': recentBallots.map((el) => el.candidValue).toList(),
    'neuron_type': neuronType,
    'created_timestamp_seconds': createdTimestampSeconds,
    'state': state,
    'stake_e8s': stakeE8s,
    'joined_community_fund_timestamp_seconds':
        joinedCommunityFundTimestampSeconds,
    'retrieved_at_timestamp_seconds': retrievedAtTimestampSeconds,
    'visibility': visibility,
    'known_neuron_data': knownNeuronData?.candidValue,
    'age_seconds': ageSeconds,
    'voting_power': votingPower,
    'voting_power_refreshed_timestamp_seconds':
        votingPowerRefreshedTimestampSeconds,
    'deciding_voting_power': decidingVotingPower,
    'potential_voting_power': potentialVotingPower,
    'eight_year_gang_bonus_base_e8s': eightYearGangBonusBaseE8s,
    'staked_maturity_e8s_equivalent': stakedMaturityE8sEquivalent,
  };

  Map<String, dynamic> toJson() => {
    'id': id?.toJson(),
    'dissolve_delay_seconds': dissolveDelaySeconds,
    'recent_ballots': recentBallots.map((el) => el.toJson()).toList(),
    'neuron_type': neuronType,
    'created_timestamp_seconds': createdTimestampSeconds,
    'state': state,
    'stake_e8s': stakeE8s,
    'joined_community_fund_timestamp_seconds':
        joinedCommunityFundTimestampSeconds,
    'retrieved_at_timestamp_seconds': retrievedAtTimestampSeconds,
    'visibility': visibility,
    'known_neuron_data': knownNeuronData?.toJson(),
    'age_seconds': ageSeconds,
    'voting_power': votingPower,
    'voting_power_refreshed_timestamp_seconds':
        votingPowerRefreshedTimestampSeconds,
    'deciding_voting_power': decidingVotingPower,
    'potential_voting_power': potentialVotingPower,
    'eight_year_gang_bonus_base_e8s': eightYearGangBonusBaseE8s,
    'staked_maturity_e8s_equivalent': stakedMaturityE8sEquivalent,
  };

  factory NnsGovernanceNeuronInfo.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceNeuronInfo(
      id: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      dissolveDelaySeconds: json.valueAsBigInt<BigInt>(
        'dissolve_delay_seconds',
      ),
      recentBallots: json.valueTo<List<NnsGovernanceBallotInfo>, List>(
        key: 'recent_ballots',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceBallotInfo>(
                      (x) => NnsGovernanceBallotInfo.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      neuronType: json.valueAsInt<int?>('neuron_type'),
      createdTimestampSeconds: json.valueAsBigInt<BigInt>(
        'created_timestamp_seconds',
      ),
      state: json.valueAsInt<int>('state'),
      stakeE8s: json.valueAsBigInt<BigInt>('stake_e8s'),
      joinedCommunityFundTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'joined_community_fund_timestamp_seconds',
      ),
      retrievedAtTimestampSeconds: json.valueAsBigInt<BigInt>(
        'retrieved_at_timestamp_seconds',
      ),
      visibility: json.valueAsInt<int?>('visibility'),
      knownNeuronData: json.valueTo<NnsGovernanceKnownNeuronData?, Map>(
        key: 'known_neuron_data',
        parse:
            (e) => NnsGovernanceKnownNeuronData.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      ageSeconds: json.valueAsBigInt<BigInt>('age_seconds'),
      votingPower: json.valueAsBigInt<BigInt>('voting_power'),
      votingPowerRefreshedTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'voting_power_refreshed_timestamp_seconds',
      ),
      decidingVotingPower: json.valueAsBigInt<BigInt?>('deciding_voting_power'),
      potentialVotingPower: json.valueAsBigInt<BigInt?>(
        'potential_voting_power',
      ),
      eightYearGangBonusBaseE8s: json.valueAsBigInt<BigInt?>(
        'eight_year_gang_bonus_base_e8s',
      ),
      stakedMaturityE8sEquivalent: json.valueAsBigInt<BigInt?>(
        'staked_maturity_e8s_equivalent',
      ),
    );
  }

  factory NnsGovernanceNeuronInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronStakeTransfer`.
final class NnsGovernanceNeuronStakeTransfer with CandidSerializable {
  final List<int> toSubaccount;
  final BigInt neuronStakeE8s;
  final IcpPrincipalAddress? from;
  final BigInt memo;
  final List<int> fromSubaccount;
  final BigInt transferTimestamp;
  final BigInt blockHeight;

  const NnsGovernanceNeuronStakeTransfer({
    required this.toSubaccount,
    required this.neuronStakeE8s,
    this.from,
    required this.memo,
    required this.fromSubaccount,
    required this.transferTimestamp,
    required this.blockHeight,
  });

  static CType get ctype => CType.record([
    Field(Label.named('to_subaccount'), CType.vec(CType.nat8)),
    Field(Label.named('neuron_stake_e8s'), CType.nat64),
    Field(Label.named('from'), CType.opt(CType.principal)),
    Field(Label.named('memo'), CType.nat64),
    Field(Label.named('from_subaccount'), CType.vec(CType.nat8)),
    Field(Label.named('transfer_timestamp'), CType.nat64),
    Field(Label.named('block_height'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'to_subaccount': toSubaccount,
    'neuron_stake_e8s': neuronStakeE8s,
    'from': from,
    'memo': memo,
    'from_subaccount': fromSubaccount,
    'transfer_timestamp': transferTimestamp,
    'block_height': blockHeight,
  };

  Map<String, dynamic> toJson() => {
    'to_subaccount': toSubaccount,
    'neuron_stake_e8s': neuronStakeE8s,
    'from': from?.address,
    'memo': memo,
    'from_subaccount': fromSubaccount,
    'transfer_timestamp': transferTimestamp,
    'block_height': blockHeight,
  };

  factory NnsGovernanceNeuronStakeTransfer.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronStakeTransfer(
      toSubaccount: json.valueAsBytes<List<int>>(
        'to_subaccount',
        encoding: StringEncoding.base64,
      ),
      neuronStakeE8s: json.valueAsBigInt<BigInt>('neuron_stake_e8s'),
      from: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'from',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      memo: json.valueAsBigInt<BigInt>('memo'),
      fromSubaccount: json.valueAsBytes<List<int>>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      transferTimestamp: json.valueAsBigInt<BigInt>('transfer_timestamp'),
      blockHeight: json.valueAsBigInt<BigInt>('block_height'),
    );
  }

  factory NnsGovernanceNeuronStakeTransfer.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronStakeTransfer.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronSubsetMetrics`.
final class NnsGovernanceNeuronSubsetMetrics with CandidSerializable {
  final BigInt? count;
  final BigInt? totalStakedE8s;
  final BigInt? totalMaturityE8sEquivalent;
  final BigInt? totalStakedMaturityE8sEquivalent;
  final BigInt? totalVotingPower;
  final BigInt? totalDecidingVotingPower;
  final BigInt? totalPotentialVotingPower;
  final List<
    NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
  >
  countBuckets;
  final List<
    NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
  >
  stakedE8sBuckets;
  final List<
    NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
  >
  maturityE8sEquivalentBuckets;
  final List<
    NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
  >
  stakedMaturityE8sEquivalentBuckets;
  final List<
    NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
  >
  votingPowerBuckets;
  final List<
    NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
  >
  decidingVotingPowerBuckets;
  final List<
    NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
  >
  potentialVotingPowerBuckets;

  const NnsGovernanceNeuronSubsetMetrics({
    this.count,
    this.totalStakedE8s,
    this.totalMaturityE8sEquivalent,
    this.totalStakedMaturityE8sEquivalent,
    this.totalVotingPower,
    this.totalDecidingVotingPower,
    this.totalPotentialVotingPower,
    required this.countBuckets,
    required this.stakedE8sBuckets,
    required this.maturityE8sEquivalentBuckets,
    required this.stakedMaturityE8sEquivalentBuckets,
    required this.votingPowerBuckets,
    required this.decidingVotingPowerBuckets,
    required this.potentialVotingPowerBuckets,
  });

  static CType get ctype => CType.record([
    Field(Label.named('count'), CType.opt(CType.nat64)),
    Field(Label.named('total_staked_e8s'), CType.opt(CType.nat64)),
    Field(Label.named('total_maturity_e8s_equivalent'), CType.opt(CType.nat64)),
    Field(
      Label.named('total_staked_maturity_e8s_equivalent'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('total_voting_power'), CType.opt(CType.nat64)),
    Field(Label.named('total_deciding_voting_power'), CType.opt(CType.nat64)),
    Field(Label.named('total_potential_voting_power'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('count_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
            .ctype,
      ),
    ),
    LazyField(
      Label.named('staked_e8s_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
            .ctype,
      ),
    ),
    LazyField(
      Label.named('maturity_e8s_equivalent_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
            .ctype,
      ),
    ),
    LazyField(
      Label.named('staked_maturity_e8s_equivalent_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
            .ctype,
      ),
    ),
    LazyField(
      Label.named('voting_power_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
            .ctype,
      ),
    ),
    LazyField(
      Label.named('deciding_voting_power_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
            .ctype,
      ),
    ),
    LazyField(
      Label.named('potential_voting_power_buckets'),
      () => CType.vec(
        NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
            .ctype,
      ),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'count': count,
    'total_staked_e8s': totalStakedE8s,
    'total_maturity_e8s_equivalent': totalMaturityE8sEquivalent,
    'total_staked_maturity_e8s_equivalent': totalStakedMaturityE8sEquivalent,
    'total_voting_power': totalVotingPower,
    'total_deciding_voting_power': totalDecidingVotingPower,
    'total_potential_voting_power': totalPotentialVotingPower,
    'count_buckets': countBuckets.map((el) => el.candidValue).toList(),
    'staked_e8s_buckets': stakedE8sBuckets.map((el) => el.candidValue).toList(),
    'maturity_e8s_equivalent_buckets':
        maturityE8sEquivalentBuckets.map((el) => el.candidValue).toList(),
    'staked_maturity_e8s_equivalent_buckets':
        stakedMaturityE8sEquivalentBuckets.map((el) => el.candidValue).toList(),
    'voting_power_buckets':
        votingPowerBuckets.map((el) => el.candidValue).toList(),
    'deciding_voting_power_buckets':
        decidingVotingPowerBuckets.map((el) => el.candidValue).toList(),
    'potential_voting_power_buckets':
        potentialVotingPowerBuckets.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'count': count,
    'total_staked_e8s': totalStakedE8s,
    'total_maturity_e8s_equivalent': totalMaturityE8sEquivalent,
    'total_staked_maturity_e8s_equivalent': totalStakedMaturityE8sEquivalent,
    'total_voting_power': totalVotingPower,
    'total_deciding_voting_power': totalDecidingVotingPower,
    'total_potential_voting_power': totalPotentialVotingPower,
    'count_buckets': countBuckets.map((el) => el.toJson()).toList(),
    'staked_e8s_buckets': stakedE8sBuckets.map((el) => el.toJson()).toList(),
    'maturity_e8s_equivalent_buckets':
        maturityE8sEquivalentBuckets.map((el) => el.toJson()).toList(),
    'staked_maturity_e8s_equivalent_buckets':
        stakedMaturityE8sEquivalentBuckets.map((el) => el.toJson()).toList(),
    'voting_power_buckets':
        votingPowerBuckets.map((el) => el.toJson()).toList(),
    'deciding_voting_power_buckets':
        decidingVotingPowerBuckets.map((el) => el.toJson()).toList(),
    'potential_voting_power_buckets':
        potentialVotingPowerBuckets.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceNeuronSubsetMetrics.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronSubsetMetrics(
      count: json.valueAsBigInt<BigInt?>('count'),
      totalStakedE8s: json.valueAsBigInt<BigInt?>('total_staked_e8s'),
      totalMaturityE8sEquivalent: json.valueAsBigInt<BigInt?>(
        'total_maturity_e8s_equivalent',
      ),
      totalStakedMaturityE8sEquivalent: json.valueAsBigInt<BigInt?>(
        'total_staked_maturity_e8s_equivalent',
      ),
      totalVotingPower: json.valueAsBigInt<BigInt?>('total_voting_power'),
      totalDecidingVotingPower: json.valueAsBigInt<BigInt?>(
        'total_deciding_voting_power',
      ),
      totalPotentialVotingPower: json.valueAsBigInt<BigInt?>(
        'total_potential_voting_power',
      ),
      countBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
        >,
        List
      >(
        key: 'count_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      stakedE8sBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
        >,
        List
      >(
        key: 'staked_e8s_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      maturityE8sEquivalentBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
        >,
        List
      >(
        key: 'maturity_e8s_equivalent_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      stakedMaturityE8sEquivalentBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
        >,
        List
      >(
        key: 'staked_maturity_e8s_equivalent_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      votingPowerBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
        >,
        List
      >(
        key: 'voting_power_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      decidingVotingPowerBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
        >,
        List
      >(
        key: 'deciding_voting_power_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      potentialVotingPowerBuckets: json.valueTo<
        List<
          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
        >,
        List
      >(
        key: 'potential_voting_power_buckets',
        parse:
            (e) =>
                e
                    .map<
                      NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets
                    >(
                      (x) =>
                          NnsGovernanceGovernanceCachedMetricsNotDissolvingNeuronsCountBuckets.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceNeuronSubsetMetrics.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronSubsetMetrics.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronsFundAuditInfo`.
final class NnsGovernanceNeuronsFundAuditInfo with CandidSerializable {
  final NnsGovernanceNeuronsFundParticipation? finalNeuronsFundParticipation;
  final NnsGovernanceNeuronsFundParticipation? initialNeuronsFundParticipation;
  final NnsGovernanceNeuronsFundSnapshot? neuronsFundRefunds;

  const NnsGovernanceNeuronsFundAuditInfo({
    this.finalNeuronsFundParticipation,
    this.initialNeuronsFundParticipation,
    this.neuronsFundRefunds,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('final_neurons_fund_participation'),
      () => CType.opt(NnsGovernanceNeuronsFundParticipation.ctype),
    ),
    LazyField(
      Label.named('initial_neurons_fund_participation'),
      () => CType.opt(NnsGovernanceNeuronsFundParticipation.ctype),
    ),
    LazyField(
      Label.named('neurons_fund_refunds'),
      () => CType.opt(NnsGovernanceNeuronsFundSnapshot.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'final_neurons_fund_participation':
        finalNeuronsFundParticipation?.candidValue,
    'initial_neurons_fund_participation':
        initialNeuronsFundParticipation?.candidValue,
    'neurons_fund_refunds': neuronsFundRefunds?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'final_neurons_fund_participation': finalNeuronsFundParticipation?.toJson(),
    'initial_neurons_fund_participation':
        initialNeuronsFundParticipation?.toJson(),
    'neurons_fund_refunds': neuronsFundRefunds?.toJson(),
  };

  factory NnsGovernanceNeuronsFundAuditInfo.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronsFundAuditInfo(
      finalNeuronsFundParticipation: json
          .valueTo<NnsGovernanceNeuronsFundParticipation?, Map>(
            key: 'final_neurons_fund_participation',
            parse:
                (e) => NnsGovernanceNeuronsFundParticipation.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      initialNeuronsFundParticipation: json
          .valueTo<NnsGovernanceNeuronsFundParticipation?, Map>(
            key: 'initial_neurons_fund_participation',
            parse:
                (e) => NnsGovernanceNeuronsFundParticipation.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      neuronsFundRefunds: json.valueTo<NnsGovernanceNeuronsFundSnapshot?, Map>(
        key: 'neurons_fund_refunds',
        parse:
            (e) => NnsGovernanceNeuronsFundSnapshot.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceNeuronsFundAuditInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronsFundAuditInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronsFundData`.
final class NnsGovernanceNeuronsFundData with CandidSerializable {
  final NnsGovernanceNeuronsFundParticipation? finalNeuronsFundParticipation;
  final NnsGovernanceNeuronsFundParticipation? initialNeuronsFundParticipation;
  final NnsGovernanceNeuronsFundSnapshot? neuronsFundRefunds;

  const NnsGovernanceNeuronsFundData({
    this.finalNeuronsFundParticipation,
    this.initialNeuronsFundParticipation,
    this.neuronsFundRefunds,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('final_neurons_fund_participation'),
      () => CType.opt(NnsGovernanceNeuronsFundParticipation.ctype),
    ),
    LazyField(
      Label.named('initial_neurons_fund_participation'),
      () => CType.opt(NnsGovernanceNeuronsFundParticipation.ctype),
    ),
    LazyField(
      Label.named('neurons_fund_refunds'),
      () => CType.opt(NnsGovernanceNeuronsFundSnapshot.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'final_neurons_fund_participation':
        finalNeuronsFundParticipation?.candidValue,
    'initial_neurons_fund_participation':
        initialNeuronsFundParticipation?.candidValue,
    'neurons_fund_refunds': neuronsFundRefunds?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'final_neurons_fund_participation': finalNeuronsFundParticipation?.toJson(),
    'initial_neurons_fund_participation':
        initialNeuronsFundParticipation?.toJson(),
    'neurons_fund_refunds': neuronsFundRefunds?.toJson(),
  };

  factory NnsGovernanceNeuronsFundData.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceNeuronsFundData(
      finalNeuronsFundParticipation: json
          .valueTo<NnsGovernanceNeuronsFundParticipation?, Map>(
            key: 'final_neurons_fund_participation',
            parse:
                (e) => NnsGovernanceNeuronsFundParticipation.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      initialNeuronsFundParticipation: json
          .valueTo<NnsGovernanceNeuronsFundParticipation?, Map>(
            key: 'initial_neurons_fund_participation',
            parse:
                (e) => NnsGovernanceNeuronsFundParticipation.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      neuronsFundRefunds: json.valueTo<NnsGovernanceNeuronsFundSnapshot?, Map>(
        key: 'neurons_fund_refunds',
        parse:
            (e) => NnsGovernanceNeuronsFundSnapshot.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceNeuronsFundData.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronsFundData.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronsFundEconomics`.
final class NnsGovernanceNeuronsFundEconomics with CandidSerializable {
  final NnsGovernancePercentage? maximumIcpXdrRate;
  final NnsGovernanceNeuronsFundMatchedFundingCurveCoefficients?
  neuronsFundMatchedFundingCurveCoefficients;
  final NnsGovernanceDecimal? maxTheoreticalNeuronsFundParticipationAmountXdr;
  final NnsGovernancePercentage? minimumIcpXdrRate;

  const NnsGovernanceNeuronsFundEconomics({
    this.maximumIcpXdrRate,
    this.neuronsFundMatchedFundingCurveCoefficients,
    this.maxTheoreticalNeuronsFundParticipationAmountXdr,
    this.minimumIcpXdrRate,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('maximum_icp_xdr_rate'),
      () => CType.opt(NnsGovernancePercentage.ctype),
    ),
    LazyField(
      Label.named('neurons_fund_matched_funding_curve_coefficients'),
      () => CType.opt(
        NnsGovernanceNeuronsFundMatchedFundingCurveCoefficients.ctype,
      ),
    ),
    LazyField(
      Label.named('max_theoretical_neurons_fund_participation_amount_xdr'),
      () => CType.opt(NnsGovernanceDecimal.ctype),
    ),
    LazyField(
      Label.named('minimum_icp_xdr_rate'),
      () => CType.opt(NnsGovernancePercentage.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'maximum_icp_xdr_rate': maximumIcpXdrRate?.candidValue,
    'neurons_fund_matched_funding_curve_coefficients':
        neuronsFundMatchedFundingCurveCoefficients?.candidValue,
    'max_theoretical_neurons_fund_participation_amount_xdr':
        maxTheoreticalNeuronsFundParticipationAmountXdr?.candidValue,
    'minimum_icp_xdr_rate': minimumIcpXdrRate?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'maximum_icp_xdr_rate': maximumIcpXdrRate?.toJson(),
    'neurons_fund_matched_funding_curve_coefficients':
        neuronsFundMatchedFundingCurveCoefficients?.toJson(),
    'max_theoretical_neurons_fund_participation_amount_xdr':
        maxTheoreticalNeuronsFundParticipationAmountXdr?.toJson(),
    'minimum_icp_xdr_rate': minimumIcpXdrRate?.toJson(),
  };

  factory NnsGovernanceNeuronsFundEconomics.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronsFundEconomics(
      maximumIcpXdrRate: json.valueTo<NnsGovernancePercentage?, Map>(
        key: 'maximum_icp_xdr_rate',
        parse:
            (e) => NnsGovernancePercentage.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      neuronsFundMatchedFundingCurveCoefficients: json.valueTo<
        NnsGovernanceNeuronsFundMatchedFundingCurveCoefficients?,
        Map
      >(
        key: 'neurons_fund_matched_funding_curve_coefficients',
        parse:
            (e) =>
                NnsGovernanceNeuronsFundMatchedFundingCurveCoefficients.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
      ),
      maxTheoreticalNeuronsFundParticipationAmountXdr: json
          .valueTo<NnsGovernanceDecimal?, Map>(
            key: 'max_theoretical_neurons_fund_participation_amount_xdr',
            parse:
                (e) => NnsGovernanceDecimal.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      minimumIcpXdrRate: json.valueTo<NnsGovernancePercentage?, Map>(
        key: 'minimum_icp_xdr_rate',
        parse:
            (e) => NnsGovernancePercentage.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceNeuronsFundEconomics.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronsFundEconomics.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronsFundMatchedFundingCurveCoefficients`.
final class NnsGovernanceNeuronsFundMatchedFundingCurveCoefficients
    with CandidSerializable {
  final NnsGovernanceDecimal? contributionThresholdXdr;
  final NnsGovernanceDecimal? oneThirdParticipationMilestoneXdr;
  final NnsGovernanceDecimal? fullParticipationMilestoneXdr;

  const NnsGovernanceNeuronsFundMatchedFundingCurveCoefficients({
    this.contributionThresholdXdr,
    this.oneThirdParticipationMilestoneXdr,
    this.fullParticipationMilestoneXdr,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('contribution_threshold_xdr'),
      () => CType.opt(NnsGovernanceDecimal.ctype),
    ),
    LazyField(
      Label.named('one_third_participation_milestone_xdr'),
      () => CType.opt(NnsGovernanceDecimal.ctype),
    ),
    LazyField(
      Label.named('full_participation_milestone_xdr'),
      () => CType.opt(NnsGovernanceDecimal.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'contribution_threshold_xdr': contributionThresholdXdr?.candidValue,
    'one_third_participation_milestone_xdr':
        oneThirdParticipationMilestoneXdr?.candidValue,
    'full_participation_milestone_xdr':
        fullParticipationMilestoneXdr?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'contribution_threshold_xdr': contributionThresholdXdr?.toJson(),
    'one_third_participation_milestone_xdr':
        oneThirdParticipationMilestoneXdr?.toJson(),
    'full_participation_milestone_xdr': fullParticipationMilestoneXdr?.toJson(),
  };

  factory NnsGovernanceNeuronsFundMatchedFundingCurveCoefficients.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronsFundMatchedFundingCurveCoefficients(
      contributionThresholdXdr: json.valueTo<NnsGovernanceDecimal?, Map>(
        key: 'contribution_threshold_xdr',
        parse:
            (e) => NnsGovernanceDecimal.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      oneThirdParticipationMilestoneXdr: json
          .valueTo<NnsGovernanceDecimal?, Map>(
            key: 'one_third_participation_milestone_xdr',
            parse:
                (e) => NnsGovernanceDecimal.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      fullParticipationMilestoneXdr: json.valueTo<NnsGovernanceDecimal?, Map>(
        key: 'full_participation_milestone_xdr',
        parse:
            (e) => NnsGovernanceDecimal.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceNeuronsFundMatchedFundingCurveCoefficients.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronsFundMatchedFundingCurveCoefficients.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronsFundNeuron`.
final class NnsGovernanceNeuronsFundNeuron with CandidSerializable {
  final IcpPrincipalAddress? controller;
  final NnsGovernancePrincipals? hotkeys;
  final bool? isCapped;
  final BigInt? nnsNeuronId;
  final BigInt? amountIcpE8s;

  const NnsGovernanceNeuronsFundNeuron({
    this.controller,
    this.hotkeys,
    this.isCapped,
    this.nnsNeuronId,
    this.amountIcpE8s,
  });

  static CType get ctype => CType.record([
    Field(Label.named('controller'), CType.opt(CType.principal)),
    LazyField(
      Label.named('hotkeys'),
      () => CType.opt(NnsGovernancePrincipals.ctype),
    ),
    Field(Label.named('is_capped'), CType.opt(CType.bool_)),
    Field(Label.named('nns_neuron_id'), CType.opt(CType.nat64)),
    Field(Label.named('amount_icp_e8s'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'controller': controller,
    'hotkeys': hotkeys?.candidValue,
    'is_capped': isCapped,
    'nns_neuron_id': nnsNeuronId,
    'amount_icp_e8s': amountIcpE8s,
  };

  Map<String, dynamic> toJson() => {
    'controller': controller?.address,
    'hotkeys': hotkeys?.toJson(),
    'is_capped': isCapped,
    'nns_neuron_id': nnsNeuronId,
    'amount_icp_e8s': amountIcpE8s,
  };

  factory NnsGovernanceNeuronsFundNeuron.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceNeuronsFundNeuron(
      controller: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'controller',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      hotkeys: json.valueTo<NnsGovernancePrincipals?, Map>(
        key: 'hotkeys',
        parse:
            (e) => NnsGovernancePrincipals.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      isCapped: json.valueAsBool<bool?>('is_capped'),
      nnsNeuronId: json.valueAsBigInt<BigInt?>('nns_neuron_id'),
      amountIcpE8s: json.valueAsBigInt<BigInt?>('amount_icp_e8s'),
    );
  }

  factory NnsGovernanceNeuronsFundNeuron.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronsFundNeuron.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronsFundNeuronPortion`.
final class NnsGovernanceNeuronsFundNeuronPortion with CandidSerializable {
  final IcpPrincipalAddress? controller;
  final List<IcpPrincipalAddress> hotkeys;
  final bool? isCapped;
  final BigInt? maturityEquivalentIcpE8s;
  final NnsGovernanceNeuronId? nnsNeuronId;
  final BigInt? amountIcpE8s;

  const NnsGovernanceNeuronsFundNeuronPortion({
    this.controller,
    required this.hotkeys,
    this.isCapped,
    this.maturityEquivalentIcpE8s,
    this.nnsNeuronId,
    this.amountIcpE8s,
  });

  static CType get ctype => CType.record([
    Field(Label.named('controller'), CType.opt(CType.principal)),
    Field(Label.named('hotkeys'), CType.vec(CType.principal)),
    Field(Label.named('is_capped'), CType.opt(CType.bool_)),
    Field(Label.named('maturity_equivalent_icp_e8s'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('nns_neuron_id'),
      () => CType.opt(NnsGovernanceNeuronId.ctype),
    ),
    Field(Label.named('amount_icp_e8s'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'controller': controller,
    'hotkeys': hotkeys,
    'is_capped': isCapped,
    'maturity_equivalent_icp_e8s': maturityEquivalentIcpE8s,
    'nns_neuron_id': nnsNeuronId?.candidValue,
    'amount_icp_e8s': amountIcpE8s,
  };

  Map<String, dynamic> toJson() => {
    'controller': controller?.address,
    'hotkeys': hotkeys.map((el) => el.address).toList(),
    'is_capped': isCapped,
    'maturity_equivalent_icp_e8s': maturityEquivalentIcpE8s,
    'nns_neuron_id': nnsNeuronId?.toJson(),
    'amount_icp_e8s': amountIcpE8s,
  };

  factory NnsGovernanceNeuronsFundNeuronPortion.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronsFundNeuronPortion(
      controller: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'controller',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      hotkeys: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'hotkeys',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      isCapped: json.valueAsBool<bool?>('is_capped'),
      maturityEquivalentIcpE8s: json.valueAsBigInt<BigInt?>(
        'maturity_equivalent_icp_e8s',
      ),
      nnsNeuronId: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'nns_neuron_id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      amountIcpE8s: json.valueAsBigInt<BigInt?>('amount_icp_e8s'),
    );
  }

  factory NnsGovernanceNeuronsFundNeuronPortion.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronsFundNeuronPortion.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronsFundParticipation`.
final class NnsGovernanceNeuronsFundParticipation with CandidSerializable {
  final BigInt? totalMaturityEquivalentIcpE8s;
  final BigInt? intendedNeuronsFundParticipationIcpE8s;
  final BigInt? directParticipationIcpE8s;
  final NnsGovernanceSwapParticipationLimits? swapParticipationLimits;
  final BigInt? maxNeuronsFundSwapParticipationIcpE8s;
  final NnsGovernanceNeuronsFundSnapshot? neuronsFundReserves;
  final NnsGovernanceIdealMatchedParticipationFunction?
  idealMatchedParticipationFunction;
  final BigInt? allocatedNeuronsFundParticipationIcpE8s;

  const NnsGovernanceNeuronsFundParticipation({
    this.totalMaturityEquivalentIcpE8s,
    this.intendedNeuronsFundParticipationIcpE8s,
    this.directParticipationIcpE8s,
    this.swapParticipationLimits,
    this.maxNeuronsFundSwapParticipationIcpE8s,
    this.neuronsFundReserves,
    this.idealMatchedParticipationFunction,
    this.allocatedNeuronsFundParticipationIcpE8s,
  });

  static CType get ctype => CType.record([
    Field(
      Label.named('total_maturity_equivalent_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(
      Label.named('intended_neurons_fund_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('direct_participation_icp_e8s'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('swap_participation_limits'),
      () => CType.opt(NnsGovernanceSwapParticipationLimits.ctype),
    ),
    Field(
      Label.named('max_neurons_fund_swap_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    LazyField(
      Label.named('neurons_fund_reserves'),
      () => CType.opt(NnsGovernanceNeuronsFundSnapshot.ctype),
    ),
    LazyField(
      Label.named('ideal_matched_participation_function'),
      () => CType.opt(NnsGovernanceIdealMatchedParticipationFunction.ctype),
    ),
    Field(
      Label.named('allocated_neurons_fund_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'total_maturity_equivalent_icp_e8s': totalMaturityEquivalentIcpE8s,
    'intended_neurons_fund_participation_icp_e8s':
        intendedNeuronsFundParticipationIcpE8s,
    'direct_participation_icp_e8s': directParticipationIcpE8s,
    'swap_participation_limits': swapParticipationLimits?.candidValue,
    'max_neurons_fund_swap_participation_icp_e8s':
        maxNeuronsFundSwapParticipationIcpE8s,
    'neurons_fund_reserves': neuronsFundReserves?.candidValue,
    'ideal_matched_participation_function':
        idealMatchedParticipationFunction?.candidValue,
    'allocated_neurons_fund_participation_icp_e8s':
        allocatedNeuronsFundParticipationIcpE8s,
  };

  Map<String, dynamic> toJson() => {
    'total_maturity_equivalent_icp_e8s': totalMaturityEquivalentIcpE8s,
    'intended_neurons_fund_participation_icp_e8s':
        intendedNeuronsFundParticipationIcpE8s,
    'direct_participation_icp_e8s': directParticipationIcpE8s,
    'swap_participation_limits': swapParticipationLimits?.toJson(),
    'max_neurons_fund_swap_participation_icp_e8s':
        maxNeuronsFundSwapParticipationIcpE8s,
    'neurons_fund_reserves': neuronsFundReserves?.toJson(),
    'ideal_matched_participation_function':
        idealMatchedParticipationFunction?.toJson(),
    'allocated_neurons_fund_participation_icp_e8s':
        allocatedNeuronsFundParticipationIcpE8s,
  };

  factory NnsGovernanceNeuronsFundParticipation.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronsFundParticipation(
      totalMaturityEquivalentIcpE8s: json.valueAsBigInt<BigInt?>(
        'total_maturity_equivalent_icp_e8s',
      ),
      intendedNeuronsFundParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'intended_neurons_fund_participation_icp_e8s',
      ),
      directParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'direct_participation_icp_e8s',
      ),
      swapParticipationLimits: json
          .valueTo<NnsGovernanceSwapParticipationLimits?, Map>(
            key: 'swap_participation_limits',
            parse:
                (e) => NnsGovernanceSwapParticipationLimits.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      maxNeuronsFundSwapParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'max_neurons_fund_swap_participation_icp_e8s',
      ),
      neuronsFundReserves: json.valueTo<NnsGovernanceNeuronsFundSnapshot?, Map>(
        key: 'neurons_fund_reserves',
        parse:
            (e) => NnsGovernanceNeuronsFundSnapshot.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      idealMatchedParticipationFunction: json
          .valueTo<NnsGovernanceIdealMatchedParticipationFunction?, Map>(
            key: 'ideal_matched_participation_function',
            parse:
                (e) =>
                    NnsGovernanceIdealMatchedParticipationFunction.fromCandid(
                      JsonParser.valueEnsureAsMap<String, dynamic>(e),
                    ),
          ),
      allocatedNeuronsFundParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'allocated_neurons_fund_participation_icp_e8s',
      ),
    );
  }

  factory NnsGovernanceNeuronsFundParticipation.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronsFundParticipation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronsFundSnapshot`.
final class NnsGovernanceNeuronsFundSnapshot with CandidSerializable {
  final List<NnsGovernanceNeuronsFundNeuronPortion> neuronsFundNeuronPortions;

  const NnsGovernanceNeuronsFundSnapshot({
    required this.neuronsFundNeuronPortions,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('neurons_fund_neuron_portions'),
      () => CType.vec(NnsGovernanceNeuronsFundNeuronPortion.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'neurons_fund_neuron_portions':
        neuronsFundNeuronPortions.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'neurons_fund_neuron_portions':
        neuronsFundNeuronPortions.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceNeuronsFundSnapshot.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceNeuronsFundSnapshot(
      neuronsFundNeuronPortions: json
          .valueTo<List<NnsGovernanceNeuronsFundNeuronPortion>, List>(
            key: 'neurons_fund_neuron_portions',
            parse:
                (e) =>
                    e
                        .map<NnsGovernanceNeuronsFundNeuronPortion>(
                          (x) =>
                              NnsGovernanceNeuronsFundNeuronPortion.fromCandid(
                                JsonParser.valueEnsureAsMap<String, dynamic>(x),
                              ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsGovernanceNeuronsFundSnapshot.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronsFundSnapshot.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NodeProvider`.
final class NnsGovernanceNodeProvider with CandidSerializable {
  final IcpPrincipalAddress? id;
  final NnsGovernanceAccountIdentifier? rewardAccount;

  const NnsGovernanceNodeProvider({this.id, this.rewardAccount});

  static CType get ctype => CType.record([
    Field(Label.named('id'), CType.opt(CType.principal)),
    LazyField(
      Label.named('reward_account'),
      () => CType.opt(NnsGovernanceAccountIdentifier.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'id': id,
    'reward_account': rewardAccount?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'id': id?.address,
    'reward_account': rewardAccount?.toJson(),
  };

  factory NnsGovernanceNodeProvider.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceNodeProvider(
      id: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      rewardAccount: json.valueTo<NnsGovernanceAccountIdentifier?, Map>(
        key: 'reward_account',
        parse:
            (e) => NnsGovernanceAccountIdentifier.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceNodeProvider.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNodeProvider.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Ok`.
final class NnsGovernanceOk with CandidSerializable {
  final NnsGovernanceNeuronsFundAuditInfo? neuronsFundAuditInfo;

  const NnsGovernanceOk({this.neuronsFundAuditInfo});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('neurons_fund_audit_info'),
      () => CType.opt(NnsGovernanceNeuronsFundAuditInfo.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'neurons_fund_audit_info': neuronsFundAuditInfo?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'neurons_fund_audit_info': neuronsFundAuditInfo?.toJson(),
  };

  factory NnsGovernanceOk.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceOk(
      neuronsFundAuditInfo: json
          .valueTo<NnsGovernanceNeuronsFundAuditInfo?, Map>(
            key: 'neurons_fund_audit_info',
            parse:
                (e) => NnsGovernanceNeuronsFundAuditInfo.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceOk.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceOk.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Ok_1`.
final class NnsGovernanceOk1 with CandidSerializable {
  final List<NnsGovernanceNeuronsFundNeuron> neuronsFundNeuronPortions;

  const NnsGovernanceOk1({required this.neuronsFundNeuronPortions});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('neurons_fund_neuron_portions'),
      () => CType.vec(NnsGovernanceNeuronsFundNeuron.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'neurons_fund_neuron_portions':
        neuronsFundNeuronPortions.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'neurons_fund_neuron_portions':
        neuronsFundNeuronPortions.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceOk1.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceOk1(
      neuronsFundNeuronPortions: json
          .valueTo<List<NnsGovernanceNeuronsFundNeuron>, List>(
            key: 'neurons_fund_neuron_portions',
            parse:
                (e) =>
                    e
                        .map<NnsGovernanceNeuronsFundNeuron>(
                          (x) => NnsGovernanceNeuronsFundNeuron.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsGovernanceOk1.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceOk1.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `OpenSnsTokenSwap`.
final class NnsGovernanceOpenSnsTokenSwap with CandidSerializable {
  final BigInt? communityFundInvestmentE8s;
  final IcpPrincipalAddress? targetSwapCanisterId;
  final NnsGovernanceParams? params;

  const NnsGovernanceOpenSnsTokenSwap({
    this.communityFundInvestmentE8s,
    this.targetSwapCanisterId,
    this.params,
  });

  static CType get ctype => CType.record([
    Field(Label.named('community_fund_investment_e8s'), CType.opt(CType.nat64)),
    Field(Label.named('target_swap_canister_id'), CType.opt(CType.principal)),
    LazyField(
      Label.named('params'),
      () => CType.opt(NnsGovernanceParams.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'community_fund_investment_e8s': communityFundInvestmentE8s,
    'target_swap_canister_id': targetSwapCanisterId,
    'params': params?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'community_fund_investment_e8s': communityFundInvestmentE8s,
    'target_swap_canister_id': targetSwapCanisterId?.address,
    'params': params?.toJson(),
  };

  factory NnsGovernanceOpenSnsTokenSwap.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceOpenSnsTokenSwap(
      communityFundInvestmentE8s: json.valueAsBigInt<BigInt?>(
        'community_fund_investment_e8s',
      ),
      targetSwapCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'target_swap_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      params: json.valueTo<NnsGovernanceParams?, Map>(
        key: 'params',
        parse:
            (e) => NnsGovernanceParams.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceOpenSnsTokenSwap.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceOpenSnsTokenSwap.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Operation`.
sealed class NnsGovernanceOperation with CandidSerializable {
  const NnsGovernanceOperation();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('RemoveHotKey'),
      () => NnsGovernanceRemoveHotKey.ctype,
    ),
    LazyField(Label.named('AddHotKey'), () => NnsGovernanceAddHotKey.ctype),
    LazyField(
      Label.named('ChangeAutoStakeMaturity'),
      () => NnsGovernanceChangeAutoStakeMaturity.ctype,
    ),
    Field(Label.named('StopDissolving'), CType.record(const [])),
    Field(Label.named('StartDissolving'), CType.record(const [])),
    LazyField(
      Label.named('IncreaseDissolveDelay'),
      () => NnsGovernanceIncreaseDissolveDelay.ctype,
    ),
    LazyField(
      Label.named('SetVisibility'),
      () => NnsGovernanceSetVisibility.ctype,
    ),
    Field(Label.named('JoinCommunityFund'), CType.record(const [])),
    Field(Label.named('LeaveCommunityFund'), CType.record(const [])),
    LazyField(
      Label.named('SetDissolveTimestamp'),
      () => NnsGovernanceSetDissolveTimestamp.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceOperation.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('RemoveHotKey')) {
      return NnsGovernanceOperationRemoveHotKey(
        json.valueTo<NnsGovernanceRemoveHotKey, Map>(
          key: 'RemoveHotKey',
          parse:
              (e) => NnsGovernanceRemoveHotKey.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('AddHotKey')) {
      return NnsGovernanceOperationAddHotKey(
        json.valueTo<NnsGovernanceAddHotKey, Map>(
          key: 'AddHotKey',
          parse:
              (e) => NnsGovernanceAddHotKey.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ChangeAutoStakeMaturity')) {
      return NnsGovernanceOperationChangeAutoStakeMaturity(
        json.valueTo<NnsGovernanceChangeAutoStakeMaturity, Map>(
          key: 'ChangeAutoStakeMaturity',
          parse:
              (e) => NnsGovernanceChangeAutoStakeMaturity.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('StopDissolving')) {
      return NnsGovernanceOperationStopDissolving.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['StopDissolving']),
      );
    }
    if (json.containsKey('StartDissolving')) {
      return NnsGovernanceOperationStartDissolving.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['StartDissolving']),
      );
    }
    if (json.containsKey('IncreaseDissolveDelay')) {
      return NnsGovernanceOperationIncreaseDissolveDelay(
        json.valueTo<NnsGovernanceIncreaseDissolveDelay, Map>(
          key: 'IncreaseDissolveDelay',
          parse:
              (e) => NnsGovernanceIncreaseDissolveDelay.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('SetVisibility')) {
      return NnsGovernanceOperationSetVisibility(
        json.valueTo<NnsGovernanceSetVisibility, Map>(
          key: 'SetVisibility',
          parse:
              (e) => NnsGovernanceSetVisibility.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('JoinCommunityFund')) {
      return NnsGovernanceOperationJoinCommunityFund.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['JoinCommunityFund']),
      );
    }
    if (json.containsKey('LeaveCommunityFund')) {
      return NnsGovernanceOperationLeaveCommunityFund.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['LeaveCommunityFund'],
        ),
      );
    }
    if (json.containsKey('SetDissolveTimestamp')) {
      return NnsGovernanceOperationSetDissolveTimestamp(
        json.valueTo<NnsGovernanceSetDissolveTimestamp, Map>(
          key: 'SetDissolveTimestamp',
          parse:
              (e) => NnsGovernanceSetDissolveTimestamp.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceOperation.fromCandid',
      reason: 'Unknown NnsGovernanceOperation arm',
    );
  }

  factory NnsGovernanceOperation.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceOperation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Operation.RemoveHotKey`.
final class NnsGovernanceOperationRemoveHotKey extends NnsGovernanceOperation {
  final NnsGovernanceRemoveHotKey value;
  const NnsGovernanceOperationRemoveHotKey(this.value);

  @override
  CType get candidType => NnsGovernanceOperation.ctype;

  @override
  dynamic get candidValue => Variant('RemoveHotKey', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RemoveHotKey': value.toJson()};
}

/// Variant arm `Operation.AddHotKey`.
final class NnsGovernanceOperationAddHotKey extends NnsGovernanceOperation {
  final NnsGovernanceAddHotKey value;
  const NnsGovernanceOperationAddHotKey(this.value);

  @override
  CType get candidType => NnsGovernanceOperation.ctype;

  @override
  dynamic get candidValue => Variant('AddHotKey', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'AddHotKey': value.toJson()};
}

/// Variant arm `Operation.ChangeAutoStakeMaturity`.
final class NnsGovernanceOperationChangeAutoStakeMaturity
    extends NnsGovernanceOperation {
  final NnsGovernanceChangeAutoStakeMaturity value;
  const NnsGovernanceOperationChangeAutoStakeMaturity(this.value);

  @override
  CType get candidType => NnsGovernanceOperation.ctype;

  @override
  dynamic get candidValue =>
      Variant('ChangeAutoStakeMaturity', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ChangeAutoStakeMaturity': value.toJson()};
}

/// Variant arm `Operation.StopDissolving`.
final class NnsGovernanceOperationStopDissolving
    extends NnsGovernanceOperation {
  const NnsGovernanceOperationStopDissolving();

  @override
  CType get candidType => NnsGovernanceOperation.ctype;

  @override
  dynamic get candidValue => Variant('StopDissolving', {});

  @override
  Map<String, dynamic> toJson() => {'StopDissolving': {}};

  factory NnsGovernanceOperationStopDissolving.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceOperationStopDissolving();
  }
}

/// Variant arm `Operation.StartDissolving`.
final class NnsGovernanceOperationStartDissolving
    extends NnsGovernanceOperation {
  const NnsGovernanceOperationStartDissolving();

  @override
  CType get candidType => NnsGovernanceOperation.ctype;

  @override
  dynamic get candidValue => Variant('StartDissolving', {});

  @override
  Map<String, dynamic> toJson() => {'StartDissolving': {}};

  factory NnsGovernanceOperationStartDissolving.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceOperationStartDissolving();
  }
}

/// Variant arm `Operation.IncreaseDissolveDelay`.
final class NnsGovernanceOperationIncreaseDissolveDelay
    extends NnsGovernanceOperation {
  final NnsGovernanceIncreaseDissolveDelay value;
  const NnsGovernanceOperationIncreaseDissolveDelay(this.value);

  @override
  CType get candidType => NnsGovernanceOperation.ctype;

  @override
  dynamic get candidValue =>
      Variant('IncreaseDissolveDelay', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'IncreaseDissolveDelay': value.toJson()};
}

/// Variant arm `Operation.SetVisibility`.
final class NnsGovernanceOperationSetVisibility extends NnsGovernanceOperation {
  final NnsGovernanceSetVisibility value;
  const NnsGovernanceOperationSetVisibility(this.value);

  @override
  CType get candidType => NnsGovernanceOperation.ctype;

  @override
  dynamic get candidValue => Variant('SetVisibility', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'SetVisibility': value.toJson()};
}

/// Variant arm `Operation.JoinCommunityFund`.
final class NnsGovernanceOperationJoinCommunityFund
    extends NnsGovernanceOperation {
  const NnsGovernanceOperationJoinCommunityFund();

  @override
  CType get candidType => NnsGovernanceOperation.ctype;

  @override
  dynamic get candidValue => Variant('JoinCommunityFund', {});

  @override
  Map<String, dynamic> toJson() => {'JoinCommunityFund': {}};

  factory NnsGovernanceOperationJoinCommunityFund.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceOperationJoinCommunityFund();
  }
}

/// Variant arm `Operation.LeaveCommunityFund`.
final class NnsGovernanceOperationLeaveCommunityFund
    extends NnsGovernanceOperation {
  const NnsGovernanceOperationLeaveCommunityFund();

  @override
  CType get candidType => NnsGovernanceOperation.ctype;

  @override
  dynamic get candidValue => Variant('LeaveCommunityFund', {});

  @override
  Map<String, dynamic> toJson() => {'LeaveCommunityFund': {}};

  factory NnsGovernanceOperationLeaveCommunityFund.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceOperationLeaveCommunityFund();
  }
}

/// Variant arm `Operation.SetDissolveTimestamp`.
final class NnsGovernanceOperationSetDissolveTimestamp
    extends NnsGovernanceOperation {
  final NnsGovernanceSetDissolveTimestamp value;
  const NnsGovernanceOperationSetDissolveTimestamp(this.value);

  @override
  CType get candidType => NnsGovernanceOperation.ctype;

  @override
  dynamic get candidValue => Variant('SetDissolveTimestamp', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'SetDissolveTimestamp': value.toJson()};
}

/// Candid record `Params`.
final class NnsGovernanceParams with CandidSerializable {
  final BigInt minParticipantIcpE8s;
  final NnsGovernanceNeuronBasketConstructionParameters1?
  neuronBasketConstructionParameters;
  final BigInt maxIcpE8s;
  final BigInt swapDueTimestampSeconds;
  final int minParticipants;
  final BigInt snsTokenE8s;
  final BigInt? saleDelaySeconds;
  final BigInt maxParticipantIcpE8s;
  final BigInt? minDirectParticipationIcpE8s;
  final BigInt minIcpE8s;
  final BigInt? maxDirectParticipationIcpE8s;

  const NnsGovernanceParams({
    required this.minParticipantIcpE8s,
    this.neuronBasketConstructionParameters,
    required this.maxIcpE8s,
    required this.swapDueTimestampSeconds,
    required this.minParticipants,
    required this.snsTokenE8s,
    this.saleDelaySeconds,
    required this.maxParticipantIcpE8s,
    this.minDirectParticipationIcpE8s,
    required this.minIcpE8s,
    this.maxDirectParticipationIcpE8s,
  });

  static CType get ctype => CType.record([
    Field(Label.named('min_participant_icp_e8s'), CType.nat64),
    LazyField(
      Label.named('neuron_basket_construction_parameters'),
      () => CType.opt(NnsGovernanceNeuronBasketConstructionParameters1.ctype),
    ),
    Field(Label.named('max_icp_e8s'), CType.nat64),
    Field(Label.named('swap_due_timestamp_seconds'), CType.nat64),
    Field(Label.named('min_participants'), CType.nat32),
    Field(Label.named('sns_token_e8s'), CType.nat64),
    Field(Label.named('sale_delay_seconds'), CType.opt(CType.nat64)),
    Field(Label.named('max_participant_icp_e8s'), CType.nat64),
    Field(
      Label.named('min_direct_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('min_icp_e8s'), CType.nat64),
    Field(
      Label.named('max_direct_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'min_participant_icp_e8s': minParticipantIcpE8s,
    'neuron_basket_construction_parameters':
        neuronBasketConstructionParameters?.candidValue,
    'max_icp_e8s': maxIcpE8s,
    'swap_due_timestamp_seconds': swapDueTimestampSeconds,
    'min_participants': minParticipants,
    'sns_token_e8s': snsTokenE8s,
    'sale_delay_seconds': saleDelaySeconds,
    'max_participant_icp_e8s': maxParticipantIcpE8s,
    'min_direct_participation_icp_e8s': minDirectParticipationIcpE8s,
    'min_icp_e8s': minIcpE8s,
    'max_direct_participation_icp_e8s': maxDirectParticipationIcpE8s,
  };

  Map<String, dynamic> toJson() => {
    'min_participant_icp_e8s': minParticipantIcpE8s,
    'neuron_basket_construction_parameters':
        neuronBasketConstructionParameters?.toJson(),
    'max_icp_e8s': maxIcpE8s,
    'swap_due_timestamp_seconds': swapDueTimestampSeconds,
    'min_participants': minParticipants,
    'sns_token_e8s': snsTokenE8s,
    'sale_delay_seconds': saleDelaySeconds,
    'max_participant_icp_e8s': maxParticipantIcpE8s,
    'min_direct_participation_icp_e8s': minDirectParticipationIcpE8s,
    'min_icp_e8s': minIcpE8s,
    'max_direct_participation_icp_e8s': maxDirectParticipationIcpE8s,
  };

  factory NnsGovernanceParams.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceParams(
      minParticipantIcpE8s: json.valueAsBigInt<BigInt>(
        'min_participant_icp_e8s',
      ),
      neuronBasketConstructionParameters: json
          .valueTo<NnsGovernanceNeuronBasketConstructionParameters1?, Map>(
            key: 'neuron_basket_construction_parameters',
            parse:
                (e) =>
                    NnsGovernanceNeuronBasketConstructionParameters1.fromCandid(
                      JsonParser.valueEnsureAsMap<String, dynamic>(e),
                    ),
          ),
      maxIcpE8s: json.valueAsBigInt<BigInt>('max_icp_e8s'),
      swapDueTimestampSeconds: json.valueAsBigInt<BigInt>(
        'swap_due_timestamp_seconds',
      ),
      minParticipants: json.valueAsInt<int>('min_participants'),
      snsTokenE8s: json.valueAsBigInt<BigInt>('sns_token_e8s'),
      saleDelaySeconds: json.valueAsBigInt<BigInt?>('sale_delay_seconds'),
      maxParticipantIcpE8s: json.valueAsBigInt<BigInt>(
        'max_participant_icp_e8s',
      ),
      minDirectParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'min_direct_participation_icp_e8s',
      ),
      minIcpE8s: json.valueAsBigInt<BigInt>('min_icp_e8s'),
      maxDirectParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'max_direct_participation_icp_e8s',
      ),
    );
  }

  factory NnsGovernanceParams.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceParams.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Percentage`.
final class NnsGovernancePercentage with CandidSerializable {
  final BigInt? basisPoints;

  const NnsGovernancePercentage({this.basisPoints});

  static CType get ctype => CType.record([
    Field(Label.named('basis_points'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'basis_points': basisPoints};

  Map<String, dynamic> toJson() => {'basis_points': basisPoints};

  factory NnsGovernancePercentage.fromCandid(Map<String, dynamic> json) {
    return NnsGovernancePercentage(
      basisPoints: json.valueAsBigInt<BigInt?>('basis_points'),
    );
  }

  factory NnsGovernancePercentage.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernancePercentage.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Principals`.
final class NnsGovernancePrincipals with CandidSerializable {
  final List<IcpPrincipalAddress> principals;

  const NnsGovernancePrincipals({required this.principals});

  static CType get ctype => CType.record([
    Field(Label.named('principals'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'principals': principals};

  Map<String, dynamic> toJson() => {
    'principals': principals.map((el) => el.address).toList(),
  };

  factory NnsGovernancePrincipals.fromCandid(Map<String, dynamic> json) {
    return NnsGovernancePrincipals(
      principals: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'principals',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernancePrincipals.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernancePrincipals.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Proposal`.
final class NnsGovernanceProposal with CandidSerializable {
  final String url;
  final String? title;
  final NnsGovernanceAction? action;
  final String summary;
  final NnsGovernanceSelfDescribingProposalAction? selfDescribingAction;

  const NnsGovernanceProposal({
    required this.url,
    this.title,
    this.action,
    required this.summary,
    this.selfDescribingAction,
  });

  static CType get ctype => CType.record([
    Field(Label.named('url'), CType.text),
    Field(Label.named('title'), CType.opt(CType.text)),
    LazyField(
      Label.named('action'),
      () => CType.opt(NnsGovernanceAction.ctype),
    ),
    Field(Label.named('summary'), CType.text),
    LazyField(
      Label.named('self_describing_action'),
      () => CType.opt(NnsGovernanceSelfDescribingProposalAction.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'url': url,
    'title': title,
    'action': action?.candidValue,
    'summary': summary,
    'self_describing_action': selfDescribingAction?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'url': url,
    'title': title,
    'action': action?.toJson(),
    'summary': summary,
    'self_describing_action': selfDescribingAction?.toJson(),
  };

  factory NnsGovernanceProposal.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceProposal(
      url: json.valueAsString<String>('url'),
      title: json.valueAsString<String?>('title'),
      action: json.valueTo<NnsGovernanceAction?, Map>(
        key: 'action',
        parse:
            (e) => NnsGovernanceAction.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      summary: json.valueAsString<String>('summary'),
      selfDescribingAction: json
          .valueTo<NnsGovernanceSelfDescribingProposalAction?, Map>(
            key: 'self_describing_action',
            parse:
                (e) => NnsGovernanceSelfDescribingProposalAction.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceProposal.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceProposal.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ProposalActionRequest`.
sealed class NnsGovernanceProposalActionRequest with CandidSerializable {
  const NnsGovernanceProposalActionRequest();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('RegisterKnownNeuron'),
      () => NnsGovernanceKnownNeuron.ctype,
    ),
    LazyField(
      Label.named('DeregisterKnownNeuron'),
      () => NnsGovernanceDeregisterKnownNeuron.ctype,
    ),
    LazyField(
      Label.named('ManageNeuron'),
      () => NnsGovernanceManageNeuronRequest.ctype,
    ),
    LazyField(
      Label.named('UpdateCanisterSettings'),
      () => NnsGovernanceUpdateCanisterSettings.ctype,
    ),
    LazyField(
      Label.named('InstallCode'),
      () => NnsGovernanceInstallCodeRequest.ctype,
    ),
    LazyField(
      Label.named('StopOrStartCanister'),
      () => NnsGovernanceStopOrStartCanister.ctype,
    ),
    LazyField(
      Label.named('CreateServiceNervousSystem'),
      () => NnsGovernanceCreateServiceNervousSystem.ctype,
    ),
    LazyField(
      Label.named('ExecuteNnsFunction'),
      () => NnsGovernanceExecuteNnsFunction.ctype,
    ),
    LazyField(
      Label.named('RewardNodeProvider'),
      () => NnsGovernanceRewardNodeProvider.ctype,
    ),
    LazyField(
      Label.named('RewardNodeProviders'),
      () => NnsGovernanceRewardNodeProviders.ctype,
    ),
    LazyField(
      Label.named('ManageNetworkEconomics'),
      () => NnsGovernanceNetworkEconomics.ctype,
    ),
    LazyField(
      Label.named('ApproveGenesisKyc'),
      () => NnsGovernancePrincipals.ctype,
    ),
    LazyField(
      Label.named('AddOrRemoveNodeProvider'),
      () => NnsGovernanceAddOrRemoveNodeProvider.ctype,
    ),
    LazyField(Label.named('Motion'), () => NnsGovernanceMotion.ctype),
    LazyField(
      Label.named('FulfillSubnetRentalRequest'),
      () => NnsGovernanceFulfillSubnetRentalRequest.ctype,
    ),
    LazyField(
      Label.named('BlessAlternativeGuestOsVersion'),
      () => NnsGovernanceBlessAlternativeGuestOsVersion.ctype,
    ),
    LazyField(
      Label.named('TakeCanisterSnapshot'),
      () => NnsGovernanceTakeCanisterSnapshot.ctype,
    ),
    LazyField(
      Label.named('LoadCanisterSnapshot'),
      () => NnsGovernanceLoadCanisterSnapshot.ctype,
    ),
    LazyField(
      Label.named('CreateCanisterAndInstallCode'),
      () => NnsGovernanceCreateCanisterAndInstallCodeRequest.ctype,
    ),
    LazyField(
      Label.named('UpdateStandardEngineReplicaVersion'),
      () => NnsGovernanceUpdateStandardEngineReplicaVersion.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceProposalActionRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('RegisterKnownNeuron')) {
      return NnsGovernanceProposalActionRequestRegisterKnownNeuron(
        json.valueTo<NnsGovernanceKnownNeuron, Map>(
          key: 'RegisterKnownNeuron',
          parse:
              (e) => NnsGovernanceKnownNeuron.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DeregisterKnownNeuron')) {
      return NnsGovernanceProposalActionRequestDeregisterKnownNeuron(
        json.valueTo<NnsGovernanceDeregisterKnownNeuron, Map>(
          key: 'DeregisterKnownNeuron',
          parse:
              (e) => NnsGovernanceDeregisterKnownNeuron.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ManageNeuron')) {
      return NnsGovernanceProposalActionRequestManageNeuron(
        json.valueTo<NnsGovernanceManageNeuronRequest, Map>(
          key: 'ManageNeuron',
          parse:
              (e) => NnsGovernanceManageNeuronRequest.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('UpdateCanisterSettings')) {
      return NnsGovernanceProposalActionRequestUpdateCanisterSettings(
        json.valueTo<NnsGovernanceUpdateCanisterSettings, Map>(
          key: 'UpdateCanisterSettings',
          parse:
              (e) => NnsGovernanceUpdateCanisterSettings.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('InstallCode')) {
      return NnsGovernanceProposalActionRequestInstallCode(
        json.valueTo<NnsGovernanceInstallCodeRequest, Map>(
          key: 'InstallCode',
          parse:
              (e) => NnsGovernanceInstallCodeRequest.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('StopOrStartCanister')) {
      return NnsGovernanceProposalActionRequestStopOrStartCanister(
        json.valueTo<NnsGovernanceStopOrStartCanister, Map>(
          key: 'StopOrStartCanister',
          parse:
              (e) => NnsGovernanceStopOrStartCanister.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('CreateServiceNervousSystem')) {
      return NnsGovernanceProposalActionRequestCreateServiceNervousSystem(
        json.valueTo<NnsGovernanceCreateServiceNervousSystem, Map>(
          key: 'CreateServiceNervousSystem',
          parse:
              (e) => NnsGovernanceCreateServiceNervousSystem.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ExecuteNnsFunction')) {
      return NnsGovernanceProposalActionRequestExecuteNnsFunction(
        json.valueTo<NnsGovernanceExecuteNnsFunction, Map>(
          key: 'ExecuteNnsFunction',
          parse:
              (e) => NnsGovernanceExecuteNnsFunction.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('RewardNodeProvider')) {
      return NnsGovernanceProposalActionRequestRewardNodeProvider(
        json.valueTo<NnsGovernanceRewardNodeProvider, Map>(
          key: 'RewardNodeProvider',
          parse:
              (e) => NnsGovernanceRewardNodeProvider.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('RewardNodeProviders')) {
      return NnsGovernanceProposalActionRequestRewardNodeProviders(
        json.valueTo<NnsGovernanceRewardNodeProviders, Map>(
          key: 'RewardNodeProviders',
          parse:
              (e) => NnsGovernanceRewardNodeProviders.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ManageNetworkEconomics')) {
      return NnsGovernanceProposalActionRequestManageNetworkEconomics(
        json.valueTo<NnsGovernanceNetworkEconomics, Map>(
          key: 'ManageNetworkEconomics',
          parse:
              (e) => NnsGovernanceNetworkEconomics.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ApproveGenesisKyc')) {
      return NnsGovernanceProposalActionRequestApproveGenesisKyc(
        json.valueTo<NnsGovernancePrincipals, Map>(
          key: 'ApproveGenesisKyc',
          parse:
              (e) => NnsGovernancePrincipals.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('AddOrRemoveNodeProvider')) {
      return NnsGovernanceProposalActionRequestAddOrRemoveNodeProvider(
        json.valueTo<NnsGovernanceAddOrRemoveNodeProvider, Map>(
          key: 'AddOrRemoveNodeProvider',
          parse:
              (e) => NnsGovernanceAddOrRemoveNodeProvider.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Motion')) {
      return NnsGovernanceProposalActionRequestMotion(
        json.valueTo<NnsGovernanceMotion, Map>(
          key: 'Motion',
          parse:
              (e) => NnsGovernanceMotion.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('FulfillSubnetRentalRequest')) {
      return NnsGovernanceProposalActionRequestFulfillSubnetRentalRequest(
        json.valueTo<NnsGovernanceFulfillSubnetRentalRequest, Map>(
          key: 'FulfillSubnetRentalRequest',
          parse:
              (e) => NnsGovernanceFulfillSubnetRentalRequest.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('BlessAlternativeGuestOsVersion')) {
      return NnsGovernanceProposalActionRequestBlessAlternativeGuestOsVersion(
        json.valueTo<NnsGovernanceBlessAlternativeGuestOsVersion, Map>(
          key: 'BlessAlternativeGuestOsVersion',
          parse:
              (e) => NnsGovernanceBlessAlternativeGuestOsVersion.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('TakeCanisterSnapshot')) {
      return NnsGovernanceProposalActionRequestTakeCanisterSnapshot(
        json.valueTo<NnsGovernanceTakeCanisterSnapshot, Map>(
          key: 'TakeCanisterSnapshot',
          parse:
              (e) => NnsGovernanceTakeCanisterSnapshot.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('LoadCanisterSnapshot')) {
      return NnsGovernanceProposalActionRequestLoadCanisterSnapshot(
        json.valueTo<NnsGovernanceLoadCanisterSnapshot, Map>(
          key: 'LoadCanisterSnapshot',
          parse:
              (e) => NnsGovernanceLoadCanisterSnapshot.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('CreateCanisterAndInstallCode')) {
      return NnsGovernanceProposalActionRequestCreateCanisterAndInstallCode(
        json.valueTo<NnsGovernanceCreateCanisterAndInstallCodeRequest, Map>(
          key: 'CreateCanisterAndInstallCode',
          parse:
              (e) =>
                  NnsGovernanceCreateCanisterAndInstallCodeRequest.fromCandid(
                    JsonParser.valueEnsureAsMap<String, dynamic>(e),
                  ),
        ),
      );
    }
    if (json.containsKey('UpdateStandardEngineReplicaVersion')) {
      return NnsGovernanceProposalActionRequestUpdateStandardEngineReplicaVersion(
        json.valueTo<NnsGovernanceUpdateStandardEngineReplicaVersion, Map>(
          key: 'UpdateStandardEngineReplicaVersion',
          parse:
              (e) => NnsGovernanceUpdateStandardEngineReplicaVersion.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceProposalActionRequest.fromCandid',
      reason: 'Unknown NnsGovernanceProposalActionRequest arm',
    );
  }

  factory NnsGovernanceProposalActionRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceProposalActionRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ProposalActionRequest.RegisterKnownNeuron`.
final class NnsGovernanceProposalActionRequestRegisterKnownNeuron
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceKnownNeuron value;
  const NnsGovernanceProposalActionRequestRegisterKnownNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('RegisterKnownNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RegisterKnownNeuron': value.toJson()};
}

/// Variant arm `ProposalActionRequest.DeregisterKnownNeuron`.
final class NnsGovernanceProposalActionRequestDeregisterKnownNeuron
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceDeregisterKnownNeuron value;
  const NnsGovernanceProposalActionRequestDeregisterKnownNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue =>
      Variant('DeregisterKnownNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DeregisterKnownNeuron': value.toJson()};
}

/// Variant arm `ProposalActionRequest.ManageNeuron`.
final class NnsGovernanceProposalActionRequestManageNeuron
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceManageNeuronRequest value;
  const NnsGovernanceProposalActionRequestManageNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('ManageNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ManageNeuron': value.toJson()};
}

/// Variant arm `ProposalActionRequest.UpdateCanisterSettings`.
final class NnsGovernanceProposalActionRequestUpdateCanisterSettings
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceUpdateCanisterSettings value;
  const NnsGovernanceProposalActionRequestUpdateCanisterSettings(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue =>
      Variant('UpdateCanisterSettings', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'UpdateCanisterSettings': value.toJson()};
}

/// Variant arm `ProposalActionRequest.InstallCode`.
final class NnsGovernanceProposalActionRequestInstallCode
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceInstallCodeRequest value;
  const NnsGovernanceProposalActionRequestInstallCode(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('InstallCode', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'InstallCode': value.toJson()};
}

/// Variant arm `ProposalActionRequest.StopOrStartCanister`.
final class NnsGovernanceProposalActionRequestStopOrStartCanister
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceStopOrStartCanister value;
  const NnsGovernanceProposalActionRequestStopOrStartCanister(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('StopOrStartCanister', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'StopOrStartCanister': value.toJson()};
}

/// Variant arm `ProposalActionRequest.CreateServiceNervousSystem`.
final class NnsGovernanceProposalActionRequestCreateServiceNervousSystem
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceCreateServiceNervousSystem value;
  const NnsGovernanceProposalActionRequestCreateServiceNervousSystem(
    this.value,
  );

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreateServiceNervousSystem', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'CreateServiceNervousSystem': value.toJson(),
  };
}

/// Variant arm `ProposalActionRequest.ExecuteNnsFunction`.
final class NnsGovernanceProposalActionRequestExecuteNnsFunction
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceExecuteNnsFunction value;
  const NnsGovernanceProposalActionRequestExecuteNnsFunction(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('ExecuteNnsFunction', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ExecuteNnsFunction': value.toJson()};
}

/// Variant arm `ProposalActionRequest.RewardNodeProvider`.
final class NnsGovernanceProposalActionRequestRewardNodeProvider
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceRewardNodeProvider value;
  const NnsGovernanceProposalActionRequestRewardNodeProvider(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('RewardNodeProvider', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RewardNodeProvider': value.toJson()};
}

/// Variant arm `ProposalActionRequest.RewardNodeProviders`.
final class NnsGovernanceProposalActionRequestRewardNodeProviders
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceRewardNodeProviders value;
  const NnsGovernanceProposalActionRequestRewardNodeProviders(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('RewardNodeProviders', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RewardNodeProviders': value.toJson()};
}

/// Variant arm `ProposalActionRequest.ManageNetworkEconomics`.
final class NnsGovernanceProposalActionRequestManageNetworkEconomics
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceNetworkEconomics value;
  const NnsGovernanceProposalActionRequestManageNetworkEconomics(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue =>
      Variant('ManageNetworkEconomics', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ManageNetworkEconomics': value.toJson()};
}

/// Variant arm `ProposalActionRequest.ApproveGenesisKyc`.
final class NnsGovernanceProposalActionRequestApproveGenesisKyc
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernancePrincipals value;
  const NnsGovernanceProposalActionRequestApproveGenesisKyc(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('ApproveGenesisKyc', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'ApproveGenesisKyc': value.toJson()};
}

/// Variant arm `ProposalActionRequest.AddOrRemoveNodeProvider`.
final class NnsGovernanceProposalActionRequestAddOrRemoveNodeProvider
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceAddOrRemoveNodeProvider value;
  const NnsGovernanceProposalActionRequestAddOrRemoveNodeProvider(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue =>
      Variant('AddOrRemoveNodeProvider', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'AddOrRemoveNodeProvider': value.toJson()};
}

/// Variant arm `ProposalActionRequest.Motion`.
final class NnsGovernanceProposalActionRequestMotion
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceMotion value;
  const NnsGovernanceProposalActionRequestMotion(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('Motion', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Motion': value.toJson()};
}

/// Variant arm `ProposalActionRequest.FulfillSubnetRentalRequest`.
final class NnsGovernanceProposalActionRequestFulfillSubnetRentalRequest
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceFulfillSubnetRentalRequest value;
  const NnsGovernanceProposalActionRequestFulfillSubnetRentalRequest(
    this.value,
  );

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue =>
      Variant('FulfillSubnetRentalRequest', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'FulfillSubnetRentalRequest': value.toJson(),
  };
}

/// Variant arm `ProposalActionRequest.BlessAlternativeGuestOsVersion`.
final class NnsGovernanceProposalActionRequestBlessAlternativeGuestOsVersion
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceBlessAlternativeGuestOsVersion value;
  const NnsGovernanceProposalActionRequestBlessAlternativeGuestOsVersion(
    this.value,
  );

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue =>
      Variant('BlessAlternativeGuestOsVersion', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'BlessAlternativeGuestOsVersion': value.toJson(),
  };
}

/// Variant arm `ProposalActionRequest.TakeCanisterSnapshot`.
final class NnsGovernanceProposalActionRequestTakeCanisterSnapshot
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceTakeCanisterSnapshot value;
  const NnsGovernanceProposalActionRequestTakeCanisterSnapshot(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('TakeCanisterSnapshot', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'TakeCanisterSnapshot': value.toJson()};
}

/// Variant arm `ProposalActionRequest.LoadCanisterSnapshot`.
final class NnsGovernanceProposalActionRequestLoadCanisterSnapshot
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceLoadCanisterSnapshot value;
  const NnsGovernanceProposalActionRequestLoadCanisterSnapshot(this.value);

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue => Variant('LoadCanisterSnapshot', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'LoadCanisterSnapshot': value.toJson()};
}

/// Variant arm `ProposalActionRequest.CreateCanisterAndInstallCode`.
final class NnsGovernanceProposalActionRequestCreateCanisterAndInstallCode
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceCreateCanisterAndInstallCodeRequest value;
  const NnsGovernanceProposalActionRequestCreateCanisterAndInstallCode(
    this.value,
  );

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreateCanisterAndInstallCode', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'CreateCanisterAndInstallCode': value.toJson(),
  };
}

/// Variant arm `ProposalActionRequest.UpdateStandardEngineReplicaVersion`.
final class NnsGovernanceProposalActionRequestUpdateStandardEngineReplicaVersion
    extends NnsGovernanceProposalActionRequest {
  final NnsGovernanceUpdateStandardEngineReplicaVersion value;
  const NnsGovernanceProposalActionRequestUpdateStandardEngineReplicaVersion(
    this.value,
  );

  @override
  CType get candidType => NnsGovernanceProposalActionRequest.ctype;

  @override
  dynamic get candidValue =>
      Variant('UpdateStandardEngineReplicaVersion', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'UpdateStandardEngineReplicaVersion': value.toJson(),
  };
}

/// Candid record `FulfillSubnetRentalRequest`.
final class NnsGovernanceFulfillSubnetRentalRequest with CandidSerializable {
  final IcpPrincipalAddress? user;
  final List<IcpPrincipalAddress>? nodeIds;
  final String? replicaVersionId;
  final IcpPrincipalAddress? initialDkgSubnetId;

  const NnsGovernanceFulfillSubnetRentalRequest({
    this.user,
    this.nodeIds,
    this.replicaVersionId,
    this.initialDkgSubnetId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('user'), CType.opt(CType.principal)),
    Field(Label.named('node_ids'), CType.opt(CType.vec(CType.principal))),
    Field(Label.named('replica_version_id'), CType.opt(CType.text)),
    Field(Label.named('initial_dkg_subnet_id'), CType.opt(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'user': user,
    'node_ids': nodeIds,
    'replica_version_id': replicaVersionId,
    'initial_dkg_subnet_id': initialDkgSubnetId,
  };

  Map<String, dynamic> toJson() => {
    'user': user?.address,
    'node_ids': nodeIds?.map((el) => el.address).toList(),
    'replica_version_id': replicaVersionId,
    'initial_dkg_subnet_id': initialDkgSubnetId?.address,
  };

  factory NnsGovernanceFulfillSubnetRentalRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceFulfillSubnetRentalRequest(
      user: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'user',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      nodeIds: json.valueTo<List<IcpPrincipalAddress>?, List>(
        key: 'node_ids',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      replicaVersionId: json.valueAsString<String?>('replica_version_id'),
      initialDkgSubnetId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'initial_dkg_subnet_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsGovernanceFulfillSubnetRentalRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceFulfillSubnetRentalRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `BlessAlternativeGuestOsVersion`.
final class NnsGovernanceBlessAlternativeGuestOsVersion
    with CandidSerializable {
  final List<int>? chipIds;
  final String? rootfsHash;
  final NnsGovernanceGuestLaunchMeasurements? baseGuestLaunchMeasurements;

  const NnsGovernanceBlessAlternativeGuestOsVersion({
    this.chipIds,
    this.rootfsHash,
    this.baseGuestLaunchMeasurements,
  });

  static CType get ctype => CType.record([
    Field(Label.named('chip_ids'), CType.opt(CType.vec(CType.vec(CType.nat8)))),
    Field(Label.named('rootfs_hash'), CType.opt(CType.text)),
    LazyField(
      Label.named('base_guest_launch_measurements'),
      () => CType.opt(NnsGovernanceGuestLaunchMeasurements.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'chip_ids': chipIds,
    'rootfs_hash': rootfsHash,
    'base_guest_launch_measurements': baseGuestLaunchMeasurements?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'chip_ids': chipIds,
    'rootfs_hash': rootfsHash,
    'base_guest_launch_measurements': baseGuestLaunchMeasurements?.toJson(),
  };

  factory NnsGovernanceBlessAlternativeGuestOsVersion.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceBlessAlternativeGuestOsVersion(
      chipIds: json.valueAsBytes<List<int>?>(
        'chip_ids',
        encoding: StringEncoding.base64,
      ),
      rootfsHash: json.valueAsString<String?>('rootfs_hash'),
      baseGuestLaunchMeasurements: json
          .valueTo<NnsGovernanceGuestLaunchMeasurements?, Map>(
            key: 'base_guest_launch_measurements',
            parse:
                (e) => NnsGovernanceGuestLaunchMeasurements.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceBlessAlternativeGuestOsVersion.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceBlessAlternativeGuestOsVersion.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `UpdateStandardEngineReplicaVersion`.
final class NnsGovernanceUpdateStandardEngineReplicaVersion
    with CandidSerializable {
  final String? newReplicaVersionId;
  final String? oldReplicaVersionId;
  final double? deploymentProgress;

  const NnsGovernanceUpdateStandardEngineReplicaVersion({
    this.newReplicaVersionId,
    this.oldReplicaVersionId,
    this.deploymentProgress,
  });

  static CType get ctype => CType.record([
    Field(Label.named('new_replica_version_id'), CType.opt(CType.text)),
    Field(Label.named('old_replica_version_id'), CType.opt(CType.text)),
    Field(Label.named('deployment_progress'), CType.opt(CType.float64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'new_replica_version_id': newReplicaVersionId,
    'old_replica_version_id': oldReplicaVersionId,
    'deployment_progress': deploymentProgress,
  };

  Map<String, dynamic> toJson() => {
    'new_replica_version_id': newReplicaVersionId,
    'old_replica_version_id': oldReplicaVersionId,
    'deployment_progress': deploymentProgress,
  };

  factory NnsGovernanceUpdateStandardEngineReplicaVersion.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceUpdateStandardEngineReplicaVersion(
      newReplicaVersionId: json.valueAsString<String?>(
        'new_replica_version_id',
      ),
      oldReplicaVersionId: json.valueAsString<String?>(
        'old_replica_version_id',
      ),
      deploymentProgress: json.valueAsDouble<double?>('deployment_progress'),
    );
  }

  factory NnsGovernanceUpdateStandardEngineReplicaVersion.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceUpdateStandardEngineReplicaVersion.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GuestLaunchMeasurements`.
final class NnsGovernanceGuestLaunchMeasurements with CandidSerializable {
  final List<NnsGovernanceGuestLaunchMeasurement>? guestLaunchMeasurements;

  const NnsGovernanceGuestLaunchMeasurements({this.guestLaunchMeasurements});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('guest_launch_measurements'),
      () => CType.opt(CType.vec(NnsGovernanceGuestLaunchMeasurement.ctype)),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'guest_launch_measurements':
        guestLaunchMeasurements?.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'guest_launch_measurements':
        guestLaunchMeasurements?.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceGuestLaunchMeasurements.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGuestLaunchMeasurements(
      guestLaunchMeasurements: json
          .valueTo<List<NnsGovernanceGuestLaunchMeasurement>?, List>(
            key: 'guest_launch_measurements',
            parse:
                (e) =>
                    e
                        .map<NnsGovernanceGuestLaunchMeasurement>(
                          (x) => NnsGovernanceGuestLaunchMeasurement.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsGovernanceGuestLaunchMeasurements.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGuestLaunchMeasurements.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GuestLaunchMeasurement`.
final class NnsGovernanceGuestLaunchMeasurement with CandidSerializable {
  final List<int>? measurement;
  final NnsGovernanceGuestLaunchMeasurementMetadata? metadata;

  const NnsGovernanceGuestLaunchMeasurement({this.measurement, this.metadata});

  static CType get ctype => CType.record([
    Field(Label.named('measurement'), CType.opt(CType.vec(CType.nat8))),
    LazyField(
      Label.named('metadata'),
      () => CType.opt(NnsGovernanceGuestLaunchMeasurementMetadata.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'measurement': measurement,
    'metadata': metadata?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'measurement': measurement,
    'metadata': metadata?.toJson(),
  };

  factory NnsGovernanceGuestLaunchMeasurement.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGuestLaunchMeasurement(
      measurement: json.valueAsBytes<List<int>?>(
        'measurement',
        encoding: StringEncoding.base64,
      ),
      metadata: json.valueTo<NnsGovernanceGuestLaunchMeasurementMetadata?, Map>(
        key: 'metadata',
        parse:
            (e) => NnsGovernanceGuestLaunchMeasurementMetadata.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceGuestLaunchMeasurement.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGuestLaunchMeasurement.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GuestLaunchMeasurementMetadata`.
final class NnsGovernanceGuestLaunchMeasurementMetadata
    with CandidSerializable {
  final String? kernelCmdline;
  final String? vcpuType;

  const NnsGovernanceGuestLaunchMeasurementMetadata({
    this.kernelCmdline,
    this.vcpuType,
  });

  static CType get ctype => CType.record([
    Field(Label.named('kernel_cmdline'), CType.opt(CType.text)),
    Field(Label.named('vcpu_type'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'kernel_cmdline': kernelCmdline,
    'vcpu_type': vcpuType,
  };

  Map<String, dynamic> toJson() => {
    'kernel_cmdline': kernelCmdline,
    'vcpu_type': vcpuType,
  };

  factory NnsGovernanceGuestLaunchMeasurementMetadata.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGuestLaunchMeasurementMetadata(
      kernelCmdline: json.valueAsString<String?>('kernel_cmdline'),
      vcpuType: json.valueAsString<String?>('vcpu_type'),
    );
  }

  factory NnsGovernanceGuestLaunchMeasurementMetadata.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGuestLaunchMeasurementMetadata.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TakeCanisterSnapshot`.
final class NnsGovernanceTakeCanisterSnapshot with CandidSerializable {
  final IcpPrincipalAddress? canisterId;
  final List<int>? replaceSnapshot;

  const NnsGovernanceTakeCanisterSnapshot({
    this.canisterId,
    this.replaceSnapshot,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
    Field(Label.named('replace_snapshot'), CType.opt(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'replace_snapshot': replaceSnapshot,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId?.address,
    'replace_snapshot': replaceSnapshot,
  };

  factory NnsGovernanceTakeCanisterSnapshot.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceTakeCanisterSnapshot(
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      replaceSnapshot: json.valueAsBytes<List<int>?>(
        'replace_snapshot',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsGovernanceTakeCanisterSnapshot.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceTakeCanisterSnapshot.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ProposalData`.
final class NnsGovernanceProposalData with CandidSerializable {
  final NnsGovernanceProposalId? id;
  final NnsGovernanceGovernanceError? failureReason;
  final List<NnsGovernanceProposalDataBallots> ballots;
  final BigInt proposalTimestampSeconds;
  final BigInt rewardEventRound;
  final BigInt failedTimestampSeconds;
  final NnsGovernanceNeuronsFundData? neuronsFundData;
  final BigInt rejectCostE8s;
  final NnsGovernanceDerivedProposalInformation? derivedProposalInformation;
  final NnsGovernanceTally? latestTally;
  final int? snsTokenSwapLifecycle;
  final BigInt decidedTimestampSeconds;
  final NnsGovernanceProposal? proposal;
  final NnsGovernanceNeuronId? proposer;
  final NnsGovernanceWaitForQuietState? waitForQuietState;
  final BigInt executedTimestampSeconds;
  final BigInt? originalTotalCommunityFundMaturityE8sEquivalent;
  final BigInt? totalPotentialVotingPower;
  final int? topic;
  final NnsGovernanceSuccessfulProposalExecutionValue? successValue;

  const NnsGovernanceProposalData({
    this.id,
    this.failureReason,
    required this.ballots,
    required this.proposalTimestampSeconds,
    required this.rewardEventRound,
    required this.failedTimestampSeconds,
    this.neuronsFundData,
    required this.rejectCostE8s,
    this.derivedProposalInformation,
    this.latestTally,
    this.snsTokenSwapLifecycle,
    required this.decidedTimestampSeconds,
    this.proposal,
    this.proposer,
    this.waitForQuietState,
    required this.executedTimestampSeconds,
    this.originalTotalCommunityFundMaturityE8sEquivalent,
    this.totalPotentialVotingPower,
    this.topic,
    this.successValue,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('id'),
      () => CType.opt(NnsGovernanceProposalId.ctype),
    ),
    LazyField(
      Label.named('failure_reason'),
      () => CType.opt(NnsGovernanceGovernanceError.ctype),
    ),
    LazyField(
      Label.named('ballots'),
      () => CType.vec(NnsGovernanceProposalDataBallots.ctype),
    ),
    Field(Label.named('proposal_timestamp_seconds'), CType.nat64),
    Field(Label.named('reward_event_round'), CType.nat64),
    Field(Label.named('failed_timestamp_seconds'), CType.nat64),
    LazyField(
      Label.named('neurons_fund_data'),
      () => CType.opt(NnsGovernanceNeuronsFundData.ctype),
    ),
    Field(Label.named('reject_cost_e8s'), CType.nat64),
    LazyField(
      Label.named('derived_proposal_information'),
      () => CType.opt(NnsGovernanceDerivedProposalInformation.ctype),
    ),
    LazyField(
      Label.named('latest_tally'),
      () => CType.opt(NnsGovernanceTally.ctype),
    ),
    Field(Label.named('sns_token_swap_lifecycle'), CType.opt(CType.int32)),
    Field(Label.named('decided_timestamp_seconds'), CType.nat64),
    LazyField(
      Label.named('proposal'),
      () => CType.opt(NnsGovernanceProposal.ctype),
    ),
    LazyField(
      Label.named('proposer'),
      () => CType.opt(NnsGovernanceNeuronId.ctype),
    ),
    LazyField(
      Label.named('wait_for_quiet_state'),
      () => CType.opt(NnsGovernanceWaitForQuietState.ctype),
    ),
    Field(Label.named('executed_timestamp_seconds'), CType.nat64),
    Field(
      Label.named('original_total_community_fund_maturity_e8s_equivalent'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('total_potential_voting_power'), CType.opt(CType.nat64)),
    Field(Label.named('topic'), CType.opt(CType.int32)),
    LazyField(
      Label.named('success_value'),
      () => CType.opt(NnsGovernanceSuccessfulProposalExecutionValue.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'id': id?.candidValue,
    'failure_reason': failureReason?.candidValue,
    'ballots': ballots.map((el) => el.candidValue).toList(),
    'proposal_timestamp_seconds': proposalTimestampSeconds,
    'reward_event_round': rewardEventRound,
    'failed_timestamp_seconds': failedTimestampSeconds,
    'neurons_fund_data': neuronsFundData?.candidValue,
    'reject_cost_e8s': rejectCostE8s,
    'derived_proposal_information': derivedProposalInformation?.candidValue,
    'latest_tally': latestTally?.candidValue,
    'sns_token_swap_lifecycle': snsTokenSwapLifecycle,
    'decided_timestamp_seconds': decidedTimestampSeconds,
    'proposal': proposal?.candidValue,
    'proposer': proposer?.candidValue,
    'wait_for_quiet_state': waitForQuietState?.candidValue,
    'executed_timestamp_seconds': executedTimestampSeconds,
    'original_total_community_fund_maturity_e8s_equivalent':
        originalTotalCommunityFundMaturityE8sEquivalent,
    'total_potential_voting_power': totalPotentialVotingPower,
    'topic': topic,
    'success_value': successValue?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'id': id?.toJson(),
    'failure_reason': failureReason?.toJson(),
    'ballots': ballots.map((el) => el.toJson()).toList(),
    'proposal_timestamp_seconds': proposalTimestampSeconds,
    'reward_event_round': rewardEventRound,
    'failed_timestamp_seconds': failedTimestampSeconds,
    'neurons_fund_data': neuronsFundData?.toJson(),
    'reject_cost_e8s': rejectCostE8s,
    'derived_proposal_information': derivedProposalInformation?.toJson(),
    'latest_tally': latestTally?.toJson(),
    'sns_token_swap_lifecycle': snsTokenSwapLifecycle,
    'decided_timestamp_seconds': decidedTimestampSeconds,
    'proposal': proposal?.toJson(),
    'proposer': proposer?.toJson(),
    'wait_for_quiet_state': waitForQuietState?.toJson(),
    'executed_timestamp_seconds': executedTimestampSeconds,
    'original_total_community_fund_maturity_e8s_equivalent':
        originalTotalCommunityFundMaturityE8sEquivalent,
    'total_potential_voting_power': totalPotentialVotingPower,
    'topic': topic,
    'success_value': successValue?.toJson(),
  };

  factory NnsGovernanceProposalData.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceProposalData(
      id: json.valueTo<NnsGovernanceProposalId?, Map>(
        key: 'id',
        parse:
            (e) => NnsGovernanceProposalId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      failureReason: json.valueTo<NnsGovernanceGovernanceError?, Map>(
        key: 'failure_reason',
        parse:
            (e) => NnsGovernanceGovernanceError.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      ballots: json.valueTo<List<NnsGovernanceProposalDataBallots>, List>(
        key: 'ballots',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceProposalDataBallots>(
                      (x) => NnsGovernanceProposalDataBallots.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      proposalTimestampSeconds: json.valueAsBigInt<BigInt>(
        'proposal_timestamp_seconds',
      ),
      rewardEventRound: json.valueAsBigInt<BigInt>('reward_event_round'),
      failedTimestampSeconds: json.valueAsBigInt<BigInt>(
        'failed_timestamp_seconds',
      ),
      neuronsFundData: json.valueTo<NnsGovernanceNeuronsFundData?, Map>(
        key: 'neurons_fund_data',
        parse:
            (e) => NnsGovernanceNeuronsFundData.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      rejectCostE8s: json.valueAsBigInt<BigInt>('reject_cost_e8s'),
      derivedProposalInformation: json
          .valueTo<NnsGovernanceDerivedProposalInformation?, Map>(
            key: 'derived_proposal_information',
            parse:
                (e) => NnsGovernanceDerivedProposalInformation.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      latestTally: json.valueTo<NnsGovernanceTally?, Map>(
        key: 'latest_tally',
        parse:
            (e) => NnsGovernanceTally.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      snsTokenSwapLifecycle: json.valueAsInt<int?>('sns_token_swap_lifecycle'),
      decidedTimestampSeconds: json.valueAsBigInt<BigInt>(
        'decided_timestamp_seconds',
      ),
      proposal: json.valueTo<NnsGovernanceProposal?, Map>(
        key: 'proposal',
        parse:
            (e) => NnsGovernanceProposal.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      proposer: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'proposer',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      waitForQuietState: json.valueTo<NnsGovernanceWaitForQuietState?, Map>(
        key: 'wait_for_quiet_state',
        parse:
            (e) => NnsGovernanceWaitForQuietState.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      executedTimestampSeconds: json.valueAsBigInt<BigInt>(
        'executed_timestamp_seconds',
      ),
      originalTotalCommunityFundMaturityE8sEquivalent: json
          .valueAsBigInt<BigInt?>(
            'original_total_community_fund_maturity_e8s_equivalent',
          ),
      totalPotentialVotingPower: json.valueAsBigInt<BigInt?>(
        'total_potential_voting_power',
      ),
      topic: json.valueAsInt<int?>('topic'),
      successValue: json
          .valueTo<NnsGovernanceSuccessfulProposalExecutionValue?, Map>(
            key: 'success_value',
            parse:
                (e) => NnsGovernanceSuccessfulProposalExecutionValue.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceProposalData.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceProposalData.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ProposalInfo`.
final class NnsGovernanceProposalInfo with CandidSerializable {
  final NnsGovernanceProposalId? id;
  final int status;
  final int topic;
  final NnsGovernanceGovernanceError? failureReason;
  final List<NnsGovernanceProposalDataBallots> ballots;
  final BigInt proposalTimestampSeconds;
  final BigInt rewardEventRound;
  final BigInt? deadlineTimestampSeconds;
  final BigInt failedTimestampSeconds;
  final BigInt rejectCostE8s;
  final NnsGovernanceDerivedProposalInformation? derivedProposalInformation;
  final NnsGovernanceTally? latestTally;
  final int rewardStatus;
  final BigInt decidedTimestampSeconds;
  final NnsGovernanceProposal? proposal;
  final NnsGovernanceNeuronId? proposer;
  final BigInt executedTimestampSeconds;
  final BigInt? totalPotentialVotingPower;
  final NnsGovernanceSuccessfulProposalExecutionValue? successValue;

  const NnsGovernanceProposalInfo({
    this.id,
    required this.status,
    required this.topic,
    this.failureReason,
    required this.ballots,
    required this.proposalTimestampSeconds,
    required this.rewardEventRound,
    this.deadlineTimestampSeconds,
    required this.failedTimestampSeconds,
    required this.rejectCostE8s,
    this.derivedProposalInformation,
    this.latestTally,
    required this.rewardStatus,
    required this.decidedTimestampSeconds,
    this.proposal,
    this.proposer,
    required this.executedTimestampSeconds,
    this.totalPotentialVotingPower,
    this.successValue,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('id'),
      () => CType.opt(NnsGovernanceProposalId.ctype),
    ),
    Field(Label.named('status'), CType.int32),
    Field(Label.named('topic'), CType.int32),
    LazyField(
      Label.named('failure_reason'),
      () => CType.opt(NnsGovernanceGovernanceError.ctype),
    ),
    LazyField(
      Label.named('ballots'),
      () => CType.vec(NnsGovernanceProposalDataBallots.ctype),
    ),
    Field(Label.named('proposal_timestamp_seconds'), CType.nat64),
    Field(Label.named('reward_event_round'), CType.nat64),
    Field(Label.named('deadline_timestamp_seconds'), CType.opt(CType.nat64)),
    Field(Label.named('failed_timestamp_seconds'), CType.nat64),
    Field(Label.named('reject_cost_e8s'), CType.nat64),
    LazyField(
      Label.named('derived_proposal_information'),
      () => CType.opt(NnsGovernanceDerivedProposalInformation.ctype),
    ),
    LazyField(
      Label.named('latest_tally'),
      () => CType.opt(NnsGovernanceTally.ctype),
    ),
    Field(Label.named('reward_status'), CType.int32),
    Field(Label.named('decided_timestamp_seconds'), CType.nat64),
    LazyField(
      Label.named('proposal'),
      () => CType.opt(NnsGovernanceProposal.ctype),
    ),
    LazyField(
      Label.named('proposer'),
      () => CType.opt(NnsGovernanceNeuronId.ctype),
    ),
    Field(Label.named('executed_timestamp_seconds'), CType.nat64),
    Field(Label.named('total_potential_voting_power'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('success_value'),
      () => CType.opt(NnsGovernanceSuccessfulProposalExecutionValue.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'id': id?.candidValue,
    'status': status,
    'topic': topic,
    'failure_reason': failureReason?.candidValue,
    'ballots': ballots.map((el) => el.candidValue).toList(),
    'proposal_timestamp_seconds': proposalTimestampSeconds,
    'reward_event_round': rewardEventRound,
    'deadline_timestamp_seconds': deadlineTimestampSeconds,
    'failed_timestamp_seconds': failedTimestampSeconds,
    'reject_cost_e8s': rejectCostE8s,
    'derived_proposal_information': derivedProposalInformation?.candidValue,
    'latest_tally': latestTally?.candidValue,
    'reward_status': rewardStatus,
    'decided_timestamp_seconds': decidedTimestampSeconds,
    'proposal': proposal?.candidValue,
    'proposer': proposer?.candidValue,
    'executed_timestamp_seconds': executedTimestampSeconds,
    'total_potential_voting_power': totalPotentialVotingPower,
    'success_value': successValue?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'id': id?.toJson(),
    'status': status,
    'topic': topic,
    'failure_reason': failureReason?.toJson(),
    'ballots': ballots.map((el) => el.toJson()).toList(),
    'proposal_timestamp_seconds': proposalTimestampSeconds,
    'reward_event_round': rewardEventRound,
    'deadline_timestamp_seconds': deadlineTimestampSeconds,
    'failed_timestamp_seconds': failedTimestampSeconds,
    'reject_cost_e8s': rejectCostE8s,
    'derived_proposal_information': derivedProposalInformation?.toJson(),
    'latest_tally': latestTally?.toJson(),
    'reward_status': rewardStatus,
    'decided_timestamp_seconds': decidedTimestampSeconds,
    'proposal': proposal?.toJson(),
    'proposer': proposer?.toJson(),
    'executed_timestamp_seconds': executedTimestampSeconds,
    'total_potential_voting_power': totalPotentialVotingPower,
    'success_value': successValue?.toJson(),
  };

  factory NnsGovernanceProposalInfo.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceProposalInfo(
      id: json.valueTo<NnsGovernanceProposalId?, Map>(
        key: 'id',
        parse:
            (e) => NnsGovernanceProposalId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      status: json.valueAsInt<int>('status'),
      topic: json.valueAsInt<int>('topic'),
      failureReason: json.valueTo<NnsGovernanceGovernanceError?, Map>(
        key: 'failure_reason',
        parse:
            (e) => NnsGovernanceGovernanceError.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      ballots: json.valueTo<List<NnsGovernanceProposalDataBallots>, List>(
        key: 'ballots',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceProposalDataBallots>(
                      (x) => NnsGovernanceProposalDataBallots.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      proposalTimestampSeconds: json.valueAsBigInt<BigInt>(
        'proposal_timestamp_seconds',
      ),
      rewardEventRound: json.valueAsBigInt<BigInt>('reward_event_round'),
      deadlineTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'deadline_timestamp_seconds',
      ),
      failedTimestampSeconds: json.valueAsBigInt<BigInt>(
        'failed_timestamp_seconds',
      ),
      rejectCostE8s: json.valueAsBigInt<BigInt>('reject_cost_e8s'),
      derivedProposalInformation: json
          .valueTo<NnsGovernanceDerivedProposalInformation?, Map>(
            key: 'derived_proposal_information',
            parse:
                (e) => NnsGovernanceDerivedProposalInformation.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      latestTally: json.valueTo<NnsGovernanceTally?, Map>(
        key: 'latest_tally',
        parse:
            (e) => NnsGovernanceTally.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      rewardStatus: json.valueAsInt<int>('reward_status'),
      decidedTimestampSeconds: json.valueAsBigInt<BigInt>(
        'decided_timestamp_seconds',
      ),
      proposal: json.valueTo<NnsGovernanceProposal?, Map>(
        key: 'proposal',
        parse:
            (e) => NnsGovernanceProposal.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      proposer: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'proposer',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      executedTimestampSeconds: json.valueAsBigInt<BigInt>(
        'executed_timestamp_seconds',
      ),
      totalPotentialVotingPower: json.valueAsBigInt<BigInt?>(
        'total_potential_voting_power',
      ),
      successValue: json
          .valueTo<NnsGovernanceSuccessfulProposalExecutionValue?, Map>(
            key: 'success_value',
            parse:
                (e) => NnsGovernanceSuccessfulProposalExecutionValue.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceProposalInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceProposalInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RegisterVote`.
final class NnsGovernanceRegisterVote with CandidSerializable {
  final int vote;
  final NnsGovernanceProposalId? proposal;

  const NnsGovernanceRegisterVote({required this.vote, this.proposal});

  static CType get ctype => CType.record([
    Field(Label.named('vote'), CType.int32),
    LazyField(
      Label.named('proposal'),
      () => CType.opt(NnsGovernanceProposalId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'vote': vote, 'proposal': proposal?.candidValue};

  Map<String, dynamic> toJson() => {
    'vote': vote,
    'proposal': proposal?.toJson(),
  };

  factory NnsGovernanceRegisterVote.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceRegisterVote(
      vote: json.valueAsInt<int>('vote'),
      proposal: json.valueTo<NnsGovernanceProposalId?, Map>(
        key: 'proposal',
        parse:
            (e) => NnsGovernanceProposalId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceRegisterVote.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRegisterVote.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RemoveHotKey`.
final class NnsGovernanceRemoveHotKey with CandidSerializable {
  final IcpPrincipalAddress? hotKeyToRemove;

  const NnsGovernanceRemoveHotKey({this.hotKeyToRemove});

  static CType get ctype => CType.record([
    Field(Label.named('hot_key_to_remove'), CType.opt(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'hot_key_to_remove': hotKeyToRemove};

  Map<String, dynamic> toJson() => {
    'hot_key_to_remove': hotKeyToRemove?.address,
  };

  factory NnsGovernanceRemoveHotKey.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceRemoveHotKey(
      hotKeyToRemove: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'hot_key_to_remove',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsGovernanceRemoveHotKey.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRemoveHotKey.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RestoreAgingNeuronGroup`.
final class NnsGovernanceRestoreAgingNeuronGroup with CandidSerializable {
  final BigInt? count;
  final BigInt? previousTotalStakeE8s;
  final BigInt? currentTotalStakeE8s;
  final int groupType;

  const NnsGovernanceRestoreAgingNeuronGroup({
    this.count,
    this.previousTotalStakeE8s,
    this.currentTotalStakeE8s,
    required this.groupType,
  });

  static CType get ctype => CType.record([
    Field(Label.named('count'), CType.opt(CType.nat64)),
    Field(Label.named('previous_total_stake_e8s'), CType.opt(CType.nat64)),
    Field(Label.named('current_total_stake_e8s'), CType.opt(CType.nat64)),
    Field(Label.named('group_type'), CType.int32),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'count': count,
    'previous_total_stake_e8s': previousTotalStakeE8s,
    'current_total_stake_e8s': currentTotalStakeE8s,
    'group_type': groupType,
  };

  Map<String, dynamic> toJson() => {
    'count': count,
    'previous_total_stake_e8s': previousTotalStakeE8s,
    'current_total_stake_e8s': currentTotalStakeE8s,
    'group_type': groupType,
  };

  factory NnsGovernanceRestoreAgingNeuronGroup.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceRestoreAgingNeuronGroup(
      count: json.valueAsBigInt<BigInt?>('count'),
      previousTotalStakeE8s: json.valueAsBigInt<BigInt?>(
        'previous_total_stake_e8s',
      ),
      currentTotalStakeE8s: json.valueAsBigInt<BigInt?>(
        'current_total_stake_e8s',
      ),
      groupType: json.valueAsInt<int>('group_type'),
    );
  }

  factory NnsGovernanceRestoreAgingNeuronGroup.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRestoreAgingNeuronGroup.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RestoreAgingSummary`.
final class NnsGovernanceRestoreAgingSummary with CandidSerializable {
  final List<NnsGovernanceRestoreAgingNeuronGroup> groups;
  final BigInt? timestampSeconds;

  const NnsGovernanceRestoreAgingSummary({
    required this.groups,
    this.timestampSeconds,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('groups'),
      () => CType.vec(NnsGovernanceRestoreAgingNeuronGroup.ctype),
    ),
    Field(Label.named('timestamp_seconds'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'groups': groups.map((el) => el.candidValue).toList(),
    'timestamp_seconds': timestampSeconds,
  };

  Map<String, dynamic> toJson() => {
    'groups': groups.map((el) => el.toJson()).toList(),
    'timestamp_seconds': timestampSeconds,
  };

  factory NnsGovernanceRestoreAgingSummary.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceRestoreAgingSummary(
      groups: json.valueTo<List<NnsGovernanceRestoreAgingNeuronGroup>, List>(
        key: 'groups',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceRestoreAgingNeuronGroup>(
                      (x) => NnsGovernanceRestoreAgingNeuronGroup.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      timestampSeconds: json.valueAsBigInt<BigInt?>('timestamp_seconds'),
    );
  }

  factory NnsGovernanceRestoreAgingSummary.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRestoreAgingSummary.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Result`.
sealed class NnsGovernanceResult with CandidSerializable {
  const NnsGovernanceResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.null_),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return const NnsGovernanceResultOk();
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceResultErr(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult.fromCandid',
      reason: 'Unknown NnsGovernanceResult arm',
    );
  }

  factory NnsGovernanceResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result.Ok` (nullary).
final class NnsGovernanceResultOk extends NnsGovernanceResult {
  const NnsGovernanceResultOk();

  @override
  CType get candidType => NnsGovernanceResult.ctype;

  @override
  dynamic get candidValue => const Variant('Ok', null);

  @override
  Map<String, dynamic> toJson() => {'Ok': null};
}

/// Variant arm `Result.Err`.
final class NnsGovernanceResultErr extends NnsGovernanceResult {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceResultErr(this.value);

  @override
  CType get candidType => NnsGovernanceResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `Result_1`.
sealed class NnsGovernanceResult1 with CandidSerializable {
  const NnsGovernanceResult1();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Error'), () => NnsGovernanceGovernanceError.ctype),
    LazyField(Label.named('NeuronId'), () => NnsGovernanceNeuronId.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult1.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Error')) {
      return NnsGovernanceResult1Error(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Error',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('NeuronId')) {
      return NnsGovernanceResult1NeuronId(
        json.valueTo<NnsGovernanceNeuronId, Map>(
          key: 'NeuronId',
          parse:
              (e) => NnsGovernanceNeuronId.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult1.fromCandid',
      reason: 'Unknown NnsGovernanceResult1 arm',
    );
  }

  factory NnsGovernanceResult1.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult1.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_1.Error`.
final class NnsGovernanceResult1Error extends NnsGovernanceResult1 {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceResult1Error(this.value);

  @override
  CType get candidType => NnsGovernanceResult1.ctype;

  @override
  dynamic get candidValue => Variant('Error', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Error': value.toJson()};
}

/// Variant arm `Result_1.NeuronId`.
final class NnsGovernanceResult1NeuronId extends NnsGovernanceResult1 {
  final NnsGovernanceNeuronId value;
  const NnsGovernanceResult1NeuronId(this.value);

  @override
  CType get candidType => NnsGovernanceResult1.ctype;

  @override
  dynamic get candidValue => Variant('NeuronId', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'NeuronId': value.toJson()};
}

/// Candid variant `Result_10`.
sealed class NnsGovernanceResult10 with CandidSerializable {
  const NnsGovernanceResult10();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsGovernanceOk1.ctype),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult10.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return NnsGovernanceResult10Ok(
        json.valueTo<NnsGovernanceOk1, Map>(
          key: 'Ok',
          parse:
              (e) => NnsGovernanceOk1.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceResult10Err(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult10.fromCandid',
      reason: 'Unknown NnsGovernanceResult10 arm',
    );
  }

  factory NnsGovernanceResult10.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult10.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_10.Ok`.
final class NnsGovernanceResult10Ok extends NnsGovernanceResult10 {
  final NnsGovernanceOk1 value;
  const NnsGovernanceResult10Ok(this.value);

  @override
  CType get candidType => NnsGovernanceResult10.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `Result_10.Err`.
final class NnsGovernanceResult10Err extends NnsGovernanceResult10 {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceResult10Err(this.value);

  @override
  CType get candidType => NnsGovernanceResult10.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `Result_2`.
sealed class NnsGovernanceResult2 with CandidSerializable {
  const NnsGovernanceResult2();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsGovernanceNeuron.ctype),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult2.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return NnsGovernanceResult2Ok(
        json.valueTo<NnsGovernanceNeuron, Map>(
          key: 'Ok',
          parse:
              (e) => NnsGovernanceNeuron.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceResult2Err(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult2.fromCandid',
      reason: 'Unknown NnsGovernanceResult2 arm',
    );
  }

  factory NnsGovernanceResult2.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult2.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_2.Ok`.
final class NnsGovernanceResult2Ok extends NnsGovernanceResult2 {
  final NnsGovernanceNeuron value;
  const NnsGovernanceResult2Ok(this.value);

  @override
  CType get candidType => NnsGovernanceResult2.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `Result_2.Err`.
final class NnsGovernanceResult2Err extends NnsGovernanceResult2 {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceResult2Err(this.value);

  @override
  CType get candidType => NnsGovernanceResult2.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `Result_3`.
sealed class NnsGovernanceResult3 with CandidSerializable {
  const NnsGovernanceResult3();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsGovernanceGovernanceCachedMetrics.ctype,
    ),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult3.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return NnsGovernanceResult3Ok(
        json.valueTo<NnsGovernanceGovernanceCachedMetrics, Map>(
          key: 'Ok',
          parse:
              (e) => NnsGovernanceGovernanceCachedMetrics.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceResult3Err(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult3.fromCandid',
      reason: 'Unknown NnsGovernanceResult3 arm',
    );
  }

  factory NnsGovernanceResult3.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult3.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_3.Ok`.
final class NnsGovernanceResult3Ok extends NnsGovernanceResult3 {
  final NnsGovernanceGovernanceCachedMetrics value;
  const NnsGovernanceResult3Ok(this.value);

  @override
  CType get candidType => NnsGovernanceResult3.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `Result_3.Err`.
final class NnsGovernanceResult3Err extends NnsGovernanceResult3 {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceResult3Err(this.value);

  @override
  CType get candidType => NnsGovernanceResult3.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `Result_4`.
sealed class NnsGovernanceResult4 with CandidSerializable {
  const NnsGovernanceResult4();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsGovernanceMonthlyNodeProviderRewards.ctype,
    ),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult4.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return NnsGovernanceResult4Ok(
        json.valueTo<NnsGovernanceMonthlyNodeProviderRewards, Map>(
          key: 'Ok',
          parse:
              (e) => NnsGovernanceMonthlyNodeProviderRewards.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceResult4Err(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult4.fromCandid',
      reason: 'Unknown NnsGovernanceResult4 arm',
    );
  }

  factory NnsGovernanceResult4.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult4.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_4.Ok`.
final class NnsGovernanceResult4Ok extends NnsGovernanceResult4 {
  final NnsGovernanceMonthlyNodeProviderRewards value;
  const NnsGovernanceResult4Ok(this.value);

  @override
  CType get candidType => NnsGovernanceResult4.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `Result_4.Err`.
final class NnsGovernanceResult4Err extends NnsGovernanceResult4 {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceResult4Err(this.value);

  @override
  CType get candidType => NnsGovernanceResult4.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `Result_5`.
sealed class NnsGovernanceResult5 with CandidSerializable {
  const NnsGovernanceResult5();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsGovernanceNeuronInfo.ctype),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult5.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return NnsGovernanceResult5Ok(
        json.valueTo<NnsGovernanceNeuronInfo, Map>(
          key: 'Ok',
          parse:
              (e) => NnsGovernanceNeuronInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceResult5Err(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult5.fromCandid',
      reason: 'Unknown NnsGovernanceResult5 arm',
    );
  }

  factory NnsGovernanceResult5.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult5.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_5.Ok`.
final class NnsGovernanceResult5Ok extends NnsGovernanceResult5 {
  final NnsGovernanceNeuronInfo value;
  const NnsGovernanceResult5Ok(this.value);

  @override
  CType get candidType => NnsGovernanceResult5.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `Result_5.Err`.
final class NnsGovernanceResult5Err extends NnsGovernanceResult5 {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceResult5Err(this.value);

  @override
  CType get candidType => NnsGovernanceResult5.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `Result_6`.
sealed class NnsGovernanceResult6 with CandidSerializable {
  const NnsGovernanceResult6();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsGovernanceOk.ctype),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult6.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return NnsGovernanceResult6Ok(
        json.valueTo<NnsGovernanceOk, Map>(
          key: 'Ok',
          parse:
              (e) => NnsGovernanceOk.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceResult6Err(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult6.fromCandid',
      reason: 'Unknown NnsGovernanceResult6 arm',
    );
  }

  factory NnsGovernanceResult6.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult6.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_6.Ok`.
final class NnsGovernanceResult6Ok extends NnsGovernanceResult6 {
  final NnsGovernanceOk value;
  const NnsGovernanceResult6Ok(this.value);

  @override
  CType get candidType => NnsGovernanceResult6.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `Result_6.Err`.
final class NnsGovernanceResult6Err extends NnsGovernanceResult6 {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceResult6Err(this.value);

  @override
  CType get candidType => NnsGovernanceResult6.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `Result_7`.
sealed class NnsGovernanceResult7 with CandidSerializable {
  const NnsGovernanceResult7();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsGovernanceNodeProvider.ctype),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult7.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return NnsGovernanceResult7Ok(
        json.valueTo<NnsGovernanceNodeProvider, Map>(
          key: 'Ok',
          parse:
              (e) => NnsGovernanceNodeProvider.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceResult7Err(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult7.fromCandid',
      reason: 'Unknown NnsGovernanceResult7 arm',
    );
  }

  factory NnsGovernanceResult7.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult7.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_7.Ok`.
final class NnsGovernanceResult7Ok extends NnsGovernanceResult7 {
  final NnsGovernanceNodeProvider value;
  const NnsGovernanceResult7Ok(this.value);

  @override
  CType get candidType => NnsGovernanceResult7.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `Result_7.Err`.
final class NnsGovernanceResult7Err extends NnsGovernanceResult7 {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceResult7Err(this.value);

  @override
  CType get candidType => NnsGovernanceResult7.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `Result_8`.
sealed class NnsGovernanceResult8 with CandidSerializable {
  const NnsGovernanceResult8();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Committed'), () => NnsGovernanceCommitted.ctype),
    Field(Label.named('Aborted'), CType.record(const [])),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult8.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Committed')) {
      return NnsGovernanceResult8Committed(
        json.valueTo<NnsGovernanceCommitted, Map>(
          key: 'Committed',
          parse:
              (e) => NnsGovernanceCommitted.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Aborted')) {
      return NnsGovernanceResult8Aborted.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Aborted']),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult8.fromCandid',
      reason: 'Unknown NnsGovernanceResult8 arm',
    );
  }

  factory NnsGovernanceResult8.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult8.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_8.Committed`.
final class NnsGovernanceResult8Committed extends NnsGovernanceResult8 {
  final NnsGovernanceCommitted value;
  const NnsGovernanceResult8Committed(this.value);

  @override
  CType get candidType => NnsGovernanceResult8.ctype;

  @override
  dynamic get candidValue => Variant('Committed', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Committed': value.toJson()};
}

/// Variant arm `Result_8.Aborted`.
final class NnsGovernanceResult8Aborted extends NnsGovernanceResult8 {
  const NnsGovernanceResult8Aborted();

  @override
  CType get candidType => NnsGovernanceResult8.ctype;

  @override
  dynamic get candidValue => Variant('Aborted', {});

  @override
  Map<String, dynamic> toJson() => {'Aborted': {}};

  factory NnsGovernanceResult8Aborted.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceResult8Aborted();
  }
}

/// Candid variant `Result_9`.
sealed class NnsGovernanceResult9 with CandidSerializable {
  const NnsGovernanceResult9();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Committed'), () => NnsGovernanceCommitted1.ctype),
    Field(Label.named('Aborted'), CType.record(const [])),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceResult9.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Committed')) {
      return NnsGovernanceResult9Committed(
        json.valueTo<NnsGovernanceCommitted1, Map>(
          key: 'Committed',
          parse:
              (e) => NnsGovernanceCommitted1.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Aborted')) {
      return NnsGovernanceResult9Aborted.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Aborted']),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceResult9.fromCandid',
      reason: 'Unknown NnsGovernanceResult9 arm',
    );
  }

  factory NnsGovernanceResult9.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceResult9.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_9.Committed`.
final class NnsGovernanceResult9Committed extends NnsGovernanceResult9 {
  final NnsGovernanceCommitted1 value;
  const NnsGovernanceResult9Committed(this.value);

  @override
  CType get candidType => NnsGovernanceResult9.ctype;

  @override
  dynamic get candidValue => Variant('Committed', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Committed': value.toJson()};
}

/// Variant arm `Result_9.Aborted`.
final class NnsGovernanceResult9Aborted extends NnsGovernanceResult9 {
  const NnsGovernanceResult9Aborted();

  @override
  CType get candidType => NnsGovernanceResult9.ctype;

  @override
  dynamic get candidValue => Variant('Aborted', {});

  @override
  Map<String, dynamic> toJson() => {'Aborted': {}};

  factory NnsGovernanceResult9Aborted.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceResult9Aborted();
  }
}

/// Candid record `RewardEvent`.
final class NnsGovernanceRewardEvent with CandidSerializable {
  final BigInt? roundsSinceLastDistribution;
  final BigInt dayAfterGenesis;
  final BigInt actualTimestampSeconds;
  final BigInt totalAvailableE8sEquivalent;
  final BigInt? latestRoundAvailableE8sEquivalent;
  final BigInt distributedE8sEquivalent;
  final List<NnsGovernanceProposalId> settledProposals;

  const NnsGovernanceRewardEvent({
    this.roundsSinceLastDistribution,
    required this.dayAfterGenesis,
    required this.actualTimestampSeconds,
    required this.totalAvailableE8sEquivalent,
    this.latestRoundAvailableE8sEquivalent,
    required this.distributedE8sEquivalent,
    required this.settledProposals,
  });

  static CType get ctype => CType.record([
    Field(
      Label.named('rounds_since_last_distribution'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('day_after_genesis'), CType.nat64),
    Field(Label.named('actual_timestamp_seconds'), CType.nat64),
    Field(Label.named('total_available_e8s_equivalent'), CType.nat64),
    Field(
      Label.named('latest_round_available_e8s_equivalent'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('distributed_e8s_equivalent'), CType.nat64),
    LazyField(
      Label.named('settled_proposals'),
      () => CType.vec(NnsGovernanceProposalId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'rounds_since_last_distribution': roundsSinceLastDistribution,
    'day_after_genesis': dayAfterGenesis,
    'actual_timestamp_seconds': actualTimestampSeconds,
    'total_available_e8s_equivalent': totalAvailableE8sEquivalent,
    'latest_round_available_e8s_equivalent': latestRoundAvailableE8sEquivalent,
    'distributed_e8s_equivalent': distributedE8sEquivalent,
    'settled_proposals': settledProposals.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'rounds_since_last_distribution': roundsSinceLastDistribution,
    'day_after_genesis': dayAfterGenesis,
    'actual_timestamp_seconds': actualTimestampSeconds,
    'total_available_e8s_equivalent': totalAvailableE8sEquivalent,
    'latest_round_available_e8s_equivalent': latestRoundAvailableE8sEquivalent,
    'distributed_e8s_equivalent': distributedE8sEquivalent,
    'settled_proposals': settledProposals.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceRewardEvent.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceRewardEvent(
      roundsSinceLastDistribution: json.valueAsBigInt<BigInt?>(
        'rounds_since_last_distribution',
      ),
      dayAfterGenesis: json.valueAsBigInt<BigInt>('day_after_genesis'),
      actualTimestampSeconds: json.valueAsBigInt<BigInt>(
        'actual_timestamp_seconds',
      ),
      totalAvailableE8sEquivalent: json.valueAsBigInt<BigInt>(
        'total_available_e8s_equivalent',
      ),
      latestRoundAvailableE8sEquivalent: json.valueAsBigInt<BigInt?>(
        'latest_round_available_e8s_equivalent',
      ),
      distributedE8sEquivalent: json.valueAsBigInt<BigInt>(
        'distributed_e8s_equivalent',
      ),
      settledProposals: json.valueTo<List<NnsGovernanceProposalId>, List>(
        key: 'settled_proposals',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceProposalId>(
                      (x) => NnsGovernanceProposalId.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceRewardEvent.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRewardEvent.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `RewardMode`.
sealed class NnsGovernanceRewardMode with CandidSerializable {
  const NnsGovernanceRewardMode();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('RewardToNeuron'),
      () => NnsGovernanceRewardToNeuron.ctype,
    ),
    LazyField(
      Label.named('RewardToAccount'),
      () => NnsGovernanceRewardToAccount.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceRewardMode.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('RewardToNeuron')) {
      return NnsGovernanceRewardModeRewardToNeuron(
        json.valueTo<NnsGovernanceRewardToNeuron, Map>(
          key: 'RewardToNeuron',
          parse:
              (e) => NnsGovernanceRewardToNeuron.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('RewardToAccount')) {
      return NnsGovernanceRewardModeRewardToAccount(
        json.valueTo<NnsGovernanceRewardToAccount, Map>(
          key: 'RewardToAccount',
          parse:
              (e) => NnsGovernanceRewardToAccount.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceRewardMode.fromCandid',
      reason: 'Unknown NnsGovernanceRewardMode arm',
    );
  }

  factory NnsGovernanceRewardMode.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRewardMode.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `RewardMode.RewardToNeuron`.
final class NnsGovernanceRewardModeRewardToNeuron
    extends NnsGovernanceRewardMode {
  final NnsGovernanceRewardToNeuron value;
  const NnsGovernanceRewardModeRewardToNeuron(this.value);

  @override
  CType get candidType => NnsGovernanceRewardMode.ctype;

  @override
  dynamic get candidValue => Variant('RewardToNeuron', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RewardToNeuron': value.toJson()};
}

/// Variant arm `RewardMode.RewardToAccount`.
final class NnsGovernanceRewardModeRewardToAccount
    extends NnsGovernanceRewardMode {
  final NnsGovernanceRewardToAccount value;
  const NnsGovernanceRewardModeRewardToAccount(this.value);

  @override
  CType get candidType => NnsGovernanceRewardMode.ctype;

  @override
  dynamic get candidValue => Variant('RewardToAccount', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'RewardToAccount': value.toJson()};
}

/// Candid record `RewardNodeProvider`.
final class NnsGovernanceRewardNodeProvider with CandidSerializable {
  final NnsGovernanceNodeProvider? nodeProvider;
  final NnsGovernanceRewardMode? rewardMode;
  final BigInt amountE8s;

  const NnsGovernanceRewardNodeProvider({
    this.nodeProvider,
    this.rewardMode,
    required this.amountE8s,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('node_provider'),
      () => CType.opt(NnsGovernanceNodeProvider.ctype),
    ),
    LazyField(
      Label.named('reward_mode'),
      () => CType.opt(NnsGovernanceRewardMode.ctype),
    ),
    Field(Label.named('amount_e8s'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'node_provider': nodeProvider?.candidValue,
    'reward_mode': rewardMode?.candidValue,
    'amount_e8s': amountE8s,
  };

  Map<String, dynamic> toJson() => {
    'node_provider': nodeProvider?.toJson(),
    'reward_mode': rewardMode?.toJson(),
    'amount_e8s': amountE8s,
  };

  factory NnsGovernanceRewardNodeProvider.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceRewardNodeProvider(
      nodeProvider: json.valueTo<NnsGovernanceNodeProvider?, Map>(
        key: 'node_provider',
        parse:
            (e) => NnsGovernanceNodeProvider.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      rewardMode: json.valueTo<NnsGovernanceRewardMode?, Map>(
        key: 'reward_mode',
        parse:
            (e) => NnsGovernanceRewardMode.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      amountE8s: json.valueAsBigInt<BigInt>('amount_e8s'),
    );
  }

  factory NnsGovernanceRewardNodeProvider.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRewardNodeProvider.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RewardNodeProviders`.
final class NnsGovernanceRewardNodeProviders with CandidSerializable {
  final bool? useRegistryDerivedRewards;
  final List<NnsGovernanceRewardNodeProvider> rewards;

  const NnsGovernanceRewardNodeProviders({
    this.useRegistryDerivedRewards,
    required this.rewards,
  });

  static CType get ctype => CType.record([
    Field(Label.named('use_registry_derived_rewards'), CType.opt(CType.bool_)),
    LazyField(
      Label.named('rewards'),
      () => CType.vec(NnsGovernanceRewardNodeProvider.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'use_registry_derived_rewards': useRegistryDerivedRewards,
    'rewards': rewards.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'use_registry_derived_rewards': useRegistryDerivedRewards,
    'rewards': rewards.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceRewardNodeProviders.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceRewardNodeProviders(
      useRegistryDerivedRewards: json.valueAsBool<bool?>(
        'use_registry_derived_rewards',
      ),
      rewards: json.valueTo<List<NnsGovernanceRewardNodeProvider>, List>(
        key: 'rewards',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceRewardNodeProvider>(
                      (x) => NnsGovernanceRewardNodeProvider.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceRewardNodeProviders.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRewardNodeProviders.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RewardToAccount`.
final class NnsGovernanceRewardToAccount with CandidSerializable {
  final NnsGovernanceAccountIdentifier? toAccount;

  const NnsGovernanceRewardToAccount({this.toAccount});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('to_account'),
      () => CType.opt(NnsGovernanceAccountIdentifier.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'to_account': toAccount?.candidValue};

  Map<String, dynamic> toJson() => {'to_account': toAccount?.toJson()};

  factory NnsGovernanceRewardToAccount.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceRewardToAccount(
      toAccount: json.valueTo<NnsGovernanceAccountIdentifier?, Map>(
        key: 'to_account',
        parse:
            (e) => NnsGovernanceAccountIdentifier.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceRewardToAccount.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRewardToAccount.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RewardToNeuron`.
final class NnsGovernanceRewardToNeuron with CandidSerializable {
  final BigInt dissolveDelaySeconds;

  const NnsGovernanceRewardToNeuron({required this.dissolveDelaySeconds});

  static CType get ctype =>
      CType.record([Field(Label.named('dissolve_delay_seconds'), CType.nat64)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'dissolve_delay_seconds': dissolveDelaySeconds};

  Map<String, dynamic> toJson() => {
    'dissolve_delay_seconds': dissolveDelaySeconds,
  };

  factory NnsGovernanceRewardToNeuron.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceRewardToNeuron(
      dissolveDelaySeconds: json.valueAsBigInt<BigInt>(
        'dissolve_delay_seconds',
      ),
    );
  }

  factory NnsGovernanceRewardToNeuron.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceRewardToNeuron.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SetDefaultFollowees`.
final class NnsGovernanceSetDefaultFollowees with CandidSerializable {
  final List<NnsGovernanceGovernanceDefaultFollowees> defaultFollowees;

  const NnsGovernanceSetDefaultFollowees({required this.defaultFollowees});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('default_followees'),
      () => CType.vec(NnsGovernanceGovernanceDefaultFollowees.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'default_followees': defaultFollowees.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'default_followees': defaultFollowees.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceSetDefaultFollowees.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSetDefaultFollowees(
      defaultFollowees: json.valueTo<
        List<NnsGovernanceGovernanceDefaultFollowees>,
        List
      >(
        key: 'default_followees',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceGovernanceDefaultFollowees>(
                      (x) => NnsGovernanceGovernanceDefaultFollowees.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceSetDefaultFollowees.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSetDefaultFollowees.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SetDissolveTimestamp`.
final class NnsGovernanceSetDissolveTimestamp with CandidSerializable {
  final BigInt dissolveTimestampSeconds;

  const NnsGovernanceSetDissolveTimestamp({
    required this.dissolveTimestampSeconds,
  });

  static CType get ctype => CType.record([
    Field(Label.named('dissolve_timestamp_seconds'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'dissolve_timestamp_seconds': dissolveTimestampSeconds,
  };

  Map<String, dynamic> toJson() => {
    'dissolve_timestamp_seconds': dissolveTimestampSeconds,
  };

  factory NnsGovernanceSetDissolveTimestamp.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSetDissolveTimestamp(
      dissolveTimestampSeconds: json.valueAsBigInt<BigInt>(
        'dissolve_timestamp_seconds',
      ),
    );
  }

  factory NnsGovernanceSetDissolveTimestamp.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSetDissolveTimestamp.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SetOpenTimeWindowRequest`.
final class NnsGovernanceSetOpenTimeWindowRequest with CandidSerializable {
  final NnsGovernanceTimeWindow? openTimeWindow;

  const NnsGovernanceSetOpenTimeWindowRequest({this.openTimeWindow});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('open_time_window'),
      () => CType.opt(NnsGovernanceTimeWindow.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'open_time_window': openTimeWindow?.candidValue};

  Map<String, dynamic> toJson() => {
    'open_time_window': openTimeWindow?.toJson(),
  };

  factory NnsGovernanceSetOpenTimeWindowRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSetOpenTimeWindowRequest(
      openTimeWindow: json.valueTo<NnsGovernanceTimeWindow?, Map>(
        key: 'open_time_window',
        parse:
            (e) => NnsGovernanceTimeWindow.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceSetOpenTimeWindowRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSetOpenTimeWindowRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SetSnsTokenSwapOpenTimeWindow`.
final class NnsGovernanceSetSnsTokenSwapOpenTimeWindow with CandidSerializable {
  final NnsGovernanceSetOpenTimeWindowRequest? request;
  final IcpPrincipalAddress? swapCanisterId;

  const NnsGovernanceSetSnsTokenSwapOpenTimeWindow({
    this.request,
    this.swapCanisterId,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('request'),
      () => CType.opt(NnsGovernanceSetOpenTimeWindowRequest.ctype),
    ),
    Field(Label.named('swap_canister_id'), CType.opt(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'request': request?.candidValue,
    'swap_canister_id': swapCanisterId,
  };

  Map<String, dynamic> toJson() => {
    'request': request?.toJson(),
    'swap_canister_id': swapCanisterId?.address,
  };

  factory NnsGovernanceSetSnsTokenSwapOpenTimeWindow.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSetSnsTokenSwapOpenTimeWindow(
      request: json.valueTo<NnsGovernanceSetOpenTimeWindowRequest?, Map>(
        key: 'request',
        parse:
            (e) => NnsGovernanceSetOpenTimeWindowRequest.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      swapCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'swap_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsGovernanceSetSnsTokenSwapOpenTimeWindow.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSetSnsTokenSwapOpenTimeWindow.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SetVisibility`.
final class NnsGovernanceSetVisibility with CandidSerializable {
  final int? visibility;

  const NnsGovernanceSetVisibility({this.visibility});

  static CType get ctype =>
      CType.record([Field(Label.named('visibility'), CType.opt(CType.int32))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'visibility': visibility};

  Map<String, dynamic> toJson() => {'visibility': visibility};

  factory NnsGovernanceSetVisibility.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceSetVisibility(
      visibility: json.valueAsInt<int?>('visibility'),
    );
  }

  factory NnsGovernanceSetVisibility.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSetVisibility.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SettleCommunityFundParticipation`.
final class NnsGovernanceSettleCommunityFundParticipation
    with CandidSerializable {
  final NnsGovernanceResult8? result;
  final BigInt? openSnsTokenSwapProposalId;

  const NnsGovernanceSettleCommunityFundParticipation({
    this.result,
    this.openSnsTokenSwapProposalId,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('result'),
      () => CType.opt(NnsGovernanceResult8.ctype),
    ),
    Field(
      Label.named('open_sns_token_swap_proposal_id'),
      CType.opt(CType.nat64),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'result': result?.candidValue,
    'open_sns_token_swap_proposal_id': openSnsTokenSwapProposalId,
  };

  Map<String, dynamic> toJson() => {
    'result': result?.toJson(),
    'open_sns_token_swap_proposal_id': openSnsTokenSwapProposalId,
  };

  factory NnsGovernanceSettleCommunityFundParticipation.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSettleCommunityFundParticipation(
      result: json.valueTo<NnsGovernanceResult8?, Map>(
        key: 'result',
        parse:
            (e) => NnsGovernanceResult8.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      openSnsTokenSwapProposalId: json.valueAsBigInt<BigInt?>(
        'open_sns_token_swap_proposal_id',
      ),
    );
  }

  factory NnsGovernanceSettleCommunityFundParticipation.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSettleCommunityFundParticipation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SettleNeuronsFundParticipationRequest`.
final class NnsGovernanceSettleNeuronsFundParticipationRequest
    with CandidSerializable {
  final NnsGovernanceResult9? result;
  final BigInt? nnsProposalId;

  const NnsGovernanceSettleNeuronsFundParticipationRequest({
    this.result,
    this.nnsProposalId,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('result'),
      () => CType.opt(NnsGovernanceResult9.ctype),
    ),
    Field(Label.named('nns_proposal_id'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'result': result?.candidValue,
    'nns_proposal_id': nnsProposalId,
  };

  Map<String, dynamic> toJson() => {
    'result': result?.toJson(),
    'nns_proposal_id': nnsProposalId,
  };

  factory NnsGovernanceSettleNeuronsFundParticipationRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSettleNeuronsFundParticipationRequest(
      result: json.valueTo<NnsGovernanceResult9?, Map>(
        key: 'result',
        parse:
            (e) => NnsGovernanceResult9.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      nnsProposalId: json.valueAsBigInt<BigInt?>('nns_proposal_id'),
    );
  }

  factory NnsGovernanceSettleNeuronsFundParticipationRequest.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSettleNeuronsFundParticipationRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SettleNeuronsFundParticipationResponse`.
final class NnsGovernanceSettleNeuronsFundParticipationResponse
    with CandidSerializable {
  final NnsGovernanceResult10? result;

  const NnsGovernanceSettleNeuronsFundParticipationResponse({this.result});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('result'),
      () => CType.opt(NnsGovernanceResult10.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'result': result?.candidValue};

  Map<String, dynamic> toJson() => {'result': result?.toJson()};

  factory NnsGovernanceSettleNeuronsFundParticipationResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSettleNeuronsFundParticipationResponse(
      result: json.valueTo<NnsGovernanceResult10?, Map>(
        key: 'result',
        parse:
            (e) => NnsGovernanceResult10.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceSettleNeuronsFundParticipationResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSettleNeuronsFundParticipationResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Spawn`.
final class NnsGovernanceSpawn with CandidSerializable {
  final int? percentageToSpawn;
  final IcpPrincipalAddress? newController;
  final BigInt? nonce;

  const NnsGovernanceSpawn({
    this.percentageToSpawn,
    this.newController,
    this.nonce,
  });

  static CType get ctype => CType.record([
    Field(Label.named('percentage_to_spawn'), CType.opt(CType.nat32)),
    Field(Label.named('new_controller'), CType.opt(CType.principal)),
    Field(Label.named('nonce'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'percentage_to_spawn': percentageToSpawn,
    'new_controller': newController,
    'nonce': nonce,
  };

  Map<String, dynamic> toJson() => {
    'percentage_to_spawn': percentageToSpawn,
    'new_controller': newController?.address,
    'nonce': nonce,
  };

  factory NnsGovernanceSpawn.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceSpawn(
      percentageToSpawn: json.valueAsInt<int?>('percentage_to_spawn'),
      newController: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'new_controller',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      nonce: json.valueAsBigInt<BigInt?>('nonce'),
    );
  }

  factory NnsGovernanceSpawn.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSpawn.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SpawnResponse`.
final class NnsGovernanceSpawnResponse with CandidSerializable {
  final NnsGovernanceNeuronId? createdNeuronId;

  const NnsGovernanceSpawnResponse({this.createdNeuronId});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('created_neuron_id'),
      () => CType.opt(NnsGovernanceNeuronId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'created_neuron_id': createdNeuronId?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'created_neuron_id': createdNeuronId?.toJson(),
  };

  factory NnsGovernanceSpawnResponse.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceSpawnResponse(
      createdNeuronId: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'created_neuron_id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceSpawnResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSpawnResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Split`.
final class NnsGovernanceSplit with CandidSerializable {
  final BigInt amountE8s;
  final BigInt? memo;

  const NnsGovernanceSplit({required this.amountE8s, this.memo});

  static CType get ctype => CType.record([
    Field(Label.named('amount_e8s'), CType.nat64),
    Field(Label.named('memo'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'amount_e8s': amountE8s, 'memo': memo};

  Map<String, dynamic> toJson() => {'amount_e8s': amountE8s, 'memo': memo};

  factory NnsGovernanceSplit.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceSplit(
      amountE8s: json.valueAsBigInt<BigInt>('amount_e8s'),
      memo: json.valueAsBigInt<BigInt?>('memo'),
    );
  }

  factory NnsGovernanceSplit.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSplit.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `StakeMaturity`.
final class NnsGovernanceStakeMaturity with CandidSerializable {
  final int? percentageToStake;

  const NnsGovernanceStakeMaturity({this.percentageToStake});

  static CType get ctype => CType.record([
    Field(Label.named('percentage_to_stake'), CType.opt(CType.nat32)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'percentage_to_stake': percentageToStake};

  Map<String, dynamic> toJson() => {'percentage_to_stake': percentageToStake};

  factory NnsGovernanceStakeMaturity.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceStakeMaturity(
      percentageToStake: json.valueAsInt<int?>('percentage_to_stake'),
    );
  }

  factory NnsGovernanceStakeMaturity.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceStakeMaturity.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `StakeMaturityResponse`.
final class NnsGovernanceStakeMaturityResponse with CandidSerializable {
  final BigInt maturityE8s;
  final BigInt stakedMaturityE8s;

  const NnsGovernanceStakeMaturityResponse({
    required this.maturityE8s,
    required this.stakedMaturityE8s,
  });

  static CType get ctype => CType.record([
    Field(Label.named('maturity_e8s'), CType.nat64),
    Field(Label.named('staked_maturity_e8s'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'maturity_e8s': maturityE8s,
    'staked_maturity_e8s': stakedMaturityE8s,
  };

  Map<String, dynamic> toJson() => {
    'maturity_e8s': maturityE8s,
    'staked_maturity_e8s': stakedMaturityE8s,
  };

  factory NnsGovernanceStakeMaturityResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceStakeMaturityResponse(
      maturityE8s: json.valueAsBigInt<BigInt>('maturity_e8s'),
      stakedMaturityE8s: json.valueAsBigInt<BigInt>('staked_maturity_e8s'),
    );
  }

  factory NnsGovernanceStakeMaturityResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceStakeMaturityResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `StopOrStartCanister`.
final class NnsGovernanceStopOrStartCanister with CandidSerializable {
  final int? action;
  final IcpPrincipalAddress? canisterId;

  const NnsGovernanceStopOrStartCanister({this.action, this.canisterId});

  static CType get ctype => CType.record([
    Field(Label.named('action'), CType.opt(CType.int32)),
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'action': action, 'canister_id': canisterId};

  Map<String, dynamic> toJson() => {
    'action': action,
    'canister_id': canisterId?.address,
  };

  factory NnsGovernanceStopOrStartCanister.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceStopOrStartCanister(
      action: json.valueAsInt<int?>('action'),
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsGovernanceStopOrStartCanister.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceStopOrStartCanister.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SwapBackgroundInformation`.
final class NnsGovernanceSwapBackgroundInformation with CandidSerializable {
  final NnsGovernanceCanisterSummary? ledgerIndexCanisterSummary;
  final List<IcpPrincipalAddress> fallbackControllerPrincipalIds;
  final List<NnsGovernanceCanisterSummary> ledgerArchiveCanisterSummaries;
  final NnsGovernanceCanisterSummary? ledgerCanisterSummary;
  final NnsGovernanceCanisterSummary? swapCanisterSummary;
  final NnsGovernanceCanisterSummary? governanceCanisterSummary;
  final NnsGovernanceCanisterSummary? rootCanisterSummary;
  final List<NnsGovernanceCanisterSummary> dappCanisterSummaries;

  const NnsGovernanceSwapBackgroundInformation({
    this.ledgerIndexCanisterSummary,
    required this.fallbackControllerPrincipalIds,
    required this.ledgerArchiveCanisterSummaries,
    this.ledgerCanisterSummary,
    this.swapCanisterSummary,
    this.governanceCanisterSummary,
    this.rootCanisterSummary,
    required this.dappCanisterSummaries,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('ledger_index_canister_summary'),
      () => CType.opt(NnsGovernanceCanisterSummary.ctype),
    ),
    Field(
      Label.named('fallback_controller_principal_ids'),
      CType.vec(CType.principal),
    ),
    LazyField(
      Label.named('ledger_archive_canister_summaries'),
      () => CType.vec(NnsGovernanceCanisterSummary.ctype),
    ),
    LazyField(
      Label.named('ledger_canister_summary'),
      () => CType.opt(NnsGovernanceCanisterSummary.ctype),
    ),
    LazyField(
      Label.named('swap_canister_summary'),
      () => CType.opt(NnsGovernanceCanisterSummary.ctype),
    ),
    LazyField(
      Label.named('governance_canister_summary'),
      () => CType.opt(NnsGovernanceCanisterSummary.ctype),
    ),
    LazyField(
      Label.named('root_canister_summary'),
      () => CType.opt(NnsGovernanceCanisterSummary.ctype),
    ),
    LazyField(
      Label.named('dapp_canister_summaries'),
      () => CType.vec(NnsGovernanceCanisterSummary.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'ledger_index_canister_summary': ledgerIndexCanisterSummary?.candidValue,
    'fallback_controller_principal_ids': fallbackControllerPrincipalIds,
    'ledger_archive_canister_summaries':
        ledgerArchiveCanisterSummaries.map((el) => el.candidValue).toList(),
    'ledger_canister_summary': ledgerCanisterSummary?.candidValue,
    'swap_canister_summary': swapCanisterSummary?.candidValue,
    'governance_canister_summary': governanceCanisterSummary?.candidValue,
    'root_canister_summary': rootCanisterSummary?.candidValue,
    'dapp_canister_summaries':
        dappCanisterSummaries.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'ledger_index_canister_summary': ledgerIndexCanisterSummary?.toJson(),
    'fallback_controller_principal_ids':
        fallbackControllerPrincipalIds.map((el) => el.address).toList(),
    'ledger_archive_canister_summaries':
        ledgerArchiveCanisterSummaries.map((el) => el.toJson()).toList(),
    'ledger_canister_summary': ledgerCanisterSummary?.toJson(),
    'swap_canister_summary': swapCanisterSummary?.toJson(),
    'governance_canister_summary': governanceCanisterSummary?.toJson(),
    'root_canister_summary': rootCanisterSummary?.toJson(),
    'dapp_canister_summaries':
        dappCanisterSummaries.map((el) => el.toJson()).toList(),
  };

  factory NnsGovernanceSwapBackgroundInformation.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSwapBackgroundInformation(
      ledgerIndexCanisterSummary: json
          .valueTo<NnsGovernanceCanisterSummary?, Map>(
            key: 'ledger_index_canister_summary',
            parse:
                (e) => NnsGovernanceCanisterSummary.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      fallbackControllerPrincipalIds: json
          .valueTo<List<IcpPrincipalAddress>, List>(
            key: 'fallback_controller_principal_ids',
            parse:
                (e) =>
                    e
                        .map<IcpPrincipalAddress>(
                          (x) => GeneratorParserUtils.principalFromCandid(x),
                        )
                        .toList(),
          ),
      ledgerArchiveCanisterSummaries: json
          .valueTo<List<NnsGovernanceCanisterSummary>, List>(
            key: 'ledger_archive_canister_summaries',
            parse:
                (e) =>
                    e
                        .map<NnsGovernanceCanisterSummary>(
                          (x) => NnsGovernanceCanisterSummary.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
      ledgerCanisterSummary: json.valueTo<NnsGovernanceCanisterSummary?, Map>(
        key: 'ledger_canister_summary',
        parse:
            (e) => NnsGovernanceCanisterSummary.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      swapCanisterSummary: json.valueTo<NnsGovernanceCanisterSummary?, Map>(
        key: 'swap_canister_summary',
        parse:
            (e) => NnsGovernanceCanisterSummary.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      governanceCanisterSummary: json
          .valueTo<NnsGovernanceCanisterSummary?, Map>(
            key: 'governance_canister_summary',
            parse:
                (e) => NnsGovernanceCanisterSummary.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      rootCanisterSummary: json.valueTo<NnsGovernanceCanisterSummary?, Map>(
        key: 'root_canister_summary',
        parse:
            (e) => NnsGovernanceCanisterSummary.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      dappCanisterSummaries: json
          .valueTo<List<NnsGovernanceCanisterSummary>, List>(
            key: 'dapp_canister_summaries',
            parse:
                (e) =>
                    e
                        .map<NnsGovernanceCanisterSummary>(
                          (x) => NnsGovernanceCanisterSummary.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsGovernanceSwapBackgroundInformation.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSwapBackgroundInformation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SwapDistribution`.
final class NnsGovernanceSwapDistribution with CandidSerializable {
  final NnsGovernanceTokens? total;

  const NnsGovernanceSwapDistribution({this.total});

  static CType get ctype => CType.record([
    LazyField(Label.named('total'), () => CType.opt(NnsGovernanceTokens.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'total': total?.candidValue};

  Map<String, dynamic> toJson() => {'total': total?.toJson()};

  factory NnsGovernanceSwapDistribution.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceSwapDistribution(
      total: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'total',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceSwapDistribution.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSwapDistribution.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SwapParameters`.
final class NnsGovernanceSwapParameters with CandidSerializable {
  final BigInt? minimumParticipants;
  final bool? neuronsFundParticipation;
  final NnsGovernanceDuration? duration;
  final NnsGovernanceNeuronBasketConstructionParameters?
  neuronBasketConstructionParameters;
  final String? confirmationText;
  final NnsGovernanceTokens? maximumParticipantIcp;
  final NnsGovernanceTokens? minimumIcp;
  final NnsGovernanceTokens? minimumDirectParticipationIcp;
  final NnsGovernanceTokens? minimumParticipantIcp;
  final NnsGovernanceGlobalTimeOfDay? startTime;
  final NnsGovernanceTokens? maximumDirectParticipationIcp;
  final NnsGovernanceTokens? maximumIcp;
  final NnsGovernanceTokens? neuronsFundInvestmentIcp;
  final NnsGovernanceCountries? restrictedCountries;

  const NnsGovernanceSwapParameters({
    this.minimumParticipants,
    this.neuronsFundParticipation,
    this.duration,
    this.neuronBasketConstructionParameters,
    this.confirmationText,
    this.maximumParticipantIcp,
    this.minimumIcp,
    this.minimumDirectParticipationIcp,
    this.minimumParticipantIcp,
    this.startTime,
    this.maximumDirectParticipationIcp,
    this.maximumIcp,
    this.neuronsFundInvestmentIcp,
    this.restrictedCountries,
  });

  static CType get ctype => CType.record([
    Field(Label.named('minimum_participants'), CType.opt(CType.nat64)),
    Field(Label.named('neurons_fund_participation'), CType.opt(CType.bool_)),
    LazyField(
      Label.named('duration'),
      () => CType.opt(NnsGovernanceDuration.ctype),
    ),
    LazyField(
      Label.named('neuron_basket_construction_parameters'),
      () => CType.opt(NnsGovernanceNeuronBasketConstructionParameters.ctype),
    ),
    Field(Label.named('confirmation_text'), CType.opt(CType.text)),
    LazyField(
      Label.named('maximum_participant_icp'),
      () => CType.opt(NnsGovernanceTokens.ctype),
    ),
    LazyField(
      Label.named('minimum_icp'),
      () => CType.opt(NnsGovernanceTokens.ctype),
    ),
    LazyField(
      Label.named('minimum_direct_participation_icp'),
      () => CType.opt(NnsGovernanceTokens.ctype),
    ),
    LazyField(
      Label.named('minimum_participant_icp'),
      () => CType.opt(NnsGovernanceTokens.ctype),
    ),
    LazyField(
      Label.named('start_time'),
      () => CType.opt(NnsGovernanceGlobalTimeOfDay.ctype),
    ),
    LazyField(
      Label.named('maximum_direct_participation_icp'),
      () => CType.opt(NnsGovernanceTokens.ctype),
    ),
    LazyField(
      Label.named('maximum_icp'),
      () => CType.opt(NnsGovernanceTokens.ctype),
    ),
    LazyField(
      Label.named('neurons_fund_investment_icp'),
      () => CType.opt(NnsGovernanceTokens.ctype),
    ),
    LazyField(
      Label.named('restricted_countries'),
      () => CType.opt(NnsGovernanceCountries.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'minimum_participants': minimumParticipants,
    'neurons_fund_participation': neuronsFundParticipation,
    'duration': duration?.candidValue,
    'neuron_basket_construction_parameters':
        neuronBasketConstructionParameters?.candidValue,
    'confirmation_text': confirmationText,
    'maximum_participant_icp': maximumParticipantIcp?.candidValue,
    'minimum_icp': minimumIcp?.candidValue,
    'minimum_direct_participation_icp':
        minimumDirectParticipationIcp?.candidValue,
    'minimum_participant_icp': minimumParticipantIcp?.candidValue,
    'start_time': startTime?.candidValue,
    'maximum_direct_participation_icp':
        maximumDirectParticipationIcp?.candidValue,
    'maximum_icp': maximumIcp?.candidValue,
    'neurons_fund_investment_icp': neuronsFundInvestmentIcp?.candidValue,
    'restricted_countries': restrictedCountries?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'minimum_participants': minimumParticipants,
    'neurons_fund_participation': neuronsFundParticipation,
    'duration': duration?.toJson(),
    'neuron_basket_construction_parameters':
        neuronBasketConstructionParameters?.toJson(),
    'confirmation_text': confirmationText,
    'maximum_participant_icp': maximumParticipantIcp?.toJson(),
    'minimum_icp': minimumIcp?.toJson(),
    'minimum_direct_participation_icp': minimumDirectParticipationIcp?.toJson(),
    'minimum_participant_icp': minimumParticipantIcp?.toJson(),
    'start_time': startTime?.toJson(),
    'maximum_direct_participation_icp': maximumDirectParticipationIcp?.toJson(),
    'maximum_icp': maximumIcp?.toJson(),
    'neurons_fund_investment_icp': neuronsFundInvestmentIcp?.toJson(),
    'restricted_countries': restrictedCountries?.toJson(),
  };

  factory NnsGovernanceSwapParameters.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceSwapParameters(
      minimumParticipants: json.valueAsBigInt<BigInt?>('minimum_participants'),
      neuronsFundParticipation: json.valueAsBool<bool?>(
        'neurons_fund_participation',
      ),
      duration: json.valueTo<NnsGovernanceDuration?, Map>(
        key: 'duration',
        parse:
            (e) => NnsGovernanceDuration.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      neuronBasketConstructionParameters: json
          .valueTo<NnsGovernanceNeuronBasketConstructionParameters?, Map>(
            key: 'neuron_basket_construction_parameters',
            parse:
                (e) =>
                    NnsGovernanceNeuronBasketConstructionParameters.fromCandid(
                      JsonParser.valueEnsureAsMap<String, dynamic>(e),
                    ),
          ),
      confirmationText: json.valueAsString<String?>('confirmation_text'),
      maximumParticipantIcp: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'maximum_participant_icp',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      minimumIcp: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'minimum_icp',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      minimumDirectParticipationIcp: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'minimum_direct_participation_icp',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      minimumParticipantIcp: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'minimum_participant_icp',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      startTime: json.valueTo<NnsGovernanceGlobalTimeOfDay?, Map>(
        key: 'start_time',
        parse:
            (e) => NnsGovernanceGlobalTimeOfDay.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      maximumDirectParticipationIcp: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'maximum_direct_participation_icp',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      maximumIcp: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'maximum_icp',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      neuronsFundInvestmentIcp: json.valueTo<NnsGovernanceTokens?, Map>(
        key: 'neurons_fund_investment_icp',
        parse:
            (e) => NnsGovernanceTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      restrictedCountries: json.valueTo<NnsGovernanceCountries?, Map>(
        key: 'restricted_countries',
        parse:
            (e) => NnsGovernanceCountries.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceSwapParameters.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSwapParameters.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SwapParticipationLimits`.
final class NnsGovernanceSwapParticipationLimits with CandidSerializable {
  final BigInt? minParticipantIcpE8s;
  final BigInt? maxParticipantIcpE8s;
  final BigInt? minDirectParticipationIcpE8s;
  final BigInt? maxDirectParticipationIcpE8s;

  const NnsGovernanceSwapParticipationLimits({
    this.minParticipantIcpE8s,
    this.maxParticipantIcpE8s,
    this.minDirectParticipationIcpE8s,
    this.maxDirectParticipationIcpE8s,
  });

  static CType get ctype => CType.record([
    Field(Label.named('min_participant_icp_e8s'), CType.opt(CType.nat64)),
    Field(Label.named('max_participant_icp_e8s'), CType.opt(CType.nat64)),
    Field(
      Label.named('min_direct_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(
      Label.named('max_direct_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'min_participant_icp_e8s': minParticipantIcpE8s,
    'max_participant_icp_e8s': maxParticipantIcpE8s,
    'min_direct_participation_icp_e8s': minDirectParticipationIcpE8s,
    'max_direct_participation_icp_e8s': maxDirectParticipationIcpE8s,
  };

  Map<String, dynamic> toJson() => {
    'min_participant_icp_e8s': minParticipantIcpE8s,
    'max_participant_icp_e8s': maxParticipantIcpE8s,
    'min_direct_participation_icp_e8s': minDirectParticipationIcpE8s,
    'max_direct_participation_icp_e8s': maxDirectParticipationIcpE8s,
  };

  factory NnsGovernanceSwapParticipationLimits.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSwapParticipationLimits(
      minParticipantIcpE8s: json.valueAsBigInt<BigInt?>(
        'min_participant_icp_e8s',
      ),
      maxParticipantIcpE8s: json.valueAsBigInt<BigInt?>(
        'max_participant_icp_e8s',
      ),
      minDirectParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'min_direct_participation_icp_e8s',
      ),
      maxDirectParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'max_direct_participation_icp_e8s',
      ),
    );
  }

  factory NnsGovernanceSwapParticipationLimits.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSwapParticipationLimits.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Tally`.
final class NnsGovernanceTally with CandidSerializable {
  final BigInt no;
  final BigInt yes;
  final BigInt total;
  final BigInt timestampSeconds;

  const NnsGovernanceTally({
    required this.no,
    required this.yes,
    required this.total,
    required this.timestampSeconds,
  });

  static CType get ctype => CType.record([
    Field(Label.named('no'), CType.nat64),
    Field(Label.named('yes'), CType.nat64),
    Field(Label.named('total'), CType.nat64),
    Field(Label.named('timestamp_seconds'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'no': no,
    'yes': yes,
    'total': total,
    'timestamp_seconds': timestampSeconds,
  };

  Map<String, dynamic> toJson() => {
    'no': no,
    'yes': yes,
    'total': total,
    'timestamp_seconds': timestampSeconds,
  };

  factory NnsGovernanceTally.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceTally(
      no: json.valueAsBigInt<BigInt>('no'),
      yes: json.valueAsBigInt<BigInt>('yes'),
      total: json.valueAsBigInt<BigInt>('total'),
      timestampSeconds: json.valueAsBigInt<BigInt>('timestamp_seconds'),
    );
  }

  factory NnsGovernanceTally.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceTally.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TimeWindow`.
final class NnsGovernanceTimeWindow with CandidSerializable {
  final BigInt startTimestampSeconds;
  final BigInt endTimestampSeconds;

  const NnsGovernanceTimeWindow({
    required this.startTimestampSeconds,
    required this.endTimestampSeconds,
  });

  static CType get ctype => CType.record([
    Field(Label.named('start_timestamp_seconds'), CType.nat64),
    Field(Label.named('end_timestamp_seconds'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'start_timestamp_seconds': startTimestampSeconds,
    'end_timestamp_seconds': endTimestampSeconds,
  };

  Map<String, dynamic> toJson() => {
    'start_timestamp_seconds': startTimestampSeconds,
    'end_timestamp_seconds': endTimestampSeconds,
  };

  factory NnsGovernanceTimeWindow.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceTimeWindow(
      startTimestampSeconds: json.valueAsBigInt<BigInt>(
        'start_timestamp_seconds',
      ),
      endTimestampSeconds: json.valueAsBigInt<BigInt>('end_timestamp_seconds'),
    );
  }

  factory NnsGovernanceTimeWindow.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceTimeWindow.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Tokens`.
final class NnsGovernanceTokens with CandidSerializable {
  final BigInt? e8s;

  const NnsGovernanceTokens({this.e8s});

  static CType get ctype =>
      CType.record([Field(Label.named('e8s'), CType.opt(CType.nat64))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'e8s': e8s};

  Map<String, dynamic> toJson() => {'e8s': e8s};

  factory NnsGovernanceTokens.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceTokens(e8s: json.valueAsBigInt<BigInt?>('e8s'));
  }

  factory NnsGovernanceTokens.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceTokens.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `UpdateCanisterSettings`.
final class NnsGovernanceUpdateCanisterSettings with CandidSerializable {
  final IcpPrincipalAddress? canisterId;
  final NnsGovernanceCanisterSettings? settings;

  const NnsGovernanceUpdateCanisterSettings({this.canisterId, this.settings});

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
    LazyField(
      Label.named('settings'),
      () => CType.opt(NnsGovernanceCanisterSettings.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'settings': settings?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId?.address,
    'settings': settings?.toJson(),
  };

  factory NnsGovernanceUpdateCanisterSettings.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceUpdateCanisterSettings(
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      settings: json.valueTo<NnsGovernanceCanisterSettings?, Map>(
        key: 'settings',
        parse:
            (e) => NnsGovernanceCanisterSettings.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceUpdateCanisterSettings.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceUpdateCanisterSettings.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `UpdateNodeProvider`.
final class NnsGovernanceUpdateNodeProvider with CandidSerializable {
  final NnsGovernanceAccountIdentifier? rewardAccount;

  const NnsGovernanceUpdateNodeProvider({this.rewardAccount});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('reward_account'),
      () => CType.opt(NnsGovernanceAccountIdentifier.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'reward_account': rewardAccount?.candidValue};

  Map<String, dynamic> toJson() => {'reward_account': rewardAccount?.toJson()};

  factory NnsGovernanceUpdateNodeProvider.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceUpdateNodeProvider(
      rewardAccount: json.valueTo<NnsGovernanceAccountIdentifier?, Map>(
        key: 'reward_account',
        parse:
            (e) => NnsGovernanceAccountIdentifier.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceUpdateNodeProvider.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceUpdateNodeProvider.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `VotingRewardParameters`.
final class NnsGovernanceVotingRewardParameters with CandidSerializable {
  final NnsGovernanceDuration? rewardRateTransitionDuration;
  final NnsGovernancePercentage? initialRewardRate;
  final NnsGovernancePercentage? finalRewardRate;

  const NnsGovernanceVotingRewardParameters({
    this.rewardRateTransitionDuration,
    this.initialRewardRate,
    this.finalRewardRate,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('reward_rate_transition_duration'),
      () => CType.opt(NnsGovernanceDuration.ctype),
    ),
    LazyField(
      Label.named('initial_reward_rate'),
      () => CType.opt(NnsGovernancePercentage.ctype),
    ),
    LazyField(
      Label.named('final_reward_rate'),
      () => CType.opt(NnsGovernancePercentage.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'reward_rate_transition_duration':
        rewardRateTransitionDuration?.candidValue,
    'initial_reward_rate': initialRewardRate?.candidValue,
    'final_reward_rate': finalRewardRate?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'reward_rate_transition_duration': rewardRateTransitionDuration?.toJson(),
    'initial_reward_rate': initialRewardRate?.toJson(),
    'final_reward_rate': finalRewardRate?.toJson(),
  };

  factory NnsGovernanceVotingRewardParameters.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceVotingRewardParameters(
      rewardRateTransitionDuration: json.valueTo<NnsGovernanceDuration?, Map>(
        key: 'reward_rate_transition_duration',
        parse:
            (e) => NnsGovernanceDuration.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      initialRewardRate: json.valueTo<NnsGovernancePercentage?, Map>(
        key: 'initial_reward_rate',
        parse:
            (e) => NnsGovernancePercentage.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      finalRewardRate: json.valueTo<NnsGovernancePercentage?, Map>(
        key: 'final_reward_rate',
        parse:
            (e) => NnsGovernancePercentage.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceVotingRewardParameters.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceVotingRewardParameters.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CustomProposalCriticality`.
final class NnsGovernanceCustomProposalCriticality with CandidSerializable {
  final List<BigInt>? additionalCriticalNativeActionIds;

  const NnsGovernanceCustomProposalCriticality({
    this.additionalCriticalNativeActionIds,
  });

  static CType get ctype => CType.record([
    Field(
      Label.named('additional_critical_native_action_ids'),
      CType.opt(CType.vec(CType.nat64)),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'additional_critical_native_action_ids': additionalCriticalNativeActionIds,
  };

  Map<String, dynamic> toJson() => {
    'additional_critical_native_action_ids': additionalCriticalNativeActionIds,
  };

  factory NnsGovernanceCustomProposalCriticality.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceCustomProposalCriticality(
      additionalCriticalNativeActionIds: json.valueTo<List<BigInt>?, List>(
        key: 'additional_critical_native_action_ids',
        parse:
            (e) =>
                e
                    .map<BigInt>((x) => JsonParser.valueAsBigInt<BigInt>(x))
                    .toList(),
      ),
    );
  }

  factory NnsGovernanceCustomProposalCriticality.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCustomProposalCriticality.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `WasmModule`.
sealed class NnsGovernanceWasmModule with CandidSerializable {
  const NnsGovernanceWasmModule();

  static CType get ctype =>
      CType.variant([Field(Label.named('Inlined'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceWasmModule.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Inlined')) {
      return NnsGovernanceWasmModuleInlined(
        json.valueAsBytes<List<int>>(
          'Inlined',
          encoding: StringEncoding.base64,
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceWasmModule.fromCandid',
      reason: 'Unknown NnsGovernanceWasmModule arm',
    );
  }

  factory NnsGovernanceWasmModule.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceWasmModule.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `WasmModule.Inlined`.
final class NnsGovernanceWasmModuleInlined extends NnsGovernanceWasmModule {
  final List<int> value;
  const NnsGovernanceWasmModuleInlined(this.value);

  @override
  CType get candidType => NnsGovernanceWasmModule.ctype;

  @override
  dynamic get candidValue => Variant('Inlined', value);

  @override
  Map<String, dynamic> toJson() => {'Inlined': value};
}

/// Candid record `WaitForQuietState`.
final class NnsGovernanceWaitForQuietState with CandidSerializable {
  final BigInt currentDeadlineTimestampSeconds;

  const NnsGovernanceWaitForQuietState({
    required this.currentDeadlineTimestampSeconds,
  });

  static CType get ctype => CType.record([
    Field(Label.named('current_deadline_timestamp_seconds'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'current_deadline_timestamp_seconds': currentDeadlineTimestampSeconds,
  };

  Map<String, dynamic> toJson() => {
    'current_deadline_timestamp_seconds': currentDeadlineTimestampSeconds,
  };

  factory NnsGovernanceWaitForQuietState.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceWaitForQuietState(
      currentDeadlineTimestampSeconds: json.valueAsBigInt<BigInt>(
        'current_deadline_timestamp_seconds',
      ),
    );
  }

  factory NnsGovernanceWaitForQuietState.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceWaitForQuietState.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `XdrConversionRate`.
final class NnsGovernanceXdrConversionRate with CandidSerializable {
  final BigInt? xdrPermyriadPerIcp;
  final BigInt? timestampSeconds;

  const NnsGovernanceXdrConversionRate({
    this.xdrPermyriadPerIcp,
    this.timestampSeconds,
  });

  static CType get ctype => CType.record([
    Field(Label.named('xdr_permyriad_per_icp'), CType.opt(CType.nat64)),
    Field(Label.named('timestamp_seconds'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'xdr_permyriad_per_icp': xdrPermyriadPerIcp,
    'timestamp_seconds': timestampSeconds,
  };

  Map<String, dynamic> toJson() => {
    'xdr_permyriad_per_icp': xdrPermyriadPerIcp,
    'timestamp_seconds': timestampSeconds,
  };

  factory NnsGovernanceXdrConversionRate.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceXdrConversionRate(
      xdrPermyriadPerIcp: json.valueAsBigInt<BigInt?>('xdr_permyriad_per_icp'),
      timestampSeconds: json.valueAsBigInt<BigInt?>('timestamp_seconds'),
    );
  }

  factory NnsGovernanceXdrConversionRate.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceXdrConversionRate.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `MaturityDisbursement`.
final class NnsGovernanceMaturityDisbursement with CandidSerializable {
  final BigInt? amountE8s;
  final BigInt? timestampOfDisbursementSeconds;
  final BigInt? finalizeDisbursementTimestampSeconds;
  final NnsGovernanceAccount? accountToDisburseTo;
  final NnsGovernanceAccountIdentifier? accountIdentifierToDisburseTo;

  const NnsGovernanceMaturityDisbursement({
    this.amountE8s,
    this.timestampOfDisbursementSeconds,
    this.finalizeDisbursementTimestampSeconds,
    this.accountToDisburseTo,
    this.accountIdentifierToDisburseTo,
  });

  static CType get ctype => CType.record([
    Field(Label.named('amount_e8s'), CType.opt(CType.nat64)),
    Field(
      Label.named('timestamp_of_disbursement_seconds'),
      CType.opt(CType.nat64),
    ),
    Field(
      Label.named('finalize_disbursement_timestamp_seconds'),
      CType.opt(CType.nat64),
    ),
    LazyField(
      Label.named('account_to_disburse_to'),
      () => CType.opt(NnsGovernanceAccount.ctype),
    ),
    LazyField(
      Label.named('account_identifier_to_disburse_to'),
      () => CType.opt(NnsGovernanceAccountIdentifier.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'amount_e8s': amountE8s,
    'timestamp_of_disbursement_seconds': timestampOfDisbursementSeconds,
    'finalize_disbursement_timestamp_seconds':
        finalizeDisbursementTimestampSeconds,
    'account_to_disburse_to': accountToDisburseTo?.candidValue,
    'account_identifier_to_disburse_to':
        accountIdentifierToDisburseTo?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'amount_e8s': amountE8s,
    'timestamp_of_disbursement_seconds': timestampOfDisbursementSeconds,
    'finalize_disbursement_timestamp_seconds':
        finalizeDisbursementTimestampSeconds,
    'account_to_disburse_to': accountToDisburseTo?.toJson(),
    'account_identifier_to_disburse_to':
        accountIdentifierToDisburseTo?.toJson(),
  };

  factory NnsGovernanceMaturityDisbursement.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceMaturityDisbursement(
      amountE8s: json.valueAsBigInt<BigInt?>('amount_e8s'),
      timestampOfDisbursementSeconds: json.valueAsBigInt<BigInt?>(
        'timestamp_of_disbursement_seconds',
      ),
      finalizeDisbursementTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'finalize_disbursement_timestamp_seconds',
      ),
      accountToDisburseTo: json.valueTo<NnsGovernanceAccount?, Map>(
        key: 'account_to_disburse_to',
        parse:
            (e) => NnsGovernanceAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      accountIdentifierToDisburseTo: json
          .valueTo<NnsGovernanceAccountIdentifier?, Map>(
            key: 'account_identifier_to_disburse_to',
            parse:
                (e) => NnsGovernanceAccountIdentifier.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsGovernanceMaturityDisbursement.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceMaturityDisbursement.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `TopicToFollow`.
sealed class NnsGovernanceTopicToFollow with CandidSerializable {
  const NnsGovernanceTopicToFollow();

  static CType get ctype => CType.variant([
    Field(Label.named('CatchAll'), CType.null_),
    Field(Label.named('NeuronManagement'), CType.null_),
    Field(Label.named('ExchangeRate'), CType.null_),
    Field(Label.named('NetworkEconomics'), CType.null_),
    Field(Label.named('Governance'), CType.null_),
    Field(Label.named('NodeAdmin'), CType.null_),
    Field(Label.named('ParticipantManagement'), CType.null_),
    Field(Label.named('SubnetManagement'), CType.null_),
    Field(Label.named('Kyc'), CType.null_),
    Field(Label.named('NodeProviderRewards'), CType.null_),
    Field(Label.named('IcOsVersionDeployment'), CType.null_),
    Field(Label.named('IcOsVersionElection'), CType.null_),
    Field(Label.named('SnsAndCommunityFund'), CType.null_),
    Field(Label.named('ApiBoundaryNodeManagement'), CType.null_),
    Field(Label.named('SubnetRental'), CType.null_),
    Field(Label.named('ApplicationCanisterManagement'), CType.null_),
    Field(Label.named('ProtocolCanisterManagement'), CType.null_),
    Field(Label.named('ServiceNervousSystemManagement'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceTopicToFollow.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('CatchAll')) {
      return const NnsGovernanceTopicToFollowCatchAll();
    }
    if (json.containsKey('NeuronManagement')) {
      return const NnsGovernanceTopicToFollowNeuronManagement();
    }
    if (json.containsKey('ExchangeRate')) {
      return const NnsGovernanceTopicToFollowExchangeRate();
    }
    if (json.containsKey('NetworkEconomics')) {
      return const NnsGovernanceTopicToFollowNetworkEconomics();
    }
    if (json.containsKey('Governance')) {
      return const NnsGovernanceTopicToFollowGovernance();
    }
    if (json.containsKey('NodeAdmin')) {
      return const NnsGovernanceTopicToFollowNodeAdmin();
    }
    if (json.containsKey('ParticipantManagement')) {
      return const NnsGovernanceTopicToFollowParticipantManagement();
    }
    if (json.containsKey('SubnetManagement')) {
      return const NnsGovernanceTopicToFollowSubnetManagement();
    }
    if (json.containsKey('Kyc')) {
      return const NnsGovernanceTopicToFollowKyc();
    }
    if (json.containsKey('NodeProviderRewards')) {
      return const NnsGovernanceTopicToFollowNodeProviderRewards();
    }
    if (json.containsKey('IcOsVersionDeployment')) {
      return const NnsGovernanceTopicToFollowIcOsVersionDeployment();
    }
    if (json.containsKey('IcOsVersionElection')) {
      return const NnsGovernanceTopicToFollowIcOsVersionElection();
    }
    if (json.containsKey('SnsAndCommunityFund')) {
      return const NnsGovernanceTopicToFollowSnsAndCommunityFund();
    }
    if (json.containsKey('ApiBoundaryNodeManagement')) {
      return const NnsGovernanceTopicToFollowApiBoundaryNodeManagement();
    }
    if (json.containsKey('SubnetRental')) {
      return const NnsGovernanceTopicToFollowSubnetRental();
    }
    if (json.containsKey('ApplicationCanisterManagement')) {
      return const NnsGovernanceTopicToFollowApplicationCanisterManagement();
    }
    if (json.containsKey('ProtocolCanisterManagement')) {
      return const NnsGovernanceTopicToFollowProtocolCanisterManagement();
    }
    if (json.containsKey('ServiceNervousSystemManagement')) {
      return const NnsGovernanceTopicToFollowServiceNervousSystemManagement();
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceTopicToFollow.fromCandid',
      reason: 'Unknown NnsGovernanceTopicToFollow arm',
    );
  }

  factory NnsGovernanceTopicToFollow.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceTopicToFollow.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TopicToFollow.CatchAll` (nullary).
final class NnsGovernanceTopicToFollowCatchAll
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowCatchAll();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('CatchAll', null);

  @override
  Map<String, dynamic> toJson() => {'CatchAll': null};
}

/// Variant arm `TopicToFollow.NeuronManagement` (nullary).
final class NnsGovernanceTopicToFollowNeuronManagement
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowNeuronManagement();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('NeuronManagement', null);

  @override
  Map<String, dynamic> toJson() => {'NeuronManagement': null};
}

/// Variant arm `TopicToFollow.ExchangeRate` (nullary).
final class NnsGovernanceTopicToFollowExchangeRate
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowExchangeRate();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('ExchangeRate', null);

  @override
  Map<String, dynamic> toJson() => {'ExchangeRate': null};
}

/// Variant arm `TopicToFollow.NetworkEconomics` (nullary).
final class NnsGovernanceTopicToFollowNetworkEconomics
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowNetworkEconomics();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('NetworkEconomics', null);

  @override
  Map<String, dynamic> toJson() => {'NetworkEconomics': null};
}

/// Variant arm `TopicToFollow.Governance` (nullary).
final class NnsGovernanceTopicToFollowGovernance
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowGovernance();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('Governance', null);

  @override
  Map<String, dynamic> toJson() => {'Governance': null};
}

/// Variant arm `TopicToFollow.NodeAdmin` (nullary).
final class NnsGovernanceTopicToFollowNodeAdmin
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowNodeAdmin();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('NodeAdmin', null);

  @override
  Map<String, dynamic> toJson() => {'NodeAdmin': null};
}

/// Variant arm `TopicToFollow.ParticipantManagement` (nullary).
final class NnsGovernanceTopicToFollowParticipantManagement
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowParticipantManagement();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('ParticipantManagement', null);

  @override
  Map<String, dynamic> toJson() => {'ParticipantManagement': null};
}

/// Variant arm `TopicToFollow.SubnetManagement` (nullary).
final class NnsGovernanceTopicToFollowSubnetManagement
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowSubnetManagement();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('SubnetManagement', null);

  @override
  Map<String, dynamic> toJson() => {'SubnetManagement': null};
}

/// Variant arm `TopicToFollow.Kyc` (nullary).
final class NnsGovernanceTopicToFollowKyc extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowKyc();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('Kyc', null);

  @override
  Map<String, dynamic> toJson() => {'Kyc': null};
}

/// Variant arm `TopicToFollow.NodeProviderRewards` (nullary).
final class NnsGovernanceTopicToFollowNodeProviderRewards
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowNodeProviderRewards();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('NodeProviderRewards', null);

  @override
  Map<String, dynamic> toJson() => {'NodeProviderRewards': null};
}

/// Variant arm `TopicToFollow.IcOsVersionDeployment` (nullary).
final class NnsGovernanceTopicToFollowIcOsVersionDeployment
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowIcOsVersionDeployment();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('IcOsVersionDeployment', null);

  @override
  Map<String, dynamic> toJson() => {'IcOsVersionDeployment': null};
}

/// Variant arm `TopicToFollow.IcOsVersionElection` (nullary).
final class NnsGovernanceTopicToFollowIcOsVersionElection
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowIcOsVersionElection();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('IcOsVersionElection', null);

  @override
  Map<String, dynamic> toJson() => {'IcOsVersionElection': null};
}

/// Variant arm `TopicToFollow.SnsAndCommunityFund` (nullary).
final class NnsGovernanceTopicToFollowSnsAndCommunityFund
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowSnsAndCommunityFund();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('SnsAndCommunityFund', null);

  @override
  Map<String, dynamic> toJson() => {'SnsAndCommunityFund': null};
}

/// Variant arm `TopicToFollow.ApiBoundaryNodeManagement` (nullary).
final class NnsGovernanceTopicToFollowApiBoundaryNodeManagement
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowApiBoundaryNodeManagement();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('ApiBoundaryNodeManagement', null);

  @override
  Map<String, dynamic> toJson() => {'ApiBoundaryNodeManagement': null};
}

/// Variant arm `TopicToFollow.SubnetRental` (nullary).
final class NnsGovernanceTopicToFollowSubnetRental
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowSubnetRental();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('SubnetRental', null);

  @override
  Map<String, dynamic> toJson() => {'SubnetRental': null};
}

/// Variant arm `TopicToFollow.ApplicationCanisterManagement` (nullary).
final class NnsGovernanceTopicToFollowApplicationCanisterManagement
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowApplicationCanisterManagement();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue =>
      const Variant('ApplicationCanisterManagement', null);

  @override
  Map<String, dynamic> toJson() => {'ApplicationCanisterManagement': null};
}

/// Variant arm `TopicToFollow.ProtocolCanisterManagement` (nullary).
final class NnsGovernanceTopicToFollowProtocolCanisterManagement
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowProtocolCanisterManagement();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue => const Variant('ProtocolCanisterManagement', null);

  @override
  Map<String, dynamic> toJson() => {'ProtocolCanisterManagement': null};
}

/// Variant arm `TopicToFollow.ServiceNervousSystemManagement` (nullary).
final class NnsGovernanceTopicToFollowServiceNervousSystemManagement
    extends NnsGovernanceTopicToFollow {
  const NnsGovernanceTopicToFollowServiceNervousSystemManagement();

  @override
  CType get candidType => NnsGovernanceTopicToFollow.ctype;

  @override
  dynamic get candidValue =>
      const Variant('ServiceNervousSystemManagement', null);

  @override
  Map<String, dynamic> toJson() => {'ServiceNervousSystemManagement': null};
}

/// Candid record `ListNeuronVotesRequest`.
final class NnsGovernanceListNeuronVotesRequest with CandidSerializable {
  final NnsGovernanceNeuronId? neuronId;
  final NnsGovernanceProposalId? beforeProposal;
  final BigInt? limit;

  const NnsGovernanceListNeuronVotesRequest({
    this.neuronId,
    this.beforeProposal,
    this.limit,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('neuron_id'),
      () => CType.opt(NnsGovernanceNeuronId.ctype),
    ),
    LazyField(
      Label.named('before_proposal'),
      () => CType.opt(NnsGovernanceProposalId.ctype),
    ),
    Field(Label.named('limit'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'neuron_id': neuronId?.candidValue,
    'before_proposal': beforeProposal?.candidValue,
    'limit': limit,
  };

  Map<String, dynamic> toJson() => {
    'neuron_id': neuronId?.toJson(),
    'before_proposal': beforeProposal?.toJson(),
    'limit': limit,
  };

  factory NnsGovernanceListNeuronVotesRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceListNeuronVotesRequest(
      neuronId: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'neuron_id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      beforeProposal: json.valueTo<NnsGovernanceProposalId?, Map>(
        key: 'before_proposal',
        parse:
            (e) => NnsGovernanceProposalId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      limit: json.valueAsBigInt<BigInt?>('limit'),
    );
  }

  factory NnsGovernanceListNeuronVotesRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListNeuronVotesRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ListNeuronVotesResponse`.
sealed class NnsGovernanceListNeuronVotesResponse with CandidSerializable {
  const NnsGovernanceListNeuronVotesResponse();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => CType.record([
        LazyField(
          Label.named('votes'),
          () => CType.opt(CType.vec(NnsGovernanceNeuronVote.ctype)),
        ),
        LazyField(
          Label.named('all_finalized_before_proposal'),
          () => CType.opt(NnsGovernanceProposalId.ctype),
        ),
      ]),
    ),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceListNeuronVotesResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsGovernanceListNeuronVotesResponseOk.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Ok']),
      );
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceListNeuronVotesResponseErr(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceListNeuronVotesResponse.fromCandid',
      reason: 'Unknown NnsGovernanceListNeuronVotesResponse arm',
    );
  }

  factory NnsGovernanceListNeuronVotesResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceListNeuronVotesResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ListNeuronVotesResponse.Ok`.
final class NnsGovernanceListNeuronVotesResponseOk
    extends NnsGovernanceListNeuronVotesResponse {
  final List<NnsGovernanceNeuronVote>? votes;
  final NnsGovernanceProposalId? allFinalizedBeforeProposal;

  const NnsGovernanceListNeuronVotesResponseOk({
    this.votes,
    this.allFinalizedBeforeProposal,
  });

  @override
  CType get candidType => NnsGovernanceListNeuronVotesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', {
    'votes': votes?.map((el) => el.candidValue).toList(),
    'all_finalized_before_proposal': allFinalizedBeforeProposal?.candidValue,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Ok': {
      'votes': votes?.map((el) => el.toJson()).toList(),
      'all_finalized_before_proposal': allFinalizedBeforeProposal?.toJson(),
    },
  };

  factory NnsGovernanceListNeuronVotesResponseOk.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceListNeuronVotesResponseOk(
      votes: json.valueTo<List<NnsGovernanceNeuronVote>?, List>(
        key: 'votes',
        parse:
            (e) =>
                e
                    .map<NnsGovernanceNeuronVote>(
                      (x) => NnsGovernanceNeuronVote.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      allFinalizedBeforeProposal: json.valueTo<NnsGovernanceProposalId?, Map>(
        key: 'all_finalized_before_proposal',
        parse:
            (e) => NnsGovernanceProposalId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }
}

/// Variant arm `ListNeuronVotesResponse.Err`.
final class NnsGovernanceListNeuronVotesResponseErr
    extends NnsGovernanceListNeuronVotesResponse {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceListNeuronVotesResponseErr(this.value);

  @override
  CType get candidType => NnsGovernanceListNeuronVotesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `NeuronVote`.
final class NnsGovernanceNeuronVote with CandidSerializable {
  final NnsGovernanceProposalId? proposalId;
  final NnsGovernanceVote? vote;

  const NnsGovernanceNeuronVote({this.proposalId, this.vote});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('proposal_id'),
      () => CType.opt(NnsGovernanceProposalId.ctype),
    ),
    LazyField(Label.named('vote'), () => CType.opt(NnsGovernanceVote.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'proposal_id': proposalId?.candidValue,
    'vote': vote?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'proposal_id': proposalId?.toJson(),
    'vote': vote?.toJson(),
  };

  factory NnsGovernanceNeuronVote.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceNeuronVote(
      proposalId: json.valueTo<NnsGovernanceProposalId?, Map>(
        key: 'proposal_id',
        parse:
            (e) => NnsGovernanceProposalId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      vote: json.valueTo<NnsGovernanceVote?, Map>(
        key: 'vote',
        parse:
            (e) => NnsGovernanceVote.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceNeuronVote.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceNeuronVote.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Vote`.
sealed class NnsGovernanceVote with CandidSerializable {
  const NnsGovernanceVote();

  static CType get ctype => CType.variant([
    Field(Label.named('Unspecified'), CType.null_),
    Field(Label.named('Yes'), CType.null_),
    Field(Label.named('No'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceVote.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Unspecified')) {
      return const NnsGovernanceVoteUnspecified();
    }
    if (json.containsKey('Yes')) {
      return const NnsGovernanceVoteYes();
    }
    if (json.containsKey('No')) {
      return const NnsGovernanceVoteNo();
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceVote.fromCandid',
      reason: 'Unknown NnsGovernanceVote arm',
    );
  }

  factory NnsGovernanceVote.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceVote.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Vote.Unspecified` (nullary).
final class NnsGovernanceVoteUnspecified extends NnsGovernanceVote {
  const NnsGovernanceVoteUnspecified();

  @override
  CType get candidType => NnsGovernanceVote.ctype;

  @override
  dynamic get candidValue => const Variant('Unspecified', null);

  @override
  Map<String, dynamic> toJson() => {'Unspecified': null};
}

/// Variant arm `Vote.Yes` (nullary).
final class NnsGovernanceVoteYes extends NnsGovernanceVote {
  const NnsGovernanceVoteYes();

  @override
  CType get candidType => NnsGovernanceVote.ctype;

  @override
  dynamic get candidValue => const Variant('Yes', null);

  @override
  Map<String, dynamic> toJson() => {'Yes': null};
}

/// Variant arm `Vote.No` (nullary).
final class NnsGovernanceVoteNo extends NnsGovernanceVote {
  const NnsGovernanceVoteNo();

  @override
  CType get candidType => NnsGovernanceVote.ctype;

  @override
  dynamic get candidValue => const Variant('No', null);

  @override
  Map<String, dynamic> toJson() => {'No': null};
}

/// Candid record `SelfDescribingProposalAction`.
final class NnsGovernanceSelfDescribingProposalAction with CandidSerializable {
  final String? typeName;
  final String? typeDescription;
  final NnsGovernanceSelfDescribingValue? value;

  const NnsGovernanceSelfDescribingProposalAction({
    this.typeName,
    this.typeDescription,
    this.value,
  });

  static CType get ctype => CType.record([
    Field(Label.named('type_name'), CType.opt(CType.text)),
    Field(Label.named('type_description'), CType.opt(CType.text)),
    LazyField(
      Label.named('value'),
      () => CType.opt(NnsGovernanceSelfDescribingValue.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'type_name': typeName,
    'type_description': typeDescription,
    'value': value?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'type_name': typeName,
    'type_description': typeDescription,
    'value': value?.toJson(),
  };

  factory NnsGovernanceSelfDescribingProposalAction.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceSelfDescribingProposalAction(
      typeName: json.valueAsString<String?>('type_name'),
      typeDescription: json.valueAsString<String?>('type_description'),
      value: json.valueTo<NnsGovernanceSelfDescribingValue?, Map>(
        key: 'value',
        parse:
            (e) => NnsGovernanceSelfDescribingValue.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceSelfDescribingProposalAction.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSelfDescribingProposalAction.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `SelfDescribingValue`.
sealed class NnsGovernanceSelfDescribingValue with CandidSerializable {
  const NnsGovernanceSelfDescribingValue();

  static CType get ctype => CType.variant([
    Field(Label.named('Blob'), CType.vec(CType.nat8)),
    Field(Label.named('Text'), CType.text),
    Field(Label.named('Bool'), CType.bool_),
    Field(Label.named('Nat'), CType.nat),
    Field(Label.named('Int'), CType.int_),
    LazyField(
      Label.named('Array'),
      () => CType.vec(NnsGovernanceSelfDescribingValue.ctype),
    ),
    LazyField(
      Label.named('Map'),
      () => CType.vec(NnsGovernanceSelfDescribingValueMap.ctype),
    ),
    Field(Label.named('Null'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceSelfDescribingValue.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Blob')) {
      return NnsGovernanceSelfDescribingValueBlob(
        json.valueAsBytes<List<int>>('Blob', encoding: StringEncoding.base64),
      );
    }
    if (json.containsKey('Text')) {
      return NnsGovernanceSelfDescribingValueText(
        json.valueAsString<String>('Text'),
      );
    }
    if (json.containsKey('Bool')) {
      return NnsGovernanceSelfDescribingValueBool(
        json.valueAsBool<bool>('Bool'),
      );
    }
    if (json.containsKey('Nat')) {
      return NnsGovernanceSelfDescribingValueNat(
        json.valueAsBigInt<BigInt>('Nat'),
      );
    }
    if (json.containsKey('Int')) {
      return NnsGovernanceSelfDescribingValueInt(
        json.valueAsBigInt<BigInt>('Int'),
      );
    }
    if (json.containsKey('Array')) {
      return NnsGovernanceSelfDescribingValueArray(
        json.valueTo<List<NnsGovernanceSelfDescribingValue>, List>(
          key: 'Array',
          parse:
              (e) =>
                  e
                      .map<NnsGovernanceSelfDescribingValue>(
                        (x) => NnsGovernanceSelfDescribingValue.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('Map')) {
      return NnsGovernanceSelfDescribingValueMap2(
        json.valueTo<List<NnsGovernanceSelfDescribingValueMap>, List>(
          key: 'Map',
          parse:
              (e) =>
                  e
                      .map<NnsGovernanceSelfDescribingValueMap>(
                        (x) => NnsGovernanceSelfDescribingValueMap.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('Null')) {
      return const NnsGovernanceSelfDescribingValueNull();
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceSelfDescribingValue.fromCandid',
      reason: 'Unknown NnsGovernanceSelfDescribingValue arm',
    );
  }

  factory NnsGovernanceSelfDescribingValue.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceSelfDescribingValue.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `SelfDescribingValue.Blob`.
final class NnsGovernanceSelfDescribingValueBlob
    extends NnsGovernanceSelfDescribingValue {
  final List<int> value;
  const NnsGovernanceSelfDescribingValueBlob(this.value);

  @override
  CType get candidType => NnsGovernanceSelfDescribingValue.ctype;

  @override
  dynamic get candidValue => Variant('Blob', value);

  @override
  Map<String, dynamic> toJson() => {'Blob': value};
}

/// Variant arm `SelfDescribingValue.Text`.
final class NnsGovernanceSelfDescribingValueText
    extends NnsGovernanceSelfDescribingValue {
  final String value;
  const NnsGovernanceSelfDescribingValueText(this.value);

  @override
  CType get candidType => NnsGovernanceSelfDescribingValue.ctype;

  @override
  dynamic get candidValue => Variant('Text', value);

  @override
  Map<String, dynamic> toJson() => {'Text': value};
}

/// Variant arm `SelfDescribingValue.Bool`.
final class NnsGovernanceSelfDescribingValueBool
    extends NnsGovernanceSelfDescribingValue {
  final bool value;
  const NnsGovernanceSelfDescribingValueBool(this.value);

  @override
  CType get candidType => NnsGovernanceSelfDescribingValue.ctype;

  @override
  dynamic get candidValue => Variant('Bool', value);

  @override
  Map<String, dynamic> toJson() => {'Bool': value};
}

/// Variant arm `SelfDescribingValue.Nat`.
final class NnsGovernanceSelfDescribingValueNat
    extends NnsGovernanceSelfDescribingValue {
  final BigInt value;
  const NnsGovernanceSelfDescribingValueNat(this.value);

  @override
  CType get candidType => NnsGovernanceSelfDescribingValue.ctype;

  @override
  dynamic get candidValue => Variant('Nat', value);

  @override
  Map<String, dynamic> toJson() => {'Nat': value};
}

/// Variant arm `SelfDescribingValue.Int`.
final class NnsGovernanceSelfDescribingValueInt
    extends NnsGovernanceSelfDescribingValue {
  final BigInt value;
  const NnsGovernanceSelfDescribingValueInt(this.value);

  @override
  CType get candidType => NnsGovernanceSelfDescribingValue.ctype;

  @override
  dynamic get candidValue => Variant('Int', value);

  @override
  Map<String, dynamic> toJson() => {'Int': value};
}

/// Variant arm `SelfDescribingValue.Array`.
final class NnsGovernanceSelfDescribingValueArray
    extends NnsGovernanceSelfDescribingValue {
  final List<NnsGovernanceSelfDescribingValue> value;
  const NnsGovernanceSelfDescribingValueArray(this.value);

  @override
  CType get candidType => NnsGovernanceSelfDescribingValue.ctype;

  @override
  dynamic get candidValue =>
      Variant('Array', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Array': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `SelfDescribingValue.Map`.
final class NnsGovernanceSelfDescribingValueMap2
    extends NnsGovernanceSelfDescribingValue {
  final List<NnsGovernanceSelfDescribingValueMap> value;
  const NnsGovernanceSelfDescribingValueMap2(this.value);

  @override
  CType get candidType => NnsGovernanceSelfDescribingValue.ctype;

  @override
  dynamic get candidValue =>
      Variant('Map', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Map': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `SelfDescribingValue.Null` (nullary).
final class NnsGovernanceSelfDescribingValueNull
    extends NnsGovernanceSelfDescribingValue {
  const NnsGovernanceSelfDescribingValueNull();

  @override
  CType get candidType => NnsGovernanceSelfDescribingValue.ctype;

  @override
  dynamic get candidValue => const Variant('Null', null);

  @override
  Map<String, dynamic> toJson() => {'Null': null};
}

/// Candid record `GetPendingProposalsRequest`.
final class NnsGovernanceGetPendingProposalsRequest with CandidSerializable {
  final bool? returnSelfDescribingAction;

  const NnsGovernanceGetPendingProposalsRequest({
    this.returnSelfDescribingAction,
  });

  static CType get ctype => CType.record([
    Field(Label.named('return_self_describing_action'), CType.opt(CType.bool_)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'return_self_describing_action': returnSelfDescribingAction,
  };

  Map<String, dynamic> toJson() => {
    'return_self_describing_action': returnSelfDescribingAction,
  };

  factory NnsGovernanceGetPendingProposalsRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceGetPendingProposalsRequest(
      returnSelfDescribingAction: json.valueAsBool<bool?>(
        'return_self_describing_action',
      ),
    );
  }

  factory NnsGovernanceGetPendingProposalsRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceGetPendingProposalsRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CreateNeuronRequest`.
final class NnsGovernanceCreateNeuronRequest with CandidSerializable {
  final BigInt? amountE8s;
  final List<int>? sourceSubaccount;
  final IcpPrincipalAddress? controller;
  final NnsGovernanceSetFollowing? followees;
  final BigInt? dissolveDelaySeconds;
  final bool? dissolving;
  final bool? autoStakeMaturity;

  const NnsGovernanceCreateNeuronRequest({
    this.amountE8s,
    this.sourceSubaccount,
    this.controller,
    this.followees,
    this.dissolveDelaySeconds,
    this.dissolving,
    this.autoStakeMaturity,
  });

  static CType get ctype => CType.record([
    Field(Label.named('amount_e8s'), CType.opt(CType.nat64)),
    Field(Label.named('source_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('controller'), CType.opt(CType.principal)),
    LazyField(
      Label.named('followees'),
      () => CType.opt(NnsGovernanceSetFollowing.ctype),
    ),
    Field(Label.named('dissolve_delay_seconds'), CType.opt(CType.nat64)),
    Field(Label.named('dissolving'), CType.opt(CType.bool_)),
    Field(Label.named('auto_stake_maturity'), CType.opt(CType.bool_)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'amount_e8s': amountE8s,
    'source_subaccount': sourceSubaccount,
    'controller': controller,
    'followees': followees?.candidValue,
    'dissolve_delay_seconds': dissolveDelaySeconds,
    'dissolving': dissolving,
    'auto_stake_maturity': autoStakeMaturity,
  };

  Map<String, dynamic> toJson() => {
    'amount_e8s': amountE8s,
    'source_subaccount': sourceSubaccount,
    'controller': controller?.address,
    'followees': followees?.toJson(),
    'dissolve_delay_seconds': dissolveDelaySeconds,
    'dissolving': dissolving,
    'auto_stake_maturity': autoStakeMaturity,
  };

  factory NnsGovernanceCreateNeuronRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsGovernanceCreateNeuronRequest(
      amountE8s: json.valueAsBigInt<BigInt?>('amount_e8s'),
      sourceSubaccount: json.valueAsBytes<List<int>?>(
        'source_subaccount',
        encoding: StringEncoding.base64,
      ),
      controller: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'controller',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      followees: json.valueTo<NnsGovernanceSetFollowing?, Map>(
        key: 'followees',
        parse:
            (e) => NnsGovernanceSetFollowing.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      dissolveDelaySeconds: json.valueAsBigInt<BigInt?>(
        'dissolve_delay_seconds',
      ),
      dissolving: json.valueAsBool<bool?>('dissolving'),
      autoStakeMaturity: json.valueAsBool<bool?>('auto_stake_maturity'),
    );
  }

  factory NnsGovernanceCreateNeuronRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCreateNeuronRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CreatedNeuron`.
final class NnsGovernanceCreatedNeuron with CandidSerializable {
  final NnsGovernanceNeuronId? neuronId;

  const NnsGovernanceCreatedNeuron({this.neuronId});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('neuron_id'),
      () => CType.opt(NnsGovernanceNeuronId.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'neuron_id': neuronId?.candidValue};

  Map<String, dynamic> toJson() => {'neuron_id': neuronId?.toJson()};

  factory NnsGovernanceCreatedNeuron.fromCandid(Map<String, dynamic> json) {
    return NnsGovernanceCreatedNeuron(
      neuronId: json.valueTo<NnsGovernanceNeuronId?, Map>(
        key: 'neuron_id',
        parse:
            (e) => NnsGovernanceNeuronId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsGovernanceCreatedNeuron.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCreatedNeuron.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `CreateNeuronResponse`.
sealed class NnsGovernanceCreateNeuronResponse with CandidSerializable {
  const NnsGovernanceCreateNeuronResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsGovernanceCreatedNeuron.ctype),
    LazyField(Label.named('Err'), () => NnsGovernanceGovernanceError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsGovernanceCreateNeuronResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsGovernanceCreateNeuronResponseOk(
        json.valueTo<NnsGovernanceCreatedNeuron, Map>(
          key: 'Ok',
          parse:
              (e) => NnsGovernanceCreatedNeuron.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsGovernanceCreateNeuronResponseErr(
        json.valueTo<NnsGovernanceGovernanceError, Map>(
          key: 'Err',
          parse:
              (e) => NnsGovernanceGovernanceError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsGovernanceCreateNeuronResponse.fromCandid',
      reason: 'Unknown NnsGovernanceCreateNeuronResponse arm',
    );
  }

  factory NnsGovernanceCreateNeuronResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsGovernanceCreateNeuronResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CreateNeuronResponse.Ok`.
final class NnsGovernanceCreateNeuronResponseOk
    extends NnsGovernanceCreateNeuronResponse {
  final NnsGovernanceCreatedNeuron value;
  const NnsGovernanceCreateNeuronResponseOk(this.value);

  @override
  CType get candidType => NnsGovernanceCreateNeuronResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `CreateNeuronResponse.Err`.
final class NnsGovernanceCreateNeuronResponseErr
    extends NnsGovernanceCreateNeuronResponse {
  final NnsGovernanceGovernanceError value;
  const NnsGovernanceCreateNeuronResponseErr(this.value);

  @override
  CType get candidType => NnsGovernanceCreateNeuronResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid type alias `Cycles`.
typedef NnsCyclesMintingCycles = BigInt;

/// Candid type alias `BlockIndex`.
typedef NnsCyclesMintingBlockIndex = BigInt;

/// Candid type alias `Subaccount`.
typedef NnsCyclesMintingSubaccount = List<int>?;

/// CType for alias `Subaccount`.
abstract final class NnsCyclesMintingSubaccountCandid {
  static CType get ctype => CType.opt(CType.vec(CType.nat8));
}

/// Candid type alias `Memo`.
typedef NnsCyclesMintingMemo = List<int>?;

/// CType for alias `Memo`.
abstract final class NnsCyclesMintingMemoCandid {
  static CType get ctype => CType.opt(CType.vec(CType.nat8));
}

/// Candid type alias `AccountIdentifier`.
typedef NnsCyclesMintingAccountIdentifier = String;

/// Candid record `NnsCyclesMintingSubnetTypesToSubnetsResponse.data`.
final class NnsCyclesMintingSubnetTypesToSubnetsResponseData
    with CandidSerializable {
  final String field0;
  final List<IcpPrincipalAddress> field1;

  const NnsCyclesMintingSubnetTypesToSubnetsResponseData({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    Field(Label.id(1), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {
    '0': field0,
    '1': field1.map((el) => el.address).toList(),
  };

  factory NnsCyclesMintingSubnetTypesToSubnetsResponseData.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingSubnetTypesToSubnetsResponseData(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: '1',
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

  factory NnsCyclesMintingSubnetTypesToSubnetsResponseData.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingSubnetTypesToSubnetsResponseData.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponse.data`.
final class NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData
    with CandidSerializable {
  final IcpPrincipalAddress field0;
  final List<IcpPrincipalAddress> field1;

  const NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.principal),
    Field(Label.id(1), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {
    '0': field0.address,
    '1': field1.map((el) => el.address).toList(),
  };

  factory NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData(
      field0: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: '0',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      field1: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: '1',
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

  factory NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `log_visibility`.
sealed class NnsCyclesMintingLogVisibility with CandidSerializable {
  const NnsCyclesMintingLogVisibility();

  static CType get ctype => CType.variant([
    Field(Label.named('controllers'), CType.null_),
    Field(Label.named('public'), CType.null_),
    Field(Label.named('allowed_viewers'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingLogVisibility.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('controllers')) {
      return const NnsCyclesMintingLogVisibilityControllers();
    }
    if (json.containsKey('public')) {
      return const NnsCyclesMintingLogVisibilityPublic();
    }
    if (json.containsKey('allowed_viewers')) {
      return NnsCyclesMintingLogVisibilityAllowedViewers(
        json.valueTo<List<IcpPrincipalAddress>, List>(
          key: 'allowed_viewers',
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
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingLogVisibility.fromCandid',
      reason: 'Unknown NnsCyclesMintingLogVisibility arm',
    );
  }

  factory NnsCyclesMintingLogVisibility.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingLogVisibility.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `log_visibility.controllers` (nullary).
final class NnsCyclesMintingLogVisibilityControllers
    extends NnsCyclesMintingLogVisibility {
  const NnsCyclesMintingLogVisibilityControllers();

  @override
  CType get candidType => NnsCyclesMintingLogVisibility.ctype;

  @override
  dynamic get candidValue => const Variant('controllers', null);

  @override
  Map<String, dynamic> toJson() => {'controllers': null};
}

/// Variant arm `log_visibility.public` (nullary).
final class NnsCyclesMintingLogVisibilityPublic
    extends NnsCyclesMintingLogVisibility {
  const NnsCyclesMintingLogVisibilityPublic();

  @override
  CType get candidType => NnsCyclesMintingLogVisibility.ctype;

  @override
  dynamic get candidValue => const Variant('public', null);

  @override
  Map<String, dynamic> toJson() => {'public': null};
}

/// Variant arm `log_visibility.allowed_viewers`.
final class NnsCyclesMintingLogVisibilityAllowedViewers
    extends NnsCyclesMintingLogVisibility {
  final List<IcpPrincipalAddress> value;
  const NnsCyclesMintingLogVisibilityAllowedViewers(this.value);

  @override
  CType get candidType => NnsCyclesMintingLogVisibility.ctype;

  @override
  dynamic get candidValue => Variant('allowed_viewers', value);

  @override
  Map<String, dynamic> toJson() => {
    'allowed_viewers': value.map((el) => el.address).toList(),
  };
}

/// Candid variant `snapshot_visibility`.
sealed class NnsCyclesMintingSnapshotVisibility with CandidSerializable {
  const NnsCyclesMintingSnapshotVisibility();

  static CType get ctype => CType.variant([
    Field(Label.named('controllers'), CType.null_),
    Field(Label.named('public'), CType.null_),
    Field(Label.named('allowed_viewers'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingSnapshotVisibility.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('controllers')) {
      return const NnsCyclesMintingSnapshotVisibilityControllers();
    }
    if (json.containsKey('public')) {
      return const NnsCyclesMintingSnapshotVisibilityPublic();
    }
    if (json.containsKey('allowed_viewers')) {
      return NnsCyclesMintingSnapshotVisibilityAllowedViewers(
        json.valueTo<List<IcpPrincipalAddress>, List>(
          key: 'allowed_viewers',
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
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingSnapshotVisibility.fromCandid',
      reason: 'Unknown NnsCyclesMintingSnapshotVisibility arm',
    );
  }

  factory NnsCyclesMintingSnapshotVisibility.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingSnapshotVisibility.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `snapshot_visibility.controllers` (nullary).
final class NnsCyclesMintingSnapshotVisibilityControllers
    extends NnsCyclesMintingSnapshotVisibility {
  const NnsCyclesMintingSnapshotVisibilityControllers();

  @override
  CType get candidType => NnsCyclesMintingSnapshotVisibility.ctype;

  @override
  dynamic get candidValue => const Variant('controllers', null);

  @override
  Map<String, dynamic> toJson() => {'controllers': null};
}

/// Variant arm `snapshot_visibility.public` (nullary).
final class NnsCyclesMintingSnapshotVisibilityPublic
    extends NnsCyclesMintingSnapshotVisibility {
  const NnsCyclesMintingSnapshotVisibilityPublic();

  @override
  CType get candidType => NnsCyclesMintingSnapshotVisibility.ctype;

  @override
  dynamic get candidValue => const Variant('public', null);

  @override
  Map<String, dynamic> toJson() => {'public': null};
}

/// Variant arm `snapshot_visibility.allowed_viewers`.
final class NnsCyclesMintingSnapshotVisibilityAllowedViewers
    extends NnsCyclesMintingSnapshotVisibility {
  final List<IcpPrincipalAddress> value;
  const NnsCyclesMintingSnapshotVisibilityAllowedViewers(this.value);

  @override
  CType get candidType => NnsCyclesMintingSnapshotVisibility.ctype;

  @override
  dynamic get candidValue => Variant('allowed_viewers', value);

  @override
  Map<String, dynamic> toJson() => {
    'allowed_viewers': value.map((el) => el.address).toList(),
  };
}

/// Candid record `environment_variable`.
final class NnsCyclesMintingEnvironmentVariable with CandidSerializable {
  final String name;
  final String value;

  const NnsCyclesMintingEnvironmentVariable({
    required this.name,
    required this.value,
  });

  static CType get ctype => CType.record([
    Field(Label.named('name'), CType.text),
    Field(Label.named('value'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'name': name, 'value': value};

  Map<String, dynamic> toJson() => {'name': name, 'value': value};

  factory NnsCyclesMintingEnvironmentVariable.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingEnvironmentVariable(
      name: json.valueAsString<String>('name'),
      value: json.valueAsString<String>('value'),
    );
  }

  factory NnsCyclesMintingEnvironmentVariable.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingEnvironmentVariable.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CanisterSettings`.
final class NnsCyclesMintingCanisterSettings with CandidSerializable {
  final List<IcpPrincipalAddress>? controllers;
  final BigInt? computeAllocation;
  final BigInt? memoryAllocation;
  final BigInt? freezingThreshold;
  final BigInt? reservedCyclesLimit;
  final NnsCyclesMintingLogVisibility? logVisibility;
  final NnsCyclesMintingSnapshotVisibility? snapshotVisibility;
  final BigInt? logMemoryLimit;
  final BigInt? wasmMemoryLimit;
  final BigInt? wasmMemoryThreshold;
  final List<NnsCyclesMintingEnvironmentVariable>? environmentVariables;

  const NnsCyclesMintingCanisterSettings({
    this.controllers,
    this.computeAllocation,
    this.memoryAllocation,
    this.freezingThreshold,
    this.reservedCyclesLimit,
    this.logVisibility,
    this.snapshotVisibility,
    this.logMemoryLimit,
    this.wasmMemoryLimit,
    this.wasmMemoryThreshold,
    this.environmentVariables,
  });

  static CType get ctype => CType.record([
    Field(Label.named('controllers'), CType.opt(CType.vec(CType.principal))),
    Field(Label.named('compute_allocation'), CType.opt(CType.nat)),
    Field(Label.named('memory_allocation'), CType.opt(CType.nat)),
    Field(Label.named('freezing_threshold'), CType.opt(CType.nat)),
    Field(Label.named('reserved_cycles_limit'), CType.opt(CType.nat)),
    LazyField(
      Label.named('log_visibility'),
      () => CType.opt(NnsCyclesMintingLogVisibility.ctype),
    ),
    LazyField(
      Label.named('snapshot_visibility'),
      () => CType.opt(NnsCyclesMintingSnapshotVisibility.ctype),
    ),
    Field(Label.named('log_memory_limit'), CType.opt(CType.nat)),
    Field(Label.named('wasm_memory_limit'), CType.opt(CType.nat)),
    Field(Label.named('wasm_memory_threshold'), CType.opt(CType.nat)),
    LazyField(
      Label.named('environment_variables'),
      () => CType.opt(CType.vec(NnsCyclesMintingEnvironmentVariable.ctype)),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'controllers': controllers,
    'compute_allocation': computeAllocation,
    'memory_allocation': memoryAllocation,
    'freezing_threshold': freezingThreshold,
    'reserved_cycles_limit': reservedCyclesLimit,
    'log_visibility': logVisibility?.candidValue,
    'snapshot_visibility': snapshotVisibility?.candidValue,
    'log_memory_limit': logMemoryLimit,
    'wasm_memory_limit': wasmMemoryLimit,
    'wasm_memory_threshold': wasmMemoryThreshold,
    'environment_variables':
        environmentVariables?.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'controllers': controllers?.map((el) => el.address).toList(),
    'compute_allocation': computeAllocation,
    'memory_allocation': memoryAllocation,
    'freezing_threshold': freezingThreshold,
    'reserved_cycles_limit': reservedCyclesLimit,
    'log_visibility': logVisibility?.toJson(),
    'snapshot_visibility': snapshotVisibility?.toJson(),
    'log_memory_limit': logMemoryLimit,
    'wasm_memory_limit': wasmMemoryLimit,
    'wasm_memory_threshold': wasmMemoryThreshold,
    'environment_variables':
        environmentVariables?.map((el) => el.toJson()).toList(),
  };

  factory NnsCyclesMintingCanisterSettings.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingCanisterSettings(
      controllers: json.valueTo<List<IcpPrincipalAddress>?, List>(
        key: 'controllers',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      computeAllocation: json.valueAsBigInt<BigInt?>('compute_allocation'),
      memoryAllocation: json.valueAsBigInt<BigInt?>('memory_allocation'),
      freezingThreshold: json.valueAsBigInt<BigInt?>('freezing_threshold'),
      reservedCyclesLimit: json.valueAsBigInt<BigInt?>('reserved_cycles_limit'),
      logVisibility: json.valueTo<NnsCyclesMintingLogVisibility?, Map>(
        key: 'log_visibility',
        parse:
            (e) => NnsCyclesMintingLogVisibility.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      snapshotVisibility: json
          .valueTo<NnsCyclesMintingSnapshotVisibility?, Map>(
            key: 'snapshot_visibility',
            parse:
                (e) => NnsCyclesMintingSnapshotVisibility.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      logMemoryLimit: json.valueAsBigInt<BigInt?>('log_memory_limit'),
      wasmMemoryLimit: json.valueAsBigInt<BigInt?>('wasm_memory_limit'),
      wasmMemoryThreshold: json.valueAsBigInt<BigInt?>('wasm_memory_threshold'),
      environmentVariables: json
          .valueTo<List<NnsCyclesMintingEnvironmentVariable>?, List>(
            key: 'environment_variables',
            parse:
                (e) =>
                    e
                        .map<NnsCyclesMintingEnvironmentVariable>(
                          (x) => NnsCyclesMintingEnvironmentVariable.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory NnsCyclesMintingCanisterSettings.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingCanisterSettings.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NotifyTopUpArg`.
final class NnsCyclesMintingNotifyTopUpArg with CandidSerializable {
  final NnsCyclesMintingBlockIndex blockIndex;
  final IcpPrincipalAddress canisterId;

  const NnsCyclesMintingNotifyTopUpArg({
    required this.blockIndex,
    required this.canisterId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('block_index'), CType.nat64),
    Field(Label.named('canister_id'), CType.principal),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'block_index': blockIndex,
    'canister_id': canisterId,
  };

  Map<String, dynamic> toJson() => {
    'block_index': blockIndex,
    'canister_id': canisterId.address,
  };

  factory NnsCyclesMintingNotifyTopUpArg.fromCandid(Map<String, dynamic> json) {
    return NnsCyclesMintingNotifyTopUpArg(
      blockIndex: json.valueAsBigInt<BigInt>('block_index'),
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsCyclesMintingNotifyTopUpArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingNotifyTopUpArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `SubnetSelection`.
sealed class NnsCyclesMintingSubnetSelection with CandidSerializable {
  const NnsCyclesMintingSubnetSelection();

  static CType get ctype => CType.variant([
    Field(
      Label.named('Subnet'),
      CType.record([Field(Label.named('subnet'), CType.principal)]),
    ),
    LazyField(Label.named('Filter'), () => NnsCyclesMintingSubnetFilter.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingSubnetSelection.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Subnet')) {
      return NnsCyclesMintingSubnetSelectionSubnet.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Subnet']),
      );
    }
    if (json.containsKey('Filter')) {
      return NnsCyclesMintingSubnetSelectionFilter(
        json.valueTo<NnsCyclesMintingSubnetFilter, Map>(
          key: 'Filter',
          parse:
              (e) => NnsCyclesMintingSubnetFilter.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingSubnetSelection.fromCandid',
      reason: 'Unknown NnsCyclesMintingSubnetSelection arm',
    );
  }

  factory NnsCyclesMintingSubnetSelection.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingSubnetSelection.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `SubnetSelection.Subnet`.
final class NnsCyclesMintingSubnetSelectionSubnet
    extends NnsCyclesMintingSubnetSelection {
  final IcpPrincipalAddress subnet;

  const NnsCyclesMintingSubnetSelectionSubnet({required this.subnet});

  @override
  CType get candidType => NnsCyclesMintingSubnetSelection.ctype;

  @override
  dynamic get candidValue => Variant('Subnet', {'subnet': subnet});

  @override
  Map<String, dynamic> toJson() => {
    'Subnet': {'subnet': subnet.address},
  };

  factory NnsCyclesMintingSubnetSelectionSubnet.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingSubnetSelectionSubnet(
      subnet: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'subnet',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }
}

/// Variant arm `SubnetSelection.Filter`.
final class NnsCyclesMintingSubnetSelectionFilter
    extends NnsCyclesMintingSubnetSelection {
  final NnsCyclesMintingSubnetFilter value;
  const NnsCyclesMintingSubnetSelectionFilter(this.value);

  @override
  CType get candidType => NnsCyclesMintingSubnetSelection.ctype;

  @override
  dynamic get candidValue => Variant('Filter', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Filter': value.toJson()};
}

/// Candid record `SubnetFilter`.
final class NnsCyclesMintingSubnetFilter with CandidSerializable {
  final String? subnetType;

  const NnsCyclesMintingSubnetFilter({this.subnetType});

  static CType get ctype =>
      CType.record([Field(Label.named('subnet_type'), CType.opt(CType.text))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'subnet_type': subnetType};

  Map<String, dynamic> toJson() => {'subnet_type': subnetType};

  factory NnsCyclesMintingSubnetFilter.fromCandid(Map<String, dynamic> json) {
    return NnsCyclesMintingSubnetFilter(
      subnetType: json.valueAsString<String?>('subnet_type'),
    );
  }

  factory NnsCyclesMintingSubnetFilter.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingSubnetFilter.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CreateCanisterArg`.
final class NnsCyclesMintingCreateCanisterArg with CandidSerializable {
  final NnsCyclesMintingCanisterSettings? settings;
  final String? subnetType;
  final NnsCyclesMintingSubnetSelection? subnetSelection;

  const NnsCyclesMintingCreateCanisterArg({
    this.settings,
    this.subnetType,
    this.subnetSelection,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('settings'),
      () => CType.opt(NnsCyclesMintingCanisterSettings.ctype),
    ),
    Field(Label.named('subnet_type'), CType.opt(CType.text)),
    LazyField(
      Label.named('subnet_selection'),
      () => CType.opt(NnsCyclesMintingSubnetSelection.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'settings': settings?.candidValue,
    'subnet_type': subnetType,
    'subnet_selection': subnetSelection?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'settings': settings?.toJson(),
    'subnet_type': subnetType,
    'subnet_selection': subnetSelection?.toJson(),
  };

  factory NnsCyclesMintingCreateCanisterArg.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingCreateCanisterArg(
      settings: json.valueTo<NnsCyclesMintingCanisterSettings?, Map>(
        key: 'settings',
        parse:
            (e) => NnsCyclesMintingCanisterSettings.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      subnetType: json.valueAsString<String?>('subnet_type'),
      subnetSelection: json.valueTo<NnsCyclesMintingSubnetSelection?, Map>(
        key: 'subnet_selection',
        parse:
            (e) => NnsCyclesMintingSubnetSelection.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsCyclesMintingCreateCanisterArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingCreateCanisterArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NotifyCreateCanisterArg`.
final class NnsCyclesMintingNotifyCreateCanisterArg with CandidSerializable {
  final NnsCyclesMintingBlockIndex blockIndex;
  final IcpPrincipalAddress controller;
  final String? subnetType;
  final NnsCyclesMintingSubnetSelection? subnetSelection;
  final NnsCyclesMintingCanisterSettings? settings;

  const NnsCyclesMintingNotifyCreateCanisterArg({
    required this.blockIndex,
    required this.controller,
    this.subnetType,
    this.subnetSelection,
    this.settings,
  });

  static CType get ctype => CType.record([
    Field(Label.named('block_index'), CType.nat64),
    Field(Label.named('controller'), CType.principal),
    Field(Label.named('subnet_type'), CType.opt(CType.text)),
    LazyField(
      Label.named('subnet_selection'),
      () => CType.opt(NnsCyclesMintingSubnetSelection.ctype),
    ),
    LazyField(
      Label.named('settings'),
      () => CType.opt(NnsCyclesMintingCanisterSettings.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'block_index': blockIndex,
    'controller': controller,
    'subnet_type': subnetType,
    'subnet_selection': subnetSelection?.candidValue,
    'settings': settings?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'block_index': blockIndex,
    'controller': controller.address,
    'subnet_type': subnetType,
    'subnet_selection': subnetSelection?.toJson(),
    'settings': settings?.toJson(),
  };

  factory NnsCyclesMintingNotifyCreateCanisterArg.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingNotifyCreateCanisterArg(
      blockIndex: json.valueAsBigInt<BigInt>('block_index'),
      controller: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'controller',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      subnetType: json.valueAsString<String?>('subnet_type'),
      subnetSelection: json.valueTo<NnsCyclesMintingSubnetSelection?, Map>(
        key: 'subnet_selection',
        parse:
            (e) => NnsCyclesMintingSubnetSelection.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      settings: json.valueTo<NnsCyclesMintingCanisterSettings?, Map>(
        key: 'settings',
        parse:
            (e) => NnsCyclesMintingCanisterSettings.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsCyclesMintingNotifyCreateCanisterArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingNotifyCreateCanisterArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `CreateCanisterError`.
sealed class NnsCyclesMintingCreateCanisterError with CandidSerializable {
  const NnsCyclesMintingCreateCanisterError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('Refunded'),
      CType.record([
        Field(Label.named('refund_amount'), CType.nat),
        Field(Label.named('create_error'), CType.text),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingCreateCanisterError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Refunded')) {
      return NnsCyclesMintingCreateCanisterErrorRefunded.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Refunded']),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingCreateCanisterError.fromCandid',
      reason: 'Unknown NnsCyclesMintingCreateCanisterError arm',
    );
  }

  factory NnsCyclesMintingCreateCanisterError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingCreateCanisterError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CreateCanisterError.Refunded`.
final class NnsCyclesMintingCreateCanisterErrorRefunded
    extends NnsCyclesMintingCreateCanisterError {
  final BigInt refundAmount;
  final String createError;

  const NnsCyclesMintingCreateCanisterErrorRefunded({
    required this.refundAmount,
    required this.createError,
  });

  @override
  CType get candidType => NnsCyclesMintingCreateCanisterError.ctype;

  @override
  dynamic get candidValue => Variant('Refunded', {
    'refund_amount': refundAmount,
    'create_error': createError,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Refunded': {'refund_amount': refundAmount, 'create_error': createError},
  };

  factory NnsCyclesMintingCreateCanisterErrorRefunded.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingCreateCanisterErrorRefunded(
      refundAmount: json.valueAsBigInt<BigInt>('refund_amount'),
      createError: json.valueAsString<String>('create_error'),
    );
  }
}

/// Candid variant `NotifyError`.
sealed class NnsCyclesMintingNotifyError with CandidSerializable {
  const NnsCyclesMintingNotifyError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('Refunded'),
      CType.record([
        Field(Label.named('reason'), CType.text),
        Field(Label.named('block_index'), CType.opt(CType.nat64)),
      ]),
    ),
    Field(Label.named('Processing'), CType.null_),
    Field(Label.named('TransactionTooOld'), CType.nat64),
    Field(Label.named('InvalidTransaction'), CType.text),
    Field(
      Label.named('Other'),
      CType.record([
        Field(Label.named('error_code'), CType.nat64),
        Field(Label.named('error_message'), CType.text),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingNotifyError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Refunded')) {
      return NnsCyclesMintingNotifyErrorRefunded.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Refunded']),
      );
    }
    if (json.containsKey('Processing')) {
      return const NnsCyclesMintingNotifyErrorProcessing();
    }
    if (json.containsKey('TransactionTooOld')) {
      return NnsCyclesMintingNotifyErrorTransactionTooOld(
        json.valueAsBigInt<BigInt>('TransactionTooOld'),
      );
    }
    if (json.containsKey('InvalidTransaction')) {
      return NnsCyclesMintingNotifyErrorInvalidTransaction(
        json.valueAsString<String>('InvalidTransaction'),
      );
    }
    if (json.containsKey('Other')) {
      return NnsCyclesMintingNotifyErrorOther.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Other']),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingNotifyError.fromCandid',
      reason: 'Unknown NnsCyclesMintingNotifyError arm',
    );
  }

  factory NnsCyclesMintingNotifyError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingNotifyError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NotifyError.Refunded`.
final class NnsCyclesMintingNotifyErrorRefunded
    extends NnsCyclesMintingNotifyError {
  final String reason;
  final NnsCyclesMintingBlockIndex? blockIndex;

  const NnsCyclesMintingNotifyErrorRefunded({
    required this.reason,
    this.blockIndex,
  });

  @override
  CType get candidType => NnsCyclesMintingNotifyError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Refunded', {'reason': reason, 'block_index': blockIndex});

  @override
  Map<String, dynamic> toJson() => {
    'Refunded': {'reason': reason, 'block_index': blockIndex},
  };

  factory NnsCyclesMintingNotifyErrorRefunded.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingNotifyErrorRefunded(
      reason: json.valueAsString<String>('reason'),
      blockIndex: json.valueAsBigInt<BigInt?>('block_index'),
    );
  }
}

/// Variant arm `NotifyError.Processing` (nullary).
final class NnsCyclesMintingNotifyErrorProcessing
    extends NnsCyclesMintingNotifyError {
  const NnsCyclesMintingNotifyErrorProcessing();

  @override
  CType get candidType => NnsCyclesMintingNotifyError.ctype;

  @override
  dynamic get candidValue => const Variant('Processing', null);

  @override
  Map<String, dynamic> toJson() => {'Processing': null};
}

/// Variant arm `NotifyError.TransactionTooOld`.
final class NnsCyclesMintingNotifyErrorTransactionTooOld
    extends NnsCyclesMintingNotifyError {
  final NnsCyclesMintingBlockIndex value;
  const NnsCyclesMintingNotifyErrorTransactionTooOld(this.value);

  @override
  CType get candidType => NnsCyclesMintingNotifyError.ctype;

  @override
  dynamic get candidValue => Variant('TransactionTooOld', value);

  @override
  Map<String, dynamic> toJson() => {'TransactionTooOld': value};
}

/// Variant arm `NotifyError.InvalidTransaction`.
final class NnsCyclesMintingNotifyErrorInvalidTransaction
    extends NnsCyclesMintingNotifyError {
  final String value;
  const NnsCyclesMintingNotifyErrorInvalidTransaction(this.value);

  @override
  CType get candidType => NnsCyclesMintingNotifyError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidTransaction', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidTransaction': value};
}

/// Variant arm `NotifyError.Other`.
final class NnsCyclesMintingNotifyErrorOther
    extends NnsCyclesMintingNotifyError {
  final BigInt errorCode;
  final String errorMessage;

  const NnsCyclesMintingNotifyErrorOther({
    required this.errorCode,
    required this.errorMessage,
  });

  @override
  CType get candidType => NnsCyclesMintingNotifyError.ctype;

  @override
  dynamic get candidValue => Variant('Other', {
    'error_code': errorCode,
    'error_message': errorMessage,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Other': {'error_code': errorCode, 'error_message': errorMessage},
  };

  factory NnsCyclesMintingNotifyErrorOther.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingNotifyErrorOther(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      errorMessage: json.valueAsString<String>('error_message'),
    );
  }
}

/// Candid variant `NotifyTopUpResult`.
sealed class NnsCyclesMintingNotifyTopUpResult with CandidSerializable {
  const NnsCyclesMintingNotifyTopUpResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => NnsCyclesMintingNotifyError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingNotifyTopUpResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsCyclesMintingNotifyTopUpResultOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return NnsCyclesMintingNotifyTopUpResultErr(
        json.valueTo<NnsCyclesMintingNotifyError, Map>(
          key: 'Err',
          parse:
              (e) => NnsCyclesMintingNotifyError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingNotifyTopUpResult.fromCandid',
      reason: 'Unknown NnsCyclesMintingNotifyTopUpResult arm',
    );
  }

  factory NnsCyclesMintingNotifyTopUpResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingNotifyTopUpResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NotifyTopUpResult.Ok`.
final class NnsCyclesMintingNotifyTopUpResultOk
    extends NnsCyclesMintingNotifyTopUpResult {
  final NnsCyclesMintingCycles value;
  const NnsCyclesMintingNotifyTopUpResultOk(this.value);

  @override
  CType get candidType => NnsCyclesMintingNotifyTopUpResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `NotifyTopUpResult.Err`.
final class NnsCyclesMintingNotifyTopUpResultErr
    extends NnsCyclesMintingNotifyTopUpResult {
  final NnsCyclesMintingNotifyError value;
  const NnsCyclesMintingNotifyTopUpResultErr(this.value);

  @override
  CType get candidType => NnsCyclesMintingNotifyTopUpResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `CreateCanisterResult`.
sealed class NnsCyclesMintingCreateCanisterResult with CandidSerializable {
  const NnsCyclesMintingCreateCanisterResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.principal),
    LazyField(
      Label.named('Err'),
      () => NnsCyclesMintingCreateCanisterError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingCreateCanisterResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsCyclesMintingCreateCanisterResultOk(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Ok',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsCyclesMintingCreateCanisterResultErr(
        json.valueTo<NnsCyclesMintingCreateCanisterError, Map>(
          key: 'Err',
          parse:
              (e) => NnsCyclesMintingCreateCanisterError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingCreateCanisterResult.fromCandid',
      reason: 'Unknown NnsCyclesMintingCreateCanisterResult arm',
    );
  }

  factory NnsCyclesMintingCreateCanisterResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingCreateCanisterResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CreateCanisterResult.Ok`.
final class NnsCyclesMintingCreateCanisterResultOk
    extends NnsCyclesMintingCreateCanisterResult {
  final IcpPrincipalAddress value;
  const NnsCyclesMintingCreateCanisterResultOk(this.value);

  @override
  CType get candidType => NnsCyclesMintingCreateCanisterResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.address};
}

/// Variant arm `CreateCanisterResult.Err`.
final class NnsCyclesMintingCreateCanisterResultErr
    extends NnsCyclesMintingCreateCanisterResult {
  final NnsCyclesMintingCreateCanisterError value;
  const NnsCyclesMintingCreateCanisterResultErr(this.value);

  @override
  CType get candidType => NnsCyclesMintingCreateCanisterResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `NotifyCreateCanisterResult`.
sealed class NnsCyclesMintingNotifyCreateCanisterResult
    with CandidSerializable {
  const NnsCyclesMintingNotifyCreateCanisterResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.principal),
    LazyField(Label.named('Err'), () => NnsCyclesMintingNotifyError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingNotifyCreateCanisterResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsCyclesMintingNotifyCreateCanisterResultOk(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Ok',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsCyclesMintingNotifyCreateCanisterResultErr(
        json.valueTo<NnsCyclesMintingNotifyError, Map>(
          key: 'Err',
          parse:
              (e) => NnsCyclesMintingNotifyError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingNotifyCreateCanisterResult.fromCandid',
      reason: 'Unknown NnsCyclesMintingNotifyCreateCanisterResult arm',
    );
  }

  factory NnsCyclesMintingNotifyCreateCanisterResult.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingNotifyCreateCanisterResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NotifyCreateCanisterResult.Ok`.
final class NnsCyclesMintingNotifyCreateCanisterResultOk
    extends NnsCyclesMintingNotifyCreateCanisterResult {
  final IcpPrincipalAddress value;
  const NnsCyclesMintingNotifyCreateCanisterResultOk(this.value);

  @override
  CType get candidType => NnsCyclesMintingNotifyCreateCanisterResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.address};
}

/// Variant arm `NotifyCreateCanisterResult.Err`.
final class NnsCyclesMintingNotifyCreateCanisterResultErr
    extends NnsCyclesMintingNotifyCreateCanisterResult {
  final NnsCyclesMintingNotifyError value;
  const NnsCyclesMintingNotifyCreateCanisterResultErr(this.value);

  @override
  CType get candidType => NnsCyclesMintingNotifyCreateCanisterResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `IcpXdrConversionRate`.
final class NnsCyclesMintingIcpXdrConversionRate with CandidSerializable {
  final BigInt timestampSeconds;
  final BigInt xdrPermyriadPerIcp;

  const NnsCyclesMintingIcpXdrConversionRate({
    required this.timestampSeconds,
    required this.xdrPermyriadPerIcp,
  });

  static CType get ctype => CType.record([
    Field(Label.named('timestamp_seconds'), CType.nat64),
    Field(Label.named('xdr_permyriad_per_icp'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'timestamp_seconds': timestampSeconds,
    'xdr_permyriad_per_icp': xdrPermyriadPerIcp,
  };

  Map<String, dynamic> toJson() => {
    'timestamp_seconds': timestampSeconds,
    'xdr_permyriad_per_icp': xdrPermyriadPerIcp,
  };

  factory NnsCyclesMintingIcpXdrConversionRate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingIcpXdrConversionRate(
      timestampSeconds: json.valueAsBigInt<BigInt>('timestamp_seconds'),
      xdrPermyriadPerIcp: json.valueAsBigInt<BigInt>('xdr_permyriad_per_icp'),
    );
  }

  factory NnsCyclesMintingIcpXdrConversionRate.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingIcpXdrConversionRate.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `IcpXdrConversionRateResponse`.
final class NnsCyclesMintingIcpXdrConversionRateResponse
    with CandidSerializable {
  final NnsCyclesMintingIcpXdrConversionRate data;
  final List<int> hashTree;
  final List<int> certificate;

  const NnsCyclesMintingIcpXdrConversionRateResponse({
    required this.data,
    required this.hashTree,
    required this.certificate,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('data'),
      () => NnsCyclesMintingIcpXdrConversionRate.ctype,
    ),
    Field(Label.named('hash_tree'), CType.vec(CType.nat8)),
    Field(Label.named('certificate'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'data': data.candidValue,
    'hash_tree': hashTree,
    'certificate': certificate,
  };

  Map<String, dynamic> toJson() => {
    'data': data.toJson(),
    'hash_tree': hashTree,
    'certificate': certificate,
  };

  factory NnsCyclesMintingIcpXdrConversionRateResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingIcpXdrConversionRateResponse(
      data: json.valueTo<NnsCyclesMintingIcpXdrConversionRate, Map>(
        key: 'data',
        parse:
            (e) => NnsCyclesMintingIcpXdrConversionRate.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      hashTree: json.valueAsBytes<List<int>>(
        'hash_tree',
        encoding: StringEncoding.base64,
      ),
      certificate: json.valueAsBytes<List<int>>(
        'certificate',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsCyclesMintingIcpXdrConversionRateResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingIcpXdrConversionRateResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SubnetTypesToSubnetsResponse`.
final class NnsCyclesMintingSubnetTypesToSubnetsResponse
    with CandidSerializable {
  final List<NnsCyclesMintingSubnetTypesToSubnetsResponseData> data;

  const NnsCyclesMintingSubnetTypesToSubnetsResponse({required this.data});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('data'),
      () => CType.vec(NnsCyclesMintingSubnetTypesToSubnetsResponseData.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'data': data.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'data': data.map((el) => el.toJson()).toList(),
  };

  factory NnsCyclesMintingSubnetTypesToSubnetsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingSubnetTypesToSubnetsResponse(
      data: json.valueTo<
        List<NnsCyclesMintingSubnetTypesToSubnetsResponseData>,
        List
      >(
        key: 'data',
        parse:
            (e) =>
                e
                    .map<NnsCyclesMintingSubnetTypesToSubnetsResponseData>(
                      (x) =>
                          NnsCyclesMintingSubnetTypesToSubnetsResponseData.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsCyclesMintingSubnetTypesToSubnetsResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingSubnetTypesToSubnetsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `PrincipalsAuthorizedToCreateCanistersToSubnetsResponse`.
final class NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponse
    with CandidSerializable {
  final List<
    NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData
  >
  data;

  const NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponse({
    required this.data,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('data'),
      () => CType.vec(
        NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData
            .ctype,
      ),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'data': data.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'data': data.map((el) => el.toJson()).toList(),
  };

  factory NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponse(
      data: json.valueTo<
        List<
          NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData
        >,
        List
      >(
        key: 'data',
        parse:
            (e) =>
                e
                    .map<
                      NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData
                    >(
                      (x) =>
                          NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponseData.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponse.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ExchangeRateCanister`.
sealed class NnsCyclesMintingExchangeRateCanister with CandidSerializable {
  const NnsCyclesMintingExchangeRateCanister();

  static CType get ctype => CType.variant([
    Field(Label.named('Set'), CType.principal),
    Field(Label.named('Unset'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingExchangeRateCanister.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Set')) {
      return NnsCyclesMintingExchangeRateCanisterSet(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Set',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('Unset')) {
      return const NnsCyclesMintingExchangeRateCanisterUnset();
    }
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingExchangeRateCanister.fromCandid',
      reason: 'Unknown NnsCyclesMintingExchangeRateCanister arm',
    );
  }

  factory NnsCyclesMintingExchangeRateCanister.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingExchangeRateCanister.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ExchangeRateCanister.Set`.
final class NnsCyclesMintingExchangeRateCanisterSet
    extends NnsCyclesMintingExchangeRateCanister {
  final IcpPrincipalAddress value;
  const NnsCyclesMintingExchangeRateCanisterSet(this.value);

  @override
  CType get candidType => NnsCyclesMintingExchangeRateCanister.ctype;

  @override
  dynamic get candidValue => Variant('Set', value);

  @override
  Map<String, dynamic> toJson() => {'Set': value.address};
}

/// Variant arm `ExchangeRateCanister.Unset` (nullary).
final class NnsCyclesMintingExchangeRateCanisterUnset
    extends NnsCyclesMintingExchangeRateCanister {
  const NnsCyclesMintingExchangeRateCanisterUnset();

  @override
  CType get candidType => NnsCyclesMintingExchangeRateCanister.ctype;

  @override
  dynamic get candidValue => const Variant('Unset', null);

  @override
  Map<String, dynamic> toJson() => {'Unset': null};
}

/// Candid record `CyclesCanisterInitPayload`.
final class NnsCyclesMintingCyclesCanisterInitPayload with CandidSerializable {
  final IcpPrincipalAddress? ledgerCanisterId;
  final IcpPrincipalAddress? governanceCanisterId;
  final NnsCyclesMintingAccountIdentifier? mintingAccountId;
  final BigInt? lastPurgedNotification;
  final NnsCyclesMintingExchangeRateCanister? exchangeRateCanister;
  final IcpPrincipalAddress? cyclesLedgerCanisterId;

  const NnsCyclesMintingCyclesCanisterInitPayload({
    this.ledgerCanisterId,
    this.governanceCanisterId,
    this.mintingAccountId,
    this.lastPurgedNotification,
    this.exchangeRateCanister,
    this.cyclesLedgerCanisterId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('ledger_canister_id'), CType.opt(CType.principal)),
    Field(Label.named('governance_canister_id'), CType.opt(CType.principal)),
    Field(Label.named('minting_account_id'), CType.opt(CType.text)),
    Field(Label.named('last_purged_notification'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('exchange_rate_canister'),
      () => CType.opt(NnsCyclesMintingExchangeRateCanister.ctype),
    ),
    Field(Label.named('cycles_ledger_canister_id'), CType.opt(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'ledger_canister_id': ledgerCanisterId,
    'governance_canister_id': governanceCanisterId,
    'minting_account_id': mintingAccountId,
    'last_purged_notification': lastPurgedNotification,
    'exchange_rate_canister': exchangeRateCanister?.candidValue,
    'cycles_ledger_canister_id': cyclesLedgerCanisterId,
  };

  Map<String, dynamic> toJson() => {
    'ledger_canister_id': ledgerCanisterId?.address,
    'governance_canister_id': governanceCanisterId?.address,
    'minting_account_id': mintingAccountId,
    'last_purged_notification': lastPurgedNotification,
    'exchange_rate_canister': exchangeRateCanister?.toJson(),
    'cycles_ledger_canister_id': cyclesLedgerCanisterId?.address,
  };

  factory NnsCyclesMintingCyclesCanisterInitPayload.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingCyclesCanisterInitPayload(
      ledgerCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'ledger_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      governanceCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'governance_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      mintingAccountId: json.valueAsString<String?>('minting_account_id'),
      lastPurgedNotification: json.valueAsBigInt<BigInt?>(
        'last_purged_notification',
      ),
      exchangeRateCanister: json
          .valueTo<NnsCyclesMintingExchangeRateCanister?, Map>(
            key: 'exchange_rate_canister',
            parse:
                (e) => NnsCyclesMintingExchangeRateCanister.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      cyclesLedgerCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'cycles_ledger_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsCyclesMintingCyclesCanisterInitPayload.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingCyclesCanisterInitPayload.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NotifyMintCyclesArg`.
final class NnsCyclesMintingNotifyMintCyclesArg with CandidSerializable {
  final NnsCyclesMintingBlockIndex blockIndex;
  final NnsCyclesMintingSubaccount toSubaccount;
  final NnsCyclesMintingMemo depositMemo;

  const NnsCyclesMintingNotifyMintCyclesArg({
    required this.blockIndex,
    required this.toSubaccount,
    required this.depositMemo,
  });

  static CType get ctype => CType.record([
    Field(Label.named('block_index'), CType.nat64),
    LazyField(
      Label.named('to_subaccount'),
      () => NnsCyclesMintingSubaccountCandid.ctype,
    ),
    LazyField(
      Label.named('deposit_memo'),
      () => NnsCyclesMintingMemoCandid.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'block_index': blockIndex,
    'to_subaccount': toSubaccount,
    'deposit_memo': depositMemo,
  };

  Map<String, dynamic> toJson() => {
    'block_index': blockIndex,
    'to_subaccount': toSubaccount,
    'deposit_memo': depositMemo,
  };

  factory NnsCyclesMintingNotifyMintCyclesArg.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingNotifyMintCyclesArg(
      blockIndex: json.valueAsBigInt<BigInt>('block_index'),
      toSubaccount: json.valueAsBytes<List<int>?>(
        'to_subaccount',
        encoding: StringEncoding.base64,
      ),
      depositMemo: json.valueAsBytes<List<int>?>(
        'deposit_memo',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsCyclesMintingNotifyMintCyclesArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingNotifyMintCyclesArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `NotifyMintCyclesResult`.
sealed class NnsCyclesMintingNotifyMintCyclesResult with CandidSerializable {
  const NnsCyclesMintingNotifyMintCyclesResult();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Ok'),
      () => NnsCyclesMintingNotifyMintCyclesSuccess.ctype,
    ),
    LazyField(Label.named('Err'), () => NnsCyclesMintingNotifyError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingNotifyMintCyclesResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return NnsCyclesMintingNotifyMintCyclesResultOk(
        json.valueTo<NnsCyclesMintingNotifyMintCyclesSuccess, Map>(
          key: 'Ok',
          parse:
              (e) => NnsCyclesMintingNotifyMintCyclesSuccess.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return NnsCyclesMintingNotifyMintCyclesResultErr(
        json.valueTo<NnsCyclesMintingNotifyError, Map>(
          key: 'Err',
          parse:
              (e) => NnsCyclesMintingNotifyError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingNotifyMintCyclesResult.fromCandid',
      reason: 'Unknown NnsCyclesMintingNotifyMintCyclesResult arm',
    );
  }

  factory NnsCyclesMintingNotifyMintCyclesResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingNotifyMintCyclesResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `NotifyMintCyclesResult.Ok`.
final class NnsCyclesMintingNotifyMintCyclesResultOk
    extends NnsCyclesMintingNotifyMintCyclesResult {
  final NnsCyclesMintingNotifyMintCyclesSuccess value;
  const NnsCyclesMintingNotifyMintCyclesResultOk(this.value);

  @override
  CType get candidType => NnsCyclesMintingNotifyMintCyclesResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `NotifyMintCyclesResult.Err`.
final class NnsCyclesMintingNotifyMintCyclesResultErr
    extends NnsCyclesMintingNotifyMintCyclesResult {
  final NnsCyclesMintingNotifyError value;
  const NnsCyclesMintingNotifyMintCyclesResultErr(this.value);

  @override
  CType get candidType => NnsCyclesMintingNotifyMintCyclesResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `NotifyMintCyclesSuccess`.
final class NnsCyclesMintingNotifyMintCyclesSuccess with CandidSerializable {
  final BigInt blockIndex;
  final BigInt minted;
  final BigInt balance;

  const NnsCyclesMintingNotifyMintCyclesSuccess({
    required this.blockIndex,
    required this.minted,
    required this.balance,
  });

  static CType get ctype => CType.record([
    Field(Label.named('block_index'), CType.nat),
    Field(Label.named('minted'), CType.nat),
    Field(Label.named('balance'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'block_index': blockIndex,
    'minted': minted,
    'balance': balance,
  };

  Map<String, dynamic> toJson() => {
    'block_index': blockIndex,
    'minted': minted,
    'balance': balance,
  };

  factory NnsCyclesMintingNotifyMintCyclesSuccess.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingNotifyMintCyclesSuccess(
      blockIndex: json.valueAsBigInt<BigInt>('block_index'),
      minted: json.valueAsBigInt<BigInt>('minted'),
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }

  factory NnsCyclesMintingNotifyMintCyclesSuccess.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingNotifyMintCyclesSuccess.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SetAuthorizedSubnetworkListArgs`.
final class NnsCyclesMintingSetAuthorizedSubnetworkListArgs
    with CandidSerializable {
  final IcpPrincipalAddress? who;
  final List<IcpPrincipalAddress> subnets;

  const NnsCyclesMintingSetAuthorizedSubnetworkListArgs({
    this.who,
    required this.subnets,
  });

  static CType get ctype => CType.record([
    Field(Label.named('who'), CType.opt(CType.principal)),
    Field(Label.named('subnets'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'who': who, 'subnets': subnets};

  Map<String, dynamic> toJson() => {
    'who': who?.address,
    'subnets': subnets.map((el) => el.address).toList(),
  };

  factory NnsCyclesMintingSetAuthorizedSubnetworkListArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingSetAuthorizedSubnetworkListArgs(
      who: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'who',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      subnets: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'subnets',
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

  factory NnsCyclesMintingSetAuthorizedSubnetworkListArgs.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingSetAuthorizedSubnetworkListArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `UpdateSubnetTypeArgs`.
sealed class NnsCyclesMintingUpdateSubnetTypeArgs with CandidSerializable {
  const NnsCyclesMintingUpdateSubnetTypeArgs();

  static CType get ctype => CType.variant([
    Field(Label.named('Add'), CType.text),
    Field(Label.named('Remove'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingUpdateSubnetTypeArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Add')) {
      return NnsCyclesMintingUpdateSubnetTypeArgsAdd(
        json.valueAsString<String>('Add'),
      );
    }
    if (json.containsKey('Remove')) {
      return NnsCyclesMintingUpdateSubnetTypeArgsRemove(
        json.valueAsString<String>('Remove'),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingUpdateSubnetTypeArgs.fromCandid',
      reason: 'Unknown NnsCyclesMintingUpdateSubnetTypeArgs arm',
    );
  }

  factory NnsCyclesMintingUpdateSubnetTypeArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingUpdateSubnetTypeArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `UpdateSubnetTypeArgs.Add`.
final class NnsCyclesMintingUpdateSubnetTypeArgsAdd
    extends NnsCyclesMintingUpdateSubnetTypeArgs {
  final String value;
  const NnsCyclesMintingUpdateSubnetTypeArgsAdd(this.value);

  @override
  CType get candidType => NnsCyclesMintingUpdateSubnetTypeArgs.ctype;

  @override
  dynamic get candidValue => Variant('Add', value);

  @override
  Map<String, dynamic> toJson() => {'Add': value};
}

/// Variant arm `UpdateSubnetTypeArgs.Remove`.
final class NnsCyclesMintingUpdateSubnetTypeArgsRemove
    extends NnsCyclesMintingUpdateSubnetTypeArgs {
  final String value;
  const NnsCyclesMintingUpdateSubnetTypeArgsRemove(this.value);

  @override
  CType get candidType => NnsCyclesMintingUpdateSubnetTypeArgs.ctype;

  @override
  dynamic get candidValue => Variant('Remove', value);

  @override
  Map<String, dynamic> toJson() => {'Remove': value};
}

/// Candid record `SubnetListWithType`.
final class NnsCyclesMintingSubnetListWithType with CandidSerializable {
  final List<IcpPrincipalAddress> subnets;
  final String subnetType;

  const NnsCyclesMintingSubnetListWithType({
    required this.subnets,
    required this.subnetType,
  });

  static CType get ctype => CType.record([
    Field(Label.named('subnets'), CType.vec(CType.principal)),
    Field(Label.named('subnet_type'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'subnets': subnets, 'subnet_type': subnetType};

  Map<String, dynamic> toJson() => {
    'subnets': subnets.map((el) => el.address).toList(),
    'subnet_type': subnetType,
  };

  factory NnsCyclesMintingSubnetListWithType.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsCyclesMintingSubnetListWithType(
      subnets: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'subnets',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      subnetType: json.valueAsString<String>('subnet_type'),
    );
  }

  factory NnsCyclesMintingSubnetListWithType.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingSubnetListWithType.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ChangeSubnetTypeAssignmentArgs`.
sealed class NnsCyclesMintingChangeSubnetTypeAssignmentArgs
    with CandidSerializable {
  const NnsCyclesMintingChangeSubnetTypeAssignmentArgs();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Add'),
      () => NnsCyclesMintingSubnetListWithType.ctype,
    ),
    LazyField(
      Label.named('Remove'),
      () => NnsCyclesMintingSubnetListWithType.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsCyclesMintingChangeSubnetTypeAssignmentArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Add')) {
      return NnsCyclesMintingChangeSubnetTypeAssignmentArgsAdd(
        json.valueTo<NnsCyclesMintingSubnetListWithType, Map>(
          key: 'Add',
          parse:
              (e) => NnsCyclesMintingSubnetListWithType.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Remove')) {
      return NnsCyclesMintingChangeSubnetTypeAssignmentArgsRemove(
        json.valueTo<NnsCyclesMintingSubnetListWithType, Map>(
          key: 'Remove',
          parse:
              (e) => NnsCyclesMintingSubnetListWithType.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsCyclesMintingChangeSubnetTypeAssignmentArgs.fromCandid',
      reason: 'Unknown NnsCyclesMintingChangeSubnetTypeAssignmentArgs arm',
    );
  }

  factory NnsCyclesMintingChangeSubnetTypeAssignmentArgs.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsCyclesMintingChangeSubnetTypeAssignmentArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ChangeSubnetTypeAssignmentArgs.Add`.
final class NnsCyclesMintingChangeSubnetTypeAssignmentArgsAdd
    extends NnsCyclesMintingChangeSubnetTypeAssignmentArgs {
  final NnsCyclesMintingSubnetListWithType value;
  const NnsCyclesMintingChangeSubnetTypeAssignmentArgsAdd(this.value);

  @override
  CType get candidType => NnsCyclesMintingChangeSubnetTypeAssignmentArgs.ctype;

  @override
  dynamic get candidValue => Variant('Add', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Add': value.toJson()};
}

/// Variant arm `ChangeSubnetTypeAssignmentArgs.Remove`.
final class NnsCyclesMintingChangeSubnetTypeAssignmentArgsRemove
    extends NnsCyclesMintingChangeSubnetTypeAssignmentArgs {
  final NnsCyclesMintingSubnetListWithType value;
  const NnsCyclesMintingChangeSubnetTypeAssignmentArgsRemove(this.value);

  @override
  CType get candidType => NnsCyclesMintingChangeSubnetTypeAssignmentArgs.ctype;

  @override
  dynamic get candidValue => Variant('Remove', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Remove': value.toJson()};
}

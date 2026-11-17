// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid record `NnsWasmGetAllowedPrincipals.arg`.
final class NnsWasmGetAllowedPrincipalsArg with CandidSerializable {
  const NnsWasmGetAllowedPrincipalsArg();

  static CType get ctype => CType.record(const []);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => <String, dynamic>{};

  Map<String, dynamic> toJson() => <String, dynamic>{};

  factory NnsWasmGetAllowedPrincipalsArg.fromCandid(Map<String, dynamic> json) {
    return const NnsWasmGetAllowedPrincipalsArg();
  }

  factory NnsWasmGetAllowedPrincipalsArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetAllowedPrincipalsArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NnsWasmGetLatestSnsVersionPretty.response`.
final class NnsWasmGetLatestSnsVersionPrettyResponse with CandidSerializable {
  final String field0;
  final String field1;

  const NnsWasmGetLatestSnsVersionPrettyResponse({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    Field(Label.id(1), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1};

  factory NnsWasmGetLatestSnsVersionPrettyResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmGetLatestSnsVersionPrettyResponse(
      field0: json.valueAsString<String>('0'),
      field1: json.valueAsString<String>('1'),
    );
  }

  factory NnsWasmGetLatestSnsVersionPrettyResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetLatestSnsVersionPrettyResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AddWasmRequest`.
final class NnsWasmAddWasmRequest with CandidSerializable {
  final List<int> hash;
  final NnsWasmSnsWasm? wasm;
  final bool? skipUpdateLatestVersion;

  const NnsWasmAddWasmRequest({
    required this.hash,
    this.wasm,
    this.skipUpdateLatestVersion,
  });

  static CType get ctype => CType.record([
    Field(Label.named('hash'), CType.vec(CType.nat8)),
    LazyField(Label.named('wasm'), () => CType.opt(NnsWasmSnsWasm.ctype)),
    Field(Label.named('skip_update_latest_version'), CType.opt(CType.bool_)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'hash': hash,
    'wasm': wasm?.candidValue,
    'skip_update_latest_version': skipUpdateLatestVersion,
  };

  Map<String, dynamic> toJson() => {
    'hash': hash,
    'wasm': wasm?.toJson(),
    'skip_update_latest_version': skipUpdateLatestVersion,
  };

  factory NnsWasmAddWasmRequest.fromCandid(Map<String, dynamic> json) {
    return NnsWasmAddWasmRequest(
      hash: json.valueAsBytes<List<int>>(
        'hash',
        encoding: StringEncoding.base64,
      ),
      wasm: json.valueTo<NnsWasmSnsWasm?, Map>(
        key: 'wasm',
        parse:
            (e) => NnsWasmSnsWasm.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      skipUpdateLatestVersion: json.valueAsBool<bool?>(
        'skip_update_latest_version',
      ),
    );
  }

  factory NnsWasmAddWasmRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmAddWasmRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AddWasmResponse`.
final class NnsWasmAddWasmResponse with CandidSerializable {
  final NnsWasmResult? result;

  const NnsWasmAddWasmResponse({this.result});

  static CType get ctype => CType.record([
    LazyField(Label.named('result'), () => CType.opt(NnsWasmResult.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'result': result?.candidValue};

  Map<String, dynamic> toJson() => {'result': result?.toJson()};

  factory NnsWasmAddWasmResponse.fromCandid(Map<String, dynamic> json) {
    return NnsWasmAddWasmResponse(
      result: json.valueTo<NnsWasmResult?, Map>(
        key: 'result',
        parse:
            (e) => NnsWasmResult.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmAddWasmResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmAddWasmResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Canister`.
final class NnsWasmCanister with CandidSerializable {
  final IcpPrincipalAddress? id;

  const NnsWasmCanister({this.id});

  static CType get ctype =>
      CType.record([Field(Label.named('id'), CType.opt(CType.principal))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'id': id};

  Map<String, dynamic> toJson() => {'id': id?.address};

  factory NnsWasmCanister.fromCandid(Map<String, dynamic> json) {
    return NnsWasmCanister(
      id: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsWasmCanister.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmCanister.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Countries`.
final class NnsWasmCountries with CandidSerializable {
  final List<String> isoCodes;

  const NnsWasmCountries({required this.isoCodes});

  static CType get ctype =>
      CType.record([Field(Label.named('iso_codes'), CType.vec(CType.text))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'iso_codes': isoCodes};

  Map<String, dynamic> toJson() => {'iso_codes': isoCodes};

  factory NnsWasmCountries.fromCandid(Map<String, dynamic> json) {
    return NnsWasmCountries(
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

  factory NnsWasmCountries.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmCountries.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DappCanisters`.
final class NnsWasmDappCanisters with CandidSerializable {
  final List<NnsWasmCanister> canisters;

  const NnsWasmDappCanisters({required this.canisters});

  static CType get ctype => CType.record([
    LazyField(Label.named('canisters'), () => CType.vec(NnsWasmCanister.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canisters': canisters.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'canisters': canisters.map((el) => el.toJson()).toList(),
  };

  factory NnsWasmDappCanisters.fromCandid(Map<String, dynamic> json) {
    return NnsWasmDappCanisters(
      canisters: json.valueTo<List<NnsWasmCanister>, List>(
        key: 'canisters',
        parse:
            (e) =>
                e
                    .map<NnsWasmCanister>(
                      (x) => NnsWasmCanister.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsWasmDappCanisters.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmDappCanisters.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DappCanistersTransferResult`.
final class NnsWasmDappCanistersTransferResult with CandidSerializable {
  final List<NnsWasmCanister> restoredDappCanisters;
  final List<NnsWasmCanister> nnsControlledDappCanisters;
  final List<NnsWasmCanister> snsControlledDappCanisters;

  const NnsWasmDappCanistersTransferResult({
    required this.restoredDappCanisters,
    required this.nnsControlledDappCanisters,
    required this.snsControlledDappCanisters,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('restored_dapp_canisters'),
      () => CType.vec(NnsWasmCanister.ctype),
    ),
    LazyField(
      Label.named('nns_controlled_dapp_canisters'),
      () => CType.vec(NnsWasmCanister.ctype),
    ),
    LazyField(
      Label.named('sns_controlled_dapp_canisters'),
      () => CType.vec(NnsWasmCanister.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'restored_dapp_canisters':
        restoredDappCanisters.map((el) => el.candidValue).toList(),
    'nns_controlled_dapp_canisters':
        nnsControlledDappCanisters.map((el) => el.candidValue).toList(),
    'sns_controlled_dapp_canisters':
        snsControlledDappCanisters.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'restored_dapp_canisters':
        restoredDappCanisters.map((el) => el.toJson()).toList(),
    'nns_controlled_dapp_canisters':
        nnsControlledDappCanisters.map((el) => el.toJson()).toList(),
    'sns_controlled_dapp_canisters':
        snsControlledDappCanisters.map((el) => el.toJson()).toList(),
  };

  factory NnsWasmDappCanistersTransferResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmDappCanistersTransferResult(
      restoredDappCanisters: json.valueTo<List<NnsWasmCanister>, List>(
        key: 'restored_dapp_canisters',
        parse:
            (e) =>
                e
                    .map<NnsWasmCanister>(
                      (x) => NnsWasmCanister.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      nnsControlledDappCanisters: json.valueTo<List<NnsWasmCanister>, List>(
        key: 'nns_controlled_dapp_canisters',
        parse:
            (e) =>
                e
                    .map<NnsWasmCanister>(
                      (x) => NnsWasmCanister.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      snsControlledDappCanisters: json.valueTo<List<NnsWasmCanister>, List>(
        key: 'sns_controlled_dapp_canisters',
        parse:
            (e) =>
                e
                    .map<NnsWasmCanister>(
                      (x) => NnsWasmCanister.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsWasmDappCanistersTransferResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmDappCanistersTransferResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DeployNewSnsRequest`.
final class NnsWasmDeployNewSnsRequest with CandidSerializable {
  final NnsWasmSnsInitPayload? snsInitPayload;

  const NnsWasmDeployNewSnsRequest({this.snsInitPayload});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('sns_init_payload'),
      () => CType.opt(NnsWasmSnsInitPayload.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'sns_init_payload': snsInitPayload?.candidValue};

  Map<String, dynamic> toJson() => {
    'sns_init_payload': snsInitPayload?.toJson(),
  };

  factory NnsWasmDeployNewSnsRequest.fromCandid(Map<String, dynamic> json) {
    return NnsWasmDeployNewSnsRequest(
      snsInitPayload: json.valueTo<NnsWasmSnsInitPayload?, Map>(
        key: 'sns_init_payload',
        parse:
            (e) => NnsWasmSnsInitPayload.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmDeployNewSnsRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmDeployNewSnsRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DeployNewSnsResponse`.
final class NnsWasmDeployNewSnsResponse with CandidSerializable {
  final NnsWasmDappCanistersTransferResult? dappCanistersTransferResult;
  final IcpPrincipalAddress? subnetId;
  final NnsWasmSnsWasmError? error;
  final NnsWasmSnsCanisterIds? canisters;

  const NnsWasmDeployNewSnsResponse({
    this.dappCanistersTransferResult,
    this.subnetId,
    this.error,
    this.canisters,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('dapp_canisters_transfer_result'),
      () => CType.opt(NnsWasmDappCanistersTransferResult.ctype),
    ),
    Field(Label.named('subnet_id'), CType.opt(CType.principal)),
    LazyField(Label.named('error'), () => CType.opt(NnsWasmSnsWasmError.ctype)),
    LazyField(
      Label.named('canisters'),
      () => CType.opt(NnsWasmSnsCanisterIds.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'dapp_canisters_transfer_result': dappCanistersTransferResult?.candidValue,
    'subnet_id': subnetId,
    'error': error?.candidValue,
    'canisters': canisters?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'dapp_canisters_transfer_result': dappCanistersTransferResult?.toJson(),
    'subnet_id': subnetId?.address,
    'error': error?.toJson(),
    'canisters': canisters?.toJson(),
  };

  factory NnsWasmDeployNewSnsResponse.fromCandid(Map<String, dynamic> json) {
    return NnsWasmDeployNewSnsResponse(
      dappCanistersTransferResult: json
          .valueTo<NnsWasmDappCanistersTransferResult?, Map>(
            key: 'dapp_canisters_transfer_result',
            parse:
                (e) => NnsWasmDappCanistersTransferResult.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      subnetId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'subnet_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      error: json.valueTo<NnsWasmSnsWasmError?, Map>(
        key: 'error',
        parse:
            (e) => NnsWasmSnsWasmError.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      canisters: json.valueTo<NnsWasmSnsCanisterIds?, Map>(
        key: 'canisters',
        parse:
            (e) => NnsWasmSnsCanisterIds.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmDeployNewSnsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmDeployNewSnsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DeployedSns`.
final class NnsWasmDeployedSns with CandidSerializable {
  final IcpPrincipalAddress? rootCanisterId;
  final IcpPrincipalAddress? governanceCanisterId;
  final IcpPrincipalAddress? indexCanisterId;
  final IcpPrincipalAddress? swapCanisterId;
  final IcpPrincipalAddress? ledgerCanisterId;

  const NnsWasmDeployedSns({
    this.rootCanisterId,
    this.governanceCanisterId,
    this.indexCanisterId,
    this.swapCanisterId,
    this.ledgerCanisterId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('root_canister_id'), CType.opt(CType.principal)),
    Field(Label.named('governance_canister_id'), CType.opt(CType.principal)),
    Field(Label.named('index_canister_id'), CType.opt(CType.principal)),
    Field(Label.named('swap_canister_id'), CType.opt(CType.principal)),
    Field(Label.named('ledger_canister_id'), CType.opt(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'root_canister_id': rootCanisterId,
    'governance_canister_id': governanceCanisterId,
    'index_canister_id': indexCanisterId,
    'swap_canister_id': swapCanisterId,
    'ledger_canister_id': ledgerCanisterId,
  };

  Map<String, dynamic> toJson() => {
    'root_canister_id': rootCanisterId?.address,
    'governance_canister_id': governanceCanisterId?.address,
    'index_canister_id': indexCanisterId?.address,
    'swap_canister_id': swapCanisterId?.address,
    'ledger_canister_id': ledgerCanisterId?.address,
  };

  factory NnsWasmDeployedSns.fromCandid(Map<String, dynamic> json) {
    return NnsWasmDeployedSns(
      rootCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'root_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      governanceCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'governance_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      indexCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'index_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      swapCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'swap_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      ledgerCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'ledger_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsWasmDeployedSns.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmDeployedSns.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DeveloperDistribution`.
final class NnsWasmDeveloperDistribution with CandidSerializable {
  final List<NnsWasmNeuronDistribution> developerNeurons;

  const NnsWasmDeveloperDistribution({required this.developerNeurons});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('developer_neurons'),
      () => CType.vec(NnsWasmNeuronDistribution.ctype),
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

  factory NnsWasmDeveloperDistribution.fromCandid(Map<String, dynamic> json) {
    return NnsWasmDeveloperDistribution(
      developerNeurons: json.valueTo<List<NnsWasmNeuronDistribution>, List>(
        key: 'developer_neurons',
        parse:
            (e) =>
                e
                    .map<NnsWasmNeuronDistribution>(
                      (x) => NnsWasmNeuronDistribution.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsWasmDeveloperDistribution.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmDeveloperDistribution.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `FractionalDeveloperVotingPower`.
final class NnsWasmFractionalDeveloperVotingPower with CandidSerializable {
  final NnsWasmTreasuryDistribution? treasuryDistribution;
  final NnsWasmDeveloperDistribution? developerDistribution;
  final NnsWasmSwapDistribution? swapDistribution;

  const NnsWasmFractionalDeveloperVotingPower({
    this.treasuryDistribution,
    this.developerDistribution,
    this.swapDistribution,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('treasury_distribution'),
      () => CType.opt(NnsWasmTreasuryDistribution.ctype),
    ),
    LazyField(
      Label.named('developer_distribution'),
      () => CType.opt(NnsWasmDeveloperDistribution.ctype),
    ),
    LazyField(
      Label.named('swap_distribution'),
      () => CType.opt(NnsWasmSwapDistribution.ctype),
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

  factory NnsWasmFractionalDeveloperVotingPower.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmFractionalDeveloperVotingPower(
      treasuryDistribution: json.valueTo<NnsWasmTreasuryDistribution?, Map>(
        key: 'treasury_distribution',
        parse:
            (e) => NnsWasmTreasuryDistribution.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      developerDistribution: json.valueTo<NnsWasmDeveloperDistribution?, Map>(
        key: 'developer_distribution',
        parse:
            (e) => NnsWasmDeveloperDistribution.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      swapDistribution: json.valueTo<NnsWasmSwapDistribution?, Map>(
        key: 'swap_distribution',
        parse:
            (e) => NnsWasmSwapDistribution.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmFractionalDeveloperVotingPower.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmFractionalDeveloperVotingPower.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetAllowedPrincipalsResponse`.
final class NnsWasmGetAllowedPrincipalsResponse with CandidSerializable {
  final List<IcpPrincipalAddress> allowedPrincipals;

  const NnsWasmGetAllowedPrincipalsResponse({required this.allowedPrincipals});

  static CType get ctype => CType.record([
    Field(Label.named('allowed_principals'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'allowed_principals': allowedPrincipals};

  Map<String, dynamic> toJson() => {
    'allowed_principals': allowedPrincipals.map((el) => el.address).toList(),
  };

  factory NnsWasmGetAllowedPrincipalsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmGetAllowedPrincipalsResponse(
      allowedPrincipals: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'allowed_principals',
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

  factory NnsWasmGetAllowedPrincipalsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetAllowedPrincipalsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetDeployedSnsByProposalIdRequest`.
final class NnsWasmGetDeployedSnsByProposalIdRequest with CandidSerializable {
  final BigInt proposalId;

  const NnsWasmGetDeployedSnsByProposalIdRequest({required this.proposalId});

  static CType get ctype =>
      CType.record([Field(Label.named('proposal_id'), CType.nat64)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'proposal_id': proposalId};

  Map<String, dynamic> toJson() => {'proposal_id': proposalId};

  factory NnsWasmGetDeployedSnsByProposalIdRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmGetDeployedSnsByProposalIdRequest(
      proposalId: json.valueAsBigInt<BigInt>('proposal_id'),
    );
  }

  factory NnsWasmGetDeployedSnsByProposalIdRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetDeployedSnsByProposalIdRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetDeployedSnsByProposalIdResponse`.
final class NnsWasmGetDeployedSnsByProposalIdResponse with CandidSerializable {
  final NnsWasmGetDeployedSnsByProposalIdResult?
  getDeployedSnsByProposalIdResult;

  const NnsWasmGetDeployedSnsByProposalIdResponse({
    this.getDeployedSnsByProposalIdResult,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('get_deployed_sns_by_proposal_id_result'),
      () => CType.opt(NnsWasmGetDeployedSnsByProposalIdResult.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'get_deployed_sns_by_proposal_id_result':
        getDeployedSnsByProposalIdResult?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'get_deployed_sns_by_proposal_id_result':
        getDeployedSnsByProposalIdResult?.toJson(),
  };

  factory NnsWasmGetDeployedSnsByProposalIdResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmGetDeployedSnsByProposalIdResponse(
      getDeployedSnsByProposalIdResult: json
          .valueTo<NnsWasmGetDeployedSnsByProposalIdResult?, Map>(
            key: 'get_deployed_sns_by_proposal_id_result',
            parse:
                (e) => NnsWasmGetDeployedSnsByProposalIdResult.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsWasmGetDeployedSnsByProposalIdResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetDeployedSnsByProposalIdResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `GetDeployedSnsByProposalIdResult`.
sealed class NnsWasmGetDeployedSnsByProposalIdResult with CandidSerializable {
  const NnsWasmGetDeployedSnsByProposalIdResult();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Error'), () => NnsWasmSnsWasmError.ctype),
    LazyField(Label.named('DeployedSns'), () => NnsWasmDeployedSns.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsWasmGetDeployedSnsByProposalIdResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Error')) {
      return NnsWasmGetDeployedSnsByProposalIdResultError(
        json.valueTo<NnsWasmSnsWasmError, Map>(
          key: 'Error',
          parse:
              (e) => NnsWasmSnsWasmError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('DeployedSns')) {
      return NnsWasmGetDeployedSnsByProposalIdResultDeployedSns(
        json.valueTo<NnsWasmDeployedSns, Map>(
          key: 'DeployedSns',
          parse:
              (e) => NnsWasmDeployedSns.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsWasmGetDeployedSnsByProposalIdResult.fromCandid',
      reason: 'Unknown NnsWasmGetDeployedSnsByProposalIdResult arm',
    );
  }

  factory NnsWasmGetDeployedSnsByProposalIdResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetDeployedSnsByProposalIdResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetDeployedSnsByProposalIdResult.Error`.
final class NnsWasmGetDeployedSnsByProposalIdResultError
    extends NnsWasmGetDeployedSnsByProposalIdResult {
  final NnsWasmSnsWasmError value;
  const NnsWasmGetDeployedSnsByProposalIdResultError(this.value);

  @override
  CType get candidType => NnsWasmGetDeployedSnsByProposalIdResult.ctype;

  @override
  dynamic get candidValue => Variant('Error', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Error': value.toJson()};
}

/// Variant arm `GetDeployedSnsByProposalIdResult.DeployedSns`.
final class NnsWasmGetDeployedSnsByProposalIdResultDeployedSns
    extends NnsWasmGetDeployedSnsByProposalIdResult {
  final NnsWasmDeployedSns value;
  const NnsWasmGetDeployedSnsByProposalIdResultDeployedSns(this.value);

  @override
  CType get candidType => NnsWasmGetDeployedSnsByProposalIdResult.ctype;

  @override
  dynamic get candidValue => Variant('DeployedSns', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'DeployedSns': value.toJson()};
}

/// Candid record `GetNextSnsVersionRequest`.
final class NnsWasmGetNextSnsVersionRequest with CandidSerializable {
  final IcpPrincipalAddress? governanceCanisterId;
  final NnsWasmSnsVersion? currentVersion;

  const NnsWasmGetNextSnsVersionRequest({
    this.governanceCanisterId,
    this.currentVersion,
  });

  static CType get ctype => CType.record([
    Field(Label.named('governance_canister_id'), CType.opt(CType.principal)),
    LazyField(
      Label.named('current_version'),
      () => CType.opt(NnsWasmSnsVersion.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'governance_canister_id': governanceCanisterId,
    'current_version': currentVersion?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'governance_canister_id': governanceCanisterId?.address,
    'current_version': currentVersion?.toJson(),
  };

  factory NnsWasmGetNextSnsVersionRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmGetNextSnsVersionRequest(
      governanceCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'governance_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      currentVersion: json.valueTo<NnsWasmSnsVersion?, Map>(
        key: 'current_version',
        parse:
            (e) => NnsWasmSnsVersion.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmGetNextSnsVersionRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetNextSnsVersionRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetNextSnsVersionResponse`.
final class NnsWasmGetNextSnsVersionResponse with CandidSerializable {
  final NnsWasmSnsVersion? nextVersion;

  const NnsWasmGetNextSnsVersionResponse({this.nextVersion});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('next_version'),
      () => CType.opt(NnsWasmSnsVersion.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'next_version': nextVersion?.candidValue};

  Map<String, dynamic> toJson() => {'next_version': nextVersion?.toJson()};

  factory NnsWasmGetNextSnsVersionResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmGetNextSnsVersionResponse(
      nextVersion: json.valueTo<NnsWasmSnsVersion?, Map>(
        key: 'next_version',
        parse:
            (e) => NnsWasmSnsVersion.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmGetNextSnsVersionResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetNextSnsVersionResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetProposalIdThatAddedWasmRequest`.
final class NnsWasmGetProposalIdThatAddedWasmRequest with CandidSerializable {
  final List<int> hash;

  const NnsWasmGetProposalIdThatAddedWasmRequest({required this.hash});

  static CType get ctype =>
      CType.record([Field(Label.named('hash'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'hash': hash};

  Map<String, dynamic> toJson() => {'hash': hash};

  factory NnsWasmGetProposalIdThatAddedWasmRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmGetProposalIdThatAddedWasmRequest(
      hash: json.valueAsBytes<List<int>>(
        'hash',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsWasmGetProposalIdThatAddedWasmRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetProposalIdThatAddedWasmRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetProposalIdThatAddedWasmResponse`.
final class NnsWasmGetProposalIdThatAddedWasmResponse with CandidSerializable {
  final BigInt? proposalId;

  const NnsWasmGetProposalIdThatAddedWasmResponse({this.proposalId});

  static CType get ctype =>
      CType.record([Field(Label.named('proposal_id'), CType.opt(CType.nat64))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'proposal_id': proposalId};

  Map<String, dynamic> toJson() => {'proposal_id': proposalId};

  factory NnsWasmGetProposalIdThatAddedWasmResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmGetProposalIdThatAddedWasmResponse(
      proposalId: json.valueAsBigInt<BigInt?>('proposal_id'),
    );
  }

  factory NnsWasmGetProposalIdThatAddedWasmResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetProposalIdThatAddedWasmResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetSnsSubnetIdsResponse`.
final class NnsWasmGetSnsSubnetIdsResponse with CandidSerializable {
  final List<IcpPrincipalAddress> snsSubnetIds;

  const NnsWasmGetSnsSubnetIdsResponse({required this.snsSubnetIds});

  static CType get ctype => CType.record([
    Field(Label.named('sns_subnet_ids'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'sns_subnet_ids': snsSubnetIds};

  Map<String, dynamic> toJson() => {
    'sns_subnet_ids': snsSubnetIds.map((el) => el.address).toList(),
  };

  factory NnsWasmGetSnsSubnetIdsResponse.fromCandid(Map<String, dynamic> json) {
    return NnsWasmGetSnsSubnetIdsResponse(
      snsSubnetIds: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'sns_subnet_ids',
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

  factory NnsWasmGetSnsSubnetIdsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetSnsSubnetIdsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetWasmMetadataRequest`.
final class NnsWasmGetWasmMetadataRequest with CandidSerializable {
  final List<int>? hash;

  const NnsWasmGetWasmMetadataRequest({this.hash});

  static CType get ctype => CType.record([
    Field(Label.named('hash'), CType.opt(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'hash': hash};

  Map<String, dynamic> toJson() => {'hash': hash};

  factory NnsWasmGetWasmMetadataRequest.fromCandid(Map<String, dynamic> json) {
    return NnsWasmGetWasmMetadataRequest(
      hash: json.valueAsBytes<List<int>?>(
        'hash',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsWasmGetWasmMetadataRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetWasmMetadataRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetWasmMetadataResponse`.
final class NnsWasmGetWasmMetadataResponse with CandidSerializable {
  final NnsWasmResult1? result;

  const NnsWasmGetWasmMetadataResponse({this.result});

  static CType get ctype => CType.record([
    LazyField(Label.named('result'), () => CType.opt(NnsWasmResult1.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'result': result?.candidValue};

  Map<String, dynamic> toJson() => {'result': result?.toJson()};

  factory NnsWasmGetWasmMetadataResponse.fromCandid(Map<String, dynamic> json) {
    return NnsWasmGetWasmMetadataResponse(
      result: json.valueTo<NnsWasmResult1?, Map>(
        key: 'result',
        parse:
            (e) => NnsWasmResult1.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmGetWasmMetadataResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetWasmMetadataResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetWasmRequest`.
final class NnsWasmGetWasmRequest with CandidSerializable {
  final List<int> hash;

  const NnsWasmGetWasmRequest({required this.hash});

  static CType get ctype =>
      CType.record([Field(Label.named('hash'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'hash': hash};

  Map<String, dynamic> toJson() => {'hash': hash};

  factory NnsWasmGetWasmRequest.fromCandid(Map<String, dynamic> json) {
    return NnsWasmGetWasmRequest(
      hash: json.valueAsBytes<List<int>>(
        'hash',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsWasmGetWasmRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetWasmRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetWasmResponse`.
final class NnsWasmGetWasmResponse with CandidSerializable {
  final NnsWasmSnsWasm? wasm;

  const NnsWasmGetWasmResponse({this.wasm});

  static CType get ctype => CType.record([
    LazyField(Label.named('wasm'), () => CType.opt(NnsWasmSnsWasm.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'wasm': wasm?.candidValue};

  Map<String, dynamic> toJson() => {'wasm': wasm?.toJson()};

  factory NnsWasmGetWasmResponse.fromCandid(Map<String, dynamic> json) {
    return NnsWasmGetWasmResponse(
      wasm: json.valueTo<NnsWasmSnsWasm?, Map>(
        key: 'wasm',
        parse:
            (e) => NnsWasmSnsWasm.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmGetWasmResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmGetWasmResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `IdealMatchedParticipationFunction`.
final class NnsWasmIdealMatchedParticipationFunction with CandidSerializable {
  final String? serializedRepresentation;

  const NnsWasmIdealMatchedParticipationFunction({
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

  factory NnsWasmIdealMatchedParticipationFunction.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmIdealMatchedParticipationFunction(
      serializedRepresentation: json.valueAsString<String?>(
        'serialized_representation',
      ),
    );
  }

  factory NnsWasmIdealMatchedParticipationFunction.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmIdealMatchedParticipationFunction.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `InitialTokenDistribution`.
sealed class NnsWasmInitialTokenDistribution with CandidSerializable {
  const NnsWasmInitialTokenDistribution();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('FractionalDeveloperVotingPower'),
      () => NnsWasmFractionalDeveloperVotingPower.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsWasmInitialTokenDistribution.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('FractionalDeveloperVotingPower')) {
      return NnsWasmInitialTokenDistributionFractionalDeveloperVotingPower(
        json.valueTo<NnsWasmFractionalDeveloperVotingPower, Map>(
          key: 'FractionalDeveloperVotingPower',
          parse:
              (e) => NnsWasmFractionalDeveloperVotingPower.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsWasmInitialTokenDistribution.fromCandid',
      reason: 'Unknown NnsWasmInitialTokenDistribution arm',
    );
  }

  factory NnsWasmInitialTokenDistribution.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmInitialTokenDistribution.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `InitialTokenDistribution.FractionalDeveloperVotingPower`.
final class NnsWasmInitialTokenDistributionFractionalDeveloperVotingPower
    extends NnsWasmInitialTokenDistribution {
  final NnsWasmFractionalDeveloperVotingPower value;
  const NnsWasmInitialTokenDistributionFractionalDeveloperVotingPower(
    this.value,
  );

  @override
  CType get candidType => NnsWasmInitialTokenDistribution.ctype;

  @override
  dynamic get candidValue =>
      Variant('FractionalDeveloperVotingPower', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'FractionalDeveloperVotingPower': value.toJson(),
  };
}

/// Candid record `InsertUpgradePathEntriesRequest`.
final class NnsWasmInsertUpgradePathEntriesRequest with CandidSerializable {
  final List<NnsWasmSnsUpgrade> upgradePath;
  final IcpPrincipalAddress? snsGovernanceCanisterId;

  const NnsWasmInsertUpgradePathEntriesRequest({
    required this.upgradePath,
    this.snsGovernanceCanisterId,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('upgrade_path'),
      () => CType.vec(NnsWasmSnsUpgrade.ctype),
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
    'upgrade_path': upgradePath.map((el) => el.candidValue).toList(),
    'sns_governance_canister_id': snsGovernanceCanisterId,
  };

  Map<String, dynamic> toJson() => {
    'upgrade_path': upgradePath.map((el) => el.toJson()).toList(),
    'sns_governance_canister_id': snsGovernanceCanisterId?.address,
  };

  factory NnsWasmInsertUpgradePathEntriesRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmInsertUpgradePathEntriesRequest(
      upgradePath: json.valueTo<List<NnsWasmSnsUpgrade>, List>(
        key: 'upgrade_path',
        parse:
            (e) =>
                e
                    .map<NnsWasmSnsUpgrade>(
                      (x) => NnsWasmSnsUpgrade.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      snsGovernanceCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'sns_governance_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsWasmInsertUpgradePathEntriesRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmInsertUpgradePathEntriesRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `InsertUpgradePathEntriesResponse`.
final class NnsWasmInsertUpgradePathEntriesResponse with CandidSerializable {
  final NnsWasmSnsWasmError? error;

  const NnsWasmInsertUpgradePathEntriesResponse({this.error});

  static CType get ctype => CType.record([
    LazyField(Label.named('error'), () => CType.opt(NnsWasmSnsWasmError.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'error': error?.candidValue};

  Map<String, dynamic> toJson() => {'error': error?.toJson()};

  factory NnsWasmInsertUpgradePathEntriesResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmInsertUpgradePathEntriesResponse(
      error: json.valueTo<NnsWasmSnsWasmError?, Map>(
        key: 'error',
        parse:
            (e) => NnsWasmSnsWasmError.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmInsertUpgradePathEntriesResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmInsertUpgradePathEntriesResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `LinearScalingCoefficient`.
final class NnsWasmLinearScalingCoefficient with CandidSerializable {
  final BigInt? slopeNumerator;
  final BigInt? interceptIcpE8s;
  final BigInt? fromDirectParticipationIcpE8s;
  final BigInt? slopeDenominator;
  final BigInt? toDirectParticipationIcpE8s;

  const NnsWasmLinearScalingCoefficient({
    this.slopeNumerator,
    this.interceptIcpE8s,
    this.fromDirectParticipationIcpE8s,
    this.slopeDenominator,
    this.toDirectParticipationIcpE8s,
  });

  static CType get ctype => CType.record([
    Field(Label.named('slope_numerator'), CType.opt(CType.nat64)),
    Field(Label.named('intercept_icp_e8s'), CType.opt(CType.nat64)),
    Field(
      Label.named('from_direct_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('slope_denominator'), CType.opt(CType.nat64)),
    Field(
      Label.named('to_direct_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'slope_numerator': slopeNumerator,
    'intercept_icp_e8s': interceptIcpE8s,
    'from_direct_participation_icp_e8s': fromDirectParticipationIcpE8s,
    'slope_denominator': slopeDenominator,
    'to_direct_participation_icp_e8s': toDirectParticipationIcpE8s,
  };

  Map<String, dynamic> toJson() => {
    'slope_numerator': slopeNumerator,
    'intercept_icp_e8s': interceptIcpE8s,
    'from_direct_participation_icp_e8s': fromDirectParticipationIcpE8s,
    'slope_denominator': slopeDenominator,
    'to_direct_participation_icp_e8s': toDirectParticipationIcpE8s,
  };

  factory NnsWasmLinearScalingCoefficient.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmLinearScalingCoefficient(
      slopeNumerator: json.valueAsBigInt<BigInt?>('slope_numerator'),
      interceptIcpE8s: json.valueAsBigInt<BigInt?>('intercept_icp_e8s'),
      fromDirectParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'from_direct_participation_icp_e8s',
      ),
      slopeDenominator: json.valueAsBigInt<BigInt?>('slope_denominator'),
      toDirectParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'to_direct_participation_icp_e8s',
      ),
    );
  }

  factory NnsWasmLinearScalingCoefficient.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmLinearScalingCoefficient.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListDeployedSnsesResponse`.
final class NnsWasmListDeployedSnsesResponse with CandidSerializable {
  final List<NnsWasmDeployedSns> instances;

  const NnsWasmListDeployedSnsesResponse({required this.instances});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('instances'),
      () => CType.vec(NnsWasmDeployedSns.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'instances': instances.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'instances': instances.map((el) => el.toJson()).toList(),
  };

  factory NnsWasmListDeployedSnsesResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmListDeployedSnsesResponse(
      instances: json.valueTo<List<NnsWasmDeployedSns>, List>(
        key: 'instances',
        parse:
            (e) =>
                e
                    .map<NnsWasmDeployedSns>(
                      (x) => NnsWasmDeployedSns.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsWasmListDeployedSnsesResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmListDeployedSnsesResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListUpgradeStep`.
final class NnsWasmListUpgradeStep with CandidSerializable {
  final NnsWasmPrettySnsVersion? prettyVersion;
  final NnsWasmSnsVersion? version;

  const NnsWasmListUpgradeStep({this.prettyVersion, this.version});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('pretty_version'),
      () => CType.opt(NnsWasmPrettySnsVersion.ctype),
    ),
    LazyField(Label.named('version'), () => CType.opt(NnsWasmSnsVersion.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'pretty_version': prettyVersion?.candidValue,
    'version': version?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'pretty_version': prettyVersion?.toJson(),
    'version': version?.toJson(),
  };

  factory NnsWasmListUpgradeStep.fromCandid(Map<String, dynamic> json) {
    return NnsWasmListUpgradeStep(
      prettyVersion: json.valueTo<NnsWasmPrettySnsVersion?, Map>(
        key: 'pretty_version',
        parse:
            (e) => NnsWasmPrettySnsVersion.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      version: json.valueTo<NnsWasmSnsVersion?, Map>(
        key: 'version',
        parse:
            (e) => NnsWasmSnsVersion.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmListUpgradeStep.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmListUpgradeStep.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListUpgradeStepsRequest`.
final class NnsWasmListUpgradeStepsRequest with CandidSerializable {
  final int limit;
  final NnsWasmSnsVersion? startingAt;
  final IcpPrincipalAddress? snsGovernanceCanisterId;

  const NnsWasmListUpgradeStepsRequest({
    required this.limit,
    this.startingAt,
    this.snsGovernanceCanisterId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('limit'), CType.nat32),
    LazyField(
      Label.named('starting_at'),
      () => CType.opt(NnsWasmSnsVersion.ctype),
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
    'limit': limit,
    'starting_at': startingAt?.candidValue,
    'sns_governance_canister_id': snsGovernanceCanisterId,
  };

  Map<String, dynamic> toJson() => {
    'limit': limit,
    'starting_at': startingAt?.toJson(),
    'sns_governance_canister_id': snsGovernanceCanisterId?.address,
  };

  factory NnsWasmListUpgradeStepsRequest.fromCandid(Map<String, dynamic> json) {
    return NnsWasmListUpgradeStepsRequest(
      limit: json.valueAsInt<int>('limit'),
      startingAt: json.valueTo<NnsWasmSnsVersion?, Map>(
        key: 'starting_at',
        parse:
            (e) => NnsWasmSnsVersion.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      snsGovernanceCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'sns_governance_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsWasmListUpgradeStepsRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmListUpgradeStepsRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ListUpgradeStepsResponse`.
final class NnsWasmListUpgradeStepsResponse with CandidSerializable {
  final List<NnsWasmListUpgradeStep> steps;

  const NnsWasmListUpgradeStepsResponse({required this.steps});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('steps'),
      () => CType.vec(NnsWasmListUpgradeStep.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'steps': steps.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'steps': steps.map((el) => el.toJson()).toList(),
  };

  factory NnsWasmListUpgradeStepsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmListUpgradeStepsResponse(
      steps: json.valueTo<List<NnsWasmListUpgradeStep>, List>(
        key: 'steps',
        parse:
            (e) =>
                e
                    .map<NnsWasmListUpgradeStep>(
                      (x) => NnsWasmListUpgradeStep.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsWasmListUpgradeStepsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmListUpgradeStepsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `MetadataSection`.
final class NnsWasmMetadataSection with CandidSerializable {
  final List<int>? contents;
  final String? name;
  final String? visibility;

  const NnsWasmMetadataSection({this.contents, this.name, this.visibility});

  static CType get ctype => CType.record([
    Field(Label.named('contents'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('name'), CType.opt(CType.text)),
    Field(Label.named('visibility'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'contents': contents,
    'name': name,
    'visibility': visibility,
  };

  Map<String, dynamic> toJson() => {
    'contents': contents,
    'name': name,
    'visibility': visibility,
  };

  factory NnsWasmMetadataSection.fromCandid(Map<String, dynamic> json) {
    return NnsWasmMetadataSection(
      contents: json.valueAsBytes<List<int>?>(
        'contents',
        encoding: StringEncoding.base64,
      ),
      name: json.valueAsString<String?>('name'),
      visibility: json.valueAsString<String?>('visibility'),
    );
  }

  factory NnsWasmMetadataSection.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmMetadataSection.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronBasketConstructionParameters`.
final class NnsWasmNeuronBasketConstructionParameters with CandidSerializable {
  final BigInt dissolveDelayIntervalSeconds;
  final BigInt count;

  const NnsWasmNeuronBasketConstructionParameters({
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

  factory NnsWasmNeuronBasketConstructionParameters.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmNeuronBasketConstructionParameters(
      dissolveDelayIntervalSeconds: json.valueAsBigInt<BigInt>(
        'dissolve_delay_interval_seconds',
      ),
      count: json.valueAsBigInt<BigInt>('count'),
    );
  }

  factory NnsWasmNeuronBasketConstructionParameters.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmNeuronBasketConstructionParameters.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronDistribution`.
final class NnsWasmNeuronDistribution with CandidSerializable {
  final IcpPrincipalAddress? controller;
  final BigInt dissolveDelaySeconds;
  final BigInt memo;
  final BigInt stakeE8s;
  final BigInt? vestingPeriodSeconds;

  const NnsWasmNeuronDistribution({
    this.controller,
    required this.dissolveDelaySeconds,
    required this.memo,
    required this.stakeE8s,
    this.vestingPeriodSeconds,
  });

  static CType get ctype => CType.record([
    Field(Label.named('controller'), CType.opt(CType.principal)),
    Field(Label.named('dissolve_delay_seconds'), CType.nat64),
    Field(Label.named('memo'), CType.nat64),
    Field(Label.named('stake_e8s'), CType.nat64),
    Field(Label.named('vesting_period_seconds'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'controller': controller,
    'dissolve_delay_seconds': dissolveDelaySeconds,
    'memo': memo,
    'stake_e8s': stakeE8s,
    'vesting_period_seconds': vestingPeriodSeconds,
  };

  Map<String, dynamic> toJson() => {
    'controller': controller?.address,
    'dissolve_delay_seconds': dissolveDelaySeconds,
    'memo': memo,
    'stake_e8s': stakeE8s,
    'vesting_period_seconds': vestingPeriodSeconds,
  };

  factory NnsWasmNeuronDistribution.fromCandid(Map<String, dynamic> json) {
    return NnsWasmNeuronDistribution(
      controller: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'controller',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      dissolveDelaySeconds: json.valueAsBigInt<BigInt>(
        'dissolve_delay_seconds',
      ),
      memo: json.valueAsBigInt<BigInt>('memo'),
      stakeE8s: json.valueAsBigInt<BigInt>('stake_e8s'),
      vestingPeriodSeconds: json.valueAsBigInt<BigInt?>(
        'vesting_period_seconds',
      ),
    );
  }

  factory NnsWasmNeuronDistribution.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmNeuronDistribution.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `NeuronsFundParticipationConstraints`.
final class NnsWasmNeuronsFundParticipationConstraints with CandidSerializable {
  final List<NnsWasmLinearScalingCoefficient> coefficientIntervals;
  final BigInt? maxNeuronsFundParticipationIcpE8s;
  final BigInt? minDirectParticipationThresholdIcpE8s;
  final NnsWasmIdealMatchedParticipationFunction?
  idealMatchedParticipationFunction;

  const NnsWasmNeuronsFundParticipationConstraints({
    required this.coefficientIntervals,
    this.maxNeuronsFundParticipationIcpE8s,
    this.minDirectParticipationThresholdIcpE8s,
    this.idealMatchedParticipationFunction,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('coefficient_intervals'),
      () => CType.vec(NnsWasmLinearScalingCoefficient.ctype),
    ),
    Field(
      Label.named('max_neurons_fund_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(
      Label.named('min_direct_participation_threshold_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    LazyField(
      Label.named('ideal_matched_participation_function'),
      () => CType.opt(NnsWasmIdealMatchedParticipationFunction.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'coefficient_intervals':
        coefficientIntervals.map((el) => el.candidValue).toList(),
    'max_neurons_fund_participation_icp_e8s': maxNeuronsFundParticipationIcpE8s,
    'min_direct_participation_threshold_icp_e8s':
        minDirectParticipationThresholdIcpE8s,
    'ideal_matched_participation_function':
        idealMatchedParticipationFunction?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'coefficient_intervals':
        coefficientIntervals.map((el) => el.toJson()).toList(),
    'max_neurons_fund_participation_icp_e8s': maxNeuronsFundParticipationIcpE8s,
    'min_direct_participation_threshold_icp_e8s':
        minDirectParticipationThresholdIcpE8s,
    'ideal_matched_participation_function':
        idealMatchedParticipationFunction?.toJson(),
  };

  factory NnsWasmNeuronsFundParticipationConstraints.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmNeuronsFundParticipationConstraints(
      coefficientIntervals: json
          .valueTo<List<NnsWasmLinearScalingCoefficient>, List>(
            key: 'coefficient_intervals',
            parse:
                (e) =>
                    e
                        .map<NnsWasmLinearScalingCoefficient>(
                          (x) => NnsWasmLinearScalingCoefficient.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
      maxNeuronsFundParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'max_neurons_fund_participation_icp_e8s',
      ),
      minDirectParticipationThresholdIcpE8s: json.valueAsBigInt<BigInt?>(
        'min_direct_participation_threshold_icp_e8s',
      ),
      idealMatchedParticipationFunction: json
          .valueTo<NnsWasmIdealMatchedParticipationFunction?, Map>(
            key: 'ideal_matched_participation_function',
            parse:
                (e) => NnsWasmIdealMatchedParticipationFunction.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsWasmNeuronsFundParticipationConstraints.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmNeuronsFundParticipationConstraints.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Ok`.
final class NnsWasmOk with CandidSerializable {
  final List<NnsWasmMetadataSection> sections;

  const NnsWasmOk({required this.sections});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('sections'),
      () => CType.vec(NnsWasmMetadataSection.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'sections': sections.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'sections': sections.map((el) => el.toJson()).toList(),
  };

  factory NnsWasmOk.fromCandid(Map<String, dynamic> json) {
    return NnsWasmOk(
      sections: json.valueTo<List<NnsWasmMetadataSection>, List>(
        key: 'sections',
        parse:
            (e) =>
                e
                    .map<NnsWasmMetadataSection>(
                      (x) => NnsWasmMetadataSection.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory NnsWasmOk.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmOk.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `PrettySnsVersion`.
final class NnsWasmPrettySnsVersion with CandidSerializable {
  final String archiveWasmHash;
  final String rootWasmHash;
  final String swapWasmHash;
  final String ledgerWasmHash;
  final String governanceWasmHash;
  final String indexWasmHash;

  const NnsWasmPrettySnsVersion({
    required this.archiveWasmHash,
    required this.rootWasmHash,
    required this.swapWasmHash,
    required this.ledgerWasmHash,
    required this.governanceWasmHash,
    required this.indexWasmHash,
  });

  static CType get ctype => CType.record([
    Field(Label.named('archive_wasm_hash'), CType.text),
    Field(Label.named('root_wasm_hash'), CType.text),
    Field(Label.named('swap_wasm_hash'), CType.text),
    Field(Label.named('ledger_wasm_hash'), CType.text),
    Field(Label.named('governance_wasm_hash'), CType.text),
    Field(Label.named('index_wasm_hash'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'archive_wasm_hash': archiveWasmHash,
    'root_wasm_hash': rootWasmHash,
    'swap_wasm_hash': swapWasmHash,
    'ledger_wasm_hash': ledgerWasmHash,
    'governance_wasm_hash': governanceWasmHash,
    'index_wasm_hash': indexWasmHash,
  };

  Map<String, dynamic> toJson() => {
    'archive_wasm_hash': archiveWasmHash,
    'root_wasm_hash': rootWasmHash,
    'swap_wasm_hash': swapWasmHash,
    'ledger_wasm_hash': ledgerWasmHash,
    'governance_wasm_hash': governanceWasmHash,
    'index_wasm_hash': indexWasmHash,
  };

  factory NnsWasmPrettySnsVersion.fromCandid(Map<String, dynamic> json) {
    return NnsWasmPrettySnsVersion(
      archiveWasmHash: json.valueAsString<String>('archive_wasm_hash'),
      rootWasmHash: json.valueAsString<String>('root_wasm_hash'),
      swapWasmHash: json.valueAsString<String>('swap_wasm_hash'),
      ledgerWasmHash: json.valueAsString<String>('ledger_wasm_hash'),
      governanceWasmHash: json.valueAsString<String>('governance_wasm_hash'),
      indexWasmHash: json.valueAsString<String>('index_wasm_hash'),
    );
  }

  factory NnsWasmPrettySnsVersion.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmPrettySnsVersion.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Result`.
sealed class NnsWasmResult with CandidSerializable {
  const NnsWasmResult();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Error'), () => NnsWasmSnsWasmError.ctype),
    Field(Label.named('Hash'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsWasmResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Error')) {
      return NnsWasmResultError(
        json.valueTo<NnsWasmSnsWasmError, Map>(
          key: 'Error',
          parse:
              (e) => NnsWasmSnsWasmError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Hash')) {
      return NnsWasmResultHash(
        json.valueAsBytes<List<int>>('Hash', encoding: StringEncoding.base64),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsWasmResult.fromCandid',
      reason: 'Unknown NnsWasmResult arm',
    );
  }

  factory NnsWasmResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result.Error`.
final class NnsWasmResultError extends NnsWasmResult {
  final NnsWasmSnsWasmError value;
  const NnsWasmResultError(this.value);

  @override
  CType get candidType => NnsWasmResult.ctype;

  @override
  dynamic get candidValue => Variant('Error', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Error': value.toJson()};
}

/// Variant arm `Result.Hash`.
final class NnsWasmResultHash extends NnsWasmResult {
  final List<int> value;
  const NnsWasmResultHash(this.value);

  @override
  CType get candidType => NnsWasmResult.ctype;

  @override
  dynamic get candidValue => Variant('Hash', value);

  @override
  Map<String, dynamic> toJson() => {'Hash': value};
}

/// Candid variant `Result_1`.
sealed class NnsWasmResult1 with CandidSerializable {
  const NnsWasmResult1();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => NnsWasmOk.ctype),
    LazyField(Label.named('Error'), () => NnsWasmSnsWasmError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsWasmResult1.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return NnsWasmResult1Ok(
        json.valueTo<NnsWasmOk, Map>(
          key: 'Ok',
          parse:
              (e) => NnsWasmOk.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Error')) {
      return NnsWasmResult1Error(
        json.valueTo<NnsWasmSnsWasmError, Map>(
          key: 'Error',
          parse:
              (e) => NnsWasmSnsWasmError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsWasmResult1.fromCandid',
      reason: 'Unknown NnsWasmResult1 arm',
    );
  }

  factory NnsWasmResult1.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmResult1.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Result_1.Ok`.
final class NnsWasmResult1Ok extends NnsWasmResult1 {
  final NnsWasmOk value;
  const NnsWasmResult1Ok(this.value);

  @override
  CType get candidType => NnsWasmResult1.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `Result_1.Error`.
final class NnsWasmResult1Error extends NnsWasmResult1 {
  final NnsWasmSnsWasmError value;
  const NnsWasmResult1Error(this.value);

  @override
  CType get candidType => NnsWasmResult1.ctype;

  @override
  dynamic get candidValue => Variant('Error', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Error': value.toJson()};
}

/// Candid record `SnsCanisterIds`.
final class NnsWasmSnsCanisterIds with CandidSerializable {
  final IcpPrincipalAddress? root;
  final IcpPrincipalAddress? swap;
  final IcpPrincipalAddress? ledger;
  final IcpPrincipalAddress? index;
  final IcpPrincipalAddress? governance;

  const NnsWasmSnsCanisterIds({
    this.root,
    this.swap,
    this.ledger,
    this.index,
    this.governance,
  });

  static CType get ctype => CType.record([
    Field(Label.named('root'), CType.opt(CType.principal)),
    Field(Label.named('swap'), CType.opt(CType.principal)),
    Field(Label.named('ledger'), CType.opt(CType.principal)),
    Field(Label.named('index'), CType.opt(CType.principal)),
    Field(Label.named('governance'), CType.opt(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'root': root,
    'swap': swap,
    'ledger': ledger,
    'index': index,
    'governance': governance,
  };

  Map<String, dynamic> toJson() => {
    'root': root?.address,
    'swap': swap?.address,
    'ledger': ledger?.address,
    'index': index?.address,
    'governance': governance?.address,
  };

  factory NnsWasmSnsCanisterIds.fromCandid(Map<String, dynamic> json) {
    return NnsWasmSnsCanisterIds(
      root: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'root',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      swap: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'swap',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      ledger: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'ledger',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      index: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'index',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      governance: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'governance',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory NnsWasmSnsCanisterIds.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmSnsCanisterIds.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SnsInitPayload`.
final class NnsWasmSnsInitPayload with CandidSerializable {
  final String? url;
  final BigInt? maxDissolveDelaySeconds;
  final BigInt? maxDissolveDelayBonusPercentage;
  final BigInt? nnsProposalId;
  final bool? neuronsFundParticipation;
  final BigInt? minParticipantIcpE8s;
  final NnsWasmNeuronBasketConstructionParameters?
  neuronBasketConstructionParameters;
  final List<String> fallbackControllerPrincipalIds;
  final String? tokenSymbol;
  final BigInt? finalRewardRateBasisPoints;
  final BigInt? maxIcpE8s;
  final BigInt? neuronMinimumStakeE8s;
  final String? confirmationText;
  final String? logo;
  final String? name;
  final BigInt? swapStartTimestampSeconds;
  final BigInt? swapDueTimestampSeconds;
  final BigInt? initialVotingPeriodSeconds;
  final BigInt? neuronMinimumDissolveDelayToVoteSeconds;
  final String? description;
  final BigInt? maxNeuronAgeSecondsForAgeBonus;
  final BigInt? minParticipants;
  final BigInt? initialRewardRateBasisPoints;
  final BigInt? waitForQuietDeadlineIncreaseSeconds;
  final BigInt? transactionFeeE8s;
  final NnsWasmDappCanisters? dappCanisters;
  final NnsWasmNeuronsFundParticipationConstraints?
  neuronsFundParticipationConstraints;
  final BigInt? maxAgeBonusPercentage;
  final NnsWasmInitialTokenDistribution? initialTokenDistribution;
  final BigInt? rewardRateTransitionDurationSeconds;
  final String? tokenLogo;
  final String? tokenName;
  final BigInt? maxParticipantIcpE8s;
  final BigInt? minDirectParticipationIcpE8s;
  final BigInt? proposalRejectCostE8s;
  final NnsWasmCountries? restrictedCountries;
  final BigInt? minIcpE8s;
  final BigInt? maxDirectParticipationIcpE8s;
  final NnsWasmCustomProposalCriticality? customProposalCriticality;

  const NnsWasmSnsInitPayload({
    this.url,
    this.maxDissolveDelaySeconds,
    this.maxDissolveDelayBonusPercentage,
    this.nnsProposalId,
    this.neuronsFundParticipation,
    this.minParticipantIcpE8s,
    this.neuronBasketConstructionParameters,
    required this.fallbackControllerPrincipalIds,
    this.tokenSymbol,
    this.finalRewardRateBasisPoints,
    this.maxIcpE8s,
    this.neuronMinimumStakeE8s,
    this.confirmationText,
    this.logo,
    this.name,
    this.swapStartTimestampSeconds,
    this.swapDueTimestampSeconds,
    this.initialVotingPeriodSeconds,
    this.neuronMinimumDissolveDelayToVoteSeconds,
    this.description,
    this.maxNeuronAgeSecondsForAgeBonus,
    this.minParticipants,
    this.initialRewardRateBasisPoints,
    this.waitForQuietDeadlineIncreaseSeconds,
    this.transactionFeeE8s,
    this.dappCanisters,
    this.neuronsFundParticipationConstraints,
    this.maxAgeBonusPercentage,
    this.initialTokenDistribution,
    this.rewardRateTransitionDurationSeconds,
    this.tokenLogo,
    this.tokenName,
    this.maxParticipantIcpE8s,
    this.minDirectParticipationIcpE8s,
    this.proposalRejectCostE8s,
    this.restrictedCountries,
    this.minIcpE8s,
    this.maxDirectParticipationIcpE8s,
    this.customProposalCriticality,
  });

  static CType get ctype => CType.record([
    Field(Label.named('url'), CType.opt(CType.text)),
    Field(Label.named('max_dissolve_delay_seconds'), CType.opt(CType.nat64)),
    Field(
      Label.named('max_dissolve_delay_bonus_percentage'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('nns_proposal_id'), CType.opt(CType.nat64)),
    Field(Label.named('neurons_fund_participation'), CType.opt(CType.bool_)),
    Field(Label.named('min_participant_icp_e8s'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('neuron_basket_construction_parameters'),
      () => CType.opt(NnsWasmNeuronBasketConstructionParameters.ctype),
    ),
    Field(
      Label.named('fallback_controller_principal_ids'),
      CType.vec(CType.text),
    ),
    Field(Label.named('token_symbol'), CType.opt(CType.text)),
    Field(
      Label.named('final_reward_rate_basis_points'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('max_icp_e8s'), CType.opt(CType.nat64)),
    Field(Label.named('neuron_minimum_stake_e8s'), CType.opt(CType.nat64)),
    Field(Label.named('confirmation_text'), CType.opt(CType.text)),
    Field(Label.named('logo'), CType.opt(CType.text)),
    Field(Label.named('name'), CType.opt(CType.text)),
    Field(Label.named('swap_start_timestamp_seconds'), CType.opt(CType.nat64)),
    Field(Label.named('swap_due_timestamp_seconds'), CType.opt(CType.nat64)),
    Field(Label.named('initial_voting_period_seconds'), CType.opt(CType.nat64)),
    Field(
      Label.named('neuron_minimum_dissolve_delay_to_vote_seconds'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('description'), CType.opt(CType.text)),
    Field(
      Label.named('max_neuron_age_seconds_for_age_bonus'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('min_participants'), CType.opt(CType.nat64)),
    Field(
      Label.named('initial_reward_rate_basis_points'),
      CType.opt(CType.nat64),
    ),
    Field(
      Label.named('wait_for_quiet_deadline_increase_seconds'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('transaction_fee_e8s'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('dapp_canisters'),
      () => CType.opt(NnsWasmDappCanisters.ctype),
    ),
    LazyField(
      Label.named('neurons_fund_participation_constraints'),
      () => CType.opt(NnsWasmNeuronsFundParticipationConstraints.ctype),
    ),
    Field(Label.named('max_age_bonus_percentage'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('initial_token_distribution'),
      () => CType.opt(NnsWasmInitialTokenDistribution.ctype),
    ),
    Field(
      Label.named('reward_rate_transition_duration_seconds'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('token_logo'), CType.opt(CType.text)),
    Field(Label.named('token_name'), CType.opt(CType.text)),
    Field(Label.named('max_participant_icp_e8s'), CType.opt(CType.nat64)),
    Field(
      Label.named('min_direct_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    Field(Label.named('proposal_reject_cost_e8s'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('restricted_countries'),
      () => CType.opt(NnsWasmCountries.ctype),
    ),
    Field(Label.named('min_icp_e8s'), CType.opt(CType.nat64)),
    Field(
      Label.named('max_direct_participation_icp_e8s'),
      CType.opt(CType.nat64),
    ),
    LazyField(
      Label.named('custom_proposal_criticality'),
      () => CType.opt(NnsWasmCustomProposalCriticality.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'url': url,
    'max_dissolve_delay_seconds': maxDissolveDelaySeconds,
    'max_dissolve_delay_bonus_percentage': maxDissolveDelayBonusPercentage,
    'nns_proposal_id': nnsProposalId,
    'neurons_fund_participation': neuronsFundParticipation,
    'min_participant_icp_e8s': minParticipantIcpE8s,
    'neuron_basket_construction_parameters':
        neuronBasketConstructionParameters?.candidValue,
    'fallback_controller_principal_ids': fallbackControllerPrincipalIds,
    'token_symbol': tokenSymbol,
    'final_reward_rate_basis_points': finalRewardRateBasisPoints,
    'max_icp_e8s': maxIcpE8s,
    'neuron_minimum_stake_e8s': neuronMinimumStakeE8s,
    'confirmation_text': confirmationText,
    'logo': logo,
    'name': name,
    'swap_start_timestamp_seconds': swapStartTimestampSeconds,
    'swap_due_timestamp_seconds': swapDueTimestampSeconds,
    'initial_voting_period_seconds': initialVotingPeriodSeconds,
    'neuron_minimum_dissolve_delay_to_vote_seconds':
        neuronMinimumDissolveDelayToVoteSeconds,
    'description': description,
    'max_neuron_age_seconds_for_age_bonus': maxNeuronAgeSecondsForAgeBonus,
    'min_participants': minParticipants,
    'initial_reward_rate_basis_points': initialRewardRateBasisPoints,
    'wait_for_quiet_deadline_increase_seconds':
        waitForQuietDeadlineIncreaseSeconds,
    'transaction_fee_e8s': transactionFeeE8s,
    'dapp_canisters': dappCanisters?.candidValue,
    'neurons_fund_participation_constraints':
        neuronsFundParticipationConstraints?.candidValue,
    'max_age_bonus_percentage': maxAgeBonusPercentage,
    'initial_token_distribution': initialTokenDistribution?.candidValue,
    'reward_rate_transition_duration_seconds':
        rewardRateTransitionDurationSeconds,
    'token_logo': tokenLogo,
    'token_name': tokenName,
    'max_participant_icp_e8s': maxParticipantIcpE8s,
    'min_direct_participation_icp_e8s': minDirectParticipationIcpE8s,
    'proposal_reject_cost_e8s': proposalRejectCostE8s,
    'restricted_countries': restrictedCountries?.candidValue,
    'min_icp_e8s': minIcpE8s,
    'max_direct_participation_icp_e8s': maxDirectParticipationIcpE8s,
    'custom_proposal_criticality': customProposalCriticality?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'url': url,
    'max_dissolve_delay_seconds': maxDissolveDelaySeconds,
    'max_dissolve_delay_bonus_percentage': maxDissolveDelayBonusPercentage,
    'nns_proposal_id': nnsProposalId,
    'neurons_fund_participation': neuronsFundParticipation,
    'min_participant_icp_e8s': minParticipantIcpE8s,
    'neuron_basket_construction_parameters':
        neuronBasketConstructionParameters?.toJson(),
    'fallback_controller_principal_ids': fallbackControllerPrincipalIds,
    'token_symbol': tokenSymbol,
    'final_reward_rate_basis_points': finalRewardRateBasisPoints,
    'max_icp_e8s': maxIcpE8s,
    'neuron_minimum_stake_e8s': neuronMinimumStakeE8s,
    'confirmation_text': confirmationText,
    'logo': logo,
    'name': name,
    'swap_start_timestamp_seconds': swapStartTimestampSeconds,
    'swap_due_timestamp_seconds': swapDueTimestampSeconds,
    'initial_voting_period_seconds': initialVotingPeriodSeconds,
    'neuron_minimum_dissolve_delay_to_vote_seconds':
        neuronMinimumDissolveDelayToVoteSeconds,
    'description': description,
    'max_neuron_age_seconds_for_age_bonus': maxNeuronAgeSecondsForAgeBonus,
    'min_participants': minParticipants,
    'initial_reward_rate_basis_points': initialRewardRateBasisPoints,
    'wait_for_quiet_deadline_increase_seconds':
        waitForQuietDeadlineIncreaseSeconds,
    'transaction_fee_e8s': transactionFeeE8s,
    'dapp_canisters': dappCanisters?.toJson(),
    'neurons_fund_participation_constraints':
        neuronsFundParticipationConstraints?.toJson(),
    'max_age_bonus_percentage': maxAgeBonusPercentage,
    'initial_token_distribution': initialTokenDistribution?.toJson(),
    'reward_rate_transition_duration_seconds':
        rewardRateTransitionDurationSeconds,
    'token_logo': tokenLogo,
    'token_name': tokenName,
    'max_participant_icp_e8s': maxParticipantIcpE8s,
    'min_direct_participation_icp_e8s': minDirectParticipationIcpE8s,
    'proposal_reject_cost_e8s': proposalRejectCostE8s,
    'restricted_countries': restrictedCountries?.toJson(),
    'min_icp_e8s': minIcpE8s,
    'max_direct_participation_icp_e8s': maxDirectParticipationIcpE8s,
    'custom_proposal_criticality': customProposalCriticality?.toJson(),
  };

  factory NnsWasmSnsInitPayload.fromCandid(Map<String, dynamic> json) {
    return NnsWasmSnsInitPayload(
      url: json.valueAsString<String?>('url'),
      maxDissolveDelaySeconds: json.valueAsBigInt<BigInt?>(
        'max_dissolve_delay_seconds',
      ),
      maxDissolveDelayBonusPercentage: json.valueAsBigInt<BigInt?>(
        'max_dissolve_delay_bonus_percentage',
      ),
      nnsProposalId: json.valueAsBigInt<BigInt?>('nns_proposal_id'),
      neuronsFundParticipation: json.valueAsBool<bool?>(
        'neurons_fund_participation',
      ),
      minParticipantIcpE8s: json.valueAsBigInt<BigInt?>(
        'min_participant_icp_e8s',
      ),
      neuronBasketConstructionParameters: json
          .valueTo<NnsWasmNeuronBasketConstructionParameters?, Map>(
            key: 'neuron_basket_construction_parameters',
            parse:
                (e) => NnsWasmNeuronBasketConstructionParameters.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      fallbackControllerPrincipalIds: json.valueTo<List<String>, List>(
        key: 'fallback_controller_principal_ids',
        parse:
            (e) =>
                e
                    .map<String>((x) => JsonParser.valueAsString<String>(x))
                    .toList(),
      ),
      tokenSymbol: json.valueAsString<String?>('token_symbol'),
      finalRewardRateBasisPoints: json.valueAsBigInt<BigInt?>(
        'final_reward_rate_basis_points',
      ),
      maxIcpE8s: json.valueAsBigInt<BigInt?>('max_icp_e8s'),
      neuronMinimumStakeE8s: json.valueAsBigInt<BigInt?>(
        'neuron_minimum_stake_e8s',
      ),
      confirmationText: json.valueAsString<String?>('confirmation_text'),
      logo: json.valueAsString<String?>('logo'),
      name: json.valueAsString<String?>('name'),
      swapStartTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'swap_start_timestamp_seconds',
      ),
      swapDueTimestampSeconds: json.valueAsBigInt<BigInt?>(
        'swap_due_timestamp_seconds',
      ),
      initialVotingPeriodSeconds: json.valueAsBigInt<BigInt?>(
        'initial_voting_period_seconds',
      ),
      neuronMinimumDissolveDelayToVoteSeconds: json.valueAsBigInt<BigInt?>(
        'neuron_minimum_dissolve_delay_to_vote_seconds',
      ),
      description: json.valueAsString<String?>('description'),
      maxNeuronAgeSecondsForAgeBonus: json.valueAsBigInt<BigInt?>(
        'max_neuron_age_seconds_for_age_bonus',
      ),
      minParticipants: json.valueAsBigInt<BigInt?>('min_participants'),
      initialRewardRateBasisPoints: json.valueAsBigInt<BigInt?>(
        'initial_reward_rate_basis_points',
      ),
      waitForQuietDeadlineIncreaseSeconds: json.valueAsBigInt<BigInt?>(
        'wait_for_quiet_deadline_increase_seconds',
      ),
      transactionFeeE8s: json.valueAsBigInt<BigInt?>('transaction_fee_e8s'),
      dappCanisters: json.valueTo<NnsWasmDappCanisters?, Map>(
        key: 'dapp_canisters',
        parse:
            (e) => NnsWasmDappCanisters.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      neuronsFundParticipationConstraints: json
          .valueTo<NnsWasmNeuronsFundParticipationConstraints?, Map>(
            key: 'neurons_fund_participation_constraints',
            parse:
                (e) => NnsWasmNeuronsFundParticipationConstraints.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      maxAgeBonusPercentage: json.valueAsBigInt<BigInt?>(
        'max_age_bonus_percentage',
      ),
      initialTokenDistribution: json
          .valueTo<NnsWasmInitialTokenDistribution?, Map>(
            key: 'initial_token_distribution',
            parse:
                (e) => NnsWasmInitialTokenDistribution.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
      rewardRateTransitionDurationSeconds: json.valueAsBigInt<BigInt?>(
        'reward_rate_transition_duration_seconds',
      ),
      tokenLogo: json.valueAsString<String?>('token_logo'),
      tokenName: json.valueAsString<String?>('token_name'),
      maxParticipantIcpE8s: json.valueAsBigInt<BigInt?>(
        'max_participant_icp_e8s',
      ),
      minDirectParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'min_direct_participation_icp_e8s',
      ),
      proposalRejectCostE8s: json.valueAsBigInt<BigInt?>(
        'proposal_reject_cost_e8s',
      ),
      restrictedCountries: json.valueTo<NnsWasmCountries?, Map>(
        key: 'restricted_countries',
        parse:
            (e) => NnsWasmCountries.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      minIcpE8s: json.valueAsBigInt<BigInt?>('min_icp_e8s'),
      maxDirectParticipationIcpE8s: json.valueAsBigInt<BigInt?>(
        'max_direct_participation_icp_e8s',
      ),
      customProposalCriticality: json
          .valueTo<NnsWasmCustomProposalCriticality?, Map>(
            key: 'custom_proposal_criticality',
            parse:
                (e) => NnsWasmCustomProposalCriticality.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsWasmSnsInitPayload.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmSnsInitPayload.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CustomProposalCriticality`.
final class NnsWasmCustomProposalCriticality with CandidSerializable {
  final List<BigInt> additionalCriticalNativeActionIds;

  const NnsWasmCustomProposalCriticality({
    required this.additionalCriticalNativeActionIds,
  });

  static CType get ctype => CType.record([
    Field(
      Label.named('additional_critical_native_action_ids'),
      CType.vec(CType.nat64),
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

  factory NnsWasmCustomProposalCriticality.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmCustomProposalCriticality(
      additionalCriticalNativeActionIds: json.valueTo<List<BigInt>, List>(
        key: 'additional_critical_native_action_ids',
        parse:
            (e) =>
                e
                    .map<BigInt>((x) => JsonParser.valueAsBigInt<BigInt>(x))
                    .toList(),
      ),
    );
  }

  factory NnsWasmCustomProposalCriticality.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmCustomProposalCriticality.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SnsUpgrade`.
final class NnsWasmSnsUpgrade with CandidSerializable {
  final NnsWasmSnsVersion? nextVersion;
  final NnsWasmSnsVersion? currentVersion;

  const NnsWasmSnsUpgrade({this.nextVersion, this.currentVersion});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('next_version'),
      () => CType.opt(NnsWasmSnsVersion.ctype),
    ),
    LazyField(
      Label.named('current_version'),
      () => CType.opt(NnsWasmSnsVersion.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'next_version': nextVersion?.candidValue,
    'current_version': currentVersion?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'next_version': nextVersion?.toJson(),
    'current_version': currentVersion?.toJson(),
  };

  factory NnsWasmSnsUpgrade.fromCandid(Map<String, dynamic> json) {
    return NnsWasmSnsUpgrade(
      nextVersion: json.valueTo<NnsWasmSnsVersion?, Map>(
        key: 'next_version',
        parse:
            (e) => NnsWasmSnsVersion.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      currentVersion: json.valueTo<NnsWasmSnsVersion?, Map>(
        key: 'current_version',
        parse:
            (e) => NnsWasmSnsVersion.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmSnsUpgrade.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmSnsUpgrade.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SnsVersion`.
final class NnsWasmSnsVersion with CandidSerializable {
  final List<int> archiveWasmHash;
  final List<int> rootWasmHash;
  final List<int> swapWasmHash;
  final List<int> ledgerWasmHash;
  final List<int> governanceWasmHash;
  final List<int> indexWasmHash;

  const NnsWasmSnsVersion({
    required this.archiveWasmHash,
    required this.rootWasmHash,
    required this.swapWasmHash,
    required this.ledgerWasmHash,
    required this.governanceWasmHash,
    required this.indexWasmHash,
  });

  static CType get ctype => CType.record([
    Field(Label.named('archive_wasm_hash'), CType.vec(CType.nat8)),
    Field(Label.named('root_wasm_hash'), CType.vec(CType.nat8)),
    Field(Label.named('swap_wasm_hash'), CType.vec(CType.nat8)),
    Field(Label.named('ledger_wasm_hash'), CType.vec(CType.nat8)),
    Field(Label.named('governance_wasm_hash'), CType.vec(CType.nat8)),
    Field(Label.named('index_wasm_hash'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'archive_wasm_hash': archiveWasmHash,
    'root_wasm_hash': rootWasmHash,
    'swap_wasm_hash': swapWasmHash,
    'ledger_wasm_hash': ledgerWasmHash,
    'governance_wasm_hash': governanceWasmHash,
    'index_wasm_hash': indexWasmHash,
  };

  Map<String, dynamic> toJson() => {
    'archive_wasm_hash': archiveWasmHash,
    'root_wasm_hash': rootWasmHash,
    'swap_wasm_hash': swapWasmHash,
    'ledger_wasm_hash': ledgerWasmHash,
    'governance_wasm_hash': governanceWasmHash,
    'index_wasm_hash': indexWasmHash,
  };

  factory NnsWasmSnsVersion.fromCandid(Map<String, dynamic> json) {
    return NnsWasmSnsVersion(
      archiveWasmHash: json.valueAsBytes<List<int>>(
        'archive_wasm_hash',
        encoding: StringEncoding.base64,
      ),
      rootWasmHash: json.valueAsBytes<List<int>>(
        'root_wasm_hash',
        encoding: StringEncoding.base64,
      ),
      swapWasmHash: json.valueAsBytes<List<int>>(
        'swap_wasm_hash',
        encoding: StringEncoding.base64,
      ),
      ledgerWasmHash: json.valueAsBytes<List<int>>(
        'ledger_wasm_hash',
        encoding: StringEncoding.base64,
      ),
      governanceWasmHash: json.valueAsBytes<List<int>>(
        'governance_wasm_hash',
        encoding: StringEncoding.base64,
      ),
      indexWasmHash: json.valueAsBytes<List<int>>(
        'index_wasm_hash',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory NnsWasmSnsVersion.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmSnsVersion.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SnsWasm`.
final class NnsWasmSnsWasm with CandidSerializable {
  final List<int> wasm;
  final BigInt? proposalId;
  final int canisterType;

  const NnsWasmSnsWasm({
    required this.wasm,
    this.proposalId,
    required this.canisterType,
  });

  static CType get ctype => CType.record([
    Field(Label.named('wasm'), CType.vec(CType.nat8)),
    Field(Label.named('proposal_id'), CType.opt(CType.nat64)),
    Field(Label.named('canister_type'), CType.int32),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'wasm': wasm,
    'proposal_id': proposalId,
    'canister_type': canisterType,
  };

  Map<String, dynamic> toJson() => {
    'wasm': wasm,
    'proposal_id': proposalId,
    'canister_type': canisterType,
  };

  factory NnsWasmSnsWasm.fromCandid(Map<String, dynamic> json) {
    return NnsWasmSnsWasm(
      wasm: json.valueAsBytes<List<int>>(
        'wasm',
        encoding: StringEncoding.base64,
      ),
      proposalId: json.valueAsBigInt<BigInt?>('proposal_id'),
      canisterType: json.valueAsInt<int>('canister_type'),
    );
  }

  factory NnsWasmSnsWasm.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmSnsWasm.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SnsWasmCanisterInitPayload`.
final class NnsWasmSnsWasmCanisterInitPayload with CandidSerializable {
  final List<IcpPrincipalAddress> allowedPrincipals;
  final bool accessControlsEnabled;
  final List<IcpPrincipalAddress> snsSubnetIds;

  const NnsWasmSnsWasmCanisterInitPayload({
    required this.allowedPrincipals,
    required this.accessControlsEnabled,
    required this.snsSubnetIds,
  });

  static CType get ctype => CType.record([
    Field(Label.named('allowed_principals'), CType.vec(CType.principal)),
    Field(Label.named('access_controls_enabled'), CType.bool_),
    Field(Label.named('sns_subnet_ids'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'allowed_principals': allowedPrincipals,
    'access_controls_enabled': accessControlsEnabled,
    'sns_subnet_ids': snsSubnetIds,
  };

  Map<String, dynamic> toJson() => {
    'allowed_principals': allowedPrincipals.map((el) => el.address).toList(),
    'access_controls_enabled': accessControlsEnabled,
    'sns_subnet_ids': snsSubnetIds.map((el) => el.address).toList(),
  };

  factory NnsWasmSnsWasmCanisterInitPayload.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmSnsWasmCanisterInitPayload(
      allowedPrincipals: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'allowed_principals',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      accessControlsEnabled: json.valueAsBool<bool>('access_controls_enabled'),
      snsSubnetIds: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'sns_subnet_ids',
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

  factory NnsWasmSnsWasmCanisterInitPayload.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmSnsWasmCanisterInitPayload.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SnsWasmError`.
final class NnsWasmSnsWasmError with CandidSerializable {
  final String message;

  const NnsWasmSnsWasmError({required this.message});

  static CType get ctype =>
      CType.record([Field(Label.named('message'), CType.text)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'message': message};

  Map<String, dynamic> toJson() => {'message': message};

  factory NnsWasmSnsWasmError.fromCandid(Map<String, dynamic> json) {
    return NnsWasmSnsWasmError(message: json.valueAsString<String>('message'));
  }

  factory NnsWasmSnsWasmError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmSnsWasmError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SwapDistribution`.
final class NnsWasmSwapDistribution with CandidSerializable {
  final BigInt totalE8s;
  final BigInt initialSwapAmountE8s;

  const NnsWasmSwapDistribution({
    required this.totalE8s,
    required this.initialSwapAmountE8s,
  });

  static CType get ctype => CType.record([
    Field(Label.named('total_e8s'), CType.nat64),
    Field(Label.named('initial_swap_amount_e8s'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'total_e8s': totalE8s,
    'initial_swap_amount_e8s': initialSwapAmountE8s,
  };

  Map<String, dynamic> toJson() => {
    'total_e8s': totalE8s,
    'initial_swap_amount_e8s': initialSwapAmountE8s,
  };

  factory NnsWasmSwapDistribution.fromCandid(Map<String, dynamic> json) {
    return NnsWasmSwapDistribution(
      totalE8s: json.valueAsBigInt<BigInt>('total_e8s'),
      initialSwapAmountE8s: json.valueAsBigInt<BigInt>(
        'initial_swap_amount_e8s',
      ),
    );
  }

  factory NnsWasmSwapDistribution.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmSwapDistribution.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TreasuryDistribution`.
final class NnsWasmTreasuryDistribution with CandidSerializable {
  final BigInt totalE8s;

  const NnsWasmTreasuryDistribution({required this.totalE8s});

  static CType get ctype =>
      CType.record([Field(Label.named('total_e8s'), CType.nat64)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'total_e8s': totalE8s};

  Map<String, dynamic> toJson() => {'total_e8s': totalE8s};

  factory NnsWasmTreasuryDistribution.fromCandid(Map<String, dynamic> json) {
    return NnsWasmTreasuryDistribution(
      totalE8s: json.valueAsBigInt<BigInt>('total_e8s'),
    );
  }

  factory NnsWasmTreasuryDistribution.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmTreasuryDistribution.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `UpdateAllowedPrincipalsRequest`.
final class NnsWasmUpdateAllowedPrincipalsRequest with CandidSerializable {
  final List<IcpPrincipalAddress> addedPrincipals;
  final List<IcpPrincipalAddress> removedPrincipals;

  const NnsWasmUpdateAllowedPrincipalsRequest({
    required this.addedPrincipals,
    required this.removedPrincipals,
  });

  static CType get ctype => CType.record([
    Field(Label.named('added_principals'), CType.vec(CType.principal)),
    Field(Label.named('removed_principals'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'added_principals': addedPrincipals,
    'removed_principals': removedPrincipals,
  };

  Map<String, dynamic> toJson() => {
    'added_principals': addedPrincipals.map((el) => el.address).toList(),
    'removed_principals': removedPrincipals.map((el) => el.address).toList(),
  };

  factory NnsWasmUpdateAllowedPrincipalsRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmUpdateAllowedPrincipalsRequest(
      addedPrincipals: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'added_principals',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      removedPrincipals: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'removed_principals',
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

  factory NnsWasmUpdateAllowedPrincipalsRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmUpdateAllowedPrincipalsRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `UpdateAllowedPrincipalsResponse`.
final class NnsWasmUpdateAllowedPrincipalsResponse with CandidSerializable {
  final NnsWasmUpdateAllowedPrincipalsResult? updateAllowedPrincipalsResult;

  const NnsWasmUpdateAllowedPrincipalsResponse({
    this.updateAllowedPrincipalsResult,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('update_allowed_principals_result'),
      () => CType.opt(NnsWasmUpdateAllowedPrincipalsResult.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'update_allowed_principals_result':
        updateAllowedPrincipalsResult?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'update_allowed_principals_result': updateAllowedPrincipalsResult?.toJson(),
  };

  factory NnsWasmUpdateAllowedPrincipalsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmUpdateAllowedPrincipalsResponse(
      updateAllowedPrincipalsResult: json
          .valueTo<NnsWasmUpdateAllowedPrincipalsResult?, Map>(
            key: 'update_allowed_principals_result',
            parse:
                (e) => NnsWasmUpdateAllowedPrincipalsResult.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
          ),
    );
  }

  factory NnsWasmUpdateAllowedPrincipalsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmUpdateAllowedPrincipalsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `UpdateAllowedPrincipalsResult`.
sealed class NnsWasmUpdateAllowedPrincipalsResult with CandidSerializable {
  const NnsWasmUpdateAllowedPrincipalsResult();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Error'), () => NnsWasmSnsWasmError.ctype),
    LazyField(
      Label.named('AllowedPrincipals'),
      () => NnsWasmGetAllowedPrincipalsResponse.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory NnsWasmUpdateAllowedPrincipalsResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Error')) {
      return NnsWasmUpdateAllowedPrincipalsResultError(
        json.valueTo<NnsWasmSnsWasmError, Map>(
          key: 'Error',
          parse:
              (e) => NnsWasmSnsWasmError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('AllowedPrincipals')) {
      return NnsWasmUpdateAllowedPrincipalsResultAllowedPrincipals(
        json.valueTo<NnsWasmGetAllowedPrincipalsResponse, Map>(
          key: 'AllowedPrincipals',
          parse:
              (e) => NnsWasmGetAllowedPrincipalsResponse.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'NnsWasmUpdateAllowedPrincipalsResult.fromCandid',
      reason: 'Unknown NnsWasmUpdateAllowedPrincipalsResult arm',
    );
  }

  factory NnsWasmUpdateAllowedPrincipalsResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmUpdateAllowedPrincipalsResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `UpdateAllowedPrincipalsResult.Error`.
final class NnsWasmUpdateAllowedPrincipalsResultError
    extends NnsWasmUpdateAllowedPrincipalsResult {
  final NnsWasmSnsWasmError value;
  const NnsWasmUpdateAllowedPrincipalsResultError(this.value);

  @override
  CType get candidType => NnsWasmUpdateAllowedPrincipalsResult.ctype;

  @override
  dynamic get candidValue => Variant('Error', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Error': value.toJson()};
}

/// Variant arm `UpdateAllowedPrincipalsResult.AllowedPrincipals`.
final class NnsWasmUpdateAllowedPrincipalsResultAllowedPrincipals
    extends NnsWasmUpdateAllowedPrincipalsResult {
  final NnsWasmGetAllowedPrincipalsResponse value;
  const NnsWasmUpdateAllowedPrincipalsResultAllowedPrincipals(this.value);

  @override
  CType get candidType => NnsWasmUpdateAllowedPrincipalsResult.ctype;

  @override
  dynamic get candidValue => Variant('AllowedPrincipals', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'AllowedPrincipals': value.toJson()};
}

/// Candid record `UpdateSnsSubnetListRequest`.
final class NnsWasmUpdateSnsSubnetListRequest with CandidSerializable {
  final List<IcpPrincipalAddress> snsSubnetIdsToAdd;
  final List<IcpPrincipalAddress> snsSubnetIdsToRemove;

  const NnsWasmUpdateSnsSubnetListRequest({
    required this.snsSubnetIdsToAdd,
    required this.snsSubnetIdsToRemove,
  });

  static CType get ctype => CType.record([
    Field(Label.named('sns_subnet_ids_to_add'), CType.vec(CType.principal)),
    Field(Label.named('sns_subnet_ids_to_remove'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'sns_subnet_ids_to_add': snsSubnetIdsToAdd,
    'sns_subnet_ids_to_remove': snsSubnetIdsToRemove,
  };

  Map<String, dynamic> toJson() => {
    'sns_subnet_ids_to_add': snsSubnetIdsToAdd.map((el) => el.address).toList(),
    'sns_subnet_ids_to_remove':
        snsSubnetIdsToRemove.map((el) => el.address).toList(),
  };

  factory NnsWasmUpdateSnsSubnetListRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmUpdateSnsSubnetListRequest(
      snsSubnetIdsToAdd: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'sns_subnet_ids_to_add',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      snsSubnetIdsToRemove: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'sns_subnet_ids_to_remove',
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

  factory NnsWasmUpdateSnsSubnetListRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmUpdateSnsSubnetListRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `UpdateSnsSubnetListResponse`.
final class NnsWasmUpdateSnsSubnetListResponse with CandidSerializable {
  final NnsWasmSnsWasmError? error;

  const NnsWasmUpdateSnsSubnetListResponse({this.error});

  static CType get ctype => CType.record([
    LazyField(Label.named('error'), () => CType.opt(NnsWasmSnsWasmError.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'error': error?.candidValue};

  Map<String, dynamic> toJson() => {'error': error?.toJson()};

  factory NnsWasmUpdateSnsSubnetListResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return NnsWasmUpdateSnsSubnetListResponse(
      error: json.valueTo<NnsWasmSnsWasmError?, Map>(
        key: 'error',
        parse:
            (e) => NnsWasmSnsWasmError.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory NnsWasmUpdateSnsSubnetListResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return NnsWasmUpdateSnsSubnetListResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

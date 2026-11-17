// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `NnsWasm`.
abstract class NnsWasmQueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const NnsWasmQueryMessage();
}

class NnsWasmQueryGetAllowedPrincipals
    extends NnsWasmQueryMessage<NnsWasmGetAllowedPrincipalsResponse> {
  final NnsWasmGetAllowedPrincipalsArg args;
  const NnsWasmQueryGetAllowedPrincipals(this.args);

  @override
  String get methodName => 'get_allowed_principals';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmGetAllowedPrincipalsResponse onResponse(List<int> bytes) {
    return NnsWasmGetAllowedPrincipalsResponse.fromBytes(bytes);
  }
}

class NnsWasmQueryGetDeployedSnsByProposalId
    extends NnsWasmQueryMessage<NnsWasmGetDeployedSnsByProposalIdResponse> {
  final NnsWasmGetDeployedSnsByProposalIdRequest args;
  const NnsWasmQueryGetDeployedSnsByProposalId(this.args);

  @override
  String get methodName => 'get_deployed_sns_by_proposal_id';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmGetDeployedSnsByProposalIdResponse onResponse(List<int> bytes) {
    return NnsWasmGetDeployedSnsByProposalIdResponse.fromBytes(bytes);
  }
}

class NnsWasmQueryGetLatestSnsVersionPretty
    extends
        NnsWasmQueryMessage<List<NnsWasmGetLatestSnsVersionPrettyResponse>> {
  final Null args;
  const NnsWasmQueryGetLatestSnsVersionPretty(this.args);

  @override
  String get methodName => 'get_latest_sns_version_pretty';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.null_, args);
  }

  @override
  List<NnsWasmGetLatestSnsVersionPrettyResponse> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(NnsWasmGetLatestSnsVersionPrettyResponse.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(decode)
        .map((e) => NnsWasmGetLatestSnsVersionPrettyResponse.fromCandid(e))
        .toList();
  }
}

class NnsWasmQueryGetNextSnsVersion
    extends NnsWasmQueryMessage<NnsWasmGetNextSnsVersionResponse> {
  final NnsWasmGetNextSnsVersionRequest args;
  const NnsWasmQueryGetNextSnsVersion(this.args);

  @override
  String get methodName => 'get_next_sns_version';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmGetNextSnsVersionResponse onResponse(List<int> bytes) {
    return NnsWasmGetNextSnsVersionResponse.fromBytes(bytes);
  }
}

class NnsWasmQueryGetProposalIdThatAddedWasm
    extends NnsWasmQueryMessage<NnsWasmGetProposalIdThatAddedWasmResponse> {
  final NnsWasmGetProposalIdThatAddedWasmRequest args;
  const NnsWasmQueryGetProposalIdThatAddedWasm(this.args);

  @override
  String get methodName => 'get_proposal_id_that_added_wasm';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmGetProposalIdThatAddedWasmResponse onResponse(List<int> bytes) {
    return NnsWasmGetProposalIdThatAddedWasmResponse.fromBytes(bytes);
  }
}

class NnsWasmQueryGetSnsSubnetIds
    extends NnsWasmQueryMessage<NnsWasmGetSnsSubnetIdsResponse> {
  final NnsWasmGetAllowedPrincipalsArg args;
  const NnsWasmQueryGetSnsSubnetIds(this.args);

  @override
  String get methodName => 'get_sns_subnet_ids';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmGetSnsSubnetIdsResponse onResponse(List<int> bytes) {
    return NnsWasmGetSnsSubnetIdsResponse.fromBytes(bytes);
  }
}

class NnsWasmQueryGetWasm extends NnsWasmQueryMessage<NnsWasmGetWasmResponse> {
  final NnsWasmGetWasmRequest args;
  const NnsWasmQueryGetWasm(this.args);

  @override
  String get methodName => 'get_wasm';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmGetWasmResponse onResponse(List<int> bytes) {
    return NnsWasmGetWasmResponse.fromBytes(bytes);
  }
}

class NnsWasmQueryGetWasmMetadata
    extends NnsWasmQueryMessage<NnsWasmGetWasmMetadataResponse> {
  final NnsWasmGetWasmMetadataRequest args;
  const NnsWasmQueryGetWasmMetadata(this.args);

  @override
  String get methodName => 'get_wasm_metadata';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmGetWasmMetadataResponse onResponse(List<int> bytes) {
    return NnsWasmGetWasmMetadataResponse.fromBytes(bytes);
  }
}

class NnsWasmQueryListDeployedSnses
    extends NnsWasmQueryMessage<NnsWasmListDeployedSnsesResponse> {
  final NnsWasmGetAllowedPrincipalsArg args;
  const NnsWasmQueryListDeployedSnses(this.args);

  @override
  String get methodName => 'list_deployed_snses';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmListDeployedSnsesResponse onResponse(List<int> bytes) {
    return NnsWasmListDeployedSnsesResponse.fromBytes(bytes);
  }
}

class NnsWasmQueryListUpgradeSteps
    extends NnsWasmQueryMessage<NnsWasmListUpgradeStepsResponse> {
  final NnsWasmListUpgradeStepsRequest args;
  const NnsWasmQueryListUpgradeSteps(this.args);

  @override
  String get methodName => 'list_upgrade_steps';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmListUpgradeStepsResponse onResponse(List<int> bytes) {
    return NnsWasmListUpgradeStepsResponse.fromBytes(bytes);
  }
}

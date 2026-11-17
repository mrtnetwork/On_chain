// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'types.dart';

/// Update messages for service `NnsWasm`.
abstract class NnsWasmUpdateMessage<RESULT> extends IICPUpdateMessage<RESULT> {
  const NnsWasmUpdateMessage();
}

class NnsWasmUpdateAddWasm
    extends NnsWasmUpdateMessage<NnsWasmAddWasmResponse> {
  final NnsWasmAddWasmRequest args;
  const NnsWasmUpdateAddWasm(this.args);

  @override
  String get methodName => 'add_wasm';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmAddWasmResponse onResponse(List<int> bytes) {
    return NnsWasmAddWasmResponse.fromBytes(bytes);
  }
}

class NnsWasmUpdateDeployNewSns
    extends NnsWasmUpdateMessage<NnsWasmDeployNewSnsResponse> {
  final NnsWasmDeployNewSnsRequest args;
  const NnsWasmUpdateDeployNewSns(this.args);

  @override
  String get methodName => 'deploy_new_sns';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmDeployNewSnsResponse onResponse(List<int> bytes) {
    return NnsWasmDeployNewSnsResponse.fromBytes(bytes);
  }
}

class NnsWasmUpdateInsertUpgradePathEntries
    extends NnsWasmUpdateMessage<NnsWasmInsertUpgradePathEntriesResponse> {
  final NnsWasmInsertUpgradePathEntriesRequest args;
  const NnsWasmUpdateInsertUpgradePathEntries(this.args);

  @override
  String get methodName => 'insert_upgrade_path_entries';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmInsertUpgradePathEntriesResponse onResponse(List<int> bytes) {
    return NnsWasmInsertUpgradePathEntriesResponse.fromBytes(bytes);
  }
}

class NnsWasmUpdateUpdateAllowedPrincipals
    extends NnsWasmUpdateMessage<NnsWasmUpdateAllowedPrincipalsResponse> {
  final NnsWasmUpdateAllowedPrincipalsRequest args;
  const NnsWasmUpdateUpdateAllowedPrincipals(this.args);

  @override
  String get methodName => 'update_allowed_principals';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmUpdateAllowedPrincipalsResponse onResponse(List<int> bytes) {
    return NnsWasmUpdateAllowedPrincipalsResponse.fromBytes(bytes);
  }
}

class NnsWasmUpdateUpdateSnsSubnetList
    extends NnsWasmUpdateMessage<NnsWasmUpdateSnsSubnetListResponse> {
  final NnsWasmUpdateSnsSubnetListRequest args;
  const NnsWasmUpdateUpdateSnsSubnetList(this.args);

  @override
  String get methodName => 'update_sns_subnet_list';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsWasmUpdateSnsSubnetListResponse onResponse(List<int> bytes) {
    return NnsWasmUpdateSnsSubnetListResponse.fromBytes(bytes);
  }
}

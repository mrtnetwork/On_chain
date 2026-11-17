// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'types.dart';

/// Update messages for service `NnsCyclesMinting`.
abstract class NnsCyclesMintingUpdateMessage<RESULT>
    extends IICPUpdateMessage<RESULT> {
  const NnsCyclesMintingUpdateMessage();
}

class NnsCyclesMintingUpdateNotifyTopUp
    extends NnsCyclesMintingUpdateMessage<NnsCyclesMintingNotifyTopUpResult> {
  final NnsCyclesMintingNotifyTopUpArg args;
  const NnsCyclesMintingUpdateNotifyTopUp(this.args);

  @override
  String get methodName => 'notify_top_up';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsCyclesMintingNotifyTopUpResult onResponse(List<int> bytes) {
    return NnsCyclesMintingNotifyTopUpResult.fromBytes(bytes);
  }
}

class NnsCyclesMintingUpdateCreateCanister
    extends
        NnsCyclesMintingUpdateMessage<NnsCyclesMintingCreateCanisterResult> {
  final NnsCyclesMintingCreateCanisterArg args;
  const NnsCyclesMintingUpdateCreateCanister(this.args);

  @override
  String get methodName => 'create_canister';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsCyclesMintingCreateCanisterResult onResponse(List<int> bytes) {
    return NnsCyclesMintingCreateCanisterResult.fromBytes(bytes);
  }
}

class NnsCyclesMintingUpdateNotifyCreateCanister
    extends
        NnsCyclesMintingUpdateMessage<
          NnsCyclesMintingNotifyCreateCanisterResult
        > {
  final NnsCyclesMintingNotifyCreateCanisterArg args;
  const NnsCyclesMintingUpdateNotifyCreateCanister(this.args);

  @override
  String get methodName => 'notify_create_canister';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsCyclesMintingNotifyCreateCanisterResult onResponse(List<int> bytes) {
    return NnsCyclesMintingNotifyCreateCanisterResult.fromBytes(bytes);
  }
}

class NnsCyclesMintingUpdateNotifyMintCycles
    extends
        NnsCyclesMintingUpdateMessage<NnsCyclesMintingNotifyMintCyclesResult> {
  final NnsCyclesMintingNotifyMintCyclesArg args;
  const NnsCyclesMintingUpdateNotifyMintCycles(this.args);

  @override
  String get methodName => 'notify_mint_cycles';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsCyclesMintingNotifyMintCyclesResult onResponse(List<int> bytes) {
    return NnsCyclesMintingNotifyMintCyclesResult.fromBytes(bytes);
  }
}

class NnsCyclesMintingUpdateSetAuthorizedSubnetworkList
    extends NnsCyclesMintingUpdateMessage<Null> {
  final NnsCyclesMintingSetAuthorizedSubnetworkListArgs args;
  const NnsCyclesMintingUpdateSetAuthorizedSubnetworkList(this.args);

  @override
  String get methodName => 'set_authorized_subnetwork_list';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class NnsCyclesMintingUpdateUpdateSubnetType
    extends NnsCyclesMintingUpdateMessage<Null> {
  final NnsCyclesMintingUpdateSubnetTypeArgs args;
  const NnsCyclesMintingUpdateUpdateSubnetType(this.args);

  @override
  String get methodName => 'update_subnet_type';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class NnsCyclesMintingUpdateChangeSubnetTypeAssignment
    extends NnsCyclesMintingUpdateMessage<Null> {
  final NnsCyclesMintingChangeSubnetTypeAssignmentArgs args;
  const NnsCyclesMintingUpdateChangeSubnetTypeAssignment(this.args);

  @override
  String get methodName => 'change_subnet_type_assignment';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

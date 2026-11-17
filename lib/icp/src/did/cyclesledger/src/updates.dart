// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'types.dart';

/// Update messages for service `CyclesLedger`.
abstract class CyclesLedgerUpdateMessage<RESULT>
    extends IICPUpdateMessage<RESULT> {
  const CyclesLedgerUpdateMessage();
}

class CyclesLedgerUpdateCreateCanister
    extends CyclesLedgerUpdateMessage<CyclesLedgerCreateCanisterResponse> {
  final CyclesLedgerCreateCanisterArgs args;
  const CyclesLedgerUpdateCreateCanister(this.args);

  @override
  String get methodName => 'create_canister';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerCreateCanisterResponse onResponse(List<int> bytes) {
    return CyclesLedgerCreateCanisterResponse.fromBytes(bytes);
  }
}

class CyclesLedgerUpdateCreateCanisterFrom
    extends CyclesLedgerUpdateMessage<CyclesLedgerCreateCanisterFromResponse> {
  final CyclesLedgerCreateCanisterFromArgs args;
  const CyclesLedgerUpdateCreateCanisterFrom(this.args);

  @override
  String get methodName => 'create_canister_from';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerCreateCanisterFromResponse onResponse(List<int> bytes) {
    return CyclesLedgerCreateCanisterFromResponse.fromBytes(bytes);
  }
}

class CyclesLedgerUpdateDeposit
    extends CyclesLedgerUpdateMessage<CyclesLedgerDepositResult> {
  final CyclesLedgerDepositArgs args;
  const CyclesLedgerUpdateDeposit(this.args);

  @override
  String get methodName => 'deposit';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerDepositResult onResponse(List<int> bytes) {
    return CyclesLedgerDepositResult.fromBytes(bytes);
  }
}

class CyclesLedgerUpdateIcrc1Transfer
    extends CyclesLedgerUpdateMessage<CyclesLedgerIcrc1TransferResponse> {
  final CyclesLedgerTransferArgs args;
  const CyclesLedgerUpdateIcrc1Transfer(this.args);

  @override
  String get methodName => 'icrc1_transfer';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerIcrc1TransferResponse onResponse(List<int> bytes) {
    return CyclesLedgerIcrc1TransferResponse.fromBytes(bytes);
  }
}

class CyclesLedgerUpdateIcrc2Approve
    extends CyclesLedgerUpdateMessage<CyclesLedgerIcrc2ApproveResponse> {
  final CyclesLedgerApproveArgs args;
  const CyclesLedgerUpdateIcrc2Approve(this.args);

  @override
  String get methodName => 'icrc2_approve';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerIcrc2ApproveResponse onResponse(List<int> bytes) {
    return CyclesLedgerIcrc2ApproveResponse.fromBytes(bytes);
  }
}

class CyclesLedgerUpdateIcrc2TransferFrom
    extends CyclesLedgerUpdateMessage<CyclesLedgerIcrc2TransferFromResponse> {
  final CyclesLedgerTransferFromArgs args;
  const CyclesLedgerUpdateIcrc2TransferFrom(this.args);

  @override
  String get methodName => 'icrc2_transfer_from';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerIcrc2TransferFromResponse onResponse(List<int> bytes) {
    return CyclesLedgerIcrc2TransferFromResponse.fromBytes(bytes);
  }
}

class CyclesLedgerUpdateWithdraw
    extends CyclesLedgerUpdateMessage<CyclesLedgerWithdrawResponse> {
  final CyclesLedgerWithdrawArgs args;
  const CyclesLedgerUpdateWithdraw(this.args);

  @override
  String get methodName => 'withdraw';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerWithdrawResponse onResponse(List<int> bytes) {
    return CyclesLedgerWithdrawResponse.fromBytes(bytes);
  }
}

class CyclesLedgerUpdateWithdrawFrom
    extends CyclesLedgerUpdateMessage<CyclesLedgerWithdrawFromResponse> {
  final CyclesLedgerWithdrawFromArgs args;
  const CyclesLedgerUpdateWithdrawFrom(this.args);

  @override
  String get methodName => 'withdraw_from';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerWithdrawFromResponse onResponse(List<int> bytes) {
    return CyclesLedgerWithdrawFromResponse.fromBytes(bytes);
  }
}

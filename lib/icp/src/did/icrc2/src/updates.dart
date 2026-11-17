// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'types.dart';

/// Update messages for service `ICRC2`.
abstract class ICRC2UpdateMessage<RESULT> extends IICPUpdateMessage<RESULT> {
  const ICRC2UpdateMessage();
}

class ICRC2UpdateIcrc2Approve
    extends ICRC2UpdateMessage<ICRC2Icrc2ApproveResponse> {
  final ICRC2ApproveArgs args;
  const ICRC2UpdateIcrc2Approve(this.args);

  @override
  String get methodName => 'icrc2_approve';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC2Icrc2ApproveResponse onResponse(List<int> bytes) {
    return ICRC2Icrc2ApproveResponse.fromBytes(bytes);
  }
}

class ICRC2UpdateIcrc2TransferFrom
    extends ICRC2UpdateMessage<ICRC2Icrc2TransferFromResponse> {
  final ICRC2TransferFromArgs args;
  const ICRC2UpdateIcrc2TransferFrom(this.args);

  @override
  String get methodName => 'icrc2_transfer_from';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC2Icrc2TransferFromResponse onResponse(List<int> bytes) {
    return ICRC2Icrc2TransferFromResponse.fromBytes(bytes);
  }
}

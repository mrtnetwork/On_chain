// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'types.dart';

/// Update messages for service `ICRC1`.
abstract class ICRC1UpdateMessage<RESULT> extends IICPUpdateMessage<RESULT> {
  const ICRC1UpdateMessage();
}

class ICRC1UpdateIcrc1Transfer
    extends ICRC1UpdateMessage<ICRC1Icrc1TransferResponse> {
  final ICRC1TransferArgs args;
  const ICRC1UpdateIcrc1Transfer(this.args);

  @override
  String get methodName => 'icrc1_transfer';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC1Icrc1TransferResponse onResponse(List<int> bytes) {
    return ICRC1Icrc1TransferResponse.fromBytes(bytes);
  }
}

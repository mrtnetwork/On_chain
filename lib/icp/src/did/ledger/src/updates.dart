// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Update messages for service `LEDGER`.
abstract class LEDGERUpdateMessage<RESULT> extends IICPUpdateMessage<RESULT> {
  const LEDGERUpdateMessage();
}

class LEDGERUpdateTransfer extends LEDGERUpdateMessage<LEDGERTransferResult> {
  final LEDGERTransferArgs args;
  const LEDGERUpdateTransfer(this.args);

  @override
  String get methodName => 'transfer';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERTransferResult onResponse(List<int> bytes) {
    return LEDGERTransferResult.fromBytes(bytes);
  }
}

class LEDGERUpdateSendDfx extends LEDGERUpdateMessage<LEDGERBlockIndex> {
  final LEDGERSendArgs args;
  const LEDGERUpdateSendDfx(this.args);

  @override
  String get methodName => 'send_dfx';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERBlockIndex onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat64) as LEDGERBlockIndex;
  }
}

class LEDGERUpdateIcrc1Transfer
    extends LEDGERUpdateMessage<LEDGERIcrc1TransferResult> {
  final LEDGERTransferArg args;
  const LEDGERUpdateIcrc1Transfer(this.args);

  @override
  String get methodName => 'icrc1_transfer';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERIcrc1TransferResult onResponse(List<int> bytes) {
    return LEDGERIcrc1TransferResult.fromBytes(bytes);
  }
}

class LEDGERUpdateIcrc2Approve
    extends LEDGERUpdateMessage<LEDGERApproveResult> {
  final LEDGERApproveArgs args;
  const LEDGERUpdateIcrc2Approve(this.args);

  @override
  String get methodName => 'icrc2_approve';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERApproveResult onResponse(List<int> bytes) {
    return LEDGERApproveResult.fromBytes(bytes);
  }
}

class LEDGERUpdateIcrc2TransferFrom
    extends LEDGERUpdateMessage<LEDGERTransferFromResult> {
  final LEDGERTransferFromArgs args;
  const LEDGERUpdateIcrc2TransferFrom(this.args);

  @override
  String get methodName => 'icrc2_transfer_from';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERTransferFromResult onResponse(List<int> bytes) {
    return LEDGERTransferFromResult.fromBytes(bytes);
  }
}

class LEDGERUpdateRemoveApproval
    extends LEDGERUpdateMessage<LEDGERApproveResult> {
  final LEDGERRemoveApprovalArgs args;
  const LEDGERUpdateRemoveApproval(this.args);

  @override
  String get methodName => 'remove_approval';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERApproveResult onResponse(List<int> bytes) {
    return LEDGERApproveResult.fromBytes(bytes);
  }
}

class LEDGERUpdateIcrc21CanisterCallConsentMessage
    extends LEDGERUpdateMessage<LEDGERIcrc21ConsentMessageResponse> {
  final LEDGERIcrc21ConsentMessageRequest args;
  const LEDGERUpdateIcrc21CanisterCallConsentMessage(this.args);

  @override
  String get methodName => 'icrc21_canister_call_consent_message';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERIcrc21ConsentMessageResponse onResponse(List<int> bytes) {
    return LEDGERIcrc21ConsentMessageResponse.fromBytes(bytes);
  }
}

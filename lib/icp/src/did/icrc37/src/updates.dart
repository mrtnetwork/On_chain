// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Update messages for service `ICRC37`.
abstract class ICRC37UpdateMessage<RESULT> extends IICPUpdateMessage<RESULT> {
  const ICRC37UpdateMessage();
}

class ICRC37UpdateIcrc37ApproveTokens
    extends ICRC37UpdateMessage<List<ICRC37ApproveTokenResult?>> {
  final List<ICRC37ApproveTokenArg> args;
  const ICRC37UpdateIcrc37ApproveTokens(this.args);

  @override
  String get methodName => 'icrc37_approve_tokens';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(
      CType.vec(ICRC37ApproveTokenArg.ctype),
      args,
    );
  }

  @override
  List<ICRC37ApproveTokenResult?> onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(
          bytes,
          CType.vec(CType.opt(ICRC37ApproveTokenResult.ctype)),
        )
        as List<ICRC37ApproveTokenResult?>;
  }
}

class ICRC37UpdateIcrc37ApproveCollection
    extends ICRC37UpdateMessage<List<ICRC37ApproveCollectionError?>> {
  final List<ICRC37ApproveCollectionArg> args;
  const ICRC37UpdateIcrc37ApproveCollection(this.args);

  @override
  String get methodName => 'icrc37_approve_collection';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(
      CType.vec(ICRC37ApproveCollectionArg.ctype),
      args,
    );
  }

  @override
  List<ICRC37ApproveCollectionError?> onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(
          bytes,
          CType.vec(CType.opt(ICRC37ApproveCollectionError.ctype)),
        )
        as List<ICRC37ApproveCollectionError?>;
  }
}

class ICRC37UpdateIcrc37RevokeTokenApprovals
    extends ICRC37UpdateMessage<List<ICRC37RevokeTokenApprovalResponse?>> {
  final List<ICRC37RevokeTokenApprovalArg> args;
  const ICRC37UpdateIcrc37RevokeTokenApprovals(this.args);

  @override
  String get methodName => 'icrc37_revoke_token_approvals';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(
      CType.vec(ICRC37RevokeTokenApprovalArg.ctype),
      args,
    );
  }

  @override
  List<ICRC37RevokeTokenApprovalResponse?> onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(
          bytes,
          CType.vec(CType.opt(ICRC37RevokeTokenApprovalResponse.ctype)),
        )
        as List<ICRC37RevokeTokenApprovalResponse?>;
  }
}

class ICRC37UpdateIcrc37RevokeCollectionApprovals
    extends ICRC37UpdateMessage<List<ICRC37RevokeCollectionApprovalResult?>> {
  final List<ICRC37RevokeCollectionApprovalArg> args;
  const ICRC37UpdateIcrc37RevokeCollectionApprovals(this.args);

  @override
  String get methodName => 'icrc37_revoke_collection_approvals';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(
      CType.vec(ICRC37RevokeCollectionApprovalArg.ctype),
      args,
    );
  }

  @override
  List<ICRC37RevokeCollectionApprovalResult?> onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(
          bytes,
          CType.vec(CType.opt(ICRC37RevokeCollectionApprovalResult.ctype)),
        )
        as List<ICRC37RevokeCollectionApprovalResult?>;
  }
}

class ICRC37UpdateIcrc37TransferFrom
    extends ICRC37UpdateMessage<List<ICRC37TransferFromResult?>> {
  final List<ICRC37TransferFromArg> args;
  const ICRC37UpdateIcrc37TransferFrom(this.args);

  @override
  String get methodName => 'icrc37_transfer_from';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(
      CType.vec(ICRC37TransferFromArg.ctype),
      args,
    );
  }

  @override
  List<ICRC37TransferFromResult?> onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(
          bytes,
          CType.vec(CType.opt(ICRC37TransferFromResult.ctype)),
        )
        as List<ICRC37TransferFromResult?>;
  }
}

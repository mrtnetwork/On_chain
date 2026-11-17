// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `ICRC37`.
abstract class ICRC37QueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const ICRC37QueryMessage();
}

class ICRC37QueryIcrc37MaxApprovalsPerTokenOrCollection
    extends ICRC37QueryMessage<BigInt?> {
  const ICRC37QueryIcrc37MaxApprovalsPerTokenOrCollection();

  @override
  String get methodName => 'icrc37_max_approvals_per_token_or_collection';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat)) as BigInt?;
  }
}

class ICRC37QueryIcrc37MaxRevokeApprovals extends ICRC37QueryMessage<BigInt?> {
  const ICRC37QueryIcrc37MaxRevokeApprovals();

  @override
  String get methodName => 'icrc37_max_revoke_approvals';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat)) as BigInt?;
  }
}

class ICRC37QueryIcrc37IsApproved extends ICRC37QueryMessage<List<bool>> {
  final List<ICRC37IsApprovedArg> args;
  const ICRC37QueryIcrc37IsApproved(this.args);

  @override
  String get methodName => 'icrc37_is_approved';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(
      CType.vec(ICRC37IsApprovedArg.ctype),
      args,
    );
  }

  @override
  List<bool> onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.vec(CType.bool_))
        as List<bool>;
  }
}

class ICRC37QueryIcrc37GetTokenApprovals
    extends ICRC37QueryMessage<List<ICRC37TokenApproval>> {
  final BigInt arg0;
  final ICRC37TokenApproval? arg1;
  final BigInt? arg2;
  const ICRC37QueryIcrc37GetTokenApprovals({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'icrc37_get_token_approvals';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat, CType.opt(ICRC37TokenApproval.ctype), CType.opt(CType.nat)],
      [arg0, arg1, arg2],
    );
  }

  @override
  List<ICRC37TokenApproval> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(ICRC37TokenApproval.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICRC37TokenApproval.fromCandid(e)).toList();
  }
}

class ICRC37QueryIcrc37GetCollectionApprovals
    extends ICRC37QueryMessage<List<ICRC37CollectionApproval>> {
  final ICRC37Account arg0;
  final ICRC37CollectionApproval? arg1;
  final BigInt? arg2;
  const ICRC37QueryIcrc37GetCollectionApprovals({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'icrc37_get_collection_approvals';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        ICRC37Account.ctype,
        CType.opt(ICRC37CollectionApprovalCandid.ctype),
        CType.opt(CType.nat),
      ],
      [arg0.candidValue, arg1, arg2],
    );
  }

  @override
  List<ICRC37CollectionApproval> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(ICRC37ApprovalInfo.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICRC37ApprovalInfo.fromCandid(e)).toList();
  }
}

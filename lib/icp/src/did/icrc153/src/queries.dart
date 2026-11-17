// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `ICRC153`.
abstract class ICRC153QueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const ICRC153QueryMessage();
}

class ICRC153QueryIcrc153IsFrozenAccount extends ICRC153QueryMessage<bool> {
  final ICRC153Account args;
  const ICRC153QueryIcrc153IsFrozenAccount(this.args);

  @override
  String get methodName => 'icrc153_is_frozen_account';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  bool onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.bool_) as bool;
  }
}

class ICRC153QueryIcrc153IsFrozenPrincipal extends ICRC153QueryMessage<bool> {
  final IcpPrincipalAddress args;
  const ICRC153QueryIcrc153IsFrozenPrincipal(this.args);

  @override
  String get methodName => 'icrc153_is_frozen_principal';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.principal, args);
  }

  @override
  bool onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.bool_) as bool;
  }
}

class ICRC153QueryIcrc153ListFrozenAccounts
    extends ICRC153QueryMessage<ICRC153FrozenAccountsResponse> {
  final ICRC153FrozenAccountsRequest args;
  const ICRC153QueryIcrc153ListFrozenAccounts(this.args);

  @override
  String get methodName => 'icrc153_list_frozen_accounts';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC153FrozenAccountsResponse onResponse(List<int> bytes) {
    return ICRC153FrozenAccountsResponse.fromBytes(bytes);
  }
}

class ICRC153QueryIcrc153ListFrozenPrincipals
    extends ICRC153QueryMessage<ICRC153FrozenPrincipalsResponse> {
  final ICRC153FrozenPrincipalsRequest args;
  const ICRC153QueryIcrc153ListFrozenPrincipals(this.args);

  @override
  String get methodName => 'icrc153_list_frozen_principals';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC153FrozenPrincipalsResponse onResponse(List<int> bytes) {
    return ICRC153FrozenPrincipalsResponse.fromBytes(bytes);
  }
}

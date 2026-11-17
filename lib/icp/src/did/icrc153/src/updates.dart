// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'types.dart';

/// Update messages for service `ICRC153`.
abstract class ICRC153UpdateMessage<RESULT> extends IICPUpdateMessage<RESULT> {
  const ICRC153UpdateMessage();
}

class ICRC153UpdateIcrc153FreezeAccount
    extends ICRC153UpdateMessage<ICRC153Icrc153FreezeAccountResponse> {
  final ICRC153FreezeAccountArgs args;
  const ICRC153UpdateIcrc153FreezeAccount(this.args);

  @override
  String get methodName => 'icrc153_freeze_account';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC153Icrc153FreezeAccountResponse onResponse(List<int> bytes) {
    return ICRC153Icrc153FreezeAccountResponse.fromBytes(bytes);
  }
}

class ICRC153UpdateIcrc153UnfreezeAccount
    extends ICRC153UpdateMessage<ICRC153Icrc153UnfreezeAccountResponse> {
  final ICRC153UnfreezeAccountArgs args;
  const ICRC153UpdateIcrc153UnfreezeAccount(this.args);

  @override
  String get methodName => 'icrc153_unfreeze_account';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC153Icrc153UnfreezeAccountResponse onResponse(List<int> bytes) {
    return ICRC153Icrc153UnfreezeAccountResponse.fromBytes(bytes);
  }
}

class ICRC153UpdateIcrc153FreezePrincipal
    extends ICRC153UpdateMessage<ICRC153Icrc153FreezePrincipalResponse> {
  final ICRC153FreezePrincipalArgs args;
  const ICRC153UpdateIcrc153FreezePrincipal(this.args);

  @override
  String get methodName => 'icrc153_freeze_principal';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC153Icrc153FreezePrincipalResponse onResponse(List<int> bytes) {
    return ICRC153Icrc153FreezePrincipalResponse.fromBytes(bytes);
  }
}

class ICRC153UpdateIcrc153UnfreezePrincipal
    extends ICRC153UpdateMessage<ICRC153Icrc153UnfreezePrincipalResponse> {
  final ICRC153UnfreezePrincipalArgs args;
  const ICRC153UpdateIcrc153UnfreezePrincipal(this.args);

  @override
  String get methodName => 'icrc153_unfreeze_principal';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC153Icrc153UnfreezePrincipalResponse onResponse(List<int> bytes) {
    return ICRC153Icrc153UnfreezePrincipalResponse.fromBytes(bytes);
  }
}

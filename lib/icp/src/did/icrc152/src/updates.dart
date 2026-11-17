// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'types.dart';

/// Update messages for service `ICRC152`.
abstract class ICRC152UpdateMessage<RESULT> extends IICPUpdateMessage<RESULT> {
  const ICRC152UpdateMessage();
}

class ICRC152UpdateIcrc152Mint
    extends ICRC152UpdateMessage<ICRC152Icrc152MintResponse> {
  final ICRC152MintArgs args;
  const ICRC152UpdateIcrc152Mint(this.args);

  @override
  String get methodName => 'icrc152_mint';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC152Icrc152MintResponse onResponse(List<int> bytes) {
    return ICRC152Icrc152MintResponse.fromBytes(bytes);
  }
}

class ICRC152UpdateIcrc152Burn
    extends ICRC152UpdateMessage<ICRC152Icrc152BurnResponse> {
  final ICRC152BurnArgs args;
  const ICRC152UpdateIcrc152Burn(this.args);

  @override
  String get methodName => 'icrc152_burn';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC152Icrc152BurnResponse onResponse(List<int> bytes) {
    return ICRC152Icrc152BurnResponse.fromBytes(bytes);
  }
}

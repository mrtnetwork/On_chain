// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'types.dart';

/// Update messages for service `ICRC154`.
abstract class ICRC154UpdateMessage<RESULT> extends IICPUpdateMessage<RESULT> {
  const ICRC154UpdateMessage();
}

class ICRC154UpdateIcrc154Pause
    extends ICRC154UpdateMessage<ICRC154Icrc154PauseResponse> {
  final ICRC154PauseArgs args;
  const ICRC154UpdateIcrc154Pause(this.args);

  @override
  String get methodName => 'icrc154_pause';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC154Icrc154PauseResponse onResponse(List<int> bytes) {
    return ICRC154Icrc154PauseResponse.fromBytes(bytes);
  }
}

class ICRC154UpdateIcrc154Unpause
    extends ICRC154UpdateMessage<ICRC154Icrc154UnpauseResponse> {
  final ICRC154UnpauseArgs args;
  const ICRC154UpdateIcrc154Unpause(this.args);

  @override
  String get methodName => 'icrc154_unpause';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC154Icrc154UnpauseResponse onResponse(List<int> bytes) {
    return ICRC154Icrc154UnpauseResponse.fromBytes(bytes);
  }
}

class ICRC154UpdateIcrc154Deactivate
    extends ICRC154UpdateMessage<ICRC154Icrc154DeactivateResponse> {
  final ICRC154DeactivateArgs args;
  const ICRC154UpdateIcrc154Deactivate(this.args);

  @override
  String get methodName => 'icrc154_deactivate';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC154Icrc154DeactivateResponse onResponse(List<int> bytes) {
    return ICRC154Icrc154DeactivateResponse.fromBytes(bytes);
  }
}

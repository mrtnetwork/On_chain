// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';

/// Query messages for service `ICRC154`.
abstract class ICRC154QueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const ICRC154QueryMessage();
}

class ICRC154QueryIcrc154IsPaused extends ICRC154QueryMessage<bool> {
  const ICRC154QueryIcrc154IsPaused();

  @override
  String get methodName => 'icrc154_is_paused';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  bool onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.bool_) as bool;
  }
}

class ICRC154QueryIcrc154IsDeactivated extends ICRC154QueryMessage<bool> {
  const ICRC154QueryIcrc154IsDeactivated();

  @override
  String get methodName => 'icrc154_is_deactivated';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  bool onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.bool_) as bool;
  }
}

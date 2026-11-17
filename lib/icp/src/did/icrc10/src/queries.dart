// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `ICRC10`.
abstract class ICRC10QueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const ICRC10QueryMessage();
}

class ICRC10QueryIcrc10SupportedStandards
    extends ICRC10QueryMessage<ICRC10SupportedStandardsResponse> {
  const ICRC10QueryIcrc10SupportedStandards();

  @override
  String get methodName => 'icrc10_supported_standards';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  ICRC10SupportedStandardsResponse onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      ICRC10SupportedStandardsResponseCandid.ctype,
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICRC10SupportedStandard.fromCandid(e)).toList();
  }
}

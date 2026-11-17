// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `ICRC2`.
abstract class ICRC2QueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const ICRC2QueryMessage();
}

class ICRC2QueryIcrc1SupportedStandards
    extends ICRC2QueryMessage<List<ICRC2Icrc1SupportedStandardsResponse>> {
  const ICRC2QueryIcrc1SupportedStandards();

  @override
  String get methodName => 'icrc1_supported_standards';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<ICRC2Icrc1SupportedStandardsResponse> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(ICRC2Icrc1SupportedStandardsResponse.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICRC2Icrc1SupportedStandardsResponse.fromCandid(e)).toList();
  }
}

class ICRC2QueryIcrc2Allowance
    extends ICRC2QueryMessage<ICRC2Icrc2AllowanceResponse> {
  final ICRC2AllowanceArgs args;
  const ICRC2QueryIcrc2Allowance(this.args);

  @override
  String get methodName => 'icrc2_allowance';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC2Icrc2AllowanceResponse onResponse(List<int> bytes) {
    return ICRC2Icrc2AllowanceResponse.fromBytes(bytes);
  }
}

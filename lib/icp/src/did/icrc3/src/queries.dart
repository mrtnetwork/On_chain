// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `ICRC3`.
abstract class ICRC3QueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const ICRC3QueryMessage();
}

class ICRC3QueryIcrc3GetArchives
    extends ICRC3QueryMessage<ICRC3GetArchivesResult> {
  final ICRC3GetArchivesArgs args;
  const ICRC3QueryIcrc3GetArchives(this.args);

  @override
  String get methodName => 'icrc3_get_archives';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICRC3GetArchivesResult onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      ICRC3GetArchivesResultCandid.ctype,
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICRC3GetArchivesResultItem.fromCandid(e)).toList();
  }
}

class ICRC3QueryIcrc3GetTipCertificate
    extends ICRC3QueryMessage<ICRC3DataCertificate?> {
  const ICRC3QueryIcrc3GetTipCertificate();

  @override
  String get methodName => 'icrc3_get_tip_certificate';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  ICRC3DataCertificate? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(ICRC3DataCertificate.ctype),
    );
    if (decode == null) return null;
    return ICRC3DataCertificate.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class ICRC3QueryIcrc3GetBlocks extends ICRC3QueryMessage<ICRC3GetBlocksResult> {
  final ICRC3GetBlocksArgs args;
  const ICRC3QueryIcrc3GetBlocks(this.args);

  @override
  String get methodName => 'icrc3_get_blocks';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(ICRC3GetBlocksArgsCandid.ctype, args);
  }

  @override
  ICRC3GetBlocksResult onResponse(List<int> bytes) {
    return ICRC3GetBlocksResult.fromBytes(bytes);
  }
}

class ICRC3QueryIcrc3SupportedBlockTypes
    extends ICRC3QueryMessage<List<ICRC3Icrc3SupportedBlockTypesResponse>> {
  const ICRC3QueryIcrc3SupportedBlockTypes();

  @override
  String get methodName => 'icrc3_supported_block_types';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<ICRC3Icrc3SupportedBlockTypesResponse> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(ICRC3Icrc3SupportedBlockTypesResponse.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICRC3Icrc3SupportedBlockTypesResponse.fromCandid(e)).toList();
  }
}

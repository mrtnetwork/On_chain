// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `CyclesLedger`.
abstract class CyclesLedgerQueryMessage<RESULT>
    extends IICPQueryMessage<RESULT> {
  const CyclesLedgerQueryMessage();
}

class CyclesLedgerQueryHttpRequest
    extends CyclesLedgerQueryMessage<CyclesLedgerHttpResponse> {
  final CyclesLedgerHttpRequest args;
  const CyclesLedgerQueryHttpRequest(this.args);

  @override
  String get methodName => 'http_request';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerHttpResponse onResponse(List<int> bytes) {
    return CyclesLedgerHttpResponse.fromBytes(bytes);
  }
}

class CyclesLedgerQueryIcrc103GetAllowances
    extends CyclesLedgerQueryMessage<CyclesLedgerICRC103GetAllowancesResponse> {
  final CyclesLedgerGetAllowancesArgs args;
  const CyclesLedgerQueryIcrc103GetAllowances(this.args);

  @override
  String get methodName => 'icrc103_get_allowances';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerICRC103GetAllowancesResponse onResponse(List<int> bytes) {
    return CyclesLedgerICRC103GetAllowancesResponse.fromBytes(bytes);
  }
}

class CyclesLedgerQueryIcrc106GetIndexPrincipal
    extends CyclesLedgerQueryMessage<CyclesLedgerGetIndexPrincipalResult> {
  const CyclesLedgerQueryIcrc106GetIndexPrincipal();

  @override
  String get methodName => 'icrc106_get_index_principal';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  CyclesLedgerGetIndexPrincipalResult onResponse(List<int> bytes) {
    return CyclesLedgerGetIndexPrincipalResult.fromBytes(bytes);
  }
}

class CyclesLedgerQueryIcrc1BalanceOf extends CyclesLedgerQueryMessage<BigInt> {
  final CyclesLedgerAccount args;
  const CyclesLedgerQueryIcrc1BalanceOf(this.args);

  @override
  String get methodName => 'icrc1_balance_of';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  BigInt onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat) as BigInt;
  }
}

class CyclesLedgerQueryIcrc1Decimals extends CyclesLedgerQueryMessage<int> {
  const CyclesLedgerQueryIcrc1Decimals();

  @override
  String get methodName => 'icrc1_decimals';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  int onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat8) as int;
  }
}

class CyclesLedgerQueryIcrc1Fee extends CyclesLedgerQueryMessage<BigInt> {
  const CyclesLedgerQueryIcrc1Fee();

  @override
  String get methodName => 'icrc1_fee';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat) as BigInt;
  }
}

class CyclesLedgerQueryIcrc1Metadata
    extends CyclesLedgerQueryMessage<List<CyclesLedgerIcrc1MetadataResponse>> {
  const CyclesLedgerQueryIcrc1Metadata();

  @override
  String get methodName => 'icrc1_metadata';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<CyclesLedgerIcrc1MetadataResponse> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(CyclesLedgerIcrc1MetadataResponse.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => CyclesLedgerIcrc1MetadataResponse.fromCandid(e)).toList();
  }
}

class CyclesLedgerQueryIcrc1MintingAccount
    extends CyclesLedgerQueryMessage<CyclesLedgerAccount?> {
  const CyclesLedgerQueryIcrc1MintingAccount();

  @override
  String get methodName => 'icrc1_minting_account';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  CyclesLedgerAccount? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(CyclesLedgerAccount.ctype),
    );
    if (decode == null) return null;
    return CyclesLedgerAccount.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class CyclesLedgerQueryIcrc1Name extends CyclesLedgerQueryMessage<String> {
  const CyclesLedgerQueryIcrc1Name();

  @override
  String get methodName => 'icrc1_name';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  String onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.text) as String;
  }
}

class CyclesLedgerQueryIcrc1SupportedStandards
    extends CyclesLedgerQueryMessage<List<CyclesLedgerSupportedStandard>> {
  const CyclesLedgerQueryIcrc1SupportedStandards();

  @override
  String get methodName => 'icrc1_supported_standards';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<CyclesLedgerSupportedStandard> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(CyclesLedgerSupportedStandard.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => CyclesLedgerSupportedStandard.fromCandid(e)).toList();
  }
}

class CyclesLedgerQueryIcrc1Symbol extends CyclesLedgerQueryMessage<String> {
  const CyclesLedgerQueryIcrc1Symbol();

  @override
  String get methodName => 'icrc1_symbol';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  String onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.text) as String;
  }
}

class CyclesLedgerQueryIcrc1TotalSupply
    extends CyclesLedgerQueryMessage<BigInt> {
  const CyclesLedgerQueryIcrc1TotalSupply();

  @override
  String get methodName => 'icrc1_total_supply';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat) as BigInt;
  }
}

class CyclesLedgerQueryIcrc2Allowance
    extends CyclesLedgerQueryMessage<CyclesLedgerAllowance> {
  final CyclesLedgerAllowanceArgs args;
  const CyclesLedgerQueryIcrc2Allowance(this.args);

  @override
  String get methodName => 'icrc2_allowance';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerAllowance onResponse(List<int> bytes) {
    return CyclesLedgerAllowance.fromBytes(bytes);
  }
}

class CyclesLedgerQueryIcrc3GetArchives
    extends CyclesLedgerQueryMessage<CyclesLedgerGetArchivesResult> {
  final CyclesLedgerGetArchivesArgs args;
  const CyclesLedgerQueryIcrc3GetArchives(this.args);

  @override
  String get methodName => 'icrc3_get_archives';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  CyclesLedgerGetArchivesResult onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CyclesLedgerGetArchivesResultCandid.ctype,
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => CyclesLedgerGetArchivesResultItem.fromCandid(e)).toList();
  }
}

class CyclesLedgerQueryIcrc3GetBlocks
    extends CyclesLedgerQueryMessage<CyclesLedgerGetBlocksResult> {
  final CyclesLedgerGetBlocksArgs args;
  const CyclesLedgerQueryIcrc3GetBlocks(this.args);

  @override
  String get methodName => 'icrc3_get_blocks';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(
      CyclesLedgerGetBlocksArgsCandid.ctype,
      args,
    );
  }

  @override
  CyclesLedgerGetBlocksResult onResponse(List<int> bytes) {
    return CyclesLedgerGetBlocksResult.fromBytes(bytes);
  }
}

class CyclesLedgerQueryIcrc3GetTipCertificate
    extends CyclesLedgerQueryMessage<CyclesLedgerDataCertificate?> {
  const CyclesLedgerQueryIcrc3GetTipCertificate();

  @override
  String get methodName => 'icrc3_get_tip_certificate';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  CyclesLedgerDataCertificate? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(CyclesLedgerDataCertificate.ctype),
    );
    if (decode == null) return null;
    return CyclesLedgerDataCertificate.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class CyclesLedgerQueryIcrc3SupportedBlockTypes
    extends CyclesLedgerQueryMessage<List<CyclesLedgerSupportedBlockType>> {
  const CyclesLedgerQueryIcrc3SupportedBlockTypes();

  @override
  String get methodName => 'icrc3_supported_block_types';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<CyclesLedgerSupportedBlockType> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(CyclesLedgerSupportedBlockType.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => CyclesLedgerSupportedBlockType.fromCandid(e)).toList();
  }
}

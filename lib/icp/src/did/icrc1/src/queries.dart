// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `ICRC1`.
abstract class ICRC1QueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const ICRC1QueryMessage();
}

class ICRC1QueryIcrc1Metadata
    extends ICRC1QueryMessage<List<ICRC1Icrc1MetadataResponse>> {
  const ICRC1QueryIcrc1Metadata();

  @override
  String get methodName => 'icrc1_metadata';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<ICRC1Icrc1MetadataResponse> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(ICRC1Icrc1MetadataResponse.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICRC1Icrc1MetadataResponse.fromCandid(e)).toList();
  }
}

class ICRC1QueryIcrc1Name extends ICRC1QueryMessage<String> {
  const ICRC1QueryIcrc1Name();

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

class ICRC1QueryIcrc1Symbol extends ICRC1QueryMessage<String> {
  const ICRC1QueryIcrc1Symbol();

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

class ICRC1QueryIcrc1Decimals extends ICRC1QueryMessage<int> {
  const ICRC1QueryIcrc1Decimals();

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

class ICRC1QueryIcrc1Fee extends ICRC1QueryMessage<BigInt> {
  const ICRC1QueryIcrc1Fee();

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

class ICRC1QueryIcrc1TotalSupply extends ICRC1QueryMessage<BigInt> {
  const ICRC1QueryIcrc1TotalSupply();

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

class ICRC1QueryIcrc1MintingAccount extends ICRC1QueryMessage<ICRC1Account?> {
  const ICRC1QueryIcrc1MintingAccount();

  @override
  String get methodName => 'icrc1_minting_account';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  ICRC1Account? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(ICRC1Account.ctype),
    );
    if (decode == null) return null;
    return ICRC1Account.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class ICRC1QueryIcrc1BalanceOf extends ICRC1QueryMessage<BigInt> {
  final ICRC1Account args;
  const ICRC1QueryIcrc1BalanceOf(this.args);

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

class ICRC1QueryIcrc1SupportedStandards
    extends ICRC1QueryMessage<List<ICRC1Icrc1SupportedStandardsResponse>> {
  const ICRC1QueryIcrc1SupportedStandards();

  @override
  String get methodName => 'icrc1_supported_standards';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<ICRC1Icrc1SupportedStandardsResponse> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(ICRC1Icrc1SupportedStandardsResponse.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICRC1Icrc1SupportedStandardsResponse.fromCandid(e)).toList();
  }
}

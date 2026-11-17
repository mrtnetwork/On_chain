// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `LEDGER`.
abstract class LEDGERQueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const LEDGERQueryMessage();
}

class LEDGERQueryAccountBalance extends LEDGERQueryMessage<LEDGERTokens> {
  final LEDGERAccountBalanceArgs args;
  const LEDGERQueryAccountBalance(this.args);

  @override
  String get methodName => 'account_balance';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERTokens onResponse(List<int> bytes) {
    return LEDGERTokens.fromBytes(bytes);
  }
}

class LEDGERQueryAccountIdentifier
    extends LEDGERQueryMessage<LEDGERAccountIdentifier> {
  final LEDGERAccount args;
  const LEDGERQueryAccountIdentifier(this.args);

  @override
  String get methodName => 'account_identifier';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERAccountIdentifier onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.vec(CType.nat8))
        as LEDGERAccountIdentifier;
  }
}

class LEDGERQueryTransferFee extends LEDGERQueryMessage<LEDGERTransferFee> {
  final LEDGERTransferFeeArg args;
  const LEDGERQueryTransferFee(this.args);

  @override
  String get methodName => 'transfer_fee';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERTransferFee onResponse(List<int> bytes) {
    return LEDGERTransferFee.fromBytes(bytes);
  }
}

class LEDGERQueryQueryBlocks
    extends LEDGERQueryMessage<LEDGERQueryBlocksResponse> {
  final LEDGERGetBlocksArgs args;
  const LEDGERQueryQueryBlocks(this.args);

  @override
  String get methodName => 'query_blocks';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERQueryBlocksResponse onResponse(List<int> bytes) {
    return LEDGERQueryBlocksResponse.fromBytes(bytes);
  }
}

class LEDGERQueryQueryEncodedBlocks
    extends LEDGERQueryMessage<LEDGERQueryEncodedBlocksResponse> {
  final LEDGERGetBlocksArgs args;
  const LEDGERQueryQueryEncodedBlocks(this.args);

  @override
  String get methodName => 'query_encoded_blocks';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERQueryEncodedBlocksResponse onResponse(List<int> bytes) {
    return LEDGERQueryEncodedBlocksResponse.fromBytes(bytes);
  }
}

class LEDGERQuerySymbol extends LEDGERQueryMessage<LEDGERSymbolResponse> {
  const LEDGERQuerySymbol();

  @override
  String get methodName => 'symbol';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  LEDGERSymbolResponse onResponse(List<int> bytes) {
    return LEDGERSymbolResponse.fromBytes(bytes);
  }
}

class LEDGERQueryName extends LEDGERQueryMessage<LEDGERNameResponse> {
  const LEDGERQueryName();

  @override
  String get methodName => 'name';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  LEDGERNameResponse onResponse(List<int> bytes) {
    return LEDGERNameResponse.fromBytes(bytes);
  }
}

class LEDGERQueryDecimals extends LEDGERQueryMessage<LEDGERDecimalsResponse> {
  const LEDGERQueryDecimals();

  @override
  String get methodName => 'decimals';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  LEDGERDecimalsResponse onResponse(List<int> bytes) {
    return LEDGERDecimalsResponse.fromBytes(bytes);
  }
}

class LEDGERQueryArchives extends LEDGERQueryMessage<LEDGERArchives> {
  const LEDGERQueryArchives();

  @override
  String get methodName => 'archives';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  LEDGERArchives onResponse(List<int> bytes) {
    return LEDGERArchives.fromBytes(bytes);
  }
}

class LEDGERQueryAccountBalanceDfx extends LEDGERQueryMessage<LEDGERTokens> {
  final LEDGERAccountBalanceArgsDfx args;
  const LEDGERQueryAccountBalanceDfx(this.args);

  @override
  String get methodName => 'account_balance_dfx';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERTokens onResponse(List<int> bytes) {
    return LEDGERTokens.fromBytes(bytes);
  }
}

class LEDGERQueryIcrc1Name extends LEDGERQueryMessage<String> {
  const LEDGERQueryIcrc1Name();

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

class LEDGERQueryIcrc1Symbol extends LEDGERQueryMessage<String> {
  const LEDGERQueryIcrc1Symbol();

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

class LEDGERQueryIcrc1Decimals extends LEDGERQueryMessage<int> {
  const LEDGERQueryIcrc1Decimals();

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

class LEDGERQueryIcrc1Metadata
    extends LEDGERQueryMessage<List<LEDGERIcrc1MetadataResponse>> {
  const LEDGERQueryIcrc1Metadata();

  @override
  String get methodName => 'icrc1_metadata';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<LEDGERIcrc1MetadataResponse> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(LEDGERIcrc1MetadataResponse.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => LEDGERIcrc1MetadataResponse.fromCandid(e)).toList();
  }
}

class LEDGERQueryIcrc1TotalSupply
    extends LEDGERQueryMessage<LEDGERIcrc1Tokens> {
  const LEDGERQueryIcrc1TotalSupply();

  @override
  String get methodName => 'icrc1_total_supply';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  LEDGERIcrc1Tokens onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat) as LEDGERIcrc1Tokens;
  }
}

class LEDGERQueryIcrc1Fee extends LEDGERQueryMessage<LEDGERIcrc1Tokens> {
  const LEDGERQueryIcrc1Fee();

  @override
  String get methodName => 'icrc1_fee';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  LEDGERIcrc1Tokens onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat) as LEDGERIcrc1Tokens;
  }
}

class LEDGERQueryIcrc1MintingAccount
    extends LEDGERQueryMessage<LEDGERAccount?> {
  const LEDGERQueryIcrc1MintingAccount();

  @override
  String get methodName => 'icrc1_minting_account';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  LEDGERAccount? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(LEDGERAccount.ctype),
    );
    if (decode == null) return null;
    return LEDGERAccount.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class LEDGERQueryIcrc1BalanceOf extends LEDGERQueryMessage<LEDGERIcrc1Tokens> {
  final LEDGERAccount args;
  const LEDGERQueryIcrc1BalanceOf(this.args);

  @override
  String get methodName => 'icrc1_balance_of';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERIcrc1Tokens onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat) as LEDGERIcrc1Tokens;
  }
}

class LEDGERQueryIcrc1SupportedStandards
    extends LEDGERQueryMessage<List<LEDGERIcrc1SupportedStandardsResponse>> {
  const LEDGERQueryIcrc1SupportedStandards();

  @override
  String get methodName => 'icrc1_supported_standards';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<LEDGERIcrc1SupportedStandardsResponse> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(LEDGERIcrc1SupportedStandardsResponse.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => LEDGERIcrc1SupportedStandardsResponse.fromCandid(e)).toList();
  }
}

class LEDGERQueryIcrc2Allowance extends LEDGERQueryMessage<LEDGERAllowance> {
  final LEDGERAllowanceArgs args;
  const LEDGERQueryIcrc2Allowance(this.args);

  @override
  String get methodName => 'icrc2_allowance';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERAllowance onResponse(List<int> bytes) {
    return LEDGERAllowance.fromBytes(bytes);
  }
}

class LEDGERQueryIcrc10SupportedStandards
    extends LEDGERQueryMessage<List<LEDGERIcrc1SupportedStandardsResponse>> {
  const LEDGERQueryIcrc10SupportedStandards();

  @override
  String get methodName => 'icrc10_supported_standards';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<LEDGERIcrc1SupportedStandardsResponse> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(LEDGERIcrc1SupportedStandardsResponse.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => LEDGERIcrc1SupportedStandardsResponse.fromCandid(e)).toList();
  }
}

class LEDGERQueryGetAllowances extends LEDGERQueryMessage<LEDGERAllowances> {
  final LEDGERGetAllowancesArgs args;
  const LEDGERQueryGetAllowances(this.args);

  @override
  String get methodName => 'get_allowances';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  LEDGERAllowances onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      LEDGERAllowancesCandid.ctype,
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => LEDGERAllowancesItem.fromCandid(e)).toList();
  }
}

class LEDGERQueryTipOfChain extends LEDGERQueryMessage<LEDGERTipOfChainRes> {
  const LEDGERQueryTipOfChain();

  @override
  String get methodName => 'tip_of_chain';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  LEDGERTipOfChainRes onResponse(List<int> bytes) {
    return LEDGERTipOfChainRes.fromBytes(bytes);
  }
}

class LEDGERQueryIsLedgerReady extends LEDGERQueryMessage<bool> {
  const LEDGERQueryIsLedgerReady();

  @override
  String get methodName => 'is_ledger_ready';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  bool onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.bool_) as bool;
  }
}

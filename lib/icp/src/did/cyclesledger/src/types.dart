// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid type alias `Allowances`.
typedef CyclesLedgerAllowances = List<CyclesLedgerAllowancesItem>;

/// CType for alias `Allowances`.
abstract final class CyclesLedgerAllowancesCandid {
  static CType get ctype => CType.vec(CyclesLedgerAllowancesItem.ctype);
}

/// Candid type alias `BlockIndex`.
typedef CyclesLedgerBlockIndex = BigInt;

/// Candid type alias `GetArchivesResult`.
typedef CyclesLedgerGetArchivesResult = List<CyclesLedgerGetArchivesResultItem>;

/// CType for alias `GetArchivesResult`.
abstract final class CyclesLedgerGetArchivesResultCandid {
  static CType get ctype => CType.vec(CyclesLedgerGetArchivesResultItem.ctype);
}

/// Candid type alias `GetBlocksArgs`.
typedef CyclesLedgerGetBlocksArgs = List<CyclesLedgerGetBlocksArgsItem>;

/// CType for alias `GetBlocksArgs`.
abstract final class CyclesLedgerGetBlocksArgsCandid {
  static CType get ctype => CType.vec(CyclesLedgerGetBlocksArgsItem.ctype);
}

/// Candid record `CyclesLedgerAllowances.item`.
final class CyclesLedgerAllowancesItem with CandidSerializable {
  final CyclesLedgerAccount fromAccount;
  final CyclesLedgerAccount toSpender;
  final BigInt allowance;
  final BigInt? expiresAt;

  const CyclesLedgerAllowancesItem({
    required this.fromAccount,
    required this.toSpender,
    required this.allowance,
    this.expiresAt,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('from_account'), () => CyclesLedgerAccount.ctype),
    LazyField(Label.named('to_spender'), () => CyclesLedgerAccount.ctype),
    Field(Label.named('allowance'), CType.nat),
    Field(Label.named('expires_at'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'from_account': fromAccount.candidValue,
    'to_spender': toSpender.candidValue,
    'allowance': allowance,
    'expires_at': expiresAt,
  };

  Map<String, dynamic> toJson() => {
    'from_account': fromAccount.toJson(),
    'to_spender': toSpender.toJson(),
    'allowance': allowance,
    'expires_at': expiresAt,
  };

  factory CyclesLedgerAllowancesItem.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerAllowancesItem(
      fromAccount: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'from_account',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      toSpender: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'to_spender',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      allowance: json.valueAsBigInt<BigInt>('allowance'),
      expiresAt: json.valueAsBigInt<BigInt?>('expires_at'),
    );
  }

  factory CyclesLedgerAllowancesItem.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerAllowancesItem.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CyclesLedgerGetArchivesResult.item`.
final class CyclesLedgerGetArchivesResultItem with CandidSerializable {
  final BigInt end;
  final IcpPrincipalAddress canisterId;
  final BigInt start;

  const CyclesLedgerGetArchivesResultItem({
    required this.end,
    required this.canisterId,
    required this.start,
  });

  static CType get ctype => CType.record([
    Field(Label.named('end'), CType.nat),
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('start'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'end': end,
    'canister_id': canisterId,
    'start': start,
  };

  Map<String, dynamic> toJson() => {
    'end': end,
    'canister_id': canisterId.address,
    'start': start,
  };

  factory CyclesLedgerGetArchivesResultItem.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerGetArchivesResultItem(
      end: json.valueAsBigInt<BigInt>('end'),
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      start: json.valueAsBigInt<BigInt>('start'),
    );
  }

  factory CyclesLedgerGetArchivesResultItem.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerGetArchivesResultItem.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CyclesLedgerGetBlocksArgs.item`.
final class CyclesLedgerGetBlocksArgsItem with CandidSerializable {
  final BigInt start;
  final BigInt length;

  const CyclesLedgerGetBlocksArgsItem({
    required this.start,
    required this.length,
  });

  static CType get ctype => CType.record([
    Field(Label.named('start'), CType.nat),
    Field(Label.named('length'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'start': start, 'length': length};

  Map<String, dynamic> toJson() => {'start': start, 'length': length};

  factory CyclesLedgerGetBlocksArgsItem.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerGetBlocksArgsItem(
      start: json.valueAsBigInt<BigInt>('start'),
      length: json.valueAsBigInt<BigInt>('length'),
    );
  }

  factory CyclesLedgerGetBlocksArgsItem.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerGetBlocksArgsItem.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CyclesLedgerGetBlocksResult.blocks`.
final class CyclesLedgerGetBlocksResultBlocks with CandidSerializable {
  final BigInt id;
  final CyclesLedgerValue block;

  const CyclesLedgerGetBlocksResultBlocks({
    required this.id,
    required this.block,
  });

  static CType get ctype => CType.record([
    Field(Label.named('id'), CType.nat),
    LazyField(Label.named('block'), () => CyclesLedgerValue.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'id': id, 'block': block.candidValue};

  Map<String, dynamic> toJson() => {'id': id, 'block': block.toJson()};

  factory CyclesLedgerGetBlocksResultBlocks.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerGetBlocksResultBlocks(
      id: json.valueAsBigInt<BigInt>('id'),
      block: json.valueTo<CyclesLedgerValue, Map>(
        key: 'block',
        parse:
            (e) => CyclesLedgerValue.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory CyclesLedgerGetBlocksResultBlocks.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerGetBlocksResultBlocks.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CyclesLedgerGetBlocksResult.archived_blocks`.
final class CyclesLedgerGetBlocksResultArchivedBlocks with CandidSerializable {
  final CyclesLedgerGetBlocksArgs args;
  final FuncRef callback;

  const CyclesLedgerGetBlocksResultArchivedBlocks({
    required this.args,
    required this.callback,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('args'), () => CyclesLedgerGetBlocksArgsCandid.ctype),
    Field(Label.named('callback'), CType.func(const FunctionType([], [], []))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'args': args.map((el) => el.candidValue).toList(),
    'callback': callback,
  };

  Map<String, dynamic> toJson() => {
    'args': args.map((el) => el.toJson()).toList(),
    'callback': callback,
  };

  factory CyclesLedgerGetBlocksResultArchivedBlocks.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerGetBlocksResultArchivedBlocks(
      args: json.valueTo<List<CyclesLedgerGetBlocksArgsItem>, List>(
        key: 'args',
        parse:
            (e) =>
                e
                    .map<CyclesLedgerGetBlocksArgsItem>(
                      (x) => CyclesLedgerGetBlocksArgsItem.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      callback: json['callback'],
    );
  }

  factory CyclesLedgerGetBlocksResultArchivedBlocks.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerGetBlocksResultArchivedBlocks.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CyclesLedgerHttpRequest.headers`.
final class CyclesLedgerHttpRequestHeaders with CandidSerializable {
  final String field0;
  final String field1;

  const CyclesLedgerHttpRequestHeaders({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    Field(Label.id(1), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1};

  factory CyclesLedgerHttpRequestHeaders.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerHttpRequestHeaders(
      field0: json.valueAsString<String>('0'),
      field1: json.valueAsString<String>('1'),
    );
  }

  factory CyclesLedgerHttpRequestHeaders.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerHttpRequestHeaders.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CyclesLedgerInitArgs.initial_balances`.
final class CyclesLedgerInitArgsInitialBalances with CandidSerializable {
  final CyclesLedgerAccount field0;
  final BigInt field1;

  const CyclesLedgerInitArgsInitialBalances({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    LazyField(Label.id(0), () => CyclesLedgerAccount.ctype),
    Field(Label.id(1), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0.candidValue, '1': field1};

  Map<String, dynamic> toJson() => {'0': field0.toJson(), '1': field1};

  factory CyclesLedgerInitArgsInitialBalances.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerInitArgsInitialBalances(
      field0: json.valueTo<CyclesLedgerAccount, Map>(
        key: '0',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      field1: json.valueAsBigInt<BigInt>('1'),
    );
  }

  factory CyclesLedgerInitArgsInitialBalances.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerInitArgsInitialBalances.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CyclesLedgerValue.Map`.
final class CyclesLedgerValueMap with CandidSerializable {
  final String field0;
  final CyclesLedgerValue field1;

  const CyclesLedgerValueMap({required this.field0, required this.field1});

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => CyclesLedgerValue.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory CyclesLedgerValueMap.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerValueMap(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<CyclesLedgerValue, Map>(
        key: '1',
        parse:
            (e) => CyclesLedgerValue.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory CyclesLedgerValueMap.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerValueMap.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `CyclesLedgerCreateCanister.response`.
sealed class CyclesLedgerCreateCanisterResponse with CandidSerializable {
  const CyclesLedgerCreateCanisterResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => CyclesLedgerCreateCanisterSuccess.ctype),
    LazyField(Label.named('Err'), () => CyclesLedgerCreateCanisterError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerCreateCanisterResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return CyclesLedgerCreateCanisterResponseOk(
        json.valueTo<CyclesLedgerCreateCanisterSuccess, Map>(
          key: 'Ok',
          parse:
              (e) => CyclesLedgerCreateCanisterSuccess.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return CyclesLedgerCreateCanisterResponseErr(
        json.valueTo<CyclesLedgerCreateCanisterError, Map>(
          key: 'Err',
          parse:
              (e) => CyclesLedgerCreateCanisterError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerCreateCanisterResponse.fromCandid',
      reason: 'Unknown CyclesLedgerCreateCanisterResponse arm',
    );
  }

  factory CyclesLedgerCreateCanisterResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerCreateCanisterResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CyclesLedgerCreateCanister.response.Ok`.
final class CyclesLedgerCreateCanisterResponseOk
    extends CyclesLedgerCreateCanisterResponse {
  final CyclesLedgerCreateCanisterSuccess value;
  const CyclesLedgerCreateCanisterResponseOk(this.value);

  @override
  CType get candidType => CyclesLedgerCreateCanisterResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `CyclesLedgerCreateCanister.response.Err`.
final class CyclesLedgerCreateCanisterResponseErr
    extends CyclesLedgerCreateCanisterResponse {
  final CyclesLedgerCreateCanisterError value;
  const CyclesLedgerCreateCanisterResponseErr(this.value);

  @override
  CType get candidType => CyclesLedgerCreateCanisterResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `CyclesLedgerCreateCanisterFrom.response`.
sealed class CyclesLedgerCreateCanisterFromResponse with CandidSerializable {
  const CyclesLedgerCreateCanisterFromResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => CyclesLedgerCreateCanisterSuccess.ctype),
    LazyField(
      Label.named('Err'),
      () => CyclesLedgerCreateCanisterFromError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerCreateCanisterFromResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return CyclesLedgerCreateCanisterFromResponseOk(
        json.valueTo<CyclesLedgerCreateCanisterSuccess, Map>(
          key: 'Ok',
          parse:
              (e) => CyclesLedgerCreateCanisterSuccess.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return CyclesLedgerCreateCanisterFromResponseErr(
        json.valueTo<CyclesLedgerCreateCanisterFromError, Map>(
          key: 'Err',
          parse:
              (e) => CyclesLedgerCreateCanisterFromError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerCreateCanisterFromResponse.fromCandid',
      reason: 'Unknown CyclesLedgerCreateCanisterFromResponse arm',
    );
  }

  factory CyclesLedgerCreateCanisterFromResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerCreateCanisterFromResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CyclesLedgerCreateCanisterFrom.response.Ok`.
final class CyclesLedgerCreateCanisterFromResponseOk
    extends CyclesLedgerCreateCanisterFromResponse {
  final CyclesLedgerCreateCanisterSuccess value;
  const CyclesLedgerCreateCanisterFromResponseOk(this.value);

  @override
  CType get candidType => CyclesLedgerCreateCanisterFromResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `CyclesLedgerCreateCanisterFrom.response.Err`.
final class CyclesLedgerCreateCanisterFromResponseErr
    extends CyclesLedgerCreateCanisterFromResponse {
  final CyclesLedgerCreateCanisterFromError value;
  const CyclesLedgerCreateCanisterFromResponseErr(this.value);

  @override
  CType get candidType => CyclesLedgerCreateCanisterFromResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `CyclesLedgerIcrc1Metadata.response`.
final class CyclesLedgerIcrc1MetadataResponse with CandidSerializable {
  final String field0;
  final CyclesLedgerMetadataValue field1;

  const CyclesLedgerIcrc1MetadataResponse({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => CyclesLedgerMetadataValue.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory CyclesLedgerIcrc1MetadataResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerIcrc1MetadataResponse(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<CyclesLedgerMetadataValue, Map>(
        key: '1',
        parse:
            (e) => CyclesLedgerMetadataValue.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory CyclesLedgerIcrc1MetadataResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerIcrc1MetadataResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `CyclesLedgerIcrc1Transfer.response`.
sealed class CyclesLedgerIcrc1TransferResponse with CandidSerializable {
  const CyclesLedgerIcrc1TransferResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => CyclesLedgerTransferError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerIcrc1TransferResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return CyclesLedgerIcrc1TransferResponseOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return CyclesLedgerIcrc1TransferResponseErr(
        json.valueTo<CyclesLedgerTransferError, Map>(
          key: 'Err',
          parse:
              (e) => CyclesLedgerTransferError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerIcrc1TransferResponse.fromCandid',
      reason: 'Unknown CyclesLedgerIcrc1TransferResponse arm',
    );
  }

  factory CyclesLedgerIcrc1TransferResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerIcrc1TransferResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CyclesLedgerIcrc1Transfer.response.Ok`.
final class CyclesLedgerIcrc1TransferResponseOk
    extends CyclesLedgerIcrc1TransferResponse {
  final CyclesLedgerBlockIndex value;
  const CyclesLedgerIcrc1TransferResponseOk(this.value);

  @override
  CType get candidType => CyclesLedgerIcrc1TransferResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `CyclesLedgerIcrc1Transfer.response.Err`.
final class CyclesLedgerIcrc1TransferResponseErr
    extends CyclesLedgerIcrc1TransferResponse {
  final CyclesLedgerTransferError value;
  const CyclesLedgerIcrc1TransferResponseErr(this.value);

  @override
  CType get candidType => CyclesLedgerIcrc1TransferResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `CyclesLedgerIcrc2Approve.response`.
sealed class CyclesLedgerIcrc2ApproveResponse with CandidSerializable {
  const CyclesLedgerIcrc2ApproveResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => CyclesLedgerApproveError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerIcrc2ApproveResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return CyclesLedgerIcrc2ApproveResponseOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return CyclesLedgerIcrc2ApproveResponseErr(
        json.valueTo<CyclesLedgerApproveError, Map>(
          key: 'Err',
          parse:
              (e) => CyclesLedgerApproveError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerIcrc2ApproveResponse.fromCandid',
      reason: 'Unknown CyclesLedgerIcrc2ApproveResponse arm',
    );
  }

  factory CyclesLedgerIcrc2ApproveResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerIcrc2ApproveResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CyclesLedgerIcrc2Approve.response.Ok`.
final class CyclesLedgerIcrc2ApproveResponseOk
    extends CyclesLedgerIcrc2ApproveResponse {
  final BigInt value;
  const CyclesLedgerIcrc2ApproveResponseOk(this.value);

  @override
  CType get candidType => CyclesLedgerIcrc2ApproveResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `CyclesLedgerIcrc2Approve.response.Err`.
final class CyclesLedgerIcrc2ApproveResponseErr
    extends CyclesLedgerIcrc2ApproveResponse {
  final CyclesLedgerApproveError value;
  const CyclesLedgerIcrc2ApproveResponseErr(this.value);

  @override
  CType get candidType => CyclesLedgerIcrc2ApproveResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `CyclesLedgerIcrc2TransferFrom.response`.
sealed class CyclesLedgerIcrc2TransferFromResponse with CandidSerializable {
  const CyclesLedgerIcrc2TransferFromResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => CyclesLedgerTransferFromError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerIcrc2TransferFromResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return CyclesLedgerIcrc2TransferFromResponseOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return CyclesLedgerIcrc2TransferFromResponseErr(
        json.valueTo<CyclesLedgerTransferFromError, Map>(
          key: 'Err',
          parse:
              (e) => CyclesLedgerTransferFromError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerIcrc2TransferFromResponse.fromCandid',
      reason: 'Unknown CyclesLedgerIcrc2TransferFromResponse arm',
    );
  }

  factory CyclesLedgerIcrc2TransferFromResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerIcrc2TransferFromResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CyclesLedgerIcrc2TransferFrom.response.Ok`.
final class CyclesLedgerIcrc2TransferFromResponseOk
    extends CyclesLedgerIcrc2TransferFromResponse {
  final BigInt value;
  const CyclesLedgerIcrc2TransferFromResponseOk(this.value);

  @override
  CType get candidType => CyclesLedgerIcrc2TransferFromResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `CyclesLedgerIcrc2TransferFrom.response.Err`.
final class CyclesLedgerIcrc2TransferFromResponseErr
    extends CyclesLedgerIcrc2TransferFromResponse {
  final CyclesLedgerTransferFromError value;
  const CyclesLedgerIcrc2TransferFromResponseErr(this.value);

  @override
  CType get candidType => CyclesLedgerIcrc2TransferFromResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `CyclesLedgerWithdraw.response`.
sealed class CyclesLedgerWithdrawResponse with CandidSerializable {
  const CyclesLedgerWithdrawResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => CyclesLedgerWithdrawError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerWithdrawResponse.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return CyclesLedgerWithdrawResponseOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return CyclesLedgerWithdrawResponseErr(
        json.valueTo<CyclesLedgerWithdrawError, Map>(
          key: 'Err',
          parse:
              (e) => CyclesLedgerWithdrawError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerWithdrawResponse.fromCandid',
      reason: 'Unknown CyclesLedgerWithdrawResponse arm',
    );
  }

  factory CyclesLedgerWithdrawResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerWithdrawResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CyclesLedgerWithdraw.response.Ok`.
final class CyclesLedgerWithdrawResponseOk
    extends CyclesLedgerWithdrawResponse {
  final CyclesLedgerBlockIndex value;
  const CyclesLedgerWithdrawResponseOk(this.value);

  @override
  CType get candidType => CyclesLedgerWithdrawResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `CyclesLedgerWithdraw.response.Err`.
final class CyclesLedgerWithdrawResponseErr
    extends CyclesLedgerWithdrawResponse {
  final CyclesLedgerWithdrawError value;
  const CyclesLedgerWithdrawResponseErr(this.value);

  @override
  CType get candidType => CyclesLedgerWithdrawResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `CyclesLedgerWithdrawFrom.response`.
sealed class CyclesLedgerWithdrawFromResponse with CandidSerializable {
  const CyclesLedgerWithdrawFromResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => CyclesLedgerWithdrawFromError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerWithdrawFromResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return CyclesLedgerWithdrawFromResponseOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return CyclesLedgerWithdrawFromResponseErr(
        json.valueTo<CyclesLedgerWithdrawFromError, Map>(
          key: 'Err',
          parse:
              (e) => CyclesLedgerWithdrawFromError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerWithdrawFromResponse.fromCandid',
      reason: 'Unknown CyclesLedgerWithdrawFromResponse arm',
    );
  }

  factory CyclesLedgerWithdrawFromResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerWithdrawFromResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CyclesLedgerWithdrawFrom.response.Ok`.
final class CyclesLedgerWithdrawFromResponseOk
    extends CyclesLedgerWithdrawFromResponse {
  final CyclesLedgerBlockIndex value;
  const CyclesLedgerWithdrawFromResponseOk(this.value);

  @override
  CType get candidType => CyclesLedgerWithdrawFromResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `CyclesLedgerWithdrawFrom.response.Err`.
final class CyclesLedgerWithdrawFromResponseErr
    extends CyclesLedgerWithdrawFromResponse {
  final CyclesLedgerWithdrawFromError value;
  const CyclesLedgerWithdrawFromResponseErr(this.value);

  @override
  CType get candidType => CyclesLedgerWithdrawFromResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `Account`.
final class CyclesLedgerAccount with CandidSerializable {
  final IcpPrincipalAddress owner;
  final List<int>? subaccount;

  const CyclesLedgerAccount({required this.owner, this.subaccount});

  static CType get ctype => CType.record([
    Field(Label.named('owner'), CType.principal),
    Field(Label.named('subaccount'), CType.opt(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'owner': owner, 'subaccount': subaccount};

  Map<String, dynamic> toJson() => {
    'owner': owner.address,
    'subaccount': subaccount,
  };

  factory CyclesLedgerAccount.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerAccount(
      owner: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'owner',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      subaccount: json.valueAsBytes<List<int>?>(
        'subaccount',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory CyclesLedgerAccount.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerAccount.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Allowance`.
final class CyclesLedgerAllowance with CandidSerializable {
  final BigInt allowance;
  final BigInt? expiresAt;

  const CyclesLedgerAllowance({required this.allowance, this.expiresAt});

  static CType get ctype => CType.record([
    Field(Label.named('allowance'), CType.nat),
    Field(Label.named('expires_at'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'allowance': allowance, 'expires_at': expiresAt};

  Map<String, dynamic> toJson() => {
    'allowance': allowance,
    'expires_at': expiresAt,
  };

  factory CyclesLedgerAllowance.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerAllowance(
      allowance: json.valueAsBigInt<BigInt>('allowance'),
      expiresAt: json.valueAsBigInt<BigInt?>('expires_at'),
    );
  }

  factory CyclesLedgerAllowance.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerAllowance.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AllowanceArgs`.
final class CyclesLedgerAllowanceArgs with CandidSerializable {
  final CyclesLedgerAccount account;
  final CyclesLedgerAccount spender;

  const CyclesLedgerAllowanceArgs({
    required this.account,
    required this.spender,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('account'), () => CyclesLedgerAccount.ctype),
    LazyField(Label.named('spender'), () => CyclesLedgerAccount.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'account': account.candidValue,
    'spender': spender.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'account': account.toJson(),
    'spender': spender.toJson(),
  };

  factory CyclesLedgerAllowanceArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerAllowanceArgs(
      account: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'account',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      spender: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'spender',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory CyclesLedgerAllowanceArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerAllowanceArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ApproveArgs`.
final class CyclesLedgerApproveArgs with CandidSerializable {
  final BigInt? fee;
  final List<int>? memo;
  final List<int>? fromSubaccount;
  final BigInt? createdAtTime;
  final BigInt amount;
  final BigInt? expectedAllowance;
  final BigInt? expiresAt;
  final CyclesLedgerAccount spender;

  const CyclesLedgerApproveArgs({
    this.fee,
    this.memo,
    this.fromSubaccount,
    this.createdAtTime,
    required this.amount,
    this.expectedAllowance,
    this.expiresAt,
    required this.spender,
  });

  static CType get ctype => CType.record([
    Field(Label.named('fee'), CType.opt(CType.nat)),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
    Field(Label.named('amount'), CType.nat),
    Field(Label.named('expected_allowance'), CType.opt(CType.nat)),
    Field(Label.named('expires_at'), CType.opt(CType.nat64)),
    LazyField(Label.named('spender'), () => CyclesLedgerAccount.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'fee': fee,
    'memo': memo,
    'from_subaccount': fromSubaccount,
    'created_at_time': createdAtTime,
    'amount': amount,
    'expected_allowance': expectedAllowance,
    'expires_at': expiresAt,
    'spender': spender.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'fee': fee,
    'memo': memo,
    'from_subaccount': fromSubaccount,
    'created_at_time': createdAtTime,
    'amount': amount,
    'expected_allowance': expectedAllowance,
    'expires_at': expiresAt,
    'spender': spender.toJson(),
  };

  factory CyclesLedgerApproveArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerApproveArgs(
      fee: json.valueAsBigInt<BigInt?>('fee'),
      memo: json.valueAsBytes<List<int>?>(
        'memo',
        encoding: StringEncoding.base64,
      ),
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
      amount: json.valueAsBigInt<BigInt>('amount'),
      expectedAllowance: json.valueAsBigInt<BigInt?>('expected_allowance'),
      expiresAt: json.valueAsBigInt<BigInt?>('expires_at'),
      spender: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'spender',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory CyclesLedgerApproveArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerApproveArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ApproveError`.
sealed class CyclesLedgerApproveError with CandidSerializable {
  const CyclesLedgerApproveError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('message'), CType.text),
        Field(Label.named('error_code'), CType.nat),
      ]),
    ),
    Field(Label.named('TemporarilyUnavailable'), CType.null_),
    Field(
      Label.named('Duplicate'),
      CType.record([Field(Label.named('duplicate_of'), CType.nat)]),
    ),
    Field(
      Label.named('BadFee'),
      CType.record([Field(Label.named('expected_fee'), CType.nat)]),
    ),
    Field(
      Label.named('AllowanceChanged'),
      CType.record([Field(Label.named('current_allowance'), CType.nat)]),
    ),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('Expired'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(
      Label.named('InsufficientFunds'),
      CType.record([Field(Label.named('balance'), CType.nat)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerApproveError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('GenericError')) {
      return CyclesLedgerApproveErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const CyclesLedgerApproveErrorTemporarilyUnavailable();
    }
    if (json.containsKey('Duplicate')) {
      return CyclesLedgerApproveErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('BadFee')) {
      return CyclesLedgerApproveErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('AllowanceChanged')) {
      return CyclesLedgerApproveErrorAllowanceChanged.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['AllowanceChanged']),
      );
    }
    if (json.containsKey('CreatedInFuture')) {
      return CyclesLedgerApproveErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const CyclesLedgerApproveErrorTooOld();
    }
    if (json.containsKey('Expired')) {
      return CyclesLedgerApproveErrorExpired.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Expired']),
      );
    }
    if (json.containsKey('InsufficientFunds')) {
      return CyclesLedgerApproveErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerApproveError.fromCandid',
      reason: 'Unknown CyclesLedgerApproveError arm',
    );
  }

  factory CyclesLedgerApproveError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerApproveError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ApproveError.GenericError`.
final class CyclesLedgerApproveErrorGenericError
    extends CyclesLedgerApproveError {
  final String message;
  final BigInt errorCode;

  const CyclesLedgerApproveErrorGenericError({
    required this.message,
    required this.errorCode,
  });

  @override
  CType get candidType => CyclesLedgerApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'message': message, 'error_code': errorCode});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'message': message, 'error_code': errorCode},
  };

  factory CyclesLedgerApproveErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerApproveErrorGenericError(
      message: json.valueAsString<String>('message'),
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
    );
  }
}

/// Variant arm `ApproveError.TemporarilyUnavailable` (nullary).
final class CyclesLedgerApproveErrorTemporarilyUnavailable
    extends CyclesLedgerApproveError {
  const CyclesLedgerApproveErrorTemporarilyUnavailable();

  @override
  CType get candidType => CyclesLedgerApproveError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `ApproveError.Duplicate`.
final class CyclesLedgerApproveErrorDuplicate extends CyclesLedgerApproveError {
  final BigInt duplicateOf;

  const CyclesLedgerApproveErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => CyclesLedgerApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory CyclesLedgerApproveErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerApproveErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `ApproveError.BadFee`.
final class CyclesLedgerApproveErrorBadFee extends CyclesLedgerApproveError {
  final BigInt expectedFee;

  const CyclesLedgerApproveErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => CyclesLedgerApproveError.ctype;

  @override
  dynamic get candidValue => Variant('BadFee', {'expected_fee': expectedFee});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee},
  };

  factory CyclesLedgerApproveErrorBadFee.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerApproveErrorBadFee(
      expectedFee: json.valueAsBigInt<BigInt>('expected_fee'),
    );
  }
}

/// Variant arm `ApproveError.AllowanceChanged`.
final class CyclesLedgerApproveErrorAllowanceChanged
    extends CyclesLedgerApproveError {
  final BigInt currentAllowance;

  const CyclesLedgerApproveErrorAllowanceChanged({
    required this.currentAllowance,
  });

  @override
  CType get candidType => CyclesLedgerApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('AllowanceChanged', {'current_allowance': currentAllowance});

  @override
  Map<String, dynamic> toJson() => {
    'AllowanceChanged': {'current_allowance': currentAllowance},
  };

  factory CyclesLedgerApproveErrorAllowanceChanged.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerApproveErrorAllowanceChanged(
      currentAllowance: json.valueAsBigInt<BigInt>('current_allowance'),
    );
  }
}

/// Variant arm `ApproveError.CreatedInFuture`.
final class CyclesLedgerApproveErrorCreatedInFuture
    extends CyclesLedgerApproveError {
  final BigInt ledgerTime;

  const CyclesLedgerApproveErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => CyclesLedgerApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory CyclesLedgerApproveErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerApproveErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `ApproveError.TooOld` (nullary).
final class CyclesLedgerApproveErrorTooOld extends CyclesLedgerApproveError {
  const CyclesLedgerApproveErrorTooOld();

  @override
  CType get candidType => CyclesLedgerApproveError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `ApproveError.Expired`.
final class CyclesLedgerApproveErrorExpired extends CyclesLedgerApproveError {
  final BigInt ledgerTime;

  const CyclesLedgerApproveErrorExpired({required this.ledgerTime});

  @override
  CType get candidType => CyclesLedgerApproveError.ctype;

  @override
  dynamic get candidValue => Variant('Expired', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'Expired': {'ledger_time': ledgerTime},
  };

  factory CyclesLedgerApproveErrorExpired.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerApproveErrorExpired(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `ApproveError.InsufficientFunds`.
final class CyclesLedgerApproveErrorInsufficientFunds
    extends CyclesLedgerApproveError {
  final BigInt balance;

  const CyclesLedgerApproveErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => CyclesLedgerApproveError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory CyclesLedgerApproveErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerApproveErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Candid record `CanisterSettings`.
final class CyclesLedgerCanisterSettings with CandidSerializable {
  final BigInt? freezingThreshold;
  final List<IcpPrincipalAddress>? controllers;
  final BigInt? reservedCyclesLimit;
  final BigInt? memoryAllocation;
  final BigInt? computeAllocation;

  const CyclesLedgerCanisterSettings({
    this.freezingThreshold,
    this.controllers,
    this.reservedCyclesLimit,
    this.memoryAllocation,
    this.computeAllocation,
  });

  static CType get ctype => CType.record([
    Field(Label.named('freezing_threshold'), CType.opt(CType.nat)),
    Field(Label.named('controllers'), CType.opt(CType.vec(CType.principal))),
    Field(Label.named('reserved_cycles_limit'), CType.opt(CType.nat)),
    Field(Label.named('memory_allocation'), CType.opt(CType.nat)),
    Field(Label.named('compute_allocation'), CType.opt(CType.nat)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'freezing_threshold': freezingThreshold,
    'controllers': controllers,
    'reserved_cycles_limit': reservedCyclesLimit,
    'memory_allocation': memoryAllocation,
    'compute_allocation': computeAllocation,
  };

  Map<String, dynamic> toJson() => {
    'freezing_threshold': freezingThreshold,
    'controllers': controllers?.map((el) => el.address).toList(),
    'reserved_cycles_limit': reservedCyclesLimit,
    'memory_allocation': memoryAllocation,
    'compute_allocation': computeAllocation,
  };

  factory CyclesLedgerCanisterSettings.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerCanisterSettings(
      freezingThreshold: json.valueAsBigInt<BigInt?>('freezing_threshold'),
      controllers: json.valueTo<List<IcpPrincipalAddress>?, List>(
        key: 'controllers',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      reservedCyclesLimit: json.valueAsBigInt<BigInt?>('reserved_cycles_limit'),
      memoryAllocation: json.valueAsBigInt<BigInt?>('memory_allocation'),
      computeAllocation: json.valueAsBigInt<BigInt?>('compute_allocation'),
    );
  }

  factory CyclesLedgerCanisterSettings.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerCanisterSettings.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ChangeIndexId`.
sealed class CyclesLedgerChangeIndexId with CandidSerializable {
  const CyclesLedgerChangeIndexId();

  static CType get ctype => CType.variant([
    Field(Label.named('SetTo'), CType.principal),
    Field(Label.named('Unset'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerChangeIndexId.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('SetTo')) {
      return CyclesLedgerChangeIndexIdSetTo(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'SetTo',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('Unset')) {
      return const CyclesLedgerChangeIndexIdUnset();
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerChangeIndexId.fromCandid',
      reason: 'Unknown CyclesLedgerChangeIndexId arm',
    );
  }

  factory CyclesLedgerChangeIndexId.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerChangeIndexId.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ChangeIndexId.SetTo`.
final class CyclesLedgerChangeIndexIdSetTo extends CyclesLedgerChangeIndexId {
  final IcpPrincipalAddress value;
  const CyclesLedgerChangeIndexIdSetTo(this.value);

  @override
  CType get candidType => CyclesLedgerChangeIndexId.ctype;

  @override
  dynamic get candidValue => Variant('SetTo', value);

  @override
  Map<String, dynamic> toJson() => {'SetTo': value.address};
}

/// Variant arm `ChangeIndexId.Unset` (nullary).
final class CyclesLedgerChangeIndexIdUnset extends CyclesLedgerChangeIndexId {
  const CyclesLedgerChangeIndexIdUnset();

  @override
  CType get candidType => CyclesLedgerChangeIndexId.ctype;

  @override
  dynamic get candidValue => const Variant('Unset', null);

  @override
  Map<String, dynamic> toJson() => {'Unset': null};
}

/// Candid record `CmcCreateCanisterArgs`.
final class CyclesLedgerCmcCreateCanisterArgs with CandidSerializable {
  final CyclesLedgerSubnetSelection? subnetSelection;
  final CyclesLedgerCanisterSettings? settings;

  const CyclesLedgerCmcCreateCanisterArgs({
    this.subnetSelection,
    this.settings,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('subnet_selection'),
      () => CType.opt(CyclesLedgerSubnetSelection.ctype),
    ),
    LazyField(
      Label.named('settings'),
      () => CType.opt(CyclesLedgerCanisterSettings.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'subnet_selection': subnetSelection?.candidValue,
    'settings': settings?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'subnet_selection': subnetSelection?.toJson(),
    'settings': settings?.toJson(),
  };

  factory CyclesLedgerCmcCreateCanisterArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCmcCreateCanisterArgs(
      subnetSelection: json.valueTo<CyclesLedgerSubnetSelection?, Map>(
        key: 'subnet_selection',
        parse:
            (e) => CyclesLedgerSubnetSelection.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      settings: json.valueTo<CyclesLedgerCanisterSettings?, Map>(
        key: 'settings',
        parse:
            (e) => CyclesLedgerCanisterSettings.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory CyclesLedgerCmcCreateCanisterArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerCmcCreateCanisterArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `CreateCanisterArgs`.
final class CyclesLedgerCreateCanisterArgs with CandidSerializable {
  final List<int>? fromSubaccount;
  final BigInt? createdAtTime;
  final BigInt amount;
  final CyclesLedgerCmcCreateCanisterArgs? creationArgs;

  const CyclesLedgerCreateCanisterArgs({
    this.fromSubaccount,
    this.createdAtTime,
    required this.amount,
    this.creationArgs,
  });

  static CType get ctype => CType.record([
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
    Field(Label.named('amount'), CType.nat),
    LazyField(
      Label.named('creation_args'),
      () => CType.opt(CyclesLedgerCmcCreateCanisterArgs.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'from_subaccount': fromSubaccount,
    'created_at_time': createdAtTime,
    'amount': amount,
    'creation_args': creationArgs?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'from_subaccount': fromSubaccount,
    'created_at_time': createdAtTime,
    'amount': amount,
    'creation_args': creationArgs?.toJson(),
  };

  factory CyclesLedgerCreateCanisterArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerCreateCanisterArgs(
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
      amount: json.valueAsBigInt<BigInt>('amount'),
      creationArgs: json.valueTo<CyclesLedgerCmcCreateCanisterArgs?, Map>(
        key: 'creation_args',
        parse:
            (e) => CyclesLedgerCmcCreateCanisterArgs.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory CyclesLedgerCreateCanisterArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerCreateCanisterArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `CreateCanisterError`.
sealed class CyclesLedgerCreateCanisterError with CandidSerializable {
  const CyclesLedgerCreateCanisterError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('message'), CType.text),
        Field(Label.named('error_code'), CType.nat),
      ]),
    ),
    Field(Label.named('TemporarilyUnavailable'), CType.null_),
    Field(
      Label.named('Duplicate'),
      CType.record([
        Field(Label.named('duplicate_of'), CType.nat),
        Field(Label.named('canister_id'), CType.opt(CType.principal)),
      ]),
    ),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(
      Label.named('FailedToCreate'),
      CType.record([
        Field(Label.named('error'), CType.text),
        Field(Label.named('refund_block'), CType.opt(CType.nat)),
        Field(Label.named('fee_block'), CType.opt(CType.nat)),
      ]),
    ),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('InsufficientFunds'),
      CType.record([Field(Label.named('balance'), CType.nat)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerCreateCanisterError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('GenericError')) {
      return CyclesLedgerCreateCanisterErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const CyclesLedgerCreateCanisterErrorTemporarilyUnavailable();
    }
    if (json.containsKey('Duplicate')) {
      return CyclesLedgerCreateCanisterErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('CreatedInFuture')) {
      return CyclesLedgerCreateCanisterErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('FailedToCreate')) {
      return CyclesLedgerCreateCanisterErrorFailedToCreate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['FailedToCreate']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const CyclesLedgerCreateCanisterErrorTooOld();
    }
    if (json.containsKey('InsufficientFunds')) {
      return CyclesLedgerCreateCanisterErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerCreateCanisterError.fromCandid',
      reason: 'Unknown CyclesLedgerCreateCanisterError arm',
    );
  }

  factory CyclesLedgerCreateCanisterError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerCreateCanisterError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CreateCanisterError.GenericError`.
final class CyclesLedgerCreateCanisterErrorGenericError
    extends CyclesLedgerCreateCanisterError {
  final String message;
  final BigInt errorCode;

  const CyclesLedgerCreateCanisterErrorGenericError({
    required this.message,
    required this.errorCode,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'message': message, 'error_code': errorCode});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'message': message, 'error_code': errorCode},
  };

  factory CyclesLedgerCreateCanisterErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterErrorGenericError(
      message: json.valueAsString<String>('message'),
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
    );
  }
}

/// Variant arm `CreateCanisterError.TemporarilyUnavailable` (nullary).
final class CyclesLedgerCreateCanisterErrorTemporarilyUnavailable
    extends CyclesLedgerCreateCanisterError {
  const CyclesLedgerCreateCanisterErrorTemporarilyUnavailable();

  @override
  CType get candidType => CyclesLedgerCreateCanisterError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `CreateCanisterError.Duplicate`.
final class CyclesLedgerCreateCanisterErrorDuplicate
    extends CyclesLedgerCreateCanisterError {
  final BigInt duplicateOf;
  final IcpPrincipalAddress? canisterId;

  const CyclesLedgerCreateCanisterErrorDuplicate({
    required this.duplicateOf,
    this.canisterId,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterError.ctype;

  @override
  dynamic get candidValue => Variant('Duplicate', {
    'duplicate_of': duplicateOf,
    'canister_id': canisterId,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {
      'duplicate_of': duplicateOf,
      'canister_id': canisterId?.address,
    },
  };

  factory CyclesLedgerCreateCanisterErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }
}

/// Variant arm `CreateCanisterError.CreatedInFuture`.
final class CyclesLedgerCreateCanisterErrorCreatedInFuture
    extends CyclesLedgerCreateCanisterError {
  final BigInt ledgerTime;

  const CyclesLedgerCreateCanisterErrorCreatedInFuture({
    required this.ledgerTime,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory CyclesLedgerCreateCanisterErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `CreateCanisterError.FailedToCreate`.
final class CyclesLedgerCreateCanisterErrorFailedToCreate
    extends CyclesLedgerCreateCanisterError {
  final String error;
  final CyclesLedgerBlockIndex? refundBlock;
  final CyclesLedgerBlockIndex? feeBlock;

  const CyclesLedgerCreateCanisterErrorFailedToCreate({
    required this.error,
    this.refundBlock,
    this.feeBlock,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterError.ctype;

  @override
  dynamic get candidValue => Variant('FailedToCreate', {
    'error': error,
    'refund_block': refundBlock,
    'fee_block': feeBlock,
  });

  @override
  Map<String, dynamic> toJson() => {
    'FailedToCreate': {
      'error': error,
      'refund_block': refundBlock,
      'fee_block': feeBlock,
    },
  };

  factory CyclesLedgerCreateCanisterErrorFailedToCreate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterErrorFailedToCreate(
      error: json.valueAsString<String>('error'),
      refundBlock: json.valueAsBigInt<BigInt?>('refund_block'),
      feeBlock: json.valueAsBigInt<BigInt?>('fee_block'),
    );
  }
}

/// Variant arm `CreateCanisterError.TooOld` (nullary).
final class CyclesLedgerCreateCanisterErrorTooOld
    extends CyclesLedgerCreateCanisterError {
  const CyclesLedgerCreateCanisterErrorTooOld();

  @override
  CType get candidType => CyclesLedgerCreateCanisterError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `CreateCanisterError.InsufficientFunds`.
final class CyclesLedgerCreateCanisterErrorInsufficientFunds
    extends CyclesLedgerCreateCanisterError {
  final BigInt balance;

  const CyclesLedgerCreateCanisterErrorInsufficientFunds({
    required this.balance,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory CyclesLedgerCreateCanisterErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Candid record `CreateCanisterFromArgs`.
final class CyclesLedgerCreateCanisterFromArgs with CandidSerializable {
  final List<int>? spenderSubaccount;
  final CyclesLedgerAccount from;
  final BigInt? createdAtTime;
  final BigInt amount;
  final CyclesLedgerCmcCreateCanisterArgs? creationArgs;

  const CyclesLedgerCreateCanisterFromArgs({
    this.spenderSubaccount,
    required this.from,
    this.createdAtTime,
    required this.amount,
    this.creationArgs,
  });

  static CType get ctype => CType.record([
    Field(Label.named('spender_subaccount'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('from'), () => CyclesLedgerAccount.ctype),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
    Field(Label.named('amount'), CType.nat),
    LazyField(
      Label.named('creation_args'),
      () => CType.opt(CyclesLedgerCmcCreateCanisterArgs.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'spender_subaccount': spenderSubaccount,
    'from': from.candidValue,
    'created_at_time': createdAtTime,
    'amount': amount,
    'creation_args': creationArgs?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'spender_subaccount': spenderSubaccount,
    'from': from.toJson(),
    'created_at_time': createdAtTime,
    'amount': amount,
    'creation_args': creationArgs?.toJson(),
  };

  factory CyclesLedgerCreateCanisterFromArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterFromArgs(
      spenderSubaccount: json.valueAsBytes<List<int>?>(
        'spender_subaccount',
        encoding: StringEncoding.base64,
      ),
      from: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'from',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
      amount: json.valueAsBigInt<BigInt>('amount'),
      creationArgs: json.valueTo<CyclesLedgerCmcCreateCanisterArgs?, Map>(
        key: 'creation_args',
        parse:
            (e) => CyclesLedgerCmcCreateCanisterArgs.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory CyclesLedgerCreateCanisterFromArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerCreateCanisterFromArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `CreateCanisterFromError`.
sealed class CyclesLedgerCreateCanisterFromError with CandidSerializable {
  const CyclesLedgerCreateCanisterFromError();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('FailedToCreateFrom'),
      () => CType.record([
        Field(Label.named('create_from_block'), CType.opt(CType.nat)),
        LazyField(
          Label.named('rejection_code'),
          () => CyclesLedgerRejectionCode.ctype,
        ),
        Field(Label.named('refund_block'), CType.opt(CType.nat)),
        Field(Label.named('approval_refund_block'), CType.opt(CType.nat)),
        Field(Label.named('rejection_reason'), CType.text),
      ]),
    ),
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('message'), CType.text),
        Field(Label.named('error_code'), CType.nat),
      ]),
    ),
    Field(Label.named('TemporarilyUnavailable'), CType.null_),
    Field(
      Label.named('InsufficientAllowance'),
      CType.record([Field(Label.named('allowance'), CType.nat)]),
    ),
    Field(
      Label.named('Duplicate'),
      CType.record([
        Field(Label.named('duplicate_of'), CType.nat),
        Field(Label.named('canister_id'), CType.opt(CType.principal)),
      ]),
    ),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('InsufficientFunds'),
      CType.record([Field(Label.named('balance'), CType.nat)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerCreateCanisterFromError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('FailedToCreateFrom')) {
      return CyclesLedgerCreateCanisterFromErrorFailedToCreateFrom.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['FailedToCreateFrom'],
        ),
      );
    }
    if (json.containsKey('GenericError')) {
      return CyclesLedgerCreateCanisterFromErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const CyclesLedgerCreateCanisterFromErrorTemporarilyUnavailable();
    }
    if (json.containsKey('InsufficientAllowance')) {
      return CyclesLedgerCreateCanisterFromErrorInsufficientAllowance.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['InsufficientAllowance'],
        ),
      );
    }
    if (json.containsKey('Duplicate')) {
      return CyclesLedgerCreateCanisterFromErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('CreatedInFuture')) {
      return CyclesLedgerCreateCanisterFromErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const CyclesLedgerCreateCanisterFromErrorTooOld();
    }
    if (json.containsKey('InsufficientFunds')) {
      return CyclesLedgerCreateCanisterFromErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerCreateCanisterFromError.fromCandid',
      reason: 'Unknown CyclesLedgerCreateCanisterFromError arm',
    );
  }

  factory CyclesLedgerCreateCanisterFromError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerCreateCanisterFromError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `CreateCanisterFromError.FailedToCreateFrom`.
final class CyclesLedgerCreateCanisterFromErrorFailedToCreateFrom
    extends CyclesLedgerCreateCanisterFromError {
  final CyclesLedgerBlockIndex? createFromBlock;
  final CyclesLedgerRejectionCode rejectionCode;
  final CyclesLedgerBlockIndex? refundBlock;
  final CyclesLedgerBlockIndex? approvalRefundBlock;
  final String rejectionReason;

  const CyclesLedgerCreateCanisterFromErrorFailedToCreateFrom({
    this.createFromBlock,
    required this.rejectionCode,
    this.refundBlock,
    this.approvalRefundBlock,
    required this.rejectionReason,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterFromError.ctype;

  @override
  dynamic get candidValue => Variant('FailedToCreateFrom', {
    'create_from_block': createFromBlock,
    'rejection_code': rejectionCode.candidValue,
    'refund_block': refundBlock,
    'approval_refund_block': approvalRefundBlock,
    'rejection_reason': rejectionReason,
  });

  @override
  Map<String, dynamic> toJson() => {
    'FailedToCreateFrom': {
      'create_from_block': createFromBlock,
      'rejection_code': rejectionCode.toJson(),
      'refund_block': refundBlock,
      'approval_refund_block': approvalRefundBlock,
      'rejection_reason': rejectionReason,
    },
  };

  factory CyclesLedgerCreateCanisterFromErrorFailedToCreateFrom.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterFromErrorFailedToCreateFrom(
      createFromBlock: json.valueAsBigInt<BigInt?>('create_from_block'),
      rejectionCode: json.valueTo<CyclesLedgerRejectionCode, Map>(
        key: 'rejection_code',
        parse:
            (e) => CyclesLedgerRejectionCode.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      refundBlock: json.valueAsBigInt<BigInt?>('refund_block'),
      approvalRefundBlock: json.valueAsBigInt<BigInt?>('approval_refund_block'),
      rejectionReason: json.valueAsString<String>('rejection_reason'),
    );
  }
}

/// Variant arm `CreateCanisterFromError.GenericError`.
final class CyclesLedgerCreateCanisterFromErrorGenericError
    extends CyclesLedgerCreateCanisterFromError {
  final String message;
  final BigInt errorCode;

  const CyclesLedgerCreateCanisterFromErrorGenericError({
    required this.message,
    required this.errorCode,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'message': message, 'error_code': errorCode});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'message': message, 'error_code': errorCode},
  };

  factory CyclesLedgerCreateCanisterFromErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterFromErrorGenericError(
      message: json.valueAsString<String>('message'),
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
    );
  }
}

/// Variant arm `CreateCanisterFromError.TemporarilyUnavailable` (nullary).
final class CyclesLedgerCreateCanisterFromErrorTemporarilyUnavailable
    extends CyclesLedgerCreateCanisterFromError {
  const CyclesLedgerCreateCanisterFromErrorTemporarilyUnavailable();

  @override
  CType get candidType => CyclesLedgerCreateCanisterFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `CreateCanisterFromError.InsufficientAllowance`.
final class CyclesLedgerCreateCanisterFromErrorInsufficientAllowance
    extends CyclesLedgerCreateCanisterFromError {
  final BigInt allowance;

  const CyclesLedgerCreateCanisterFromErrorInsufficientAllowance({
    required this.allowance,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('InsufficientAllowance', {'allowance': allowance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientAllowance': {'allowance': allowance},
  };

  factory CyclesLedgerCreateCanisterFromErrorInsufficientAllowance.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterFromErrorInsufficientAllowance(
      allowance: json.valueAsBigInt<BigInt>('allowance'),
    );
  }
}

/// Variant arm `CreateCanisterFromError.Duplicate`.
final class CyclesLedgerCreateCanisterFromErrorDuplicate
    extends CyclesLedgerCreateCanisterFromError {
  final BigInt duplicateOf;
  final IcpPrincipalAddress? canisterId;

  const CyclesLedgerCreateCanisterFromErrorDuplicate({
    required this.duplicateOf,
    this.canisterId,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterFromError.ctype;

  @override
  dynamic get candidValue => Variant('Duplicate', {
    'duplicate_of': duplicateOf,
    'canister_id': canisterId,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {
      'duplicate_of': duplicateOf,
      'canister_id': canisterId?.address,
    },
  };

  factory CyclesLedgerCreateCanisterFromErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterFromErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }
}

/// Variant arm `CreateCanisterFromError.CreatedInFuture`.
final class CyclesLedgerCreateCanisterFromErrorCreatedInFuture
    extends CyclesLedgerCreateCanisterFromError {
  final BigInt ledgerTime;

  const CyclesLedgerCreateCanisterFromErrorCreatedInFuture({
    required this.ledgerTime,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory CyclesLedgerCreateCanisterFromErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterFromErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `CreateCanisterFromError.TooOld` (nullary).
final class CyclesLedgerCreateCanisterFromErrorTooOld
    extends CyclesLedgerCreateCanisterFromError {
  const CyclesLedgerCreateCanisterFromErrorTooOld();

  @override
  CType get candidType => CyclesLedgerCreateCanisterFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `CreateCanisterFromError.InsufficientFunds`.
final class CyclesLedgerCreateCanisterFromErrorInsufficientFunds
    extends CyclesLedgerCreateCanisterFromError {
  final BigInt balance;

  const CyclesLedgerCreateCanisterFromErrorInsufficientFunds({
    required this.balance,
  });

  @override
  CType get candidType => CyclesLedgerCreateCanisterFromError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory CyclesLedgerCreateCanisterFromErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterFromErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Candid record `CreateCanisterSuccess`.
final class CyclesLedgerCreateCanisterSuccess with CandidSerializable {
  final CyclesLedgerBlockIndex blockId;
  final IcpPrincipalAddress canisterId;

  const CyclesLedgerCreateCanisterSuccess({
    required this.blockId,
    required this.canisterId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('block_id'), CType.nat),
    Field(Label.named('canister_id'), CType.principal),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'block_id': blockId, 'canister_id': canisterId};

  Map<String, dynamic> toJson() => {
    'block_id': blockId,
    'canister_id': canisterId.address,
  };

  factory CyclesLedgerCreateCanisterSuccess.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerCreateCanisterSuccess(
      blockId: json.valueAsBigInt<BigInt>('block_id'),
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory CyclesLedgerCreateCanisterSuccess.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerCreateCanisterSuccess.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DataCertificate`.
final class CyclesLedgerDataCertificate with CandidSerializable {
  final List<int> certificate;
  final List<int> hashTree;

  const CyclesLedgerDataCertificate({
    required this.certificate,
    required this.hashTree,
  });

  static CType get ctype => CType.record([
    Field(Label.named('certificate'), CType.vec(CType.nat8)),
    Field(Label.named('hash_tree'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'certificate': certificate,
    'hash_tree': hashTree,
  };

  Map<String, dynamic> toJson() => {
    'certificate': certificate,
    'hash_tree': hashTree,
  };

  factory CyclesLedgerDataCertificate.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerDataCertificate(
      certificate: json.valueAsBytes<List<int>>(
        'certificate',
        encoding: StringEncoding.base64,
      ),
      hashTree: json.valueAsBytes<List<int>>(
        'hash_tree',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory CyclesLedgerDataCertificate.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerDataCertificate.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DepositArgs`.
final class CyclesLedgerDepositArgs with CandidSerializable {
  final CyclesLedgerAccount to;
  final List<int>? memo;

  const CyclesLedgerDepositArgs({required this.to, this.memo});

  static CType get ctype => CType.record([
    LazyField(Label.named('to'), () => CyclesLedgerAccount.ctype),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'to': to.candidValue, 'memo': memo};

  Map<String, dynamic> toJson() => {'to': to.toJson(), 'memo': memo};

  factory CyclesLedgerDepositArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerDepositArgs(
      to: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'to',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      memo: json.valueAsBytes<List<int>?>(
        'memo',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory CyclesLedgerDepositArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerDepositArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DepositResult`.
final class CyclesLedgerDepositResult with CandidSerializable {
  final BigInt balance;
  final CyclesLedgerBlockIndex blockIndex;

  const CyclesLedgerDepositResult({
    required this.balance,
    required this.blockIndex,
  });

  static CType get ctype => CType.record([
    Field(Label.named('balance'), CType.nat),
    Field(Label.named('block_index'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'balance': balance, 'block_index': blockIndex};

  Map<String, dynamic> toJson() => {
    'balance': balance,
    'block_index': blockIndex,
  };

  factory CyclesLedgerDepositResult.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerDepositResult(
      balance: json.valueAsBigInt<BigInt>('balance'),
      blockIndex: json.valueAsBigInt<BigInt>('block_index'),
    );
  }

  factory CyclesLedgerDepositResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerDepositResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetAllowancesArgs`.
final class CyclesLedgerGetAllowancesArgs with CandidSerializable {
  final BigInt? take;
  final CyclesLedgerAccount? prevSpender;
  final CyclesLedgerAccount? fromAccount;

  const CyclesLedgerGetAllowancesArgs({
    this.take,
    this.prevSpender,
    this.fromAccount,
  });

  static CType get ctype => CType.record([
    Field(Label.named('take'), CType.opt(CType.nat)),
    LazyField(
      Label.named('prev_spender'),
      () => CType.opt(CyclesLedgerAccount.ctype),
    ),
    LazyField(
      Label.named('from_account'),
      () => CType.opt(CyclesLedgerAccount.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'take': take,
    'prev_spender': prevSpender?.candidValue,
    'from_account': fromAccount?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'take': take,
    'prev_spender': prevSpender?.toJson(),
    'from_account': fromAccount?.toJson(),
  };

  factory CyclesLedgerGetAllowancesArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerGetAllowancesArgs(
      take: json.valueAsBigInt<BigInt?>('take'),
      prevSpender: json.valueTo<CyclesLedgerAccount?, Map>(
        key: 'prev_spender',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fromAccount: json.valueTo<CyclesLedgerAccount?, Map>(
        key: 'from_account',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory CyclesLedgerGetAllowancesArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerGetAllowancesArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `GetAllowancesError`.
sealed class CyclesLedgerGetAllowancesError with CandidSerializable {
  const CyclesLedgerGetAllowancesError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('message'), CType.text),
        Field(Label.named('error_code'), CType.nat),
      ]),
    ),
    Field(
      Label.named('AccessDenied'),
      CType.record([Field(Label.named('reason'), CType.text)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerGetAllowancesError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('GenericError')) {
      return CyclesLedgerGetAllowancesErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('AccessDenied')) {
      return CyclesLedgerGetAllowancesErrorAccessDenied.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['AccessDenied']),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerGetAllowancesError.fromCandid',
      reason: 'Unknown CyclesLedgerGetAllowancesError arm',
    );
  }

  factory CyclesLedgerGetAllowancesError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerGetAllowancesError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetAllowancesError.GenericError`.
final class CyclesLedgerGetAllowancesErrorGenericError
    extends CyclesLedgerGetAllowancesError {
  final String message;
  final BigInt errorCode;

  const CyclesLedgerGetAllowancesErrorGenericError({
    required this.message,
    required this.errorCode,
  });

  @override
  CType get candidType => CyclesLedgerGetAllowancesError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'message': message, 'error_code': errorCode});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'message': message, 'error_code': errorCode},
  };

  factory CyclesLedgerGetAllowancesErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerGetAllowancesErrorGenericError(
      message: json.valueAsString<String>('message'),
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
    );
  }
}

/// Variant arm `GetAllowancesError.AccessDenied`.
final class CyclesLedgerGetAllowancesErrorAccessDenied
    extends CyclesLedgerGetAllowancesError {
  final String reason;

  const CyclesLedgerGetAllowancesErrorAccessDenied({required this.reason});

  @override
  CType get candidType => CyclesLedgerGetAllowancesError.ctype;

  @override
  dynamic get candidValue => Variant('AccessDenied', {'reason': reason});

  @override
  Map<String, dynamic> toJson() => {
    'AccessDenied': {'reason': reason},
  };

  factory CyclesLedgerGetAllowancesErrorAccessDenied.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerGetAllowancesErrorAccessDenied(
      reason: json.valueAsString<String>('reason'),
    );
  }
}

/// Candid record `GetArchivesArgs`.
final class CyclesLedgerGetArchivesArgs with CandidSerializable {
  final IcpPrincipalAddress? from;

  const CyclesLedgerGetArchivesArgs({this.from});

  static CType get ctype =>
      CType.record([Field(Label.named('from'), CType.opt(CType.principal))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'from': from};

  Map<String, dynamic> toJson() => {'from': from?.address};

  factory CyclesLedgerGetArchivesArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerGetArchivesArgs(
      from: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'from',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory CyclesLedgerGetArchivesArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerGetArchivesArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetBlocksResult`.
final class CyclesLedgerGetBlocksResult with CandidSerializable {
  final BigInt logLength;
  final List<CyclesLedgerGetBlocksResultBlocks> blocks;
  final List<CyclesLedgerGetBlocksResultArchivedBlocks> archivedBlocks;

  const CyclesLedgerGetBlocksResult({
    required this.logLength,
    required this.blocks,
    required this.archivedBlocks,
  });

  static CType get ctype => CType.record([
    Field(Label.named('log_length'), CType.nat),
    LazyField(
      Label.named('blocks'),
      () => CType.vec(CyclesLedgerGetBlocksResultBlocks.ctype),
    ),
    LazyField(
      Label.named('archived_blocks'),
      () => CType.vec(CyclesLedgerGetBlocksResultArchivedBlocks.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'log_length': logLength,
    'blocks': blocks.map((el) => el.candidValue).toList(),
    'archived_blocks': archivedBlocks.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'log_length': logLength,
    'blocks': blocks.map((el) => el.toJson()).toList(),
    'archived_blocks': archivedBlocks.map((el) => el.toJson()).toList(),
  };

  factory CyclesLedgerGetBlocksResult.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerGetBlocksResult(
      logLength: json.valueAsBigInt<BigInt>('log_length'),
      blocks: json.valueTo<List<CyclesLedgerGetBlocksResultBlocks>, List>(
        key: 'blocks',
        parse:
            (e) =>
                e
                    .map<CyclesLedgerGetBlocksResultBlocks>(
                      (x) => CyclesLedgerGetBlocksResultBlocks.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      archivedBlocks: json.valueTo<
        List<CyclesLedgerGetBlocksResultArchivedBlocks>,
        List
      >(
        key: 'archived_blocks',
        parse:
            (e) =>
                e
                    .map<CyclesLedgerGetBlocksResultArchivedBlocks>(
                      (x) =>
                          CyclesLedgerGetBlocksResultArchivedBlocks.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
    );
  }

  factory CyclesLedgerGetBlocksResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerGetBlocksResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `GetIndexPrincipalError`.
sealed class CyclesLedgerGetIndexPrincipalError with CandidSerializable {
  const CyclesLedgerGetIndexPrincipalError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('description'), CType.text),
        Field(Label.named('error_code'), CType.nat),
      ]),
    ),
    Field(Label.named('IndexPrincipalNotSet'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerGetIndexPrincipalError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('GenericError')) {
      return CyclesLedgerGetIndexPrincipalErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('IndexPrincipalNotSet')) {
      return const CyclesLedgerGetIndexPrincipalErrorIndexPrincipalNotSet();
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerGetIndexPrincipalError.fromCandid',
      reason: 'Unknown CyclesLedgerGetIndexPrincipalError arm',
    );
  }

  factory CyclesLedgerGetIndexPrincipalError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerGetIndexPrincipalError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetIndexPrincipalError.GenericError`.
final class CyclesLedgerGetIndexPrincipalErrorGenericError
    extends CyclesLedgerGetIndexPrincipalError {
  final String description;
  final BigInt errorCode;

  const CyclesLedgerGetIndexPrincipalErrorGenericError({
    required this.description,
    required this.errorCode,
  });

  @override
  CType get candidType => CyclesLedgerGetIndexPrincipalError.ctype;

  @override
  dynamic get candidValue => Variant('GenericError', {
    'description': description,
    'error_code': errorCode,
  });

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'description': description, 'error_code': errorCode},
  };

  factory CyclesLedgerGetIndexPrincipalErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerGetIndexPrincipalErrorGenericError(
      description: json.valueAsString<String>('description'),
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
    );
  }
}

/// Variant arm `GetIndexPrincipalError.IndexPrincipalNotSet` (nullary).
final class CyclesLedgerGetIndexPrincipalErrorIndexPrincipalNotSet
    extends CyclesLedgerGetIndexPrincipalError {
  const CyclesLedgerGetIndexPrincipalErrorIndexPrincipalNotSet();

  @override
  CType get candidType => CyclesLedgerGetIndexPrincipalError.ctype;

  @override
  dynamic get candidValue => const Variant('IndexPrincipalNotSet', null);

  @override
  Map<String, dynamic> toJson() => {'IndexPrincipalNotSet': null};
}

/// Candid variant `GetIndexPrincipalResult`.
sealed class CyclesLedgerGetIndexPrincipalResult with CandidSerializable {
  const CyclesLedgerGetIndexPrincipalResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.principal),
    LazyField(
      Label.named('Err'),
      () => CyclesLedgerGetIndexPrincipalError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerGetIndexPrincipalResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return CyclesLedgerGetIndexPrincipalResultOk(
        json.valueTo<IcpPrincipalAddress, dynamic>(
          key: 'Ok',
          parse: (e) => GeneratorParserUtils.principalFromCandid(e),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return CyclesLedgerGetIndexPrincipalResultErr(
        json.valueTo<CyclesLedgerGetIndexPrincipalError, Map>(
          key: 'Err',
          parse:
              (e) => CyclesLedgerGetIndexPrincipalError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerGetIndexPrincipalResult.fromCandid',
      reason: 'Unknown CyclesLedgerGetIndexPrincipalResult arm',
    );
  }

  factory CyclesLedgerGetIndexPrincipalResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerGetIndexPrincipalResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `GetIndexPrincipalResult.Ok`.
final class CyclesLedgerGetIndexPrincipalResultOk
    extends CyclesLedgerGetIndexPrincipalResult {
  final IcpPrincipalAddress value;
  const CyclesLedgerGetIndexPrincipalResultOk(this.value);

  @override
  CType get candidType => CyclesLedgerGetIndexPrincipalResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.address};
}

/// Variant arm `GetIndexPrincipalResult.Err`.
final class CyclesLedgerGetIndexPrincipalResultErr
    extends CyclesLedgerGetIndexPrincipalResult {
  final CyclesLedgerGetIndexPrincipalError value;
  const CyclesLedgerGetIndexPrincipalResultErr(this.value);

  @override
  CType get candidType => CyclesLedgerGetIndexPrincipalResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `HttpRequest`.
final class CyclesLedgerHttpRequest with CandidSerializable {
  final String url;
  final String method;
  final List<int> body;
  final List<CyclesLedgerHttpRequestHeaders> headers;

  const CyclesLedgerHttpRequest({
    required this.url,
    required this.method,
    required this.body,
    required this.headers,
  });

  static CType get ctype => CType.record([
    Field(Label.named('url'), CType.text),
    Field(Label.named('method'), CType.text),
    Field(Label.named('body'), CType.vec(CType.nat8)),
    LazyField(
      Label.named('headers'),
      () => CType.vec(CyclesLedgerHttpRequestHeaders.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'url': url,
    'method': method,
    'body': body,
    'headers': headers.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'url': url,
    'method': method,
    'body': body,
    'headers': headers.map((el) => el.toJson()).toList(),
  };

  factory CyclesLedgerHttpRequest.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerHttpRequest(
      url: json.valueAsString<String>('url'),
      method: json.valueAsString<String>('method'),
      body: json.valueAsBytes<List<int>>(
        'body',
        encoding: StringEncoding.base64,
      ),
      headers: json.valueTo<List<CyclesLedgerHttpRequestHeaders>, List>(
        key: 'headers',
        parse:
            (e) =>
                e
                    .map<CyclesLedgerHttpRequestHeaders>(
                      (x) => CyclesLedgerHttpRequestHeaders.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory CyclesLedgerHttpRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerHttpRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `HttpResponse`.
final class CyclesLedgerHttpResponse with CandidSerializable {
  final List<int> body;
  final List<CyclesLedgerHttpRequestHeaders> headers;
  final int statusCode;

  const CyclesLedgerHttpResponse({
    required this.body,
    required this.headers,
    required this.statusCode,
  });

  static CType get ctype => CType.record([
    Field(Label.named('body'), CType.vec(CType.nat8)),
    LazyField(
      Label.named('headers'),
      () => CType.vec(CyclesLedgerHttpRequestHeaders.ctype),
    ),
    Field(Label.named('status_code'), CType.nat16),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'body': body,
    'headers': headers.map((el) => el.candidValue).toList(),
    'status_code': statusCode,
  };

  Map<String, dynamic> toJson() => {
    'body': body,
    'headers': headers.map((el) => el.toJson()).toList(),
    'status_code': statusCode,
  };

  factory CyclesLedgerHttpResponse.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerHttpResponse(
      body: json.valueAsBytes<List<int>>(
        'body',
        encoding: StringEncoding.base64,
      ),
      headers: json.valueTo<List<CyclesLedgerHttpRequestHeaders>, List>(
        key: 'headers',
        parse:
            (e) =>
                e
                    .map<CyclesLedgerHttpRequestHeaders>(
                      (x) => CyclesLedgerHttpRequestHeaders.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      statusCode: json.valueAsInt<int>('status_code'),
    );
  }

  factory CyclesLedgerHttpResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerHttpResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ICRC103GetAllowancesResponse`.
sealed class CyclesLedgerICRC103GetAllowancesResponse with CandidSerializable {
  const CyclesLedgerICRC103GetAllowancesResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => CyclesLedgerAllowancesCandid.ctype),
    LazyField(Label.named('Err'), () => CyclesLedgerGetAllowancesError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerICRC103GetAllowancesResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return CyclesLedgerICRC103GetAllowancesResponseOk(
        json.valueTo<List<CyclesLedgerAllowancesItem>, List>(
          key: 'Ok',
          parse:
              (e) =>
                  e
                      .map<CyclesLedgerAllowancesItem>(
                        (x) => CyclesLedgerAllowancesItem.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return CyclesLedgerICRC103GetAllowancesResponseErr(
        json.valueTo<CyclesLedgerGetAllowancesError, Map>(
          key: 'Err',
          parse:
              (e) => CyclesLedgerGetAllowancesError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerICRC103GetAllowancesResponse.fromCandid',
      reason: 'Unknown CyclesLedgerICRC103GetAllowancesResponse arm',
    );
  }

  factory CyclesLedgerICRC103GetAllowancesResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerICRC103GetAllowancesResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC103GetAllowancesResponse.Ok`.
final class CyclesLedgerICRC103GetAllowancesResponseOk
    extends CyclesLedgerICRC103GetAllowancesResponse {
  final CyclesLedgerAllowances value;
  const CyclesLedgerICRC103GetAllowancesResponseOk(this.value);

  @override
  CType get candidType => CyclesLedgerICRC103GetAllowancesResponse.ctype;

  @override
  dynamic get candidValue =>
      Variant('Ok', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Ok': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `ICRC103GetAllowancesResponse.Err`.
final class CyclesLedgerICRC103GetAllowancesResponseErr
    extends CyclesLedgerICRC103GetAllowancesResponse {
  final CyclesLedgerGetAllowancesError value;
  const CyclesLedgerICRC103GetAllowancesResponseErr(this.value);

  @override
  CType get candidType => CyclesLedgerICRC103GetAllowancesResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `InitArgs`.
final class CyclesLedgerInitArgs with CandidSerializable {
  final List<CyclesLedgerInitArgsInitialBalances>? initialBalances;
  final IcpPrincipalAddress? indexId;
  final BigInt maxBlocksPerRequest;

  const CyclesLedgerInitArgs({
    this.initialBalances,
    this.indexId,
    required this.maxBlocksPerRequest,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('initial_balances'),
      () => CType.opt(CType.vec(CyclesLedgerInitArgsInitialBalances.ctype)),
    ),
    Field(Label.named('index_id'), CType.opt(CType.principal)),
    Field(Label.named('max_blocks_per_request'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'initial_balances': initialBalances?.map((el) => el.candidValue).toList(),
    'index_id': indexId,
    'max_blocks_per_request': maxBlocksPerRequest,
  };

  Map<String, dynamic> toJson() => {
    'initial_balances': initialBalances?.map((el) => el.toJson()).toList(),
    'index_id': indexId?.address,
    'max_blocks_per_request': maxBlocksPerRequest,
  };

  factory CyclesLedgerInitArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerInitArgs(
      initialBalances: json
          .valueTo<List<CyclesLedgerInitArgsInitialBalances>?, List>(
            key: 'initial_balances',
            parse:
                (e) =>
                    e
                        .map<CyclesLedgerInitArgsInitialBalances>(
                          (x) => CyclesLedgerInitArgsInitialBalances.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
      indexId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'index_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      maxBlocksPerRequest: json.valueAsBigInt<BigInt>('max_blocks_per_request'),
    );
  }

  factory CyclesLedgerInitArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerInitArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `LedgerArgs`.
sealed class CyclesLedgerLedgerArgs with CandidSerializable {
  const CyclesLedgerLedgerArgs();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Upgrade'),
      () => CType.opt(CyclesLedgerUpgradeArgs.ctype),
    ),
    LazyField(Label.named('Init'), () => CyclesLedgerInitArgs.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerLedgerArgs.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Upgrade')) {
      return CyclesLedgerLedgerArgsUpgrade(
        json.valueTo<CyclesLedgerUpgradeArgs?, Map>(
          key: 'Upgrade',
          parse:
              (e) => CyclesLedgerUpgradeArgs.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Init')) {
      return CyclesLedgerLedgerArgsInit(
        json.valueTo<CyclesLedgerInitArgs, Map>(
          key: 'Init',
          parse:
              (e) => CyclesLedgerInitArgs.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerLedgerArgs.fromCandid',
      reason: 'Unknown CyclesLedgerLedgerArgs arm',
    );
  }

  factory CyclesLedgerLedgerArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerLedgerArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `LedgerArgs.Upgrade`.
final class CyclesLedgerLedgerArgsUpgrade extends CyclesLedgerLedgerArgs {
  final CyclesLedgerUpgradeArgs? value;
  const CyclesLedgerLedgerArgsUpgrade(this.value);

  @override
  CType get candidType => CyclesLedgerLedgerArgs.ctype;

  @override
  dynamic get candidValue => Variant('Upgrade', value?.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Upgrade': value?.toJson()};
}

/// Variant arm `LedgerArgs.Init`.
final class CyclesLedgerLedgerArgsInit extends CyclesLedgerLedgerArgs {
  final CyclesLedgerInitArgs value;
  const CyclesLedgerLedgerArgsInit(this.value);

  @override
  CType get candidType => CyclesLedgerLedgerArgs.ctype;

  @override
  dynamic get candidValue => Variant('Init', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Init': value.toJson()};
}

/// Candid variant `MetadataValue`.
sealed class CyclesLedgerMetadataValue with CandidSerializable {
  const CyclesLedgerMetadataValue();

  static CType get ctype => CType.variant([
    Field(Label.named('Int'), CType.int_),
    Field(Label.named('Nat'), CType.nat),
    Field(Label.named('Blob'), CType.vec(CType.nat8)),
    Field(Label.named('Text'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerMetadataValue.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Int')) {
      return CyclesLedgerMetadataValueInt(json.valueAsBigInt<BigInt>('Int'));
    }
    if (json.containsKey('Nat')) {
      return CyclesLedgerMetadataValueNat(json.valueAsBigInt<BigInt>('Nat'));
    }
    if (json.containsKey('Blob')) {
      return CyclesLedgerMetadataValueBlob(
        json.valueAsBytes<List<int>>('Blob', encoding: StringEncoding.base64),
      );
    }
    if (json.containsKey('Text')) {
      return CyclesLedgerMetadataValueText(json.valueAsString<String>('Text'));
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerMetadataValue.fromCandid',
      reason: 'Unknown CyclesLedgerMetadataValue arm',
    );
  }

  factory CyclesLedgerMetadataValue.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerMetadataValue.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `MetadataValue.Int`.
final class CyclesLedgerMetadataValueInt extends CyclesLedgerMetadataValue {
  final BigInt value;
  const CyclesLedgerMetadataValueInt(this.value);

  @override
  CType get candidType => CyclesLedgerMetadataValue.ctype;

  @override
  dynamic get candidValue => Variant('Int', value);

  @override
  Map<String, dynamic> toJson() => {'Int': value};
}

/// Variant arm `MetadataValue.Nat`.
final class CyclesLedgerMetadataValueNat extends CyclesLedgerMetadataValue {
  final BigInt value;
  const CyclesLedgerMetadataValueNat(this.value);

  @override
  CType get candidType => CyclesLedgerMetadataValue.ctype;

  @override
  dynamic get candidValue => Variant('Nat', value);

  @override
  Map<String, dynamic> toJson() => {'Nat': value};
}

/// Variant arm `MetadataValue.Blob`.
final class CyclesLedgerMetadataValueBlob extends CyclesLedgerMetadataValue {
  final List<int> value;
  const CyclesLedgerMetadataValueBlob(this.value);

  @override
  CType get candidType => CyclesLedgerMetadataValue.ctype;

  @override
  dynamic get candidValue => Variant('Blob', value);

  @override
  Map<String, dynamic> toJson() => {'Blob': value};
}

/// Variant arm `MetadataValue.Text`.
final class CyclesLedgerMetadataValueText extends CyclesLedgerMetadataValue {
  final String value;
  const CyclesLedgerMetadataValueText(this.value);

  @override
  CType get candidType => CyclesLedgerMetadataValue.ctype;

  @override
  dynamic get candidValue => Variant('Text', value);

  @override
  Map<String, dynamic> toJson() => {'Text': value};
}

/// Candid variant `RejectionCode`.
sealed class CyclesLedgerRejectionCode with CandidSerializable {
  const CyclesLedgerRejectionCode();

  static CType get ctype => CType.variant([
    Field(Label.named('NoError'), CType.null_),
    Field(Label.named('CanisterError'), CType.null_),
    Field(Label.named('SysTransient'), CType.null_),
    Field(Label.named('DestinationInvalid'), CType.null_),
    Field(Label.named('Unknown'), CType.null_),
    Field(Label.named('SysFatal'), CType.null_),
    Field(Label.named('CanisterReject'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerRejectionCode.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('NoError')) {
      return const CyclesLedgerRejectionCodeNoError();
    }
    if (json.containsKey('CanisterError')) {
      return const CyclesLedgerRejectionCodeCanisterError();
    }
    if (json.containsKey('SysTransient')) {
      return const CyclesLedgerRejectionCodeSysTransient();
    }
    if (json.containsKey('DestinationInvalid')) {
      return const CyclesLedgerRejectionCodeDestinationInvalid();
    }
    if (json.containsKey('Unknown')) {
      return const CyclesLedgerRejectionCodeUnknown();
    }
    if (json.containsKey('SysFatal')) {
      return const CyclesLedgerRejectionCodeSysFatal();
    }
    if (json.containsKey('CanisterReject')) {
      return const CyclesLedgerRejectionCodeCanisterReject();
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerRejectionCode.fromCandid',
      reason: 'Unknown CyclesLedgerRejectionCode arm',
    );
  }

  factory CyclesLedgerRejectionCode.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerRejectionCode.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `RejectionCode.NoError` (nullary).
final class CyclesLedgerRejectionCodeNoError extends CyclesLedgerRejectionCode {
  const CyclesLedgerRejectionCodeNoError();

  @override
  CType get candidType => CyclesLedgerRejectionCode.ctype;

  @override
  dynamic get candidValue => const Variant('NoError', null);

  @override
  Map<String, dynamic> toJson() => {'NoError': null};
}

/// Variant arm `RejectionCode.CanisterError` (nullary).
final class CyclesLedgerRejectionCodeCanisterError
    extends CyclesLedgerRejectionCode {
  const CyclesLedgerRejectionCodeCanisterError();

  @override
  CType get candidType => CyclesLedgerRejectionCode.ctype;

  @override
  dynamic get candidValue => const Variant('CanisterError', null);

  @override
  Map<String, dynamic> toJson() => {'CanisterError': null};
}

/// Variant arm `RejectionCode.SysTransient` (nullary).
final class CyclesLedgerRejectionCodeSysTransient
    extends CyclesLedgerRejectionCode {
  const CyclesLedgerRejectionCodeSysTransient();

  @override
  CType get candidType => CyclesLedgerRejectionCode.ctype;

  @override
  dynamic get candidValue => const Variant('SysTransient', null);

  @override
  Map<String, dynamic> toJson() => {'SysTransient': null};
}

/// Variant arm `RejectionCode.DestinationInvalid` (nullary).
final class CyclesLedgerRejectionCodeDestinationInvalid
    extends CyclesLedgerRejectionCode {
  const CyclesLedgerRejectionCodeDestinationInvalid();

  @override
  CType get candidType => CyclesLedgerRejectionCode.ctype;

  @override
  dynamic get candidValue => const Variant('DestinationInvalid', null);

  @override
  Map<String, dynamic> toJson() => {'DestinationInvalid': null};
}

/// Variant arm `RejectionCode.Unknown` (nullary).
final class CyclesLedgerRejectionCodeUnknown extends CyclesLedgerRejectionCode {
  const CyclesLedgerRejectionCodeUnknown();

  @override
  CType get candidType => CyclesLedgerRejectionCode.ctype;

  @override
  dynamic get candidValue => const Variant('Unknown', null);

  @override
  Map<String, dynamic> toJson() => {'Unknown': null};
}

/// Variant arm `RejectionCode.SysFatal` (nullary).
final class CyclesLedgerRejectionCodeSysFatal
    extends CyclesLedgerRejectionCode {
  const CyclesLedgerRejectionCodeSysFatal();

  @override
  CType get candidType => CyclesLedgerRejectionCode.ctype;

  @override
  dynamic get candidValue => const Variant('SysFatal', null);

  @override
  Map<String, dynamic> toJson() => {'SysFatal': null};
}

/// Variant arm `RejectionCode.CanisterReject` (nullary).
final class CyclesLedgerRejectionCodeCanisterReject
    extends CyclesLedgerRejectionCode {
  const CyclesLedgerRejectionCodeCanisterReject();

  @override
  CType get candidType => CyclesLedgerRejectionCode.ctype;

  @override
  dynamic get candidValue => const Variant('CanisterReject', null);

  @override
  Map<String, dynamic> toJson() => {'CanisterReject': null};
}

/// Candid record `SubnetFilter`.
final class CyclesLedgerSubnetFilter with CandidSerializable {
  final String? subnetType;

  const CyclesLedgerSubnetFilter({this.subnetType});

  static CType get ctype =>
      CType.record([Field(Label.named('subnet_type'), CType.opt(CType.text))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'subnet_type': subnetType};

  Map<String, dynamic> toJson() => {'subnet_type': subnetType};

  factory CyclesLedgerSubnetFilter.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerSubnetFilter(
      subnetType: json.valueAsString<String?>('subnet_type'),
    );
  }

  factory CyclesLedgerSubnetFilter.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerSubnetFilter.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `SubnetSelection`.
sealed class CyclesLedgerSubnetSelection with CandidSerializable {
  const CyclesLedgerSubnetSelection();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Filter'), () => CyclesLedgerSubnetFilter.ctype),
    Field(
      Label.named('Subnet'),
      CType.record([Field(Label.named('subnet'), CType.principal)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerSubnetSelection.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Filter')) {
      return CyclesLedgerSubnetSelectionFilter(
        json.valueTo<CyclesLedgerSubnetFilter, Map>(
          key: 'Filter',
          parse:
              (e) => CyclesLedgerSubnetFilter.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Subnet')) {
      return CyclesLedgerSubnetSelectionSubnet.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Subnet']),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerSubnetSelection.fromCandid',
      reason: 'Unknown CyclesLedgerSubnetSelection arm',
    );
  }

  factory CyclesLedgerSubnetSelection.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerSubnetSelection.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `SubnetSelection.Filter`.
final class CyclesLedgerSubnetSelectionFilter
    extends CyclesLedgerSubnetSelection {
  final CyclesLedgerSubnetFilter value;
  const CyclesLedgerSubnetSelectionFilter(this.value);

  @override
  CType get candidType => CyclesLedgerSubnetSelection.ctype;

  @override
  dynamic get candidValue => Variant('Filter', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Filter': value.toJson()};
}

/// Variant arm `SubnetSelection.Subnet`.
final class CyclesLedgerSubnetSelectionSubnet
    extends CyclesLedgerSubnetSelection {
  final IcpPrincipalAddress subnet;

  const CyclesLedgerSubnetSelectionSubnet({required this.subnet});

  @override
  CType get candidType => CyclesLedgerSubnetSelection.ctype;

  @override
  dynamic get candidValue => Variant('Subnet', {'subnet': subnet});

  @override
  Map<String, dynamic> toJson() => {
    'Subnet': {'subnet': subnet.address},
  };

  factory CyclesLedgerSubnetSelectionSubnet.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerSubnetSelectionSubnet(
      subnet: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'subnet',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }
}

/// Candid record `SupportedBlockType`.
final class CyclesLedgerSupportedBlockType with CandidSerializable {
  final String url;
  final String blockType;

  const CyclesLedgerSupportedBlockType({
    required this.url,
    required this.blockType,
  });

  static CType get ctype => CType.record([
    Field(Label.named('url'), CType.text),
    Field(Label.named('block_type'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'url': url, 'block_type': blockType};

  Map<String, dynamic> toJson() => {'url': url, 'block_type': blockType};

  factory CyclesLedgerSupportedBlockType.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerSupportedBlockType(
      url: json.valueAsString<String>('url'),
      blockType: json.valueAsString<String>('block_type'),
    );
  }

  factory CyclesLedgerSupportedBlockType.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerSupportedBlockType.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SupportedStandard`.
final class CyclesLedgerSupportedStandard with CandidSerializable {
  final String url;
  final String name;

  const CyclesLedgerSupportedStandard({required this.url, required this.name});

  static CType get ctype => CType.record([
    Field(Label.named('url'), CType.text),
    Field(Label.named('name'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'url': url, 'name': name};

  Map<String, dynamic> toJson() => {'url': url, 'name': name};

  factory CyclesLedgerSupportedStandard.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerSupportedStandard(
      url: json.valueAsString<String>('url'),
      name: json.valueAsString<String>('name'),
    );
  }

  factory CyclesLedgerSupportedStandard.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerSupportedStandard.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TransferArgs`.
final class CyclesLedgerTransferArgs with CandidSerializable {
  final CyclesLedgerAccount to;
  final BigInt? fee;
  final List<int>? memo;
  final List<int>? fromSubaccount;
  final BigInt? createdAtTime;
  final BigInt amount;

  const CyclesLedgerTransferArgs({
    required this.to,
    this.fee,
    this.memo,
    this.fromSubaccount,
    this.createdAtTime,
    required this.amount,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('to'), () => CyclesLedgerAccount.ctype),
    Field(Label.named('fee'), CType.opt(CType.nat)),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
    Field(Label.named('amount'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'to': to.candidValue,
    'fee': fee,
    'memo': memo,
    'from_subaccount': fromSubaccount,
    'created_at_time': createdAtTime,
    'amount': amount,
  };

  Map<String, dynamic> toJson() => {
    'to': to.toJson(),
    'fee': fee,
    'memo': memo,
    'from_subaccount': fromSubaccount,
    'created_at_time': createdAtTime,
    'amount': amount,
  };

  factory CyclesLedgerTransferArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerTransferArgs(
      to: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'to',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fee: json.valueAsBigInt<BigInt?>('fee'),
      memo: json.valueAsBytes<List<int>?>(
        'memo',
        encoding: StringEncoding.base64,
      ),
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
      amount: json.valueAsBigInt<BigInt>('amount'),
    );
  }

  factory CyclesLedgerTransferArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerTransferArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `TransferError`.
sealed class CyclesLedgerTransferError with CandidSerializable {
  const CyclesLedgerTransferError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('message'), CType.text),
        Field(Label.named('error_code'), CType.nat),
      ]),
    ),
    Field(Label.named('TemporarilyUnavailable'), CType.null_),
    Field(
      Label.named('BadBurn'),
      CType.record([Field(Label.named('min_burn_amount'), CType.nat)]),
    ),
    Field(
      Label.named('Duplicate'),
      CType.record([Field(Label.named('duplicate_of'), CType.nat)]),
    ),
    Field(
      Label.named('BadFee'),
      CType.record([Field(Label.named('expected_fee'), CType.nat)]),
    ),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('InsufficientFunds'),
      CType.record([Field(Label.named('balance'), CType.nat)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerTransferError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('GenericError')) {
      return CyclesLedgerTransferErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const CyclesLedgerTransferErrorTemporarilyUnavailable();
    }
    if (json.containsKey('BadBurn')) {
      return CyclesLedgerTransferErrorBadBurn.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadBurn']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return CyclesLedgerTransferErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('BadFee')) {
      return CyclesLedgerTransferErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('CreatedInFuture')) {
      return CyclesLedgerTransferErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const CyclesLedgerTransferErrorTooOld();
    }
    if (json.containsKey('InsufficientFunds')) {
      return CyclesLedgerTransferErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerTransferError.fromCandid',
      reason: 'Unknown CyclesLedgerTransferError arm',
    );
  }

  factory CyclesLedgerTransferError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerTransferError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferError.GenericError`.
final class CyclesLedgerTransferErrorGenericError
    extends CyclesLedgerTransferError {
  final String message;
  final BigInt errorCode;

  const CyclesLedgerTransferErrorGenericError({
    required this.message,
    required this.errorCode,
  });

  @override
  CType get candidType => CyclesLedgerTransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'message': message, 'error_code': errorCode});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'message': message, 'error_code': errorCode},
  };

  factory CyclesLedgerTransferErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferErrorGenericError(
      message: json.valueAsString<String>('message'),
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
    );
  }
}

/// Variant arm `TransferError.TemporarilyUnavailable` (nullary).
final class CyclesLedgerTransferErrorTemporarilyUnavailable
    extends CyclesLedgerTransferError {
  const CyclesLedgerTransferErrorTemporarilyUnavailable();

  @override
  CType get candidType => CyclesLedgerTransferError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `TransferError.BadBurn`.
final class CyclesLedgerTransferErrorBadBurn extends CyclesLedgerTransferError {
  final BigInt minBurnAmount;

  const CyclesLedgerTransferErrorBadBurn({required this.minBurnAmount});

  @override
  CType get candidType => CyclesLedgerTransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('BadBurn', {'min_burn_amount': minBurnAmount});

  @override
  Map<String, dynamic> toJson() => {
    'BadBurn': {'min_burn_amount': minBurnAmount},
  };

  factory CyclesLedgerTransferErrorBadBurn.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferErrorBadBurn(
      minBurnAmount: json.valueAsBigInt<BigInt>('min_burn_amount'),
    );
  }
}

/// Variant arm `TransferError.Duplicate`.
final class CyclesLedgerTransferErrorDuplicate
    extends CyclesLedgerTransferError {
  final BigInt duplicateOf;

  const CyclesLedgerTransferErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => CyclesLedgerTransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory CyclesLedgerTransferErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `TransferError.BadFee`.
final class CyclesLedgerTransferErrorBadFee extends CyclesLedgerTransferError {
  final BigInt expectedFee;

  const CyclesLedgerTransferErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => CyclesLedgerTransferError.ctype;

  @override
  dynamic get candidValue => Variant('BadFee', {'expected_fee': expectedFee});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee},
  };

  factory CyclesLedgerTransferErrorBadFee.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferErrorBadFee(
      expectedFee: json.valueAsBigInt<BigInt>('expected_fee'),
    );
  }
}

/// Variant arm `TransferError.CreatedInFuture`.
final class CyclesLedgerTransferErrorCreatedInFuture
    extends CyclesLedgerTransferError {
  final BigInt ledgerTime;

  const CyclesLedgerTransferErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => CyclesLedgerTransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory CyclesLedgerTransferErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `TransferError.TooOld` (nullary).
final class CyclesLedgerTransferErrorTooOld extends CyclesLedgerTransferError {
  const CyclesLedgerTransferErrorTooOld();

  @override
  CType get candidType => CyclesLedgerTransferError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `TransferError.InsufficientFunds`.
final class CyclesLedgerTransferErrorInsufficientFunds
    extends CyclesLedgerTransferError {
  final BigInt balance;

  const CyclesLedgerTransferErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => CyclesLedgerTransferError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory CyclesLedgerTransferErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Candid record `TransferFromArgs`.
final class CyclesLedgerTransferFromArgs with CandidSerializable {
  final CyclesLedgerAccount to;
  final BigInt? fee;
  final List<int>? spenderSubaccount;
  final CyclesLedgerAccount from;
  final List<int>? memo;
  final BigInt? createdAtTime;
  final BigInt amount;

  const CyclesLedgerTransferFromArgs({
    required this.to,
    this.fee,
    this.spenderSubaccount,
    required this.from,
    this.memo,
    this.createdAtTime,
    required this.amount,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('to'), () => CyclesLedgerAccount.ctype),
    Field(Label.named('fee'), CType.opt(CType.nat)),
    Field(Label.named('spender_subaccount'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('from'), () => CyclesLedgerAccount.ctype),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
    Field(Label.named('amount'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'to': to.candidValue,
    'fee': fee,
    'spender_subaccount': spenderSubaccount,
    'from': from.candidValue,
    'memo': memo,
    'created_at_time': createdAtTime,
    'amount': amount,
  };

  Map<String, dynamic> toJson() => {
    'to': to.toJson(),
    'fee': fee,
    'spender_subaccount': spenderSubaccount,
    'from': from.toJson(),
    'memo': memo,
    'created_at_time': createdAtTime,
    'amount': amount,
  };

  factory CyclesLedgerTransferFromArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerTransferFromArgs(
      to: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'to',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fee: json.valueAsBigInt<BigInt?>('fee'),
      spenderSubaccount: json.valueAsBytes<List<int>?>(
        'spender_subaccount',
        encoding: StringEncoding.base64,
      ),
      from: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'from',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      memo: json.valueAsBytes<List<int>?>(
        'memo',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
      amount: json.valueAsBigInt<BigInt>('amount'),
    );
  }

  factory CyclesLedgerTransferFromArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerTransferFromArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `TransferFromError`.
sealed class CyclesLedgerTransferFromError with CandidSerializable {
  const CyclesLedgerTransferFromError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('message'), CType.text),
        Field(Label.named('error_code'), CType.nat),
      ]),
    ),
    Field(Label.named('TemporarilyUnavailable'), CType.null_),
    Field(
      Label.named('InsufficientAllowance'),
      CType.record([Field(Label.named('allowance'), CType.nat)]),
    ),
    Field(
      Label.named('BadBurn'),
      CType.record([Field(Label.named('min_burn_amount'), CType.nat)]),
    ),
    Field(
      Label.named('Duplicate'),
      CType.record([Field(Label.named('duplicate_of'), CType.nat)]),
    ),
    Field(
      Label.named('BadFee'),
      CType.record([Field(Label.named('expected_fee'), CType.nat)]),
    ),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('InsufficientFunds'),
      CType.record([Field(Label.named('balance'), CType.nat)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerTransferFromError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('GenericError')) {
      return CyclesLedgerTransferFromErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const CyclesLedgerTransferFromErrorTemporarilyUnavailable();
    }
    if (json.containsKey('InsufficientAllowance')) {
      return CyclesLedgerTransferFromErrorInsufficientAllowance.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['InsufficientAllowance'],
        ),
      );
    }
    if (json.containsKey('BadBurn')) {
      return CyclesLedgerTransferFromErrorBadBurn.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadBurn']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return CyclesLedgerTransferFromErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('BadFee')) {
      return CyclesLedgerTransferFromErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('CreatedInFuture')) {
      return CyclesLedgerTransferFromErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const CyclesLedgerTransferFromErrorTooOld();
    }
    if (json.containsKey('InsufficientFunds')) {
      return CyclesLedgerTransferFromErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerTransferFromError.fromCandid',
      reason: 'Unknown CyclesLedgerTransferFromError arm',
    );
  }

  factory CyclesLedgerTransferFromError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerTransferFromError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferFromError.GenericError`.
final class CyclesLedgerTransferFromErrorGenericError
    extends CyclesLedgerTransferFromError {
  final String message;
  final BigInt errorCode;

  const CyclesLedgerTransferFromErrorGenericError({
    required this.message,
    required this.errorCode,
  });

  @override
  CType get candidType => CyclesLedgerTransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'message': message, 'error_code': errorCode});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'message': message, 'error_code': errorCode},
  };

  factory CyclesLedgerTransferFromErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferFromErrorGenericError(
      message: json.valueAsString<String>('message'),
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
    );
  }
}

/// Variant arm `TransferFromError.TemporarilyUnavailable` (nullary).
final class CyclesLedgerTransferFromErrorTemporarilyUnavailable
    extends CyclesLedgerTransferFromError {
  const CyclesLedgerTransferFromErrorTemporarilyUnavailable();

  @override
  CType get candidType => CyclesLedgerTransferFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `TransferFromError.InsufficientAllowance`.
final class CyclesLedgerTransferFromErrorInsufficientAllowance
    extends CyclesLedgerTransferFromError {
  final BigInt allowance;

  const CyclesLedgerTransferFromErrorInsufficientAllowance({
    required this.allowance,
  });

  @override
  CType get candidType => CyclesLedgerTransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('InsufficientAllowance', {'allowance': allowance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientAllowance': {'allowance': allowance},
  };

  factory CyclesLedgerTransferFromErrorInsufficientAllowance.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferFromErrorInsufficientAllowance(
      allowance: json.valueAsBigInt<BigInt>('allowance'),
    );
  }
}

/// Variant arm `TransferFromError.BadBurn`.
final class CyclesLedgerTransferFromErrorBadBurn
    extends CyclesLedgerTransferFromError {
  final BigInt minBurnAmount;

  const CyclesLedgerTransferFromErrorBadBurn({required this.minBurnAmount});

  @override
  CType get candidType => CyclesLedgerTransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('BadBurn', {'min_burn_amount': minBurnAmount});

  @override
  Map<String, dynamic> toJson() => {
    'BadBurn': {'min_burn_amount': minBurnAmount},
  };

  factory CyclesLedgerTransferFromErrorBadBurn.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferFromErrorBadBurn(
      minBurnAmount: json.valueAsBigInt<BigInt>('min_burn_amount'),
    );
  }
}

/// Variant arm `TransferFromError.Duplicate`.
final class CyclesLedgerTransferFromErrorDuplicate
    extends CyclesLedgerTransferFromError {
  final BigInt duplicateOf;

  const CyclesLedgerTransferFromErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => CyclesLedgerTransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory CyclesLedgerTransferFromErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferFromErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `TransferFromError.BadFee`.
final class CyclesLedgerTransferFromErrorBadFee
    extends CyclesLedgerTransferFromError {
  final BigInt expectedFee;

  const CyclesLedgerTransferFromErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => CyclesLedgerTransferFromError.ctype;

  @override
  dynamic get candidValue => Variant('BadFee', {'expected_fee': expectedFee});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee},
  };

  factory CyclesLedgerTransferFromErrorBadFee.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferFromErrorBadFee(
      expectedFee: json.valueAsBigInt<BigInt>('expected_fee'),
    );
  }
}

/// Variant arm `TransferFromError.CreatedInFuture`.
final class CyclesLedgerTransferFromErrorCreatedInFuture
    extends CyclesLedgerTransferFromError {
  final BigInt ledgerTime;

  const CyclesLedgerTransferFromErrorCreatedInFuture({
    required this.ledgerTime,
  });

  @override
  CType get candidType => CyclesLedgerTransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory CyclesLedgerTransferFromErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferFromErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `TransferFromError.TooOld` (nullary).
final class CyclesLedgerTransferFromErrorTooOld
    extends CyclesLedgerTransferFromError {
  const CyclesLedgerTransferFromErrorTooOld();

  @override
  CType get candidType => CyclesLedgerTransferFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `TransferFromError.InsufficientFunds`.
final class CyclesLedgerTransferFromErrorInsufficientFunds
    extends CyclesLedgerTransferFromError {
  final BigInt balance;

  const CyclesLedgerTransferFromErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => CyclesLedgerTransferFromError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory CyclesLedgerTransferFromErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerTransferFromErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Candid record `UpgradeArgs`.
final class CyclesLedgerUpgradeArgs with CandidSerializable {
  final CyclesLedgerChangeIndexId? changeIndexId;
  final BigInt? maxBlocksPerRequest;

  const CyclesLedgerUpgradeArgs({this.changeIndexId, this.maxBlocksPerRequest});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('change_index_id'),
      () => CType.opt(CyclesLedgerChangeIndexId.ctype),
    ),
    Field(Label.named('max_blocks_per_request'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'change_index_id': changeIndexId?.candidValue,
    'max_blocks_per_request': maxBlocksPerRequest,
  };

  Map<String, dynamic> toJson() => {
    'change_index_id': changeIndexId?.toJson(),
    'max_blocks_per_request': maxBlocksPerRequest,
  };

  factory CyclesLedgerUpgradeArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerUpgradeArgs(
      changeIndexId: json.valueTo<CyclesLedgerChangeIndexId?, Map>(
        key: 'change_index_id',
        parse:
            (e) => CyclesLedgerChangeIndexId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      maxBlocksPerRequest: json.valueAsBigInt<BigInt?>(
        'max_blocks_per_request',
      ),
    );
  }

  factory CyclesLedgerUpgradeArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerUpgradeArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Value`.
sealed class CyclesLedgerValue with CandidSerializable {
  const CyclesLedgerValue();

  static CType get ctype => CType.variant([
    Field(Label.named('Int'), CType.int_),
    LazyField(Label.named('Map'), () => CType.vec(CyclesLedgerValueMap.ctype)),
    Field(Label.named('Nat'), CType.nat),
    Field(Label.named('Nat64'), CType.nat64),
    Field(Label.named('Blob'), CType.vec(CType.nat8)),
    Field(Label.named('Text'), CType.text),
    LazyField(Label.named('Array'), () => CType.vec(CyclesLedgerValue.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerValue.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Int')) {
      return CyclesLedgerValueInt(json.valueAsBigInt<BigInt>('Int'));
    }
    if (json.containsKey('Map')) {
      return CyclesLedgerValueMap2(
        json.valueTo<List<CyclesLedgerValueMap>, List>(
          key: 'Map',
          parse:
              (e) =>
                  e
                      .map<CyclesLedgerValueMap>(
                        (x) => CyclesLedgerValueMap.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('Nat')) {
      return CyclesLedgerValueNat(json.valueAsBigInt<BigInt>('Nat'));
    }
    if (json.containsKey('Nat64')) {
      return CyclesLedgerValueNat64(json.valueAsBigInt<BigInt>('Nat64'));
    }
    if (json.containsKey('Blob')) {
      return CyclesLedgerValueBlob(
        json.valueAsBytes<List<int>>('Blob', encoding: StringEncoding.base64),
      );
    }
    if (json.containsKey('Text')) {
      return CyclesLedgerValueText(json.valueAsString<String>('Text'));
    }
    if (json.containsKey('Array')) {
      return CyclesLedgerValueArray(
        json.valueTo<List<CyclesLedgerValue>, List>(
          key: 'Array',
          parse:
              (e) =>
                  e
                      .map<CyclesLedgerValue>(
                        (x) => CyclesLedgerValue.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerValue.fromCandid',
      reason: 'Unknown CyclesLedgerValue arm',
    );
  }

  factory CyclesLedgerValue.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerValue.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Value.Int`.
final class CyclesLedgerValueInt extends CyclesLedgerValue {
  final BigInt value;
  const CyclesLedgerValueInt(this.value);

  @override
  CType get candidType => CyclesLedgerValue.ctype;

  @override
  dynamic get candidValue => Variant('Int', value);

  @override
  Map<String, dynamic> toJson() => {'Int': value};
}

/// Variant arm `Value.Map`.
final class CyclesLedgerValueMap2 extends CyclesLedgerValue {
  final List<CyclesLedgerValueMap> value;
  const CyclesLedgerValueMap2(this.value);

  @override
  CType get candidType => CyclesLedgerValue.ctype;

  @override
  dynamic get candidValue =>
      Variant('Map', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Map': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `Value.Nat`.
final class CyclesLedgerValueNat extends CyclesLedgerValue {
  final BigInt value;
  const CyclesLedgerValueNat(this.value);

  @override
  CType get candidType => CyclesLedgerValue.ctype;

  @override
  dynamic get candidValue => Variant('Nat', value);

  @override
  Map<String, dynamic> toJson() => {'Nat': value};
}

/// Variant arm `Value.Nat64`.
final class CyclesLedgerValueNat64 extends CyclesLedgerValue {
  final BigInt value;
  const CyclesLedgerValueNat64(this.value);

  @override
  CType get candidType => CyclesLedgerValue.ctype;

  @override
  dynamic get candidValue => Variant('Nat64', value);

  @override
  Map<String, dynamic> toJson() => {'Nat64': value};
}

/// Variant arm `Value.Blob`.
final class CyclesLedgerValueBlob extends CyclesLedgerValue {
  final List<int> value;
  const CyclesLedgerValueBlob(this.value);

  @override
  CType get candidType => CyclesLedgerValue.ctype;

  @override
  dynamic get candidValue => Variant('Blob', value);

  @override
  Map<String, dynamic> toJson() => {'Blob': value};
}

/// Variant arm `Value.Text`.
final class CyclesLedgerValueText extends CyclesLedgerValue {
  final String value;
  const CyclesLedgerValueText(this.value);

  @override
  CType get candidType => CyclesLedgerValue.ctype;

  @override
  dynamic get candidValue => Variant('Text', value);

  @override
  Map<String, dynamic> toJson() => {'Text': value};
}

/// Variant arm `Value.Array`.
final class CyclesLedgerValueArray extends CyclesLedgerValue {
  final List<CyclesLedgerValue> value;
  const CyclesLedgerValueArray(this.value);

  @override
  CType get candidType => CyclesLedgerValue.ctype;

  @override
  dynamic get candidValue =>
      Variant('Array', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Array': value.map((el) => el.toJson()).toList(),
  };
}

/// Candid record `WithdrawArgs`.
final class CyclesLedgerWithdrawArgs with CandidSerializable {
  final IcpPrincipalAddress to;
  final List<int>? fromSubaccount;
  final BigInt? createdAtTime;
  final BigInt amount;

  const CyclesLedgerWithdrawArgs({
    required this.to,
    this.fromSubaccount,
    this.createdAtTime,
    required this.amount,
  });

  static CType get ctype => CType.record([
    Field(Label.named('to'), CType.principal),
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
    Field(Label.named('amount'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'to': to,
    'from_subaccount': fromSubaccount,
    'created_at_time': createdAtTime,
    'amount': amount,
  };

  Map<String, dynamic> toJson() => {
    'to': to.address,
    'from_subaccount': fromSubaccount,
    'created_at_time': createdAtTime,
    'amount': amount,
  };

  factory CyclesLedgerWithdrawArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerWithdrawArgs(
      to: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'to',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
      amount: json.valueAsBigInt<BigInt>('amount'),
    );
  }

  factory CyclesLedgerWithdrawArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerWithdrawArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `WithdrawError`.
sealed class CyclesLedgerWithdrawError with CandidSerializable {
  const CyclesLedgerWithdrawError();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('FailedToWithdraw'),
      () => CType.record([
        LazyField(
          Label.named('rejection_code'),
          () => CyclesLedgerRejectionCode.ctype,
        ),
        Field(Label.named('fee_block'), CType.opt(CType.nat)),
        Field(Label.named('rejection_reason'), CType.text),
      ]),
    ),
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('message'), CType.text),
        Field(Label.named('error_code'), CType.nat),
      ]),
    ),
    Field(Label.named('TemporarilyUnavailable'), CType.null_),
    Field(
      Label.named('Duplicate'),
      CType.record([Field(Label.named('duplicate_of'), CType.nat)]),
    ),
    Field(
      Label.named('BadFee'),
      CType.record([Field(Label.named('expected_fee'), CType.nat)]),
    ),
    Field(
      Label.named('InvalidReceiver'),
      CType.record([Field(Label.named('receiver'), CType.principal)]),
    ),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('InsufficientFunds'),
      CType.record([Field(Label.named('balance'), CType.nat)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerWithdrawError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('FailedToWithdraw')) {
      return CyclesLedgerWithdrawErrorFailedToWithdraw.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['FailedToWithdraw']),
      );
    }
    if (json.containsKey('GenericError')) {
      return CyclesLedgerWithdrawErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const CyclesLedgerWithdrawErrorTemporarilyUnavailable();
    }
    if (json.containsKey('Duplicate')) {
      return CyclesLedgerWithdrawErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('BadFee')) {
      return CyclesLedgerWithdrawErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('InvalidReceiver')) {
      return CyclesLedgerWithdrawErrorInvalidReceiver.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InvalidReceiver']),
      );
    }
    if (json.containsKey('CreatedInFuture')) {
      return CyclesLedgerWithdrawErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const CyclesLedgerWithdrawErrorTooOld();
    }
    if (json.containsKey('InsufficientFunds')) {
      return CyclesLedgerWithdrawErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerWithdrawError.fromCandid',
      reason: 'Unknown CyclesLedgerWithdrawError arm',
    );
  }

  factory CyclesLedgerWithdrawError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerWithdrawError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `WithdrawError.FailedToWithdraw`.
final class CyclesLedgerWithdrawErrorFailedToWithdraw
    extends CyclesLedgerWithdrawError {
  final CyclesLedgerRejectionCode rejectionCode;
  final BigInt? feeBlock;
  final String rejectionReason;

  const CyclesLedgerWithdrawErrorFailedToWithdraw({
    required this.rejectionCode,
    this.feeBlock,
    required this.rejectionReason,
  });

  @override
  CType get candidType => CyclesLedgerWithdrawError.ctype;

  @override
  dynamic get candidValue => Variant('FailedToWithdraw', {
    'rejection_code': rejectionCode.candidValue,
    'fee_block': feeBlock,
    'rejection_reason': rejectionReason,
  });

  @override
  Map<String, dynamic> toJson() => {
    'FailedToWithdraw': {
      'rejection_code': rejectionCode.toJson(),
      'fee_block': feeBlock,
      'rejection_reason': rejectionReason,
    },
  };

  factory CyclesLedgerWithdrawErrorFailedToWithdraw.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawErrorFailedToWithdraw(
      rejectionCode: json.valueTo<CyclesLedgerRejectionCode, Map>(
        key: 'rejection_code',
        parse:
            (e) => CyclesLedgerRejectionCode.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      feeBlock: json.valueAsBigInt<BigInt?>('fee_block'),
      rejectionReason: json.valueAsString<String>('rejection_reason'),
    );
  }
}

/// Variant arm `WithdrawError.GenericError`.
final class CyclesLedgerWithdrawErrorGenericError
    extends CyclesLedgerWithdrawError {
  final String message;
  final BigInt errorCode;

  const CyclesLedgerWithdrawErrorGenericError({
    required this.message,
    required this.errorCode,
  });

  @override
  CType get candidType => CyclesLedgerWithdrawError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'message': message, 'error_code': errorCode});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'message': message, 'error_code': errorCode},
  };

  factory CyclesLedgerWithdrawErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawErrorGenericError(
      message: json.valueAsString<String>('message'),
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
    );
  }
}

/// Variant arm `WithdrawError.TemporarilyUnavailable` (nullary).
final class CyclesLedgerWithdrawErrorTemporarilyUnavailable
    extends CyclesLedgerWithdrawError {
  const CyclesLedgerWithdrawErrorTemporarilyUnavailable();

  @override
  CType get candidType => CyclesLedgerWithdrawError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `WithdrawError.Duplicate`.
final class CyclesLedgerWithdrawErrorDuplicate
    extends CyclesLedgerWithdrawError {
  final BigInt duplicateOf;

  const CyclesLedgerWithdrawErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => CyclesLedgerWithdrawError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory CyclesLedgerWithdrawErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `WithdrawError.BadFee`.
final class CyclesLedgerWithdrawErrorBadFee extends CyclesLedgerWithdrawError {
  final BigInt expectedFee;

  const CyclesLedgerWithdrawErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => CyclesLedgerWithdrawError.ctype;

  @override
  dynamic get candidValue => Variant('BadFee', {'expected_fee': expectedFee});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee},
  };

  factory CyclesLedgerWithdrawErrorBadFee.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawErrorBadFee(
      expectedFee: json.valueAsBigInt<BigInt>('expected_fee'),
    );
  }
}

/// Variant arm `WithdrawError.InvalidReceiver`.
final class CyclesLedgerWithdrawErrorInvalidReceiver
    extends CyclesLedgerWithdrawError {
  final IcpPrincipalAddress receiver;

  const CyclesLedgerWithdrawErrorInvalidReceiver({required this.receiver});

  @override
  CType get candidType => CyclesLedgerWithdrawError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidReceiver', {'receiver': receiver});

  @override
  Map<String, dynamic> toJson() => {
    'InvalidReceiver': {'receiver': receiver.address},
  };

  factory CyclesLedgerWithdrawErrorInvalidReceiver.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawErrorInvalidReceiver(
      receiver: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'receiver',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }
}

/// Variant arm `WithdrawError.CreatedInFuture`.
final class CyclesLedgerWithdrawErrorCreatedInFuture
    extends CyclesLedgerWithdrawError {
  final BigInt ledgerTime;

  const CyclesLedgerWithdrawErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => CyclesLedgerWithdrawError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory CyclesLedgerWithdrawErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `WithdrawError.TooOld` (nullary).
final class CyclesLedgerWithdrawErrorTooOld extends CyclesLedgerWithdrawError {
  const CyclesLedgerWithdrawErrorTooOld();

  @override
  CType get candidType => CyclesLedgerWithdrawError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `WithdrawError.InsufficientFunds`.
final class CyclesLedgerWithdrawErrorInsufficientFunds
    extends CyclesLedgerWithdrawError {
  final BigInt balance;

  const CyclesLedgerWithdrawErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => CyclesLedgerWithdrawError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory CyclesLedgerWithdrawErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Candid record `WithdrawFromArgs`.
final class CyclesLedgerWithdrawFromArgs with CandidSerializable {
  final IcpPrincipalAddress to;
  final List<int>? spenderSubaccount;
  final CyclesLedgerAccount from;
  final BigInt? createdAtTime;
  final BigInt amount;

  const CyclesLedgerWithdrawFromArgs({
    required this.to,
    this.spenderSubaccount,
    required this.from,
    this.createdAtTime,
    required this.amount,
  });

  static CType get ctype => CType.record([
    Field(Label.named('to'), CType.principal),
    Field(Label.named('spender_subaccount'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('from'), () => CyclesLedgerAccount.ctype),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
    Field(Label.named('amount'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'to': to,
    'spender_subaccount': spenderSubaccount,
    'from': from.candidValue,
    'created_at_time': createdAtTime,
    'amount': amount,
  };

  Map<String, dynamic> toJson() => {
    'to': to.address,
    'spender_subaccount': spenderSubaccount,
    'from': from.toJson(),
    'created_at_time': createdAtTime,
    'amount': amount,
  };

  factory CyclesLedgerWithdrawFromArgs.fromCandid(Map<String, dynamic> json) {
    return CyclesLedgerWithdrawFromArgs(
      to: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'to',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      spenderSubaccount: json.valueAsBytes<List<int>?>(
        'spender_subaccount',
        encoding: StringEncoding.base64,
      ),
      from: json.valueTo<CyclesLedgerAccount, Map>(
        key: 'from',
        parse:
            (e) => CyclesLedgerAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
      amount: json.valueAsBigInt<BigInt>('amount'),
    );
  }

  factory CyclesLedgerWithdrawFromArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerWithdrawFromArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `WithdrawFromError`.
sealed class CyclesLedgerWithdrawFromError with CandidSerializable {
  const CyclesLedgerWithdrawFromError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('message'), CType.text),
        Field(Label.named('error_code'), CType.nat),
      ]),
    ),
    Field(Label.named('TemporarilyUnavailable'), CType.null_),
    Field(
      Label.named('InsufficientAllowance'),
      CType.record([Field(Label.named('allowance'), CType.nat)]),
    ),
    Field(
      Label.named('Duplicate'),
      CType.record([Field(Label.named('duplicate_of'), CType.nat)]),
    ),
    Field(
      Label.named('InvalidReceiver'),
      CType.record([Field(Label.named('receiver'), CType.principal)]),
    ),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(Label.named('TooOld'), CType.null_),
    LazyField(
      Label.named('FailedToWithdrawFrom'),
      () => CType.record([
        Field(Label.named('withdraw_from_block'), CType.opt(CType.nat)),
        LazyField(
          Label.named('rejection_code'),
          () => CyclesLedgerRejectionCode.ctype,
        ),
        Field(Label.named('refund_block'), CType.opt(CType.nat)),
        Field(Label.named('approval_refund_block'), CType.opt(CType.nat)),
        Field(Label.named('rejection_reason'), CType.text),
      ]),
    ),
    Field(
      Label.named('InsufficientFunds'),
      CType.record([Field(Label.named('balance'), CType.nat)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory CyclesLedgerWithdrawFromError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('GenericError')) {
      return CyclesLedgerWithdrawFromErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const CyclesLedgerWithdrawFromErrorTemporarilyUnavailable();
    }
    if (json.containsKey('InsufficientAllowance')) {
      return CyclesLedgerWithdrawFromErrorInsufficientAllowance.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['InsufficientAllowance'],
        ),
      );
    }
    if (json.containsKey('Duplicate')) {
      return CyclesLedgerWithdrawFromErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('InvalidReceiver')) {
      return CyclesLedgerWithdrawFromErrorInvalidReceiver.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InvalidReceiver']),
      );
    }
    if (json.containsKey('CreatedInFuture')) {
      return CyclesLedgerWithdrawFromErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const CyclesLedgerWithdrawFromErrorTooOld();
    }
    if (json.containsKey('FailedToWithdrawFrom')) {
      return CyclesLedgerWithdrawFromErrorFailedToWithdrawFrom.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['FailedToWithdrawFrom'],
        ),
      );
    }
    if (json.containsKey('InsufficientFunds')) {
      return CyclesLedgerWithdrawFromErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    throw OnChainErrors.icpCandid(
      'CyclesLedgerWithdrawFromError.fromCandid',
      reason: 'Unknown CyclesLedgerWithdrawFromError arm',
    );
  }

  factory CyclesLedgerWithdrawFromError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return CyclesLedgerWithdrawFromError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `WithdrawFromError.GenericError`.
final class CyclesLedgerWithdrawFromErrorGenericError
    extends CyclesLedgerWithdrawFromError {
  final String message;
  final BigInt errorCode;

  const CyclesLedgerWithdrawFromErrorGenericError({
    required this.message,
    required this.errorCode,
  });

  @override
  CType get candidType => CyclesLedgerWithdrawFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'message': message, 'error_code': errorCode});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'message': message, 'error_code': errorCode},
  };

  factory CyclesLedgerWithdrawFromErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawFromErrorGenericError(
      message: json.valueAsString<String>('message'),
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
    );
  }
}

/// Variant arm `WithdrawFromError.TemporarilyUnavailable` (nullary).
final class CyclesLedgerWithdrawFromErrorTemporarilyUnavailable
    extends CyclesLedgerWithdrawFromError {
  const CyclesLedgerWithdrawFromErrorTemporarilyUnavailable();

  @override
  CType get candidType => CyclesLedgerWithdrawFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `WithdrawFromError.InsufficientAllowance`.
final class CyclesLedgerWithdrawFromErrorInsufficientAllowance
    extends CyclesLedgerWithdrawFromError {
  final BigInt allowance;

  const CyclesLedgerWithdrawFromErrorInsufficientAllowance({
    required this.allowance,
  });

  @override
  CType get candidType => CyclesLedgerWithdrawFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('InsufficientAllowance', {'allowance': allowance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientAllowance': {'allowance': allowance},
  };

  factory CyclesLedgerWithdrawFromErrorInsufficientAllowance.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawFromErrorInsufficientAllowance(
      allowance: json.valueAsBigInt<BigInt>('allowance'),
    );
  }
}

/// Variant arm `WithdrawFromError.Duplicate`.
final class CyclesLedgerWithdrawFromErrorDuplicate
    extends CyclesLedgerWithdrawFromError {
  final CyclesLedgerBlockIndex duplicateOf;

  const CyclesLedgerWithdrawFromErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => CyclesLedgerWithdrawFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory CyclesLedgerWithdrawFromErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawFromErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `WithdrawFromError.InvalidReceiver`.
final class CyclesLedgerWithdrawFromErrorInvalidReceiver
    extends CyclesLedgerWithdrawFromError {
  final IcpPrincipalAddress receiver;

  const CyclesLedgerWithdrawFromErrorInvalidReceiver({required this.receiver});

  @override
  CType get candidType => CyclesLedgerWithdrawFromError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidReceiver', {'receiver': receiver});

  @override
  Map<String, dynamic> toJson() => {
    'InvalidReceiver': {'receiver': receiver.address},
  };

  factory CyclesLedgerWithdrawFromErrorInvalidReceiver.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawFromErrorInvalidReceiver(
      receiver: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'receiver',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }
}

/// Variant arm `WithdrawFromError.CreatedInFuture`.
final class CyclesLedgerWithdrawFromErrorCreatedInFuture
    extends CyclesLedgerWithdrawFromError {
  final BigInt ledgerTime;

  const CyclesLedgerWithdrawFromErrorCreatedInFuture({
    required this.ledgerTime,
  });

  @override
  CType get candidType => CyclesLedgerWithdrawFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory CyclesLedgerWithdrawFromErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawFromErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `WithdrawFromError.TooOld` (nullary).
final class CyclesLedgerWithdrawFromErrorTooOld
    extends CyclesLedgerWithdrawFromError {
  const CyclesLedgerWithdrawFromErrorTooOld();

  @override
  CType get candidType => CyclesLedgerWithdrawFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `WithdrawFromError.FailedToWithdrawFrom`.
final class CyclesLedgerWithdrawFromErrorFailedToWithdrawFrom
    extends CyclesLedgerWithdrawFromError {
  final BigInt? withdrawFromBlock;
  final CyclesLedgerRejectionCode rejectionCode;
  final BigInt? refundBlock;
  final BigInt? approvalRefundBlock;
  final String rejectionReason;

  const CyclesLedgerWithdrawFromErrorFailedToWithdrawFrom({
    this.withdrawFromBlock,
    required this.rejectionCode,
    this.refundBlock,
    this.approvalRefundBlock,
    required this.rejectionReason,
  });

  @override
  CType get candidType => CyclesLedgerWithdrawFromError.ctype;

  @override
  dynamic get candidValue => Variant('FailedToWithdrawFrom', {
    'withdraw_from_block': withdrawFromBlock,
    'rejection_code': rejectionCode.candidValue,
    'refund_block': refundBlock,
    'approval_refund_block': approvalRefundBlock,
    'rejection_reason': rejectionReason,
  });

  @override
  Map<String, dynamic> toJson() => {
    'FailedToWithdrawFrom': {
      'withdraw_from_block': withdrawFromBlock,
      'rejection_code': rejectionCode.toJson(),
      'refund_block': refundBlock,
      'approval_refund_block': approvalRefundBlock,
      'rejection_reason': rejectionReason,
    },
  };

  factory CyclesLedgerWithdrawFromErrorFailedToWithdrawFrom.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawFromErrorFailedToWithdrawFrom(
      withdrawFromBlock: json.valueAsBigInt<BigInt?>('withdraw_from_block'),
      rejectionCode: json.valueTo<CyclesLedgerRejectionCode, Map>(
        key: 'rejection_code',
        parse:
            (e) => CyclesLedgerRejectionCode.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      refundBlock: json.valueAsBigInt<BigInt?>('refund_block'),
      approvalRefundBlock: json.valueAsBigInt<BigInt?>('approval_refund_block'),
      rejectionReason: json.valueAsString<String>('rejection_reason'),
    );
  }
}

/// Variant arm `WithdrawFromError.InsufficientFunds`.
final class CyclesLedgerWithdrawFromErrorInsufficientFunds
    extends CyclesLedgerWithdrawFromError {
  final BigInt balance;

  const CyclesLedgerWithdrawFromErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => CyclesLedgerWithdrawFromError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory CyclesLedgerWithdrawFromErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return CyclesLedgerWithdrawFromErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

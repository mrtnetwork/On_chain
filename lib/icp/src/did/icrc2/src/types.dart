// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid record `ICRC2Icrc1SupportedStandards.response`.
final class ICRC2Icrc1SupportedStandardsResponse with CandidSerializable {
  final String name;
  final String url;

  const ICRC2Icrc1SupportedStandardsResponse({
    required this.name,
    required this.url,
  });

  static CType get ctype => CType.record([
    Field(Label.named('name'), CType.text),
    Field(Label.named('url'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'name': name, 'url': url};

  Map<String, dynamic> toJson() => {'name': name, 'url': url};

  factory ICRC2Icrc1SupportedStandardsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC2Icrc1SupportedStandardsResponse(
      name: json.valueAsString<String>('name'),
      url: json.valueAsString<String>('url'),
    );
  }

  factory ICRC2Icrc1SupportedStandardsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC2Icrc1SupportedStandardsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ICRC2Icrc2Approve.response`.
sealed class ICRC2Icrc2ApproveResponse with CandidSerializable {
  const ICRC2Icrc2ApproveResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC2ApproveError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC2Icrc2ApproveResponse.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC2Icrc2ApproveResponseOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC2Icrc2ApproveResponseErr(
        json.valueTo<ICRC2ApproveError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC2ApproveError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC2Icrc2ApproveResponse.fromCandid',
      reason: 'Unknown ICRC2Icrc2ApproveResponse arm',
    );
  }

  factory ICRC2Icrc2ApproveResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC2Icrc2ApproveResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC2Icrc2Approve.response.Ok`.
final class ICRC2Icrc2ApproveResponseOk extends ICRC2Icrc2ApproveResponse {
  final BigInt value;
  const ICRC2Icrc2ApproveResponseOk(this.value);

  @override
  CType get candidType => ICRC2Icrc2ApproveResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC2Icrc2Approve.response.Err`.
final class ICRC2Icrc2ApproveResponseErr extends ICRC2Icrc2ApproveResponse {
  final ICRC2ApproveError value;
  const ICRC2Icrc2ApproveResponseErr(this.value);

  @override
  CType get candidType => ICRC2Icrc2ApproveResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `ICRC2Icrc2TransferFrom.response`.
sealed class ICRC2Icrc2TransferFromResponse with CandidSerializable {
  const ICRC2Icrc2TransferFromResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC2TransferFromError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC2Icrc2TransferFromResponse.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC2Icrc2TransferFromResponseOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC2Icrc2TransferFromResponseErr(
        json.valueTo<ICRC2TransferFromError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC2TransferFromError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC2Icrc2TransferFromResponse.fromCandid',
      reason: 'Unknown ICRC2Icrc2TransferFromResponse arm',
    );
  }

  factory ICRC2Icrc2TransferFromResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC2Icrc2TransferFromResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC2Icrc2TransferFrom.response.Ok`.
final class ICRC2Icrc2TransferFromResponseOk
    extends ICRC2Icrc2TransferFromResponse {
  final BigInt value;
  const ICRC2Icrc2TransferFromResponseOk(this.value);

  @override
  CType get candidType => ICRC2Icrc2TransferFromResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC2Icrc2TransferFrom.response.Err`.
final class ICRC2Icrc2TransferFromResponseErr
    extends ICRC2Icrc2TransferFromResponse {
  final ICRC2TransferFromError value;
  const ICRC2Icrc2TransferFromResponseErr(this.value);

  @override
  CType get candidType => ICRC2Icrc2TransferFromResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `ICRC2Icrc2Allowance.response`.
final class ICRC2Icrc2AllowanceResponse with CandidSerializable {
  final BigInt allowance;
  final BigInt? expiresAt;

  const ICRC2Icrc2AllowanceResponse({required this.allowance, this.expiresAt});

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

  factory ICRC2Icrc2AllowanceResponse.fromCandid(Map<String, dynamic> json) {
    return ICRC2Icrc2AllowanceResponse(
      allowance: json.valueAsBigInt<BigInt>('allowance'),
      expiresAt: json.valueAsBigInt<BigInt?>('expires_at'),
    );
  }

  factory ICRC2Icrc2AllowanceResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC2Icrc2AllowanceResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Account`.
final class ICRC2Account with CandidSerializable {
  final IcpPrincipalAddress owner;
  final List<int>? subaccount;

  const ICRC2Account({required this.owner, this.subaccount});

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

  factory ICRC2Account.fromCandid(Map<String, dynamic> json) {
    return ICRC2Account(
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

  factory ICRC2Account.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC2Account.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ApproveArgs`.
final class ICRC2ApproveArgs with CandidSerializable {
  final List<int>? fromSubaccount;
  final ICRC2Account spender;
  final BigInt amount;
  final BigInt? expectedAllowance;
  final BigInt? expiresAt;
  final BigInt? fee;
  final List<int>? memo;
  final BigInt? createdAtTime;

  const ICRC2ApproveArgs({
    this.fromSubaccount,
    required this.spender,
    required this.amount,
    this.expectedAllowance,
    this.expiresAt,
    this.fee,
    this.memo,
    this.createdAtTime,
  });

  static CType get ctype => CType.record([
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('spender'), () => ICRC2Account.ctype),
    Field(Label.named('amount'), CType.nat),
    Field(Label.named('expected_allowance'), CType.opt(CType.nat)),
    Field(Label.named('expires_at'), CType.opt(CType.nat64)),
    Field(Label.named('fee'), CType.opt(CType.nat)),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'from_subaccount': fromSubaccount,
    'spender': spender.candidValue,
    'amount': amount,
    'expected_allowance': expectedAllowance,
    'expires_at': expiresAt,
    'fee': fee,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'from_subaccount': fromSubaccount,
    'spender': spender.toJson(),
    'amount': amount,
    'expected_allowance': expectedAllowance,
    'expires_at': expiresAt,
    'fee': fee,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  factory ICRC2ApproveArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC2ApproveArgs(
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      spender: json.valueTo<ICRC2Account, Map>(
        key: 'spender',
        parse:
            (e) => ICRC2Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      amount: json.valueAsBigInt<BigInt>('amount'),
      expectedAllowance: json.valueAsBigInt<BigInt?>('expected_allowance'),
      expiresAt: json.valueAsBigInt<BigInt?>('expires_at'),
      fee: json.valueAsBigInt<BigInt?>('fee'),
      memo: json.valueAsBytes<List<int>?>(
        'memo',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
    );
  }

  factory ICRC2ApproveArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC2ApproveArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ApproveError`.
sealed class ICRC2ApproveError with CandidSerializable {
  const ICRC2ApproveError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('BadFee'),
      CType.record([Field(Label.named('expected_fee'), CType.nat)]),
    ),
    Field(
      Label.named('InsufficientFunds'),
      CType.record([Field(Label.named('balance'), CType.nat)]),
    ),
    Field(
      Label.named('AllowanceChanged'),
      CType.record([Field(Label.named('current_allowance'), CType.nat)]),
    ),
    Field(
      Label.named('Expired'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(
      Label.named('Duplicate'),
      CType.record([Field(Label.named('duplicate_of'), CType.nat)]),
    ),
    Field(Label.named('TemporarilyUnavailable'), CType.null_),
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('error_code'), CType.nat),
        Field(Label.named('message'), CType.text),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC2ApproveError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('BadFee')) {
      return ICRC2ApproveErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('InsufficientFunds')) {
      return ICRC2ApproveErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    if (json.containsKey('AllowanceChanged')) {
      return ICRC2ApproveErrorAllowanceChanged.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['AllowanceChanged']),
      );
    }
    if (json.containsKey('Expired')) {
      return ICRC2ApproveErrorExpired.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Expired']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC2ApproveErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC2ApproveErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC2ApproveErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const ICRC2ApproveErrorTemporarilyUnavailable();
    }
    if (json.containsKey('GenericError')) {
      return ICRC2ApproveErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC2ApproveError.fromCandid',
      reason: 'Unknown ICRC2ApproveError arm',
    );
  }

  factory ICRC2ApproveError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC2ApproveError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ApproveError.BadFee`.
final class ICRC2ApproveErrorBadFee extends ICRC2ApproveError {
  final BigInt expectedFee;

  const ICRC2ApproveErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => ICRC2ApproveError.ctype;

  @override
  dynamic get candidValue => Variant('BadFee', {'expected_fee': expectedFee});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee},
  };

  factory ICRC2ApproveErrorBadFee.fromCandid(Map<String, dynamic> json) {
    return ICRC2ApproveErrorBadFee(
      expectedFee: json.valueAsBigInt<BigInt>('expected_fee'),
    );
  }
}

/// Variant arm `ApproveError.InsufficientFunds`.
final class ICRC2ApproveErrorInsufficientFunds extends ICRC2ApproveError {
  final BigInt balance;

  const ICRC2ApproveErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => ICRC2ApproveError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory ICRC2ApproveErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC2ApproveErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Variant arm `ApproveError.AllowanceChanged`.
final class ICRC2ApproveErrorAllowanceChanged extends ICRC2ApproveError {
  final BigInt currentAllowance;

  const ICRC2ApproveErrorAllowanceChanged({required this.currentAllowance});

  @override
  CType get candidType => ICRC2ApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('AllowanceChanged', {'current_allowance': currentAllowance});

  @override
  Map<String, dynamic> toJson() => {
    'AllowanceChanged': {'current_allowance': currentAllowance},
  };

  factory ICRC2ApproveErrorAllowanceChanged.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC2ApproveErrorAllowanceChanged(
      currentAllowance: json.valueAsBigInt<BigInt>('current_allowance'),
    );
  }
}

/// Variant arm `ApproveError.Expired`.
final class ICRC2ApproveErrorExpired extends ICRC2ApproveError {
  final BigInt ledgerTime;

  const ICRC2ApproveErrorExpired({required this.ledgerTime});

  @override
  CType get candidType => ICRC2ApproveError.ctype;

  @override
  dynamic get candidValue => Variant('Expired', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'Expired': {'ledger_time': ledgerTime},
  };

  factory ICRC2ApproveErrorExpired.fromCandid(Map<String, dynamic> json) {
    return ICRC2ApproveErrorExpired(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `ApproveError.TooOld` (nullary).
final class ICRC2ApproveErrorTooOld extends ICRC2ApproveError {
  const ICRC2ApproveErrorTooOld();

  @override
  CType get candidType => ICRC2ApproveError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `ApproveError.CreatedInFuture`.
final class ICRC2ApproveErrorCreatedInFuture extends ICRC2ApproveError {
  final BigInt ledgerTime;

  const ICRC2ApproveErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC2ApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC2ApproveErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC2ApproveErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `ApproveError.Duplicate`.
final class ICRC2ApproveErrorDuplicate extends ICRC2ApproveError {
  final BigInt duplicateOf;

  const ICRC2ApproveErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC2ApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC2ApproveErrorDuplicate.fromCandid(Map<String, dynamic> json) {
    return ICRC2ApproveErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `ApproveError.TemporarilyUnavailable` (nullary).
final class ICRC2ApproveErrorTemporarilyUnavailable extends ICRC2ApproveError {
  const ICRC2ApproveErrorTemporarilyUnavailable();

  @override
  CType get candidType => ICRC2ApproveError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `ApproveError.GenericError`.
final class ICRC2ApproveErrorGenericError extends ICRC2ApproveError {
  final BigInt errorCode;
  final String message;

  const ICRC2ApproveErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC2ApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC2ApproveErrorGenericError.fromCandid(Map<String, dynamic> json) {
    return ICRC2ApproveErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `TransferFromArgs`.
final class ICRC2TransferFromArgs with CandidSerializable {
  final List<int>? spenderSubaccount;
  final ICRC2Account from;
  final ICRC2Account to;
  final BigInt amount;
  final BigInt? fee;
  final List<int>? memo;
  final BigInt? createdAtTime;

  const ICRC2TransferFromArgs({
    this.spenderSubaccount,
    required this.from,
    required this.to,
    required this.amount,
    this.fee,
    this.memo,
    this.createdAtTime,
  });

  static CType get ctype => CType.record([
    Field(Label.named('spender_subaccount'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('from'), () => ICRC2Account.ctype),
    LazyField(Label.named('to'), () => ICRC2Account.ctype),
    Field(Label.named('amount'), CType.nat),
    Field(Label.named('fee'), CType.opt(CType.nat)),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'spender_subaccount': spenderSubaccount,
    'from': from.candidValue,
    'to': to.candidValue,
    'amount': amount,
    'fee': fee,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'spender_subaccount': spenderSubaccount,
    'from': from.toJson(),
    'to': to.toJson(),
    'amount': amount,
    'fee': fee,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  factory ICRC2TransferFromArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC2TransferFromArgs(
      spenderSubaccount: json.valueAsBytes<List<int>?>(
        'spender_subaccount',
        encoding: StringEncoding.base64,
      ),
      from: json.valueTo<ICRC2Account, Map>(
        key: 'from',
        parse:
            (e) => ICRC2Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      to: json.valueTo<ICRC2Account, Map>(
        key: 'to',
        parse:
            (e) => ICRC2Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      amount: json.valueAsBigInt<BigInt>('amount'),
      fee: json.valueAsBigInt<BigInt?>('fee'),
      memo: json.valueAsBytes<List<int>?>(
        'memo',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
    );
  }

  factory ICRC2TransferFromArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC2TransferFromArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `TransferFromError`.
sealed class ICRC2TransferFromError with CandidSerializable {
  const ICRC2TransferFromError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('BadFee'),
      CType.record([Field(Label.named('expected_fee'), CType.nat)]),
    ),
    Field(
      Label.named('BadBurn'),
      CType.record([Field(Label.named('min_burn_amount'), CType.nat)]),
    ),
    Field(
      Label.named('InsufficientFunds'),
      CType.record([Field(Label.named('balance'), CType.nat)]),
    ),
    Field(
      Label.named('InsufficientAllowance'),
      CType.record([Field(Label.named('allowance'), CType.nat)]),
    ),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(
      Label.named('Duplicate'),
      CType.record([Field(Label.named('duplicate_of'), CType.nat)]),
    ),
    Field(Label.named('TemporarilyUnavailable'), CType.null_),
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('error_code'), CType.nat),
        Field(Label.named('message'), CType.text),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC2TransferFromError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('BadFee')) {
      return ICRC2TransferFromErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('BadBurn')) {
      return ICRC2TransferFromErrorBadBurn.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadBurn']),
      );
    }
    if (json.containsKey('InsufficientFunds')) {
      return ICRC2TransferFromErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    if (json.containsKey('InsufficientAllowance')) {
      return ICRC2TransferFromErrorInsufficientAllowance.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['InsufficientAllowance'],
        ),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC2TransferFromErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC2TransferFromErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC2TransferFromErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const ICRC2TransferFromErrorTemporarilyUnavailable();
    }
    if (json.containsKey('GenericError')) {
      return ICRC2TransferFromErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC2TransferFromError.fromCandid',
      reason: 'Unknown ICRC2TransferFromError arm',
    );
  }

  factory ICRC2TransferFromError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC2TransferFromError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferFromError.BadFee`.
final class ICRC2TransferFromErrorBadFee extends ICRC2TransferFromError {
  final BigInt expectedFee;

  const ICRC2TransferFromErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => ICRC2TransferFromError.ctype;

  @override
  dynamic get candidValue => Variant('BadFee', {'expected_fee': expectedFee});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee},
  };

  factory ICRC2TransferFromErrorBadFee.fromCandid(Map<String, dynamic> json) {
    return ICRC2TransferFromErrorBadFee(
      expectedFee: json.valueAsBigInt<BigInt>('expected_fee'),
    );
  }
}

/// Variant arm `TransferFromError.BadBurn`.
final class ICRC2TransferFromErrorBadBurn extends ICRC2TransferFromError {
  final BigInt minBurnAmount;

  const ICRC2TransferFromErrorBadBurn({required this.minBurnAmount});

  @override
  CType get candidType => ICRC2TransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('BadBurn', {'min_burn_amount': minBurnAmount});

  @override
  Map<String, dynamic> toJson() => {
    'BadBurn': {'min_burn_amount': minBurnAmount},
  };

  factory ICRC2TransferFromErrorBadBurn.fromCandid(Map<String, dynamic> json) {
    return ICRC2TransferFromErrorBadBurn(
      minBurnAmount: json.valueAsBigInt<BigInt>('min_burn_amount'),
    );
  }
}

/// Variant arm `TransferFromError.InsufficientFunds`.
final class ICRC2TransferFromErrorInsufficientFunds
    extends ICRC2TransferFromError {
  final BigInt balance;

  const ICRC2TransferFromErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => ICRC2TransferFromError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory ICRC2TransferFromErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC2TransferFromErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Variant arm `TransferFromError.InsufficientAllowance`.
final class ICRC2TransferFromErrorInsufficientAllowance
    extends ICRC2TransferFromError {
  final BigInt allowance;

  const ICRC2TransferFromErrorInsufficientAllowance({required this.allowance});

  @override
  CType get candidType => ICRC2TransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('InsufficientAllowance', {'allowance': allowance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientAllowance': {'allowance': allowance},
  };

  factory ICRC2TransferFromErrorInsufficientAllowance.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC2TransferFromErrorInsufficientAllowance(
      allowance: json.valueAsBigInt<BigInt>('allowance'),
    );
  }
}

/// Variant arm `TransferFromError.TooOld` (nullary).
final class ICRC2TransferFromErrorTooOld extends ICRC2TransferFromError {
  const ICRC2TransferFromErrorTooOld();

  @override
  CType get candidType => ICRC2TransferFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `TransferFromError.CreatedInFuture`.
final class ICRC2TransferFromErrorCreatedInFuture
    extends ICRC2TransferFromError {
  final BigInt ledgerTime;

  const ICRC2TransferFromErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC2TransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC2TransferFromErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC2TransferFromErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `TransferFromError.Duplicate`.
final class ICRC2TransferFromErrorDuplicate extends ICRC2TransferFromError {
  final BigInt duplicateOf;

  const ICRC2TransferFromErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC2TransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC2TransferFromErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC2TransferFromErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `TransferFromError.TemporarilyUnavailable` (nullary).
final class ICRC2TransferFromErrorTemporarilyUnavailable
    extends ICRC2TransferFromError {
  const ICRC2TransferFromErrorTemporarilyUnavailable();

  @override
  CType get candidType => ICRC2TransferFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `TransferFromError.GenericError`.
final class ICRC2TransferFromErrorGenericError extends ICRC2TransferFromError {
  final BigInt errorCode;
  final String message;

  const ICRC2TransferFromErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC2TransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC2TransferFromErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC2TransferFromErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `AllowanceArgs`.
final class ICRC2AllowanceArgs with CandidSerializable {
  final ICRC2Account account;
  final ICRC2Account spender;

  const ICRC2AllowanceArgs({required this.account, required this.spender});

  static CType get ctype => CType.record([
    LazyField(Label.named('account'), () => ICRC2Account.ctype),
    LazyField(Label.named('spender'), () => ICRC2Account.ctype),
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

  factory ICRC2AllowanceArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC2AllowanceArgs(
      account: json.valueTo<ICRC2Account, Map>(
        key: 'account',
        parse:
            (e) => ICRC2Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      spender: json.valueTo<ICRC2Account, Map>(
        key: 'spender',
        parse:
            (e) => ICRC2Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICRC2AllowanceArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC2AllowanceArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

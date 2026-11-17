// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid variant `ICRC152Icrc152Mint.response`.
sealed class ICRC152Icrc152MintResponse with CandidSerializable {
  const ICRC152Icrc152MintResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC152MintError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC152Icrc152MintResponse.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC152Icrc152MintResponseOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC152Icrc152MintResponseErr(
        json.valueTo<ICRC152MintError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC152MintError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC152Icrc152MintResponse.fromCandid',
      reason: 'Unknown ICRC152Icrc152MintResponse arm',
    );
  }

  factory ICRC152Icrc152MintResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC152Icrc152MintResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC152Icrc152Mint.response.Ok`.
final class ICRC152Icrc152MintResponseOk extends ICRC152Icrc152MintResponse {
  final BigInt value;
  const ICRC152Icrc152MintResponseOk(this.value);

  @override
  CType get candidType => ICRC152Icrc152MintResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC152Icrc152Mint.response.Err`.
final class ICRC152Icrc152MintResponseErr extends ICRC152Icrc152MintResponse {
  final ICRC152MintError value;
  const ICRC152Icrc152MintResponseErr(this.value);

  @override
  CType get candidType => ICRC152Icrc152MintResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `ICRC152Icrc152Burn.response`.
sealed class ICRC152Icrc152BurnResponse with CandidSerializable {
  const ICRC152Icrc152BurnResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC152BurnError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC152Icrc152BurnResponse.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC152Icrc152BurnResponseOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC152Icrc152BurnResponseErr(
        json.valueTo<ICRC152BurnError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC152BurnError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC152Icrc152BurnResponse.fromCandid',
      reason: 'Unknown ICRC152Icrc152BurnResponse arm',
    );
  }

  factory ICRC152Icrc152BurnResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC152Icrc152BurnResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC152Icrc152Burn.response.Ok`.
final class ICRC152Icrc152BurnResponseOk extends ICRC152Icrc152BurnResponse {
  final BigInt value;
  const ICRC152Icrc152BurnResponseOk(this.value);

  @override
  CType get candidType => ICRC152Icrc152BurnResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC152Icrc152Burn.response.Err`.
final class ICRC152Icrc152BurnResponseErr extends ICRC152Icrc152BurnResponse {
  final ICRC152BurnError value;
  const ICRC152Icrc152BurnResponseErr(this.value);

  @override
  CType get candidType => ICRC152Icrc152BurnResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `Account`.
final class ICRC152Account with CandidSerializable {
  final IcpPrincipalAddress owner;
  final List<int>? subaccount;

  const ICRC152Account({required this.owner, this.subaccount});

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

  factory ICRC152Account.fromCandid(Map<String, dynamic> json) {
    return ICRC152Account(
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

  factory ICRC152Account.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC152Account.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `MintArgs`.
final class ICRC152MintArgs with CandidSerializable {
  final ICRC152Account to;
  final BigInt amount;
  final BigInt createdAtTime;
  final String? reason;

  const ICRC152MintArgs({
    required this.to,
    required this.amount,
    required this.createdAtTime,
    this.reason,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('to'), () => ICRC152Account.ctype),
    Field(Label.named('amount'), CType.nat),
    Field(Label.named('created_at_time'), CType.nat64),
    Field(Label.named('reason'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'to': to.candidValue,
    'amount': amount,
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  Map<String, dynamic> toJson() => {
    'to': to.toJson(),
    'amount': amount,
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  factory ICRC152MintArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC152MintArgs(
      to: json.valueTo<ICRC152Account, Map>(
        key: 'to',
        parse:
            (e) => ICRC152Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      amount: json.valueAsBigInt<BigInt>('amount'),
      createdAtTime: json.valueAsBigInt<BigInt>('created_at_time'),
      reason: json.valueAsString<String?>('reason'),
    );
  }

  factory ICRC152MintArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC152MintArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `MintError`.
sealed class ICRC152MintError with CandidSerializable {
  const ICRC152MintError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.text),
    Field(Label.named('InvalidAccount'), CType.text),
    Field(Label.named('InvalidAmount'), CType.text),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
    ),
    Field(
      Label.named('Duplicate'),
      CType.record([Field(Label.named('duplicate_of'), CType.nat)]),
    ),
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

  factory ICRC152MintError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Unauthorized')) {
      return ICRC152MintErrorUnauthorized(
        json.valueAsString<String>('Unauthorized'),
      );
    }
    if (json.containsKey('InvalidAccount')) {
      return ICRC152MintErrorInvalidAccount(
        json.valueAsString<String>('InvalidAccount'),
      );
    }
    if (json.containsKey('InvalidAmount')) {
      return ICRC152MintErrorInvalidAmount(
        json.valueAsString<String>('InvalidAmount'),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC152MintErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC152MintErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC152MintErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC152MintErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC152MintError.fromCandid',
      reason: 'Unknown ICRC152MintError arm',
    );
  }

  factory ICRC152MintError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC152MintError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `MintError.Unauthorized`.
final class ICRC152MintErrorUnauthorized extends ICRC152MintError {
  final String value;
  const ICRC152MintErrorUnauthorized(this.value);

  @override
  CType get candidType => ICRC152MintError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value};
}

/// Variant arm `MintError.InvalidAccount`.
final class ICRC152MintErrorInvalidAccount extends ICRC152MintError {
  final String value;
  const ICRC152MintErrorInvalidAccount(this.value);

  @override
  CType get candidType => ICRC152MintError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidAccount', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidAccount': value};
}

/// Variant arm `MintError.InvalidAmount`.
final class ICRC152MintErrorInvalidAmount extends ICRC152MintError {
  final String value;
  const ICRC152MintErrorInvalidAmount(this.value);

  @override
  CType get candidType => ICRC152MintError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidAmount', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidAmount': value};
}

/// Variant arm `MintError.TooOld` (nullary).
final class ICRC152MintErrorTooOld extends ICRC152MintError {
  const ICRC152MintErrorTooOld();

  @override
  CType get candidType => ICRC152MintError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `MintError.CreatedInFuture`.
final class ICRC152MintErrorCreatedInFuture extends ICRC152MintError {
  final BigInt ledgerTime;

  const ICRC152MintErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC152MintError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC152MintErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC152MintErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `MintError.Duplicate`.
final class ICRC152MintErrorDuplicate extends ICRC152MintError {
  final BigInt duplicateOf;

  const ICRC152MintErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC152MintError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC152MintErrorDuplicate.fromCandid(Map<String, dynamic> json) {
    return ICRC152MintErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `MintError.GenericError`.
final class ICRC152MintErrorGenericError extends ICRC152MintError {
  final BigInt errorCode;
  final String message;

  const ICRC152MintErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC152MintError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC152MintErrorGenericError.fromCandid(Map<String, dynamic> json) {
    return ICRC152MintErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `BurnArgs`.
final class ICRC152BurnArgs with CandidSerializable {
  final ICRC152Account from;
  final BigInt amount;
  final BigInt createdAtTime;
  final String? reason;

  const ICRC152BurnArgs({
    required this.from,
    required this.amount,
    required this.createdAtTime,
    this.reason,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('from'), () => ICRC152Account.ctype),
    Field(Label.named('amount'), CType.nat),
    Field(Label.named('created_at_time'), CType.nat64),
    Field(Label.named('reason'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'from': from.candidValue,
    'amount': amount,
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  Map<String, dynamic> toJson() => {
    'from': from.toJson(),
    'amount': amount,
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  factory ICRC152BurnArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC152BurnArgs(
      from: json.valueTo<ICRC152Account, Map>(
        key: 'from',
        parse:
            (e) => ICRC152Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      amount: json.valueAsBigInt<BigInt>('amount'),
      createdAtTime: json.valueAsBigInt<BigInt>('created_at_time'),
      reason: json.valueAsString<String?>('reason'),
    );
  }

  factory ICRC152BurnArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC152BurnArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `BurnError`.
sealed class ICRC152BurnError with CandidSerializable {
  const ICRC152BurnError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.text),
    Field(Label.named('InvalidAccount'), CType.text),
    Field(Label.named('InvalidAmount'), CType.text),
    Field(
      Label.named('InsufficientBalance'),
      CType.record([Field(Label.named('balance'), CType.nat)]),
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

  factory ICRC152BurnError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Unauthorized')) {
      return ICRC152BurnErrorUnauthorized(
        json.valueAsString<String>('Unauthorized'),
      );
    }
    if (json.containsKey('InvalidAccount')) {
      return ICRC152BurnErrorInvalidAccount(
        json.valueAsString<String>('InvalidAccount'),
      );
    }
    if (json.containsKey('InvalidAmount')) {
      return ICRC152BurnErrorInvalidAmount(
        json.valueAsString<String>('InvalidAmount'),
      );
    }
    if (json.containsKey('InsufficientBalance')) {
      return ICRC152BurnErrorInsufficientBalance.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['InsufficientBalance'],
        ),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC152BurnErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC152BurnErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC152BurnErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC152BurnErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC152BurnError.fromCandid',
      reason: 'Unknown ICRC152BurnError arm',
    );
  }

  factory ICRC152BurnError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC152BurnError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `BurnError.Unauthorized`.
final class ICRC152BurnErrorUnauthorized extends ICRC152BurnError {
  final String value;
  const ICRC152BurnErrorUnauthorized(this.value);

  @override
  CType get candidType => ICRC152BurnError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value};
}

/// Variant arm `BurnError.InvalidAccount`.
final class ICRC152BurnErrorInvalidAccount extends ICRC152BurnError {
  final String value;
  const ICRC152BurnErrorInvalidAccount(this.value);

  @override
  CType get candidType => ICRC152BurnError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidAccount', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidAccount': value};
}

/// Variant arm `BurnError.InvalidAmount`.
final class ICRC152BurnErrorInvalidAmount extends ICRC152BurnError {
  final String value;
  const ICRC152BurnErrorInvalidAmount(this.value);

  @override
  CType get candidType => ICRC152BurnError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidAmount', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidAmount': value};
}

/// Variant arm `BurnError.InsufficientBalance`.
final class ICRC152BurnErrorInsufficientBalance extends ICRC152BurnError {
  final BigInt balance;

  const ICRC152BurnErrorInsufficientBalance({required this.balance});

  @override
  CType get candidType => ICRC152BurnError.ctype;

  @override
  dynamic get candidValue =>
      Variant('InsufficientBalance', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientBalance': {'balance': balance},
  };

  factory ICRC152BurnErrorInsufficientBalance.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC152BurnErrorInsufficientBalance(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Variant arm `BurnError.TooOld` (nullary).
final class ICRC152BurnErrorTooOld extends ICRC152BurnError {
  const ICRC152BurnErrorTooOld();

  @override
  CType get candidType => ICRC152BurnError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `BurnError.CreatedInFuture`.
final class ICRC152BurnErrorCreatedInFuture extends ICRC152BurnError {
  final BigInt ledgerTime;

  const ICRC152BurnErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC152BurnError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC152BurnErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC152BurnErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `BurnError.Duplicate`.
final class ICRC152BurnErrorDuplicate extends ICRC152BurnError {
  final BigInt duplicateOf;

  const ICRC152BurnErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC152BurnError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC152BurnErrorDuplicate.fromCandid(Map<String, dynamic> json) {
    return ICRC152BurnErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `BurnError.GenericError`.
final class ICRC152BurnErrorGenericError extends ICRC152BurnError {
  final BigInt errorCode;
  final String message;

  const ICRC152BurnErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC152BurnError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC152BurnErrorGenericError.fromCandid(Map<String, dynamic> json) {
    return ICRC152BurnErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

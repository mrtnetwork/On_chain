// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid variant `ICRC153Icrc153FreezeAccount.response`.
sealed class ICRC153Icrc153FreezeAccountResponse with CandidSerializable {
  const ICRC153Icrc153FreezeAccountResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC153FreezeAccountError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC153Icrc153FreezeAccountResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return ICRC153Icrc153FreezeAccountResponseOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return ICRC153Icrc153FreezeAccountResponseErr(
        json.valueTo<ICRC153FreezeAccountError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC153FreezeAccountError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC153Icrc153FreezeAccountResponse.fromCandid',
      reason: 'Unknown ICRC153Icrc153FreezeAccountResponse arm',
    );
  }

  factory ICRC153Icrc153FreezeAccountResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153Icrc153FreezeAccountResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC153Icrc153FreezeAccount.response.Ok`.
final class ICRC153Icrc153FreezeAccountResponseOk
    extends ICRC153Icrc153FreezeAccountResponse {
  final BigInt value;
  const ICRC153Icrc153FreezeAccountResponseOk(this.value);

  @override
  CType get candidType => ICRC153Icrc153FreezeAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC153Icrc153FreezeAccount.response.Err`.
final class ICRC153Icrc153FreezeAccountResponseErr
    extends ICRC153Icrc153FreezeAccountResponse {
  final ICRC153FreezeAccountError value;
  const ICRC153Icrc153FreezeAccountResponseErr(this.value);

  @override
  CType get candidType => ICRC153Icrc153FreezeAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `ICRC153Icrc153UnfreezeAccount.response`.
sealed class ICRC153Icrc153UnfreezeAccountResponse with CandidSerializable {
  const ICRC153Icrc153UnfreezeAccountResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC153UnfreezeAccountError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC153Icrc153UnfreezeAccountResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return ICRC153Icrc153UnfreezeAccountResponseOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return ICRC153Icrc153UnfreezeAccountResponseErr(
        json.valueTo<ICRC153UnfreezeAccountError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC153UnfreezeAccountError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC153Icrc153UnfreezeAccountResponse.fromCandid',
      reason: 'Unknown ICRC153Icrc153UnfreezeAccountResponse arm',
    );
  }

  factory ICRC153Icrc153UnfreezeAccountResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153Icrc153UnfreezeAccountResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC153Icrc153UnfreezeAccount.response.Ok`.
final class ICRC153Icrc153UnfreezeAccountResponseOk
    extends ICRC153Icrc153UnfreezeAccountResponse {
  final BigInt value;
  const ICRC153Icrc153UnfreezeAccountResponseOk(this.value);

  @override
  CType get candidType => ICRC153Icrc153UnfreezeAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC153Icrc153UnfreezeAccount.response.Err`.
final class ICRC153Icrc153UnfreezeAccountResponseErr
    extends ICRC153Icrc153UnfreezeAccountResponse {
  final ICRC153UnfreezeAccountError value;
  const ICRC153Icrc153UnfreezeAccountResponseErr(this.value);

  @override
  CType get candidType => ICRC153Icrc153UnfreezeAccountResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `ICRC153Icrc153FreezePrincipal.response`.
sealed class ICRC153Icrc153FreezePrincipalResponse with CandidSerializable {
  const ICRC153Icrc153FreezePrincipalResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC153FreezePrincipalError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC153Icrc153FreezePrincipalResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return ICRC153Icrc153FreezePrincipalResponseOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return ICRC153Icrc153FreezePrincipalResponseErr(
        json.valueTo<ICRC153FreezePrincipalError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC153FreezePrincipalError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC153Icrc153FreezePrincipalResponse.fromCandid',
      reason: 'Unknown ICRC153Icrc153FreezePrincipalResponse arm',
    );
  }

  factory ICRC153Icrc153FreezePrincipalResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153Icrc153FreezePrincipalResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC153Icrc153FreezePrincipal.response.Ok`.
final class ICRC153Icrc153FreezePrincipalResponseOk
    extends ICRC153Icrc153FreezePrincipalResponse {
  final BigInt value;
  const ICRC153Icrc153FreezePrincipalResponseOk(this.value);

  @override
  CType get candidType => ICRC153Icrc153FreezePrincipalResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC153Icrc153FreezePrincipal.response.Err`.
final class ICRC153Icrc153FreezePrincipalResponseErr
    extends ICRC153Icrc153FreezePrincipalResponse {
  final ICRC153FreezePrincipalError value;
  const ICRC153Icrc153FreezePrincipalResponseErr(this.value);

  @override
  CType get candidType => ICRC153Icrc153FreezePrincipalResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `ICRC153Icrc153UnfreezePrincipal.response`.
sealed class ICRC153Icrc153UnfreezePrincipalResponse with CandidSerializable {
  const ICRC153Icrc153UnfreezePrincipalResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC153UnfreezePrincipalError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC153Icrc153UnfreezePrincipalResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return ICRC153Icrc153UnfreezePrincipalResponseOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return ICRC153Icrc153UnfreezePrincipalResponseErr(
        json.valueTo<ICRC153UnfreezePrincipalError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC153UnfreezePrincipalError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC153Icrc153UnfreezePrincipalResponse.fromCandid',
      reason: 'Unknown ICRC153Icrc153UnfreezePrincipalResponse arm',
    );
  }

  factory ICRC153Icrc153UnfreezePrincipalResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153Icrc153UnfreezePrincipalResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC153Icrc153UnfreezePrincipal.response.Ok`.
final class ICRC153Icrc153UnfreezePrincipalResponseOk
    extends ICRC153Icrc153UnfreezePrincipalResponse {
  final BigInt value;
  const ICRC153Icrc153UnfreezePrincipalResponseOk(this.value);

  @override
  CType get candidType => ICRC153Icrc153UnfreezePrincipalResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC153Icrc153UnfreezePrincipal.response.Err`.
final class ICRC153Icrc153UnfreezePrincipalResponseErr
    extends ICRC153Icrc153UnfreezePrincipalResponse {
  final ICRC153UnfreezePrincipalError value;
  const ICRC153Icrc153UnfreezePrincipalResponseErr(this.value);

  @override
  CType get candidType => ICRC153Icrc153UnfreezePrincipalResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `Account`.
final class ICRC153Account with CandidSerializable {
  final IcpPrincipalAddress owner;
  final List<int>? subaccount;

  const ICRC153Account({required this.owner, this.subaccount});

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

  factory ICRC153Account.fromCandid(Map<String, dynamic> json) {
    return ICRC153Account(
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

  factory ICRC153Account.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153Account.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `FreezeAccountArgs`.
final class ICRC153FreezeAccountArgs with CandidSerializable {
  final ICRC153Account account;
  final BigInt createdAtTime;
  final String? reason;

  const ICRC153FreezeAccountArgs({
    required this.account,
    required this.createdAtTime,
    this.reason,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('account'), () => ICRC153Account.ctype),
    Field(Label.named('created_at_time'), CType.nat64),
    Field(Label.named('reason'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'account': account.candidValue,
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  Map<String, dynamic> toJson() => {
    'account': account.toJson(),
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  factory ICRC153FreezeAccountArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC153FreezeAccountArgs(
      account: json.valueTo<ICRC153Account, Map>(
        key: 'account',
        parse:
            (e) => ICRC153Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      createdAtTime: json.valueAsBigInt<BigInt>('created_at_time'),
      reason: json.valueAsString<String?>('reason'),
    );
  }

  factory ICRC153FreezeAccountArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153FreezeAccountArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `FreezeAccountError`.
sealed class ICRC153FreezeAccountError with CandidSerializable {
  const ICRC153FreezeAccountError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.text),
    Field(Label.named('InvalidAccount'), CType.text),
    Field(Label.named('AlreadyFrozen'), CType.text),
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

  factory ICRC153FreezeAccountError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Unauthorized')) {
      return ICRC153FreezeAccountErrorUnauthorized(
        json.valueAsString<String>('Unauthorized'),
      );
    }
    if (json.containsKey('InvalidAccount')) {
      return ICRC153FreezeAccountErrorInvalidAccount(
        json.valueAsString<String>('InvalidAccount'),
      );
    }
    if (json.containsKey('AlreadyFrozen')) {
      return ICRC153FreezeAccountErrorAlreadyFrozen(
        json.valueAsString<String>('AlreadyFrozen'),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC153FreezeAccountErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC153FreezeAccountErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC153FreezeAccountErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC153FreezeAccountErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC153FreezeAccountError.fromCandid',
      reason: 'Unknown ICRC153FreezeAccountError arm',
    );
  }

  factory ICRC153FreezeAccountError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153FreezeAccountError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `FreezeAccountError.Unauthorized`.
final class ICRC153FreezeAccountErrorUnauthorized
    extends ICRC153FreezeAccountError {
  final String value;
  const ICRC153FreezeAccountErrorUnauthorized(this.value);

  @override
  CType get candidType => ICRC153FreezeAccountError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value};
}

/// Variant arm `FreezeAccountError.InvalidAccount`.
final class ICRC153FreezeAccountErrorInvalidAccount
    extends ICRC153FreezeAccountError {
  final String value;
  const ICRC153FreezeAccountErrorInvalidAccount(this.value);

  @override
  CType get candidType => ICRC153FreezeAccountError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidAccount', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidAccount': value};
}

/// Variant arm `FreezeAccountError.AlreadyFrozen`.
final class ICRC153FreezeAccountErrorAlreadyFrozen
    extends ICRC153FreezeAccountError {
  final String value;
  const ICRC153FreezeAccountErrorAlreadyFrozen(this.value);

  @override
  CType get candidType => ICRC153FreezeAccountError.ctype;

  @override
  dynamic get candidValue => Variant('AlreadyFrozen', value);

  @override
  Map<String, dynamic> toJson() => {'AlreadyFrozen': value};
}

/// Variant arm `FreezeAccountError.TooOld` (nullary).
final class ICRC153FreezeAccountErrorTooOld extends ICRC153FreezeAccountError {
  const ICRC153FreezeAccountErrorTooOld();

  @override
  CType get candidType => ICRC153FreezeAccountError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `FreezeAccountError.CreatedInFuture`.
final class ICRC153FreezeAccountErrorCreatedInFuture
    extends ICRC153FreezeAccountError {
  final BigInt ledgerTime;

  const ICRC153FreezeAccountErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC153FreezeAccountError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC153FreezeAccountErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153FreezeAccountErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `FreezeAccountError.Duplicate`.
final class ICRC153FreezeAccountErrorDuplicate
    extends ICRC153FreezeAccountError {
  final BigInt duplicateOf;

  const ICRC153FreezeAccountErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC153FreezeAccountError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC153FreezeAccountErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153FreezeAccountErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `FreezeAccountError.GenericError`.
final class ICRC153FreezeAccountErrorGenericError
    extends ICRC153FreezeAccountError {
  final BigInt errorCode;
  final String message;

  const ICRC153FreezeAccountErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC153FreezeAccountError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC153FreezeAccountErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153FreezeAccountErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `UnfreezeAccountArgs`.
final class ICRC153UnfreezeAccountArgs with CandidSerializable {
  final ICRC153Account account;
  final BigInt createdAtTime;
  final String? reason;

  const ICRC153UnfreezeAccountArgs({
    required this.account,
    required this.createdAtTime,
    this.reason,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('account'), () => ICRC153Account.ctype),
    Field(Label.named('created_at_time'), CType.nat64),
    Field(Label.named('reason'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'account': account.candidValue,
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  Map<String, dynamic> toJson() => {
    'account': account.toJson(),
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  factory ICRC153UnfreezeAccountArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC153UnfreezeAccountArgs(
      account: json.valueTo<ICRC153Account, Map>(
        key: 'account',
        parse:
            (e) => ICRC153Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      createdAtTime: json.valueAsBigInt<BigInt>('created_at_time'),
      reason: json.valueAsString<String?>('reason'),
    );
  }

  factory ICRC153UnfreezeAccountArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153UnfreezeAccountArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `UnfreezeAccountError`.
sealed class ICRC153UnfreezeAccountError with CandidSerializable {
  const ICRC153UnfreezeAccountError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.text),
    Field(Label.named('InvalidAccount'), CType.text),
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

  factory ICRC153UnfreezeAccountError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Unauthorized')) {
      return ICRC153UnfreezeAccountErrorUnauthorized(
        json.valueAsString<String>('Unauthorized'),
      );
    }
    if (json.containsKey('InvalidAccount')) {
      return ICRC153UnfreezeAccountErrorInvalidAccount(
        json.valueAsString<String>('InvalidAccount'),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC153UnfreezeAccountErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC153UnfreezeAccountErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC153UnfreezeAccountErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC153UnfreezeAccountErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC153UnfreezeAccountError.fromCandid',
      reason: 'Unknown ICRC153UnfreezeAccountError arm',
    );
  }

  factory ICRC153UnfreezeAccountError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153UnfreezeAccountError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `UnfreezeAccountError.Unauthorized`.
final class ICRC153UnfreezeAccountErrorUnauthorized
    extends ICRC153UnfreezeAccountError {
  final String value;
  const ICRC153UnfreezeAccountErrorUnauthorized(this.value);

  @override
  CType get candidType => ICRC153UnfreezeAccountError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value};
}

/// Variant arm `UnfreezeAccountError.InvalidAccount`.
final class ICRC153UnfreezeAccountErrorInvalidAccount
    extends ICRC153UnfreezeAccountError {
  final String value;
  const ICRC153UnfreezeAccountErrorInvalidAccount(this.value);

  @override
  CType get candidType => ICRC153UnfreezeAccountError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidAccount', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidAccount': value};
}

/// Variant arm `UnfreezeAccountError.TooOld` (nullary).
final class ICRC153UnfreezeAccountErrorTooOld
    extends ICRC153UnfreezeAccountError {
  const ICRC153UnfreezeAccountErrorTooOld();

  @override
  CType get candidType => ICRC153UnfreezeAccountError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `UnfreezeAccountError.CreatedInFuture`.
final class ICRC153UnfreezeAccountErrorCreatedInFuture
    extends ICRC153UnfreezeAccountError {
  final BigInt ledgerTime;

  const ICRC153UnfreezeAccountErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC153UnfreezeAccountError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC153UnfreezeAccountErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153UnfreezeAccountErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `UnfreezeAccountError.Duplicate`.
final class ICRC153UnfreezeAccountErrorDuplicate
    extends ICRC153UnfreezeAccountError {
  final BigInt duplicateOf;

  const ICRC153UnfreezeAccountErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC153UnfreezeAccountError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC153UnfreezeAccountErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153UnfreezeAccountErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `UnfreezeAccountError.GenericError`.
final class ICRC153UnfreezeAccountErrorGenericError
    extends ICRC153UnfreezeAccountError {
  final BigInt errorCode;
  final String message;

  const ICRC153UnfreezeAccountErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC153UnfreezeAccountError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC153UnfreezeAccountErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153UnfreezeAccountErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `FreezePrincipalArgs`.
final class ICRC153FreezePrincipalArgs with CandidSerializable {
  final IcpPrincipalAddress principal;
  final BigInt createdAtTime;
  final String? reason;

  const ICRC153FreezePrincipalArgs({
    required this.principal,
    required this.createdAtTime,
    this.reason,
  });

  static CType get ctype => CType.record([
    Field(Label.named('principal'), CType.principal),
    Field(Label.named('created_at_time'), CType.nat64),
    Field(Label.named('reason'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'principal': principal,
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  Map<String, dynamic> toJson() => {
    'principal': principal.address,
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  factory ICRC153FreezePrincipalArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC153FreezePrincipalArgs(
      principal: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'principal',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      createdAtTime: json.valueAsBigInt<BigInt>('created_at_time'),
      reason: json.valueAsString<String?>('reason'),
    );
  }

  factory ICRC153FreezePrincipalArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153FreezePrincipalArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `FreezePrincipalError`.
sealed class ICRC153FreezePrincipalError with CandidSerializable {
  const ICRC153FreezePrincipalError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.text),
    Field(Label.named('InvalidPrincipal'), CType.text),
    Field(Label.named('AlreadyFrozen'), CType.text),
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

  factory ICRC153FreezePrincipalError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Unauthorized')) {
      return ICRC153FreezePrincipalErrorUnauthorized(
        json.valueAsString<String>('Unauthorized'),
      );
    }
    if (json.containsKey('InvalidPrincipal')) {
      return ICRC153FreezePrincipalErrorInvalidPrincipal(
        json.valueAsString<String>('InvalidPrincipal'),
      );
    }
    if (json.containsKey('AlreadyFrozen')) {
      return ICRC153FreezePrincipalErrorAlreadyFrozen(
        json.valueAsString<String>('AlreadyFrozen'),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC153FreezePrincipalErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC153FreezePrincipalErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC153FreezePrincipalErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC153FreezePrincipalErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC153FreezePrincipalError.fromCandid',
      reason: 'Unknown ICRC153FreezePrincipalError arm',
    );
  }

  factory ICRC153FreezePrincipalError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153FreezePrincipalError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `FreezePrincipalError.Unauthorized`.
final class ICRC153FreezePrincipalErrorUnauthorized
    extends ICRC153FreezePrincipalError {
  final String value;
  const ICRC153FreezePrincipalErrorUnauthorized(this.value);

  @override
  CType get candidType => ICRC153FreezePrincipalError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value};
}

/// Variant arm `FreezePrincipalError.InvalidPrincipal`.
final class ICRC153FreezePrincipalErrorInvalidPrincipal
    extends ICRC153FreezePrincipalError {
  final String value;
  const ICRC153FreezePrincipalErrorInvalidPrincipal(this.value);

  @override
  CType get candidType => ICRC153FreezePrincipalError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidPrincipal', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidPrincipal': value};
}

/// Variant arm `FreezePrincipalError.AlreadyFrozen`.
final class ICRC153FreezePrincipalErrorAlreadyFrozen
    extends ICRC153FreezePrincipalError {
  final String value;
  const ICRC153FreezePrincipalErrorAlreadyFrozen(this.value);

  @override
  CType get candidType => ICRC153FreezePrincipalError.ctype;

  @override
  dynamic get candidValue => Variant('AlreadyFrozen', value);

  @override
  Map<String, dynamic> toJson() => {'AlreadyFrozen': value};
}

/// Variant arm `FreezePrincipalError.TooOld` (nullary).
final class ICRC153FreezePrincipalErrorTooOld
    extends ICRC153FreezePrincipalError {
  const ICRC153FreezePrincipalErrorTooOld();

  @override
  CType get candidType => ICRC153FreezePrincipalError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `FreezePrincipalError.CreatedInFuture`.
final class ICRC153FreezePrincipalErrorCreatedInFuture
    extends ICRC153FreezePrincipalError {
  final BigInt ledgerTime;

  const ICRC153FreezePrincipalErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC153FreezePrincipalError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC153FreezePrincipalErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153FreezePrincipalErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `FreezePrincipalError.Duplicate`.
final class ICRC153FreezePrincipalErrorDuplicate
    extends ICRC153FreezePrincipalError {
  final BigInt duplicateOf;

  const ICRC153FreezePrincipalErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC153FreezePrincipalError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC153FreezePrincipalErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153FreezePrincipalErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `FreezePrincipalError.GenericError`.
final class ICRC153FreezePrincipalErrorGenericError
    extends ICRC153FreezePrincipalError {
  final BigInt errorCode;
  final String message;

  const ICRC153FreezePrincipalErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC153FreezePrincipalError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC153FreezePrincipalErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153FreezePrincipalErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `UnfreezePrincipalArgs`.
final class ICRC153UnfreezePrincipalArgs with CandidSerializable {
  final IcpPrincipalAddress principal;
  final BigInt createdAtTime;
  final String? reason;

  const ICRC153UnfreezePrincipalArgs({
    required this.principal,
    required this.createdAtTime,
    this.reason,
  });

  static CType get ctype => CType.record([
    Field(Label.named('principal'), CType.principal),
    Field(Label.named('created_at_time'), CType.nat64),
    Field(Label.named('reason'), CType.opt(CType.text)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'principal': principal,
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  Map<String, dynamic> toJson() => {
    'principal': principal.address,
    'created_at_time': createdAtTime,
    'reason': reason,
  };

  factory ICRC153UnfreezePrincipalArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC153UnfreezePrincipalArgs(
      principal: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'principal',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      createdAtTime: json.valueAsBigInt<BigInt>('created_at_time'),
      reason: json.valueAsString<String?>('reason'),
    );
  }

  factory ICRC153UnfreezePrincipalArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153UnfreezePrincipalArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `UnfreezePrincipalError`.
sealed class ICRC153UnfreezePrincipalError with CandidSerializable {
  const ICRC153UnfreezePrincipalError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.text),
    Field(Label.named('InvalidPrincipal'), CType.text),
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

  factory ICRC153UnfreezePrincipalError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Unauthorized')) {
      return ICRC153UnfreezePrincipalErrorUnauthorized(
        json.valueAsString<String>('Unauthorized'),
      );
    }
    if (json.containsKey('InvalidPrincipal')) {
      return ICRC153UnfreezePrincipalErrorInvalidPrincipal(
        json.valueAsString<String>('InvalidPrincipal'),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC153UnfreezePrincipalErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC153UnfreezePrincipalErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC153UnfreezePrincipalErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC153UnfreezePrincipalErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC153UnfreezePrincipalError.fromCandid',
      reason: 'Unknown ICRC153UnfreezePrincipalError arm',
    );
  }

  factory ICRC153UnfreezePrincipalError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153UnfreezePrincipalError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `UnfreezePrincipalError.Unauthorized`.
final class ICRC153UnfreezePrincipalErrorUnauthorized
    extends ICRC153UnfreezePrincipalError {
  final String value;
  const ICRC153UnfreezePrincipalErrorUnauthorized(this.value);

  @override
  CType get candidType => ICRC153UnfreezePrincipalError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value};
}

/// Variant arm `UnfreezePrincipalError.InvalidPrincipal`.
final class ICRC153UnfreezePrincipalErrorInvalidPrincipal
    extends ICRC153UnfreezePrincipalError {
  final String value;
  const ICRC153UnfreezePrincipalErrorInvalidPrincipal(this.value);

  @override
  CType get candidType => ICRC153UnfreezePrincipalError.ctype;

  @override
  dynamic get candidValue => Variant('InvalidPrincipal', value);

  @override
  Map<String, dynamic> toJson() => {'InvalidPrincipal': value};
}

/// Variant arm `UnfreezePrincipalError.TooOld` (nullary).
final class ICRC153UnfreezePrincipalErrorTooOld
    extends ICRC153UnfreezePrincipalError {
  const ICRC153UnfreezePrincipalErrorTooOld();

  @override
  CType get candidType => ICRC153UnfreezePrincipalError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `UnfreezePrincipalError.CreatedInFuture`.
final class ICRC153UnfreezePrincipalErrorCreatedInFuture
    extends ICRC153UnfreezePrincipalError {
  final BigInt ledgerTime;

  const ICRC153UnfreezePrincipalErrorCreatedInFuture({
    required this.ledgerTime,
  });

  @override
  CType get candidType => ICRC153UnfreezePrincipalError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC153UnfreezePrincipalErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153UnfreezePrincipalErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `UnfreezePrincipalError.Duplicate`.
final class ICRC153UnfreezePrincipalErrorDuplicate
    extends ICRC153UnfreezePrincipalError {
  final BigInt duplicateOf;

  const ICRC153UnfreezePrincipalErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC153UnfreezePrincipalError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC153UnfreezePrincipalErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153UnfreezePrincipalErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `UnfreezePrincipalError.GenericError`.
final class ICRC153UnfreezePrincipalErrorGenericError
    extends ICRC153UnfreezePrincipalError {
  final BigInt errorCode;
  final String message;

  const ICRC153UnfreezePrincipalErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC153UnfreezePrincipalError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC153UnfreezePrincipalErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153UnfreezePrincipalErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `FrozenAccountsRequest`.
final class ICRC153FrozenAccountsRequest with CandidSerializable {
  final ICRC153Account? startAfter;
  final BigInt maxResults;

  const ICRC153FrozenAccountsRequest({
    this.startAfter,
    required this.maxResults,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('start_after'),
      () => CType.opt(ICRC153Account.ctype),
    ),
    Field(Label.named('max_results'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'start_after': startAfter?.candidValue,
    'max_results': maxResults,
  };

  Map<String, dynamic> toJson() => {
    'start_after': startAfter?.toJson(),
    'max_results': maxResults,
  };

  factory ICRC153FrozenAccountsRequest.fromCandid(Map<String, dynamic> json) {
    return ICRC153FrozenAccountsRequest(
      startAfter: json.valueTo<ICRC153Account?, Map>(
        key: 'start_after',
        parse:
            (e) => ICRC153Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      maxResults: json.valueAsBigInt<BigInt>('max_results'),
    );
  }

  factory ICRC153FrozenAccountsRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153FrozenAccountsRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `FrozenAccountsResponse`.
final class ICRC153FrozenAccountsResponse with CandidSerializable {
  final List<ICRC153Account> accounts;
  final bool hasMore;

  const ICRC153FrozenAccountsResponse({
    required this.accounts,
    required this.hasMore,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('accounts'), () => CType.vec(ICRC153Account.ctype)),
    Field(Label.named('has_more'), CType.bool_),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'accounts': accounts.map((el) => el.candidValue).toList(),
    'has_more': hasMore,
  };

  Map<String, dynamic> toJson() => {
    'accounts': accounts.map((el) => el.toJson()).toList(),
    'has_more': hasMore,
  };

  factory ICRC153FrozenAccountsResponse.fromCandid(Map<String, dynamic> json) {
    return ICRC153FrozenAccountsResponse(
      accounts: json.valueTo<List<ICRC153Account>, List>(
        key: 'accounts',
        parse:
            (e) =>
                e
                    .map<ICRC153Account>(
                      (x) => ICRC153Account.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      hasMore: json.valueAsBool<bool>('has_more'),
    );
  }

  factory ICRC153FrozenAccountsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153FrozenAccountsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `FrozenPrincipalsRequest`.
final class ICRC153FrozenPrincipalsRequest with CandidSerializable {
  final IcpPrincipalAddress? startAfter;
  final BigInt maxResults;

  const ICRC153FrozenPrincipalsRequest({
    this.startAfter,
    required this.maxResults,
  });

  static CType get ctype => CType.record([
    Field(Label.named('start_after'), CType.opt(CType.principal)),
    Field(Label.named('max_results'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'start_after': startAfter,
    'max_results': maxResults,
  };

  Map<String, dynamic> toJson() => {
    'start_after': startAfter?.address,
    'max_results': maxResults,
  };

  factory ICRC153FrozenPrincipalsRequest.fromCandid(Map<String, dynamic> json) {
    return ICRC153FrozenPrincipalsRequest(
      startAfter: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'start_after',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      maxResults: json.valueAsBigInt<BigInt>('max_results'),
    );
  }

  factory ICRC153FrozenPrincipalsRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153FrozenPrincipalsRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `FrozenPrincipalsResponse`.
final class ICRC153FrozenPrincipalsResponse with CandidSerializable {
  final List<IcpPrincipalAddress> principals;
  final bool hasMore;

  const ICRC153FrozenPrincipalsResponse({
    required this.principals,
    required this.hasMore,
  });

  static CType get ctype => CType.record([
    Field(Label.named('principals'), CType.vec(CType.principal)),
    Field(Label.named('has_more'), CType.bool_),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'principals': principals, 'has_more': hasMore};

  Map<String, dynamic> toJson() => {
    'principals': principals.map((el) => el.address).toList(),
    'has_more': hasMore,
  };

  factory ICRC153FrozenPrincipalsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC153FrozenPrincipalsResponse(
      principals: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'principals',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      hasMore: json.valueAsBool<bool>('has_more'),
    );
  }

  factory ICRC153FrozenPrincipalsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC153FrozenPrincipalsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

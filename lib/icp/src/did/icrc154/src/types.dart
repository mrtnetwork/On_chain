// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid variant `ICRC154Icrc154Pause.response`.
sealed class ICRC154Icrc154PauseResponse with CandidSerializable {
  const ICRC154Icrc154PauseResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC154PauseError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC154Icrc154PauseResponse.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC154Icrc154PauseResponseOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC154Icrc154PauseResponseErr(
        json.valueTo<ICRC154PauseError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC154PauseError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC154Icrc154PauseResponse.fromCandid',
      reason: 'Unknown ICRC154Icrc154PauseResponse arm',
    );
  }

  factory ICRC154Icrc154PauseResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC154Icrc154PauseResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC154Icrc154Pause.response.Ok`.
final class ICRC154Icrc154PauseResponseOk extends ICRC154Icrc154PauseResponse {
  final BigInt value;
  const ICRC154Icrc154PauseResponseOk(this.value);

  @override
  CType get candidType => ICRC154Icrc154PauseResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC154Icrc154Pause.response.Err`.
final class ICRC154Icrc154PauseResponseErr extends ICRC154Icrc154PauseResponse {
  final ICRC154PauseError value;
  const ICRC154Icrc154PauseResponseErr(this.value);

  @override
  CType get candidType => ICRC154Icrc154PauseResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `ICRC154Icrc154Unpause.response`.
sealed class ICRC154Icrc154UnpauseResponse with CandidSerializable {
  const ICRC154Icrc154UnpauseResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC154UnpauseError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC154Icrc154UnpauseResponse.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC154Icrc154UnpauseResponseOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC154Icrc154UnpauseResponseErr(
        json.valueTo<ICRC154UnpauseError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC154UnpauseError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC154Icrc154UnpauseResponse.fromCandid',
      reason: 'Unknown ICRC154Icrc154UnpauseResponse arm',
    );
  }

  factory ICRC154Icrc154UnpauseResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC154Icrc154UnpauseResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC154Icrc154Unpause.response.Ok`.
final class ICRC154Icrc154UnpauseResponseOk
    extends ICRC154Icrc154UnpauseResponse {
  final BigInt value;
  const ICRC154Icrc154UnpauseResponseOk(this.value);

  @override
  CType get candidType => ICRC154Icrc154UnpauseResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC154Icrc154Unpause.response.Err`.
final class ICRC154Icrc154UnpauseResponseErr
    extends ICRC154Icrc154UnpauseResponse {
  final ICRC154UnpauseError value;
  const ICRC154Icrc154UnpauseResponseErr(this.value);

  @override
  CType get candidType => ICRC154Icrc154UnpauseResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `ICRC154Icrc154Deactivate.response`.
sealed class ICRC154Icrc154DeactivateResponse with CandidSerializable {
  const ICRC154Icrc154DeactivateResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC154DeactivateError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC154Icrc154DeactivateResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return ICRC154Icrc154DeactivateResponseOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return ICRC154Icrc154DeactivateResponseErr(
        json.valueTo<ICRC154DeactivateError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC154DeactivateError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC154Icrc154DeactivateResponse.fromCandid',
      reason: 'Unknown ICRC154Icrc154DeactivateResponse arm',
    );
  }

  factory ICRC154Icrc154DeactivateResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC154Icrc154DeactivateResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC154Icrc154Deactivate.response.Ok`.
final class ICRC154Icrc154DeactivateResponseOk
    extends ICRC154Icrc154DeactivateResponse {
  final BigInt value;
  const ICRC154Icrc154DeactivateResponseOk(this.value);

  @override
  CType get candidType => ICRC154Icrc154DeactivateResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC154Icrc154Deactivate.response.Err`.
final class ICRC154Icrc154DeactivateResponseErr
    extends ICRC154Icrc154DeactivateResponse {
  final ICRC154DeactivateError value;
  const ICRC154Icrc154DeactivateResponseErr(this.value);

  @override
  CType get candidType => ICRC154Icrc154DeactivateResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `PauseArgs`.
final class ICRC154PauseArgs with CandidSerializable {
  final String? reason;
  final BigInt createdAtTime;

  const ICRC154PauseArgs({this.reason, required this.createdAtTime});

  static CType get ctype => CType.record([
    Field(Label.named('reason'), CType.opt(CType.text)),
    Field(Label.named('created_at_time'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'reason': reason,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'reason': reason,
    'created_at_time': createdAtTime,
  };

  factory ICRC154PauseArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC154PauseArgs(
      reason: json.valueAsString<String?>('reason'),
      createdAtTime: json.valueAsBigInt<BigInt>('created_at_time'),
    );
  }

  factory ICRC154PauseArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC154PauseArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `PauseError`.
sealed class ICRC154PauseError with CandidSerializable {
  const ICRC154PauseError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.text),
    Field(Label.named('AlreadyPaused'), CType.text),
    Field(Label.named('AlreadyDeactivated'), CType.text),
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

  factory ICRC154PauseError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Unauthorized')) {
      return ICRC154PauseErrorUnauthorized(
        json.valueAsString<String>('Unauthorized'),
      );
    }
    if (json.containsKey('AlreadyPaused')) {
      return ICRC154PauseErrorAlreadyPaused(
        json.valueAsString<String>('AlreadyPaused'),
      );
    }
    if (json.containsKey('AlreadyDeactivated')) {
      return ICRC154PauseErrorAlreadyDeactivated(
        json.valueAsString<String>('AlreadyDeactivated'),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC154PauseErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC154PauseErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC154PauseErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC154PauseErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC154PauseError.fromCandid',
      reason: 'Unknown ICRC154PauseError arm',
    );
  }

  factory ICRC154PauseError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC154PauseError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `PauseError.Unauthorized`.
final class ICRC154PauseErrorUnauthorized extends ICRC154PauseError {
  final String value;
  const ICRC154PauseErrorUnauthorized(this.value);

  @override
  CType get candidType => ICRC154PauseError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value};
}

/// Variant arm `PauseError.AlreadyPaused`.
final class ICRC154PauseErrorAlreadyPaused extends ICRC154PauseError {
  final String value;
  const ICRC154PauseErrorAlreadyPaused(this.value);

  @override
  CType get candidType => ICRC154PauseError.ctype;

  @override
  dynamic get candidValue => Variant('AlreadyPaused', value);

  @override
  Map<String, dynamic> toJson() => {'AlreadyPaused': value};
}

/// Variant arm `PauseError.AlreadyDeactivated`.
final class ICRC154PauseErrorAlreadyDeactivated extends ICRC154PauseError {
  final String value;
  const ICRC154PauseErrorAlreadyDeactivated(this.value);

  @override
  CType get candidType => ICRC154PauseError.ctype;

  @override
  dynamic get candidValue => Variant('AlreadyDeactivated', value);

  @override
  Map<String, dynamic> toJson() => {'AlreadyDeactivated': value};
}

/// Variant arm `PauseError.TooOld` (nullary).
final class ICRC154PauseErrorTooOld extends ICRC154PauseError {
  const ICRC154PauseErrorTooOld();

  @override
  CType get candidType => ICRC154PauseError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `PauseError.CreatedInFuture`.
final class ICRC154PauseErrorCreatedInFuture extends ICRC154PauseError {
  final BigInt ledgerTime;

  const ICRC154PauseErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC154PauseError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC154PauseErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC154PauseErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `PauseError.Duplicate`.
final class ICRC154PauseErrorDuplicate extends ICRC154PauseError {
  final BigInt duplicateOf;

  const ICRC154PauseErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC154PauseError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC154PauseErrorDuplicate.fromCandid(Map<String, dynamic> json) {
    return ICRC154PauseErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `PauseError.GenericError`.
final class ICRC154PauseErrorGenericError extends ICRC154PauseError {
  final BigInt errorCode;
  final String message;

  const ICRC154PauseErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC154PauseError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC154PauseErrorGenericError.fromCandid(Map<String, dynamic> json) {
    return ICRC154PauseErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `UnpauseArgs`.
final class ICRC154UnpauseArgs with CandidSerializable {
  final String? reason;
  final BigInt createdAtTime;

  const ICRC154UnpauseArgs({this.reason, required this.createdAtTime});

  static CType get ctype => CType.record([
    Field(Label.named('reason'), CType.opt(CType.text)),
    Field(Label.named('created_at_time'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'reason': reason,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'reason': reason,
    'created_at_time': createdAtTime,
  };

  factory ICRC154UnpauseArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC154UnpauseArgs(
      reason: json.valueAsString<String?>('reason'),
      createdAtTime: json.valueAsBigInt<BigInt>('created_at_time'),
    );
  }

  factory ICRC154UnpauseArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC154UnpauseArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `UnpauseError`.
sealed class ICRC154UnpauseError with CandidSerializable {
  const ICRC154UnpauseError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.text),
    Field(Label.named('NotPaused'), CType.text),
    Field(Label.named('AlreadyDeactivated'), CType.text),
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

  factory ICRC154UnpauseError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Unauthorized')) {
      return ICRC154UnpauseErrorUnauthorized(
        json.valueAsString<String>('Unauthorized'),
      );
    }
    if (json.containsKey('NotPaused')) {
      return ICRC154UnpauseErrorNotPaused(
        json.valueAsString<String>('NotPaused'),
      );
    }
    if (json.containsKey('AlreadyDeactivated')) {
      return ICRC154UnpauseErrorAlreadyDeactivated(
        json.valueAsString<String>('AlreadyDeactivated'),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC154UnpauseErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC154UnpauseErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC154UnpauseErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC154UnpauseErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC154UnpauseError.fromCandid',
      reason: 'Unknown ICRC154UnpauseError arm',
    );
  }

  factory ICRC154UnpauseError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC154UnpauseError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `UnpauseError.Unauthorized`.
final class ICRC154UnpauseErrorUnauthorized extends ICRC154UnpauseError {
  final String value;
  const ICRC154UnpauseErrorUnauthorized(this.value);

  @override
  CType get candidType => ICRC154UnpauseError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value};
}

/// Variant arm `UnpauseError.NotPaused`.
final class ICRC154UnpauseErrorNotPaused extends ICRC154UnpauseError {
  final String value;
  const ICRC154UnpauseErrorNotPaused(this.value);

  @override
  CType get candidType => ICRC154UnpauseError.ctype;

  @override
  dynamic get candidValue => Variant('NotPaused', value);

  @override
  Map<String, dynamic> toJson() => {'NotPaused': value};
}

/// Variant arm `UnpauseError.AlreadyDeactivated`.
final class ICRC154UnpauseErrorAlreadyDeactivated extends ICRC154UnpauseError {
  final String value;
  const ICRC154UnpauseErrorAlreadyDeactivated(this.value);

  @override
  CType get candidType => ICRC154UnpauseError.ctype;

  @override
  dynamic get candidValue => Variant('AlreadyDeactivated', value);

  @override
  Map<String, dynamic> toJson() => {'AlreadyDeactivated': value};
}

/// Variant arm `UnpauseError.TooOld` (nullary).
final class ICRC154UnpauseErrorTooOld extends ICRC154UnpauseError {
  const ICRC154UnpauseErrorTooOld();

  @override
  CType get candidType => ICRC154UnpauseError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `UnpauseError.CreatedInFuture`.
final class ICRC154UnpauseErrorCreatedInFuture extends ICRC154UnpauseError {
  final BigInt ledgerTime;

  const ICRC154UnpauseErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC154UnpauseError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC154UnpauseErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC154UnpauseErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `UnpauseError.Duplicate`.
final class ICRC154UnpauseErrorDuplicate extends ICRC154UnpauseError {
  final BigInt duplicateOf;

  const ICRC154UnpauseErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC154UnpauseError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC154UnpauseErrorDuplicate.fromCandid(Map<String, dynamic> json) {
    return ICRC154UnpauseErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `UnpauseError.GenericError`.
final class ICRC154UnpauseErrorGenericError extends ICRC154UnpauseError {
  final BigInt errorCode;
  final String message;

  const ICRC154UnpauseErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC154UnpauseError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC154UnpauseErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC154UnpauseErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `DeactivateArgs`.
final class ICRC154DeactivateArgs with CandidSerializable {
  final String? reason;
  final BigInt createdAtTime;

  const ICRC154DeactivateArgs({this.reason, required this.createdAtTime});

  static CType get ctype => CType.record([
    Field(Label.named('reason'), CType.opt(CType.text)),
    Field(Label.named('created_at_time'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'reason': reason,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'reason': reason,
    'created_at_time': createdAtTime,
  };

  factory ICRC154DeactivateArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC154DeactivateArgs(
      reason: json.valueAsString<String?>('reason'),
      createdAtTime: json.valueAsBigInt<BigInt>('created_at_time'),
    );
  }

  factory ICRC154DeactivateArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC154DeactivateArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `DeactivateError`.
sealed class ICRC154DeactivateError with CandidSerializable {
  const ICRC154DeactivateError();

  static CType get ctype => CType.variant([
    Field(Label.named('Unauthorized'), CType.text),
    Field(Label.named('AlreadyDeactivated'), CType.text),
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

  factory ICRC154DeactivateError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Unauthorized')) {
      return ICRC154DeactivateErrorUnauthorized(
        json.valueAsString<String>('Unauthorized'),
      );
    }
    if (json.containsKey('AlreadyDeactivated')) {
      return ICRC154DeactivateErrorAlreadyDeactivated(
        json.valueAsString<String>('AlreadyDeactivated'),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC154DeactivateErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC154DeactivateErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC154DeactivateErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC154DeactivateErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC154DeactivateError.fromCandid',
      reason: 'Unknown ICRC154DeactivateError arm',
    );
  }

  factory ICRC154DeactivateError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC154DeactivateError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `DeactivateError.Unauthorized`.
final class ICRC154DeactivateErrorUnauthorized extends ICRC154DeactivateError {
  final String value;
  const ICRC154DeactivateErrorUnauthorized(this.value);

  @override
  CType get candidType => ICRC154DeactivateError.ctype;

  @override
  dynamic get candidValue => Variant('Unauthorized', value);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': value};
}

/// Variant arm `DeactivateError.AlreadyDeactivated`.
final class ICRC154DeactivateErrorAlreadyDeactivated
    extends ICRC154DeactivateError {
  final String value;
  const ICRC154DeactivateErrorAlreadyDeactivated(this.value);

  @override
  CType get candidType => ICRC154DeactivateError.ctype;

  @override
  dynamic get candidValue => Variant('AlreadyDeactivated', value);

  @override
  Map<String, dynamic> toJson() => {'AlreadyDeactivated': value};
}

/// Variant arm `DeactivateError.TooOld` (nullary).
final class ICRC154DeactivateErrorTooOld extends ICRC154DeactivateError {
  const ICRC154DeactivateErrorTooOld();

  @override
  CType get candidType => ICRC154DeactivateError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `DeactivateError.CreatedInFuture`.
final class ICRC154DeactivateErrorCreatedInFuture
    extends ICRC154DeactivateError {
  final BigInt ledgerTime;

  const ICRC154DeactivateErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC154DeactivateError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC154DeactivateErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC154DeactivateErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `DeactivateError.Duplicate`.
final class ICRC154DeactivateErrorDuplicate extends ICRC154DeactivateError {
  final BigInt duplicateOf;

  const ICRC154DeactivateErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC154DeactivateError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC154DeactivateErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC154DeactivateErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `DeactivateError.GenericError`.
final class ICRC154DeactivateErrorGenericError extends ICRC154DeactivateError {
  final BigInt errorCode;
  final String message;

  const ICRC154DeactivateErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC154DeactivateError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC154DeactivateErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC154DeactivateErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

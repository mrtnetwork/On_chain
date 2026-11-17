// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid type alias `Subaccount`.
typedef ICRC7Subaccount = List<int>;

/// Candid record `ICRC7Value.Map`.
final class ICRC7ValueMap with CandidSerializable {
  final String field0;
  final ICRC7Value field1;

  const ICRC7ValueMap({required this.field0, required this.field1});

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => ICRC7Value.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory ICRC7ValueMap.fromCandid(Map<String, dynamic> json) {
    return ICRC7ValueMap(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<ICRC7Value, Map>(
        key: '1',
        parse:
            (e) => ICRC7Value.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICRC7ValueMap.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC7ValueMap.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Account`.
final class ICRC7Account with CandidSerializable {
  final IcpPrincipalAddress owner;
  final ICRC7Subaccount? subaccount;

  const ICRC7Account({required this.owner, this.subaccount});

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

  factory ICRC7Account.fromCandid(Map<String, dynamic> json) {
    return ICRC7Account(
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

  factory ICRC7Account.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC7Account.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Value`.
sealed class ICRC7Value with CandidSerializable {
  const ICRC7Value();

  static CType get ctype => CType.variant([
    Field(Label.named('Blob'), CType.vec(CType.nat8)),
    Field(Label.named('Text'), CType.text),
    Field(Label.named('Nat'), CType.nat),
    Field(Label.named('Int'), CType.int_),
    LazyField(Label.named('Array'), () => CType.vec(ICRC7Value.ctype)),
    LazyField(Label.named('Map'), () => CType.vec(ICRC7ValueMap.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC7Value.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Blob')) {
      return ICRC7ValueBlob(
        json.valueAsBytes<List<int>>('Blob', encoding: StringEncoding.base64),
      );
    }
    if (json.containsKey('Text')) {
      return ICRC7ValueText(json.valueAsString<String>('Text'));
    }
    if (json.containsKey('Nat')) {
      return ICRC7ValueNat(json.valueAsBigInt<BigInt>('Nat'));
    }
    if (json.containsKey('Int')) {
      return ICRC7ValueInt(json.valueAsBigInt<BigInt>('Int'));
    }
    if (json.containsKey('Array')) {
      return ICRC7ValueArray(
        json.valueTo<List<ICRC7Value>, List>(
          key: 'Array',
          parse:
              (e) =>
                  e
                      .map<ICRC7Value>(
                        (x) => ICRC7Value.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('Map')) {
      return ICRC7ValueMap2(
        json.valueTo<List<ICRC7ValueMap>, List>(
          key: 'Map',
          parse:
              (e) =>
                  e
                      .map<ICRC7ValueMap>(
                        (x) => ICRC7ValueMap.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC7Value.fromCandid',
      reason: 'Unknown ICRC7Value arm',
    );
  }

  factory ICRC7Value.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC7Value.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Value.Blob`.
final class ICRC7ValueBlob extends ICRC7Value {
  final List<int> value;
  const ICRC7ValueBlob(this.value);

  @override
  CType get candidType => ICRC7Value.ctype;

  @override
  dynamic get candidValue => Variant('Blob', value);

  @override
  Map<String, dynamic> toJson() => {'Blob': value};
}

/// Variant arm `Value.Text`.
final class ICRC7ValueText extends ICRC7Value {
  final String value;
  const ICRC7ValueText(this.value);

  @override
  CType get candidType => ICRC7Value.ctype;

  @override
  dynamic get candidValue => Variant('Text', value);

  @override
  Map<String, dynamic> toJson() => {'Text': value};
}

/// Variant arm `Value.Nat`.
final class ICRC7ValueNat extends ICRC7Value {
  final BigInt value;
  const ICRC7ValueNat(this.value);

  @override
  CType get candidType => ICRC7Value.ctype;

  @override
  dynamic get candidValue => Variant('Nat', value);

  @override
  Map<String, dynamic> toJson() => {'Nat': value};
}

/// Variant arm `Value.Int`.
final class ICRC7ValueInt extends ICRC7Value {
  final BigInt value;
  const ICRC7ValueInt(this.value);

  @override
  CType get candidType => ICRC7Value.ctype;

  @override
  dynamic get candidValue => Variant('Int', value);

  @override
  Map<String, dynamic> toJson() => {'Int': value};
}

/// Variant arm `Value.Array`.
final class ICRC7ValueArray extends ICRC7Value {
  final List<ICRC7Value> value;
  const ICRC7ValueArray(this.value);

  @override
  CType get candidType => ICRC7Value.ctype;

  @override
  dynamic get candidValue =>
      Variant('Array', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Array': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `Value.Map`.
final class ICRC7ValueMap2 extends ICRC7Value {
  final List<ICRC7ValueMap> value;
  const ICRC7ValueMap2(this.value);

  @override
  CType get candidType => ICRC7Value.ctype;

  @override
  dynamic get candidValue =>
      Variant('Map', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Map': value.map((el) => el.toJson()).toList(),
  };
}

/// Candid record `TransferArg`.
final class ICRC7TransferArg with CandidSerializable {
  final List<int>? fromSubaccount;
  final ICRC7Account to;
  final BigInt tokenId;
  final List<int>? memo;
  final BigInt? createdAtTime;

  const ICRC7TransferArg({
    this.fromSubaccount,
    required this.to,
    required this.tokenId,
    this.memo,
    this.createdAtTime,
  });

  static CType get ctype => CType.record([
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('to'), () => ICRC7Account.ctype),
    Field(Label.named('token_id'), CType.nat),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'from_subaccount': fromSubaccount,
    'to': to.candidValue,
    'token_id': tokenId,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'from_subaccount': fromSubaccount,
    'to': to.toJson(),
    'token_id': tokenId,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  factory ICRC7TransferArg.fromCandid(Map<String, dynamic> json) {
    return ICRC7TransferArg(
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      to: json.valueTo<ICRC7Account, Map>(
        key: 'to',
        parse:
            (e) => ICRC7Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      tokenId: json.valueAsBigInt<BigInt>('token_id'),
      memo: json.valueAsBytes<List<int>?>(
        'memo',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
    );
  }

  factory ICRC7TransferArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC7TransferArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `TransferResult`.
sealed class ICRC7TransferResult with CandidSerializable {
  const ICRC7TransferResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC7TransferError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC7TransferResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC7TransferResultOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC7TransferResultErr(
        json.valueTo<ICRC7TransferError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC7TransferError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC7TransferResult.fromCandid',
      reason: 'Unknown ICRC7TransferResult arm',
    );
  }

  factory ICRC7TransferResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC7TransferResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferResult.Ok`.
final class ICRC7TransferResultOk extends ICRC7TransferResult {
  final BigInt value;
  const ICRC7TransferResultOk(this.value);

  @override
  CType get candidType => ICRC7TransferResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `TransferResult.Err`.
final class ICRC7TransferResultErr extends ICRC7TransferResult {
  final ICRC7TransferError value;
  const ICRC7TransferResultErr(this.value);

  @override
  CType get candidType => ICRC7TransferResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `TransferError`.
sealed class ICRC7TransferError with CandidSerializable {
  const ICRC7TransferError();

  static CType get ctype => CType.variant([
    Field(Label.named('NonExistingTokenId'), CType.null_),
    Field(Label.named('InvalidRecipient'), CType.null_),
    Field(Label.named('Unauthorized'), CType.null_),
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
    Field(
      Label.named('GenericBatchError'),
      CType.record([
        Field(Label.named('error_code'), CType.nat),
        Field(Label.named('message'), CType.text),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC7TransferError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('NonExistingTokenId')) {
      return const ICRC7TransferErrorNonExistingTokenId();
    }
    if (json.containsKey('InvalidRecipient')) {
      return const ICRC7TransferErrorInvalidRecipient();
    }
    if (json.containsKey('Unauthorized')) {
      return const ICRC7TransferErrorUnauthorized();
    }
    if (json.containsKey('TooOld')) {
      return const ICRC7TransferErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC7TransferErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC7TransferErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC7TransferErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('GenericBatchError')) {
      return ICRC7TransferErrorGenericBatchError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericBatchError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC7TransferError.fromCandid',
      reason: 'Unknown ICRC7TransferError arm',
    );
  }

  factory ICRC7TransferError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC7TransferError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferError.NonExistingTokenId` (nullary).
final class ICRC7TransferErrorNonExistingTokenId extends ICRC7TransferError {
  const ICRC7TransferErrorNonExistingTokenId();

  @override
  CType get candidType => ICRC7TransferError.ctype;

  @override
  dynamic get candidValue => const Variant('NonExistingTokenId', null);

  @override
  Map<String, dynamic> toJson() => {'NonExistingTokenId': null};
}

/// Variant arm `TransferError.InvalidRecipient` (nullary).
final class ICRC7TransferErrorInvalidRecipient extends ICRC7TransferError {
  const ICRC7TransferErrorInvalidRecipient();

  @override
  CType get candidType => ICRC7TransferError.ctype;

  @override
  dynamic get candidValue => const Variant('InvalidRecipient', null);

  @override
  Map<String, dynamic> toJson() => {'InvalidRecipient': null};
}

/// Variant arm `TransferError.Unauthorized` (nullary).
final class ICRC7TransferErrorUnauthorized extends ICRC7TransferError {
  const ICRC7TransferErrorUnauthorized();

  @override
  CType get candidType => ICRC7TransferError.ctype;

  @override
  dynamic get candidValue => const Variant('Unauthorized', null);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': null};
}

/// Variant arm `TransferError.TooOld` (nullary).
final class ICRC7TransferErrorTooOld extends ICRC7TransferError {
  const ICRC7TransferErrorTooOld();

  @override
  CType get candidType => ICRC7TransferError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `TransferError.CreatedInFuture`.
final class ICRC7TransferErrorCreatedInFuture extends ICRC7TransferError {
  final BigInt ledgerTime;

  const ICRC7TransferErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC7TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC7TransferErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC7TransferErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `TransferError.Duplicate`.
final class ICRC7TransferErrorDuplicate extends ICRC7TransferError {
  final BigInt duplicateOf;

  const ICRC7TransferErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC7TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC7TransferErrorDuplicate.fromCandid(Map<String, dynamic> json) {
    return ICRC7TransferErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `TransferError.GenericError`.
final class ICRC7TransferErrorGenericError extends ICRC7TransferError {
  final BigInt errorCode;
  final String message;

  const ICRC7TransferErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC7TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC7TransferErrorGenericError.fromCandid(Map<String, dynamic> json) {
    return ICRC7TransferErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Variant arm `TransferError.GenericBatchError`.
final class ICRC7TransferErrorGenericBatchError extends ICRC7TransferError {
  final BigInt errorCode;
  final String message;

  const ICRC7TransferErrorGenericBatchError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC7TransferError.ctype;

  @override
  dynamic get candidValue => Variant('GenericBatchError', {
    'error_code': errorCode,
    'message': message,
  });

  @override
  Map<String, dynamic> toJson() => {
    'GenericBatchError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC7TransferErrorGenericBatchError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC7TransferErrorGenericBatchError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid type alias `Timestamp`.
typedef ICRC1Timestamp = BigInt;

/// Candid type alias `Duration`.
typedef ICRC1Duration = BigInt;

/// Candid type alias `Subaccount`.
typedef ICRC1Subaccount = List<int>;

/// Candid record `ICRC1Icrc1Metadata.response`.
final class ICRC1Icrc1MetadataResponse with CandidSerializable {
  final String field0;
  final ICRC1Value field1;

  const ICRC1Icrc1MetadataResponse({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => ICRC1Value.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory ICRC1Icrc1MetadataResponse.fromCandid(Map<String, dynamic> json) {
    return ICRC1Icrc1MetadataResponse(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<ICRC1Value, Map>(
        key: '1',
        parse:
            (e) => ICRC1Value.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICRC1Icrc1MetadataResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC1Icrc1MetadataResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ICRC1Icrc1Transfer.response`.
sealed class ICRC1Icrc1TransferResponse with CandidSerializable {
  const ICRC1Icrc1TransferResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC1TransferError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC1Icrc1TransferResponse.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC1Icrc1TransferResponseOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC1Icrc1TransferResponseErr(
        json.valueTo<ICRC1TransferError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC1TransferError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC1Icrc1TransferResponse.fromCandid',
      reason: 'Unknown ICRC1Icrc1TransferResponse arm',
    );
  }

  factory ICRC1Icrc1TransferResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC1Icrc1TransferResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICRC1Icrc1Transfer.response.Ok`.
final class ICRC1Icrc1TransferResponseOk extends ICRC1Icrc1TransferResponse {
  final BigInt value;
  const ICRC1Icrc1TransferResponseOk(this.value);

  @override
  CType get candidType => ICRC1Icrc1TransferResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ICRC1Icrc1Transfer.response.Err`.
final class ICRC1Icrc1TransferResponseErr extends ICRC1Icrc1TransferResponse {
  final ICRC1TransferError value;
  const ICRC1Icrc1TransferResponseErr(this.value);

  @override
  CType get candidType => ICRC1Icrc1TransferResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `ICRC1Icrc1SupportedStandards.response`.
final class ICRC1Icrc1SupportedStandardsResponse with CandidSerializable {
  final String name;
  final String url;

  const ICRC1Icrc1SupportedStandardsResponse({
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

  factory ICRC1Icrc1SupportedStandardsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC1Icrc1SupportedStandardsResponse(
      name: json.valueAsString<String>('name'),
      url: json.valueAsString<String>('url'),
    );
  }

  factory ICRC1Icrc1SupportedStandardsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC1Icrc1SupportedStandardsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Account`.
final class ICRC1Account with CandidSerializable {
  final IcpPrincipalAddress owner;
  final ICRC1Subaccount? subaccount;

  const ICRC1Account({required this.owner, this.subaccount});

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

  factory ICRC1Account.fromCandid(Map<String, dynamic> json) {
    return ICRC1Account(
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

  factory ICRC1Account.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC1Account.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TransferArgs`.
final class ICRC1TransferArgs with CandidSerializable {
  final ICRC1Subaccount? fromSubaccount;
  final ICRC1Account to;
  final BigInt amount;
  final BigInt? fee;
  final List<int>? memo;
  final ICRC1Timestamp? createdAtTime;

  const ICRC1TransferArgs({
    this.fromSubaccount,
    required this.to,
    required this.amount,
    this.fee,
    this.memo,
    this.createdAtTime,
  });

  static CType get ctype => CType.record([
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('to'), () => ICRC1Account.ctype),
    Field(Label.named('amount'), CType.nat),
    Field(Label.named('fee'), CType.opt(CType.nat)),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'from_subaccount': fromSubaccount,
    'to': to.candidValue,
    'amount': amount,
    'fee': fee,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'from_subaccount': fromSubaccount,
    'to': to.toJson(),
    'amount': amount,
    'fee': fee,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  factory ICRC1TransferArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC1TransferArgs(
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      to: json.valueTo<ICRC1Account, Map>(
        key: 'to',
        parse:
            (e) => ICRC1Account.fromCandid(
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

  factory ICRC1TransferArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC1TransferArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `TransferError`.
sealed class ICRC1TransferError with CandidSerializable {
  const ICRC1TransferError();

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

  factory ICRC1TransferError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('BadFee')) {
      return ICRC1TransferErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('BadBurn')) {
      return ICRC1TransferErrorBadBurn.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadBurn']),
      );
    }
    if (json.containsKey('InsufficientFunds')) {
      return ICRC1TransferErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const ICRC1TransferErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC1TransferErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC1TransferErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const ICRC1TransferErrorTemporarilyUnavailable();
    }
    if (json.containsKey('GenericError')) {
      return ICRC1TransferErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC1TransferError.fromCandid',
      reason: 'Unknown ICRC1TransferError arm',
    );
  }

  factory ICRC1TransferError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC1TransferError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferError.BadFee`.
final class ICRC1TransferErrorBadFee extends ICRC1TransferError {
  final BigInt expectedFee;

  const ICRC1TransferErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => ICRC1TransferError.ctype;

  @override
  dynamic get candidValue => Variant('BadFee', {'expected_fee': expectedFee});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee},
  };

  factory ICRC1TransferErrorBadFee.fromCandid(Map<String, dynamic> json) {
    return ICRC1TransferErrorBadFee(
      expectedFee: json.valueAsBigInt<BigInt>('expected_fee'),
    );
  }
}

/// Variant arm `TransferError.BadBurn`.
final class ICRC1TransferErrorBadBurn extends ICRC1TransferError {
  final BigInt minBurnAmount;

  const ICRC1TransferErrorBadBurn({required this.minBurnAmount});

  @override
  CType get candidType => ICRC1TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('BadBurn', {'min_burn_amount': minBurnAmount});

  @override
  Map<String, dynamic> toJson() => {
    'BadBurn': {'min_burn_amount': minBurnAmount},
  };

  factory ICRC1TransferErrorBadBurn.fromCandid(Map<String, dynamic> json) {
    return ICRC1TransferErrorBadBurn(
      minBurnAmount: json.valueAsBigInt<BigInt>('min_burn_amount'),
    );
  }
}

/// Variant arm `TransferError.InsufficientFunds`.
final class ICRC1TransferErrorInsufficientFunds extends ICRC1TransferError {
  final BigInt balance;

  const ICRC1TransferErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => ICRC1TransferError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory ICRC1TransferErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC1TransferErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Variant arm `TransferError.TooOld` (nullary).
final class ICRC1TransferErrorTooOld extends ICRC1TransferError {
  const ICRC1TransferErrorTooOld();

  @override
  CType get candidType => ICRC1TransferError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `TransferError.CreatedInFuture`.
final class ICRC1TransferErrorCreatedInFuture extends ICRC1TransferError {
  final ICRC1Timestamp ledgerTime;

  const ICRC1TransferErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC1TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC1TransferErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC1TransferErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `TransferError.Duplicate`.
final class ICRC1TransferErrorDuplicate extends ICRC1TransferError {
  final BigInt duplicateOf;

  const ICRC1TransferErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC1TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC1TransferErrorDuplicate.fromCandid(Map<String, dynamic> json) {
    return ICRC1TransferErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `TransferError.TemporarilyUnavailable` (nullary).
final class ICRC1TransferErrorTemporarilyUnavailable
    extends ICRC1TransferError {
  const ICRC1TransferErrorTemporarilyUnavailable();

  @override
  CType get candidType => ICRC1TransferError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `TransferError.GenericError`.
final class ICRC1TransferErrorGenericError extends ICRC1TransferError {
  final BigInt errorCode;
  final String message;

  const ICRC1TransferErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC1TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC1TransferErrorGenericError.fromCandid(Map<String, dynamic> json) {
    return ICRC1TransferErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid variant `Value`.
sealed class ICRC1Value with CandidSerializable {
  const ICRC1Value();

  static CType get ctype => CType.variant([
    Field(Label.named('Nat'), CType.nat),
    Field(Label.named('Int'), CType.int_),
    Field(Label.named('Text'), CType.text),
    Field(Label.named('Blob'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC1Value.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Nat')) {
      return ICRC1ValueNat(json.valueAsBigInt<BigInt>('Nat'));
    }
    if (json.containsKey('Int')) {
      return ICRC1ValueInt(json.valueAsBigInt<BigInt>('Int'));
    }
    if (json.containsKey('Text')) {
      return ICRC1ValueText(json.valueAsString<String>('Text'));
    }
    if (json.containsKey('Blob')) {
      return ICRC1ValueBlob(
        json.valueAsBytes<List<int>>('Blob', encoding: StringEncoding.base64),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC1Value.fromCandid',
      reason: 'Unknown ICRC1Value arm',
    );
  }

  factory ICRC1Value.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC1Value.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Value.Nat`.
final class ICRC1ValueNat extends ICRC1Value {
  final BigInt value;
  const ICRC1ValueNat(this.value);

  @override
  CType get candidType => ICRC1Value.ctype;

  @override
  dynamic get candidValue => Variant('Nat', value);

  @override
  Map<String, dynamic> toJson() => {'Nat': value};
}

/// Variant arm `Value.Int`.
final class ICRC1ValueInt extends ICRC1Value {
  final BigInt value;
  const ICRC1ValueInt(this.value);

  @override
  CType get candidType => ICRC1Value.ctype;

  @override
  dynamic get candidValue => Variant('Int', value);

  @override
  Map<String, dynamic> toJson() => {'Int': value};
}

/// Variant arm `Value.Text`.
final class ICRC1ValueText extends ICRC1Value {
  final String value;
  const ICRC1ValueText(this.value);

  @override
  CType get candidType => ICRC1Value.ctype;

  @override
  dynamic get candidValue => Variant('Text', value);

  @override
  Map<String, dynamic> toJson() => {'Text': value};
}

/// Variant arm `Value.Blob`.
final class ICRC1ValueBlob extends ICRC1Value {
  final List<int> value;
  const ICRC1ValueBlob(this.value);

  @override
  CType get candidType => ICRC1Value.ctype;

  @override
  dynamic get candidValue => Variant('Blob', value);

  @override
  Map<String, dynamic> toJson() => {'Blob': value};
}

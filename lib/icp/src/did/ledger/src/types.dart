// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid type alias `AccountIdentifier`.
typedef LEDGERAccountIdentifier = List<int>;

/// Candid type alias `SubAccount`.
typedef LEDGERSubAccount = List<int>;

/// Candid type alias `BlockIndex`.
typedef LEDGERBlockIndex = BigInt;

/// Candid type alias `Memo`.
typedef LEDGERMemo = BigInt;

/// Candid type alias `QueryArchiveFn`.
typedef LEDGERQueryArchiveFn = FuncRef;

/// CType for alias `QueryArchiveFn`.
abstract final class LEDGERQueryArchiveFnCandid {
  static CType get ctype => CType.func(const FunctionType([], [], []));
}

/// Candid type alias `TextAccountIdentifier`.
typedef LEDGERTextAccountIdentifier = String;

/// Candid type alias `Icrc1BlockIndex`.
typedef LEDGERIcrc1BlockIndex = BigInt;

/// Candid type alias `Icrc1Timestamp`.
typedef LEDGERIcrc1Timestamp = BigInt;

/// Candid type alias `Icrc1Tokens`.
typedef LEDGERIcrc1Tokens = BigInt;

/// Candid type alias `Allowances`.
typedef LEDGERAllowances = List<LEDGERAllowancesItem>;

/// CType for alias `Allowances`.
abstract final class LEDGERAllowancesCandid {
  static CType get ctype => CType.vec(LEDGERAllowancesItem.ctype);
}

/// Candid record `LEDGERInitArgs.initial_values`.
final class LEDGERInitArgsInitialValues with CandidSerializable {
  final LEDGERTextAccountIdentifier field0;
  final LEDGERTokens field1;

  const LEDGERInitArgsInitialValues({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => LEDGERTokens.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory LEDGERInitArgsInitialValues.fromCandid(Map<String, dynamic> json) {
    return LEDGERInitArgsInitialValues(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<LEDGERTokens, Map>(
        key: '1',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERInitArgsInitialValues.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERInitArgsInitialValues.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `LEDGERIcrc21ConsentMessageSpec.device_spec`.
sealed class LEDGERIcrc21ConsentMessageSpecDeviceSpec with CandidSerializable {
  const LEDGERIcrc21ConsentMessageSpecDeviceSpec();

  static CType get ctype => CType.variant([
    Field(Label.named('GenericDisplay'), CType.null_),
    Field(Label.named('FieldsDisplay'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERIcrc21ConsentMessageSpecDeviceSpec.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('GenericDisplay')) {
      return const LEDGERIcrc21ConsentMessageSpecDeviceSpecGenericDisplay();
    }
    if (json.containsKey('FieldsDisplay')) {
      return const LEDGERIcrc21ConsentMessageSpecDeviceSpecFieldsDisplay();
    }
    throw OnChainErrors.icpCandid(
      'LEDGERIcrc21ConsentMessageSpecDeviceSpec.fromCandid',
      reason: 'Unknown LEDGERIcrc21ConsentMessageSpecDeviceSpec arm',
    );
  }

  factory LEDGERIcrc21ConsentMessageSpecDeviceSpec.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc21ConsentMessageSpecDeviceSpec.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `LEDGERIcrc21ConsentMessageSpec.device_spec.GenericDisplay` (nullary).
final class LEDGERIcrc21ConsentMessageSpecDeviceSpecGenericDisplay
    extends LEDGERIcrc21ConsentMessageSpecDeviceSpec {
  const LEDGERIcrc21ConsentMessageSpecDeviceSpecGenericDisplay();

  @override
  CType get candidType => LEDGERIcrc21ConsentMessageSpecDeviceSpec.ctype;

  @override
  dynamic get candidValue => const Variant('GenericDisplay', null);

  @override
  Map<String, dynamic> toJson() => {'GenericDisplay': null};
}

/// Variant arm `LEDGERIcrc21ConsentMessageSpec.device_spec.FieldsDisplay` (nullary).
final class LEDGERIcrc21ConsentMessageSpecDeviceSpecFieldsDisplay
    extends LEDGERIcrc21ConsentMessageSpecDeviceSpec {
  const LEDGERIcrc21ConsentMessageSpecDeviceSpecFieldsDisplay();

  @override
  CType get candidType => LEDGERIcrc21ConsentMessageSpecDeviceSpec.ctype;

  @override
  dynamic get candidValue => const Variant('FieldsDisplay', null);

  @override
  Map<String, dynamic> toJson() => {'FieldsDisplay': null};
}

/// Candid record `LEDGERFieldsDisplay.fields`.
final class LEDGERFieldsDisplayFields with CandidSerializable {
  final String field0;
  final LEDGERIcrc21Value field1;

  const LEDGERFieldsDisplayFields({required this.field0, required this.field1});

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => LEDGERIcrc21Value.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory LEDGERFieldsDisplayFields.fromCandid(Map<String, dynamic> json) {
    return LEDGERFieldsDisplayFields(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<LEDGERIcrc21Value, Map>(
        key: '1',
        parse:
            (e) => LEDGERIcrc21Value.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERFieldsDisplayFields.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERFieldsDisplayFields.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `LEDGERAllowances.item`.
final class LEDGERAllowancesItem with CandidSerializable {
  final LEDGERTextAccountIdentifier fromAccountId;
  final LEDGERTextAccountIdentifier toSpenderId;
  final LEDGERTokens allowance;
  final BigInt? expiresAt;

  const LEDGERAllowancesItem({
    required this.fromAccountId,
    required this.toSpenderId,
    required this.allowance,
    this.expiresAt,
  });

  static CType get ctype => CType.record([
    Field(Label.named('from_account_id'), CType.text),
    Field(Label.named('to_spender_id'), CType.text),
    LazyField(Label.named('allowance'), () => LEDGERTokens.ctype),
    Field(Label.named('expires_at'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'from_account_id': fromAccountId,
    'to_spender_id': toSpenderId,
    'allowance': allowance.candidValue,
    'expires_at': expiresAt,
  };

  Map<String, dynamic> toJson() => {
    'from_account_id': fromAccountId,
    'to_spender_id': toSpenderId,
    'allowance': allowance.toJson(),
    'expires_at': expiresAt,
  };

  factory LEDGERAllowancesItem.fromCandid(Map<String, dynamic> json) {
    return LEDGERAllowancesItem(
      fromAccountId: json.valueAsString<String>('from_account_id'),
      toSpenderId: json.valueAsString<String>('to_spender_id'),
      allowance: json.valueTo<LEDGERTokens, Map>(
        key: 'allowance',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      expiresAt: json.valueAsBigInt<BigInt?>('expires_at'),
    );
  }

  factory LEDGERAllowancesItem.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERAllowancesItem.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `LEDGERSymbol.response`.
final class LEDGERSymbolResponse with CandidSerializable {
  final String symbol;

  const LEDGERSymbolResponse({required this.symbol});

  static CType get ctype =>
      CType.record([Field(Label.named('symbol'), CType.text)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'symbol': symbol};

  Map<String, dynamic> toJson() => {'symbol': symbol};

  factory LEDGERSymbolResponse.fromCandid(Map<String, dynamic> json) {
    return LEDGERSymbolResponse(symbol: json.valueAsString<String>('symbol'));
  }

  factory LEDGERSymbolResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERSymbolResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `LEDGERName.response`.
final class LEDGERNameResponse with CandidSerializable {
  final String name;

  const LEDGERNameResponse({required this.name});

  static CType get ctype =>
      CType.record([Field(Label.named('name'), CType.text)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'name': name};

  Map<String, dynamic> toJson() => {'name': name};

  factory LEDGERNameResponse.fromCandid(Map<String, dynamic> json) {
    return LEDGERNameResponse(name: json.valueAsString<String>('name'));
  }

  factory LEDGERNameResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERNameResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `LEDGERDecimals.response`.
final class LEDGERDecimalsResponse with CandidSerializable {
  final int decimals;

  const LEDGERDecimalsResponse({required this.decimals});

  static CType get ctype =>
      CType.record([Field(Label.named('decimals'), CType.nat32)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'decimals': decimals};

  Map<String, dynamic> toJson() => {'decimals': decimals};

  factory LEDGERDecimalsResponse.fromCandid(Map<String, dynamic> json) {
    return LEDGERDecimalsResponse(decimals: json.valueAsInt<int>('decimals'));
  }

  factory LEDGERDecimalsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERDecimalsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `LEDGERIcrc1Metadata.response`.
final class LEDGERIcrc1MetadataResponse with CandidSerializable {
  final String field0;
  final LEDGERValue field1;

  const LEDGERIcrc1MetadataResponse({
    required this.field0,
    required this.field1,
  });

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => LEDGERValue.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory LEDGERIcrc1MetadataResponse.fromCandid(Map<String, dynamic> json) {
    return LEDGERIcrc1MetadataResponse(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<LEDGERValue, Map>(
        key: '1',
        parse:
            (e) => LEDGERValue.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERIcrc1MetadataResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc1MetadataResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `LEDGERIcrc1SupportedStandards.response`.
final class LEDGERIcrc1SupportedStandardsResponse with CandidSerializable {
  final String name;
  final String url;

  const LEDGERIcrc1SupportedStandardsResponse({
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

  factory LEDGERIcrc1SupportedStandardsResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERIcrc1SupportedStandardsResponse(
      name: json.valueAsString<String>('name'),
      url: json.valueAsString<String>('url'),
    );
  }

  factory LEDGERIcrc1SupportedStandardsResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc1SupportedStandardsResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Tokens`.
final class LEDGERTokens with CandidSerializable {
  final BigInt e8s;

  const LEDGERTokens({required this.e8s});

  static CType get ctype =>
      CType.record([Field(Label.named('e8s'), CType.nat64)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'e8s': e8s};

  Map<String, dynamic> toJson() => {'e8s': e8s};

  factory LEDGERTokens.fromCandid(Map<String, dynamic> json) {
    return LEDGERTokens(e8s: json.valueAsBigInt<BigInt>('e8s'));
  }

  factory LEDGERTokens.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTokens.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TimeStamp`.
final class LEDGERTimeStamp with CandidSerializable {
  final BigInt timestampNanos;

  const LEDGERTimeStamp({required this.timestampNanos});

  static CType get ctype =>
      CType.record([Field(Label.named('timestamp_nanos'), CType.nat64)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'timestamp_nanos': timestampNanos};

  Map<String, dynamic> toJson() => {'timestamp_nanos': timestampNanos};

  factory LEDGERTimeStamp.fromCandid(Map<String, dynamic> json) {
    return LEDGERTimeStamp(
      timestampNanos: json.valueAsBigInt<BigInt>('timestamp_nanos'),
    );
  }

  factory LEDGERTimeStamp.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTimeStamp.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Transaction`.
final class LEDGERTransaction with CandidSerializable {
  final LEDGERMemo memo;
  final List<int>? icrc1Memo;
  final LEDGEROperation? operation;
  final LEDGERTimeStamp createdAtTime;

  const LEDGERTransaction({
    required this.memo,
    this.icrc1Memo,
    this.operation,
    required this.createdAtTime,
  });

  static CType get ctype => CType.record([
    Field(Label.named('memo'), CType.nat64),
    Field(Label.named('icrc1_memo'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('operation'), () => CType.opt(LEDGEROperation.ctype)),
    LazyField(Label.named('created_at_time'), () => LEDGERTimeStamp.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'memo': memo,
    'icrc1_memo': icrc1Memo,
    'operation': operation?.candidValue,
    'created_at_time': createdAtTime.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'memo': memo,
    'icrc1_memo': icrc1Memo,
    'operation': operation?.toJson(),
    'created_at_time': createdAtTime.toJson(),
  };

  factory LEDGERTransaction.fromCandid(Map<String, dynamic> json) {
    return LEDGERTransaction(
      memo: json.valueAsBigInt<BigInt>('memo'),
      icrc1Memo: json.valueAsBytes<List<int>?>(
        'icrc1_memo',
        encoding: StringEncoding.base64,
      ),
      operation: json.valueTo<LEDGEROperation?, Map>(
        key: 'operation',
        parse:
            (e) => LEDGEROperation.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      createdAtTime: json.valueTo<LEDGERTimeStamp, Map>(
        key: 'created_at_time',
        parse:
            (e) => LEDGERTimeStamp.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERTransaction.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTransaction.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TransferArgs`.
final class LEDGERTransferArgs with CandidSerializable {
  final LEDGERMemo memo;
  final LEDGERTokens amount;
  final LEDGERTokens fee;
  final LEDGERSubAccount? fromSubaccount;
  final LEDGERAccountIdentifier to;
  final LEDGERTimeStamp? createdAtTime;

  const LEDGERTransferArgs({
    required this.memo,
    required this.amount,
    required this.fee,
    this.fromSubaccount,
    required this.to,
    this.createdAtTime,
  });

  static CType get ctype => CType.record([
    Field(Label.named('memo'), CType.nat64),
    LazyField(Label.named('amount'), () => LEDGERTokens.ctype),
    LazyField(Label.named('fee'), () => LEDGERTokens.ctype),
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('to'), CType.vec(CType.nat8)),
    LazyField(
      Label.named('created_at_time'),
      () => CType.opt(LEDGERTimeStamp.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'memo': memo,
    'amount': amount.candidValue,
    'fee': fee.candidValue,
    'from_subaccount': fromSubaccount,
    'to': to,
    'created_at_time': createdAtTime?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'memo': memo,
    'amount': amount.toJson(),
    'fee': fee.toJson(),
    'from_subaccount': fromSubaccount,
    'to': to,
    'created_at_time': createdAtTime?.toJson(),
  };

  factory LEDGERTransferArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERTransferArgs(
      memo: json.valueAsBigInt<BigInt>('memo'),
      amount: json.valueTo<LEDGERTokens, Map>(
        key: 'amount',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fee: json.valueTo<LEDGERTokens, Map>(
        key: 'fee',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      to: json.valueAsBytes<List<int>>('to', encoding: StringEncoding.base64),
      createdAtTime: json.valueTo<LEDGERTimeStamp?, Map>(
        key: 'created_at_time',
        parse:
            (e) => LEDGERTimeStamp.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERTransferArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTransferArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `TransferError`.
sealed class LEDGERTransferError with CandidSerializable {
  const LEDGERTransferError();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('BadFee'),
      () => CType.record([
        LazyField(Label.named('expected_fee'), () => LEDGERTokens.ctype),
      ]),
    ),
    LazyField(
      Label.named('InsufficientFunds'),
      () => CType.record([
        LazyField(Label.named('balance'), () => LEDGERTokens.ctype),
      ]),
    ),
    Field(
      Label.named('TxTooOld'),
      CType.record([Field(Label.named('allowed_window_nanos'), CType.nat64)]),
    ),
    Field(Label.named('TxCreatedInFuture'), CType.null_),
    Field(
      Label.named('TxDuplicate'),
      CType.record([Field(Label.named('duplicate_of'), CType.nat64)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERTransferError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('BadFee')) {
      return LEDGERTransferErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('InsufficientFunds')) {
      return LEDGERTransferErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    if (json.containsKey('TxTooOld')) {
      return LEDGERTransferErrorTxTooOld.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['TxTooOld']),
      );
    }
    if (json.containsKey('TxCreatedInFuture')) {
      return const LEDGERTransferErrorTxCreatedInFuture();
    }
    if (json.containsKey('TxDuplicate')) {
      return LEDGERTransferErrorTxDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['TxDuplicate']),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERTransferError.fromCandid',
      reason: 'Unknown LEDGERTransferError arm',
    );
  }

  factory LEDGERTransferError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTransferError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferError.BadFee`.
final class LEDGERTransferErrorBadFee extends LEDGERTransferError {
  final LEDGERTokens expectedFee;

  const LEDGERTransferErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => LEDGERTransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('BadFee', {'expected_fee': expectedFee.candidValue});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee.toJson()},
  };

  factory LEDGERTransferErrorBadFee.fromCandid(Map<String, dynamic> json) {
    return LEDGERTransferErrorBadFee(
      expectedFee: json.valueTo<LEDGERTokens, Map>(
        key: 'expected_fee',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }
}

/// Variant arm `TransferError.InsufficientFunds`.
final class LEDGERTransferErrorInsufficientFunds extends LEDGERTransferError {
  final LEDGERTokens balance;

  const LEDGERTransferErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => LEDGERTransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('InsufficientFunds', {'balance': balance.candidValue});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance.toJson()},
  };

  factory LEDGERTransferErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERTransferErrorInsufficientFunds(
      balance: json.valueTo<LEDGERTokens, Map>(
        key: 'balance',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }
}

/// Variant arm `TransferError.TxTooOld`.
final class LEDGERTransferErrorTxTooOld extends LEDGERTransferError {
  final BigInt allowedWindowNanos;

  const LEDGERTransferErrorTxTooOld({required this.allowedWindowNanos});

  @override
  CType get candidType => LEDGERTransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('TxTooOld', {'allowed_window_nanos': allowedWindowNanos});

  @override
  Map<String, dynamic> toJson() => {
    'TxTooOld': {'allowed_window_nanos': allowedWindowNanos},
  };

  factory LEDGERTransferErrorTxTooOld.fromCandid(Map<String, dynamic> json) {
    return LEDGERTransferErrorTxTooOld(
      allowedWindowNanos: json.valueAsBigInt<BigInt>('allowed_window_nanos'),
    );
  }
}

/// Variant arm `TransferError.TxCreatedInFuture` (nullary).
final class LEDGERTransferErrorTxCreatedInFuture extends LEDGERTransferError {
  const LEDGERTransferErrorTxCreatedInFuture();

  @override
  CType get candidType => LEDGERTransferError.ctype;

  @override
  dynamic get candidValue => const Variant('TxCreatedInFuture', null);

  @override
  Map<String, dynamic> toJson() => {'TxCreatedInFuture': null};
}

/// Variant arm `TransferError.TxDuplicate`.
final class LEDGERTransferErrorTxDuplicate extends LEDGERTransferError {
  final LEDGERBlockIndex duplicateOf;

  const LEDGERTransferErrorTxDuplicate({required this.duplicateOf});

  @override
  CType get candidType => LEDGERTransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('TxDuplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'TxDuplicate': {'duplicate_of': duplicateOf},
  };

  factory LEDGERTransferErrorTxDuplicate.fromCandid(Map<String, dynamic> json) {
    return LEDGERTransferErrorTxDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Candid variant `TransferResult`.
sealed class LEDGERTransferResult with CandidSerializable {
  const LEDGERTransferResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat64),
    LazyField(Label.named('Err'), () => LEDGERTransferError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERTransferResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return LEDGERTransferResultOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return LEDGERTransferResultErr(
        json.valueTo<LEDGERTransferError, Map>(
          key: 'Err',
          parse:
              (e) => LEDGERTransferError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERTransferResult.fromCandid',
      reason: 'Unknown LEDGERTransferResult arm',
    );
  }

  factory LEDGERTransferResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTransferResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferResult.Ok`.
final class LEDGERTransferResultOk extends LEDGERTransferResult {
  final LEDGERBlockIndex value;
  const LEDGERTransferResultOk(this.value);

  @override
  CType get candidType => LEDGERTransferResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `TransferResult.Err`.
final class LEDGERTransferResultErr extends LEDGERTransferResult {
  final LEDGERTransferError value;
  const LEDGERTransferResultErr(this.value);

  @override
  CType get candidType => LEDGERTransferResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `AccountBalanceArgs`.
final class LEDGERAccountBalanceArgs with CandidSerializable {
  final LEDGERAccountIdentifier account;

  const LEDGERAccountBalanceArgs({required this.account});

  static CType get ctype =>
      CType.record([Field(Label.named('account'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'account': account};

  Map<String, dynamic> toJson() => {'account': account};

  factory LEDGERAccountBalanceArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERAccountBalanceArgs(
      account: json.valueAsBytes<List<int>>(
        'account',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory LEDGERAccountBalanceArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERAccountBalanceArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TransferFeeArg`.
final class LEDGERTransferFeeArg with CandidSerializable {
  const LEDGERTransferFeeArg();

  static CType get ctype => CType.record(const []);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => <String, dynamic>{};

  Map<String, dynamic> toJson() => <String, dynamic>{};

  factory LEDGERTransferFeeArg.fromCandid(Map<String, dynamic> json) {
    return const LEDGERTransferFeeArg();
  }

  factory LEDGERTransferFeeArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTransferFeeArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TransferFee`.
final class LEDGERTransferFee with CandidSerializable {
  final LEDGERTokens transferFee;

  const LEDGERTransferFee({required this.transferFee});

  static CType get ctype => CType.record([
    LazyField(Label.named('transfer_fee'), () => LEDGERTokens.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'transfer_fee': transferFee.candidValue};

  Map<String, dynamic> toJson() => {'transfer_fee': transferFee.toJson()};

  factory LEDGERTransferFee.fromCandid(Map<String, dynamic> json) {
    return LEDGERTransferFee(
      transferFee: json.valueTo<LEDGERTokens, Map>(
        key: 'transfer_fee',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERTransferFee.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTransferFee.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetBlocksArgs`.
final class LEDGERGetBlocksArgs with CandidSerializable {
  final LEDGERBlockIndex start;
  final BigInt length;

  const LEDGERGetBlocksArgs({required this.start, required this.length});

  static CType get ctype => CType.record([
    Field(Label.named('start'), CType.nat64),
    Field(Label.named('length'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'start': start, 'length': length};

  Map<String, dynamic> toJson() => {'start': start, 'length': length};

  factory LEDGERGetBlocksArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERGetBlocksArgs(
      start: json.valueAsBigInt<BigInt>('start'),
      length: json.valueAsBigInt<BigInt>('length'),
    );
  }

  factory LEDGERGetBlocksArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERGetBlocksArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Operation`.
sealed class LEDGEROperation with CandidSerializable {
  const LEDGEROperation();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('Mint'),
      () => CType.record([
        Field(Label.named('to'), CType.vec(CType.nat8)),
        LazyField(Label.named('amount'), () => LEDGERTokens.ctype),
      ]),
    ),
    LazyField(
      Label.named('Burn'),
      () => CType.record([
        Field(Label.named('from'), CType.vec(CType.nat8)),
        Field(Label.named('spender'), CType.opt(CType.vec(CType.nat8))),
        LazyField(Label.named('amount'), () => LEDGERTokens.ctype),
      ]),
    ),
    LazyField(
      Label.named('Transfer'),
      () => CType.record([
        Field(Label.named('from'), CType.vec(CType.nat8)),
        Field(Label.named('to'), CType.vec(CType.nat8)),
        LazyField(Label.named('amount'), () => LEDGERTokens.ctype),
        LazyField(Label.named('fee'), () => LEDGERTokens.ctype),
        Field(Label.named('spender'), CType.opt(CType.vec(CType.nat8))),
      ]),
    ),
    LazyField(
      Label.named('Approve'),
      () => CType.record([
        Field(Label.named('from'), CType.vec(CType.nat8)),
        Field(Label.named('spender'), CType.vec(CType.nat8)),
        Field(Label.named('allowance_e8s'), CType.int_),
        LazyField(Label.named('allowance'), () => LEDGERTokens.ctype),
        LazyField(Label.named('fee'), () => LEDGERTokens.ctype),
        LazyField(
          Label.named('expires_at'),
          () => CType.opt(LEDGERTimeStamp.ctype),
        ),
        LazyField(
          Label.named('expected_allowance'),
          () => CType.opt(LEDGERTokens.ctype),
        ),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGEROperation.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Mint')) {
      return LEDGEROperationMint.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Mint']),
      );
    }
    if (json.containsKey('Burn')) {
      return LEDGEROperationBurn.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Burn']),
      );
    }
    if (json.containsKey('Transfer')) {
      return LEDGEROperationTransfer.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Transfer']),
      );
    }
    if (json.containsKey('Approve')) {
      return LEDGEROperationApprove.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Approve']),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGEROperation.fromCandid',
      reason: 'Unknown LEDGEROperation arm',
    );
  }

  factory LEDGEROperation.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGEROperation.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Operation.Mint`.
final class LEDGEROperationMint extends LEDGEROperation {
  final LEDGERAccountIdentifier to;
  final LEDGERTokens amount;

  const LEDGEROperationMint({required this.to, required this.amount});

  @override
  CType get candidType => LEDGEROperation.ctype;

  @override
  dynamic get candidValue =>
      Variant('Mint', {'to': to, 'amount': amount.candidValue});

  @override
  Map<String, dynamic> toJson() => {
    'Mint': {'to': to, 'amount': amount.toJson()},
  };

  factory LEDGEROperationMint.fromCandid(Map<String, dynamic> json) {
    return LEDGEROperationMint(
      to: json.valueAsBytes<List<int>>('to', encoding: StringEncoding.base64),
      amount: json.valueTo<LEDGERTokens, Map>(
        key: 'amount',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }
}

/// Variant arm `Operation.Burn`.
final class LEDGEROperationBurn extends LEDGEROperation {
  final LEDGERAccountIdentifier from;
  final LEDGERAccountIdentifier? spender;
  final LEDGERTokens amount;

  const LEDGEROperationBurn({
    required this.from,
    this.spender,
    required this.amount,
  });

  @override
  CType get candidType => LEDGEROperation.ctype;

  @override
  dynamic get candidValue => Variant('Burn', {
    'from': from,
    'spender': spender,
    'amount': amount.candidValue,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Burn': {'from': from, 'spender': spender, 'amount': amount.toJson()},
  };

  factory LEDGEROperationBurn.fromCandid(Map<String, dynamic> json) {
    return LEDGEROperationBurn(
      from: json.valueAsBytes<List<int>>(
        'from',
        encoding: StringEncoding.base64,
      ),
      spender: json.valueAsBytes<List<int>?>(
        'spender',
        encoding: StringEncoding.base64,
      ),
      amount: json.valueTo<LEDGERTokens, Map>(
        key: 'amount',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }
}

/// Variant arm `Operation.Transfer`.
final class LEDGEROperationTransfer extends LEDGEROperation {
  final LEDGERAccountIdentifier from;
  final LEDGERAccountIdentifier to;
  final LEDGERTokens amount;
  final LEDGERTokens fee;
  final List<int>? spender;

  const LEDGEROperationTransfer({
    required this.from,
    required this.to,
    required this.amount,
    required this.fee,
    this.spender,
  });

  @override
  CType get candidType => LEDGEROperation.ctype;

  @override
  dynamic get candidValue => Variant('Transfer', {
    'from': from,
    'to': to,
    'amount': amount.candidValue,
    'fee': fee.candidValue,
    'spender': spender,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Transfer': {
      'from': from,
      'to': to,
      'amount': amount.toJson(),
      'fee': fee.toJson(),
      'spender': spender,
    },
  };

  factory LEDGEROperationTransfer.fromCandid(Map<String, dynamic> json) {
    return LEDGEROperationTransfer(
      from: json.valueAsBytes<List<int>>(
        'from',
        encoding: StringEncoding.base64,
      ),
      to: json.valueAsBytes<List<int>>('to', encoding: StringEncoding.base64),
      amount: json.valueTo<LEDGERTokens, Map>(
        key: 'amount',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fee: json.valueTo<LEDGERTokens, Map>(
        key: 'fee',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      spender: json.valueAsBytes<List<int>?>(
        'spender',
        encoding: StringEncoding.base64,
      ),
    );
  }
}

/// Variant arm `Operation.Approve`.
final class LEDGEROperationApprove extends LEDGEROperation {
  final LEDGERAccountIdentifier from;
  final LEDGERAccountIdentifier spender;
  final BigInt allowanceE8s;
  final LEDGERTokens allowance;
  final LEDGERTokens fee;
  final LEDGERTimeStamp? expiresAt;
  final LEDGERTokens? expectedAllowance;

  const LEDGEROperationApprove({
    required this.from,
    required this.spender,
    required this.allowanceE8s,
    required this.allowance,
    required this.fee,
    this.expiresAt,
    this.expectedAllowance,
  });

  @override
  CType get candidType => LEDGEROperation.ctype;

  @override
  dynamic get candidValue => Variant('Approve', {
    'from': from,
    'spender': spender,
    'allowance_e8s': allowanceE8s,
    'allowance': allowance.candidValue,
    'fee': fee.candidValue,
    'expires_at': expiresAt?.candidValue,
    'expected_allowance': expectedAllowance?.candidValue,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Approve': {
      'from': from,
      'spender': spender,
      'allowance_e8s': allowanceE8s,
      'allowance': allowance.toJson(),
      'fee': fee.toJson(),
      'expires_at': expiresAt?.toJson(),
      'expected_allowance': expectedAllowance?.toJson(),
    },
  };

  factory LEDGEROperationApprove.fromCandid(Map<String, dynamic> json) {
    return LEDGEROperationApprove(
      from: json.valueAsBytes<List<int>>(
        'from',
        encoding: StringEncoding.base64,
      ),
      spender: json.valueAsBytes<List<int>>(
        'spender',
        encoding: StringEncoding.base64,
      ),
      allowanceE8s: json.valueAsBigInt<BigInt>('allowance_e8s'),
      allowance: json.valueTo<LEDGERTokens, Map>(
        key: 'allowance',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fee: json.valueTo<LEDGERTokens, Map>(
        key: 'fee',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      expiresAt: json.valueTo<LEDGERTimeStamp?, Map>(
        key: 'expires_at',
        parse:
            (e) => LEDGERTimeStamp.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      expectedAllowance: json.valueTo<LEDGERTokens?, Map>(
        key: 'expected_allowance',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }
}

/// Candid record `Block`.
final class LEDGERBlock with CandidSerializable {
  final List<int>? parentHash;
  final LEDGERTransaction transaction;
  final LEDGERTimeStamp timestamp;

  const LEDGERBlock({
    this.parentHash,
    required this.transaction,
    required this.timestamp,
  });

  static CType get ctype => CType.record([
    Field(Label.named('parent_hash'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('transaction'), () => LEDGERTransaction.ctype),
    LazyField(Label.named('timestamp'), () => LEDGERTimeStamp.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'parent_hash': parentHash,
    'transaction': transaction.candidValue,
    'timestamp': timestamp.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'parent_hash': parentHash,
    'transaction': transaction.toJson(),
    'timestamp': timestamp.toJson(),
  };

  factory LEDGERBlock.fromCandid(Map<String, dynamic> json) {
    return LEDGERBlock(
      parentHash: json.valueAsBytes<List<int>?>(
        'parent_hash',
        encoding: StringEncoding.base64,
      ),
      transaction: json.valueTo<LEDGERTransaction, Map>(
        key: 'transaction',
        parse:
            (e) => LEDGERTransaction.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      timestamp: json.valueTo<LEDGERTimeStamp, Map>(
        key: 'timestamp',
        parse:
            (e) => LEDGERTimeStamp.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERBlock.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERBlock.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `BlockRange`.
final class LEDGERBlockRange with CandidSerializable {
  final List<LEDGERBlock> blocks;

  const LEDGERBlockRange({required this.blocks});

  static CType get ctype => CType.record([
    LazyField(Label.named('blocks'), () => CType.vec(LEDGERBlock.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'blocks': blocks.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'blocks': blocks.map((el) => el.toJson()).toList(),
  };

  factory LEDGERBlockRange.fromCandid(Map<String, dynamic> json) {
    return LEDGERBlockRange(
      blocks: json.valueTo<List<LEDGERBlock>, List>(
        key: 'blocks',
        parse:
            (e) =>
                e
                    .map<LEDGERBlock>(
                      (x) => LEDGERBlock.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory LEDGERBlockRange.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERBlockRange.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `QueryArchiveError`.
sealed class LEDGERQueryArchiveError with CandidSerializable {
  const LEDGERQueryArchiveError();

  static CType get ctype => CType.variant([
    Field(
      Label.named('BadFirstBlockIndex'),
      CType.record([
        Field(Label.named('requested_index'), CType.nat64),
        Field(Label.named('first_valid_index'), CType.nat64),
      ]),
    ),
    Field(
      Label.named('Other'),
      CType.record([
        Field(Label.named('error_code'), CType.nat64),
        Field(Label.named('error_message'), CType.text),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERQueryArchiveError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('BadFirstBlockIndex')) {
      return LEDGERQueryArchiveErrorBadFirstBlockIndex.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['BadFirstBlockIndex'],
        ),
      );
    }
    if (json.containsKey('Other')) {
      return LEDGERQueryArchiveErrorOther.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Other']),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERQueryArchiveError.fromCandid',
      reason: 'Unknown LEDGERQueryArchiveError arm',
    );
  }

  factory LEDGERQueryArchiveError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERQueryArchiveError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `QueryArchiveError.BadFirstBlockIndex`.
final class LEDGERQueryArchiveErrorBadFirstBlockIndex
    extends LEDGERQueryArchiveError {
  final LEDGERBlockIndex requestedIndex;
  final LEDGERBlockIndex firstValidIndex;

  const LEDGERQueryArchiveErrorBadFirstBlockIndex({
    required this.requestedIndex,
    required this.firstValidIndex,
  });

  @override
  CType get candidType => LEDGERQueryArchiveError.ctype;

  @override
  dynamic get candidValue => Variant('BadFirstBlockIndex', {
    'requested_index': requestedIndex,
    'first_valid_index': firstValidIndex,
  });

  @override
  Map<String, dynamic> toJson() => {
    'BadFirstBlockIndex': {
      'requested_index': requestedIndex,
      'first_valid_index': firstValidIndex,
    },
  };

  factory LEDGERQueryArchiveErrorBadFirstBlockIndex.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERQueryArchiveErrorBadFirstBlockIndex(
      requestedIndex: json.valueAsBigInt<BigInt>('requested_index'),
      firstValidIndex: json.valueAsBigInt<BigInt>('first_valid_index'),
    );
  }
}

/// Variant arm `QueryArchiveError.Other`.
final class LEDGERQueryArchiveErrorOther extends LEDGERQueryArchiveError {
  final BigInt errorCode;
  final String errorMessage;

  const LEDGERQueryArchiveErrorOther({
    required this.errorCode,
    required this.errorMessage,
  });

  @override
  CType get candidType => LEDGERQueryArchiveError.ctype;

  @override
  dynamic get candidValue => Variant('Other', {
    'error_code': errorCode,
    'error_message': errorMessage,
  });

  @override
  Map<String, dynamic> toJson() => {
    'Other': {'error_code': errorCode, 'error_message': errorMessage},
  };

  factory LEDGERQueryArchiveErrorOther.fromCandid(Map<String, dynamic> json) {
    return LEDGERQueryArchiveErrorOther(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      errorMessage: json.valueAsString<String>('error_message'),
    );
  }
}

/// Candid variant `QueryArchiveResult`.
sealed class LEDGERQueryArchiveResult with CandidSerializable {
  const LEDGERQueryArchiveResult();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => LEDGERBlockRange.ctype),
    LazyField(Label.named('Err'), () => LEDGERQueryArchiveError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERQueryArchiveResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return LEDGERQueryArchiveResultOk(
        json.valueTo<LEDGERBlockRange, Map>(
          key: 'Ok',
          parse:
              (e) => LEDGERBlockRange.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return LEDGERQueryArchiveResultErr(
        json.valueTo<LEDGERQueryArchiveError, Map>(
          key: 'Err',
          parse:
              (e) => LEDGERQueryArchiveError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERQueryArchiveResult.fromCandid',
      reason: 'Unknown LEDGERQueryArchiveResult arm',
    );
  }

  factory LEDGERQueryArchiveResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERQueryArchiveResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `QueryArchiveResult.Ok`.
final class LEDGERQueryArchiveResultOk extends LEDGERQueryArchiveResult {
  final LEDGERBlockRange value;
  const LEDGERQueryArchiveResultOk(this.value);

  @override
  CType get candidType => LEDGERQueryArchiveResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `QueryArchiveResult.Err`.
final class LEDGERQueryArchiveResultErr extends LEDGERQueryArchiveResult {
  final LEDGERQueryArchiveError value;
  const LEDGERQueryArchiveResultErr(this.value);

  @override
  CType get candidType => LEDGERQueryArchiveResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `QueryBlocksResponse`.
final class LEDGERQueryBlocksResponse with CandidSerializable {
  final BigInt chainLength;
  final List<int>? certificate;
  final List<LEDGERBlock> blocks;
  final LEDGERBlockIndex firstBlockIndex;
  final List<LEDGERArchivedBlocksRange> archivedBlocks;

  const LEDGERQueryBlocksResponse({
    required this.chainLength,
    this.certificate,
    required this.blocks,
    required this.firstBlockIndex,
    required this.archivedBlocks,
  });

  static CType get ctype => CType.record([
    Field(Label.named('chain_length'), CType.nat64),
    Field(Label.named('certificate'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('blocks'), () => CType.vec(LEDGERBlock.ctype)),
    Field(Label.named('first_block_index'), CType.nat64),
    LazyField(
      Label.named('archived_blocks'),
      () => CType.vec(LEDGERArchivedBlocksRange.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'chain_length': chainLength,
    'certificate': certificate,
    'blocks': blocks.map((el) => el.candidValue).toList(),
    'first_block_index': firstBlockIndex,
    'archived_blocks': archivedBlocks.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'chain_length': chainLength,
    'certificate': certificate,
    'blocks': blocks.map((el) => el.toJson()).toList(),
    'first_block_index': firstBlockIndex,
    'archived_blocks': archivedBlocks.map((el) => el.toJson()).toList(),
  };

  factory LEDGERQueryBlocksResponse.fromCandid(Map<String, dynamic> json) {
    return LEDGERQueryBlocksResponse(
      chainLength: json.valueAsBigInt<BigInt>('chain_length'),
      certificate: json.valueAsBytes<List<int>?>(
        'certificate',
        encoding: StringEncoding.base64,
      ),
      blocks: json.valueTo<List<LEDGERBlock>, List>(
        key: 'blocks',
        parse:
            (e) =>
                e
                    .map<LEDGERBlock>(
                      (x) => LEDGERBlock.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      firstBlockIndex: json.valueAsBigInt<BigInt>('first_block_index'),
      archivedBlocks: json.valueTo<List<LEDGERArchivedBlocksRange>, List>(
        key: 'archived_blocks',
        parse:
            (e) =>
                e
                    .map<LEDGERArchivedBlocksRange>(
                      (x) => LEDGERArchivedBlocksRange.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory LEDGERQueryBlocksResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERQueryBlocksResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ArchivedBlocksRange`.
final class LEDGERArchivedBlocksRange with CandidSerializable {
  final LEDGERBlockIndex start;
  final BigInt length;
  final LEDGERQueryArchiveFn callback;

  const LEDGERArchivedBlocksRange({
    required this.start,
    required this.length,
    required this.callback,
  });

  static CType get ctype => CType.record([
    Field(Label.named('start'), CType.nat64),
    Field(Label.named('length'), CType.nat64),
    LazyField(Label.named('callback'), () => LEDGERQueryArchiveFnCandid.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'start': start,
    'length': length,
    'callback': callback,
  };

  Map<String, dynamic> toJson() => {
    'start': start,
    'length': length,
    'callback': callback,
  };

  factory LEDGERArchivedBlocksRange.fromCandid(Map<String, dynamic> json) {
    return LEDGERArchivedBlocksRange(
      start: json.valueAsBigInt<BigInt>('start'),
      length: json.valueAsBigInt<BigInt>('length'),
      callback: json['callback'],
    );
  }

  factory LEDGERArchivedBlocksRange.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERArchivedBlocksRange.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ArchivedEncodedBlocksRange`.
final class LEDGERArchivedEncodedBlocksRange with CandidSerializable {
  final FuncRef callback;
  final BigInt start;
  final BigInt length;

  const LEDGERArchivedEncodedBlocksRange({
    required this.callback,
    required this.start,
    required this.length,
  });

  static CType get ctype => CType.record([
    Field(Label.named('callback'), CType.func(const FunctionType([], [], []))),
    Field(Label.named('start'), CType.nat64),
    Field(Label.named('length'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'callback': callback,
    'start': start,
    'length': length,
  };

  Map<String, dynamic> toJson() => {
    'callback': callback,
    'start': start,
    'length': length,
  };

  factory LEDGERArchivedEncodedBlocksRange.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERArchivedEncodedBlocksRange(
      callback: json['callback'],
      start: json.valueAsBigInt<BigInt>('start'),
      length: json.valueAsBigInt<BigInt>('length'),
    );
  }

  factory LEDGERArchivedEncodedBlocksRange.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERArchivedEncodedBlocksRange.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `QueryEncodedBlocksResponse`.
final class LEDGERQueryEncodedBlocksResponse with CandidSerializable {
  final List<int>? certificate;
  final List<int> blocks;
  final BigInt chainLength;
  final BigInt firstBlockIndex;
  final List<LEDGERArchivedEncodedBlocksRange> archivedBlocks;

  const LEDGERQueryEncodedBlocksResponse({
    this.certificate,
    required this.blocks,
    required this.chainLength,
    required this.firstBlockIndex,
    required this.archivedBlocks,
  });

  static CType get ctype => CType.record([
    Field(Label.named('certificate'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('blocks'), CType.vec(CType.vec(CType.nat8))),
    Field(Label.named('chain_length'), CType.nat64),
    Field(Label.named('first_block_index'), CType.nat64),
    LazyField(
      Label.named('archived_blocks'),
      () => CType.vec(LEDGERArchivedEncodedBlocksRange.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'certificate': certificate,
    'blocks': blocks,
    'chain_length': chainLength,
    'first_block_index': firstBlockIndex,
    'archived_blocks': archivedBlocks.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'certificate': certificate,
    'blocks': blocks,
    'chain_length': chainLength,
    'first_block_index': firstBlockIndex,
    'archived_blocks': archivedBlocks.map((el) => el.toJson()).toList(),
  };

  factory LEDGERQueryEncodedBlocksResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERQueryEncodedBlocksResponse(
      certificate: json.valueAsBytes<List<int>?>(
        'certificate',
        encoding: StringEncoding.base64,
      ),
      blocks: json.valueAsBytes<List<int>>(
        'blocks',
        encoding: StringEncoding.base64,
      ),
      chainLength: json.valueAsBigInt<BigInt>('chain_length'),
      firstBlockIndex: json.valueAsBigInt<BigInt>('first_block_index'),
      archivedBlocks: json
          .valueTo<List<LEDGERArchivedEncodedBlocksRange>, List>(
            key: 'archived_blocks',
            parse:
                (e) =>
                    e
                        .map<LEDGERArchivedEncodedBlocksRange>(
                          (x) => LEDGERArchivedEncodedBlocksRange.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory LEDGERQueryEncodedBlocksResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERQueryEncodedBlocksResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Archive`.
final class LEDGERArchive with CandidSerializable {
  final IcpPrincipalAddress canisterId;

  const LEDGERArchive({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory LEDGERArchive.fromCandid(Map<String, dynamic> json) {
    return LEDGERArchive(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory LEDGERArchive.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERArchive.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Archives`.
final class LEDGERArchives with CandidSerializable {
  final List<LEDGERArchive> archives;

  const LEDGERArchives({required this.archives});

  static CType get ctype => CType.record([
    LazyField(Label.named('archives'), () => CType.vec(LEDGERArchive.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'archives': archives.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'archives': archives.map((el) => el.toJson()).toList(),
  };

  factory LEDGERArchives.fromCandid(Map<String, dynamic> json) {
    return LEDGERArchives(
      archives: json.valueTo<List<LEDGERArchive>, List>(
        key: 'archives',
        parse:
            (e) =>
                e
                    .map<LEDGERArchive>(
                      (x) => LEDGERArchive.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory LEDGERArchives.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERArchives.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Duration`.
final class LEDGERDuration with CandidSerializable {
  final BigInt secs;
  final int nanos;

  const LEDGERDuration({required this.secs, required this.nanos});

  static CType get ctype => CType.record([
    Field(Label.named('secs'), CType.nat64),
    Field(Label.named('nanos'), CType.nat32),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'secs': secs, 'nanos': nanos};

  Map<String, dynamic> toJson() => {'secs': secs, 'nanos': nanos};

  factory LEDGERDuration.fromCandid(Map<String, dynamic> json) {
    return LEDGERDuration(
      secs: json.valueAsBigInt<BigInt>('secs'),
      nanos: json.valueAsInt<int>('nanos'),
    );
  }

  factory LEDGERDuration.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERDuration.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ArchiveOptions`.
final class LEDGERArchiveOptions with CandidSerializable {
  final BigInt triggerThreshold;
  final BigInt numBlocksToArchive;
  final BigInt? nodeMaxMemorySizeBytes;
  final BigInt? maxMessageSizeBytes;
  final IcpPrincipalAddress controllerId;
  final List<IcpPrincipalAddress>? moreControllerIds;
  final BigInt? cyclesForArchiveCreation;
  final BigInt? maxTransactionsPerResponse;

  const LEDGERArchiveOptions({
    required this.triggerThreshold,
    required this.numBlocksToArchive,
    this.nodeMaxMemorySizeBytes,
    this.maxMessageSizeBytes,
    required this.controllerId,
    this.moreControllerIds,
    this.cyclesForArchiveCreation,
    this.maxTransactionsPerResponse,
  });

  static CType get ctype => CType.record([
    Field(Label.named('trigger_threshold'), CType.nat64),
    Field(Label.named('num_blocks_to_archive'), CType.nat64),
    Field(Label.named('node_max_memory_size_bytes'), CType.opt(CType.nat64)),
    Field(Label.named('max_message_size_bytes'), CType.opt(CType.nat64)),
    Field(Label.named('controller_id'), CType.principal),
    Field(
      Label.named('more_controller_ids'),
      CType.opt(CType.vec(CType.principal)),
    ),
    Field(Label.named('cycles_for_archive_creation'), CType.opt(CType.nat64)),
    Field(Label.named('max_transactions_per_response'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'trigger_threshold': triggerThreshold,
    'num_blocks_to_archive': numBlocksToArchive,
    'node_max_memory_size_bytes': nodeMaxMemorySizeBytes,
    'max_message_size_bytes': maxMessageSizeBytes,
    'controller_id': controllerId,
    'more_controller_ids': moreControllerIds,
    'cycles_for_archive_creation': cyclesForArchiveCreation,
    'max_transactions_per_response': maxTransactionsPerResponse,
  };

  Map<String, dynamic> toJson() => {
    'trigger_threshold': triggerThreshold,
    'num_blocks_to_archive': numBlocksToArchive,
    'node_max_memory_size_bytes': nodeMaxMemorySizeBytes,
    'max_message_size_bytes': maxMessageSizeBytes,
    'controller_id': controllerId.address,
    'more_controller_ids': moreControllerIds?.map((el) => el.address).toList(),
    'cycles_for_archive_creation': cyclesForArchiveCreation,
    'max_transactions_per_response': maxTransactionsPerResponse,
  };

  factory LEDGERArchiveOptions.fromCandid(Map<String, dynamic> json) {
    return LEDGERArchiveOptions(
      triggerThreshold: json.valueAsBigInt<BigInt>('trigger_threshold'),
      numBlocksToArchive: json.valueAsBigInt<BigInt>('num_blocks_to_archive'),
      nodeMaxMemorySizeBytes: json.valueAsBigInt<BigInt?>(
        'node_max_memory_size_bytes',
      ),
      maxMessageSizeBytes: json.valueAsBigInt<BigInt?>(
        'max_message_size_bytes',
      ),
      controllerId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'controller_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      moreControllerIds: json.valueTo<List<IcpPrincipalAddress>?, List>(
        key: 'more_controller_ids',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      cyclesForArchiveCreation: json.valueAsBigInt<BigInt?>(
        'cycles_for_archive_creation',
      ),
      maxTransactionsPerResponse: json.valueAsBigInt<BigInt?>(
        'max_transactions_per_response',
      ),
    );
  }

  factory LEDGERArchiveOptions.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERArchiveOptions.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `SendArgs`.
final class LEDGERSendArgs with CandidSerializable {
  final LEDGERMemo memo;
  final LEDGERTokens amount;
  final LEDGERTokens fee;
  final LEDGERSubAccount? fromSubaccount;
  final LEDGERTextAccountIdentifier to;
  final LEDGERTimeStamp? createdAtTime;

  const LEDGERSendArgs({
    required this.memo,
    required this.amount,
    required this.fee,
    this.fromSubaccount,
    required this.to,
    this.createdAtTime,
  });

  static CType get ctype => CType.record([
    Field(Label.named('memo'), CType.nat64),
    LazyField(Label.named('amount'), () => LEDGERTokens.ctype),
    LazyField(Label.named('fee'), () => LEDGERTokens.ctype),
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('to'), CType.text),
    LazyField(
      Label.named('created_at_time'),
      () => CType.opt(LEDGERTimeStamp.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'memo': memo,
    'amount': amount.candidValue,
    'fee': fee.candidValue,
    'from_subaccount': fromSubaccount,
    'to': to,
    'created_at_time': createdAtTime?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'memo': memo,
    'amount': amount.toJson(),
    'fee': fee.toJson(),
    'from_subaccount': fromSubaccount,
    'to': to,
    'created_at_time': createdAtTime?.toJson(),
  };

  factory LEDGERSendArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERSendArgs(
      memo: json.valueAsBigInt<BigInt>('memo'),
      amount: json.valueTo<LEDGERTokens, Map>(
        key: 'amount',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fee: json.valueTo<LEDGERTokens, Map>(
        key: 'fee',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      to: json.valueAsString<String>('to'),
      createdAtTime: json.valueTo<LEDGERTimeStamp?, Map>(
        key: 'created_at_time',
        parse:
            (e) => LEDGERTimeStamp.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERSendArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERSendArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `AccountBalanceArgsDfx`.
final class LEDGERAccountBalanceArgsDfx with CandidSerializable {
  final LEDGERTextAccountIdentifier account;

  const LEDGERAccountBalanceArgsDfx({required this.account});

  static CType get ctype =>
      CType.record([Field(Label.named('account'), CType.text)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'account': account};

  Map<String, dynamic> toJson() => {'account': account};

  factory LEDGERAccountBalanceArgsDfx.fromCandid(Map<String, dynamic> json) {
    return LEDGERAccountBalanceArgsDfx(
      account: json.valueAsString<String>('account'),
    );
  }

  factory LEDGERAccountBalanceArgsDfx.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERAccountBalanceArgsDfx.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `FeatureFlags`.
final class LEDGERFeatureFlags with CandidSerializable {
  final bool icrc2;

  const LEDGERFeatureFlags({required this.icrc2});

  static CType get ctype =>
      CType.record([Field(Label.named('icrc2'), CType.bool_)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'icrc2': icrc2};

  Map<String, dynamic> toJson() => {'icrc2': icrc2};

  factory LEDGERFeatureFlags.fromCandid(Map<String, dynamic> json) {
    return LEDGERFeatureFlags(icrc2: json.valueAsBool<bool>('icrc2'));
  }

  factory LEDGERFeatureFlags.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERFeatureFlags.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `InitArgs`.
final class LEDGERInitArgs with CandidSerializable {
  final LEDGERTextAccountIdentifier mintingAccount;
  final LEDGERAccount? icrc1MintingAccount;
  final List<LEDGERInitArgsInitialValues> initialValues;
  final BigInt? maxMessageSizeBytes;
  final LEDGERDuration? transactionWindow;
  final LEDGERArchiveOptions? archiveOptions;
  final List<IcpPrincipalAddress> sendWhitelist;
  final LEDGERTokens? transferFee;
  final String? tokenSymbol;
  final String? tokenName;
  final LEDGERFeatureFlags? featureFlags;

  const LEDGERInitArgs({
    required this.mintingAccount,
    this.icrc1MintingAccount,
    required this.initialValues,
    this.maxMessageSizeBytes,
    this.transactionWindow,
    this.archiveOptions,
    required this.sendWhitelist,
    this.transferFee,
    this.tokenSymbol,
    this.tokenName,
    this.featureFlags,
  });

  static CType get ctype => CType.record([
    Field(Label.named('minting_account'), CType.text),
    LazyField(
      Label.named('icrc1_minting_account'),
      () => CType.opt(LEDGERAccount.ctype),
    ),
    LazyField(
      Label.named('initial_values'),
      () => CType.vec(LEDGERInitArgsInitialValues.ctype),
    ),
    Field(Label.named('max_message_size_bytes'), CType.opt(CType.nat64)),
    LazyField(
      Label.named('transaction_window'),
      () => CType.opt(LEDGERDuration.ctype),
    ),
    LazyField(
      Label.named('archive_options'),
      () => CType.opt(LEDGERArchiveOptions.ctype),
    ),
    Field(Label.named('send_whitelist'), CType.vec(CType.principal)),
    LazyField(Label.named('transfer_fee'), () => CType.opt(LEDGERTokens.ctype)),
    Field(Label.named('token_symbol'), CType.opt(CType.text)),
    Field(Label.named('token_name'), CType.opt(CType.text)),
    LazyField(
      Label.named('feature_flags'),
      () => CType.opt(LEDGERFeatureFlags.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'minting_account': mintingAccount,
    'icrc1_minting_account': icrc1MintingAccount?.candidValue,
    'initial_values': initialValues.map((el) => el.candidValue).toList(),
    'max_message_size_bytes': maxMessageSizeBytes,
    'transaction_window': transactionWindow?.candidValue,
    'archive_options': archiveOptions?.candidValue,
    'send_whitelist': sendWhitelist,
    'transfer_fee': transferFee?.candidValue,
    'token_symbol': tokenSymbol,
    'token_name': tokenName,
    'feature_flags': featureFlags?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'minting_account': mintingAccount,
    'icrc1_minting_account': icrc1MintingAccount?.toJson(),
    'initial_values': initialValues.map((el) => el.toJson()).toList(),
    'max_message_size_bytes': maxMessageSizeBytes,
    'transaction_window': transactionWindow?.toJson(),
    'archive_options': archiveOptions?.toJson(),
    'send_whitelist': sendWhitelist.map((el) => el.address).toList(),
    'transfer_fee': transferFee?.toJson(),
    'token_symbol': tokenSymbol,
    'token_name': tokenName,
    'feature_flags': featureFlags?.toJson(),
  };

  factory LEDGERInitArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERInitArgs(
      mintingAccount: json.valueAsString<String>('minting_account'),
      icrc1MintingAccount: json.valueTo<LEDGERAccount?, Map>(
        key: 'icrc1_minting_account',
        parse:
            (e) => LEDGERAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      initialValues: json.valueTo<List<LEDGERInitArgsInitialValues>, List>(
        key: 'initial_values',
        parse:
            (e) =>
                e
                    .map<LEDGERInitArgsInitialValues>(
                      (x) => LEDGERInitArgsInitialValues.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      maxMessageSizeBytes: json.valueAsBigInt<BigInt?>(
        'max_message_size_bytes',
      ),
      transactionWindow: json.valueTo<LEDGERDuration?, Map>(
        key: 'transaction_window',
        parse:
            (e) => LEDGERDuration.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      archiveOptions: json.valueTo<LEDGERArchiveOptions?, Map>(
        key: 'archive_options',
        parse:
            (e) => LEDGERArchiveOptions.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      sendWhitelist: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'send_whitelist',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      transferFee: json.valueTo<LEDGERTokens?, Map>(
        key: 'transfer_fee',
        parse:
            (e) => LEDGERTokens.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      tokenSymbol: json.valueAsString<String?>('token_symbol'),
      tokenName: json.valueAsString<String?>('token_name'),
      featureFlags: json.valueTo<LEDGERFeatureFlags?, Map>(
        key: 'feature_flags',
        parse:
            (e) => LEDGERFeatureFlags.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERInitArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERInitArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Account`.
final class LEDGERAccount with CandidSerializable {
  final IcpPrincipalAddress owner;
  final LEDGERSubAccount? subaccount;

  const LEDGERAccount({required this.owner, this.subaccount});

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

  factory LEDGERAccount.fromCandid(Map<String, dynamic> json) {
    return LEDGERAccount(
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

  factory LEDGERAccount.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERAccount.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TransferArg`.
final class LEDGERTransferArg with CandidSerializable {
  final LEDGERSubAccount? fromSubaccount;
  final LEDGERAccount to;
  final LEDGERIcrc1Tokens amount;
  final LEDGERIcrc1Tokens? fee;
  final List<int>? memo;
  final LEDGERIcrc1Timestamp? createdAtTime;

  const LEDGERTransferArg({
    this.fromSubaccount,
    required this.to,
    required this.amount,
    this.fee,
    this.memo,
    this.createdAtTime,
  });

  static CType get ctype => CType.record([
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('to'), () => LEDGERAccount.ctype),
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

  factory LEDGERTransferArg.fromCandid(Map<String, dynamic> json) {
    return LEDGERTransferArg(
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      to: json.valueTo<LEDGERAccount, Map>(
        key: 'to',
        parse:
            (e) => LEDGERAccount.fromCandid(
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

  factory LEDGERTransferArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTransferArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Icrc1TransferError`.
sealed class LEDGERIcrc1TransferError with CandidSerializable {
  const LEDGERIcrc1TransferError();

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
    Field(Label.named('TemporarilyUnavailable'), CType.null_),
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

  factory LEDGERIcrc1TransferError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('BadFee')) {
      return LEDGERIcrc1TransferErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('BadBurn')) {
      return LEDGERIcrc1TransferErrorBadBurn.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadBurn']),
      );
    }
    if (json.containsKey('InsufficientFunds')) {
      return LEDGERIcrc1TransferErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const LEDGERIcrc1TransferErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return LEDGERIcrc1TransferErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const LEDGERIcrc1TransferErrorTemporarilyUnavailable();
    }
    if (json.containsKey('Duplicate')) {
      return LEDGERIcrc1TransferErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return LEDGERIcrc1TransferErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERIcrc1TransferError.fromCandid',
      reason: 'Unknown LEDGERIcrc1TransferError arm',
    );
  }

  factory LEDGERIcrc1TransferError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc1TransferError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Icrc1TransferError.BadFee`.
final class LEDGERIcrc1TransferErrorBadFee extends LEDGERIcrc1TransferError {
  final LEDGERIcrc1Tokens expectedFee;

  const LEDGERIcrc1TransferErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => LEDGERIcrc1TransferError.ctype;

  @override
  dynamic get candidValue => Variant('BadFee', {'expected_fee': expectedFee});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee},
  };

  factory LEDGERIcrc1TransferErrorBadFee.fromCandid(Map<String, dynamic> json) {
    return LEDGERIcrc1TransferErrorBadFee(
      expectedFee: json.valueAsBigInt<BigInt>('expected_fee'),
    );
  }
}

/// Variant arm `Icrc1TransferError.BadBurn`.
final class LEDGERIcrc1TransferErrorBadBurn extends LEDGERIcrc1TransferError {
  final LEDGERIcrc1Tokens minBurnAmount;

  const LEDGERIcrc1TransferErrorBadBurn({required this.minBurnAmount});

  @override
  CType get candidType => LEDGERIcrc1TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('BadBurn', {'min_burn_amount': minBurnAmount});

  @override
  Map<String, dynamic> toJson() => {
    'BadBurn': {'min_burn_amount': minBurnAmount},
  };

  factory LEDGERIcrc1TransferErrorBadBurn.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERIcrc1TransferErrorBadBurn(
      minBurnAmount: json.valueAsBigInt<BigInt>('min_burn_amount'),
    );
  }
}

/// Variant arm `Icrc1TransferError.InsufficientFunds`.
final class LEDGERIcrc1TransferErrorInsufficientFunds
    extends LEDGERIcrc1TransferError {
  final LEDGERIcrc1Tokens balance;

  const LEDGERIcrc1TransferErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => LEDGERIcrc1TransferError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory LEDGERIcrc1TransferErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERIcrc1TransferErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Variant arm `Icrc1TransferError.TooOld` (nullary).
final class LEDGERIcrc1TransferErrorTooOld extends LEDGERIcrc1TransferError {
  const LEDGERIcrc1TransferErrorTooOld();

  @override
  CType get candidType => LEDGERIcrc1TransferError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `Icrc1TransferError.CreatedInFuture`.
final class LEDGERIcrc1TransferErrorCreatedInFuture
    extends LEDGERIcrc1TransferError {
  final BigInt ledgerTime;

  const LEDGERIcrc1TransferErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => LEDGERIcrc1TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory LEDGERIcrc1TransferErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERIcrc1TransferErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `Icrc1TransferError.TemporarilyUnavailable` (nullary).
final class LEDGERIcrc1TransferErrorTemporarilyUnavailable
    extends LEDGERIcrc1TransferError {
  const LEDGERIcrc1TransferErrorTemporarilyUnavailable();

  @override
  CType get candidType => LEDGERIcrc1TransferError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `Icrc1TransferError.Duplicate`.
final class LEDGERIcrc1TransferErrorDuplicate extends LEDGERIcrc1TransferError {
  final LEDGERIcrc1BlockIndex duplicateOf;

  const LEDGERIcrc1TransferErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => LEDGERIcrc1TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory LEDGERIcrc1TransferErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERIcrc1TransferErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `Icrc1TransferError.GenericError`.
final class LEDGERIcrc1TransferErrorGenericError
    extends LEDGERIcrc1TransferError {
  final BigInt errorCode;
  final String message;

  const LEDGERIcrc1TransferErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => LEDGERIcrc1TransferError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory LEDGERIcrc1TransferErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERIcrc1TransferErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid variant `Icrc1TransferResult`.
sealed class LEDGERIcrc1TransferResult with CandidSerializable {
  const LEDGERIcrc1TransferResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => LEDGERIcrc1TransferError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERIcrc1TransferResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return LEDGERIcrc1TransferResultOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return LEDGERIcrc1TransferResultErr(
        json.valueTo<LEDGERIcrc1TransferError, Map>(
          key: 'Err',
          parse:
              (e) => LEDGERIcrc1TransferError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERIcrc1TransferResult.fromCandid',
      reason: 'Unknown LEDGERIcrc1TransferResult arm',
    );
  }

  factory LEDGERIcrc1TransferResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc1TransferResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Icrc1TransferResult.Ok`.
final class LEDGERIcrc1TransferResultOk extends LEDGERIcrc1TransferResult {
  final LEDGERIcrc1BlockIndex value;
  const LEDGERIcrc1TransferResultOk(this.value);

  @override
  CType get candidType => LEDGERIcrc1TransferResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `Icrc1TransferResult.Err`.
final class LEDGERIcrc1TransferResultErr extends LEDGERIcrc1TransferResult {
  final LEDGERIcrc1TransferError value;
  const LEDGERIcrc1TransferResultErr(this.value);

  @override
  CType get candidType => LEDGERIcrc1TransferResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `Value`.
sealed class LEDGERValue with CandidSerializable {
  const LEDGERValue();

  static CType get ctype => CType.variant([
    Field(Label.named('Nat'), CType.nat),
    Field(Label.named('Int'), CType.int_),
    Field(Label.named('Text'), CType.text),
    Field(Label.named('Blob'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERValue.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Nat')) {
      return LEDGERValueNat(json.valueAsBigInt<BigInt>('Nat'));
    }
    if (json.containsKey('Int')) {
      return LEDGERValueInt(json.valueAsBigInt<BigInt>('Int'));
    }
    if (json.containsKey('Text')) {
      return LEDGERValueText(json.valueAsString<String>('Text'));
    }
    if (json.containsKey('Blob')) {
      return LEDGERValueBlob(
        json.valueAsBytes<List<int>>('Blob', encoding: StringEncoding.base64),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERValue.fromCandid',
      reason: 'Unknown LEDGERValue arm',
    );
  }

  factory LEDGERValue.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERValue.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Value.Nat`.
final class LEDGERValueNat extends LEDGERValue {
  final BigInt value;
  const LEDGERValueNat(this.value);

  @override
  CType get candidType => LEDGERValue.ctype;

  @override
  dynamic get candidValue => Variant('Nat', value);

  @override
  Map<String, dynamic> toJson() => {'Nat': value};
}

/// Variant arm `Value.Int`.
final class LEDGERValueInt extends LEDGERValue {
  final BigInt value;
  const LEDGERValueInt(this.value);

  @override
  CType get candidType => LEDGERValue.ctype;

  @override
  dynamic get candidValue => Variant('Int', value);

  @override
  Map<String, dynamic> toJson() => {'Int': value};
}

/// Variant arm `Value.Text`.
final class LEDGERValueText extends LEDGERValue {
  final String value;
  const LEDGERValueText(this.value);

  @override
  CType get candidType => LEDGERValue.ctype;

  @override
  dynamic get candidValue => Variant('Text', value);

  @override
  Map<String, dynamic> toJson() => {'Text': value};
}

/// Variant arm `Value.Blob`.
final class LEDGERValueBlob extends LEDGERValue {
  final List<int> value;
  const LEDGERValueBlob(this.value);

  @override
  CType get candidType => LEDGERValue.ctype;

  @override
  dynamic get candidValue => Variant('Blob', value);

  @override
  Map<String, dynamic> toJson() => {'Blob': value};
}

/// Candid record `ChangeArchiveOptions`.
final class LEDGERChangeArchiveOptions with CandidSerializable {
  final BigInt? triggerThreshold;
  final BigInt? numBlocksToArchive;
  final BigInt? nodeMaxMemorySizeBytes;
  final BigInt? maxMessageSizeBytes;
  final IcpPrincipalAddress? controllerId;
  final List<IcpPrincipalAddress>? moreControllerIds;
  final BigInt? cyclesForArchiveCreation;
  final BigInt? maxTransactionsPerResponse;

  const LEDGERChangeArchiveOptions({
    this.triggerThreshold,
    this.numBlocksToArchive,
    this.nodeMaxMemorySizeBytes,
    this.maxMessageSizeBytes,
    this.controllerId,
    this.moreControllerIds,
    this.cyclesForArchiveCreation,
    this.maxTransactionsPerResponse,
  });

  static CType get ctype => CType.record([
    Field(Label.named('trigger_threshold'), CType.opt(CType.nat64)),
    Field(Label.named('num_blocks_to_archive'), CType.opt(CType.nat64)),
    Field(Label.named('node_max_memory_size_bytes'), CType.opt(CType.nat64)),
    Field(Label.named('max_message_size_bytes'), CType.opt(CType.nat64)),
    Field(Label.named('controller_id'), CType.opt(CType.principal)),
    Field(
      Label.named('more_controller_ids'),
      CType.opt(CType.vec(CType.principal)),
    ),
    Field(Label.named('cycles_for_archive_creation'), CType.opt(CType.nat64)),
    Field(Label.named('max_transactions_per_response'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'trigger_threshold': triggerThreshold,
    'num_blocks_to_archive': numBlocksToArchive,
    'node_max_memory_size_bytes': nodeMaxMemorySizeBytes,
    'max_message_size_bytes': maxMessageSizeBytes,
    'controller_id': controllerId,
    'more_controller_ids': moreControllerIds,
    'cycles_for_archive_creation': cyclesForArchiveCreation,
    'max_transactions_per_response': maxTransactionsPerResponse,
  };

  Map<String, dynamic> toJson() => {
    'trigger_threshold': triggerThreshold,
    'num_blocks_to_archive': numBlocksToArchive,
    'node_max_memory_size_bytes': nodeMaxMemorySizeBytes,
    'max_message_size_bytes': maxMessageSizeBytes,
    'controller_id': controllerId?.address,
    'more_controller_ids': moreControllerIds?.map((el) => el.address).toList(),
    'cycles_for_archive_creation': cyclesForArchiveCreation,
    'max_transactions_per_response': maxTransactionsPerResponse,
  };

  factory LEDGERChangeArchiveOptions.fromCandid(Map<String, dynamic> json) {
    return LEDGERChangeArchiveOptions(
      triggerThreshold: json.valueAsBigInt<BigInt?>('trigger_threshold'),
      numBlocksToArchive: json.valueAsBigInt<BigInt?>('num_blocks_to_archive'),
      nodeMaxMemorySizeBytes: json.valueAsBigInt<BigInt?>(
        'node_max_memory_size_bytes',
      ),
      maxMessageSizeBytes: json.valueAsBigInt<BigInt?>(
        'max_message_size_bytes',
      ),
      controllerId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'controller_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      moreControllerIds: json.valueTo<List<IcpPrincipalAddress>?, List>(
        key: 'more_controller_ids',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      cyclesForArchiveCreation: json.valueAsBigInt<BigInt?>(
        'cycles_for_archive_creation',
      ),
      maxTransactionsPerResponse: json.valueAsBigInt<BigInt?>(
        'max_transactions_per_response',
      ),
    );
  }

  factory LEDGERChangeArchiveOptions.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERChangeArchiveOptions.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `UpgradeArgs`.
final class LEDGERUpgradeArgs with CandidSerializable {
  final LEDGERAccount? icrc1MintingAccount;
  final LEDGERFeatureFlags? featureFlags;
  final LEDGERChangeArchiveOptions? changeArchiveOptions;

  const LEDGERUpgradeArgs({
    this.icrc1MintingAccount,
    this.featureFlags,
    this.changeArchiveOptions,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('icrc1_minting_account'),
      () => CType.opt(LEDGERAccount.ctype),
    ),
    LazyField(
      Label.named('feature_flags'),
      () => CType.opt(LEDGERFeatureFlags.ctype),
    ),
    LazyField(
      Label.named('change_archive_options'),
      () => CType.opt(LEDGERChangeArchiveOptions.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'icrc1_minting_account': icrc1MintingAccount?.candidValue,
    'feature_flags': featureFlags?.candidValue,
    'change_archive_options': changeArchiveOptions?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'icrc1_minting_account': icrc1MintingAccount?.toJson(),
    'feature_flags': featureFlags?.toJson(),
    'change_archive_options': changeArchiveOptions?.toJson(),
  };

  factory LEDGERUpgradeArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERUpgradeArgs(
      icrc1MintingAccount: json.valueTo<LEDGERAccount?, Map>(
        key: 'icrc1_minting_account',
        parse:
            (e) => LEDGERAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      featureFlags: json.valueTo<LEDGERFeatureFlags?, Map>(
        key: 'feature_flags',
        parse:
            (e) => LEDGERFeatureFlags.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      changeArchiveOptions: json.valueTo<LEDGERChangeArchiveOptions?, Map>(
        key: 'change_archive_options',
        parse:
            (e) => LEDGERChangeArchiveOptions.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERUpgradeArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERUpgradeArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `LedgerCanisterPayload`.
sealed class LEDGERLedgerCanisterPayload with CandidSerializable {
  const LEDGERLedgerCanisterPayload();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Init'), () => LEDGERInitArgs.ctype),
    LazyField(Label.named('Upgrade'), () => CType.opt(LEDGERUpgradeArgs.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERLedgerCanisterPayload.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Init')) {
      return LEDGERLedgerCanisterPayloadInit(
        json.valueTo<LEDGERInitArgs, Map>(
          key: 'Init',
          parse:
              (e) => LEDGERInitArgs.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Upgrade')) {
      return LEDGERLedgerCanisterPayloadUpgrade(
        json.valueTo<LEDGERUpgradeArgs?, Map>(
          key: 'Upgrade',
          parse:
              (e) => LEDGERUpgradeArgs.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERLedgerCanisterPayload.fromCandid',
      reason: 'Unknown LEDGERLedgerCanisterPayload arm',
    );
  }

  factory LEDGERLedgerCanisterPayload.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERLedgerCanisterPayload.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `LedgerCanisterPayload.Init`.
final class LEDGERLedgerCanisterPayloadInit
    extends LEDGERLedgerCanisterPayload {
  final LEDGERInitArgs value;
  const LEDGERLedgerCanisterPayloadInit(this.value);

  @override
  CType get candidType => LEDGERLedgerCanisterPayload.ctype;

  @override
  dynamic get candidValue => Variant('Init', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Init': value.toJson()};
}

/// Variant arm `LedgerCanisterPayload.Upgrade`.
final class LEDGERLedgerCanisterPayloadUpgrade
    extends LEDGERLedgerCanisterPayload {
  final LEDGERUpgradeArgs? value;
  const LEDGERLedgerCanisterPayloadUpgrade(this.value);

  @override
  CType get candidType => LEDGERLedgerCanisterPayload.ctype;

  @override
  dynamic get candidValue => Variant('Upgrade', value?.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Upgrade': value?.toJson()};
}

/// Candid record `ApproveArgs`.
final class LEDGERApproveArgs with CandidSerializable {
  final LEDGERSubAccount? fromSubaccount;
  final LEDGERAccount spender;
  final LEDGERIcrc1Tokens amount;
  final LEDGERIcrc1Tokens? expectedAllowance;
  final LEDGERIcrc1Timestamp? expiresAt;
  final LEDGERIcrc1Tokens? fee;
  final List<int>? memo;
  final LEDGERIcrc1Timestamp? createdAtTime;

  const LEDGERApproveArgs({
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
    LazyField(Label.named('spender'), () => LEDGERAccount.ctype),
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

  factory LEDGERApproveArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERApproveArgs(
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      spender: json.valueTo<LEDGERAccount, Map>(
        key: 'spender',
        parse:
            (e) => LEDGERAccount.fromCandid(
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

  factory LEDGERApproveArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERApproveArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ApproveError`.
sealed class LEDGERApproveError with CandidSerializable {
  const LEDGERApproveError();

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

  factory LEDGERApproveError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('BadFee')) {
      return LEDGERApproveErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('InsufficientFunds')) {
      return LEDGERApproveErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    if (json.containsKey('AllowanceChanged')) {
      return LEDGERApproveErrorAllowanceChanged.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['AllowanceChanged']),
      );
    }
    if (json.containsKey('Expired')) {
      return LEDGERApproveErrorExpired.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Expired']),
      );
    }
    if (json.containsKey('TooOld')) {
      return const LEDGERApproveErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return LEDGERApproveErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return LEDGERApproveErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const LEDGERApproveErrorTemporarilyUnavailable();
    }
    if (json.containsKey('GenericError')) {
      return LEDGERApproveErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERApproveError.fromCandid',
      reason: 'Unknown LEDGERApproveError arm',
    );
  }

  factory LEDGERApproveError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERApproveError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ApproveError.BadFee`.
final class LEDGERApproveErrorBadFee extends LEDGERApproveError {
  final LEDGERIcrc1Tokens expectedFee;

  const LEDGERApproveErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => LEDGERApproveError.ctype;

  @override
  dynamic get candidValue => Variant('BadFee', {'expected_fee': expectedFee});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee},
  };

  factory LEDGERApproveErrorBadFee.fromCandid(Map<String, dynamic> json) {
    return LEDGERApproveErrorBadFee(
      expectedFee: json.valueAsBigInt<BigInt>('expected_fee'),
    );
  }
}

/// Variant arm `ApproveError.InsufficientFunds`.
final class LEDGERApproveErrorInsufficientFunds extends LEDGERApproveError {
  final LEDGERIcrc1Tokens balance;

  const LEDGERApproveErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => LEDGERApproveError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory LEDGERApproveErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERApproveErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Variant arm `ApproveError.AllowanceChanged`.
final class LEDGERApproveErrorAllowanceChanged extends LEDGERApproveError {
  final LEDGERIcrc1Tokens currentAllowance;

  const LEDGERApproveErrorAllowanceChanged({required this.currentAllowance});

  @override
  CType get candidType => LEDGERApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('AllowanceChanged', {'current_allowance': currentAllowance});

  @override
  Map<String, dynamic> toJson() => {
    'AllowanceChanged': {'current_allowance': currentAllowance},
  };

  factory LEDGERApproveErrorAllowanceChanged.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERApproveErrorAllowanceChanged(
      currentAllowance: json.valueAsBigInt<BigInt>('current_allowance'),
    );
  }
}

/// Variant arm `ApproveError.Expired`.
final class LEDGERApproveErrorExpired extends LEDGERApproveError {
  final BigInt ledgerTime;

  const LEDGERApproveErrorExpired({required this.ledgerTime});

  @override
  CType get candidType => LEDGERApproveError.ctype;

  @override
  dynamic get candidValue => Variant('Expired', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'Expired': {'ledger_time': ledgerTime},
  };

  factory LEDGERApproveErrorExpired.fromCandid(Map<String, dynamic> json) {
    return LEDGERApproveErrorExpired(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `ApproveError.TooOld` (nullary).
final class LEDGERApproveErrorTooOld extends LEDGERApproveError {
  const LEDGERApproveErrorTooOld();

  @override
  CType get candidType => LEDGERApproveError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `ApproveError.CreatedInFuture`.
final class LEDGERApproveErrorCreatedInFuture extends LEDGERApproveError {
  final BigInt ledgerTime;

  const LEDGERApproveErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => LEDGERApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory LEDGERApproveErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERApproveErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `ApproveError.Duplicate`.
final class LEDGERApproveErrorDuplicate extends LEDGERApproveError {
  final LEDGERIcrc1BlockIndex duplicateOf;

  const LEDGERApproveErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => LEDGERApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory LEDGERApproveErrorDuplicate.fromCandid(Map<String, dynamic> json) {
    return LEDGERApproveErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `ApproveError.TemporarilyUnavailable` (nullary).
final class LEDGERApproveErrorTemporarilyUnavailable
    extends LEDGERApproveError {
  const LEDGERApproveErrorTemporarilyUnavailable();

  @override
  CType get candidType => LEDGERApproveError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `ApproveError.GenericError`.
final class LEDGERApproveErrorGenericError extends LEDGERApproveError {
  final BigInt errorCode;
  final String message;

  const LEDGERApproveErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => LEDGERApproveError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory LEDGERApproveErrorGenericError.fromCandid(Map<String, dynamic> json) {
    return LEDGERApproveErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid variant `ApproveResult`.
sealed class LEDGERApproveResult with CandidSerializable {
  const LEDGERApproveResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => LEDGERApproveError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERApproveResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return LEDGERApproveResultOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return LEDGERApproveResultErr(
        json.valueTo<LEDGERApproveError, Map>(
          key: 'Err',
          parse:
              (e) => LEDGERApproveError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERApproveResult.fromCandid',
      reason: 'Unknown LEDGERApproveResult arm',
    );
  }

  factory LEDGERApproveResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERApproveResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ApproveResult.Ok`.
final class LEDGERApproveResultOk extends LEDGERApproveResult {
  final LEDGERIcrc1BlockIndex value;
  const LEDGERApproveResultOk(this.value);

  @override
  CType get candidType => LEDGERApproveResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ApproveResult.Err`.
final class LEDGERApproveResultErr extends LEDGERApproveResult {
  final LEDGERApproveError value;
  const LEDGERApproveResultErr(this.value);

  @override
  CType get candidType => LEDGERApproveResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `AllowanceArgs`.
final class LEDGERAllowanceArgs with CandidSerializable {
  final LEDGERAccount account;
  final LEDGERAccount spender;

  const LEDGERAllowanceArgs({required this.account, required this.spender});

  static CType get ctype => CType.record([
    LazyField(Label.named('account'), () => LEDGERAccount.ctype),
    LazyField(Label.named('spender'), () => LEDGERAccount.ctype),
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

  factory LEDGERAllowanceArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERAllowanceArgs(
      account: json.valueTo<LEDGERAccount, Map>(
        key: 'account',
        parse:
            (e) => LEDGERAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      spender: json.valueTo<LEDGERAccount, Map>(
        key: 'spender',
        parse:
            (e) => LEDGERAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERAllowanceArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERAllowanceArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `Allowance`.
final class LEDGERAllowance with CandidSerializable {
  final LEDGERIcrc1Tokens allowance;
  final LEDGERIcrc1Timestamp? expiresAt;

  const LEDGERAllowance({required this.allowance, this.expiresAt});

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

  factory LEDGERAllowance.fromCandid(Map<String, dynamic> json) {
    return LEDGERAllowance(
      allowance: json.valueAsBigInt<BigInt>('allowance'),
      expiresAt: json.valueAsBigInt<BigInt?>('expires_at'),
    );
  }

  factory LEDGERAllowance.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERAllowance.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TransferFromArgs`.
final class LEDGERTransferFromArgs with CandidSerializable {
  final LEDGERSubAccount? spenderSubaccount;
  final LEDGERAccount from;
  final LEDGERAccount to;
  final LEDGERIcrc1Tokens amount;
  final LEDGERIcrc1Tokens? fee;
  final List<int>? memo;
  final LEDGERIcrc1Timestamp? createdAtTime;

  const LEDGERTransferFromArgs({
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
    LazyField(Label.named('from'), () => LEDGERAccount.ctype),
    LazyField(Label.named('to'), () => LEDGERAccount.ctype),
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

  factory LEDGERTransferFromArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERTransferFromArgs(
      spenderSubaccount: json.valueAsBytes<List<int>?>(
        'spender_subaccount',
        encoding: StringEncoding.base64,
      ),
      from: json.valueTo<LEDGERAccount, Map>(
        key: 'from',
        parse:
            (e) => LEDGERAccount.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      to: json.valueTo<LEDGERAccount, Map>(
        key: 'to',
        parse:
            (e) => LEDGERAccount.fromCandid(
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

  factory LEDGERTransferFromArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTransferFromArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `TransferFromResult`.
sealed class LEDGERTransferFromResult with CandidSerializable {
  const LEDGERTransferFromResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => LEDGERTransferFromError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERTransferFromResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return LEDGERTransferFromResultOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return LEDGERTransferFromResultErr(
        json.valueTo<LEDGERTransferFromError, Map>(
          key: 'Err',
          parse:
              (e) => LEDGERTransferFromError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERTransferFromResult.fromCandid',
      reason: 'Unknown LEDGERTransferFromResult arm',
    );
  }

  factory LEDGERTransferFromResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTransferFromResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferFromResult.Ok`.
final class LEDGERTransferFromResultOk extends LEDGERTransferFromResult {
  final LEDGERIcrc1BlockIndex value;
  const LEDGERTransferFromResultOk(this.value);

  @override
  CType get candidType => LEDGERTransferFromResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `TransferFromResult.Err`.
final class LEDGERTransferFromResultErr extends LEDGERTransferFromResult {
  final LEDGERTransferFromError value;
  const LEDGERTransferFromResultErr(this.value);

  @override
  CType get candidType => LEDGERTransferFromResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `TransferFromError`.
sealed class LEDGERTransferFromError with CandidSerializable {
  const LEDGERTransferFromError();

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

  factory LEDGERTransferFromError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('BadFee')) {
      return LEDGERTransferFromErrorBadFee.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadFee']),
      );
    }
    if (json.containsKey('BadBurn')) {
      return LEDGERTransferFromErrorBadBurn.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['BadBurn']),
      );
    }
    if (json.containsKey('InsufficientFunds')) {
      return LEDGERTransferFromErrorInsufficientFunds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['InsufficientFunds']),
      );
    }
    if (json.containsKey('InsufficientAllowance')) {
      return LEDGERTransferFromErrorInsufficientAllowance.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['InsufficientAllowance'],
        ),
      );
    }
    if (json.containsKey('TooOld')) {
      return const LEDGERTransferFromErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return LEDGERTransferFromErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return LEDGERTransferFromErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('TemporarilyUnavailable')) {
      return const LEDGERTransferFromErrorTemporarilyUnavailable();
    }
    if (json.containsKey('GenericError')) {
      return LEDGERTransferFromErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERTransferFromError.fromCandid',
      reason: 'Unknown LEDGERTransferFromError arm',
    );
  }

  factory LEDGERTransferFromError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTransferFromError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferFromError.BadFee`.
final class LEDGERTransferFromErrorBadFee extends LEDGERTransferFromError {
  final LEDGERIcrc1Tokens expectedFee;

  const LEDGERTransferFromErrorBadFee({required this.expectedFee});

  @override
  CType get candidType => LEDGERTransferFromError.ctype;

  @override
  dynamic get candidValue => Variant('BadFee', {'expected_fee': expectedFee});

  @override
  Map<String, dynamic> toJson() => {
    'BadFee': {'expected_fee': expectedFee},
  };

  factory LEDGERTransferFromErrorBadFee.fromCandid(Map<String, dynamic> json) {
    return LEDGERTransferFromErrorBadFee(
      expectedFee: json.valueAsBigInt<BigInt>('expected_fee'),
    );
  }
}

/// Variant arm `TransferFromError.BadBurn`.
final class LEDGERTransferFromErrorBadBurn extends LEDGERTransferFromError {
  final LEDGERIcrc1Tokens minBurnAmount;

  const LEDGERTransferFromErrorBadBurn({required this.minBurnAmount});

  @override
  CType get candidType => LEDGERTransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('BadBurn', {'min_burn_amount': minBurnAmount});

  @override
  Map<String, dynamic> toJson() => {
    'BadBurn': {'min_burn_amount': minBurnAmount},
  };

  factory LEDGERTransferFromErrorBadBurn.fromCandid(Map<String, dynamic> json) {
    return LEDGERTransferFromErrorBadBurn(
      minBurnAmount: json.valueAsBigInt<BigInt>('min_burn_amount'),
    );
  }
}

/// Variant arm `TransferFromError.InsufficientFunds`.
final class LEDGERTransferFromErrorInsufficientFunds
    extends LEDGERTransferFromError {
  final LEDGERIcrc1Tokens balance;

  const LEDGERTransferFromErrorInsufficientFunds({required this.balance});

  @override
  CType get candidType => LEDGERTransferFromError.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientFunds', {'balance': balance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientFunds': {'balance': balance},
  };

  factory LEDGERTransferFromErrorInsufficientFunds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERTransferFromErrorInsufficientFunds(
      balance: json.valueAsBigInt<BigInt>('balance'),
    );
  }
}

/// Variant arm `TransferFromError.InsufficientAllowance`.
final class LEDGERTransferFromErrorInsufficientAllowance
    extends LEDGERTransferFromError {
  final LEDGERIcrc1Tokens allowance;

  const LEDGERTransferFromErrorInsufficientAllowance({required this.allowance});

  @override
  CType get candidType => LEDGERTransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('InsufficientAllowance', {'allowance': allowance});

  @override
  Map<String, dynamic> toJson() => {
    'InsufficientAllowance': {'allowance': allowance},
  };

  factory LEDGERTransferFromErrorInsufficientAllowance.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERTransferFromErrorInsufficientAllowance(
      allowance: json.valueAsBigInt<BigInt>('allowance'),
    );
  }
}

/// Variant arm `TransferFromError.TooOld` (nullary).
final class LEDGERTransferFromErrorTooOld extends LEDGERTransferFromError {
  const LEDGERTransferFromErrorTooOld();

  @override
  CType get candidType => LEDGERTransferFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `TransferFromError.CreatedInFuture`.
final class LEDGERTransferFromErrorCreatedInFuture
    extends LEDGERTransferFromError {
  final LEDGERIcrc1Timestamp ledgerTime;

  const LEDGERTransferFromErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => LEDGERTransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory LEDGERTransferFromErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERTransferFromErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `TransferFromError.Duplicate`.
final class LEDGERTransferFromErrorDuplicate extends LEDGERTransferFromError {
  final LEDGERIcrc1BlockIndex duplicateOf;

  const LEDGERTransferFromErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => LEDGERTransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory LEDGERTransferFromErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERTransferFromErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `TransferFromError.TemporarilyUnavailable` (nullary).
final class LEDGERTransferFromErrorTemporarilyUnavailable
    extends LEDGERTransferFromError {
  const LEDGERTransferFromErrorTemporarilyUnavailable();

  @override
  CType get candidType => LEDGERTransferFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TemporarilyUnavailable', null);

  @override
  Map<String, dynamic> toJson() => {'TemporarilyUnavailable': null};
}

/// Variant arm `TransferFromError.GenericError`.
final class LEDGERTransferFromErrorGenericError
    extends LEDGERTransferFromError {
  final BigInt errorCode;
  final String message;

  const LEDGERTransferFromErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => LEDGERTransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory LEDGERTransferFromErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERTransferFromErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `icrc21_consent_message_metadata`.
final class LEDGERIcrc21ConsentMessageMetadata with CandidSerializable {
  final String language;
  final int? utcOffsetMinutes;

  const LEDGERIcrc21ConsentMessageMetadata({
    required this.language,
    this.utcOffsetMinutes,
  });

  static CType get ctype => CType.record([
    Field(Label.named('language'), CType.text),
    Field(Label.named('utc_offset_minutes'), CType.opt(CType.int16)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'language': language,
    'utc_offset_minutes': utcOffsetMinutes,
  };

  Map<String, dynamic> toJson() => {
    'language': language,
    'utc_offset_minutes': utcOffsetMinutes,
  };

  factory LEDGERIcrc21ConsentMessageMetadata.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERIcrc21ConsentMessageMetadata(
      language: json.valueAsString<String>('language'),
      utcOffsetMinutes: json.valueAsInt<int?>('utc_offset_minutes'),
    );
  }

  factory LEDGERIcrc21ConsentMessageMetadata.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc21ConsentMessageMetadata.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `icrc21_consent_message_spec`.
final class LEDGERIcrc21ConsentMessageSpec with CandidSerializable {
  final LEDGERIcrc21ConsentMessageMetadata metadata;
  final LEDGERIcrc21ConsentMessageSpecDeviceSpec? deviceSpec;

  const LEDGERIcrc21ConsentMessageSpec({
    required this.metadata,
    this.deviceSpec,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('metadata'),
      () => LEDGERIcrc21ConsentMessageMetadata.ctype,
    ),
    LazyField(
      Label.named('device_spec'),
      () => CType.opt(LEDGERIcrc21ConsentMessageSpecDeviceSpec.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'metadata': metadata.candidValue,
    'device_spec': deviceSpec?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'metadata': metadata.toJson(),
    'device_spec': deviceSpec?.toJson(),
  };

  factory LEDGERIcrc21ConsentMessageSpec.fromCandid(Map<String, dynamic> json) {
    return LEDGERIcrc21ConsentMessageSpec(
      metadata: json.valueTo<LEDGERIcrc21ConsentMessageMetadata, Map>(
        key: 'metadata',
        parse:
            (e) => LEDGERIcrc21ConsentMessageMetadata.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      deviceSpec: json.valueTo<LEDGERIcrc21ConsentMessageSpecDeviceSpec?, Map>(
        key: 'device_spec',
        parse:
            (e) => LEDGERIcrc21ConsentMessageSpecDeviceSpec.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERIcrc21ConsentMessageSpec.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc21ConsentMessageSpec.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `icrc21_consent_message_request`.
final class LEDGERIcrc21ConsentMessageRequest with CandidSerializable {
  final String method;
  final List<int> arg;
  final LEDGERIcrc21ConsentMessageSpec userPreferences;

  const LEDGERIcrc21ConsentMessageRequest({
    required this.method,
    required this.arg,
    required this.userPreferences,
  });

  static CType get ctype => CType.record([
    Field(Label.named('method'), CType.text),
    Field(Label.named('arg'), CType.vec(CType.nat8)),
    LazyField(
      Label.named('user_preferences'),
      () => LEDGERIcrc21ConsentMessageSpec.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'method': method,
    'arg': arg,
    'user_preferences': userPreferences.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'method': method,
    'arg': arg,
    'user_preferences': userPreferences.toJson(),
  };

  factory LEDGERIcrc21ConsentMessageRequest.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERIcrc21ConsentMessageRequest(
      method: json.valueAsString<String>('method'),
      arg: json.valueAsBytes<List<int>>('arg', encoding: StringEncoding.base64),
      userPreferences: json.valueTo<LEDGERIcrc21ConsentMessageSpec, Map>(
        key: 'user_preferences',
        parse:
            (e) => LEDGERIcrc21ConsentMessageSpec.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERIcrc21ConsentMessageRequest.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc21ConsentMessageRequest.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Icrc21Value`.
sealed class LEDGERIcrc21Value with CandidSerializable {
  const LEDGERIcrc21Value();

  static CType get ctype => CType.variant([
    Field(
      Label.named('TokenAmount'),
      CType.record([
        Field(Label.named('decimals'), CType.nat8),
        Field(Label.named('amount'), CType.nat64),
        Field(Label.named('symbol'), CType.text),
      ]),
    ),
    Field(
      Label.named('TimestampSeconds'),
      CType.record([Field(Label.named('amount'), CType.nat64)]),
    ),
    Field(
      Label.named('DurationSeconds'),
      CType.record([Field(Label.named('amount'), CType.nat64)]),
    ),
    Field(
      Label.named('Text'),
      CType.record([Field(Label.named('content'), CType.text)]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERIcrc21Value.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('TokenAmount')) {
      return LEDGERIcrc21ValueTokenAmount.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['TokenAmount']),
      );
    }
    if (json.containsKey('TimestampSeconds')) {
      return LEDGERIcrc21ValueTimestampSeconds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['TimestampSeconds']),
      );
    }
    if (json.containsKey('DurationSeconds')) {
      return LEDGERIcrc21ValueDurationSeconds.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['DurationSeconds']),
      );
    }
    if (json.containsKey('Text')) {
      return LEDGERIcrc21ValueText.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Text']),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERIcrc21Value.fromCandid',
      reason: 'Unknown LEDGERIcrc21Value arm',
    );
  }

  factory LEDGERIcrc21Value.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc21Value.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Icrc21Value.TokenAmount`.
final class LEDGERIcrc21ValueTokenAmount extends LEDGERIcrc21Value {
  final int decimals;
  final BigInt amount;
  final String symbol;

  const LEDGERIcrc21ValueTokenAmount({
    required this.decimals,
    required this.amount,
    required this.symbol,
  });

  @override
  CType get candidType => LEDGERIcrc21Value.ctype;

  @override
  dynamic get candidValue => Variant('TokenAmount', {
    'decimals': decimals,
    'amount': amount,
    'symbol': symbol,
  });

  @override
  Map<String, dynamic> toJson() => {
    'TokenAmount': {'decimals': decimals, 'amount': amount, 'symbol': symbol},
  };

  factory LEDGERIcrc21ValueTokenAmount.fromCandid(Map<String, dynamic> json) {
    return LEDGERIcrc21ValueTokenAmount(
      decimals: json.valueAsInt<int>('decimals'),
      amount: json.valueAsBigInt<BigInt>('amount'),
      symbol: json.valueAsString<String>('symbol'),
    );
  }
}

/// Variant arm `Icrc21Value.TimestampSeconds`.
final class LEDGERIcrc21ValueTimestampSeconds extends LEDGERIcrc21Value {
  final BigInt amount;

  const LEDGERIcrc21ValueTimestampSeconds({required this.amount});

  @override
  CType get candidType => LEDGERIcrc21Value.ctype;

  @override
  dynamic get candidValue => Variant('TimestampSeconds', {'amount': amount});

  @override
  Map<String, dynamic> toJson() => {
    'TimestampSeconds': {'amount': amount},
  };

  factory LEDGERIcrc21ValueTimestampSeconds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERIcrc21ValueTimestampSeconds(
      amount: json.valueAsBigInt<BigInt>('amount'),
    );
  }
}

/// Variant arm `Icrc21Value.DurationSeconds`.
final class LEDGERIcrc21ValueDurationSeconds extends LEDGERIcrc21Value {
  final BigInt amount;

  const LEDGERIcrc21ValueDurationSeconds({required this.amount});

  @override
  CType get candidType => LEDGERIcrc21Value.ctype;

  @override
  dynamic get candidValue => Variant('DurationSeconds', {'amount': amount});

  @override
  Map<String, dynamic> toJson() => {
    'DurationSeconds': {'amount': amount},
  };

  factory LEDGERIcrc21ValueDurationSeconds.fromCandid(
    Map<String, dynamic> json,
  ) {
    return LEDGERIcrc21ValueDurationSeconds(
      amount: json.valueAsBigInt<BigInt>('amount'),
    );
  }
}

/// Variant arm `Icrc21Value.Text`.
final class LEDGERIcrc21ValueText extends LEDGERIcrc21Value {
  final String content;

  const LEDGERIcrc21ValueText({required this.content});

  @override
  CType get candidType => LEDGERIcrc21Value.ctype;

  @override
  dynamic get candidValue => Variant('Text', {'content': content});

  @override
  Map<String, dynamic> toJson() => {
    'Text': {'content': content},
  };

  factory LEDGERIcrc21ValueText.fromCandid(Map<String, dynamic> json) {
    return LEDGERIcrc21ValueText(
      content: json.valueAsString<String>('content'),
    );
  }
}

/// Candid record `FieldsDisplay`.
final class LEDGERFieldsDisplay with CandidSerializable {
  final String intent;
  final List<LEDGERFieldsDisplayFields> fields;

  const LEDGERFieldsDisplay({required this.intent, required this.fields});

  static CType get ctype => CType.record([
    Field(Label.named('intent'), CType.text),
    LazyField(
      Label.named('fields'),
      () => CType.vec(LEDGERFieldsDisplayFields.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'intent': intent,
    'fields': fields.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'intent': intent,
    'fields': fields.map((el) => el.toJson()).toList(),
  };

  factory LEDGERFieldsDisplay.fromCandid(Map<String, dynamic> json) {
    return LEDGERFieldsDisplay(
      intent: json.valueAsString<String>('intent'),
      fields: json.valueTo<List<LEDGERFieldsDisplayFields>, List>(
        key: 'fields',
        parse:
            (e) =>
                e
                    .map<LEDGERFieldsDisplayFields>(
                      (x) => LEDGERFieldsDisplayFields.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory LEDGERFieldsDisplay.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERFieldsDisplay.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `icrc21_consent_message`.
sealed class LEDGERIcrc21ConsentMessage with CandidSerializable {
  const LEDGERIcrc21ConsentMessage();

  static CType get ctype => CType.variant([
    Field(Label.named('GenericDisplayMessage'), CType.text),
    LazyField(
      Label.named('FieldsDisplayMessage'),
      () => LEDGERFieldsDisplay.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERIcrc21ConsentMessage.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('GenericDisplayMessage')) {
      return LEDGERIcrc21ConsentMessageGenericDisplayMessage(
        json.valueAsString<String>('GenericDisplayMessage'),
      );
    }
    if (json.containsKey('FieldsDisplayMessage')) {
      return LEDGERIcrc21ConsentMessageFieldsDisplayMessage(
        json.valueTo<LEDGERFieldsDisplay, Map>(
          key: 'FieldsDisplayMessage',
          parse:
              (e) => LEDGERFieldsDisplay.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERIcrc21ConsentMessage.fromCandid',
      reason: 'Unknown LEDGERIcrc21ConsentMessage arm',
    );
  }

  factory LEDGERIcrc21ConsentMessage.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc21ConsentMessage.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `icrc21_consent_message.GenericDisplayMessage`.
final class LEDGERIcrc21ConsentMessageGenericDisplayMessage
    extends LEDGERIcrc21ConsentMessage {
  final String value;
  const LEDGERIcrc21ConsentMessageGenericDisplayMessage(this.value);

  @override
  CType get candidType => LEDGERIcrc21ConsentMessage.ctype;

  @override
  dynamic get candidValue => Variant('GenericDisplayMessage', value);

  @override
  Map<String, dynamic> toJson() => {'GenericDisplayMessage': value};
}

/// Variant arm `icrc21_consent_message.FieldsDisplayMessage`.
final class LEDGERIcrc21ConsentMessageFieldsDisplayMessage
    extends LEDGERIcrc21ConsentMessage {
  final LEDGERFieldsDisplay value;
  const LEDGERIcrc21ConsentMessageFieldsDisplayMessage(this.value);

  @override
  CType get candidType => LEDGERIcrc21ConsentMessage.ctype;

  @override
  dynamic get candidValue => Variant('FieldsDisplayMessage', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'FieldsDisplayMessage': value.toJson()};
}

/// Candid record `icrc21_consent_info`.
final class LEDGERIcrc21ConsentInfo with CandidSerializable {
  final LEDGERIcrc21ConsentMessage consentMessage;
  final LEDGERIcrc21ConsentMessageMetadata metadata;

  const LEDGERIcrc21ConsentInfo({
    required this.consentMessage,
    required this.metadata,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('consent_message'),
      () => LEDGERIcrc21ConsentMessage.ctype,
    ),
    LazyField(
      Label.named('metadata'),
      () => LEDGERIcrc21ConsentMessageMetadata.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'consent_message': consentMessage.candidValue,
    'metadata': metadata.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'consent_message': consentMessage.toJson(),
    'metadata': metadata.toJson(),
  };

  factory LEDGERIcrc21ConsentInfo.fromCandid(Map<String, dynamic> json) {
    return LEDGERIcrc21ConsentInfo(
      consentMessage: json.valueTo<LEDGERIcrc21ConsentMessage, Map>(
        key: 'consent_message',
        parse:
            (e) => LEDGERIcrc21ConsentMessage.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      metadata: json.valueTo<LEDGERIcrc21ConsentMessageMetadata, Map>(
        key: 'metadata',
        parse:
            (e) => LEDGERIcrc21ConsentMessageMetadata.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory LEDGERIcrc21ConsentInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc21ConsentInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `icrc21_error_info`.
final class LEDGERIcrc21ErrorInfo with CandidSerializable {
  final String description;

  const LEDGERIcrc21ErrorInfo({required this.description});

  static CType get ctype =>
      CType.record([Field(Label.named('description'), CType.text)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'description': description};

  Map<String, dynamic> toJson() => {'description': description};

  factory LEDGERIcrc21ErrorInfo.fromCandid(Map<String, dynamic> json) {
    return LEDGERIcrc21ErrorInfo(
      description: json.valueAsString<String>('description'),
    );
  }

  factory LEDGERIcrc21ErrorInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc21ErrorInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `icrc21_error`.
sealed class LEDGERIcrc21Error with CandidSerializable {
  const LEDGERIcrc21Error();

  static CType get ctype => CType.variant([
    LazyField(
      Label.named('UnsupportedCanisterCall'),
      () => LEDGERIcrc21ErrorInfo.ctype,
    ),
    LazyField(
      Label.named('ConsentMessageUnavailable'),
      () => LEDGERIcrc21ErrorInfo.ctype,
    ),
    LazyField(
      Label.named('InsufficientPayment'),
      () => LEDGERIcrc21ErrorInfo.ctype,
    ),
    Field(
      Label.named('GenericError'),
      CType.record([
        Field(Label.named('error_code'), CType.nat),
        Field(Label.named('description'), CType.text),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERIcrc21Error.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('UnsupportedCanisterCall')) {
      return LEDGERIcrc21ErrorUnsupportedCanisterCall(
        json.valueTo<LEDGERIcrc21ErrorInfo, Map>(
          key: 'UnsupportedCanisterCall',
          parse:
              (e) => LEDGERIcrc21ErrorInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('ConsentMessageUnavailable')) {
      return LEDGERIcrc21ErrorConsentMessageUnavailable(
        json.valueTo<LEDGERIcrc21ErrorInfo, Map>(
          key: 'ConsentMessageUnavailable',
          parse:
              (e) => LEDGERIcrc21ErrorInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('InsufficientPayment')) {
      return LEDGERIcrc21ErrorInsufficientPayment(
        json.valueTo<LEDGERIcrc21ErrorInfo, Map>(
          key: 'InsufficientPayment',
          parse:
              (e) => LEDGERIcrc21ErrorInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('GenericError')) {
      return LEDGERIcrc21ErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERIcrc21Error.fromCandid',
      reason: 'Unknown LEDGERIcrc21Error arm',
    );
  }

  factory LEDGERIcrc21Error.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc21Error.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `icrc21_error.UnsupportedCanisterCall`.
final class LEDGERIcrc21ErrorUnsupportedCanisterCall extends LEDGERIcrc21Error {
  final LEDGERIcrc21ErrorInfo value;
  const LEDGERIcrc21ErrorUnsupportedCanisterCall(this.value);

  @override
  CType get candidType => LEDGERIcrc21Error.ctype;

  @override
  dynamic get candidValue =>
      Variant('UnsupportedCanisterCall', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'UnsupportedCanisterCall': value.toJson()};
}

/// Variant arm `icrc21_error.ConsentMessageUnavailable`.
final class LEDGERIcrc21ErrorConsentMessageUnavailable
    extends LEDGERIcrc21Error {
  final LEDGERIcrc21ErrorInfo value;
  const LEDGERIcrc21ErrorConsentMessageUnavailable(this.value);

  @override
  CType get candidType => LEDGERIcrc21Error.ctype;

  @override
  dynamic get candidValue =>
      Variant('ConsentMessageUnavailable', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {
    'ConsentMessageUnavailable': value.toJson(),
  };
}

/// Variant arm `icrc21_error.InsufficientPayment`.
final class LEDGERIcrc21ErrorInsufficientPayment extends LEDGERIcrc21Error {
  final LEDGERIcrc21ErrorInfo value;
  const LEDGERIcrc21ErrorInsufficientPayment(this.value);

  @override
  CType get candidType => LEDGERIcrc21Error.ctype;

  @override
  dynamic get candidValue => Variant('InsufficientPayment', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'InsufficientPayment': value.toJson()};
}

/// Variant arm `icrc21_error.GenericError`.
final class LEDGERIcrc21ErrorGenericError extends LEDGERIcrc21Error {
  final BigInt errorCode;
  final String description;

  const LEDGERIcrc21ErrorGenericError({
    required this.errorCode,
    required this.description,
  });

  @override
  CType get candidType => LEDGERIcrc21Error.ctype;

  @override
  dynamic get candidValue => Variant('GenericError', {
    'error_code': errorCode,
    'description': description,
  });

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'description': description},
  };

  factory LEDGERIcrc21ErrorGenericError.fromCandid(Map<String, dynamic> json) {
    return LEDGERIcrc21ErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      description: json.valueAsString<String>('description'),
    );
  }
}

/// Candid variant `icrc21_consent_message_response`.
sealed class LEDGERIcrc21ConsentMessageResponse with CandidSerializable {
  const LEDGERIcrc21ConsentMessageResponse();

  static CType get ctype => CType.variant([
    LazyField(Label.named('Ok'), () => LEDGERIcrc21ConsentInfo.ctype),
    LazyField(Label.named('Err'), () => LEDGERIcrc21Error.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory LEDGERIcrc21ConsentMessageResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return LEDGERIcrc21ConsentMessageResponseOk(
        json.valueTo<LEDGERIcrc21ConsentInfo, Map>(
          key: 'Ok',
          parse:
              (e) => LEDGERIcrc21ConsentInfo.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    if (json.containsKey('Err')) {
      return LEDGERIcrc21ConsentMessageResponseErr(
        json.valueTo<LEDGERIcrc21Error, Map>(
          key: 'Err',
          parse:
              (e) => LEDGERIcrc21Error.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'LEDGERIcrc21ConsentMessageResponse.fromCandid',
      reason: 'Unknown LEDGERIcrc21ConsentMessageResponse arm',
    );
  }

  factory LEDGERIcrc21ConsentMessageResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERIcrc21ConsentMessageResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `icrc21_consent_message_response.Ok`.
final class LEDGERIcrc21ConsentMessageResponseOk
    extends LEDGERIcrc21ConsentMessageResponse {
  final LEDGERIcrc21ConsentInfo value;
  const LEDGERIcrc21ConsentMessageResponseOk(this.value);

  @override
  CType get candidType => LEDGERIcrc21ConsentMessageResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Ok': value.toJson()};
}

/// Variant arm `icrc21_consent_message_response.Err`.
final class LEDGERIcrc21ConsentMessageResponseErr
    extends LEDGERIcrc21ConsentMessageResponse {
  final LEDGERIcrc21Error value;
  const LEDGERIcrc21ConsentMessageResponseErr(this.value);

  @override
  CType get candidType => LEDGERIcrc21ConsentMessageResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid record `GetAllowancesArgs`.
final class LEDGERGetAllowancesArgs with CandidSerializable {
  final LEDGERTextAccountIdentifier fromAccountId;
  final LEDGERTextAccountIdentifier? prevSpenderId;
  final BigInt? take;

  const LEDGERGetAllowancesArgs({
    required this.fromAccountId,
    this.prevSpenderId,
    this.take,
  });

  static CType get ctype => CType.record([
    Field(Label.named('from_account_id'), CType.text),
    Field(Label.named('prev_spender_id'), CType.opt(CType.text)),
    Field(Label.named('take'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'from_account_id': fromAccountId,
    'prev_spender_id': prevSpenderId,
    'take': take,
  };

  Map<String, dynamic> toJson() => {
    'from_account_id': fromAccountId,
    'prev_spender_id': prevSpenderId,
    'take': take,
  };

  factory LEDGERGetAllowancesArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERGetAllowancesArgs(
      fromAccountId: json.valueAsString<String>('from_account_id'),
      prevSpenderId: json.valueAsString<String?>('prev_spender_id'),
      take: json.valueAsBigInt<BigInt?>('take'),
    );
  }

  factory LEDGERGetAllowancesArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERGetAllowancesArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TipOfChainRes`.
final class LEDGERTipOfChainRes with CandidSerializable {
  final List<int>? certification;
  final LEDGERBlockIndex tipIndex;

  const LEDGERTipOfChainRes({this.certification, required this.tipIndex});

  static CType get ctype => CType.record([
    Field(Label.named('certification'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('tip_index'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'certification': certification,
    'tip_index': tipIndex,
  };

  Map<String, dynamic> toJson() => {
    'certification': certification,
    'tip_index': tipIndex,
  };

  factory LEDGERTipOfChainRes.fromCandid(Map<String, dynamic> json) {
    return LEDGERTipOfChainRes(
      certification: json.valueAsBytes<List<int>?>(
        'certification',
        encoding: StringEncoding.base64,
      ),
      tipIndex: json.valueAsBigInt<BigInt>('tip_index'),
    );
  }

  factory LEDGERTipOfChainRes.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERTipOfChainRes.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `RemoveApprovalArgs`.
final class LEDGERRemoveApprovalArgs with CandidSerializable {
  final LEDGERSubAccount? fromSubaccount;
  final LEDGERAccountIdentifier spender;
  final LEDGERIcrc1Tokens? fee;

  const LEDGERRemoveApprovalArgs({
    this.fromSubaccount,
    required this.spender,
    this.fee,
  });

  static CType get ctype => CType.record([
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('spender'), CType.vec(CType.nat8)),
    Field(Label.named('fee'), CType.opt(CType.nat)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'from_subaccount': fromSubaccount,
    'spender': spender,
    'fee': fee,
  };

  Map<String, dynamic> toJson() => {
    'from_subaccount': fromSubaccount,
    'spender': spender,
    'fee': fee,
  };

  factory LEDGERRemoveApprovalArgs.fromCandid(Map<String, dynamic> json) {
    return LEDGERRemoveApprovalArgs(
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      spender: json.valueAsBytes<List<int>>(
        'spender',
        encoding: StringEncoding.base64,
      ),
      fee: json.valueAsBigInt<BigInt?>('fee'),
    );
  }

  factory LEDGERRemoveApprovalArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return LEDGERRemoveApprovalArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

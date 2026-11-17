// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid type alias `Subaccount`.
typedef ICRC37Subaccount = List<int>;

/// Candid type alias `CollectionApproval`.
typedef ICRC37CollectionApproval = ICRC37ApprovalInfo;

/// CType for alias `CollectionApproval`.
abstract final class ICRC37CollectionApprovalCandid {
  static CType get ctype => ICRC37ApprovalInfo.ctype;
}

/// Candid record `Account`.
final class ICRC37Account with CandidSerializable {
  final IcpPrincipalAddress owner;
  final ICRC37Subaccount? subaccount;

  const ICRC37Account({required this.owner, this.subaccount});

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

  factory ICRC37Account.fromCandid(Map<String, dynamic> json) {
    return ICRC37Account(
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

  factory ICRC37Account.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37Account.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ApprovalInfo`.
final class ICRC37ApprovalInfo with CandidSerializable {
  final ICRC37Account spender;
  final List<int>? fromSubaccount;
  final BigInt? expiresAt;
  final List<int>? memo;
  final BigInt createdAtTime;

  const ICRC37ApprovalInfo({
    required this.spender,
    this.fromSubaccount,
    this.expiresAt,
    this.memo,
    required this.createdAtTime,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('spender'), () => ICRC37Account.ctype),
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('expires_at'), CType.opt(CType.nat64)),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'spender': spender.candidValue,
    'from_subaccount': fromSubaccount,
    'expires_at': expiresAt,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'spender': spender.toJson(),
    'from_subaccount': fromSubaccount,
    'expires_at': expiresAt,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  factory ICRC37ApprovalInfo.fromCandid(Map<String, dynamic> json) {
    return ICRC37ApprovalInfo(
      spender: json.valueTo<ICRC37Account, Map>(
        key: 'spender',
        parse:
            (e) => ICRC37Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      expiresAt: json.valueAsBigInt<BigInt?>('expires_at'),
      memo: json.valueAsBytes<List<int>?>(
        'memo',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt>('created_at_time'),
    );
  }

  factory ICRC37ApprovalInfo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37ApprovalInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ApproveTokenArg`.
final class ICRC37ApproveTokenArg with CandidSerializable {
  final BigInt tokenId;
  final ICRC37ApprovalInfo approvalInfo;

  const ICRC37ApproveTokenArg({
    required this.tokenId,
    required this.approvalInfo,
  });

  static CType get ctype => CType.record([
    Field(Label.named('token_id'), CType.nat),
    LazyField(Label.named('approval_info'), () => ICRC37ApprovalInfo.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'token_id': tokenId,
    'approval_info': approvalInfo.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'token_id': tokenId,
    'approval_info': approvalInfo.toJson(),
  };

  factory ICRC37ApproveTokenArg.fromCandid(Map<String, dynamic> json) {
    return ICRC37ApproveTokenArg(
      tokenId: json.valueAsBigInt<BigInt>('token_id'),
      approvalInfo: json.valueTo<ICRC37ApprovalInfo, Map>(
        key: 'approval_info',
        parse:
            (e) => ICRC37ApprovalInfo.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICRC37ApproveTokenArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37ApproveTokenArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ApproveTokenResult`.
sealed class ICRC37ApproveTokenResult with CandidSerializable {
  const ICRC37ApproveTokenResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC37ApproveTokenError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC37ApproveTokenResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC37ApproveTokenResultOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC37ApproveTokenResultErr(
        json.valueTo<ICRC37ApproveTokenError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC37ApproveTokenError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC37ApproveTokenResult.fromCandid',
      reason: 'Unknown ICRC37ApproveTokenResult arm',
    );
  }

  factory ICRC37ApproveTokenResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37ApproveTokenResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ApproveTokenResult.Ok`.
final class ICRC37ApproveTokenResultOk extends ICRC37ApproveTokenResult {
  final BigInt value;
  const ICRC37ApproveTokenResultOk(this.value);

  @override
  CType get candidType => ICRC37ApproveTokenResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ApproveTokenResult.Err`.
final class ICRC37ApproveTokenResultErr extends ICRC37ApproveTokenResult {
  final ICRC37ApproveTokenError value;
  const ICRC37ApproveTokenResultErr(this.value);

  @override
  CType get candidType => ICRC37ApproveTokenResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `ApproveTokenError`.
sealed class ICRC37ApproveTokenError with CandidSerializable {
  const ICRC37ApproveTokenError();

  static CType get ctype => CType.variant([
    Field(Label.named('InvalidSpender'), CType.null_),
    Field(Label.named('Unauthorized'), CType.null_),
    Field(Label.named('NonExistingTokenId'), CType.null_),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
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

  factory ICRC37ApproveTokenError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('InvalidSpender')) {
      return const ICRC37ApproveTokenErrorInvalidSpender();
    }
    if (json.containsKey('Unauthorized')) {
      return const ICRC37ApproveTokenErrorUnauthorized();
    }
    if (json.containsKey('NonExistingTokenId')) {
      return const ICRC37ApproveTokenErrorNonExistingTokenId();
    }
    if (json.containsKey('TooOld')) {
      return const ICRC37ApproveTokenErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC37ApproveTokenErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC37ApproveTokenErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('GenericBatchError')) {
      return ICRC37ApproveTokenErrorGenericBatchError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericBatchError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC37ApproveTokenError.fromCandid',
      reason: 'Unknown ICRC37ApproveTokenError arm',
    );
  }

  factory ICRC37ApproveTokenError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37ApproveTokenError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ApproveTokenError.InvalidSpender` (nullary).
final class ICRC37ApproveTokenErrorInvalidSpender
    extends ICRC37ApproveTokenError {
  const ICRC37ApproveTokenErrorInvalidSpender();

  @override
  CType get candidType => ICRC37ApproveTokenError.ctype;

  @override
  dynamic get candidValue => const Variant('InvalidSpender', null);

  @override
  Map<String, dynamic> toJson() => {'InvalidSpender': null};
}

/// Variant arm `ApproveTokenError.Unauthorized` (nullary).
final class ICRC37ApproveTokenErrorUnauthorized
    extends ICRC37ApproveTokenError {
  const ICRC37ApproveTokenErrorUnauthorized();

  @override
  CType get candidType => ICRC37ApproveTokenError.ctype;

  @override
  dynamic get candidValue => const Variant('Unauthorized', null);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': null};
}

/// Variant arm `ApproveTokenError.NonExistingTokenId` (nullary).
final class ICRC37ApproveTokenErrorNonExistingTokenId
    extends ICRC37ApproveTokenError {
  const ICRC37ApproveTokenErrorNonExistingTokenId();

  @override
  CType get candidType => ICRC37ApproveTokenError.ctype;

  @override
  dynamic get candidValue => const Variant('NonExistingTokenId', null);

  @override
  Map<String, dynamic> toJson() => {'NonExistingTokenId': null};
}

/// Variant arm `ApproveTokenError.TooOld` (nullary).
final class ICRC37ApproveTokenErrorTooOld extends ICRC37ApproveTokenError {
  const ICRC37ApproveTokenErrorTooOld();

  @override
  CType get candidType => ICRC37ApproveTokenError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `ApproveTokenError.CreatedInFuture`.
final class ICRC37ApproveTokenErrorCreatedInFuture
    extends ICRC37ApproveTokenError {
  final BigInt ledgerTime;

  const ICRC37ApproveTokenErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC37ApproveTokenError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC37ApproveTokenErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37ApproveTokenErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `ApproveTokenError.GenericError`.
final class ICRC37ApproveTokenErrorGenericError
    extends ICRC37ApproveTokenError {
  final BigInt errorCode;
  final String message;

  const ICRC37ApproveTokenErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC37ApproveTokenError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC37ApproveTokenErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37ApproveTokenErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Variant arm `ApproveTokenError.GenericBatchError`.
final class ICRC37ApproveTokenErrorGenericBatchError
    extends ICRC37ApproveTokenError {
  final BigInt errorCode;
  final String message;

  const ICRC37ApproveTokenErrorGenericBatchError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC37ApproveTokenError.ctype;

  @override
  dynamic get candidValue => Variant('GenericBatchError', {
    'error_code': errorCode,
    'message': message,
  });

  @override
  Map<String, dynamic> toJson() => {
    'GenericBatchError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC37ApproveTokenErrorGenericBatchError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37ApproveTokenErrorGenericBatchError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `ApproveCollectionArg`.
final class ICRC37ApproveCollectionArg with CandidSerializable {
  final ICRC37ApprovalInfo approvalInfo;

  const ICRC37ApproveCollectionArg({required this.approvalInfo});

  static CType get ctype => CType.record([
    LazyField(Label.named('approval_info'), () => ICRC37ApprovalInfo.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'approval_info': approvalInfo.candidValue};

  Map<String, dynamic> toJson() => {'approval_info': approvalInfo.toJson()};

  factory ICRC37ApproveCollectionArg.fromCandid(Map<String, dynamic> json) {
    return ICRC37ApproveCollectionArg(
      approvalInfo: json.valueTo<ICRC37ApprovalInfo, Map>(
        key: 'approval_info',
        parse:
            (e) => ICRC37ApprovalInfo.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICRC37ApproveCollectionArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37ApproveCollectionArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ApproveCollectionResult`.
sealed class ICRC37ApproveCollectionResult with CandidSerializable {
  const ICRC37ApproveCollectionResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC37ApproveCollectionError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC37ApproveCollectionResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC37ApproveCollectionResultOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC37ApproveCollectionResultErr(
        json.valueTo<ICRC37ApproveCollectionError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC37ApproveCollectionError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC37ApproveCollectionResult.fromCandid',
      reason: 'Unknown ICRC37ApproveCollectionResult arm',
    );
  }

  factory ICRC37ApproveCollectionResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37ApproveCollectionResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ApproveCollectionResult.Ok`.
final class ICRC37ApproveCollectionResultOk
    extends ICRC37ApproveCollectionResult {
  final BigInt value;
  const ICRC37ApproveCollectionResultOk(this.value);

  @override
  CType get candidType => ICRC37ApproveCollectionResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `ApproveCollectionResult.Err`.
final class ICRC37ApproveCollectionResultErr
    extends ICRC37ApproveCollectionResult {
  final ICRC37ApproveCollectionError value;
  const ICRC37ApproveCollectionResultErr(this.value);

  @override
  CType get candidType => ICRC37ApproveCollectionResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `ApproveCollectionError`.
sealed class ICRC37ApproveCollectionError with CandidSerializable {
  const ICRC37ApproveCollectionError();

  static CType get ctype => CType.variant([
    Field(Label.named('InvalidSpender'), CType.null_),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
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

  factory ICRC37ApproveCollectionError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('InvalidSpender')) {
      return const ICRC37ApproveCollectionErrorInvalidSpender();
    }
    if (json.containsKey('TooOld')) {
      return const ICRC37ApproveCollectionErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC37ApproveCollectionErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC37ApproveCollectionErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('GenericBatchError')) {
      return ICRC37ApproveCollectionErrorGenericBatchError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericBatchError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC37ApproveCollectionError.fromCandid',
      reason: 'Unknown ICRC37ApproveCollectionError arm',
    );
  }

  factory ICRC37ApproveCollectionError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37ApproveCollectionError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ApproveCollectionError.InvalidSpender` (nullary).
final class ICRC37ApproveCollectionErrorInvalidSpender
    extends ICRC37ApproveCollectionError {
  const ICRC37ApproveCollectionErrorInvalidSpender();

  @override
  CType get candidType => ICRC37ApproveCollectionError.ctype;

  @override
  dynamic get candidValue => const Variant('InvalidSpender', null);

  @override
  Map<String, dynamic> toJson() => {'InvalidSpender': null};
}

/// Variant arm `ApproveCollectionError.TooOld` (nullary).
final class ICRC37ApproveCollectionErrorTooOld
    extends ICRC37ApproveCollectionError {
  const ICRC37ApproveCollectionErrorTooOld();

  @override
  CType get candidType => ICRC37ApproveCollectionError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `ApproveCollectionError.CreatedInFuture`.
final class ICRC37ApproveCollectionErrorCreatedInFuture
    extends ICRC37ApproveCollectionError {
  final BigInt ledgerTime;

  const ICRC37ApproveCollectionErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC37ApproveCollectionError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC37ApproveCollectionErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37ApproveCollectionErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `ApproveCollectionError.GenericError`.
final class ICRC37ApproveCollectionErrorGenericError
    extends ICRC37ApproveCollectionError {
  final BigInt errorCode;
  final String message;

  const ICRC37ApproveCollectionErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC37ApproveCollectionError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC37ApproveCollectionErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37ApproveCollectionErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Variant arm `ApproveCollectionError.GenericBatchError`.
final class ICRC37ApproveCollectionErrorGenericBatchError
    extends ICRC37ApproveCollectionError {
  final BigInt errorCode;
  final String message;

  const ICRC37ApproveCollectionErrorGenericBatchError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC37ApproveCollectionError.ctype;

  @override
  dynamic get candidValue => Variant('GenericBatchError', {
    'error_code': errorCode,
    'message': message,
  });

  @override
  Map<String, dynamic> toJson() => {
    'GenericBatchError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC37ApproveCollectionErrorGenericBatchError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37ApproveCollectionErrorGenericBatchError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `RevokeTokenApprovalArg`.
final class ICRC37RevokeTokenApprovalArg with CandidSerializable {
  final ICRC37Account? spender;
  final List<int>? fromSubaccount;
  final BigInt tokenId;
  final List<int>? memo;
  final BigInt? createdAtTime;

  const ICRC37RevokeTokenApprovalArg({
    this.spender,
    this.fromSubaccount,
    required this.tokenId,
    this.memo,
    this.createdAtTime,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('spender'), () => CType.opt(ICRC37Account.ctype)),
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('token_id'), CType.nat),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'spender': spender?.candidValue,
    'from_subaccount': fromSubaccount,
    'token_id': tokenId,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'spender': spender?.toJson(),
    'from_subaccount': fromSubaccount,
    'token_id': tokenId,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  factory ICRC37RevokeTokenApprovalArg.fromCandid(Map<String, dynamic> json) {
    return ICRC37RevokeTokenApprovalArg(
      spender: json.valueTo<ICRC37Account?, Map>(
        key: 'spender',
        parse:
            (e) => ICRC37Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      tokenId: json.valueAsBigInt<BigInt>('token_id'),
      memo: json.valueAsBytes<List<int>?>(
        'memo',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
    );
  }

  factory ICRC37RevokeTokenApprovalArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37RevokeTokenApprovalArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `RevokeTokenApprovalResponse`.
sealed class ICRC37RevokeTokenApprovalResponse with CandidSerializable {
  const ICRC37RevokeTokenApprovalResponse();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC37RevokeTokenApprovalError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC37RevokeTokenApprovalResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return ICRC37RevokeTokenApprovalResponseOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return ICRC37RevokeTokenApprovalResponseErr(
        json.valueTo<ICRC37RevokeTokenApprovalError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC37RevokeTokenApprovalError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC37RevokeTokenApprovalResponse.fromCandid',
      reason: 'Unknown ICRC37RevokeTokenApprovalResponse arm',
    );
  }

  factory ICRC37RevokeTokenApprovalResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37RevokeTokenApprovalResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `RevokeTokenApprovalResponse.Ok`.
final class ICRC37RevokeTokenApprovalResponseOk
    extends ICRC37RevokeTokenApprovalResponse {
  final BigInt value;
  const ICRC37RevokeTokenApprovalResponseOk(this.value);

  @override
  CType get candidType => ICRC37RevokeTokenApprovalResponse.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `RevokeTokenApprovalResponse.Err`.
final class ICRC37RevokeTokenApprovalResponseErr
    extends ICRC37RevokeTokenApprovalResponse {
  final ICRC37RevokeTokenApprovalError value;
  const ICRC37RevokeTokenApprovalResponseErr(this.value);

  @override
  CType get candidType => ICRC37RevokeTokenApprovalResponse.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `RevokeTokenApprovalError`.
sealed class ICRC37RevokeTokenApprovalError with CandidSerializable {
  const ICRC37RevokeTokenApprovalError();

  static CType get ctype => CType.variant([
    Field(Label.named('ApprovalDoesNotExist'), CType.null_),
    Field(Label.named('Unauthorized'), CType.null_),
    Field(Label.named('NonExistingTokenId'), CType.null_),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
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

  factory ICRC37RevokeTokenApprovalError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('ApprovalDoesNotExist')) {
      return const ICRC37RevokeTokenApprovalErrorApprovalDoesNotExist();
    }
    if (json.containsKey('Unauthorized')) {
      return const ICRC37RevokeTokenApprovalErrorUnauthorized();
    }
    if (json.containsKey('NonExistingTokenId')) {
      return const ICRC37RevokeTokenApprovalErrorNonExistingTokenId();
    }
    if (json.containsKey('TooOld')) {
      return const ICRC37RevokeTokenApprovalErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC37RevokeTokenApprovalErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC37RevokeTokenApprovalErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('GenericBatchError')) {
      return ICRC37RevokeTokenApprovalErrorGenericBatchError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericBatchError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC37RevokeTokenApprovalError.fromCandid',
      reason: 'Unknown ICRC37RevokeTokenApprovalError arm',
    );
  }

  factory ICRC37RevokeTokenApprovalError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37RevokeTokenApprovalError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `RevokeTokenApprovalError.ApprovalDoesNotExist` (nullary).
final class ICRC37RevokeTokenApprovalErrorApprovalDoesNotExist
    extends ICRC37RevokeTokenApprovalError {
  const ICRC37RevokeTokenApprovalErrorApprovalDoesNotExist();

  @override
  CType get candidType => ICRC37RevokeTokenApprovalError.ctype;

  @override
  dynamic get candidValue => const Variant('ApprovalDoesNotExist', null);

  @override
  Map<String, dynamic> toJson() => {'ApprovalDoesNotExist': null};
}

/// Variant arm `RevokeTokenApprovalError.Unauthorized` (nullary).
final class ICRC37RevokeTokenApprovalErrorUnauthorized
    extends ICRC37RevokeTokenApprovalError {
  const ICRC37RevokeTokenApprovalErrorUnauthorized();

  @override
  CType get candidType => ICRC37RevokeTokenApprovalError.ctype;

  @override
  dynamic get candidValue => const Variant('Unauthorized', null);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': null};
}

/// Variant arm `RevokeTokenApprovalError.NonExistingTokenId` (nullary).
final class ICRC37RevokeTokenApprovalErrorNonExistingTokenId
    extends ICRC37RevokeTokenApprovalError {
  const ICRC37RevokeTokenApprovalErrorNonExistingTokenId();

  @override
  CType get candidType => ICRC37RevokeTokenApprovalError.ctype;

  @override
  dynamic get candidValue => const Variant('NonExistingTokenId', null);

  @override
  Map<String, dynamic> toJson() => {'NonExistingTokenId': null};
}

/// Variant arm `RevokeTokenApprovalError.TooOld` (nullary).
final class ICRC37RevokeTokenApprovalErrorTooOld
    extends ICRC37RevokeTokenApprovalError {
  const ICRC37RevokeTokenApprovalErrorTooOld();

  @override
  CType get candidType => ICRC37RevokeTokenApprovalError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `RevokeTokenApprovalError.CreatedInFuture`.
final class ICRC37RevokeTokenApprovalErrorCreatedInFuture
    extends ICRC37RevokeTokenApprovalError {
  final BigInt ledgerTime;

  const ICRC37RevokeTokenApprovalErrorCreatedInFuture({
    required this.ledgerTime,
  });

  @override
  CType get candidType => ICRC37RevokeTokenApprovalError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC37RevokeTokenApprovalErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37RevokeTokenApprovalErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `RevokeTokenApprovalError.GenericError`.
final class ICRC37RevokeTokenApprovalErrorGenericError
    extends ICRC37RevokeTokenApprovalError {
  final BigInt errorCode;
  final String message;

  const ICRC37RevokeTokenApprovalErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC37RevokeTokenApprovalError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC37RevokeTokenApprovalErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37RevokeTokenApprovalErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Variant arm `RevokeTokenApprovalError.GenericBatchError`.
final class ICRC37RevokeTokenApprovalErrorGenericBatchError
    extends ICRC37RevokeTokenApprovalError {
  final BigInt errorCode;
  final String message;

  const ICRC37RevokeTokenApprovalErrorGenericBatchError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC37RevokeTokenApprovalError.ctype;

  @override
  dynamic get candidValue => Variant('GenericBatchError', {
    'error_code': errorCode,
    'message': message,
  });

  @override
  Map<String, dynamic> toJson() => {
    'GenericBatchError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC37RevokeTokenApprovalErrorGenericBatchError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37RevokeTokenApprovalErrorGenericBatchError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `RevokeCollectionApprovalArg`.
final class ICRC37RevokeCollectionApprovalArg with CandidSerializable {
  final ICRC37Account? spender;
  final List<int>? fromSubaccount;
  final List<int>? memo;
  final BigInt? createdAtTime;

  const ICRC37RevokeCollectionApprovalArg({
    this.spender,
    this.fromSubaccount,
    this.memo,
    this.createdAtTime,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('spender'), () => CType.opt(ICRC37Account.ctype)),
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('memo'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('created_at_time'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'spender': spender?.candidValue,
    'from_subaccount': fromSubaccount,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'spender': spender?.toJson(),
    'from_subaccount': fromSubaccount,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  factory ICRC37RevokeCollectionApprovalArg.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37RevokeCollectionApprovalArg(
      spender: json.valueTo<ICRC37Account?, Map>(
        key: 'spender',
        parse:
            (e) => ICRC37Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      memo: json.valueAsBytes<List<int>?>(
        'memo',
        encoding: StringEncoding.base64,
      ),
      createdAtTime: json.valueAsBigInt<BigInt?>('created_at_time'),
    );
  }

  factory ICRC37RevokeCollectionApprovalArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37RevokeCollectionApprovalArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `RevokeCollectionApprovalResult`.
sealed class ICRC37RevokeCollectionApprovalResult with CandidSerializable {
  const ICRC37RevokeCollectionApprovalResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(
      Label.named('Err'),
      () => ICRC37RevokeCollectionApprovalError.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC37RevokeCollectionApprovalResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('Ok')) {
      return ICRC37RevokeCollectionApprovalResultOk(
        json.valueAsBigInt<BigInt>('Ok'),
      );
    }
    if (json.containsKey('Err')) {
      return ICRC37RevokeCollectionApprovalResultErr(
        json.valueTo<ICRC37RevokeCollectionApprovalError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC37RevokeCollectionApprovalError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC37RevokeCollectionApprovalResult.fromCandid',
      reason: 'Unknown ICRC37RevokeCollectionApprovalResult arm',
    );
  }

  factory ICRC37RevokeCollectionApprovalResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37RevokeCollectionApprovalResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `RevokeCollectionApprovalResult.Ok`.
final class ICRC37RevokeCollectionApprovalResultOk
    extends ICRC37RevokeCollectionApprovalResult {
  final BigInt value;
  const ICRC37RevokeCollectionApprovalResultOk(this.value);

  @override
  CType get candidType => ICRC37RevokeCollectionApprovalResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `RevokeCollectionApprovalResult.Err`.
final class ICRC37RevokeCollectionApprovalResultErr
    extends ICRC37RevokeCollectionApprovalResult {
  final ICRC37RevokeCollectionApprovalError value;
  const ICRC37RevokeCollectionApprovalResultErr(this.value);

  @override
  CType get candidType => ICRC37RevokeCollectionApprovalResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `RevokeCollectionApprovalError`.
sealed class ICRC37RevokeCollectionApprovalError with CandidSerializable {
  const ICRC37RevokeCollectionApprovalError();

  static CType get ctype => CType.variant([
    Field(Label.named('ApprovalDoesNotExist'), CType.null_),
    Field(Label.named('TooOld'), CType.null_),
    Field(
      Label.named('CreatedInFuture'),
      CType.record([Field(Label.named('ledger_time'), CType.nat64)]),
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

  factory ICRC37RevokeCollectionApprovalError.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('ApprovalDoesNotExist')) {
      return const ICRC37RevokeCollectionApprovalErrorApprovalDoesNotExist();
    }
    if (json.containsKey('TooOld')) {
      return const ICRC37RevokeCollectionApprovalErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC37RevokeCollectionApprovalErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC37RevokeCollectionApprovalErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('GenericBatchError')) {
      return ICRC37RevokeCollectionApprovalErrorGenericBatchError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericBatchError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC37RevokeCollectionApprovalError.fromCandid',
      reason: 'Unknown ICRC37RevokeCollectionApprovalError arm',
    );
  }

  factory ICRC37RevokeCollectionApprovalError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37RevokeCollectionApprovalError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `RevokeCollectionApprovalError.ApprovalDoesNotExist` (nullary).
final class ICRC37RevokeCollectionApprovalErrorApprovalDoesNotExist
    extends ICRC37RevokeCollectionApprovalError {
  const ICRC37RevokeCollectionApprovalErrorApprovalDoesNotExist();

  @override
  CType get candidType => ICRC37RevokeCollectionApprovalError.ctype;

  @override
  dynamic get candidValue => const Variant('ApprovalDoesNotExist', null);

  @override
  Map<String, dynamic> toJson() => {'ApprovalDoesNotExist': null};
}

/// Variant arm `RevokeCollectionApprovalError.TooOld` (nullary).
final class ICRC37RevokeCollectionApprovalErrorTooOld
    extends ICRC37RevokeCollectionApprovalError {
  const ICRC37RevokeCollectionApprovalErrorTooOld();

  @override
  CType get candidType => ICRC37RevokeCollectionApprovalError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `RevokeCollectionApprovalError.CreatedInFuture`.
final class ICRC37RevokeCollectionApprovalErrorCreatedInFuture
    extends ICRC37RevokeCollectionApprovalError {
  final BigInt ledgerTime;

  const ICRC37RevokeCollectionApprovalErrorCreatedInFuture({
    required this.ledgerTime,
  });

  @override
  CType get candidType => ICRC37RevokeCollectionApprovalError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC37RevokeCollectionApprovalErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37RevokeCollectionApprovalErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `RevokeCollectionApprovalError.GenericError`.
final class ICRC37RevokeCollectionApprovalErrorGenericError
    extends ICRC37RevokeCollectionApprovalError {
  final BigInt errorCode;
  final String message;

  const ICRC37RevokeCollectionApprovalErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC37RevokeCollectionApprovalError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC37RevokeCollectionApprovalErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37RevokeCollectionApprovalErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Variant arm `RevokeCollectionApprovalError.GenericBatchError`.
final class ICRC37RevokeCollectionApprovalErrorGenericBatchError
    extends ICRC37RevokeCollectionApprovalError {
  final BigInt errorCode;
  final String message;

  const ICRC37RevokeCollectionApprovalErrorGenericBatchError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC37RevokeCollectionApprovalError.ctype;

  @override
  dynamic get candidValue => Variant('GenericBatchError', {
    'error_code': errorCode,
    'message': message,
  });

  @override
  Map<String, dynamic> toJson() => {
    'GenericBatchError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC37RevokeCollectionApprovalErrorGenericBatchError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37RevokeCollectionApprovalErrorGenericBatchError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Candid record `IsApprovedArg`.
final class ICRC37IsApprovedArg with CandidSerializable {
  final ICRC37Account spender;
  final List<int>? fromSubaccount;
  final BigInt tokenId;

  const ICRC37IsApprovedArg({
    required this.spender,
    this.fromSubaccount,
    required this.tokenId,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('spender'), () => ICRC37Account.ctype),
    Field(Label.named('from_subaccount'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('token_id'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'spender': spender.candidValue,
    'from_subaccount': fromSubaccount,
    'token_id': tokenId,
  };

  Map<String, dynamic> toJson() => {
    'spender': spender.toJson(),
    'from_subaccount': fromSubaccount,
    'token_id': tokenId,
  };

  factory ICRC37IsApprovedArg.fromCandid(Map<String, dynamic> json) {
    return ICRC37IsApprovedArg(
      spender: json.valueTo<ICRC37Account, Map>(
        key: 'spender',
        parse:
            (e) => ICRC37Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      fromSubaccount: json.valueAsBytes<List<int>?>(
        'from_subaccount',
        encoding: StringEncoding.base64,
      ),
      tokenId: json.valueAsBigInt<BigInt>('token_id'),
    );
  }

  factory ICRC37IsApprovedArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37IsApprovedArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TokenApproval`.
final class ICRC37TokenApproval with CandidSerializable {
  final BigInt tokenId;
  final ICRC37ApprovalInfo approvalInfo;

  const ICRC37TokenApproval({
    required this.tokenId,
    required this.approvalInfo,
  });

  static CType get ctype => CType.record([
    Field(Label.named('token_id'), CType.nat),
    LazyField(Label.named('approval_info'), () => ICRC37ApprovalInfo.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'token_id': tokenId,
    'approval_info': approvalInfo.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'token_id': tokenId,
    'approval_info': approvalInfo.toJson(),
  };

  factory ICRC37TokenApproval.fromCandid(Map<String, dynamic> json) {
    return ICRC37TokenApproval(
      tokenId: json.valueAsBigInt<BigInt>('token_id'),
      approvalInfo: json.valueTo<ICRC37ApprovalInfo, Map>(
        key: 'approval_info',
        parse:
            (e) => ICRC37ApprovalInfo.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICRC37TokenApproval.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37TokenApproval.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `TransferFromArg`.
final class ICRC37TransferFromArg with CandidSerializable {
  final List<int>? spenderSubaccount;
  final ICRC37Account from;
  final ICRC37Account to;
  final BigInt tokenId;
  final List<int>? memo;
  final BigInt? createdAtTime;

  const ICRC37TransferFromArg({
    this.spenderSubaccount,
    required this.from,
    required this.to,
    required this.tokenId,
    this.memo,
    this.createdAtTime,
  });

  static CType get ctype => CType.record([
    Field(Label.named('spender_subaccount'), CType.opt(CType.vec(CType.nat8))),
    LazyField(Label.named('from'), () => ICRC37Account.ctype),
    LazyField(Label.named('to'), () => ICRC37Account.ctype),
    Field(Label.named('token_id'), CType.nat),
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
    'token_id': tokenId,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  Map<String, dynamic> toJson() => {
    'spender_subaccount': spenderSubaccount,
    'from': from.toJson(),
    'to': to.toJson(),
    'token_id': tokenId,
    'memo': memo,
    'created_at_time': createdAtTime,
  };

  factory ICRC37TransferFromArg.fromCandid(Map<String, dynamic> json) {
    return ICRC37TransferFromArg(
      spenderSubaccount: json.valueAsBytes<List<int>?>(
        'spender_subaccount',
        encoding: StringEncoding.base64,
      ),
      from: json.valueTo<ICRC37Account, Map>(
        key: 'from',
        parse:
            (e) => ICRC37Account.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      to: json.valueTo<ICRC37Account, Map>(
        key: 'to',
        parse:
            (e) => ICRC37Account.fromCandid(
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

  factory ICRC37TransferFromArg.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37TransferFromArg.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `TransferFromResult`.
sealed class ICRC37TransferFromResult with CandidSerializable {
  const ICRC37TransferFromResult();

  static CType get ctype => CType.variant([
    Field(Label.named('Ok'), CType.nat),
    LazyField(Label.named('Err'), () => ICRC37TransferFromError.ctype),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC37TransferFromResult.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Ok')) {
      return ICRC37TransferFromResultOk(json.valueAsBigInt<BigInt>('Ok'));
    }
    if (json.containsKey('Err')) {
      return ICRC37TransferFromResultErr(
        json.valueTo<ICRC37TransferFromError, Map>(
          key: 'Err',
          parse:
              (e) => ICRC37TransferFromError.fromCandid(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC37TransferFromResult.fromCandid',
      reason: 'Unknown ICRC37TransferFromResult arm',
    );
  }

  factory ICRC37TransferFromResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37TransferFromResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferFromResult.Ok`.
final class ICRC37TransferFromResultOk extends ICRC37TransferFromResult {
  final BigInt value;
  const ICRC37TransferFromResultOk(this.value);

  @override
  CType get candidType => ICRC37TransferFromResult.ctype;

  @override
  dynamic get candidValue => Variant('Ok', value);

  @override
  Map<String, dynamic> toJson() => {'Ok': value};
}

/// Variant arm `TransferFromResult.Err`.
final class ICRC37TransferFromResultErr extends ICRC37TransferFromResult {
  final ICRC37TransferFromError value;
  const ICRC37TransferFromResultErr(this.value);

  @override
  CType get candidType => ICRC37TransferFromResult.ctype;

  @override
  dynamic get candidValue => Variant('Err', value.candidValue);

  @override
  Map<String, dynamic> toJson() => {'Err': value.toJson()};
}

/// Candid variant `TransferFromError`.
sealed class ICRC37TransferFromError with CandidSerializable {
  const ICRC37TransferFromError();

  static CType get ctype => CType.variant([
    Field(Label.named('InvalidRecipient'), CType.null_),
    Field(Label.named('Unauthorized'), CType.null_),
    Field(Label.named('NonExistingTokenId'), CType.null_),
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

  factory ICRC37TransferFromError.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('InvalidRecipient')) {
      return const ICRC37TransferFromErrorInvalidRecipient();
    }
    if (json.containsKey('Unauthorized')) {
      return const ICRC37TransferFromErrorUnauthorized();
    }
    if (json.containsKey('NonExistingTokenId')) {
      return const ICRC37TransferFromErrorNonExistingTokenId();
    }
    if (json.containsKey('TooOld')) {
      return const ICRC37TransferFromErrorTooOld();
    }
    if (json.containsKey('CreatedInFuture')) {
      return ICRC37TransferFromErrorCreatedInFuture.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['CreatedInFuture']),
      );
    }
    if (json.containsKey('Duplicate')) {
      return ICRC37TransferFromErrorDuplicate.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['Duplicate']),
      );
    }
    if (json.containsKey('GenericError')) {
      return ICRC37TransferFromErrorGenericError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericError']),
      );
    }
    if (json.containsKey('GenericBatchError')) {
      return ICRC37TransferFromErrorGenericBatchError.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['GenericBatchError']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC37TransferFromError.fromCandid',
      reason: 'Unknown ICRC37TransferFromError arm',
    );
  }

  factory ICRC37TransferFromError.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC37TransferFromError.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `TransferFromError.InvalidRecipient` (nullary).
final class ICRC37TransferFromErrorInvalidRecipient
    extends ICRC37TransferFromError {
  const ICRC37TransferFromErrorInvalidRecipient();

  @override
  CType get candidType => ICRC37TransferFromError.ctype;

  @override
  dynamic get candidValue => const Variant('InvalidRecipient', null);

  @override
  Map<String, dynamic> toJson() => {'InvalidRecipient': null};
}

/// Variant arm `TransferFromError.Unauthorized` (nullary).
final class ICRC37TransferFromErrorUnauthorized
    extends ICRC37TransferFromError {
  const ICRC37TransferFromErrorUnauthorized();

  @override
  CType get candidType => ICRC37TransferFromError.ctype;

  @override
  dynamic get candidValue => const Variant('Unauthorized', null);

  @override
  Map<String, dynamic> toJson() => {'Unauthorized': null};
}

/// Variant arm `TransferFromError.NonExistingTokenId` (nullary).
final class ICRC37TransferFromErrorNonExistingTokenId
    extends ICRC37TransferFromError {
  const ICRC37TransferFromErrorNonExistingTokenId();

  @override
  CType get candidType => ICRC37TransferFromError.ctype;

  @override
  dynamic get candidValue => const Variant('NonExistingTokenId', null);

  @override
  Map<String, dynamic> toJson() => {'NonExistingTokenId': null};
}

/// Variant arm `TransferFromError.TooOld` (nullary).
final class ICRC37TransferFromErrorTooOld extends ICRC37TransferFromError {
  const ICRC37TransferFromErrorTooOld();

  @override
  CType get candidType => ICRC37TransferFromError.ctype;

  @override
  dynamic get candidValue => const Variant('TooOld', null);

  @override
  Map<String, dynamic> toJson() => {'TooOld': null};
}

/// Variant arm `TransferFromError.CreatedInFuture`.
final class ICRC37TransferFromErrorCreatedInFuture
    extends ICRC37TransferFromError {
  final BigInt ledgerTime;

  const ICRC37TransferFromErrorCreatedInFuture({required this.ledgerTime});

  @override
  CType get candidType => ICRC37TransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('CreatedInFuture', {'ledger_time': ledgerTime});

  @override
  Map<String, dynamic> toJson() => {
    'CreatedInFuture': {'ledger_time': ledgerTime},
  };

  factory ICRC37TransferFromErrorCreatedInFuture.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37TransferFromErrorCreatedInFuture(
      ledgerTime: json.valueAsBigInt<BigInt>('ledger_time'),
    );
  }
}

/// Variant arm `TransferFromError.Duplicate`.
final class ICRC37TransferFromErrorDuplicate extends ICRC37TransferFromError {
  final BigInt duplicateOf;

  const ICRC37TransferFromErrorDuplicate({required this.duplicateOf});

  @override
  CType get candidType => ICRC37TransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('Duplicate', {'duplicate_of': duplicateOf});

  @override
  Map<String, dynamic> toJson() => {
    'Duplicate': {'duplicate_of': duplicateOf},
  };

  factory ICRC37TransferFromErrorDuplicate.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37TransferFromErrorDuplicate(
      duplicateOf: json.valueAsBigInt<BigInt>('duplicate_of'),
    );
  }
}

/// Variant arm `TransferFromError.GenericError`.
final class ICRC37TransferFromErrorGenericError
    extends ICRC37TransferFromError {
  final BigInt errorCode;
  final String message;

  const ICRC37TransferFromErrorGenericError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC37TransferFromError.ctype;

  @override
  dynamic get candidValue =>
      Variant('GenericError', {'error_code': errorCode, 'message': message});

  @override
  Map<String, dynamic> toJson() => {
    'GenericError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC37TransferFromErrorGenericError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37TransferFromErrorGenericError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

/// Variant arm `TransferFromError.GenericBatchError`.
final class ICRC37TransferFromErrorGenericBatchError
    extends ICRC37TransferFromError {
  final BigInt errorCode;
  final String message;

  const ICRC37TransferFromErrorGenericBatchError({
    required this.errorCode,
    required this.message,
  });

  @override
  CType get candidType => ICRC37TransferFromError.ctype;

  @override
  dynamic get candidValue => Variant('GenericBatchError', {
    'error_code': errorCode,
    'message': message,
  });

  @override
  Map<String, dynamic> toJson() => {
    'GenericBatchError': {'error_code': errorCode, 'message': message},
  };

  factory ICRC37TransferFromErrorGenericBatchError.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC37TransferFromErrorGenericBatchError(
      errorCode: json.valueAsBigInt<BigInt>('error_code'),
      message: json.valueAsString<String>('message'),
    );
  }
}

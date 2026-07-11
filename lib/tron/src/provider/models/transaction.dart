import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solidity/solidity.dart';
import 'package:on_chain/tron/src/exception/exception.dart';
import 'package:on_chain/tron/src/models/models.dart';

enum TronResultCode {
  sucess("SUCESS"),
  failed("FAILED");

  final String value;
  const TronResultCode(this.value);
  static TronResultCode fromValue(String value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw TronPluginException("Invalid TronResultCode name"),
    );
  }
}

enum TronContractResult {
  defaultResult("DEFAULT"), // 0
  success("SUCCESS"), // 1
  revert("REVERT"), // 2
  badJumpDestination("BAD_JUMP_DESTINATION"), // 3
  outOfMemory("OUT_OF_MEMORY"), // 4
  precompiledContract("PRECOMPILED_CONTRACT"), // 5
  stackTooSmall("STACK_TOO_SMALL"), // 6
  stackTooLarge("STACK_TOO_LARGE"), // 7
  illegalOperation("ILLEGAL_OPERATION"), // 8
  stackOverflow("STACK_OVERFLOW"), // 9
  outOfEnergy("OUT_OF_ENERGY"), // 10
  outOfTime("OUT_OF_TIME"), // 11
  jvmStackOverflow("JVM_STACK_OVER_FLOW"), // 12
  unknown("UNKNOWN"), // 13
  transferFailed("TRANSFER_FAILED"), // 14
  invalidCode("INVALID_CODE"); // 15

  final String value;
  const TronContractResult(this.value);
  static TronContractResult fromValue(String value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw TronPluginException("Invalid TronContractResult name"),
    );
  }
}

class TronTransactionExtention {
  final TronTransactionWithResult? transaction;
  final List<String> constantResult;
  final int? energyUsed;
  final BigInt? energyPenalty;
  final TronReturn result;
  final AbiFunctionFragment? fragment;

  List<dynamic>? get outputResult {
    if (fragment == null || constantResult.length != 1) return null;
    return fragment!.decodeOutputHex(constantResult[0]);
  }

  bool get isSuccess =>
      result.result &&
      transaction != null &&
      !transaction!.ret.any(
        (e) =>
            e.ret == TronResultCode.failed ||
            (e.contractRet != null &&
                e.contractRet != TronContractResult.success),
      );
  String? get error => result.message;
  const TronTransactionExtention({
    required this.transaction,
    required this.constantResult,
    required this.energyUsed,
    required this.energyPenalty,
    required this.result,
    this.fragment,
  });
  factory TronTransactionExtention.fromJson(
    Map<String, dynamic> json, {
    AbiFunctionFragment? fragment,
  }) {
    return TronTransactionExtention(
      transaction:
          json["transaction"] == null
              ? null
              : TronTransactionWithResult.fromJson(
                json.valueEnsureAsMap<String, dynamic>("transaction"),
              ),
      constantResult: json.valueAsList<List<String>?>("constant_result") ?? [],
      energyUsed: json.valueAsInt("energy_used"),
      energyPenalty: json.valueAsBigInt("energy_penalty"),
      result: TronReturn.fromJson(
        json.valueEnsureAsMap<String, dynamic>("result"),
      ),
      fragment: fragment,
    );
  }
}

class TronTransactionWithResult {
  final TransactionRaw rawData;
  final List<String> signature;
  final List<TronResult> ret;
  final String? rawDatahex;

  Map<String, dynamic> toJson() {
    return {
      "raw_data": rawData.toJson(),
      "signature": signature,
      "ret": ret.map((e) => e.toJson()).toList(),
      "raw_data_hex": rawDatahex,
    };
  }

  /// Create a new [Transaction] instance with specified parameters.
  TronTransactionWithResult({
    required this.rawData,
    required List<String> signature,
    required List<TronResult> ret,
    this.rawDatahex,
  }) : signature = signature.immutable,
       ret = ret.immutable;

  factory TronTransactionWithResult.fromJson(Map<String, dynamic> json) {
    return TronTransactionWithResult(
      rawData: TransactionRaw.fromJson(json['raw_data']),
      signature: json.valueAsList<List<String>?>("signature") ?? [],
      rawDatahex: json.valueAs("raw_data_hex"),
      ret:
          json
              .valueAsList<List<Map<String, dynamic>>?>('ret')
              ?.where((e) => e.isNotEmpty)
              .map((e) => TronResult.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class TronResult {
  final BigInt? fee;
  final TronResultCode? ret;
  final TronContractResult? contractRet;

  final String? assetIssueID;
  final BigInt? withdrawAmount;
  final BigInt? unfreezeAmount;
  final BigInt? exchangeReceivedAmount;
  final BigInt? exchangeInjectAnotherAmount;
  final BigInt? exchangeWithdrawAnotherAmount;
  final BigInt? exchangeId;
  final BigInt? shieldedTransactionFee;

  final BigInt? withdrawExpireAmount;
  final Map<String, BigInt>? cancelUnfreezeV2Amount;

  const TronResult({
    this.fee,
    this.ret,
    this.contractRet,
    this.assetIssueID,
    this.withdrawAmount,
    this.unfreezeAmount,
    this.exchangeReceivedAmount,
    this.exchangeInjectAnotherAmount,
    this.exchangeWithdrawAnotherAmount,
    this.exchangeId,
    this.shieldedTransactionFee,
    this.withdrawExpireAmount,
    this.cancelUnfreezeV2Amount,
  });

  factory TronResult.fromJson(Map<String, dynamic> json) {
    return TronResult(
      fee: json.valueAsBigInt("fee"),
      ret: json["ret"] == null ? null : TronResultCode.fromValue(json['ret']),
      contractRet:
          json["contractRet"] == null
              ? null
              : TronContractResult.fromValue(json.valueAs("contractRet")),
      assetIssueID: json.valueAs("assetIssueID"),
      withdrawAmount: json.valueAsBigInt("withdraw_amount"),
      unfreezeAmount: json.valueAsBigInt("unfreeze_amount"),
      exchangeReceivedAmount: json.valueAsBigInt("exchange_received_amount"),
      exchangeInjectAnotherAmount: json.valueAsBigInt(
        "exchange_inject_another_amount",
      ),
      exchangeWithdrawAnotherAmount: json.valueAsBigInt(
        "exchange_withdraw_another_amount",
      ),
      exchangeId: json.valueAsBigInt("exchange_id"),
      shieldedTransactionFee: json.valueAsBigInt("shielded_transaction_fee"),
      withdrawExpireAmount: json['withdraw_expire_amount'],
      cancelUnfreezeV2Amount: (json['cancel_unfreezeV2_amount'] as Map?)?.map(
        (k, v) => MapEntry(k.toString(), BigintUtils.parse(v)),
      ),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "fee": fee?.toString(),
      "ret": ret?.value,
      "assetIssueID": assetIssueID,
      "withdraw_amount": withdrawAmount?.toString(),
      "contractRet": contractRet?.value,
      "unfreeze_amount": unfreezeAmount?.toString(),
      "exchange_received_amount": exchangeReceivedAmount?.toString(),
      "exchange_inject_another_amount": exchangeInjectAnotherAmount?.toString(),
      "exchange_withdraw_another_amount":
          exchangeWithdrawAnotherAmount?.toString(),
      "exchange_id": exchangeId?.toString(),
      "shielded_transaction_fee": shieldedTransactionFee?.toString(),
      "withdraw_expire_amount": withdrawExpireAmount?.toString(),
      "cancel_unfreezeV2_amount": cancelUnfreezeV2Amount?.map(
        (k, v) => MapEntry(k, v.toString()),
      ),
    };
  }
}

enum TronResponseCode {
  success("SUCCESS"),
  sigError("SIGERROR"),
  contractValidateError("CONTRACT_VALIDATE_ERROR"),
  contractExeError("CONTRACT_EXE_ERROR"),
  bandwidthError("BANDWITH_ERROR"),
  dupTransactionError("DUP_TRANSACTION_ERROR"),
  taposError("TAPOS_ERROR"),
  tooBigTransactionError("TOO_BIG_TRANSACTION_ERROR"),
  transactionExpirationError("TRANSACTION_EXPIRATION_ERROR"),
  serverBusy("SERVER_BUSY"),
  noConnection("NO_CONNECTION"),
  notEnoughEffectiveConnection("NOT_ENOUGH_EFFECTIVE_CONNECTION"),
  blockUnsolidified("BLOCK_UNSOLIDIFIED"),
  otherError("OTHER_ERROR");

  final String value;
  const TronResponseCode(this.value);

  static TronResponseCode fromValue(String value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ItemNotFoundException(name: "TronResponseCode"),
    );
  }
}

class TronReturn {
  final bool result;
  final TronResponseCode? code;
  final String? message;

  const TronReturn({required this.result, this.code, this.message});

  factory TronReturn.fromJson(Map<String, dynamic> json) {
    return TronReturn(
      result: json.valueAs<bool?>("result") ?? false,
      code:
          json['code'] != null
              ? TronResponseCode.fromValue(json.valueAs("code"))
              : null,
      message: json.valueAs("message"),
    );
  }
}

class TronBroadcastHexResponse {
  final bool result;
  final String txid;
  final String? code;
  final String? message;
  final Map<String, dynamic> transaction;
  TronBroadcastHexResponse({
    required this.result,
    required this.code,
    required this.message,
    required this.transaction,
    required this.txid,
  });
  factory TronBroadcastHexResponse.fromJson(Map<String, dynamic> json) {
    return TronBroadcastHexResponse(
      code: json.valueAs("code"),
      message: json.valueAs("message"),
      result: json.valueAs("result"),
      transaction: StringUtils.toJson(json["transaction"]),
      txid: json.valueAs("txid"),
    );
  }

  Transaction toTronTransaction() {
    return Transaction.fromJson(transaction);
  }
}

class TronGetTransactionByIdResponse {
  final List<TronResult> ret;
  final String txID;
  final Map<String, dynamic> rawData;
  final List<String> signature;
  final String rawDataHex;
  bool get isSuccess =>
      !ret.any(
        (e) =>
            e.ret == TronResultCode.failed ||
            (e.ret != null && e.ret != TronResultCode.sucess),
      );
  const TronGetTransactionByIdResponse({
    required this.ret,
    required this.txID,
    required this.rawData,
    required this.signature,
    required this.rawDataHex,
  });
  factory TronGetTransactionByIdResponse.fromJson(Map<String, dynamic> json) {
    return TronGetTransactionByIdResponse(
      ret:
          json
              .valueAsList<List<Map<String, dynamic>>?>("ret")
              ?.where((e) => e.isNotEmpty)
              .map((e) => TronResult.fromJson(e))
              .toList() ??
          [],
      txID: json.valueAs("txID"),
      rawData: json.valueEnsureAsMap<String, dynamic>("raw_data"),
      signature: json.valueAsList<List<String>?>("signature") ?? [],
      rawDataHex: json.valueAs("raw_data_hex"),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "ret": ret.map((e) => e.toJson()).toList(),
      "txID": txID,
      "raw_data": rawData,
      "signature": signature,
      "raw_data_hex": rawDataHex,
    };
  }

  Transaction toTronTransaction() {
    return Transaction(
      rawData: TransactionRaw.deserialize(BytesUtils.fromHexString(rawDataHex)),
      signature: signature.map((e) => BytesUtils.fromHexString(e)).toList(),
    );
  }
}

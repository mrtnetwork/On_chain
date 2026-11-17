import 'package:blockchain_utils/blockchain_utils.dart';

/// OnChain (multi-chain) error types. Phase 2: taxonomy only, no serialization.
/// One value per legacy exception class; splits (algo/hedera/icp/fil/tezos)
/// stay distinct, single-class chains share their plugin value.
enum OnChainErrorType implements BuErrorType {
  ethereumPlugin(18000),
  eip4361(18001),
  solidityAbi(18002),
  bcsSerialization(18003),
  solanaPlugin(18004),
  suiPlugin(18005),
  suiTxBuilder(18006),
  aptosPlugin(18007),
  adaPlugin(18008),
  tronPlugin(18009),
  tronAddress(18010),
  nearPlugin(18011),
  algoPlugin(18020),
  algoAbi(18021),
  algoTxBuilder(18022),
  hederaPlugin(18030),
  hederaAddress(18031),
  hederaTxBuilder(18032),
  icpPlugin(18040),
  icpAddress(18041),
  icpCandid(18042),
  icpClient(18043),
  filPlugin(18050),
  filAddress(18051),
  filEvmRevert(18052),
  tezosPlugin(18060),
  tezosMicheline(18061),
  tezosAddress(18062),
  tezosAbi(18063),
  tezosMetadata(18064),
  tezosView(18065);

  @override
  String get domain => 'onchain';

  @override
  String get errName => name;

  @override
  final int id;
  const OnChainErrorType(this.id);
  @override
  bool isValid(int? tag) {
    return id == tag;
  }
}

/// Same-signature replacements for the removed per-chain factories.
/// Message text and `details` shapes are preserved verbatim.
abstract final class OnChainErrors {
  static BuError algoPlugin(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.algoPlugin,
    "Algorand operation failed during $where",
    details:
        {
          "reason": reason,
          "error": internalError?.toString(),
          ...?details,
        }.notNullValue,
  );

  static BuError algoAbi(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String>? details,
  }) => BuError(
    OnChainErrorType.algoAbi,
    "Algorand ABI operation failed during $where",
    details:
        {
          "reason": reason,
          "error": internalError?.toString(),
          ...?details,
        }.notNullValue,
  );

  static BuError algoTx(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.algoTxBuilder,
    "Algorand transaction operation failed during $where",
    details: {
      if (reason != null) 'reason': reason,
      if (internalError != null) 'error': internalError.toString(),
      ...?details,
    },
  );

  static BuError algoTxNotBuilding(String statusName) => BuError(
    OnChainErrorType.algoTxBuilder,
    'The composer is no longer in the BUILDING status; no more '
    'transactions can be added.',
    details: {'status': statusName},
  );

  static BuError algoTxAlreadyFinalized(String statusName) => BuError(
    OnChainErrorType.algoTxBuilder,
    'The group has already been submitted or committed.',
    details: {'status': statusName},
  );

  static const algoTxEmptyGroup = BuError(
    OnChainErrorType.algoTxBuilder,
    'Cannot build an empty transaction group.',
  );

  static BuError algoTxGroupSizeExceeded(int maxSize) => BuError(
    OnChainErrorType.algoTxBuilder,
    'Adding this transaction would exceed the maximum atomic group '
    'size of $maxSize.',
    details: {'maxGroupSize': '$maxSize'},
  );

  static const algoTxAlreadyGrouped = BuError(
    OnChainErrorType.algoTxBuilder,
    'The transaction being added already has a group id set. Only '
    'ungrouped transactions can be added to the composer.',
  );

  static BuError algoTxArgumentCountMismatch({
    required String methodName,
    required int expected,
    required int actual,
  }) => BuError(
    OnChainErrorType.algoTxBuilder,
    'Method "$methodName" expects $expected argument(s) but got $actual.',
    details: {
      'method': methodName,
      'expected': '$expected',
      'actual': '$actual',
    },
  );

  static BuError algoTxInvalidArgument({
    required String methodName,
    required int index,
    required String detail,
  }) => BuError(
    OnChainErrorType.algoTxBuilder,
    'Invalid argument at index $index for method "$methodName": $detail',
    details: {'method': methodName, 'index': '$index', 'detail': detail},
  );

  static BuError algoTxReturnValueDecodeFailed({
    required String txId,
    required String methodName,
    Object? internalError,
  }) => BuError(
    OnChainErrorType.algoTxBuilder,
    'Failed to decode the return value logged by method "$methodName".',
    details: {
      'txId': txId,
      'method': methodName,
      if (internalError != null) 'error': internalError.toString(),
    },
  );

  static BuError algoTxSigningFailed({
    required String txId,
    Object? internalError,
  }) => BuError(
    OnChainErrorType.algoTxBuilder,
    'Failed to sign transaction $txId.',
    details: {
      'txId': txId,
      if (internalError != null) 'error': internalError.toString(),
    },
  );

  static const algoTxNotSigned = BuError(
    OnChainErrorType.algoTxBuilder,
    'Not every transaction in the group has been signed yet.',
  );

  static BuError nearPlugin(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String>? details,
  }) => BuError(
    OnChainErrorType.nearPlugin,
    "NEAR operation failed during $where.",
    details:
        {
          "reason": reason,
          "error": internalError?.toString(),
          ...?details,
        }.notNullValue,
  );

  static BuError hederaPlugin(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.hederaPlugin,
    "Hedera operation failed during $where.",
    details:
        {
          "reason": reason,
          "error": internalError?.toString(),
          ...?details,
        }.notNullValue,
  );

  static BuError hederaAddress(
    String where, {
    required String reason,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.hederaAddress,
    "Hedera address operation failed during $where.",
    details: {"reason": reason, ...?details}.notNullValue,
  );

  static BuError hederaTx(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.hederaTxBuilder,
    "Hedera transaction operation failed during $where.",
    details:
        {
          "reason": reason,
          "error": internalError?.toString(),
          ...?details,
        }.notNullValue,
  );

  static BuError icpPlugin(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.icpPlugin,
    "ICP operation failed during $where.",
    details:
        {
          "reason": reason,
          "error": internalError?.toString(),
          ...?details,
        }.notNullValue,
  );

  static BuError icpAddress(
    String where, {
    required String reason,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.icpAddress,
    "ICP address failed during $where",
    details: {"reason": reason, ...?details}.notNullValue,
  );

  static BuError icpCandid(
    String where, {
    required String reason,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.icpCandid,
    "Candid operation failed during $where.",
    details: {"reason": reason, ...?details}.notNullValue,
  );

  static BuError icpClient(
    String where, {
    required String reason,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.icpClient,
    "ICP client operation failed during $where",
    details: {"reason": reason, ...?details}.notNullValue,
  );

  static BuError filPlugin(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.filPlugin,
    "Filecoin operation failed during $where.",
    details:
        {
          "reason": reason,
          "error": internalError?.toString(),
          ...?details,
        }.notNullValue,
  );

  static BuError filAddress(
    String where, {
    required String reason,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.filAddress,
    "Filecoin address operation failed during $where.",
    details: {"reason": reason, ...?details}.notNullValue,
  );

  static BuError tezosPlugin(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.tezosPlugin,
    'Tezos operation failed during $where.',
    details: {
      'reason': reason,
      'error': internalError?.toString(),
      ...?details,
    },
  );

  static BuError tezosMicheline(
    String where, {
    required String reason,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.tezosMicheline,
    'MichelineExpr operation failed during $where.',
    details: {'reason': reason, ...?details}.notNullValue,
  );

  static BuError tezosAddress(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.tezosAddress,
    'Tezos address operation failed during $where.',
    details:
        {
          'reason': reason,
          'error': internalError?.toString(),
          ...?details,
        }.notNullValue,
  );

  static BuError tezosAbi(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.tezosAbi,
    'Tezos ABI operation failed during $where.',
    details: {
      'reason': reason,
      'error': internalError?.toString(),
      ...?details,
    },
  );

  static BuError tezosMetadata(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.tezosMetadata,
    'Tezos metadata operation failed during $where',
    details: {
      'reason': reason,
      'error': internalError?.toString(),
      ...?details,
    },
  );

  static BuError tezosView(
    String where, {
    String? reason,
    Object? internalError,
    Map<String, String?>? details,
  }) => BuError(
    OnChainErrorType.tezosView,
    'Tezos view failed during $where.',
    details: {
      'reason': reason,
      'error': internalError?.toString(),
      ...?details,
    },
  );

  static BuError suiTx(String operation, {required String reason}) => BuError(
    OnChainErrorType.suiTxBuilder,
    "SuiTransactionBuilder.$operation failed.",
    details: {"reason": reason},
  );
}

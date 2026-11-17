import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/algorand/src/builder/src/signer.dart';
import 'package:on_chain/algorand/src/abi/src/abi_type.dart';
import 'package:on_chain/algorand/src/abi/src/method.dart';
import 'package:on_chain/algorand/src/abi/src/types.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/rpc/api/api.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';
import 'package:on_chain/algorand/src/transaction/src/fields.dart';
import 'package:on_chain/algorand/src/transaction/src/signatures.dart';
import 'package:on_chain/algorand/src/transaction/src/transaction.dart';
import 'package:on_chain/algorand/src/types/types.dart';
import 'package:on_chain/algorand/src/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Status of an [AtomicTransactionComposer]
enum AtomicTransactionComposerStatus {
  building,
  built,
  signed,
  submitted,
  committed,
}

/// High-level helper to build, sign, submit and wait for atomic
/// transaction groups. Mirrors the official Go / JS / Python
/// AtomicTransactionComposer APIs, using [BuError]
/// for every failure instead of generic `StateError`/`ArgumentError`.
class AtomicTransactionComposer {
  AtomicTransactionComposer();

  /// Maximum number of transactions allowed in a single atomic group,
  /// enforced by the protocol.
  static const int _kMaxAtomicGroupSize = 16;

  /// Maximum number of application-call arguments (selector included)
  /// allowed per transaction.
  static const int _kMaxAppArgs = 16;

  final _lock = SafeAtomicLock();

  // /// Hard cap for this composer instance. Defaults to the protocol max
  // /// ([_kMaxAtomicGroupSize]) but can be lowered by callers that want to
  // /// leave headroom for e.g. a fee-bump transaction added later.
  // final int _kMaxAtomicGroupSize;

  AtomicTransactionComposerStatus _status =
      AtomicTransactionComposerStatus.building;
  final List<_TxContext> _txContexts = [];

  // ─────────────────────────────────────────────────────────────

  AtomicTransactionComposerStatus get status => _status;

  bool get isBuilding => _status == AtomicTransactionComposerStatus.building;
  bool get isBuilt =>
      _status.index >= AtomicTransactionComposerStatus.built.index;
  bool get isSigned =>
      _status.index >= AtomicTransactionComposerStatus.signed.index;
  bool get isSubmitted =>
      _status.index >= AtomicTransactionComposerStatus.submitted.index;
  bool get isCommitted => _status == AtomicTransactionComposerStatus.committed;

  /// Number of transactions currently in the composer.
  int get count => _txContexts.length;

  /// How many more transactions can be added before hitting [_kMaxAtomicGroupSize].
  int get remainingCapacity => _kMaxAtomicGroupSize - count;

  bool get isEmpty => _txContexts.isEmpty;
  bool get isNotEmpty => _txContexts.isNotEmpty;

  /// True if any transaction in the group is an ABI method call.
  bool get hasMethodCalls =>
      _txContexts.any((c) => c.txn.type == AlgoTxType.appl);

  /// Read-only snapshot of the transactions currently held (unsigned).
  List<AlgoTransaction> get transactions =>
      List.unmodifiable(_txContexts.map((c) => c.txn));

  /// Transaction ids for every transaction in the group. Stable regardless
  /// of build status, but the group id only appears in these ids once
  /// [buildGroup] has actually run.
  List<String> get transactionIds =>
      List.unmodifiable(_txContexts.map((c) => c.txId));

  /// Adds a regular (non-ABI) transaction.
  Future<void> addTransaction(TransactionWithSigner txnAndSigner) async {
    await _lock.run(() async {
      _ensureBuilding();
      _ensureCapacity(1);
      final groupId = txnAndSigner.txn.group;
      if (groupId != null && groupId.isNotEmpty) {
        throw OnChainErrors.algoTxAlreadyGrouped;
      }
      _txContexts.add(
        _TxContext(
          txn: txnAndSigner.txn,
          signer: txnAndSigner.signer,
          method: txnAndSigner.abiMethod,
        ),
      );
    });
  }

  /// Adds several plain transactions at once, preserving order.
  ///
  Future<void> addTransactions(Iterable<TransactionWithSigner> items) async {
    for (final item in items) {
      await addTransaction(item);
    }
  }

  /// Adds an ABI method call (application call + optional foreign txs).
  Future<List<TransactionWithSigner>> buildAddMethodCallTransaction({
    required BigInt appId,
    required ABIMethod method,
    required List<dynamic> methodArgs,
    required AlgoAddress sender,
    required AlgoTransactionSigner signer,
    required AlgoQuickClientApi client,
    BigInt? flatFee,
    AlgoTypesOnCompletion onCompletion = AlgoTypesOnCompletion.noOpOC,
    List<int>? approvalProgram,
    List<int>? clearStateProgram,
    StateSchema? globalSchema,
    StateSchema? localSchema,
    BigInt? extraPages,
    List<int>? note,
    List<int>? lease,
    AlgoAddress? rekeyTo,
    List<BigInt> foreignApps = const [],
    List<BigInt> foreignAssets = const [],
    List<AlgoAddress> foreignAccounts = const [],
    List<BoxRef> boxes = const [],
    BigInt? rejectVersion,
  }) async {
    if (methodArgs.length != method.args.length) {
      throw OnChainErrors.algoTxArgumentCountMismatch(
        methodName: method.name,
        expected: method.args.length,
        actual: methodArgs.length,
      );
    }

    final accounts = List<AlgoAddress>.from(foreignAccounts);
    final apps = List<BigInt>.from(foreignApps);
    final assets = List<BigInt>.from(foreignAssets);

    final appArgs = _buildAppArgs(
      method: method,
      methodArgs: methodArgs,
      appId: appId,
      sender: sender,
      accounts: accounts,
      apps: apps,
      assets: assets,
    );

    final fields = ApplicationCallTxnFields(
      applicationId: appId,
      onCompletion: BigInt.from(onCompletion.value),
      applicationArgs: appArgs.encodeArgs,
      accounts: accounts.isEmpty ? null : accounts,
      foreignApps: apps.isEmpty ? null : apps,
      foreignAssets: assets.isEmpty ? null : assets,
      boxes: boxes.isEmpty ? null : boxes,
      localStateSchema: localSchema,
      globalStateSchema: globalSchema,
      approvalProgram: approvalProgram,
      clearStateProgram: clearStateProgram,
      extraProgramPages: extraPages,
      rejectVersion: rejectVersion,
    );

    final finalTx = await buildTransaction(
      client: client,
      tx: fields,
      sender: sender,
      signer: signer,
      lease: lease,
      rekeyTo: rekeyTo,
      note: note,
      flatFee: flatFee,
      abiMethod: method,
    );
    return [...appArgs.txes, finalTx];
  }

  /// Resolves and encodes the ABI arguments for a method call. Transaction
  /// args are peeled off and returned as `txes` (the caller is responsible for
  /// adding them to the group); reference args are resolved against the foreign
  /// arrays and encoded as their index. Returns the full application argument
  /// list (selector first).
  ({List<List<int>> encodeArgs, List<TransactionWithSigner> txes})
  _buildAppArgs({
    required ABIMethod method,
    required List<dynamic> methodArgs,
    required BigInt appId,
    required AlgoAddress sender,
    required List<AlgoAddress> accounts,
    required List<BigInt> apps,
    required List<BigInt> assets,
  }) {
    final appArgs = <List<int>>[method.getSelector()];
    final abiTypes = <ABIType>[];
    final abiValues = <Object?>[];
    final List<TransactionWithSigner> extraTxes = [];

    for (var i = 0; i < method.args.length; i++) {
      final argSpec = method.args[i];
      final arg = methodArgs[i];
      final t = argSpec.type;

      switch (t) {
        case ABITransactionType():
          if (arg is! TransactionWithSigner) {
            throw OnChainErrors.algoTxInvalidArgument(
              methodName: method.name,
              index: i,
              detail:
                  'expected a TransactionWithSigner for a '
                  'transaction-type argument',
            );
          }
          final txType = AlgoTxType.tryParse(t.value);
          if (txType != null && arg.txn.type != txType) {
            throw OnChainErrors.algoTxInvalidArgument(
              methodName: method.name,
              index: i,
              detail:
                  "Invalid transaction type. expected: ${txType.name}, transaction: ${arg.txn.type.name}",
            );
          }
          extraTxes.add(arg);
          continue;

        case ABIReferenceType reference:
          switch (reference) {
            case ABIReferenceType.account:
              if (arg is! String && arg is! AlgoAddress) {
                throw OnChainErrors.algoTxInvalidArgument(
                  methodName: method.name,
                  index: i,
                  detail: 'account reference must be a String or AlgoAddress',
                );
              }
              final idx = _populateForeignAccount(arg, accounts, sender);
              abiTypes.add(ABIUintType(8));
              abiValues.add(idx);
              continue;

            case ABIReferenceType.application:
              final id = _asBigInt(arg, method.name, i, 'application');
              final idx = _populateForeignBigInt(id, apps, appId);
              abiTypes.add(ABIUintType(8));
              abiValues.add(idx);
              continue;

            case ABIReferenceType.asset:
              final id = _asBigInt(arg, method.name, i, 'asset');
              final idx = _populateForeignBigInt(id, assets, null);
              abiTypes.add(ABIUintType(8));
              abiValues.add(idx);
              continue;
          }

        case ABIType t:
          abiTypes.add(t);
          abiValues.add(arg);
          continue;
      }
    }

    if (abiTypes.isEmpty) return (encodeArgs: appArgs, txes: extraTxes);

    // First (_kMaxAppArgs - 2) args are encoded individually; anything
    // beyond that is packed into a trailing tuple, per ARC-4.
    if (abiTypes.length > _kMaxAppArgs - 1) {
      final splitAt = _kMaxAppArgs - 2;
      final headTypes = abiTypes.sublist(0, splitAt);
      final tailTypes = abiTypes.sublist(splitAt);
      final headVals = abiValues.sublist(0, splitAt);
      final tailVals = abiValues.sublist(splitAt);

      for (var i = 0; i < headTypes.length; i++) {
        appArgs.add(headTypes[i].encode(headVals[i]));
      }
      appArgs.add(ABITupleType(tailTypes).encode(tailVals));
    } else {
      for (var i = 0; i < abiTypes.length; i++) {
        appArgs.add(abiTypes[i].encode(abiValues[i]));
      }
    }
    return (encodeArgs: appArgs, txes: extraTxes);
  }

  BigInt _asBigInt(Object? arg, String methodName, int index, String kind) {
    try {
      return JsonParser.valueAsBigInt(arg);
    } catch (e) {
      throw OnChainErrors.algoTxInvalidArgument(
        methodName: methodName,
        index: index,
        detail: '$kind reference must be convertible to BigInt',
      );
    }
  }

  /// Assigns a group id (if more than one txn) and freezes the group.
  List<TransactionWithSigner> buildGroup() {
    if (_status.index > AtomicTransactionComposerStatus.building.index) {
      return _getFinalized();
    }
    final groupId = _computeGroupHash();
    if (groupId != null) {
      for (var i = 0; i < _txContexts.length; i++) {
        _txContexts[i] = _txContexts[i].copyWith(
          txn: _txContexts[i].txn.copyWith(group: groupId),
        );
      }
    }

    _status = AtomicTransactionComposerStatus.built;
    return _getFinalized();
  }

  List<int>? _computeGroupHash() {
    final txes = _txContexts;
    if (txes.isEmpty) {
      throw OnChainErrors.algoTxEmptyGroup;
    }
    if (txes.length > _kMaxAtomicGroupSize) {
      throw OnChainErrors.algoTxGroupSizeExceeded(_kMaxAtomicGroupSize);
    }

    if (txes.length > 1) {
      return AlgoUtils.computeGroupId(txes.map((c) => c.txn).toList());
    }
    return null;
  }

  /// Obtains signatures for every transaction (caches the result so
  /// repeated calls are cheap).
  Future<List<AlgoSignedTxn?>> gatherSignatures() async {
    return _lock.run(() async {
      buildGroup(); // ensure we are at least BUILT

      for (var i = 0; i < _txContexts.length; i++) {
        final tx = _txContexts[i];
        if (tx.signedTx != null) continue;
        try {
          final sigs = await tx.signer.signTransactionsAsync(tx.txn);
          _txContexts[i] = tx.copyWith(signedTx: sigs);
        } catch (e) {
          throw OnChainErrors.algoTxSigningFailed(
            txId: tx.txId,
            internalError: e,
          );
        }
      }
      _status = AtomicTransactionComposerStatus.signed;
      return _txContexts.map((c) => c.signedTx).toList();
    });
  }

  /// Submits the group. Does **not** wait for confirmation.
  Future<List<String>> submit(
    AlgoQuickClientApi client, {
    bool simulate = true,
    Duration? timeout,
  }) async {
    if (_status.index > AtomicTransactionComposerStatus.submitted.index) {
      throw OnChainErrors.algoTxAlreadyFinalized(_status.name);
    }
    final signed = await _requireAllSigned();
    return _lock.run(() async {
      if (_status.index > AtomicTransactionComposerStatus.submitted.index) {
        throw OnChainErrors.algoTxAlreadyFinalized(_status.name);
      }
      if (simulate) {
        final simulation = await this.simulate(client, timeout: timeout);
        final failed = simulation.simulateResponse.failedAt ?? [];
        if (failed.isNotEmpty ||
            simulation.simulateResponse.txnResults.any(
              (e) => e.txnResult.poolError.isNotEmpty,
            )) {
          throw OnChainErrors.algoTx(
            "submit",
            reason: "Simulation failed.",
            details: {
              "failureMessage":
                  simulation.simulateResponse.failureMessage ??
                  simulation.simulateResponse.txnResults
                      .firstWhereNullable(
                        (e) => e.txnResult.poolError.isNotEmpty,
                      )
                      ?.txnResult
                      .poolError,
            },
          );
        }
      }

      try {
        await client.sendTransactions(signed);
      } catch (e) {
        throw OnChainErrors.algoTx('submit', internalError: e);
      }

      _status = AtomicTransactionComposerStatus.submitted;
      return transactionIds;
    });
  }

  /// Submits and waits until the group is confirmed.
  Future<ExecuteResult> execute(
    AlgoQuickClientApi client, {
    int waitRounds = 4,
    Duration? timeout,
  }) async {
    if (_status == AtomicTransactionComposerStatus.committed) {
      throw OnChainErrors.algoTxAlreadyFinalized(_status.name);
    }

    await submit(client, timeout: timeout);
    return _lock.run(() async {
      // Wait on the first method-call txn (or the first txn if none).
      final waitIndex = _txContexts.indexWhere((c) => c.method != null);
      final idx = waitIndex >= 0 ? waitIndex : 0;

      final info = await client.waitForConfirmation(
        txId: _txContexts[idx].txId,
        waitRounds: waitRounds,
        timeout: timeout,
      );

      _status = AtomicTransactionComposerStatus.committed;

      final methodResults = <ABIMethodResult?>[];
      for (final ctx in _txContexts) {
        final method = ctx.method;
        if (method == null) {
          methodResults.add(null);
          continue;
        }
        final txnInfo =
            ctx.txId == _txContexts[idx].txId
                ? info
                : await client.pendingTransactionInfo(ctx.txId);
        methodResults.add(_buildMethodResult(ctx, txnInfo));
      }

      return ExecuteResult(
        confirmedRound: info.confirmedRound ?? BigInt.zero,
        txIds: transactionIds,
        methodResults: methodResults,
      );
    });
  }

  ({Object? returnValue, List<int>? rawResult}) _decodeMethodResult(
    _TxContext ctx,
    ABIMethod method,
    List<List<int>>? logs,
  ) {
    const returnHash = [0x15, 0x1f, 0x7c, 0x75];
    final rType = method.returns.type;
    if (rType == null) {
      return (rawResult: <int>[], returnValue: null);
    }

    if (logs == null || logs.isEmpty) {
      return (returnValue: null, rawResult: null);
    }

    final lastLog = logs.last;

    if (lastLog.length < returnHash.length ||
        !BytesUtils.bytesEqual(
          lastLog.sublist(0, returnHash.length),
          returnHash,
        )) {
      return (returnValue: null, rawResult: null);
    }

    final rawResult = lastLog.sublist(returnHash.length);

    try {
      final returnValue = rType.decode(rawResult);

      return (rawResult: rawResult, returnValue: returnValue);
    } catch (e) {
      throw OnChainErrors.algoTxReturnValueDecodeFailed(
        txId: ctx.txId,
        methodName: method.name,
        internalError: e,
      );
    }
  }

  /// Decodes the ABI return value logged by a method-call transaction,
  /// if any.
  ABIMethodResult? _buildMethodResult(
    _TxContext ctx,
    AlgoRestTypesPendingTransactionResponse? response,
  ) {
    final method = ctx.method;
    if (method == null) return null;
    final decode = _decodeMethodResult(ctx, method, response?.logs);

    return ABIMethodResult(
      txId: ctx.txId,
      transactionInfo: response,
      method: method,
      rawReturnValue: decode.rawResult,
      returnValue: decode.returnValue,
    );
  }

  /// Simulates the group (does not advance status past SIGNED).
  Future<SimulateResult> simulate(
    AlgoQuickClientApi client, {
    Map<String, dynamic>? request,
    Duration? timeout,
  }) async {
    List<(_TxContext, AlgoSignedTxn)> txes =
        _txContexts.map((e) => (e, e.simulateTx())).toList();
    if (_status.index <= AtomicTransactionComposerStatus.building.index) {
      final groupId = _computeGroupHash();
      if (groupId != null) {
        final txContexts = _txContexts.map(
          (e) => e.copyWith(
            txn: e.txn.copyWith(group: groupId),
            replaceSignedTx: true,
            signedTx: null,
          ),
        );
        txes = txContexts.map((e) => (e, e.simulateTx())).toList();
      }
    }
    final response = await client.simulateTransactions(
      txes.map((e) => e.$2).toList(),
      timeout: timeout,
    );
    final result = response.txnGroups.elementAtOrNull(0);
    if (result == null) {
      throw OnChainErrors.algoTx(
        "simulate",
        reason: "Unexpected simulate response. Missing transaction group.",
      );
    }
    return SimulateResult(
      simulateResponse: result,
      methodResults:
          txes.indexed.map((e) {
            final txResult = result.txnResults.elementAtOrNull(e.$1)?.txnResult;
            return _buildMethodResult(e.$2.$1, txResult);
          }).toList(),
    );
  }

  Future<List<AlgoSignedTxn>> _requireAllSigned() async {
    final stxs = await gatherSignatures();
    final signed = <AlgoSignedTxn>[];
    for (final s in stxs) {
      if (s == null) {
        throw OnChainErrors.algoTxNotSigned;
      }
      signed.add(s);
    }
    return signed;
  }

  Future<AlgoTypesSuggestedParams> getSuggestedParams({
    required AlgoQuickClientApi client,
    BigInt? flatFee,
    Duration? timeout,
  }) async {
    return await client.getTransactionSuggestedParams(
      flatFee: flatFee,
      timeout: timeout,
    );
  }

  Future<TransactionWithSigner> buildTransaction({
    required AlgoQuickClientApi client,
    required AlgoTxFields tx,
    required AlgoAddress sender,
    required AlgoTransactionSigner signer,
    Duration? timeout,
    AlgoAddress? rekeyTo,
    List<int>? lease,
    List<int>? note,
    BigInt? flatFee,
    ABIMethod? abiMethod,
  }) async {
    final suggestedParams = await getSuggestedParams(
      client: client,
      flatFee: flatFee,
      timeout: timeout,
    );
    BigInt fee = suggestedParams.minFee;
    if (suggestedParams.flatFee) {
      fee = suggestedParams.fee;
    }

    final header = TransactionHeader(
      sender: sender,
      fee: fee,
      firstValid: suggestedParams.firstRoundValid,
      lastValid: suggestedParams.lastRoundValid,
      genesisId: suggestedParams.genesisID,
      genesisHash: suggestedParams.genesisHash,
      rekeyTo: rekeyTo,
      lease: lease,
      note: note,
    );

    AlgoTransaction transaction = AlgoTransaction.fromFields(
      header: header,
      fields: tx,
    );
    if (!suggestedParams.flatFee && suggestedParams.fee != BigInt.zero) {
      final signedTx = await signer.signSimulateTransactionsAsync(transaction);
      final bytes = signedTx.toSerializeBytes().length;
      fee = BigintUtils.max(
        suggestedParams.minFee,
        BigInt.from(bytes) * suggestedParams.fee,
      );
      transaction = transaction.copyWith(fee: fee);
    }
    return TransactionWithSigner(
      txn: transaction,
      signer: signer,
      abiMethod: abiMethod,
    );
  }

  /// Returns a new composer with the same (ungrouped, unsigned)
  /// transactions, reset to BUILDING status. The current composer is
  /// left untouched.
  AtomicTransactionComposer clone() {
    final copy = AtomicTransactionComposer();
    for (final ctx in _txContexts) {
      copy._txContexts.add(
        ctx.copyWith(
          txn: ctx.txn.copyWith(replaceGroup: true),
          signedTx: null,
          replaceSignedTx: true,
        ),
      );
    }
    return copy;
  }

  /// Clears every transaction and resets status back to BUILDING.
  /// Throws if the group has already been submitted, since discarding a
  /// submitted group's bookkeeping could hide an in-flight transaction.
  void reset() {
    if (isSubmitted) {
      throw OnChainErrors.algoTxAlreadyFinalized(_status.name);
    }
    _txContexts.clear();
    _status = AtomicTransactionComposerStatus.building;
  }

  @override
  String toString() =>
      'AtomicTransactionComposer(status: ${_status.name}, count: $count, '
      '_kMaxAtomicGroupSize: $_kMaxAtomicGroupSize)';

  void _ensureBuilding() {
    if (_status != AtomicTransactionComposerStatus.building) {
      throw OnChainErrors.algoTxNotBuilding(_status.name);
    }
  }

  void _ensureCapacity(int additional) {
    if (count + additional > _kMaxAtomicGroupSize) {
      throw OnChainErrors.algoTxGroupSizeExceeded(_kMaxAtomicGroupSize);
    }
  }

  List<TransactionWithSigner> _getFinalized() =>
      _txContexts
          .map((c) => TransactionWithSigner(txn: c.txn, signer: c.signer))
          .toList();

  static int _populateForeignBigInt(
    BigInt value,
    List<BigInt> array,
    BigInt? zeroValue,
  ) {
    if (zeroValue != null && value == zeroValue) return 0;
    final offset = zeroValue == null ? 0 : 1;
    for (var i = 0; i < array.length; i++) {
      if (array[i] == value) return i + offset;
    }
    array.add(value);
    return array.length - 1 + offset;
  }

  /// Resolves an account reference (String address or AlgoAddress) against
  /// the foreign-accounts array, adding it if not already present.
  static int _populateForeignAccount(
    dynamic value,
    List<AlgoAddress> array,
    AlgoAddress zeroValue,
  ) {
    final addr = value is AlgoAddress ? value : AlgoAddress(value as String);
    if (addr == zeroValue) return 0;
    for (var i = 0; i < array.length; i++) {
      if (addr == array[i]) return i + 1;
    }
    array.add(addr);
    return array.length;
  }
}

// Internal bookkeeping.
class _TxContext {
  _TxContext({
    required this.txn,
    required this.signer,
    this.method,
    this.signedTx,
  });

  final AlgoTransaction txn;
  final AlgoTransactionSigner signer;
  final ABIMethod? method; // null for plain (non-ABI) transactions
  final AlgoSignedTxn? signedTx;
  String? _txId;

  AlgoSignedTxn simulateTx() {
    final tx = signedTx;
    return tx ?? AlgoSignedTxn(transaction: txn);
  }

  String get txId => _txId ??= txn.transactionIDString();

  _TxContext copyWith({
    AlgoTransaction? txn,
    AlgoTransactionSigner? signer,
    ABIMethod? method,
    AlgoSignedTxn? signedTx,
    bool replaceSignedTx = false,
  }) {
    return _TxContext(
      txn: txn ?? this.txn,
      signer: signer ?? this.signer,
      method: method ?? this.method,
      signedTx: replaceSignedTx ? signedTx : signedTx ?? this.signedTx,
    );
  }
}

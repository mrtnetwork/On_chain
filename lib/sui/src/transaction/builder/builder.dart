import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/serialization/bcs/move/types/types.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/intent/intent.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/object.dart';
import 'package:on_chain/sui/src/rpc/api/api/api.dart';
import 'package:on_chain/sui/src/transaction/transaction.dart';
import 'package:on_chain/sui/src/utils/function.dart';
import 'package:on_chain/transaction/transaction.dart';

class SuiTransactionBuilder
    implements
        IOnchainTxBuilder<
          SuiOnchainTransaction,
          SuiGetTransactionParams,
          SuiFillTransactionParams,
          SuiFillTransactionResult,
          SuiSignTransactionParams,
          SuiSignedTransactionResult,
          SuiFinalizeTransactionParams,
          SuiFinalizedTransactionResult,
          SuiSubmitTransactionParams,
          SuiSubmitTransactionResult
        > {
  SuiTransactionBuilder({SuiQuickClientApi? client}) : _client = client;

  final SuiQuickClientApi? _client;

  final List<SuiCallArguments> _inputs = [];
  final List<SuiCommand> _commands = [];
  SuiAddress? _sender;
  List<SuiObjectRef>? _gasPayment;
  SuiAddress? _gasOwner;
  BigInt? _gasPrice;
  BigInt? _gasBudget;
  SuiTransactionExpiration? _expiration;

  TxBuilderPhase _phase = TxBuilderPhase.building;
  @override
  TxBuilderPhase get phase => _phase;

  SuiTransactionDataV1? _filledData;
  SuiSignedTransactionResult? _signedResult;

  void _onMutate() {
    if (_phase == TxBuilderPhase.signed || _phase == TxBuilderPhase.finalized) {
      _phase = TxBuilderPhase.building;
      _filledData = null;
      _signedResult = null;
    }
  }

  void _requireCommands(String operation) {
    if (_commands.isEmpty) {
      throw OnChainErrors.suiTx(
        operation,
        reason: 'No commands added. Use moveCall/transferObjects/... first.',
      );
    }
  }

  // ===========================================================================
  // sui.js-style command helpers (each returns its result reference)
  // ===========================================================================

  /// Adds a raw [SuiCallArg] input, returning its index reference.
  SuiArgumentInput addInput(SuiCallArg input) {
    _onMutate();
    final index = _inputs.length;
    _inputs.add(input);
    return SuiArgumentInput(index);
  }

  SuiArgumentInput pureU64(BigInt value) => addInput(SuiCallArgPure.u64(value));
  SuiArgumentInput pureAddress(SuiAddress value) =>
      addInput(SuiCallArgPure.address(value));
  SuiArgumentInput pureString(String value) =>
      addInput(SuiCallArgPure.string(value));
  SuiArgumentInput pureBool(bool value) =>
      addInput(SuiCallArgPure.boolean(value));
  SuiArgumentInput pureBytes(List<int> value) =>
      addInput(SuiCallArgPure.bytes(value));

  SuiArgument gasCoin() => SuiArgumentGasCoin();

  SuiArgumentResult moveCall({
    required SuiAddress package,
    required String module,
    required String function,
    List<String> typeArguments = const [],
    required List<SuiArgument> arguments,
  }) {
    _onMutate();
    final index = _commands.length;
    _commands.add(
      SuiCommandMoveCall(
        SuiProgrammableMoveCall(
          package: package,
          module: module,
          function: function,
          typeArguments: [
            for (final t in typeArguments) SuiTypeTagUtils.parseTag(t),
          ],
          arguments: arguments,
        ),
      ),
    );
    return SuiArgumentResult(index);
  }

  /// TRANSFER_OBJECTS: moves `objects` to `address`. Returns nothing, like
  /// sui.js — transferred objects leave the transaction.
  void transferObjects(List<SuiArgument> objects, SuiArgument address) {
    _onMutate();
    if (objects.isEmpty) {
      throw OnChainErrors.suiTx(
        'transferObjects',
        reason: 'Objects cannot be empty.',
      );
    }
    _commands.add(
      SuiCommandTransferObjects(objects: objects, address: address),
    );
  }

  /// SPLIT_COIN: splits `amounts` off `coin`, returning one
  /// `NestedResult(command, i)` reference per amount so each split coin can
  /// be used individually (a plain `Result` would alias all of them).
  List<SuiArgument> splitCoins(SuiArgument coin, List<BigInt> amounts) {
    _onMutate();
    if (amounts.isEmpty) {
      throw OnChainErrors.suiTx(
        'splitCoins',
        reason: 'Amounts cannot be empty.',
      );
    }
    final index = _commands.length;
    _commands.add(
      SuiCommandSplitCoins(
        coin: coin,
        amounts: [for (final a in amounts) pureU64(a)],
      ),
    );
    return [
      for (int i = 0; i < amounts.length; i++)
        SuiArgumentNestedResult(commandIndex: index, resultIndex: i),
    ];
  }

  void mergeCoins(SuiArgument destination, List<SuiArgument> sources) {
    _onMutate();
    if (sources.isEmpty) {
      throw OnChainErrors.suiTx(
        'mergeCoins',
        reason: 'Sources cannot be empty.',
      );
    }
    _commands.add(
      SuiCommandMergeCoins(destination: destination, sources: sources),
    );
  }

  SuiArgumentResult publish({
    required List<List<int>> modules,
    required List<SuiAddress> dependencies,
  }) {
    _onMutate();
    if (modules.isEmpty) {
      throw OnChainErrors.suiTx('publish', reason: 'Modules cannot be empty.');
    }
    final index = _commands.length;
    _commands.add(
      SuiCommandPublish(modules: modules, dependencies: dependencies),
    );
    return SuiArgumentResult(index);
  }

  SuiArgumentResult makeMoveVec({
    SuiTypeInput? type,
    required List<SuiArgument> elements,
  }) {
    _onMutate();
    final index = _commands.length;
    _commands.add(SuiCommandMakeMoveVec(typeInput: type, elements: elements));
    return SuiArgumentResult(index);
  }

  SuiArgumentResult upgrade({
    required List<List<int>> modules,
    required List<SuiAddress> dependencies,
    required SuiAddress package,
    required SuiArgument ticket,
  }) {
    _onMutate();
    final index = _commands.length;
    _commands.add(
      SuiCommandUpgrade(
        modules: modules,
        dependencies: dependencies,
        package: package,
        ticket: ticket,
      ),
    );
    return SuiArgumentResult(index);
  }

  // -- envelope setters ------------------------------------------------------

  /// Shared `SuiSystemState` (0x5) reference for system calls, `&mut`.
  /// Its initial shared version is 1 since genesis (verified against live
  /// chain state); pass an explicit [systemState] built from a fresh object
  /// fetch if that ever changes.
  static SuiObjectArg suiSystemStateShared() {
    return SuiObjectArgSharedObject(
      id: SuiAddress(
        '0x0000000000000000000000000000000000000000000000000000000000000005',
      ),
      initialSharedVersion: BigInt.one,
      mutability: SuiSharedObjectMutability.mutable,
    );
  }

  /// `0x3::sui_system::request_add_stake`: stakes `stakeCoin` with
  /// `validator`, returning the new `StakedSui` object reference. The shared
  /// system state is prepended automatically ([systemState] overrides it).
  SuiArgumentResult requestAddStake({
    required SuiArgument stakeCoin,
    required SuiAddress validator,
    SuiObjectArg? systemState,
  }) {
    _onMutate();
    final systemStateInput = addInput(
      SuiCallArgObject(systemState ?? suiSystemStateShared()),
    );
    return moveCall(
      package: SuiAddress(
        '0x0000000000000000000000000000000000000000000000000000000000000003',
      ),
      module: 'sui_system',
      function: 'request_add_stake',
      arguments: [systemStateInput, stakeCoin, pureAddress(validator)],
    );
  }

  /// `0x3::sui_system::request_withdraw_stake`: withdraws `stakedSui`,
  /// returning the withdrawn coin reference.
  SuiArgumentResult requestWithdrawStake({
    required SuiArgument stakedSui,
    SuiObjectArg? systemState,
  }) {
    _onMutate();
    final systemStateInput = addInput(
      SuiCallArgObject(systemState ?? suiSystemStateShared()),
    );
    return moveCall(
      package: SuiAddress(
        '0x0000000000000000000000000000000000000000000000000000000000000003',
      ),
      module: 'sui_system',
      function: 'request_withdraw_stake',
      arguments: [systemStateInput, stakedSui],
    );
  }

  /// Transfers SUI to `recipient`: the whole gas coin when `amount` is null,
  /// else splits `amount` off the gas coin first (sui.js `transferSui`).
  void transferSui({required SuiArgument recipient, BigInt? amount}) {
    _onMutate();
    if (amount == null) {
      _commands.add(
        SuiCommandTransferObjects(
          objects: [SuiArgumentGasCoin()],
          address: recipient,
        ),
      );
      return;
    }
    final parts = splitCoins(SuiArgumentGasCoin(), [amount]);
    _commands.add(
      SuiCommandTransferObjects(objects: parts, address: recipient),
    );
  }

  /// `pay`: joins `coins` into the first, splits `amounts` and transfers
  /// each part to the matching recipient (lengths must match).
  void pay({
    required List<SuiArgument> coins,
    required List<SuiArgument> recipients,
    required List<BigInt> amounts,
  }) {
    _onMutate();
    if (coins.isEmpty || recipients.isEmpty || amounts.isEmpty) {
      throw OnChainErrors.suiTx(
        'pay',
        reason: 'Coins, recipients and amounts cannot be empty.',
      );
    }
    if (recipients.length != amounts.length) {
      throw OnChainErrors.suiTx(
        'pay',
        reason: 'Recipients and amounts length mismatch.',
      );
    }
    final base = coins.first;
    if (coins.length > 1) {
      mergeCoins(base, coins.sublist(1));
    }
    final parts = splitCoins(base, amounts);
    for (int i = 0; i < parts.length; i++) {
      transferObjects([parts[i]], recipients[i]);
    }
  }

  // -- envelope setters ------------------------------------------------------

  void setSender(SuiAddress sender) {
    _onMutate();
    _sender = sender;
  }

  void setGasPrice(BigInt price) {
    _onMutate();
    _gasPrice = price;
  }

  void setGasBudget(BigInt budget) {
    _onMutate();
    _gasBudget = budget;
  }

  void setGasOwner(SuiAddress owner) {
    _onMutate();
    _gasOwner = owner;
  }

  void setGasPayment(List<SuiObjectRef> payment) {
    _onMutate();
    _gasPayment = payment;
  }

  void setExpiration(SuiTransactionExpiration expiration) {
    _onMutate();
    _expiration = expiration;
  }

  // ===========================================================================
  // IOnchainTxBuilder phases
  // ===========================================================================

  SuiTransactionDataV1 _buildData() {
    _requireCommands('getTransaction');
    final sender = _sender;
    if (sender == null) {
      throw OnChainErrors.suiTx(
        'getTransaction',
        reason: 'Sender is not set. Use setSender() or fillTransaction().',
      );
    }
    return SuiTransactionDataV1(
      kind: SuiTransactionKindProgrammableTransaction(
        SuiProgrammableTransaction(
          inputs: List.unmodifiable(_inputs),
          commands: List.unmodifiable(_commands),
        ),
      ),
      sender: sender,
      gasData: SuiGasData(
        payment: _gasPayment ?? const [],
        owner: _gasOwner ?? sender,
        price: _gasPrice ?? BigInt.zero,
        budget: _gasBudget ?? BigInt.zero,
      ),
      expiration: _expiration ?? SuiTransactionExpirationNone(),
    );
  }

  @override
  Future<SuiOnchainTransaction> getTransaction({
    SuiGetTransactionParams? params,
  }) async {
    return SuiOnchainTransaction(_buildData());
  }

  SuiQuickClientApi _requireClient(String operation) {
    final client = _client;
    if (client == null) {
      throw OnChainErrors.suiTx(
        operation,
        reason: 'No client. Pass SuiQuickClientApi to the builder.',
      );
    }
    return client;
  }

  /// Greedy smallest-cover coin selection for [needed].
  static List<SuiObject> selectGasCoins(List<SuiObject> coins, BigInt needed) {
    final sorted = List<SuiObject>.from(coins)..sort(
      (a, b) => (a.balance ?? BigInt.zero).compareTo(b.balance ?? BigInt.zero),
    );
    BigInt total = BigInt.zero;
    final selected = <SuiObject>[];
    for (final coin in sorted) {
      selected.add(coin);
      total += coin.balance ?? BigInt.zero;
      if (total >= needed) break;
    }
    if (total < needed) {
      throw OnChainErrors.suiTx(
        'selectGasCoins',
        reason: 'Insufficient gas balance: have $total, need $needed.',
      );
    }
    return selected;
  }

  static SuiObjectRef _coinToRef(SuiObject coin) {
    return SuiObjectRef(
      address: SuiAddress(coin.objectId ?? ''),
      version: coin.version ?? BigInt.zero,
      digest: SuiObjectDigest.fromBase58(coin.digest ?? ''),
    );
  }

  @override
  Future<SuiFillTransactionResult> fillTransaction({
    required SuiFillTransactionParams params,
  }) async {
    if (_phase == TxBuilderPhase.signed || _phase == TxBuilderPhase.finalized) {
      throw OnChainErrors.suiTx(
        'fillTransaction',
        reason: 'Transaction is already signed.',
      );
    }
    _requireCommands('fillTransaction');
    final client = _requireClient('fillTransaction');
    _sender = params.sender;
    final gasOwner = params.sponsor ?? params.sender;
    _gasOwner = gasOwner;
    _expiration = params.expiration ?? _expiration;

    final gasPrice = params.gasPrice ?? await client.getGasPrice();
    _gasPrice = gasPrice;

    // Provisional envelope for estimation.
    List<SuiObject> probeCoins = params.gasCoins ?? [];
    if (probeCoins.isEmpty) {
      probeCoins =
          await client
              .watchAccountCoins(
                gasOwner,
                coinType: SuiTransactionConst.suiTypeArgs,
              )
              .expand((e) => e)
              .toList();
    }
    if (probeCoins.isEmpty) {
      throw OnChainErrors.suiTx(
        'fillTransaction',
        reason: 'Gas owner has no SUI coins.',
      );
    }
    BigInt budget = params.budget ?? BigInt.zero;
    if (params.budget == null) {
      // Estimate via simulation. The probe budget must be covered by the
      // probe payment or the node rejects the dry-run, so cap it at the
      // available balance (estimation only needs headroom above actual use).
      final probeTotal = probeCoins.fold<BigInt>(
        BigInt.zero,
        (sum, c) => sum + (c.balance ?? BigInt.zero),
      );
      final probeBudget =
          probeTotal < SuiTransactionConst.maxGas
              ? probeTotal
              : SuiTransactionConst.maxGas;
      final probeData = _buildData().copyWith(
        gasData: SuiGasData(
          payment: [for (final c in probeCoins) _coinToRef(c)],
          owner: gasOwner,
          price: gasPrice,
          budget: probeBudget,
        ),
      );
      final simulated = await client.simulateTransaction(
        B64Encoder.encode(probeData.toVariantBcs()),
      );
      final used = simulated.transaction?.effects?.gasUsed;
      if (used == null) {
        throw OnChainErrors.suiTx(
          'fillTransaction',
          reason: 'Simulation returned no gas usage.',
        );
      }
      // Budget against GROSS cost (computation + storage), not net of
      // rebate: the gas meter enforces the budget as charges accrue and the
      // storage rebate only lands at the end. Net-based budgets fail live
      // with InsufficientGas even when the balance covers them.
      final gross =
          (used.computationCost ?? BigInt.zero) +
          (used.storageCost ?? BigInt.zero);
      budget =
          ((gross * BigInt.from((params.safetyMultiplier * 1000).round())) ~/
              BigInt.from(1000)) +
          SuiTransactionConst.gasSafeOverHead;
      if (budget < SuiTransactionConst.minGas) {
        budget = SuiTransactionConst.minGas;
      }
      if (budget > SuiTransactionConst.maxGas) {
        budget = SuiTransactionConst.maxGas;
      }
    }
    _gasBudget = budget;
    final selected = params.gasCoins ?? selectGasCoins(probeCoins, budget);
    final covered = selected.fold<BigInt>(
      BigInt.zero,
      (sum, coin) => sum + (coin.balance ?? BigInt.zero),
    );
    if (covered < budget) {
      throw OnChainErrors.suiTx(
        'fillTransaction',
        reason: 'Insufficient gas balance: have $covered, need $budget.',
      );
    }
    _gasPayment = [for (final c in selected) _coinToRef(c)];

    _filledData = _buildData();
    _signedResult = null;
    _phase = TxBuilderPhase.filled;
    return SuiFillTransactionResult(
      gasPrice: gasPrice,
      budget: budget,
      gasCoins: selected,
      gasOwner: gasOwner,
    );
  }

  @override
  Future<SuiSignedTransactionResult> signTransaction({
    required SuiSignTransactionParams params,
  }) async {
    if (_phase != TxBuilderPhase.filled && _phase != TxBuilderPhase.signed) {
      throw OnChainErrors.suiTx(
        'signTransaction',
        reason: 'Call fillTransaction() before signing.',
      );
    }
    if (params.signers.isEmpty) {
      throw OnChainErrors.suiTx(
        'signTransaction',
        reason: 'At least one signer is required.',
      );
    }
    final data = _filledData ?? _buildData();
    // Sui signs blake2b256(intent || tx): the 3-byte intent prefix
    // (TransactionData/V0/Sui) must wrap the BCS or the node rejects the
    // signature. The account hashes internally.
    final intentBytes =
        SuiIntentMessage.transactionData(transaction: data).toBcs();
    final signatures = <List<int>>[];
    for (final signer in params.signers) {
      final signature = signer.signTransaction(intentBytes);
      signatures.add(signature.toVariantBcs());
    }
    final signed = SuiSenderSignedTransaction(
      intentMessage: SuiIntentMessage.transactionData(transaction: data),
      signatures: signatures,
    );
    // Execute takes TransactionData BCS (unsigned envelope) + separate
    // signatures — NOT the sender-signed envelope BCS.
    final encoded = B64Encoder.encode(data.toVariantBcs());
    final result = SuiSignedTransactionResult(
      signedTransaction: signed,
      txBytes: encoded,
      digest: data.txHash(),
    );
    _signedResult = result;
    _phase = TxBuilderPhase.signed;
    return result;
  }

  @override
  Future<SuiFinalizedTransactionResult> finalizeTransaction({
    SuiFinalizeTransactionParams? params,
  }) async {
    final signed = _signedResult;
    if (signed == null) {
      throw OnChainErrors.suiTx(
        'finalizeTransaction',
        reason: 'Call signTransaction() before finalizeTransaction().',
      );
    }
    _phase = TxBuilderPhase.finalized;
    return SuiFinalizedTransactionResult(
      signedTransaction: signed.signedTransaction,
      txBytes: signed.txBytes,
      digest: signed.digest,
    );
  }

  @override
  Future<SuiSubmitTransactionResult> submit({
    SuiSubmitTransactionParams? params,
  }) async {
    if (_phase != TxBuilderPhase.signed && _phase != TxBuilderPhase.finalized) {
      throw OnChainErrors.suiTx(
        'submit',
        reason: 'Call finalizeTransaction() before submit().',
      );
    }
    final client = _requireClient('submit');
    final signed = _signedResult;
    if (signed == null) {
      throw OnChainErrors.suiTx('submit', reason: 'Nothing signed to submit.');
    }
    final signatures =
        signed.signedTransaction.signatures
            .map((e) => SuiBaseSignature.deserialize(e.toList()))
            .toList();
    // The execute endpoint takes flag||signature||pubkey per signature in
    // BCS variant form, which the account objects already produce.
    final response = await client.executeTransaction(
      txBytes: signed.txBytes,
      signatures: signatures,
    );
    return SuiSubmitTransactionResult(
      response: response,
      digest: response.transaction?.digest ?? signed.digest,
    );
  }
}

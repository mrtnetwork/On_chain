import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/address/src/address.dart';
import 'package:on_chain/hedera/src/crypto/crypto.dart';
import 'package:on_chain/hedera/src/rpc/api/api.dart';
import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/transaction/signer/transaction_body_signers.dart';
import 'package:on_chain/hedera/src/transaction/types/types.dart';
import 'package:on_chain/hedera/src/transaction/utils/utils.dart';
import 'package:on_chain/hedera/src/transaction/utils/validation.dart';
import 'package:on_chain/hedera/src/transaction/fee/fee.dart';
import 'package:on_chain/solidity/contract/contract_abi.dart';
import 'package:on_chain/transaction/transaction.dart';

class HederaTransactionBuilder implements IHederaTxBuilder {
  final HederaClient client;
  final HederaFeeCalculatorLike feeCalculator;
  final AmountConverter amountConverter = AmountConverter.hdra;
  late final HederaTransactionBuilderUtils utils;
  TxBodySignerLookupParams? _lockupSignerParams;

  HederaTransactionBuilder(
    this.client, {
    HederaFeeCalculatorLike? feeCalculator,
  }) : feeCalculator = feeCalculator ?? HederaFeeCalculator(client: client) {
    utils = HederaTransactionBuilderUtils(
      client: client,
      feeCalculator: this.feeCalculator,
    );
  }

  TxBuilderPhase _phase = TxBuilderPhase.building;
  @override
  TxBuilderPhase get phase => _phase;

  HederaTransactionBody? _filledBody;
  HederaSignedTransactionResult? _signedResult;
  HederaTransaction? _finalizedTransaction;

  bool get isFilled =>
      _phase == TxBuilderPhase.filled ||
      _phase == TxBuilderPhase.signed ||
      _phase == TxBuilderPhase.finalized;
  bool get isSigned =>
      _phase == TxBuilderPhase.signed || _phase == TxBuilderPhase.finalized;
  bool get isFinalized => _phase == TxBuilderPhase.finalized;

  // ── envelope ─────────────────────────────────────────────────────────────
  HederaTransactionID? _transactionID;
  HederaAccountID? _nodeAccountID;
  BigInt? _transactionFee;
  HederaDuration? _transactionValidDuration;
  bool _generateRecord = false;
  String? _txMemo;

  HederaTransactionID? get transactionID => _transactionID;
  BigInt? get transactionFee => _transactionFee;
  bool get generateRecord => _generateRecord;
  String? get txMemo => _txMemo;

  // ── body ─────────────────────────────────────────────────────────────────
  HederaCryptoTransferTransactionBody? _cryptoTransfer;
  HederaTransactionBody? _customBody;

  bool get _hasBody => _cryptoTransfer != null || _customBody != null;

  void clearState() {
    if (_phase == TxBuilderPhase.finalized) {
      throw OnChainErrors.hederaTx(
        'clearState',
        reason:
            'Transaction is already finalized. Create a new builder to change it.',
      );
    }
    _clearFillState();
  }

  void _clearFillState() {
    _filledBody = null;
    _signedResult = null;
    _finalizedTransaction = null;
    if (_phase != TxBuilderPhase.building) {
      _phase = TxBuilderPhase.building;
    }
  }

  void _onMutate() {
    if (_phase == TxBuilderPhase.signed || _phase == TxBuilderPhase.finalized) {
      throw OnChainErrors.hederaTx(
        'HederaTransactionBuilder',
        reason:
            'Transaction is already signed; cannot modify. '
            'Build a new transaction instead.',
      );
    }
    _clearFillState();
  }

  static HederaAddress? _addrFromAccountId(HederaAccountID? id) =>
      HederaTransactionBuilderUtils.addressFromAccountId(id);

  void addHbarTransfer({
    required BigInt amount,
    required HederaAddress account,
    HederaHookCall? prePostTxAllowanceHook,
    HederaHookCall? preTxAllowanceHook,
    bool? isApproval,
  }) {
    _onMutate();
    if (_customBody != null) {
      throw OnChainErrors.hederaTx(
        'addHbarTransfer',
        reason: 'Custom body already set via setTransactionBody / set*.',
      );
    }
    if (amount == BigInt.zero) {
      throw OnChainErrors.hederaTx(
        'addHbarTransfer',
        reason: 'Transfer amount cannot be zero',
      );
    }
    _cryptoTransfer ??= const HederaCryptoTransferTransactionBody();
    final current = _cryptoTransfer!.transfers ?? const HederaTransferList();
    final entry = HederaAccountAmount(
      amount: amount,
      accountID: account.toAccountId(),
      prePostTxAllowanceHook: prePostTxAllowanceHook,
      preTxAllowanceHook: preTxAllowanceHook,
      isApproval: isApproval,
    );
    _cryptoTransfer = _cryptoTransfer!.copyWith(
      transfers: current.copyWith(
        accountAmounts: [...current.accountAmounts, entry],
      ),
    );
  }

  void transferHbar({
    required HederaAddress from,
    required HederaAddress to,
    required BigInt amount,
  }) {
    if (amount <= BigInt.zero) {
      throw OnChainErrors.hederaTx(
        'transferHbar',
        reason: 'Amount must be positive.',
      );
    }
    addHbarTransfer(amount: -amount, account: from);
    addHbarTransfer(amount: amount, account: to);
  }

  void addTokenTransfer({
    required HederaTokenID token,
    required BigInt amount,
    required HederaAddress account,
    bool? isApproval,
  }) {
    _onMutate();
    if (_customBody != null) {
      throw OnChainErrors.hederaTx(
        'addTokenTransfer',
        reason: 'Custom body already set via setTransactionBody / set*.',
      );
    }
    if (amount == BigInt.zero) {
      throw OnChainErrors.hederaTx(
        'addTokenTransfer',
        reason: 'Amount cannot be zero.',
      );
    }
    _cryptoTransfer ??= const HederaCryptoTransferTransactionBody();
    final existing = List<HederaTokenTransferList>.from(
      _cryptoTransfer!.tokenTransfers,
    );
    final idx = existing.indexWhere(
      (t) =>
          t.token?.shardNum == token.shardNum &&
          t.token?.realmNum == token.realmNum &&
          t.token?.tokenNum == token.tokenNum,
    );
    final entry = HederaAccountAmount(
      amount: amount,
      accountID: account.toAccountId(),
      isApproval: isApproval,
    );
    if (idx >= 0) {
      final old = existing[idx];
      existing[idx] = old.copyWith(transfers: [...old.transfers, entry]);
    } else {
      existing.add(HederaTokenTransferList(token: token, transfers: [entry]));
    }
    _cryptoTransfer = _cryptoTransfer!.copyWith(tokenTransfers: existing);
  }

  void addNftTransfer({
    required HederaTokenID token,
    required BigInt serialNumber,
    required HederaAddress sender,
    required HederaAddress receiver,
    bool? isApproval,
  }) {
    _onMutate();
    if (_customBody != null) {
      throw OnChainErrors.hederaTx(
        'addNftTransfer',
        reason: 'Custom body already set via setTransactionBody / set*.',
      );
    }
    _cryptoTransfer ??= const HederaCryptoTransferTransactionBody();
    final existing = List<HederaTokenTransferList>.from(
      _cryptoTransfer!.tokenTransfers,
    );
    final nft = HederaNftTransfer(
      senderAccountID: sender.toAccountId(),
      receiverAccountID: receiver.toAccountId(),
      serialNumber: serialNumber,
      isApproval: isApproval,
    );
    final idx = existing.indexWhere((t) => t.token?.tokenNum == token.tokenNum);
    if (idx >= 0) {
      final old = existing[idx];
      existing[idx] = old.copyWith(nftTransfers: [...old.nftTransfers, nft]);
    } else {
      existing.add(HederaTokenTransferList(token: token, nftTransfers: [nft]));
    }
    _cryptoTransfer = _cryptoTransfer!.copyWith(tokenTransfers: existing);
  }

  /// Apply a full data [HederaTransactionBody]. Envelope fields are ignored.
  void setTransactionBody(HederaTransactionBody body) {
    _onMutate();
    if (_cryptoTransfer != null) {
      throw OnChainErrors.hederaTx(
        'setTransactionBody',
        reason: 'Crypto transfer helpers already used. Use a new builder.',
      );
    }
    if (_customBody != null) {
      throw OnChainErrors.hederaTx(
        'setTransactionBody',
        reason: 'A transaction body is already set.',
      );
    }
    if (!_bodyHasData(body)) {
      throw OnChainErrors.hederaTx(
        'setTransactionBody',
        reason: 'Transaction body has no data field set.',
      );
    }
    TransactionBuilderValidation.validateBody(body);
    _customBody = body;
  }

  static bool _bodyHasData(HederaTransactionBody b) {
    return b.cryptoTransfer != null ||
        b.cryptoCreateAccount != null ||
        b.cryptoUpdateAccount != null ||
        b.cryptoDelete != null ||
        b.cryptoApproveAllowance != null ||
        b.cryptoDeleteAllowance != null ||
        b.contractCall != null ||
        b.contractCreateInstance != null ||
        b.contractUpdateInstance != null ||
        b.contractDeleteInstance != null ||
        b.fileCreate != null ||
        b.fileAppend != null ||
        b.fileUpdate != null ||
        b.fileDelete != null ||
        b.systemDelete != null ||
        b.systemUndelete != null ||
        b.freeze != null ||
        b.consensusCreateTopic != null ||
        b.consensusUpdateTopic != null ||
        b.consensusDeleteTopic != null ||
        b.consensusSubmitMessage != null ||
        b.tokenCreation != null ||
        b.tokenUpdate != null ||
        b.tokenDeletion != null ||
        b.tokenMint != null ||
        b.tokenBurn != null ||
        b.tokenWipe != null ||
        b.tokenAssociate != null ||
        b.tokenDissociate != null ||
        b.tokenFreeze != null ||
        b.tokenUnfreeze != null ||
        b.tokenGrantKyc != null ||
        b.tokenRevokeKyc != null ||
        b.tokenPause != null ||
        b.tokenUnpause != null ||
        b.tokenFeeScheduleUpdate != null ||
        b.tokenUpdateNfts != null ||
        b.tokenReject != null ||
        b.tokenAirdrop != null ||
        b.tokenCancelAirdrop != null ||
        b.tokenClaimAirdrop != null ||
        b.scheduleCreate != null ||
        b.scheduleDelete != null ||
        b.scheduleSign != null ||
        b.ethereumTransaction != null ||
        b.utilPrng != null;
  }

  // ── Crypto account ───────────────────────────────────────────────────────

  void setCryptoCreateAccount({
    required HederaKey key,
    BigInt? initialBalance,
    bool? receiverSigRequired,
    HederaDuration? autoRenewPeriod,
    int? maxAutomaticTokenAssociations,
    HederaAccountID? stakedAccountId,
    BigInt? stakedNodeId,
    bool? declineReward,
    String? memo,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        cryptoCreateAccount: HederaCryptoCreateTransactionBody(
          key: key,
          initialBalance: initialBalance ?? BigInt.zero,
          receiverSigRequired: receiverSigRequired ?? false,
          autoRenewPeriod: autoRenewPeriod,
          memo: memo,
          maxAutomaticTokenAssociations: maxAutomaticTokenAssociations,
          stakedAccountId: stakedAccountId,
          stakedNodeId: stakedNodeId,
          declineReward: declineReward,
        ),
      ),
    );
  }

  void setCryptoUpdateAccount({
    required HederaAddress accountToUpdate,
    HederaKey? key,
    HederaDuration? autoRenewPeriod,
    bool? receiverSigRequired,
    int? maxAutomaticTokenAssociations,
    HederaAccountID? stakedAccountId,
    BigInt? stakedNodeId,
    bool? declineReward,
    String? memo,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        cryptoUpdateAccount: HederaCryptoUpdateTransactionBody(
          accountIDToUpdate: accountToUpdate.toAccoutId(),
          key: key,
          autoRenewPeriod: autoRenewPeriod,
          receiverSigRequired: receiverSigRequired,
          memo: memo == null ? null : HederaStringValue(value: memo),
          maxAutomaticTokenAssociations:
              maxAutomaticTokenAssociations == null
                  ? null
                  : HederaInt32Value(value: maxAutomaticTokenAssociations),
          stakedAccountId: stakedAccountId,
          stakedNodeId: stakedNodeId,
          declineReward:
              declineReward == null
                  ? null
                  : HederaBoolValue(value: declineReward),
        ),
      ),
    );
  }

  void setCryptoDelete({
    required HederaAddress accountToDelete,
    required HederaAddress transferAccount,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        cryptoDelete: HederaCryptoDeleteTransactionBody(
          deleteAccountID: accountToDelete.toAccoutId(),
          transferAccountID: transferAccount.toAccoutId(),
        ),
      ),
    );
  }

  void setCryptoApproveAllowance({
    List<HederaCryptoAllowance>? cryptoAllowances,
    List<HederaTokenAllowance>? tokenAllowances,
    List<HederaNftAllowance>? nftAllowances,
  }) {
    final hasCrypto = cryptoAllowances != null && cryptoAllowances.isNotEmpty;
    final hasToken = tokenAllowances != null && tokenAllowances.isNotEmpty;
    final hasNft = nftAllowances != null && nftAllowances.isNotEmpty;
    if (!hasCrypto && !hasToken && !hasNft) {
      throw OnChainErrors.hederaTx(
        'setCryptoApproveAllowance',
        reason: 'At least one allowance list must be non-empty',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        cryptoApproveAllowance: HederaCryptoApproveAllowanceTransactionBody(
          cryptoAllowances: cryptoAllowances ?? const [],
          tokenAllowances: tokenAllowances ?? const [],
          nftAllowances: nftAllowances ?? const [],
        ),
      ),
    );
  }

  void setCryptoDeleteAllowance({
    required List<HederaNftRemoveAllowance> nftAllowances,
  }) {
    if (nftAllowances.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setCryptoDeleteAllowance',
        reason: 'NftAllowances cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        cryptoDeleteAllowance: HederaCryptoDeleteAllowanceTransactionBody(
          nftAllowances: nftAllowances,
        ),
      ),
    );
  }

  // ── Contract (sync set + async prepare helpers) ──────────────────────────

  /// Sync: apply a complete [HederaContractCallTransactionBody]
  /// (use [prepareContractCall] when gas must be estimated).
  void setContractCall(HederaContractCallTransactionBody body) {
    if (body.contractID == null) {
      throw OnChainErrors.hederaTx(
        'setContractCall',
        reason: 'ContractID is required.',
      );
    }
    setTransactionBody(HederaTransactionBody(contractCall: body));
  }

  void setContractCallFields({
    required HederaContractID contractID,
    required BigInt gas,
    BigInt? amount,
    List<int>? functionParameters,
  }) {
    if (amount != null && amount.isNegative) {
      throw OnChainErrors.hederaTx(
        'setContractCallFields',
        reason: 'Amount cannot be negative.',
      );
    }
    setContractCall(
      HederaContractCallTransactionBody(
        contractID: contractID,
        gas: gas,
        amount: amount,
        functionParameters: functionParameters,
      ),
    );
  }

  /// Async helper — estimates gas and returns a complete call body.
  Future<HederaPrepareContractCallTransactionBody> prepareContractCall({
    required HederaContractID contractID,
    BigInt? gas,
    BigInt? amount,
    List<int>? functionParameters,
    HederaAddress? gasEstimateFrom,
    double gasSafetyMultiplier = 1.2,
  }) async {
    if (amount != null && amount.isNegative) {
      throw OnChainErrors.hederaTx(
        'prepareContractCall',
        reason: 'Amount cannot be negative.',
      );
    }
    final resolvedGas = await utils.resolveContractCallGas(
      contractID: contractID,
      gas: gas,
      functionParameters: functionParameters,
      gasEstimateFrom: gasEstimateFrom,
      amount: amount,
      gasSafetyMultiplier: gasSafetyMultiplier,
    );
    return HederaPrepareContractCallTransactionBody(
      body: HederaContractCallTransactionBody(
        contractID: contractID,
        gas: resolvedGas.gasEstimate,
        amount: amount,
        functionParameters: functionParameters,
      ),
      estimateResult: resolvedGas,
    );
  }

  Future<HederaPrepareContractCallTransactionBody> prepareContractCallWithAbi({
    required HederaContractID contractID,
    required ContractABI abi,
    required String functionName,
    required List<dynamic> params,
    BigInt? gas,
    BigInt? amount,
    HederaAddress? gasEstimateFrom,
    double gasSafetyMultiplier = 1.2,
  }) async {
    final encoded = HederaTransactionBuilderUtils.encodeFunctionCall(
      abi: abi,
      functionName: functionName,
      params: params,
    );
    final result = await prepareContractCall(
      contractID: contractID,
      gas: gas,
      amount: amount,
      functionParameters: encoded,
      gasEstimateFrom: gasEstimateFrom,
      gasSafetyMultiplier: gasSafetyMultiplier,
    );
    return HederaPrepareContractCallTransactionBody(
      body: result.body,
      estimateResult: result.estimateResult?.copyWith(
        result: HederaTransactionBuilderUtils.decodeFunctionCall(
          abi: abi,
          functionName: functionName,
          result: result.estimateResult?.resultHex,
        ),
      ),
    );
  }

  void setContractCreate(HederaContractCreateTransactionBody body) {
    if (body.fileID == null &&
        (body.initcode == null || body.initcode!.isEmpty)) {
      throw OnChainErrors.hederaTx(
        'setContractCreate',
        reason: 'Either fileID or initcode is required',
      );
    }
    setTransactionBody(HederaTransactionBody(contractCreateInstance: body));
  }

  Future<HederaPrepareContractCreateTransactionBody> prepareContractCreate({
    HederaFileID? fileID,
    List<int>? initcode,
    HederaKey? adminKey,
    BigInt? gas,
    BigInt? initialBalance,
    HederaDuration? autoRenewPeriod,
    List<int>? constructorParameters,
    String? memo,
    int? maxAutomaticTokenAssociations,
    HederaAccountID? autoRenewAccountId,
    HederaAccountID? stakedAccountId,
    BigInt? stakedNodeId,
    bool? declineReward,
    HederaAddress? gasEstimateFrom,
    double gasSafetyMultiplier = 1.2,

    /// Local creation bytecode for mirror gas estimate when using [fileID]
    /// (not written into the transaction body).
    List<int>? gasEstimateBytecode,
  }) async {
    if (fileID == null && (initcode == null || initcode.isEmpty)) {
      throw OnChainErrors.hederaTx(
        'prepareContractCreate',
        reason: 'Either fileID or initcode is required',
      );
    }
    List<int>? estimateCode = initcode;
    if ((estimateCode == null || estimateCode.isEmpty) &&
        gasEstimateBytecode != null &&
        gasEstimateBytecode.isNotEmpty) {
      estimateCode = [...gasEstimateBytecode, ...?constructorParameters];
    }
    final resolvedGas = await utils.resolveContractCreateGas(
      gas: gas,
      initcode: estimateCode,
      gasEstimateFrom: gasEstimateFrom,
      initialBalance: initialBalance,
      gasSafetyMultiplier: gasSafetyMultiplier,
    );
    return HederaPrepareContractCreateTransactionBody(
      estimateResult: resolvedGas,
      body: HederaContractCreateTransactionBody(
        fileID: fileID,
        initcode: initcode,
        adminKey: adminKey,
        gas: resolvedGas.gasEstimate,
        initialBalance: initialBalance ?? BigInt.zero,
        autoRenewPeriod: autoRenewPeriod,
        constructorParameters: constructorParameters,
        memo: memo,
        maxAutomaticTokenAssociations: maxAutomaticTokenAssociations,
        autoRenewAccountId: autoRenewAccountId,
        stakedAccountId: stakedAccountId,
        stakedNodeId: stakedNodeId,
        declineReward: declineReward,
      ),
    );
  }

  /// Prepare a contract-create body with ABI-encoded constructor args.
  ///
  /// - Inline: pass [bytecode] only → `initcode = bytecode || encode(ctor)`
  /// - File: pass [fileID] (+ optional [bytecode] for mirror gas estimate)
  ///   → body uses `fileID` + `constructorParameters` only
  Future<HederaPrepareContractCreateTransactionBody>
  prepareContractCreateWithAbi({
    List<int>? bytecode,
    HederaFileID? fileID,
    required ContractABI abi,
    required List<dynamic> constructorParams,
    BigInt? gas,
    HederaKey? adminKey,
    BigInt? initialBalance,
    HederaDuration? autoRenewPeriod,
    String? memo,
    int? maxAutomaticTokenAssociations,
    HederaAccountID? autoRenewAccountId,
    HederaAccountID? stakedAccountId,
    BigInt? stakedNodeId,
    bool? declineReward,
    HederaAddress? gasEstimateFrom,
    double gasSafetyMultiplier = 1.2,
  }) async {
    final hasBytecode = bytecode != null && bytecode.isNotEmpty;
    final hasFile = fileID != null;
    if (!hasFile && !hasBytecode) {
      throw OnChainErrors.hederaTx(
        'prepareContractCreateWithAbi',
        reason: 'Provide bytecode and/or fileID',
      );
    }

    final ctorArgs = HederaTransactionBuilderUtils.encodeConstructor(
      abi: abi,
      params: constructorParams,
    );

    if (hasFile) {
      // Body uses fileID; pass local bytecode so gas can be estimated on mirror.
      return prepareContractCreate(
        fileID: fileID,
        constructorParameters: ctorArgs,
        adminKey: adminKey,
        gas: gas,
        initialBalance: initialBalance,
        autoRenewPeriod: autoRenewPeriod,
        memo: memo,
        maxAutomaticTokenAssociations: maxAutomaticTokenAssociations,
        autoRenewAccountId: autoRenewAccountId,
        stakedAccountId: stakedAccountId,
        stakedNodeId: stakedNodeId,
        declineReward: declineReward,
        gasEstimateFrom: gasEstimateFrom,
        gasSafetyMultiplier: gasSafetyMultiplier,
        gasEstimateBytecode: hasBytecode ? bytecode : null,
      );
    }

    final initcode = [...bytecode!, ...ctorArgs];
    return prepareContractCreate(
      initcode: initcode,
      adminKey: adminKey,
      gas: gas,
      initialBalance: initialBalance,
      autoRenewPeriod: autoRenewPeriod,
      memo: memo,
      maxAutomaticTokenAssociations: maxAutomaticTokenAssociations,
      autoRenewAccountId: autoRenewAccountId,
      stakedAccountId: stakedAccountId,
      stakedNodeId: stakedNodeId,
      declineReward: declineReward,
      gasEstimateFrom: gasEstimateFrom,
      gasSafetyMultiplier: gasSafetyMultiplier,
    );
  }

  void setContractUpdate({
    required HederaContractID contractID,
    HederaKey? adminKey,
    HederaDuration? autoRenewPeriod,
    HederaFileID? fileID,
    String? memo,
    HederaAccountID? autoRenewAccountId,
    HederaAccountID? stakedAccountId,
    BigInt? stakedNodeId,
    bool? declineReward,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        contractUpdateInstance: HederaContractUpdateTransactionBody(
          contractID: contractID,
          adminKey: adminKey,
          autoRenewPeriod: autoRenewPeriod,
          fileID: fileID,
          memo: memo,
          autoRenewAccountId: autoRenewAccountId,
          stakedAccountId: stakedAccountId,
          stakedNodeId: stakedNodeId,
        ),
      ),
    );
  }

  void setContractDelete({
    required HederaContractID contractID,
    HederaAccountID? transferAccountID,
    HederaContractID? transferContractID,
    bool? permanentRemoval,
  }) {
    if (transferAccountID == null && transferContractID == null) {
      throw OnChainErrors.hederaTx(
        'setContractDelete',
        reason: 'Either transferAccountID or transferContractID is required',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        contractDeleteInstance: HederaContractDeleteTransactionBody(
          contractID: contractID,
          transferAccountID: transferAccountID,
          transferContractID: transferContractID,
          permanentRemoval: permanentRemoval,
        ),
      ),
    );
  }

  // ── File / system ────────────────────────────────────────────────────────

  void setFileCreate({
    required List<int> contents,
    required DateTime expirationTime,
    HederaKeyList? keys,
    String? memo,
  }) {
    if (contents.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setFileCreate',
        reason: 'Contents cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        fileCreate: HederaFileCreateTransactionBody(
          contents: contents,
          keys: keys,
          memo: memo,
          expirationTime: HederaTimestamp(
            seconds: BigInt.from(expirationTime.millisecondsSinceEpoch ~/ 1000),
            nanos:
                (expirationTime.millisecond * 1000000) +
                (expirationTime.microsecond * 1000),
          ),
        ),
      ),
    );
  }

  void setFileAppend({
    required HederaFileID fileID,
    required List<int> contents,
  }) {
    if (contents.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setFileAppend',
        reason: 'Contents cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        fileAppend: HederaFileAppendTransactionBody(
          fileID: fileID,
          contents: contents,
        ),
      ),
    );
  }

  void setFileUpdate({
    required HederaFileID fileID,
    List<int>? contents,
    HederaKeyList? keys,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        fileUpdate: HederaFileUpdateTransactionBody(
          fileID: fileID,
          contents: contents,
          keys: keys,
        ),
      ),
    );
  }

  void setFileDelete({required HederaFileID fileID}) {
    setTransactionBody(
      HederaTransactionBody(
        fileDelete: HederaFileDeleteTransactionBody(fileID: fileID),
      ),
    );
  }

  void setSystemDelete({
    HederaFileID? fileID,
    HederaContractID? contractID,
    HederaTimestampSeconds? expirationTime,
  }) {
    if (fileID == null && contractID == null) {
      throw OnChainErrors.hederaTx(
        'setSystemDelete',
        reason: 'FileID or contractID required.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        systemDelete: HederaSystemDeleteTransactionBody(
          fileID: fileID,
          contractID: contractID,
          expirationTime: expirationTime,
        ),
      ),
    );
  }

  void setSystemUndelete({HederaFileID? fileID, HederaContractID? contractID}) {
    if (fileID == null && contractID == null) {
      throw OnChainErrors.hederaTx(
        'setSystemUndelete',
        reason: 'FileID or contractID required.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        systemUndelete: HederaSystemUndeleteTransactionBody(
          fileID: fileID,
          contractID: contractID,
        ),
      ),
    );
  }

  void setFreeze({
    required HederaFreezeType freezeType,
    HederaTimestamp? startTime,
    HederaFileID? updateFile,
    List<int>? fileHash,
  }) {
    if (updateFile != null && (fileHash == null || fileHash.isEmpty)) {
      throw OnChainErrors.hederaTx(
        'setFreeze',
        reason: 'FileHash (SHA384) is required when updateFile is set.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        freeze: HederaFreezeTransactionBody(
          freezeType: freezeType,
          startTime: startTime,
          updateFile: updateFile,
          fileHash: fileHash,
        ),
      ),
    );
  }

  // ── Consensus ────────────────────────────────────────────────────────────

  void setConsensusCreateTopic({
    String? memo,
    HederaKey? adminKey,
    HederaKey? submitKey,
    HederaDuration? autoRenewPeriod,
    HederaAccountID? autoRenewAccount,
    HederaKey? feeScheduleKey,
    List<HederaKey>? feeExemptKeyList,
    List<HederaFixedCustomFee>? customFees,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        consensusCreateTopic: HederaConsensusCreateTopicTransactionBody(
          memo: memo,
          adminKey: adminKey,
          submitKey: submitKey,
          autoRenewPeriod: autoRenewPeriod,
          autoRenewAccount: autoRenewAccount,
          feeScheduleKey: feeScheduleKey,
          feeExemptKeyList: feeExemptKeyList ?? const [],
          customFees: customFees ?? const [],
        ),
      ),
    );
  }

  void setConsensusUpdateTopic({
    required HederaTopicID topicID,
    String? memo,
    HederaKey? adminKey,
    HederaKey? submitKey,
    HederaDuration? autoRenewPeriod,
    HederaAccountID? autoRenewAccount,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        consensusUpdateTopic: HederaConsensusUpdateTopicTransactionBody(
          topicID: topicID,
          memo: memo == null ? null : HederaStringValue(value: memo),
          adminKey: adminKey,
          submitKey: submitKey,
          autoRenewPeriod: autoRenewPeriod,
          autoRenewAccount: autoRenewAccount,
        ),
      ),
    );
  }

  void setConsensusDeleteTopic({required HederaTopicID topicID}) {
    setTransactionBody(
      HederaTransactionBody(
        consensusDeleteTopic: HederaConsensusDeleteTopicTransactionBody(
          topicID: topicID,
        ),
      ),
    );
  }

  void setConsensusSubmitMessage({
    required HederaTopicID topicID,
    required List<int> message,
    HederaConsensusMessageChunkInfo? chunkInfo,
  }) {
    if (message.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setConsensusSubmitMessage',
        reason: 'Message cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        consensusSubmitMessage: HederaConsensusSubmitMessageTransactionBody(
          topicID: topicID,
          message: message,
          chunkInfo: chunkInfo,
        ),
      ),
    );
  }

  // ── Token ────────────────────────────────────────────────────────────────

  void setTokenCreate({
    required String name,
    required String symbol,
    required int decimals,
    required BigInt initialSupply,
    required HederaAddress treasury,
    HederaKey? adminKey,
    HederaKey? kycKey,
    HederaKey? freezeKey,
    HederaKey? wipeKey,
    HederaKey? supplyKey,
    HederaKey? feeScheduleKey,
    HederaKey? pauseKey,
    HederaKey? metadataKey,
    bool? freezeDefault,
    HederaAddress? autoRenewAccount,
    HederaDuration? autoRenewPeriod,
    String? memo,
    HederaTokenType? tokenType,
    HederaTokenSupplyType? supplyType,
    BigInt? maxSupply,
    List<HederaCustomFee>? customFees,
    List<int>? metadata,
  }) {
    if (name.isEmpty || symbol.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setTokenCreate',
        reason: 'Name and symbol are required.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        tokenCreation: HederaTokenCreateTransactionBody(
          name: name,
          symbol: symbol,
          decimals: decimals,
          initialSupply: initialSupply,
          treasury: treasury.toAccoutId(),
          adminKey: adminKey,
          kycKey: kycKey,
          freezeKey: freezeKey,
          wipeKey: wipeKey,
          supplyKey: supplyKey,
          feeScheduleKey: feeScheduleKey,
          pauseKey: pauseKey,
          metadataKey: metadataKey,
          freezeDefault: freezeDefault,
          autoRenewAccount: autoRenewAccount?.toAccoutId(),
          autoRenewPeriod: autoRenewPeriod,
          memo: memo,
          tokenType: tokenType,
          supplyType: supplyType,
          maxSupply: maxSupply,
          customFees: customFees ?? const [],
          metadata: metadata,
        ),
      ),
    );
  }

  void setTokenUpdate({
    required HederaTokenID token,
    String? name,
    String? symbol,
    HederaAddress? treasury,
    HederaKey? adminKey,
    HederaKey? kycKey,
    HederaKey? freezeKey,
    HederaKey? wipeKey,
    HederaKey? supplyKey,
    HederaKey? feeScheduleKey,
    HederaKey? pauseKey,
    HederaKey? metadataKey,
    HederaAddress? autoRenewAccount,
    HederaDuration? autoRenewPeriod,
    String? memo,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        tokenUpdate: HederaTokenUpdateTransactionBody(
          token: token,
          name: name,
          symbol: symbol,
          treasury: treasury?.toAccoutId(),
          adminKey: adminKey,
          kycKey: kycKey,
          freezeKey: freezeKey,
          wipeKey: wipeKey,
          supplyKey: supplyKey,
          feeScheduleKey: feeScheduleKey,
          pauseKey: pauseKey,
          metadataKey: metadataKey,
          autoRenewAccount: autoRenewAccount?.toAccoutId(),
          autoRenewPeriod: autoRenewPeriod,
          memo: memo == null ? null : HederaStringValue(value: memo),
        ),
      ),
    );
  }

  void setTokenDelete({required HederaTokenID token}) {
    setTransactionBody(
      HederaTransactionBody(
        tokenDeletion: HederaTokenDeleteTransactionBody(token: token),
      ),
    );
  }

  void setTokenMint({
    required HederaTokenID token,
    BigInt? amount,
    List<List<int>>? metadata,
  }) {
    final hasAmount = amount != null && amount > BigInt.zero;
    final hasMeta = metadata != null && metadata.isNotEmpty;
    if (!hasAmount && !hasMeta) {
      throw OnChainErrors.hederaTx(
        'setTokenMint',
        reason: 'Amount or metadata required.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        tokenMint: HederaTokenMintTransactionBody(
          token: token,
          amount: amount,
          metadata: metadata ?? const [],
        ),
      ),
    );
  }

  void setTokenBurn({
    required HederaTokenID token,
    BigInt? amount,
    List<BigInt>? serialNumbers,
  }) {
    final hasAmount = amount != null && amount > BigInt.zero;
    final hasSerials = serialNumbers != null && serialNumbers.isNotEmpty;
    if (!hasAmount && !hasSerials) {
      throw OnChainErrors.hederaTx(
        'setTokenBurn',
        reason: 'Amount or serialNumbers required.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        tokenBurn: HederaTokenBurnTransactionBody(
          token: token,
          amount: amount,
          serialNumbers: serialNumbers ?? const [],
        ),
      ),
    );
  }

  void setTokenWipe({
    required HederaTokenID token,
    required HederaAddress account,
    BigInt? amount,
    List<BigInt>? serialNumbers,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        tokenWipe: HederaTokenWipeAccountTransactionBody(
          token: token,
          account: account.toAccoutId(),
          amount: amount,
          serialNumbers: serialNumbers ?? const [],
        ),
      ),
    );
  }

  void setTokenAssociate({
    required HederaAddress account,
    required List<HederaTokenID> tokens,
  }) {
    if (tokens.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setTokenAssociate',
        reason: 'Tokens cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        tokenAssociate: HederaTokenAssociateTransactionBody(
          account: account.toAccoutId(),
          tokens: tokens,
        ),
      ),
    );
  }

  void setTokenDissociate({
    required HederaAddress account,
    required List<HederaTokenID> tokens,
  }) {
    if (tokens.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setTokenDissociate',
        reason: 'Tokens cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        tokenDissociate: HederaTokenDissociateTransactionBody(
          account: account.toAccoutId(),
          tokens: tokens,
        ),
      ),
    );
  }

  void setTokenFreeze({
    required HederaTokenID token,
    required HederaAddress account,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        tokenFreeze: HederaTokenFreezeAccountTransactionBody(
          token: token,
          account: account.toAccoutId(),
        ),
      ),
    );
  }

  void setTokenUnfreeze({
    required HederaTokenID token,
    required HederaAddress account,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        tokenUnfreeze: HederaTokenUnfreezeAccountTransactionBody(
          token: token,
          account: account.toAccoutId(),
        ),
      ),
    );
  }

  void setTokenGrantKyc({
    required HederaTokenID token,
    required HederaAddress account,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        tokenGrantKyc: HederaTokenGrantKycTransactionBody(
          token: token,
          account: account.toAccoutId(),
        ),
      ),
    );
  }

  void setTokenRevokeKyc({
    required HederaTokenID token,
    required HederaAddress account,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        tokenRevokeKyc: HederaTokenRevokeKycTransactionBody(
          token: token,
          account: account.toAccoutId(),
        ),
      ),
    );
  }

  void setTokenPause({required HederaTokenID token}) {
    setTransactionBody(
      HederaTransactionBody(
        tokenPause: HederaTokenPauseTransactionBody(token: token),
      ),
    );
  }

  void setTokenUnpause({required HederaTokenID token}) {
    setTransactionBody(
      HederaTransactionBody(
        tokenUnpause: HederaTokenUnpauseTransactionBody(token: token),
      ),
    );
  }

  void setTokenFeeScheduleUpdate({
    required HederaTokenID tokenId,
    required List<HederaCustomFee> customFees,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        tokenFeeScheduleUpdate: HederaTokenFeeScheduleUpdateTransactionBody(
          tokenId: tokenId,
          customFees: customFees,
        ),
      ),
    );
  }

  void setTokenUpdateNfts({
    required HederaTokenID token,
    required List<BigInt> serialNumbers,
    List<int>? metadata,
  }) {
    if (serialNumbers.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setTokenUpdateNfts',
        reason: 'SerialNumbers cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        tokenUpdateNfts: HederaTokenUpdateNftsTransactionBody(
          token: token,
          serialNumbers: serialNumbers,
          metadata: metadata == null ? null : HederaBytesValue(value: metadata),
        ),
      ),
    );
  }

  void setTokenReject({
    required HederaAddress owner,
    required List<HederaTokenReference> rejections,
  }) {
    if (rejections.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setTokenReject',
        reason: 'Rejections cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        tokenReject: HederaTokenRejectTransactionBody(
          owner: owner.toAccoutId(),
          rejections: rejections,
        ),
      ),
    );
  }

  void setTokenAirdrop({
    required List<HederaTokenTransferList> tokenTransfers,
  }) {
    if (tokenTransfers.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setTokenAirdrop',
        reason: 'TokenTransfers cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        tokenAirdrop: HederaTokenAirdropTransactionBody(
          tokenTransfers: tokenTransfers,
        ),
      ),
    );
  }

  void setTokenCancelAirdrop({
    required List<HederaPendingAirdropId> pendingAirdrops,
  }) {
    if (pendingAirdrops.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setTokenCancelAirdrop',
        reason: 'PendingAirdrops cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        tokenCancelAirdrop: HederaTokenCancelAirdropTransactionBody(
          pendingAirdrops: pendingAirdrops,
        ),
      ),
    );
  }

  void setTokenClaimAirdrop({
    required List<HederaPendingAirdropId> pendingAirdrops,
  }) {
    if (pendingAirdrops.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setTokenClaimAirdrop',
        reason: 'PendingAirdrops cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        tokenClaimAirdrop: HederaTokenClaimAirdropTransactionBody(
          pendingAirdrops: pendingAirdrops,
        ),
      ),
    );
  }

  // ── Schedule / ethereum / util ───────────────────────────────────────────

  void setScheduleCreate({
    required HederaSchedulableTransactionBody scheduledTransactionBody,
    String? memo,
    HederaKey? adminKey,
    HederaAccountID? payerAccountID,
    HederaTimestamp? expirationTime,
    bool? waitForExpiry,
  }) {
    setTransactionBody(
      HederaTransactionBody(
        scheduleCreate: HederaScheduleCreateTransactionBody(
          scheduledTransactionBody: scheduledTransactionBody,
          memo: memo,
          adminKey: adminKey,
          payerAccountID: payerAccountID,
          expirationTime: expirationTime,
          waitForExpiry: waitForExpiry,
        ),
      ),
    );
  }

  void setScheduleDelete({required HederaScheduleID scheduleID}) {
    setTransactionBody(
      HederaTransactionBody(
        scheduleDelete: HederaScheduleDeleteTransactionBody(
          scheduleID: scheduleID,
        ),
      ),
    );
  }

  void setScheduleSign({required HederaScheduleID scheduleID}) {
    setTransactionBody(
      HederaTransactionBody(
        scheduleSign: HederaScheduleSignTransactionBody(scheduleID: scheduleID),
      ),
    );
  }

  void setEthereumTransaction({
    required List<int> ethereumData,
    HederaFileID? callData,
    BigInt? maxGasAllowance,
  }) {
    if (ethereumData.isEmpty) {
      throw OnChainErrors.hederaTx(
        'setEthereumTransaction',
        reason: 'EthereumData cannot be empty.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        ethereumTransaction: HederaEthereumTransactionBody(
          ethereumData: ethereumData,
          callData: callData,
          maxGasAllowance: maxGasAllowance,
        ),
      ),
    );
  }

  void setUtilPrng({int? range}) {
    if (range != null && range <= 0) {
      throw OnChainErrors.hederaTx(
        'setUtilPrng',
        reason: 'Range must be > 0 when set.',
      );
    }
    setTransactionBody(
      HederaTransactionBody(
        utilPrng: HederaUtilPrngTransactionBody(range: range),
      ),
    );
  }

  // ===========================================================================
  // Assemble body (sync core)
  // ===========================================================================

  HederaOnchainTransaction _getTransactionSync() {
    if (!_hasBody) {
      throw OnChainErrors.hederaTx(
        'getTransaction',
        reason:
            'No transaction body. Use crypto transfer helpers or set* methods.',
      );
    }

    final HederaTransactionBody body;
    if (_customBody != null) {
      final c = _customBody!;
      body = HederaTransactionBody(
        transactionID: _transactionID,
        nodeAccountID: _nodeAccountID,
        transactionFee: _transactionFee,
        transactionValidDuration:
            _transactionValidDuration ??
            HederaDuration(seconds: BigInt.from(120)),
        generateRecord: _generateRecord,
        memo: _txMemo,
        contractCall: c.contractCall,
        contractCreateInstance: c.contractCreateInstance,
        contractUpdateInstance: c.contractUpdateInstance,
        contractDeleteInstance: c.contractDeleteInstance,
        cryptoCreateAccount: c.cryptoCreateAccount,
        cryptoDelete: c.cryptoDelete,
        cryptoTransfer: c.cryptoTransfer,
        cryptoUpdateAccount: c.cryptoUpdateAccount,
        cryptoApproveAllowance: c.cryptoApproveAllowance,
        cryptoDeleteAllowance: c.cryptoDeleteAllowance,
        fileAppend: c.fileAppend,
        fileCreate: c.fileCreate,
        fileDelete: c.fileDelete,
        fileUpdate: c.fileUpdate,
        systemDelete: c.systemDelete,
        systemUndelete: c.systemUndelete,
        freeze: c.freeze,
        consensusCreateTopic: c.consensusCreateTopic,
        consensusUpdateTopic: c.consensusUpdateTopic,
        consensusDeleteTopic: c.consensusDeleteTopic,
        consensusSubmitMessage: c.consensusSubmitMessage,
        tokenCreation: c.tokenCreation,
        tokenFreeze: c.tokenFreeze,
        tokenUnfreeze: c.tokenUnfreeze,
        tokenGrantKyc: c.tokenGrantKyc,
        tokenRevokeKyc: c.tokenRevokeKyc,
        tokenDeletion: c.tokenDeletion,
        tokenUpdate: c.tokenUpdate,
        tokenMint: c.tokenMint,
        tokenBurn: c.tokenBurn,
        tokenWipe: c.tokenWipe,
        tokenAssociate: c.tokenAssociate,
        tokenDissociate: c.tokenDissociate,
        tokenFeeScheduleUpdate: c.tokenFeeScheduleUpdate,
        tokenPause: c.tokenPause,
        tokenUnpause: c.tokenUnpause,
        tokenUpdateNfts: c.tokenUpdateNfts,
        tokenReject: c.tokenReject,
        tokenAirdrop: c.tokenAirdrop,
        tokenCancelAirdrop: c.tokenCancelAirdrop,
        tokenClaimAirdrop: c.tokenClaimAirdrop,
        scheduleCreate: c.scheduleCreate,
        scheduleDelete: c.scheduleDelete,
        scheduleSign: c.scheduleSign,
        ethereumTransaction: c.ethereumTransaction,
        utilPrng: c.utilPrng,
      );
    } else {
      body = HederaTransactionBody(
        transactionID: _transactionID,
        nodeAccountID: _nodeAccountID,
        transactionFee: _transactionFee,
        transactionValidDuration:
            _transactionValidDuration ??
            HederaDuration(seconds: BigInt.from(120)),
        generateRecord: _generateRecord,
        memo: _txMemo,
        cryptoTransfer: _cryptoTransfer,
      );
    }
    TransactionBuilderValidation.validateBody(body);
    return HederaOnchainTransaction(body);
  }

  @override
  Future<HederaOnchainTransaction> getTransaction({
    HederaGetTransactionParams? params,
  }) async {
    return _getTransactionSync();
  }

  @override
  Future<HederaFillTransactionResult> fillTransaction({
    required HederaFillTransactionParams params,
  }) async {
    if (_phase == TxBuilderPhase.signed || _phase == TxBuilderPhase.finalized) {
      throw OnChainErrors.hederaTx(
        'fillTransaction',
        reason: 'Transaction is already signed.',
      );
    }
    if (!_hasBody) {
      throw OnChainErrors.hederaTx(
        'fillTransaction',
        reason: 'No transaction body has been set.',
      );
    }

    final payer = params.payer;
    _nodeAccountID = params.nodeAccountID ?? client.nodeAccountId;
    final validDur = params.transactionValidDuration;
    _transactionValidDuration = HederaDuration(
      seconds: BigInt.from(validDur.inSeconds),
    );
    _txMemo = params.memo;
    _generateRecord = params.generateRecord;
    _transactionID = HederaTransactionBuilderUtils.buildTxId(address: payer).id;

    HederaTransactionBody bodyForFee = _getTransactionSync().body;
    final gasForFee = HederaTransactionBuilderUtils.resolveGasUsed(
      bodyForFee,
      null,
    );

    HederaFeeEstimate? fee;
    final txFee = params.transactionFee;
    List<TxSignerRole>? missingRoles;
    _lockupSignerParams = params.lockupSignerParams;
    if (txFee == null || txFee <= BigInt.zero) {
      List<TxSigningRequirement>? local;
      int? totalSignatureCount = params.totalSignatures;
      if (totalSignatureCount == null) {
        bodyForFee = bodyForFee.copyWith(transactionFee: BinaryOps.maxInt64);
        local = await bodyForFee.detectAllSigningRequirements(
          client: client,
          lookup: params.lockupSignerParams.scopedTo(bodyForFee),
        );
        totalSignatureCount = local.totalSignatureCount;
      }

      missingRoles = local?.missingKeys;
      // Base fee estimate: do not fold EVM gas into the body max-fee ceiling.
      fee = await utils.estimateFeeUnified(
        body: bodyForFee,
        signatureCount: totalSignatureCount,
        requiredKeySignatureSlots: local?.existingKeyCount ?? 0,
        requiredSigners: local?.existingAccountCount ?? 0,
        mode:
            client.strategy.allowMirror
                ? HederaFeeScheduleMode.mirror
                : HederaFeeScheduleMode.scheduleHip1261,
        gasUsed: gasForFee,
        safetyMultiplier: params.feeSafetyMultiplier,
      );
      _transactionFee = fee.maxFee;
    } else {
      _transactionFee = txFee;
      fee = HederaFeeEstimate(maxFee: txFee, total: txFee);
    }

    _filledBody = _getTransactionSync().body;
    _signedResult = null;
    _finalizedTransaction = null;
    _phase = TxBuilderPhase.filled;
    return HederaFillTransactionResult(fee: fee, missingKeys: missingRoles);
  }

  @override
  Future<HederaSignedTransactionResult> signTransaction({
    required HederaSignTransactionParams params,
  }) async {
    if (phase != TxBuilderPhase.filled && phase != TxBuilderPhase.signed) {
      throw OnChainErrors.hederaTx(
        'signTransaction',
        reason: 'Call fillTransaction() before signing.',
      );
    }
    final body = _filledBody ?? _getTransactionSync().body;

    final lockupSignerParams = params.lockupSignerParams ?? _lockupSignerParams;
    HederaSignatureMap? sigMap = params.signatures;
    List<TxSigningRequirement>? detected;
    if (sigMap == null) {
      final pairs = <HederaSignaturePair>[];
      final seen = <String>{};

      void addUnique(Iterable<HederaSignaturePair> list) {
        for (final p in list) {
          final prefix = p.pubKeyPrefix;
          final id =
              prefix == null || prefix.isEmpty
                  ? 'empty-${pairs.length}'
                  : BytesUtils.toHexString(prefix);
          if (seen.add(id)) pairs.add(p);
        }
      }

      final signers = params.signers;
      if (signers != null) {
        for (final s in signers) {
          addUnique(await s.signTransaction(body));
        }
        sigMap = HederaSignatureMap(sigPair: pairs);
      } else {
        detected = await body.detectAllSigningRequirements(
          client: client,
          lookup:
              lockupSignerParams ??
              TxBodySignerLookupParams(resolveStateKeys: true),
        );
        final seenPk = <HederaPublicKey>{};
        for (final i in detected) {
          final signer = await params.signerCallback(
            role: i.role,
            account: i.account,
            key: i.key,
          );
          if (signer == null) continue;
          for (final i in signer.publicKeys) {
            if (seenPk.contains(i)) continue;
            final s = await signer.signer(i);
            if (s == null) continue;
            addUnique(await s.signTransaction(body));
            seenPk.add(i);
          }
        }
        sigMap = HederaSignatureMap(sigPair: pairs);
      }
    }
    final signedContents = HederaSignedTransaction(
      bodyBytes: body.toBuffer(),
      sigMap: sigMap,
    );
    final tx = HederaTransaction(
      signedTransactionBytes: signedContents.toBuffer(),
    );
    final result = HederaSignedTransactionResult(
      transaction: tx,
      body: body,
      sigMap: sigMap,
      requirementSigners: detected,
    );
    _signedResult = result;
    _finalizedTransaction = tx;
    _lockupSignerParams = lockupSignerParams;
    _phase = TxBuilderPhase.signed;
    return result;
  }

  @override
  Future<HederaFinalizedTransactionResult> finalizeTransaction({
    HederaFinalizeTransactionParams? params,
  }) async {
    if (_signedResult == null || _finalizedTransaction == null) {
      throw OnChainErrors.hederaTx(
        'finalizeTransaction',
        reason: 'Call signTransaction() before finalizeTransaction().',
      );
    }
    _phase = TxBuilderPhase.finalized;
    return HederaFinalizedTransactionResult(
      transaction: _finalizedTransaction!,
      signed: _signedResult!,
    );
  }

  @override
  Future<HederaSubmitTransactionResult> submit({
    HederaSubmitTransactionParams? params,
  }) async {
    final tx = _finalizedTransaction;
    final signedTx = _signedResult;
    final txId = _transactionID;
    if ((_phase != TxBuilderPhase.finalized &&
            _phase != TxBuilderPhase.signed) ||
        tx == null ||
        txId == null ||
        signedTx == null) {
      throw OnChainErrors.hederaTx(
        'submit',
        reason: 'Call finalizeTransaction() before submit().',
      );
    }
    final p = params ?? const HederaSubmitTransactionParams();
    if (_phase != TxBuilderPhase.finalized && _phase != TxBuilderPhase.signed) {
      throw OnChainErrors.hederaTx(
        'submit',
        reason: 'Transaction is not signed/finalized.',
      );
    }

    if (!p.waitForReceipt) {
      final response = await client.submitTransaction(
        transaction: tx,
        body: signedTx.body,
      );
      return HederaSubmitTransactionResult(
        response: response,
        success: true,
        transactionId: txId.toTxId(),
      );
    }

    final payer = _addrFromAccountId(txId.accountID);
    if (payer == null) {
      throw OnChainErrors.hederaTx(
        'submit',
        reason: 'Cannot resolve payer from transactionID.',
      );
    }
    final result = await client.submitTransactionAndWait(
      transaction: tx,
      body: signedTx.body,
      transactionId: txId,
      timeout: p.timeout,
    );
    return HederaSubmitTransactionResult(
      response: result.submitResponse,
      receipt: result.receipt,
      success: result.success,
      transactionId: txId.toTxId(),
    );
  }
}

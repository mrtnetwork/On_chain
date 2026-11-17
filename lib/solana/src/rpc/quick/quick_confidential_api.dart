// High-level helpers for Token-2022 **confidential transfers** (ZK SPL
// token), mirroring `FilQuickPaychApi` (build + send + confirm in one call).
//
// Proving (Bulletproofs/Sigma, ElGamal/AES crypto) lives in the Rust
// `solana_zk` backend: Dart never invents proofs. Callers pass the backend's
// proof/context-state instructions via [proofInstructions] (placed
// immediately before the confidential instruction, since `proofOffset`s are
// relative to it) plus any context-state accounts via [proofAccounts]. This
// mixin only assembles wire layouts, fetches a fresh blockhash, simulates,
// signs, sends and optionally waits for finalization.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/confidential_transfer_account.dart';
import 'package:on_chain/solana/src/instructions/spl_token/constant.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/confidential_transfer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/confidential_transfer_layouts.dart';
import 'package:on_chain/solana/src/instructions/spl_token/spl_token_2022_extensions_program.dart';
import 'package:on_chain/solana/src/instructions/spl_token/utils/utils/confidential_zk_utils.dart';
import 'package:on_chain/solana/src/keypair/private_key.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/transaction/transaction.dart';

import 'api.dart';

mixin SolanaQuickConfidentialApi on SolanaQuickClientApi {
  /// Core helper (mirrors FIL `buildAndSendMessage` + `pushWithResult`):
  /// builds a transaction from [instructions], fetches a fresh blockhash,
  /// optionally simulates, signs, sends and optionally waits for finalization.
  /// Returns the transaction signature.
  ///
  /// Proof-heavy flows (withdraw/transfer with inline ZK proofs) exceed the
  /// 1232-byte legacy cap: pass `type: TransactionType.v1` with a
  /// [config] (compute units + loaded-accounts limit) for those.
  Future<String> buildSignAndSendConfidential({
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    required List<TransactionInstruction> instructions,
    TransactionType? type,
    TransactionV1Config config = const TransactionV1Config.empty(),
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    SolanaRequestEncoding encoding = SolanaRequestEncoding.base64,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final blockhash = await getBlockHash();
    final transaction = SolanaTransaction(
      payerKey: feePayer,
      recentBlockhash: blockhash,
      instructions: instructions,
      type: type,
      config: config,
    );
    if (simulateBeforeSend) {
      final sim = await simulate(transaction: transaction);
      if (sim.err != null) {
        throw BuError(
          OnChainErrorType.solanaPlugin,
          'Confidential transaction simulation failed.',
          details: {'err': sim.err.toString()},
        );
      }
    }
    transaction.sign(signers);
    final signature = await sendTransaction(
      transaction,
      skipPreflight: skipPreflight,
      maxRetries: maxRetries,
      commitment: commitment,
      encoding: encoding,
    );
    if (awaitConfirmation) {
      await trackTransaction(transactionId: signature, timeout: confirmTimeout);
    }
    return signature;
  }

  /// Confidential-transfer extension state of [tokenAccount], or null when
  /// the account carries no such extension.
  Future<ConfidentialTransferAccount?> getConfidentialTransferState(
    SolAddress tokenAccount,
  ) async {
    final info = await getAccountInfo(tokenAccount);
    if (info == null) return null;
    try {
      return ConfidentialTransferAccount.fromAccountBytes(info.toBytesData());
    } on BuError {
      return null;
    }
  }

  /// Decrypted confidential balances of [tokenAccount] (the confidential
  /// `getBalance`): pending lo/hi ElGamal ciphertexts plus the exact AES
  /// available balance. Returns null when the account or its confidential
  /// extension is missing. [api] is the `solana_zk` backend (e.g.
  /// `NativeSolanaZkApi`); [elGamalSecret] is the 32-byte ElGamal secret and
  /// [aeKey16] the 16-byte AES key derived at `ConfigureAccount`. One RPC
  /// fetch, local decrypts only.
  Future<SolanaConfidentialBalances?> readConfidentialBalances({
    required SolAddress tokenAccount,
    required SolanaZkApi api,
    required List<int> elGamalSecret,
    required List<int> aeKey16,
  }) async {
    final info = await getAccountInfo(tokenAccount);
    if (info == null) return null;
    try {
      return SolanaConfidentialZkUtils.readBalances(
        api: api,
        accountBytes: info.toBytesData(),
        elGamalSecret: elGamalSecret,
        aeKey16: aeKey16,
      );
    } on BuError {
      return null;
    }
  }

  /// Deposit public balance into confidential pending balance (27, 5).
  /// No ZK proofs needed.
  Future<String> confidentialDeposit({
    required SolAddress token,
    required SolAddress mint,
    required SolAddress authority,
    required BigInt amount,
    required int decimals,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialDeposit(
      token: token,
      mint: mint,
      authority: authority,
      layout: SPLToken2022ConfidentialDepositLayout(
        amount: amount,
        decimals: decimals,
      ),
      programId: programId,
      multiSigners: multiSigners,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [ix],
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Withdraw from confidential available balance to public balance (27, 6).
  /// [newDecryptableAvailableBalance] (36 bytes) and the equality/range
  /// proofs come from the Rust backend.
  Future<String> confidentialWithdraw({
    required SolAddress token,
    required SolAddress mint,
    required SolAddress authority,
    required BigInt amount,
    required int decimals,
    required List<int> newDecryptableAvailableBalance,
    required int equalityProofInstructionOffset,
    required int rangeProofInstructionOffset,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<TransactionInstruction> proofInstructions = const [],
    List<SolAddress> proofAccounts = const [],
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    TransactionType? type,
    TransactionV1Config config = const TransactionV1Config.empty(),
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialWithdraw(
      token: token,
      mint: mint,
      authority: authority,
      layout: SPLToken2022ConfidentialWithdrawLayout(
        amount: amount,
        decimals: decimals,
        newDecryptableAvailableBalance: newDecryptableAvailableBalance,
        equalityProofInstructionOffset: equalityProofInstructionOffset,
        rangeProofInstructionOffset: rangeProofInstructionOffset,
      ),
      programId: programId,
      multiSigners: multiSigners,
      proofAccounts: proofAccounts,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [...proofInstructions, ix],
      type: type,
      config: config,
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Confidential transfer between token accounts (27, 7). Ciphertexts,
  /// decryptable balances and all proofs come from the Rust backend.
  Future<String> confidentialTransfer({
    required SolAddress source,
    required SolAddress mint,
    required SolAddress destination,
    required SolAddress authority,
    required List<int> newSourceDecryptableAvailableBalance,
    required List<int> transferAmountAuditorCiphertextLo,
    required List<int> transferAmountAuditorCiphertextHi,
    required int equalityProofInstructionOffset,
    required int ciphertextValidityProofInstructionOffset,
    required int rangeProofInstructionOffset,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<TransactionInstruction> proofInstructions = const [],
    List<SolAddress> proofAccounts = const [],
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    TransactionType? type,
    TransactionV1Config config = const TransactionV1Config.empty(),
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialTransfer(
      source: source,
      mint: mint,
      destination: destination,
      authority: authority,
      layout: SPLToken2022ConfidentialTransferLayout(
        newSourceDecryptableAvailableBalance:
            newSourceDecryptableAvailableBalance,
        transferAmountAuditorCiphertextLo: transferAmountAuditorCiphertextLo,
        transferAmountAuditorCiphertextHi: transferAmountAuditorCiphertextHi,
        equalityProofInstructionOffset: equalityProofInstructionOffset,
        ciphertextValidityProofInstructionOffset:
            ciphertextValidityProofInstructionOffset,
        rangeProofInstructionOffset: rangeProofInstructionOffset,
      ),
      programId: programId,
      multiSigners: multiSigners,
      proofAccounts: proofAccounts,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [...proofInstructions, ix],
      type: type,
      config: config,
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Confidential transfer with transfer-fee withheld (27, 13).
  Future<String> confidentialTransferWithFee({
    required SolAddress source,
    required SolAddress mint,
    required SolAddress destination,
    required SolAddress authority,
    required List<int> newSourceDecryptableAvailableBalance,
    required List<int> transferAmountAuditorCiphertextLo,
    required List<int> transferAmountAuditorCiphertextHi,
    required int equalityProofInstructionOffset,
    required int transferAmountCiphertextValidityProofInstructionOffset,
    required int feeSigmaProofInstructionOffset,
    required int feeCiphertextValidityProofInstructionOffset,
    required int rangeProofInstructionOffset,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<TransactionInstruction> proofInstructions = const [],
    List<SolAddress> proofAccounts = const [],
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    TransactionType? type,
    TransactionV1Config config = const TransactionV1Config.empty(),
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialTransferWithFee(
      source: source,
      mint: mint,
      destination: destination,
      authority: authority,
      layout: SPLToken2022ConfidentialTransferWithFeeLayout(
        newSourceDecryptableAvailableBalance:
            newSourceDecryptableAvailableBalance,
        transferAmountAuditorCiphertextLo: transferAmountAuditorCiphertextLo,
        transferAmountAuditorCiphertextHi: transferAmountAuditorCiphertextHi,
        equalityProofInstructionOffset: equalityProofInstructionOffset,
        transferAmountCiphertextValidityProofInstructionOffset:
            transferAmountCiphertextValidityProofInstructionOffset,
        feeSigmaProofInstructionOffset: feeSigmaProofInstructionOffset,
        feeCiphertextValidityProofInstructionOffset:
            feeCiphertextValidityProofInstructionOffset,
        rangeProofInstructionOffset: rangeProofInstructionOffset,
      ),
      programId: programId,
      multiSigners: multiSigners,
      proofAccounts: proofAccounts,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [...proofInstructions, ix],
      type: type,
      config: config,
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Move pending balance to available balance (27, 8).
  Future<String> confidentialApplyPendingBalance({
    required SolAddress token,
    required SolAddress authority,
    required BigInt expectedPendingBalanceCreditCounter,
    required List<int> newDecryptableAvailableBalance,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialApplyPendingBalance(
      token: token,
      authority: authority,
      layout: SPLToken2022ConfidentialApplyPendingBalanceLayout(
        expectedPendingBalanceCreditCounter:
            expectedPendingBalanceCreditCounter,
        newDecryptableAvailableBalance: newDecryptableAvailableBalance,
      ),
      programId: programId,
      multiSigners: multiSigners,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [ix],
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Initialize confidential-transfer config on a mint (27, 0). Must sit in
  /// the same transaction as `InitializeMint`; pass that instruction via
  /// [prefixInstructions].
  Future<String> confidentialInitializeMint({
    required SolAddress mint,
    required SolAddress? authority,
    required bool autoApproveNewAccounts,
    required List<int>? auditorElGamalPubkey,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<TransactionInstruction> prefixInstructions = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialInitializeMint(
      mint: mint,
      layout: SPLToken2022ConfidentialInitializeMintLayout(
        authority: authority,
        autoApproveNewAccounts: autoApproveNewAccounts,
        auditorElGamalPubkey: auditorElGamalPubkey,
      ),
      programId: programId,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [...prefixInstructions, ix],
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Update the confidential-transfer mint config (27, 1).
  Future<String> confidentialUpdateMint({
    required SolAddress mint,
    required SolAddress authority,
    required bool autoApproveNewAccounts,
    required List<int>? auditorElGamalPubkey,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialUpdateMint(
      mint: mint,
      authority: authority,
      layout: SPLToken2022ConfidentialUpdateMintLayout(
        autoApproveNewAccounts: autoApproveNewAccounts,
        auditorElGamalPubkey: auditorElGamalPubkey,
      ),
      programId: programId,
      multiSigners: multiSigners,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [ix],
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Configure a token account for confidential transfers (27, 2).
  /// [decryptableZeroBalance] is the 36-byte AES sidecar from the backend;
  /// the pubkey-validity proof comes via [proofInstructions]/[proofAccounts]
  /// (offset 0 = context-state account).
  Future<String> confidentialConfigureAccount({
    required SolAddress token,
    required SolAddress mint,
    required SolAddress authority,
    required List<int> decryptableZeroBalance,
    required BigInt maximumPendingBalanceCreditCounter,
    required int proofInstructionOffset,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<TransactionInstruction> proofInstructions = const [],
    List<SolAddress> proofAccounts = const [],
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    TransactionType? type,
    TransactionV1Config config = const TransactionV1Config.empty(),
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialConfigureAccount(
      token: token,
      mint: mint,
      authority: authority,
      layout: SPLToken2022ConfidentialConfigureAccountLayout(
        decryptableZeroBalance: decryptableZeroBalance,
        maximumPendingBalanceCreditCounter: maximumPendingBalanceCreditCounter,
        proofInstructionOffset: proofInstructionOffset,
      ),
      programId: programId,
      multiSigners: multiSigners,
      proofAccounts: proofAccounts,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [...proofInstructions, ix],
      type: type,
      config: config,
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Configure via the ElGamal registry instead of a pubkey-validity proof
  /// (27, 14).
  Future<String> confidentialConfigureAccountWithRegistry({
    required SolAddress token,
    required SolAddress mint,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<SolAddress> registryAccounts = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix =
        SPLToken2022ExtensionsProgram.confidentialConfigureAccountWithRegistry(
          token: token,
          mint: mint,
          layout:
              const SPLToken2022ConfidentialConfigureAccountWithRegistryLayout(),
          programId: programId,
          registryAccounts: registryAccounts,
        );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [ix],
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Approve a configured account when auto-approve is off (27, 3).
  Future<String> confidentialApproveAccount({
    required SolAddress token,
    required SolAddress mint,
    required SolAddress authority,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialApproveAccount(
      token: token,
      mint: mint,
      authority: authority,
      layout: const SPLToken2022ConfidentialApproveAccountLayout(),
      programId: programId,
      multiSigners: multiSigners,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [ix],
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Empty a confidential balance so the account can be closed (27, 4).
  Future<String> confidentialEmptyAccount({
    required SolAddress token,
    required SolAddress authority,
    required int proofInstructionOffset,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<TransactionInstruction> proofInstructions = const [],
    List<SolAddress> proofAccounts = const [],
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    TransactionType? type,
    TransactionV1Config config = const TransactionV1Config.empty(),
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialEmptyAccount(
      token: token,
      authority: authority,
      layout: SPLToken2022ConfidentialEmptyAccountLayout(
        proofInstructionOffset: proofInstructionOffset,
      ),
      programId: programId,
      multiSigners: multiSigners,
      proofAccounts: proofAccounts,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [...proofInstructions, ix],
      type: type,
      config: config,
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Toggle confidential/non-confidential credit acceptance (27, 9-12).
  Future<String> confidentialToggleCredits({
    required SolAddress token,
    required SolAddress owner,
    required ConfidentialTransferInstruction toggle,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) async {
    final ix = SPLToken2022ExtensionsProgram.confidentialToggleCredits(
      token: token,
      owner: owner,
      layout: SPLToken2022ConfidentialToggleCreditsLayout(toggle: toggle),
      programId: programId,
      multiSigners: multiSigners,
    );
    return buildSignAndSendConfidential(
      feePayer: feePayer,
      signers: signers,
      instructions: [ix],
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Allow incoming confidential credits (27, 9).
  Future<String> confidentialEnableConfidentialCredits({
    required SolAddress token,
    required SolAddress owner,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) {
    return confidentialToggleCredits(
      token: token,
      owner: owner,
      toggle: ConfidentialTransferInstruction.enableConfidentialCredits,
      feePayer: feePayer,
      signers: signers,
      multiSigners: multiSigners,
      programId: programId,
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Block incoming confidential credits (27, 10).
  Future<String> confidentialDisableConfidentialCredits({
    required SolAddress token,
    required SolAddress owner,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) {
    return confidentialToggleCredits(
      token: token,
      owner: owner,
      toggle: ConfidentialTransferInstruction.disableConfidentialCredits,
      feePayer: feePayer,
      signers: signers,
      multiSigners: multiSigners,
      programId: programId,
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Allow incoming non-confidential credits (27, 11).
  Future<String> confidentialEnableNonConfidentialCredits({
    required SolAddress token,
    required SolAddress owner,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) {
    return confidentialToggleCredits(
      token: token,
      owner: owner,
      toggle: ConfidentialTransferInstruction.enableNonConfidentialCredits,
      feePayer: feePayer,
      signers: signers,
      multiSigners: multiSigners,
      programId: programId,
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }

  /// Block incoming non-confidential credits (27, 12).
  Future<String> confidentialDisableNonConfidentialCredits({
    required SolAddress token,
    required SolAddress owner,
    required SolAddress feePayer,
    required List<SolanaPrivateKey> signers,
    List<SolAddress> multiSigners = const [],
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    bool simulateBeforeSend = true,
    bool skipPreflight = false,
    Commitment? commitment,
    int? maxRetries,
    bool awaitConfirmation = true,
    Duration confirmTimeout = const Duration(minutes: 1),
  }) {
    return confidentialToggleCredits(
      token: token,
      owner: owner,
      toggle: ConfidentialTransferInstruction.disableNonConfidentialCredits,
      feePayer: feePayer,
      signers: signers,
      multiSigners: multiSigners,
      programId: programId,
      simulateBeforeSend: simulateBeforeSend,
      skipPreflight: skipPreflight,
      commitment: commitment,
      maxRetries: maxRetries,
      awaitConfirmation: awaitConfirmation,
      confirmTimeout: confirmTimeout,
    );
  }
}

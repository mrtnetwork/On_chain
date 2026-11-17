enum TxBuilderPhase { building, filled, signed, finalized }

abstract class IOnchainTransaction {}

abstract class IOnchainTransactionParams {}

abstract class IOnchainFillTransactionParams {}

abstract class IOnchainFillTransactionResult {}

abstract class IOnchainSignTransactionParams {}

abstract class IOnchainSignedTransactionResult {}

abstract class IOnchainFinalizeTransactionParams {}

abstract class IOnchainFinalizedTransactionResult {}

abstract class IOnchainSubmitTransactionParams {}

abstract class IOnchainSubmitTransactionResult {}

abstract class IOnchainTxBuilder<
  TX extends IOnchainTransaction,
  GETTXPARAMS extends IOnchainTransactionParams,
  FILLPARAMS extends IOnchainFillTransactionParams,
  FILLRESULT extends IOnchainFillTransactionResult,
  SIGNPARAMS extends IOnchainSignTransactionParams,
  SIGNEDRESULT extends IOnchainSignedTransactionResult,
  FINALIZEPARAMS extends IOnchainFinalizeTransactionParams,
  FINALIZERESULT extends IOnchainFinalizedTransactionResult,
  SUBMITPARAMS extends IOnchainSubmitTransactionParams,
  SUBMITRESULT extends IOnchainSubmitTransactionResult
> {
  TxBuilderPhase get phase;
  Future<TX> getTransaction({GETTXPARAMS? params});

  Future<FILLRESULT> fillTransaction({required FILLPARAMS params});

  Future<SIGNEDRESULT> signTransaction({required SIGNPARAMS params});

  Future<FINALIZERESULT> finalizeTransaction({FINALIZEPARAMS? params});

  Future<SUBMITRESULT> submit({SUBMITPARAMS? params});
}

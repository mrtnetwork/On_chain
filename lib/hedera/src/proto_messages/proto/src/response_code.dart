import 'package:blockchain_utils/blockchain_utils.dart';

/// *
///  * # Response Code Enumeration
///  * An enumeration of possible response codes.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.base"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * An enumeration of possible response codes.
enum HederaResponseCodeEnum implements ProtoEnumVariant {
  /// *
  ///      * The transaction passed the precheck validations.
  ok(0, 'OK'),

  /// *
  ///      * For any error not handled by specific error codes listed below.
  invalidTransaction(1, 'INVALID_TRANSACTION'),

  /// *
  ///      * Payer account does not exist.
  payerAccountNotFound(2, 'PAYER_ACCOUNT_NOT_FOUND'),

  /// *
  ///      * Node Account provided does not match the node account of the node the transaction was submitted
  ///      * to.
  invalidNodeAccount(3, 'INVALID_NODE_ACCOUNT'),

  /// *
  ///      * Pre-Check error when TransactionValidStart + transactionValidDuration is less than current
  ///      * consensus time.
  transactionExpired(4, 'TRANSACTION_EXPIRED'),

  /// *
  ///      * Transaction start time is greater than current consensus time
  invalidTransactionStart(5, 'INVALID_TRANSACTION_START'),

  /// *
  ///      * The given transactionValidDuration was either non-positive, or greater than the maximum
  ///      * valid duration of 180 secs.
  ///      *
  invalidTransactionDuration(6, 'INVALID_TRANSACTION_DURATION'),

  /// *
  ///      * The transaction signature is not valid
  invalidSignature(7, 'INVALID_SIGNATURE'),

  /// *
  ///      * Transaction memo size exceeded 100 bytes
  memoTooLong(8, 'MEMO_TOO_LONG'),

  /// *
  ///      * The fee provided in the transaction is insufficient for this type of transaction
  insufficientTxFee(9, 'INSUFFICIENT_TX_FEE'),

  /// *
  ///      * The payer account has insufficient cryptocurrency to pay the transaction fee
  insufficientPayerBalance(10, 'INSUFFICIENT_PAYER_BALANCE'),

  /// *
  ///      * This transaction ID is a duplicate of one that was submitted to this node or reached consensus
  ///      * in the last 180 seconds (receipt period)
  duplicateTransaction(11, 'DUPLICATE_TRANSACTION'),

  /// *
  ///      * If API is throttled out
  busy(12, 'BUSY'),

  /// *
  ///      * The API is not currently supported
  notSupported(13, 'NOT_SUPPORTED'),

  /// *
  ///      * The file id is invalid or does not exist
  invalidFileId(14, 'INVALID_FILE_ID'),

  /// *
  ///      * The account id is invalid or does not exist
  invalidAccountId(15, 'INVALID_ACCOUNT_ID'),

  /// *
  ///      * The contract id is invalid or does not exist
  invalidContractId(16, 'INVALID_CONTRACT_ID'),

  /// *
  ///      * Transaction id is not valid
  invalidTransactionId(17, 'INVALID_TRANSACTION_ID'),

  /// *
  ///      * Receipt for given transaction id does not exist
  receiptNotFound(18, 'RECEIPT_NOT_FOUND'),

  /// *
  ///      * Record for given transaction id does not exist
  recordNotFound(19, 'RECORD_NOT_FOUND'),

  /// *
  ///      * The solidity id is invalid or entity with this solidity id does not exist
  invalidSolidityId(20, 'INVALID_SOLIDITY_ID'),

  /// *
  ///      * The responding node has submitted the transaction to the network. Its final status is still
  ///      * unknown.
  unknown(21, 'UNKNOWN'),

  /// *
  ///      * The transaction succeeded
  success(22, 'SUCCESS'),

  /// *
  ///      * There was a system error and the transaction failed because of invalid request parameters.
  failInvalid(23, 'FAIL_INVALID'),

  /// *
  ///      * There was a system error while performing fee calculation, reserved for future.
  failFee(24, 'FAIL_FEE'),

  /// *
  ///      * There was a system error while performing balance checks, reserved for future.
  failBalance(25, 'FAIL_BALANCE'),

  /// *
  ///      * Key not provided in the transaction body
  keyRequired(26, 'KEY_REQUIRED'),

  /// *
  ///      * Unsupported algorithm/encoding used for keys in the transaction
  badEncoding(27, 'BAD_ENCODING'),

  /// *
  ///      * When the account balance is not sufficient for the transfer
  insufficientAccountBalance(28, 'INSUFFICIENT_ACCOUNT_BALANCE'),

  /// *
  ///      * During an update transaction when the system is not able to find the Users Solidity address
  invalidSolidityAddress(29, 'INVALID_SOLIDITY_ADDRESS'),

  /// *
  ///      * Not enough gas was supplied to execute transaction
  insufficientGas(30, 'INSUFFICIENT_GAS'),

  /// *
  ///      * contract byte code size is over the limit
  contractSizeLimitExceeded(31, 'CONTRACT_SIZE_LIMIT_EXCEEDED'),

  /// *
  ///      * local execution (query) is requested for a function which changes state
  localCallModificationException(32, 'LOCAL_CALL_MODIFICATION_EXCEPTION'),

  /// *
  ///      * Contract REVERT OPCODE executed
  contractRevertExecuted(33, 'CONTRACT_REVERT_EXECUTED'),

  /// *
  ///      * For any contract execution related error not handled by specific error codes listed above.
  contractExecutionException(34, 'CONTRACT_EXECUTION_EXCEPTION'),

  /// *
  ///      * In Query validation, account with +ve(amount) value should be Receiving node account, the
  ///      * receiver account should be only one account in the list
  invalidReceivingNodeAccount(35, 'INVALID_RECEIVING_NODE_ACCOUNT'),

  /// *
  ///      * Header is missing in Query request
  missingQueryHeader(36, 'MISSING_QUERY_HEADER'),

  /// *
  ///      * The update of the account failed
  accountUpdateFailed(37, 'ACCOUNT_UPDATE_FAILED'),

  /// *
  ///      * Provided key encoding was not supported by the system
  invalidKeyEncoding(38, 'INVALID_KEY_ENCODING'),

  /// *
  ///      * null solidity address
  nullSolidityAddress(39, 'NULL_SOLIDITY_ADDRESS'),

  /// *
  ///      * update of the contract failed
  contractUpdateFailed(40, 'CONTRACT_UPDATE_FAILED'),

  /// *
  ///      * the query header is invalid
  invalidQueryHeader(41, 'INVALID_QUERY_HEADER'),

  /// *
  ///      * Invalid fee submitted
  invalidFeeSubmitted(42, 'INVALID_FEE_SUBMITTED'),

  /// *
  ///      * Payer signature is invalid
  invalidPayerSignature(43, 'INVALID_PAYER_SIGNATURE'),

  /// *
  ///      * The keys were not provided in the request.
  keyNotProvided(44, 'KEY_NOT_PROVIDED'),

  /// *
  ///      * Expiration time provided in the transaction was invalid.
  invalidExpirationTime(45, 'INVALID_EXPIRATION_TIME'),

  /// *
  ///      * WriteAccess Control Keys are not provided for the file
  noWaclKey(46, 'NO_WACL_KEY'),

  /// *
  ///      * The contents of file are provided as empty.
  fileContentEmpty(47, 'FILE_CONTENT_EMPTY'),

  /// *
  ///      * The crypto transfer credit and debit do not sum equal to 0
  invalidAccountAmounts(48, 'INVALID_ACCOUNT_AMOUNTS'),

  /// *
  ///      * Transaction body provided is empty
  emptyTransactionBody(49, 'EMPTY_TRANSACTION_BODY'),

  /// *
  ///      * Invalid transaction body provided
  invalidTransactionBody(50, 'INVALID_TRANSACTION_BODY'),

  /// *
  ///      * the type of key (base ed25519 key, KeyList, or ThresholdKey) does not match the type of
  ///      * signature (base ed25519 signature, SignatureList, or ThresholdKeySignature)
  invalidSignatureTypeMismatchingKey(
    51,
    'INVALID_SIGNATURE_TYPE_MISMATCHING_KEY',
  ),

  /// *
  ///      * the number of key (KeyList, or ThresholdKey) does not match that of signature (SignatureList,
  ///      * or ThresholdKeySignature). e.g. if a keyList has 3 base keys, then the corresponding
  ///      * signatureList should also have 3 base signatures.
  invalidSignatureCountMismatchingKey(
    52,
    'INVALID_SIGNATURE_COUNT_MISMATCHING_KEY',
  ),

  /// *
  ///      * the livehash body is empty
  emptyLiveHashBody(53, 'EMPTY_LIVE_HASH_BODY'),

  /// *
  ///      * the livehash data is missing
  emptyLiveHash(54, 'EMPTY_LIVE_HASH'),

  /// *
  ///      * the keys for a livehash are missing
  emptyLiveHashKeys(55, 'EMPTY_LIVE_HASH_KEYS'),

  /// *
  ///      * the livehash data is not the output of a SHA-384 digest
  invalidLiveHashSize(56, 'INVALID_LIVE_HASH_SIZE'),

  /// *
  ///      * the query body is empty
  emptyQueryBody(57, 'EMPTY_QUERY_BODY'),

  /// *
  ///      * the crypto livehash query is empty
  emptyLiveHashQuery(58, 'EMPTY_LIVE_HASH_QUERY'),

  /// *
  ///      * the livehash is not present
  liveHashNotFound(59, 'LIVE_HASH_NOT_FOUND'),

  /// *
  ///      * the account id passed has not yet been created.
  accountIdDoesNotExist(60, 'ACCOUNT_ID_DOES_NOT_EXIST'),

  /// *
  ///      * the livehash already exists for a given account
  liveHashAlreadyExists(61, 'LIVE_HASH_ALREADY_EXISTS'),

  /// *
  ///      * File WACL keys are invalid
  invalidFileWacl(62, 'INVALID_FILE_WACL'),

  /// *
  ///      * Serialization failure
  serializationFailed(63, 'SERIALIZATION_FAILED'),

  /// *
  ///      * The size of the Transaction is greater than transactionMaxBytes
  transactionOversize(64, 'TRANSACTION_OVERSIZE'),

  /// *
  ///      * The Transaction has more than 50 levels
  transactionTooManyLayers(65, 'TRANSACTION_TOO_MANY_LAYERS'),

  /// *
  ///      * Contract is marked as deleted
  contractDeleted(66, 'CONTRACT_DELETED'),

  /// *
  ///      * the platform node is either disconnected or lagging behind.
  platformNotActive(67, 'PLATFORM_NOT_ACTIVE'),

  /// *
  ///      * one public key matches more than one prefixes on the signature map
  keyPrefixMismatch(68, 'KEY_PREFIX_MISMATCH'),

  /// *
  ///      * transaction not created by platform due to large backlog
  platformTransactionNotCreated(69, 'PLATFORM_TRANSACTION_NOT_CREATED'),

  /// *
  ///      * auto renewal period is not a positive number of seconds
  invalidRenewalPeriod(70, 'INVALID_RENEWAL_PERIOD'),

  /// *
  ///      * the response code when a smart contract id is passed for a crypto API request
  invalidPayerAccountId(71, 'INVALID_PAYER_ACCOUNT_ID'),

  /// *
  ///      * the account has been marked as deleted
  accountDeleted(72, 'ACCOUNT_DELETED'),

  /// *
  ///      * the file has been marked as deleted
  fileDeleted(73, 'FILE_DELETED'),

  /// *
  ///      * same accounts repeated in the transfer account list
  accountRepeatedInAccountAmounts(74, 'ACCOUNT_REPEATED_IN_ACCOUNT_AMOUNTS'),

  /// *
  ///      * attempting to set negative balance value for crypto account
  settingNegativeAccountBalance(75, 'SETTING_NEGATIVE_ACCOUNT_BALANCE'),

  /// *
  ///      * when deleting smart contract that has crypto balance either transfer account or transfer smart
  ///      * contract is required
  obtainerRequired(76, 'OBTAINER_REQUIRED'),

  /// *
  ///      * when deleting smart contract that has crypto balance you can not use the same contract id as
  ///      * transferContractId as the one being deleted
  obtainerSameContractId(77, 'OBTAINER_SAME_CONTRACT_ID'),

  /// *
  ///      * transferAccountId or transferContractId specified for contract delete does not exist
  obtainerDoesNotExist(78, 'OBTAINER_DOES_NOT_EXIST'),

  /// *
  ///      * attempting to modify (update or delete a immutable smart contract, i.e. one created without a
  ///      * admin key)
  modifyingImmutableContract(79, 'MODIFYING_IMMUTABLE_CONTRACT'),

  /// *
  ///      * Unexpected exception thrown by file system functions
  fileSystemException(80, 'FILE_SYSTEM_EXCEPTION'),

  /// *
  ///      * the duration is not a subset of [MINIMUM_AUTORENEW_DURATION,MAXIMUM_AUTORENEW_DURATION]
  autorenewDurationNotInRange(81, 'AUTORENEW_DURATION_NOT_IN_RANGE'),

  /// *
  ///      * Decoding the smart contract binary to a byte array failed. Check that the input is a valid hex
  ///      * string.
  errorDecodingBytestring(82, 'ERROR_DECODING_BYTESTRING'),

  /// *
  ///      * File to create a smart contract was of length zero
  contractFileEmpty(83, 'CONTRACT_FILE_EMPTY'),

  /// *
  ///      * Bytecode for smart contract is of length zero
  contractBytecodeEmpty(84, 'CONTRACT_BYTECODE_EMPTY'),

  /// *
  ///      * Attempt to set negative initial balance
  invalidInitialBalance(85, 'INVALID_INITIAL_BALANCE'),

  /// *
  ///      * Attempt to set negative receive record threshold
  invalidReceiveRecordThreshold(86, 'INVALID_RECEIVE_RECORD_THRESHOLD'),

  /// *
  ///      * Attempt to set negative send record threshold
  invalidSendRecordThreshold(87, 'INVALID_SEND_RECORD_THRESHOLD'),

  /// *
  ///      * Special Account Operations should be performed by only Genesis account, return this code if it
  ///      * is not Genesis Account
  accountIsNotGenesisAccount(88, 'ACCOUNT_IS_NOT_GENESIS_ACCOUNT'),

  /// *
  ///      * The fee payer account doesn't have permission to submit such Transaction
  payerAccountUnauthorized(89, 'PAYER_ACCOUNT_UNAUTHORIZED'),

  /// *
  ///      * FreezeTransactionBody is invalid
  invalidFreezeTransactionBody(90, 'INVALID_FREEZE_TRANSACTION_BODY'),

  /// *
  ///      * FreezeTransactionBody does not exist
  freezeTransactionBodyNotFound(91, 'FREEZE_TRANSACTION_BODY_NOT_FOUND'),

  /// *
  ///      * Exceeded the number of accounts (both from and to) allowed for crypto transfer list
  transferListSizeLimitExceeded(92, 'TRANSFER_LIST_SIZE_LIMIT_EXCEEDED'),

  /// *
  ///      * Smart contract result size greater than specified maxResultSize
  resultSizeLimitExceeded(93, 'RESULT_SIZE_LIMIT_EXCEEDED'),

  /// *
  ///      * The payer account is not a special account(account 0.0.55)
  notSpecialAccount(94, 'NOT_SPECIAL_ACCOUNT'),

  /// *
  ///      * Negative gas was offered in smart contract call
  contractNegativeGas(95, 'CONTRACT_NEGATIVE_GAS'),

  /// *
  ///      * Negative value / initial balance was specified in a smart contract call / create
  contractNegativeValue(96, 'CONTRACT_NEGATIVE_VALUE'),

  /// *
  ///      * Failed to update fee file
  invalidFeeFile(97, 'INVALID_FEE_FILE'),

  /// *
  ///      * Failed to update exchange rate file
  invalidExchangeRateFile(98, 'INVALID_EXCHANGE_RATE_FILE'),

  /// *
  ///      * Payment tendered for contract local call cannot cover both the fee and the gas
  insufficientLocalCallGas(99, 'INSUFFICIENT_LOCAL_CALL_GAS'),

  /// *
  ///      * Entities with Entity ID below 1000 are not allowed to be deleted
  entityNotAllowedToDelete(100, 'ENTITY_NOT_ALLOWED_TO_DELETE'),

  /// *
  ///      * Violating one of these rules: 1) treasury account can update all entities below 0.0.1000, 2)
  ///      * account 0.0.50 can update all entities from 0.0.51 - 0.0.80, 3) Network Function Master Account
  ///      * A/c 0.0.50 - Update all Network Function accounts &amp; perform all the Network Functions listed
  ///      * below, 4) Network Function Accounts: i) A/c 0.0.55 - Update Address Book files (0.0.101/102),
  ///      * ii) A/c 0.0.56 - Update Fee schedule (0.0.111), iii) A/c 0.0.57 - Update Exchange Rate
  ///      * (0.0.112).
  authorizationFailed(101, 'AUTHORIZATION_FAILED'),

  /// *
  ///      * Fee Schedule Proto uploaded but not valid (append or update is required)
  fileUploadedProtoInvalid(102, 'FILE_UPLOADED_PROTO_INVALID'),

  /// *
  ///      * Fee Schedule Proto uploaded but not valid (append or update is required)
  fileUploadedProtoNotSavedToDisk(103, 'FILE_UPLOADED_PROTO_NOT_SAVED_TO_DISK'),

  /// *
  ///      * Fee Schedule Proto File Part uploaded
  feeScheduleFilePartUploaded(104, 'FEE_SCHEDULE_FILE_PART_UPLOADED'),

  /// *
  ///      * The change on Exchange Rate exceeds Exchange_Rate_Allowed_Percentage
  exchangeRateChangeLimitExceeded(105, 'EXCHANGE_RATE_CHANGE_LIMIT_EXCEEDED'),

  /// *
  ///      * Contract permanent storage exceeded the currently allowable limit
  maxContractStorageExceeded(106, 'MAX_CONTRACT_STORAGE_EXCEEDED'),

  /// *
  ///      * Transfer Account should not be same as Account to be deleted
  transferAccountSameAsDeleteAccount(
    107,
    'TRANSFER_ACCOUNT_SAME_AS_DELETE_ACCOUNT',
  ),
  totalLedgerBalanceInvalid(108, 'TOTAL_LEDGER_BALANCE_INVALID'),

  /// *
  ///      * The expiration date/time on a smart contract may not be reduced
  expirationReductionNotAllowed(110, 'EXPIRATION_REDUCTION_NOT_ALLOWED'),

  /// *
  ///      * Gas exceeded currently allowable gas limit per transaction
  maxGasLimitExceeded(111, 'MAX_GAS_LIMIT_EXCEEDED'),

  /// *
  ///      * File size exceeded the currently allowable limit
  maxFileSizeExceeded(112, 'MAX_FILE_SIZE_EXCEEDED'),

  /// *
  ///      * When a valid signature is not provided for operations on account with receiverSigRequired=true
  receiverSigRequired(113, 'RECEIVER_SIG_REQUIRED'),

  /// *
  ///      * The Topic ID specified is not in the system.
  invalidTopicId(150, 'INVALID_TOPIC_ID'),

  /// *
  ///      * A provided admin key was invalid. Verify the bytes for an Ed25519 public key are exactly 32 bytes; and the bytes for a compressed ECDSA(secp256k1) key are exactly 33 bytes, with the first byte either 0x02 or 0x03..
  invalidAdminKey(155, 'INVALID_ADMIN_KEY'),

  /// *
  ///      * A provided submit key was invalid.
  invalidSubmitKey(156, 'INVALID_SUBMIT_KEY'),

  /// *
  ///      * An attempted operation was not authorized (ie - a deleteTopic for a topic with no adminKey).
  unauthorized(157, 'UNAUTHORIZED'),

  /// *
  ///      * A ConsensusService message is empty.
  invalidTopicMessage(158, 'INVALID_TOPIC_MESSAGE'),

  /// *
  ///      * The autoRenewAccount specified is not a valid, active account.
  invalidAutorenewAccount(159, 'INVALID_AUTORENEW_ACCOUNT'),

  /// *
  ///      * An adminKey was not specified on the topic, so there must not be an autoRenewAccount.
  autorenewAccountNotAllowed(160, 'AUTORENEW_ACCOUNT_NOT_ALLOWED'),

  /// *
  ///      * The topic has expired, was not automatically renewed, and is in a 7 day grace period before the
  ///      * topic will be deleted unrecoverably. This error response code will not be returned until
  ///      * autoRenew functionality is supported by HAPI.
  topicExpired(162, 'TOPIC_EXPIRED'),
  invalidChunkNumber(163, 'INVALID_CHUNK_NUMBER'),

  /// chunk number must be from 1 to total (chunks) inclusive.
  invalidChunkTransactionId(164, 'INVALID_CHUNK_TRANSACTION_ID'),

  /// For every chunk, the payer account that is part of initialTransactionID must match the Payer Account of this transaction. The entire initialTransactionID should match the transactionID of the first chunk, but this is not checked or enforced by Hedera except when the chunk number is 1.
  accountFrozenForToken(165, 'ACCOUNT_FROZEN_FOR_TOKEN'),

  /// Account is frozen and cannot transact with the token
  tokensPerAccountLimitExceeded(166, 'TOKENS_PER_ACCOUNT_LIMIT_EXCEEDED'),

  /// An involved account already has more than &lt;tt&gt;tokens.maxPerAccount&lt;/tt&gt; associations with non-deleted tokens.
  invalidTokenId(167, 'INVALID_TOKEN_ID'),

  /// The token is invalid or does not exist
  invalidTokenDecimals(168, 'INVALID_TOKEN_DECIMALS'),

  /// Invalid token decimals
  invalidTokenInitialSupply(169, 'INVALID_TOKEN_INITIAL_SUPPLY'),

  /// Invalid token initial supply
  invalidTreasuryAccountForToken(170, 'INVALID_TREASURY_ACCOUNT_FOR_TOKEN'),

  /// Treasury Account does not exist or is deleted
  invalidTokenSymbol(171, 'INVALID_TOKEN_SYMBOL'),

  /// Token Symbol is not UTF-8 capitalized alphabetical string
  tokenHasNoFreezeKey(172, 'TOKEN_HAS_NO_FREEZE_KEY'),

  /// Freeze key is not set on token
  transfersNotZeroSumForToken(173, 'TRANSFERS_NOT_ZERO_SUM_FOR_TOKEN'),

  /// Amounts in transfer list are not net zero
  missingTokenSymbol(174, 'MISSING_TOKEN_SYMBOL'),

  /// A token symbol was not provided
  tokenSymbolTooLong(175, 'TOKEN_SYMBOL_TOO_LONG'),

  /// The provided token symbol was too long
  accountKycNotGrantedForToken(176, 'ACCOUNT_KYC_NOT_GRANTED_FOR_TOKEN'),

  /// KYC must be granted and account does not have KYC granted
  tokenHasNoKycKey(177, 'TOKEN_HAS_NO_KYC_KEY'),

  /// KYC key is not set on token
  insufficientTokenBalance(178, 'INSUFFICIENT_TOKEN_BALANCE'),

  /// Token balance is not sufficient for the transaction
  tokenWasDeleted(179, 'TOKEN_WAS_DELETED'),

  /// Token transactions cannot be executed on deleted token
  tokenHasNoSupplyKey(180, 'TOKEN_HAS_NO_SUPPLY_KEY'),

  /// Supply key is not set on token
  tokenHasNoWipeKey(181, 'TOKEN_HAS_NO_WIPE_KEY'),

  /// Wipe key is not set on token
  invalidTokenMintAmount(182, 'INVALID_TOKEN_MINT_AMOUNT'),

  /// The requested token mint amount would cause an invalid total supply
  invalidTokenBurnAmount(183, 'INVALID_TOKEN_BURN_AMOUNT'),

  /// The requested token burn amount would cause an invalid total supply
  tokenNotAssociatedToAccount(184, 'TOKEN_NOT_ASSOCIATED_TO_ACCOUNT'),

  /// A required token-account relationship is missing
  cannotWipeTokenTreasuryAccount(185, 'CANNOT_WIPE_TOKEN_TREASURY_ACCOUNT'),

  /// The target of a wipe operation was the token treasury account
  invalidKycKey(186, 'INVALID_KYC_KEY'),

  /// The provided KYC key was invalid.
  invalidWipeKey(187, 'INVALID_WIPE_KEY'),

  /// The provided wipe key was invalid.
  invalidFreezeKey(188, 'INVALID_FREEZE_KEY'),

  /// The provided freeze key was invalid.
  invalidSupplyKey(189, 'INVALID_SUPPLY_KEY'),

  /// The provided supply key was invalid.
  missingTokenName(190, 'MISSING_TOKEN_NAME'),

  /// Token Name is not provided
  tokenNameTooLong(191, 'TOKEN_NAME_TOO_LONG'),

  /// Token Name is too long
  invalidWipingAmount(192, 'INVALID_WIPING_AMOUNT'),

  /// The provided wipe amount must not be negative, zero or bigger than the token holder balance
  tokenIsImmutable(193, 'TOKEN_IS_IMMUTABLE'),

  /// Token does not have Admin key set, thus update/delete transactions cannot be performed
  tokenAlreadyAssociatedToAccount(194, 'TOKEN_ALREADY_ASSOCIATED_TO_ACCOUNT'),

  /// An &lt;tt&gt;associateToken&lt;/tt&gt; operation specified a token already associated to the account
  transactionRequiresZeroTokenBalances(
    195,
    'TRANSACTION_REQUIRES_ZERO_TOKEN_BALANCES',
  ),

  /// An attempted operation is invalid until all token balances for the target account are zero
  accountIsTreasury(196, 'ACCOUNT_IS_TREASURY'),

  /// An attempted operation is invalid because the account is a treasury
  tokenIdRepeatedInTokenList(197, 'TOKEN_ID_REPEATED_IN_TOKEN_LIST'),

  /// Same TokenIDs present in the token list
  tokenTransferListSizeLimitExceeded(
    198,
    'TOKEN_TRANSFER_LIST_SIZE_LIMIT_EXCEEDED',
  ),

  /// Exceeded the number of token transfers (both from and to) allowed for token transfer list
  emptyTokenTransferBody(199, 'EMPTY_TOKEN_TRANSFER_BODY'),

  /// TokenTransfersTransactionBody has no TokenTransferList
  emptyTokenTransferAccountAmounts(200, 'EMPTY_TOKEN_TRANSFER_ACCOUNT_AMOUNTS'),

  /// TokenTransfersTransactionBody has a TokenTransferList with no AccountAmounts
  /// *
  ///      * The Scheduled entity does not exist; or has now expired, been deleted, or been executed
  invalidScheduleId(201, 'INVALID_SCHEDULE_ID'),

  /// *
  ///      * The Scheduled entity cannot be modified. Admin key not set
  scheduleIsImmutable(202, 'SCHEDULE_IS_IMMUTABLE'),

  /// *
  ///      * The provided Scheduled Payer does not exist
  invalidSchedulePayerId(203, 'INVALID_SCHEDULE_PAYER_ID'),

  /// *
  ///      * The Schedule Create Transaction TransactionID account does not exist
  invalidScheduleAccountId(204, 'INVALID_SCHEDULE_ACCOUNT_ID'),

  /// *
  ///      * The provided sig map did not contain any new valid signatures from required signers of the scheduled transaction
  noNewValidSignatures(205, 'NO_NEW_VALID_SIGNATURES'),

  /// *
  ///      * The required signers for a scheduled transaction cannot be resolved, for example because they do not exist or have been deleted
  unresolvableRequiredSigners(206, 'UNRESOLVABLE_REQUIRED_SIGNERS'),

  /// *
  ///      * Only whitelisted transaction types may be scheduled
  scheduledTransactionNotInWhitelist(
    207,
    'SCHEDULED_TRANSACTION_NOT_IN_WHITELIST',
  ),

  /// *
  ///      * At least one of the signatures in the provided sig map did not represent a valid signature for any required signer
  someSignaturesWereInvalid(208, 'SOME_SIGNATURES_WERE_INVALID'),

  /// *
  ///      * The scheduled field in the TransactionID may not be set to true
  transactionIdFieldNotAllowed(209, 'TRANSACTION_ID_FIELD_NOT_ALLOWED'),

  /// *
  ///      * A schedule already exists with the same identifying fields of an attempted ScheduleCreate (that is, all fields other than scheduledPayerAccountID)
  identicalScheduleAlreadyCreated(210, 'IDENTICAL_SCHEDULE_ALREADY_CREATED'),

  /// *
  ///      * A string field in the transaction has a UTF-8 encoding with the prohibited zero byte
  invalidZeroByteInString(211, 'INVALID_ZERO_BYTE_IN_STRING'),

  /// *
  ///      * A schedule being signed or deleted has already been deleted
  scheduleAlreadyDeleted(212, 'SCHEDULE_ALREADY_DELETED'),

  /// *
  ///      * A schedule being signed or deleted has already been executed
  scheduleAlreadyExecuted(213, 'SCHEDULE_ALREADY_EXECUTED'),

  /// *
  ///      * ConsensusSubmitMessage request's message size is larger than allowed.
  messageSizeTooLarge(214, 'MESSAGE_SIZE_TOO_LARGE'),

  /// *
  ///      * An operation was assigned to more than one throttle group in a given bucket
  operationRepeatedInBucketGroups(215, 'OPERATION_REPEATED_IN_BUCKET_GROUPS'),

  /// *
  ///      * The capacity needed to satisfy all opsPerSec groups in a bucket overflowed a signed 8-byte integral type
  bucketCapacityOverflow(216, 'BUCKET_CAPACITY_OVERFLOW'),

  /// *
  ///      * Given the network size in the address book, the node-level capacity for an operation would never be enough to accept a single request; usually means a bucket burstPeriod should be increased
  nodeCapacityNotSufficientForOperation(
    217,
    'NODE_CAPACITY_NOT_SUFFICIENT_FOR_OPERATION',
  ),

  /// *
  ///      * A bucket was defined without any throttle groups
  bucketHasNoThrottleGroups(218, 'BUCKET_HAS_NO_THROTTLE_GROUPS'),

  /// *
  ///      * A throttle group was granted zero opsPerSec
  throttleGroupHasZeroOpsPerSec(219, 'THROTTLE_GROUP_HAS_ZERO_OPS_PER_SEC'),

  /// *
  ///      * The throttle definitions file was updated, but some supported operations were not assigned a bucket
  successButMissingExpectedOperation(
    220,
    'SUCCESS_BUT_MISSING_EXPECTED_OPERATION',
  ),

  /// *
  ///      * The new contents for the throttle definitions system file were not valid protobuf
  unparseableThrottleDefinitions(221, 'UNPARSEABLE_THROTTLE_DEFINITIONS'),

  /// *
  ///      * The new throttle definitions system file were invalid, and no more specific error could be divined
  invalidThrottleDefinitions(222, 'INVALID_THROTTLE_DEFINITIONS'),

  /// *
  ///      * The transaction references an account which has passed its expiration without renewal funds available, and currently remains in the ledger only because of the grace period given to expired entities
  accountExpiredAndPendingRemoval(223, 'ACCOUNT_EXPIRED_AND_PENDING_REMOVAL'),

  /// *
  ///      * Invalid token max supply
  invalidTokenMaxSupply(224, 'INVALID_TOKEN_MAX_SUPPLY'),

  /// *
  ///      * Invalid token nft serial number
  invalidTokenNftSerialNumber(225, 'INVALID_TOKEN_NFT_SERIAL_NUMBER'),

  /// *
  ///      * Invalid nft id
  invalidNftId(226, 'INVALID_NFT_ID'),

  /// *
  ///      * Nft metadata is too long
  metadataTooLong(227, 'METADATA_TOO_LONG'),

  /// *
  ///      * Repeated operations count exceeds the limit
  batchSizeLimitExceeded(228, 'BATCH_SIZE_LIMIT_EXCEEDED'),

  /// *
  ///      * The range of data to be gathered is out of the set boundaries
  invalidQueryRange(229, 'INVALID_QUERY_RANGE'),

  /// *
  ///      * A custom fractional fee set a denominator of zero
  fractionDividesByZero(230, 'FRACTION_DIVIDES_BY_ZERO'),

  /// *
  ///      * The transaction payer could not afford a custom fee
  insufficientPayerBalanceForCustomFee(
    231,
    'INSUFFICIENT_PAYER_BALANCE_FOR_CUSTOM_FEE',
  ),

  /// *
  ///      * More than 10 custom fees were specified
  customFeesListTooLong(232, 'CUSTOM_FEES_LIST_TOO_LONG'),

  /// *
  ///      * Any of the feeCollector accounts for customFees is invalid
  invalidCustomFeeCollector(233, 'INVALID_CUSTOM_FEE_COLLECTOR'),

  /// *
  ///      * Any of the token Ids in customFees is invalid
  invalidTokenIdInCustomFees(234, 'INVALID_TOKEN_ID_IN_CUSTOM_FEES'),

  /// *
  ///      * Any of the token Ids in customFees are not associated to feeCollector
  tokenNotAssociatedToFeeCollector(
    235,
    'TOKEN_NOT_ASSOCIATED_TO_FEE_COLLECTOR',
  ),

  /// *
  ///      * A token cannot have more units minted due to its configured supply ceiling
  tokenMaxSupplyReached(236, 'TOKEN_MAX_SUPPLY_REACHED'),

  /// *
  ///      * The transaction attempted to move an NFT serial number from an account other than its owner
  senderDoesNotOwnNftSerialNo(237, 'SENDER_DOES_NOT_OWN_NFT_SERIAL_NO'),

  /// *
  ///      * A custom fee schedule entry did not specify either a fixed or fractional fee
  customFeeNotFullySpecified(238, 'CUSTOM_FEE_NOT_FULLY_SPECIFIED'),

  /// *
  ///      * Only positive fees may be assessed at this time
  customFeeMustBePositive(239, 'CUSTOM_FEE_MUST_BE_POSITIVE'),

  /// *
  ///      * Fee schedule key is not set on token
  tokenHasNoFeeScheduleKey(240, 'TOKEN_HAS_NO_FEE_SCHEDULE_KEY'),

  /// *
  ///      * A fractional custom fee exceeded the range of a 64-bit signed integer
  customFeeOutsideNumericRange(241, 'CUSTOM_FEE_OUTSIDE_NUMERIC_RANGE'),

  /// *
  ///      * A royalty cannot exceed the total fungible value exchanged for an NFT
  royaltyFractionCannotExceedOne(242, 'ROYALTY_FRACTION_CANNOT_EXCEED_ONE'),

  /// *
  ///      * Each fractional custom fee must have its maximum_amount, if specified, at least its minimum_amount
  fractionalFeeMaxAmountLessThanMinAmount(
    243,
    'FRACTIONAL_FEE_MAX_AMOUNT_LESS_THAN_MIN_AMOUNT',
  ),

  /// *
  ///      * A fee schedule update tried to clear the custom fees from a token whose fee schedule was already empty
  customScheduleAlreadyHasNoFees(244, 'CUSTOM_SCHEDULE_ALREADY_HAS_NO_FEES'),

  /// *
  ///      * Only tokens of type FUNGIBLE_COMMON can be used to as fee schedule denominations
  customFeeDenominationMustBeFungibleCommon(
    245,
    'CUSTOM_FEE_DENOMINATION_MUST_BE_FUNGIBLE_COMMON',
  ),

  /// *
  ///      * Only tokens of type FUNGIBLE_COMMON can have fractional fees
  customFractionalFeeOnlyAllowedForFungibleCommon(
    246,
    'CUSTOM_FRACTIONAL_FEE_ONLY_ALLOWED_FOR_FUNGIBLE_COMMON',
  ),

  /// *
  ///      * The provided custom fee schedule key was invalid
  invalidCustomFeeScheduleKey(247, 'INVALID_CUSTOM_FEE_SCHEDULE_KEY'),

  /// *
  ///      * The requested token mint metadata was invalid
  invalidTokenMintMetadata(248, 'INVALID_TOKEN_MINT_METADATA'),

  /// *
  ///      * The requested token burn metadata was invalid
  invalidTokenBurnMetadata(249, 'INVALID_TOKEN_BURN_METADATA'),

  /// *
  ///      * The treasury for a unique token cannot be changed until it owns no NFTs
  currentTreasuryStillOwnsNfts(250, 'CURRENT_TREASURY_STILL_OWNS_NFTS'),

  /// *
  ///      * An account cannot be dissociated from a unique token if it owns NFTs for the token
  accountStillOwnsNfts(251, 'ACCOUNT_STILL_OWNS_NFTS'),

  /// *
  ///      * A NFT can only be burned when owned by the unique token's treasury
  treasuryMustOwnBurnedNft(252, 'TREASURY_MUST_OWN_BURNED_NFT'),

  /// *
  ///      * An account did not own the NFT to be wiped
  accountDoesNotOwnWipedNft(253, 'ACCOUNT_DOES_NOT_OWN_WIPED_NFT'),

  /// *
  ///      * An AccountAmount token transfers list referenced a token type other than FUNGIBLE_COMMON
  accountAmountTransfersOnlyAllowedForFungibleCommon(
    254,
    'ACCOUNT_AMOUNT_TRANSFERS_ONLY_ALLOWED_FOR_FUNGIBLE_COMMON',
  ),

  /// *
  ///      * All the NFTs allowed in the current price regime have already been minted
  maxNftsInPriceRegimeHaveBeenMinted(
    255,
    'MAX_NFTS_IN_PRICE_REGIME_HAVE_BEEN_MINTED',
  ),

  /// *
  ///      * The payer account has been marked as deleted
  payerAccountDeleted(256, 'PAYER_ACCOUNT_DELETED'),

  /// *
  ///      * The reference chain of custom fees for a transferred token exceeded the maximum length of 2
  customFeeChargingExceededMaxRecursionDepth(
    257,
    'CUSTOM_FEE_CHARGING_EXCEEDED_MAX_RECURSION_DEPTH',
  ),

  /// *
  ///      * More than 20 balance adjustments were to satisfy a CryptoTransfer and its implied custom fee payments
  customFeeChargingExceededMaxAccountAmounts(
    258,
    'CUSTOM_FEE_CHARGING_EXCEEDED_MAX_ACCOUNT_AMOUNTS',
  ),

  /// *
  ///      * The sender account in the token transfer transaction could not afford a custom fee
  insufficientSenderAccountBalanceForCustomFee(
    259,
    'INSUFFICIENT_SENDER_ACCOUNT_BALANCE_FOR_CUSTOM_FEE',
  ),

  /// *
  ///      * Currently no more than 4,294,967,295 NFTs may be minted for a given unique token type
  serialNumberLimitReached(260, 'SERIAL_NUMBER_LIMIT_REACHED'),

  /// *
  ///      * Only tokens of type NON_FUNGIBLE_UNIQUE can have royalty fees
  customRoyaltyFeeOnlyAllowedForNonFungibleUnique(
    261,
    'CUSTOM_ROYALTY_FEE_ONLY_ALLOWED_FOR_NON_FUNGIBLE_UNIQUE',
  ),

  /// *
  ///      * The account has reached the limit on the automatic associations count.
  noRemainingAutomaticAssociations(262, 'NO_REMAINING_AUTOMATIC_ASSOCIATIONS'),

  /// *
  ///      * Already existing automatic associations are more than the new maximum automatic associations.
  existingAutomaticAssociationsExceedGivenLimit(
    263,
    'EXISTING_AUTOMATIC_ASSOCIATIONS_EXCEED_GIVEN_LIMIT',
  ),

  /// *
  ///      * Cannot set the number of automatic associations for an account more than the maximum allowed
  ///      * token associations &lt;tt&gt;tokens.maxPerAccount&lt;/tt&gt;.
  requestedNumAutomaticAssociationsExceedsAssociationLimit(
    264,
    'REQUESTED_NUM_AUTOMATIC_ASSOCIATIONS_EXCEEDS_ASSOCIATION_LIMIT',
  ),

  /// *
  ///      * Token is paused. This Token cannot be a part of any kind of Transaction until unpaused.
  tokenIsPaused(265, 'TOKEN_IS_PAUSED'),

  /// *
  ///      * Pause key is not set on token
  tokenHasNoPauseKey(266, 'TOKEN_HAS_NO_PAUSE_KEY'),

  /// *
  ///      * The provided pause key was invalid
  invalidPauseKey(267, 'INVALID_PAUSE_KEY'),

  /// *
  ///      * The update file in a freeze transaction body must exist.
  freezeUpdateFileDoesNotExist(268, 'FREEZE_UPDATE_FILE_DOES_NOT_EXIST'),

  /// *
  ///      * The hash of the update file in a freeze transaction body must match the in-memory hash.
  freezeUpdateFileHashDoesNotMatch(
    269,
    'FREEZE_UPDATE_FILE_HASH_DOES_NOT_MATCH',
  ),

  /// *
  ///      * A FREEZE_UPGRADE transaction was handled with no previous update prepared.
  noUpgradeHasBeenPrepared(270, 'NO_UPGRADE_HAS_BEEN_PREPARED'),

  /// *
  ///      * A FREEZE_ABORT transaction was handled with no scheduled freeze.
  noFreezeIsScheduled(271, 'NO_FREEZE_IS_SCHEDULED'),

  /// *
  ///      * The update file hash when handling a FREEZE_UPGRADE transaction differs from the file
  ///      * hash at the time of handling the PREPARE_UPGRADE transaction.
  updateFileHashChangedSincePrepareUpgrade(
    272,
    'UPDATE_FILE_HASH_CHANGED_SINCE_PREPARE_UPGRADE',
  ),

  /// *
  ///      * The given freeze start time was in the (consensus) past.
  freezeStartTimeMustBeFuture(273, 'FREEZE_START_TIME_MUST_BE_FUTURE'),

  /// *
  ///      * The prepared update file cannot be updated or appended until either the upgrade has
  ///      * been completed, or a FREEZE_ABORT has been handled.
  preparedUpdateFileIsImmutable(274, 'PREPARED_UPDATE_FILE_IS_IMMUTABLE'),

  /// *
  ///      * Once a freeze is scheduled, it must be aborted before any other type of freeze can
  ///      * can be performed.
  freezeAlreadyScheduled(275, 'FREEZE_ALREADY_SCHEDULED'),

  /// *
  ///      * If an NMT upgrade has been prepared, the following operation must be a FREEZE_UPGRADE.
  ///      * (To issue a FREEZE_ONLY, submit a FREEZE_ABORT first.)
  freezeUpgradeInProgress(276, 'FREEZE_UPGRADE_IN_PROGRESS'),

  /// *
  ///      * If an NMT upgrade has been prepared, the subsequent FREEZE_UPGRADE transaction must
  ///      * confirm the id of the file to be used in the upgrade.
  updateFileIdDoesNotMatchPrepared(
    277,
    'UPDATE_FILE_ID_DOES_NOT_MATCH_PREPARED',
  ),

  /// *
  ///      * If an NMT upgrade has been prepared, the subsequent FREEZE_UPGRADE transaction must
  ///      * confirm the hash of the file to be used in the upgrade.
  updateFileHashDoesNotMatchPrepared(
    278,
    'UPDATE_FILE_HASH_DOES_NOT_MATCH_PREPARED',
  ),

  /// *
  ///      * Consensus throttle did not allow execution of this transaction. System is throttled at
  ///      * consensus level.
  consensusGasExhausted(279, 'CONSENSUS_GAS_EXHAUSTED'),

  /// *
  ///      * A precompiled contract succeeded, but was later reverted.
  revertedSuccess(280, 'REVERTED_SUCCESS'),

  /// *
  ///      * All contract storage allocated to the current price regime has been consumed.
  maxStorageInPriceRegimeHasBeenUsed(
    281,
    'MAX_STORAGE_IN_PRICE_REGIME_HAS_BEEN_USED',
  ),

  /// *
  ///      * An alias used in a CryptoTransfer transaction is not the serialization of a primitive Key
  ///      * message--that is, a Key with a single Ed25519 or ECDSA(secp256k1) public key and no
  ///      * unknown protobuf fields.
  invalidAliasKey(282, 'INVALID_ALIAS_KEY'),

  /// *
  ///      * A fungible token transfer expected a different number of decimals than the involved
  ///      * type actually has.
  unexpectedTokenDecimals(283, 'UNEXPECTED_TOKEN_DECIMALS'),

  /// *
  ///      * The proxy account id is invalid or does not exist.
  invalidProxyAccountId(284, 'INVALID_PROXY_ACCOUNT_ID'),

  /// *
  ///      * The transfer account id in CryptoDelete transaction is invalid or does not exist.
  invalidTransferAccountId(285, 'INVALID_TRANSFER_ACCOUNT_ID'),

  /// *
  ///      * The fee collector account id in TokenFeeScheduleUpdate is invalid or does not exist.
  invalidFeeCollectorAccountId(286, 'INVALID_FEE_COLLECTOR_ACCOUNT_ID'),

  /// *
  ///      * The alias already set on an account cannot be updated using CryptoUpdate transaction.
  aliasIsImmutable(287, 'ALIAS_IS_IMMUTABLE'),

  /// *
  ///      * An approved allowance specifies a spender account that is the same as the hbar/token
  ///      * owner account.
  spenderAccountSameAsOwner(288, 'SPENDER_ACCOUNT_SAME_AS_OWNER'),

  /// *
  ///      * The establishment or adjustment of an approved allowance cause the token allowance
  ///      * to exceed the token maximum supply.
  amountExceedsTokenMaxSupply(289, 'AMOUNT_EXCEEDS_TOKEN_MAX_SUPPLY'),

  /// *
  ///      * The specified amount for an approved allowance cannot be negative.
  negativeAllowanceAmount(290, 'NEGATIVE_ALLOWANCE_AMOUNT'),

  /// *
  ///      * The approveForAll flag cannot be set for a fungible token.
  cannotApproveForAllFungibleCommon(
    291,
    'CANNOT_APPROVE_FOR_ALL_FUNGIBLE_COMMON',
  ),

  /// *
  ///      * The spender does not have an existing approved allowance with the hbar/token owner.
  spenderDoesNotHaveAllowance(292, 'SPENDER_DOES_NOT_HAVE_ALLOWANCE'),

  /// *
  ///      * The transfer amount exceeds the current approved allowance for the spender account.
  amountExceedsAllowance(293, 'AMOUNT_EXCEEDS_ALLOWANCE'),

  /// *
  ///      * The payer account of an approveAllowances or adjustAllowance transaction is attempting
  ///      * to go beyond the maximum allowed number of allowances.
  maxAllowancesExceeded(294, 'MAX_ALLOWANCES_EXCEEDED'),

  /// *
  ///      * No allowances have been specified in the approval transaction.
  emptyAllowances(295, 'EMPTY_ALLOWANCES'),

  /// *
  ///      * Spender is repeated more than once in Crypto or Token or NFT allowance lists in a single
  ///      * CryptoApproveAllowance transaction.
  spenderAccountRepeatedInAllowances(
    296,
    'SPENDER_ACCOUNT_REPEATED_IN_ALLOWANCES',
  ),

  /// *
  ///      * Serial numbers are repeated in nft allowance for a single spender account
  repeatedSerialNumsInNftAllowances(
    297,
    'REPEATED_SERIAL_NUMS_IN_NFT_ALLOWANCES',
  ),

  /// *
  ///      * Fungible common token used in NFT allowances
  fungibleTokenInNftAllowances(298, 'FUNGIBLE_TOKEN_IN_NFT_ALLOWANCES'),

  /// *
  ///      * Non fungible token used in fungible token allowances
  nftInFungibleTokenAllowances(299, 'NFT_IN_FUNGIBLE_TOKEN_ALLOWANCES'),

  /// *
  ///      * The account id specified as the owner is invalid or does not exist.
  invalidAllowanceOwnerId(300, 'INVALID_ALLOWANCE_OWNER_ID'),

  /// *
  ///      * The account id specified as the spender is invalid or does not exist.
  invalidAllowanceSpenderId(301, 'INVALID_ALLOWANCE_SPENDER_ID'),

  /// *
  ///      * [Deprecated] If the CryptoDeleteAllowance transaction has repeated crypto or token or Nft allowances to delete.
  repeatedAllowancesToDelete(302, 'REPEATED_ALLOWANCES_TO_DELETE'),

  /// *
  ///      * If the account Id specified as the delegating spender is invalid or does not exist.
  invalidDelegatingSpender(303, 'INVALID_DELEGATING_SPENDER'),

  /// *
  ///      * The delegating Spender cannot grant approveForAll allowance on a NFT token type for another spender.
  delegatingSpenderCannotGrantApproveForAll(
    304,
    'DELEGATING_SPENDER_CANNOT_GRANT_APPROVE_FOR_ALL',
  ),

  /// *
  ///      * The delegating Spender cannot grant allowance on a NFT serial for another spender as it doesnt not have approveForAll
  ///      * granted on token-owner.
  delegatingSpenderDoesNotHaveApproveForAll(
    305,
    'DELEGATING_SPENDER_DOES_NOT_HAVE_APPROVE_FOR_ALL',
  ),

  /// *
  ///      * The scheduled transaction could not be created because it's expiration_time was too far in the future.
  scheduleExpirationTimeTooFarInFuture(
    306,
    'SCHEDULE_EXPIRATION_TIME_TOO_FAR_IN_FUTURE',
  ),

  /// *
  ///      * The scheduled transaction could not be created because it's expiration_time was less than or equal to the consensus time.
  scheduleExpirationTimeMustBeHigherThanConsensusTime(
    307,
    'SCHEDULE_EXPIRATION_TIME_MUST_BE_HIGHER_THAN_CONSENSUS_TIME',
  ),

  /// *
  ///      * The scheduled transaction could not be created because it would cause throttles to be violated on the specified expiration_time.
  scheduleFutureThrottleExceeded(308, 'SCHEDULE_FUTURE_THROTTLE_EXCEEDED'),

  /// *
  ///      * The scheduled transaction could not be created because it would cause the gas limit to be violated on the specified expiration_time.
  scheduleFutureGasLimitExceeded(309, 'SCHEDULE_FUTURE_GAS_LIMIT_EXCEEDED'),

  /// *
  ///      * The ethereum transaction either failed parsing or failed signature validation, or some other EthereumTransaction error not covered by another response code.
  invalidEthereumTransaction(310, 'INVALID_ETHEREUM_TRANSACTION'),

  /// *
  ///      * EthereumTransaction was signed against a chainId that this network does not support.
  wrongChainId(311, 'WRONG_CHAIN_ID'),

  /// *
  ///      * This transaction specified an ethereumNonce that is not the current ethereumNonce of the account.
  wrongNonce(312, 'WRONG_NONCE'),

  /// *
  ///      * The ethereum transaction specified an access list, which the network does not support.
  accessListUnsupported(313, 'ACCESS_LIST_UNSUPPORTED'),

  /// *
  ///      * A schedule being signed or deleted has passed it's expiration date and is pending execution if needed and then expiration.
  schedulePendingExpiration(314, 'SCHEDULE_PENDING_EXPIRATION'),

  /// *
  ///      * A selfdestruct or ContractDelete targeted a contract that is a token treasury.
  contractIsTokenTreasury(315, 'CONTRACT_IS_TOKEN_TREASURY'),

  /// *
  ///      * A selfdestruct or ContractDelete targeted a contract with non-zero token balances.
  contractHasNonZeroTokenBalances(316, 'CONTRACT_HAS_NON_ZERO_TOKEN_BALANCES'),

  /// *
  ///      * A contract referenced by a transaction is "detached"; that is, expired and lacking any
  ///      * hbar funds for auto-renewal payment---but still within its post-expiry grace period.
  contractExpiredAndPendingRemoval(317, 'CONTRACT_EXPIRED_AND_PENDING_REMOVAL'),

  /// *
  ///      * A ContractUpdate requested removal of a contract's auto-renew account, but that contract has
  ///      * no auto-renew account.
  contractHasNoAutoRenewAccount(318, 'CONTRACT_HAS_NO_AUTO_RENEW_ACCOUNT'),

  /// *
  ///      * A delete transaction submitted via HAPI set permanent_removal=true
  permanentRemovalRequiresSystemInitiation(
    319,
    'PERMANENT_REMOVAL_REQUIRES_SYSTEM_INITIATION',
  ),

  /// * A CryptoCreate or ContractCreate used the deprecated proxyAccountID field.
  proxyAccountIdFieldIsDeprecated(320, 'PROXY_ACCOUNT_ID_FIELD_IS_DEPRECATED'),

  /// *
  ///      * An account set the staked_account_id to itself in CryptoUpdate or ContractUpdate transactions.
  selfStakingIsNotAllowed(321, 'SELF_STAKING_IS_NOT_ALLOWED'),

  /// *
  ///      * The staking account id or staking node id given is invalid or does not exist.
  invalidStakingId(322, 'INVALID_STAKING_ID'),

  /// *
  ///      * Native staking, while implemented, has not yet enabled by the council.
  stakingNotEnabled(323, 'STAKING_NOT_ENABLED'),

  /// *
  ///      * The range provided in UtilPrng transaction is negative.
  invalidPrngRange(324, 'INVALID_PRNG_RANGE'),

  /// *
  ///      * The maximum number of entities allowed in the current price regime have been created.
  maxEntitiesInPriceRegimeHaveBeenCreated(
    325,
    'MAX_ENTITIES_IN_PRICE_REGIME_HAVE_BEEN_CREATED',
  ),

  /// *
  ///     * The full prefix signature for precompile is not valid
  invalidFullPrefixSignatureForPrecompile(
    326,
    'INVALID_FULL_PREFIX_SIGNATURE_FOR_PRECOMPILE',
  ),

  /// *
  ///     * The combined balances of a contract and its auto-renew account (if any) did not cover
  ///     * the rent charged for net new storage used in a transaction.
  insufficientBalancesForStorageRent(
    327,
    'INSUFFICIENT_BALANCES_FOR_STORAGE_RENT',
  ),

  /// *
  ///     * A contract transaction tried to use more than the allowed number of child records, via
  ///     * either system contract records or internal contract creations.
  maxChildRecordsExceeded(328, 'MAX_CHILD_RECORDS_EXCEEDED'),

  /// *
  ///     * The combined balances of a contract and its auto-renew account (if any) or balance of an account did not cover
  ///     * the auto-renewal fees in a transaction.
  insufficientBalancesForRenewalFees(
    329,
    'INSUFFICIENT_BALANCES_FOR_RENEWAL_FEES',
  ),

  /// *
  ///     * A transaction's protobuf message includes unknown fields; could mean that a client
  ///     * expects not-yet-released functionality to be available.
  transactionHasUnknownFields(330, 'TRANSACTION_HAS_UNKNOWN_FIELDS'),

  /// *
  ///      * The account cannot be modified. Account's key is not set
  accountIsImmutable(331, 'ACCOUNT_IS_IMMUTABLE'),

  /// *
  ///      * An alias that is assigned to an account or contract cannot be assigned to another account or contract.
  aliasAlreadyAssigned(332, 'ALIAS_ALREADY_ASSIGNED'),

  /// *
  ///      * A provided metadata key was invalid. Verification includes, for example, checking the size of Ed25519 and ECDSA(secp256k1) public keys.
  invalidMetadataKey(333, 'INVALID_METADATA_KEY'),

  /// *
  ///      * Metadata key is not set on token
  tokenHasNoMetadataKey(334, 'TOKEN_HAS_NO_METADATA_KEY'),

  /// *
  ///      * Token Metadata is not provided
  missingTokenMetadata(335, 'MISSING_TOKEN_METADATA'),

  /// *
  ///      * NFT serial numbers are missing in the TokenUpdateNftsTransactionBody
  missingSerialNumbers(336, 'MISSING_SERIAL_NUMBERS'),

  /// *
  ///      * Admin key is not set on token
  tokenHasNoAdminKey(337, 'TOKEN_HAS_NO_ADMIN_KEY'),

  /// *
  ///      * A transaction failed because the consensus node identified is
  ///      * deleted from the address book.
  nodeDeleted(338, 'NODE_DELETED'),

  /// *
  ///      * A transaction failed because the consensus node identified is not valid or
  ///      * does not exist in state.
  invalidNodeId(339, 'INVALID_NODE_ID'),

  /// *
  ///      * A transaction failed because one or more entries in the list of
  ///      * service endpoints for the `gossip_endpoint` field is invalid.&lt;br/&gt;
  ///      * The most common cause for this response is a service endpoint that has
  ///      * the domain name (DNS) set rather than address and port.
  invalidGossipEndpoint(340, 'INVALID_GOSSIP_ENDPOINT'),

  /// *
  ///      * A transaction failed because the node account identifier provided
  ///      * does not exist or is not valid.&lt;br/&gt;
  ///      * One common source of this error is providing a node account identifier
  ///      * using the "alias" form rather than "numeric" form.
  ///      * It is also used for atomic batch transaction for child transaction if the node account id is not 0.0.0.
  invalidNodeAccountId(341, 'INVALID_NODE_ACCOUNT_ID'),

  /// *
  ///      * A transaction failed because the description field cannot be encoded
  ///      * as UTF-8 or is more than 100 bytes when encoded.
  invalidNodeDescription(342, 'INVALID_NODE_DESCRIPTION'),

  /// *
  ///      * A transaction failed because one or more entries in the list of
  ///      * service endpoints for the `service_endpoint` field is invalid.&lt;br/&gt;
  ///      * The most common cause for this response is a service endpoint that has
  ///      * the domain name (DNS) set rather than address and port.
  invalidServiceEndpoint(343, 'INVALID_SERVICE_ENDPOINT'),

  /// *
  ///      * A transaction failed because the TLS certificate provided for the
  ///      * node is missing or invalid.
  ///      * &lt;p&gt;
  ///      * #### Probable Causes
  ///      * The certificate MUST be a TLS certificate of a type permitted for gossip
  ///      * signatures.&lt;br/&gt;
  ///      * The value presented MUST be a UTF-8 NFKD encoding of the TLS
  ///      * certificate.&lt;br/&gt;
  ///      * The certificate encoded MUST be in PEM format.&lt;br/&gt;
  ///      * The `gossip_ca_certificate` field is REQUIRED and MUST NOT be empty.
  invalidGossipCaCertificate(344, 'INVALID_GOSSIP_CA_CERTIFICATE'),

  /// *
  ///      * A transaction failed because the hash provided for the gRPC certificate
  ///      * is present but invalid.
  ///      * &lt;p&gt;
  ///      * #### Probable Causes
  ///      * The `grpc_certificate_hash` MUST be a SHA-384 hash.&lt;br/&gt;
  ///      * The input hashed MUST be a UTF-8 NFKD encoding of the actual TLS
  ///      * certificate.&lt;br/&gt;
  ///      * The certificate to be encoded MUST be in PEM format.
  invalidGrpcCertificate(345, 'INVALID_GRPC_CERTIFICATE'),

  /// *
  ///      * The maximum automatic associations value is not valid.&lt;br/&gt;
  ///      * The most common cause for this error is a value less than `-1`.
  invalidMaxAutoAssociations(346, 'INVALID_MAX_AUTO_ASSOCIATIONS'),

  /// *
  ///      * The maximum number of nodes allowed in the address book have been created.
  maxNodesCreated(347, 'MAX_NODES_CREATED'),

  /// *
  ///      * In ServiceEndpoint, domain_name and ipAddressV4 are mutually exclusive
  ipFqdnCannotBeSetForSameEndpoint(
    348,
    'IP_FQDN_CANNOT_BE_SET_FOR_SAME_ENDPOINT',
  ),

  /// *
  ///      *  Fully qualified domain name is not allowed in gossip_endpoint
  gossipEndpointCannotHaveFqdn(349, 'GOSSIP_ENDPOINT_CANNOT_HAVE_FQDN'),

  /// *
  ///      * In ServiceEndpoint, domain_name size too large
  fqdnSizeTooLarge(350, 'FQDN_SIZE_TOO_LARGE'),

  /// *
  ///      * ServiceEndpoint is invalid
  invalidEndpoint(351, 'INVALID_ENDPOINT'),

  /// *
  ///      * The number of gossip endpoints exceeds the limit
  gossipEndpointsExceededLimit(352, 'GOSSIP_ENDPOINTS_EXCEEDED_LIMIT'),

  /// *
  ///      * The transaction attempted to use duplicate `TokenReference`.&lt;br/&gt;
  ///      * This affects `TokenReject` attempting to reject same token reference more than once.
  tokenReferenceRepeated(353, 'TOKEN_REFERENCE_REPEATED'),

  /// *
  ///      * The account id specified as the owner in `TokenReject` is invalid or does not exist.
  invalidOwnerId(354, 'INVALID_OWNER_ID'),

  /// *
  ///      * The transaction attempted to use more than the allowed number of `TokenReference`.
  tokenReferenceListSizeLimitExceeded(
    355,
    'TOKEN_REFERENCE_LIST_SIZE_LIMIT_EXCEEDED',
  ),

  /// *
  ///      * The number of service endpoints exceeds the limit
  serviceEndpointsExceededLimit(356, 'SERVICE_ENDPOINTS_EXCEEDED_LIMIT'),

  /// * The IPv4 address is invalid
  invalidIpv4Address(357, 'INVALID_IPV4_ADDRESS'),

  /// *
  ///      * The transaction attempted to use empty `TokenReference` list.
  emptyTokenReferenceList(358, 'EMPTY_TOKEN_REFERENCE_LIST'),

  /// * The node account is not allowed to be updated
  updateNodeAccountNotAllowed(359, 'UPDATE_NODE_ACCOUNT_NOT_ALLOWED'),

  /// * The token has no metadata or supply key
  tokenHasNoMetadataOrSupplyKey(360, 'TOKEN_HAS_NO_METADATA_OR_SUPPLY_KEY'),

  /// *
  ///     * The list of `PendingAirdropId`s is empty and MUST NOT be empty.
  emptyPendingAirdropIdList(361, 'EMPTY_PENDING_AIRDROP_ID_LIST'),

  /// *
  ///     * A `PendingAirdropId` is repeated in a `claim` or `cancel` transaction.
  pendingAirdropIdRepeated(362, 'PENDING_AIRDROP_ID_REPEATED'),

  /// *
  ///     * The number of `PendingAirdropId` values in the list exceeds the maximum
  ///     * allowable number.
  pendingAirdropIdListTooLong(363, 'PENDING_AIRDROP_ID_LIST_TOO_LONG'),

  /// * A pending airdrop already exists for the specified NFT.
  pendingNftAirdropAlreadyExists(364, 'PENDING_NFT_AIRDROP_ALREADY_EXISTS'),

  /// * The identified account is sender for one or more pending airdrop(s)
  ///      * and cannot be deleted.
  ///      * &lt;p&gt;
  ///      * The requester SHOULD cancel all pending airdrops before resending
  ///      * this transaction.
  accountHasPendingAirdrops(365, 'ACCOUNT_HAS_PENDING_AIRDROPS'),

  /// *
  ///      * Consensus throttle did not allow execution of this transaction.&lt;br/&gt;
  ///      * The transaction should be retried after a modest delay.
  throttledAtConsensus(366, 'THROTTLED_AT_CONSENSUS'),

  /// *
  ///      * The provided pending airdrop id is invalid.&lt;br/&gt;
  ///      * This pending airdrop MAY already be claimed or cancelled.
  ///      * &lt;p&gt;
  ///      * The client SHOULD query a mirror node to determine the current status of
  ///      * the pending airdrop.
  invalidPendingAirdropId(367, 'INVALID_PENDING_AIRDROP_ID'),

  /// *
  ///      * The token to be airdropped has a fallback royalty fee and cannot be
  ///      * sent or claimed via an airdrop transaction.
  tokenAirdropWithFallbackRoyalty(368, 'TOKEN_AIRDROP_WITH_FALLBACK_ROYALTY'),

  /// *
  ///      * This airdrop claim is for a pending airdrop with an invalid token.&lt;br/&gt;
  ///      * The token might be deleted, or the sender may not have enough tokens
  ///      * to fulfill the offer.
  ///      * &lt;p&gt;
  ///      * The client SHOULD query mirror node to determine the status of the
  ///      * pending airdrop and whether the sender can fulfill the offer.
  invalidTokenInPendingAirdrop(369, 'INVALID_TOKEN_IN_PENDING_AIRDROP'),

  /// *
  ///      * A scheduled transaction configured to wait for expiry to execute was given
  ///      * an expiry time at which there is already too many transactions scheduled to
  ///      * expire; its creation must be retried with a different expiry.
  scheduleExpiryIsBusy(370, 'SCHEDULE_EXPIRY_IS_BUSY'),

  /// *
  ///      * The provided gRPC certificate hash is invalid.
  invalidGrpcCertificateHash(371, 'INVALID_GRPC_CERTIFICATE_HASH'),

  /// *
  ///      * A scheduled transaction configured to wait for expiry to execute was not
  ///      * given an explicit expiration time.
  missingExpiryTime(372, 'MISSING_EXPIRY_TIME'),

  /// *
  ///      * A contract operation attempted to schedule another transaction after it
  ///      * had already scheduled a recursive contract call.
  noSchedulingAllowedAfterScheduledRecursion(
    373,
    'NO_SCHEDULING_ALLOWED_AFTER_SCHEDULED_RECURSION',
  ),

  /// *
  ///      * A contract can schedule recursive calls a finite number of times (this is
  ///      * approximately four million times with typical network configuration.)
  recursiveSchedulingLimitReached(374, 'RECURSIVE_SCHEDULING_LIMIT_REACHED'),

  /// *
  ///      * The target network is waiting for the ledger ID to be set, which is a
  ///      * side effect of finishing the network's TSS construction.
  waitingForLedgerId(375, 'WAITING_FOR_LEDGER_ID'),

  /// *
  ///      * The provided fee exempt key list size exceeded the limit.
  maxEntriesForFeeExemptKeyListExceeded(
    376,
    'MAX_ENTRIES_FOR_FEE_EXEMPT_KEY_LIST_EXCEEDED',
  ),

  /// *
  ///      * The provided fee exempt key list contains duplicated keys.
  feeExemptKeyListContainsDuplicatedKeys(
    377,
    'FEE_EXEMPT_KEY_LIST_CONTAINS_DUPLICATED_KEYS',
  ),

  /// *
  ///      * The provided fee exempt key list contains an invalid key.
  invalidKeyInFeeExemptKeyList(378, 'INVALID_KEY_IN_FEE_EXEMPT_KEY_LIST'),

  /// *
  ///      * The provided fee schedule key contains an invalid key.
  invalidFeeScheduleKey(379, 'INVALID_FEE_SCHEDULE_KEY'),

  /// *
  ///      * If a fee schedule key is not set when we create a topic
  ///      * we cannot add it on update.
  feeScheduleKeyCannotBeUpdated(380, 'FEE_SCHEDULE_KEY_CANNOT_BE_UPDATED'),

  /// *
  ///      * If the topic's custom fees are updated the topic SHOULD have a
  ///      * fee schedule key
  feeScheduleKeyNotSet(381, 'FEE_SCHEDULE_KEY_NOT_SET'),

  /// *
  ///      * The fee amount is exceeding the amount that the payer
  ///      * is willing to pay.
  maxCustomFeeLimitExceeded(382, 'MAX_CUSTOM_FEE_LIMIT_EXCEEDED'),

  /// *
  ///      * There are no corresponding custom fees.
  noValidMaxCustomFee(383, 'NO_VALID_MAX_CUSTOM_FEE'),

  /// *
  ///      * The provided list contains invalid max custom fee.
  invalidMaxCustomFees(384, 'INVALID_MAX_CUSTOM_FEES'),

  /// *
  ///      * The provided max custom fee list contains fees with
  ///      * duplicate denominations.
  duplicateDenominationInMaxCustomFeeList(
    385,
    'DUPLICATE_DENOMINATION_IN_MAX_CUSTOM_FEE_LIST',
  ),

  /// *
  ///      * The provided max custom fee list contains fees with
  ///      * duplicate account id.
  duplicateAccountIdInMaxCustomFeeList(
    386,
    'DUPLICATE_ACCOUNT_ID_IN_MAX_CUSTOM_FEE_LIST',
  ),

  /// *
  ///      * Max custom fees list is not supported for this operation.
  maxCustomFeesIsNotSupported(387, 'MAX_CUSTOM_FEES_IS_NOT_SUPPORTED'),

  /// *
  ///      * The list of batch transactions is empty
  batchListEmpty(388, 'BATCH_LIST_EMPTY'),

  /// *
  ///      * The list of batch transactions contains duplicated transactions
  batchListContainsDuplicates(389, 'BATCH_LIST_CONTAINS_DUPLICATES'),

  /// *
  ///      * The list of batch transactions contains a transaction type that is
  ///      * in the AtomicBatch blacklist as configured in the network.
  batchTransactionInBlacklist(390, 'BATCH_TRANSACTION_IN_BLACKLIST'),

  /// *
  ///      * The inner transaction of a batch transaction failed
  innerTransactionFailed(391, 'INNER_TRANSACTION_FAILED'),

  /// *
  ///      * The inner transaction of a batch transaction is missing a batch key
  missingBatchKey(392, 'MISSING_BATCH_KEY'),

  /// *
  ///      * The batch key is set for a non batch transaction
  batchKeySetOnNonInnerTransaction(
    393,
    'BATCH_KEY_SET_ON_NON_INNER_TRANSACTION',
  ),

  /// *
  ///      * The batch key is not valid
  invalidBatchKey(394, 'INVALID_BATCH_KEY'),

  /// *
  ///      * The provided schedule expiry time is not configurable.
  scheduleExpiryNotConfigurable(395, 'SCHEDULE_EXPIRY_NOT_CONFIGURABLE'),

  /// *
  ///      * The network just started at genesis and is creating system entities.
  creatingSystemEntities(396, 'CREATING_SYSTEM_ENTITIES'),

  /// *
  ///      * The least common multiple of the throttle group's milliOpsPerSec is
  ///      * too large and it's overflowing.
  throttleGroupLcmOverflow(397, 'THROTTLE_GROUP_LCM_OVERFLOW'),

  /// *
  ///      * Token airdrop transactions can not contain multiple senders for a single token.
  airdropContainsMultipleSendersForAToken(
    398,
    'AIRDROP_CONTAINS_MULTIPLE_SENDERS_FOR_A_TOKEN',
  ),

  /// *
  ///      * The GRPC proxy endpoint is set in the NodeCreate or NodeUpdate transaction,
  ///      * which the network does not support.
  grpcWebProxyNotSupported(399, 'GRPC_WEB_PROXY_NOT_SUPPORTED'),

  /// *
  ///      * An NFT transfers list referenced a token type other than NON_FUNGIBLE_UNIQUE.
  nftTransfersOnlyAllowedForNonFungibleUnique(
    400,
    'NFT_TRANSFERS_ONLY_ALLOWED_FOR_NON_FUNGIBLE_UNIQUE',
  ),

  /// *
  ///      * A HAPI client cannot set the SignedTransaction#use_serialized_tx_message_hash_algorithm field.
  invalidSerializedTxMessageHashAlgorithm(
    401,
    'INVALID_SERIALIZED_TX_MESSAGE_HASH_ALGORITHM',
  ),

  /// *
  ///      * A HookStore referenced a valid entity number but with the wrong entity type.
  wrongHookEntityType(499, 'WRONG_HOOK_ENTITY_TYPE'),

  /// *
  ///      * An EVM hook execution was throttled due to high network gas utilization.
  evmHookGasThrottled(500, 'EVM_HOOK_GAS_THROTTLED'),

  /// *
  ///      * A user tried to create a hook with an id already in use.
  hookIdInUse(501, 'HOOK_ID_IN_USE'),

  /// *
  ///      * A transaction tried to execute a hook that did not match the specified
  ///      * type or was malformed in some other way.
  badHookRequest(502, 'BAD_HOOK_REQUEST'),

  /// *
  ///      * A CryptoTransfer relying on a ACCOUNT_ALLOWANCE hook was rejected.
  rejectedByAccountAllowanceHook(503, 'REJECTED_BY_ACCOUNT_ALLOWANCE_HOOK'),

  /// *
  ///      * A hook id was not found.
  hookNotFound(504, 'HOOK_NOT_FOUND'),

  /// *
  ///      * An EVM hook mapping slot, storage key, or storage value exceeded 32 bytes.
  evmHookStorageUpdateBytesTooLong(
    505,
    'EVM_HOOK_STORAGE_UPDATE_BYTES_TOO_LONG',
  ),

  /// *
  ///      * An EVM hook's mapping slot, storage key, or storage value failed to use the
  ///      * minimal representation (i.e., no leading zeros).
  evmHookStorageUpdateBytesMustUseMinimalRepresentation(
    506,
    'EVM_HOOK_STORAGE_UPDATE_BYTES_MUST_USE_MINIMAL_REPRESENTATION',
  ),

  /// *
  ///      * A hook id was invalid.
  invalidHookId(507, 'INVALID_HOOK_ID'),

  /// *
  ///      * An EVM hook storage update had no contents.
  emptyEvmHookStorageUpdate(508, 'EMPTY_EVM_HOOK_STORAGE_UPDATE'),

  /// *
  ///      * A user repeated the same hook id in a creation details list.
  hookIdRepeatedInCreationDetails(509, 'HOOK_ID_REPEATED_IN_CREATION_DETAILS'),

  /// *
  ///      * Hooks are not not enabled on the target Hiero network.
  hooksNotEnabled(510, 'HOOKS_NOT_ENABLED'),

  /// *
  ///      * The target hook is not an EVM hook.
  hookIsNotAnEvmHook(511, 'HOOK_IS_NOT_AN_EVM_HOOK'),

  /// *
  ///      * A hook was deleted.
  hookDeleted(512, 'HOOK_DELETED'),

  /// *
  ///      * The HookStore tried to update too many storage slots in a single transaction.
  tooManyEvmHookStorageUpdates(513, 'TOO_MANY_EVM_HOOK_STORAGE_UPDATES'),

  /// *
  ///      * An EVM hook mapping slot, storage key, or storage value failed to use the
  ///      * minimal representation (i.e., no leading zeros).
  hookCreationBytesMustUseMinimalRepresentation(
    514,
    'HOOK_CREATION_BYTES_MUST_USE_MINIMAL_REPRESENTATION',
  ),

  /// *
  ///      * A EVM hook mapping slot, storage key, or storage value exceeded 32 bytes.
  hookCreationBytesTooLong(515, 'HOOK_CREATION_BYTES_TOO_LONG'),

  /// *
  ///      * A hook creation spec was not found.
  invalidHookCreationSpec(516, 'INVALID_HOOK_CREATION_SPEC'),

  /// *
  ///      * A hook extension point was empty.
  hookExtensionEmpty(517, 'HOOK_EXTENSION_EMPTY'),

  /// *
  ///      * A hook admin key was invalid.
  invalidHookAdminKey(518, 'INVALID_HOOK_ADMIN_KEY'),

  /// *
  ///      * The hook deletion requires the hook to have zero storage slots.
  hookDeletionRequiresZeroStorageSlots(
    519,
    'HOOK_DELETION_REQUIRES_ZERO_STORAGE_SLOTS',
  ),

  /// *
  ///      * Cannot set both a hook call and an approval on the same AccountAmount or NftTransfer message.
  cannotSetHooksAndApproval(520, 'CANNOT_SET_HOOKS_AND_APPROVAL'),

  /// *
  ///      * The attempted operation is invalid until all the target entity's hooks have been deleted.
  transactionRequiresZeroHooks(521, 'TRANSACTION_REQUIRES_ZERO_HOOKS'),

  /// *
  ///      * The HookCall set in the transaction is invalid
  invalidHookCall(522, 'INVALID_HOOK_CALL'),

  /// *
  ///      *  Hooks are not supported to be used in TokenAirdrop transactions
  hooksAreNotSupportedInAirdrops(523, 'HOOKS_ARE_NOT_SUPPORTED_IN_AIRDROPS'),

  /// *
  ///      * This operation cannot be completed because the target
  ///      * account is a "Node Account".&lt;br/&gt;
  ///      * This account is currently in use as the "Node Account" for a
  ///      * consensus node, and therefore the requested change is
  ///      * not permitted. The transaction may be resubmitted once the
  ///      * account is no longer in use as a "Node Account" for any
  ///      * consensus node.
  accountIsLinkedToANode(524, 'ACCOUNT_IS_LINKED_TO_A_NODE'),

  /// *
  ///      *  Hooks are not supported to be used in Batch transactions and Scheduled transactions.
  ///      * They are only supported in a top level CryptoTransfer transaction.
  hooksExecutionsRequireTopLevelCryptoTransfer(
    525,
    'HOOKS_EXECUTIONS_REQUIRE_TOP_LEVEL_CRYPTO_TRANSFER',
  ),

  /// *
  ///      * This operation cannot be completed because the target
  ///      * account has a zero balance.&lt;br/&gt;
  ///      * Node accounts require a positive balance. The transaction may be
  ///      * resubmitted once the account has been funded.
  nodeAccountHasZeroBalance(526, 'NODE_ACCOUNT_HAS_ZERO_BALANCE'),

  /// *
  ///      * This operation cannot be completed because the target
  ///      * account is a "Fee Collection Account".&lt;br/&gt;
  ///      * Any attempt to transfer to a fee collection account is not permitted.
  transferToFeeCollectionAccountNotAllowed(
    527,
    'TRANSFER_TO_FEE_COLLECTION_ACCOUNT_NOT_ALLOWED',
  ),

  /// *
  ///      * The number of hook invocations exceeds the maximum allowed per transaction.
  tooManyHookInvocations(528, 'TOO_MANY_HOOK_INVOCATIONS'),

  /// *
  ///      * A registered node ID is invalid or does not exist.
  invalidRegisteredNodeId(529, 'INVALID_REGISTERED_NODE_ID'),

  /// *
  ///      * A registered service endpoint is invalid.&lt;br/&gt;
  ///      * The port is out of range, or the address field is not set.
  invalidRegisteredEndpoint(530, 'INVALID_REGISTERED_ENDPOINT'),

  /// *
  ///      * The number of registered service endpoints exceeds the configured limit.
  registeredEndpointsExceededLimit(531, 'REGISTERED_ENDPOINTS_EXCEEDED_LIMIT'),

  /// *
  ///      * A registered service endpoint has an invalid address.&lt;br/&gt;
  ///      * The IP address length is not 4 (IPv4) or 16 (IPv6), or the
  ///      * domain name is not a valid ASCII FQDN.
  invalidRegisteredEndpointAddress(532, 'INVALID_REGISTERED_ENDPOINT_ADDRESS'),

  /// *
  ///      * A registered service endpoint does not specify an endpoint type.&lt;br/&gt;
  ///      * Exactly one of block_node, mirror_node, or rpc_relay MUST be set.
  invalidRegisteredEndpointType(533, 'INVALID_REGISTERED_ENDPOINT_TYPE'),

  /// *
  ///      * A registered node cannot be deleted because it is still associated
  ///      * with a consensus node via their associated registered node list.
  registeredNodeStillAssociated(534, 'REGISTERED_NODE_STILL_ASSOCIATED'),

  /// *
  ///      * The number of associated registered nodes exceeds the maximum allowed limit.
  maxRegisteredNodesExceeded(535, 'MAX_REGISTERED_NODES_EXCEEDED');

  const HederaResponseCodeEnum(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaResponseCodeEnum fromValue(int? value) {
    value ??= 0;
    return HederaResponseCodeEnum.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaResponseCodeEnum found for the given value. $value",
                details: {
                  "name": "HederaResponseCodeEnum",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaResponseCodeEnum from(Object? value) {
    value ??= 0;
    return HederaResponseCodeEnum.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaResponseCodeEnum found for the given value. $value",
                details: {
                  "name": "HederaResponseCodeEnum",
                  "value": value?.toString(),
                },
              ),
    );
  }
}
